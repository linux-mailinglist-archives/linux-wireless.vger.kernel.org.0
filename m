Return-Path: <linux-wireless+bounces-24318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5301AE31CC
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422F57A68BB
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713901422AB;
	Sun, 22 Jun 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="fLPprGzM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32ADD299
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750621528; cv=none; b=VDvRtHC3RuY+ZHx8bL6B8ukSgHWkBx3/9qN0/VIToP4vVtpSOUPmc1bSv9LVL+2IgF8r37m6bQiBFCVt9/8k2h+Qv4cpCYftAfqBldr6fqoKrZ6WFgfm3wzbnVWUoFNUwdF2kYoCyEjPpNw8Yb4z0ne5TOr5OXu7v6g+uspM7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750621528; c=relaxed/simple;
	bh=xMl0gncXwfJpbyLYubw2FwsDgOENBfjuqAn9J+V6JDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGQxj0i9ZlCcBYICZ5Pw4g5i9/FU4Uv+346o0/uVpMx80X/znm+owsYt5nhNFh91VubZt3Y62dbhwyZFl38uxWQgIi83NWY4G0chVkBkxpB+zyPMjp8y2lgzrROLqO9czGMlrm8ks9WEJZMw2tl9mlPgZWh80q76FyOrItdxMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=tometzki.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=fLPprGzM; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tometzki.de
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e7fac85892so850827137.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1750621525; x=1751226325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ChgWC+3ezS/6tB64iTOn4h92WPPY7VUopVU/jQD7g8=;
        b=fLPprGzMxYo4Eqc0hs5/jkf+kf5NVj7CMLYdZTBTrcYjGHDLddD7+Fm9pDyqNbSCwU
         eJUpv1P4WBOEUzGroK/XWcyXv0xt4Zf9ac2RkvWVLJLyVWVtT1zl/DBROoZBKYOn+0FE
         AzXnQ5zhOypQ2VdqC47aObBbs47IA9qIRDM5LsryGHbH4wvE37WBAX6eAQ6WBcSd1Gkp
         tem3mYujMtgrMX/J3N5tqkgXgQ83lhBWrU9ckOw5ROy0enCXQe2DsV3mlAeCzm546OLT
         IqRLq9FEAgWshAO4jPJ5ANX3gxXx9Mhbuohc5BkI6EjvC8GxM4zXXTi5rVNgOOJevfJy
         ADNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750621525; x=1751226325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ChgWC+3ezS/6tB64iTOn4h92WPPY7VUopVU/jQD7g8=;
        b=UdY/bvld3RluSK6GjGr3jtTN6FuxkNPRIKhnfwYIeOZ+itvsOXP/W7XngZfiui9gz+
         NU/jH4/CuJWJtI9GWsUY5vRXYGQvgmCaW7oE/qEJ/fbJUM+8YyGtQfcXkRKA2o3VwzVH
         EK5Q9DOECbxF3XgKviiYgN9yKAD95WR1jYNXLqw6feh0vlqdtsEfWuqWqPa0WFXagRK4
         bel21boSBYD6UClE9oy7wF0B+4Z4b8ejHCG8HmAENjmX2gsgtQ4Cj74/y5mAMSiZHCo0
         SN8+wq9/v9/iFHyG8cehqyaO8TF4RvitT/Dc1s+FYdKyOnk4R6V1drKin6zhqOa/HWxQ
         cNhQ==
X-Gm-Message-State: AOJu0YzvBglC25dFVCmpWvIcDm4tcKcquMtNf88u24Ll83E0BeYHeeZU
	Q+DD6ElkbcF+hKr+VX3IcIpeFirOWBTwqQFSNI5oEVWvYS4kbuRyui49yrxmvR2ZfZOBQbyG9/k
	OMA36+lzpm9YYV/gUBLyKWQVE9QrmQGs5vdVy8tFUvw==
X-Gm-Gg: ASbGncsXgWoBY0uoaExU7gBOGGozFiwLhd6xNIokv6JjO9FOvc6aDQKmoGO7F4d9W4K
	Ko3NcBb0txSZRNplhzCTgXlohX02x1pi1f51ccXb7ToSOYQD2xYOJNZ5ZfcZLLf3kuJcZpiZxS+
	zmDA/olT4hT/hKrw5oYMcu5nbMH54i9qCEjDdTT1Ba+ubUCEJ7l8lDUUkb0lAYUzM3o9l9OlBTM
	4pNycP+GJtmbA==
X-Google-Smtp-Source: AGHT+IG1ytte1PKWUtJPyzMDnukdyiPq2U8ipMkApBgqIsoHE7yQfT6CIobEIp92dXYY/EarclIJC5CZptO2BDJpGP4=
X-Received: by 2002:a05:6102:2ac9:b0:4e7:bf03:cd79 with SMTP id
 ada2fe7eead31-4e9c278f547mr5663013137.5.1750621525576; Sun, 22 Jun 2025
 12:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFgvmhSbup2BnUHu@fedora>
In-Reply-To: <aFgvmhSbup2BnUHu@fedora>
From: Damian Tometzki <damian@riscv-rocks.de>
Date: Sun, 22 Jun 2025 21:45:14 +0200
X-Gm-Features: Ac12FXyOU_bdBPqnMrGIUvjiVObxa6euaNtZ5QVxUNDgfEL_cn5TDfels2jU9WI
Message-ID: <CAL=B37mqrHOzEQzPX3=6S5XaUZexYRUXNBgUuGsiX6+4iHWO8g@mail.gmail.com>
Subject: Re: wlwifi AX201: WARN_ON in iwl_mvm_mld_mac_ctxt_cmd_common repeated
 UMAC FW crashes on 6.16-rc2
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 6:30=E2=80=AFPM Damian Tometzki <damian@riscv-rocks=
.de> wrote:
>
> Hi Miri,
> Hi all,
>
> with v6.16-rc2 I consistently hit a Wi-Fi firmware crash on a
> Lenovo ThinkPad X1 Carbon Gen 9.
>
> Hardware / FW
> -------------
>  * NIC  : Intel Wi-Fi 6 AX201 160 MHz (PCI ID a0f0:0070, rev 0x351)
>  * FW   : 77.864baa2e.0 QuZ-a0-hr-b0-77.ucode (auto-loaded)
>  * BIOS : N32ET96W (1.72)
>  * Platform: 20XWCTO1WW
>
> Kernel: 6.16.0-rc2 #440 PREEMPT(lazy)
>
> Symptoms
> --------
> Immediately after NetworkManager (or plain `ip link set wlp0s20f3 up`)
> the driver warns:
>
>     WARNING at drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c:37
>     iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0
>
> The firmware then aborts:
>
>     FW error in SYNC CMD MAC_CONFIG_CMD
>     NMI_INTERRUPT_UMAC_FATAL
>     ADVANCED_SYSASSERT 0x20103126
>     Microcode SW error detected. Restarting 0x0.
>
> The cycle repeats every few seconds; the interface never becomes usable.
> Full dmesg attached.
>
> --
> VG
> Demian Tometzki

Hi together,

I identified commit 83f3ac2848b46e3e5af5d06b5f176c as the cause of the issu=
e.
After reverting it, the system is working again.

Best regards
Damian

