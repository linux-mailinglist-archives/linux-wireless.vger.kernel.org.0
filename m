Return-Path: <linux-wireless+bounces-13469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513F98EF48
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008942846A2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8D17B50F;
	Thu,  3 Oct 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4/F2tUI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD86184540
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958728; cv=none; b=teNZRBReqkwxS+s36Tt8eQWeCfmUv+mB/lDX17dojioB7oUR06SVAqZQPyoMDgVVmFAGe9I8dBCD4YQgZDMUkhOJVpc0IjZqFPKb+vo395uFYYKRTtJig+W3gyYSqzZNNCjaGEtiBSRt6lxYY/m0lio4aSTS07k1dv7SrcCUSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958728; c=relaxed/simple;
	bh=NFf20JAyBq7me1xPlnd51mNT8EQ8/5YXGBcoxLXmDIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rh0lw6yVyHpRKeeF5u3YLU8ZSJ2ATW87TU5Xeq1UOcSCEwl4YVIQwjtfdc0JtJIWL7MtxPC/wUt0rb/LRKEGF+As+jRqZveJz5EPss64Y/ZD6M198fUTDjCd4GL8SnP+OTrIvllJlAfIotpmTKHtMTgCKKpF6P/pUj10EwAbhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4/F2tUI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C11CE4000A;
	Thu,  3 Oct 2024 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727958724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUsiZWCkmRYN7Yt/XFaYbJwSqJgrDmCWn10KJ8u5NNc=;
	b=c4/F2tUIYzHXdhS6JEusjqcwhDbBQYXLkjuE/yQgBA4QwyCeKuebnZbPWHTZaohj5im4DL
	5DQ5GJR2k402UQlTBu0+MtVGrrfrd1oJT51vY63Put21T5DjRJQRcfAJ47Ro6cWZ9DZPWb
	Nm/BbjBHdWJ1fFUIxoURp0Uc8cWpLueez4bMh93aRwFPZlci0A09sLRbWE/0W0hSAb4EwN
	8MDTD9ZcaXkzPFUxITqKHGIJ6ucxvnGekGSrGATDrRD87Gx1EHqMJD58oGlENHUUQ/C6WA
	ze+WNtXNUYjtfP2Rn2jiSfMZnbiCPMEp86HWOCQciJbUO9KROPlNi4FjbJQXTg==
Message-ID: <8d90714b-3646-4cfb-8b2c-89b21b1d8000@bootlin.com>
Date: Thu, 3 Oct 2024 14:32:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Set MAC after operation mode
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240926195308.2823595-1-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240926195308.2823595-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 9/26/24 21:52, Marek Vasut wrote:
> It seems it is necessary to set WILC MAC address after operation mode,
> otherwise the MAC address of the WILC MAC is reset back to what is in
> nvmem. This causes a failure to associate with AP after the WILC MAC
> address was overridden by userspace.
> 
> Test case:
> "
> ap$ cat << EOF > hostap.conf
> interface=wlan0
> ssid=ssid
> hw_mode=g
> channel=6
> wpa=2
> wpa_passphrase=pass
> wpa_key_mgmt=WPA-PSK
> EOF
> ap$ hostapd -d hostap.conf
> ap$ ifconfig wlan0 10.0.0.1
> "
> 
> "
> sta$ ifconfig wlan0 hw ether 00:11:22:33:44:55
> sta$ wpa_supplicant -i wlan0 -c <(wpa_passphrase ssid pass)
> sta$ ifconfig wlan0 10.0.0.2
> sta$ ping 10.0.0.1 # fails without this patch
> "
> 
> AP still indicates SA with original MAC address from nvmem without this patch:
> "
> nl80211: RX frame da=ff:ff:ff:ff:ff:ff sa=60:01:23:45:67:89 bssid=ff:ff:ff:ff:ff:ff ...
>                                           ^^^^^^^^^^^^^^^^^
> "

Good catch, thanks for the fix. I tracked a bit the issue history and it seems
to have been introduced by my recent change about reading the mac address early
from the chip nvmem (to set correctly mac address reported to userspace once net
device has been registered). I indeed reproduce the issue, and reverting the
commit below makes it disappear, so the following can be added:

Fixes: 83d9b54ee5d4 ("wifi: wilc1000: read MAC address from fuse at probe")

> Signed-off-by: Marek Vasut <marex@denx.de>

Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Thanks,

Alexis
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

