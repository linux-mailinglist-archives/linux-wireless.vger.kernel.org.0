Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9D700184
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbjELH3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 03:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbjELH3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 03:29:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC3E5A
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 00:29:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3063afa2372so8893818f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683876566; x=1686468566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg16tA9O76bI6kdBrAhWP4R9WbAZuPBTQCmoyq0zXj4=;
        b=GZF+dfDRxpA4enKPUjlEXIxIl2Ug3JnmgUnY3X+J4/rLnvUB7anRaCVSdgnxEhv9Tc
         KiPAFU6fuK9El8jPxHW7vlXCBWZTp3GGqxHB7VDxqAzHkrDuJUvF6jIIlm+NMBEd2QtN
         LiQVf1WsJEwgdtXUrtz+e9DWX/4Pp5XLXkJRczWWmRCMuuF7UfhTyh2FHeCsVjTorWYC
         0G7RdBt3JtzHDE7GWAANGq205dujhg4gJZEzg9+/Ycy5n44Uh8ui47wPSRe9066LTFFh
         1F4315SdqMFOLVpDzQE69QGVI1/rAPNTQam2cCCLhX+Ax+qvBmGgyme2lRk3UNEKBlZl
         cD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876566; x=1686468566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg16tA9O76bI6kdBrAhWP4R9WbAZuPBTQCmoyq0zXj4=;
        b=JUjqi6mU3FQaBzK5LEWA4zh9fy704LaiXC64+Mksadm4XXXfTEdcpz43j5Jt+F64BX
         e254YM2BXj/cKvarcxB/r/2oT7N7fcQmFZb7MUB+iO9TwWpbdjJj+ci1TkSA+VVWEEX6
         +RHZL9UdoZFw8cbl7GRNvSPEjYfV2H7j13alO6kO3xvZ/BBBCEIXknGfVv8iGzxPbMpi
         S0rLA9aNk65Jwmv8frc14zN7ZqMYhx06ZkknDNJAshQOZDZVqQxULKe5xjv/MTF67gUA
         RfbyuQW4ZdZiuy0z4pOM5gKYaSU/KfmjsT+xJltMeOsmvzrK84AhXfGgtKu90u0zqWFv
         RtlQ==
X-Gm-Message-State: AC+VfDyTem+Prmxm/RIsLqmY6Hzg/RdhnInMvLH0+Ev8Qb2x910XB2nh
        sFKeStMKgSZKvN/HMOpkllTRVW8VWNHguYuhVNp4E2ZeXbk=
X-Google-Smtp-Source: ACHHUZ7QmEgoV5pnuRyhiVbIsnp1K1pDtY8Xy6vGQRbBtxBNhe9NrdBImkgrTEvEpsZlQ6raJNEXOBgvf1OLtKH1txw=
X-Received: by 2002:a5d:54c5:0:b0:306:3489:2615 with SMTP id
 x5-20020a5d54c5000000b0030634892615mr16006799wrv.40.1683876566220; Fri, 12
 May 2023 00:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAD9ZU8BHTOA9=V7NQvkGBLK4DV2NRvk2rDxJX6qr6unZsg-QdA@mail.gmail.com>
 <20230511132607.2908454-1-petter@technux.se>
In-Reply-To: <20230511132607.2908454-1-petter@technux.se>
From:   Gabriel Tisan <gabriel.tisan@gmail.com>
Date:   Fri, 12 May 2023 09:29:15 +0200
Message-ID: <CAD9ZU8Dz8_DNb6=h0xBBOkJv0Z5=H97jq3jZABwfay0P4zawjw@mail.gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
To:     Petter Mabacker <petter@technux.se>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        s.hauer@pengutronix.de, tony0620emma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On my machine it works.

# iperf -s -u -p 5077
------------------------------------------------------------
Server listening on UDP port 5077
Receiving 1470 byte datagrams
UDP buffer size:   176 KByte (default)
------------------------------------------------------------
[  3] local 192.168.199.128 port 5077 connected with 192.168.199.129 port 5=
2400
[ ID] Interval       Transfer     Bandwidth       Jitter   Lost/Total Datag=
rams
[  3]  0.0-300.2 sec  1.13 GBytes  32.5 Mbits/sec  0.811 ms 447069/1275909 =
(35%)

