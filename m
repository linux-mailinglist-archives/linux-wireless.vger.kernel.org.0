Return-Path: <linux-wireless+bounces-14162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C869A2A30
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6451B2E119
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D911DF74E;
	Thu, 17 Oct 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quqVDQH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D71DF727;
	Thu, 17 Oct 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183744; cv=none; b=LFYbBMEF5Fo9KUcTcRjwGE2TZV1L/sECZFwWJ78nKHBTrfPZDHp35sQB+AJDpNlwwo5igyLTbvBwBMnLMxYNBeTiU0truRjhwyNxNbl7ryDWk9ck/viStkPdaFgTG5jqEJ8ATBju9uFgc+aJZQp2rR0bEYokuTrPXrV6yVJzahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183744; c=relaxed/simple;
	bh=eYGcyuOSxC14ybADTjktACHOwvhQLE7zko6r6geGqf0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GegLWtTT8AlKwMXwoBgSYsviV2W8oWqC//nmJaL2eoYGV31OU8JX4Y7Il1vFhASl6LZNA+xCU6zTuqKm9YIVNISb8iqtUz8YgQSQHgtdO8NclH5rHKdhVQVSC7OISkdCzHl6GkG96coru0ayw06ve8HpU91ZR9Uaa50A5yu91lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quqVDQH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE874C4CEC3;
	Thu, 17 Oct 2024 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183743;
	bh=eYGcyuOSxC14ybADTjktACHOwvhQLE7zko6r6geGqf0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=quqVDQH/ay3YKK8MhzDmcYEli4oQnOrOyfOAz8t+0oJ8ubdnLuZrKQ4SWKIy5qlIc
	 qwah4K0uglQNtQTUqi7Mbq1uWKbO4WGknVGRMZkMW98guxQ8d6Cd5po4XYredIwkd0
	 0CPeYWNgLyWQA5QZdosL/nBwWjJg8W7T2DH48GeSiqDJT5acpTJ6nhWOzzx5ATz6Qm
	 6MH41uP0R9tR/XGKx55a1ejOd9IIAu7F089v2ngOO+IOzGjmDJ+f5sgV8CRJeDYOdY
	 Rknb/vWsZiV3PWAV8PEW0QOVDPi9BiD/OEO9lXzyI7ueTtHM6f0OFiwkAlSG4u6aCY
	 3R0fhoX7U5h3w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: wilc1000: Set MAC after operation mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241003132504.52233-1-marex@denx.de>
References: <20241003132504.52233-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918374043.970100.2764180936900141438.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:49:01 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

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
> 
> Fixes: 83d9b54ee5d4 ("wifi: wilc1000: read MAC address from fuse at probe")
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Patch applied to wireless-next.git, thanks.

29dd3e48b9bd wifi: wilc1000: Set MAC after operation mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241003132504.52233-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


