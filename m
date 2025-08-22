Return-Path: <linux-wireless+bounces-26559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D9B31443
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 11:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B56B7AEC56
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F52EE608;
	Fri, 22 Aug 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5ud3sh0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C62882CA
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855998; cv=none; b=j0l4iedSRWCyJgz2ojGJnXCGJp+OCthJBClCxS2nNzNavFJnxFuVakwalGSjv2OSi1oJbaCSoZ8BJy0THP/AHhXLFuvAkBFSb3rjfQUw7JCEJuyYWoJ5JjlgnePzBM3/2TlFVhN+3vbwp43M4QG/jvxLNvbqgLewDMFAtLZrL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855998; c=relaxed/simple;
	bh=9nZ1dfmu8OqljtQuyItgouikVaIU+A0T3hqGAizlse0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WZxLF3fXeuw1zLfQrGAhtZBb2OCTbFalxeNfURnX5iJH/hdu2hh8/Hd3+f0ECupmTlE7BqNtOl2OWQV3QTTzGWCHPM2oaliTWz7hTGiZEuRpb7kszLJgo7fqKy0mCO7XD83WcZfVajJzSm/F2ROCdTIH7CHPfzkfqhkWydot3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5ud3sh0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6059fb47so15658237b3.3
        for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755855995; x=1756460795; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ptTcae9P3h/a0ej2AadQcW1KzQN8gBNuyAZ2cnowOM=;
        b=l5ud3sh0CVqR5dY+g8p8GmZhX9CBGMG6ktADdzFcSbChZrQEcvJ80Glm+TvQWBZKWZ
         zRDqSwOEk4kSQyByVqOpkGxLH3CnM0KDad8o5XpPGyG1ynqE0PKqJ21zSaiBepT/7t02
         bC20eXjAWGSv37YIT13ceFhjP4nFTW0Rx9aT9+RQ3ew8YACSPNV8IvBY+2uWpcEe5/+S
         I955+7WA2E6AFgbjFOXnGSOXXM05QmlzPL8A19r5GHflgMlY8VdQk0DkXNJCZCuiwHsR
         g44kUIJrC53IplmQyIE+PNv0CL2pIw25V7RiX0zfSNiyOVFzicVJfrLPI8sDqOOXn8A9
         coiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855995; x=1756460795;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ptTcae9P3h/a0ej2AadQcW1KzQN8gBNuyAZ2cnowOM=;
        b=YtyZaQzRB9zepD0a5UEMOZNaYAlFmuzPgI7ZZmY/KgOamwLazNZuZx7lZvk0P4kpmo
         vRGE27mUXhGWVyO5/eigZo+ii/HbvfaDBX18qmxGoPcyD9HgcdY3s9HkGXXpSWTTMBmr
         3BGaKF4Tdfkb6lKukmBZGRHd/4MClC2GVzvlJtFOG5k+xWZ4g7W1zusCPKjph52+MIhu
         6qM976ndRjtc8W7+8H2afZpYNt6jI8mdnml30Q+VH9GSiovLDqxVHcplK4Qk0Pzbr5Ph
         U5kkeOEG9ouEIph/C2OTfq7ZXG1VkYTld2efCvotCtEYPCDs5GCqT48ZWitLewl4n984
         YtSg==
X-Gm-Message-State: AOJu0YwN6Lq3jg+bLZulExkdK+G0eKB7yK/+qVc0ZHx+bZg1f5kjsjh4
	Ejm6YrIRnXTafWCnpxP1MdGzuwvbWETZGvvhmIec3YzCcdbD3l9Yc6+mc5WPU3/p3Fgp4W4qYXv
	ZVoM/b3usxbeOC/IRYrEYNVZvED92hbs5x32t
X-Gm-Gg: ASbGnctqlPjn/ktoUNp8v9qRGLBrVJ4EWmt85BjPsnTF9tqeAB/ulj6QcoVTqfEG/MV
	ojhngmSPzxtC6ebV/VonZpxgrdEJwSLrntXKc66D0AP/l0xPhrbYH4fodKwCPxMFteFqS9Bvh6Y
	7wxirSHf6dfhtIFld81oRZqr4FPoH6IdpKuz/hThRELH3z271950JT/ZtM52pJiPiEB05UdJXs4
	xy+LE4d
X-Google-Smtp-Source: AGHT+IFgiELg1gu6vxlymrRmde9m/9IOvjLyX1wmR5F3JNa6SZDsvsY/4qjYfxvE9lB6h/sEbkAf/T7BYjywoT15+C0=
X-Received: by 2002:a05:690c:708f:b0:71f:b0b6:c32 with SMTP id
 00721157ae682-71fdc31b308mr23610357b3.23.1755855995603; Fri, 22 Aug 2025
 02:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LI=?= <debugger94@gmail.com>
Date: Fri, 22 Aug 2025 12:46:24 +0300
X-Gm-Features: Ac12FXyCCbwQxeiRHmry5D6jekG2gMZ0AVY1MPLElJEbvvAOpHCyh4aMbGHU5EE
Message-ID: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
Subject: Remove TL-WN722N V2 from untested devices
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have been using this Wi-Fi dongle for many years now and have had no
problems with it. The device is quite old and known, dumping its efuse to
the log and asking the user to send the results to Jes.Sorensen@gmail.com
on every boot makes little sense. Please apply:

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 831b5025c634..113e01df0902 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7815,7 +7815,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
                        untested = 0;
                break;
        case 0x2357:
-               if (id->idProduct == 0x0109 || id->idProduct == 0x0135)
+               if (id->idProduct == 0x0109 || id->idProduct == 0x010c
|| id->idProduct == 0x0135)
                        untested = 0;
                break;
        case 0x0b05:

