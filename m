Return-Path: <linux-wireless+bounces-24257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14998ADFA01
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55D7172825
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860FE7E9;
	Thu, 19 Jun 2025 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="iQZdtZb+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52194635
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750291607; cv=none; b=hYf5lT0d0/msWqgt4lyxdLWAwwY4/edGFmXpI2FKJwbu/ujxISa/g27qvYtLfa5CIH0UeHGKIA1Z5hkXji3Unj+kAKtqPmfVAMDQ3idQSme1cJ7Hyu6Rxs7Y1V5o26XjdIjrrCCvCQ0FqfBwmKebOj/j7zdq9riP4NQ0f5/ggKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750291607; c=relaxed/simple;
	bh=/XocijGvCyGCc2CnPOXGmvTukvrLadVhz0scEpBA+8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwctTOjr28vkxPJa2axibHEknN2wW5G+V9VHN+JComhNKXK6kDlMKaLM5Nn9EzbXKfhbuQ8SZseHQEKDiaF8elJet1tHhwUN1J1ag4LtTB1ZsWS9oTKOe5GpqzpmIzrCiYkUe9REyf8V0X8uNYiaUp0njkbYlvMKJSH0/AW9GA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=iQZdtZb+; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6D36C2C5AE7
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 23:48:26 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2511550009D;
	Wed, 18 Jun 2025 23:48:18 +0000 (UTC)
Received: from [172.31.0.20] (71-212-32-17.tukw.qwest.net [71.212.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 77AFB13C2B0;
	Wed, 18 Jun 2025 16:48:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 77AFB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1750290493;
	bh=/XocijGvCyGCc2CnPOXGmvTukvrLadVhz0scEpBA+8U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iQZdtZb+JXHTCYSF1xnW0oPG0mCI/0TT3JrxQENbuxou2l6usFjHLrGuf3ypTqli5
	 OvPha/BT3+sR2LrwWSApID6ks6SgcMJfhWWygrafAQy8y8140yqd/bZ8t1TGxIQ3EY
	 E/wPYByPC6tMjGe6WGXUSXN2e2nzACNsias9MEGI=
Message-ID: <248a9715-d2e4-4d01-aeb0-87fff55784b4@candelatech.com>
Date: Wed, 18 Jun 2025 16:48:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: problem: low wifi download/upload speed on AMD RZ717
To: =?UTF-8?Q?Ionu=C8=9B_Nicula?= <nicula.iccc@gmail.com>, nbd@nbd.name,
 lorenzo@kernel.org, ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
References: <CAHQvu9-jM+=t6VHM6XsK2nwjMv-xN=V4GTAV+Op7c=P737TWNQ@mail.gmail.com>
Content-Language: en-US
From: Alex Gavin <alex.gavin@candelatech.com>
In-Reply-To: <CAHQvu9-jM+=t6VHM6XsK2nwjMv-xN=V4GTAV+Op7c=P737TWNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1750290499-iHwyPT83lAm9
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1750290499;iHwyPT83lAm9;<alex.gavin@candelatech.com>;7b1dbd643cc93a487ba726540f27fdbe
X-PPE-TRUSTED: V=1;DIR=OUT;

Ionut:

I already posted on the Framework forum here [1], but reposting here for posterity. I tested w/ a 
MediaTek-chipset AP, but I'd be happy to try other chipsets if desired (the MikroTik hAP ac2 appears 
to be an older Qualcomm-based chipset).

I don’t have the Framework Laptop 13", AMD AI 300 Series, so take this with a grain of salt. I 
actually saw improvement with upstream stable 6.14.3 kernel compared to upstream stable 6.14.2.

Testing info below, but generally, performance seemed to improve with successive kernel versions 
(yay, stabilizing!). 6.15.2 with May firmware performed the best, so hopefully this improvement 
translates to the Framework platforms as well :)

