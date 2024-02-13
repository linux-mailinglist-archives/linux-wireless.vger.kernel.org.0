Return-Path: <linux-wireless+bounces-3549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C24853339
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58E5B242FB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D961DFF7;
	Tue, 13 Feb 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZm0nuIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC21B299
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834795; cv=none; b=Z2Szy0pbUj7jqSmMwGKNluipK0xKdw8/yiN6HRcCJ63LIhhYnBgl8qS22e4MNdpLQoYMaPJFjsqLI9e2Cm20hp79O/BQ3fi1LmvMIlF6xcqBNwg6GDq1ukBw7wasVTtFEfz+2IB9JFg2IHKJbVU91idlh5l2ti9BEPZTw9andXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834795; c=relaxed/simple;
	bh=KL5Ul93ymANUDZn10/voe53+3Xh//KjMPUw4UojNmwU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BWFBQNV7RqKF9tA3AYs8tjcAcE50aqV7ZcPs0oWpd7Dh3jhlkOB4WNG4WlFgv56XQCAYuch4o1uM9KfKFXRmCooCDmIxyIwz5+1MAhuU6noc8jk0BsncY5vd++4MI8YvWjTddDo4S0oHds8q+9ALWGt2gs+Qr7KBgt6haXte46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZm0nuIS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-411d231ea71so1549295e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834792; x=1708439592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+pL2WjfFv1sInMZH0Q/O2wjdg1t5+LthYDMUbGvz9Q=;
        b=QZm0nuISiMPaG5QUgiDWhshUzHCXcMKb5hbhlvRk3bZZLjsjfkbUxmVp9vPsjlIv3W
         nGiLruqpu5OtblpTz5O64qFBr+q35L/yw6R83+cEm7+CXsskWPTsCw6wY+8HEDTNqFFZ
         0ftAp+V2/oTageC1F6urI8/hSViSc55QqGxBkT54qV6sVvetWqNw6V8fBoFQqu8mcK6r
         B2kDd9g0WrhwImukO6bSBECePjMV4lOCceNDpfFeUSwf4tefDZIOzISuRiAfBwwHKekf
         lW6rcXPQBdvBQrnMPK3QJmtjMsIeTTlsYD6r57NAwpvkSfmp/DQ9YTY6L+0VjzFR5jj2
         CPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834792; x=1708439592;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+pL2WjfFv1sInMZH0Q/O2wjdg1t5+LthYDMUbGvz9Q=;
        b=EMyNdDXRnzcllW2l98gTlloHsLHoRtqA8ha/Eqjaysd1fYf0nfud9FHFnAw5mrpmWB
         Ativ2Zq8vpsgrb/9CcOk7TERQy8TfWayayHaJy2BEKf/czPZj9AhqesVePWSSlOW/Y46
         bRd33r4ivVPgXLqxqq0jvSohMHaiBrwaWmjq3Pd0QVG9B41zBc402hHbHRcsbl/qVKfa
         glanCgV1RVy1nzTaWB8KH1PxdWcKMqET0xuha1+HmDH2mAa2DNd5wCqU8bScGIadnni4
         HnZubNNuiq3BvpRDi6+VGnCuwY3U6WoW1QC8bpTSqgA7QrxR+qefTw7Vtwq9Al+UlAnk
         oZeg==
X-Gm-Message-State: AOJu0YywndTUwyANLkrV3A3uzWBbOUB4DnwmeyqMYTuLtTng961XA/3v
	407owd9ooG3mASQhx4q8KW8tUN9ASd8Zz8T65TaoUU2fl+wqwQJApCeiKGC6
X-Google-Smtp-Source: AGHT+IH4T2uKhCyXwNGlam+VUVgzmemOEA4KAl898rTBjV6B6ZPyISjOJIPY7hcFH/lG5gbaAT4Cdw==
X-Received: by 2002:a05:600c:46d2:b0:410:8c99:1836 with SMTP id q18-20020a05600c46d200b004108c991836mr9584616wmo.6.1707834792027;
        Tue, 13 Feb 2024 06:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXErSGFGPFHxVP0+kq3RJuNMX77S47JhpMxOdGpZshPcpRdEhLSDu/6H17D7MS/8kstlsEjA40aegYIIZa0amzFeP7tYiYbzBFc
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b0033b43a5f53csm9623995wrr.103.2024.02.13.06.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:33:11 -0800 (PST)
Message-ID: <7b6a602a-6101-4bab-958d-bcff4d565b40@gmail.com>
Date: Tue, 13 Feb 2024 16:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl_usb: Store the endpoint addresses
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

And use the stored addresses in rtl8192cu instead of hardcoding them.

This is what the vendor drivers do.

