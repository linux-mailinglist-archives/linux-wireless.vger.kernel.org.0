Return-Path: <linux-wireless+bounces-4814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC6D87DF5F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA57B20C0C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591061D531;
	Sun, 17 Mar 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNm9ie4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584B1D537
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701516; cv=none; b=qhZ6UYWipvejB86roZUnP31mMVBsUM50z1Zl4M9qLoLe3gV+zsW6pMNNwIs7yRtQJL/9Sbdtyd1dfN4K9nC33JbI170q5bqXT8jolXPQ8ZsDC3b8wRAiJxWC7+Lu2I7fU1cQ1XEeUQQMRNffzWGqhNgr9RnrzxO6E6PGNyujnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701516; c=relaxed/simple;
	bh=CavmDXcZw3UBA59g6ZqWQ7xoa9ES2GHRoL5ZDCWGUEU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VgOtHzsRotfTbPCGM6MoVJCumqm9Y/vDdcLn6Ynau0Ldibew1n2DKLk+VkoelYZYDD8PHhpOW/XgyScYLu1/fkTUdkBlnU4tuQwxh/7llyPo7WlOWz0u8TTK1BiVqlvRQfx3n9Liw8lCokt1D6UY4nHZCEY7O7H1p0BfX53ntMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNm9ie4F; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e6777af4so704300e87.2
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701512; x=1711306312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qrVpd5hOB17cXRrkjyE9wgP2Gw/bh1J5X9cZ0tUuOI=;
        b=gNm9ie4F12ErcMb4s/CJoSbsDvAqqB0gXlhrRpQ3HPmLQIub7Nvb0MXEhGGrvJSmAg
         dnFbkCkM2mJmvkoIS7VxtPy/2xswzrER8ii+SQII7QpI6+EIwpkOD4f6VyHR/7UbqRS/
         M3o3LOSdaz6dvUaoWDjjaWCEL8G5S1Xrd2XlfK2372IFpTMwIeJeKfrwRIGAX6/gSEzX
         k8hZiSjygXbMGWAIq0cz5gp9DfV5IuzzxyMZTktTgKlj69OziUrNWuzKlbc3ihQGtHOk
         WGt97RTP42gf7dsz6wMeLTtLbUsVWYnL9KfucfHOA5lQ6//zXBTYlFzAR+acDiJGFbyw
         9L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701512; x=1711306312;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qrVpd5hOB17cXRrkjyE9wgP2Gw/bh1J5X9cZ0tUuOI=;
        b=kxlFxP4IE97+h4DhLDMHR3jMvpcnPXnPGDN9FD8wK05VRza0vFxUvhQ24h0YQGXWqO
         1/oSvnb599+BHWYJ9Lzr0fHqFri+tfmx9d34sSqozoqDtSRDqN9D34aoaupEVOx8bTUt
         lEmnSLkxOKPYovSNoRnjLY7BHJWgQkl/8XpQdcdqAVIIdvfxOBVe9w2Txt3Ap7Q583Uv
         71mwQKI4sNtebn62X0bXs7qdF/K3rxgttZr5Rh1ylOFnPosBlckW8616XLxyx0NwtkDy
         Yh4etYqzFCpsyNFJGBeymp31g6vKPNLAh9J7sR26ugI5A4aWJZxQoLYb2KxIS9M8gEaX
         S7aw==
X-Gm-Message-State: AOJu0Yxqd9bftYyQTlYeMlYBBxIVlJ6IGaG1TFazrB6QAbSiF8TKYMHN
	zBtYmzqfOinXoIr91xcDyPNBFIjoGa06zmRkX0I+E6PKhombe1ggQ4pS/BpG
X-Google-Smtp-Source: AGHT+IGN8PTGmSApxqzKa7Nmij9J056i3IhVH5Cbhs64zeY6dykfw5bq6+KzrDWETOukL47/SceWyA==
X-Received: by 2002:a19:434e:0:b0:512:fe25:550b with SMTP id m14-20020a19434e000000b00512fe25550bmr3482933lfj.47.1710701512112;
        Sun, 17 Mar 2024 11:51:52 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a4550e8ae70sm4032071ejc.63.2024.03.17.11.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:51:51 -0700 (PDT)
