Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4710E421F52
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhJEHSl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 03:18:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43317 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHSl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 03:18:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1957GjleE021507, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1957GjleE021507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 5 Oct 2021 15:16:45 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 15:16:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 5 Oct 2021 15:16:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Tue, 5 Oct 2021 15:16:44 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 03/24] rtw89: add core and trx files
Thread-Topic: [PATCH v6 03/24] rtw89: add core and trx files
Thread-Index: AQHXlXz/YnZ2oZOf0EqyX08JkH+H2au+l1CcgAWc+lA=
Date:   Tue, 5 Oct 2021 07:16:44 +0000
Message-ID: <4b2f1c6b06e040d19b64d07500e0447b@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-4-pkshih@realtek.com>
 <877dewiudp.fsf@codeaurora.org>
In-Reply-To: <877dewiudp.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/5_=3F=3F_06:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/05/2021 07:00:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166506 [Oct 04 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/05/2021 07:03:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On
> Behalf Of Kalle Valo
> Sent: Saturday, October 2, 2021 12:26 AM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > Implement main flows that contains register/unregister mac80211 hw with
> > hardware capability, power on/off sequence, STA state actions, and
> > TX/RX path.
> >
> > The chip info is read from efuse while probing PCI, and then it can be
> > used to induce supported channel, band, bitrate, ht/vht/he capability,
> > and etc. Then, we register hardware with these capabilities.
> >
> > When network interface is up, driver does power-on sequence to enable MAC,
> > BB and RF function blocks. Oppositely, do power-off sequence when
> > interface is going to down.
> >
> > To maintain STA state, five callbacks are implemented -- add, assoc,
> > disassoc, disconnect and remove. In which state, driver tells firmware STA
> > info via H2C.
> >
> > TX flow:
> > When a SKB is going to be transmitted, we must know its type first. If
> > the type is mgmt or fwcmd made by driver, SKB is queued into corresponding
> > DMA channel and PCI ring. The other type is data frame that is more
> > complex, because it needs to establish BA session to have better throughput
> > with AMPDU and AMSDU.
> > In order to have better PCI DMA efficiency, we don't kick off DMA every
> > SKB. With wake TX queue, kick off DMA after a bunch of SKBs are written.
> > To achieve this, we have two HCI ops -- tx_write and tx_kick_off.
> >
> > BA establishment work:
> > For data frames, we start to establish BA session if the STA is associated
> > with APMDU capability and the TID session isn't established, and then the
> > BA work is used to ask mac80211 to start AMPDU actions. Driver implements
> > AMPDU action callbacks to know the session is established, so that we can
> > set AGG_EN bit in TX descriptor to enable AMPDU.
> >
> > RX flow:
> > When a RX SKB is delivered from PCI, rtw89_core_rx() process it depneds on
> > its type -- WIFI, C2H or PPDU. If type is C2H, it's queued into a C2H
> > queue, and wake a work to handle the C2H packet. If type is WIFI, it's a
> > normal RX packet. When mgmt or data frame is received, it is queued
> > into pending RX SKB queue to wait for corresponding PPDU packet (another
> > RX packet with PPDU type) to fill its rx_status, like RSSI. And, then
> > indicate this packet to mac80211. When control frame is received, indicate
> > it to mac80211 immediately.
> >
> > Track work:
> > Use track work to monitor PHY status to know the changes of environment,
> > and then update RA status or do RFK accordingly.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
> > +static __always_inline void RTW89_SET_TXWD(u8 *txdesc, u32 val, u8 offset, u32 mask)
> > +{
> > +	u32 *txd32 = (u32 *)txdesc;
> > +
> > +	le32p_replace_bits((__le32 *)(txd32 + offset), val, mask);
> > +}
> 
> I'm not convinced about this either, please just use inline.

This is because 'mask' argument of le32p_replace_bits() must be constant
only. If I use inline and build this driver with ccflags-y += -Os,
compiler reports errors:

In function 'field_multiplier',
    inlined from 'le32_encode_bits' at ./include/linux/bitfield.h:154:1,
    inlined from 'le32p_replace_bits' at ./include/linux/bitfield.h:154:1,
    inlined from 'RTW89_SET_FWCMD_UA32.constprop' at /work/git-root/rtwlan/rtw89/fw.h:1397:2:
./include/linux/bitfield.h:119:3: error: call to '__bad_mask' declared with attribute error: bad bitfield mask
  119 |   __bad_mask();
      |   ^~~~~~~~~~~~

I check the implement of le32p_replace_bits(), it looks like

static __always_inline void type##p_replace_bits(__##type *p,           \
                                        base val, base field)           \
{                                                                       \
        *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
}

So, I imitate the function to use __always_inline, and then it works.

Do you think I don't need to consider the case of Os?
But, -Os seems a standard option of Linux kernel.

ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
KBUILD_CFLAGS += -O2
else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
KBUILD_CFLAGS += -O3
else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
KBUILD_CFLAGS += -Os
endif

--
Ping-Ke

