Return-Path: <linux-wireless+bounces-16632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D62E9F83B3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 20:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49F9167874
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3970194C96;
	Thu, 19 Dec 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxTy9tnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55F1A2642
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634850; cv=none; b=exAWUrhxzM+rYFZV7LLDTtFhDVx1fVcIJHx0h7h+iqjQWOc/oppo7zjqbMH6w3v54S0TZdrlVCsCeZ6sAFN0IRcH/e/3Jhxl6VbVWgcet3TzDmv6N48GMfurHKOfKMmIgN9zguO0uWm08/5VpqhRgYYwFhAsE/HGf58mhOG8RhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634850; c=relaxed/simple;
	bh=SLUiY2wcJTTS1vhLSMh30EAozyggKUvkNGh0Q+o/XSw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Z7Lq2evvFa/TQpclh9gELzpmiMDh/vcbghesG2uLyGVi9B4PZKrs8R8+pDhf7RzuO05kPG+vO82yvARaEyeEH8/gvOJ54LQdZ77+Rm9limIs1Ac5nqiWnltwdP+oqWH2tepcx8IRKwpM5o/eaq1hON/NNpHtccuXLnFztr0leF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxTy9tnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A8CC4CECE;
	Thu, 19 Dec 2024 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734634850;
	bh=SLUiY2wcJTTS1vhLSMh30EAozyggKUvkNGh0Q+o/XSw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uxTy9tntNULSO1OXehOzoZEm7BKhuD+EJx0F0nY7DaMsW3euc8VVAT+9f4Xul9J7I
	 Vhmk/2wfAHVGoDnVTzccTHVEXX+u+huDqrAvbaHSNiWwvKf8/llMJnV2UASGM6tf1L
	 cUYJVvJw5koMR17BVhBPoRNOAel01rDkrk9hIPoXWvK2cSHKaQeEJRB+dq8WdICqWZ
	 2doG8g8J9zbUh9b5JdV+5rJX+1RVZjBMFucW+rbh1KilqIqVerrKXrFfOpTIpj8cBM
	 MsK+hRm7/OQaBMY5ckqVSbY3zXRPLLFpnWSKU/zf7FAykeoTrffIKEcYIJzySIGatw
	 OB+5iHYJryUsw==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>,  Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH] wifi: rtw88: Add USB PHY configuration
References: <a3b87566-4e11-4fc2-8c51-db592e56af13@gmail.com>
Date: Thu, 19 Dec 2024 21:00:46 +0200
In-Reply-To: <a3b87566-4e11-4fc2-8c51-db592e56af13@gmail.com> (Bitterblue
	Smith's message of "Thu, 19 Dec 2024 18:20:33 +0200")
Message-ID: <871py3sdk1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> Add some extra configuration for USB devices. Currently only RTL8822BU
> version (cut) D needs this. The new code makes use of the existing
> usb3_param_8822b array from rtw8822b.c.
>
> A user reported that TP-Link Archer T3U in USB 3 mode was randomly
> disconnecting from USB:
>
> [ 26.036502] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
> ...
> [ 27.576491] usb 2-2: USB disconnect, device number 3
> [ 28.621528] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
> ...
> [ 45.984521] usb 2-2: USB disconnect, device number 4
> ...
> [ 46.845585] usb 2-2: new SuperSpeed USB device number 5 using xhci_hcd
> ...
> [ 94.400380] usb 2-2: USB disconnect, device number 5
> ...
> [ 95.590421] usb 2-2: new SuperSpeed USB device number 6 using xhci_hcd
>
> This patch fixes that.
>
> Link: https://github.com/lwfinger/rtw88/issues/262.

I think the dot in the end of link is not needed. Maybe Ping can remove that?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

