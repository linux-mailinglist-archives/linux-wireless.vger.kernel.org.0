Return-Path: <linux-wireless+bounces-10989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354A948884
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225491C21E52
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D215C12F;
	Tue,  6 Aug 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV91jZcl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129D1547DC
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920098; cv=none; b=bpaHYd3Dg0Wzga8O+U2PuakeKd5RcRAyjaLkc+oFqf0ODEhUW5grmGNRFmp/bprIeHVdMyy68l7haLP9jA1Uqp9kdgr+9OLTBDje9iIjr1iRio0ZY8LyHceqfUnSkbnuqHQVZfd2eiERrreVzr6LCb2F+eqZ0bJjhZlmu+XFw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920098; c=relaxed/simple;
	bh=G4b3lV3v+PsDorKidJcIMxIpUpukpP/iC9OcBvSlY9Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iltjAzTKyPlafZAFIBdkPRCvBYdK/7m8d7AqOHhnq1j2p5TOVLQ/yLdj44NO9zbugqDy6kv5hdEJiuD8PFyjoKeJtypsGQYKAwJmQPhGm2HTv6QZW0cwON/eZZKlw35Kn6wOqT67E1HA02N17vNjaj5ZhWjU2A5Ly05jqzfMsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV91jZcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E44C32786;
	Tue,  6 Aug 2024 04:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722920098;
	bh=G4b3lV3v+PsDorKidJcIMxIpUpukpP/iC9OcBvSlY9Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YV91jZclZZFVWbIQoegN8a3Fh0Kw/xtqcEoT8MWoiRnN4gOClvICDIhAH+eyKf49u
	 dX0DuGzByGGne7+r8zfS6WINrem31clkVlZ1FqWyy2CqoR2XVaAiqJ8qItnjk8Oh1o
	 cS1jnrUUdCXa+mm0JLDq9LnD8U349hQAfRuONHXFDxpaIQXqpESC2l+9KhGNSDAsGn
	 +anoS1S80vYSNJV5rxNEJ6UwZ4+uQ+MmegZcWboiTK0CFPk3QJUay+bluMDCl/t1d+
	 mpBiPZC0KYdH49rJWlU1z3ytxJnkHFrOBmhkNK7KzMPGi4yWbax8srkzyhtHjEqhp5
	 FV/JnxqlX2L9Q==
From: Kalle Valo <kvalo@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Wang Ming <machel@vivo.com>,  Minjie Du <duminjie@vivo.com>,
  linux-wireless@vger.kernel.org,  dan.g.tob@gmail.com
Subject: Re: [PATCH] wifi: ath9k: Remove error checks when creating debugfs
 entries
References: <20240805110225.19690-1-toke@toke.dk> <87ikwepwv1.fsf@toke.dk>
Date: Tue, 06 Aug 2024 07:54:55 +0300
In-Reply-To: <87ikwepwv1.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Mon, 05 Aug 2024 21:56:18 +0200")
Message-ID: <871q32jlnk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> We should not be checking the return values from debugfs creation at all=
: the
>> debugfs functions are designed to handle errors of previously called fun=
ctions
>> and just transparently abort the creation of debugfs entries when debugf=
s is
>> disabled. If we check the return value and abort driver initialisation, =
we break
>> the driver if debugfs is disabled (such as when booting with debugfs=3Do=
ff).
>>
>> Earlier versions of ath9k accidentally did the right thing by checking t=
he
>> return value, but only for NULL, not for IS_ERR(). This was "fixed" by t=
he two
>> commits referenced below, breaking ath9k with debugfs=3Doff starting fro=
m the 6.6
>> kernel (as reported in the Bugzilla linked below).
>>
>> Restore functionality by just getting rid of the return value check enti=
rely.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219122
>> Fixes: 1e4134610d93 ("wifi: ath9k: use IS_ERR() with debugfs_create_dir(=
)")
>> Fixes: 6edb4ba6fb5b ("wifi: ath9k: fix parameter check in ath9k_init_deb=
ug()")
>> Reported-by: dan.g.tob@gmail.com
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
>>From the bugzilla entry above:
>
> Tested-by: Daniel Tobias <dan.g.tob@gmail.com>
>
>
> Kalle, if you could also update the reported-by to include Daniel's full
> name when applying, that would be awesome :)

Will do.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

