Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE22A2CFF
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfH3CwU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:52:20 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:46981 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbfH3CwU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133538; x=1598669538;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=JAiY7LbEsdAUN6ap71H6955nIQdA1Ou1KE3uQG8mYSs=;
  b=EZoORRBsENnAQnwUg6ShcyUkYhyoAnbyBFT/M6IOF3cIS8RR+li8NKOf
   t1eRv/xFWFv7Ix8F9NbZ2ORk0R7HyZ0GAi8TRhVt5gxOqLhshmVuWCKYz
   1YvtG2V2Nr7q5vRcER3RtHOOh8X92q0vkURjXwNMBvdNbDp/SmbduiG1c
   4=;
Subject: RE: [PATCH v2 6/7] ath10k: enable alt data of TX path for sdio
Thread-Topic: [PATCH v2 6/7] ath10k: enable alt data of TX path for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 30 Aug 2019 10:52:17 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:52:17 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:52:15 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:52:15 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXWLfkQPj6Bb+V0+8K59OZN03UacTAPOQ
Date:   Fri, 30 Aug 2019 02:52:15 +0000
Message-ID: <46f55dc93a744069a4107e1bce6674a0@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-7-git-send-email-wgong@codeaurora.org>
 <CANMq1KDJSwyzz2y-yadJPnGijm=G6y0zg1tMZDyacH8a990BOg@mail.gmail.com>
In-Reply-To: <CANMq1KDJSwyzz2y-yadJPnGijm=G6y0zg1tMZDyacH8a990BOg@mail.gmail.com>
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
> Sent: Wednesday, August 28, 2019 1:38 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 6/7] ath10k: enable alt data of TX path for =
sdio
>=20
Changed and V3 sent, https://patchwork.kernel.org/patch/11122141/

>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
