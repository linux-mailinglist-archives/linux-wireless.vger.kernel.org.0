Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58210E71C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 09:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLBIzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 03:55:25 -0500
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:5737 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbfLBIzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 03:55:25 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 03:55:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1575276924; x=1606812924;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=mY4Mfzi4wHFg9TJbIm3FYqENG4Ux0hXcgw/UJCa3ao4=;
  b=FUKYk137xnJT3fnn3McvBCr50gQYGCzlYzoRhvJt/ztPZLBeLi78JIVO
   jyDmH2Fm+bqJhtuW5P0pHYh2FbWPSs1k10QHdAJ4t7GjZGnbUZFJ/lgvs
   qaASd9ejzcnwj7goJxYAG9ObkICU6MK9Gcng67qhBXXZzEEAGdEDmze4i
   U=;
Subject: RE: [PATCH v7 0/3] ath10k: improve throughout of TX of sdio
Thread-Topic: [PATCH v7 0/3] ath10k: improve throughout of TX of sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 02 Dec 2019 16:49:10 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Dec 2019 16:49:06 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Mon, 2 Dec 2019 16:49:04 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Mon, 2 Dec 2019 16:49:04 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVhYWo2dAcydoA60KRzRcGJ7x5SKemz1QA
Date:   Mon, 2 Dec 2019 08:49:04 +0000
Message-ID: <5a0a6348feea46ae93c055189168d41f@aptaiexm02f.ap.qualcomm.com>
References: <20191018072750.10372-1-wgong@codeaurora.org>
In-Reply-To: <20191018072750.10372-1-wgong@codeaurora.org>
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
> Sent: Friday, October 18, 2019 3:28 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH v7 0/3] ath10k: improve throughout of TX of sdio
>=20
V8 sent:
https://patchwork.kernel.org/cover/11265701/
[v8,0/4] ath10k: improve throughout of TX of sdio=20
[v8,1/4] ath10k: disable TX complete indication of htt for sdio =20
[v8,2/4] ath10k: change ATH10K_SDIO_BUS_REQUEST_MAX_NUM from 64 to 1024 =20
[v8,3/4] ath10k: add htt TX bundle for sdio =20
[v8,4/4] ath10k: enable alt data of TX path for sdio