C:\work\iperf\iperf-2.0.9-win64>iperf -c 192.168.199.128 -u -p 5077 -b
200M -t 300
------------------------------------------------------------
Client connecting to 192.168.199.128, UDP port 5077
Sending 1470 byte datagrams, IPG target: 58.80 us (kalman adjust)
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 192.168.199.129 port 52400 connected with 192.168.199.128 port =
5077
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-300.0 sec  1.75 GBytes  50.0 Mbits/sec
[  3] Sent 1275909 datagrams
[  3] Server Report:
[  3]  0.0-300.2 sec  1.13 GBytes  32.5 Mbits/sec   0.811 ms
447069/1275909 (35%)

The only problem that I have is that after some time appears that the
link goes up again,
although the connection does not break and the stick is still plugged in.
# ip -oneline -family inet monitor link
6: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
6: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

# uname -a
Linux 6.0.5-rt14-00133-g9bc110e18268 #23 PREEMPT_RT @1683554137 ppc GNU/Lin=
ux

I use Linux 6.0.5 patched with latest changes from rtw88:

$ git log --oneline
9bc110e18268 (HEAD -> v6.0.5-rt14-rtw88) wifi: rtw88: Update spelling in ma=
in.h
3ae5fb6c4817 wifi: rtw88: Fix memory leak in rtw88_usb
45b8a6b717f7 wifi: rtw88: call rtw8821c_switch_rf_set() according to
chip variant
9a026c4ca518 wifi: rtw88: set pkg_type correctly for specific rtw8821c vari=
ants
1a6a48dcfc62 wifi: rtw88: rtw8821c: Fix rfe_option field width
dc964f05689e wifi: rtw88: usb: fix priority queue to endpoint mapping
551f663748ec wifi: rtw88: 8822c: add iface combination
406db9770c3b wifi: rtw88: prevent scan abort with other VIFs
c4baacf76af1 wifi: rtw88: refine reserved page flow for AP mode
bf443e16ab6b wifi: rtw88: disallow PS during AP mode
a4e31f468776 wifi: rtw88: 8822c: extend reserved page number
7d3459fec41d wifi: rtw88: add port switch for AP mode
1663c8bbfb6c wifi: rtw88: add bitmap for dynamic port settings
177cce5278da wifi: rtw88: Add support for the SDIO based RTL8821CS chipset
0c2d0c2e95e9 wifi: rtw88: Add support for the SDIO based RTL8822CS chipset
54ccc15bf8e8 wifi: rtw88: Add support for the SDIO based RTL8822BS chipset
5ba6cc26d37d wifi: rtw88: main: Reserve 8 bytes of extra TX headroom
for SDIO cards
78968acd1cf7 wifi: rtw88: main: Add the {cpwm,rpwm}_addr for SDIO based chi=
psets
2c84a6fbc425 wifi: rtw88: mac: Support SDIO specific bits in the power
on sequence
f8fecd6b4b15 wifi: rtw88: sdio: Add HCI implementation for SDIO based chips=
ets
18d149b363ec wifi: rtw88: Clear RTW_FLAG_POWERON early in rtw_mac_power_swi=
tch()
4428afb018ad wifi: rtw88: Remove redundant pci_clear_master
e03a57505246 wifi: rtw88: remove unused rtw_pci_get_tx_desc function
1a33faaf7ee2 wifi: rtw88: fix memory leak in rtw_usb_probe()
7df514789989 wifi: rtw88: mac: Return the original error from
rtw_mac_power_switch()
cdcec0087eed wifi: rtw88: mac: Return the original error from
rtw_pwr_seq_parser()
29e7e78aff16 wifi: rtw88: rtw8822c: Implement RTL8822CS (SDIO) efuse parsin=
g
fd1c578236f0 wifi: rtw88: rtw8822b: Implement RTL8822BS (SDIO) efuse parsin=
g
27cf63903f82 wifi: rtw88: rtw8821c: Implement RTL8821CS (SDIO) efuse parsin=
g
880dcc22d96e wifi: rtw88: mac: Add SDIO HCI support in the TX/page table se=
tup
02a905156d9f wifi: rtw88: mac: Add support for the SDIO HCI in
rtw_pwr_seq_parser()
3cbb5e76d79d wifi: rtw88: use RTW_FLAG_POWERON flag to prevent to
power on/off twice
d645a4334e82 wifi: rtw88: add flag check before enter or leave IPS
96c6c8188d76 wifi: rtw88: usb: drop now unnecessary URB size check
7c6f489cee16 wifi: rtw88: usb: send Zero length packets if necessary
3cd2c456cf5f wifi: rtw88: usb: Set qsel correctly
93da623c5ab9 wifi: rtw88: mac: Use existing macros in rtw_pwr_seq_parser()
2adec4917988 wifi: rtw88: Move enum rtw_tx_queue_type mapping code to tx.{c=
,h}
25e6d15c23f2 wifi: rtw88: pci: Change queue datatype to enum rtw_tx_queue_t=
ype
f915cdb6b40c wifi: rtw88: pci: Use enum type for
rtw_hw_queue_mapping() and ac_to_hwq
32c6e075e96f wifi: rtw88: Use non-atomic sta iterator in
rtw_ra_mask_info_update()
42509ddaa145 wifi: rtw88: Use rtw_iterate_vifs() for rtw_vif_watch_dog_iter=
()
a963db0abf71 wifi: rtw88: Move register access from rtw_bf_assoc()
outside the RCU
ba948e675516 wifi: rtw88: Add rtw8723du chipset support
5790a74b07bc wifi: rtw88: Add rtw8822cu chipset support
a22a3494b2b0 wifi: rtw88: Add rtw8822bu chipset support
fff42b4bfafe wifi: rtw88: Add rtw8821cu chipset support
bf5a6ce1815f wifi: rtw88: Add common USB chip support
2bd3a3cdff6b wifi: rtw88: iterate over vif/sta list non-atomically
e6198781367b wifi: rtw88: Drop coex mutex
7274d8b3144a wifi: rtw88: Drop h2c.lock
aa76144a028e wifi: rtw88: Drop rf_lock
2d162565d3bb wifi: rtw88: Call rtw_fw_beacon_filter_config() with
rtwdev->mutex held
9691b6813454 wifi: rtw88: print firmware type in info message
94243d5a51f9 wifi: rtw88: 8821c: enable BT device recovery mechanism
ec71728e9565 wifi: rtw88: fix race condition when doing H2C command
dd281929b088 wifi: mac80211: extend ieee80211_nullfunc_get() for MLO
040e3123e9d9 (tag: v6.0.5-rt14) v6.0.5-rt14c775cbedc0b8 net: axienet:
Remove the obsolete u64_stats_fetch_*_irq().
19dbfda76f91 (tag: v6.0.5-rt13) v6.0.5-rt13
20d4181d35af Merge tag 'v6.0.5' into linux-6.0.y-rt
3829606fc5df (tag: v6.0.5) Linux 6.0.5


