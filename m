Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930AB3AF56
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 09:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfFJHMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 03:12:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60903 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387581AbfFJHMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 03:12:19 -0400
X-UUID: 9f0457cc934d4f35b73fcb4307072f38-20190610
X-UUID: 9f0457cc934d4f35b73fcb4307072f38-20190610
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1673450468; Mon, 10 Jun 2019 15:12:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 15:12:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 15:12:09 +0800
Message-ID: <1560150729.14203.11.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: mt7615: add support for per-chain signal strength
 reporting
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, Roy Luo <royluo@google.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "Felix Fietkau" <nbd@nbd.name>
Date:   Mon, 10 Jun 2019 15:12:09 +0800
In-Reply-To: <64662021-8e5a-91b5-9afb-3c9005564d19@newmedia-net.de>
References: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
         <d6cfd2e9-4b2b-36ac-6cae-a34f74204801@newmedia-net.de>
         <1560132590.28258.5.camel@mtkswgap22> <1560140541.5606.12.camel@mtkswgap22>
         <64662021-8e5a-91b5-9afb-3c9005564d19@newmedia-net.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0BD6B986BECE4C40659DF7058A6D7B24417A93659896793BB653FCF3A5D280E92000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-06-10 at 06:47 +0200, Sebastian Gottschall wrote:
> okay. curious is, that my variant works with sane results too.
> i will test your variant and check the results
> 
> Sebastian

Please don't top post as it's hard to track the thread.

More specifically, IBRSSI is obtained from packet's L-STF portion and
MTK HW PD (packet detection) will take it as a reference. (with
variation more or less)

As for RCPI which is calculated from packet's data portion. The other
MTK chipsets may use IBRSSI as their baseband couldn't report RCPI.

Ryder

> Am 10.06.2019 um 06:22 schrieb Ryder Lee:
> > On Mon, 2019-06-10 at 10:09 +0800, Ryder Lee wrote:
> >> On Sun, 2019-06-09 at 16:44 +0200, Sebastian Gottschall wrote:
> >>> according to my findings
> >>>
> >>> MT_RXV4_RCPI1 is part of rx descriptor 4 and not 3
> >>> so it must be rxdg4 = rxd[4] etc.
> >> RXV start from 1 in the code.
> >>
> >> That is: RXV1 <-> rxdg0, RXV2 <-> rxdg1 ...so RXV4 <-> rxdg3
> >>
> >>> however rxdg3 contains MT_RXV3_IB_RSSIRX which can be used for signal calculation.
> >>> i already wrote a similar code for this driver which i sended to felix a long time ago.
> >>> my variant looks like
> >>>                   status->signal = (FIELD_GET(MT_RXV3_IB_RSSIRX, rxdg3) - 220) / 2;
> >>>                   status->chain_signal[0] = (FIELD_GET(MT_RXV4_RCPI0, rxdg4) - 220) / 2;
> >>>                   status->chain_signal[1] = (FIELD_GET(MT_RXV4_RCPI1, rxdg4) - 220) / 2;
> >>>                   status->chain_signal[2] = (FIELD_GET(MT_RXV4_RCPI2, rxdg4) - 220) / 2;
> >>>                   status->chain_signal[3] = (FIELD_GET(MT_RXV4_RCPI3, rxdg4) - 220) / 2;
> > mt7615 actually doesn't use in-band RSSI for signal calculation, but it
> > occurs to me that i should modify the code to compare per-chain's
> > signal. Something like this:
> >
> > 		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
> > 		status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
> > 		status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
> > 		status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
> > 		status->signal = status->chain_signal[0];
> >
> > 		switch (status->chains) {
> > 		case 0xf:
> > 			status->signal = max(status->signal,
> > 					     status->chain_signal[3]);
> > 		case 0x7:
> > 			status->signal = max(status->signal,
> > 					     status->chain_signal[2]);
> > 		case 0x3:
> > 			status->signal = max(status->signal,
> > 					     status->chain_signal[1]);
> > 			break;
> > 		default:
> > 			break;
> > 		}
> >
> >
> > I could send a v2 or you can take care of that.
> >
> > Ryder
> >
> >


