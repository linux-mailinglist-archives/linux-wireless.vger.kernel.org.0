Return-Path: <linux-wireless+bounces-17762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A13A1727E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 19:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D6B7A1F7B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CC1E32BE;
	Mon, 20 Jan 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr0AgaHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B60EC0;
	Mon, 20 Jan 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396106; cv=none; b=LoYmB1fUr8DLONcNuk6c6dAcOgFB10zCuJ3QuVY0qKOD8uzTlMN5KWmpXFtf3IEW9wERwsIjy0fM7X6iG2JjwQEGa3R2s3ogC212qTy9aDl+zLAcJHU8fJl9MnNovz2+KrYpWPNGhavlEIMhVQX9zBlC3C1u17V5FDwW6eJ+rRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396106; c=relaxed/simple;
	bh=RRKi2WIwPIMTJbi4FhUzSOVkairuWsLduXVttsjJ4mU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=i11yKKnwIekQza3h2MUZy9rE6n4HKH8BhvwbVTtfnt4Q/y1GMYupKeDyATdP/ZkzX8kNv5jEe+z41UaSNfYESZ3AUEJZixokLZ7lc0R4HQpB/vxvixExFWr3n0RJ1RHALESfyOGmVnxoi60Zcvt9U7J/NVLkvrRvLmYYNKOMncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr0AgaHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFF3C4CEDD;
	Mon, 20 Jan 2025 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737396105;
	bh=RRKi2WIwPIMTJbi4FhUzSOVkairuWsLduXVttsjJ4mU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Wr0AgaHpmG+nqSwTUJxsBlrmxiBHrJA72mWa3Qs+T6zbmbApupsgqQZmsvCXsgQDf
	 sSVc75YKarwTytDGwPfS0nAVJAm2P8SFr+lBpH0rW8I5tuO64SwXHmzLCeGoZm6n7a
	 sbvAnfB4cAJG4QcK4BMGj49ARzIxinHLSaI8r8fTBx07HjZDzwQE+rZuLlGH+lqw0a
	 txFvhC2aXwPXb+FpmtHByj0zbFH7uSlt6jcuwklzleIJ5Fvk/nIuAtl6f/SXNgwLRt
	 qcVjA/Yd4+eA573yvry8FhugavEVvfkmcZUJJCCU5D2vISLRmwyY0Ku9BPsmIJJCil
	 EtpBd+TcmOUKg==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Aditya Garg <gargaditya08@live.com>,  Arend van Spriel
 <aspriel@gmail.com>,  Hector Martin <marcan@marcan.st>,  Janne Grunau
 <j@jannau.net>,  Orlando Chamberlain <orlandoch.dev@gmail.com>,
  <stable@vger.kernel.org>,  <linux-wireless@vger.kernel.org>,
  <brcm80211@lists.linux.dev>,  <brcm80211-dev-list.pdl@broadcom.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: brcmfmac: use random seed flag for BCM4355 and
 BCM4364 firmware
References: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
	<19484c927b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Mon, 20 Jan 2025 20:01:41 +0200
In-Reply-To: <19484c927b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Mon, 20 Jan 2025 18:36:03 +0100")
Message-ID: <87tt9tjrei.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On January 20, 2025 5:50:56 PM Aditya Garg <gargaditya08@live.com> wrote:
>
>> From: Aditya Garg <gargaditya08@live.com>
>>
>> Before 6.13, random seed to the firmware was given based on the logic
>> whether the device had valid OTP or not, and such devices were found
>> mainly on the T2 and Apple Silicon Macs. In 6.13, the logic was changed,
>> and the device table was used for this purpose, so as to cover the special
>> case of BCM43752 chip.
>>
>> During the transition, the device table for BCM4364 and BCM4355 Wi-Fi chips
>> which had valid OTP was not modified, thus breaking Wi-Fi on these devices.
>> This patch adds does the necessary changes, similar to the ones done for
>> other chips.
>>
>> Fixes: ea11a89c3ac6 ("wifi: brcmfmac: add flag for random seed
>> during firmware download")
>> Cc: stable@vger.kernel.org
>
> Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>

I'll queue this to wireless tree for v6.14.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

