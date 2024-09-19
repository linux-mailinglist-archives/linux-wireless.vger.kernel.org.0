Return-Path: <linux-wireless+bounces-13009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03197C608
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8661C212B8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B21990C3;
	Thu, 19 Sep 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqk3Tk6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB111990C7
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735232; cv=none; b=sjbNfTf5fkkv6IsR/0rf7J3/32/LKAObCBSSATobxidUj9Fy/UNb+DTvFXFLws2FGc3HHmptf/Qqz3wisO1ZZk2s493kV7VxNChkh3jX3v1EpZ9P13DWhqv96KXWQXgPIFEL9WZct9rgQepEr5GmEGzMtRM/KaNPe6GmpvECois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735232; c=relaxed/simple;
	bh=h56T/fPOl219mcY9lThmVQpZI8eI0zCoDqX1joJbeQo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DWGScH0/qtcDLrOlDVx9DPYtTrj5auN/WnUDnk/Hazsp1DMhXw5KLoKemCEjgujwxePsFElectU20gOYL8KvPEHkdvRcSCkqPBGrJn1/ohU4KOAN1s73s6h5Ji+K18zEfP0rs+epCj7QKDZ+6L2x1g+FFUVnq8PGQrq0OCDQzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqk3Tk6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2531C4CECD;
	Thu, 19 Sep 2024 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726735231;
	bh=h56T/fPOl219mcY9lThmVQpZI8eI0zCoDqX1joJbeQo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iqk3Tk6L3ylJmC7kkwmczO/MuQ7YF2PQLuFBXRrkskhWIj0tbHrRIWdaXB8ap8Vsz
	 Egc6PQC6xirmf+XBEu+sKOKWS2EnBt5VFKstc4B/erYj17z2lkZe4N/OJEFZmWICcg
	 l6kp9yhxrlKbi9l7zwtRpWqNFmBufwaHEa8OmWcXSd5OAflQXTM0RyVKKAbyLrpWS4
	 DWcy8bYiHQgE1ZgKbdjoGKXYgcu8Y66g+dtlwwcOpVZQ5CBN82mmCTdn7IBL93gUW3
	 01D5sZQryyIxC58ZNgUCTY5OQ77R6sqIyA7W7m6kkdmbrInBCDGriJ1+ujR4wtnZoK
	 UhUY67ydQP63A==
From: Kalle Valo <kvalo@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ben Hutchings <ben@decadent.org.uk>,  linux-wireless@vger.kernel.org,
  =?utf-8?Q?Martin-=C3=89ric?= Racine <martin-eric.racine@iki.fi>,  Brandon
 Nielsen
 <nielsenb@jetfuse.net>
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
References: <ZuIhQRi/791vlUhE@decadent.org.uk>
	<172666715574.3996465.3960547479597216434.kvalo@kernel.org>
	<20240919082809.GA13162@wp.pl>
Date: Thu, 19 Sep 2024 11:40:28 +0300
In-Reply-To: <20240919082809.GA13162@wp.pl> (Stanislaw Gruszka's message of
	"Thu, 19 Sep 2024 10:28:09 +0200")
Message-ID: <87wmj8aver.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislaw Gruszka <stf_xl@wp.pl> writes:

> On Wed, Sep 18, 2024 at 01:45:57PM +0000, Kalle Valo wrote:
>
>> Ben Hutchings <ben@decadent.org.uk> wrote:
>>=20
>> > iwlegacy uses command buffers with a payload size of 320
>> > bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
>> > describes the default buffers and there is no separate type describing
>> > the huge buffers.
>> >=20
>> > The il_enqueue_hcmd() function works with both default and huge
>> > buffers, and has a memcpy() to the buffer payload.  The size of
>> > this copy may exceed 320 bytes when using a huge buffer, which
>> > now results in a run-time warning:
>> >=20
>> >     memcpy: detected field-spanning write (size 1014) of single field =
"&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:317=
0 (size 320)
>> >=20
>> > To fix this:
>> >=20
>> > - Define a new struct type for huge buffers, with a correctly sized
>> >   payload field
>> > - When using a huge buffer in il_enqueue_hcmd(), cast the command
>> >   buffer pointer to that type when looking up the payload field
>> >=20
>> > Reported-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
>> > References: https://bugs.debian.org/1062421
>> > References: https://bugzilla.kernel.org/show_bug.cgi?id=3D219124
>> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>> > Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcp=
y()")
>> > Tested-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
>> > Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
>> > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
>>=20
>> Should this patch go wireless tree for v6.12? As this is a regression I =
think
>> it should.
>
> It's not driver regression per se, just false positive warning when built
> with CONFIG_FORTIFY_SOURCE. But it should go to 6.12 IMHO as fix for
> the warning.

Thanks, I'll then take this to wireless tree.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

