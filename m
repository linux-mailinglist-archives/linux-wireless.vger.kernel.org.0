Return-Path: <linux-wireless+bounces-17613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E2A14246
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 20:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228093A7F97
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89D2343B6;
	Thu, 16 Jan 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myq3GfpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF241DE894;
	Thu, 16 Jan 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055849; cv=none; b=Xlc9ucfb0wBORgoc/te4tpBnEm0k6K7jzhWRpzZY6wn72a5Qxi3nUalSKZMilgfTp8W9LnslkAIxFapNb/B/o6FWlbQJBVYHH+iB1XlY42fejRin4blvgcC/lK+5pP9DxYbwmWRN5Y9i9EmXbvkS0F/xAdKIYlJXs7JZmbtgW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055849; c=relaxed/simple;
	bh=au41G+O3NWVMVoiWdgDfIPR2t61AC5R91sEVezhmo1I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fuNDPBtc+jUk40QZGaS0gdKqfbYzmND7dXJZMP24HGKZKvnvq1iG9YzfuIyVg/RG0EVMJd9pM4rGF2+qETAiLG/MqFB4ByIkA+Yo487EGkDq75AyRkxQ3NymYWUkOM9Y6ZX21epKU+cUCZ4ERyln9HbsfRnfaekpcMrQrd62dOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myq3GfpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D947C4CEE2;
	Thu, 16 Jan 2025 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737055849;
	bh=au41G+O3NWVMVoiWdgDfIPR2t61AC5R91sEVezhmo1I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=myq3GfpRyk7/hJOvIYX/1RYUukcLK+zcPUlvZZAktKxsiegFnwyOmMvedSAf8eIrg
	 OX6WrBc/OIBFItF/b2grPixsAM9bmwgibdxcPXdQEoLEvH5vhTESEiWDxP9QSttfdr
	 0nfBtqMhepjhOJtUqK7/lo5nFMLqP6ZWi12wS26TMQR1+0OVHUCEYvxRXWWKEUn+LH
	 Mg5+FJACbzENJ5NbOFYDdTz6Lqz1OJsTY+6GwHM3N6FBmpjxMdO+8Zucfv5riXaTUN
	 ID4oqeLCAtIkIWvofjHOnLRwqGr07WpmQvuSMar0X2Yh9Q2CaWaO560fu3QPG6iqW9
	 B21cRDhXvH/2g==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,  Johannes Berg
 <johannes@sipsolutions.net>,  Bitterblue Smith <rtl8821cerfe2@gmail.com>,
  Wireless <linux-wireless@vger.kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the wireless-next tree
References: <20250116130812.6e6c7b3e@canb.auug.org.au>
	<e19a87ad9cd54bfa9907f3a043b25d30@realtek.com>
Date: Thu, 16 Jan 2025 21:30:45 +0200
In-Reply-To: <e19a87ad9cd54bfa9907f3a043b25d30@realtek.com> (Ping-Ke Shih's
	message of "Thu, 16 Jan 2025 05:49:28 +0000")
Message-ID: <87cygmmu8q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> Hi all,
>> 
>> After merging the wireless-next tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>> 
>> drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rtw_led_init'
>>    19 | void rtw_led_init(struct rtw_dev *rtwdev)
>>       |      ^~~~~~~~~~~~
>> In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
>> drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous definition of 'rtw_led_init' with type
>> 'void(struct rtw_dev *)'
>>    15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
>>       |                    ^~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_led_deinit'
>>    64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
>>       |      ^~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous definition of 'rtw_led_deinit' with type
>> 'void(struct rtw_dev *)'
>>    19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
>>       |                    ^~~~~~~~~~~~~~
>> 
>> Caused by commit
>> 
>>   4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
>> 
>> I have used the wireless-next tree from next-20250115 for today.
>
> I reproduced this issue, and fixed it by a patch [1].
>
> [1] https://lore.kernel.org/linux-wireless/20250116054337.35723-1-pkshih@realtek.com/T/#u

The v2 of that patch is now applied:

https://git.kernel.org/wireless/wireless-next/c/b4bfbc50b1b9

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

