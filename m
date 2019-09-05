Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B612CAA052
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfIEKrF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 06:47:05 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:57172 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbfIEKrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 06:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567680423; x=1599216423;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=B/BhA6lwvFBMbsj1YpKPU5Wb9BIP4rXnId6txWpG8Xk=;
  b=sgD2MCtlIAMzrusopM0Re893b11UT5oN9f65W+/jP3nVCXwnSSiOGBJV
   6mKaTspb5AqsfSkkcCSbNDRutZzjs1isY7OrSOB4WlVJXQtp44yRy/8sf
   CkxqU0q6SglsjgL26O9gjO/HE2GugqCAnYtqpnh74+NSOaRqURc1MSfJx
   E=;
Subject: RE: [PATCH v4 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
Thread-Topic: [PATCH v4 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 05 Sep 2019 18:47:01 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Sep 2019 18:46:58 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Thu, 5 Sep 2019 18:46:56 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Thu, 5 Sep 2019 18:46:56 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYXAKNV76CPzag0esUHWXrWjstacc62zg
Date:   Thu, 5 Sep 2019 10:46:56 +0000
Message-ID: <764f04c1ddc440ee824c2cf2668384dc@aptaiexm02f.ap.qualcomm.com>
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
 <1567416146-14403-2-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1567416146-14403-2-git-send-email-wgong@codeaurora.org>
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
> Subject: [EXT] [PATCH v4 1/8] ath10k: adjust skb length in
> ath10k_sdio_mbox_rx_packet
>=20
Patch v5 sent without change, https://patchwork.kernel.org/patch/11132657/=
=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
