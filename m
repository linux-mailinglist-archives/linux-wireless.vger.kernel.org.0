Return-Path: <linux-wireless+bounces-7294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4398BE796
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21E41C236C2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EAA168B08;
	Tue,  7 May 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCpWWx52"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA811649C8
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096480; cv=none; b=MB3igxm2wrUFAXvEOMdhY9ivFkFSVI8id8uuVEdFgeXOKw3hu4fG05uj6Vm18vuw9w3ph7oSJJNK3ZUKN5qKkqfnPh1xvB/W+JOeg0bD0i89qUfBtTUd+Gv2LYl/Zl4REGIF4AtroiHC9/7LndcBFlaPnZBBbN3/LJDL7AxWd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096480; c=relaxed/simple;
	bh=aE+kaQPAah4Dcjpm1i07io+My5mBVg5XQ5w7U/wMEDA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nuyjlsXz19RKprCgjfbc3q9GPD1TFjPoIyWG/b9f2RLPFiI9SfaihyCEEMvRZvztHt4Nky3kl3CYkkXO7mmCrTI853XhQg1om1eQ2rnPKKMfbxV+gLMTpF3ua5+AjIFqLZPD1RkT+fMdrjUvr5tr77u6jPv9TKJ8FcB4pX+C8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCpWWx52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244A0C2BBFC;
	Tue,  7 May 2024 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715096479;
	bh=aE+kaQPAah4Dcjpm1i07io+My5mBVg5XQ5w7U/wMEDA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aCpWWx52W0k+cS0jciM7Sbxn1e7alWt5CQgZdTfRQmOst0/yfIgc2wBjMdmYm1+Ny
	 8WmMBu5f810pi8opESxsmDqD+La4I2j6RNWt06GwdbjQfED3DiWmaTJVLcOgOA29Nz
	 0tx5itsNGPFMvoMhErEUfbsMSPAhn0SkS8Ra18b2ZWfo91pXI+iehhzAfSyoF3EZpj
	 Kz+9QxeEmFyrdeboCf17v9uat0LWKkXbX+mIYjmp5OfPr7qPig++mfpcMY5gxGe8sN
	 97kSkfS7C/qaYaZFClUSzgWSmoMhNAcGlN7T3cFpH96eMVdNfAcM0SwegoBSNzsfr5
	 Zs/+G+lsRzJDg==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 0/8] wifi: ath12k: Introduce device group abstraction
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
Date: Tue, 07 May 2024 18:41:17 +0300
In-Reply-To: <20240507045702.2858954-1-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Tue, 7 May 2024 10:26:54 +0530")
Message-ID: <87bk5hmxya.fsf@kernel.org>
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
> v4:
>   - Modified the cover letter
> v3:
>   - Removed depends-on tag of "wifi: ath12k: Refactor the hardware recovery
>     procedures" as it is merged to ToT
>   - Addressed the deadlock warning seen during rmmod.

Thanks, after a quick test I don't see the warning anymore.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

