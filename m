Return-Path: <linux-wireless+bounces-6709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DFB8AE124
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C061C21152
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2492208E;
	Tue, 23 Apr 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP4VvxCA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EB1E863
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865150; cv=none; b=lRQpmULrHbv2vh6rUHzmZr9cEFqWIuMTSjwZOcPkStQdtrILeqjXf6djyhSEbHO0TOLFUjhMWG1TxLbrN0h4EeIX6l/qCKyotaPgr0Kvjcjr5vy320E6Hn56bjY6MAPAfg70ixJpE1zNLN+f8+OpGnp3HtS0YmIChlQl8vV7PV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865150; c=relaxed/simple;
	bh=NaTj27pMTZHoTQIdEq5WvNAK/WPhjv2zXs7+43AjdA8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cVjHDVGaSuBErBiTipplcCN9GF+FG5gQMxFYAE+kG5orvf5q81uMioRDft1tnfacqEjBd/MjmP35BdsAz0llmfGyU1PJgELyKpNdJCwiN5jMgh3xvCoDX3cN2o4cIQMLeMXoQD2twEQGk0x42PvI3K0SvqmB+3RCeKlcdJbt/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP4VvxCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9753C116B1;
	Tue, 23 Apr 2024 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865149;
	bh=NaTj27pMTZHoTQIdEq5WvNAK/WPhjv2zXs7+43AjdA8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PP4VvxCAfcKl9HyUynzFkR0jxhv53l2j4V6L4IGp4h4d8fF3/41kw3qrGBaH/ISc2
	 rymUNXZwCKFMNE5+xXJ37lwf7EUuMgY0YcfXF6dQU8DF4LaIwORJY9alv159tkE8c5
	 xaCyVKAcDRmnA55/homb5f8a1gY24fNuu8X/4OqMPPGdvjlysuMg3k5lHiMkgq/woU
	 MsoGkXsASdlP9SeYJqjY7oD+cqIu+ZGeZWHydGOcyFLNIWfDu5D9JA+meYrGXDNDvY
	 31u1gHEl9oUSYvHsNTujp9wkDyTxofOINcB6KpNRdu6VW41exy4j9nhhzjW5rzItam
	 Uvi128W2J3sOg==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/8] wifi: ath12k: Introduce device group abstraction
References: <20240420083750.1545670-1-quic_hprem@quicinc.com>
Date: Tue, 23 Apr 2024 12:39:07 +0300
In-Reply-To: <20240420083750.1545670-1-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Sat, 20 Apr 2024 14:07:42 +0530")
Message-ID: <878r14v2o4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

> To support multi-link operation, multiple devices with different bands say
> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
> an abstraction to mac80211.
>
> Device group abstraction - when there are multiple devices that are
> connected by any means of communication interface between them, then these
> devices can be combined together as a single group using a group id to form
> a group abstraction. In ath12k driver, this abstraction would be named as
> ath12k_hw_group (ag).
>
> Please find below illustration of device group abstraction with two
> devices.
>
>                  Grouping of multiple devices (in future)
> +------------------------------------------------------------------------+
> |  +-------------------------------------+       +-------------------+   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
> |  |         (Dual band device)          |       |                   |   |
> |  +-------------------------------------+       +-------------------+   |
> |                 ath12k_hw_group (ag) based on group id                 |
> +------------------------------------------------------------------------+
>
> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
> device 2 has one radio (6 GHz).
>
> In existing code -
>         device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>         (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>         respectively. Similarly, device 2 will register its hw (6GHz) as
>         phy2 to mac80211.
>
> In future, with multi-link abstraction
>
>         combination 1 - Different group id for device1 and device 2
>                 Device 1 will create a single hardware abstraction hw1
>                 (2 GHz and  5 GHz) and will be registered to mac80211 as
>                 phy0. similarly, device 2 will register its hardware
>                 (6 GHz) to mac80211 as phy1.
>
>         combination 2 - Same group id for device1 and device 2
>                 Both device details are combined together as a group, say
>                 group1, with single hardware abstraction of radios 2 GHz,
>                 5 GHz and 6 GHz band details and will be registered to
>                 mac80211 as phy0.
>
> Add base infrastructure changes to add device grouping abstraction with
> a single device.
>
> This patch series brings the base code changes with following order:
>         1. Refactor existing code which would facilitate in introducing
>            device group abstraction.
>         2. Create a device group abstraction during device probe.
>         3. Start the device group only after QMI firmware ready event is
>            received for all the devices that are combined in the group.
>         4. Move the hardware abstractions (ath12k_hw - ah) from device
>            (ath12k_base - ab) to device group abstraction (ag) as it would
>            ease in having different combinations of group abstraction that
>            can be registered to mac80211.
>
>
> Depends-on:
>         [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery
> procedures

Are you referring to this patchset:

https://patchwork.kernel.org/project/linux-wireless/list/?series=821155&state=*&order=date

That was sent three months ago and at least I couldn't find a newer
version. So I'll just drop this patchset for now without even looking at
it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

