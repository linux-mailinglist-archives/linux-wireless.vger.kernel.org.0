Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF6A7909
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIDCxG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:53:06 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:25304 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727722AbfIDCxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567565585; x=1599101585;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ce1LyIJsst268UIaT8qzmnUQzaBGDuk7qlW2EIvBuEo=;
  b=BVlEmed8V0SjUXpaxCinuKMlSr0/1vuADjJUUO8PKhZIEVuzHwp1do6T
   eukF+rg+c9HUwb++xJWNKk9XjBCcvENABEg9zdwl+k9GwwZxF2UcQmxkQ
   9HU5I/DhAg3sBuXEekYHmZJVjVYsaeFqecffxNMzRvyav4dHqxoxtltcZ
   A=;
Subject: RE: [PATCH v3 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH v3 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 04 Sep 2019 10:53:04 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 10:52:59 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 10:52:57 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 10:52:57 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXuCgv+l+3UA4lk6mCk3Lpfzlu6ca2cxw
Date:   Wed, 4 Sep 2019 02:52:57 +0000
Message-ID: <bf3c71d1826a4a238d0b0fd41058ed08@aptaiexm02f.ap.qualcomm.com>
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org>
 <1566998177-2658-4-git-send-email-wgong@codeaurora.org>
 <CANMq1KDLXsar1AqU=mfce-2LGD7SRDmC5phkKtz92D3BG35Eog@mail.gmail.com>
In-Reply-To: <CANMq1KDLXsar1AqU=mfce-2LGD7SRDmC5phkKtz92D3BG35Eog@mail.gmail.com>
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
> Sent: Friday, August 30, 2019 11:11 AM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v3 3/8] ath10k: change max RX bundle size from =
8
> to 32 for sdio
Patch v4 sent, https://patchwork.kernel.org/patch/11126225/
>=20
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
