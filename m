Return-Path: <linux-wireless+bounces-823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806AA8141DB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 07:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFEB2846F2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680F748A;
	Fri, 15 Dec 2023 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOePsk9b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B85D528;
	Fri, 15 Dec 2023 06:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCD7C433C8;
	Fri, 15 Dec 2023 06:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702622140;
	bh=Dn71pnp1Fex8QG4wBzzTBZfQB4hdIO33Nsn74V1lK2I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fOePsk9bBNBlA1shPOJMUTrvU7RBq6fRxexVtCBTacxkiDhTiMOfoZEHdCUC7Ati7
	 j5dSki9HgTHaM81FW66DPJB9K5hLaFvNiTsLRbip71VCTu3ifwEsf1fTvqu+5h9lxW
	 d3OJiI6+tJk1gkIfsO6GTQr7v+P59e/rQHR5BUeXyknGpsKtOHrdkWDKRNywBA9cwk
	 TO2pAy8gttM30GwW2ueLNioLr0X3ia5uLs3ACi0EmdZ0npsrc69fS2jW+nrOeAoqIl
	 AG3mJZNaFjSyuLJ7jmMK6JrKy0+hkNFnf8dViVPT4GqdmmwJzG5+6yNj+cDaqz9G0f
	 l95v+vmnK5zpA==
From: Kalle Valo <kvalo@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Alex Deucher <alexander.deucher@amd.com>,
  Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,  Ma Jun
 <Jun.Ma2@amd.com>,
  "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,  linux-wireless
 <linux-wireless@vger.kernel.org>,  amd-gfx list
 <amd-gfx@lists.freedesktop.org>,  Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and
 wifi / amdgpu due for the v6.8 merge window
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
	<87le9w4u6v.fsf@kernel.org>
	<8bd60010-7534-4c22-9337-c4219946d8d6@amd.com>
Date: Fri, 15 Dec 2023 08:35:35 +0200
In-Reply-To: <8bd60010-7534-4c22-9337-c4219946d8d6@amd.com> (Mario
	Limonciello's message of "Thu, 14 Dec 2023 10:47:01 -0600")
Message-ID: <87bkasm0qw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 12/14/2023 10:36, Kalle Valo wrote:
>
>> Hans de Goede <hdegoede@redhat.com> writes:
>> 
>>> Hi Wifi and AMDGPU maintainers,
>>>
>>> Here is a pull-request for the platform-drivers-x86 parts of:
>>>
>>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>>
>>>  From my pov the pdx86 bits are ready and the
>>> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
>>> the wifi-subsys resp. the amdgpu driver changes on top.
>>>
>>> This only adds kernel internal API, so if in the future the API
>>> needs work that can be done.
>>>
>>> I've not merged this branch into pdx86/for-next yet, since I see
>>> little use in merging it without any users. I'll merge it once either
>>> the wifi or amdgpu changes are also merged (and if some blocking
>>> issues get identified before either are merged I can prepare a new
>>> pull-request fixing the issues).
>> I was testing latest wireless-testing with ath11k and noticed this:
>> [  370.796884] ath11k_pci 0000:06:00.0: WBRF is not supported
>> I think that's just spam and not really necessary. Could someone
>> remove
>> that or change to a debug message, please?
>> 
>
> Do you have dynamic debug turned up perhaps?  It's already supposed to
> be a dbg message.
>
> +	dev_dbg(dev, "WBRF is %s supported\n",
> +		local->wbrf_supported ? "" : "not");

Oh, I should have checked that. I do have it enabled:

CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y

But that shouldn't enable the debug message unless I specifically enable
it via debugfs, right? But then I noticed this in net/mac80211/Makefile:

ccflags-y += -DDEBUG

I'm guessing this is the reason why the debug message is always printed?

It looks like wbrf.c has the only dev_dbg() call in mac80211, all others
use the macros from net/mac80211/debug.h. I think wbrf.c should also use
one of the macros from debug.h and not dev_dbg().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

