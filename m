Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFAC20D291
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgF2Su1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 14:50:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34474 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgF2SuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:24 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05T5KAPd8027358, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05T5KAPd8027358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 13:20:10 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 13:20:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 13:20:10 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Mon, 29 Jun 2020 13:20:10 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        Nick Owens <mischief@offblast.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: fix skb_under_panic in tx path
Thread-Topic: [PATCH] rtw88: fix skb_under_panic in tx path
Thread-Index: AQHWSy3fNWZ7ZTAl2026K9XMJhOX9ajpgAiAgAWS6IA=
Date:   Mon, 29 Jun 2020 05:20:09 +0000
Message-ID: <e42b0d0e87b2461a9b023e432635e6a6@realtek.com>
References: <20200625201857.almm27xgzburyxxu@wololo.home.arpa>
 <3d8546b66a4f2027a7fab1de291ec40f@adapt-ip.com>
In-Reply-To: <3d8546b66a4f2027a7fab1de291ec40f@adapt-ip.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On 2020-06-25 13:18, Nick Owens wrote:
> > hello :)
> 
> Hi Nick :)
> 
> > this change fixes a reliable crash on my thinkpad A485.
> >
> > please note i have no prior experience doing kernel development or
> > sending patches, and i'm not sure if this is a correct approach.
> 
> You probably want to submit patches with git-send-email. See
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatch
> es
> 
> > From aa589182d30a0f99e1b3201ed4f3830e8af71dac Mon Sep 17 00:00:00
> 2001
> > From: Nick Owens <mischief@offblast.org>
> > Date: Thu, 25 Jun 2020 12:55:41 -0700
> > Subject: [PATCH] rtw88: fix skb_under_panic in tx path
> >
> > fixes the following panic on my thinkpad A485
> >
> > Oops#1 Part3
> > <0>[ 3743.881656] skbuff: skb_under_panic: text:000000005f69fd98
> > len:208 put:48 head:000000009e2719e8 data:00000000bd3795e0 tail:0xc2
> > end:0x2c0 dev:wlp2s0
> 
> skb->head and skb->data here are really far (0.5GB) apart. Maybe
> skb->data actually got corrupted earlier?
> 
> > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
> > b/drivers/net/wireless/realtek/rtw88/pci.c
> > index d735f3127fe8..21b3b268cb25 100644
> > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > @@ -741,6 +741,12 @@ static int rtw_pci_tx_write_data(struct rtw_dev
> > *rtwdev,
> >  	else if (!avail_desc(ring->r.wp, ring->r.rp, ring->r.len))
> >  		return -ENOSPC;
> >
> > +	if (skb_headroom(skb) < chip->tx_pkt_desc_sz &&
> > +	    pskb_expand_head(skb, chip->tx_pkt_desc_sz - skb_headroom(skb),
> > 0, GFP_ATOMIC)) {
> > +		dev_err(rtwdev->dev, "no headroom available");
> > +		return -ENOMEM;
> > +	}
> > +
> 
> If it is a headroom issue, you can actually express the needed headroom
> needed by the driver in hw->extra_tx_headroom during init and avoid the
> pskb_expand_head() here.
> 

Looks like a headroom issue, but the driver already assigned headroom.
	max_tx_headroom = rtwdev->chip->tx_pkt_desc_sz;
	hw->extra_tx_headroom = max_tx_headroom;

Then I am not sure why this happens. Nick, can you help to dump_stack()
so we can see where is the skb from?

Yen-Hsuan
