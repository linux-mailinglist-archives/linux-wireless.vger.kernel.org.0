Return-Path: <linux-wireless+bounces-12463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9B96B3E5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F8E28131C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDB176FA2;
	Wed,  4 Sep 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTxmW4/5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FF15099D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437137; cv=none; b=uv5uZ2na8U6EtJBYnT2hswsEev9VahcxT8Slnx/k57dhj2qfEjtAfqEFkoO0PsmXkP6a1eeNvefw97Z9xvyXEO60zjHx1Y3L7xRVOH/7Q6gpDa8Mquy5ZKYJ5SDjFqBj+fsUOisnhPb+2ShITC2l6lrlichy1h2LFPr0vRUaGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437137; c=relaxed/simple;
	bh=5oioWBL4GnXhrAnuJK34nTYd8tgLtRoIQVtQnty79lE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nQ0ad9LSQAfomHEDIJTevaMPYI0EUc7xG6TLm4Ye+xfgL0N9R3vZpVW4jHAsgWfc9NQPdWP7pbd61lRYcINAb5ymA59f8UxnpXndjdERoT/I8/WoYWJpgxvRClXgfQ5pbZyZPHb8dWZt4ngGC3vx7KAAtxPv4vwI6+fw2hwNv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTxmW4/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C3C4CEC2;
	Wed,  4 Sep 2024 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437135;
	bh=5oioWBL4GnXhrAnuJK34nTYd8tgLtRoIQVtQnty79lE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uTxmW4/5Tivl1Lw5GkBHz8geIm+sUn0PypgvlewV44as/ORvt65YkogsAOqwM90Fv
	 W7m78vJJVJfwidvAkNzHwKY+8SsHPVfvM8b/YQJDOIthdLCB0fo0rCqEM5btfHBVH5
	 pq6lQ5fiMF2dtE1MicL40wRFq5wTMkh3qhuKwWvVbil0Y7HcG39ydTQVXt/UEDjm9e
	 MVNKXtQPLAwWDmvNQcZ7TMeBkD93SJ5EBrIAGXILrhTEoGmalbn/gpUa9fwSiSYG4u
	 H8w86ptMQic10we4F34GJkfZ/kezqN5/Ey8PrnN4nGI0iMtQWBjD2v0jIaqBjG6HI/
	 bfamSxkgjhhTw==
From: Kalle Valo <kvalo@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,  toke@toke.dk,  nbd@nbd.name
Subject: Re: [PATCH] wireless: ath9k: eeprom: remove platform data
References: <20240903202713.471489-1-rosenp@gmail.com>
Date: Wed, 04 Sep 2024 11:05:32 +0300
In-Reply-To: <20240903202713.471489-1-rosenp@gmail.com> (Rosen Penev's message
	of "Tue, 3 Sep 2024 13:27:13 -0700")
Message-ID: <87jzfrkfn7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> There are no more board files defining platform data for this driver and
> eeprom support through NVMEM has already been implemented. No need to
> keep this old functionality around.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  As an aside, the last user of this functionality downstream in OpenWrt
>  has been removed: https://github.com/openwrt/openwrt/commit/7ac8279bd
>
>  drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
> index efb7889142d4..df58dc02e104 100644
> --- a/drivers/net/wireless/ath/ath9k/eeprom.c
> +++ b/drivers/net/wireless/ath/ath9k/eeprom.c
> @@ -15,7 +15,6 @@
>   */
>  
>  #include "hw.h"
> -#include <linux/ath9k_platform.h>

What about the file include/linux/ath9k_platform.h? That should be also
removed, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

