Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB222BD31
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 04:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfE1CZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 22:25:18 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:33802 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727342AbfE1CZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 22:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1559010316; x=1590546316;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=WLnDk5Mnjr31/8vRYU/58Mtb42f28Ex/mJLgUCh5Rqg=;
  b=CpiOBxMmBnPY6WooEurFQPwF6mgpm44Dq5ojTWJrrXm0MaLDtFwzFFw6
   0weKblFiPCuLWTFcsd3lWcCmohc83iP68SBsyuoaAxYKRydgXqhbf0PDH
   Pr3bQYKEZ4vzA7weFrNhYqw3Z6YuTMJUN3ZxXv2XR58Mz48NgMTw/5Hre
   8=;
Subject: RE: [PATCH] ath10k: add support for simulate crash on SDIO chip
Thread-Topic: [PATCH] ath10k: add support for simulate crash on SDIO chip
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 28 May 2019 10:25:14 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9270"; a="30538387"
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 May 2019 10:25:09 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Tue, 28 May 2019 10:25:07 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1395.000; Tue, 28 May 2019 10:25:07 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     Claire Chang <tientzu@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHU/ktg0k6a4wyR5kyzZvSP6GJAC6Z/+7UQ
Date:   Tue, 28 May 2019 02:25:07 +0000
Message-ID: <9d7964c815c54582a304e49e4667c0f5@aptaiexm02f.ap.qualcomm.com>
References: <1555406865-21514-1-git-send-email-wgong@codeaurora.org>
 <CANMq1KBjupZeuw3hmQHbYui4G9+Ni7SPPE1SNqG9=89iVhFjgg@mail.gmail.com>
In-Reply-To: <CANMq1KBjupZeuw3hmQHbYui4G9+Ni7SPPE1SNqG9=89iVhFjgg@mail.gmail.com>
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
> Sent: Monday, April 29, 2019 1:21 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: Claire Chang <tientzu@chromium.org>; linux-wireless@vger.kernel.org;
> ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH] ath10k: add support for simulate crash on SDIO
> chip
>=20
> Err, so you consider _any_ CPU interrupt to be caused by the FW
> crashing? Is that correct? If so, please at least add a comment.
>=20
> Otherwise, maybe you should run this only if
> MBOX_CPU_STATUS_ENABLE_ASSERT_MASK is set in cpu_int_status?
>=20
> >         return ret;
> >  }
> >

Hi Nicolas,
New patch has uploaded for the change
https://patchwork.kernel.org/patch/10921341/
[v2] ath10k: add support for simulate crash on SDIO chip

https://patchwork.kernel.org/patch/10955189/
[v3] ath10k: add support for firmware crash recovery on SDIO chip
