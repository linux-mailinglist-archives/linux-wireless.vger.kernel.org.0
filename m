Return-Path: <linux-wireless+bounces-26091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8665B18845
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481951C25878
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F051F9F70;
	Fri,  1 Aug 2025 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ043Iqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB815539A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080879; cv=none; b=RQKfJc7OdajOx7J9V2ggaZGOOO2ytSqSsSl8RXzNZE9ujScu1wQiZVGgiKRDFDTridffggx32CkLW3WKTXFe2/fJx/skR3vh3DiUEswnNkrVEXT+/GmCtjrnnuDxXXHzh1xxJECehXL5FREW+Wdb+1xjJBxxoaUdodAJizlVksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080879; c=relaxed/simple;
	bh=1ywMnvO3BVj3uOgYGR3tp5oO/dTbgDIZnofq8Mgk9NY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bYzLfSxuHkM86itgLFoZwu+FUb34yuT/O62HBKYv6BN44ev/7jN3yh7MHeOGAo/tfNKpVEMR0cr0Uuo4Z8RpQxvh0jP0e9T2HKg1Nm9yO+/wBAcsdhl2ECv4xkmxgIne02gJJAwvhtjLtIEHilyWpwWfl/OsJ2qhBICHpiu7JEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ043Iqp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af937728c3eso156466766b.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080876; x=1754685676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFTcVQfjMO2SYexnAeF7p+ALiX5LQw1aRtv/U67mwBc=;
        b=VQ043IqpJCTG4DwA8c1mT1syQIhWyua/YtIiNOJl0u5n1QiUTdrH/fVHAZ8C8X86eQ
         OxkKZR6cdH5UKJqkx2nMrJSuMDDWzyjEewptErmGF4wPqaK5xDzarZjesB+N1goUNUzZ
         tTlzHehXthjOtA/P66tKmtHAPgubr7+2fTAhlW9or55g/qnoMR3VWx7Iw0dVyeZY8NKV
         tWgVC9JJBVrLH/2d3EwyZkN3vagAEKRBU4IneMpzjM1amv5Vb3KwJoa0J7c2Gp9+bMiK
         3hyioJZu3g+bNC0SbFa0a9YR5CFATiwmOmZMh/CAuptQggGA3KnQce7PsBqJOSTJ8xCT
         FU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080876; x=1754685676;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFTcVQfjMO2SYexnAeF7p+ALiX5LQw1aRtv/U67mwBc=;
        b=h+rE71sGPXxCvLQJri6liU+PAqpvTOHAlbEPnNXt7xmxXWhShigI+XaDTptEdV81rc
         grU7O2IwSwl+JIZlgUV2cOxcbLZaHNOyj01NoTaH3TgR+J9sZiHYwEpas3JWTJ5LHs2t
         0Gp30oP+RpwR5FY+6OIb8vYA89XsFGdDPwtwCdwIveAcHJHAECvNgjksE77IJDPej44C
         YvrCLv9CHc3LUegmzaF4jDXhNPscKGcGtONwxKVlJiCJmE2PvjYMXLkNt2nYfffNtD8H
         gNleAG+Ny0zQSWs69lLUB04ltGp+eDRmTnM5ngcmNy+SZEaEk3I3c8+ZI3nVyLdi2Mpl
         9Uhw==
X-Gm-Message-State: AOJu0YxGTtsCdpaKdxSfukPQbumN3Kkv0Kr59zKo/qgQvJ6zqaweYhMT
	+KdCTijKbSo3ZbBYkc1nJUc3c1wR0iwXpadcP7hsi2noSdVcr0+sP9PlC/MtSw==
X-Gm-Gg: ASbGnctr0yDS48hrbNhEsQz9bAlCMiRtTUalA8QJmMVMlSYmJ+UmxpifCdiJao3xvpx
	9V2dx6dCK67oqhGFBPZoesHOkm0sr788pSTHzvqv6TdyZuAyZdkmwjIeKYRodOqpA6MXI8uGcB9
	CP+8BRcd9mp4hk6T/3L2hU6e5vbq6EhAUjhJ6OOx1FVd4xGeP4nrr3qYeWIfDV58qbnV8PMIIvk
	lLLithY7RaBL5T3FmrSCjAdJ7y3vIC90feOLzKKhYIYxUcYUYqVp0TfgssS+50XdzP2s2JWQ0O9
	zjDL7ql9UKYBxF3lEXC/42Rqi+W27/knZqN3N4l/QQ1eB4vGkXNXWd1RG3oHaU2dyoY915RpkuJ
	KtnrB59GCv/4St9l4mNBnmgYjDecRjw==
X-Google-Smtp-Source: AGHT+IGIzWuyfUSLkOa4aQzHTPPPt/R9TXpaCXtCIr6tdvqHJvKJReS3Q923NqST3h2S8KfvdbEPTg==
X-Received: by 2002:a17:907:cd0d:b0:ae8:8d00:76c3 with SMTP id a640c23a62f3a-af940930757mr95164166b.29.1754080875635;
        Fri, 01 Aug 2025 13:41:15 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm330052366b.90.2025.08.01.13.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:41:15 -0700 (PDT)
Message-ID: <6f70e669-e635-4d91-8151-ffeda6ee7c3a@gmail.com>
Date: Fri, 1 Aug 2025 23:41:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 09/11] wifi: rtw89: 8852c: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8852c_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Also fix the offset of the MAC address because it was wrong.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 16 +++++++---------
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 4a1405ba3567..2e5fa87ba9a1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -480,14 +480,6 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8852c_e_efuse_parsing(struct rtw89_efuse *efuse,
-				     struct rtw8852c_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8852c_efuse *map)
 {
@@ -596,12 +588,18 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8852c_e_efuse_parsing(efuse, map);
+		ether_addr_copy(efuse->addr, map->e.mac_addr);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		ether_addr_copy(efuse->addr, map->u.mac_addr);
 		break;
 	default:
 		return -ENOTSUPP;
 	}
 
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+
 	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 77b05daedd10..8585921ac6c4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -11,7 +11,7 @@
 #define BB_PATH_NUM_8852C 2
 
 struct rtw8852c_u_efuse {
-	u8 rsvd[0x38];
+	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
 };
 
-- 
2.50.0


