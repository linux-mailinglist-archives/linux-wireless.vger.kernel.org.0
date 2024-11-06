Return-Path: <linux-wireless+bounces-14977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2719BE570
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 12:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41061F24BAD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335711DD0F3;
	Wed,  6 Nov 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB7btOgM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECC1D434E;
	Wed,  6 Nov 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892178; cv=none; b=KVUK7FwJFetGNmH1j9TwRuFIZy6etDV++pfD92eRMhdfUsVyAQ4bdZfHsJGVUBOyOYCjTZ6XKTnC6vU2pCSf0DaL/CV2ugFohcof6uxKO4I3Vk/LZwdqY58WDd7Yt7HazFA7Y8UvRm6KCQIeoZUZskvnjwI+I2zgPO6wv8FPT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892178; c=relaxed/simple;
	bh=xXiA+fwcm0+kb/0qjLRbZF8bv0p/PuAEplcvU6cxXsw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LrdbZ/3JeihKxWkezE7QcSZZLo3evM20iQR2PEWF7/NJUJ++LRPfT8kWZr5BqCVa1P7tcYdGZ59OST3GKNNVcL/y5FPvRsU7juPO0Z7QdIQr+a9lixVYnTtPJhOvgAcUqCogeDtBO0gREmoVGN5NcwoPw22dfGezC+jBnZTx5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB7btOgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB59C4CECD;
	Wed,  6 Nov 2024 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730892177;
	bh=xXiA+fwcm0+kb/0qjLRbZF8bv0p/PuAEplcvU6cxXsw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bB7btOgMImW7cmMrSqlmHFSsYIoU3KRAVoiMSZC976giIFTcG2vaHa0SrQw2kJC38
	 5eu2zq325MhzhgH7GrM1xDrShGGLHolPFyIuT5Nwgo4FB8rQbE8VdwzZpzMbiJtqvu
	 Ha4dStLkb0m+3Afruwfx3kinFQTwqZlmYsWwDENBm+QnHRIT9wItEgDx3Gm1b5A5Fd
	 uW2V57uFpP+2PNdxv53xuD4G9rdPFtXDnpoVfN9/XmkYTjThAh3hDH9dbaLnLoio0S
	 tKMXWWdRw9mtyPjwEIjTzQWdMUTESOowhuNPum2Gb5yPo2nQbzm4fuywvLtpS/YNLJ
	 oYLHaR3LkX5ug==
From: Kalle Valo <kvalo@kernel.org>
To: "Alf Marius" <post@alfmarius.net>
Cc: regressions@lists.linux.dev,  "Andrii Batyiev" <batyiev@gmail.com>,
    linux-wireless@vger.kernel.org
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
Date: Wed, 06 Nov 2024 13:22:54 +0200
In-Reply-To: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com> (Alf
	Marius's message of "Tue, 05 Nov 2024 23:47:08 +0100")
Message-ID: <87wmhg61yp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(dropping stable, adding linux-wireless)

"Alf Marius" <post@alfmarius.net> writes:

> Hi,
> I recently installed Arch Linux on an old laptop (Fujitsu-Siemens AMILO Xi 2550) and noticed that:
>
> - when booting Linux from the Arch ISO (kernel version 6.10.10) WIFI is working fine
> - after installing Arch Linux from the ISO and booting (kernel version 6.11.5) WIFI was not working properly
>
> By "not working properly" I mean: 
> downloading small files or installing a few small packages was working
> ok, but when downloading larger files or installing larger packages
> with lots of dependencies, the connection would gradually slow down
> and eventually die.
>
> I reported this on the Arch Linux forum (https://bbs.archlinux.org/viewtopic.php?pid=2206757)
> and some helpful memeber suggested that this might be the commit that broke things:
> https://github.com/torvalds/linux/commit/02b682d54598f61cbb7dbb14d98ec1801112b878
>
> An Arch Linux packet manager (gromit) helped me debug this issue by building a couple of kernels that I tested.
>
> - https://pkgbuild.com/\~gromit/linux-bisection-kernels/linux-mainline-6.12rc5-1-x86_64.pkg.tar.zst
> - https://pkgbuild.com/\~gromit/linux-bisection-kernels/linux-mainline-6.12rc5-1.1-x86_64.pkg.tar.zst
>
> The first one didn't work, but the second (in which he reverted the commit linked above) did fix my problem.
> So, I guess this commit should be investigated by those in the know.
> Thats why I also added Andrii and Kalle to CC as they are listed in the commit message.
>
> My network controller: Intel corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection (rev 61)
> Kernel driver in use: iwl4965
>
> This is my first kernel bug report, hope I did everything right :)

Perfect report, thanks.

> I'm ofc willing to help provide more info and debug locally here to help solve this issue.

Andrii, any ideas? Unless we can fix this quickly I think we need to
revert commit 02b682d5459.

#regzbot introduced: 02b682d54598f61cbb7dbb14d98ec1801112b878 ^

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