On Thu, May 11, 2023 at 3:26=E2=80=AFPM Petter Mabacker <petter@technux.se>=
 wrote:
>
> >Actually there is a recent firmware 9.9.15.
> >Petter use that, is displayed in the first email.
>
> >I have also an LM482 with 9.9.15 firmware. I used iperf with TCP and I
> >could not reproduce that.
> >I will try iperf with UDP like in your case.
> >How do you use LM482 when running iperf ? As station or AP ?
>
> >Gabriel
>
> Yes, I have been using 9.9.15, but I have also tested using 9.9.14 firmwa=
re.
> I'm running it as a station. Please let me know if you manage to reproduc=
e a similar behaviour by flooding the udp like in my example.
>
> Thanks.
> BR Petter
>
> On Tue, May 9, 2023 at 11:18=3DE2=3D80=3DAFAM Sascha Hauer <s.hauer@pengu=
tronix.d=3D
> e> wrote:
> >>
> >> On Tue, May 09, 2023 at 09:43:50AM +0200, Petter Mabacker wrote:
> >> > >> I'm working with a Linux 6.1 based track, but with all the mentio=
ned bug fixes cherry-picked to that track. They have all made the LM842 a l=
ot more stabile, but the issue I see with "tx report failed" is currently b=
locking me from using the LM842, since the mender upgrade is a crucial part=
 for my use-case.
