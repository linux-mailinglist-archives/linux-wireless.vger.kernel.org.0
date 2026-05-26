Return-Path: <linux-wireless+bounces-36937-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH6OB08kFmqBiAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36937-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 00:53:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4255DD5DC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 00:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46FBF3012336
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25234369203;
	Tue, 26 May 2026 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/mXuUxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462603C37A3
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835932; cv=none; b=ORYLGxh1LvZ6c4wYXqIAgHaSmYgwIF8OvGsS991jGkq3WyMzGzxhO2V0NJSRx17cGwf+Ie5k0Dm0y7/t+kXx+3NYBM2P8+fKn4J5BPV+R3Qb0v2PqouX+QgNK/isE5UovpTFYuIYMtrfO7XExK6cl4CJcJ3ixIvJx+VhNB4DhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835932; c=relaxed/simple;
	bh=THqpWEB/dRSGfxUHGm+y4rhy5dg/xMFRk68bkRsp7mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4lqnHwSPBAIbxoii1zIc6XZvrx+tFIy2tb2nuyDTEOg25MU1IldN5ThZnC5lVO7m/DkPYSMtxBcx63BrbAcyZy1D3vsiremDpRWJxoHIB2AJE5HICLVsTGcOVwaNNLrLoihKttsMVMZp08UD5+/GWIgWNK+71NoHTpHKyo+1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/mXuUxb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01151F00A3E
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835929;
	bh=VfzM6LdUA0qi+e/RUFYNl4nW0x6KKJ/y2kEbTpe+cQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d/mXuUxbZ7aBqjOlq6VE9I2LzkcLSBqVn161XdA4+LDv4yMtvweLjkyTzBstuv4tp
	 LitF0Zw/cdkHNiQZobqP9aHvLPZ1Wmy/CV+At7x32zFMgtJxkKkXG48ZnvuzX7x8h1
	 kQ+x1dTyDaa5k/QuFmxKD+B1hsOLgk1nFobK8iV+/XczMIa5NhHwQfcTAhq0ggFnzt
	 S+iRtZGLZVU/gFDtzD7Ups8pU4MIZ5/2mgkO9nh5dGZ57sJfNBgcKGcuMlbAlQXWKM
	 4uucenI4DbAErB38TsiG8LClSNs5Z5NRxgVYTdUENW5Idj8pY2YpHnKMuNNImS8SXN
	 6XKadrfI5hjcA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3939d2bd7ecso93275031fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 15:52:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YxtTNQjQ3RMB2ew099fcykR2CrkNYwQbFESkEuS5qbJDQwIYT2A
	eOCCUEahe5SlW1KL2Qjd6LP5xky7LfcBIdtj7QfHhQCytBpVW7CxIuV7ywrGZNid4zA+thukFZR
	j7J7VHgD3EcvjOsi3iEr0t0QOM2Eq+zw=
X-Received: by 2002:a05:651c:198f:b0:391:11de:dd5b with SMTP id
 38308e7fff4ca-395d8ea8c7dmr62250781fa.11.1779835927953; Tue, 26 May 2026
 15:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahTdpNQp2va_xTVR@wico-dev.wnam.ru>
