Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730436204CA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 01:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiKHAmr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 19:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiKHAmq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 19:42:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABE9724F34
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 16:42:45 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A80fxXgB012793, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A80fxXgB012793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Nov 2022 08:41:59 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Nov 2022 08:42:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Nov 2022 08:42:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 8 Nov 2022 08:42:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852b: change debug mask of message of no TX resource
Thread-Topic: [PATCH] wifi: rtw89: 8852b: change debug mask of message of no
 TX resource
Thread-Index: AQHY71WQnsVH3zhrYUyie5/LKnbp8a4za3DVgADLfzA=
Date:   Tue, 8 Nov 2022 00:42:36 +0000
Message-ID: <fdf7dc9ba2bc4f649b9e3fa2b9c12f03@realtek.com>
References: <20221103072517.15284-1-pkshih@realtek.com>
 <87sfivt05w.fsf@kernel.org>
In-Reply-To: <87sfivt05w.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/11/7_=3F=3F_10:50:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, November 7, 2022 8:33 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] wifi: rtw89: 8852b: change debug mask of message of no TX resource
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > 8852B has smaller TX FIFO than others in WiFi chip, so it would be buffer
> > full frequently, but it doesn't affect TX performance. However, it shows
> > verbose debug messages with RTW89_DBG_UNEXP mask that is to show up
> > abnormal behavior, so change debug mask to RTW89_DBG_TXRX for 8852B.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/pci.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
> > index 07a2e23759f0b..99a254d7ba5ed 100644
> > --- a/drivers/net/wireless/realtek/rtw89/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> > @@ -971,8 +971,10 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
> >  	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> >  	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
> >  	struct rtw89_pci_tx_wd_ring *wd_ring = &tx_ring->wd_ring;
> > +	const struct rtw89_chip_info *chip = rtwdev->chip;
> >  	u32 bd_cnt, wd_cnt, min_cnt = 0;
> >  	struct rtw89_pci_rx_ring *rx_ring;
> > +	enum rtw89_debug_mask debug_mask;
> >  	u32 cnt;
> >
> >  	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
> > @@ -996,10 +998,16 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
> >  	bd_cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
> >  	wd_cnt = wd_ring->curr_num;
> >  	min_cnt = min(bd_cnt, wd_cnt);
> > -	if (min_cnt == 0)
> > -		rtw89_debug(rtwdev, rtwpci->low_power ? RTW89_DBG_TXRX : RTW89_DBG_UNEXP,
> > +	if (min_cnt == 0) {
> > +		if (rtwpci->low_power || chip->chip_id == RTL8852B)
> > +			debug_mask = RTW89_DBG_TXRX;
> > +		else
> > +			debug_mask = RTW89_DBG_UNEXP;
> > +
> > +		rtw89_debug(rtwdev, debug_mask,
> >  			    "still no tx resource after reclaim: wd_cnt=%d bd_cnt=%d\n",
> >  			    wd_cnt, bd_cnt);
> > +	}
> 
> Changing the debug mask like this looks a bit weird to me. At least it
> would be good to have a comment in the code explainin why this is done
> like this.
> 

I will add a comment to figure out the reason.

Ping-Ke

