Return-Path: <linux-wireless+bounces-8548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD728FC9F4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20255B242FD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363991922F9;
	Wed,  5 Jun 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ftk2zt4b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF3190490;
	Wed,  5 Jun 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586002; cv=none; b=Ec14+5cAFv7CV9bYNzXr5tXPp8h/QSE2R/db0o29fRpCmNH6Ow70VZ/lNtcCAlf1f23r4b2o/+h9qnTZzFboKolYv2bis5KD7XbQ9zAnwiXMDX1BJ61B6e84jZwKjKVCZx0uZjANjCGDqFREvgeE0S0beTu8VMyXUlnZGha4zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586002; c=relaxed/simple;
	bh=2zPj2TTAN6lL62g/2HNovoeYRhcJFH7D5qxrP2BKHbU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SP5Fe/1QyMkTERnymynAR2pPtfH/2lFO/Rcf2HYuJ8iXd6bb/t4g00Ihzu0epjWGUDEIA3nbAW7US1S0zTR16+XfARxBnffywgAW1mV/JgiG+9jHWfgNyV1Hs7HO/zThZ3gZdFp222HFX7Ce1eWzVsVC+b7KfZHoTDgvsiahoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ftk2zt4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1C2C3277B;
	Wed,  5 Jun 2024 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717586001;
	bh=2zPj2TTAN6lL62g/2HNovoeYRhcJFH7D5qxrP2BKHbU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ftk2zt4bwhD4VGWRbg8OBth5AhSQQeDntJVzB39gyol/9y5J3ml3eAr6uzf5iTFXj
	 naT+v1aOshoeTx/rQdlSoQIRcVoQLjpz0YqEEvYzRB62llRX6YpSSb0jf5pdkpu1XD
	 ynPzWEM9pPBDgXo59U4gl4CKgI5moqDD8ikbJg+ZTu1Lsoq6AHBXzzOYIWqtHRlKm+
	 VIHvqLpi6gHS7zr1RD+GgQ3RIP6uHZuSuOLuj05S72FQun7eCJL8rKGPhPQM9jduis
	 FIktw27BHGHUmMsjb1fd8HEcAX0Jca3pYPMO+hD+EiiZ7sAFU1l2/tkQAamuuHZVl0
	 GXRtx5dh8VKdg==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Nemanov, Michael" <michael.nemanov@ti.com>,  Johannes Berg
 <johannes.berg@intel.com>,  Breno Leitao <leitao@debian.org>,  Justin
 Stitt <justinstitt@google.com>,  Kees Cook <keescook@chromium.org>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  Sabeeh
 Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 08/17] Add main.c
References: <20240521171841.884576-1-michael.nemanov@ti.com>
	<20240521171841.884576-9-michael.nemanov@ti.com>
	<cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
	<456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
	<97d8acf9-6cb3-4da7-ad4e-0f2d0a63c172@kernel.org>
	<2e2ec1ba-0c24-4173-af60-ea51004f2e10@ti.com>
	<eea16e12-6e9d-4630-87e6-f44071ab1c4e@ti.com>
	<2c4283be-0369-4be3-ba07-987b9fb41476@kernel.org>
Date: Wed, 05 Jun 2024 14:13:17 +0300
In-Reply-To: <2c4283be-0369-4be3-ba07-987b9fb41476@kernel.org> (Krzysztof
	Kozlowski's message of "Wed, 5 Jun 2024 12:04:29 +0200")
Message-ID: <87a5jzmylu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

>>>>> +u32 cc33xx_debug_level = DEBUG_NO_DATAPATH;
>>>>>
>>>> Why this is global? Why u32? Why global variable is defined at the end
>>>> of the file?!?!
>>>  
>>> cc33xx_debug_level together with cc33xx_debug/info/error() macros is how
>>> all traces were done in drivers/net/wireless/ti/wlcore/ (originally was
>>> wl1271_debug/info etc.)
>>> It enables / disables traces without rebuilding or even reloading which
>>> is very helpful for remote support. These macros map to dynamic_pr_debug
>>> / pr_debug. I saw similar wrappers in other wireless drivers (ath12k).
>>> This is also why there are plenty of cc33xx_debug() all over the code,
>>> most are silent by default.
>> 
>> Any more thoughts on debug traces? I'll remove all trivial function 
>> entry / exit traces as Krzysztof requested. Is it OK to keep other 
>> cc33xx_debug() calls which will be off by default?
>
> Sorry, I don't see the point. Dynamic debug gives you debug control. You
> just added orthogonal code to existing debug infrastructure, so as far
> as I am concerned, this should be dropped in favor of standard debugging
> calls.

I think most wireless drivers have this kind of debug level parameter,
for example debug_level in iwlwifi or debug_mask in ath12k. Our problem
with the dynamic debug framework is that it's either too fine grained
(ie. per line) or too coarse (per file), but in wireless we usually want
to have some kind of per functionality level debugging as well. For
example, to show only management frame transmissions, certain firmware
interface commands and so on.

A long time ago there was a discussion about extending dynamic debug
framework but not sure if that ever happened.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

