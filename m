Return-Path: <linux-wireless+bounces-9524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE3915F23
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 08:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A19B20E7E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3714658D;
	Tue, 25 Jun 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obLPoGLI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0719143C67;
	Tue, 25 Jun 2024 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298599; cv=none; b=Uf+W27WO8YaoycW7qM0KAVsJXqAO1zFVKamBso663P3lJxgY8C0a+lQkTjNvZBq3kvjsM4J7SOe+qcG2CRRvamN5cqY1DCWB6xm+fzIZJ3sK+Vkd81fsiAVEIlxUetQIFSTIhscaZMNMcFX6y4cbJqCuXmxEJ5P8mQFa+wQ+Y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298599; c=relaxed/simple;
	bh=zNj07+1fdLb+Kkx4sM2QIhA4tF5aq2auTeOEjXT/xsU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gLRJ/c47Q3iLJa5c9A9/gxO5gL00sXevUvcHwWR2+Hz1o6q8ImdNLKjV4XyS3ST7Szvjhc6Ba8ydzQXDFgvPuz7RH8jJIPomZZAjIlfnhSU0hlsi7Ka42yKYZg1pHyxHLPOA5gI2N0pm9vEODhi5N0iKiti9jCw4nHFaE/fM30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obLPoGLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28222C32781;
	Tue, 25 Jun 2024 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719298599;
	bh=zNj07+1fdLb+Kkx4sM2QIhA4tF5aq2auTeOEjXT/xsU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=obLPoGLIauEarta+M0u2bjskALZAJd0r/KaYiMhPmk4EeiBAQPRv59fkiSzK7yXsS
	 voZ2jD7KE7a5IMV/MetpZyrBGtU3Dv25bjnk+P5vzmbSwfVDi4kSKYdp/4oFerLZvR
	 pK493UrhJSjcDn8tesLMfqUl52GCgEif9pi9ARZEGjVVZoRep2w0AxE/KNMHjmYG2s
	 pKVDnSJYqFv6LivMZpLd+TyvIuLCtYGi/XU+P1O6Iih76WGjBivBG2xupBhCrKttFW
	 Dn4T5+Ctsg1/9PBeYL9QvwEiip5NrN4RhUF+uqpW9ip/mK1S3JZ/SzUH6HJmr6x9Oh
	 /uiwllM89N7Xw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Koen Vandeputte <koen.vandeputte@citymesh.com>,
  <ath10k@lists.infradead.org>,  linux-wireless
 <linux-wireless@vger.kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  <netdev@vger.kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
  Kees Cook <keescook@chromium.org>
Subject: Re: ieee80211.h virtual_map splat
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
	<c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com>
Date: Tue, 25 Jun 2024 09:56:35 +0300
In-Reply-To: <c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com> (Jeff
	Johnson's message of "Mon, 24 Jun 2024 20:44:11 -0700")
Message-ID: <87o77pik7w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 6/21/2024 1:04 AM, Koen Vandeputte wrote:
>
>> Hi all,
>> 
>> Within OpenWRT, we switched to kernel 6.6 some time ago.
>> 
>> During testing on a WiFi WDS setup (ath10k), I noticed an old standing
>> bug which now prints a lot more data due to the kernel upgrade:
>> 
>> - All WDS stations are connected
>> - The splat occurs
>> - All WDS station seem to go in timeout and disconnect
>> - The behavior is fixed after a reboot
>> 
>> Yes, we use ath10k-ct over here, but this part of the code is
>> identical to upstream ath10k.
>> 
>> The main issue:
>> 
>> memcpy: detected field-spanning write (size 64) of single field
>> "tim->virtual_map" at
>> ../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
>> (size 1)
>> 
>> 
>> looks like virtual_map is defined as  "u8 virtual_map[1]", triggering
>> that error within "include/linux/ieee80211.h"
>> 
>> /**
>>  * struct ieee80211_tim_ie - Traffic Indication Map information element
>>  * @dtim_count: DTIM Count
>>  * @dtim_period: DTIM Period
>>  * @bitmap_ctrl: Bitmap Control
>>  * @virtual_map: Partial Virtual Bitmap
>>  *
>>  * This structure represents the payload of the "TIM element" as
>>  * described in IEEE Std 802.11-2020 section 9.4.2.5.
>>  */
>> struct ieee80211_tim_ie {
>>         u8 dtim_count;
>>         u8 dtim_period;
>>         u8 bitmap_ctrl;
>>         /* variable size: 1 - 251 bytes */
>>         u8 virtual_map[1];
>> } __packed;
>> 
>> 
>> According to this page, defining it this way is actually deprecated:
>> https://www.kernel.org/doc/html/latest/process/deprecated.html
>> 
>> What is the correct way to fix this?
>> Converting it to "u8 virtual_map[];"  ?
>
> Adding netdev to the initial message in the thread.
> https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
>
> There was some discussion in the thread, with the observation that the splat 
> is fixed by:
> 2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")
>
> Followed by discussion if this should be backported.
>
> Kees said that "netdev [...] maintainers have asked that contributors not 
> include "Cc: stable" tags, as they want to evaluate for themselves whether 
> patches should go to stable or not"

BTW this rule doesn't apply to wireless subsystem. For wireless patches
it's ok to "Cc: stable" in patches or anyone can send a request to
stable maintainers to pick a patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

