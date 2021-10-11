Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416E74288C9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhJKIcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 04:32:47 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50245 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhJKIcr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 04:32:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633941047; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=blLrJgUbz/d2t6DrdFAzGfqMpSyl8BbuJZHTAM6xJOw=; b=KpXVhIsLVE2do6mCd/AfzXjzY68vFBgLf41LYPxLsY+fA1cPCxUrQEUMnEVfAIX0i4l3Zbfw
 RbKErOVacg1ERF3ilgcCT36oF1Kws25I6Isa7E2xLMM6FgluQcqIroamLuUBR/oiAQr7b9L3
 q3mIc111Y+IWzb3yUrqDH97Kf6w=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6163f6234ccc4cf2c7decc5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:30:27
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8CDD9C43616; Mon, 11 Oct 2021 08:30:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3534AC4360D;
        Mon, 11 Oct 2021 08:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3534AC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath11k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE if NSS ratio enabled
Date:   Mon, 11 Oct 2021 04:30:20 -0400
Message-Id: <20211011083020.30536-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When NSS ratio enabled reported by firmware, SUPPORTS_VHT_EXT_NSS_BW
is set in ath11k, meanwhile IEEE80211_VHT_EXT_NSS_BW_CAPABLE also
need to be set, otherwise it is invalid because spec in IEEE Std
802.11™-2016 as below.

Table 9-251—Supported VHT-MCS and NSS Set subfields, it has subfield
VHT Extended NSS BW Capable, its definition is:
Indicates whether the STA is capable of interpreting the Extended NSS
BW Support subfield of the VHT Capabilities Information field.

dmesg have a message without this patch:
[ 3143.177810] [5204] mac80211:ieee80211_register_hw:1258: ieee80211 phy0: copying sband (band 1) due to VHT EXT NSS BW flag
It means mac80211 will set IEEE80211_VHT_EXT_NSS_BW_CAPABLE if ath11k not
set it in ieee80211_register_hw(). So it is better to set it in ath11k.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c73b2de11ae3..4c59cea34174 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4123,6 +4123,10 @@ ath11k_create_vht_cap(struct ath11k *ar, u32 rate_cap_tx_chainmask,
 	vht_cap.vht_supported = 1;
 	vht_cap.cap = ar->pdev->cap.vht_cap;
 
+	if (ar->pdev->cap.nss_ratio_enabled)
+		vht_cap.vht_mcs.tx_highest |=
+			cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
+
 	ath11k_set_vht_txbf_cap(ar, &vht_cap.cap);
 
 	rxmcs_map = 0;
-- 
2.31.1

