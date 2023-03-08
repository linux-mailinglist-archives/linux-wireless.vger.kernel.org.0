Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804F66B0F19
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCHQok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 11:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCHQoi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 11:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA0C4E80
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 08:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678293825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5staGGVFCvJCRbAvHYkqGsvPTRohZD51GHt7UXqkps=;
        b=b5WKFlQP2kjo70DdwHNuxLtIeXVQ1I9y0LfaUl6lrjidvQVlBqhILNncfb5nlEP1rhdks1
        1B/9fIWI+tLH91SaawMNLsZkhmqj7hJ4RCp82FWvSy4NvynB3NFavz44dEgYnhgDwPOpv4
        HnIFhhUT+qiIMkKC5Kb3Mm9cYsB9NMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-qemT0oyBMlCF1rA6KywYIA-1; Wed, 08 Mar 2023 11:43:44 -0500
X-MC-Unique: qemT0oyBMlCF1rA6KywYIA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA7CF85CBE0;
        Wed,  8 Mar 2023 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-0-11.rdu2.redhat.com [10.22.0.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 515A9492B05;
        Wed,  8 Mar 2023 16:43:42 +0000 (UTC)
Message-ID: <6e14212a414067c970b8d2d0bf6eb8df5319a972.camel@redhat.com>
Subject: Re: Performance of rtw88_8822bu
From:   Dan Williams <dcbw@redhat.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 08 Mar 2023 10:43:42 -0600
In-Reply-To: <1f01b1ff59d7412aa7eafdce022d7635@realtek.com>
References: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
         <20230306091845.GC27249@pengutronix.de>
         <20230306125944.GD27249@pengutronix.de>
         <6ed1239f8c404dcb9d571771c230b69b@realtek.com>
         <2064a549-ef7a-98bf-cc24-a25b8571877f@lwfinger.net>
         <1f01b1ff59d7412aa7eafdce022d7635@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-08 at 00:36 +0000, Ping-Ke Shih wrote:
>=20
>=20
> > -----Original Message-----
> > From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry
> > Finger
> > Sent: Tuesday, March 7, 2023 10:44 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>; Sascha Hauer
> > <s.hauer@pengutronix.de>
> > Cc: linux-wireless <linux-wireless@vger.kernel.org>
> > Subject: Re: Performance of rtw88_8822bu
> >=20
> > On 3/6/23 19:39, Ping-Ke Shih wrote:
> > >=20
> > >=20
> > > > -----Original Message-----
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Monday, March 6, 2023 9:00 PM
> > > > To: Larry Finger <Larry.Finger@lwfinger.net>
> > > > Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless
> > > > <linux-wireless@vger.kernel.org>
> > > > Subject: Re: Performance of rtw88_8822bu
> > > >=20
> > > > On Mon, Mar 06, 2023 at 10:18:45AM +0100, Sascha Hauer wrote:
> > > > > Hi Larry,
> > > > >=20
> > > > > On Sat, Mar 04, 2023 at 08:52:26PM -0600, Larry Finger wrote:
> > > > > > Sascha an Ping-Ke,
> > > > > >=20
> > > > > > I have been testing the RTW8822BU driver found in my rtw88
> > > > > > GitHub repo. This
> > > > > > code matches the code found in wireless-next. I created 9
> > > > > > files of 5.8 GiB
> > > > > > each and used a for loop to copy them from the test
> > > > > > computer to/from my
> > > > > > server. The wireless connection is on the 5 GHz band
> > > > > > (channel 153) connected
> > > > > > to an ax1500 Wifi 6 router, which in turn is connected to
> > > > > > the server via a
> > > > > > 1G ethernet cable. The connection has not crashed, but I
> > > > > > see strange
> > > > > > behavior.
> > > > >=20
> > > > > What chipset are you using? Is it a RTL8822bu or some other
> > > > > chipset
> > > > > reported by the driver?
> > > > >=20
> > > > > >=20
> > > > > > With both TX and RX, the rate is high at 13.5 MiB/s for RX
> > > > > > and 11.1 MiB/s
> > > > > > for TX for about 1/3 of the time, but then the driver
> > > > > > reports "timed out to
> > > > > > flush queue 3" and the rate drops to 3-5 MiB/s for RX and
> > > > > > 2-3 MiB/s for TX.
> > > > > > These low rates are in effect for 2/3 of the time. The 5G
> > > > > > bands are
> > > > > > relatively unused in my house, thus I do not suspect
> > > > > > interference.
> > > > >=20
> > > > > I've received a very similar report this weekend. About 3-4
> > > > > messages per
> > > > > second, "timed out to flush queue 3", but driver continues to
> > > > > work.
> > > > > I've also seen it this morning by accident and once again
> > > > > while writing
> > > > > this mail. This was on a RTL8821CU.
> > > > >=20
> > > > > So far I have no idea what the problem might be.
> > > >=20
> > > > The "timed out to flush queue %d\n" message comes from
> > > > __rtw_mac_flush_prio_queue(). Here some registers are read
> > > > which show
> > > > the number of reserved pages for a queue and the number of
> > > > available
> > > > pages of a queue. I used the debugfs interface to observe these
> > > > registers from time to time:
> > > >=20
> > > > f=3D$(echo /sys/kernel/debug/ieee80211/phy*/rtw88/read_reg); for
> > > > i in 0x230 0x234 0x238 0x23c; do echo
> > "$i
> > > > 4" > $f; cat $f; done
> > > >=20
> > > > This is what they show:
> > > >=20
> > > > reg 0x230: 0x00230040
> > > > reg 0x234: 0x00400040
> > > > reg 0x238: 0x00400040
> > > > reg 0x23c: 0x00000000
> > > >=20
> > > > The upper 16bit contain the number of available pages and the
> > > > lower
> > > > 16bit contain the number of reserved pages (Note these are the
> > > > registers
> > > > on a RTL8822CU, on other chipsets the number of available pages
> > > > is
> > > > lower, like 0x10 on RTL8821CU). Register 0x230 is the
> > > > interesting one
> > > > for us, it has the values for queue 3.
> > > >=20
> > > > What I can see is that for the other queues the number of
> > > > reserved pages
> > > > usually matches the number of available pages. It happens
> > > > sometimes that
> > > > the number of available pages goes down to 0x3f, but with the
> > > > next
> > > > register read it goes back to 0x40. For 0x230 this is different
> > > > though.
> > > > Here the number of available pages continuously decreases over
> > > > time and
> > > > never goes back up.
> > > >=20
> > > > I don't know what this is trying to tell me. It seems that
> > > > things queued
> > > > to queue RTW_DMA_MAPPING_HIGH are sometimes (always?) stuck.
> > > > Unfortunately I also don't know how the different priority
> > > > queues relate
> > > > to the different USB endpoints and how these in turn go
> > > > together with
> > > > the qsel settings. Maybe Ping-Ke can shed some light on this.
> > > >=20
> > >=20
> > > To quickly check if RTW_DMA_MAPPING_HIGH get stuck, changing
> > > qsel_to_ep[]
> > > to different priority queue would be helpful to identify the
> > > problem.
> > > If only this queue works not well, we may dig MAC settings.
> > > Otherwise,
> > > it may be a RF performance problem.
> > >=20
> > > 0x240 is another queue called public queue. If
> > > 0x230/0x234/0x238/0x23c
> > > become full, packets are queued into this queue. From view of MAC
> > > circuit,
> > > it fetches these queues in specific order (from high to low
> > > conceptually;
> > > I'm 100% sure.), and apply EDCA contention parameters for
> > > internal and
> > > external contention.
> > >=20
> > > I don't have much useful ideas to this problem for now.
> >=20
> > Ping-Ke and Sasha,
> >=20
> > I made a discovery this morning. I set up a transfer from my NFS
> > server to the
> > computer over an rtw8822bu link using rsync with the --progress
> > option. In a
> > second window, I ran Sasha's register dump in a loop using a 5
> > second delay
> > between readouts. A third window showed was running 'dmesg -w'.
> >=20
> > The transfer ran to completion on a 5.8 GiB file with all
> > incremental speeds
> > reported as 11-12 MB/s. No timeouts on flushing the queue were
> > logged, until I
> > opened the NetworkManager applet! At that point, I got many queue
> > timeouts
> > logged, and the instantaneous throughput dropped to 2-3 MB/s as I
> > reported
> > earlier. Surprisingly, there were no changes in the registers when
> > the errors
> > happened.
> >=20
> > The NM applet is going to be reading the transfer rate from the
> > device, which
> > apparently messes up the data flow to/from the device.
> >=20
> > As long as I do not cause the NM applet to display the connections,
> > I get
> > nothing logged.
> >=20
>=20
> I think NM triggers scan operation when turning it on. Then, driver
> switches channels
> between AP and scan channels with flushing queue that causes timeout.
> The cause is
> still hard to transmit packets out, so TX buffer gets jammed.

Yes, (at least historically) nm-applet requests that NM perform a scan
when you interact with it, on the theory that when you open the WiFi
network menu you probably want to see recent scan results. Similar to
MacOS's AirPort menu.

Most drivers handle that OK with intermittent traffic, but it will
cause disruption if for high throughput and/or latency-sensitive
traffic.

Dan

>=20
> If you enlarge the retry count or timeout value of
> __rtw_mac_flush_prio_queue(),=20
> the timeout flushing could be disappear. Also, if we can implement
> rtwdev->hci.ops->flush_queues for USB, the flushing log can be
> reduced.
>=20
> Ping-Ke
>=20

