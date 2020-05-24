Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4C1DFF30
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgEXNo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 09:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEXNo6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 09:44:58 -0400
Received: from localhost (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CC6206D5;
        Sun, 24 May 2020 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590327897;
        bh=CbjM5fDJLpcpo2Lq2tfp74GGL0eo2iAGO4J32/ZY9qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRK24cjV2Bi+zPkhLpHhElavGVk+exgw2aUtji31OnAn6K+WBcMTKf7h52Fz3GoaI
         xwPvWv79zsnRZEzb2A+2iFX8SZx7uKLYpT+C2nzzGRXGT7Ihr0cDB48AwECd00azvf
         EIAHGnv3jZDWsqaQ7sLhWVkTqiAkHm4Oq5XtCkn8=
Date:   Sun, 24 May 2020 15:45:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH] mt76: only iterate over initialized rx queues
Message-ID: <20200524134500.GA33803@localhost.localdomain>
References: <20200524130746.98760-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20200524130746.98760-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fixes the following reported crash:
>=20
> [    2.361127] BUG: spinlock bad magic on CPU#0, modprobe/456
> [    2.361583]  lock: 0xffffa1287525b3b8, .magic: 00000000, .owner: <none=
>/-1, .owner_cpu: 0
> [    2.362250] CPU: 0 PID: 456 Comm: modprobe Not tainted 4.14.177 #5
> [    2.362751] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.75.0 0=
6/17/2019
> [    2.363343] Call Trace:
> [    2.363552]  dump_stack+0x97/0xdb
> [    2.363826]  ? spin_bug+0xa6/0xb3
> [    2.364096]  do_raw_spin_lock+0x6a/0x9a
> [    2.364417]  mt76_dma_rx_fill+0x44/0x1de [mt76]
> [    2.364787]  ? mt76_dma_kick_queue+0x18/0x18 [mt76]
> [    2.365184]  mt76_dma_init+0x53/0x85 [mt76]
> [    2.365532]  mt7615_dma_init+0x3d7/0x546 [mt7615e]
> [    2.365928]  mt7615_register_device+0xe6/0x1a0 [mt7615e]
> [    2.366364]  mt7615_mmio_probe+0x14b/0x171 [mt7615e]
> [    2.366771]  mt7615_pci_probe+0x118/0x13b [mt7615e]
> [    2.367169]  pci_device_probe+0xaf/0x13d
> [    2.367491]  driver_probe_device+0x284/0x2ca
> [    2.367840]  __driver_attach+0x7a/0x9e
> [    2.368146]  ? driver_attach+0x1f/0x1f
> [    2.368451]  bus_for_each_dev+0xa0/0xdb
> [    2.368765]  bus_add_driver+0x132/0x204
> [    2.369078]  driver_register+0x8e/0xcd
> [    2.369384]  do_one_initcall+0x160/0x257
> [    2.369706]  ? 0xffffffffc0240000
> [    2.369980]  do_init_module+0x60/0x1bb
> [    2.370286]  load_module+0x18c2/0x1a2b
> [    2.370596]  ? kernel_read_file+0x141/0x1b9
> [    2.370937]  ? kernel_read_file_from_fd+0x46/0x71
> [    2.371320]  SyS_finit_module+0xcc/0xf0
> [    2.371636]  do_syscall_64+0x6b/0xf7
> [    2.371930]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [    2.372344] RIP: 0033:0x7da218ae4199
> [    2.372637] RSP: 002b:00007fffd0608398 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [    2.373252] RAX: ffffffffffffffda RBX: 00005a705449df90 RCX: 00007da21=
8ae4199
> [    2.373833] RDX: 0000000000000000 RSI: 00005a7052e73bd8 RDI: 000000000=
0000006
> [    2.374411] RBP: 00007fffd06083e0 R08: 0000000000000000 R09: 00005a705=
449d540
> [    2.374989] R10: 0000000000000006 R11: 0000000000000246 R12: 000000000=
0000000
> [    2.375569] R13: 00005a705449def0 R14: 00005a7052e73bd8 R15: 000000000=
0000000
>=20
> Reported-by: Sean Wang <sean.wang@mediatek.com>
> Fixes: d3377b78cec6 ("mt76: add HE phy modes and hardware queue")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Just a couple of nitpicks inline, for the rest:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/debugfs.c      | 2 +-
>  drivers/net/wireless/mediatek/mt76/dma.c          | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt76.h         | 4 ++++
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c   | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c   | 8 +++++---
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c   | 3 ++-
>  8 files changed, 20 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/w=
ireless/mediatek/mt76/debugfs.c
> index 0278e1b44576..3a5de1d1b121 100644
> --- a/drivers/net/wireless/mediatek/mt76/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
> @@ -51,7 +51,7 @@ static int mt76_rx_queues_read(struct seq_file *s, void=
 *data)
