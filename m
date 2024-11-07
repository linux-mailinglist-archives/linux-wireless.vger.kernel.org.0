Return-Path: <linux-wireless+bounces-15051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA99C0143
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571431F22381
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1C1E1336;
	Thu,  7 Nov 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="LY71vcJM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613441E3DE3
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972171; cv=none; b=ePMeou88h1csZ+UUzR3oAPPk0SRfoatPYyWBmol+GT85EYWC155Vj13Uvr1JtLfsVfkiu4d1+dw8zvVJ5KXcZi4RZnmDDdZxTJ3tpkzB7yLs3PIWh15q4rHFckRXj16Uc5Mdfa6YISwNYpsh6U4BTJvUFQh6PRlT5tFgFhjdQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972171; c=relaxed/simple;
	bh=Oz5vc1v5cRJA8Au+w4A3iYC10lutyIM+uyKGO+bh6n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQmrcMBeTXQchfWRb1kQBdbjoD/CVKfJVuC2tquwwsDzjmHhEFLn+Lzeon/6hLS/6opwvzq2oVzPsSPQXyZ/knHPRrDaGJc+usRldIWJ4LYZ0ERNdSg3nI3JZMY6xUbTk0N2GlcMaksFhiRVMIaWXBcvNL6CxhZ+ThLifzYO3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=LY71vcJM; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1730972167; bh=Oz5vc1v5cRJA8Au+w4A3iYC10lutyIM+uyKGO+bh6n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LY71vcJMkhtWQ2YhSP+y8Be0S5w5sMC56zt3FC4Mr5FXVHYXaUHSjuUjiBb6gpOaw
	 bAATOHoCDNjfdkv07+kDZzekswtc6SaPuSG11jpo6BLymAtzcezXN90Tly/4sltOyR
	 O97k1IL7y/DKOauTJtsr1Y0vpIflUQOGkl20OQth2jusHnjmiWAHljpcBRv+osyp0F
	 Id7tbUr0Xf6xDrCz4dUtoTbKXyIvlM+iYZwtYEIviCkOier9E5tX/M0E5zPPtjRoSg
	 4htXpSpJBwy8ogLtoIgMNIAfaymF1FioADMxVU9fbAgqfyyw52Cn2or5Y1dwc781S6
	 hnzYbeQ+lkpbQ==
To: Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann
 <se@simonwunderlich.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 ih@simonwunderlich.de
Subject: Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when
 it occurs
In-Reply-To: <5009451.31r3eYUQgx@prime>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper> <87msic78no.fsf@toke.dk>
 <5009451.31r3eYUQgx@prime>
Date: Thu, 07 Nov 2024 10:36:07 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cyj775dk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Wunderlich <sw@simonwunderlich.de> writes:

> On Wednesday, November 6, 2024 3:12:59 PM CET Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
>> Sven Eckelmann <se@simonwunderlich.de> writes:
>> > Hi,
>> >=20
>> > Thank you for submitting the patch.
>> >=20
>> > On Wednesday, 6 November 2024 13:41:44 CET Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
>> >> Since this is based on ideas by all three people, but not actually
>> >> directly derived from any of the patches, I'm including Suggested-by
>> >> tags from Simon, Sven and Felix below, which should hopefully serve as
>> >> proper credit.
>> >=20
>> > At least for me, this is more than enough. Thanks.
>> >=20
>> > I don't have the setup at the moment to test it again - maybe Issam ca=
n do
>> > this. One concern I would have (because I don't find the notes regardi=
ng
>> > this problem), is whether this check is now breaking because we count
>> > more things. In the past, rxlp/rxok was used for the check. And now I
>> > don't know whether the count for the other ones were still increasing.
>> >=20
>> > * RXHP (rather sure that "high priority frame" wasn't increasing)
>> > * RXEOL ("no RX descriptors available" - I would guess no, but I can't=
 say
>> > for>=20
>> >   sure)
>> >=20
>> > * RXORN ("FIFO overrun" I would guess no, but I can't say for sure)
>> >=20
>> > Reviewed-by: Sven Eckelmann <se@simonwunderlich.de>
>>=20
>> Great, thanks for the review! I'll let it sit in patchwork for a little
>> while to give people a chance to test it out before sending it over to
>> Kalle to be applied :)
>>=20
>> -Toke
>
> Hi Toke,
>
> this looks good to me in general. I'm not sure either about the particula=
r RX=20
> interrupts. We can test this by putting the AP in a shield box and verify=
 that=20
> the counters are actually increasing, and that should be good enough.
>
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Great, thanks! Would be awesome if you could test it out an report back! :)

-Toke

