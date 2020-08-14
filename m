Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD734244617
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHNIEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 04:04:33 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:59239 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgHNIEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 04:04:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597392272; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2VWhHvy+dAEpokrHqac8Yco++JKHoZbC+fOsh8eOZtA=; b=tVrzSgvajbbLiIPcOE69DSdtY/2+UE5lWV2IY1P8PSuinwFMaYrh9ymIc+V/CxV9IHeX/mpt
 pbdRqqAi+NZAvfmmpC2d2VVsel509E7Vwv68wbRJvaNSumdR4src+hmIDqo3Z3BJuA+yRecI
 r35F4OvpgjqcPdW9x75u75SEWxk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f36458f2b87d66049483949 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 08:04:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09723C433CB; Fri, 14 Aug 2020 08:04:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86C0AC433C9;
        Fri, 14 Aug 2020 08:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86C0AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: correct the array index from mcs index for HT mode for QCA6174
Date:   Fri, 14 Aug 2020 16:04:54 +0800
Message-Id: <1597392294-13124-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The mcs index of HT mode is 0 to 31, please refer http://mcsindex.com/.
Its spatial stream(Nss) number is from 1 to 4, mcs index is 0~7 for
Nss=1, 8~15 for Nss=2, 16~23 for Nss=3 and 24~31 is for Nss=4.

The mcs is reported from firmware in wmi_tlv_peer_stats_info of
event WMI_TLV_PEER_STATS_INFO_EVENTID, its range is from 0~15 for
QCA6174 SDIO and PCIe. It is for both Nss=1 and Nss=2, and it has 2
rate table supported_ht_mcs_rate_nss1 and supported_ht_mcs_rate_nss2
in ath10k, they are for Nss=1 and Nss=2, each table has 8 rates.

It need to find the matched row number with the mcs index, for example,
mcs index is 2, it is <=7, so it is Nss=1, and match row 2 in table of
Nss=1. If mcs index is 12, it is >= 8 and <= 15, so it is Nss=2, it
match row 4(12-8) in table of Nss=2. If mcs index is >=16, it is for
Nss=3/4, it need to add rate table, so it is not support in current
ath10k.

This patch is to find the row number in rate table of Nss=1 or Nss=2
with the mcs index reported from firmware.

This patch only effect the chips which supports_peer_stats_info of its
hw_params is true, it is true only for QCA6174 currently.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00048
Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3e3896214e8b..daa9e43d16b0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8368,19 +8368,32 @@ static void ath10k_mac_get_rate_flags_ht(struct ath10k *ar, u32 rate, u8 nss, u8
 					 u8 *flags, u8 *bw)
 {
 	struct ath10k_index_ht_data_rate_type *mcs_rate;
+	u8 index;
+	size_t len_nss1 = ARRAY_SIZE(supported_ht_mcs_rate_nss1);
+	size_t len_nss2 = ARRAY_SIZE(supported_ht_mcs_rate_nss2);
+
+	if (mcs >= (len_nss1 + len_nss2)) {
+		ath10k_warn(ar, "not supported mcs %d in current rate table", mcs);
+		return;
+	}
 
 	mcs_rate = (struct ath10k_index_ht_data_rate_type *)
 		   ((nss == 1) ? &supported_ht_mcs_rate_nss1 :
 		   &supported_ht_mcs_rate_nss2);
 
-	if (rate == mcs_rate[mcs].supported_rate[0]) {
+	if (mcs >= len_nss1)
+		index = mcs - len_nss1;
+	else
+		index = mcs;
+
+	if (rate == mcs_rate[index].supported_rate[0]) {
 		*bw = RATE_INFO_BW_20;
-	} else if (rate == mcs_rate[mcs].supported_rate[1]) {
+	} else if (rate == mcs_rate[index].supported_rate[1]) {
 		*bw |= RATE_INFO_BW_40;
-	} else if (rate == mcs_rate[mcs].supported_rate[2]) {
+	} else if (rate == mcs_rate[index].supported_rate[2]) {
 		*bw |= RATE_INFO_BW_20;
 		*flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (rate == mcs_rate[mcs].supported_rate[3]) {
+	} else if (rate == mcs_rate[index].supported_rate[3]) {
 		*bw |= RATE_INFO_BW_40;
 		*flags |= RATE_INFO_FLAGS_SHORT_GI;
 	} else {
@@ -8441,6 +8454,9 @@ static void ath10k_mac_parse_bitrate(struct ath10k *ar, u32 rate_code,
 	u8 mcs = WMI_TLV_GET_HW_RC_RATE_V1(rate_code);
 	u8 flags = 0, bw = 0;
 
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac parse rate code 0x%x bitrate %d kbps\n",
+		   rate_code, bitrate_kbps);
+
 	if (preamble == WMI_RATE_PREAMBLE_HT)
 		mode = ATH10K_PHY_MODE_HT;
 	else if (preamble == WMI_RATE_PREAMBLE_VHT)
-- 
2.23.0

