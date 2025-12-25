Return-Path: <linux-wireless+bounces-30108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D0CDDB96
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Dec 2025 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E35783015E01
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Dec 2025 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830531B822;
	Thu, 25 Dec 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYrSDPsI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393B186E2E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766663704; cv=none; b=q/6TMGpo5SfWrBp1q9RygJol4hbZHx5d8TTu6/9/wXut4//sittBNHNi/ijeyWIDlGlSOzDrrSbExmLQyemSOVhCF0eGXofIeVUoCKE5RT01RnisGDAZBuak4RreAC2V9IIgS+pyY8fLpcmatoUNBAyZaNxCMko/2HVyiVhu4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766663704; c=relaxed/simple;
	bh=26jbtWO1gui1Tg4M2KXsYQt7Cc6dhgtAwRsKPEv+q0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utaAjstOBKc+JABSWg8P2OFmgTDc2RddTo/Xa0JFhR9jvupKvZ2C4+Kc5JZa4AFcrviyQnSz+z6rwiPoiJx45u/zKORu/Bu7/UR57mvvWE6zKEWBusGqB8PDltMY8/hwrBizl91SvKMzrn+OCy74KcXsppFGiFCfJhxOviqpQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYrSDPsI; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso3912085f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766663700; x=1767268500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1F0wCtq3gcx/BwLH3t1r9Kcjr/HuK/9IXAdL1YRX6k=;
        b=UYrSDPsIOk2yH5GzSgPjaP0uWSExvmdA0BWj2gh4Ec06KVeGFvIwymW4GGRFKswncl
         9/EbpMhn98fDPigNYKW8FDZYRuy2EIOpYYdtmhZFFvGgRRF1hyesMdfMquwlcslrNSZ4
         Qan+knk8xzIeeXcXGtFzMcY4tmWjbc33spgn4h5ydzGrSgC+dwSgVMutqZitOlraSlio
         7Faoi3XLXT+wPShtr2V84KGwE9RQglBAoJOWYkE4RIa8YzKj5+B4BH4x6tJ5IIj1ojk7
         gl7vrx0jY5CnGJlyFypczi47dVdHioXWGFuTOdqmbvJy369mVRwOwMOyb1U+Jr9NUfHk
         MydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766663700; x=1767268500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1F0wCtq3gcx/BwLH3t1r9Kcjr/HuK/9IXAdL1YRX6k=;
        b=mFFO5fjbdj1jeVjv38/r//Pme1ANSjj1FkRj+T9N2J2qHMyGhcW9QmVwEiQuJPjWPJ
         ueShJUMOgcHELEoojcxeF1TMiEyrEC10wmASrLnr0wl0GJiC6xUxarDsBZe0v1rPqJo+
         N0/3/S22RDlyicQ6EFQy6PyWClYMxuYrEfA615d3OtpmtE0CqcoeOnNUOKa0zm8+cbwD
         jGURvBAH8m2ipTsCMNV/lbIsSG4faxMXahjmIPAMCAIRYnxaDg4e+BsO51qhO8Bk3+Gr
         092/vI5ntnBiDg+0sQdhMWOWq0Px8AMo81yQxllwzFQJX2cl+5cJVkHhWU4sAE51fpya
         OH2Q==
X-Gm-Message-State: AOJu0Yw+8GGmarEF3YrMjLYpJ33SCbYb5GtrcRc5iD7HIUFi8NS4vb+5
	bHqerwM9V2/15AwXxkAcvZ2z2MFZ/LG4SLedJsMuJpf0mDGEc7BkKHll
X-Gm-Gg: AY/fxX6/Fr93Zk2j6ApKWT8Ah/rE0OrT2c2E9PuRtUh6K3mRWad9k9VeHIw9f87vpuf
	UcpHPr+kxgrJEm4hl7Mzvu/YM9fzqNVDksSAtQveHmwaaLVo2uGEAQ4PNvdwuMLVL5glxfEq/3F
	NKk+sJSdma8ZVCvzRJEjUfx8PIai4eZzT0/OP3Ivl8ASnnoPSXv11gVtWAvC3bU1B/JTYT7vGEm
	maWkdR+l/ISAPMwJst6IlKG1Me8RPudH7Z3I9HHa+SLpFHF+TLu8iiW5SusuMuLxLw/ODEZxLMV
	epiJjza/1eZhd5lqik7fIPMCQ5RHLSLwJJ7fa10PHsdzWQSD0kVD3Vb0FwlSHbhE+o6U+0kEgwD
	dIzXZYE3rPpKB9dq+fmitAoSs465AmDTrIuLTO+IFFtw5tA+hvwvxqhLCQDA/rETeckS9ibg=
X-Google-Smtp-Source: AGHT+IHugqS8KlGEruk1RYHem/ONDjxOPQtNAOoiwifvCDUQycnoRBKbn+/i8CRTpf+IcmvGYK5Qyg==
X-Received: by 2002:a5d:588c:0:b0:42b:2a09:2e55 with SMTP id ffacd0b85a97d-4324e45d3famr19833686f8f.0.1766663699468;
        Thu, 25 Dec 2025 03:54:59 -0800 (PST)
Received: from ubuntu.. ([2400:adc5:19e:d700::3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa0908sm39022593f8f.31.2025.12.25.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 03:54:59 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH] rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add
Date: Thu, 25 Dec 2025 11:54:29 +0000
Message-ID: <20251225115430.13011-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not set hw->sta_data_size, which causes mac80211 to
allocate insufficient space for driver private station data in
__sta_info_alloc(). When rtl8xxxu_sta_add() accesses members of
struct rtl8xxxu_sta_info through sta->drv_priv, this results in a
slab-out-of-bounds write.

KASAN report on RISC-V (VisionFive 2) with RTL8192EU adapter:

  BUG: KASAN: slab-out-of-bounds in rtl8xxxu_sta_add+0x31c/0x346
  Write of size 8 at addr ffffffd6d3e9ae88 by task kworker/u16:0/12

Set hw->sta_data_size to sizeof(struct rtl8xxxu_sta_info) during
probe, similar to how hw->vif_data_size is configured. This ensures
mac80211 allocates sufficient space for the driver's per-station
private data.

Tested on StarFive VisionFive 2 v1.2A board.

Fixes: eef55f1545c9 ("wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()")

Cc: stable@vger.kernel.org

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index c06ad064f37c..f9a527f6a175 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7826,6 +7826,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 
 	hw->vif_data_size = sizeof(struct rtl8xxxu_vif);
+	hw->sta_data_size = sizeof(struct rtl8xxxu_sta_info);
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-- 
2.43.0


