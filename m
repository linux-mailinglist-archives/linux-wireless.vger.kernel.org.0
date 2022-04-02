Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9414F04B3
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357611AbiDBQDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357730AbiDBQDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 12:03:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367B67D2B
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 09:01:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 5so9977261lfp.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 Apr 2022 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICNgre31Vkr1jiI14jV6Rv7hm2wKM+f1gjZng17AJZo=;
        b=hWdHRFRgHDWMQl+QOCEb3CZjOiPpkHEk/X7UMBjdk0gRucuZzJhR0kvnTebuLgKrmH
         rGZBU6Q6QL7ln5iX9pKVC593KAYi/j3htHYz/zQ+YD4D9dOrWDc+LyFaipd6VqT0BOyz
         UgN8i/bNxgw85Fb3zx1v4xzlDHEawC8ys9+UVq3Ie5FnP49Sx+jSKaYeaCYtqmvsMqKd
         79rwsHsWYzA3fe4M74brUkQj8h7L7FrXlrjgUDklSyvHtldJkMxi65/rja/46dsnK9WJ
         aL6uPs0Wh7y6LJwQgpJM7p/lRcbPHspUcBfgUxtCryHXh7nqKYmpZjjocyblvNSpaeQR
         cLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICNgre31Vkr1jiI14jV6Rv7hm2wKM+f1gjZng17AJZo=;
        b=736GuWX6i4BDVmmRVHIwohIG+GoeUp8xEfAizQiY5vIKZZ6Jyw5Wq4CVBX8TQJ6JVi
         eZKRjHzSfGjY0zJOAg38ZM8pGlsbE1/rB1tk3+c97NByPWWTiU9zbdtTIEAwMmDtBUzE
         f1SAkkvwaylQdx2JDZ38TEl3anXHcf9KBqgkDv/WnjKUX1nygNQKjLsLQRMb9jyMDQ92
         pLGL8S7zGYQWYrIfHU+jCG6GjussMzY+l0bpF9YrUKNJh/VWP8zl7X3uCyxsn8oz7VyW
         ozBrOmuCcdxfYWxYs1HBRFlAmh/s59wCmesnEu+ZkM+080/yRi5TWXz6BQcozaD/hCY3
         pR+w==
X-Gm-Message-State: AOAM531dNQnvU7KSrRDYujHgNGhifw1i2DNedy2sBDqKW6P3ZNtBq7Pe
        qP2Xw9CdbcNkInV42YK6CGI=
X-Google-Smtp-Source: ABdhPJx+jfO1oobwtGuVgAl+93Oe7StQqmvwAKxRsFrqHCVaMM9OpXcShpEVTTwScI3cjGVzCsyTZw==
X-Received: by 2002:ac2:50d1:0:b0:44a:12e5:9d3e with SMTP id h17-20020ac250d1000000b0044a12e59d3emr17878713lfm.25.1648915281518;
        Sat, 02 Apr 2022 09:01:21 -0700 (PDT)
Received: from rsa-laptop.rossosh.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id f25-20020a193819000000b0044a59b380c0sm558775lfa.68.2022.04.02.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:01:21 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 3/3] ath10k: add encapsulation offloading support
Date:   Sat,  2 Apr 2022 19:01:11 +0300
Message-Id: <20220402160111.12877-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
References: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Frame encapsulation from Ethernet into the IEEE 802.11 frame format
takes a considerable host CPU time on the xmit path. The firmware is
able to do this operation for us, so enable encapsulation offloading for
AP and Sta interface types to improve overall system performance.

The driver is almost ready for encapsulation offloading support. There
are only a few places where the driver assumes the frame format is IEEE
802.11 that need to be fixed.

Encapsulation offloading is currently disabled by default and the driver
utilizes mac80211 encapsulation support. To activate offloading, the
frame_mode=2 parameter should be passed during module loading.

On a QCA9563+QCA9888-based access point in bridged mode, encapsulation
offloading increases TCP 16-streams DL throughput from 365 to 396 mbps
(+8%) and UDP DL throughput from 436 to 483 mbps (+11%).

Tested-on: QCA9888 hw 2.0 10.4-3.9.0.2-00131
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c  | 67 +++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index b74b6f5a7178..f8f28682c431 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(uart_print, "Uart target debugging");
 MODULE_PARM_DESC(skip_otp, "Skip otp failure for calibration in testmode");
 MODULE_PARM_DESC(cryptmode, "Crypto mode: 0-hardware, 1-software");
 MODULE_PARM_DESC(frame_mode,
-		 "Datapath frame mode (0: raw, 1: native wifi (default))");
+		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
 MODULE_PARM_DESC(coredump_mask, "Bitfield of what to include in firmware crash file");
 MODULE_PARM_DESC(fw_diag_log, "Diag based fw log debugging");
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b11aaee8b8c0..0886e141aad4 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3710,6 +3710,9 @@ ath10k_mac_tx_h_get_txmode(struct ath10k *ar,
 	const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
 	__le16 fc = hdr->frame_control;
 
+	if (IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		return ATH10K_HW_TXRX_ETHERNET;
+
 	if (!vif || vif->type == NL80211_IFTYPE_MONITOR)
 		return ATH10K_HW_TXRX_RAW;
 
@@ -3870,6 +3873,12 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 	bool noack = false;
 
 	cb->flags = 0;
+
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		cb->flags |= ATH10K_SKB_F_QOS;	/* Assume data frames are QoS */
+		goto finish_cb_fill;
+	}
+
 	if (!ath10k_tx_h_use_hwcrypto(vif, skb))
 		cb->flags |= ATH10K_SKB_F_NO_HWCRYPT;
 
@@ -3908,6 +3917,7 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 		cb->flags |= ATH10K_SKB_F_RAW_TX;
 	}
 