In-Reply-To: <ahTdpNQp2va_xTVR@wico-dev.wnam.ru>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 26 May 2026 17:51:54 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzq2R1c6ZiNU-HqLuOEKV=xsQ3r40Ft59RvoUk69TyNxxA@mail.gmail.com>
X-Gm-Features: AVHnY4LTuhbTCmsfBdzRK2G66Png7EatfFUpCFT_KBks5SDiEB00CcZg69NThDc
Message-ID: <CAGp9Lzq2R1c6ZiNU-HqLuOEKV=xsQ3r40Ft59RvoUk69TyNxxA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: track rx napi ownership for cleanup
To: Ruslan Isaev <legale.legale@gmail.com>
Cc: linux-wireless@vger.kernel.org, sean.wang@mediatek.com, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36937-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9C4255DD5DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, May 25, 2026 at 6:39=E2=80=AFPM Ruslan Isaev <legale.legale@gmail.c=
om> wrote:
>
>
> mt76_dma_cleanup() deletes rx napi instances for every allocated rx
> queue. This is not symmetric with mt76_dma_init(), which skips WED_RRO
> queues when adding rx napi.
>
> Adding an unconditional napi_disable() in the cleanup path fixes the
> mt7915 remove warning, but it is not safe for all other mt76 paths. mt792=
1 and
> mt7925 can already disable rx napi in their unregister
> paths before calling mt76_dma_cleanup(). On mt7996/mt7992 WED_RRO
> queues may have ndesc set even though mt76 never added or enabled napi fo=
r them.
>
> Track rx napi ownership and enabled state in struct mt76_queue so
> cleanup only disables and deletes napi instances that were actually
> added by mt76.
>
> This keeps the existing reset/suspend/remove ordering intact while
> avoiding double napi_disable() and avoiding napi cleanup on WED_RRO
> queues without napi.
>
> Signed-off-by: Ruslan Isaev <legale.legale@gmail.com>
> ---
> v2:
> - track mt76 rx napi state added/enabled
> - avoid double napi_disable() on mt7921/mt7925 cleanup paths
> - avoid napi cleanup on WED_RRO queues without napi

I do not think v2 is the right shape yet, mainly for a few reasons:

1. The patch scope changed too much

   v1 looked like a focused fix for the mt7915/mt7981 remove warning.
   But v2 changes the title to RX NAPI ownership tracking and touches
   many reset and unregister paths across mt76 and drivers

   Could you clarify why the title and scope changed from a targeted
   cleanup fix to a generic RX NAPI state refactor?

2. If the issue is limited to mt7915/mt7981 remove, we should consider
   fixing it in that functional driver path first

   Adding generic NAPI state tracking to struct mt76_queue feels too
   broad if the original warning is only from a specific driver removal
   path.

3. mt7921/mt7925 do not have the same original issue in practice

   The problem I saw with v1 on mt7925 was caused by adding an
   unconditional napi_disable() in mt76_dma_cleanup(), while mt7921 and
   mt7925 already disable RX NAPI in their unregister paths that cause the
   driver to hang.

   If mt76_dma_cleanup() is going to own the final RX NAPI
   disable/delete path, those duplicated RX NAPI disables in
   mt7921/mt7925 unregister should be removed first.

4. If mt76 core does more, functional driver paths should become simpler

   A common mt76-layer cleanup should reduce duplicated chip-specific
   cleanup logic. v2 instead adds a new NAPI state machine and updates
   many functional driver paths, which makes the overall flow harder to
   reason about.

5. The WED RRO issue can probably be handled with a smaller symmetric
   init/cleanup condition

   mt76_dma_init() already skips WED RRO queues when adding RX NAPI.
   mt76_dma_cleanup() should use the same condition and only
   disable/delete RX NAPI for queues where init actually added RX NAPI.

   That would keep init and cleanup symmetric without introducing RX
   NAPI ownership state unless we really need it.

So my concern is not about fixing the warning itself, but about the
scope and complexity of v2.

I think we can handle this in two stages:

1. First, fix the current mt7915/mt7981 issue in the affected functional
   driver remove path with a minimal and targeted patch. The patch should
   also include the appropriate Fixes tag.

2. Then, as a follow-up, we can consider whether mt76 core should own
   more of the RX NAPI cleanup path. If we do that, the goal should be
   to make the functional driver paths simpler, keep the init/cleanup
   conditions symmetric and not cause regression.

Also, I think the patch title should not change too much between v1 and
v2 If this series is still intended to fix the mt7915/mt7981 remove warning=
,
I would keep the title and scope focused on that first.

           Sean


