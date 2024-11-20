Return-Path: <linux-wireless+bounces-15528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD999D3685
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 10:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8761F2307B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43218A6DB;
	Wed, 20 Nov 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG0oUOm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F4149C42
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093933; cv=none; b=k1SPWgec4UW7HesoQK4dlRiQzgtGn9a7f417S2OOjf614o07ifp+uAHF+eLDZ/1bUenwnMp6xYsVmBTehpwL8pjWiZT8bF663iS5ZgOh1R8tuxtNKKwIERAzl9H/HaXHL/4Jspo943a8+UQanjGAA+XjZqOHWlK17RXu0NQp/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093933; c=relaxed/simple;
	bh=KzkWkeGvECoGV2/VEbmWP61/DoXb42otfNZTqANZIVA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oN8QRPGkjG5vuzx8L3LgfrOFg5DXAiOKZ5FswFIlFs+TF9g4NyWIeIAvY3CxAo4Bk7VQFx7ZVp5FRxSq/Q4JhIJo80RDTe6nJOekZpWs5wQFmL9aQY0zkTgEi4iWcr5PXm3MTEB9g67FVFvbWMnFhI3WsuTxIQwuss8tulOlK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG0oUOm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADDC4CECD;
	Wed, 20 Nov 2024 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093933;
	bh=KzkWkeGvECoGV2/VEbmWP61/DoXb42otfNZTqANZIVA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NG0oUOm8jeYSJZVv9vSyZt75bfL9btbyC9+yRlOzNDCXn6RzOJCJ9tNpqKUwo+P9Y
	 eFBqGVmn5tnPZAu3qAAOX/hp6uNR7mpSiLSLNjpCdBjM35PPB25WUHv6Y6MnWrZMaS
	 uKqJ2svh080GGX6ElFZDgcvcjSj890Z/cmFIDCvu3zIj8GCD8Vs9LZOsMc6Wospg8/
	 j/Uk5YTL7DKqEwredHRS1BquxGEuNofDDtpwFetyv4SG9lnHzncYzIgLvHeTxZxeKW
	 IRd/o7ES2wRd+t9ZAZPHgeTkjRNf9fUjK4GUBhPj4xWwjvgyqZC2VbexgBoA/u/2la
	 pI+k6509sg77Q==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW
 supports
References: <20241118040255.40854-1-pkshih@realtek.com>
	<20241118040255.40854-2-pkshih@realtek.com>
	<87ikskvhwt.fsf@kernel.org>
	<28b8c5c56c374a2da274f8d32b12f0da@realtek.com>
Date: Wed, 20 Nov 2024 11:12:10 +0200
In-Reply-To: <28b8c5c56c374a2da274f8d32b12f0da@realtek.com> (Ping-Ke Shih's
	message of "Wed, 20 Nov 2024 03:14:50 +0000")
Message-ID: <87r076z2tx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Kalle Valo <kvalo@kernel.org> wrote:
>
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
>> >
>> > After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature,
>> > called NOTIFY_AP_INFO, to notify driver information related to AP mode.
>> > And, one function of it is to monitor PS states of remote stations. Once
>> > one of them changes, FW will send a C2H event to tell driver. With this
>> > FW feature, we can declare AP_LINK_PS.
>> >
>> > For now, driver still needs to determine if a frame is ps-poll or U-APSD
>> > trigger. So, add the corresponding RX handling in driver, which activates
>> > only when at least one AP is running.
>> >
>> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> [...]
>> 
>> > +// CLASS 36 - SoftAP
>> 
>> In wireless we prefer '/* */'.
>> 
>
> The checkpatch is changed to allow this style by default, so I didn't catch
> the warning. Add option "--ignore C99_COMMENT_TOLERANCE" to my local script.

Oh, didn't know that. We should then add that to our ath12k-check script
as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

