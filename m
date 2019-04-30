Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38510F3D9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfD3KMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 06:12:16 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:6750 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727147AbfD3KMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 06:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1556619134; x=1588155134;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=BZotg9k9E1CKXnw/zm8MhESu2Ja8QFGo/7IeWgypMlU=;
  b=CYx09mfc+yejpK194UV4jEyucrKBOd3u599RChRmejQW971ONvc24cv7
   EQEbTzE+gQnhlZzO1Yr8mncy7a4MqpvWC9pOwSzQi/O4Mdk1OKN178lUn
   tZeyyXjPUvTsqbAKYlmxbVy/R1SkyA/pzh3E/yxMpjkp12ABKTps09Qq4
   k=;
Subject: RE: [PATCH] ath10k: add peer id check in ath10k_peer_find_by_id
Thread-Topic: [PATCH] ath10k: add peer id check in ath10k_peer_find_by_id
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 30 Apr 2019 18:12:12 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9242"; a="28185922"
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Apr 2019 18:12:12 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Tue, 30 Apr 2019 18:12:10 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1395.000; Tue, 30 Apr 2019 18:12:10 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     Claire Chang <tientzu@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Thread-Index: AQHU/naVjdeK9KpvqkiaD4Ar16f1/qZUc6BggAAJjYA=
Date:   Tue, 30 Apr 2019 10:12:09 +0000
Message-ID: <7d528d143ae14de2a489c6986f71ac45@aptaiexm02f.ap.qualcomm.com>
References: <1554260478-4161-1-git-send-email-wgong@codeaurora.org>
 <CANMq1KAU1B4Bweq3O6O8HOMwT7fHjj9tDyxqMsn_vn4gwxXL=Q@mail.gmail.com>
 <87wojbrg0m.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87wojbrg0m.fsf@kamboji.qca.qualcomm.com>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Kalle Valo
> Sent: Tuesday, April 30, 2019 5:37 PM
> To: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Claire Chang <tientzu@chromium.org>; linux-wireless@vger.kernel.org;
> ath10k@lists.infradead.org; Wen Gong <wgong@codeaurora.org>
> Subject: [EXT] Re: [PATCH] ath10k: add peer id check in
> ath10k_peer_find_by_id
> >> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> >> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> >> @@ -157,6 +157,9 @@ struct ath10k_peer
> *ath10k_peer_find_by_id(struct ath10k *ar, int peer_id)
> >>  {
> >>         struct ath10k_peer *peer;
> >>
> >> +       if (peer_id >=3D sizeof(peer->peer_ids) * BITS_PER_BYTE)
> >
> > I'd use >=3D BITS_PER_TYPE(peer->peer_ids).
>=20
> Nice, I didn't know about that. Wen, please submit v2 using this.
>=20
> --
> Kalle Valo
Yes,=20
I have send v2 yesterday:
[PATCH v2] ath10k: add peer id check in ath10k_peer_find_by_id
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