Message-ID: <d610a8cc-5de4-4c92-aed3-eb4621c222c8@gmail.com>
Date: Sun, 17 Mar 2024 20:51:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 07/12] wifi: rtlwifi: Add rtl8192du/trx.{c,h}
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
In-Reply-To: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These contain routines related to sending frames to the chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  | 380 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |  60 +++
 2 files changed, 440 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
new file mode 100644
index 000000000000..830e6e1f2718
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
@@ -0,0 +1,380 @@
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
+	set_tx_desc_rts_enable(txdesc,
+			       ((tcb_desc->rts_enable &&
+				!tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_hw_rts_enable(txdesc,
+				  ((tcb_desc->rts_enable ||
+				   tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_cts2self(txdesc, ((tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_rts_stbc(txdesc, ((tcb_desc->rts_stbc) ? 1 : 0));
+	/* 5G have no CCK rate */
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		if (tcb_desc->rts_rate < DESC_RATE6M)
+			tcb_desc->rts_rate = DESC_RATE6M;
+	set_tx_desc_rts_rate(txdesc, tcb_desc->rts_rate);
+	set_tx_desc_rts_bw(txdesc, 0);
+	set_tx_desc_rts_sc(txdesc, tcb_desc->rts_sc);
+	set_tx_desc_rts_short(txdesc,
+			      ((tcb_desc->rts_rate <= DESC_RATE54M) ?
+			       (tcb_desc->rts_use_shortpreamble ? 1 : 0)
+			       : (tcb_desc->rts_use_shortgi ? 1 : 0)));
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
+	set_tx_desc_pkt_id(txdesc, 0);
+	set_tx_desc_queue_sel(txdesc, _rtl92du_hwq_to_descq(queue_index));
+	set_tx_desc_data_rate_fb_limit(txdesc, 0x1F);
+	set_tx_desc_rts_rate_fb_limit(txdesc, 0xF);
+	set_tx_desc_disable_fb(txdesc, 0);
+	set_tx_desc_use_rate(txdesc, tcb_desc->use_driver_rate ? 1 : 0);
+	if (ieee80211_is_data_qos(fc)) {
+		if (mac->rdg_en) {
+			rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+				"Enable RDG function\n");
+			set_tx_desc_rdg_enable(txdesc, 1);
+			set_tx_desc_htc(txdesc, 1);
+		}
+		set_tx_desc_qos(txdesc, 1);
+	}
+	if (rtlpriv->dm.useramask) {
+		set_tx_desc_rate_id(txdesc, tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->mac_id);
+	} else {
+		set_tx_desc_rate_id(txdesc, 0xC + tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->ratr_index);
+	}
+	if (!ieee80211_is_data_qos(fc) && ppsc->leisure_ps &&
+	    ppsc->fwctrl_lps) {
+		set_tx_desc_hwseq_en(txdesc, 1);
+		set_tx_desc_pkt_id(txdesc, 8);
+	}
+	if (ieee80211_has_morefrags(fc))
+		set_tx_desc_more_frag(txdesc, 1);
+	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
+	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
+		set_tx_desc_bmc(txdesc, 1);
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
+	int err = 0;
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
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+int rtl92du_endpoint_mapping(struct ieee80211_hw *hw)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	int error = -EINVAL;
+
+	_rtl92du_config_out_ep(hw, rtlusb->out_ep_nums);
+
+	/* Normal chip with one IN and one OUT doesn't have interrupt IN EP. */
+	if (rtlusb->out_ep_nums == 1 && rtlusb->in_ep_nums != 1)
+		goto err_out;
+
+	error = _rtl92du_out_ep_mapping(hw);
+	if (error)
+		goto err_out;
+err_out:
+	return error;
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
index 000000000000..ace83f1b420d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_TRX_H__
+#define __RTL92DE_TRX_H__
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
2.43.2