Perhaps this is not strictly necessary for RTL8192CU devices. However,
the dual mac version of RTL8192DU has two USB interfaces, each with its
own set of endpoints. Hardcoding their addresses in the upcoming
rtl8192du driver would require making some assumptions which I'm not
qualified to make.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  | 77 ++++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.h  |  1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c    | 31 ++++++--
 drivers/net/wireless/realtek/rtlwifi/usb.h    |  2 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  1 -
 6 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index 9f4cf09090d6..48be7e346efc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -145,7 +145,6 @@ MODULE_PARM_DESC(debug_mask, "Set debug mask (default 0)");
 
 static struct rtl_hal_usbint_cfg rtl92cu_interface_cfg = {
 	/* rx */
-	.in_ep_num = RTL92C_USB_BULK_IN_NUM,
 	.rx_urb_num = RTL92C_NUM_RX_URBS,
 	.rx_max_size = RTL92C_SIZE_MAX_RX_BUFFER,
 	.usb_rx_hdl = rtl8192cu_rx_hdl,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index cbbd1dab8af0..b8124b474646 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -79,68 +79,75 @@ static int configvernoutep(struct ieee80211_hw *hw)
 static void twooutepmapping(struct ieee80211_hw *hw, bool is_chip8,
 			     bool  bwificfg, struct rtl_ep_map *ep_map)
 {
+	struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
+	struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (bwificfg) { /* for WMM */
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"USB Chip-B & WMM Setting.....\n");
-		ep_map->ep_mapping[RTL_TXQ_BE]	= 2;
-		ep_map->ep_mapping[RTL_TXQ_BK]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_VI]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_VO] = 2;
-		ep_map->ep_mapping[RTL_TXQ_MGT] = 2;
-		ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
-		ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
+		ep_map->ep_mapping[RTL_TXQ_BE]	= rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_BK]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_VI]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_VO]	= rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_HI]	= rtlusb->out_eps[0];
 	} else { /* typical setting */
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"USB typical Setting.....\n");
-		ep_map->ep_mapping[RTL_TXQ_BE]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_BK]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_VI]	= 2;
-		ep_map->ep_mapping[RTL_TXQ_VO]	= 2;
-		ep_map->ep_mapping[RTL_TXQ_MGT] = 2;
-		ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
-		ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
+		ep_map->ep_mapping[RTL_TXQ_BE]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_BK]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_VI]	= rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_VO]	= rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_HI]	= rtlusb->out_eps[0];
 	}
 }
 
 static void threeoutepmapping(struct ieee80211_hw *hw, bool  bwificfg,
 			       struct rtl_ep_map *ep_map)
 {
+	struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
+	struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (bwificfg) { /* for WMM */
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"USB 3EP Setting for WMM.....\n");
-		ep_map->ep_mapping[RTL_TXQ_BE]	= 5;
-		ep_map->ep_mapping[RTL_TXQ_BK]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_VI]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_VO]	= 2;
-		ep_map->ep_mapping[RTL_TXQ_MGT] = 2;
-		ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
-		ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
+		ep_map->ep_mapping[RTL_TXQ_BE]	= rtlusb->out_eps[2];
+		ep_map->ep_mapping[RTL_TXQ_BK]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_VI]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_VO]	= rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_HI]	= rtlusb->out_eps[0];
 	} else { /* typical setting */
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"USB 3EP Setting for typical.....\n");
-		ep_map->ep_mapping[RTL_TXQ_BE]	= 5;
-		ep_map->ep_mapping[RTL_TXQ_BK]	= 5;
-		ep_map->ep_mapping[RTL_TXQ_VI]	= 3;
-		ep_map->ep_mapping[RTL_TXQ_VO]	= 2;
-		ep_map->ep_mapping[RTL_TXQ_MGT] = 2;
-		ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
-		ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
+		ep_map->ep_mapping[RTL_TXQ_BE]	= rtlusb->out_eps[2];
+		ep_map->ep_mapping[RTL_TXQ_BK]	= rtlusb->out_eps[2];
+		ep_map->ep_mapping[RTL_TXQ_VI]	= rtlusb->out_eps[1];
+		ep_map->ep_mapping[RTL_TXQ_VO]	= rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+		ep_map->ep_mapping[RTL_TXQ_HI]	= rtlusb->out_eps[0];
 	}
 }
 
 static void oneoutepmapping(struct ieee80211_hw *hw, struct rtl_ep_map *ep_map)
 {
-	ep_map->ep_mapping[RTL_TXQ_BE]	= 2;
-	ep_map->ep_mapping[RTL_TXQ_BK]	= 2;
-	ep_map->ep_mapping[RTL_TXQ_VI]	= 2;
-	ep_map->ep_mapping[RTL_TXQ_VO] = 2;
-	ep_map->ep_mapping[RTL_TXQ_MGT] = 2;
-	ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
-	ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
+	struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
+	struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
+
+	ep_map->ep_mapping[RTL_TXQ_BE]	= rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BK]	= rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VI]	= rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VO]	= rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI]	= rtlusb->out_eps[0];
 }
 
 static int _out_ep_mapping(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index caeebe4480ff..09e61dc0f317 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -4,7 +4,6 @@
 #ifndef __RTL92CU_TRX_H__
 #define __RTL92CU_TRX_H__
 
-#define RTL92C_USB_BULK_IN_NUM			1
 #define RTL92C_NUM_RX_URBS			8
 #define RTL92C_NUM_TX_URBS			32
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 1fc480fe18ad..6e8c87a2fae4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -216,7 +216,6 @@ static int _rtl_usb_init_rx(struct ieee80211_hw *hw)
 
 	rtlusb->rx_max_size = rtlpriv->cfg->usb_interface_cfg->rx_max_size;
 	rtlusb->rx_urb_num = rtlpriv->cfg->usb_interface_cfg->rx_urb_num;
-	rtlusb->in_ep = rtlpriv->cfg->usb_interface_cfg->in_ep_num;
 	rtlusb->usb_rx_hdl = rtlpriv->cfg->usb_interface_cfg->usb_rx_hdl;
 	rtlusb->usb_rx_segregate_hdl =
 		rtlpriv->cfg->usb_interface_cfg->usb_rx_segregate_hdl;
@@ -248,20 +247,38 @@ static int _rtl_usb_init(struct ieee80211_hw *hw)
 
 		pep_desc = &usb_intf->cur_altsetting->endpoint[epidx].desc;
 
-		if (usb_endpoint_dir_in(pep_desc))
+		if (usb_endpoint_dir_in(pep_desc)) {
+			if (usb_endpoint_xfer_bulk(pep_desc)) {
+				/* The vendor drivers assume there is only one
+				 * bulk in ep and that it's the first in ep.
+				 */
+				if (rtlusb->in_ep_nums == 0)
+					rtlusb->in_ep = usb_endpoint_num(pep_desc);
+				else
+					pr_warn("%s: bulk in endpoint is not the first in endpoint\n",
+						__func__);
+			}
+
 			rtlusb->in_ep_nums++;
-		else if (usb_endpoint_dir_out(pep_desc))
+		} else if (usb_endpoint_dir_out(pep_desc)) {
+			if (rtlusb->out_ep_nums < RTL_USB_MAX_BULKOUT_NUM) {
+				if (usb_endpoint_xfer_bulk(pep_desc))
+					rtlusb->out_eps[rtlusb->out_ep_nums] =
+							usb_endpoint_num(pep_desc);
+			} else {
+				pr_warn("%s: found more bulk out endpoints than the expected %d\n",
+					__func__, RTL_USB_MAX_BULKOUT_NUM);
+			}
+
 			rtlusb->out_ep_nums++;
+		}
 
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"USB EP(0x%02x), MaxPacketSize=%d, Interval=%d\n",
 			pep_desc->bEndpointAddress, pep_desc->wMaxPacketSize,
 			pep_desc->bInterval);
 	}
