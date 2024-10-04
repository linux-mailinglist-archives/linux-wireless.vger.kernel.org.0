Return-Path: <linux-wireless+bounces-13515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4028899076D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F551C20EBE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22391AA79D;
	Fri,  4 Oct 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTd5TWNc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2B148316;
	Fri,  4 Oct 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055662; cv=none; b=c2wqepVE3f284j6tR2gl8cczeOHYWoMilDpp5oU0J59ZKR+apu7KP6n9F0nP5jJO/i22twCLgoN+K4aydELvcsFO/U2lXQjzj++af2rvArdooz2OiAJ5akHsYY+6EcsdQAu7KSPw6W2K1ublqFgg6YbbILsZ/hxZ42wigMOIGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055662; c=relaxed/simple;
	bh=DbOhM6QwRTwSar41MTMU3QGRJ+Zy5twRhfthc688G3w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=M5tU/001+CbMRcRjqPzjAEi+0Cu/4fLq9A43Au/nqJZOZ+geChzlozN9SOUfYstZmyLT8w3AsOS0l3LUQ27OtdVOaCtarb8eeNAiSgtqBQpi/jZCFfWLyOWRfGfxCWRWxbgDQS3WX3hw+P2wl4+xXJ34QX6puQv0r6vz9vBmLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTd5TWNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F29BC4CEC6;
	Fri,  4 Oct 2024 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728055662;
	bh=DbOhM6QwRTwSar41MTMU3QGRJ+Zy5twRhfthc688G3w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uTd5TWNcIH/I7s3pxin9kFkF1/dWHpoSYL99wloBxTHPJX4moXd0kEVvnZRWOSg2A
	 8153cH12Wm+VK3iLBBGA1778yyeIJhlskSEFhf/Q4dHA/SelLgoam4qiOmEgiQvd2A
	 ZRWR7yw4KPiaojxiwQCFrQqBglYdV2qy5bHDrh+aHLNnRNQxPJGyg0y17+Bl1IgZot
	 7GVyxbcGEtAd/ZxrL+XLYDtpVtizkHcVJvJnnt2CPx6UtXwU3lKW3VQKb2oPsKmbRW
	 gToeHmpoI+LzOFQBtmzi9af/9IrIPLu7DoSh4i+MKrCsP2vHxx5atVR3bO5NAkAs4x
	 gkusttEr3GyRA==
From: Kalle Valo <kvalo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Johannes Berg <johannes@sipsolutions.net>,  Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
	<20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
Date: Fri, 04 Oct 2024 18:27:38 +0300
In-Reply-To: <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org> (Simon
	Horman's message of "Fri, 04 Oct 2024 11:03:21 +0100")
Message-ID: <87setb7us5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> We already exclude wireless drivers from the netdev@ traffic, to
> delegate it to linux-wireless@, and avoid overwhelming netdev@.
>
> Many of the following wireless-related sections MAINTAINERS
> are already not included in the NETWORKING [GENERAL] section.
> For consistency, exclude those that are.
>
> * 802.11 (including CFG80211/NL80211)
> * MAC80211
> * RFKILL
>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f..ea3ea2c0d3fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16197,8 +16197,19 @@ F:	lib/random32.c
>  F:	net/
>  F:	tools/net/
>  F:	tools/testing/selftests/net/
> +X:	Documentation/networking/mac80211-injection.rst
> +X:	Documentation/networking/mac80211_hwsim/
> +X:	Documentation/networking/regulatory.rst
> +X:	include/net/cfg80211.h
> +X:	include/net/ieee80211_radiotap.h
> +X:	include/net/iw_handler.h
> +X:	include/net/mac80211.h
> +X:	include/net/wext.h

Should we add also lib80211.h?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