+finish_cb_fill:
 	cb->vif = vif;
 	cb->txq = txq;
 	cb->airtime_est = airtime;
@@ -4031,7 +4041,11 @@ static int ath10k_mac_tx(struct ath10k *ar,
 		ath10k_tx_h_seq_no(vif, skb);
 		break;
 	case ATH10K_HW_TXRX_ETHERNET:
-		ath10k_tx_h_8023(skb);
+		/* Convert 802.11->802.3 header only if the frame was erlier
+		 * encapsulated to 802.11 by mac80211. Otherwise pass it as is.
+		 */
+		if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
+			ath10k_tx_h_8023(skb);
 		break;
 	case ATH10K_HW_TXRX_RAW:
 		if (!test_bit(ATH10K_FLAG_RAW_MODE, &ar->dev_flags) &&
@@ -4643,12 +4657,10 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ieee80211_sta *sta = control->sta;
 	struct ieee80211_txq *txq = NULL;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
 	enum ath10k_hw_txrx_mode txmode;
 	enum ath10k_mac_tx_path txpath;
 	bool is_htt;
 	bool is_mgmt;
-	bool is_presp;
 	int ret;
 	u16 airtime;
 
@@ -4662,8 +4674,14 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 	is_mgmt = (txpath == ATH10K_MAC_TX_HTT_MGMT);
 
 	if (is_htt) {
+		bool is_presp = false;
+
 		spin_lock_bh(&ar->htt.tx_lock);
-		is_presp = ieee80211_is_probe_resp(hdr->frame_control);
+		if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
+			struct ieee80211_hdr *hdr = (void *)skb->data;
+
+			is_presp = ieee80211_is_probe_resp(hdr->frame_control);
+		}
 
 		ret = ath10k_htt_tx_inc_pending(htt);
 		if (ret) {
@@ -5447,6 +5465,30 @@ static int ath10k_mac_set_txbf_conf(struct ath10k_vif *arvif)
 					 ar->wmi.vdev_param->txbf, value);
 }
 
+static void ath10k_update_vif_offload(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif)
+{
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k *ar = hw->priv;
+	u32 vdev_param;
+	int ret;
+
+	if (ath10k_frame_mode != ATH10K_HW_TXRX_ETHERNET ||
+	    ar->wmi.vdev_param->tx_encap_type == WMI_VDEV_PARAM_UNSUPPORTED ||
+	     (vif->type != NL80211_IFTYPE_STATION &&
+	      vif->type != NL80211_IFTYPE_AP))
+		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+
+	vdev_param = ar->wmi.vdev_param->tx_encap_type;
+	ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
+					ATH10K_HW_TXRX_NATIVE_WIFI);
+	/* 10.X firmware does not support this VDEV parameter. Do not warn */
+	if (ret && ret != -EOPNOTSUPP) {
+		ath10k_warn(ar, "failed to set vdev %i TX encapsulation: %d\n",
+			    arvif->vdev_id, ret);
+	}
+}
+
 /*
  * TODO:
  * Figure out how to handle WMI_VDEV_SUBTYPE_P2P_DEVICE,
@@ -5656,15 +5698,7 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 
 	arvif->def_wep_key_idx = -1;
 
-	vdev_param = ar->wmi.vdev_param->tx_encap_type;
-	ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
-					ATH10K_HW_TXRX_NATIVE_WIFI);
-	/* 10.X firmware does not support this VDEV parameter. Do not warn */
-	if (ret && ret != -EOPNOTSUPP) {
-		ath10k_warn(ar, "failed to set vdev %i TX encapsulation: %d\n",
-			    arvif->vdev_id, ret);
-		goto err_vdev_delete;
-	}
+	ath10k_update_vif_offload(hw, vif);
 
 	/* Configuring number of spatial stream for monitor interface is causing
 	 * target assert in qca9888 and qca6174.
@@ -9353,6 +9387,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.stop				= ath10k_stop,
 	.config				= ath10k_config,
 	.add_interface			= ath10k_add_interface,
+	.update_vif_offload		= ath10k_update_vif_offload,
 	.remove_interface		= ath10k_remove_interface,
 	.configure_filter		= ath10k_configure_filter,
 	.bss_info_changed		= ath10k_bss_info_changed,
@@ -10022,6 +10057,12 @@ int ath10k_mac_register(struct ath10k *ar)
 	if (test_bit(WMI_SERVICE_TDLS_UAPSD_BUFFER_STA, ar->wmi.svc_map))
 		ieee80211_hw_set(ar->hw, SUPPORTS_TDLS_BUFFER_STA);
 
+	if (ath10k_frame_mode == ATH10K_HW_TXRX_ETHERNET) {
+		if (ar->wmi.vdev_param->tx_encap_type !=
+		    WMI_VDEV_PARAM_UNSUPPORTED)
+			ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	}
+
 	ar->hw->wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 	ar->hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	ar->hw->wiphy->max_remain_on_channel_duration = 5000;
-- 
2.34.1

