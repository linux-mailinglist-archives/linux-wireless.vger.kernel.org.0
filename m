Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2E386B31
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhEQUV0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:26 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50949 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbhEQUVY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282808; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=ku7yAvD5M3SMfIgtuSth8sXJbT35O3EqpZxbNrqYVOU=; b=ggRY8CEQtmrHs9lDsfdWwYtAFaQtxIQq5RSO7N3w91efNAKy0NSNRau+B18/uZAQXAVaFHCa
 57amOSbUqPpf9Ejwnb9EkyktaprBUicNSAm6SpOwrnut+SSJLHKRcPFnc3EG6sLglSrqw3Tf
 lK/f/n69RQxgYlEbtx1MBUCvv04=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60a2cff7b15734c8f971a7e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:07
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2637C4338A; Mon, 17 May 2021 20:20:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43B19C433D3;
        Mon, 17 May 2021 20:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43B19C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 2/9] mac80211: add definition of regulatory info in 6G Hz operation information
Date:   Mon, 17 May 2021 16:19:25 -0400
Message-Id: <20210517201932.8860-3-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517201932.8860-1-wgong@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE P802.11ax™/D8.0 added regulatory info subfield in HE operation
element, this patch is to add it in mac80211 definition.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/linux/ieee80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 3d8cf579745d..894a2c4d7cb7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2266,6 +2266,9 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
 
+#define IEEE80211_6GHZ_CTRL_REG_LPI_AP	0
+#define IEEE80211_6GHZ_CTRL_REG_SP_AP	1
+
 /**
  * ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
  * @primary: primary channel
@@ -2282,6 +2285,7 @@ struct ieee80211_he_6ghz_oper {
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ	2
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ	3
 #define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON	0x4
+#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x38
 	u8 control;
 	u8 ccfs0;
 	u8 ccfs1;
-- 
2.31.1

