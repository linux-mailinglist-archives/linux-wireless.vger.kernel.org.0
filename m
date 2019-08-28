Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E669F92B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfH1EY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 00:24:29 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:1195 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfH1EY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 00:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566966267; x=1598502267;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=CXzB/bzc1cdVdYR4chC1TCl+JVX8vhGdoxM0hTLjYhA=;
  b=mFNKYmx6KEFqAw93t09j20pcDCYZMoNViSKDJqNx1AH2Lf//7tqQz9mW
   xkn6Lnjd1QnzAX5jQeDVAHyl069U+bXKdYTNsV5CjYjyM2EW0bVx3MvgC
   UEkU98pF5y2rNkNoyIZ3hJQaXABacaQe0wGG/sl53GebHPAlqWRSolDAm
   I=;
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 28 Aug 2019 12:24:26 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Aug 2019 12:24:21 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 28 Aug 2019 12:24:19 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 28 Aug 2019 12:24:19 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXKzzjxZCt6O9SkuF3pWkouQdf6cP9z3g
Date:   Wed, 28 Aug 2019 04:24:19 +0000
Message-ID: <7975595590134eb298cf3c0ea17aa4b1@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
 <CANMq1KDo1xur9M7+XgNWkdarJOQfu9_Ofk=G5ajypWpq00e9=A@mail.gmail.com>
In-Reply-To: <CANMq1KDo1xur9M7+XgNWkdarJOQfu9_Ofk=G5ajypWpq00e9=A@mail.gmail.com>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Nicolas
> Boichat
> Sent: Tuesday, August 27, 2019 3:56 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH 4/7] ath10k: disable TX complete indication of =
htt
> for sdio
>=20
> On Tue, Aug 20, 2019 at 7:55 PM Wen Gong <wgong@codeaurora.org> wrote:
> >
> > Tx complete message from firmware cost bus bandwidth of sdio, and bus
> > bandwidth is the bollteneck of throughput, it will effect the bandwidth
> > occupancy of data packet of TX and RX.
> >
> > This patch disable TX complete indication from firmware for htt data
> > packet, it results in significant performance improvement on TX path.
> >
Patch v2 sent with the changes, https://patchwork.kernel.org/patch/11116685=
/

> >
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
