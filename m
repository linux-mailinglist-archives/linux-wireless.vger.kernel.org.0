Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0563CA78C3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfIDCdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:33:32 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:5780 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfIDCdc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567564410; x=1599100410;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=1jV4FCpqNNc2FKSQvjt737YtE0bfFSptZVZVApDLF/8=;
  b=Fw9Or7d/OnTzqpHOkBLZuAjlTs4q9ob/RcuRqig28PAcxmocWu/qu6I9
   nMnjp1Gj2tbC83IwpBlvaVg3/uSfNgXUjdh1qRvdQYvurbmVQ9NTgxHOx
   NhRE+JaAnXwZJ0WPK9VWLDmAdWl0mAeCqFmSs5PAGfY1c2RF6v4xaqu9O
   M=;
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 04 Sep 2019 10:33:29 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 10:33:26 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 10:33:24 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 10:33:24 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVV05YxAe/tDTcpEq1n2AngIHyU6ca42qw
Date:   Wed, 4 Sep 2019 02:33:24 +0000
Message-ID: <6f9112febc5c4afb8cb6548db0089987@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
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
> Subject: [EXT] [PATCH 4/7] ath10k: disable TX complete indication of htt =
for
> sdio
>=20
Patch v2 sent, https://patchwork.kernel.org/patch/11116685/=20
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
