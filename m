Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A1C18C796
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 07:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCTGi7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 02:38:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44778 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgCTGi4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 02:38:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id 37so2562239pgm.11
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Gz23ad9AvdRoMjmJFcsLfjZKfRHk6dvHUMzeLv4Wjw=;
        b=GrR9VV/Jq9umbquLRVw1EwHmsDlx7qq470R4dR8XLM3KMa0kYapSCjUs/UC70/Y3JK
         586CSwAQ+uib6khtLjipY2Azs93Ya0Up+T6MuW3HI+iBxgyNq7AaFjL0oEeDBxVe5L06
         wL9KWUcDThTLTR6xBD460qU/s191ZZ+r6lsCKnlwcVgTHuF4J4/pJdkbn64Am/s8pOgC
         +XUhVFSIQ+PP52slvKBTxVU3eDD3VndHnNw/MxTYzUIWjAnubpCeYpQxySSiSmkWTYNP
         nABl0K/YNAJP1K+Zyctk16c3bdxohta9H8qCcO7DJFwQr4yBIBgv2Nej4AcmkNXKshzJ
         C41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Gz23ad9AvdRoMjmJFcsLfjZKfRHk6dvHUMzeLv4Wjw=;
        b=YhjeADYXKqI7PaVlrPzRZ2sXjxkZ0FZQBLxu1i87aEhzFynEtdP/uf7ULMMQ2K1IXF
         SR18ksVhAbN5ymaTwFO2dE0d8+3OWt5Hg2qK0/nW/f1I8RaOPuwSbtr0G2yiVS2zCEo6
         7G7jKYhP+lVWu06ZCYjLSuhcTXvfmtLfPGbuXrlace7fKh5nlnLhWrlaLHefeUZfbo+x
         PHRZ2ntUaHeuSKJeY1Nr884VWB/dNbT5x+mvhGAWOZDA2IxvjGQJKp3v4vVPPSHMhFFQ
         83TpbPN5Z4HKV2QQ8iUGImDFev3vPxYB1N5JFE1y52vezCriM2z1znSU9LtV2ogJdt5N
         fkfg==
X-Gm-Message-State: ANhLgQ2kLCbAbjeDZsqh+7nHAZuWb6eh5A8M9nR3nfK4BNp1rwTTCsRk
        TEJRIS2irjkqMlMoXJ57YnUwZQ==
X-Google-Smtp-Source: ADFU+vtXDTo5wevM9skvrRSf+gizUi9kU2ZHkCT0Tj1M5HBjmttRJU36h2f8oxdfASpetZKz9BtPGQ==
X-Received: by 2002:a63:6ec7:: with SMTP id j190mr7040675pgc.356.1584686335108;
        Thu, 19 Mar 2020 23:38:55 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id y3sm4370901pfy.158.2020.03.19.23.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 23:38:54 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH v2 2/2] rtl8xxxu: Feed current txrate information for mac80211
Date:   Fri, 20 Mar 2020 14:38:33 +0800
Message-Id: <20200320063833.1058-3-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200320063833.1058-1-chiu@endlessm.com>
References: <20200320063833.1058-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The nl80211 commands such as 'iw link' can't get current txrate
information from the driver. This commit fills in the tx rate
information from the C2H RA report in the sta_statistics function.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---

Note:
  v2: Make the rtl8xxxu_desc_to_mcsrate() static 

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 12 ++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 75 ++++++++++++++++++-
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 86d1d50511a8..e6fd1ecaca9c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1183,13 +1183,16 @@ struct rtl8723bu_c2h {
 		} __packed bt_info;
 		struct {
 			u8 rate:7;
-			u8 dummy0_0:1;
+			u8 sgi:1;
 			u8 macid;
 			u8 ldpc:1;
 			u8 txbf:1;
 			u8 noisy_state:1;
 			u8 dummy2_0:5;
 			u8 dummy3_0;
+			u8 dummy4_0;
+			u8 dummy5_0;
+			u8 bw;
 		} __packed ra_report;
 	};
 };
@@ -1269,6 +1272,12 @@ struct rtl8xxxu_btcoex {
 #define RTL8XXXU_SNR_THRESH_HIGH	50
 #define RTL8XXXU_SNR_THRESH_LOW	20
 
+struct rtl8xxxu_ra_report {
+	struct rate_info txrate;
+	u32 bit_rate;
+	u8 desc_rate;
+};
+
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
 	struct usb_device *udev;
@@ -1384,6 +1393,7 @@ struct rtl8xxxu_priv {
 	struct sk_buff_head c2hcmd_queue;
 	spinlock_t c2hcmd_lock;
 	struct rtl8xxxu_btcoex bt_coex;
+	struct rtl8xxxu_ra_report ra_report;
 };
 
 struct rtl8xxxu_rx_urb {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c334418cd7ae..19efae462a24 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5389,6 +5389,35 @@ void rtl8723bu_handle_bt_info(struct rtl8xxxu_priv *priv)
 	}
 }
 