>
>  drivers/net/wireless/mediatek/mt76/dma.c      |  9 +++--
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 40 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7603/mac.c   |  8 ++--
>  .../net/wireless/mediatek/mt76/mt7615/pci.c   |  6 +--
>  .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  4 +-
>  .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  4 +-
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 +-
>  .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  6 +--
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |  8 ++--
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  8 ++--
>  .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  4 +-
>  .../net/wireless/mediatek/mt76/mt7925/pci.c   |  8 ++--
>  .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  8 ++--
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   |  8 ++--
>  drivers/net/wireless/mediatek/mt76/npu.c      |  3 +-
>  15 files changed, 86 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index f8c2fe5f2f58..5c531131a25f 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -1099,9 +1099,12 @@ static void
>  mt76_dma_rx_queue_init(struct mt76_dev *dev, enum mt76_rxq_id qid,
>                        int (*poll)(struct napi_struct *napi, int budget))
>  {
> +       struct mt76_queue *q =3D &dev->q_rx[qid];
> +
>         netif_napi_add(dev->napi_dev, &dev->napi[qid], poll);
> -       mt76_dma_rx_fill_buf(dev, &dev->q_rx[qid], false);
> -       napi_enable(&dev->napi[qid]);
> +       q->napi_state =3D MT76_NAPI_ADDED;
> +       mt76_dma_rx_fill_buf(dev, q, false);
> +       mt76_rx_napi_enable(dev, qid);
>  }
>
>  static int
> @@ -1189,7 +1192,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
>         mt76_for_each_q_rx(dev, i) {
>                 struct mt76_queue *q =3D &dev->q_rx[i];
>
> -               netif_napi_del(&dev->napi[i]);
> +               mt76_rx_napi_del(dev, i);
>                 mt76_dma_rx_cleanup(dev, q);
>
>                 page_pool_destroy(q->page_pool);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 527bef97e122..3ce936bdcf88 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -251,6 +251,7 @@ struct mt76_queue {
>         int buf_size;
>         bool stopped;
>         bool blocked;
> +       u8 napi_state;
>
>         u8 buf_offset;
>         u16 flags;
> @@ -1283,6 +1284,45 @@ static inline int mt76_wed_dma_setup(struct mt76_d=
ev *dev, struct mt76_queue *q,
>         for (i =3D 0; i < ARRAY_SIZE((dev)->q_rx); i++)   \
>                 if ((dev)->q_rx[i].ndesc)
>
> +#define MT76_NAPI_ADDED                BIT(0)
> +#define MT76_NAPI_ENABLED      BIT(1)
> +
> +static inline void mt76_rx_napi_enable(struct mt76_dev *dev, int qid)
> +{
> +       struct mt76_queue *q =3D &dev->q_rx[qid];
> +
> +       if (!(q->napi_state & MT76_NAPI_ADDED) ||
> +           (q->napi_state & MT76_NAPI_ENABLED))
> +               return;
> +
> +       napi_enable(&dev->napi[qid]);
> +       q->napi_state |=3D MT76_NAPI_ENABLED;
> +}
> +
> +static inline void mt76_rx_napi_disable(struct mt76_dev *dev, int qid)
> +{
> +       struct mt76_queue *q =3D &dev->q_rx[qid];
> +
> +       if (!(q->napi_state & MT76_NAPI_ADDED) ||
> +           !(q->napi_state & MT76_NAPI_ENABLED))
> +               return;
> +
> +       napi_disable(&dev->napi[qid]);
> +       q->napi_state &=3D ~MT76_NAPI_ENABLED;
> +}
> +
> +static inline void mt76_rx_napi_del(struct mt76_dev *dev, int qid)
> +{
> +       struct mt76_queue *q =3D &dev->q_rx[qid];
> +
> +       if (!(q->napi_state & MT76_NAPI_ADDED))
> +               return;
> +
> +       mt76_rx_napi_disable(dev, qid);
> +       netif_napi_del(&dev->napi[qid]);
> +       q->napi_state =3D 0;
> +}
> +
>
>  #define mt76_dereference(p, dev) \
>         rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7603/mac.c
> index d3110eeb45d7..be35ec0d31d4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> @@ -1423,8 +1423,8 @@ static void mt7603_mac_watchdog_reset(struct mt7603=
_dev *dev)
>
>         mt76_worker_disable(&dev->mt76.tx_worker);
>         tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
> -       napi_disable(&dev->mt76.napi[0]);
> -       napi_disable(&dev->mt76.napi[1]);
> +       mt76_rx_napi_disable(&dev->mt76, 0);
> +       mt76_rx_napi_disable(&dev->mt76, 1);
>         napi_disable(&dev->mt76.tx_napi);
>
>         mutex_lock(&dev->mt76.mutex);
> @@ -1474,8 +1474,8 @@ static void mt7603_mac_watchdog_reset(struct mt7603=
_dev *dev)
>         mt7603_beacon_set_timer(dev, -1, beacon_int);
>
>         napi_enable(&dev->mt76.tx_napi);
> -       napi_enable(&dev->mt76.napi[0]);
> -       napi_enable(&dev->mt76.napi[1]);
> +       mt76_rx_napi_enable(&dev->mt76, 0);
> +       mt76_rx_napi_enable(&dev->mt76, 1);
>
>         local_bh_disable();
>         napi_schedule(&dev->mt76.tx_napi);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/pci.c
> index f5018bfa317a..600b4f2bf1a1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> @@ -92,7 +92,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_=
message_t state)
>         mt76_worker_disable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_disable(&mdev->napi[i]);
> +               mt76_rx_napi_disable(mdev, i);
>         }
>         tasklet_kill(&mdev->irq_tasklet);
>
> @@ -127,7 +127,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, p=
m_message_t state)
>
>  restore:
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>         if (hif_suspend)
> @@ -166,7 +166,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
>         mt76_worker_enable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/driver=
s/net/wireless/mediatek/mt76/mt7615/pci_mac.c
> index 53cb1eed1e4f..a83589c628f9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
> @@ -236,7 +236,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
>
>         mt76_worker_disable(&dev->mt76.tx_worker);
>         mt76_for_each_q_rx(&dev->mt76, i)
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         napi_disable(&dev->mt76.tx_napi);
>
>         mt7615_mutex_acquire(dev);
> @@ -264,7 +264,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
>
>         napi_enable(&dev->mt76.tx_napi);
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_enable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_enable(&dev->mt76, i);
>         }
>
>         local_bh_disable();
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x0/pci.c
> index f8d206a07f99..96380d016351 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> @@ -257,7 +257,7 @@ static int mt76x0e_suspend(struct pci_dev *pdev, pm_m=
essage_t state)
>         napi_disable(&mdev->tx_napi);
>
>         mt76_for_each_q_rx(mdev, i)
> -               napi_disable(&mdev->napi[i]);
> +               mt76_rx_napi_disable(mdev, i);
>
>         mt76x02_dma_disable(dev);
>         mt76x02_mcu_cleanup(dev);
> @@ -285,7 +285,7 @@ static int mt76x0e_resume(struct pci_dev *pdev)
>
>         mt76_for_each_q_rx(mdev, i) {
>                 mt76_queue_rx_reset(dev, i);
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_mmio.c
> index dc7c03d23123..0da4bbad5ba3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> @@ -444,7 +444,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev=
 *dev)
