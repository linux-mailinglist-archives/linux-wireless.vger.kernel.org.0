Return-Path: <linux-wireless+bounces-17983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076FA1CF0E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D84166673
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 22:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6C481A3;
	Sun, 26 Jan 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVwyh/1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D15672
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932165; cv=none; b=OLqISEiHWQPpZ4hTGCgZpk7ziljY2WyOdCx4UojVkJqDCdae9cqUbn3fS25cdPWEn8Jh+R7O/KzNCUy/S2fi8tcDsFjDVzXxN2zS7qrvZbOhEg+bo8q0o5nusZD/QnxpkgaDk4MR9TU2it346m+7spAqZtOptmDfVLzEiIFkqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932165; c=relaxed/simple;
	bh=/W8JoqKt2VzVOsheaDiKXp47kL/MT+Ix5zC4Xl6IAMs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gLrFHekwjCzEGYleKVJ3b2nAv6H77tP+0dT36f8+kpZl/I/zr/16XznF70VRNdeOQUIUPOwCrq5kWfkIZPaBqtK2ZM+eRKrDZlcUXbFrd/0Z1UBrgTq/h7x810/h3WgY87uMBZkWiEVtiUjOZZt+12ov+4PtDmypD2OGIIOTWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVwyh/1K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362f61757fso40635725e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932162; x=1738536962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqYPQ74fEu1XMQIFRIu9bz+u5J2Uf7E8HdDyJjb8mU0=;
        b=KVwyh/1Krx4AufJC3hILG8yYWZ+oZJP64e5BYXctuigrMH57RUYpauYG0/At3sfGtW
         F7rkoaDlhx+V0ANaNOVjEhhOMMPQTHQJHlBTQ6roeiMu2NfnUorqg0qr0Egd0xGt8+QO
         BwMs+lBqLllGTdoN0TgYA5/5C96B3VWqViHv+Zy8fxdBdrThAu8PLN+sULQqd5DW1Bni
         50SuRDhYfWckJBwDFeBNIxkqg7s/cfWzt6gMXE6pFz35UG1jI0Au2sgWiu3KcK4TyzYo
         PSC7G+7Tp/EE/2Wo+zNGLXB1P0Ksbg1ZMFWRDPP66UKlVVLR+zSxW2VX3V1N14A8DQwr
         INJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932162; x=1738536962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqYPQ74fEu1XMQIFRIu9bz+u5J2Uf7E8HdDyJjb8mU0=;
        b=kLW1SNzjvYeMfxDrsWve44GnUR45onENKDEvECtCeVIH1aevg2gsmuaoOqi6M+tB6z
         WVTqUp0J4A+H1KJhbQIKKnAv5D2FetuJzX1UjyBB7abR8Im8/M4/Ws0pH2fpdoGutsrY
         VzWqGJJlBPuHFqRzBrF511Z36YPk/R73E7SWCR5odRHOsEGcQVvfZ1XI/xv5nPRLr62Q
         UfTPS50p0u5NqBbTBvkV5pQld8tHlZQ14w77GSMS0WxXMw0+MaPTqUJU2HoaVEQcxfbU
         R/jS7wDKOlrsqrmUxVAZkVQ8pU2QFks1VjP5wPx60JTk3EdJdfMhYoBJ37PrKfM3DqZw
         X+ow==
X-Gm-Message-State: AOJu0YzFR8dXdLxU4/aQM6G6lN1VUH+gJVkQjx1glzoCyYOrgd4sa9Mw
	VE/BORGZ9uoEJgt+E46GWJlVUm+sSHTQjMtHQwsN0HbNdTWVC3JqOlTCKA==
X-Gm-Gg: ASbGncus8mF+esBGFO0Pa5km/TOBTBklVhCqHd/O+YF1F5bxuh/2gFcw5Qknd1SSCf5
	w4P2PX6cXG3T8dV2p+72ZHOuECu7jmmEyFQBI7HPNfPtR3732HWDeUi4zfIs4qGSq7mYjV9Y4iY
	CqhWScRa+1kTnNNKgju4XVh4NoTqx3AY6eRxlpizZIVivRgT42S3rmTgQ2MDkANaeJalZbatPkK
	6U6GpZUesZ6J/7Zk8yk2hIKp5FC70alwBD/UICREB3jj1Tkt3T87MLxho3xKXTKHEo7ycNEd0U+
	7zU3ttDRQkup
X-Google-Smtp-Source: AGHT+IFCY5Es+Y1T/E92V8KmWHy7dueHXSfnAXc9grSv8UbEdSDaBLoluJJdfN/GKiPa3xszGNcX3Q==
X-Received: by 2002:a05:600c:a01:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-438913db8b0mr341772165e9.12.1737932161716;
        Sun, 26 Jan 2025 14:56:01 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd575468sm107463045e9.39.2025.01.26.14.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:56:00 -0800 (PST)
Message-ID: <241f642c-b31f-4b52-be65-515269769a2b@gmail.com>
Date: Mon, 27 Jan 2025 00:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/7] wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These members of struct rtw_chip_info each have a size of 2. Increase
their size to 4, which is the number of RF paths the RTL8814AU has.

This is required to read and write the RF registers of the RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e40e62302984..ba64d269521a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1239,8 +1239,8 @@ struct rtw_chip_info {
 
 	const struct rtw_hw_reg *dig;
 	const struct rtw_hw_reg *dig_cck;
-	u32 rf_base_addr[2];
-	u32 rf_sipi_addr[2];
+	u32 rf_base_addr[RTW_RF_PATH_MAX];
+	u32 rf_sipi_addr[RTW_RF_PATH_MAX];
 	const struct rtw_rf_sipi_addr *rf_sipi_read_addr;
 	u8 fix_rf_phy_num;
 	const struct rtw_ltecoex_addr *ltecoex_addr;
-- 
2.48.1