>  	struct mt76_dev *dev =3D dev_get_drvdata(s->private);
>  	int i, queued;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->q_rx); i++) {
> +	mt76_for_each_q_rx(dev, i) {
>  		struct mt76_queue *q =3D &dev->q_rx[i];
> =20
>  		if (!q->ndesc)

doing so you can drop this check here

> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index 75e659774e07..f4d6074fe32a 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -576,7 +576,7 @@ mt76_dma_init(struct mt76_dev *dev)
> =20
>  	init_dummy_netdev(&dev->napi_dev);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->q_rx); i++) {
> +	mt76_for_each_q_rx(dev, i) {
>  		netif_napi_add(&dev->napi_dev, &dev->napi[i], mt76_dma_rx_poll,
>  			       64);
>  		mt76_dma_rx_fill(dev, &dev->q_rx[i]);
> @@ -610,7 +610,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
>  	for (i =3D 0; i < ARRAY_SIZE(dev->q_tx); i++)
>  		mt76_dma_tx_cleanup(dev, i, true);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->q_rx); i++) {
> +	mt76_for_each_q_rx(dev, i) {
>  		netif_napi_del(&dev->napi[i]);
>  		mt76_dma_rx_cleanup(dev, &dev->q_rx[i]);
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index afb1ccf61b74..78378dcf430a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -671,6 +671,10 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
>  #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanu=
p(&((dev)->mt76), __VA_ARGS__)
>  #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->m=
t76), __VA_ARGS__)
> =20
> +#define mt76_for_each_q_rx(dev, i)	\
> +	for (i =3D 0; i < ARRAY_SIZE((dev)->q_rx) && \
> +		    (dev)->q_rx[i].desc; i++)
> +
>  struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int siz=
e,
>  				   const struct ieee80211_ops *ops,
>  				   const struct mt76_driver_ops *drv_ops);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7603/mac.c
> index 0f205ffe4905..8060c1514396 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> @@ -1438,8 +1438,9 @@ static void mt7603_mac_watchdog_reset(struct mt7603=
_dev *dev)
>  	for (i =3D 0; i < __MT_TXQ_MAX; i++)
>  		mt76_queue_tx_cleanup(dev, i, true);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
> +	mt76_for_each_q_rx(&dev->mt76, i) {
>  		mt76_queue_rx_reset(dev, i);
> +	}

you can drop braces here

> =20
>  	mt7603_dma_sched_reset(dev);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index f1009c92ec1b..9f1c6ca7a665 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -1820,8 +1820,9 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
>  	for (i =3D 0; i < __MT_TXQ_MAX; i++)
>  		mt76_queue_tx_cleanup(dev, i, true);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
> +	mt76_for_each_q_rx(&dev->mt76, i) {
>  		mt76_queue_rx_reset(dev, i);
> +	}

you can drop braces here
> =20
>  	mt76_set(dev, MT_WPDMA_GLO_CFG,
>  		 MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/pci.c
> index b09d08d0dac9..ba12f199bce0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> @@ -86,8 +86,9 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_=
message_t state)
>  	napi_disable(&mdev->tx_napi);
>  	tasklet_kill(&mdev->tx_tasklet);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->q_rx); i++)
> +	mt76_for_each_q_rx(mdev, i) {
>  		napi_disable(&mdev->napi[i]);
> +	}

same here

>  	tasklet_kill(&dev->irq_tasklet);
> =20
>  	mt7615_dma_reset(dev);
> @@ -120,8 +121,9 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, p=
m_message_t state)
>  	return 0;
> =20
>  restore:
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->q_rx); i++)
> +	mt76_for_each_q_rx(mdev, i) {
>  		napi_enable(&mdev->napi[i]);
> +	}
>  	napi_enable(&mdev->tx_napi);
>  	if (hif_suspend)
>  		mt7615_mcu_set_hif_suspend(dev, false);
> @@ -156,7 +158,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
>  	if (pdma_reset)
>  		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->q_rx); i++) {
> +	mt76_for_each_q_rx(mdev, i) {
>  		napi_enable(&mdev->napi[i]);
>  		napi_schedule(&mdev->napi[i]);
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_mmio.c
> index 18adedfbbb8e..cbbe986655fe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> @@ -489,8 +489,9 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev=
 *dev)
>  	for (i =3D 0; i < __MT_TXQ_MAX; i++)
>  		mt76_queue_tx_cleanup(dev, i, true);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
> +	mt76_for_each_q_rx(&dev->mt76, i) {
>  		mt76_queue_rx_reset(dev, i);
> +	}
> =20
>  	mt76x02_mac_start(dev);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index ab20dfde94af..a264e304a3df 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1146,8 +1146,9 @@ mt7915_dma_reset(struct mt7915_dev *dev)
>  	for (i =3D 0; i < __MT_TXQ_MAX; i++)
>  		mt76_queue_tx_cleanup(dev, i, true);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
> +	mt76_for_each_q_rx(&dev->mt76, i) {
>  		mt76_queue_rx_reset(dev, i);
> +	}

same here
> =20
>  	/* re-init prefetch settings after reset */
>  	mt7915_dma_prefetch(dev);
> --=20
> 2.24.0
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXsp6WQAKCRA6cBh0uS2t
rDLfAQCU5f4kFLhZfwefvy6H1rJyH+2IAmyft0U96TfZcHEspQD/c205pjuHbUbf
5fMfwj1EBeGVI6q6SIU8Y3nUbK0begs=
=9EXn
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
