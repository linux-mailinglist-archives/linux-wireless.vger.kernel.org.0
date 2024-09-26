Return-Path: <linux-wireless+bounces-13223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FA0987421
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 15:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5CF1F2300C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15784134BD;
	Thu, 26 Sep 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="AiQXfF7Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC510F4
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355892; cv=none; b=L8GthkP/cB9iZhf2i+r+1Oa60GomhS0j17SXB6aD4eBuCuK5VlgZAuJY3e5TzsRoDN7t3R+gK3M+2f90NBUYxGSnCs+aStjFFiuA2SoBf5gGeT+akoLYO8SzZG9lfvLn0fcxWBeIEWacmL/He4jbfCvKJMsvM30qroGcIkJ0Zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355892; c=relaxed/simple;
	bh=KSZp6U3XFM2xw90GPqWP11KQQuv8b4x6sfTALFoEurQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l/d5yNTLAJ2M7UoeUT9JyAYvAQjqiiNt4jJgPgnR+W7LgpOwJ8v4yR/AuzrKBbU0/08jlbRXkjqw+ZTAv9HCLokIM9HaWJjV9UTAm0f3cvM0ht+JP34+o5ssEpdgW5lUayEP/l7btJd33YT7y1fX3HUx2bbbhliYOaRdlA406o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=AiQXfF7Z; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1727355882; bh=5N+2n6VIBOLmTcDYjjmKCNpf8hHSZxpBEwNHZDHBcDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AiQXfF7ZPFnJOfxR7Ttl/LUuHJFaI9Habf17b39d+LhmIz4Hy0TnhqF6nniSO0SQM
	 6HXGhHsQkeRd7VqlFhYcromiJX0eVWtC7OE57lF35ARBs+7b3ehXRcLAkq0rgkv7ax
	 DkANAWSt8DUyxgYAXjgd8NtAW/wsZd2H6qlewx8zs6lKN7myttQk4pCSXedSnYFZqn
	 mNe13xQ90RWaiwpasH+YEb8qVhqJHFqDcKUTJ1aijl5bpvJnX0PN8SiM1WwW5Tbl06
	 5hIkbiFphuYjCoVb8wgZNx8LeWJVYevJO9Ni3/mL/RH8NEHXmn9Lnhl8MR5KdL5ZMu
	 llBPC8pIbb4Hw==
