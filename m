Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525AAA9F4E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfIEKNJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 06:13:09 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:29565 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfIEKNJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 06:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567678387; x=1599214387;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=c8lnVKRd4oYfcb+T9m4p99nIX6j6JBOUVLqQAzWi6bQ=;
  b=Fcqvg/aX3pHfqPBxi6mO+EADWkhSNYyk0T/XQwMQq2eSgpcLDfJq2pgh
   1dxdhRAjH45dBLoZkWr+3lhDv4qROSIMVNAeb97WLZMjP4Kz+4H+Lf+yk
   Oi/KvcdiHG8WBQhNvHZ1KzjhseDeGxzMbum0gqYJqvVY5OIvRak96PTMA
   E=;
Subject: RE: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 05 Sep 2019 18:13:06 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Sep 2019 18:13:02 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Thu, 5 Sep 2019 18:12:18 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Thu, 5 Sep 2019 18:12:18 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Dave Taht <dave@taht.net>
CC:     "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYyWHN94QO+EK10ysmtsaB0TpPacc3hzQ
Date:   Thu, 5 Sep 2019 10:12:17 +0000
Message-ID: <6ffd391176154f72a964b22090d89f9d@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
        <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
        <87k1apnyyo.fsf@taht.net>
        <259d8d7f8c2a4c428ae14ff211c83c1a@aptaiexm02f.ap.qualcomm.com>
 <87lfv4chi2.fsf@taht.net>
In-Reply-To: <87lfv4chi2.fsf@taht.net>
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
> Sent: Wednesday, September 4, 2019 9:34 PM
> To: Wen Gong <wgong@qti.qualcomm.com>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 t=
o
> 32 for sdio
>=20
> > Hi Dave,
> > So your mean is change 8  to 32 will impact latency? It will increase l=
atency
> of rx?
>=20
> Heh. for rx, in this case, probably not!
>=20
> I just get twitchy every time folk fiddle with buffer sizes. In one
> recent case someone had fiddled with the interrupt polling interval on
> something, going from 1ms to 10ms - it saved on cpu, but...
> ... just trying to make sure folk grok the tradoffs with a bit of
> laughter.
>=20
> carry on!
Hah, so you do not have any concern about this patch.
Patch 3 sent, https://patchwork.kernel.org/patch/11122175/
>=20
> >
> >>
> >> 0xFFFEFFFF
