Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70803A2D05
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfH3Cy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:54:28 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:54485 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfH3Cy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133667; x=1598669667;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ombiV9o10Jt3Chz64WGOIxId9Rw7x93r/0lS2evzSrs=;
  b=AS4ZQrDa+dmYtyDKDoCx4eb64OGtF3h1MN7nCTTMglKtlSAkr3uM+9Sf
   2yRUNwIgiAGQYsaWMt1xfVxp34dXVapY1s9s27N1vUyCq7aRKEa4THS6t
   vPR/ipreUk0VxgsK2WfWaLljQgG4dWy29RgKSGHePWia9kgC/na0ddxm8
   g=;
Subject: RE: [PATCH] ath10k: add fw coredump for sdio when firmware assert
Thread-Topic: [PATCH] ath10k: add fw coredump for sdio when firmware assert
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 30 Aug 2019 10:54:26 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:54:25 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:54:23 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:54:23 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@qti.qualcomm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     Brian Norris <briannorris@chromium.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXNAbtURsVnEXnU268W2eITmuOKcP+xkwgAMHkbA=
Date:   Fri, 30 Aug 2019 02:54:23 +0000
Message-ID: <7c93ebf1372c48ee9b72ce10d0533846@aptaiexm02f.ap.qualcomm.com>
References: <1566371979-22730-1-git-send-email-wgong@codeaurora.org>
 <CANMq1KDGWh6Cc8akX_1g-n_fYe_2FHrpgnWf=sLxFnME7t5vBQ@mail.gmail.com>
 <8f0f2930e12a4dcabb69c13affe89a31@aptaiexm02f.ap.qualcomm.com>
In-Reply-To: <8f0f2930e12a4dcabb69c13affe89a31@aptaiexm02f.ap.qualcomm.com>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Wen Gong
> Sent: Wednesday, August 28, 2019 1:00 PM
> To: Nicolas Boichat <drinkcat@chromium.org>; Wen Gong
> <wgong@codeaurora.org>
> Cc: Brian Norris <briannorris@chromium.org>; open list:NETWORKING
> DRIVERS (WIRELESS) <linux-wireless@vger.kernel.org>;
> ath10k@lists.infradead.org
> Subject: [EXT] RE: [PATCH] ath10k: add fw coredump for sdio when firmware
> assert

Changed and v2 sent, https://patchwork.kernel.org/patch/11122827/
>=20
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
