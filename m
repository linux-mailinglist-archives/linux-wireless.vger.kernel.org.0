Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9081181513
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 10:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgCKJgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 05:36:19 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45658 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKJgT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 05:36:19 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBxmi-000w5d-SV; Wed, 11 Mar 2020 10:36:16 +0100
Message-ID: <75fcee24b6eacd59473731087f854dfc451cab40.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] nl80211: add monitor mode scan feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org
Date:   Wed, 11 Mar 2020 10:36:15 +0100
In-Reply-To: <91e4b8c4-5fc3-536f-9209-124b0cfc230f@tu-ilmenau.de>
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
         <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
         <91e4b8c4-5fc3-536f-9209-124b0cfc230f@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-03-04 at 10:30 +0100, Markus Theil wrote:
> 
> I used this patchset for some time to build a combined monitoring and
> channel survey tool.
> A mt76 based USB dongle is used, because mt76 supports the channel
> survey cmd which yields the channel's busy time.
> At the same time, the tool listens for beacons over the monitor
> interface to log available networks and their RSSI to the user.
> When the user changes into heatmap mode, he can issue active scan
> requests at different points on the floor plan. All of this this
> can be done with a single interface in monitor mode. I change the
> frequency of the monitoring interface periodically to passively listen
> at other channels.
> 
> nl80211 is able to receive scan results in my setup. "iw dev $MON_IF
> scan" also works as expected.
> 
> A combination of an unassociated STA VIF and a monitor VIF (scan on STA
> VIF, receive Wi-Fi frames on monitor VIF) does not work, because
> I cannot freely set the channel on an unassociated STA VIF. Trying to
> set the operating frequency on the monitor VIF also fails, when the STA
> VIF is up.
> Bringing the STA VIF up would be needed for scanning on it.
> 
> Therefore this patches solved my solely monitoring-oriented use-case.

Yeah, I kinda see where you're coming from, but I still don't think this
makes a lot of sense. I'm actually surprised that "iw dev mon scan"
works (in that it prints results) - would have expected the results to
just go nowhere?

And as you say, you're actually sending probe requests here, while you
cannot even set the MAC address properly on a radiotap monitor
interface.

I don't really think we should mix all these concepts, the more things
we try to allow in monitor mode, the more confusing that becomes (is it
active now? or passive?)

johannes

