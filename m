Return-Path: <linux-wireless+bounces-18790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A8A3188E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C565016813F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232C8267714;
	Tue, 11 Feb 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtQ33NZv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0C1B4243
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312604; cv=none; b=JViHDrPG7hTudm2C+hN2Klz6qUG0Bnrn3xZFB9bP2px5LRCLZ8Tl23HG19ny/9UlYojtWdqZq8OaGThuqyLzWtYdBbB0yjPZ/IbFs/XuK5qmmeWT08Oro1QWiW/uawYle0vl5ah2tjU34ttUKIr9AwCWTaptdeSJVeGFrtO+adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312604; c=relaxed/simple;
	bh=as8PTLPQ7jJaqIVxtzWeWF6+J/91+LkZOUmtLPdNjuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X0NluUtr94IhIPKElNvUfUm9Fh+BMQ5PAD3yON2GUsqWdTPJ5Zi8hPLPnvGLZgY3oanVOvOVY5Vmbn3Fi9QhwtFcnO7BDMXUCL6pznDSrKo6Mnc/ZrfN+L5Wt/PXJis+T8W8Z2Fk8uRhc/oP+KD+fQuzFb/dSmaPQ5Q8cToyk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtQ33NZv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so9781584a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312601; x=1739917401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9YgchMAmn9tt0Nglo8OmxPNVzUyvTpxHyVJrjH8I3dk=;
        b=jtQ33NZvax4e858E7+Ov7gNXYPoRiNdl6lHKGP6NKrWcAkDNzuNECpZzW6jeJV/vjq
         ZApez3WWOctvGpo+2J2Cw2ONUJ1Jt8zPSBVV/y+DJnIPOguFSW36X7QFgezwX/5BlgIY
         /6JO3mFJBB66t5V5PVafVEreqANvh9dtgDNrNTXsdXsOeUp4gyjHsACweZ+qEpPI79Tm
         YR6GD3aObuI+mFN3slVWz0OoWhdXEFcuptqR6TYnZDdrAi98zk/x2WmAedM9upUf5zww
         KkIAD6qKjsRx2mGwoZdXZzaZHJfUKNCiu9MwaPvOdQglDmghVxjaM1jOBJPuKYEV8oIh
         3DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312601; x=1739917401;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YgchMAmn9tt0Nglo8OmxPNVzUyvTpxHyVJrjH8I3dk=;
        b=V6Mro5yQhLo+WA2hzBU34J8CUm9W0/OvHb1LZftiNDok3j3XcfhVsiwet9BKrgAxGx
         a2o1fV0semC+IEFaU0+k2aq1bY/qikvTyAI5cGg0ds/ZzuXs+kiR6RNLKyvFjn/ZZ0QB
         oB7HxX/CQjkvQjRLiVUN3Ga/80IOLvVyJ/xm8Ao4dXW2RHkdo/09qxPk5/a+QX7SCX/w
         7vRu1cX9M0wujN42duilz4gmCwc7ej6CFs0rTgZYGUaOKS9MnlYnjEWxrRKftXE71vS3
         Ia9ldSgEXNYpb28bDvPqpgnVjCJJtrv+sRZuXGuIEtauVqTPC2tRnokw3pKVt9Dm0tZ4
         xgBQ==
X-Gm-Message-State: AOJu0Yxx9aMchmdMAJp7YRtu5dvNX1gP1YMg5DpW9q6HdzZOCS5/cUZq
	//3RYLNb89+dEEleiGAVM+eDEwQABM1/qyshIL+x118J0miOWzd1w4YPfQ==
X-Gm-Gg: ASbGncsZ1Nsgpl7BWXqdE9r/g2eySLaqtem65dgXMgwIDivoQyrDdZBAe/51USZj6HP
	j4oZS+xuRe0u0FlThAmyNqLt/SIajveiwcRdUwHlzP+C4/s2QXpwYNzMPzOk5zBwuJpOngFui8v
	IeBGM+r21wym9VoJZoVxiskwNB8GWeCE+Rs5gF5/K5spabreZ4ITHxa2D0tXcQjxFwyq3P4K7Vw
	eMmYpwQRqjhy7kItbdeBlqchyhUA5nFiwhXUkJWg5qKYY36UykFTHkvnmsltRdMJyxOeVfixUFH
	DpMCV1xca4HDThr+bQ7MHikf
X-Google-Smtp-Source: AGHT+IEtBVR++LokhpnjB4eTm0iwtmi4sLHu42iUt8D6ufvXVI18hP1ivlns7EG/5/5OWk3waPPxNg==
X-Received: by 2002:a05:6402:35cb:b0:5dc:58c8:3154 with SMTP id 4fb4d7f45d1cf-5deadde67f8mr1915672a12.28.1739312600498;
        Tue, 11 Feb 2025 14:23:20 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7dca728fcsm223495666b.166.2025.02.11.14.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:23:20 -0800 (PST)
Message-ID: <afb71646-e164-4635-861d-e2f5b4e16aa3@gmail.com>
Date: Wed, 12 Feb 2025 00:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/8] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the RX mask and the highest RX rate according to the number of
spatial streams the chip can receive. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e4f9b744f24d..3319bb5044c3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1565,6 +1565,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1584,17 +1585,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (efuse->hw_cap.nss > 1) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(300);
-	} else {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(150);
-	}
+
+	for (i = 0; i < efuse->hw_cap.nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
-- 
2.48.1


