Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338636BAF79
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 12:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjCOLqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjCOLqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 07:46:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C7265AA
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 04:46:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32FBk17w9002790, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32FBk17w9002790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 15 Mar 2023 19:46:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Mar 2023 19:45:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Mar 2023 19:45:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 15 Mar 2023 19:45:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
CC:     Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/5] wifi: rtw89: 8852c: add beacon filter and CQM support
Thread-Topic: [PATCH 1/5] wifi: rtw89: 8852c: add beacon filter and CQM
 support
Thread-Index: AQHZUwM9emcfit61BUyDIkN8d0SOjK77iydZgAAFchCAAC/jYA==
Date:   Wed, 15 Mar 2023 11:45:20 +0000
Message-ID: <e379029310cd4737ba3dd579394fba19@realtek.com>
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-2-pkshih@realtek.com>
 <87zg8emn4i.fsf@kernel.org> <e3670d1075f54c69ba3971067b3d06b7@realtek.com>
In-Reply-To: <e3670d1075f54c69ba3971067b3d06b7@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Wednesday, March 15, 2023 4:58 PM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: RE: [PATCH 1/5] wifi: rtw89: 8852c: add beacon filter and CQM support
> 
> > -----Original Message-----
> > From: Kalle Valo <kvalo@kernel.org>
> > Sent: Wednesday, March 15, 2023 4:32 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org
> > Subject: Re: [PATCH 1/5] wifi: rtw89: 8852c: add beacon filter and CQM support
> >
> > Ping-Ke Shih <pkshih@realtek.com> writes:
> >
> > > From: Po-Hao Huang <phhuang@realtek.com>
> > >
> > > Adding this supports beacon filter and connection quality monitor.
> > > To make host CPU wake up less, let firmware perform signal
> > > monitoring and beacon processing, then notify driver upon signal
> > > changes or beacon loss.
> > >
> > > This feature needs firmware 0.27.56 or newer to support it.
> > >
> > > Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > [...]
> >
> > > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > > @@ -1438,6 +1438,8 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
> > >       struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
> > >       struct sk_buff *skb = iter_data->skb;
> > >       struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> > > +     struct rtw89_rx_phy_ppdu *phy_ppdu =
> > > +             (struct rtw89_rx_phy_ppdu *)iter_data->phy_ppdu;
> >
> > Why the cast? I don't think it's needed.
> 
> Will fix it by next version.
> 
> >
> > > @@ -3181,6 +3204,15 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
> > >  #define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
> > >       le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
> > >
> > > +#define RTW89_GET_MAC_BCNFLTR_RPT_MACID(c2h) \
> > > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
> > > +#define RTW89_GET_MAC_BCNFLTR_RPT_TYPE(c2h) \
> > > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(9, 8))
> > > +#define RTW89_GET_MAC_BCNFLTR_RPT_EVENT(c2h) \
> > > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(11, 10))
> > > +#define RTW89_GET_MAC_BCNFLTR_RPT_MA(c2h) \
> > > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
> >
> > I have to admit that I every time I see this code pattern it makes me
> > regret it. Something like what Arnd proposed back in the day would look
> > so much cleaner:
> >
> > https://lore.kernel.org/all/CAK8P3a1rsKZZKMKFTDWgE3usX9gYKJqUvTMxSdEuZrp8BaKdaA@mail.gmail.com/
> >
> > Of course this is just a generic comment about rtw89, and has nothing to
> > do with this patchset, but it would be great if someone could take a
> > look and try out Arnd's proposal. It would be good to start with just
> > one or two commands and send that as an RFC to see how it looks like.
> >
> 
> I write a draft RFC here. Please see if it's in expectation. If so, I can
> change all of them by another patch or RFC.
> 
> In header file:
> 
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID_MASK GENMASK(7, 0)
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_TYPE_MASK GENMASK(9, 8)
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT_MASK GENMASK(11, 10)
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA_MASK GENMASK(23, 16)
> 
> 
> Access the values via le32_get_bits() in functions somewhere:
> 
> 	const __le32 *c2h = skb->data;
> 
> 	type =   le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID_MASK);
> 	sig =    le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA_MASK) - MAX_RSSI;
> 	event =  le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT_MASK);
> 	mac_id = le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID_MASK);
> 

I forget to propose a RFC for writing (e.g. H2C commands to firmware), and
here they are:

	__le32 *h2c = skb->data;

#define RTW89_H2C_DISCONNECT_DETECT_W0_ENABLE BIT(0)
#define RTW89_H2C_DISCONNECT_DETECT_W0_TRYOK_BCNFAIL_COUNT_EN BIT(1)
#define RTW89_H2C_DISCONNECT_DETECT_W0_DISCONNECT BIT(2)
#define RTW89_H2C_DISCONNECT_DETECT_W0_MAC_ID GENMASK(15, 8)
#define RTW89_H2C_DISCONNECT_DETECT_W0_CHECK_PERIOD GENMASK(23, 16)
#define RTW89_H2C_DISCONNECT_DETECT_W0_TRY_PKT_COUNT GENMASK(31, 24)
#define RTW89_H2C_DISCONNECT_DETECT_W1_TRYOK_BCNFAIL_COUNT_LIMIT GENMASK(7, 0)

	h2c[0] = le32_encode_bits(enable, RTW89_H2C_DISCONNECT_DETECT_W0_ENABLE) |
		 le32_encode_bits(!enable, RTW89_H2C_DISCONNECT_DETECT_W0_DISCONNECT) |
		 le32_encode_bits(macid, RTW89_H2C_DISCONNECT_DETECT_W0_MAC_ID) |
		 le32_encode_bits(100, RTW89_H2C_DISCONNECT_DETECT_W0_CHECK_PERIOD);
	h2c[1] = le32_encode_bits(5, RTW89_H2C_DISCONNECT_DETECT_W1_TRYOK_BCNFAIL_COUNT_LIMIT);


Ping-Ke


