Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2955A0262
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfH1M77 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 08:59:59 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:29647 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfH1M77 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 08:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566997198; x=1598533198;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=wOU4tVJO3ByJwR7Ch5MaE86PQonwsrDPw/6jEeqaQdE=;
  b=azE88Xdp+YEunauBrvo+vGLkfhxyD4U59kelXnK2iZwnvFIYmnfBvcLN
   omYPwhegnwmHc14xSRfph2DIMcMm/ljh84zumcePNdVSZ6UdmVzP8Ig2p
   Wzu9Txcor2uWngi7lTe9OXS2jbm3WQNLfctt2guPxbReJJ9qyjDfyEiPu
   k=;
Subject: RE: [PATCH v2 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH v2 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 28 Aug 2019 20:59:56 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Aug 2019 20:59:52 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 28 Aug 2019 20:59:50 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 28 Aug 2019 20:59:50 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXWFSQ/SJykVh+UihzVRM6dfs6acQhZzQ
Date:   Wed, 28 Aug 2019 12:59:50 +0000
Message-ID: <d97ba89eaee24e07ac14c34fca2ad46d@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-5-git-send-email-wgong@codeaurora.org>
 <CANMq1KDeQaJWYiAz=P9pKm0_seNmtnEHVgt9T0-=40Ew=zLs0A@mail.gmail.com>
In-Reply-To: <CANMq1KDeQaJWYiAz=P9pKm0_seNmtnEHVgt9T0-=40Ew=zLs0A@mail.gmail.com>
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
> Sent: Wednesday, August 28, 2019 1:27 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 4/7] ath10k: disable TX complete indication =
of
> htt for sdio
> >  static unsigned int ath10k_cryptmode_param;
> >  static bool uart_print;
> > +static bool disable_tx_comp =3D true;
>=20
> So you don't like my feedback to call this enable_tx_comp? That's ok,
> but please let me know why ,-)
Since tx complete is enabled by default, so disable_tx_comp will be a=20
Make sense word per my understand.
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