>         napi_disable(&dev->mt76.tx_napi);
>
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         }
>
>         mutex_lock(&dev->mt76.mutex);
> @@ -505,7 +505,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev=
 *dev)
>
>         napi_enable(&dev->mt76.tx_napi);
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_enable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_enable(&dev->mt76, i);
>         }
>
>         local_bh_disable();
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x2/pci.c
> index 491a32921a06..a23c2560e90f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> @@ -119,7 +119,7 @@ mt76x2e_suspend(struct pci_dev *pdev, pm_message_t st=
ate)
>         mt76_worker_disable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i)
> -               napi_disable(&mdev->napi[i]);
> +               mt76_rx_napi_disable(mdev, i);
>
>         pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
>         pci_save_state(pdev);
> @@ -131,7 +131,7 @@ mt76x2e_suspend(struct pci_dev *pdev, pm_message_t st=
ate)
>
>  restore:
>         mt76_for_each_q_rx(mdev, i)
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         napi_enable(&mdev->tx_napi);
>
>         return err;
> @@ -153,7 +153,7 @@ mt76x2e_resume(struct pci_dev *pdev)
>         mt76_worker_enable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index cec2c4208255..354ed0b69013 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1327,7 +1327,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
>         mt76_worker_disable(&dev->mt76.tx_worker);
>         mt76_for_each_q_rx(mdev, i) {
>                 if (mdev->q_rx[i].ndesc)
> -                       napi_disable(&dev->mt76.napi[i]);
> +                       mt76_rx_napi_disable(&dev->mt76, i);
>         }
>         napi_disable(&dev->mt76.tx_napi);
>
> @@ -1339,7 +1339,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
>
>         mt76_for_each_q_rx(mdev, i) {
>                 if (mdev->q_rx[i].ndesc) {
> -                       napi_enable(&dev->mt76.napi[i]);
> +                       mt76_rx_napi_enable(&dev->mt76, i);
>                 }
>         }
>
> @@ -1527,7 +1527,7 @@ void mt7915_mac_reset_work(struct work_struct *work=
)
>
>         mt76_worker_disable(&dev->mt76.tx_worker);
>         mt76_for_each_q_rx(&dev->mt76, i)
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         napi_disable(&dev->mt76.tx_napi);
>
>
> @@ -1558,7 +1558,7 @@ void mt7915_mac_reset_work(struct work_struct *work=
)
>                 clear_bit(MT76_RESET, &phy2->mt76->state);
>
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_enable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_enable(&dev->mt76, i);
>         }
>
>         local_bh_disable();
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 7a790ddf43bb..c3188b344e50 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -52,7 +52,7 @@ static void mt7921e_unregister_device(struct mt792x_dev=
 *dev)
