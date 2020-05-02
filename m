Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33331C287E
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgEBWB5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 May 2020 18:01:57 -0400
Received: from pd.grulic.org.ar ([200.16.16.187]:49886 "EHLO pd.grulic.org.ar"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgEBWB4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 May 2020 18:01:56 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 May 2020 18:01:55 EDT
Received: from localhost (82-64-204-19.subs.proxad.net [82.64.204.19])
        by pd.grulic.org.ar (Postfix) with ESMTPSA id 7638723F33
        for <linux-wireless@vger.kernel.org>; Sat,  2 May 2020 18:55:34 -0300 (-03)
Date:   Sat, 2 May 2020 23:55:21 +0200
From:   Marcos Dione <mdione@grulic.org.ar>
To:     linux-wireless@vger.kernel.org
Subject: Channel turns from usable to NO-IR in a few minutes
Message-ID: <20200502215521.GA11574@diablo.grulicueva.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


First of all, I'm not suscribet to the list, so please CC: me on an
answres, please.

I have a self built Linux router with a wifi card that I had setup a year
ago or more as an AP. I worked for some 8 months without an issue, until
a few months back (I have no date) it just stooped working.

It took me a while to look into it, but finally today I got it working on
channel 44 on the 5GHz band. I chose that channel because it was the only
one available according to hostapd:

    nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220 5240[NO_IR] 
                                5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 
                                5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 
                                5500[DISABLED][NO_IR][RADAR] 
                                5520[DISABLED][NO_IR][RADAR]

Because I got greedy, I wanted to keep configuring it to try to get 40GHz
in the channel 46, but when I tried to run it again, I got:

    nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 
                                5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 
                                5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 
                                5500[DISABLED][NO_IR][RADAR] 
                                5520[DISABLED][NO_IR][RADAR]
    Channel 44 (primary) not allowed for AP mode, flags: 0x2073 NO-IR

There was no package updates in between, they might have been some 5 to
10 minutes. The router was not rebooted, and has been connected to
internet ever since I set it up initially a year ago. The country
regulatory information is for France:

    nl80211: Regulatory information - country=FR (DFS-ETSI)
    nl80211: 2402-2482 @ 40 MHz 20 mBm
    nl80211: 5170-5250 @ 80 MHz 20 mBm
    nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS)
    nl80211: 5490-5710 @ 160 MHz 27 mBm (DFS)
    nl80211: 57000-66000 @ 2160 MHz 40 mBm

What could have happened, and could I somehow revert this?


-- 
(Not so) Random fortune:
The technology industry sees itself as in rebellion against corporate
America: not corrupt, not buttoned-up, not empty. In fact, a tech company
can be as corrupt, soulless, and empty as any corporation, but being
unprofessional helps us maintain the belief that we are somehow different
from Wall Street.
	    -- Shanley Kane
