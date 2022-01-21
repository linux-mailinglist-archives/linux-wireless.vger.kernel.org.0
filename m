Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0924959F6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378706AbiAUGdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 01:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiAUGds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 01:33:48 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EDC061574
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jan 2022 22:33:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o12so30357112lfu.12
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jan 2022 22:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apj9lP22BdJ0IafZPIW8s3bphYXxSWO2EHd6e7o/yYI=;
        b=J6tuOHbG/RN36yY4xKdUtS3BLVRUAIJgdQK4cSbiLW+i+Mbx9YOoop2jn0Zp0bPJmM
         hxRTXVC+TXpv3TH7NRnj4Vx6vPnzoXdQxXcK68XYXSWDF94YefcFwof0V3UxVaUJ/D61
         w/Ae+VjM/awV2o8ZX2n1OhPidFfIyRUevL8pVqSLhni81X9k9tPhSfPgbS4vJ+qnogyF
         TOOCVSFA8q1r+QUOEjyPgzfDvqw2rtp6fsoBtLKRhqNaQphHYAb+yZU4A31idM52e/Vj
         LyYQlZUENdNeSPi9Opjszs5qDZDu/LkUaOBKoPOmV0svM8UqQONNaj1UyNFWsqtCtclH
         SlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apj9lP22BdJ0IafZPIW8s3bphYXxSWO2EHd6e7o/yYI=;
        b=mEtk76f3of+pLpoQtceRTrGRo7KNRJqDsnZLI3mnmjZ7in12BLjFuHMi1WVNFS4iGq
         8CvZp0tZZo7+EgqwHV9be8RIhVtuwEU2lfQiVI7eNBwqksQfn7XXOlYK70/sCDRaWRuV
         J6h3fiszTU2wYuK0NTpbsrNAYvu+108EokcbTg7T4ATw8T0fx1A4Bs2yCxUv3/oiGBo4
         ZlJ8+6bmbA3QXxYWoHoSz6NL1k7S/scRjv/Kn/vLcy/BcO0AlPumAjUCXRqiDlNenhC3
         3/vTb8694adMw9Q1bPooHcq9nid1g2lB+BWux16CZSykSi4ZEvd1PMNkL5TKNTgRz5eo
         2VMg==
X-Gm-Message-State: AOAM532c8X35iZVlKmTMwssjDIx99aujQ75t3Yq55/gURoZfju3iNU+N
        1p/TdG7Wc1WVkFlJg6zhS77GIcQ1cnvif4uWqb4=
X-Google-Smtp-Source: ABdhPJy+eYFJorJdVe7F5r8XVydlkBP3x/fj0S2H85mfoNTMC6EheHYNkvi1v5f3ir9Z4DuEVP7XkxGygATo36Bb5dU=
X-Received: by 2002:ac2:5581:: with SMTP id v1mr2730396lfg.514.1642746825756;
 Thu, 20 Jan 2022 22:33:45 -0800 (PST)
MIME-Version: 1.0
References: <70e27cbc652cbdb78277b9c691a3a5ba02653afb.1641540175.git.objelf@gmail.com>
 <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
In-Reply-To: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Fri, 21 Jan 2022 07:33:34 +0100
Message-ID: <CAFED-jke=w2RpZCq5y=9apg3sW9r_MmYxsKQyaDwtjPQY6=pDQ@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921e: fix possible probe failure after reboot
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     sean.wang@mediatek.com, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

pt., 21 sty 2022 o 00:23 Khalid Aziz <khalid@gonehiking.org> napisa=C5=82(a=
):
>
> On 1/7/22 12:30 AM, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > It doesn't guarantee the mt7921e gets started with ASPM L0 after each
> > machine reboot on every platform.
> >
> > If mt7921e gets started with not ASPM L0, it would be possible that the
> > driver encounters time to time failure in mt7921_pci_probe, like a
> > weird chip identifier is read
> >
> > [  215.514503] mt7921e 0000:05:00.0: ASIC revision: feed0000
> > [  216.604741] mt7921e: probe of 0000:05:00.0 failed with error -110
> >
> > or failing to init hardware because the driver is not allowed to access=
 the
> > register until the device is in ASPM L0 state. So, we call
> > __mt7921e_mcu_drv_pmctrl in early mt7921_pci_probe to force the device
> > to bring back to the L0 state for we can safely access registers in any
> > case.
> >

BTW, probably I see something similar with mt7915e (inside ramips):

