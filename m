Return-Path: <linux-wireless+bounces-3879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3E85E6BE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4B61F28A15
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF685651;
	Wed, 21 Feb 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0sXQRv8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED685940
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541712; cv=none; b=XHJ+J7vfUDxfrLQYG3oBFV8CkZmzlNNYtXY2YYCGICOLvJJzIAzwL/myqPa05K3/Ye7BsBL+KL6xgdSFuWbE1HzfOW4IsEEpIRxxpN9J/CScUBZDX4rIiiXE6dUdoSUKISDkl4F+3r0OHqBVLgOFR+YotlBkxm0XstoilPRk5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541712; c=relaxed/simple;
	bh=AzAZhTVawrpAHrCPRPkS3Sy3hzsVEHlOpWaWhRG8quM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=LdzH4Da9lbLF1PAoQDWkse8gckcx+yMFp5t++sUZtgXichcSUpgblD/n8RfquEV7QCcu1nHNE8tuu4xo7ja4hpRIuCzBaagPpDzzGNjl5r/oixEZ7MkKpQ3XnLLg6pmiKz/7Xjt8iB36/1kN8NG93Zlakqx3mHsycOOmbawMaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0sXQRv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB9C433C7;
	Wed, 21 Feb 2024 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541711;
	bh=AzAZhTVawrpAHrCPRPkS3Sy3hzsVEHlOpWaWhRG8quM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c0sXQRv8BzG8qwsq+YcIBdcWkv7U68g7cyJxZfofiU1slFbGMcRk0j1nq05u/5CdD
	 TfvR1SVYFhINjvjm2JvpmoPnl2Kg9jjwREIoXzDq49MDSCwhaWrSAWOW0wNBlxeIgR
	 hzcsRC3N8jp/y1P3jkqHepQRzauvsiqHwjrLmTnZoSCrmVPiHcZIqrOip6rJU+gqny
	 3xh3eaXVZKXsSF+my4hrJcuOkCfZy1k21r1IVGNjmgf8ybWTHhiiJqgxQtoRziZcaM
	 4WkQFgQlCiUDIwpOkZ9TOKcO4ln02FZ24ijI/DG3YplFxzIBfmoQu0XTqoJlTuG3rc
	 Zn6Veb6PoU1Tw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4e936334-5f81-403f-a495-0628ebfb6903@gmail.com>
References: <4e936334-5f81-403f-a495-0628ebfb6903@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854170880.1918455.13905629998790956767.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:55:10 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtl8192cu is checking rtl_mac.tids when deciding if it should enable
> aggregation. This is wrong because rtl_mac.tids is not initialised
> anywhere. Check rtl_sta_info.tids instead, which is initialised.
> 
> Also, when enabling aggregation also enable RTS. The vendor driver does
> this, my router does this. It seems like the thing to do.
> 
> Also also, it seems right to set the AMPDU density only when enabling
> aggregation.
> 
> Also also also, delete the unused member rtl_mac.tids and the unused
> macros RTL_AGG_ON and RTL_AGG_OFF.
> 
> Naturally, with working AMPDU the download/upload speeds are better.
> Before: 59/32 Mbps.
> After:  68/46 Mbps.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

8ca4cdef9329 wifi: rtlwifi: rtl8192cu: Fix TX aggregation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4e936334-5f81-403f-a495-0628ebfb6903@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


