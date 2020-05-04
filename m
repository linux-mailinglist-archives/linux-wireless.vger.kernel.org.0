Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05C21C40C3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgEDRGz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 13:06:55 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61144 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgEDRGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 13:06:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588612014; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xV9DwieOETp85uRilqJXwoKSn4Hb2ILx/AsUkH9bC8k=; b=WYZ1G7fs6/5Z4Wz2O9aTHRRBxCLJeYN/6yT+tmfyIH7ZvgodvnF9+c6+M3xgr8OtejTapjYt
 SOLqo2VcFISrs5QyrHWwUQ1j5jy7bec2WNdhPTNu1miByUDz5FljDaEOy+xHH0o9k6qRVByQ
 LqkVE/yRQmktX9rRo3/5Ctnfj6A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb04bad.7fa7bade4dc0-smtp-out-n03;
 Mon, 04 May 2020 17:06:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E34CDC433D2; Mon,  4 May 2020 17:06:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from cheath10p342229-lin.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA95C433CB;
        Mon,  4 May 2020 17:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FA95C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH 1/2] mac80211: Add new AMPDU factor macro for HE peer caps
Date:   Mon,  4 May 2020 22:34:59 +0530
Message-Id: <1588611900-21185-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add IEEE80211_HE_VHT_MAX_AMPDU_FACTOR and IEEE80211_HE_HT_MAX_AMPDU_FACTOR
as per spec to use for peer max ampdu factor.

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 include/linux/ieee80211.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a561db4..69e214c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1821,6 +1821,8 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_MAC_CAP3_FLEX_TWT_SCHED			0x40
 #define IEEE80211_HE_MAC_CAP3_RX_CTRL_FRAME_TO_MULTIBSS		0x80
 
+#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_SHIFT		3
+
 #define IEEE80211_HE_MAC_CAP4_BSRP_BQRP_A_MPDU_AGG		0x01
 #define IEEE80211_HE_MAC_CAP4_QTP				0x02
 #define IEEE80211_HE_MAC_CAP4_BQR				0x04
@@ -1842,6 +1844,9 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_MAC_CAP5_PUNCTURED_SOUNDING		0x40
 #define IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX		0x80
 
+#define IEEE80211_HE_VHT_MAX_AMPDU_FACTOR	20
+#define IEEE80211_HE_HT_MAX_AMPDU_FACTOR	16
+
 /* 802.11ax HE PHY capabilities */
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G		0x02
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G	0x04
-- 
1.9.1
