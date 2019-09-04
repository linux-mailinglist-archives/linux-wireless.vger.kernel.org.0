Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9767BA790B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfIDCzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:55:38 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:26138 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbfIDCzi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567565737; x=1599101737;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=xRmhuNm1Y90GG9dIUkgmXRB9g95cDPJ515pi0MDymsI=;
  b=pqLMLeAWQ84wNveE3XE5wCE25Do5EDtGl/l3K6eJrBpud9B084Ypc33Z
   q2ujcZfl5WXQqrqj/4nlwN5p6yWI7h413M3mcTkSI7kzPdYlNh7/Gusz5
   4GTmo1yQr9wWZS0Fdmt82csOkH2qA9F/cALPdWNLtwEiVdQypskFyeHBZ
   0=;
Subject: RE: [PATCH v3 4/8] ath10k: add workqueue for RX path of sdio
Thread-Topic: [PATCH v3 4/8] ath10k: add workqueue for RX path of sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 04 Sep 2019 10:55:36 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 10:55:32 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 10:53:57 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 10:53:57 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVXoibqDgIK544R0OGZW22VfB8RKca2s+w
Date:   Wed, 4 Sep 2019 02:53:56 +0000
Message-ID: <69b89708f046420793e4aa5ac4dd2562@aptaiexm02f.ap.qualcomm.com>
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org>
 <1566998177-2658-5-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566998177-2658-5-git-send-email-wgong@codeaurora.org>
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
> Sent: Wednesday, August 28, 2019 9:16 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH v3 4/8] ath10k: add workqueue for RX path of sdio
>=20
Patch v4 sent, https://patchwork.kernel.org/patch/11126229/
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
