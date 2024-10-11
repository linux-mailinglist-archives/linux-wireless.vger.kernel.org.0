Return-Path: <linux-wireless+bounces-13885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5562199A424
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7E928503A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C221791B;
	Fri, 11 Oct 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6W1W9Lk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF5216A11;
	Fri, 11 Oct 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650661; cv=none; b=m2hc0qysKZxsNloH5qRfVGFr0g45/HhEWbRyA9jg2Ew3/3ti26caXE2cD8ktRIcIVf9ZpGMqKu70DBUFfWUF5GdDozOEhrlrOaPuNCsb1S4J42+0Lz8V8g/1aud9vnXSwva+4vtIx2p+/kAyIrUBEsK3P/aOgkvQWXdv9NO3/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650661; c=relaxed/simple;
	bh=tBrMY6G14CJqYgINJ5acrgKtzsOiWyaQGmIsQEg4IHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZkYRg4MqWHYNYHkKkbechwdysDd5Q9ZV6blCxp/vh5g3x6PRR5GYmcd5gtMfTf7wHdoD7c36QYkrPXKlh1c4URJ9TfIsMs77f7wicKTF2iroj6hkU7p6De05qCaOZFnnY0lnv8FFjAy7YsF/nraDKWdmC1eYNf9BrQU9rYwUwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6W1W9Lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDDDC4CEC3;
	Fri, 11 Oct 2024 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728650661;
	bh=tBrMY6G14CJqYgINJ5acrgKtzsOiWyaQGmIsQEg4IHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=O6W1W9LkiNV3aJ6tZFXjNxRPfSdaTMziktsJFY5myjGso8FzgRhEeG/BJbXIT0IBw
	 3Om9AYk0iezZL3sf9vty0Dv3urjms1d7pd7DZqAk2SWe43O8roTXodUWp4JFtpFa1y
	 eXC347qi2FwGGsOGw7gQS0ATtFFoUL1zMIGxaXDtWtAlyPZTH69RODunkNRrgXh9cV
	 qI11SPQcnozm3q5axM+klX53SkIVuv32um+0p4ZSTUPt/ZDnaoo8qbdznGEcDev/rj
	 NGBZyOPV2Ai1RKecjMci8DOxhO+mQWY769I0ctqIG5kIWhLkQsorSq1DVUtHbnnyVH
	 KfdprW6QRLWHQ==
From: Kalle Valo <kvalo@kernel.org>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
  <Syed.Hussain@infineon.com>,  <Vinoth.Sampath@infineon.com>,
  <Double.Lo@infineon.com>,  <Carter.Chen@infineon.com>,
  <wlan-kernel-dev-list@infineon.com>,  <brcm80211@lists.linux.dev>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: wifi: brcm80211: add Infineon DEV list for
 communication & maintenance
References: <20241007142955.111232-1-gokulkumar.sivakumar@infineon.com>
	<87zfng3rf1.fsf@kernel.org>
	<ZwP8B8FgDPKEUTXp@ISCN5CG14747PP.infineon.com>
Date: Fri, 11 Oct 2024 15:44:17 +0300
In-Reply-To: <ZwP8B8FgDPKEUTXp@ISCN5CG14747PP.infineon.com> (Gokul Sivakumar's
	message of "Mon, 7 Oct 2024 20:49:35 +0530")
Message-ID: <8734l23j32.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gokul Sivakumar <gokulkumar.sivakumar@infineon.com> writes:

> On 10/07, Kalle Valo wrote:
>
>> Gokul Sivakumar <gokulkumar.sivakumar@infineon.com> writes:
>> 
>> > The Infineon E-Mail distribution list <wlan-kernel-dev-list@infineon.com>
>> > is a replacement for the obsolete list <SHA-cyfmac-dev-list@infineon.com>,
>> > which got removed from the BRCM80211 section in the MAINTAINERS file.
>> >
>> > The new distribution list can be used by the community to contact Infineon
>> > WLAN Kernel DEV team, and also for Infineon team to get notified with the
>> > activity in the upstream kernel brcm80211 subsystem.
>> >
>> > Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
>> > ---
>> >  MAINTAINERS | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 77fcd6f802a5..adfbf5af9eb9 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -4475,6 +4475,7 @@ M:      Arend van Spriel <arend.vanspriel@broadcom.com>
>> >  L:   linux-wireless@vger.kernel.org
>> >  L:   brcm80211@lists.linux.dev
>> >  L:   brcm80211-dev-list.pdl@broadcom.com
>> > +L:   wlan-kernel-dev-list@infineon.com
>> >  S:   Supported
>> >  F:   drivers/net/wireless/broadcom/brcm80211/
>> >  F:   include/linux/platform_data/brcmfmac.h
>> 
>> A lot simpler is that Infineon subscribes to brcm80211@lists.linux.dev
>> list, that way there's just one list for all communication. And actually
>> broadcom could do the same?
>> 
>> I'll also fix the linux-wireless list address, it was wrong originally.
>> 
>
> For brcm80211 activity related notification, the brcm80211@lists.linux.dev
> list seems sufficient. But in addition, more importantly, for the people in
> the community having queries specifically regarding the Infineon WLAN
> chipset support, it would be helpful to have this E-Mail Distribution list,
> So they can notify and communicate with the Infineon WLAN Kernel DEV team.

You can add that to your documentation or website.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

