Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3B14C8F4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgA2Ktd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 05:49:33 -0500
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:45824 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgA2Kta (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 05:49:30 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 05:49:28 EST
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 4870PV3lYlz3B0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 11:40:30 +0100 (CET)
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 4870PS72Xsz1XLDR3;
        Wed, 29 Jan 2020 11:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key2-intmail; t=1580294429;
        bh=Skgd7nQuGIH0SzNyM73QXazPLkq6t2aHCOtjPfNCUbc=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=lxtvtRGQW6+uoOadisBkvmFTobrRRbIuHEyH4Gr2oeSCD2bcD2AtvicWnxorgAYNZ
         Et3X9lHvJabw9U+n2N0itW8sJA3DsOt2UL4Q6Dru6L4hQdOneXVJtXKMrvFPJ85yVt
         q+BpLtC/MYZnpivP6h0vcKWvWhBjiXuYo2h72AzI=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 4870PS6jPBz1Mq;
        Wed, 29 Jan 2020 11:40:28 +0100 (CET)
X-AuditID: 0a3aad14-aadff700000047f7-63-5e31611cf972
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 6C.1A.18423.C11613E5; Wed, 29 Jan 2020 11:40:28 +0100 (CET)
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (si0swiexhc01.bsh.corp.bshg.com [10.49.76.137])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 4870PS4XQmzB0t;
        Wed, 29 Jan 2020 11:40:28 +0100 (CET)
Received: from SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 29 Jan 2020 11:40:28 +0100
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1847.3; Wed, 29 Jan 2020 11:40:28 +0100
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272]) by
 SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272%5]) with mapi id
 15.01.1847.005; Wed, 29 Jan 2020 11:40:28 +0100
From:   "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
To:     JH <jupiter.hce@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Subject: RE: Strange inconsistant WiFi network behaviour
Thread-Topic: Strange inconsistant WiFi network behaviour
Thread-Index: AQHV1oWC58uQ1YLNlUiYf68AHLTNsqgBcp1w
Date:   Wed, 29 Jan 2020 10:40:28 +0000
Message-ID: <c76ff8bb50164eeb86feeb2eba76beac@bshg.com>
References: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
In-Reply-To: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.17]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22TW1AbZRTH+XaXZBNZuyykOYaQQmoftIoJ1mlsHUfH6uRJ26m8UKWGspCM
        udAkIPBgsVovKWNBi0iwJU0jokMwclEoLdigHai3dmhaGCnFabyExlpKbSk0GXdZaPLgyzfn
        +5/zO//znZ0lcaaHVJAmq5O1Ww1mtUhKSDf5sx9WGrRFmqlD63VNvbNiXd9gE6GLtk+Kn8L1
        /e6LYv3+ljihn+tSbcULpU+UsGZTJWt/5MlXpEb/6KdE+VBW1ZuNIawWDcpdSEICvQGuuEK4
        C0lJhm7CYO7Ut6nCZRTB7bN/YXwVQ+/F4KOvC4VEDEHf5CAmXH5G0BnwifgqEa2B865JnI8z
        6d3QMhcj+DiD1kFD43WRoD8OrhEvIcT50DwUWdIJeh20nRsT8zFFb4Rj3rhIcN4K7dd/W4ol
        9Da40zG9FCM6GwKBX5a8cFoOXX/cShXeQ4PvuKADLYPI5fiyvgZ+aphNFeofAs+AMA9Or4e2
        I1dwwTcdRpvDhFC/GT7rnkb1CNxJFu4k3J2Eu5NwDyK+QLJSVlNp0W7coMmzF7OOGo02b5fN
        0oWEb5jZhxaDpUGEkSiIHiMxtYyKbtEWMfcW20qqjQaHcae9wsw61ApqT/S9l5mMu7Kjothi
        cjhMNmsQAYmrMynZsxxHlRiqa1i7TcCCKIsk1HKqjHzhJYYuMzjZV1m2nLWvZDeTpBqoUBEH
        ptvZMraq1GR2rqTV2RRKSUlhVidnkm0xUhJEj5JpnHeEb0E5yg0Wh6lsGb9PwJkVNYGeRgVk
        feSQFydPfn+YO08tnYsBnxdnCKvNyirkVMpOriPNs8YK692ZFEpqaHdeESNLSiT6zqBxRCJ1
        BiXh4TTud0lMA1Qtv8D0ZTEB5fs4hm6hoc6vA9/ZfgK+DEcI8LQuiGHcc4CEOyfaJHD1yJgE
        vhq4KoHD459Q0Fl/i4KF5sZVsNjfmgnz0ZgMhk6eXw0j1y5lwf6jPUoI/z6shKmDE0r4PMQd
        8Y9D2RC/6VVB78BRFYx894MKpk5Pq2DeF1dBe+f0GpicacmB+Y72HJiIHs8Bz68/5sKNhoVc
        GA3Hcme4TWPcpm8aNPymnQbn/2x6WU08TlGLAh1nzGf2jV16x1O7ZWJ4x4Xgvtt/MoXd515k
        ruH2gyP/9qwDyWxvCRl7a9ASEGPI73968cPXC765Ubjtjc7nd8GAryptQqRVrcVqCvTdvj3V
        m+Siyzvuj12M/dP07muVihOevQ/kP1fvqXhm7fa/6z5oCB841nphOC3+9vt2veWeuiw14TAa
        tA/idofhP3bti7bHBAAA
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

