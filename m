Return-Path: <linux-wireless+bounces-4808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D287DF50
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B87E1F20F49
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088F1CD3D;
	Sun, 17 Mar 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDSnnbJf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BF1CD2A
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701111; cv=none; b=bpqsTFXQwcSYzYnfQaBqbQ6tuXkFlf3Iqrq53CPWUyfeU8fMRmzxZBQbalwtUfwRLyxq4xRisvUJN3xXZ+v+rIvbu3DxmRchqtG1G6jDK7QdDtA04ipzP0DDbHF2q6plv3LCGslA9eHlcTDZ3x47DZVFcsVnKZ3pOfwkPnM+FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701111; c=relaxed/simple;
	bh=e7M8PvtvkdbxkfCP6P7IhSX2jIVHHGYQojR7PoEO9XE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f2wOVqQlGHxhGluYq1LoFswv+ROWdAl61wIrzRZZxZ92SKcYEsXzZAObdem3nT31h0lH2i3px6T93qKB7ug8hLYDcmN50j6+yEJ14vEy4iPTu4gs4BqeZuAlKo+WML5weIwKTAweaWmYyTC+gviukpBrd5cL0XN08NNAMT6XgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDSnnbJf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-568c6c391d8so943650a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701108; x=1711305908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwVjchAckvI2UTY/NAsSU5EgxykCmqlGnTIDYq6lQQU=;
        b=BDSnnbJfPZcx3GVvGOcNng+ZL5hlazU6wSP2OG917BBfJrVdcBj2ij5vw1qxp2O70i
         bktgJfHTDB1ixMmP2+EULMTU2ByXplJYx7SXzuuSipAozapKxYUgcwMJYUBagkIeiqnM
         9UKs/RFqJqJBpfYxmv6RiqAcq3+Lr4FbdoOCLJOQ3te8dQtod5HTGQGL2bzqGt6CuRR9
         GRkNCGBZc9nMMfFa9Lv/i8wtWWcrcteRVKfvW9hv+Sgn8V+gWz+q7slt7wB7G4h0CtPO
         eCbvbv2fDc8y7kGSBSnkN4nSnzEovLQp8dbyiOLDlw/T1r+mRXkR4DdbfQip+Zn2Yr9G
         igfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701108; x=1711305908;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwVjchAckvI2UTY/NAsSU5EgxykCmqlGnTIDYq6lQQU=;
        b=vvjSaHyyjhPxoTtwy1IR9PiSg6VnH2mDk+idk/vXqPetMyFe5eEetux3XrSFBYvIsY
         +QMmmOO1dL+EPUvhrgfqUQTT2szm23u3f2Ft7N3/XVvDYzo6zEe32WhRuLKog52gTNZI
         LwalPNZdH1HJklRcOXF7su6TUHuZKSaIpZBVMEyVXZIV7qtVY+9HPGh2R+1bB6a2VtjW
         dUjudJgp9mQ8sM0e3XteY031dAm6COq+seOtw1Zt9/rUaZdmXqE3nhVRVYj3dfz2PvAE
         BLf7rtc1wtJ1A3F9dQrjBZ3PSFWpxyA7nNi5KrOxqNeTnxsjTW5r042kaH0U7+Cfh77X
         Nf9w==
X-Gm-Message-State: AOJu0YzIwh1AMMarSQ50J1WG1Ms3ayU9QDwA4rDdUA4R4pVxNJqq0pMu
	VJlwwfncwbvf5S3FFDvVNXwEJvpVd+pYf8Op+tHy2vX0ztPxbMuT7HQOGbNo
X-Google-Smtp-Source: AGHT+IF58iP8jD2hK4H03L14tAgmQJruENlsMc4tGlgJcW4Kbk3JCRcDv0o+fJ1BS95O9RspGW0oVQ==
X-Received: by 2002:a05:6402:22da:b0:565:dfac:a686 with SMTP id dm26-20020a05640222da00b00565dfaca686mr5804655edb.38.1710701108033;
        Sun, 17 Mar 2024 11:45:08 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b00568cee4a83dsm1017622edr.80.2024.03.17.11.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:45:07 -0700 (PDT)
Message-ID: <5e0b7433-6f4d-4e0e-8550-c28914419f6c@gmail.com>
Date: Sun, 17 Mar 2024 20:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 01/12] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
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

Different channels have different TX power settings. rtl8192de is using
the TX power setting from the wrong channel in the 5 GHz band because
_rtl92c_phy_get_rightchnlplace expects an array which includes 2.4 GHz
and 5 GHz channel numbers, but it's using an array which includes only
the 5 GHz channel numbers.

Use the array channel_all (defined in rtl8192de/phy.c) instead of
the incorrect channel5g (defined in core.c).

Tested only with rtl8192du, which will use the same TX power code.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
No change from v1, which was originally sent separately:
https://lore.kernel.org/linux-wireless/9995b805-ef8b-47c9-b176-ff540066039a@gmail.com/
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d835a27429f0..56b5cd032a9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
-- 
2.43.2

