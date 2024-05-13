Return-Path: <linux-wireless+bounces-7576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C70558C3B8A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F83B20A76
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE651016;
	Mon, 13 May 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2m5M+jK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B750291
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582574; cv=none; b=iGvwtfbR6Ns2YY9J6eHJxL/IqieQ8m3cNCVIcDnH9KTX9XGCP9z4sQCFla0pwOyVTRHifXjdiGZpERIyBKyfRVyAwjACdTPeFI5iSHuvBVyK3zNB30jLu+d8AMCXrY7c6h69NZHSlC9nBUsSTTIWT8m58Urqu22dLSsgGUIrTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582574; c=relaxed/simple;
	bh=kePK/3SjYEg3uR+1Wiz6WrVO0FcONxm7h8aC3VJdIE0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kbLyPvbkHQEPjGb7Uz7pakl22IVuJEVB+lKAqfKAlUK5Uz+o/DX3MyJMX7rgR60IUjl8wdNN5ptHD7ygJiRr1Vf6Y0e8/bLB5fph+7Aq7bxhtO5WJrQ92UYnxrkeIVdtgsiQGd4oXeRHMk5jjR1o6MgjpzD5tpdOqM0MB39jyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2m5M+jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882E9C113CC;
	Mon, 13 May 2024 06:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715582574;
	bh=kePK/3SjYEg3uR+1Wiz6WrVO0FcONxm7h8aC3VJdIE0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=f2m5M+jKbF0dGRQWWpiruJ7FDdhFvMaY8QthfzZVVu8I23aLu6Ok8I8MYvKnNBAvP
	 DqHziv1AbCBB1fYtt7uFfboRe8UDkbGZlqFcLCfG4NT4uOaHFSs+cACXzajqnHyglv
	 nEI3cvWqWxycGFA1Gt080B/I9rc5YW6f9lyDwv31cAft+c/Iic85MqQXzlq8qoabcx
	 uBinz1iT7hQcq9X3suyGJHvGqNG7ZuhkmTQ+Oi58J5xCMaylDBKbiO5Z8UESQ0VHCu
	 YkyGrGH+8XhbyowLNz+mwPPG9ADbcrvaQwn4JG2XSGSTP2TCasEIsxboJ5cwQLub2R
	 m16p4Ymp/33Sg==
From: Kalle Valo <kvalo@kernel.org>
To: <michael.nemanov@ti.com>
Cc: <linux-wireless@vger.kernel.org>,  <sabeeh-khan@ti.com>
Subject: Re: [RFC PATCH 00/17] wifi: cc33xx: Add driver for new TI CC33xx
 wireless device family
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
Date: Mon, 13 May 2024 09:42:51 +0300
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com> (michael
	nemanov's message of "Sun, 12 May 2024 21:32:30 +0300")
Message-ID: <87cypqjjpw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<michael.nemanov@ti.com> writes:

> From: Michael Nemanov <michael.nemanov@ti.com>
>
> This series adds support for CC33xx which is a new family of WLAN IEEE802.11 a/b/g/n/ax
> and BLE 5.4 transceivers by Texas Instruments. These devices are 20MHz single spatial stream
> enabling STA (IEEE802.11ax) and AP (IEEE802.11n only) roles as well as both roles simultaneously.
> Communication to the CC33xx is done via 4-bit SDIO with two extra
> GPIOs: Enable and Interrupt.

I didn't review this yet but decided to do some build testing and it
doesn't even build:

drivers/net/wireless/ti/cc33xx/debugfs.c: In function 'cc33xx_debugfs_add_files_helper':
drivers/net/wireless/ti/cc33xx/debugfs.h:37:37: error: 'cc' undeclared (first use in this function)

I also see some warnings from GCC. I pushed the patches to a pending
branch so most likely you get reports from kbuild bot:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/log/?h=pending

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

