Return-Path: <linux-wireless+bounces-16513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A709F5B51
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 01:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736001890D30
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0694A3C;
	Wed, 18 Dec 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbiDtzT0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199919A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481209; cv=none; b=s3/kVcLpe70FqBmNRTJ+ix01kug23iL7yGtnXFZIIvswAgCXvTEoHDgYBQl7Y3YGtVp6cmJWrqgLSV57rLHoEpSoroGsEes1OkVPAKltBCzNQFwsbc6aaNlBiFcsELP8d/hXUCsgjtC+3DfAb98nqbusVmyamUABD7FPhpUvIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481209; c=relaxed/simple;
	bh=8gc9+WHU2Y1SfNw9dO5271YzclmjEkxNQXUqgMA899s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mj7a4WJg759uXJqeX5NJVN5srvypdzbYM27VcikYNiVQJXRVWCr8RFozQJi2SzlhgBL4XSOPTRlUfSKvgpwIxiERbHEosc2INSqEXEUPeWo8x+ABYrd584mM1z3ag4pa4CsHAlI2NPswFaFFkWB6sdnxjXtKpYscDhYxAoBHU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbiDtzT0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso1521628a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734481206; x=1735086006; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ukAjYGHDuLM4MLhPaTALrtH2utG6lvlFgjSZjHegg8=;
        b=VbiDtzT0TbA97UXh/XYrl6rvFYRlLFXPd+Hs/Rtm/bWW5oUfKfltQuLLp0d6z+mNQy
         97X+RwEw2tDgzENQwhvZa52Juz9e18o65GoglhChu7WV1+9XXHWEZx83MAiJCcNeX8P3
         4BieuVC/2NoGi7PvQTnsPs1MZKXgEu10/mFfjr+GzRPMbHr1I3pNNuU/SvjBeMEMelB/
         h7KlOOPI5x89b8NcizUkEdQt7DIj0gF/o0rUvBkVnXTSF7UvcYU7yH6LbPjy/c8vvmJo
         HIzFoMmJ4GShu6MvAK+zEQLDs++2GslBPdxOLKmE8r/vhbMW7bDGu/X2CYtdcCyz12a9
         B6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481206; x=1735086006;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ukAjYGHDuLM4MLhPaTALrtH2utG6lvlFgjSZjHegg8=;
        b=fpiwqL5hunlvK9DLic9J2jy7TKwpLfKNan84rhgRDEq05PquDoi4EAdFaC7GKqJeO1
         5YC4r4dJqMakUCPQOaJwKnD9cDuOnnyQClqnsJXiBai8Th9sdwXTYwcgcGepFwG6bbKB
         lHmfj2+vN1q9h6Kw/waJ9aTLKG9mPpERzQVPku65NQLpMhYMw8PKOGJrmIp9x7UTbeNQ
         gvNaV12DWZ8B7QQKTMntUfoZ3xVvOsGFYB37zd7E/8ZTDTeFs9f6LTFZFlJh4zRYPcUn
         yAM2YIZ0noIcHZlEREvKG3bVgd39VQMOgAE32RDLZKmn++Lr3iNGnE2Cn3ASm5rHJD9N
         SWKQ==
X-Gm-Message-State: AOJu0Yx6d+/xFZq2Fad9tJsznco//FWeg5wTHREz4O8CwS0KQOeD0+Cm
	hlhTtZurI1tGMu5rRBDESgOqztDRZ9CPl9ZgIHkCZXOyzbmdTXHykG2Rjg==
X-Gm-Gg: ASbGncv2wTc8rMykv2Yn7ogSZyHnWFJs0SNpzbU9yEQPN+IXwYI4fbHL8HcilZoR0d7
	R45OjzsgNSELd49KeNbGYcaXkjBnQMowpk+yFCraRJo3ikmtwVKl1FUI7Aen8FXGRQfHu0SJnKK
	J1ZEgWbIfsrGP886KJI6nLAvxhfsyqdu9Q/tq2eDMoU6m27d/f+ESvYF5ZsdVy/tDZDrZydD2Nl
	c0N+9MMe5ij0AByVi3ghvHdiEWEov4OgU7LiD1BSWb01E10Oag3782dGULRC2sk
X-Google-Smtp-Source: AGHT+IFYJZqRqLbnJw7MYYoZNnvP7w1GxgLu+cDEZXmbB1snI3X+YnRoy5yJmP2A6R/jdGoYJDFkVQ==
X-Received: by 2002:a05:6402:5203:b0:5d0:ee52:353e with SMTP id 4fb4d7f45d1cf-5d7ee4242d0mr833645a12.29.1734481206363;
        Tue, 17 Dec 2024 16:20:06 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.78])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab50absm4761310a12.7.2024.12.17.16.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 16:20:05 -0800 (PST)
Message-ID: <146b1077-768a-44f9-86b3-a36814edf92a@gmail.com>
Date: Wed, 18 Dec 2024 02:20:03 +0200
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
Subject: [PATCH] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A user reports that the firmware upload consistently fails when it's
uploaded in chunks of 128 bytes, but it works when uploaded in chunks
of 196 bytes. The official driver uses 196 bytes also.

Link: https://github.com/a5a5aa555oo/rtl8xxxu/issues/2
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
index e6df10d7f028..43bb5ea0041e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1827,7 +1827,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.cck_rssi = rtl8188e_cck_rssi,
 	.led_classdev_brightness_set = rtl8188eu_led_brightness_set,
 	.set_ampdu_factor = rtl8xxxu_set_ampdu_factor_v1,
-	.writeN_block_size = 128,
+	.writeN_block_size = 196,
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.has_tx_report = 1,
-- 
2.47.1


