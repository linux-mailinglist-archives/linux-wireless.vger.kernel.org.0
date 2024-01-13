Return-Path: <linux-wireless+bounces-1869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93A882CA43
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 07:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5ACDB231B6
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 06:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8D1C32;
	Sat, 13 Jan 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4YE+osR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501AEDD
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 06:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C53C433F1;
	Sat, 13 Jan 2024 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705127750;
	bh=2lDoVeuLevD2cGbfNrGI37VCjhOWBD5I+sKHOpjsC9c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e4YE+osRpjEd1aEsMdRTUvqs0IzbTkaecOwVsqQr86Qm9ANGHL4BeBrYHw3wGtenC
	 jfVDra7tv3UZD37zI41Ovf9oi0Os6/R/P/fqrqETDUWZLiX0AaXdBZhXflI23LpB/S
	 DEEpHjYnVnz9bGtfdJInREBrmIPUkU06VXjXyckHgmNHG4pSnn0FZp5PQ2c4iSHsoH
	 zD8JH4OpaqNUpdqJW0K694TsaEqp+4H5/+VeYFb0lrej8hh3Lsv5bW8PqbDW77/2Au
	 CttnviQ64ozP0+9IHfXzEfXTjeKEeMT+NaT5y2wEwhTpAxyx9nkQJpP1HY/LTBVsJC
	 QSbs1Grksj+Xg==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>,  Larry Finger
 <Larry.Finger@lwfinger.net>
Subject: Re: wifi: rtlwifi: Speed up firmware loading for USB
References: <6351ca3f-6b06-4fe1-ace7-6e9d67497dce@gmail.com>
Date: Sat, 13 Jan 2024 08:35:48 +0200
In-Reply-To: <6351ca3f-6b06-4fe1-ace7-6e9d67497dce@gmail.com> (Bitterblue
	Smith's message of "Fri, 12 Jan 2024 21:49:53 +0200")
Message-ID: <87o7dphha3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

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
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

There's another version so I assume I can drop this one:

https://patchwork.kernel.org/project/linux-wireless/patch/0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

