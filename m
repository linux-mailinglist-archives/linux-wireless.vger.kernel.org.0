Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695F5A78E8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfIDChU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:37:20 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:35670 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbfIDChU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567564639; x=1599100639;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=g9u/yU9+0rtxWO/CVuWR2Mu+vWnGorb9YD6CCHbIVs4=;
  b=cvJamroVp48lUPo2URku6EBfladuZicSzNCbIEq4kKpYMPbILICWx1Zy
   wuI2ELrwWIDMNHjzqDtZ7jeNnMccxHnxgMNStqWm0uOrt0iTyjvA6ECVj
   dMWgkqvYXf8uNyPlad6up7nx2qUpqZ1sbIw1aJ6KLjyPRjr6/1wPimWjb
   U=;
Subject: RE: [PATCH 7/7] ath10k: enable napi on RX path for sdio
Thread-Topic: [PATCH 7/7] ath10k: enable napi on RX path for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 04 Sep 2019 10:37:18 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 10:37:18 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 10:37:16 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 10:37:16 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVV05o/A96nV2nAk2Zzc4nCVwcnaca5I9w
Date:   Wed, 4 Sep 2019 02:37:16 +0000
Message-ID: <2f1d0d1cdd6d4f9097304d52ff3d3c98@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-8-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566302108-18219-8-git-send-email-wgong@codeaurora.org>
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
> Sent: Tuesday, August 20, 2019 7:55 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH 7/7] ath10k: enable napi on RX path for sdio
>=20
Patch v2 sent, https://patchwork.kernel.org/patch/11116669/

>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