>         cancel_work_sync(&dev->init_work);
>         mt76_unregister_device(&dev->mt76);
>         mt76_for_each_q_rx(&dev->mt76, i)
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         cancel_delayed_work_sync(&pm->ps_work);
>         cancel_work_sync(&pm->wake_work);
>         cancel_work_sync(&dev->reset_work);
> @@ -492,7 +492,7 @@ static int mt7921_pci_suspend(struct device *device)
>         mt76_worker_disable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_disable(&mdev->napi[i]);
> +               mt76_rx_napi_disable(mdev, i);
>         }
>
>         /* wait until dma is idle  */
> @@ -518,7 +518,7 @@ static int mt7921_pci_suspend(struct device *device)
>
>  restore_napi:
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> @@ -564,7 +564,7 @@ static int mt7921_pci_resume(struct device *device)
>         mt76_worker_enable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index 0db7acb3a637..5d7871b8f77c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -72,7 +72,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
>
>         mt76_worker_disable(&dev->mt76.tx_worker);
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         }
>         napi_disable(&dev->mt76.tx_napi);
>
> @@ -82,7 +82,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
>         mt792x_wpdma_reset(dev, true);
>
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_enable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_enable(&dev->mt76, i);
>         }
>
>         local_bh_disable();
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/pci.c
> index c4161754c01d..1da650ac7f4d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -40,7 +40,7 @@ static void mt7925e_unregister_device(struct mt792x_dev=
 *dev)
