Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B859F966
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 06:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfH1E2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 00:28:54 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:10708 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfH1E2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 00:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566966533; x=1598502533;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=31cRo7XeATcd5d/W5qUHoMufFBS/JEFIh50LAfWhg0c=;
  b=stS/vL4QGisn0ZuD5IWVctvWUr48Oue4hYrBkac4eprVnN9tXnvS3P5q
   nruji1+kL1Cekk3xnoRu9zuioWnYFRNvJBFelgsFVVNBlpVwlB1TfLW7w
   8JZ90lGeR/pH4PJ2WN2kE94ag93NCnwiIxw76Q/B4qeqVUebEFTMJlDMR
   U=;
Subject: RE: [PATCH v2 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH v2 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 28 Aug 2019 12:28:52 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Aug 2019 12:28:52 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 28 Aug 2019 12:28:50 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 28 Aug 2019 12:28:50 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVXMcAaQNCTGrwykaR5PufkoN8wKcP+IBw
Date:   Wed, 28 Aug 2019 04:28:50 +0000
Message-ID: <63ee1a9d35474ecea7b5490d4c534fe5@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-3-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566903707-27536-3-git-send-email-wgong@codeaurora.org>
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
> Sent: Tuesday, August 27, 2019 7:02 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH v2 2/7] ath10k: change max RX bundle size from 8 to
> 32 for sdio

v2: change macro HTC_GET_BUNDLE_COUNT

>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
