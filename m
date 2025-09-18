Return-Path: <linux-wireless+bounces-27464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9214B83268
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB107A69EB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674581F3BA9;
	Thu, 18 Sep 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlu4+r53"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D71E51E0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177272; cv=none; b=HpHI9nEdWcEEUE4P7k6hpV11ncWh2OPm/v+Hf9MWcgaL+OevUN29pCacldzhZmtbocpu5ScKZtoUB5WW1sHQG4FY5X0ySJeShzvqGNL9oWO8xCZreLZn8NDKCODiKhXL+yQM1BBkqhMJG8n3fwM61lhj2WXKLuNa2CtGU4HCAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177272; c=relaxed/simple;
	bh=BCopRdkAlLZUwepfWLHtixLX3yDFPpQqCze/Cb93lwo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l/8FHSyBozQ5z09a+XrneCDBjhZOP+tBiAqrs3aMQ6tw6zW3vU6Ytlc5ErwfmhmIlt584UmQuW74kALHt4UL4OSXhOly4o/hyMZL8Ti4LYMrVFzeNxFYNCQ2FDaHqOsLJFgHCvDsy5MFO8Lk0Twas+jPX0ZgMW36IuqihG+ehI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zlu4+r53; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b223ec0d5caso16651166b.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758177267; x=1758782067; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/ySUXJSHe8lpQVFSN8o7h8cD/xMra4YZMnsAza4vk8=;
        b=Zlu4+r53z29VnLv90SE7MXi1wfnQMaN8TsAer8VuMcLHX+9WfK4vklpc1fu+KWHxkI
         gJxHCAu9A3lVVqyTlQ8vkSm6PNlCbet3UETCHwlTfdM68AEe2SbECNqVgAS1VwK6ABLd
         IXXwULo339vIeth7a3aTJxyeFlxAmTWUGklwNdeRLeaZ5yZdnO29E6u27XXOh5/Cva2h
         ASDJDS2ofC4aOb9+aby/78XKfQnsCdon9bDRkkGrl4dIvgMz0TPRxo8RI8oQ6DJ8cRWQ
         ALS0nu9ivFj6iJTKA4UL5k1gahjzft6AcsWk+4OFUP1RAFpmuJTNwz1dnPK8UGs5h5ZW
         Dhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177267; x=1758782067;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/ySUXJSHe8lpQVFSN8o7h8cD/xMra4YZMnsAza4vk8=;
        b=Qi0sV3jUVy4UjsUz48iL5PMAt0I6trrNP7wJD9PWAXNMwp5JADPhxUWjtYRuSSa5Ju
         YPaS4FoVjd4g6VvMwwei89D8YkRWYfZhe9SS67P4sfUai7sFLp/ZCI8gWz5f/EqK6uTp
         0MhYaabC9oJyLpOYNFcaRfoIIl/MNpRl0XZ0SrN5FhRP9oxhZgZkqIV5PmRzV7Z4uov5
         MD3nGf2ns9I/HfkpxRz9LtiYdy4dQDl85fya8972hr/K3d6gheNrxwmWirCEWEU/ZwrB
         Me8C+Qnou1gJqv4hXA1j2AZ5DZ6FHKbHdg6jdkpP8vL+ndcGYyMjhtTby5hSPkYjmqmy
         fcGg==
X-Gm-Message-State: AOJu0Yyc+yDZEMfoEsJOwiCrDjXmk2VVZCX5hi6FNG0ar25hvknPXWWb
	o93N0e1J3sj1QwokFUf7iHSn98V45it1jhCEXDNkvBMYZierkyCXo16lK1J8wxJkixEo1VSuNel
	IZc090iboQcGHFAdKmr63fM2yVZs0Sjb/ggxCS6Q=
X-Gm-Gg: ASbGncvIz/ZAMTai207mr8NAkawlftU59iOxdcSWsnKTEUUEaOuk8UsX6gQxOOMpSes
	wOIP3c73fsmU2yfXDQhPJ/sUeZ8d1kxO/hDKzrefsX2SX/FHMN2lAL9tOU9SQpaawU6jTf1E2an
	8oLDLYDrvE+D20/dvX0vNOkQn2rtz2lDiL+7LRYLbAz96Zz/+zq2EgLTtyEen2UVx/DHIcXXVNL
	r/07fM5n2r6r8UcrYr15l2YTjiuBuYV2nxF
X-Google-Smtp-Source: AGHT+IET22ufB/xb6tHH1YtrYMLovt2prENQrB7ShitB4k6AXjdd81YqSOU4EtZP0cF75cKFjrwp5rfOzQiLL76X1IE=
X-Received: by 2002:a17:907:6d02:b0:afe:be04:5ce2 with SMTP id
 a640c23a62f3a-b1bc2779eadmr491602266b.64.1758177267512; Wed, 17 Sep 2025
 23:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: amit kumar <amit60700@gmail.com>
Date: Thu, 18 Sep 2025 12:04:15 +0530
X-Gm-Features: AS18NWAiMvUScp727Etf8J9TCBq_xjGbuL1DEk_60qWYVcJLvPZhyE2aRakmFCs
Message-ID: <CAJNKUtcMh9+i2AiXGxKDqa41QRrkfHbU1rR-HJEKx9aJj2tJSg@mail.gmail.com>
Subject: Inquiry: WPA3-FT Roaming Support in iwd ver3.9
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear iwd maintainers and community,

I=E2=80=99m currently working with iwd version 3.9 and have been evaluating
Fast Transition (FT) behavior across different security
configurations.

In my testing:

1>WPA2-FT works flawlessly =E2=80=94 the device connects and roams as expec=
ted.
2>WPA3-SAE also connects without issue.
3>However, when the AP is configured with WPA3-FT only (AKM suite
00-0F-AC:9), iwd fails to connect, logging:
3.a>iwd[440]: autoconnect: No suitable BSSes found

Upon reviewing the source code, I noticed that the AKM suite for FT
over SAE (IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) is not included in the
logic that identifies WPA3-Personal networks. After adding the
following patch to ie.c, iwd successfully connects to the WPA3-FT AP:

----

diff --git a/src/ie.c b/src/ie.c
--- a/src/ie.c
+++ b/src/ie.c
@@ -1338,7 +1338,8 @@ bool ie_rsne_is_wpa3_personal(const struct
ie_rsn_info *info)
         * 3. an AP should enable AKM suite selector: 00-0F-AC:6
         * 5. an AP shall set MFPC to 1, MFPR to 0
         */
-       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256))
+       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
+           !(info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
                return false;

        if (!info->mfpc)

----

My query:
Does iwd officially support WPA3-FT roaming? If not, is there a
specific reason this AKM suite is excluded =E2=80=94 such as spec maturity,
roaming logic limitations, or security concerns?

I=E2=80=99d appreciate any insights into the roadmap or design consideratio=
ns
around WPA3-FT support. Happy to share logs or test results if
helpful.

Best regards,
[Amit Kumar]

