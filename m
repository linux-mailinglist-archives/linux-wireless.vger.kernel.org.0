Return-Path: <linux-wireless+bounces-2507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831E83D1B9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 01:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACEB1C2202C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F376387;
	Fri, 26 Jan 2024 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI0WtVQr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAC629;
	Fri, 26 Jan 2024 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230290; cv=none; b=uqHREWMhAhN2g0YgDH7lus4XWQe+NB/V36TqLBHnDd7V689NwXSDxWuoyijFUKiC6/uyzVZIapdF9sKJSNhKwjyWkZFlzTT9GoW7Xh/nk9UflFH+T1JfRESZ0GK0mB55r93QtVC4350tE7JICUDpj7dcLs3nKGU5fgcrIcxZnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230290; c=relaxed/simple;
	bh=1W6ObQ9wbGVmB/qjj2YEH5FXXuCWrDS7IjwQ5kLv6+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukC9WliVbQRPypI7Vh/sLmwu/suMx32TGDwwm43ILm1XHekVhkwbvV4s3MlBSI9zKr0WgNUm2b64c3xOGdak8B73S0P7EcLWzZ+AKrebmJiBDzxo4vfeRr2jewhYSeLJPoY1W6V2lQ6rClUVjcE8O/EPP7xXaqFJaiC58jVX5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI0WtVQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E64C433F1;
	Fri, 26 Jan 2024 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706230289;
	bh=1W6ObQ9wbGVmB/qjj2YEH5FXXuCWrDS7IjwQ5kLv6+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rI0WtVQrxLUmCg/Tuyrrow4NjzcVG5gt0nMyeHpiRGpDwwP/VEKeYwB29tI9Rzzbs
	 zmOKZ4ySB3OrK7aZ54iivoezM3qg/aMTY/7oM3Z6yQXSkERRqxnoOVVrqfETyg3Xn0
	 sXvUKJ91peE9RD4Ma3DTGgJbCjObvWB90oyvXb8AkGJtm/1ZNlNT02CzDZeeWDr1ed
	 Fyu47cFy88Oqy4zXyOyLZ/xU4zxjxC3TJYJXL4axix1DkkvKUbwp4JiLLe7VxReoNj
	 lKbIBJtvX4ZErD4MxYAsAWWdzoaop2+HyuX9iBY90o/wQpA021R4T5sYv52GGKqh/B
	 Je9caNI4XBzXw==
Date: Thu, 25 Jan 2024 16:51:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-01-25
Message-ID: <20240125165128.7e43a1f3@kernel.org>
In-Reply-To: <20240125104030.B6CA6C433C7@smtp.kernel.org>
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 10:40:30 +0000 (UTC) Kalle Valo wrote:
> The first "new features" pull request for v6.9. We have only driver
> changes this time and most of them are for Realtek drivers. Really
> nice to see activity in Broadcom drivers again.

minor thing for a follow up:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49: warning: no newline at end of file

