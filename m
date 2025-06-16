Return-Path: <linux-wireless+bounces-24126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BCADA969
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990B71889EE2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DA1EDA2B;
	Mon, 16 Jun 2025 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbSKvSNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA31DF756
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058776; cv=none; b=rAaFKFEJcnlbjmf4oMi/1ADQV6bwfM0B2x472b/HojZX9diwqmvAKz4Y2zQszSNZE3Q+QkzP5tUUFWCkVQpSbTsR50xyI9l8XGIXVrp93DqPSok8a7oiJS/KuA4tS88l7CKb9BnnSuzkuPgg9V5xQNcQXsZBdzlSbOgFK/AsnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058776; c=relaxed/simple;
	bh=mJYitqaIgu00nPVFj7JM9/H2NYxDQSw81n3Uo6DjgQY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Meq5HSuwdjTBebHgBQS275LJ7hoD8OW1/D1AQgbgLN/Onq0l6EnHKUv8qivyowaRFQ8XYh2cZn9Glpmm47Cr6QYpXYB4chMV+D4X7rV1EXM1kPEEqfnpzV2mK+6Yo/RXokpHyRZ399/1hBds681IdAd7kjek5+irni+ZdiF+le0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbSKvSNS; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2e3e58edab5so1480035fac.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750058773; x=1750663573; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJYitqaIgu00nPVFj7JM9/H2NYxDQSw81n3Uo6DjgQY=;
        b=RbSKvSNSo+/zXWnFHxrbhCXkT4lVyd24cWoimu+/G0CljLPZjQbipTafUKSNhXiv/r
         2SPXgF1IaOs35EJCXx045b09HRkusehb59p83o70MeWE3oDa2+/4ip6eV25KvdMDjoH2
         Eql5hu0EOb+VvPDlgJzFVM9cHxiNbAyBpMoLsATLfq97DsZWxUIIgN9HY8CsqQy0WW7o
         47hs+lXB81KBaryaq5J4sfCooTHQg5q8w/qyowUa9w3TZgcM94iyNuxSA8goVss9v/4t
         CCHKlwA1uARNZBK55qsQVLvOljcxr94xgR5nNchE+BL3gbGLjRtfvay+6KhtY3WCIy8N
         XT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750058773; x=1750663573;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJYitqaIgu00nPVFj7JM9/H2NYxDQSw81n3Uo6DjgQY=;
        b=vjCxKS5hOfyuOJeuXAWvbNuYnZxU9WsFru+ZiFt3J0pXUBGYXd8P++rYQiNUiIqNNi
         myPNC7qp34CGbtKVFGvwut9HNjgHiAvz5Mj8Ulbarr2gLd65P1/FqMSqAoSXSwMVsQNR
         bawjTA0yIDPopY1wn/JsJ7mTC7MmHqMDqCCywhwR8MFgTw3AzZwbStpc17KGUuy0GYV/
         n5jSxMSKFF7ZRke3WCKaz2jXuqw64Bsh3Ez1P0Z9sI24PynU/hzwcZKgDydpuQro/IfD
         gy20+tUZiW05GVhpn3UGLoTgnmWaaDxQm4C5ecrp311xafePSJx55VY0On3l3InK21LO
         nyDw==
X-Forwarded-Encrypted: i=1; AJvYcCW+I9+5yc5+fnTiajygEHIATgNPgfGyOoAJGSM2/AGnBcijIPUv3uFQst/YdvggMtLf3CsZF1NyB6dcnQ8rEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6u65dWbFUKyOTVSWRpbaWhVuKQtMLpc4iHI2Jve45b2uggp7
	lUqXAdA04itsqxazhrNRx/DTwFzP0gsE/6Brfna2sj+II4KXmz7VwYE1wxajlnRI+qZFgx97dP+
	GIGWvtPI6gdJTJ3eIaQY7HPcmoPqv3gZYM7UdKXQ=
X-Gm-Gg: ASbGnctj/7+Yp52x0VfsFsaPeLbMQ4TjduDsKf8VXnbJ1BKZe65nZfoWwt0FuCR8nMI
	moBKKXC+oNZ3bEL4XNXFsD8tIrXN/GTz86O8t9Ex/swMsFWD5EyH9em8Aemwzb089x/9j0vkB7V
	CWe3JyxaXuFw/VPdlYU0vjUMs60YL2KHRqsWFx+skJKNVFvg==
X-Google-Smtp-Source: AGHT+IEzqLDpYCYICbqkpjUMi/HK1TVlIAyEQ+6YgadwJY6J50g6HR5GVX3qXVz5blGaCWN9UjXxo0dtZ9rXUyRZQ0U=
X-Received: by 2002:a05:6870:d0d5:b0:2d5:2955:aa6a with SMTP id
 586e51a60fabf-2eaf0830607mr4405427fac.7.1750058773144; Mon, 16 Jun 2025
 00:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ryan Chung <seokwoo.chung130@gmail.com>
Date: Mon, 16 Jun 2025 16:26:00 +0900
X-Gm-Features: AX0GCFuDEOd-JI1oJ4C24zpNfUEjByFoC1Zs46UDTWDwisOyNfNWyli6GVjuo7o
Message-ID: <CAB1jyqw5RzeC4bT0oXEZ4fC2hcLj65sokW8gt=bp6=1d511D_g@mail.gmail.com>
Subject: [BUG] wifi: iwlwifi driver does not detect the card in Linux 6.16
To: linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. I have been trying to build the mainline on my laptop and have
been facing a weird issue. I have been able to use WIFI on my
linux-6.11.0-25-generic on my Ubuntu 24.04. However, on my newest
build (linux-6.16.0-rc1), I can't use my WIFI. Secure boot is off.

I have realized that kernels built with 'make defconfig' would simply
not boot up after adding to grub. Therefore, I copied the .config from
the generic and changed the following two configs:

CONFIG_SYSTEM_ TRUSTED KEYS=3D=E2=80=9D=E2=80=9D
CONFIG_SYSTEM_REVOCATION_KEYS=3D""

They initially required .pem files, but the original .config will not
compile as it created errors and were therefore modified.

I also checked the bottom configs and they seemed to be set correctly.
CONFIG_IWLWIFI=3Dm
CONFIG_IWLMVM=3Dm

Below are some additional information:
- Network controller [0280]: Intel Corporation Device [8086:a840] (rev 10)
- I was able to find my card (A840/00E4) in drv.c
- When running 'lspci -nnk | grep -iA3 network', iwlwifi is NOT listed
as a kernel driver.
- Running 'sudo modprobe iwlwifi' does work

Please let me know if there are ways to fix the issue. If given the
guidance, I would be glad to work on it and write the necessary
patches. Thank you.

Best regards,
Ryan Chung

