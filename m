Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A42A7A35
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 06:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfIDEnb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 00:43:31 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:34223 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728515AbfIDEna (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567572209; x=1599108209;
  h=from:to:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=DMDQwa1wMgq3WtQtLRk0tX1gDVhgMz6LcVx5a87hHFo=;
  b=P8kXHcZxs6TDG/bnelMFI5ijqrqhnVXRP9PYzmTneIydX54FwqQciDX0
   DYN20LHeSLZaQir0l+NuDNa2T77UdzKJcIXas9ZCVAgNfWATJh8pHzyH9
   r+wgjDNQ+l67Gt1fXYqbMTtJqpUO0EZfUiODkY4PhkchpnOLKkXmvEcNj
   E=;
Subject: RE: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 04 Sep 2019 12:43:27 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 12:43:23 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 12:43:21 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 12:43:21 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Dave Taht <dave@taht.net>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYnII1QGsPhG3K0ybAPHFlPgABKca8VbA
Date:   Wed, 4 Sep 2019 04:43:21 +0000
Message-ID: <259d8d7f8c2a4c428ae14ff211c83c1a@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
        <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
 <87k1apnyyo.fsf@taht.net>
In-Reply-To: <87k1apnyyo.fsf@taht.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.249.136.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: Dave Taht <dave@taht.net>
> Sent: Wednesday, September 4, 2019 12:10 AM
> To: Wen Gong <wgong@qti.qualcomm.com>; ath10k@lists.infradead.org;
> linux-wireless@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 t=
o
> 32 for sdio
>=20
>=20
> In terms of deeply grokking what increasing buffering to achieve high
> bandwidth on a testbench, vs what it can do to clobber latency in the
> real world at low bandwidths, I tend to point folk at:
>=20
> https://www.youtube.com/watch?v=3DRb-UnHDw02o&t=3D25m40s
>=20
> where I got a whole bunch of hackers to stand up and act like packets
> in an aggregating FIFO wifi queue.
>=20
> This key section is only 8 minutes long, and I promise, y'all laugh
> at least 3 times at the demonstration.
>=20
> At the time, also, the ath10k was so overbuffered that on one test
> I could try to start 100 flows, and only get five.
>=20
> https://lwn.net/Articles/705884/
>=20
> and on my slides:
>=20
> https://blog.linuxplumbersconf.org/2016/ocw//system/presentations/3963/
> original/linuxplumbers_wifi_latency-3Nov.pdf
>=20
Hi Dave,
So your mean is change 8  to 32 will impact latency? It will increase laten=
cy of rx?

>=20
> 0xFFFEFFFF
