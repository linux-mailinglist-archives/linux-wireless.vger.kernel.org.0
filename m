Return-Path: <linux-wireless+bounces-4171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B3486AB8D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820C1B22F16
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C237165;
	Wed, 28 Feb 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZEhLunl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817E37153
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113469; cv=none; b=PjszqtWXnKJ61g/OYpqQlJysbSvHq9bZ2QYqm1pWxvSPAaPhaWsCv95rE7+3/HI2obYfiYROj6+0/t/cf0r8bM1m7rDxs25e38UBMBwHlGjxr6EQeKOXZvZ5AWveMiomYLbYINNfOqhrDGrm+rpt5h2AqkFI+nM3BpkmF5ws8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113469; c=relaxed/simple;
	bh=OqKzQIRL58M1riU+dyWiAQz0iEAfhi7wWJihRorkkk0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bAhZ+vsQxDkfnwl9QWQQqmQrIXdyrIJpXHt1axhuzI2n4AgAEagE/+rZu/gYL4PCXkhihH4jiaCHuVzAop+gDftHAQgWNe1XV9khNVrPnM1IzAkcfpgmVFtDVWDUVrv7LO2eF8ZUppffyRjoLEHrjXecdMo3JYCL7ns/orOXArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZEhLunl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D8AC433C7;
	Wed, 28 Feb 2024 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709113468;
	bh=OqKzQIRL58M1riU+dyWiAQz0iEAfhi7wWJihRorkkk0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HZEhLunldBkTtKlTY2yU5x+nty4Ne/rRCiUvlUl9MofpuSxXoTsGQkqPODAep/6DF
	 9tA3A9o+Za85z0BJVEy5ZfLEw6xrk4TPu7ellcrfahsb6WF3ORsm41qCXTbGwhrJj4
	 DEIB2xjiHaKpzfWn8alNVHk4C7vFgriz5tGQa02HWIE3TuwF2Dqc0VjpgUCXONfnea
	 LGJOjbdPLCzOZgveAXSexHONsUd3Y0coNAxLMm2tPuSWtxAi3gE/MdrYo/LsRJa0LU
	 mfpDBQVhN1uFv5TLvU5d6jGdZjgL/453aX/jmkzoFYKyOWuo0+kiIHAtKvqkImalpJ
	 7wkRb+Gfe6yPg==
From: Kalle Valo <kvalo@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] wifi: rt2x00: fix __le32 sparse warnings
References: <20240130151556.2315951-1-kvalo@kernel.org>
	<20240130151556.2315951-5-kvalo@kernel.org>
	<87il3aaqoz.fsf@kernel.org> <20240203123528.GA170353@wp.pl>
Date: Wed, 28 Feb 2024 11:44:25 +0200
In-Reply-To: <20240203123528.GA170353@wp.pl> (Stanislaw Gruszka's message of
	"Sat, 3 Feb 2024 13:35:28 +0100")
Message-ID: <87v8689b46.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stanislaw Gruszka <stf_xl@wp.pl> writes:

> On Wed, Jan 31, 2024 at 09:48:44AM +0200, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>> > Sparse warns:
>> >
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39: warning: incorrect type in assignment (different base types)
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    expected unsigned int [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    got restricted __le32 [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43: warning: incorrect type in assignment (different base types)
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    expected unsigned int [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    got restricted __le32 [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43: warning: incorrect type in assignment (different base types)
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    expected unsigned int [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    got restricted __le32 [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43: warning: incorrect type in assignment (different base types)
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    expected unsigned int [usertype]
>> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    got restricted __le32 [usertype]
>> >
>> > rt2x00 does some wicked casting here so no wonder sparse warns. Clean that up
>> > and use cpu_to_le16() to avoid any warnings.
>> >
>> > Compile tested only.
>> >
>> > Signed-off-by: Kalle Valo <kvalo@kernel.org>
>> 
>> Stanislaw, sorry somehow I corrupted your address but fixed it now. Let
>> me know what you think, patch here:
>> 
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240130151556.2315951-5-kvalo@kernel.org/
>
> If I analyse it correctly, patch is not ok on Big Endian machines
> where we do bytes swapping.

Ouch, thanks for catching this. Johannes sent a new version:

https://patchwork.kernel.org/project/linux-wireless/patch/20240223114023.ce0c714124e9.I2b5710b761f63522574fbe7654d37151c31e0b77@changeid/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

