Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A953FFF60
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhICLte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:49:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45250 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235143AbhICLtd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669714; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=hoWXgGGISPMiY2lHMuQSz3w8l1gdOH1IMqS4cmZCt80=; b=C62C5wrXCBKGDX+M7tbqFvHeZLRsbVtkibQCa+0OAkNIpz5Bnbkm+MguWu6gJaYkKEt2k+G+
 bAIaMYuK4dzhk1N9w88gyUkVyYr9ElaN3Xixm7X7ERyHUq5AsrXJ2FDk7wnRBMYbfeWVZiNr
 JtTvzV64QJUZ4jezmeN0B6+goCA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61320b8f89cdb62061a53c49 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:31
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CB36C43460; Fri,  3 Sep 2021 11:48:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B200C4360C;
        Fri,  3 Sep 2021 11:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1B200C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 2/9] ieee80211: add definition of regulatory info in 6 GHz operation information
Date:   Fri,  3 Sep 2021 07:48:14 -0400
Message-Id: <20210903114821.23346-3-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE Std 802.11ax™-2021 added regulatory info subfield in HE operation
element, this patch is to add it in mac80211 definition.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/linux/ieee80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2bab84297407..bed510b7bb6b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2298,6 +2298,9 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
 
+#define IEEE80211_6GHZ_CTRL_REG_LPI_AP	0
+#define IEEE80211_6GHZ_CTRL_REG_SP_AP	1
+
 /**
  * ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
  * @primary: primary channel
@@ -2314,6 +2317,7 @@ struct ieee80211_he_6ghz_oper {
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ	2
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ	3
 #define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON	0x4
+#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x38
 	u8 control;
 	u8 ccfs0;
 	u8 ccfs1;
-- 
2.31.1

