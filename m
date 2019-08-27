Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFA9E125
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfH0IKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 04:10:05 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:23038 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731391AbfH0IDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 04:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566892980; x=1598428980;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=4ojrGrL0wESrTRr+PXXy9IAigPfb8/ZmH00rWyuv4dg=;
  b=aJ0Q+q6AUF4NP+2HQAjCqvvIQu2Q1No2SGOwYGzl1iA7U+BPAkure1zc
   oEIRiiRcqO5vXnIsWwNvQAfF0uzcTlaVE7P4Kb6Sc0pn5c0t//mRtx4cx
   dOmUp2kfAN/Q6RKjYlJ/dPnWqCU+z7I7vk1ul5MvdN/ZyAQgwAKAewdRQ
   c=;
Subject: RE: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
Thread-Topic: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 27 Aug 2019 16:02:58 +0800
Received: from aptaiexm02e.ap.qualcomm.com ([10.249.150.15])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Aug 2019 16:02:54 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02e.ap.qualcomm.com (10.249.150.15) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Tue, 27 Aug 2019 16:02:52 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Tue, 27 Aug 2019 16:02:52 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXKrOUvYo32uqIkuIjmEPEapo6qcOngKQ
Date:   Tue, 27 Aug 2019 08:02:52 +0000
Message-ID: <2ec213d88ebb4b89812826866b39886d@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-2-git-send-email-wgong@codeaurora.org>
 <CANMq1KBR0nd+XOJWpgWyoJdsFgZByQyjD-0dpttygiN0OfiD5Q@mail.gmail.com>
In-Reply-To: <CANMq1KBR0nd+XOJWpgWyoJdsFgZByQyjD-0dpttygiN0OfiD5Q@mail.gmail.com>
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
> Sent: Tuesday, August 27, 2019 3:41 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> wireless@vger.kernel.org>; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
>=20
> > -static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
> > +static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
> >  {
> >         struct ath10k_sdio *ar_sdio =3D ath10k_sdio_priv(ar);
> > +       struct ath10k_sdio_rx_data *pkt;
> >         int ret, i;
> > +       u32 pkt_offset, virt_pkt_len;
> >
> > +       virt_pkt_len =3D 0;
> >         for (i =3D 0; i < ar_sdio->n_rx_pkts; i++) {
> > -               ret =3D ath10k_sdio_mbox_rx_packet(ar,
> > -                                                &ar_sdio->rx_pkts[i]);
> > -               if (ret)
> > +               virt_pkt_len +=3D ar_sdio->rx_pkts[i].alloc_len;
> > +       }
> > +
> > +       if (virt_pkt_len < ATH10K_SDIO_DMA_BUF_SIZE) {
> > +               ret =3D ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_a=
ddr,
> > +                                        ar_sdio->vsg_buffer, virt_pkt_=
len);
> > +               if (ret) {
> > +                       i =3D 0;
> >                         goto err;
> > +               }
> > +       } else {
> > +               ath10k_err(ar, "size exceeding limit %d\n", virt_pkt_le=
n);
> > +       }
> > +
> > +       pkt_offset =3D 0;
> > +       for (i =3D 0; i < ar_sdio->n_rx_pkts; i++) {
> > +               struct sk_buff *skb =3D ar_sdio->rx_pkts[i].skb;
> > +
> > +               pkt =3D &ar_sdio->rx_pkts[i];
> > +               memcpy(skb->data, ar_sdio->vsg_buffer + pkt_offset,
> > +                      pkt->alloc_len);
>=20
> Why do you copy alloc_len if you only plan to use act_len?
alloc_len is aligned to block size(256),  and act_len maybe not same for ea=
ch packet in the bundle.
Eg a bundle:
Packet 1 len 240,   alloc_len: 256, 1st time: act_len 240, left padding siz=
e is 16,
Packet 1 len 250, alloc_len: 256, 1st time: act_len 240, left padding size =
is 6,
Packet 1 len 230,   alloc_len: 256, 1st time: act_len 240, left padding siz=
e is 26,

The bundled buffer len is 256 * 3 =3D 768, it has 256 bytes for each packet=
, the left size is padding which=20
Is not needed, but the left padding is not same for each packet, before rea=
d all the buffer from sdio bus,
It does not know each packet's act len, it only know the 1st packet's act l=
en.
So it need to copy all the alloc_len's buffer to ensure it will not lose da=
ta.

> Actually, just use skb_put_data.
>=20
> Also, do you have the same issue as
> https://patchwork.kernel.org/patch/11116215/ w.r.t. act_len being
> incorrect?
>=20
> > +               pkt->status =3D 0;
> > +               skb_put(skb, pkt->act_len);
> > +               pkt_offset +=3D pkt->alloc_len;
> >         }
> >
> >         return 0;
> >
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
