Return-Path: <linux-wireless+bounces-24146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC7ADADE8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 13:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1047A6331
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B729C35B;
	Mon, 16 Jun 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhflbkV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C02641C3;
	Mon, 16 Jun 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071632; cv=none; b=DtLb8IOkNkcmU9IHOsjkvIRR3tpujZd08b2W/u9MZRCyzJUZ6TzNHlgR4G9/5mdQ70OU3N45/E9Rcbd3LnORCz2KBfvwwD4+3LQQj6dDck+pibcds9i3PVMqhI+9hB2Y/yfw/pA7IFh878afl47EyatpIzaq7soT1xeT983Ecwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071632; c=relaxed/simple;
	bh=6z9NzNvBj8ioUHa19DGKBiny64vYpDpgrxx9Br4X40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1D3ezryo3Z+TKzLl9F94CNRqcXcC1ZVK0RakvsQxxilkP167X6teO6m2jgb7SPx5uWXUEtnUZxNZC0t2PYWTECM5DXbgtaIhfAypwa5b9r2rItSWKbP+U3iInYjxuunSY2Bi9TMd+Fli75+yQYIIyQW9ghJ4I3h+vYIFjEQTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhflbkV1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453442d3a15so1293385e9.0;
        Mon, 16 Jun 2025 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750071629; x=1750676429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bqiSrhoIiWXRKRJpyDH6Ku/AH8RgOghRxqamwLvyLU=;
        b=mhflbkV1n88kH3b68ibPeEBd4okzurc+4MKAc1s5yR/2xBSJd3T78mgoeAyp0qmrZT
         kMQfK15rrfIHT2W6MzQzf/5r5M/Y9KHLIsvOyfQaVNM9UatrWMmVNTFegti7rmpF3+xq
         ei+0/EyEhanj1P8rogYoR2busborb08fXJXOh90CptqIcy2a/JYFBKYpeUDrBWAvl0s2
         oLCkoX34fvlmRx5ToPqaegESRKGcFeEISaUo8yl3nFQIoXOcKwmmGGUUz5n7dp62wmpN
         tgqOa2twM1YdcJD21enBga7MOIjVkG0D01Y9R5Ar5KnCe+JabnUeEu66QHBEzRJ85iJE
         sfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750071629; x=1750676429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bqiSrhoIiWXRKRJpyDH6Ku/AH8RgOghRxqamwLvyLU=;
        b=QkJ/q3+p3QfsmpwJEY/wHdfYxzkPezll/2kMhRku7xgc2wVj3fANGgHr2G9tHrQTr5
         kpYP6/EPgvmwKcp6M9PiiGtIypdaLkcu6vaC83IerhpHouSrN616jWqHj7twBDEE37cQ
         f3ElINEn8JeiUUOenU32Qrs4MQ0cDLWHt2Grqui5fErOmyjVYaeYEwICdiDCcW0eBt24
         9CJHmqHdpoDSFoA99AwiziipgufipVp0/QpZ6uvH18uWt/KWln0qL+OM7E+c/0vN/TwA
         8Odopn2C6oDk5HQolrkwUR0fvaOveNBHlygDncpVy6eMJYw0hsQ7CV0bHlcH+W2V7cun
         ppSA==
X-Forwarded-Encrypted: i=1; AJvYcCVtN6PXHfWr23YDr1THV/WUrKZ2zBUYPVCOOp8zOE0GXhSbVpuBX9GDFfpj8XNK7KPCZOO7eE8YWsovHow=@vger.kernel.org, AJvYcCWF8XR5ps2kIKe+5IBqaJ1XJDDIpbg4/E9rcwgBGPGJYQ3JyKYiB3RCEoHRyo5fP/+mQv72eb2cobWjuF/fSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbKyyEPqRzSEXVXQKwtwnj4vK+fBJuK8okHlvblwNTBkbMz+C
	LtB/3GCiSpgN31VydpukoNha+Tbti3GPivekOCO4pK+fqr4PKRFGBDQU//weScPC
X-Gm-Gg: ASbGncsbEGOhgQQBdgpIAhQ7fgVX1TiTWo/hpBcmw3+eFYf5hthHIyTWk+gFwF58srF
	l904K7ji3WMI7BFZoZ8+w4hfcF4NLfZJPCeXxwoIL2OgSnLJ5QzyRsGZ337FLOGT8Dt1JDLb27s
	FRsYp81+qMtxa7UtQ+FMYrUoNat65FFWaDZ2mHYA1C0sovr5CRb/sgHuqCO/IEHkPXCSPHrJ2Bg
	pxTYejUf0kALYFeyuQD9wwf0porM8dvJgiIAN9GfW0Y5IqkEh1Oz5FWgHuTnmmwM07Xl2fwpXOA
	bNuaW8BX5PRDDPDg/VrMuYT6b9GFvCKQ2zx7WJpKqI/u/kMrQPLDfm/K4CvIDyV9pJ6REDMTGp6
	FCNDk6FRQxRkG5hmLJo34E90v2JiPNtUDWx2toJeyz/N0E80BOrybo05dcz+dgrZc0N1+zqdmbu
	M=
X-Google-Smtp-Source: AGHT+IFP6IfBMjPk0Sy/UFfTQ8tgtMlunh5jZblveLko5YxX6LY6VgpRrVA339mdGWac2iuKaZopLg==
X-Received: by 2002:a05:600c:35cc:b0:451:df07:f41e with SMTP id 5b1f17b1804b1-4533ca4d6bfmr28881245e9.1.1750071628498;
        Mon, 16 Jun 2025 04:00:28 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec30071b84413be10a7ee.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:71b8:4413:be10:a7ee])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453421fe188sm67869595e9.5.2025.06.16.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:00:28 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
Date: Mon, 16 Jun 2025 12:56:30 +0200
Message-ID: <20250616105631.444309-4-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `_rtl_pci_init_one_rxdesc()` can fail even when the new
`skb` is passed because of a DMA mapping error.  If it fails, the `skb`
is not saved in the rx ringbuffer and thus lost.

Compile tested only

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 472072630f8d..d080469264cf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -805,13 +805,19 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 		skb = new_skb;
 no_new:
 		if (rtlpriv->use_new_trx_flow) {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 		} else {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 			if (rtlpci->rx_ring[rxring_idx].idx ==
 			    rtlpci->rxringcount - 1)
 				rtlpriv->cfg->ops->set_desc(hw, (u8 *)pdesc,
-- 
2.43.0


