Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F80A2D01
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfH3Cwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:52:55 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:16697 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727216AbfH3Cwz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133574; x=1598669574;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=+ZyU7CTvWQEs+oV1t+MWTWx424qD+3s986DErneCy5c=;
  b=SkDEzFQFHnrRzHVfeZa/EbV47unypy4VSc43OQYMlIKM32bevjwmk2Il
   9Pj5RXZL97kD0i+CyRGnol3OkRedsvWH+fafVN1RPK6IHlT9TtaGaWM7P
   iPE49XJVn6Qr0Mm2ULrM/KWcJK+drUXJexx09NXHMKviFyh/tQQR9Jfeb
   c=;
Subject: RE: [PATCH v2 7/7] ath10k: enable napi on RX path for sdio
Thread-Topic: [PATCH v2 7/7] ath10k: enable napi on RX path for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 30 Aug 2019 10:52:53 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:52:53 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:52:51 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:52:51 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXWMTQUSOA0hE8EaEPXwyNjcZkqcTASRw
Date:   Fri, 30 Aug 2019 02:52:51 +0000
Message-ID: <dd7f7cd664e64ee59965117ffd7c2c7e@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-8-git-send-email-wgong@codeaurora.org>
 <CANMq1KCQZCOw8kHn2MJfAT9fWoLCmz2jFWqHzd=9QOgZ7MeaXQ@mail.gmail.com>
In-Reply-To: <CANMq1KCQZCOw8kHn2MJfAT9fWoLCmz2jFWqHzd=9QOgZ7MeaXQ@mail.gmail.com>
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
> Sent: Wednesday, August 28, 2019 1:40 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 7/7] ath10k: enable napi on RX path for sdio
>=20
Changed and v3 sent, https://patchwork.kernel.org/patch/11122183/

> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
