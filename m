Return-Path: <linux-wireless+bounces-23362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5AAC229F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8877A6D16
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66634224243;
	Fri, 23 May 2025 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKoPvgui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7E227EBE
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003310; cv=none; b=izo1207RGWS+8e6CBotbGZghOtywy2Rhp6IuUfwrSqvzoMAAugr4EavytAEuDfkK9YGV2OuCWCMZvLkSY6OsaM3vA5XaOs21wRMfh2qF/Bm4lI9PYFtfezG51YD24vMes3sR2K9zq4Y+K/9+p/P5ESH4EgvNDtte24FGCx2vAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003310; c=relaxed/simple;
	bh=PCZ2v817MkVxDCN/h7289zEUDZkJ6xAdupup9TAn8uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZkfBX21ZYW3/CxsNZ2TiNUWErcz6uvqMwFLM4xJP8qDMOpubDakzGBWj756qCdudjzqgg5Z8GQILPlr5EKcTYWi9OhP7aapJvvDDKY/nSf0rm7kH+B7rMynIhFqWC2tma3NgS+N0e0Nlj9Qr15kFXcTl3hJYmEepCpZKNXW2j2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKoPvgui; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c96af71dso7375382b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748003308; x=1748608108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VD716zK/7CVITjuUnKgA9oHaQB2K3dBB9BwVz8Oc9Ss=;
        b=JKoPvguid5rySqVswEG8FfKO9xd7sWNyZlcRZ/ClwRPpO+fDld8u/prSRcXckWelme
         OGBAMxH0bLrUkgw4/8Ye03S6Q4/IY2Mq87o2JURASI3hmPXQilm4Xmc5odZ6myWAxJF1
         M2ZgEP3W8bO94iWap/u+H5pXq/Fjqzzz/c3lp29rug7br7Bq4JhuuabOzdKLzP7szaTf
         hLkhYIGIYKQFlGO2wnkr5FJdgxPyOwRVMGTW/m/uZsaBithkztIMACty6eiBZFH+5w5z
         4wFfVbv7t6UqH17pmO/C/liPighElhEWNoWOLKjhGZTCwSSZLdMJNnZWVoEU2xPVBrKq
         KqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748003308; x=1748608108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VD716zK/7CVITjuUnKgA9oHaQB2K3dBB9BwVz8Oc9Ss=;
        b=ZPQQv9GsDoXxVZZxXZkDwKl31e7aNWYzhn4cA6OAGeWCO3lpCla16fp+fj26WCVmHX
         L31E6GecmBLqKZC74sT7KOjmLbYXKNUvwfeacEj7vBe8bNgua6+0rb8gMCDxjKibKa3O
         N9SeSXBmVrS6c9UU39AhQhxyjH1DIHLsanX9+VvLK2+Gu7KTKnjQ9NsRppVY0bjYIjt2
         WOv4NPUnCnN0EJ4XBjPvKN4ci0Ejv/Gcsk+XHryAVR7WReQE6JSlbDJ9oKLIbQceF0Ip
         cWkHISUdRU+ISqid7yA84t0Hy4ELU/TAv6QKLAJvEJVQDiUffH6Lgr+ZdAlYXLMKiL4q
         SRiA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9jKrGYabPZzb5PvAkxLreeo2qftph/S+0w68MTK+/doCuSjSZ4QZ9wlVgq1RtLKqkDRa5n1NjURvlrhY/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5+EGALiq9RL/w53k0otJB2rzY/6JKp02PFCuFFwq9NSc1oD5
	bhSxY98raB/npXMpZDvKnmicGxo+CN+rwgzTVYlwfghcMXWrHnXIPrIR
X-Gm-Gg: ASbGnctkpkRyPhIFOM2e7CmX9ekkEVZMhnkGbfr7svJ8GsyzSsxfiM3o1LcnKaVCPCx
	rMdIfS+aZG8fzSQAjCxLoiKJl7ccs+mo/IwM9AqzuCPQNDEco+66VlTP1dy5o9gYNCZYaHlnEMi
	LJCPqijyWAj/BvkiBStod/vyn+hYcqZk/CvXS7UQkHuhjWJVcOW/u5l7C3tK4dFizHqI9a33qMu
	lUuArtXWp26m208mI0cx22a6u/2XOc8QKLfOaexnh8b3smKWQTNH+2mdXHF58/dUmVTH86Nehax
	VVf0guyPayWSbmnZ4miOyr/n7Z3NancbRx7BIrzIeP2XBhp239MrYj+Tj30P5kasjiqQjn3JGcF
	HAUwIz50g62wbdqcozCj42mYSQ5Ktxg==
