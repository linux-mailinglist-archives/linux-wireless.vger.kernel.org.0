Return-Path: <linux-wireless+bounces-11747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E2959F4C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5585A1F22C00
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0776E1AD5CE;
	Wed, 21 Aug 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilMiZ4j+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3B19992E;
	Wed, 21 Aug 2024 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249237; cv=none; b=vCE06c6/6K/NKmTp32bz/gduYZWi1cbzbrkjBDcepCanF1zDZpfB8js/gouH/91DpDIk2I0eJ/aUDU7pZUHRPZcLlS8T84BMkFPRJYAsxFIwKpK4MOpO8pDo5rRxMmvPtZRMg1Ya3NrsHDyDUbuqanbH4zwEMG6Aet0qLa0AFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249237; c=relaxed/simple;
	bh=rwV2Ym9YJJlsH5AituA1MObz8M1TbPmkdjV1mr25zv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kGCxpyCXhOOntpBC9TAkWQRx0tPWW3GWjXUTEFfnw8YwDtveFS29nkSqK/V7QO88DdEl5UqAg+0ZFl+wG3PFJqIovJ3OdfGw8fG/8NrTZyQ8qHl/FSPMcURhB5AoYYs8vZzyWie0oQdIA5nbHIJ3RNzo7YFeX4PNdP1FgJhPiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilMiZ4j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049DC32781;
	Wed, 21 Aug 2024 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724249237;
	bh=rwV2Ym9YJJlsH5AituA1MObz8M1TbPmkdjV1mr25zv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ilMiZ4j+7uU0dcxrFtSKnC/E4rsgwZDvcSlDQD9hVJdjPbBs0e+epISz3ppyBME98
	 t/p/DFvnvoghTL70JLY4aQbtjnhz4Thq4lyknQqs4Ihj2DV5BKjKPWIIMWT2hVOL25
	 cUfjB+0Us1he+GzthfNlJZiYMqp86NWI40ilE4753rvufnwppqdAxG+FhaXQMtiIVx
	 PAW2CUm4EdpOsyryl5HIKzXh4MrnuERkHM62e1yx05rZmgJ9OS13O9WIPjYCAFX9ov
	 lsiRIaAb5ygyLfF59tj+2KIDpIJQDAg/FC7HRx/blrgfThFR6+rjPF5gm8/WO4OFTD
	 5V8SxSyXwSgpw==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH 00/31] wifi: mwifiex: cleanup driver
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
	<87o75nw0oh.fsf@kernel.org> <ZsXLrEXiPke1RUw2@pengutronix.de>
Date: Wed, 21 Aug 2024 17:07:14 +0300
In-Reply-To: <ZsXLrEXiPke1RUw2@pengutronix.de> (Sascha Hauer's message of
	"Wed, 21 Aug 2024 13:12:44 +0200")
Message-ID: <87bk1mvujx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Tue, Aug 20, 2024 at 08:42:38PM +0300, Kalle Valo wrote:
>> Sascha Hauer <s.hauer@pengutronix.de> writes:
>> 
>> > This series has a bunch of cleanup and bugfix patches for the mwifiex
>> > driver.
>> >
>> 
>> [...]
>> 
>> > ---
>> > Sascha Hauer (31):
>> 
>> BTW 30 patches is a lot to review. A good rule of thumb is to have max
>> 12 patches per patchset, maybe a bit more if the patches are small.
>> Splitting this into two patchsets would make it a lot more pleasent for
>> the reviewers.
>
> Ok, I'll split up this series into smaller chunks. Be prepared there are
> more to come

Awesome, keep them coming! 

> this driver is really full of cruft...

Honestly I have not not looked at the driver in detail but that's what
everyone are saying. So I appreciate you doing this. And I wish NXP
would help you in the effort, this a great way to learn how things work
in upstream.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

