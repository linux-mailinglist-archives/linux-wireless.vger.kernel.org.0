Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740F9A2CF5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfH3CtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:49:23 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:63367 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfH3CtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133361; x=1598669361;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=xDN3uxVZeMK6gWpUSic1oggZq05pqOuN6kR2YpYeUK4=;
  b=wHdBtG6bwWS5OiArBhhXCiINobeRq+3aIQW1rfqExW65pMTd2DHeGsLG
   lNrIyYlPD7ZMM88rm5n5PlLkNlqXhfacHyaPdZY02ZlJ4Jgktt7aR5u6r
   ZaX+Dkz8BgBBrbnqXFv+UfOHeOyNOAlxwoQSFkKTB9jCJYsjEGAgNyoie
   U=;
Subject: RE: [PATCH v2 3/7] ath10k: add workqueue for RX path of sdio
Thread-Topic: [PATCH v2 3/7] ath10k: add workqueue for RX path of sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 30 Aug 2019 10:49:21 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:49:15 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:49:14 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:49:14 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXV/ZaRnarIYRO0GjQRH9RKI5pqcS/5gA
Date:   Fri, 30 Aug 2019 02:49:14 +0000
Message-ID: <fe3102a7c5324f31afc8151e2a01f7e9@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-4-git-send-email-wgong@codeaurora.org>
 <CANMq1KDSi_6g2pthZfLqnBrwzAhTcXQtUpmZsR4+EqZgFONnZw@mail.gmail.com>
In-Reply-To: <CANMq1KDSi_6g2pthZfLqnBrwzAhTcXQtUpmZsR4+EqZgFONnZw@mail.gmail.com>
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

-----Original Message-----
From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Nicolas Boic=
hat
Sent: Wednesday, August 28, 2019 1:17 PM
To: Wen Gong <wgong@codeaurora.org>
Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-wireless@vger.kernel.org=
>; ath10k@lists.infradead.org
Subject: [EXT] Re: [PATCH v2 3/7] ath10k: add workqueue for RX path of sdio

Changed and V3 sent, https://patchwork.kernel.org/patch/11122163/
_______________________________________________
ath10k mailing list
ath10k@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/ath10k