-	if (rtlusb->in_ep_nums <  rtlpriv->cfg->usb_interface_cfg->in_ep_num) {
-		pr_err("Too few input end points found\n");
-		return -EINVAL;
-	}
+
 	if (rtlusb->out_ep_nums == 0) {
 		pr_err("No output end points found\n");
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.h b/drivers/net/wireless/realtek/rtlwifi/usb.h
index 3bf85b23eec1..12529afc0510 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.h
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.h
@@ -19,6 +19,7 @@
 
 #define RTL_USB_MAX_TXQ_NUM		4		/* max tx queue */
 #define RTL_USB_MAX_EP_NUM		6		/* max ep number */
+#define RTL_USB_MAX_BULKOUT_NUM		4
 #define RTL_USB_MAX_TX_URBS_NUM		8
 
 enum rtl_txq {
@@ -94,6 +95,7 @@ struct rtl_usb {
 
 	/* Tx */
 	u8 out_ep_nums ;
+	u8 out_eps[RTL_USB_MAX_BULKOUT_NUM];
 	u8 out_queue_sel;
 	struct rtl_ep_map ep_map;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index b65d54115eac..f388d13e2ba8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2353,7 +2353,6 @@ struct rtl_mod_params {
 
 struct rtl_hal_usbint_cfg {
 	/* data - rx */
-	u32 in_ep_num;
 	u32 rx_urb_num;
 	u32 rx_max_size;
 
-- 
2.43.0

