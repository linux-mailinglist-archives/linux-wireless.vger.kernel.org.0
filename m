Return-Path: <linux-wireless+bounces-19712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86BA4C4E2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6377A9B63
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25482153E2;
	Mon,  3 Mar 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4CNAVc8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE32147F3
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015165; cv=none; b=St2RunAanMFJ3zFwFUqGZvd7nQWgbN2YVhRCJ35l3uHgZQzmyNBVcPflu4D8OHoikq1NrLdeI6S11ZqOm+3/3TBr9gPUYJU0rEiu0+6FlKcBawXhh/doHnDajJhY6gaaAOqS2EOtw5tjC2QwuaVHp4Xr5LzTHpMkIHh9tBa0vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015165; c=relaxed/simple;
	bh=1wkDWTo6UDspkIQ2f1VsP5w/YfI2tXLWuZDGQuM90qw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S5/qktWP0zaEmmeMSLNP6MEj/gI+I50X6BMrgxxb/bsCgoflxDWaeMx4asBfgWMbwI8dSsPs40tc8cH3RoXdSGePshjxOT1YqGbgUXYKz63zsWCOOY3misrmbezrXeIWXuF/lZq/1BLUQx34Drb7a6gSCc4CxBsY0bk4hbCeBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4CNAVc8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223480ea43aso113789395ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015163; x=1741619963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWIXuPc4m1eeN4AwHgo8V/KdIHX8Pn3/CGz7RPYywtw=;
        b=j4CNAVc8ZkcFlMB0DZFEDGywshWp2E7mPkLWsgANrdL5Nw2gMfnKJAyQYWYTypQcG9
         NwoChCHC5KHjLj6o3AFnlE1Q5uqviYAjM0RT1LNemOdtojov3LMkzMEK4064p88J/TfW
         6+uwgPUxkdwSN+eQnbj0j0YZcGjTESvnxunulG4YQg1DHnIzO74U3q4975Bmls9nCkrL
         OkC3hYdeVNl3izKWl9P4hrAiRZ9q0PLHeQjbVdaV+y9hoil3fftNrfbr3I/joDlxVOU5
         QlVsO+DtST2fBVpf536GXxHa8lsH2DNF3mekR242tSoL7OwhRtpIEW+HkfS8aqIbNwah
         zbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015163; x=1741619963;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWIXuPc4m1eeN4AwHgo8V/KdIHX8Pn3/CGz7RPYywtw=;
        b=K/k9mXXAC+DJx4R57p0GAXWjXqvhG50BR4qHkWf2xHycEHyYQZIlCWi/OGtvHHJprL
         ZpzoPYdMHG5xJx1TN90/B5bq2Us6FoIHcmKsAe76WL+sbUujL663ikgo3iYa88FYn0I5
         QNkf9vThMJTujTMM7DHFKPcaI0XB7egm7835MjrvkrzJNWHwBAovX7CVhTT4agKHoIpP
         qHJFOkn6ZCxHDDl47Hb8XmUFeo+A99B05b6M7swc3+Lbzy7SZhSszoe6F5yA4Lb4HGDF
         pETVDpHAPcuhJpUJzo7Cp6ocq4et/E3uTVWTmJutsz3ao6yf/SUeQ9flwU1JSd721BsO
         9oGg==
X-Gm-Message-State: AOJu0YwopB5KpzsQ88B3uxxY8ktuUyg1mQ9FtxT4q3+sXRA+tbNKKmvZ
	fY8LXkS9gbycJNoCe2ZC6Uine7MSVnu2o6kmmRjcupN3ym2KbwVbDMM8uA==
