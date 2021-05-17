Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0554C386B32
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhEQUV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56754 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhEQUV0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282810; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uuIAjdRE0Ti40fZg9EfjVcWG1MGHeEI07hq4NN2t540=; b=ATRmYLAWLMwkmapFjOnQpbhi+sIVVFfdQCfaGKvbxzlxRbcyNi3WwhSvxR7YoOadjv/dyX+q
 TuZYVmtC5Bxa2dBW3vXbCwRdYOEs2LqlwPLSVH92ArtJosL7mcoejK5sITfIR8kpyWH4ilfK
 +p6bqkS172WTdQdfIfdvdwWVHdk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60a2cffab15734c8f971b0b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:10
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89D7BC43217; Mon, 17 May 2021 20:20:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1DF5C433D3;
        Mon, 17 May 2021 20:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1DF5C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 3/9] mac80211: add parse regulatory info in 6G Hz operation information
Date:   Mon, 17 May 2021 16:19:26 -0400
Message-Id: <20210517201932.8860-4-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517201932.8860-1-wgong@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to convert the regulatory info subfield in HE operation
element to power type and save in struct cfg80211_chan_def.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/util.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f080fcf60e45..f58136e844a7 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3405,6 +3405,16 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 					      NL80211_BAND_6GHZ);
 	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
 
+	switch (u8_get_bits(he_6ghz_oper->control,
+			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+		he_chandef.power_type = NL80211_REG_LPI_AP;
+		break;
+	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+		he_chandef.power_type = NL80211_REG_SP_AP;
+		break;
+	}
+
 	switch (u8_get_bits(he_6ghz_oper->control,
 			    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
 	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
-- 
2.31.1

