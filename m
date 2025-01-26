Return-Path: <linux-wireless+bounces-17980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4691A1CF0B
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A092D1886819
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3342056;
	Sun, 26 Jan 2025 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwPay0LR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FC5672
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932034; cv=none; b=ZV/MOD87STlM+2uvVjbvjXwcYmzGIuJjwbFvQjFRIjaQqGY4sKAE+Gl0DZEDX7v/rFfi0zstPSrcqZ/qa0KJcBqYuTXqEgKk1m3Z207a/llWISLkIEglKcfWMxXd23McjVPGY2WXmRbHT0t4olbjS8we9h/7zKRyRhf1fJPppFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932034; c=relaxed/simple;
	bh=w7IO+dyvb58ZJfz4Cpas3+qJgjZbamZZiIpdmVHIlC4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=darIbkwht3eCAuYl3w1SaUXftCbAV+Tw9oQHjLyWuq3onYvDXkBHOaRh/L4g7oWqfDjfDtSU2smCUR+EeQbk8gguDVEgQAPfE1RUJ9Jsxfaay36iTvi7P3zzdAN7+zBL610oGlyWiZs7tPQ2I+2rsq7RpfqekuThb7UpVGnrYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwPay0LR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a88ba968aso3791379f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932031; x=1738536831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+Fr7qGeN+LeEeP+tt4dHzvjJ7Lgpc40XLCNl8pt5Ak=;
        b=TwPay0LRPlH9IorMJi6w9CbWOF6rVdXaejOnaRaOD+sz3W6PbMMmM7hngTYP0HYxIX
         4/ZLy1xux9o6FzghKnjtCme4nvpr1MTw6mv8C0pj8Y2snfl753joj8XN+8GkkHU+5txs
         ooa3LEtVK5H0cNOIsa8PLMTE87bRuA7d8YbRZgnrm86pVWyvCbS8ZoK+sgsJaMdsAvZ0
         vsGN37W7fjTfNLjNjZ2gW/IlAmVFM9HoKtUYcuVbM0n1KkkPu8pgYCsUpJNWQEvbumdN
         lc48bdiDC0SxQjfsS7P3POQA+FKDTvHXfvM8PIBDtXN7DkKwQfALgMnI9ft6Onl3KfgG
         WHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932031; x=1738536831;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Fr7qGeN+LeEeP+tt4dHzvjJ7Lgpc40XLCNl8pt5Ak=;
        b=fknXFHoXPSTcDz8nvQgiMtZPdMrcusUUVfaIr3jIdRIhK3jpO1MymclQjK+CYWlslo
         BKdRQR/GD7ao0Yyz0VMYinB9pYZCOZXGYQRvvxjpMfyTCsTluTM9RowN2Mq2wMa2mzaZ
         nbfqS3biBDv3nKDgZmhJbmdgb0JiutLTgp0Oua5m7ANG33xSvmdATbUVbjrQl+zNdERN
         9iVIZOAWmLb7ZVFl71WBEq1vUMHEjcjNsd5jL63784zbPNx/QtW6iEQTJhuWbv5W8aC4
         /XD+gMkDuKh0DN4SsygnXmHeK/5a/e6ysvloIP+EtNM+T5PUZaxRCt3AYJCSkbzis7ap
         2FXQ==
X-Gm-Message-State: AOJu0YwqD/y5p5sgfsik9RXh9Ckhlc+2NloeRQWDYuDWJJaT64cxPPWh
	C+gv54DR/IE9IipuCinkGvbQkl12E6Pq2llkK0jSKNE5hyu5pt0mJDwZ9w==
X-Gm-Gg: ASbGnctLZgLf5PRDlWFSrh2En+9x8HJUWXF+ldxGRjubO0au1UDzmHsuxIf6I7EyQOz
	DSswbaQFtYzLecrNor+7f/p8Iwkt8MTEdrvVUMYn3BB2grIKjnirp+2lw4tyvMD+koLvngTZiPA
	pkz3DFGBtd+5f6whaqUmLW1xsCs97S7LgsYiyU9FngeyZ8fDN/Q8HKU3mU9oPZa/llDuEvlm+Yj
	BjNAAK1XmSiMZFGvbZ2UIvX2iLP87qdxF/IpPmArKIpZCXC2SjQF0kvwmaXhd68xmwxil9d/vBp
	t+aZb2eoPzHKrMTi+v0sFc0=
X-Google-Smtp-Source: AGHT+IGbtvEBSX932LBcdMI2sf7xe78Wos7ifcmA7HaIIUgIQS9bq2e1txUCBb+KtnLS2Zrr6S5LWg==
X-Received: by 2002:a5d:64c3:0:b0:38c:3fab:3def with SMTP id ffacd0b85a97d-38c3fab419cmr2293415f8f.10.1737932029237;
        Sun, 26 Jan 2025 14:53:49 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bad92sm9245590f8f.61.2025.01.26.14.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:53:48 -0800 (PST)
Message-ID: <0e9b08ef-4719-4d37-8b5c-2d1a780499d7@gmail.com>
Date: Mon, 27 Jan 2025 00:53:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/7] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Don't call ltecoex_read_reg() and ltecoex_reg_write() when the
ltecoex_addr member of struct rtw_chip_info is NULL. The RTL8814AU
doesn't have this feature.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index cae9cca6dca3..63edf6461de8 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -784,7 +784,8 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
 	if (!check_firmware_size(data, size))
 		return -EINVAL;
 
-	if (!ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
+	if (rtwdev->chip->ltecoex_addr &&
+	    !ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
 		return -EBUSY;
 
 	wlan_cpu_enable(rtwdev, false);
@@ -802,7 +803,8 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
 
 	wlan_cpu_enable(rtwdev, true);
 
-	if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
+	if (rtwdev->chip->ltecoex_addr &&
+	    !ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
 		ret = -EBUSY;
 		goto dlfw_fail;
 	}
-- 
2.48.1


