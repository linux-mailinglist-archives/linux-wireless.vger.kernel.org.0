Return-Path: <linux-wireless+bounces-6350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC948A5CB5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 23:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9281C212AA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67882D93;
	Mon, 15 Apr 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKN91KOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9771DFEB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215416; cv=none; b=eYDV7VoASLLvVg4tM66RMeFbKEXu59DYyLeexQzD7oNe3us08svSZ7GgJNuFiZ6x4Iwj89iwKE1xAyrhpeFDx/L2qhjqxBRQo+n+JEtaTS+d9VKpAqxH9Ox8a3XYLwmp2pSetE6StseQwMNyhXtFXDFeMGQuKhhhSxuD/0x9WrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215416; c=relaxed/simple;
	bh=5sfISh2h+9JxsUcfOBiqNMe43FrwJsGtK678hd5t8ZY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GnGgFsBz3/oOA46LagNRgKtucZ7bksk3FLjqzwxbxHfag/O9wFf7qqbMjLsx+lTm/axw449ITOnLtxmcwUlib9OGYu+Tu9df3kAkmfkWcfv8nyxtcLJigqcJoDHJ3R39acsBXzmjvZnOdWPw/B75RiwBKYKNMUWcb3qhlyRXi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKN91KOi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41881bce4b5so5789515e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215413; x=1713820213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeQkXfIliUoQhaGX2i26s0aNXxrZ7g3zMHTNv0vz9fs=;
        b=CKN91KOid1dYdJFN/cNUxHaBGRkKclzf6bjytg/puG8c27aqOuCgpy2RCCMX3WXhFW
         G13sbWJo5hkKb1tZJL1Zl5X+i2WYODP7U/czQnKnsYBC8t4kV4pAniBKB5S3TigKkNxs
         8Q1Ww+nEd83fMQ67TL/0LsokvUevx0I0MRs+31qYD6/F2ZwfQbxZOlegRUaII2cBege/
         hqcknB//TNB4xmFSH63BigSod+m99VVhu248aNx+o5rGZUccee2sp9FyCE+AQ/NhtSM0
         djxdTTplF2heDdQGGQ2Ep/H0F3d95RMU9cbvGTxoKPMT8OwJ9aqIUGOr8g+9lHSKg2Ne
         FLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215413; x=1713820213;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yeQkXfIliUoQhaGX2i26s0aNXxrZ7g3zMHTNv0vz9fs=;
        b=TZgoLljga+An3hqvfSaXHuMyBDv9q0m0vJo+ArLQXmp9VTpuax4TLrnTbTya5tL4mt
         LkTRF/s6itLXnt2fqbrnwz+iR4gCPCZESsETTVZ7AcHgpYF4aWudwJ+4Xp91jN3m7dkO
         Dnu85FVXP/DkPQ7ZpzcIY1WsphlGT55OLBGvh1jhSoJtpfigiSkPxzCMWHYMKOvrCZz+
         uXuNu779h2Gw81PGCrONVT/+h6Tk484cmTSsKOQfEuV/ghB6V5qHCg3QVBuPWmMb+OVo
         2CshpdBQXLN50o2Ncnnd52UVVTyvQDbh0hsq9yVMyqfHV7qvaCN40/VTVzEa4LhoTotY
         2Daw==
X-Gm-Message-State: AOJu0Yz7Ed/tVZmPBASsfJ/KUDBeTq0as9pQUvpV+0Cs9gNMW/IWCtjS
	orgY997YFtAB4sG9WIbU26D5gJ1Hv9TKORpj/Ofepu8aS3H+vtJWIBWzqR1d
X-Google-Smtp-Source: AGHT+IFRkQhdYV6qhR/9R+op8RK/KjtJ/jNfDPerOQ+dCQiRKaujtOvczRfX6Z2Yyb2C+BEGL3+0EA==
X-Received: by 2002:a05:600c:19cc:b0:416:4973:4d87 with SMTP id u12-20020a05600c19cc00b0041649734d87mr10273469wmq.3.1713215412866;
        Mon, 15 Apr 2024 14:10:12 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b0041825f17a71sm10657866wmg.30.2024.04.15.14.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:10:12 -0700 (PDT)
Message-ID: <3068a7f8-0178-4ea7-bd18-4e377db07e76@gmail.com>
Date: Tue, 16 Apr 2024 00:10:11 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Fix gen1 rate mask command
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The H2C (host to card) command which tells the firmware which TX rates
it can use is slightly wrong. Fix the order of the bytes.

Also put the macid in the command (relevant for AP mode).

This was tested with RTL8192CU. It also affects the RTL8723AU.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   | 10 +++++++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 +++++++++++-------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index fd92d23c43d9..ca44d82cb5aa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1430,10 +1430,14 @@ struct h2c_cmd {
 			u8 data;
 		} __packed joinbss;
 		struct {
+#define RAID_MASK		GENMASK(31, 28)
+#define RATE_MASK_MASK		GENMASK(27, 0)
+#define MACID_MASK		GENMASK(4, 0)
+#define SHORT_GI_MASK		BIT(5)
+
 			u8 cmd;
-			__le16 mask_hi;
-			u8 arg;
-			__le16 mask_lo;
+			__le32 rate_mask_and_raid;
+			u8 macid_and_short_gi;
 		} __packed ramask;
 		struct {
 			u8 cmd;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fac7824ae727..acbafc25c6e0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4641,15 +4641,19 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 	memset(&h2c, 0, sizeof(struct h2c_cmd));
 
 	h2c.ramask.cmd = H2C_SET_RATE_MASK;
-	h2c.ramask.mask_lo = cpu_to_le16(ramask & 0xffff);
-	h2c.ramask.mask_hi = cpu_to_le16(ramask >> 16);
 
-	h2c.ramask.arg = 0x80;
-	if (sgi)
-		h2c.ramask.arg |= 0x20;
+	le32p_replace_bits(&h2c.ramask.rate_mask_and_raid, rateid, RAID_MASK);
+	le32p_replace_bits(&h2c.ramask.rate_mask_and_raid, ramask, RATE_MASK_MASK);
+
+	u8p_replace_bits(&h2c.ramask.macid_and_short_gi, macid, MACID_MASK);
+	u8p_replace_bits(&h2c.ramask.macid_and_short_gi, sgi, SHORT_GI_MASK);
+	u8p_replace_bits(&h2c.ramask.macid_and_short_gi, 1, BIT(7));
+
+	dev_dbg(&priv->udev->dev,
+		"%s: rate mask %08x, rate id %02x, arg %02x, size %zi\n",
+		__func__, ramask, rateid, h2c.ramask.macid_and_short_gi,
+		sizeof(h2c.ramask));
 
-	dev_dbg(&priv->udev->dev, "%s: rate mask %08x, arg %02x, size %zi\n",
-		__func__, ramask, h2c.ramask.arg, sizeof(h2c.ramask));
 	rtl8xxxu_gen1_h2c_cmd(priv, &h2c, sizeof(h2c.ramask));
 }
 
-- 
2.44.0


