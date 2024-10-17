Return-Path: <linux-wireless+bounces-14140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F89A1BF3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE63CB20FF3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FCD1D0DE7;
	Thu, 17 Oct 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZqco2w9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252C1D0DC4;
	Thu, 17 Oct 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151324; cv=none; b=Kc4S5w8Tz5PdD2G42LoTdGojT4yiOxcL4Q/26ai0fsfI/xI7Xzy7zosQegLDXg7tiQmqE3RdwKAp0OZOTzNbhwbGG89Edh5lfyVuv4Hc5bKSGLlBsEqCvs3dcR3GivdMn1GpGEBhQ8/BSLV5+GYOfg5wUUiKmwT0rOu1+E+LAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151324; c=relaxed/simple;
	bh=AbxgFND14fAabCol8XiCmaikesH5sGAZCim6GukqBPA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eQOpjztSuknblkxq6hi/JD2uzd5AD7TKPn12Pg0ssHUNrgGlypYgMbKW4YrFkvaZ7iyuEKU/Qi7jyKP+jT1G9auWPyt6Vw3ZxznoS7TozgC3onodi9PXVE6No36tCiR011NvcXMYCVfT+P5xMmiz9uTOu0yhSzIJbJhalYflRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZqco2w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2178C4CECD;
	Thu, 17 Oct 2024 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729151324;
	bh=AbxgFND14fAabCol8XiCmaikesH5sGAZCim6GukqBPA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EZqco2w905uQTSAODuE00UWJtI0d16Nh8Tply6BmUT2CqLgMsRGZYOgNxvs039gNH
	 Djr6j+ATPqSkVYCkZjwVP31J7odXj2Unplzj9lNjOLhcJ85/u45eX7GIALjwPtwL6Q
	 o8vo7oNVKYXIFUAlfmjDomWR3K/DJ+mbzx1i+x5+doAg8IUkNG3DHPwRICyOFSkn6N
	 eniY0OQTEYRtq+VT8gtaGJTe4i+gKaOGh9x2PRoyWK8kjE110NQ4dopfIgqvkbMhzX
	 Qx8osaPw7OdB5nC5boB9Hd6drg4AQDar5Au7pKCvihgPodUsCwFU58VnBtSov14kLi
	 bKtpnHK5AWqDA==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: David Lin <yu-hao.lin@nxp.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  johannes@sipsolutions.net,
  briannorris@chromium.org,  francesco@dolcini.it,
  tsung-hsien.hsieh@nxp.com,  kernel@pengutronix.de
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<Zsc1efkBHDXdZtfJ@pengutronix.de>
Date: Thu, 17 Oct 2024 10:48:40 +0300
In-Reply-To: <Zsc1efkBHDXdZtfJ@pengutronix.de> (Sascha Hauer's message of
	"Thu, 22 Aug 2024 14:56:25 +0200")
Message-ID: <87a5f341bb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
>
>> This series adds support for IW61x which is a new family of 2.4/5 GHz
>> dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
>> tri-radio single chip by NXP. These devices support 20/40/80MHz
>> single spatial stream in both STA and AP mode. Communication to the
>> IW61x is done via SDIO interface
>> 
>> This driver is a derivative of existing Mwifiex [1] and based on similar
>> full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
>> kits in both AP and STA mode.
>> 
>> All code passes sparse and checkpatch
>> 
>> Data sheet (require registration):
>> https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
>> plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
>> 4-plus-802-15-4-tri-radio-solution:IW612
>> 
>> Known gaps to be addressed in the following patches,
>>   - Enable 11ax capabilities. This initial patch support up to 11ac.
>>   - Support DFS channel. This initial patch doesn't support DFS channel in
>>     both AP/STA mode.
>> 
>> This patch is presented as a request for comment with the intention of being
>> made into a patch after initial feedbacks are addressed
>> 
>> [1] We had considered adding IW61x to mwifiex driver, however due to
>>     FW architecture, host command interface and supported features are
>>     significantly different, we have to create the new nxpwifi driver.
>>     Subsequent NXP chipsets will be added and sustained in this new driver.
>
> I added IW61x support to the mwifiex driver and besides the VDLL
> handling which must be added I didn't notice any differences. There
> might be other differences, but I doubt that these can't be integrated
> into the mwifiex driver.
>
> Honestly I don't think adding a new driver is a good ideai, given how big
> wifi drivers are and how limited the review bandwidth is.
>
> What we'll end up with is that we'll receive the same patches for both
> drivers, or worse, only for one driver while the other stays unpatched.
>
> I even found some of the bugs and deficiencies I am just fixing for the
> mwifiex driver in the nxpwifi driver as well. So please direct your
> effort to improving the existing driver rather than putting more burden
> to the maintainers by adding a new driver. I am sure this is the faster
> path to get the necessary changes upstream, plus users of the mwifiex
> driver will profit from these changes as well.
>
> Of course I don't have to decide this. The wifi maintainer(s) will have
> the final word, but these are my 2 cents on this topic.

Replying to an old mail but I'm with Sascha here and I'm also skeptic
about adding a new driver. Especially my worry is that after the driver
is accepted we will not hear from NXP anymore and the community has two
almost identical drivers to maintain. There have been cases that after
taking the driver the company disappears and we (the community) are left
maintaining the abandoned driver.

Also I have not seen any convincing reasons why a new driver is needed.
For me much better approach would be to extend mwifiex like Sascha
recommends.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

