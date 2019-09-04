Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D90A7916
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfIDC7W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:59:22 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:27322 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727930AbfIDC7W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567565961; x=1599101961;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=mQ48EkLJWXrvCTOwlvDWUMrzn+gYlesewO6sZQIn9es=;
  b=JobO8EkFDeUEFmr168JvT1T1FpZPjz1NSWLznqY6CTC9+7Gk7m/tBfaG
   8hpNnItBx7PjommLxAMniJS60m2en+BgBSdMK8GBslcM8htrYdWiURcdj
   Fe+Z3PpqDkn4fivi4kEI8ouROSd0kbQ8aTd0y5olRG+jRFiXVO4Y/RzZQ
   Y=;
Subject: RE: [PATCH v3 8/8] ath10k: enable napi on RX path for sdio
Thread-Topic: [PATCH v3 8/8] ath10k: enable napi on RX path for sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 04 Sep 2019 10:59:20 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 10:59:19 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 10:59:17 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 10:59:17 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXuHgGrf4JK3oFUeKyrj+pnzU16ca25bw
Date:   Wed, 4 Sep 2019 02:59:17 +0000
Message-ID: <151900cc2dca462788bf2ccd39d9e989@aptaiexm02f.ap.qualcomm.com>
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org>
 <1566998177-2658-9-git-send-email-wgong@codeaurora.org>
 <CANMq1KBXWydTR50fVqF7ks5gBTpUAS8Ga-8_MzeMGAknnyoVzg@mail.gmail.com>
In-Reply-To: <CANMq1KBXWydTR50fVqF7ks5gBTpUAS8Ga-8_MzeMGAknnyoVzg@mail.gmail.com>
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
> Sent: Friday, August 30, 2019 11:20 AM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v3 8/8] ath10k: enable napi on RX path for sdio
>=20
> On Fri, Aug 30, 2019 at 1:50 AM Wen Gong <wgong@codeaurora.org> wrote:
Patch v4 sent, https://patchwork.kernel.org/patch/11126239/
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
