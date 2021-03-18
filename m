Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714FC340ACD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhCRRB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 13:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCRRBD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 13:01:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57FC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 10:01:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMw17-000ERX-Ut; Thu, 18 Mar 2021 18:01:02 +0100
Message-ID: <8cb6896efc94008f4862ae94375f67cd1b379dcd.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim: wrong tx/rx bitrate when width != 20MHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 18 Mar 2021 18:01:01 +0100
In-Reply-To: <CAK8U23bTXsJrCLbAOMB+qk5ZPrnaTOoncA3Xe=HGNBPwkNkc1g@mail.gmail.com> (sfid-20200930_042153_224585_BA641453)
References: <CAK8U23bTXsJrCLbAOMB+qk5ZPrnaTOoncA3Xe=HGNBPwkNkc1g@mail.gmail.com>
         (sfid-20200930_042153_224585_BA641453)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-29 at 23:21 -0300, Ramon Fontes wrote:
> I'm running 2 virtual interfaces: one in master mode with hostapd
> (802.11n in 40MHz) and the other one in managed mode.
> 
> I can confirm that the AP is working on 40MHz:
> 
> ap1 iw dev ap1-wlan1 info
> Interface ap1-wlan1
> ifindex 221
> wdev 0x6c00000001
> addr 02:00:00:00:02:00
> ssid new-ssid
> type AP
> wiphy 108
> channel 3 (2422 MHz), width: 40 MHz, center1: 2432 MHz
> txpower 14.00 dBm
> 
> as well as the client:
> 
> sta1 iw dev sta1-wlan0 info
> Interface sta1-wlan0
> ifindex 219
> wdev 0x6a00000001
> addr 00:00:00:00:00:02
> ssid new-ssid
> type managed
> wiphy 106
> channel 3 (2422 MHz), width: 40 MHz, center1: 2432 MHz
> txpower 14.00 dBm
> 
> However, tx/rx bitrates of the client are not equivalent to the 40 MHz
> channels. Only the MCS index seems to be ok and I can change it via
> iw.

You are setting it fixed? What if set the bandwidth too?

Or maybe that's not implemented right?

I was going to say that for rate scaling there's no requirement to pick
40MHz, although there's no reason (especially in hwsim) for it to pick
anything else either, so that's a bit odd.

> For some reason I can see the correct tx/rx bitrate right at the
> beginning of the association (e.g. tx bitrate: 270.0 MBit/s MCS 15
> 40MHz), but right after that they change to 20 MHz. I have been trying
> to identify errors in mac80211_hwsim, but I was not successful. Can
> anybody help me? I did tests with/without wmediumd and the results are
> the same.

Now I'm confused - you said here "they change", but above you set you
were actually setting them fixed? So they should change?

If you do nothing fixed, what happens?

johannes

