Return-Path: <linux-wireless+bounces-1394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C1582220B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AEAB2266B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED491640B;
	Tue,  2 Jan 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIMz+fNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFA1640D
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccec119587so38551481fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jan 2024 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704223991; x=1704828791; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB8sT5wgcgVMIrbYDePIvUmnwGjgDoDJ3qyqAdGeARs=;
        b=nIMz+fNYdSu706najX2i64c1H1GxU5HiqUfNxyI6i7rZWG0sZbE9Y5R+f6O8qntJNW
         g6FgtI9U0zY0+GcbTsM+eQUUsy61L8aWLsoLhJg8yh0mG7PIrr+HxGVYJwYLhJ3IOm81
         yodLiG02yY98FYgFhJqQ4n5+dcon5ZL+nzAyICHud7P6AvCWHTYRVb8d1BmUeZ/73Guo
         aSTKwyNYy0g4JPwcBAKgxaVH7Bq8ZkrkPE8u/MhjDk/Or/MQp1jBcYZ6bBynd1oRCnfx
         JH2W6EaU3ZLI1Go5u0bzcC0+7DbiKmO12VTGl2MUFaEwoB7vRQPnD/t6e9egAeGiH3NN
         W+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223991; x=1704828791;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EB8sT5wgcgVMIrbYDePIvUmnwGjgDoDJ3qyqAdGeARs=;
        b=PdrMfI+udTX6DxHD59edscLCrjZbAg9WrPh3mRmone1i6AB/rC/dt+qKus6xFERBRp
         ZSV0ehNiA0djWuvkTo18IYGmi9+RjMYSBfEJhKtoav4Z2oNuVFke1n6MIjPA0ovYnIM9
         Iw99GiOcyuA45vS7AZYCEK4DPt/d63ExZWk/T7atLmc/Ipn4tgtPgzyPzsctAViZNFY2
         lHdOICcny9kY65bVITDAXHsRNDtwe2WBuTJK7g9uJUZbQdHpsAB3B7JacombNzdApeVH
         nSPuolKsK/sNdh/FlAAdmsASnfSh6ge1FQroNPBKFDAkJrCYhN9q/Zy5noZHEWv00SF6
         FFWw==
X-Gm-Message-State: AOJu0Yz+pRgBjb1kowamLcZjJmeFT9pCE2YPoR/RPcBinZAQOvIfQnN2
	2Hf1yYiQGmkxliIe3bnEdCitdst1iFM=
X-Google-Smtp-Source: AGHT+IHNYWmLk+IpJqjrQQEv17OGyS9n8QPjXkg5z5iS0UqPMS8z0mFAk1iUIgewstHMNfxW7st5Dg==
X-Received: by 2002:a2e:9049:0:b0:2cc:7849:f4b with SMTP id n9-20020a2e9049000000b002cc78490f4bmr8323802ljg.97.1704223990491;
        Tue, 02 Jan 2024 11:33:10 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id h8-20020a2ebc88000000b002cd0465f297sm1050735ljf.95.2024.01.02.11.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 11:33:10 -0800 (PST)
Message-ID: <761e6836-6cd6-4930-91b6-0446834655c5@gmail.com>
Date: Tue, 2 Jan 2024 21:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Fix off by one initial RTS rate
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl8xxxu_set_basic_rates() sets the wrong initial RTS rate. It sets the
next higher rate than the one it should set, e.g. 36M instead of 24M.

The while loop was supposed to find the index of the most significant
bit which is 1, but it was copied incorrectly from the vendor driver.
Use __fls() instead.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use __fls().
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 180907319e8c..2b1b633a1f96 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4839,10 +4839,9 @@ static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 
 	dev_dbg(&priv->udev->dev, "%s: rates %08x\n", __func__,	rate_cfg);
 
-	while (rate_cfg) {
-		rate_cfg = (rate_cfg >> 1);
-		rate_idx++;
-	}
+	if (rate_cfg)
+		rate_idx = __fls(rate_cfg);
+
 	rtl8xxxu_write8(priv, REG_INIRTS_RATE_SEL, rate_idx);
 }
 
-- 
2.43.0

