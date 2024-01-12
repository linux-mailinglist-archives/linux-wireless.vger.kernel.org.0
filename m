Return-Path: <linux-wireless+bounces-1832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3E82C46C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B63B23DA6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5C17C89;
	Fri, 12 Jan 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg6XRXln"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F717C80
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652F9C433C7;
	Fri, 12 Jan 2024 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079541;
	bh=fh+ambkwu/uF2MWlrKjGUZFOteEdu6Oml9kYEqmGpa8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Tg6XRXlnRLR25mmhDfb3MKXOyLOIA9lYaxYvRMqDl8l83S01G/nbyZY7IuJmvntiJ
	 t8sDUpwzJ13FmLSPcpKDeBgFRRKvCkC9z+yFqf9kD0GumVZP11aXyWFyPxfxlnMtRZ
	 28dS7gp8qmXVV1hBe2W1qNHUcOmT9MODDgc++Fbn37vS+XUcqF/TPiUzzn4H8Kk9At
	 ANCKsVrGBu/fBWvR71v6OQWeqeBDg/RVynL/efCtbtI680PbzZqwrSQ4bJjbkfsBjR
	 wRGrwcIlxuGq/2SZMhXJmDDXqH+Ok9NIonLx2wh2vZrf8fj1igzgRX1lfRUF5jhy5V
	 tBdMFKn2Fx4bg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtlwifi: rtl_usb: Use sync register writes
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <fb71bae6-8b19-4b6e-b4a6-0d260f2139e1@gmail.com>
References: <fb71bae6-8b19-4b6e-b4a6-0d260f2139e1@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170507953842.1153005.9541258288523966124.kvalo@kernel.org>
Date: Fri, 12 Jan 2024 17:12:20 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Currently rtl_usb performs register writes using the async
> usb_submit_urb() function. This appears to work fine for the RTL8192CU,
> but the RTL8192DU (soon to be supported by rtlwifi) has a problem:
> it transmits everything at the 1M rate in the 2.4 GHz band. (The 5 GHz
> band is still untested.)
> 
> With this patch, rtl_usb performs the register writes using the
> synchronous usb_control_msg() function, and the RTL8192DU works
> normally. The RTL8192CU still works.
> 
> The vendor drivers use the async writes in only one function,
> rtl8192du_trigger_gpio_0 / rtl8192cu_trigger_gpio_0, which probably
> doesn't even run in real life. They use sync writes everywhere else.
> 
> Also, remove "sync" and "async" from the names of the members of
> struct rtl_io to avoid confusion:
> 
> write{8,16,32}_async -> write{8,16,32}
>  read{8,16,32}_sync  ->  read{8,16,32}
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

178cc55d5129 wifi: rtlwifi: rtl_usb: Use sync register writes

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/fb71bae6-8b19-4b6e-b4a6-0d260f2139e1@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


