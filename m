Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E670E25E01
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2019 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEVGYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 May 2019 02:24:35 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:42200 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfEVGYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 May 2019 02:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1558506273; x=1590042273;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=cOHiQkwHCdKnpqdqLXnm29nEAGaGFK9XtWEviAGAfyI=;
  b=ksauLWOnayPPfGPNybxminEwpA/grj2T14X4q7/e7GL3+LNTzXsC5aLW
   tCRJ6xf9s6GjbTJjstU4PPQWkdZ0EbfQtxVqMM1YxNBrbPCnHsB3adnPY
   dv1SKY8eDiWxk7xHgHMoa0XhwlDxaIzp0kGUe6OytZuuYjJYqXAqKBZ4+
   c=;
Subject: RE: [PATCH v2] ath10k: add support for simulate crash on SDIO chip
Thread-Topic: [PATCH v2] ath10k: add support for simulate crash on SDIO chip
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 22 May 2019 14:24:32 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9264"; a="29982290"
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 May 2019 14:24:27 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Wed, 22 May 2019 14:24:24 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1395.000; Wed, 22 May 2019 14:24:24 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Claire Chang <tientzu@google.com>, Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVCslW/u/fYzi78E+Y5SXBgv663aZ2uDcw
Date:   Wed, 22 May 2019 06:24:24 +0000
Message-ID: <5b1f1d8619524128894e5f31ca4733af@aptaiexm02f.ap.qualcomm.com>
References: <1556524457-17469-1-git-send-email-wgong@codeaurora.org>
 <CALiNf29_GwSEUJ_vdp+_1DeDyFZj0uuUY9kYh94w4P_eeDT=8g@mail.gmail.com>
In-Reply-To: <CALiNf29_GwSEUJ_vdp+_1DeDyFZj0uuUY9kYh94w4P_eeDT=8g@mail.gmail.com>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Claire
> Chang
> Sent: Wednesday, May 15, 2019 10:53 AM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2] ath10k: add support for simulate crash on S=
DIO
> chip
>=20
> Tested-by: Claire Chang <tientzu@chromium.org>
>=20
> If this patch adds support for detecting the real firmware assert,
> maybe the title should be "add support for _crash recovery_ on SDIO
> chip"
Yes, seems this title is more appropriate.
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
