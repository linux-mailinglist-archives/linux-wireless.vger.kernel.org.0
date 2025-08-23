Return-Path: <linux-wireless+bounces-26563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C0B328FE
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 16:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610E15C3C2C
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334921CA10;
	Sat, 23 Aug 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQbavFdL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF731D7E4A
	for <linux-wireless@vger.kernel.org>; Sat, 23 Aug 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957955; cv=none; b=hKA6fvmNBX8C/4FUOSWHKOf+HShzU8KKyg6KtPf2GzrAxCn0m9x8P3+3blWpSgs9GXgu5PQuhFNdVMcrZvv5UE9u/pSuvvc6MVuK1WBsYYMnnzFcWPyC0jgLAUy7MpH2ZBRGr8jMhmPPDZ4S26Of8gP9gRZDWLa1rMk7h42SWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957955; c=relaxed/simple;
	bh=WUMPC8fcE10JCTYxxBeDrtmZAukYnv1xny/Hrq6FOHs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IFd0wYWZPR6Y+OgaEYfwVKCwKSPBFOtAeGBeulPL+ZEQcCKfsLRayuUrnASyV6GLTIqaI2zE7td++SM1lRv0iiRkXCN6rup6G+AvqO0Van5g5RXbawGZW8TLedcHsjgNHnVuJd0BIVk5iXSxAAtEV4M3elWKS1DbEbbWWXCXsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQbavFdL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso3570368a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 23 Aug 2025 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755957952; x=1756562752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WUMPC8fcE10JCTYxxBeDrtmZAukYnv1xny/Hrq6FOHs=;
        b=QQbavFdL4gXVMMAbTU6TS2cv5Q6FFV54mW24j0P5Oe64vU2NOhDN3rTSeBFUEDznRh
         Ngy8dgzLgpUpbs53wlZiG1uDp13jYXt2+3TvmDmEXf5Ad6ytr+k+oKpgIttyp61RxxbN
         S6oMTUGZxQnGyZC1BT0Awd6lVLn+XeqoHYS0IqjBCH5RUNcKhZQUjTq0wUZc5dWaZQFo
         cYgAKCh73P2Fxt0ifLpZv7ALMXEw8yiuD+RWP6tBg4D5LjrYoVTFd3kXvvKPVTi2e5w6
         PhNB2M8BdIA7qrPt2iMtnNN0AeDcmnqbc2j6AQh+WsevNoXApD/PNpJEafANMT6bWodm
         pFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755957952; x=1756562752;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUMPC8fcE10JCTYxxBeDrtmZAukYnv1xny/Hrq6FOHs=;
        b=ikiC3mXiztO3l8hqr/f7YyK9HHD1lopHMXHOPSp2i7NRVC9Kol1DE01wL2G12BCo+l
         7WjWd/qaycHt7h10JIOi031FfpToH7aTqb5ThNfu4YQY6icctHfkofpIG6XVQxOUX+84
         xBtqGe1/LLOoC/Z/u01YA9zx47AjhuMtZRwDhwHvqfCUnUqPBwN57VmqW+5lfeYneQqq
         /TSVZOYuFZfbVyhhxS0vCjCP5rGNsQIloRKbJDCL0ssEhwffKV9HxcwMCmoH/bHt3h59
         AKysYHKuc6jrgypouMz/PXT0kPm2TWPeW2gs3/Hq/8mTtVE8Qu6hDVzT1qd4QDTPZ3pk
         P/5A==
X-Gm-Message-State: AOJu0Yz8OGautjssFZHV9ZzSFYbaPW0oOZOqvv7RuafzoFlI5bbYqqdo
	qxfbEQZ9zpUIBXGlcOVRG6JUPJXpjChTxGASTll8ogvcDLMaswRV/gD1nS55saf56fxAmDaEjtN
	M17aMcTBBcRInGRg2+glxGMbxc9E3nE0=
X-Gm-Gg: ASbGncuwQ7bL45F+KmI1E0Ivycmy5aELf97v5Ksf1IjGIn2N/w6dDesUOgdYiI8Rjkv
	TgmeLjicKcuatfHXSKiS5N3/zntfzMMzTW2xg+mHlsxvROc5LOUqlbqSKLavUx1FxrZ4VLmZALa
	U3aPSztVbvC3FOOJIA3OQJJ262qW8/LXstHMuES583P8BewckSig9h4NKFRh8NQ0r4ZM+Rntt8O
	rW1w7M=
X-Google-Smtp-Source: AGHT+IG+sM1YjzuWt+dAD2iioZRu/JngAJr05F1DV7lmK6YatPlAJ2bSDfKyhK5IjkJGbFWTFI9vaghccM+p2pHmJ4k=
X-Received: by 2002:a05:6402:21c1:b0:618:28c3:aee0 with SMTP id
 4fb4d7f45d1cf-61c1b45c454mr4815610a12.8.1755957952266; Sat, 23 Aug 2025
 07:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhi-Jun You <hujy652@gmail.com>
Date: Sat, 23 Aug 2025 22:05:41 +0800
X-Gm-Features: Ac12FXxEkyjkOsaHAErDwu055kU3cvPBf_YFKYBQEhdjKyTT45dT_sQ0Tfm94Yw
Message-ID: <CAHGaMk9FOEg3L5Dto87JJLRrsptQbac=trm2e4m=Xh65dxiC-A@mail.gmail.com>
Subject: Question about mt7981 precal size
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to convert my device to read EEPROM and precal through
NVMEM but encountered a problem with precal size.

Based on documentation and 19a954e, set the precal size to 54K + 16 +
102K = 159760 but I got a warning saying it failed to load precal and
the size is 200720. Added some debug line for the precal sizes I got:

mt798x-wmac 18000000.wifi: group size=96272
mt798x-wmac 18000000.wifi: dpd size=104448
mt798x-wmac 18000000.wifi: precal size=200720

mt7981 is using 2.4G + 6G cal group size but why? Then I took a look
at the vendor driver and it's using 2.4G + 5G + 6G cal group size
which looks even weirder.

So which one is the correct size? I assume the correct size should be
the same as the vendor driver but I might be wrong.

Best regards,
Zhi-Jun

