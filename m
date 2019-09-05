Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8007AA069
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfIEKtf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 06:49:35 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:5113 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730839AbfIEKtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567680574; x=1599216574;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=u5M4gOaZN9e0mRZpf/tcATYZCItElZgVaELSHqN64Ms=;
  b=d5vgfNdsT+W5tRv5SEtaVVMX6mYRfTM2X23OSuqFTnN22eqqGXfGYqtI
   q2vnvNDR+WtJFPB8krtIpr6RfoTA1fhLIGXSObpq0k+uo+GPbtE+fLObG
   WHgINMkBBAHCCpiBr+rm91Fe7QxLe9LahUyFVa5e3KvbNPYSjgBC4gap3
   c=;
Subject: RE: [PATCH v4 6/8] ath10k: add htt TX bundle for sdio
Thread-Topic: [PATCH v4 6/8] ath10k: add htt TX bundle for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 05 Sep 2019 18:49:33 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Sep 2019 18:49:33 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Thu, 5 Sep 2019 18:49:31 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Thu, 5 Sep 2019 18:49:31 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYXAfNPKOLvT+cke9UTEFwblqLacc7ClA
Date:   Thu, 5 Sep 2019 10:49:31 +0000
Message-ID: <ef2e679f9dc940528218870edac43b05@aptaiexm02f.ap.qualcomm.com>
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
 <1567416146-14403-7-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1567416146-14403-7-git-send-email-wgong@codeaurora.org>
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
> Subject: [EXT] [PATCH v4 6/8] ath10k: add htt TX bundle for sdio
>=20
Patch v5 sent with change, https://patchwork.kernel.org/patch/11132675/
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
