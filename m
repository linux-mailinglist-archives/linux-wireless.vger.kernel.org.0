Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA8AA071
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfIEKud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 06:50:33 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:7002 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731476AbfIEKuc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567680632; x=1599216632;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=rVn3Xny9R8JPc+zFOJCISKNCSjmBTjjXhYya3D/aurc=;
  b=o3wAOwoDXJ+GMbSyiNjzE6d/Obz/Bet7Fj6drAPyaAZJ4Hj0ucA9VYKv
   oHcZfDmLMgHZdVcn/zRZcIxcEa/wmwMtQoQiq8KgqAjT6H06K0FuuQ53S
   bdKyKjxs0FUIQHBKRcE1tPJSU9Am3lxxCfjTyZrItwYzjQ6R9u3qhN25C
   Y=;
Subject: RE: [PATCH v4 8/8] ath10k: enable napi on RX path for sdio
Thread-Topic: [PATCH v4 8/8] ath10k: enable napi on RX path for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 05 Sep 2019 18:50:31 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Sep 2019 18:50:31 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Thu, 5 Sep 2019 18:50:29 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Thu, 5 Sep 2019 18:50:29 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYXAmp8mxVCKAGUqXejG7xPiQLacc7HIg
Date:   Thu, 5 Sep 2019 10:50:29 +0000
Message-ID: <c816734498c349119c12c23bc8a4827f@aptaiexm02f.ap.qualcomm.com>
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
 <1567416146-14403-9-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1567416146-14403-9-git-send-email-wgong@codeaurora.org>
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
> Sent: Monday, September 2, 2019 5:22 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH v4 8/8] ath10k: enable napi on RX path for sdio
>=20
Patch v5 sent with change, https://patchwork.kernel.org/patch/11132677/
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
