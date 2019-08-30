Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05EE6A2CFB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH3Cun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:50:43 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:61063 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfH3Cun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567133442; x=1598669442;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=qLwbLD0yKNm5gv0eYaOoOJ/mznBqupHwJ604VanYmw0=;
  b=PCj9XlspGQLXXhak6OUnE6fB68i4DSFeSRqEoZ/adty4IaBQnRkEPT+b
   hqiZ64DzTKb0LfkfZCiBdkeqG3gcZoCvwyMe/P/QfMf7ubCXgE44UYIS0
   npHK7gM1PtaHsQnLpQpAvw2dpQAIwjb3z/MqTiCYo+VqesFeWL4MO4heu
   U=;
Subject: RE: [PATCH v2 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH v2 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 30 Aug 2019 10:50:41 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Aug 2019 10:50:41 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 30 Aug 2019 10:50:39 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 30 Aug 2019 10:50:39 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@qti.qualcomm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXWFSQ/SJykVh+UihzVRM6dfs6acQhZzQgAJ664A=
Date:   Fri, 30 Aug 2019 02:50:39 +0000
Message-ID: <9d1b5a99e4bf403090e0f7d2533a6cc8@aptaiexm02f.ap.qualcomm.com>
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
 <1566903707-27536-5-git-send-email-wgong@codeaurora.org>
 <CANMq1KDeQaJWYiAz=P9pKm0_seNmtnEHVgt9T0-=40Ew=zLs0A@mail.gmail.com>
 <d97ba89eaee24e07ac14c34fca2ad46d@aptaiexm02f.ap.qualcomm.com>
In-Reply-To: <d97ba89eaee24e07ac14c34fca2ad46d@aptaiexm02f.ap.qualcomm.com>
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
> Sent: Wednesday, August 28, 2019 9:00 PM
> To: Nicolas Boichat <drinkcat@chromium.org>; Wen Gong
> <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] RE: [PATCH v2 4/7] ath10k: disable TX complete indication =
of
> htt for sdio

Changed and V3 sent, https://patchwork.kernel.org/patch/11122177/

>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
