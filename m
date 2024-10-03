Return-Path: <linux-wireless+bounces-13473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D498F050
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF011F22AEB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73BB1E495;
	Thu,  3 Oct 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JXaxl6+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879A186E46
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961954; cv=none; b=hbTqJbFdBNu9dURteuJ0re7AziigAen0kNU83FW5s2yeeODCSp7r45hDfMnT1mBKSWyO3bV35NARVmFKsTC94b/SYtBRP9/DNvtiDE8hxu0KLxJqSvI/qneIBY2K1XkRGWqUyLgOHyIANvcrMhK4TqP1T8PZsIiSDDo1Oyykjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961954; c=relaxed/simple;
	bh=LojP7bAAjR53TpIzOgGbf1XLM8sKSczZwbv0BYhxR0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaqsSdvaeQrkOpkerdbDHwj4uH4AMVKLM93hjLEXq6LZOp3GG5LRDmEdBPhRF2qcyPWky37vjneD6DUDJcqUI2jI5kXnO5X2OduIH+jRuDnGxs/UK+M+rwWboEGCvUEH54kZD3EwdvprGKDX4AQpF3Q5ilSuWY6lR5ocpSZdjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JXaxl6+p; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 46797882EF;
	Thu,  3 Oct 2024 15:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727961951;
	bh=y6BxYfe8mbUmdeYNrizupkQmuVKyQXKXIq/T2to1UWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JXaxl6+p+6BMZMAkcXIwa6+NO9JoXGGpkk9SyL5x+GftI/pl0y0xa9nZ780iNlpdv
	 Wd2l2MljoKWFdUAMrbT+Tk7y9W9jT3PFnJdlt8ALVgGs7KCl4Yzscu9WPyfaivbdEc
	 92xuj++ELDrN7oi23svFXVvsxej4NfZYFX6Ndb6hLeXfHq6+BmzpJTnwpPbIKVVZGJ
	 qAt0U00FvCQagGv9CTkbWbgP9YdJGOaqa0Zc2cMWQ6SklFkFyFAnmMzIFaa4ninwif
	 zWxrn4vpHmc84xhr7TCx+zHS3s2TqFXhZB7md8RzDMQ7h8RiYpBBM4BnzqguHItuZo
	 g2ZNWCljM73jQ==
Message-ID: <089601b8-7bab-4369-822d-9ce1f0091f82@denx.de>
Date: Thu, 3 Oct 2024 15:25:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Set MAC after operation mode
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240926195308.2823595-1-marex@denx.de>
 <8d90714b-3646-4cfb-8b2c-89b21b1d8000@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8d90714b-3646-4cfb-8b2c-89b21b1d8000@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/3/24 2:32 PM, Alexis Lothoré wrote:
> Hello Marek,

Hi,

> On 9/26/24 21:52, Marek Vasut wrote:
>> It seems it is necessary to set WILC MAC address after operation mode,
>> otherwise the MAC address of the WILC MAC is reset back to what is in
>> nvmem. This causes a failure to associate with AP after the WILC MAC
>> address was overridden by userspace.
>>
>> Test case:
>> "
>> ap$ cat << EOF > hostap.conf
>> interface=wlan0
>> ssid=ssid
>> hw_mode=g
>> channel=6
>> wpa=2
>> wpa_passphrase=pass
>> wpa_key_mgmt=WPA-PSK
>> EOF
>> ap$ hostapd -d hostap.conf
>> ap$ ifconfig wlan0 10.0.0.1
>> "
>>
>> "
>> sta$ ifconfig wlan0 hw ether 00:11:22:33:44:55
>> sta$ wpa_supplicant -i wlan0 -c <(wpa_passphrase ssid pass)
>> sta$ ifconfig wlan0 10.0.0.2
>> sta$ ping 10.0.0.1 # fails without this patch
>> "
>>
>> AP still indicates SA with original MAC address from nvmem without this patch:
>> "
>> nl80211: RX frame da=ff:ff:ff:ff:ff:ff sa=60:01:23:45:67:89 bssid=ff:ff:ff:ff:ff:ff ...
>>                                            ^^^^^^^^^^^^^^^^^
>> "
> 
> Good catch, thanks for the fix. I tracked a bit the issue history and it seems
> to have been introduced by my recent change about reading the mac address early
> from the chip nvmem (to set correctly mac address reported to userspace once net
> device has been registered). I indeed reproduce the issue, and reverting the
> commit below makes it disappear, so the following can be added:
> 
> Fixes: 83d9b54ee5d4 ("wifi: wilc1000: read MAC address from fuse at probe")
> 
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Nice, thanks !

