Return-Path: <linux-wireless+bounces-13251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A50F987E96
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 08:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC8D1C213D6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9715B572;
	Fri, 27 Sep 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="sA4l1q8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838815ADAB
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419469; cv=none; b=gfnYY7MC6dRBP6uMEiXlnYPSY9MPZCin6YBbV1C2orr2t+8ufERbkI4KsGrZ36uh9zy8U+7urYJclZ1mx4kc0ONvwGIHQAKjOYqJ8mfVwW6xlZ1593ViKlpCr1WAD5lf0+8Lc1zUhLuoUYCjmog1q/NXYzmRUdAZAPJT0POxMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419469; c=relaxed/simple;
	bh=vJf5m5pUt/Bw0QoFzZgajj+QHx5EyyZqfni8TlKfFi4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=so2UHjBimfumOjbDZTHJ55K5FoPV/lAFW2hoTLeP7W8XjJUxFozKy1OUgJGRXtoLBmKEY0LQJTNwdZ5aVCWnzqZjlthDlUh4OgqRW8gD4zKfNFqxLLlyG2PS+Lh9vicc1M5ucn+KcLuk5J+k+/O2iZzRiSvELGt14oS7Ya3PXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=sA4l1q8I; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1727419455; bh=3faqF2hvbA1cP26ER+TEAIEkXSs9h5R212FgDKc50kY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sA4l1q8I9lornHaXjaZcp4GMZ0nAJtl5ZFfmmOOBI62fhj8hVGN07VNDR0XoxHJD8
	 rZCp5ACVb46QNJlYHyVcDJ2drCP4o3aFk2KGYbvB16ocI7RvHktqvRATHK5B2eyGtv
	 POGPhoA14t9Ds+Jg4lkYJCVLGlIgpzNTfBxodu9x5YNsdKwbWDj0IqN/B8Hr4miZoS
	 z8jQhxfvEDAnSQj5fXzrdFQL6K0ApmHpo27N8uizO5Q3fvuHnaRPwi1eHQwlKfTABZ
	 y1iXohcPrjhjyH7Cep9J6KHY/BED2SMZwiI3koAe6cigmc9JKp4rq5Nq4cWSqTjhe0
	 0HNbR884JYJTA==
