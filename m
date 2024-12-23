Return-Path: <linux-wireless+bounces-16733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4619FB076
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DFE1882626
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733B21AB6D8;
	Mon, 23 Dec 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8IwmvSD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B114287
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734966124; cv=none; b=heTx9E2vbaDvWqICQfv0evf4Xe7zvI2i/xlLMaXxt8ROSREfEvzwaLQADByHwOEpG1WkdkWcERPRGboOyhhoZJsAi+DaUwk8J3WhFZQI9foGsYe7YE4p+/yE2rz17cBJLIErscR0ebx1Hjj/QnnX8WuII96njyQzLtlPNbBPR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734966124; c=relaxed/simple;
	bh=5o+dgMZ+xIgZjPEqIlqEebpdkE7foAkE+SukklpdU8k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mMPwz7Jup0UjlUVFt/ftM4DszZDGNvxML53Zj56lUqp2f6gpWLJ6CKw++jU/xu5uarlzt9Ivf/cwXyF6n1CwBqXjdoYfFU+JSyYnntQhPV85+3JDCqC1EtXky47ahCjzicqjrmiryevd8AVDpvrkqw9p/wD+nz0fKdqIKLvLz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8IwmvSD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso95456866b.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 07:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734966121; x=1735570921; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R6wjeG2XEa6ElBWIK/lDlXFOawkRZyij1If6/QC2oI=;
        b=D8IwmvSDlfIezK8i363C8j5Y6vwnTtQOk0HBvKvGjiZ+/UIXkwVtj3V/qOPnBvWBFW
         tgSMp3UkTclu/nCAjwkC44CaMUI3ak6fb3UexAhyHzG4UG0GROyJuZyg+ODt3ljkVkDN
         +Zrr03qI5AIQYO0D87eblnf0pY61Bxyzdw79TcnaoAuNxCpGGwOcVvkicRSLt172JEZz
         qc2+AwXEg8CnNyvDJ5Ls+pxoUytdgxV4X3U0w7KR6EEUedPwvBQnITUVrkBLB0KkL2/2
         edEFQJRMguCvYfmlt1ECg2n9DSM6lvcCqUApuymxkjACcynUx5VjQCxjbLJD/Ruzbymd
         k5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734966121; x=1735570921;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6R6wjeG2XEa6ElBWIK/lDlXFOawkRZyij1If6/QC2oI=;
        b=S3DwiH7h8X2dqNY5CUKzEfA1xVjVsPNQfX8v7y//FWOgGYPILuWX/fgqFLMx6Rmtzl
         4U92hchcz8Zi7pwA8InS2YZBEcx6n8KgmOt/UoTOrrpbIGXIsNxXC+2FVLLV4yXWIlZK
         H//8ds3Jp7d3XpDAzRa/7VYacthbkAvMDXWIxAMu+7o5/nvMfqpYlfiwAdkhs0UXPee5
         nAM1GW0/g7aX6oAZ0D1sZhrh+MOGyXQQ5i7iMKLaEoPJ3wewsfGvwPoGGGFoZ6ho/J6d
         aYlLDwuShyP22RPpQvvj14ZO0qo2U3Aey7qXbHGLaeCzXzDbNnsSko7o/QXl/JVb9uEo
         RaIQ==
X-Gm-Message-State: AOJu0Yx0iOPzp3SgT6ATQltHfWxM8VEK5XJrjTH5kgryBTErzeV68UXU
	X6mS6Xy8hPK/dSqm946jdja4gkCwzOjQ6uUXbtpMFFvBZzhiC4vtOElpUg==
X-Gm-Gg: ASbGnctt3rLE09f0HWOipkKEn3FITG//Saa4H+22EUSs2VngCSmbBB6SSTziRdBgNqf
	80olEMHEt0/hc117qoghUE1ZsSUexsyRV2n50VlRsZq4vA5CspuHtz3CfUfICC++YSiInX6x8cz
	ImOPsBsRX6RGQKPvE4wjzcz0s9Dp1Q+WtG9GPQeiO4GDdQ5A2glOR+93FpFqM43Y0aguRc5I97N
	6h49iokTP/eheHNFn6u0n5I4LzkqwGpXz7NJNzncTAc+W/gld8kTg18oBPGG2fD
X-Google-Smtp-Source: AGHT+IHLIbiJ5akkYauEsRub6B6px931aZ+73yBn2J5MO2juSC+RoXh/9OH2IObvH1A92BvsJkaTiw==
X-Received: by 2002:a17:907:2d8b:b0:aa6:6e41:ea53 with SMTP id a640c23a62f3a-aac271316a3mr1380100566b.7.1734966119964;
        Mon, 23 Dec 2024 07:01:59 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06e0c3sm523740266b.199.2024.12.23.07.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 07:01:59 -0800 (PST)
Message-ID: <cba8e2f2-32c4-4174-90ba-0219f29dbdde@gmail.com>
Date: Mon, 23 Dec 2024 17:01:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A user reports that the firmware upload consistently fails when it's
uploaded in chunks of 128 bytes, but it works when uploaded in chunks
of 196 bytes. The official driver uses 196 bytes also.

Link: https://github.com/a5a5aa555oo/rtl8xxxu/issues/2
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make the patch apply.
---
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
index 3d04df0f5bf4..766a7a7c7d28 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1860,7 +1860,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.set_crystal_cap = rtl8188f_set_crystal_cap,
 	.cck_rssi = rtl8188e_cck_rssi,
 	.led_classdev_brightness_set = rtl8188eu_led_brightness_set,
-	.writeN_block_size = 128,
+	.writeN_block_size = 196,
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.has_tx_report = 1,
-- 
2.47.1


