Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A129312AA8A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2019 07:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLZGiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Dec 2019 01:38:06 -0500
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:59778 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfLZGiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Dec 2019 01:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1577342285; x=1608878285;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=J8+wed+SF9vVAtfwPyOzfe2DRaPD/2Xi/xGBms0Y2uA=;
  b=XVOCw9Ek6uegdZv76Fe8NMZNqecUmERZJA9Li+xpmspxGVvZ7x3VyaIp
   y8AWJtF7CFBOrJpwFy3RC0FjmERMy73vyPE7digMZSfSmQkAeuQ+zVHlR
   skMAExYlVpkcmYnDYUK5TSt1cwm74aZXfs25XTX2AZw/4k7GlwsOHd2eS
   I=;
Subject: RE: [PATCH] ath10k: start recovery process when payload length exceeds max
 htc length for sdio
Thread-Topic: [PATCH] ath10k: start recovery process when payload length exceeds max htc
 length for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 26 Dec 2019 14:38:01 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Dec 2019 14:37:58 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Thu, 26 Dec 2019 14:37:56 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Thu, 26 Dec 2019 14:37:56 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVtwM5cmoEosErVUSoACeK8vh5vafL/9aQ
Date:   Thu, 26 Dec 2019 06:37:56 +0000
Message-ID: <02596d5969ab4edabe0b725379bc26a2@aptaiexm02f.ap.qualcomm.com>
References: <20191220070021.12103-1-wgong@codeaurora.org>
In-Reply-To: <20191220070021.12103-1-wgong@codeaurora.org>
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
> Sent: Friday, December 20, 2019 3:00 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH] ath10k: start recovery process when payload length
> exceeds max htc length for sdio
V2 sent: https://patchwork.kernel.org/patch/11310185/
