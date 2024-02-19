Return-Path: <linux-wireless+bounces-3766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E7859E24
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683CE1F210C4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7720DD9;
	Mon, 19 Feb 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJoCqymt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A120320
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331089; cv=none; b=WNPB55I6c7fsKchJn0twB9l7tH2lSyMtGDtv4riasiewpFymXu0pwzhAmH1qMyvxQKAKGcGAxCnyMTK0lb7Bs1LJ3VL9S4lvT/Lx+M2Jc+o4TBfYgrTLz0oBGiUXOJocVA+fE+EZNPtJgZfHgDvZIBm3Tr8NDLIVLajRBIO8690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331089; c=relaxed/simple;
	bh=Y2u32DfU8dXkywLAO8ZAlP6VP7FsCfhc9CQaIY9dxbw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=a5uVRoxhnLD1mDuFMhj2PGfvWyopmh1LKQY3ihc7CxexMI0tT+JdQOPFa+vl/bWtW2gL3uVHunp2yDKIhdHyKwcxg1WQa2O7J6M0DcX6/55wT+1elX2gwFdqa1acb1+yfLwgcTotqQDMoQhJi0Ma58hOcfIBuikit9WpSRt2wIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJoCqymt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4705C433F1;
	Mon, 19 Feb 2024 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708331088;
	bh=Y2u32DfU8dXkywLAO8ZAlP6VP7FsCfhc9CQaIY9dxbw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HJoCqymt/nJGp/4irATToAxMH7KQzaZvmzf6FTCrOCJSQ2q0f3+ERK1d+vBTIwNef
	 +VkY12I4guHKYi1P1HCc/Ao6JS6wcctWCTCccbfkD10Z0wnqxj/+AP31uXsHuqiKhV
	 mMri+4GdDK+Q3vTabFYc8wsUyM6SJSvYfQYD+AWdIZ0iXrV34CwK0lS9DUVwXnmCsA
	 riAwXSR+koxNH922WmpUGA5LBHhbRP9IEBWwe8IHAjqWUDl+5X43hoL7N4iPMTwvBX
	 CpTTFy2wiZziZpVi79TZW7amIqV7arIV7REwfFRGiJ4apaQ6WROQ2xD10dqAT65vOT
	 3WuP/rDqaRDYA==
From: Kalle Valo <kvalo@kernel.org>
To: Brent Roman <brent@mbari.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
  linux-wireless@vger.kernel.org,  martin.blumenstingl@googlemail.com
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa RockPi-S
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
	<9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
	<f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
	<b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
	<878r3hc6hy.fsf@kernel.org>
	<42772df2-32b3-2b37-045d-b528a752bef7@mbari.org>
Date: Mon, 19 Feb 2024 10:24:45 +0200
In-Reply-To: <42772df2-32b3-2b37-045d-b528a752bef7@mbari.org> (Brent Roman's
	message of "Sun, 18 Feb 2024 23:43:19 -0800")
Message-ID: <874je4dfoy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Brent Roman <brent@mbari.org> writes:

> Yes, that's all true.=C2=A0 However... Random MAC address assignment tends
> to cause devices to be assigned a different IP address on each reboot.
> This often doesn't play nicely with port forwarding.

Sure, I wasn't claiming that using random addresses is the perfect
solution. But you could also set a fixed random address from user space
(hopefully that works with rtw88).

> It's difficult to "prove" the RK3308 cpu serial numbers are unique,
> but they should be and the few I've tested have been.

Please take into account that rtw88 driver can be used with all sort of
different CPUs, not just RK3308. This is why I pointed this out.

(please don't top post)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

