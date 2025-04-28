Return-Path: <linux-wireless+bounces-22156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EACA9FC2E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 23:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEEE7A571D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB211632DF;
	Mon, 28 Apr 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIWKn0Bb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F81FDA8C
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745875604; cv=none; b=HKy/bjYP9/aI6qIcPV0323Ztr6itRX/OspqvaHaJzMPHVF8c6UQo+IM1/fgVXG2ZvVZKGdZj0zW3SQkaN4wp1gAMAes6cdYhwVCxaDz8QV3TBMenz+KRUg+92qlJFtlf8G0TnKxSyU8hJOL0WcQIh72nM9/aFGO7kKemBjGLTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745875604; c=relaxed/simple;
	bh=I3kBGBZqJJicmhbV7fvwOEx/8gEshHMwA8jz+sflJ8o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QgeCuY5Nxi73+vZIlji5bPCZJTAUWLqtsYcg/JxHmzFa1t6Icef82Jgs9lRiyCbNBGqvpX52r+zVKHcS9/3gpGhLaufAupGply8/gPBMJ/ASVovEC3LerUXsLO18vwr2rWHjQdp+HfWfOBgF2JTKBr8H1dmakzJxImVSLQrrjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIWKn0Bb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so915805666b.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745875600; x=1746480400; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVSw/djU49LtNdI0gDZINaHxpkYgQuox+NC4SmApPAM=;
        b=dIWKn0BbgzMml2ucrTP5LBmiFzwEnl+ya0wHBokx0HkmHjNNfazWVKMJZxGbyt/aU2
         zT3w+CjpbxwTYIjzkqXS0nrzUE03fBRVy/wTOGgrdUHAEOtAVkSM5M49FaGKuHO/6EFW
         6SitSqtCpryiTEXc5lxDECXrLuDg9XdnYAUBaCFMXJcQk6HRvOKX2Gz4Gb9vtZjVAXVn
         uIZnQGuX74hrtnCTYwthPsB/2YSxE6lmyXjRZkH2TyitQiRHDhHs+rLLGHtmV9hn97h6
         YxPSRZTPEV4VNkJDwtIUFWbJ0TnknkSDrbJXuOUOxw4kQBM2whmWn1cK/5p7ED560Ktp
         j+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745875600; x=1746480400;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xVSw/djU49LtNdI0gDZINaHxpkYgQuox+NC4SmApPAM=;
        b=JWvkCXpj06tt1w+7A1Iib0TnoUEUC9r4GWIkQZY2HFWeodQNZ7IXCVK4oEGaBCagIZ
         xNASuXqNzSqj3oNcSAWKuBMZrl1FRprQBGH9SxCRVb+fhj8yDO7UsHletWl6tUgblud2
         tBivUglvxkLM9SGwPhbBTJqTn61iPnsNF24WZD+r80LUt7M/txWZxuMRCcXEU/7W8bBj
         ppkvwbB2ntu05t5R9Xy1dT0RDaQ3Relpk9h1Lvo0R3POsxf79JKbIAlxzWdJ+PK2cSgW
         pU3uM5CI9J4z9Br5cJigtbFT4yoh39uDDKqJ/2CERYqc6tYg4q1JSFmI7dU+ghKEWHK9
         a7uA==
X-Gm-Message-State: AOJu0YzBCu4Wst4m/gTznyBlg79fv90X3DwwtPcfsepVD3mTwT9CRlao
	6nfKA2M4DRxyVDbyVjs4CEEJntORJYi4u829nt07lg7OI3iFc2RhNHz8SQ==
X-Gm-Gg: ASbGncsh7R9JQPXz8DWxzE0qDDFOTWmuXY5LPSq3OmnnJqKp/xx+n3WG1ZHJbp/TFsr
	n7gPPNNAQrjVKAsmWtyMBwl0vHduMXJwG3fQZlogwkAvPBkXFfq6S1TkpGvUC2QnxQBP+JDNgdH
	LU7P250eLu1g2BGIoomox/egkHu7aPD0ewVqJqfqqtn37wPRBZGRa+oRqPjurqKI8g1WzClzPlG
	bs+2CqCBlRHu8/tErHOvjAF2PLjaALddzeFRj8SriXXrqLG3GHShhIbO1iC/g/nM2LjGky/ZYCh
	8QB8z3Agnyda3yMtZu4VKUFVEGAMECTvyn1vIqjAdvKtDwkjsQ==
X-Google-Smtp-Source: AGHT+IF2zkUD/Ie66j1KwpWO9Eu+YX3mzF38UgTTKEqJ0ope/iaw4MMeHCMUQFJaM+6rCXhotoSpTw==
X-Received: by 2002:a17:907:7e84:b0:aca:d83b:611b with SMTP id a640c23a62f3a-ace84aad97bmr1044036466b.43.1745875599439;
        Mon, 28 Apr 2025 14:26:39 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec5d0d74esm33099166b.117.2025.04.28.14.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 14:26:39 -0700 (PDT)
Message-ID: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
Date: Tue, 29 Apr 2025 00:26:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw88: Fix RX aggregation settings for
 RTL8723DS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use the same RX aggregation size and timeout used by the out-of-tree
RTL8723DS driver. Also set mystery bit 31 of REG_RXDMA_AGG_PG_TH. This
improves the RX speed from ~44 Mbps to ~67 Mbps.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index c57f683d9af8..6f63fd5db665 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -677,12 +677,20 @@ static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
 {
 	u8 size, timeout;
 
-	if (rtw_chip_wcpu_11n(rtwdev)) {
+	switch (rtwdev->chip->id) {
+	case RTW_CHIP_TYPE_8703B:
 		size = 0x6;
 		timeout = 0x6;
-	} else {
+		break;
+	case RTW_CHIP_TYPE_8723D:
+		size = 0xa;
+		timeout = 0x3;
+		rtw_write8_set(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
+		break;
+	default:
 		size = 0xff;
 		timeout = 0x1;
+		break;
 	}
 
 	/* Make the firmware honor the size limit configured below */
-- 
2.49.0