Received: from m101-u7-ing.websupport.se (unknown [10.30.7.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4XDv2L30WQz1Xtq;
	Thu, 26 Sep 2024 15:04:42 +0200 (CEST)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u7-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u7-ing.websupport.se (Postfix) with ESMTPSA id 4XDv2J5z9wz11Ln;
	Thu, 26 Sep 2024 15:04:40 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 15:04:40 +0200
From: petter@technux.se
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: rtw88: USB devices randomly stop receiving anything
In-Reply-To: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <ea1e7d48c1724dfbda8e7d28acb386a9@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Server: m101-rspamd-out-6
X-Rspamd-Action: no action
X-Out-Spamd-Result: default: False [-0.10 / 1000.00];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	WS_IP_WHITELIST(0.00)[109.235.175.25];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Out-Rspamd-Queue-Id: 4XDv2J5z9wz11Ln
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 7055
X-purgate-ID: 155908::1727355882-C843FF5A-A8D769F6/0/0
Feedback-ID: m101:technux.se

On 2024-09-25 13:46, Bitterblue Smith wrote:
> Hi,
> 
> I have this problem with RTL8811CU, RTL8723DU, RTL8811AU, RTL8812AU.
> I assume all USB devices are affected. If I have qBittorrent running,
> the wifi stops working after a few hours:
> 
> Sep 24 00:48:21 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:21 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:23 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:23 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:25 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:25 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:27 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:27 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:29 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:29 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:31 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:31 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:33 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:33 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:35 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:35 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:37 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:37 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:39 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:39 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:41 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-BEACON-LOSS
> Sep 24 00:48:41 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
> CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Added 
> BSSID ... into ignore list, ignoring for 10 seconds
> Sep 24 00:48:42 ideapad2 NetworkManager[433]: <info>  [1727128122.0377] 
> device (wlp3s0f3u2i2): supplicant interface state: completed -> 
> disconnected
> Sep 24 00:48:45 ideapad2 NetworkManager[433]: <info>  [1727128125.6030] 
> device (wlp3s0f3u2i2): supplicant interface state: disconnected -> 
> scanning
> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Removed 
> BSSID ... from ignore list (clear)
> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: SME: 
> Trying to authenticate with ... (SSID='...' freq=2472 MHz)
> Sep 24 00:48:50 ideapad2 kernel: wlp3s0f3u2i2: authenticate with ... 
> (local address=,,,)
> Sep 24 00:48:51 ideapad2 NetworkManager[433]: <info>  [1727128131.2488] 
> device (wlp3s0f3u2i2): supplicant interface state: scanning -> 
> authenticating
> Sep 24 00:48:51 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 
> 1/3)
> Sep 24 00:48:51 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:52 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 
> 2/3)
> Sep 24 00:48:52 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:53 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 
> 3/3)
> Sep 24 00:48:53 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
> report from firmware
> Sep 24 00:48:54 ideapad2 kernel: wlp3s0f3u2i2: authentication with ... 
> timed out
> 
> After this all scans return nothing. The chip is still alive,
> though. The LED blinks during the scans (it's hardware-controlled)
> and another device in monitor mode can see the probe requests.
> 
> I confirmed that even C2H stop coming. I used aireplay-ng to send
> some authentication or association frames (can't remember) which
> require TX ACK report. I saw "failed to get tx report from firmware"
> and no C2H.
> 
> While qBittorrent is needed to trigger this bug, simply downloading
> a random Linux iso did not do the job. "Other" torrents did. It's
> unclear why. Maybe it's uploading that triggers the bug.
> 
> I left iperf3 running all day and nothing happened. Only qBittorrent
> can break it.
> 
> RTL8822CE doesn't have this problem. I can use qBittorrent with it
> just fine.
> 
> I mounted debugfs and dumped the MAC registers during a scan using
> this command:
> 
> for i in {00..20}; do sleep 0.5; cat 
> /sys/kernel/debug/ieee80211/phy2/rtw88/mac_{0..7} > dead-$i.txt; done
> 
> I thought maybe some RX URBs failed silently and rtw88 stopped
> sending them to the device (== stopped requesting data from it),
> but that's not the case. [1]
> 
> I have the device in this state right now. Is there anything else
> I should look at?

What hardware are you running on? This looks very similar to some issue 
me and some colleagues have seen from time-to-time when using LM842 
(8822cu)[1][2][3], when running it on our i.MX6SX arm board. It has thou 
been harder and harder to trigger that issue on our board. But the 
outcome when it happens is identical to your. In our case we get it when 
running a number of mender streamed installations. We also can trigger 
something similar when doing hw-offload scanning, so we have disabled 
that in our setup. For us however it seems related to slower platforms, 
we haven't seen it on systems with better performance. Also it become a 
lot better when the USB RX aggregation was added to the chip + running 
with the patch in [3]. We also got it on LM808 (8812AU) then after 
suggestion we tried morrownr driver [4] with USB aggregation enabled and 
couldn't trigger it anymore. But feels like all these things are just 
ways to reduce the risk of getting into this state. So I think you just 
found yet another way to reproduce the behavior. So hopefully that is 
the first step of finding the root cause of it. I will gladly help to 
test things in this area if you guys find something interesting.

[1] 
https://lore.kernel.org/all/20230526055551.1823094-1-petter@technux.se/t/
[2] 
https://lore.kernel.org/linux-wireless/20230616122612.GL18491@pengutronix.de/T/#t
[3] 
https://lore.kernel.org/linux-wireless/20230612134048.321500-1-petter@technux.se/
[4] https://github.com/morrownr/8812au-20210820

> 
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/realtek/rtw88/usb.c?h=v6.10.11&id=25eaef533bf3ccc6fee5067aac16f41f280e343e#n641