X-Gm-Gg: ASbGnctGxI4U2Yd1Wwrt3ZeMYUcj154jLCDyRHwn8y/4CwD91yDhuHkjJejNsu0IIGh
	6Wkosem3mW++RnVmZGYyzWDNFEjJzj8A25Wum/zNni4qF7PifAA+byu01XjZGeH71UbSR0bx08r
	6MAsi9mkzpizzVzFFYRxmARlJNCFeqmnNuuQEt/hGyJfELuNxVwsuozPiaccu+cAZbtt356oGtN
	ufIc/Wksh3qKAEG/fGGQR/rHTX2WW7qK5hEDiTrpJw9z8KP1hnjBv3uYbcuaoZcrtcZs8pgnWnv
	0uu1tIQzrK/3tf8sqz1Yh9vFFodOEQm8Gakf0A7KuKzpuPfV
X-Google-Smtp-Source: AGHT+IElZ7MSRul6VnOUi3YIAcx+W0OWu4AJQ8VE2nVgWZeXyyB6RkpCRTVGIzMizYQwknZJO3BWwg==
X-Received: by 2002:a05:6a00:ad0:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-734ac36d76dmr22319128b3a.11.1741015162760;
        Mon, 03 Mar 2025 07:19:22 -0800 (PST)
Received: from [10.100.120.127] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736512c5694sm2594945b3a.179.2025.03.03.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 07:19:22 -0800 (PST)
Message-ID: <62a3f906-d16d-42ed-9a72-aaeb81499098@gmail.com>
Date: Mon, 3 Mar 2025 07:19:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection timeouts (NL80211_TIMEOUT_UNSPECIFIED) after
 disconnect/association timeout
From: James Prestwood <prestwoj@gmail.com>
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: ath10k@lists.infradead.org,
 "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <441e9883-1efc-498b-ba33-6a4f12443f3b@gmail.com>
Content-Language: en-US
In-Reply-To: <441e9883-1efc-498b-ba33-6a4f12443f3b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Still seeing this, and I think I've uncovered a bit more info. I'm going 
to add some additional debugging to confirm, but it appears for some 
reason the kernel's BSS list does not contain the BSS (or in some cases 
any BSS's) we are trying to connect to. I'll go over the sequence of 
events again:

1. Client gets deauthenticated for whatever reason

Feb 27 22:43:58 kernel: wlan0: deauthenticated from **:**:**:22:60:7c 
(Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA)

2. Client issues a scan to reconnect, note that it clearly sees the 
following BSS's after scanning:

Feb 27 22:43:58 iwd[457]: src/station.c:station_print_scan_bss() 
Processing BSS '**:**:**:22:40:92' with SSID: <redacted>, freq: 5300, 
rank: 1702, strength: -5900, data_rate: 173.3, snr: 40, load: 21/255
Feb 27 22:43:58 iwd[457]: src/station.c:station_print_scan_bss() 
Processing BSS '**:**:**:1c:10:98' with SSID: <redacted>, freq: 5500, 
rank: 1418, strength: -6300, data_rate: 144.4, snr: 33, load: 37/255

3. Client tries to connect to **:**:**:22:40:92

Feb 27 22:43:58 iwd[457]: event: connect-info, ssid: <redacted>, bss: 
**:**:**:22:40:92, signal: -59, load: 21/255
Feb 27 22:43:58 iwd[457]: event: state, old: autoconnect_quick, new: 
connecting (auto)

4. Based on the IWD logging it appears the kernel has no BSS record, and 
tries to issue a scan (the scan was definitely not from IWD), but 
apparently comes up with nothing:

Feb 27 22:43:58 iwd[457]: src/scan.c:scan_notify() Scan notification 
Trigger Scan(33)
Feb 27 22:43:59 iwd[457]: src/scan.c:scan_notify() Scan notification New 
Scan Results(34)
Feb 27 22:43:59 iwd[457]: src/netdev.c:netdev_mlme_notify() MLME 
notification Connect(46)
Feb 27 22:43:59 iwd[457]: src/netdev.c:netdev_connect_event()
Feb 27 22:43:59 iwd[457]: src/netdev.c:netdev_connect_event() aborting 
and ignore_connect_event not set, proceed
Feb 27 22:43:59 iwd[457]: event: connect-timeout, reason: 0

