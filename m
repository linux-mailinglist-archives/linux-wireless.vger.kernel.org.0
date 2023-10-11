Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0B7C4E60
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjJKJTr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjJKJTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 05:19:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0191
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 02:19:43 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B9JPxeC3857870, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B9JPxeC3857870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 17:19:25 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 11 Oct 2023 17:19:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Oct 2023 17:19:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 17:19:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] wifi: rtw89: add EHT radiotap in monitor mode
Thread-Topic: [PATCH v2 6/6] wifi: rtw89: add EHT radiotap in monitor mode
Thread-Index: AQHZ+x8C65IQAoUJ7kiM6zWajLzKz7BEUELtgAAAk+A=
Date:   Wed, 11 Oct 2023 09:19:24 +0000
Message-ID: <167371414b9a42dbbfbdf3268fcc7991@realtek.com>
References: <20231010021006.6061-1-pkshih@realtek.com>
        <20231010021006.6061-7-pkshih@realtek.com> <87il7d4j3u.fsf@kernel.org>
In-Reply-To: <87il7d4j3u.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Wednesday, October 11, 2023 5:14 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v2 6/6] wifi: rtw89: add EHT radiotap in monitor mode
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > Add IEEE80211_RADIOTAP_EHT and IEEE80211_RADIOTAP_EHT_USIG radiotap to
> > fill basic EHT NSS, MCS, GI and bandwidth.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/core.c | 66 +++++++++++++++++++++++
> >  drivers/net/wireless/realtek/rtw89/core.h |  9 +++-
> >  2 files changed, 74 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> > index 2742e6646cf1..8cb1715d049a 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -1907,6 +1907,70 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
> >       rx_status->rate_idx -= 4;
> >  }
> >
> > +static u8 rx_status_bw_to_radiotap_eht_usig[] = {
> > +     [RATE_INFO_BW_20] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_20MHZ,
> > +     [RATE_INFO_BW_5] = U8_MAX,
> > +     [RATE_INFO_BW_10] = U8_MAX,
> > +     [RATE_INFO_BW_40] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_40MHZ,
> > +     [RATE_INFO_BW_80] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_80MHZ,
> > +     [RATE_INFO_BW_160] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_160MHZ,
> > +     [RATE_INFO_BW_HE_RU] = U8_MAX,
> > +     [RATE_INFO_BW_320] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_320MHZ_1,
> > +     [RATE_INFO_BW_EHT_RU] = U8_MAX,
> > +};
> 
> Sorry, I noticed this only when I was abot to commit this. Should this
> be static const?

Yes, I miss it.

> 
> > +static void rtw89_core_update_radiotap_eht(struct rtw89_dev *rtwdev,
> > +                                        struct sk_buff *skb,
> > +                                        struct ieee80211_rx_status *rx_status)
> > +{
> > +     struct ieee80211_radiotap_eht_usig *usig;
> > +     struct ieee80211_radiotap_eht *eht;
> > +     struct ieee80211_radiotap_tlv *tlv;
> > +     int eht_len = struct_size(eht, user_info, 1);
> > +     int usig_len = sizeof(*usig);
> > +     int len;
> > +     u8 bw;
> > +
> > +     len = sizeof(*tlv) + ALIGN(eht_len, 4) +
> > +           sizeof(*tlv) + ALIGN(usig_len, 4);
> > +
> > +     rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
> > +     skb_reset_mac_header(skb);
> > +
> > +     /* EHT */
> > +     tlv = skb_push(skb, len);
> > +     memset(tlv, 0, len);
> > +     tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT);
> > +     tlv->len = cpu_to_le16(eht_len);
> > +
> > +     eht = (struct ieee80211_radiotap_eht *)tlv->data;
> > +     eht->known = cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_GI);
> > +     eht->data[0] =
> > +             le32_encode_bits(rx_status->eht.gi, IEEE80211_RADIOTAP_EHT_DATA0_GI);
> > +
> > +     eht->user_info[0] =
> > +             cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
> > +                         IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O);
> > +     eht->user_info[0] |=
> > +             le32_encode_bits(rx_status->rate_idx, IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
> > +             le32_encode_bits(rx_status->nss, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
> > +
> > +     /* U-SIG */
> > +     tlv = (void *)tlv + sizeof(*tlv) + ALIGN(eht_len, 4);
> > +     tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
> > +     tlv->len = cpu_to_le16(usig_len);
> > +
> > +     bw = rx_status->bw < ARRAY_SIZE(rx_status_bw_to_radiotap_eht_usig) ?
> > +          rx_status_bw_to_radiotap_eht_usig[rx_status->bw] : U8_MAX;
> > +     if (bw == U8_MAX)
> > +             return;
> 
> This is cosmetics but I feel that 'if' statement is more readable than
> ':' operator:
> 
> if (rx_status->bw >= ARRAY_SIZE(rx_status_bw_to_radiotap_eht_usig)
>         return;
> 
> bw = rx_status_bw_to_radiotap_eht_usig[rx_status->bw];
> 

Got it. I will prepare v3 for them.

Thank you. 

