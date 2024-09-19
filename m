Return-Path: <linux-wireless+bounces-13010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A293497C61F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D1C1C20D51
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BBF15B0F2;
	Thu, 19 Sep 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJOsfAcB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEDFC0E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735565; cv=none; b=CmS4I0ov5S5L1meNDsEaXbErfAFK0wGthHuXDxaqtf2IYpgrinP4/V7oFYIq/uC8zhlgOHm+TwPgFl+NSCoHY7PXkDQdxZ17FdS4OXyuENxTwqubDM3Kj4swWxdpTD712otNKDmBwxIDZRJrustIS5rd7/54K9mPFcbiab6X0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735565; c=relaxed/simple;
	bh=eCxU4p6XDvooiISyOMXib2zwRAh0WY5U75insDIZxrY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Ae7mi2ZpmFiVKuH5RFg/Zzl1BSdH3wv5v1hRN5LkEP7OCxLoHAlI6xuK54FI16v1Dzg1XPUbc4fI1YlS52A09RJYfHetpKpNgTqn13mlWB+UgBeVswmg18sfqShDf9xgvdACjxahQYa6SlbYTYER8WSN9+tgw4AG+Y/oclcEv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJOsfAcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E54C4CEC4;
	Thu, 19 Sep 2024 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726735565;
	bh=eCxU4p6XDvooiISyOMXib2zwRAh0WY5U75insDIZxrY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nJOsfAcB3fYRd66m0gaPYsLaLp/RinqR1kwmkClEpWkaPW9/LgDJcvlSjAAz3ItVC
	 Vo8oa3Cdh5OiM6w66CorSdibOQazbanjOJ0v2VwJFzS0a205tGsn4cyFWGow3T2ikY
	 aMSvueuOzKUF0VyFigcLdXGanFenTV70aEXw6O2l7DMtregzLos9nSvhuy7xH6g41E
	 tRIto8bkJnpDfBMp3Ql81wvZ0cucI4+VUbX/Ab5rxkWLmcac/jclo2Dypn3oA5J4A1
	 lmqLW44HT/b/K7MpN63mBD929wkKO4ftKNT66JPj3cgci8jRnJyrA+4uzC8BVQZg9O
	 XlsVqswQ9PQsg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZuIhQRi/791vlUhE@decadent.org.uk>
References: <ZuIhQRi/791vlUhE@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
 =?iso-8859-1?q?Martin-=C9ric?= Racine <martin-eric.racine@iki.fi>,
 Brandon Nielsen <nielsenb@jetfuse.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172673556244.134107.10464809786453477005.kvalo@kernel.org>
Date: Thu, 19 Sep 2024 08:46:03 +0000 (UTC)

Ben Hutchings <ben@decadent.org.uk> wrote:

> iwlegacy uses command buffers with a payload size of 320
> bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> describes the default buffers and there is no separate type describing
> the huge buffers.
> 
> The il_enqueue_hcmd() function works with both default and huge
> buffers, and has a memcpy() to the buffer payload.  The size of
> this copy may exceed 320 bytes when using a huge buffer, which
> now results in a run-time warning:
> 
>     memcpy: detected field-spanning write (size 1014) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (size 320)
> 
> To fix this:
> 
> - Define a new struct type for huge buffers, with a correctly sized
>   payload field
> - When using a huge buffer in il_enqueue_hcmd(), cast the command
>   buffer pointer to that type when looking up the payload field
> 
> Reported-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> References: https://bugs.debian.org/1062421
> References: https://bugzilla.kernel.org/show_bug.cgi?id=219124
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> Tested-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless.git, thanks.

d4cdc46ca16a wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZuIhQRi/791vlUhE@decadent.org.uk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


