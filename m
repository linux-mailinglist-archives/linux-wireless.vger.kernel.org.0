Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592289F95D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 06:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfH1EZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 00:25:50 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:31646 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfH1EZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 00:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566966348; x=1598502348;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=1w7wzvKuS9YEZhjT4ceycD2S/64vc4595oy7ZgVgPbk=;
  b=FuhxNRCZoI+gUk+9DAnKZaTes1u+vW1Zfc1TKwgOkup4Cd3mYJsAfkeN
   9I4ovKbx/u7LB5pfRQ1AGARkeQAk5RMXuQkvCA0IFWV30cP+ymPIOUC7u
   3bnTKVicMXaMjmAIXnPjtm7fTwSqpcmKcZhmXCEVZ8NglGl6bdfoAsiL7
   c=;
Subject: RE: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
Thread-Topic: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 28 Aug 2019 12:25:47 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Aug 2019 12:25:43 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 28 Aug 2019 12:25:40 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 28 Aug 2019 12:25:40 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Thread-Index: AQHVXKrOUvYo32uqIkuIjmEPEapo6qcOngKQ//9/pgCAAdoPoA==
Date:   Wed, 28 Aug 2019 04:25:40 +0000
Message-ID: <032d964e076f4d34ac516863b031bf17@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-2-git-send-email-wgong@codeaurora.org>
 <CANMq1KBR0nd+XOJWpgWyoJdsFgZByQyjD-0dpttygiN0OfiD5Q@mail.gmail.com>
 <2ec213d88ebb4b89812826866b39886d@aptaiexm02f.ap.qualcomm.com>
 <CANMq1KCiH8-16esCfwi+60=ArZKC0G83Qs-W2Hq5GARar=6D9g@mail.gmail.com>
In-Reply-To: <CANMq1KCiH8-16esCfwi+60=ArZKC0G83Qs-W2Hq5GARar=6D9g@mail.gmail.com>
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
> Sent: Tuesday, August 27, 2019 4:08 PM
> To: Wen Gong <wgong@qti.qualcomm.com>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org; Wen Gong
> <wgong@codeaurora.org>
> Subject: [EXT] Re: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
>=20
> On Tue, Aug 27, 2019 at 4:03 PM Wen Gong <wgong@qti.qualcomm.com>
> wrote:
> >
> > > -----Original Message-----
> > > From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Nicola=
s
> > > Boichat
> > > Sent: Tuesday, August 27, 2019 3:41 PM
> > > To: Wen Gong <wgong@codeaurora.org>
> > > Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> > > wireless@vger.kernel.org>; ath10k@lists.infradead.org
> > > Subject: [EXT] Re: [PATCH 1/7] ath10k: enable RX bundle receive for s=
dio
> > The bundled buffer len is 256 * 3 =3D 768, it has 256 bytes for each pa=
cket,
> the left size is padding which
> > Is not needed, but the left padding is not same for each packet, before=
 read
> all the buffer from sdio bus,
> > It does not know each packet's act len, it only know the 1st packet's a=
ct len.
> > So it need to copy all the alloc_len's buffer to ensure it will not los=
e data.
>=20
> Gotcha, thanks.
Patch v2 sent with the changes, https://patchwork.kernel.org/patch/11116681=
/
>=20
> > > Actually, just use skb_put_data.
> > >
> > > Also, do you have the same issue as
> > > https://patchwork.kernel.org/patch/11116215/ w.r.t. act_len being
> > > incorrect?
> > >
> > > > +               pkt->status =3D 0;
> > > > +               skb_put(skb, pkt->act_len);
>=20
> So I guess this is incorrect, see patchwork linked above.
>=20
> > > > +               pkt_offset +=3D pkt->alloc_len;
> > > >         }
> > > >
> > > >         return 0;
> > > >
> > >
> > > _______________________________________________
> > > ath10k mailing list
> > > ath10k@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/ath10k
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
