Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256CA971DA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfHUGBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 02:01:15 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:34199 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfHUGBP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 02:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566367274; x=1597903274;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Z4sOZIIqc3uNbOQ5iNitu/gQo/TygmuGLUxJ+qGRP88=;
  b=yZ8p2RPRMD1Wjd4pjzW4ESxHfGnrorIpjKeIIJVGz2u79k8wawdSE3rI
   zMrB8mcuEA32T6iF0wYHIlsN2kzvrblr3t1LSGtiTCN9cADEHok6OEYNm
   8/N0sDpXv/WfK8+kXL4ZT/Ghi7P8AaXyd6tnSgfOo4PKxOtn82FK7Yfdr
   g=;
Subject: RE: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 21 Aug 2019 14:01:12 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Aug 2019 14:01:07 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 21 Aug 2019 14:01:05 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 21 Aug 2019 14:01:05 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVV1IT665ZCd8Q0062/iF/q1AQPqcFGalg
Date:   Wed, 21 Aug 2019 06:01:05 +0000
Message-ID: <59f668bda688419e9b6f44587d391135@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
 <87ef1gt49d.fsf@toke.dk>
In-Reply-To: <87ef1gt49d.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.80.80.8]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Toke
> H=F8iland-J=F8rgensen
> Sent: Tuesday, August 20, 2019 8:23 PM
> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 t=
o
> 32 for sdio
>=20
> Wen Gong <wgong@codeaurora.org> writes:
>=20
> > The max bundle size support by firmware is 32, change it from 8 to 32
> > will help performance. This results in significant performance
> > improvement on RX path.
>=20
> What happens when the hardware doesn't have enough data to fill a
> bundle? Does it send a smaller one, or does it wait until it can fill
> it?
>=20

The bundle is filled by firmware.=20
It will not wait until it can fill it.
For example, if you do ping per second, it will have only 1 ping packet
In the bundle.

> -Toke
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
