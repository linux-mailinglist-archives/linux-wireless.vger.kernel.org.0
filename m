Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40606AD41D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 02:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCGBjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 20:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCGBjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 20:39:43 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25754393E
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 17:39:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3271dBNt9023616, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3271dBNt9023616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 7 Mar 2023 09:39:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 09:39:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Mar 2023 09:39:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Tue, 7 Mar 2023 09:39:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Performance of rtw88_8822bu
Thread-Topic: Performance of rtw88_8822bu
Thread-Index: AQHZTw2LEbAWGDOEr0ecTTsLi0GDw67s9RWAgAA9vgCAAVbTsA==
Date:   Tue, 7 Mar 2023 01:39:19 +0000
Message-ID: <6ed1239f8c404dcb9d571771c230b69b@realtek.com>
References: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
 <20230306091845.GC27249@pengutronix.de>
 <20230306125944.GD27249@pengutronix.de>
In-Reply-To: <20230306125944.GD27249@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, March 6, 2023 9:00 PM
> To: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless <linux-wireless@vger.kernel.org>
> Subject: Re: Performance of rtw88_8822bu
> 
> On Mon, Mar 06, 2023 at 10:18:45AM +0100, Sascha Hauer wrote:
> > Hi Larry,
> >
> > On Sat, Mar 04, 2023 at 08:52:26PM -0600, Larry Finger wrote:
> > > Sascha an Ping-Ke,
> > >
> > > I have been testing the RTW8822BU driver found in my rtw88 GitHub repo. This
> > > code matches the code found in wireless-next. I created 9 files of 5.8 GiB
> > > each and used a for loop to copy them from the test computer to/from my
> > > server. The wireless connection is on the 5 GHz band (channel 153) connected
> > > to an ax1500 Wifi 6 router, which in turn is connected to the server via a
> > > 1G ethernet cable. The connection has not crashed, but I see strange
> > > behavior.
> >
> > What chipset are you using? Is it a RTL8822bu or some other chipset
> > reported by the driver?
> >
> > >
> > > With both TX and RX, the rate is high at 13.5 MiB/s for RX and 11.1 MiB/s
> > > for TX for about 1/3 of the time, but then the driver reports "timed out to
> > > flush queue 3" and the rate drops to 3-5 MiB/s for RX and 2-3 MiB/s for TX.
> > > These low rates are in effect for 2/3 of the time. The 5G bands are
> > > relatively unused in my house, thus I do not suspect interference.
> >
> > I've received a very similar report this weekend. About 3-4 messages per
> > second, "timed out to flush queue 3", but driver continues to work.
> > I've also seen it this morning by accident and once again while writing
> > this mail. This was on a RTL8821CU.
> >
> > So far I have no idea what the problem might be.
> 
> The "timed out to flush queue %d\n" message comes from
> __rtw_mac_flush_prio_queue(). Here some registers are read which show
> the number of reserved pages for a queue and the number of available
> pages of a queue. I used the debugfs interface to observe these
> registers from time to time:
> 
> f=$(echo /sys/kernel/debug/ieee80211/phy*/rtw88/read_reg); for i in 0x230 0x234 0x238 0x23c; do echo "$i
> 4" > $f; cat $f; done
> 
> This is what they show:
> 
> reg 0x230: 0x00230040
> reg 0x234: 0x00400040
> reg 0x238: 0x00400040
> reg 0x23c: 0x00000000
> 
> The upper 16bit contain the number of available pages and the lower
> 16bit contain the number of reserved pages (Note these are the registers
> on a RTL8822CU, on other chipsets the number of available pages is
> lower, like 0x10 on RTL8821CU). Register 0x230 is the interesting one
> for us, it has the values for queue 3.
> 
> What I can see is that for the other queues the number of reserved pages
> usually matches the number of available pages. It happens sometimes that
> the number of available pages goes down to 0x3f, but with the next
> register read it goes back to 0x40. For 0x230 this is different though.
> Here the number of available pages continuously decreases over time and
> never goes back up.
> 
> I don't know what this is trying to tell me. It seems that things queued
> to queue RTW_DMA_MAPPING_HIGH are sometimes (always?) stuck.
> Unfortunately I also don't know how the different priority queues relate
> to the different USB endpoints and how these in turn go together with
> the qsel settings. Maybe Ping-Ke can shed some light on this.
> 

To quickly check if RTW_DMA_MAPPING_HIGH get stuck, changing qsel_to_ep[]
to different priority queue would be helpful to identify the problem.
If only this queue works not well, we may dig MAC settings. Otherwise,
it may be a RF performance problem.

0x240 is another queue called public queue. If 0x230/0x234/0x238/0x23c
become full, packets are queued into this queue. From view of MAC circuit,
it fetches these queues in specific order (from high to low conceptually; 
I'm 100% sure.), and apply EDCA contention parameters for internal and
external contention. 

I don't have much useful ideas to this problem for now.

Ping-Ke

