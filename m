Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7385BA2CF1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfH3Csv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:48:51 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:13444 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfH3Csv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133329; x=1598669329;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=H1+UOtbGh2bVIFzS+y3QK+W5ZfrUQI2sVwm8V4/sNW4=;
  b=ZNFwwvApgSDcvSu3A8RDdCCH1dhzC4RaS29fMgJQVnnJbwSNatzw/z3h
   PZk4ULkzt5Pm+yW+BGEv18y3SiMRy6jXBibR4Vd6uuSZXHpGi5ZRnlolW
   J+cPMO94E0srfx2FNG3OdKtf1VWRDd+HsbXGR4R5Y6i8hf5lteYf4PNCc
   Y=;
Subject: RE: [PATCH v2 1/7] ath10k: enable RX bundle receive for sdio
Thread-Topic: [PATCH v2 1/7] ath10k: enable RX bundle receive for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 30 Aug 2019 10:48:48 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:48:43 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:48:41 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:48:41 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXV7JIoVzfwp/nke0rpJol9BC7acS/8Tg
Date:   Fri, 30 Aug 2019 02:48:41 +0000
Message-ID: <fce5391f6279436fb3a2a1d9b408c70b@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-2-git-send-email-wgong@codeaurora.org>
 <CANMq1KBLX3rKs6q2SmKhMctRAKF71y0K3it5kTfR0xG5Qk8MLg@mail.gmail.com>
In-Reply-To: <CANMq1KBLX3rKs6q2SmKhMctRAKF71y0K3it5kTfR0xG5Qk8MLg@mail.gmail.com>
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
Sent: Wednesday, August 28, 2019 1:09 PM
To: Wen Gong <wgong@codeaurora.org>
Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-wireless@vger.kernel.org=
>; ath10k@lists.infradead.org
Subject: [EXT] Re: [PATCH v2 1/7] ath10k: enable RX bundle receive for sdio

Changed and V3 sent, split to 2 patches
https://patchwork.kernel.org/patch/11121751/
https://patchwork.kernel.org/patch/11119355/
_______________________________________________
ath10k mailing list
ath10k@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/ath10k
