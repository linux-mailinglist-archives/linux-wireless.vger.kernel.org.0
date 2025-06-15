Return-Path: <linux-wireless+bounces-24108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BFADA339
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Jun 2025 21:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA116DAB5
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Jun 2025 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFF202C5D;
	Sun, 15 Jun 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="onLWW1Tt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C21448D5;
	Sun, 15 Jun 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750017291; cv=none; b=GDBuGPimQXYPmuwvUEHTYcYOE1f4Su0ukHKVlNjxlzKsW1b4EQgvDQ/ixEjXFwxPZ3Tou1ihfFjiuX/dYLwwAMBMHlpV3oJLBFKS2BZvhz47stfNcP4I/izEoPIoexOCgbIFqFg0doZO5Ac31cXKHLkGwCkgOTl4C8lsdJWD098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750017291; c=relaxed/simple;
	bh=EQw+hMkWJE87NJAgoJIJCHEItaPmmFQKnT9FyXdbP9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eH5tdfI9IR23sRbGWKDjvXa5yRD064Qw9LbLG01XTrOm+BfTu1i9fC0URnR6A9v4c9HxLrU+AzEwkhmowQZpiXbJquHmwqhk52jemp+L6kylrZ2AHdf0bIJSmT+lccin26SRmCR7X5bmfwtVtUp1XKDxcip0n+ViAGwATUyorj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=onLWW1Tt; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.21])
	by mail.ispras.ru (Postfix) with ESMTPSA id E19E3552F539;
	Sun, 15 Jun 2025 19:54:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E19E3552F539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1750017277;
	bh=nCgOc2TqwUreXv9EEKiRr6tldV30AHKoQMHNOS2HvUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=onLWW1TtvsYVsBhnmRDQxvl0WScB57uKkSjFDv19Fj0xQ1+Gbq9YuXHnoLcw8k38t
	 cGaKsyU4vQlsB4I8g+466mcxlzQV5FaVw6RyYXM/HTrdsqnrMY1MeeAUTib8ALeYV/
	 MZ+N1DGtRpHNsfp4i5FyEyJu3zSy7uiJ9au77Gek=
Date: Sun, 15 Jun 2025 22:54:37 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, linux-wireless@vger.kernel.org, 
	Christian Lamparter <chunkeey@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: carl9170: do not ping device which has failed to
 load firmware
Message-ID: <3qom4fkg7kp4l3bcgrbivmm2yi2wqrmso7rb5qe3xffjj3k7hz@nc7gx4atzfyq>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12719f87-ce87-4614-a34e-5f05efd55121@gmail.com>

It's better to be back to the original thread.  Sorry, I misclicked and
forgot to put In-Reply-To firstly.

That part of the broken thread:
https://lore.kernel.org/linux-wireless/y4ufvifcearf75qds5hlro3rfiadwfwlixz5xg3w6jjozk5sdg@7yyfsdvyehon/T/#u

Quoting your last reply there..

On Sat, 14 Jun 2025 18:33:28 +0200, Christian Lamparter wrote:
> Hi,
> 
> On 6/13/25 10:19 PM, Fedor Pchelkin wrote:
> > Dmitry Antipov wrote:
> >> Syzkaller reports [1, 2] crashes caused by an attempts to ping
> >> the device which has failed to load firmware. Since such a device
> >> doesn't pass 'ieee80211_register_hw()', an internal workqueue
> >> managed by 'ieee80211_queue_work()' is not yet created and an
> >> attempt to queue work on it causes null-ptr-deref.
> >>
> >> [1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
> >> [2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
> >> Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
> >> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> >> ---
> >>   drivers/net/wireless/ath/carl9170/usb.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> >> index a3e03580cd9f..a0bfa0c477ee 100644
> >> --- a/drivers/net/wireless/ath/carl9170/usb.c
> >> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> >> @@ -438,13 +438,18 @@ static void carl9170_usb_rx_complete(struct urb *urb)
> >>   
> >>   		if (atomic_read(&ar->rx_anch_urbs) == 0) {
> >>   			/*
> >> -			 * The system is too slow to cope with
> >> -			 * the enormous workload. We have simply
> >> -			 * run out of active rx urbs and this
> >> -			 * unfortunately leads to an unpredictable
> >> -			 * device.
> >> +			 * At this point, either the system is too slow to
> >> +			 * cope with the enormous workload (so we have simply
> >> +			 * run out of active rx urbs and this unfortunately
> >> +			 * leads to an unpredictable device), or the device
> >> +			 * is not fully functional after an unsuccessful
> >> +			 * firmware loading attempts (so it doesn't pass
> >> +			 * ieee80211_register_hw() and there is no internal
> >> +			 * workqueue at all).
> >>   			 */
> >>   
> >> +			if (WARN_ON_ONCE(!ar->registered))
> >> +				return;
> > 
> > Is WARN justifiable here if it concerns handling a predefined error
> > condition?
> 
> The driver has many more WARN_ON_(ONCE). Most of them are from "back in the day". I think
> carl9170 predates Syzkaller by something like 5 years or less.

Just the fact of presence of other WARNs in the driver is not usually a
pretext to add the new ones.  WARNs should be used to point out that
something is going wrong on the kernel level, i.e. be indicators of
kernel bugs (BUG and BUG_ONs are discouraged for the new code, if I
remember correctly).

> 
> In this case, it would be good to know if this only happens with syzkaller, or with some
> dogy device (be it the hci, or maybe the ar9170 device itself - they are getting old by now).
> I mean Garbage In => Garbage Out. But yes, it shouldn't crash.

The patch description lacks details on why Syzkaller does ever hit such a
situation, even taking into account that fuzzers love to exaggerate the
likelihood of hitting some weird and impossible-to-hit-in-practice stuff.

Dmitry, if you'd like to, please give some comments on the following..

The path in question is executed when carl9170_usb_submit_rx_urb() fails.
I didn't check the repro, only judging by driver code and crash report,
but presumably it fails due to usb_submit_urb() returning some -ENODEV
because the device is disconnected concurrently.  usb_submit_urb() errors
lead to &ar->rx_anch_urbs still remaining to have a zero value.

I think the key reason of the crash is that the device disconnection and
the URB completion callback - carl9170_usb_rx_complete() where the crash
occurs - have a race.

The logs say it's disconnected just before the crash:
[   87.100458][ T2990] usb 4-1: USB disconnect, device number 11
[   87.101369][    C1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
[   87.101407][    C1] KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]

So it looks like ar->registered being false here is a "correct" failure
condition, i.e. it can be expected when the certain phase of the driver
initialization fails and should be handled without any WARNs.

> 
> > I mean, yeah, it avoids a crash in the completion handler but kernels
> > with panic_on_warn - the ones which Syzkaller runs - will still stumble
> > here for no reason.
> 
> I bet there is already a precedence for this, if someone knows it or has previous decisions:
> Please join in!
> 
> Regards,
> Christian

