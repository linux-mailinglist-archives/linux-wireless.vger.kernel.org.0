Return-Path: <linux-wireless+bounces-7333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F098BFB4F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206191C21185
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A51481C4;
	Wed,  8 May 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk1fx8gh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970007B3FD
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165447; cv=none; b=pJihjwZvUoHBHtyXPvzgqR2nQzRRiHPeeAC6dadJVdLDoks+NOBA7YI5FRIAUurneVyplskae++KGf/BNiSWSwvdlNqnIddnMXSskiKWmeH6wYrcz/Eh4MgeJtQJZy1i7Uke37IU1kIbhQ/H7N1gQpvwaI077UjBYaMyLP6kjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165447; c=relaxed/simple;
	bh=gnNI1CmEi+G+lCzGlkxsVmYwPmox6c00vZ7vlgP0gOU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jWAvAfzkBqhp5JqxW36lPiBNgemkDG9zGR0KsF1ozNz3L6t89bIOGvwV1cvJCRKtNsirPWKoBH3UFFbN7wtNLrWKYmGNT6GEWtiRmPWxkO30VyVP7KJ0pect/wZaPYCsVoo9CSc6fmmbgKwM9H1PJHAtaOa9rnJ9Nf0OhIAeUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk1fx8gh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a8f0d941so1108424166b.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165444; x=1715770244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KfD9AGkDJ3LUIeWERO8+Ikrp44I26y0e4sFd0c+nZEI=;
        b=Gk1fx8gh7fotlweeMffq2vzgbySpQOnMmMCkS1A+Q0qpykTGmligMvcUPgVkOpGw64
         Ch9MFCVwME9TOt6xF4E87JT5aYvWpPO9L+Ln5/Enghz73FfIIUrOBEYYsojd04u4WyeQ
         AAW9WqQN4lwn1FQb1EX3dKcTAk0anGmg/BCirhJaz5t3c4m4QnXOpS0TNylNfIn2GGid
         KZJSbdJF6SiLCNfwmXENHXwNpfDyZZgCMTBPXg8N/txjsOWTLDfaa9bdguts3sxyF4mM
         RtaimMAxUpfaC+kdaMr/0H7SMplmXZaXkPc2FfkyVIg++kY3vgDjyAJFv/7SrsTPVPue
         3NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165444; x=1715770244;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfD9AGkDJ3LUIeWERO8+Ikrp44I26y0e4sFd0c+nZEI=;
        b=in3GOsZF3QYMHH8hU423Q2UBEkqz8GfbIkl23MkjTAuuPjwBtqcyX5eAkYX2tOOGbU
         XnsI/fEF5TPrzmlYRLwjNLkcv7L0nye80oI4XVJOEck+PBaXoDLHqBC30ghWbpBZzXue
         kiPYxiadYJPWhz+weRrQ1BGe3a+V5p5NheJTOExUuCt70Hikv6R3hvKUpz8CU6MZ6B/s
         Tye1uTy9dVFW/h8In5qWWLh1raikWHLsR/xf+CxcX2fBwXdmqThSUzRXHinx3cj2RxKr
         axAWKphAzyM7c/t0GskS9RsKhX3o4iK6dX6DrXnIpwEpMZahZpVAZAQh71kH8TEeK9w2
         pWtA==
X-Gm-Message-State: AOJu0Yz8PmyWR5HbE94//BsPi0+cqSP5fqQcAuIP0fsYz5T7//Y8L1QR
	4z1imV/sH1rSGf+r+begXhKnio2U6qeifNxlze7U+A0DD7lWJseO1vb8YQLJ
X-Google-Smtp-Source: AGHT+IFEirEyWDLUE/0rhHz5Jz7Q3/vXHGamtf7tgP5vCQcrW5lVCSFs8mWJw6mPs3mRJ68eDpQrBA==
X-Received: by 2002:a50:9ec1:0:b0:572:a7a6:8ecd with SMTP id 4fb4d7f45d1cf-5731d9b76f6mr1499606a12.8.1715165443853;
        Wed, 08 May 2024 03:50:43 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id e22-20020a056402105600b0057300ba262esm3376520edu.34.2024.05.08.03.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:50:43 -0700 (PDT)
Message-ID: <da52694a-15a1-4d18-afbc-98545a729e15@gmail.com>
Date: Wed, 8 May 2024 13:50:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 05/11] wifi: rtlwifi: Add rtl8192du/trx.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Language: en-US
In-Reply-To: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These contain routines related to sending frames to the chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v5:
 - No change.