+static struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
+	{.bitrate = 10, .hw_value = 0x00,},
+	{.bitrate = 20, .hw_value = 0x01,},
+	{.bitrate = 55, .hw_value = 0x02,},
+	{.bitrate = 110, .hw_value = 0x03,},
+	{.bitrate = 60, .hw_value = 0x04,},
+	{.bitrate = 90, .hw_value = 0x05,},
+	{.bitrate = 120, .hw_value = 0x06,},
+	{.bitrate = 180, .hw_value = 0x07,},
+	{.bitrate = 240, .hw_value = 0x08,},
+	{.bitrate = 360, .hw_value = 0x09,},
+	{.bitrate = 480, .hw_value = 0x0a,},
+	{.bitrate = 540, .hw_value = 0x0b,},
+};
+
+static void rtl8xxxu_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
+{
+	if (rate <= DESC_RATE_54M)
+		return;
+
+	if (rate >= DESC_RATE_MCS0 && rate <= DESC_RATE_MCS15) {
+		if (rate < DESC_RATE_MCS8)
+			*nss = 1;
+		else
+			*nss = 2;
+		*mcs = rate - DESC_RATE_MCS0;
+	}
+}
+
 static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 {
 	struct rtl8xxxu_priv *priv;
@@ -5397,9 +5426,14 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 	unsigned long flags;
 	u8 bt_info = 0;
 	struct rtl8xxxu_btcoex *btcoex;
+	struct rtl8xxxu_ra_report *rarpt;
+	u8 rate, sgi, bw;
+	u32 bit_rate;
+	u8 mcs = 0, nss = 0;
 
 	priv = container_of(work, struct rtl8xxxu_priv, c2hcmd_work);
 	btcoex = &priv->bt_coex;
+	rarpt = &priv->ra_report;
 
 	if (priv->rf_paths > 1)
 		goto out;
@@ -5422,6 +5456,34 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 			}
 			rtl8723bu_handle_bt_info(priv);
 			break;
+		case C2H_8723B_RA_REPORT:
+			rarpt->txrate.flags = 0;
+			rate = c2h->ra_report.rate;
+			sgi = c2h->ra_report.sgi;
+			bw = c2h->ra_report.bw;
+
+			if (rate < DESC_RATE_MCS0) {
+				rarpt->txrate.legacy =
+					rtl8xxxu_legacy_ratetable[rate].bitrate;
+			} else {
+				rtl8xxxu_desc_to_mcsrate(rate, &mcs, &nss);
+				rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
+
+				rarpt->txrate.mcs = mcs;
+				rarpt->txrate.nss = nss;
+
+				if (sgi) {
+					rarpt->txrate.flags |=
+						RATE_INFO_FLAGS_SHORT_GI;
+				}
+
+				if (bw == RATE_INFO_BW_20)
+					rarpt->txrate.bw |= RATE_INFO_BW_20;
+			}
+			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
+			rarpt->bit_rate = bit_rate;
+			rarpt->desc_rate = rate;
+			break;
 		default:
 			break;
 		}
@@ -5465,7 +5527,7 @@ static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,
 	case C2H_8723B_RA_REPORT:
 		dev_dbg(dev,
 			"C2H RA RPT: rate %02x, unk %i, macid %02x, noise %i\n",
-			c2h->ra_report.rate, c2h->ra_report.dummy0_0,
+			c2h->ra_report.rate, c2h->ra_report.sgi,
 			c2h->ra_report.macid, c2h->ra_report.noisy_state);
 		break;
 	default:
@@ -6069,6 +6131,16 @@ rtl8xxxu_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static void
+rtl8xxxu_sta_statistics(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, struct station_info *sinfo)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	sinfo->txrate = priv->ra_report.txrate;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+}
+
 static u8 rtl8xxxu_signal_to_snr(int signal)
 {
 	if (signal < RTL8XXXU_NOISE_FLOOR_MIN)
@@ -6371,6 +6443,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.sw_scan_complete = rtl8xxxu_sw_scan_complete,
 	.set_key = rtl8xxxu_set_key,
 	.ampdu_action = rtl8xxxu_ampdu_action,
+	.sta_statistics = rtl8xxxu_sta_statistics,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.20.1

