Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7337ADAF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhEKSEn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhEKSEX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:04:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC7C061345;
        Tue, 11 May 2021 11:03:14 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lgWiu-007aAS-Mj; Tue, 11 May 2021 20:03:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Wen Gong <wgong@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH 15/18] ath10k: Fix TKIP Michael MIC verification for PCIe
Date:   Tue, 11 May 2021 20:02:56 +0200
Message-Id: <20210511200110.c3f1d42c6746.I795593fcaae941c471425b8c7d5f7bb185d29142@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511180259.159598-1-johannes@sipsolutions.net>
References: <20210511180259.159598-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

TKIP Michael MIC was not verified properly for PCIe cases since the
validation steps in ieee80211_rx_h_michael_mic_verify() in mac80211 did
not get fully executed due to unexpected flag values in
ieee80211_rx_status.

Fix this by setting the flags property to meet mac80211 expectations for
performing Michael MIC validation there. This fixes CVE-2020-26141. It
does the same as ath10k_htt_rx_proc_rx_ind_hl() for SDIO which passed
MIC verification case. This applies only to QCA6174/QCA9377 PCIe.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Cc: stable@vger.kernel.org
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 12451ab66a19..87196f9bbdea 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1974,6 +1974,11 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 		}
 
 		ath10k_htt_rx_h_csum_offload(msdu);
+
+		if (frag && !fill_crypt_header &&
+		    enctype == HTT_RX_MPDU_ENCRYPT_TKIP_WPA)
+			status->flag &= ~RX_FLAG_MMIC_STRIPPED;
+
 		ath10k_htt_rx_h_undecap(ar, msdu, status, first_hdr, enctype,
 					is_decrypted);
 
@@ -1991,6 +1996,11 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 
 		hdr = (void *)msdu->data;
 		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+
+		if (frag && !fill_crypt_header &&
+		    enctype == HTT_RX_MPDU_ENCRYPT_TKIP_WPA)
+			status->flag &= ~RX_FLAG_IV_STRIPPED &
+					~RX_FLAG_MMIC_STRIPPED;
 	}
 }
 
-- 
2.30.2

