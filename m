Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636623ADDD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 06:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfFJEWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 00:22:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20318 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfFJEWm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 00:22:42 -0400
X-UUID: 9d2390c1bdd04e9e982503720ff051eb-20190610
X-UUID: 9d2390c1bdd04e9e982503720ff051eb-20190610
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 732374127; Mon, 10 Jun 2019 12:22:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 12:22:21 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 12:22:21 +0800
Message-ID: <1560140541.5606.12.camel@mtkswgap22>
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
Date:   Mon, 10 Jun 2019 12:22:21 +0800
In-Reply-To: <1560132590.28258.5.camel@mtkswgap22>
References: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
         <d6cfd2e9-4b2b-36ac-6cae-a34f74204801@newmedia-net.de>
         <1560132590.28258.5.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-06-10 at 10:09 +0800, Ryder Lee wrote:
> On Sun, 2019-06-09 at 16:44 +0200, Sebastian Gottschall wrote:
> > according to my findings
> > 
> > MT_RXV4_RCPI1 is part of rx descriptor 4 and not 3
> > so it must be rxdg4 = rxd[4] etc.
> 
> RXV start from 1 in the code.
> 
> That is: RXV1 <-> rxdg0, RXV2 <-> rxdg1 ...so RXV4 <-> rxdg3
> 
> > however rxdg3 contains MT_RXV3_IB_RSSIRX which can be used for signal calculation.
> > i already wrote a similar code for this driver which i sended to felix a long time ago.
> > my variant looks like
> >                  status->signal = (FIELD_GET(MT_RXV3_IB_RSSIRX, rxdg3) - 220) / 2;
> >                  status->chain_signal[0] = (FIELD_GET(MT_RXV4_RCPI0, rxdg4) - 220) / 2;
> >                  status->chain_signal[1] = (FIELD_GET(MT_RXV4_RCPI1, rxdg4) - 220) / 2;
> >                  status->chain_signal[2] = (FIELD_GET(MT_RXV4_RCPI2, rxdg4) - 220) / 2;
> >                  status->chain_signal[3] = (FIELD_GET(MT_RXV4_RCPI3, rxdg4) - 220) / 2;

mt7615 actually doesn't use in-band RSSI for signal calculation, but it
occurs to me that i should modify the code to compare per-chain's
signal. Something like this:

		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
		status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
		status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
		status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
		status->signal = status->chain_signal[0];

		switch (status->chains) {
		case 0xf:
			status->signal = max(status->signal,
					     status->chain_signal[3]);
		case 0x7:
			status->signal = max(status->signal,
					     status->chain_signal[2]);
		case 0x3:
			status->signal = max(status->signal,
					     status->chain_signal[1]);
			break;
		default:
			break;
		}


I could send a v2 or you can take care of that.

Ryder