Have mt7915e in my mt7621 (mt7621-pci) router (pandora box/ramips).
After fresh start (disconnect/connect power supply/cold reset) works correc=
tly.
After reboot seems to always fail with:
Sat Dec 18 08:43:58 2021 kern.info kernel: [   14.552269] mt7621-pci
1e140000.pcie: bus=3D3 slot=3D2 irq=3D25
Sat Dec 18 08:43:58 2021 kern.info kernel: [   14.557823] pci
0000:00:02.0: enabling device (0000 -> 0003)
Sat Dec 18 08:43:58 2021 kern.info kernel: [   14.563499] mt7915e
0000:03:00.0: enabling device (0000 -> 0002)
Sat Dec 18 08:43:58 2021 kern.err kernel: [   35.094270] mt7915e
0000:03:00.0: Message 00000010 (seq 1) timeout
Sat Dec 18 08:43:58 2021 kern.err kernel: [   35.100457] mt7915e
0000:03:00.0: Failed to get patch semaphore
Sat Dec 18 08:43:58 2021 kern.err kernel: [   55.574220] mt7915e
0000:03:00.0: Message 00000010 (seq 2) timeout
Sat Dec 18 08:43:58 2021 kern.err kernel: [   55.580380] mt7915e
0000:03:00.0: Failed to get patch semaphore
Sat Dec 18 08:43:58 2021 kern.warn kernel: [   55.586529] mt7915e:
probe of 0000:03:00.0 failed with error -11


This is lspci output:
02:00.0 Network controller: MEDIATEK Corp. MT7612E 802.11acbgn PCI
Express Wireless Network Adapter
03:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax
PCI Express Wireless Network Adapter

Detection works correctly after disconnect/connect power supply (cold reboo=
t).

I don't see this issue (same HW/card) with.
 - my laptop x86_64
 - banana_pi aarch64

Any idea this could be same/similar issue and there is possible fix for tha=
t?

BR
Janusz



