Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2482442BAF7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbhJMI5k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 04:57:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53095 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJMI5k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 04:57:40 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19D8tVRf9012750, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19D8tVRf9012750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Oct 2021 16:55:31 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 16:55:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 13 Oct 2021 16:55:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Wed, 13 Oct 2021 16:55:29 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v7 00/24] rtw89: add Realtek 802.11ax driver
Thread-Topic: [PATCH v7 00/24] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHXu/iJAwMQQSujW0S+UB8Qd29qRavKVXS6gANjmPWAAN8qkIAB4am5gAAtd+A=
Date:   Wed, 13 Oct 2021 08:55:29 +0000
Message-ID: <adfb1ac4113c4ff08fd31596161a4146@realtek.com>
References: <20211008035627.19463-1-pkshih@realtek.com>
        <87lf32622d.fsf@codeaurora.org> <878ryz4vfw.fsf@codeaurora.org>
        <72f1067becb44a7a962c5d43cefe189e@realtek.com>
 <87h7dlwj58.fsf@codeaurora.org>
In-Reply-To: <87h7dlwj58.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/13_=3F=3F_06:20:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/13/2021 08:42:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166684 [Oct 13 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1;git.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/13/2021 08:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On
> Behalf Of Kalle Valo
> Sent: Wednesday, October 13, 2021 2:09 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v7 00/24] rtw89: add Realtek 802.11ax driver
> 
> Pkshih <pkshih@realtek.com> writes:
> 
> >> -----Original Message-----
> >> From: kvalo=codeaurora.org@mg.codeaurora.org
> >> <kvalo=codeaurora.org@mg.codeaurora.org> On
> >> Behalf Of Kalle Valo
> >> Sent: Monday, October 11, 2021 8:07 PM
> >> To: Pkshih <pkshih@realtek.com>
> >> Cc: linux-wireless@vger.kernel.org
> >> Subject: Re: [PATCH v7 00/24] rtw89: add Realtek 802.11ax driver
> >>
> >> Kalle Valo <kvalo@codeaurora.org> writes:
> >>
> >> > Ping-Ke Shih <pkshih@realtek.com> writes:
> >> >
> >> >> This driver named rtw89, which is the next generation of rtw88, supports
> >> >> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
> >> >> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
> >> >> though.
> >> >>
> >> >> The chip architecture is entirely different from the chips supported by
> >> >> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
> >> >> are totally redefined, so it's impossible to reuse register definition. To
> >> >> communicate with firmware, new H2C/C2H format is proposed. In order to have
> >> >> better utilization, TX DMA flow is changed to two stages DMA. To provide
> >> >> rich RX status information, additional RX PPDU packets are added.
> >> >>
> >> >> Since there are so many differences mentioned above, we decide to propose
> >> >> a new driver. It has many authors, they are listed in alphabetic order:
> >> >>
> >> >> Chin-Yen Lee <timlee@realtek.com>
> >> >> Ping-Ke Shih <pkshih@realtek.com>
> >> >> Po Hao Huang <phhuang@realtek.com>
> >> >> Tzu-En Huang <tehuang@realtek.com>
> >> >> Vincent Fann <vincent_fann@realtek.com>
> >> >> Yan-Hsuan Chuang <tony0620emma@gmail.com>
> >> >> Zong-Zhe Yang <kevin_yang@realtek.com>
> >> >>
> >> >> Tested-by: Brian Norris <briannorris@chromium.org>
> >> >> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >> >>
> >> >> v7:
> >> >>   - use consistent license of Kconfig
> >> >>   - remove #ifdef and dummy functions from coex.c
> >> >>   - C2H handler of coex uses meaningful naming insetad, and use le32_to_cpu()
> >> >>     to convert the value.
> >> >>   - add icmp packet notify to coex
> >> >>   - use function call instead of a work to notify coex about traffic changed
> >> >>   - fix dereference security CAM NULL pointer while disconnecting occasionally
> >> >>   - fill tx descriptor once a 32 bits word (Suggested by Arnd. Thanks!)
> >> >>   - use static pci PS, so remove pci link_ps
> >> >>   - make many mac tables constant
> >> >>   - add early_h2c debugfs entry to notify firmware early
> >> >>   - support new RA report format
> >> >>   - configure retry_lowest_rate by band
> >> >>   - avoid to use of whil(1) to parse power sequence
> >> >>   - notify rfk before/after scanning to reset status
> >> >>   - firmware: rtw89: 8852a: update fw to v0.13.30.0
> >> >>     https://github.com/pkshih/linux-firmware.git
> >> >>     pick the commit 6595133a7cde82be932067afde834dcd036167f8
> >> >
> >> > I have not reviewed this version yet, but I pushed it to the pending
> >> > branch for build testing:
> >> >
> >> >
> >>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=
> >> pending&id=c321740f93af1a31d9e149ce5077e28bd4e859f7
> >> >
> >> > For the final commit my plan is to squash all patches into one big
> >> > patch. I will do that after reviewing v7, if everything is ok of course.
> >> >
> >> > Are there more Tested-by or Reviewed-by tags?
> >
> > Sorry for the late reply. Because our National Day is Oct. 10th, and
> > additional holiday on Oct. 11th.
> >
> > Aaron have tested v5 and a tag is given [1].
> >
> > Tested-by: Aaron Ma <aaron.ma@canonical.com>
> 
> I added Aaron to the commit log and pushed the driver to the master
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id
> =e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd
> 
> So the driver is now officially accepted, a big thank you to everyone
> who participated with the review and testing! Now let's see what kind of
> reports we get from linux-next.
> 

Thank you!

Should I add myself to the file MAINTAINERS?

--
Ping-Ke