>         cancel_work_sync(&dev->init_work);
>         mt76_unregister_device(&dev->mt76);
>         mt76_for_each_q_rx(&dev->mt76, i)
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         cancel_delayed_work_sync(&pm->ps_work);
>         cancel_work_sync(&pm->wake_work);
>         cancel_work_sync(&dev->reset_work);
> @@ -481,7 +481,7 @@ static int mt7925_pci_suspend(struct device *device)
>         mt76_worker_disable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_disable(&mdev->napi[i]);
> +               mt76_rx_napi_disable(mdev, i);
>         }
>
>         /* wait until dma is idle  */
> @@ -509,7 +509,7 @@ static int mt7925_pci_suspend(struct device *device)
>
>  restore_napi:
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> @@ -559,7 +559,7 @@ static int _mt7925_pci_resume(struct device *device, =
bool restore)
>         mt76_worker_enable(&mdev->tx_worker);
>
>         mt76_for_each_q_rx(mdev, i) {
> -               napi_enable(&mdev->napi[i]);
> +               mt76_rx_napi_enable(mdev, i);
>         }
>         napi_enable(&mdev->tx_napi);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/driver=
s/net/wireless/mediatek/mt76/mt7925/pci_mac.c
> index 3072850c2752..6bb47db8d16a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
> @@ -88,11 +88,11 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
>
>         mt76_worker_disable(&dev->mt76.tx_worker);
>         if (irq_map->rx.data_complete_mask)
> -               napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
> +               mt76_rx_napi_disable(&dev->mt76, MT_RXQ_MAIN);
>         if (irq_map->rx.wm_complete_mask)
> -               napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
> +               mt76_rx_napi_disable(&dev->mt76, MT_RXQ_MCU);
>         if (irq_map->rx.wm2_complete_mask)
> -               napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
> +               mt76_rx_napi_disable(&dev->mt76, MT_RXQ_MCU_WA);
>         if (irq_map->tx.all_complete_mask)
>                 napi_disable(&dev->mt76.tx_napi);
>
> @@ -102,7 +102,7 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
>         mt792x_wpdma_reset(dev, true);
>
>         mt76_for_each_q_rx(&dev->mt76, i) {
> -               napi_enable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_enable(&dev->mt76, i);
>         }
>         napi_enable(&dev->mt76.tx_napi);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index e2a83da3a09c..a75238ce8807 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -2262,7 +2262,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
>                         continue;
>
>                 if (mdev->q_rx[i].ndesc)
> -                       napi_disable(&dev->mt76.napi[i]);
> +                       mt76_rx_napi_disable(&dev->mt76, i);
>         }
>         napi_disable(&dev->mt76.tx_napi);
>
> @@ -2278,7 +2278,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
>                         continue;
>
>                 if (mdev->q_rx[i].ndesc) {
> -                       napi_enable(&dev->mt76.napi[i]);
> +                       mt76_rx_napi_enable(&dev->mt76, i);
>                         local_bh_disable();
>                         napi_schedule(&dev->mt76.napi[i]);
>                         local_bh_enable();
> @@ -2534,7 +2534,7 @@ void mt7996_mac_reset_work(struct work_struct *work=
)
>                 if (mt76_queue_is_npu_txfree(&dev->mt76.q_rx[i]))
>                         continue;
>
> -               napi_disable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_disable(&dev->mt76, i);
>         }
>         napi_disable(&dev->mt76.tx_napi);
>
> @@ -2596,7 +2596,7 @@ void mt7996_mac_reset_work(struct work_struct *work=
)
>                 if (mt76_queue_is_npu_txfree(&dev->mt76.q_rx[i]))
>                         continue;
>
> -               napi_enable(&dev->mt76.napi[i]);
> +               mt76_rx_napi_enable(&dev->mt76, i);
>                 local_bh_disable();
>                 napi_schedule(&dev->mt76.napi[i]);
>                 local_bh_enable();
> diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wirel=
ess/mediatek/mt76/npu.c
> index c4c7c0af6321..fb4ba5bdbf48 100644
> --- a/drivers/net/wireless/mediatek/mt76/npu.c
> +++ b/drivers/net/wireless/mediatek/mt76/npu.c
> @@ -291,8 +291,9 @@ int mt76_npu_rx_queue_init(struct mt76_dev *dev, stru=
ct mt76_queue *q)
>                 goto out;
>
>         netif_napi_add(dev->napi_dev, &dev->napi[qid], mt76_npu_rx_poll);
> +       q->napi_state =3D MT76_NAPI_ADDED;
>         mt76_npu_fill_rx_queue(dev, q);
> -       napi_enable(&dev->napi[qid]);
> +       mt76_rx_napi_enable(dev, qid);
>  out:
>         mutex_unlock(&dev->mutex);
>
> --
> 2.39.5
>
>

