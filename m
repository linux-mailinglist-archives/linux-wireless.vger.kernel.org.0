Return-Path: <linux-wireless+bounces-10871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9A9464C3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 23:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087BC1C21739
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A35338D;
	Fri,  2 Aug 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blRMLkd+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429344D8D1;
	Fri,  2 Aug 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632611; cv=none; b=Bl5/+lnP7DvOdcFfH13nKNbVw1c0EzCpepIW4XbS7qRveDKcLgEPkdOPW7tq3lMMcCgtnT6cOyVpLiH0stutYkyYPlWqRcd/ZmD1jFLll+rFI3j5JZ8Px6naJYJFp+eYVo9ggpYZloSmbfc6fHz+4WGZnXDRiRXbhrFb0ZFnTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632611; c=relaxed/simple;
	bh=NSWEWY7m4rem5BURAF0Rbqz0Q/zr+jn6KSf12D3cXng=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ijWwtjxqaYbBREbNPw+1Knf+xTgBww0RA6VejOwvPheS1hFjeDI83RBxzeoYn0lK9Aim1qByk7ubxHsjegq2F9VbpWqP/VInWrNnsgpDI2W7CuwtxKXMZX3aACthPw+lAJF/6NlMziD0EfKBiTg5DXyABiWL8cEWNoggv1IY1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blRMLkd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBB7C32782;
	Fri,  2 Aug 2024 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722632610;
	bh=NSWEWY7m4rem5BURAF0Rbqz0Q/zr+jn6KSf12D3cXng=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=blRMLkd+UE9YesW6uswPYfydf3nURkuVfABqI26kfADxkZRSfEJnlU4wFklUxuXrg
	 ugv9jJElyCZBIjVP2C1+OIarq8ZtenIulvlbKYA7zwhMyBCmEycRIJt6AvEPW1EfW+
	 zzTD++eLNYqNHjxE9vL4ZKsIrTuCVuEVvNc3OkhbnnQrLPoW/uRDyeTQyQ+D4FVO4R
	 qeWAvBj7/gklJjIR6yYtwnjS0c9Gh4/4uV8J7zhu76YgtmerzRWk7H8Uup/rd0GTkf
	 tNU8LvOoYX8i55r8CE2hXBhgHfGBls2oPiT+iYnqQ2r8FCAp05eKBrzECgTXlgxj3j
	 so2/exmaM9V1g==
From: Kalle Valo <kvalo@kernel.org>
To: Mark Esler <mark.esler@canonical.com>
Cc: color Ice <wirelessdonghack@gmail.com>,  stf_xl@wp.pl,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
    Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
References: <CAOV16XESCK0-sMENJFxvWiKqogBJ4PQwA2DvJBvWq-g+NtV8ow@mail.gmail.com>
	<ZqyWpovXcaAX2f5c@aeon>
Date: Sat, 03 Aug 2024 00:03:26 +0300
In-Reply-To: <ZqyWpovXcaAX2f5c@aeon> (Mark Esler's message of "Fri, 2 Aug 2024
	03:19:50 -0500")
Message-ID: <87wmky7i3l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Esler <mark.esler@canonical.com> writes:

> On Fri, Aug 02, 2024 at 03:57:47PM +0800, color Ice wrote:
>> Dear RT2X00 driver maintainers,
>> 
>> We have discovered a critical vulnerability in the RT2X00 driver. We
>> recommend urgently submitting an update.
>> 
>> *Vulnerability Description*: When a PC is running Ubuntu 22.04 or 24.04,
>> executing our proof of concept (POC) can directly cause a null pointer
>> dereference or use-after-free (UAF). The systems we tested were:
>> 
>>    - *Description*: Ubuntu 22.04.4 LTS *Release*: 22.04
>>    - *Description*: Ubuntu 24.04 LTS *Release*: 24.04
>> 
>> We tested network cards from the RT2870/RT3070/RT5370 series, which all
>> belong to the RT2X00 driver group, and all were able to trigger the
>> vulnerability. Additionally, executing the POC requires only user-level
>> privileges. Debian systems are not affected.
>
> It is unclear if Ubuntu is the only affected distro.

It's also unclear how this works as there's no description about the
issue. I'm not going to run any scripts and I don't know how python
usb.core package works. I guess it needs root privileges to be able to
send these USB commands?

If this really is a security vulnerability, here are the instructions
how to report them:

https://docs.kernel.org/process/security-bugs.html

Also adding Greg.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