The timeout reason 0 is NL80211_TIMEOUT_UNSPECIFIED.

5. IWD proceeds to the next BSS, which the kernel also needs to scan 
for, but succeeds:

Feb 27 22:43:59 iwd[457]: event: connect-info, ssid: <redacted>, 
bss: **:**:**:1c:10:98, signal: -63, load: 37/255
Feb 27 22:43:59 iwd[457]: src/station.c:station_try_next_bss() 
Attempting to connect to next BSS **:**:**:1c:10:98
Feb 27 22:43:59 iwd[457]: src/netdev.c:netdev_link_notify() event 16 on 
ifindex 5
Feb 27 22:43:59 iwd[457]: src/scan.c:scan_notify() Scan notification 
Trigger Scan(33)
Feb 27 22:43:59 iwd[457]: src/scan.c:scan_notify() Scan notification New 
Scan Results(34)
Feb 27 22:43:59 iwd[457]: src/netdev.c:netdev_link_notify() event 16 on 
ifindex 5
Feb 27 22:43:59 iwd[457]: src/netdev.c:netdev_mlme_notify() MLME 
notification New Station(19)
Feb 27 22:43:59 kernel: wlan0: authenticate with **:**:**:1c:10:98 
(local address=**:**:**:a2:a4:58)
Feb 27 22:43:59 kernel: wlan0: send auth to **:**:**:1c:10:98 (try 1/3)

So it would appear to me that despite the original scan that IWD issued 
which clearly showed both BSS's the kernel's BSS list did not contain 
those entries. In both cases above the kernel needed to scan for the 
requested BSS. Anything we can do on the supplicant side? I figured an 
explicit scan by the supplicant would surely populate the kernel's BSS 
list, but apparently in some cases it does not?

Thanks,

James

