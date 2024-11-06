Return-Path: <linux-wireless+bounces-14981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FEC9BEB2C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 13:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460261C215E4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062791F666E;
	Wed,  6 Nov 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ6UKVKG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AEE1E103C
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896890; cv=none; b=ii/4iysuMzMYcLNi2x45RMmslMtztAlUtxi4ERKOV0PaVT9JVoGhSq8bAHo6l37K1Tnt2rGby6AFRDkWVvsw+uFfd0gXPwqNDTIJq659DMwULLaidMqtjgx7nUnjqfXGzeSpvmb/dKZZFQvi+rXm5hnZZo0Aho5uar+KFiBpZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896890; c=relaxed/simple;
	bh=Z/s9/b6M32QTZka+1X3nQVBIL9Rx7UuOY/sD8it5hWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFBrDh3ANP9LXhb7tn5ZVCbh+2V7XY/BJw3ZFoEGbTnvRZJupQDGj4TZ7TQmME/O+bUxocQMtG1sQKsV2tahgOyEQRHIu0kNrH9f7j/l8cetaNRHgQmYD8ZVfwUucVz0BjpXEKwoDWMoTba0GSiWZ1MUjX9xzRYd9zkxgXpoDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ6UKVKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F66C4CECD;
	Wed,  6 Nov 2024 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730896890;
	bh=Z/s9/b6M32QTZka+1X3nQVBIL9Rx7UuOY/sD8it5hWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LJ6UKVKG4TxFA2+zkYY5iFAMTVTlxTpfu6wLpj1VcUkrNogJbXnBYANDLoJZ5J7sV
	 R70kmmRtVuZLGsXCiUu2EdcIuzxr0158AsEQm6BCtrnvoHnTicu4S9uXxjr3ptgEq0
	 2q0M9eXIjEC0KNKNaA8MY8V4iPhRW5+53qhcQhZX501Pm3rq0yEgDWiIIsWhWtTI6R
	 CptzstyT5Yzbz24qlEKTJXR9MM7Piis4aE5wX7kejQZXhd9LAWLY1eG4V5yYpv/0cW
	 +GRIB/I9lD7KnSd076o1dvB6rWz7Le2RjjGI1HIf8MVm55cYOocexLyGQnGBf+HEdQ
	 hEx+w1mICS1xQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7B6A0164C448; Wed, 06 Nov 2024 13:41:27 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Sven Eckelmann <se@simonwunderlich.de>, ih@simonwunderlich.de, Issam
 Hamdi <ih@simonwunderlich.de>, sw@simonwunderlich.de
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 mathias.kretschmer@fit.fraunhofer.de
Subject: Re: [PATCH v2 2/2] wifi: ath9k: Reset chip on potential deaf state
In-Reply-To: <865447434.0ifERbkFSE@ripper>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241106090439.3487958-1-ih@simonwunderlich.de>
 <20241106090439.3487958-2-ih@simonwunderlich.de>
 <865447434.0ifERbkFSE@ripper>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 06 Nov 2024 13:41:27 +0100
Message-ID: <87pln87cw8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sven Eckelmann <se@simonwunderlich.de> writes:

> Overall, the proposal from Toke seems to be a lot better integrated in the HW 
> check style which was introduced by Felix in the beginning of 2017 [1].
>
> At the same time there was a proposal by Felix [2] - which diverged too much 
> from our original patch (and as a result caused too many resets) [3]. I would 
> therefore propose to check Toke's version and test handles the problem 
> correctly.

Yes, agreed. I did actually write up a commit message for that, let me
send it as a proper patch...

-Toke

