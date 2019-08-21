Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3286E9722E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 08:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfHUGUS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 02:20:18 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:59543 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfHUGUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 02:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566368417; x=1597904417;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=WBkZXWKm6w/uVqLAawYFur0sYNZA3WC5C6OFy6a7AnA=;
  b=ua6E30DrXaRlL9HWWqdo4oaJBqExPCKMu6JFN+/ahSriLsGBt9rkgLVu
   yVxGjH+OLoMSGoJ3KkbbViOFw38iW1L0N05Pp2jqfrgIThfONha/bicQ2
   vVvFmHCrcJJWz8Ml/J7F+of2vwWGGXt9cJSmP2Wk/bFyz2O3wX04NB++f
   s=;
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 21 Aug 2019 14:20:16 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Aug 2019 14:20:11 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 21 Aug 2019 14:20:09 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 21 Aug 2019 14:20:09 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVV1IyEev87vakM0G2WVqJ6I35M6cFHQig
Date:   Wed, 21 Aug 2019 06:20:09 +0000
Message-ID: <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
 <87blwkt480.fsf@toke.dk>
In-Reply-To: <87blwkt480.fsf@toke.dk>
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
> Sent: Tuesday, August 20, 2019 8:24 PM
> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] Re: [PATCH 4/7] ath10k: disable TX complete indication of =
htt
> for sdio
>=20
> Wen Gong <wgong@codeaurora.org> writes:
>=20
> > Tx complete message from firmware cost bus bandwidth of sdio, and bus
> > bandwidth is the bollteneck of throughput, it will effect the bandwidth
> > occupancy of data packet of TX and RX.
> >
> > This patch disable TX complete indication from firmware for htt data
> > packet, it results in significant performance improvement on TX path.
>=20
> Wait, how does that work? Am I understanding it correctly that this
> replaces a per-packet TX completion with a periodic one sent out of
> band?
When this patch applied, firmware will not indicate tx complete for tx
Data, it only indicate HTT_T2H_MSG_TYPE_TX_CREDIT_UPDATE_IND,
This htt msg will tell how many data tx complete without status(status mayb=
e success/fail).
>=20
> And could you explain what the credits thing is for, please? :)
For high latency bus chip, all the tx data's content(include ip/udp/tcp hea=
der
and payload) will be transfer to firmware's memory via bus.
And firmware has limited memory for tx data, the tx data's content must
Saved in firmware memory before it tx complete, if ath10k transfer tx
data more than the limit, firmware will occur error. The credit is used
to avoid ath10k exceed the limit.
>=20
> -Toke
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
