Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA89B6B2398
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCIMBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 07:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCIMBJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 07:01:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157FDC0A6
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 04:01:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1paExA-0000Fl-K8; Thu, 09 Mar 2023 13:01:00 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1paEx8-0008OS-Tk; Thu, 09 Mar 2023 13:00:58 +0100
Date:   Thu, 9 Mar 2023 13:00:58 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Performance of rtw88_8822bu
Message-ID: <20230309120058.GF5784@pengutronix.de>
References: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
 <20230306091845.GC27249@pengutronix.de>
 <20230306125944.GD27249@pengutronix.de>
 <6ed1239f8c404dcb9d571771c230b69b@realtek.com>
 <2064a549-ef7a-98bf-cc24-a25b8571877f@lwfinger.net>
 <1f01b1ff59d7412aa7eafdce022d7635@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f01b1ff59d7412aa7eafdce022d7635@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 08, 2023 at 12:36:15AM +0000, Ping-Ke Shih wrote:
> 
> 
> > -----Original Message-----
> > From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
> > Sent: Tuesday, March 7, 2023 10:44 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>; Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: linux-wireless <linux-wireless@vger.kernel.org>
> > Subject: Re: Performance of rtw88_8822bu
> > 
> > On 3/6/23 19:39, Ping-Ke Shih wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Sascha Hauer <s.hauer@pengutronix.de>
> > >> Sent: Monday, March 6, 2023 9:00 PM
> > >> To: Larry Finger <Larry.Finger@lwfinger.net>
> > >> Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless <linux-wireless@vger.kernel.org>
> > >> Subject: Re: Performance of rtw88_8822bu
> > >>
> > >> On Mon, Mar 06, 2023 at 10:18:45AM +0100, Sascha Hauer wrote:
> > >>> Hi Larry,
> > >>>
> > >>> On Sat, Mar 04, 2023 at 08:52:26PM -0600, Larry Finger wrote:
> > >>>> Sascha an Ping-Ke,
> > >>>>
> > >>>> I have been testing the RTW8822BU driver found in my rtw88 GitHub repo. This
> > >>>> code matches the code found in wireless-next. I created 9 files of 5.8 GiB
> > >>>> each and used a for loop to copy them from the test computer to/from my
> > >>>> server. The wireless connection is on the 5 GHz band (channel 153) connected
> > >>>> to an ax1500 Wifi 6 router, which in turn is connected to the server via a
> > >>>> 1G ethernet cable. The connection has not crashed, but I see strange
> > >>>> behavior.
> > >>>
> > >>> What chipset are you using? Is it a RTL8822bu or some other chipset
> > >>> reported by the driver?
> > >>>
> > >>>>
> > >>>> With both TX and RX, the rate is high at 13.5 MiB/s for RX and 11.1 MiB/s
> > >>>> for TX for about 1/3 of the time, but then the driver reports "timed out to
> > >>>> flush queue 3" and the rate drops to 3-5 MiB/s for RX and 2-3 MiB/s for TX.
> > >>>> These low rates are in effect for 2/3 of the time. The 5G bands are
> > >>>> relatively unused in my house, thus I do not suspect interference.
> > >>>
> > >>> I've received a very similar report this weekend. About 3-4 messages per
> > >>> second, "timed out to flush queue 3", but driver continues to work.
> > >>> I've also seen it this morning by accident and once again while writing
> > >>> this mail. This was on a RTL8821CU.
> > >>>
> > >>> So far I have no idea what the problem might be.
> > >>
> > >> The "timed out to flush queue %d\n" message comes from
> > >> __rtw_mac_flush_prio_queue(). Here some registers are read which show
> > >> the number of reserved pages for a queue and the number of available
> > >> pages of a queue. I used the debugfs interface to observe these
> > >> registers from time to time:
> > >>
> > >> f=$(echo /sys/kernel/debug/ieee80211/phy*/rtw88/read_reg); for i in 0x230 0x234 0x238 0x23c; do echo
> > "$i
> > >> 4" > $f; cat $f; done
> > >>
> > >> This is what they show:
> > >>
> > >> reg 0x230: 0x00230040
> > >> reg 0x234: 0x00400040
> > >> reg 0x238: 0x00400040
> > >> reg 0x23c: 0x00000000
> > >>
> > >> The upper 16bit contain the number of available pages and the lower
> > >> 16bit contain the number of reserved pages (Note these are the registers
> > >> on a RTL8822CU, on other chipsets the number of available pages is
> > >> lower, like 0x10 on RTL8821CU). Register 0x230 is the interesting one
> > >> for us, it has the values for queue 3.
> > >>
> > >> What I can see is that for the other queues the number of reserved pages
> > >> usually matches the number of available pages. It happens sometimes that
> > >> the number of available pages goes down to 0x3f, but with the next
> > >> register read it goes back to 0x40. For 0x230 this is different though.
> > >> Here the number of available pages continuously decreases over time and
> > >> never goes back up.
> > >>
> > >> I don't know what this is trying to tell me. It seems that things queued
> > >> to queue RTW_DMA_MAPPING_HIGH are sometimes (always?) stuck.
> > >> Unfortunately I also don't know how the different priority queues relate
> > >> to the different USB endpoints and how these in turn go together with
> > >> the qsel settings. Maybe Ping-Ke can shed some light on this.
> > >>
> > >
> > > To quickly check if RTW_DMA_MAPPING_HIGH get stuck, changing qsel_to_ep[]
> > > to different priority queue would be helpful to identify the problem.
> > > If only this queue works not well, we may dig MAC settings. Otherwise,
> > > it may be a RF performance problem.
> > >
> > > 0x240 is another queue called public queue. If 0x230/0x234/0x238/0x23c
> > > become full, packets are queued into this queue. From view of MAC circuit,
> > > it fetches these queues in specific order (from high to low conceptually;
> > > I'm 100% sure.), and apply EDCA contention parameters for internal and
> > > external contention.
> > >
> > > I don't have much useful ideas to this problem for now.
> > 
> > Ping-Ke and Sasha,
> > 
> > I made a discovery this morning. I set up a transfer from my NFS server to the
> > computer over an rtw8822bu link using rsync with the --progress option. In a
> > second window, I ran Sasha's register dump in a loop using a 5 second delay
> > between readouts. A third window showed was running 'dmesg -w'.
> > 
> > The transfer ran to completion on a 5.8 GiB file with all incremental speeds
> > reported as 11-12 MB/s. No timeouts on flushing the queue were logged, until I
> > opened the NetworkManager applet! At that point, I got many queue timeouts
> > logged, and the instantaneous throughput dropped to 2-3 MB/s as I reported
> > earlier. Surprisingly, there were no changes in the registers when the errors
> > happened.
> > 
> > The NM applet is going to be reading the transfer rate from the device, which
> > apparently messes up the data flow to/from the device.
> > 
> > As long as I do not cause the NM applet to display the connections, I get
> > nothing logged.
> > 
> 
> I think NM triggers scan operation when turning it on. Then, driver switches channels
> between AP and scan channels with flushing queue that causes timeout. The cause is
> still hard to transmit packets out, so TX buffer gets jammed.
> 
> If you enlarge the retry count or timeout value of __rtw_mac_flush_prio_queue(), 
> the timeout flushing could be disappear. Also, if we can implement
> rtwdev->hci.ops->flush_queues for USB, the flushing log can be reduced.

I don't have nm-applet available on my box, but with a 'nmcli dev wifi
list --rescan yes' I run into problems quite fast. That also happens on
an otherwise idle wifi link.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
