Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6A3AE52
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 06:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfFJEsE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 00:48:04 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:54386 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbfFJEsE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 00:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=a+MCzpnl0xNsgcO1BNyJajn0uqIgCFJ5QcmD+iHYyro=;
        b=YCubijx9eK9f9Ko/oDWdt6Qvg8YIMbn/pgO70gbQmWCHyDHKSpx/6569+7vP2TD88ivMyCH4aN07klszoX4w00nLLAum/DuJNRlpCVpI0S8J2tAw4hRR0Qlit9G+ESV1NRRVgfL+RFihIR3CMpKJwk0imNKo7fRLXunKZoP71qk=;
Subject: Re: [PATCH] mt76: mt7615: add support for per-chain signal strength
 reporting
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        linux-mediatek@lists.infradead.org, Roy Luo <royluo@google.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
References: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
 <d6cfd2e9-4b2b-36ac-6cae-a34f74204801@newmedia-net.de>
 <1560132590.28258.5.camel@mtkswgap22> <1560140541.5606.12.camel@mtkswgap22>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <64662021-8e5a-91b5-9afb-3c9005564d19@newmedia-net.de>
Date:   Mon, 10 Jun 2019 06:47:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560140541.5606.12.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f05:3a00:f095:7be4:6d09:fd49]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1haCDp-0003SA-AI; Mon, 10 Jun 2019 06:47:53 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

okay. curious is, that my variant works with sane results too.
i will test your variant and check the results

Sebastian

Am 10.06.2019 um 06:22 schrieb Ryder Lee:
> On Mon, 2019-06-10 at 10:09 +0800, Ryder Lee wrote:
>> On Sun, 2019-06-09 at 16:44 +0200, Sebastian Gottschall wrote:
>>> according to my findings
>>>
>>> MT_RXV4_RCPI1 is part of rx descriptor 4 and not 3
>>> so it must be rxdg4 = rxd[4] etc.
>> RXV start from 1 in the code.
>>
>> That is: RXV1 <-> rxdg0, RXV2 <-> rxdg1 ...so RXV4 <-> rxdg3
>>
>>> however rxdg3 contains MT_RXV3_IB_RSSIRX which can be used for signal calculation.
>>> i already wrote a similar code for this driver which i sended to felix a long time ago.
>>> my variant looks like
>>>                   status->signal = (FIELD_GET(MT_RXV3_IB_RSSIRX, rxdg3) - 220) / 2;
>>>                   status->chain_signal[0] = (FIELD_GET(MT_RXV4_RCPI0, rxdg4) - 220) / 2;
>>>                   status->chain_signal[1] = (FIELD_GET(MT_RXV4_RCPI1, rxdg4) - 220) / 2;
>>>                   status->chain_signal[2] = (FIELD_GET(MT_RXV4_RCPI2, rxdg4) - 220) / 2;
>>>                   status->chain_signal[3] = (FIELD_GET(MT_RXV4_RCPI3, rxdg4) - 220) / 2;
> mt7615 actually doesn't use in-band RSSI for signal calculation, but it
> occurs to me that i should modify the code to compare per-chain's
> signal. Something like this:
>
> 		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
> 		status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
> 		status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
> 		status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
> 		status->signal = status->chain_signal[0];
>
> 		switch (status->chains) {
> 		case 0xf:
> 			status->signal = max(status->signal,
> 					     status->chain_signal[3]);
> 		case 0x7:
> 			status->signal = max(status->signal,
> 					     status->chain_signal[2]);
> 		case 0x3:
> 			status->signal = max(status->signal,
> 					     status->chain_signal[1]);
> 			break;
> 		default:
> 			break;
> 		}
>
>
> I could send a v2 or you can take care of that.
>
> Ryder
>
>
