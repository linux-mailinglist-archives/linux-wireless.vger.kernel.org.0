Return-Path: <linux-wireless+bounces-7987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD838CCCCC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D8EB2154C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF013A879;
	Thu, 23 May 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AacDWEb3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C791E535;
	Thu, 23 May 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448537; cv=none; b=TTo2fL8fdyNj3AFRHGrMi5D6Jw4vKHqHzvphwEoRfR70SpOsuOgLgVXlTY7h2QUuKGH7xQfAVIyA5xw52wMm/DmZ+kXnWVhBzrE6iAUHgIJlhceAEjCnCGT7bvNuqiZ5/pYnn+Ua3VJ9zNS6lX5C0bVBz8aWYwpCvKwva7RujlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448537; c=relaxed/simple;
	bh=pEQWtK3bCrqEX/gNjxkAEOCoAJCQsEno4zkmSpPLoZw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b5v5IaufMa4zc3KZ3GieN8e9mSTbn0b0/8dbxZ0Twn1lbxyqFON2xtb+6DAEfRJWa3awq5NUWh7qMmRiJaadrvwaf75m02oTzRoOMBHHGfVIDgmMrSXZcq90JYlZDzW9Uo11HmQLtxmEDyQdr2Qcdr2FyqJ2GYzT1cHCcx0aNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AacDWEb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6541FC2BD10;
	Thu, 23 May 2024 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716448537;
	bh=pEQWtK3bCrqEX/gNjxkAEOCoAJCQsEno4zkmSpPLoZw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AacDWEb3OQIMF3pc/zEkwhcbeCvJjNVAUtTeV/QGcyT5FQG1au493A6b0+ouQVaXU
	 yjKVgieoGIRXZ5QSG/jnfO5LUQwnY0h9NncRDNPxsidzpvYA8qdlHogyLKdPi6Qtqg
	 oWgJthhSixz6YvWGflmgROZx4rDbxE8PD2hFRL0PHPJCMzJTC8fVn0//0Hmcn3Fg89
	 A1VlG0u28q+XxLN2tWC0OQd6ZGoDCI2ZmeuQOqtESHjHeRemlHsAxELaW1RAMVPfKA
	 w8Y76zdqahAkxW77ncJscaDGrVwAd8BetQZCdu7PXy4+4xajYbFJoPzKlMfkMPCmfY
	 bLLU/I2CIpxAw==
From: Kalle Valo <kvalo@kernel.org>
To: <michael.nemanov@ti.com>
Cc: Johannes Berg <johannes.berg@intel.com>,  Breno Leitao
 <leitao@debian.org>,  Justin Stitt <justinstitt@google.com>,  Kees Cook
 <keescook@chromium.org>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 00/17] wifi: cc33xx: Add driver for new TI CC33xx
 wireless device family
References: <20240521171841.884576-1-michael.nemanov@ti.com>
Date: Thu, 23 May 2024 10:15:33 +0300
In-Reply-To: <20240521171841.884576-1-michael.nemanov@ti.com> (michael
	nemanov's message of "Tue, 21 May 2024 20:18:24 +0300")
Message-ID: <87msohatii.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<michael.nemanov@ti.com> writes:

> From: Michael Nemanov <michael.nemanov@ti.com>
>
> Hello everyone,
>
> This series adds support for CC33xx which is a new family of WLAN
> IEEE802.11 a/b/g/n/ax and BLE 5.4 transceivers by Texas Instruments.
> These devices are 20MHz single spatial stream enabling STA
> (IEEE802.11ax) and AP (IEEE802.11n only) roles as well as both roles
> simultaneously. Communication to the CC33xx is done via 4-bit SDIO
> with two extra GPIOs: Enable and Interrupt.
>
> Data sheet: https://www.ti.com/lit/gpn/cc3301
>
> This driver's architecture is a soft-MAC and derivative of existing
> wl18xx + wlcore code [1]. It has been tested with the AM335x, AM625x,
> and i.MX8-MP evaluation kits.
>
> All code passes sparse and checkpatch with very few pragmatic exceptions.
>
> Known gaps to be addressed in following patches:
> 1. BLE support
>
> Test log:
> https://0x0.st/XPUd.log
>
> Change log:
> v1:
> * Added dt-bindings
> * Removed debugfs to ease review
> * Fix build issue with CONFIG_CFG80211_CERTIFICATION_ONUS
> * Fix multiple build warnings found with Clang 18 and W=12
>
> RFC: https://lore.kernel.org/linux-wireless/20240512183247.2190242-1-michael.nemanov@ti.com/
>
>
> [1] It was considered implementing CC33xx as another user of wlcore
> but The differences in HW, host interface, IRQ functionality, Rx/Tx
> behavior and supported features were too significant so this was
> abandoned.

The community (myself included) has been frustrated that TI has dropped
the ball on their existing wireless drivers:

https://docs.kernel.org/process/maintainers.html#ti-wilink-wireless-drivers

This kind of behaviour is not exactly building trust. So how is this
driver going to be any different?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

