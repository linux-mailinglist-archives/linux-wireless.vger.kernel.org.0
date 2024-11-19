Return-Path: <linux-wireless+bounces-15504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABF9D2621
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 13:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B162B2C360
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682F1CBA1A;
	Tue, 19 Nov 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="FAsE9/OL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922C1514FB
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020277; cv=none; b=ZFdf9E2OpAojtQ3zbSkdqhg/O5LMrzeoU316wfvRm1Ogl1+WN8PshusxRgEhK8ji3BzEbG1JaUtRYr4cnlWmwYQSlIaVw7tNGqBPBkhmwc5zB88XIlucoiY0LeIfOLhMkX/g4QAhe5uvtx5GzyGfRbSIHBJF5WC3XI/vuVCnpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020277; c=relaxed/simple;
	bh=4WOoSt6hQ71pgExT9iFQuy0ocabPDYVFfzxsM2NmJ+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iB+FiA4+VeM7927Iv3n64WR+JtWYNvGcddCwXZb0WV1Fr6aRjc/5yhxJFGxQOCH/cJQ/XGl1yZz0l29sXMfd/6xk+B44ebRTqQHTZF9GTclbsxOdZYgVZfxPP/iI4TlMzLsA1FA/VLoEgOgCAo62NnlF48lGKM2ZUyqfMBa3lHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=FAsE9/OL; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1732020265; bh=4WOoSt6hQ71pgExT9iFQuy0ocabPDYVFfzxsM2NmJ+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FAsE9/OLm+CYIucRacheRlHfWNGyuWOs0aWJCLye9tYDTATTLceWC4LLwBnbPEJT/
	 DvE89EEMYz7UMV5bccoUG+IS3KdIAMnM6yuzFLlZk2vNC2N+LYhYgWtUb0lvBXPz6I
	 wCNHaGu8UI4G50fp9u4jUtFPJ+aFveU+MG4o5Xv4zSq3/mY9V3fIM8GD0MxcPnIlNr
	 ChIbvbyl6j2xr0tKcINSz2qGFIOqZ04Plzlv31CSDoXul79nb+JtNdSMhAVCyI9NPH
	 3CXdX9LZj0gZCgtMiK0UG6Lxa3xDWju4L/EPcybIjw5fJH2vtTU+zXHClxmEqBzQXj
	 721cvuR/Q0c0A==
To: Sven Eckelmann <se@simonwunderlich.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Simon Wunderlich
 <sw@simonwunderlich.de>, Felix Fietkau <nbd@nbd.name>,
 ih@simonwunderlich.de
Subject: Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when
 it occurs
In-Reply-To: <4937914.GXAFRqVoOG@ripper>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper> <4937914.GXAFRqVoOG@ripper>
Date: Tue, 19 Nov 2024 13:44:25 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875xojqtp2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann <se@simonwunderlich.de> writes:

> On Wednesday, 6 November 2024 14:39:14 CET Sven Eckelmann wrote:
>> On Wednesday, 6 November 2024 13:41:44 CET Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> > Since this is based on ideas by all three people, but not actually
>> > directly derived from any of the patches, I'm including Suggested-by
>> > tags from Simon, Sven and Felix below, which should hopefully serve as
>> > proper credit.
>>=20
>> At least for me, this is more than enough. Thanks.
>>=20
>> I don't have the setup at the moment to test it again
>
> I've prepared a new Freifunk Vogtland firmware with this patch and placed=
 it=20
> on a node which "regularly" has this problem. It is a node in a residenti=
al=20
> neighbourhood with the usual amount of WiFi activity. It was known that t=
his=20
> node requires ~2 resets in 10 days.
>
> After having it running for 10 1/2 days, I could see that the node was st=
ill=20
> working correctly and the "Rx path inactive" counter showed 3 resets duri=
ng=20
> that time period.
>
> Tested-by: Sven Eckelmann <se@simonwunderlich.de>

Great, thanks for testing!

-Toke

