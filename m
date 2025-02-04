Return-Path: <linux-wireless+bounces-18462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A5A27A1E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571F61630E0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A922217F50;
	Tue,  4 Feb 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsp3mc9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F96217F53
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694222; cv=none; b=TcvhBHE/fDJw7aMtmsN8sPqd9mg2+sVus1N4HvYlvyOYRoR9g3sS89C1cSAtPnRem8/ouuuzgzVVKkmq4SH46y0TpTYe0S0tXAGQJ2Fo0+VfJ+VwzXRC2jNvlUCBCsSvjrJTH8a/folNyQ+dYvs859l7VEaX23NI2hHfkZ5xK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694222; c=relaxed/simple;
	bh=zi7VfPwdiah/6OHuVN652JFehCKRXYhwDYtlU3t1vkA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kA3mKhjES8zBmZJABq2wHpbxGeShn5JL2yyJNifXv1bXZjecrxipUB1sOcX9uoDxlN6IQmJLbWlrTSVl5hefyZZk6CNW07shMuQwqS2nVzpFcTXKiO8EMiwJBNs7/u5XSfdIOL+xXLkdzzYblVm7jDKuFhdCwmeVGs2ixuC2W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsp3mc9E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab68a4ab074so720334166b.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694219; x=1739299019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfZ+8udk5apdH5a/livDU4AwIo1+sDU7dep3IDErhIY=;
        b=Vsp3mc9EStLOAqQ3IMl9J1Dt1yHW+oBd1YX7EtDOAeI9sfcViDnB9CJSQMepQui5C9
         It9Qh3MN5d9a+AY6qZrE0p568iOZBot42hDhgGDYJvL12xM53z+EzQCbfbHPixQA7k/r
         WziMmhT/kSXXib3kkYSwdAxKzKs0tdTsVmQwoQbDyNeqPdceVDDzCbtTmmqlV7BnE0Ji
         F+5JcTWY8fzvM4NWMDyFb0YPmV1YzKGva5OMJRw6mIPZRyUJPFRsS93PJp+xIv2Scsn2
         dYo8eAjcP7Mjf3FFLtv0n2ScvYQhM7axSJ0HD66ZGWkCTIHqD0sxpJMXjGBm7icqPgyN
         nxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694219; x=1739299019;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfZ+8udk5apdH5a/livDU4AwIo1+sDU7dep3IDErhIY=;
        b=IK4TOt6AAE3pCVIBON3JQSV6mbG3k6o/I/8JJ375D3Y+6UrpadA4VoWnB1M2NYfyaB
         BxzUJYgRqeGj0C+isklhGgaY9NiM1eEd9AfEVMPJsuEV3fXQXQjYRQb7xZVY1226bOmh
         74LjYBELVHyZeCrzDBVcnhRK2vXNa9+hk4Az/ObFtGy7ETRf+BNA0iM5IJumiSO08jLK
         zaijPPd824O7Wxb4SaWhvY3CkK49tBXtE1UigFcnqx202nTpdcTAGlJoksuTKLngzEse
         lFn+je/U+jYagWBPNVX2OytWeYfXcvPctB3oOh3ED+X/ZRV3xiXRwFhnqItFG53zcmDq
         o0qg==
X-Gm-Message-State: AOJu0YwQMy9gR+BXD4TOqQMcml0tRFon1mq38VrBK7NexIM2f8WqvKAC
	k/uJruWbUCUMno9HPU2NkVaixV5BteSuqyzctx8QVagFJenl6gDh0xcy7w==
X-Gm-Gg: ASbGncvmX4trOspWIxQOYX2JdGgiqUOa3hzQ+h31P3xg1aJutnYQzo2Xtntb2cYzuEK
	c1Fv1OrYKR/vQgTFusRTAq8ijyEmxVL6iU5xp0R4dvflSv/coRKzhJn7ZcgEA4/Vixvbh2PI4A9
	5im2B44kcrGnbSoGYTX53x0m/V7mEXrcYyIxJgrEQCGT8KdDRoJPmo+oBbs4+fP7d2AtknrxF8Z
	5Yp9lF1pCwDkIP1SMKd+wjpHRox1wd3IKTpDZFrs2IsU47N8fMQc3MgphQ+GjAu9DEKFcp1MQa1
	fOZd+zGuKKiHYeytqzxA77k6
X-Google-Smtp-Source: AGHT+IH+0bzYEqPHOy1U029Gg7iZzdcVdqCtPNeBY24lIY5n5XoKnSpr49SRK8SPaLUbUBWNS1qxuQ==
X-Received: by 2002:a05:6402:51ce:b0:5dc:d11d:702a with SMTP id 4fb4d7f45d1cf-5dcdb70e046mr186473a12.8.1738694218445;
        Tue, 04 Feb 2025 10:36:58 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7ea7sm952813366b.5.2025.02.04.10.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:36:58 -0800 (PST)
Message-ID: <55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com>
Date: Tue, 4 Feb 2025 20:36:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/9] wifi: rtw88: Fix __rtw_download_firmware() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Don't call ltecoex_read_reg() and ltecoex_reg_write() when the
ltecoex_addr member of struct rtw_chip_info is NULL. The RTL8814AU
doesn't have this feature.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
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


