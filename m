Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08942542A0D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiFHIyY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiFHIxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:53:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0A3A9CF8
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:13:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2588D6OW0022289, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2588D6OW0022289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 8 Jun 2022 16:13:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 8 Jun 2022 16:13:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 8 Jun 2022 16:13:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Wed, 8 Jun 2022 16:13:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Eric Huang <echuang@realtek.com>,
        Bernie Huang <phhuang@realtek.com>
Subject: RE: [PATCH 1/3] ieee80211: add trigger frame definition
Thread-Topic: [PATCH 1/3] ieee80211: add trigger frame definition
Thread-Index: AQHYdViFkfeE8bWkU0utvOMtYIYSNa1FMsc0gAAAurA=
Date:   Wed, 8 Jun 2022 08:13:05 +0000
Message-ID: <edc136dc78b142c5a8f4c73e5464d994@realtek.com>
References: <20220601013917.18814-1-pkshih@realtek.com>
        <20220601013917.18814-2-pkshih@realtek.com> <87h74vshno.fsf@kernel.org>
In-Reply-To: <87h74vshno.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/6/8_=3F=3F_06:01:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Wednesday, June 8, 2022 4:07 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Eric Huang <echuang@realtek.com>; Bernie
> Huang <phhuang@realtek.com>
> Subject: Re: [PATCH 1/3] ieee80211: add trigger frame definition
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Po Hao Huang <phhuang@realtek.com>
> >
> > Define trigger stype of control frame, and its checking function, struct
> > and trigger type within common_info of trigger.
> >
> > Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  include/linux/ieee80211.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> > index 75d40acb60c1c..f3b2d5b56d643 100644
> > --- a/include/linux/ieee80211.h
> > +++ b/include/linux/ieee80211.h
> > @@ -76,6 +76,7 @@
> >  #define IEEE80211_STYPE_ACTION		0x00D0
> >
> >  /* control */
> > +#define IEEE80211_STYPE_TRIGGER		0x0020
> >  #define IEEE80211_STYPE_CTL_EXT		0x0060
> >  #define IEEE80211_STYPE_BACK_REQ	0x0080
> >  #define IEEE80211_STYPE_BACK		0x0090
> > @@ -295,6 +296,17 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
> >
> >  #define IEEE80211_HT_CTL_LEN		4
> >
> > +/* trigger type within common_info of trigger frame */
> > +#define IEEE80211_TRIGGER_TYPE_MASK		0xfULL
> > +#define IEEE80211_TRIGGER_TYPE_BASIC		0x0
> > +#define IEEE80211_TRIGGER_TYPE_BFRP		0x1
> > +#define IEEE80211_TRIGGER_TYPE_MU_BAR		0x2
> > +#define IEEE80211_TRIGGER_TYPE_MU_RTS		0x3
> > +#define IEEE80211_TRIGGER_TYPE_BSRP		0x4
> > +#define IEEE80211_TRIGGER_TYPE_GCR_MU_BAR	0x5
> > +#define IEEE80211_TRIGGER_TYPE_BQRP		0x6
> > +#define IEEE80211_TRIGGER_TYPE_NFRP		0x7
> 
> Why ULL in the mask? I don't see it used anywhere else in the file.
> 

This is because common_info in ieee80211_trigger is __le64:

+struct ieee80211_trigger {
	...
+	__le64 common_info;
	...
+}

Then, 
	type = le64_get_bits(tf->common_info, IEEE80211_TRIGGER_TYPE_MASK);
is used to access trigger type of common_info in patch 2/3.

Ping-Ke

