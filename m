Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857A0A2CFD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfH3Cvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:51:40 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:23008 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbfH3Cvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133499; x=1598669499;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=mji4E8HLRAVVgay0BufnntHbSpXKpC2+0GLTt3ptbDw=;
  b=NofdxpdYbPJo9C4BDdEQZEgQM/xQo/iLQKiE5FURHNZlwBk/xE1WDFog
   2NtuFeXRICuvW7ZMlhUkcBoKygwXpU/a4dmSsraP+GkhkBDrMgOfsqXEF
   AoURt8jKgVvZG+BpICa2TOAIqzg37jCNDd1H8byNKUZxI+CncUaMBMvZL
   g=;
Subject: RE: [PATCH v2 5/7] ath10k: add htt TX bundle for sdio
Thread-Topic: [PATCH v2 5/7] ath10k: add htt TX bundle for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 30 Aug 2019 10:51:38 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:51:38 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:51:36 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:51:36 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@qti.qualcomm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXWKa4RLo4LlR4Eu0hbim+24wL6cQhk8AgAJ6ZQA=
Date:   Fri, 30 Aug 2019 02:51:36 +0000
Message-ID: <ad1a5a4649aa49a78021a9f9628b17f1@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-6-git-send-email-wgong@codeaurora.org>
 <CANMq1KAQncoZ3yX5Sfsc5tR8z9tJyA=jFF4_F1K=hLRe51OD4g@mail.gmail.com>
 <2ebd81574092476a952ddeb671d1bfcf@aptaiexm02f.ap.qualcomm.com>
In-Reply-To: <2ebd81574092476a952ddeb671d1bfcf@aptaiexm02f.ap.qualcomm.com>
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
> Sent: Wednesday, August 28, 2019 9:03 PM
> To: Nicolas Boichat <drinkcat@chromium.org>; Wen Gong
> <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] RE: [PATCH v2 5/7] ath10k: add htt TX bundle for sdio
>=20
Changed and V3 sent, https://patchwork.kernel.org/patch/11121539/=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