> >> > >>
> >> > >> I have been trying to find a better way to reproduce the issue, w=
ithout any success so far. For me it takes just 10-30 sec with above mentio=
n flooding using iperf to at least trigger a similar case.
> >> > >>
> >> > >> ...
> >> > >> [  671.908527] rtw_8822cu 1-1:1.2: failed to get rx_queue, overfl=
ow
> >> > >> [  671.914632] rtw_8822cu 1-1:1.2: failed to get rx_queue, overfl=
ow
> >> > >> [  671.920750] rtw_8822cu 1-1:1.2: failed to get rx_queue, overfl=
ow
> >> > >> [  671.926792] rtw_8822cu 1-1:1.2: failed to get rx_queue, overfl=
ow
> >> > >> [  671.932924] rtw_8822cu 1-1:1.2: failed to get rx_queue, overfl=
ow
> >> >
> >> > >I am still not sure what to do about this. It happens with high RX =
load.
> >> > >One way would be to just drop the log level of this message.
> >> > >Otherwise this message should be harmless.
> >> >
> >> > Like stated in earlier mails, the initial problem was found during a
> >> > mender upgrade (streaming a ~200MB file). In that case the problem
> >> > occurs without any high RX load warnings. So that is not really
> >> > related (at least I don't think so).
> >> >
> >> > The real problem is that the driver ends-up in a not working state
> >> > after this. Not even hot-plugging the dongle will help. Instead a
> >> > reboot or reset of the driver (rmmod/insmod etc) is required.
> >> >
> >> > >>
> >> > >> [  694.709045] rtw_8822cu 1-1:1.2: failed to get tx report from f=
irmware
> >> > >>
> >> > >> [  710.169496] rtw_8822cu 1-1:1.2: firmware failed to report dens=
ity after scan
> >> > >> [  717.701235] rtw_8822cu 1-1:1.2: failed to send h2c command
> >> > >>
> >> > >> I can also mention that I'm running this in a i.MX6 SoloX based b=
oard.
> >> > >>
> >> > >> I will let you guys know if I find a better way to reproduce the
> >> > >> issue. But if you have any good ideas what above error (that brin=
gs
> >> > >> down the entire interface) really mean (for example does it indic=
ate
> >> > >> kernel or firmware issue), please feel free to share some informa=
tion
> >> > >> about it and it might help me in troubleshooting the issue furthe=
r.
> >> >
> >> > >Please try reproducing this with a recent mainline vanilla kernel. =
It
> >> > >shouldn't be too hard to bring up a i.MX6 board with a vanilla kern=
el.
> >> >
> >> > Just to be sure, I have tried this using latest kernel tree as you s=
uggested:
> >> >
> >> > ~# uname -r
> >> > 6.4.0-rc1-g5ca44e46dff4
> >> >
> >> > However I get the very same behavior (in this case it's from the fai=
led mender upgrade):
> >> > [  724.788270] rtw_8822cu 1-1:1.2: failed to get tx report from firm=
ware
> >> > [  728.499480] rtw_8822cu 1-1:1.2: failed to send h2c command
> >> > [  758.558511] rtw_8822cu 1-1:1.2: firmware failed to report density=
 after scan
> >> > May 09 06:48:17 iotgw mender[643]: time=3D3D"2023-05-09T06:48:17Z" l=
evel=3D3Derror msg=3D3D"Download connection broken: read tcp 192.168.68.113=
:54072->52.239.140.42:443: read: connection timed out"
> >> > [  796.975782] rtw_8822cu 1-1:1.2: firmware failed to report density=
 after scan
> >> > [  835.251656] rtw_8822cu 1-1:1.2: firmware failed to report density=
 after scan
> >> > [  843.586421] rtw_8822cu 1-1:1.2: failed to send h2c command
> >>
> >> Unfortunately it looks like this very often when something goes wrong =
in
> >> the RTW88 driver. These messages seem to be a general sign for the
> >> device to say that we have touched it wrong somehow and it's stuck now=
.
> >>
> >> >
> >> > When I try to hotplug the dongle (that still don't solve the issue).=
 I
> >> > can see below printout, any ideas what it really mean? (I never see
> >> > this before the problem occurs, only when hotplugging after the
> >> > problem occurs):
> >> >
> >> > [ 2298.729359] wlx34c9f08deb60: Limiting TX power to 23 (23 - 0) dBm=
 as advertised by 1c:3b:f3:55:59:93
> >> >
> >> > Since you cannot reproduce the similar (perhaps not even the same ro=
ot
> >> > issue) issue I saw using iperf, I will focus on trying to reproduce =
it
> >> > using something similar as the streaming procedure done by mender. A=
ny
> >> > other suggestions from your side, or any logs etc that could be of
> >> > interest?
> >>
> >> You could verify that you are using a recent firmware. The driver prin=
ts
> >> it during initialization. It should be 9.9.11.
> >>
> >> Other than that I don't have any good idea, sorry.
> >>
> >> Sascha
> >>
> >> --
> >> Pengutronix e.K.                           |                          =
   |
> >> Steuerwalder Str. 21                       | http://www.pengutronix.de=
/  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0 =
   |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-55=
55 |
>
