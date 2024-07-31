Return-Path: <linux-wireless+bounces-10724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A39429A0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2218B20DC1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CD1A8BF7;
	Wed, 31 Jul 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9SkYUnF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DD18CBED
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415913; cv=none; b=T6zPkQnCeLcBNKhQ3qSfA4BqOuaQzNA0hvkCBDdeInHCQeANvCcnruYpMN5CvbvUf+Jdp0wnBJUJFx4NU71+gg7kYNcptctV+CrVbpxVZ2mg4C9s5L8wKdAgfU4j4PhMZgQZ28R9fFZbQd7mQ2ETpoVMd64mr7NADKTaz69sBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415913; c=relaxed/simple;
	bh=eq6ZbUjCp8yGbWbk+wUwlkkjoHUI0f5wvuxs5k0tigE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DDdazQmEs7PaYZQD8ELWkCfx6MM5VTnvGNqJW0SOEr+ybdCI+HtjmcOvuAB6OQgF6U0oh8+0oI9S6yBBsnvXOkzn9ihKGLtAhQMZvkC5BAzC8CGECIp2fOJFkaAUHOFC53mLUOUpGIEjig6JCqpUvCLkTG9ezYpMgZXNR0KUxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9SkYUnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6D7C4AF0E;
	Wed, 31 Jul 2024 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722415912;
	bh=eq6ZbUjCp8yGbWbk+wUwlkkjoHUI0f5wvuxs5k0tigE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=V9SkYUnFJq677ztCX6/2lYBJMv7eaeT/1xWxCqFjlEKd/ysfKPMBllkmI1H4KNjJ0
	 I5pTbW2SziHqGgW08Isvty/RSlpW4iVq+v50h1UH08X3ZghSlCCEj9xjEys7dBlF0J
	 msz2YMvJ8BS0AhOT8za2h1To27sK0t5qtjyYS/pdo5Cx7flqCAaSCvWhXTGYBD6ELN
	 NppBFfdaLbY9xNf+8LqsfCuZIPN652buyc/I2yOEZddGSSQtvUpLJpSkYy4/m07jl5
	 O3YTh39sLPPD02RLDU9wx4VTHwu5gbM2oqBez6W/XhE1Xn1mQYHrddjBuzyyrrnhSy
	 uv/dVhcZNsItQ==
From: Kalle Valo <kvalo@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Felix Fietkau <nbd@nbd.name>,  Sean Wang <sean.wang@kernel.org>,
  deren.wu@mediatek.com,  linux-mediatek@lists.infradead.org,
  linux-wireless@vger.kernel.org,  lorenzo.bianconi@redhat.com,
  mingyen.hsieh@mediatek.com,  sean.wang@mediatek.com
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
References: <20240711175156.4465-1-spasswolf@web.de>
	<CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	<adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
	<4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
	<2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
	<65621cad9a22df881745e9333a5c3696bdbb8df3.camel@web.de>
Date: Wed, 31 Jul 2024 11:51:49 +0300
In-Reply-To: <65621cad9a22df881745e9333a5c3696bdbb8df3.camel@web.de> (Bert
	Karwatzki's message of "Mon, 29 Jul 2024 13:12:15 +0200")
Message-ID: <87frrqkkpm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bert Karwatzki <spasswolf@web.de> writes:

> Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
>
>> On 17.07.24 16:38, Bert Karwatzki wrote:
>>
>> > So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change. The early
>> > return in that case avoids the NULL pointer and mvif->phy has its usual value
>> > again on the next call to mt7921_ipv6_addr_change so Wifi is working again. I
>> > don't know how this could happen but perhaps you have an idea.
>>
>> This change should fix it: https://nbd.name/p/0747f54f
>> Please test.
>
> The BUG is still present in linux-6.11-rc1.

I'm not sure what's the status with this. There's one mt76 patch going
to v6.11-rc2:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=6557a28f3e3a54cff4f0dcdd1dfa649b26557ab3

But that looks to be a fix for a different problem, right? Felix, are
you planning to submit that 0747f54f as a proper patch? I could then
take it to wireless tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