v4:
 - Fix trx.h header guard.
 - Delete unnecessary err, error variables.
 - Simplify rtl92du_tx_fill_desc, add empty lines.

v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  | 377 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |  60 +++
 2 files changed, 437 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
new file mode 100644
index 000000000000..dbf04ad20060
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../pci.h"
+#include "../base.h"
+#include "../stats.h"
+#include "../usb.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/trx_common.h"
+#include "phy.h"
+#include "trx.h"
+#include "led.h"
+
+void rtl92du_tx_cleanup(struct ieee80211_hw *hw, struct sk_buff *skb)
+{
+}
+
+int rtl92du_tx_post_hdl(struct ieee80211_hw *hw, struct urb *urb,
+			struct sk_buff *skb)
+{
+	return 0;
+}
+
+struct sk_buff *rtl92du_tx_aggregate_hdl(struct ieee80211_hw *hw,
+					 struct sk_buff_head *list)
+{
+	return skb_dequeue(list);
+}
+
+static enum rtl_desc_qsel _rtl92du_hwq_to_descq(u16 queue_index)
+{
+	switch (queue_index) {
+	case RTL_TXQ_BCN:
+		return QSLT_BEACON;
+	case RTL_TXQ_MGT:
+		return QSLT_MGNT;
+	case RTL_TXQ_VO:
+		return QSLT_VO;
+	case RTL_TXQ_VI:
+		return QSLT_VI;
+	case RTL_TXQ_BK:
+		return QSLT_BK;
+	default:
+	case RTL_TXQ_BE:
+		return QSLT_BE;
+	}
+}
+
+/* For HW recovery information */
+static void _rtl92du_tx_desc_checksum(__le32 *txdesc)
+{
+	__le16 *ptr = (__le16 *)txdesc;
+	u16 checksum = 0;
+	u32 index;
+
+	/* Clear first */
+	set_tx_desc_tx_desc_checksum(txdesc, 0);
+	for (index = 0; index < 16; index++)
+		checksum = checksum ^ le16_to_cpu(*(ptr + index));
+	set_tx_desc_tx_desc_checksum(txdesc, checksum);
+}
+
+void rtl92du_tx_fill_desc(struct ieee80211_hw *hw,
+			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
+			  struct ieee80211_sta *sta,
+			  struct sk_buff *skb,
+			  u8 queue_index,
+			  struct rtl_tcb_desc *tcb_desc)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	struct rtl_sta_info *sta_entry;
+	__le16 fc = hdr->frame_control;
+	u8 agg_state = RTL_AGG_STOP;
+	u16 pktlen = skb->len;
+	u32 rts_en, hw_rts_en;
+	u8 ampdu_density = 0;
+	u16 seq_number;
+	__le32 *txdesc;
+	u8 rate_flag;
+	u8 tid;
+
+	rtl_get_tcb_desc(hw, info, sta, skb, tcb_desc);
+
+	txdesc = (__le32 *)skb_push(skb, RTL_TX_HEADER_SIZE);
+	memset(txdesc, 0, RTL_TX_HEADER_SIZE);
+
+	set_tx_desc_pkt_size(txdesc, pktlen);
+	set_tx_desc_linip(txdesc, 0);
+	set_tx_desc_pkt_offset(txdesc, RTL_DUMMY_OFFSET);
+	set_tx_desc_offset(txdesc, RTL_TX_HEADER_SIZE);
+	/* 5G have no CCK rate */
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		if (tcb_desc->hw_rate < DESC_RATE6M)
+			tcb_desc->hw_rate = DESC_RATE6M;
+
+	set_tx_desc_tx_rate(txdesc, tcb_desc->hw_rate);
+	if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
+		set_tx_desc_data_shortgi(txdesc, 1);
+
+	if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+	    tcb_desc->hw_rate == DESC_RATEMCS7)
+		set_tx_desc_data_shortgi(txdesc, 1);
+
+	if (sta) {
+		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
+		tid = ieee80211_get_tid(hdr);
+		agg_state = sta_entry->tids[tid].agg.agg_state;
+		ampdu_density = sta->deflink.ht_cap.ampdu_density;
+	}
+
+	if (agg_state == RTL_AGG_OPERATIONAL &&
+	    info->flags & IEEE80211_TX_CTL_AMPDU) {
+		set_tx_desc_agg_enable(txdesc, 1);
+		set_tx_desc_max_agg_num(txdesc, 0x14);
+		set_tx_desc_ampdu_density(txdesc, ampdu_density);
+		tcb_desc->rts_enable = 1;
+		tcb_desc->rts_rate = DESC_RATE24M;
+	} else {
+		set_tx_desc_agg_break(txdesc, 1);
+	}
+	seq_number = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
+	set_tx_desc_seq(txdesc, seq_number);
+
+	rts_en = tcb_desc->rts_enable && !tcb_desc->cts_enable;
+	hw_rts_en = tcb_desc->rts_enable || tcb_desc->cts_enable;
+	set_tx_desc_rts_enable(txdesc, rts_en);
+	set_tx_desc_hw_rts_enable(txdesc, hw_rts_en);
+	set_tx_desc_cts2self(txdesc, tcb_desc->cts_enable);
+	set_tx_desc_rts_stbc(txdesc, tcb_desc->rts_stbc);
+	/* 5G have no CCK rate */
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		if (tcb_desc->rts_rate < DESC_RATE6M)
+			tcb_desc->rts_rate = DESC_RATE6M;
+	set_tx_desc_rts_rate(txdesc, tcb_desc->rts_rate);
+	set_tx_desc_rts_bw(txdesc, 0);
+	set_tx_desc_rts_sc(txdesc, tcb_desc->rts_sc);
+	set_tx_desc_rts_short(txdesc, tcb_desc->rts_use_shortpreamble);
+
+	rate_flag = info->control.rates[0].flags;
+	if (mac->bw_40) {
+		if (rate_flag & IEEE80211_TX_RC_DUP_DATA) {
+			set_tx_desc_data_bw(txdesc, 1);
+			set_tx_desc_tx_sub_carrier(txdesc, 3);
+		} else if (rate_flag & IEEE80211_TX_RC_40_MHZ_WIDTH) {
+			set_tx_desc_data_bw(txdesc, 1);
+			set_tx_desc_tx_sub_carrier(txdesc, mac->cur_40_prime_sc);
+		} else {
+			set_tx_desc_data_bw(txdesc, 0);
+			set_tx_desc_tx_sub_carrier(txdesc, 0);
+		}
+	} else {
+		set_tx_desc_data_bw(txdesc, 0);
+		set_tx_desc_tx_sub_carrier(txdesc, 0);
+	}
+
+	if (info->control.hw_key) {
+		struct ieee80211_key_conf *keyconf = info->control.hw_key;
+
+		switch (keyconf->cipher) {
+		case WLAN_CIPHER_SUITE_WEP40:
+		case WLAN_CIPHER_SUITE_WEP104:
+		case WLAN_CIPHER_SUITE_TKIP:
+			set_tx_desc_sec_type(txdesc, 0x1);
+			break;
+		case WLAN_CIPHER_SUITE_CCMP:
+			set_tx_desc_sec_type(txdesc, 0x3);
+			break;
+		default:
+			set_tx_desc_sec_type(txdesc, 0x0);
+			break;
+		}
+	}
+
+	set_tx_desc_pkt_id(txdesc, 0);
+	set_tx_desc_queue_sel(txdesc, _rtl92du_hwq_to_descq(queue_index));
+	set_tx_desc_data_rate_fb_limit(txdesc, 0x1F);
+	set_tx_desc_rts_rate_fb_limit(txdesc, 0xF);
+	set_tx_desc_disable_fb(txdesc, 0);
+	set_tx_desc_use_rate(txdesc, tcb_desc->use_driver_rate);
+
+	if (ieee80211_is_data_qos(fc)) {
+		if (mac->rdg_en) {
+			rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+				"Enable RDG function\n");
+			set_tx_desc_rdg_enable(txdesc, 1);
+			set_tx_desc_htc(txdesc, 1);
+		}
+		set_tx_desc_qos(txdesc, 1);
+	}
+
+	if (rtlpriv->dm.useramask) {
+		set_tx_desc_rate_id(txdesc, tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->mac_id);
+	} else {
+		set_tx_desc_rate_id(txdesc, 0xC + tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->ratr_index);
+	}
+
+	if (!ieee80211_is_data_qos(fc) && ppsc->leisure_ps &&
+	    ppsc->fwctrl_lps) {
+		set_tx_desc_hwseq_en(txdesc, 1);
+		set_tx_desc_pkt_id(txdesc, 8);
+	}
+
+	if (ieee80211_has_morefrags(fc))
+		set_tx_desc_more_frag(txdesc, 1);
+	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
+	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
+		set_tx_desc_bmc(txdesc, 1);
+
+	set_tx_desc_own(txdesc, 1);
+	set_tx_desc_last_seg(txdesc, 1);
+	set_tx_desc_first_seg(txdesc, 1);
+	_rtl92du_tx_desc_checksum(txdesc);
+
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
+}
+
+static void _rtl92du_config_out_ep(struct ieee80211_hw *hw, u8 num_out_pipe)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u16 ep_cfg;
+
+	rtlusb->out_queue_sel = 0;
+	rtlusb->out_ep_nums = 0;
+
+	if (rtlhal->interfaceindex == 0)
+		ep_cfg = rtl_read_word(rtlpriv, REG_USB_Queue_Select_MAC0);
+	else
+		ep_cfg = rtl_read_word(rtlpriv, REG_USB_Queue_Select_MAC1);
+
+	if (ep_cfg & 0x00f) {
+		rtlusb->out_queue_sel |= TX_SELE_HQ;
+		rtlusb->out_ep_nums++;
+	}
+	if (ep_cfg & 0x0f0) {
+		rtlusb->out_queue_sel |= TX_SELE_NQ;
+		rtlusb->out_ep_nums++;
+	}
+	if (ep_cfg & 0xf00) {
+		rtlusb->out_queue_sel |= TX_SELE_LQ;
+		rtlusb->out_ep_nums++;
+	}
+
+	switch (num_out_pipe) {
+	case 3:
+		rtlusb->out_queue_sel = TX_SELE_HQ | TX_SELE_NQ | TX_SELE_LQ;
+		rtlusb->out_ep_nums = 3;
+		break;
+	case 2:
+		rtlusb->out_queue_sel = TX_SELE_HQ | TX_SELE_NQ;
+		rtlusb->out_ep_nums = 2;
+		break;
+	case 1:
+		rtlusb->out_queue_sel = TX_SELE_HQ;
+		rtlusb->out_ep_nums = 1;
+		break;
+	default:
+		break;
+	}
+}
+
+static void _rtl92du_one_out_ep_mapping(struct rtl_usb *rtlusb,
+					struct rtl_ep_map *ep_map)
+{
+	ep_map->ep_mapping[RTL_TXQ_BE] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BK] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VI] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VO] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI] = rtlusb->out_eps[0];
+}
+
+static void _rtl92du_two_out_ep_mapping(struct rtl_usb *rtlusb,
+					struct rtl_ep_map *ep_map)
+{
+	ep_map->ep_mapping[RTL_TXQ_BE] = rtlusb->out_eps[1];
+	ep_map->ep_mapping[RTL_TXQ_BK] = rtlusb->out_eps[1];
+	ep_map->ep_mapping[RTL_TXQ_VI] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VO] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI] = rtlusb->out_eps[0];
+}
+
+static void _rtl92du_three_out_ep_mapping(struct rtl_usb *rtlusb,
+					  struct rtl_ep_map *ep_map)
+{
+	ep_map->ep_mapping[RTL_TXQ_BE] = rtlusb->out_eps[2];
+	ep_map->ep_mapping[RTL_TXQ_BK] = rtlusb->out_eps[2];
+	ep_map->ep_mapping[RTL_TXQ_VI] = rtlusb->out_eps[1];
+	ep_map->ep_mapping[RTL_TXQ_VO] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI] = rtlusb->out_eps[0];
+}
+
+static int _rtl92du_out_ep_mapping(struct ieee80211_hw *hw)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_ep_map *ep_map = &rtlusb->ep_map;
+
+	switch (rtlusb->out_ep_nums) {
+	case 1:
+		_rtl92du_one_out_ep_mapping(rtlusb, ep_map);
+		break;
+	case 2:
+		_rtl92du_two_out_ep_mapping(rtlusb, ep_map);
+		break;
+	case 3:
+		_rtl92du_three_out_ep_mapping(rtlusb, ep_map);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int rtl92du_endpoint_mapping(struct ieee80211_hw *hw)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+
+	_rtl92du_config_out_ep(hw, rtlusb->out_ep_nums);
+
+	/* Normal chip with one IN and one OUT doesn't have interrupt IN EP. */
+	if (rtlusb->out_ep_nums == 1 && rtlusb->in_ep_nums != 1)
+		return -EINVAL;
+
+	return _rtl92du_out_ep_mapping(hw);
+}
+
+u16 rtl92du_mq_to_hwq(__le16 fc, u16 mac80211_queue_index)
+{
+	u16 hw_queue_index;
+
+	if (unlikely(ieee80211_is_beacon(fc))) {
+		hw_queue_index = RTL_TXQ_BCN;
+		goto out;
+	}
+	if (ieee80211_is_mgmt(fc)) {
+		hw_queue_index = RTL_TXQ_MGT;
+		goto out;
+	}
+
+	switch (mac80211_queue_index) {
+	case 0:
+		hw_queue_index = RTL_TXQ_VO;
+		break;
+	case 1:
+		hw_queue_index = RTL_TXQ_VI;
+		break;
+	case 2:
+		hw_queue_index = RTL_TXQ_BE;
+		break;
+	case 3:
+		hw_queue_index = RTL_TXQ_BK;
+		break;
+	default:
+		hw_queue_index = RTL_TXQ_BE;
+		WARN_ONCE(true, "rtl8192du: QSLT_BE queue, skb_queue:%d\n",
+			  mac80211_queue_index);
+		break;
+	}
+out:
+	return hw_queue_index;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
new file mode 100644
index 000000000000..24a6f02f2bbb
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DU_TRX_H__
+#define __RTL92DU_TRX_H__
+
+#define TX_SELE_HQ				BIT(0)	/* High Queue */
+#define TX_SELE_LQ				BIT(1)	/* Low Queue */
+#define TX_SELE_NQ				BIT(2)	/* Normal Queue */
+
+#define TX_TOTAL_PAGE_NUMBER_92DU			0xF8
+#define TEST_PAGE_NUM_PUBQ_92DU				0x89
+#define TX_TOTAL_PAGE_NUMBER_92D_DUAL_MAC		0x7A
+#define NORMAL_PAGE_NUM_PUBQ_92D_DUAL_MAC		0x5A
+#define NORMAL_PAGE_NUM_HPQ_92D_DUAL_MAC		0x10
+#define NORMAL_PAGE_NUM_LPQ_92D_DUAL_MAC		0x10
+#define NORMAL_PAGE_NUM_NORMALQ_92D_DUAL_MAC		0
+
+#define WMM_NORMAL_TX_TOTAL_PAGE_NUMBER			0xF5
+
+#define WMM_NORMAL_PAGE_NUM_PUBQ_92D			0x65
+#define WMM_NORMAL_PAGE_NUM_HPQ_92D			0x30
+#define WMM_NORMAL_PAGE_NUM_LPQ_92D			0x30
+#define WMM_NORMAL_PAGE_NUM_NPQ_92D			0x30
+
+#define WMM_NORMAL_PAGE_NUM_PUBQ_92D_DUAL_MAC		0x32
+#define WMM_NORMAL_PAGE_NUM_HPQ_92D_DUAL_MAC		0x18
+#define WMM_NORMAL_PAGE_NUM_LPQ_92D_DUAL_MAC		0x18
+#define WMM_NORMAL_PAGE_NUM_NPQ_92D_DUAL_MAC		0x18
+
+static inline void set_tx_desc_bmc(__le32 *__txdesc, u32 __value)
+{
+	le32p_replace_bits(__txdesc, __value, BIT(24));
+}
+
+static inline void set_tx_desc_agg_break(__le32 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__txdesc + 1), __value, BIT(6));
+}
+
+static inline void set_tx_desc_tx_desc_checksum(__le32 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__txdesc + 7), __value, GENMASK(15, 0));
+}
+
+void rtl92du_tx_fill_desc(struct ieee80211_hw *hw,
+			  struct ieee80211_hdr *hdr, u8 *pdesc,
+			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
+			  struct ieee80211_sta *sta,
+			  struct sk_buff *skb, u8 hw_queue,
+			  struct rtl_tcb_desc *ptcb_desc);
+int rtl92du_endpoint_mapping(struct ieee80211_hw *hw);
+u16 rtl92du_mq_to_hwq(__le16 fc, u16 mac80211_queue_index);
+struct sk_buff *rtl92du_tx_aggregate_hdl(struct ieee80211_hw *hw,
+					 struct sk_buff_head *list);
+void rtl92du_tx_cleanup(struct ieee80211_hw *hw, struct sk_buff  *skb);
+int rtl92du_tx_post_hdl(struct ieee80211_hw *hw, struct urb *urb,
+			struct sk_buff *skb);
+
+#endif
-- 
2.44.0


