Return-Path: <linux-wireless+bounces-8137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB98D094C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8642810F8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B865561FCC;
	Mon, 27 May 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5GMWFz8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9B1DA58;
	Mon, 27 May 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830255; cv=none; b=e6EnCoj3wJzzX3QHS7sxiDXY+12ckKH5V91mFLvLsqRMchx5fU03COIwzG9enh0oVoezfSjlE/l/vidlSqcMtYw7CtOgq9Q1Wchqns+w6Q1yalnwYUFRrkWmNkEaBu/CwYBjvbqdKqpZNES4vQNUvCZ2h0ki2HlU27cuesrjQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830255; c=relaxed/simple;
	bh=1ZMhNL/6A406EwttWRYVsylDBq6qoRLco9BwftzrOLQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UWUJqdfMFWkmL2N8f6DL9Hy7Bt8JANgQc5VUN5XVHzDP2m6irNmexx6b3D32K6pnRWXlgN3aAkqvhW13v1ImnH0DJ4XRJviIKKTdph4wvpEBAJ8zPKKFCmDOl32oXzHwvoe+saRBT5+9O2/1DqAcs3f7lvZ62UI323UqceOMw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5GMWFz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BF8C2BBFC;
	Mon, 27 May 2024 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716830255;
	bh=1ZMhNL/6A406EwttWRYVsylDBq6qoRLco9BwftzrOLQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=k5GMWFz8aO9ZCFimFqIHTeTAc1N8yxkVzx9ZMPBp/bVeyyjjPyrGKF7pAGuJsYO0b
	 uPWzuMj8TRQ35MV29igdJTQc/+Dmj9n7XtkZ1LbBTsz5bFikCOlVywslG0wh/UvT7b
	 8tQEHlSd2hE4tUN1Z5Igi8TlZBvwIUJbVRB0InZzEyLtlmJsp5rrcON9PyrKc+l9YO
	 H2b6+CX+PDZkCAxs77xieNYf8F4ZWsQ4bmMghZsn6N69oT3jLH571JL54MwASeOOEX
	 9+LUTzO5FJ6XPR/NyNz6YmRvpHHwe61TmkQ5xBumuyDVek5TrtjKdvCdpZzyJG3KKC
	 Kc4hr9xfKq6ag==
From: Kalle Valo <kvalo@kernel.org>
To: marcin.slusarz@gmail.com
Cc: linux-wireless@vger.kernel.org,  Marcin =?utf-8?Q?=C5=9Alusarz?=
 <mslusarz@renau.com>,
  Ping-Ke Shih <pkshih@realtek.com>,  Larry Finger
 <Larry.Finger@lwfinger.net>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: schedule rx work after everything is set up
References: <20240527170137.455671-1-marcin.slusarz@gmail.com>
Date: Mon, 27 May 2024 20:17:31 +0300
In-Reply-To: <20240527170137.455671-1-marcin.slusarz@gmail.com> (marcin
	slusarz's message of "Mon, 27 May 2024 19:01:37 +0200")
Message-ID: <87jzjf8990.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

marcin.slusarz@gmail.com writes:

> From: Marcin =C5=9Alusarz <mslusarz@renau.com>
>
> Right now it's possible to hit NULL pointer dereference in
> rtw_rx_fill_rx_status on hw object and/or its fields because
> initialization routine can start getting USB replies before
> rtw_dev is fully setup.
>
> The stack trace looks like this:
>
> rtw_rx_fill_rx_status
> rtw8821c_query_rx_desc
> rtw_usb_rx_handler
> ...
> queue_work
> rtw_usb_read_port_complete
> ...
> usb_submit_urb
> rtw_usb_rx_resubmit
> rtw_usb_init_rx
> rtw_usb_probe
>
> So while we do the async stuff rtw_usb_probe continues and calls
> rtw_register_hw, which does all kinds of initialization (e.g.
> via ieee80211_register_hw) that rtw_rx_fill_rx_status relies on.
>
> Fix this by moving the first usb_submit_urb after everything
> is set up.
>
> For me, this bug manifested as:
> [    8.893177] rtw_8821cu 1-1:1.2: band wrong, packet dropped
> [    8.910904] rtw_8821cu 1-1:1.2: hw->conf.chandef.chan NULL in rtw_rx_f=
ill_rx_status
> because I'm using Larry's backport of rtw88 driver with the NULL
> checks in rtw_rx_fill_rx_status.
>
> This should fix:
> https://marc.info/?l=3Dlinux-wireless&m=3D167907688311943&w=3D2

Please use permalinks from lore.kernel.org, marc links don't contain the
Message-Id and are hence unreliable.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