Received: from m101-u6-ing.websupport.se (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4XFLXv0Wkjz2nPk;
	Fri, 27 Sep 2024 08:44:15 +0200 (CEST)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u6-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u6-ing.websupport.se (Postfix) with ESMTPSA id 4XFLXt0vbMz18TR;
	Fri, 27 Sep 2024 08:44:14 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Sep 2024 08:44:13 +0200
From: petter@technux.se
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: rtw88: USB devices randomly stop receiving anything
In-Reply-To: <0ce86878-7baf-45ac-acc4-4fd9e717102d@gmail.com>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
 <ea1e7d48c1724dfbda8e7d28acb386a9@technux.se>
 <0ce86878-7baf-45ac-acc4-4fd9e717102d@gmail.com>
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <9a0877415aab627feda465531ffd4926@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Out-Rspamd-Server: m101-rspamd-out-6
X-Rspamd-Action: no action
X-Out-Spamd-Result: default: False [-0.10 / 1000.00];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	WS_IP_WHITELIST(0.00)[109.235.175.24];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Out-Rspamd-Queue-Id: 4XFLXt0vbMz18TR
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 8978
X-purgate-ID: 155908::1727419455-C7C3EF5A-6CBDC735/0/0
Feedback-ID: m101:technux.se

On 2024-09-26 18:51, Bitterblue Smith wrote:
> On 26/09/2024 16:04, petter@technux.se wrote:
>> On 2024-09-25 13:46, Bitterblue Smith wrote:
>>> Hi,
>>> 
>>> I have this problem with RTL8811CU, RTL8723DU, RTL8811AU, RTL8812AU.
>>> I assume all USB devices are affected. If I have qBittorrent running,
>>> the wifi stops working after a few hours:
>>> 
>>> Sep 24 00:48:21 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:21 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:23 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:23 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:25 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:25 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:27 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:27 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:29 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:29 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:31 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:31 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:33 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:33 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:35 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:35 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:37 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:37 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:39 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:39 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:41 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-BEACON-LOSS
>>> Sep 24 00:48:41 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: 
>>> CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
>>> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Added 
>>> BSSID ... into ignore list, ignoring for 10 seconds
>>> Sep 24 00:48:42 ideapad2 NetworkManager[433]: <info>  
>>> [1727128122.0377] device (wlp3s0f3u2i2): supplicant interface state: 
>>> completed -> disconnected
>>> Sep 24 00:48:45 ideapad2 NetworkManager[433]: <info>  
>>> [1727128125.6030] device (wlp3s0f3u2i2): supplicant interface state: 
>>> disconnected -> scanning
>>> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Removed 
>>> BSSID ... from ignore list (clear)
>>> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: SME: 
>>> Trying to authenticate with ... (SSID='...' freq=2472 MHz)
>>> Sep 24 00:48:50 ideapad2 kernel: wlp3s0f3u2i2: authenticate with ... 
>>> (local address=,,,)
>>> Sep 24 00:48:51 ideapad2 NetworkManager[433]: <info>  
>>> [1727128131.2488] device (wlp3s0f3u2i2): supplicant interface state: 
>>> scanning -> authenticating
>>> Sep 24 00:48:51 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 
>>> 1/3)
>>> Sep 24 00:48:51 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:52 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 
>>> 2/3)
>>> Sep 24 00:48:52 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:53 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 
>>> 3/3)
>>> Sep 24 00:48:53 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx 
>>> report from firmware
>>> Sep 24 00:48:54 ideapad2 kernel: wlp3s0f3u2i2: authentication with 
>>> ... timed out
>>> 
>>> After this all scans return nothing. The chip is still alive,
>>> though. The LED blinks during the scans (it's hardware-controlled)
>>> and another device in monitor mode can see the probe requests.
>>> 
>>> I confirmed that even C2H stop coming. I used aireplay-ng to send
>>> some authentication or association frames (can't remember) which
>>> require TX ACK report. I saw "failed to get tx report from firmware"
>>> and no C2H.
>>> 
>>> While qBittorrent is needed to trigger this bug, simply downloading
>>> a random Linux iso did not do the job. "Other" torrents did. It's
>>> unclear why. Maybe it's uploading that triggers the bug.
>>> 
>>> I left iperf3 running all day and nothing happened. Only qBittorrent
>>> can break it.
>>> 
>>> RTL8822CE doesn't have this problem. I can use qBittorrent with it
>>> just fine.
>>> 
>>> I mounted debugfs and dumped the MAC registers during a scan using
>>> this command:
>>> 
>>> for i in {00..20}; do sleep 0.5; cat 
>>> /sys/kernel/debug/ieee80211/phy2/rtw88/mac_{0..7} > dead-$i.txt; done
>>> 
>>> I thought maybe some RX URBs failed silently and rtw88 stopped
>>> sending them to the device (== stopped requesting data from it),
>>> but that's not the case. [1]
>>> 
>>> I have the device in this state right now. Is there anything else
>>> I should look at?
>> 
>> What hardware are you running on? This looks very similar to some 
>> issue me and some colleagues have seen from time-to-time when using 
>> LM842 (8822cu)[1][2][3], when running it on our i.MX6SX arm board. It 
>> has thou been harder and harder to trigger that issue on our board. 
>> But the outcome when it happens is identical to your. In our case we 
>> get it when running a number of mender streamed installations. We also 
>> can trigger something similar when doing hw-offload scanning, so we 
>> have disabled that in our setup. For us however it seems related to 
>> slower platforms, we haven't seen it on systems with better 
>> performance. Also it become a lot better when the USB RX aggregation 
>> was added to the chip + running with the patch in [3]. We also got it 
>> on LM808 (8812AU) then after suggestion we tried morrownr driver [4] 
>> with USB aggregation enabled and couldn't trigger it anymore. But 
>> feels like all these things are just ways to reduce the risk of 
>> getting into this state. So I think you just
>> found yet another way to reproduce the behavior. So hopefully that is 
>> the first step of finding the root cause of it. I will gladly help to 
>> test things in this area if you guys find something interesting.
>> 
>> [1] 
>> https://lore.kernel.org/all/20230526055551.1823094-1-petter@technux.se/t/
>> [2] 
>> https://lore.kernel.org/linux-wireless/20230616122612.GL18491@pengutronix.de/T/#t
>> [3] 
>> https://lore.kernel.org/linux-wireless/20230612134048.321500-1-petter@technux.se/
>> [4] https://github.com/morrownr/8812au-20210820
>> 
>>> 
>>> 
>>> [1] 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/realtek/rtw88/usb.c?h=v6.10.11&id=25eaef533bf3ccc6fee5067aac16f41f280e343e#n641
> 
> The hardware is a Lenovo Ideapad 3 15ADA6 with AMD Athlon Gold 3150U.
> 
> How does Mender handle the data transfers? Does it have something
> in common with torrents?

In my case I guess they behaves a bit the same, meaning that mender will 
sort of stream data, by downloading the os image in chunks and wire it 
to disk. So both the torrent and mender will most likely stress the 
network and system in a similar way by performing a lot of RX + disk I/O 
which seems to make the driver behaves bad after some time.

For me it feels like it easier to trigger the issue with mender updates 
when combining it with some tx traffic etc which I guess is happening 
when you use qbitorrent..


I will see if I can reproduce the issue using bitorrent also in some 
good way. Also after the usb aggregation changes I do not see issue with 
"failed to get tx report" that frequent. Instead its more often stuck 
with "firmware failed to leave lps state" but rest of the side-effects 
as you describe is the same.

INFO[0000] Native sector size of block device /dev/mmcblkX is 512 bytes. 
Mender will write in chunks of 1048576 bytes
.................[54407.626931] rtw_8822cu 1-1:1.2: firmware failed to 
leave lps state
[54408.136328] Bluetooth: hci0: urb fb582009 failed to resubmit (2)
[54408.622588] wlxxxxxxx: deauthenticating from e5:65:d5:35:95:d5 by 
local choice (Reason: 3=DEAUTH_LEAVING)
[54408.919367] rtw_8822cu 1-1:1.2: firmware failed to leave lps state

