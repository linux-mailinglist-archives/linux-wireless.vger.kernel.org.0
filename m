Return-Path: <linux-wireless+bounces-15289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171759C83FB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 08:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23552843EE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9241632D3;
	Thu, 14 Nov 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN1ClnPi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E754163;
	Thu, 14 Nov 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569525; cv=none; b=nHLhcAthDTw+i6j3g0IurFDXXghKip3vGC8/5DfcZTMM/RgDj4EKXPreZFGB7GJy9NRAyfQKf+cJpH9LB2dq8XPqiYLF+kJn1Anq/wf03KoFXYdCwUa9PMh1tY97ujcDfwlZ0UmvIrLWPhLFzAqEt2mj2Duxctl/CfKFYZq3++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569525; c=relaxed/simple;
	bh=K3rkARdwpZRU4ELjDko9Yrc6XRCeMq8xxM0zFILucfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fDIyx/FRfYOcqpaBbaYT29Hcr+BadIjytqn4a0Ks5ZtOtgmWpA+r/sBj3WVe2QA0401YCjqb5+W8hYOEUnwt0Wd77/rjSeutRUA25KAnQxacnS7rOXp0KG9duStdwMqrCZKm09RrCJOGgwKiFy50pedcRL32l7IgYdnVQTRWl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN1ClnPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A96C4CECF;
	Thu, 14 Nov 2024 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731569525;
	bh=K3rkARdwpZRU4ELjDko9Yrc6XRCeMq8xxM0zFILucfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eN1ClnPi5rQJMyX2BWoNnyObQj078tdqzCmhr2ZJO4BI935E3SCbiEXvhBho1ClkC
	 r1A0oM+Cv9kc6raFarmbQQCgNeKUtpcwvWXOANK0gNx9WM6y0g0UgxOrVc5qrmhG/+
	 9mu9YJTXcq8odmJBkETSsHfK/7/BWmoNzM22QoZJTcQ3y5NC9I/sVtPFVmpTZuGID0
	 Rp/AflSFyAlrn6HdwmkaM4wwfPnlKxuPodrOLYK7H8dM/jjmsQIv1gxTacy7sEmKcj
	 w3GSrkLd3AATwKryKjqhY7CGs4yjr+dP5D0W1XZRe5zEfKHxTD4eC6n/2I8JAool4a
	 INVWexym3smdQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Alf Marius" <post@alfmarius.net>
Cc: "Andrey Batyiev" <batyiev@gmail.com>,  regressions@lists.linux.dev,
  linux-wireless@vger.kernel.org
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
	<87wmhg61yp.fsf@kernel.org>
	<CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
	<4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
Date: Thu, 14 Nov 2024 09:32:02 +0200
In-Reply-To: <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com> (Alf
	Marius's message of "Wed, 06 Nov 2024 20:27:40 +0100")
Message-ID: <87ttcauv7x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alf Marius" <post@alfmarius.net> writes:

> Good evening folks :)
>
> [Andrey Batyiev]
>> Hello everyone,
>> I've only tested it on my 3945. I have no equipment to test it on 4965, sorry.
>
> Yes the commit message says "Tested on iwl3945 only."
> ..which I did find a bit strange. Is it normal to deploy code to the mainline
> that is untested? Why was this also applied to 4965?
>
> I'm just asking questions here, as I have no direct knownledge of C or
> kernel driver programming. I've 20 yrs of web-dev experience though
> and know from experience that shipping untested code is a bad idea.
>
> Anyway, not trying to point fingers here! Just curious to find those who
> wrote the actual code, maybe get some info on why this was added
> and if it is really important. If not, maybe a revert is in order
>
> Regarding testing, I obviously have a laptop with the 4965 card and
> I'm more than willing to test stuff out if needed.

I sent a revert to fix this:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=11597043d74809daf5d14256b96d6781749b3f82

If all goes well this should be in v6.13-rc1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