> > In the patch, we move all functions from dma.c to pci.c and register mt=
76
> > bus operation earilier, that is the __mt7921e_mcu_drv_pmctrl depends on=
.
> >
> > Fixes: bf3747ae2e25 ("mt76: mt7921: enable aspm by default")
> > Reported-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
> > Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>
>
> Tested-by: Khalid Aziz <khalid@gonehiking.org>
>
> --
> Khalid
> > ---
> >   .../net/wireless/mediatek/mt76/mt7921/dma.c   | 119 -----------------
> >   .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
> >   .../net/wireless/mediatek/mt76/mt7921/pci.c   | 124 +++++++++++++++++=
+
> >   .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  18 ++-
> >   4 files changed, 139 insertions(+), 123 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/dma.c
> > index cdff1fd52d93..39d6ce4ecddd 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> > @@ -78,110 +78,6 @@ static void mt7921_dma_prefetch(struct mt7921_dev *=
dev)
> >       mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
> >   }
> >
> > -static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
> > -{
> > -     static const struct {
> > -             u32 phys;
> > -             u32 mapped;
> > -             u32 size;
> > -     } fixed_map[] =3D {
> > -             { 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBL=
ON) */
> > -             { 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_M=
IB) */
> > -             { 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_T=
MAC) */
> > -             { 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_D=
MA) */
> > -             { 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_L=
PON) */
> > -             { 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_A=
GG) */
> > -             { 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_A=
RB) */
> > -             { 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_R=
MAC) */
> > -             { 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
> > -             { 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (confi=
gure register) */
> > -             { 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
> > -             { 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 =
*/
> > -             { 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 =
*/
> > -             { 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 =
(MEM_DMA) */
> > -             { 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 =
*/
> > -             { 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
> > -             { 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
> > -             { 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_hos=
t_csr_top */
> > -             { 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
> > -             { 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
> > -             { 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> > -             { 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> > -             { 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
> > -             { 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
> > -             { 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) =
*/
> > -             { 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) *=
/
> > -             { 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_C=
FG) */
> > -             { 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_T=
RB) */
> > -             { 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_W=
TBLOFF) */
> > -             { 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_E=
TBF) */
> > -             { 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_I=
NT) */
> > -             { 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_C=
FG) */
> > -             { 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_T=
RB) */
> > -             { 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_A=
GG) */
> > -             { 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_A=
RB) */
> > -             { 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_T=
MAC) */
> > -             { 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_R=
MAC) */
> > -             { 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_D=
MA) */
> > -             { 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_W=
TBLOFF) */
> > -             { 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_E=
TBF) */
> > -             { 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_L=
PON) */
> > -             { 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_I=
NT) */
> > -             { 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_M=
IB) */
> > -     };
> > -     int i;
> > -
> > -     if (addr < 0x100000)
> > -             return addr;
> > -
> > -     for (i =3D 0; i < ARRAY_SIZE(fixed_map); i++) {
> > -             u32 ofs;
> > -
> > -             if (addr < fixed_map[i].phys)
> > -                     continue;
> > -
> > -             ofs =3D addr - fixed_map[i].phys;
> > -             if (ofs > fixed_map[i].size)
> > -                     continue;
> > -
> > -             return fixed_map[i].mapped + ofs;
> > -     }
> > -
> > -     if ((addr >=3D 0x18000000 && addr < 0x18c00000) ||
> > -         (addr >=3D 0x70000000 && addr < 0x78000000) ||
> > -         (addr >=3D 0x7c000000 && addr < 0x7c400000))
> > -             return mt7921_reg_map_l1(dev, addr);
> > -
> > -     dev_err(dev->mt76.dev, "Access currently unsupported address %08x=
\n",
> > -             addr);
> > -
> > -     return 0;
> > -}
> > -
> > -static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
> > -{
> > -     struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, =
mt76);
> > -     u32 addr =3D __mt7921_reg_addr(dev, offset);
> > -
> > -     return dev->bus_ops->rr(mdev, addr);
> > -}
> > -
> > -static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
> > -{
> > -     struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, =
mt76);
> > -     u32 addr =3D __mt7921_reg_addr(dev, offset);
> > -
> > -     dev->bus_ops->wr(mdev, addr, val);
> > -}
> > -
> > -static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32=
 val)
> > -{
> > -     struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, =
mt76);
> > -     u32 addr =3D __mt7921_reg_addr(dev, offset);
> > -
> > -     return dev->bus_ops->rmw(mdev, addr, mask, val);
> > -}
> > -
> >   static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
> >   {
> >       if (force) {
> > @@ -341,23 +237,8 @@ int mt7921_wpdma_reinit_cond(struct mt7921_dev *de=
v)
> >
> >   int mt7921_dma_init(struct mt7921_dev *dev)
> >   {
> > -     struct mt76_bus_ops *bus_ops;
> >       int ret;
> >
> > -     dev->phy.dev =3D dev;
> > -     dev->phy.mt76 =3D &dev->mt76.phy;
> > -     dev->mt76.phy.priv =3D &dev->phy;
> > -     dev->bus_ops =3D dev->mt76.bus;
> > -     bus_ops =3D devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus=
_ops),
> > -                            GFP_KERNEL);
> > -     if (!bus_ops)
> > -             return -ENOMEM;
> > -
> > -     bus_ops->rr =3D mt7921_rr;
> > -     bus_ops->wr =3D mt7921_wr;
> > -     bus_ops->rmw =3D mt7921_rmw;
> > -     dev->mt76.bus =3D bus_ops;
> > -
> >       mt76_dma_attach(&dev->mt76);
> >
> >       ret =3D mt7921_dma_disable(dev, true);
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drive=
rs/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > index 8b674e042568..63e3c7ef5e89 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > @@ -443,6 +443,7 @@ int mt7921e_mcu_init(struct mt7921_dev *dev);
> >   int mt7921s_wfsys_reset(struct mt7921_dev *dev);
> >   int mt7921s_mac_reset(struct mt7921_dev *dev);
> >   int mt7921s_init_reset(struct mt7921_dev *dev);
> > +int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
> >   int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
> >   int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/pci.c
> > index 1ae0d5826ca7..a0c82d19c4d9 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > @@ -121,6 +121,110 @@ static void mt7921e_unregister_device(struct mt79=
21_dev *dev)
> >       mt76_free_device(&dev->mt76);
> >   }
> >
> > +static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
> > +{
> > +     static const struct {
> > +             u32 phys;
> > +             u32 mapped;
> > +             u32 size;
> > +     } fixed_map[] =3D {
> > +             { 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBL=
ON) */
> > +             { 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_M=
IB) */
> > +             { 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_T=
MAC) */
> > +             { 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_D=
MA) */
> > +             { 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_L=
PON) */
> > +             { 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_A=
GG) */
> > +             { 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_A=
RB) */
> > +             { 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_R=
MAC) */
> > +             { 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
> > +             { 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (confi=
gure register) */
> > +             { 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
> > +             { 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 =
*/
> > +             { 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 =
*/
> > +             { 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 =
(MEM_DMA) */
> > +             { 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 =
*/
> > +             { 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
> > +             { 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
> > +             { 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_hos=
t_csr_top */
> > +             { 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
> > +             { 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
> > +             { 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> > +             { 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> > +             { 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
> > +             { 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
> > +             { 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) =
*/
> > +             { 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) *=
/
> > +             { 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_C=
FG) */
> > +             { 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_T=
RB) */
> > +             { 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_W=
TBLOFF) */
> > +             { 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_E=
TBF) */
> > +             { 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_I=
NT) */
> > +             { 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_C=
FG) */
> > +             { 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_T=
RB) */
> > +             { 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_A=
GG) */
> > +             { 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_A=
RB) */
> > +             { 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_T=
MAC) */
> > +             { 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_R=
MAC) */
> > +             { 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_D=
MA) */
> > +             { 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_W=
TBLOFF) */
> > +             { 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_E=
TBF) */
> > +             { 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_L=
PON) */
> > +             { 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_I=
NT) */
> > +             { 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_M=
IB) */
> > +     };
> > +     int i;
> > +
> > +     if (addr < 0x100000)
> > +             return addr;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(fixed_map); i++) {
> > +             u32 ofs;
> > +
> > +             if (addr < fixed_map[i].phys)
> > +                     continue;
> > +
> > +             ofs =3D addr - fixed_map[i].phys;
> > +             if (ofs > fixed_map[i].size)
> > +                     continue;
> > +
> > +             return fixed_map[i].mapped + ofs;
> > +     }
> > +
> > +     if ((addr >=3D 0x18000000 && addr < 0x18c00000) ||
> > +         (addr >=3D 0x70000000 && addr < 0x78000000) ||
> > +         (addr >=3D 0x7c000000 && addr < 0x7c400000))
> > +             return mt7921_reg_map_l1(dev, addr);
> > +
> > +     dev_err(dev->mt76.dev, "Access currently unsupported address %08x=
\n",
> > +             addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
> > +{
> > +     struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, =
mt76);
> > +     u32 addr =3D __mt7921_reg_addr(dev, offset);
> > +
> > +     return dev->bus_ops->rr(mdev, addr);
> > +}
> > +
> > +static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
> > +{
> > +     struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, =
mt76);
> > +     u32 addr =3D __mt7921_reg_addr(dev, offset);
> > +
> > +     dev->bus_ops->wr(mdev, addr, val);
> > +}
> > +
> > +static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32=
 val)
> > +{
> > +     struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, =
mt76);
> > +     u32 addr =3D __mt7921_reg_addr(dev, offset);
> > +
> > +     return dev->bus_ops->rmw(mdev, addr, mask, val);
> > +}
> > +
> >   static int mt7921_pci_probe(struct pci_dev *pdev,
> >                           const struct pci_device_id *id)
> >   {
> > @@ -152,6 +256,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> >               .fw_own =3D mt7921e_mcu_fw_pmctrl,
> >       };
> >
> > +     struct mt76_bus_ops *bus_ops;
> >       struct mt7921_dev *dev;
> >       struct mt76_dev *mdev;
> >       int ret;
> > @@ -189,6 +294,25 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> >
> >       mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
> >       tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned lon=
g)dev);
> > +
> > +     dev->phy.dev =3D dev;
> > +     dev->phy.mt76 =3D &dev->mt76.phy;
> > +     dev->mt76.phy.priv =3D &dev->phy;
> > +     dev->bus_ops =3D dev->mt76.bus;
> > +     bus_ops =3D devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus=
_ops),
> > +                            GFP_KERNEL);
> > +     if (!bus_ops)
> > +             return -ENOMEM;
> > +
> > +     bus_ops->rr =3D mt7921_rr;
> > +     bus_ops->wr =3D mt7921_wr;
> > +     bus_ops->rmw =3D mt7921_rmw;
> > +     dev->mt76.bus =3D bus_ops;
> > +
> > +     ret =3D __mt7921e_mcu_drv_pmctrl(dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       mdev->rev =3D (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
> >                   (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
> >       dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/driv=
ers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> > index f9e350b67fdc..36669e5aeef3 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> > @@ -59,10 +59,8 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
> >       return err;
> >   }
> >
> > -int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> > +int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> >   {
> > -     struct mt76_phy *mphy =3D &dev->mt76.phy;
> > -     struct mt76_connac_pm *pm =3D &dev->pm;
> >       int i, err =3D 0;
> >
> >       for (i =3D 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> > @@ -75,9 +73,21 @@ int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> >       if (i =3D=3D MT7921_DRV_OWN_RETRY_COUNT) {
> >               dev_err(dev->mt76.dev, "driver own failed\n");
> >               err =3D -EIO;
> > -             goto out;
> >       }
> >
> > +     return err;
> > +}
> > +
> > +int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> > +{
> > +     struct mt76_phy *mphy =3D &dev->mt76.phy;
> > +     struct mt76_connac_pm *pm =3D &dev->pm;
> > +     int err;
> > +
> > +     err =3D __mt7921e_mcu_drv_pmctrl(dev);
> > +     if (err < 0)
> > +             goto out;
> > +
> >       mt7921_wpdma_reinit_cond(dev);
> >       clear_bit(MT76_STATE_PM, &mphy->state);
> >
>
>


--
Janusz Dziedzic