there are WiFi routers like AVM which are implement the WiFi Stack in a str=
icter way than other routers or other WiFi chips-firmware.
I mention this cause weh ad some issue with a cypress wifi firmware which l=
eads to "sometimes" disconnect from routers. And we figured out that this w=
as mostly the case with AVM. We are in contact with AVM in it turns out tha=
t the AVM router work proberly. The issues was with the cypress chipset fir=
mware. Now we are in contact with cypress and they accepted the issue.
So it is not always a connman problem :-) .

Best regards
Jan

-----Original Message-----
From: JH <jupiter.hce@gmail.com>=20
Sent: Wednesday, January 29, 2020 10:22 AM
To: linux-wireless <linux-wireless@vger.kernel.org>; connman <connman@lists=
.01.org>
Subject: Strange inconsistant WiFi network behaviour

Hi,

I have 2 iMX6 devices running uBlox Lily WiFi, mrvl firmware sd8801_uapsta.=
bin in kernel 4.19.75. In my office, a WiFi router is just 1 meter away, th=
e WiFi signal should not be a problem. One device could connect to the WiFi=
 router well and stably, one could not, here were error messages:

[  408.990029] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
.....................

[56.986414] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameter

connmand[13469]:
../connman-1.35/src/service.c:preferred_tech_add_by_type() type 5 service 0=
x119120 Telstra
connmand[13469]: ../connman-1.35/src/service.c:auto_connect_service()
preferred 1 sessions 0 reason auto
connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
2 (retries 0)
connmand[13469]:
../connman-1.35/plugins/ofono.c:netreg_update_strength() /ubloxqmi_2 Streng=
th 80
connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
4 (retries 1)
connmand[13469]: ../connman-1.35/plugins/wifi.c:throw_wifi_scan()
device 0x118da8 0x116c78
connmand[13469]:
../connman-1.35/src/device.c:connman_device_ref_debug() 0x118da8 ref 4 by .=
./connman-1.35/plugins/wifi.c:1214:throw_wifi_scan()
connmand[13469]:
../connman-1.35/src/device.c:connman_device_set_scanning() device
0x118da8 scanning 1
connmand[13469]:
../connman-1.35/src/technology.c:__connman_technology_scan_started()
device 0x118da8
connmand[13469]: ../connman-1.35/plugins/wifi.c:autoscan_timeout() interval=
 27
connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
0x11a7c8 interface state 4
connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_started()
connmand[13469]: ../connman-1.35/src/rtnl.c:rtnl_message() NEWLINK len
56 type 16 flags 0x0000 seq 0 pid 0
connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_finished()
connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
0x11a7c8 interface state 3

Both devices were installed the same firmware and software, if it was firmw=
are / software issues, both would not be able to connect to WiFi, as one de=
vice could connect to the office WiFi router well, it could not the WiFi ro=
uter problem either.

If I move the faulty one to my home, it could connect to my home WiFi, so t=
he device does not have WiFi problem, that is really confusing, what could =
cause that kind problem and how to debug and fix it?

Thank you.

Kind regards,

- jh
_______________________________________________
connman mailing list -- connman@lists.01.org To unsubscribe send an email t=
o connman-leave@lists.01.org
