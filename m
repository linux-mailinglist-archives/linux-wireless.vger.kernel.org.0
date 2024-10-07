Return-Path: <linux-wireless+bounces-13622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B049993533
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D41428486A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29A1DD9D9;
	Mon,  7 Oct 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLTK1Ieg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AC1D6DCE;
	Mon,  7 Oct 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322868; cv=none; b=HkB9xBgTObAEypHzm/d9+9nF5hp1pARNVy175df15XbpzvHBFvif/wp5GofCP9JgAT/DeB0Q3ybt9pl13TKCliogJRrY7CyrPuOUmy4foUZk66/4tmzkINttI3DnMXbIoNTm5Nc7A+hVJkenzkl79FRCQc2n6sYJm/qmbt2V2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322868; c=relaxed/simple;
	bh=dSfnVQ4JAFzyMREkoETp/HHuCtLwsJ6pu0JR7N/AEkE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HcgdDAz2zW1mv1fo57BDhhnuNgMZA6FvWLn9XgUuaKUCW6bq89LWAxcpm6WB3v1O9zXELwMpOBdDZNagkbffjEWSRo2AOvT5mRGYWyAeWIabPb7Kh2Ffka7CI4If5p+uvsDIi93DMaB6W0bQXPRPOr9WM+jbNfUnPGuDgf7ZGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLTK1Ieg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305FAC4CEC6;
	Mon,  7 Oct 2024 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728322868;
	bh=dSfnVQ4JAFzyMREkoETp/HHuCtLwsJ6pu0JR7N/AEkE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DLTK1IegbE8t4wKnvUOyjU5hb4agfrbk0pyT1qftq/wQXpAAQmYCjc2rGmVnP6CnP
	 fXwIa1faXxF1m7bFIR4nNpHucuhZFhTxLVc8UCgH9egC6QEHqlMnZz4CDxi7T6y+zF
	 D2nky0edGQ6AL8TDYv5Yto3buBASpIv9xSR+wr+wtvzO9ycB4WCuZhYFIb0xQmxer7
	 hDpvXSFYBhvY2z8XKIdGv7jPoPIrd0M6pXDJ2RkT8n1t7qhY7/8aiEDimGKjfQSpWN
	 1HcyGipecqHQOfrLy2hM5efXiksLTvgUfAOGa/LOdsrM/cv2Et8ekf2XVbLdgDFgOA
	 h9C9FX8MvQmpg==
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
	<87setb7us5.fsf@kernel.org> <20241007141305.GD32733@kernel.org>
Date: Mon, 07 Oct 2024 20:41:04 +0300
In-Reply-To: <20241007141305.GD32733@kernel.org> (Simon Horman's message of
	"Mon, 7 Oct 2024 15:13:05 +0100")
Message-ID: <87ed4r4xqn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> On Fri, Oct 04, 2024 at 06:27:38PM +0300, Kalle Valo wrote:
>
>> Simon Horman <horms@kernel.org> writes:
>> 
>> > We already exclude wireless drivers from the netdev@ traffic, to
>> > delegate it to linux-wireless@, and avoid overwhelming netdev@.
>> >
>> > Many of the following wireless-related sections MAINTAINERS
>> > are already not included in the NETWORKING [GENERAL] section.
>> > For consistency, exclude those that are.
>> >
>> > * 802.11 (including CFG80211/NL80211)
>> > * MAC80211
>> > * RFKILL
>> >
>> > Signed-off-by: Simon Horman <horms@kernel.org>
>> > ---
>> >  MAINTAINERS | 11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index c27f3190737f..ea3ea2c0d3fa 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -16197,8 +16197,19 @@ F:	lib/random32.c
>> >  F:	net/
>> >  F:	tools/net/
>> >  F:	tools/testing/selftests/net/
>> > +X:	Documentation/networking/mac80211-injection.rst
>> > +X:	Documentation/networking/mac80211_hwsim/
>> > +X:	Documentation/networking/regulatory.rst
>> > +X:	include/net/cfg80211.h
>> > +X:	include/net/ieee80211_radiotap.h
>> > +X:	include/net/iw_handler.h
>> > +X:	include/net/mac80211.h
>> > +X:	include/net/wext.h
>> 
>> Should we add also lib80211.h?
>
> Thanks, I missed that one. Perhaps it should have:
>
> * An F: entry in the MAC80211
> * An X: entry in the NETWORKING [GENERAL]
>
> If so, perhaps I can just add that to a v2 of this patch.
> Let me know what you think.

Like Johannes said, the cfg80211 entry is more approriate but otherwise
sounds like a good plan, thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

