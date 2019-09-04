Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA32A7902
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfIDCuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:50:15 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:24375 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727867AbfIDCuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567565413; x=1599101413;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=44eugvvOxE68WWjKvO79s/b4AgVnqfdN+gD7csPzzg8=;
  b=rtK7qCXMZewcgPQsdVlZ30LReg/j8wwWRu0z//C4LryUGHYIWiitX0th
   UoACHx6cXOPBWK5FhaPKxrjr4eOQ8u3Vs2Fx93vCF2Ne+df/HLZEMsxQ9
   1uYtPga3d5aauvx2JNKXgrEiIIn/5oU+y+J/2XBdTD0OVmTzjthGhRTbG
   Y=;
Subject: RE: [PATCH v4 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
Thread-Topic: [PATCH v4 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 04 Sep 2019 10:50:12 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 10:50:12 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 10:50:10 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 10:50:10 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYXAVa1OUNWMQOEGN3QFbDA2u66ca0++A
Date:   Wed, 4 Sep 2019 02:50:10 +0000
Message-ID: <f70df46709bc4badb36c94e2dd8a49a9@aptaiexm02f.ap.qualcomm.com>
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
 <1567416146-14403-4-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1567416146-14403-4-git-send-email-wgong@codeaurora.org>
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
> Subject: [EXT] [PATCH v4 3/8] ath10k: change max RX bundle size from 8 to
> 32 for sdio
>=20
Patch v4 sent, https://patchwork.kernel.org/patch/11126225/
>=20
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