On 12/4/24 8:57 AM, James Prestwood wrote:
> Hi,
>
> I noticed this behavior where in some cases if the client gets 
> disconnect or fails to roam due to an association timeout the next 
> connection attempt will fail with a timeout of 
> NL80211_TIMEOUT_UNSPECIFIED as the reason. Briefly looking at the 
> kernel code in nl80211/sme.c:cfg80211_conn_do_work() this appears to 
> be the default value passed in, so its hitting one of the cases that 
> aren't auth/assoc related. There are no kernel logs when this happens. 
> The supplicant fails multiple times continuing to iterate BSS's until 
> it finally is able to connect a few seconds later. In some _very_ rare 
> cases I have seen the client never able to reconnect to any BSS's, it 
> just loops over all BSS with the same NL80211_TIMEOUT_UNSPECIFIED 
> error indefinitely until a customer notices and reboots the client.
>
> I see this behavior on kernel 6.2 and 6.8 (that's all our clients run 
> at the moment) and on both ath10k and ath11k drivers. I'm not able to 
> get this to happen with mac80211_hwsim fwiw. Prior to switching to 6.2 
> (and 6.8) we were on 5.15 and I never saw this happen.
>
> Below are some logs from the kernel and IWD. Lots of irrelevant lines 
> have been removed to be more concise.
>
> tl;dr
>
> 1. Got an association timeout attempting to roam, disconnected
>
> 2. Scanned (~1 second), plenty of available BSS's
>
> 3. Failed to connect to 4 different BSS's in a row with 
> NL80211_TIMEOUT_UNSPECIFIED ("reason: 0")
>
> 4. Failed to connect to the next BSS with an auth timeout (no issue 
> here, this just happens sometimes)
>
> 5. Finally able to connect to another BSS (oddly, the original BSS we 
> were roaming away from)
>
>
> Dec 04 11:42:34 iwd[391]: event: roam-info, bss: **:**:**:13:06:ea, 
> signal: -87, load: 63/255
> Dec 04 11:42:34 iwd[391]: event: state, old: connected, new: ft-roaming
> Dec 04 11:42:34 kernel: wlan0: disconnect from AP **:**:**:13:07:b6 
> for new assoc to **:**:**:13:06:ea
> Dec 04 11:42:34 kernel: wlan0: associate with **:**:**:13:06:ea (try 1/3)
> Dec 04 11:42:34 kernel: wlan0: associate with **:**:**:13:06:ea (try 2/3)
> Dec 04 11:42:34 kernel: wlan0: associate with **:**:**:13:06:ea (try 3/3)
> Dec 04 11:42:34 kernel: wlan0: association with **:**:**:13:06:ea 
> timed out
> Dec 04 11:42:34 iwd[391]: src/netdev.c:netdev_associate_event()
> Dec 04 11:42:34 iwd[391]: event: association-timeout,
> Dec 04 11:42:34 iwd[391]: event: state, old: ft-roaming, new: 
> disconnected
> Dec 04 11:42:34 iwd[391]: event: state, old: disconnected, new: 
> autoconnect_quick
> Dec 04 11:42:34 iwd[391]: src/station.c:station_quick_scan_triggered() 
> Quick scan triggered for wlan0
> Dec 04 11:42:35 iwd[391]: src/scan.c:scan_notify() Scan notification 
> New Scan Results(34)
> Dec 04 11:42:35 iwd[391]: src/netdev.c:netdev_link_notify() event 16 
> on ifindex 5
> Dec 04 11:42:35 iwd[391]: event: connect-info, ssid: <redacted>, bss: 
> **:**:**:12:fc:f8, signal: -56, load: 65/255
> Dec 04 11:42:35 iwd[391]: event: state, old: autoconnect_quick, new: 
> connecting (auto)
> Dec 04 11:42:35 iwd[391]: event: connect-timeout, reason: 0
> Dec 04 11:42:35 iwd[391]: event: connect-info, ssid: <redacted>, bss: 
> **:**:**:12:fd:56, signal: -62, load: 69/255
> Dec 04 11:42:36 iwd[391]: event: connect-timeout, reason: 0
> Dec 04 11:42:36 iwd[391]: event: connect-info, ssid: <redacted>, bss: 
> **:**:**:13:08:33, signal: -60, load: 53/255
> Dec 04 11:42:36 iwd[391]: event: connect-timeout, reason: 0
> Dec 04 11:42:36 iwd[391]: event: connect-info, ssid: <redacted>, bss: 
> **:**:**:12:fd:34, signal: -67, load: 43/255
> Dec 04 11:42:36 iwd[391]: event: connect-timeout, reason: 0
> Dec 04 11:42:36 kernel: wlan0: authenticate with **:**:**:13:07:b6
> Dec 04 11:42:36 iwd[391]: event: connect-failed, status: 1
> Dec 04 11:42:36 iwd[391]: event: connect-info, ssid: <redacted>, bss: 
> **:**:**:13:07:b6, signal: -70, load: 28/255
> Dec 04 11:42:36 iwd[391]: src/station.c:station_try_next_bss() 
> Attempting to connect to next BSS **:**:**:13:07:b6
> Dec 04 11:42:36 kernel: wlan0: send auth to **:**:**:13:07:b6 (try 1/3)
> Dec 04 11:42:36 kernel: wlan0: send auth to **:**:**:13:07:b6 (try 2/3)
> Dec 04 11:42:36 kernel: wlan0: authenticated
> Dec 04 11:42:36 kernel: wlan0: associate with **:**:**:13:07:b6 (try 1/3)
> Dec 04 11:42:36 kernel: wlan0: RX AssocResp from **:**:**:13:07:b6 
> (capab=0x1511 status=0 aid=3)
>
>
> While writing this email I also saw it happen live while I had a 
> mac80211/cfg80211 trace running. In this recent case it failed on 12 
> consecutive BSS's with the unspecified timeout. That trace log is 
> attached, maybe could shed more light on this.
>
> Thanks,
>
> James

