Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8273D586
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jun 2023 03:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjFZB06 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Jun 2023 21:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZB0y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Jun 2023 21:26:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C705DC6
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jun 2023 18:26:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35Q1PFurC026641, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35Q1PFurC026641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 26 Jun 2023 09:25:15 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 26 Jun 2023 09:25:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Jun 2023 09:25:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 26 Jun 2023 09:25:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "petter@technux.se" <petter@technux.se>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux@ulli-kroll.de" <linux@ulli-kroll.de>,
        "morrownr@gmail.com" <morrownr@gmail.com>,
        "petter.mabacker@esab.se" <petter.mabacker@esab.se>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: Linux mainline support for RTL8811AU/RTL8821AU
Thread-Topic: Linux mainline support for RTL8811AU/RTL8821AU
Thread-Index: AQHZnc5dl9i8HjN9rEOIrsiwl7X/wK+IiCyAgAFbh4CADZRgAIAE5PMA
Date:   Mon, 26 Jun 2023 01:25:37 +0000
Message-ID: <128d43c8d0134b5ea18cbb4497e03a6c@realtek.com>
References: <e1d49f94865f4a69b3b3228b00697ad1@realtek.com>
 <20230623063528.472664-1-petter@technux.se>
In-Reply-To: <20230623063528.472664-1-petter@technux.se>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: petter@technux.se <petter@technux.se>
> Sent: Friday, June 23, 2023 2:35 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Larry.Finger@lwfinger.net; kernel@pengutronix.de; kvalo@kernel.org; linux-wireless@vger.kernel.org;
> linux@ulli-kroll.de; morrownr@gmail.com; petter.mabacker@esab.se; petter@technux.se;
> s.hauer@pengutronix.de
> Subject: RE: Linux mainline support for RTL8811AU/RTL8821AU
> 
> 
> >> -----Original Message-----
> >> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
> >> Sent: Wednesday, June 14, 2023 2:29 AM
> >> To: petter@technux.se; linux-wireless@vger.kernel.org
> >> Cc: Ping-Ke Shih <pkshih@realtek.com>; morrownr@gmail.com; kernel@pengutronix.de; kvalo@kernel.org;
> >> linux@ulli-kroll.de; petter.mabacker@esab.se; s.hauer@pengutronix.de
> >> Subject: Re: Linux mainline support for RTL8811AU/RTL8821AU
> >>
> >> On 6/13/23 03:09, petter@technux.se wrote:
> >> > Hi,
> >> >
> >> > I'm investigating a wifi dongle (LM808) that is based on the RTL8811AU chipset.
> >> >
> >> > $ lsusb
> >> > ..
> >> > Bus 003 Device 066: ID 0bda:a811 Realtek Semiconductor Corp. RTL8811AU 802.11a/b/g/n/ac WLAN Adapter
> >> > ..
> >> >
> >> > I cannot find any driver support in mainline for that chipset (8811cu/8821cu, seems to exists). Just
> curious
> >> if anyone knows if there are any ongoing efforts to get this driver included in mainline?
> >> >
> >> > I can see that both:
> >> >
> >> > https://www.lm-technologies.com/product/wifi-usb-adapter-433mbps-lm808/?template=driver
> >> >
> >> > and
> >> >
> >> > https://github.com/morrownr/8821au-20210708
> >> >
> >> > exists for non-mainline support, so will play a bit with them. But for maintenance etc I'm interested
> >> to learn about possible mainline efforts within this area.
> >>
> >> It seems that the RTW8821AE has never been built or released. If it had been,
> >> then extending that driver to the 8821AU would be easy as there would be a file
> >> rtw8821a.c that contained all the details of that chip. Without that, there is
> >> little that anyone outside Realtek can do. The vendor driver, which is the one
> >> in the link you posted, will likely work.
> >>
> 
> >rtlwifi can support RTL8821AE/RTL8812AE and basic USB infrastructure, so it looks
> >like possible to support 8821AU by rtlwifi.
> >
> >Ping-Ke
> 
> So since no rtw8821a.c is available, like Larry pointed out in another response. Then it sounds like
> investigating
> rtlwifi is the best way forward then. Do you mean that it should be possible to get the 8821AU up-and-running
> just by
> making use of the info in ./drivers/net/wireless/realtek/rtlwifi/rtl8821ae then? Are there any plans to
> release a rtl8821au fw through linux-firmware, since
> I guess that will be needed also.

Yes, rtlwifi/rtl8821ae + rtlwifi/usb.c should be possible to get 8821AU work, and
the firmware is the same as 8821AE.

Ping-Ke

