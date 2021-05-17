Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F87386B3B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhEQUVp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52579 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239261AbhEQUVg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282819; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VK4UK5kSffOJbSxn2oczi2SPdI/m1A68RieCMNy/ETY=; b=TBfft33oicrDrY7JcmuisYWZye60Emy80Biy+eE+h5cfMg3ZWDDVQjfulv8zh4fs3XFVGD3T
 pznfwgnxP3uqIWqAud/4Atnhb04G3zR+J5QxjOR1NIhT1mqtAGBSWtB+caJwYWbTc5ykImj9
 9T879klLDg3EbQXidVgmhitPZ0I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60a2d002b15734c8f971cc9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:18
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04423C4338A; Mon, 17 May 2021 20:20:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72C77C43217;
        Mon, 17 May 2021 20:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72C77C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 9/9] mac80211: save transmit power envelope element and power constraint
Date:   Mon, 17 May 2021 16:19:32 -0400
Message-Id: <20210517201932.8860-10-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517201932.8860-1-wgong@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to save the transmit power envelope element and power
constraint in struct ieee80211_bss_conf for 6GHz.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/mlme.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2e33a1263518..5b02d78bd934 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5076,6 +5076,27 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		else
 			he_oper = NULL;
 
+		if (is_6ghz) {
+			struct ieee802_11_elems elems;
+			struct ieee80211_bss_conf *bss_conf;
+			u8 i, n;
+
+			ieee802_11_parse_elems(ies->data, ies->len, false, &elems,
+					       NULL, NULL);
+			bss_conf = &sdata->vif.bss_conf;
+			bss_conf->pwr_reduction = 0;
+			if (elems.pwr_constr_elem)
+				bss_conf->pwr_reduction = *elems.pwr_constr_elem;
+
+			memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
+			bss_conf->tx_pwr_env_num = elems.tx_pwr_env_num;
+			n = min_t(u8, elems.tx_pwr_env_num,
+				  ARRAY_SIZE(elems.tx_pwr_env));
+			for (i = 0; i < n; i++)
+				memcpy(&bss_conf->tx_pwr_env[i], elems.tx_pwr_env[i],
+				       elems.tx_pwr_env_len[i]);
+		}
+
 		if (!ieee80211_verify_sta_he_mcs_support(sband, he_oper))
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
-- 
2.31.1

