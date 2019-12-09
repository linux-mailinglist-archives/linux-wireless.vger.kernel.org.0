Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8122D11763B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLITtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:49:10 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:37236 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:49:10 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ieP1o-00GSqj-G5; Mon, 09 Dec 2019 20:49:08 +0100
Message-ID: <283f52f854eb895b7da9d68a665b9679ba006d47.camel@sipsolutions.net>
Subject: Re: iw - set freq regression
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Dec 2019 20:49:07 +0100
In-Reply-To: <CAFED-jmt5BjTNQ=oQsSpTZRY115BsukCdhXTz-f-bBtin1PP7Q@mail.gmail.com> (sfid-20191209_204325_000067_F9F15227)
References: <CAFED-jmt5BjTNQ=oQsSpTZRY115BsukCdhXTz-f-bBtin1PP7Q@mail.gmail.com>
         (sfid-20191209_204325_000067_F9F15227)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-12-09 at 20:43 +0100, Janusz Dziedzic wrote:
> Hello,
> 
> For v4.9 this command works correctly:
> ./iw wlp1s0 set freq 5220 20 5220 0
> ./iw wlp1s0 set freq 5180 40 5190 0
> 
> With latest master this fail with err msg:
> Usage:    ./iw [options] dev <devname> set freq <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]
>     dev <devname> set freq <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]
> Options:
>     --debug        enable netlink debugging
> 
> After bisection and revert this one, works as before:
> 4871fcf iw: parse_freqs: check how many center frequencies to expect
> 
> I know we don't need to set this all arguments and finally I can change my script (don't set cf1/cf2).
> Anyway report this.

Thanks. Hmm. So ... dunno. It seems a bit more user-friendly to not have
the center_freq2, but OTOH having it as 0 at least won't really matter?

I think we needed this for e.g. handle_start_ap() to not be (quite as)
ambiguous since the chandef is followed by the beacon interval. If the
center2_freq is _always_ consumed by the chandef, then a beacon interval
of 200 would be like 200 MHz, and the result would fail here ...

So not really sure. I guess we could add another argument or check if
the last arg ('parsed') is non-NULL to change the behaviour, but is it
worth it?

johannes