X-Google-Smtp-Source: AGHT+IHe9G/u+uEoEYDrGyFzCsfoHfjVKFmm2i8dADPeZy0QefAsq4sFezYfELpsRaRNH+vHgf0p7Q==
X-Received: by 2002:a05:6a21:1349:b0:1f5:87dc:a315 with SMTP id adf61e73a8af0-2162189eee9mr42769791637.12.1748003307641;
        Fri, 23 May 2025 05:28:27 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm12693192b3a.88.2025.05.23.05.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 05:28:26 -0700 (PDT)
Message-ID: <56bcd608-bda2-40a8-9314-d978a39bf90f@gmail.com>
Date: Fri, 23 May 2025 05:28:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Association comeback delay behavior
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
 <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/23/25 4:59 AM, Johannes Berg wrote:
> Hi James,
>
>> 1. The kernel takes the delay in the association response frame and
>> waits, but has no sane bounds for how long the wait is. An AP could send
>> 0xffffffff and the kernel will just block for that entire duration.
> For some value of "block", it's not really blocking in the (traditional)
> threading sense of the word :)
Yes, true, its not blocking the kernel. Just blocks userspace unless 
that event is handled, which isn't handled by any userspace supplicants 
AFAICT.
>
>
>> 2. The first issue would appear to be guarded by the fact that
>> run_again() only reschedules if the new timeout is less than the current
>> time remaining but only if there is an existing timer set.
>>
>> Looking at the code, the association timer gets set when we begin an
>> association so it _should_ be set when we hit this comeback delay case.
>> But through testing I found that it is not. Hacking hostapd to use 10000
>> TU's as the comeback delay I see this:
>>
>> [    4.338185] wlan1: associate with 02:00:00:00:00:00 (try 1/3)
>> [    4.340023] wlan1: RX AssocResp from 02:00:00:00:00:00 (capab=0x411
>> status=30 aid=0)
>> [    4.340409] wlan1: 02:00:00:00:00:00 rejected association
>> temporarily; comeback duration 10000 TU (10240 ms)
>> [   14.654103] wlan1: associate with 02:00:00:00:00:00 (try 2/3)
>> [   14.657405] wlan1: RX AssocResp from 02:00:00:00:00:00 (capab=0x411
>> status=30 aid=0)
>> [   14.658430] wlan1: 02:00:00:00:00:00 rejected association
>> temporarily; comeback duration 10000 TU (10240 ms)
>> [   14.848706] wlan1: associate with 02:00:00:00:00:00 (try 3/3)
>> [   14.851596] wlan1: RX AssocResp from 02:00:00:00:00:00 (capab=0x411
>> status=30 aid=0)
>> [   14.854269] wlan1: 02:00:00:00:00:00 rejected association
>> temporarily; comeback duration 10000 TU (10240 ms)
>>
>> So the first association attempt waited the full 10 seconds, then after
>> that the timer was presumably set, and we only waited the default 200ms
>> (ASSOC_TIMEOUT).
> That's not exactly how it works, run_again() multiplexes different
> things onto the same timer by tracking the various sources. So the
> _timer_ might be expiring again, but the actual "assoc handling" part
> should only happen after 10000 TU.
>
>> So to me, this feels like either a bug
> Yes. I can't reproduce it though:
>
> [    4.300000] wlan0: authenticate with 02:00:00:00:00:00 (local address=92:9c:4c:00:00:01)
> [    4.300000] wlan0: send auth to 02:00:00:00:00:00 (try 1/3)
> [    4.300000] wlan0: authenticated
> [    4.310000] wlan0: associate with 02:00:00:00:00:00 (try 1/3)
> [    4.310000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [    4.310000] wlan0: 02:00:00:00:00:00 rejected association temporarily; comeback duration 10000 TU (10240 ms)
> [   14.560000] wlan0: associate with 02:00:00:00:00:00 (try 2/3)
> [   14.560000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [   14.560000] wlan0: 02:00:00:00:00:00 rejected association temporarily; comeback duration 10000 TU (10240 ms)
> [   25.440000] wlan0: associate with 02:00:00:00:00:00 (try 3/3)
> [   25.440000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [   25.440000] wlan0: 02:00:00:00:00:00 rejected association temporarily; comeback duration 10000 TU (10240 ms)
> [   36.320000] wlan0: association with 02:00:00:00:00:00 timed out
>
>
> That last "timed out" should really come earlier though, oops. Let me
> fix that:
>
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index fa7cf3b8ad59..f4a5deedfaab 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -6383,7 +6383,8 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
>   
>   	if (status_code == WLAN_STATUS_ASSOC_REJECTED_TEMPORARILY &&
>   	    elems->timeout_int &&
> -	    elems->timeout_int->type == WLAN_TIMEOUT_ASSOC_COMEBACK) {
> +	    elems->timeout_int->type == WLAN_TIMEOUT_ASSOC_COMEBACK &&
> +	    assoc_data->tries < IEEE80211_ASSOC_MAX_TRIES) {
>   		u32 tu, ms;
>   
>   		cfg80211_assoc_comeback(sdata->dev, assoc_data->ap_addr,
>
>
> So now I see:
>
> [    4.300000] wlan0: authenticate with 02:00:00:00:00:00 (local address=92:9c:4c:00:00:01)
> [    4.300000] wlan0: send auth to 02:00:00:00:00:00 (try 1/3)
> [    4.300000] wlan0: authenticated
> [    4.310000] wlan0: associate with 02:00:00:00:00:00 (try 1/3)
> [    4.310000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [    4.310000] wlan0: 02:00:00:00:00:00 rejected association temporarily; comeback duration 10000 TU (10240 ms)
> [   14.560000] wlan0: associate with 02:00:00:00:00:00 (try 2/3)
> [   14.560000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [   14.560000] wlan0: 02:00:00:00:00:00 rejected association temporarily; comeback duration 10000 TU (10240 ms)
> [   25.440000] wlan0: associate with 02:00:00:00:00:00 (try 3/3)
> [   25.440000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [   25.440000] wlan0: 02:00:00:00:00:00 denied association (code=30)
>
>>    - If the timer being unset is expected, the kernel should be limiting
>> this wait to something reasonable.
> Define "reasonable"? I mean, sure, if it says 0xffffffff we'll even
> overflow the calculation and end up trying way too early, and if it says
> 0x100000 instead to avoid the overflow inside the calculation and in
> jiffies, we'll wait a very long time:
>
> [    4.300000] wlan0: authenticate with 02:00:00:00:00:00 (local address=92:9c:4c:00:00:01)
> [    4.300000] wlan0: send auth to 02:00:00:00:00:00 (try 1/3)
> [    4.300000] wlan0: authenticated
> [    4.310000] wlan0: associate with 02:00:00:00:00:00 (try 1/3)
> [    4.310000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=0x401 status=30 aid=0)
> [    4.310000] wlan0: 02:00:00:00:00:00 rejected association temporarily; comeback duration 1048576 TU (1073741 ms)
> [ 1078.240000] wlan0: associate with 02:00:00:00:00:00 (try 2/3)
> [ 1078.240000] wlan0: deauthenticated from 02:00:00:00:00:00 while associating (Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA)
>
> Long enough, in fact, that hostapd forgot the STA even existed ;-)
>
>
>> I also realize that CMD_ASSOC_COMEBACK was added and userspace gets
>> notified, but this feels excessive to handle in userspace when the
>> kernel could instead enforce a sane timeout all on its own without
>> requiring userspace disconnect/reconnect when the AP sends an absurd
>> timeout.
> Define "absurd". Bigger than around what I was demonstrating above
> doesn't actually work properly anyway due to the possible overflows, and
> sure, 15 minutes is long, but doesn't feel "absurd".
>
> I tend to think this is exactly right - the kernel will wait, but since
> it's not doing anything else that doesn't really matter. Maybe it'll
> work later (earlier tests above), maybe it won't (like when the AP
> forgot about the STA above), but it's not like the kernel is holding
> some important resource busy for all that time?
>
> And userspace gets notified and gets a choice, so of course it can give
> up on the association instead.
>
> And yeah I did "iw connect -w" and it'd be hard to actually work around
> it with that, but it could even make the assoc socket-owned and then
> it'd probably stop when you hit Ctrl-C, and anyway nobody really uses
> that.
>
>
>> My main concern here is a rouge AP scenario that can then DoS all your
>> clients that try and connect to it.
> Oh, so you're just trying to sell us a missing implementation in iwd as
> a kernel security bug? :-)
Depends on how you look at it I guess. Handling the event in userspace 
almost feels like an escape hatch for the kernel having used untrusted 
input but that's just how I see it. Waiting 15 minutes for a WiFi 
connection that should take 200ms is on the level of absurd and 
unreasonable from my view, but that's just my opinion. But it sounds 
like this is all by design, so we can just handle the event in userspace.
>
> johannes