My testing scenario includes the following:
- mt7925 radio in an Intel-based CPU system
- mt7996-based WiFi 7 AP (no MLO)
- AP configured to 40MHz at channel 36 (surprisingly unused where I’m at)
- Station configured to WPA2, no PMF (802.11w)
- Kernels built from tagged versions in the Linux stable tree
- Single-direction, 1Gbps-configured iperf3 UDP traffic with 10 parallel streams
   ('iperf3 --bind-dev wlan0 -b 1G -P 10 -u', add '-R' to do opposite direction)

I tested each of the following kernels with mt7925 firmware from March, April, and May (available in 
the Linux firmware repo on kernel.org). I skipped over a few 6.14 kernels, as there really aren’t 
many ‘mt76’ or ‘mt7925’ driver fixes/updates until 6.14.8 and 6.14.9 and none after.

- 6.14.2
- 6.14.3 (includes successive connection failing fix)
- 6.14.9 (includes IPv6 and multicast traffic drop fix)
- 6.15.2

For folks looking to reproduce or especially detailed info:

- Query driver and firmware information with 'ethtool -i wlan0' command
   (use '-S' instead for interface statistics)
- Link rate and related information (MCS, NSS) can be queried using the 'iw wlan0 link' command.
   Note that you’ll need to get a recent version to display EHT (WiFi 7) information.
   I like running it in a loop like 'watch -n .1 "iw wlan0 link"'
- wpa_supplicant config below ('wpa_supplicant -c wlan0.conf -i wlan0')
- Using a secondary sniffer radio, saw that 6.14.2 would not do upload traffic with block ACKs
   (frame aggregation) with all firmware versions. 6.14.3 did, though, which seemingly explains the
   substantial increase in upload throughput.

Supplicant config:
# Only used if you're also using 'wpa_cli'
ctrl_interface=/var/run/wpa_supplicant

network={
     # Need to use 'wpa_passphrase' to generate WPA2 'psk'
     # e.g. 'wpa_passphrase ssid password'
     ssid="ssid"
     psk=XXXXXXX

     # Can force to specific band using BSSID
     #bssid=xx:xx:xx:xx:xx:xx

     pairwise=CCMP
     key_mgmt=WPA-PSK
     ieee80211w=0
}

[1] 
https://community.frame.work/t/amd-ryzen-ai-300-not-fully-supported-by-linux-yet/70046/29?u=alex_gavin

-- 
Alex Gavin

On 6/7/25 14:21, Ionuț Nicula wrote:
> Hello!
> 
> I have some network issues on my new Framework 13 laptop [1] which is
> running an AMD AI 300 series CPU and the AMD RZ717 network card (which
> uses the mt7925e driver). In case it's relevant, I'm using a Mikrotik
> hAP ac2 router, running RouterOS 6.49.18.
> 
> I've tried some different Linux versions and these are my observations:
> 
> 1. From Linux 6.14.2 to 6.14.3 there seems to be a regression with
>     regards to download speed, but an improvement with regards to upload
>     speed. On 6.14.2 I'm getting 250Mbps download and 50Mbps upload. On
>     6.14.3 I'm getting 16Mbps download and 250Mbps upload.
> 2. On the other versions that I've tried, namely 6.14.6, 6.14.9, 6.14.10
>     and 6.15.1, the results are the same as on 6.14.3 -- low download
>     speed and good upload speed.
> 
> Note: the expected result is 200-300Mbps for both download and upload,
> which is what I get when I use USB tethering with my phone (connected to
> the same wireless network).
> 
> On the versions that come after 6.14.2, the WiFi is basically unusable.
> But on 6.14.2, like I said, the upload speed is low.
> 
> Some people [2] have reported that the RZ717 WiFi issues have improved
> around 6.14.7, but clearly this is not the case for my setup. So this
> issue might be router-dependent.
> 
> If you need other information that would be useful for
> investigating/solving this issue, let me know.
> 
> [1] https://frame.work/ro/en/laptop13
> [2] https://community.frame.work/t/amd-ryzen-ai-300-not-fully-supported-by-linux-yet/70046
> 


