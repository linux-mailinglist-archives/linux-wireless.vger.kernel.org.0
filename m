Return-Path: <linux-wireless+bounces-806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5A3813682
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643D11F21ED1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446C60BA1;
	Thu, 14 Dec 2023 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAkZjkxq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187C60B9C;
	Thu, 14 Dec 2023 16:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8033C433C7;
	Thu, 14 Dec 2023 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702572082;
	bh=aR0AfO4Zo8a3/6CuOkcgFklla3J0GR//5YEavtZmcQs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GAkZjkxq8d7vJm4HIljWKOFiPA/2BaPPlaKZHPZLRO4DD9wbOPXlgbeH+TLYP80AN
	 FwpgqFP1DI/D308SUJ9TxRb+/r63ETwuEw//2P2LhWxPQv75QE7qZXYHYXty/YuwJW
	 pPRySd8xG8XoCoQ55EaAlQIfVfGovXBUuY3xBOeRa8WbqAZ7aU2+N9avI86gzFNPcq
	 plgeZFHkfCFUJIXkWPhhYUYjyJfxnlp58CCzIelrlYYYO+TS58TbEWqa1LO2RiWaPV
	 hnNMPKstrMT6M9WYuL3zUy4iNnZm1hux6CKimeuWh6NV5lqEsqQ6YD84lp/FSyJIYx
	 sWEKi2H6vIl4g==
From: Kalle Valo <kvalo@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
  Ma Jun <Jun.Ma2@amd.com>,  "Limonciello, Mario"
 <Mario.Limonciello@amd.com>,  "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,  linux-wireless
 <linux-wireless@vger.kernel.org>,  amd-gfx list
 <amd-gfx@lists.freedesktop.org>,  Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and
 wifi / amdgpu due for the v6.8 merge window
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
Date: Thu, 14 Dec 2023 18:36:56 +0200
In-Reply-To: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com> (Hans de
	Goede's message of "Mon, 11 Dec 2023 12:02:16 +0100")
Message-ID: <87le9w4u6v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hans de Goede <hdegoede@redhat.com> writes:

> Hi Wifi and AMDGPU maintainers,
>
> Here is a pull-request for the platform-drivers-x86 parts of:
>
> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>
> From my pov the pdx86 bits are ready and the
> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
> the wifi-subsys resp. the amdgpu driver changes on top.
>
> This only adds kernel internal API, so if in the future the API needs work that can be done.
>
> I've not merged this branch into pdx86/for-next yet, since I see
> little use in merging it without any users. I'll merge it once either
> the wifi or amdgpu changes are also merged (and if some blocking
> issues get identified before either are merged I can prepare a new
> pull-request fixing the issues).

I was testing latest wireless-testing with ath11k and noticed this:

[  370.796884] ath11k_pci 0000:06:00.0: WBRF is not supported

I think that's just spam and not really necessary. Could someone remove
that or change to a debug message, please?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

