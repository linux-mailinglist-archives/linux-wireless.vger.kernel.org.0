Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE52A2CF3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfH3CtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:49:03 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:13450 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfH3CtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133342; x=1598669342;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=CbLmm34SBCymc715VwUv5ZIAyyI8bEd+tg2+bH4IjVo=;
  b=CY4mr4Z5hTG8WHL4dIcZ1TtFxGieHaMM4PXwRT3eI2fxw5COpoDAO6lh
   +x1/vwP/ALQdMjJIhW0/wOg9p2+7dV4FkjDTcY3JhrqEYY0vR3VOWRSLF
   UXUzG0edgA+bHCe5+LCAyaCsIac2oXuteXcYu6VDXsa7gbTAuc1vIbAzN
   Y=;
Subject: RE: [PATCH v2 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH v2 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 30 Aug 2019 10:49:01 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:48:56 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:48:54 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:48:55 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXV9n1yvXyZUqCkmQKmsYyyv+JacS/7Ag
Date:   Fri, 30 Aug 2019 02:48:54 +0000
Message-ID: <9821fb44c1b34b2890e0aa8b422d4c67@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-3-git-send-email-wgong@codeaurora.org>
 <CANMq1KAntBMo40jdv3T5k00EfjPzO1XvVdjL3oo2V9Eot1H4jg@mail.gmail.com>
In-Reply-To: <CANMq1KAntBMo40jdv3T5k00EfjPzO1XvVdjL3oo2V9Eot1H4jg@mail.gmail.com>
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
Sent: Wednesday, August 28, 2019 1:14 PM
To: Wen Gong <wgong@codeaurora.org>
Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-wireless@vger.kernel.org=
>; ath10k@lists.infradead.org
Subject: [EXT] Re: [PATCH v2 2/7] ath10k: change max RX bundle size from 8 =
to 32 for sdio

Changed and V3 sent, https://patchwork.kernel.org/patch/11122175/

_______________________________________________
ath10k mailing list
ath10k@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/ath10k
