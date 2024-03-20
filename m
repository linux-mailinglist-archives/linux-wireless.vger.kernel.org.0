Return-Path: <linux-wireless+bounces-4954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB8880E2A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CB01C22ED9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7939FEB;
	Wed, 20 Mar 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN+S9WGO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90639FC3
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925159; cv=none; b=m0p53f2dEMmC2QN7ocJbFBfNlH9pEK2W5msumqIxdVdQOvvMbkj8TjUU7um2sjkfcwCj61HydAWy1JMFtc82dkAEnxs4jiwbIEQy6R8LhDHQXDJpL9Rx+Sq83Rv6t8COtc7ASdTAv8jx9skbXvg8HItzekcXKSD4ox7bqjD6Uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925159; c=relaxed/simple;
	bh=u/VzySYQ1Rmdd+HxMwxGd5Tt1tOaSJ+SqoOW598AaYI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nkww2eGyhJ9GGxOg2WasII7Z0OrnALER7u288sOYbJ+VP55BAuvTslz06Fx10Iqh2+lA7RG6Y8khzQ9znJpf+dKXclTXCp5nOi2h4Ftgrktvkwfd5aAJBTxsqyeG8ImUvdVyEoEro6YgPd7k4LTGha7XDQQs8kG+VAirBB/PjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN+S9WGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB3FC433F1;
	Wed, 20 Mar 2024 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710925159;
	bh=u/VzySYQ1Rmdd+HxMwxGd5Tt1tOaSJ+SqoOW598AaYI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tN+S9WGOU0nrunB2baggcG4CrB1DudoUOqRDX3FSCpXLsemrDfAbRvjhih9QRT1XB
	 jz9nBohWXforShjcapUvfJOXn3o5ueB/luksZf74v8vBBr+VfSJMI+px+9KuqMXUma
	 ruwxVrDg5gJfWRCLUY0zmvyZayP0RWVHC0l4HYtMbYnRr052crhHgR/rq/xozBeH0b
	 1QZJBFctzUo7qR/eo5S+AwNImci73V2gjaGRFJdtpbZpyBDpCuAcyNIaZLDEutF2Lj
	 UnJnkX74fKnzv1WhsPUgxd2nKjBvElu4Xl55AuprZ4agW1kvAyEI6F43eN+MxBRkFJ
	 0sk3ZjgMF3d+w==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "fiona.klute@gmx.de" <fiona.klute@gmx.de>,  "Jes.Sorensen@gmail.com"
 <Jes.Sorensen@gmail.com>,  "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>,  "rtl8821cerfe2@gmail.com"
 <rtl8821cerfe2@gmail.com>,  "Larry.Finger@lwfinger.net"
 <Larry.Finger@lwfinger.net>,  "martin.kaistra@linutronix.de"
 <martin.kaistra@linutronix.de>,  "martin.blumenstingl@googlemail.com"
 <martin.blumenstingl@googlemail.com>,  "brianwitte@mailfence.com"
 <brianwitte@mailfence.com>
Subject: Re: Git tree to manage Realtek WiFi drivers
References: <503a9152324a817c251193ee486e1bbcb48d2fa8.camel@realtek.com>
Date: Wed, 20 Mar 2024 10:59:15 +0200
In-Reply-To: <503a9152324a817c251193ee486e1bbcb48d2fa8.camel@realtek.com>
	(Ping-Ke Shih's message of "Tue, 19 Mar 2024 01:33:27 +0000")
Message-ID: <87edc5b7oc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> First of all, thank all contributors (Cc'ed) to add new features and
> chips support of Realtek WiFi under drivers/net/wireless/realtek/.
>
> To balance load of maintainers, I will start being the maintainer to manage
> Realtek drivers [1] by an new git tree [2] that I fork from wireless-next,
> and the main branch is rtw-next. For submitters, all things are the same as
> usual except to codebase.
>
> Also welcome to help review patches from other contributors. That is
> really helpful to get these drivers better.

Ping-Ke, a big thank you for starting to maintain the rtw tree! Not only
that it helps me, I suspect Realtek driver development will be faster as
I'm not the bottleneck anymore.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

