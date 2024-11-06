Return-Path: <linux-wireless+bounces-14991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923629BEFDD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FAE2833D8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1781F9ABD;
	Wed,  6 Nov 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ToWgAjQF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2517DFF2
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902389; cv=none; b=fYBXV0Rv3KdprOMuwLEeK7hBBwhpCZTDgLbhsnHJb3uEBE54qhF2ASvEczVyhGOAAaoHpoUXmm8qOe5DenWsW+t8YlkwMATEZQrmUXE2bbipumxqb7M2v9wmivgSk6Q6Mayo9hLmA3ztpYwbKehW8vlu3Akxx24rMp+m6FwNYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902389; c=relaxed/simple;
	bh=XgmpvKM/3tN/k7Piv+U060GJx68qRrXsEJqtXLy7//I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHt+Sa9WgIrE+GhIK1ndsT4e8GIvFWcGCUdIMEGX4CR57cmfI1OSkpgjvoxpszuR6DK/USyco19LgK5NYlmXzRdNlorVwb5GMEHUotpt8jZE6BtR7JIpgkRmxKZtFMSPWoKvbOgCK85l6avi5AeFw82OGDskSW24GVaZGKjPx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ToWgAjQF; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1730902380; bh=XgmpvKM/3tN/k7Piv+U060GJx68qRrXsEJqtXLy7//I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ToWgAjQFS+F51ltRgpTXgc1vp+WgbOTKMBoj7BTfQU3VbEaF7HJX4Tv845PVFC8w4
	 LfA15jWb06pNcdcFJl/rOpijnUATcK0gI6zKW4GyV75WuzkNstsM3dD8ZlpPk5pjEV
	 mM0qzITXQHmyyJjkWRqzbOKX4xGJtmnWQTP0OZuSDdZyJ/nf78KqMbMYapFLCs0vXm
	 Po3sNSPE597HlHawqmzHVEaj1gt3o+olVetVFXR+ayI4SfBYf9ntU74l6TtSHdblLg
	 MbExuSzUR3wagb51uxF9k5tGItbwQb9EZpx+kK+oedZRvzZKKxgxemoDtl2FjmEfIK
	 OUY65zxRXm8sA==
To: Sven Eckelmann <se@simonwunderlich.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Simon Wunderlich
 <sw@simonwunderlich.de>, Felix Fietkau <nbd@nbd.name>,
 ih@simonwunderlich.de
Subject: Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when
 it occurs
In-Reply-To: <3288096.AJdgDx1Vlc@ripper>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper>
Date: Wed, 06 Nov 2024 15:12:59 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87msic78no.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann <se@simonwunderlich.de> writes:

> Hi,
>
> Thank you for submitting the patch.
>
> On Wednesday, 6 November 2024 13:41:44 CET Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> Since this is based on ideas by all three people, but not actually
>> directly derived from any of the patches, I'm including Suggested-by
>> tags from Simon, Sven and Felix below, which should hopefully serve as
>> proper credit.
>
> At least for me, this is more than enough. Thanks.
>
> I don't have the setup at the moment to test it again - maybe Issam can d=
o=20
> this. One concern I would have (because I don't find the notes regarding =
this=20
> problem), is whether this check is now breaking because we count more thi=
ngs.=20
> In the past, rxlp/rxok was used for the check. And now I don't know wheth=
er=20
> the count for the other ones were still increasing.
>
> * RXHP (rather sure that "high priority frame" wasn't increasing)
> * RXEOL ("no RX descriptors available" - I would guess no, but I can't sa=
y for
>   sure)
> * RXORN ("FIFO overrun" I would guess no, but I can't say for sure)
>
> Reviewed-by: Sven Eckelmann <se@simonwunderlich.de>

Great, thanks for the review! I'll let it sit in patchwork for a little
while to give people a chance to test it out before sending it over to
Kalle to be applied :)

-Toke

