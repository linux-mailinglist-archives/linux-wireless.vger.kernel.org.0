Return-Path: <linux-wireless+bounces-2267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14D832E33
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E91B21514
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA1655C27;
	Fri, 19 Jan 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRjd7yPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EC55C05
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685497; cv=none; b=kf6VRU2LZPGRJm88vg/IC9SpQe+BTZh6+6FE0YPEu6jMCN6U+dv4JNBXXVilo0a4vus2kk0QZmn43EkTgxFEqIVD8LOtJ9YxB+1XumPQHOigFJ4KgGUOp/O/y2bcXx6rEIy4uZvOX6ufY9/Z1uOix4U08G0MXe9y5r/5499JpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685497; c=relaxed/simple;
	bh=Fn/qDGxACViVGOKYQeECJDl5cPCHS+tRoOGoK6iaLZo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Hkwi09fjcejGkK/1jnyjDnKkIsIY8bqGjK6o8rg0UaV65lvbj9al0FNUy1KZuDfdQ9p0cMZipWaNCW7TO/xjG826bl6tPnCvLE8PXtvgAhzkTVrIsieFuqyu10XCPlL9N++qdvChDh0VbQOYGTVkr/+MScb+9KiHGKPrcfTBC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRjd7yPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB97C433C7;
	Fri, 19 Jan 2024 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685497;
	bh=Fn/qDGxACViVGOKYQeECJDl5cPCHS+tRoOGoK6iaLZo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=iRjd7yPZ8FL2jsj2wMsX4a3ouPMrLWZ4zqCzYIAuMvMKZsY8Qvt4d+oyafhR7yQoP
	 KEe5KkK/4TCn831R6VLeJEnOSx5xtz2mE8pxOPyAXJDRD3/araEz3bxf1F6hdoXX0l
	 3R3hRHE1IIJ/QPfuS2kw/xiKSyWTPusN8o9Ms6Naumyu+5pQ9V47k0KZQDoqXul7eE
	 vKD7ODoBGZe0ujLsdy6QJlibdrM2lMjwahdhJJl2UBbHFZIzAGGn0UL1YB3o94CWD5
	 1n/2mtzkHSC7vHBo3iXXhkfETS980idmfK1AX2BEFYw9XLY3tAzlesZf0FoyP7hn4d
	 IdZlvdckW/iQQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
References: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568549408.3153793.3782157778815282405.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:31:35 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
> one byte at a time.
> 
> Also, after plugging the device, the firmware gets uploaded three times
> before a connection to the AP is established.
> 
> Maybe this is fine for most users, but when testing changes to the
> driver it's really annoying to wait so long.
> 
> Speed up the firmware upload by writing chunks of 64 bytes at a time.
> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
> RTL8192DU).
> 
> PCI devices could upload it in chunks of 4 bytes, but I don't have any
> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
> rather than as dwords") decided otherwise anyway.
> 
> Allocate memory for the firmware image with kmalloc instead of vzalloc
> because this memory is passed directly to usb_control_msg(), which
> can't take memory allocated by vmalloc.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b06439c66874 wifi: rtlwifi: Speed up firmware loading for USB

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


