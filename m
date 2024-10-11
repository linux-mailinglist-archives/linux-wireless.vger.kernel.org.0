Return-Path: <linux-wireless+bounces-13879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14999A30C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098E71C21DC4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D79216449;
	Fri, 11 Oct 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGMzVL0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23022AE7F
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647813; cv=none; b=bGd0rILdmiyNgBUz+qLxcZb5Gso+T6ixgRDDHxitYwNosuD3LRJ/C/KF/RlG+UormSWw8EUwPKzhtZPz3jffKIvGyleB5JBKhACJKMtOpgENEP2EGTy9IoCmGPZXpDr7x/Z6O+tACkSgLgQ4cTbzBn+1ph6Uzgj6iAkXCIMvp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647813; c=relaxed/simple;
	bh=gZnUhYNCVqMbY7q4Hb0AYHRcNq4W26G6/42wDs2NtlI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cvR63qr56v0fWsxbrzAxsbpOG/NZ3VcDERycolp7AqD3NOxOFeFYSgWGM/P/hqcxZDxGBX2Cg60UEdGKhrW5yKdmGow4Rh0Ki+ZxAvF+3Nh2ZE/kW7/wJ2hx5b/GiB4tJ6wZva8GhjA7z6Bje2cWToREplVgg9n8szEJkbcNow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGMzVL0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931C8C4CEC3;
	Fri, 11 Oct 2024 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728647812;
	bh=gZnUhYNCVqMbY7q4Hb0AYHRcNq4W26G6/42wDs2NtlI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iGMzVL0BOc/GomVGSj9Mkk288w4m3Fm6F0BiycC0vHLNEl09gDeg0vcsPADnsqSBO
	 4GNKIxeuET3xFdZTH9VUn7dZ7dBE6Smatz7CrQL8WvLnRSxKtD1x7SHRL4iAqMwsSX
	 Mo3aSYWIQKq0JbgSMh/ggc1Si0r9u1NuT01ZAQw5R8OyHRTqwA3o1xJCqsCveZn04T
	 0tZJJ1w4iVqYSMzKb2XrO248Ab71G+CuyQ6Xx7qCXVckscEpqgd2kUac2x6D7KWWTO
	 U47m/29jwHlOoM2+11u1noR7WKgtnJbX+OTxVxz8KvTnxV/Xb02o30URyRVLbi1jT+
	 nz0AH42Byqlzg==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
References: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
	<3731c7452dbf48f8a35e982d08963ba8@realtek.com>
Date: Fri, 11 Oct 2024 14:56:50 +0300
In-Reply-To: <3731c7452dbf48f8a35e982d08963ba8@realtek.com> (Ping-Ke Shih's
	message of "Wed, 9 Oct 2024 00:18:30 +0000")
Message-ID: <875xpy7szh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> RTL8822CU, RTL8822BU, and RTL8821CU don't need BIT_EN_PRE_CALC.
>> In fact, RTL8822BU in USB 3 mode doesn't pass all the frames to the
>> driver, resulting in much lower download speed than normal:
>
> Have you also tested in USB 2 mode? Just want to know this patch works on
> both modes. 
>
>> [  5]   0.00-10.00  sec  98.6 MBytes  82.7 Mbits/sec                  receiver
>> 
>> Don't set BIT_EN_PRE_CALC. Then the speed is much better:
>> 
>> [  5]   0.00-10.00  sec   714 MBytes   599 Mbits/sec                  receiver
>
> Good job. That improves ten times of RX throughput!
>
>> 
>> Fixes: 002a5db9a52a ("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
>> ---
>> The code in the official drivers is a little broken. It sets
>> BIT_EN_PRE_CALC and then immediately unsets it. I didn't notice that
>> before.
>> 
>> Maybe this should go to kernel 6.12, if it's not too late. Commit 002a5db9a52a
>> ("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c") first appears
>> in 6.12.
>
> Kalle, could you help to take this patch via wireless tree? If yes, I will
> assign this to you in patchwork. 

Yes, let's take this to wireless. And you don't need to ask me, just
mention that this should go to wireless tree and assign the patch to me :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

