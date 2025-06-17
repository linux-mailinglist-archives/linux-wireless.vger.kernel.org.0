Return-Path: <linux-wireless+bounces-24164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D1ADBE7A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533903B9897
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 01:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6381198A2F;
	Tue, 17 Jun 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aJ6ClQAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402E85260;
	Tue, 17 Jun 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122755; cv=none; b=fKIiFlfITO1o7TMp3usfd406+cuixLaLmikb79w6jICaPgMWxuf13i1u+jiwWMo4iZoud8ZTWrvTz/ANNOhPfuEtorKbgJU9c2aL2lwa8XsQagClxXkez/J0EsFN8GAtTcxd26wl/RfvbtICc9g1G+zxDiVvkFxIa6g3++fM0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122755; c=relaxed/simple;
	bh=oefOgSc1Z039uTfN1C6ysnyJt0su6eLbpzjAuLMfzVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QR1CelPGdS7AT+NCauzoUmgWDf7fV+PXeTMEZ82RtSVZkB9wIR2AyTfcWMtL/Vy+9w+rZbfrDdYWgG+uEq3yTe9XK3F1z1OcBLm8qk0J+y5DineiJQCnkLoh88A8gMnvHjZtWZvdeITuRYFqt32sK3KLs5jVBhDRjLAajWYQkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aJ6ClQAX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55H1B4pG41349268, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750122664; bh=7ZvcDqtfgtaeywsuOoqwrM09yTIb0YVKK5xMuDws+d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aJ6ClQAXiSoZTR1EBEIhWlrvTXa50CDvs7LRaUZxYrpclb72k50bmdNFqLxNtcsyi
	 bPGM0EKXRKPB97V9hx5spjYaKxeoCQzyB8Y2Dfp3+hpdeDdSK07n6p8vqn1fCFH8AS
	 f62ppZPmAlOj6t4dVL1Gz5H7YJeLVcdvuNTjowjeLSHWueGrx67VPMfADCto241Xz6
	 EdDJDbZ0C84UAU8v0oefQpdeuYXjo3JGhDjelby0DeMU9OkyoE5H44LbMh+vIkwI8s
	 XTTryJR/67vATFJCFSmKXcn38BLiVFMFADlp0lSu4+nlillJ5ltL4FVuaivQKLN3YY
	 8hHLzXVzvyuFA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55H1B4pG41349268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 09:11:04 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 09:11:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 17 Jun 2025 09:11:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 17 Jun 2025 09:11:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Daniil Dulov <d.dulov@aladdin.ru>, Hin-Tak Leung <hintak.leung@gmail.com>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        "John W. Linville"
	<linville@tuxdriver.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH 1/2] rtl818x: Fix potential data race in rtl8187_tx_cb()
Thread-Topic: [PATCH 1/2] rtl818x: Fix potential data race in rtl8187_tx_cb()
Thread-Index: AQHb3qk786dJTgtSZESHoKjQfcrgl7QGghzQ
Date: Tue, 17 Jun 2025 01:11:09 +0000
Message-ID: <a139c0c192ff4f1fbc14dafc37c54bab@realtek.com>
References: <20250616101050.6911-1-d.dulov@aladdin.ru>
 <20250616101050.6911-2-d.dulov@aladdin.ru>
In-Reply-To: <20250616101050.6911-2-d.dulov@aladdin.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Daniil Dulov <d.dulov@aladdin.ru> wrote:
> There is a potential data race between rtl8187_tx_cb() and rtl8187_stop()=
.
> It is possible for rtl8187_stop() to clear the queue right after rtl8187_=
tx_cb()
> checks that queue has more than 5 elements, but before it dequeues any sk=
b.
> This results in skb_dequeue() returns NULL and the pointer is dereference=
d
> in ieee80211_tx_status_irqsafe().

Is there a way to flush rtl8187_tx_cb() before rtl8187_stop() clear queue?
It looks risky that rtl8187_tx_cb() can still be running after rtl8187_stop=
().
Maybe you only treat this patch as a workaround?

>=20
>  BUG: kernel NULL pointer dereference, address: 0000000000000080
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.15.0 #8 PREEMPT(volun=
tary)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/=
2015
>  RIP: 0010:ieee80211_tx_status_irqsafe+0x21/0xc0 [mac80211]
>  Call Trace:
>   <IRQ>
>   rtl8187_tx_cb+0x116/0x150 [rtl8187]
>   __usb_hcd_giveback_urb+0x9d/0x120
>   usb_giveback_urb_bh+0xbb/0x140
>   process_one_work+0x19b/0x3c0
>   bh_worker+0x1a7/0x210
>   tasklet_action+0x10/0x30
>   handle_softirqs+0xf0/0x340
>   __irq_exit_rcu+0xcd/0xf0
>   common_interrupt+0x85/0xa0
>   </IRQ>
>=20
> In order to avoid potential data races and leading dereference of a NULL
> pointer, acquire the queue lock before any work with the queue is done an=
d
> replace all skb_* calls with their lockless versions.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Do you have a real hardware and tested this patchset? If not, please mentio=
n
compile tested only in commit message.=20

>=20
> Fixes: 3517afdefc3a ("rtl8187: feedback transmitted packets using tx clos=
e descriptor for 8187B")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  .../net/wireless/realtek/rtl818x/rtl8187/dev.c    | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> index 220ac5bdf279..8fe6fdc32e56 100644
> --- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> +++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> @@ -189,6 +189,7 @@ static void rtl8187_tx_cb(struct urb *urb)
>         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>         struct ieee80211_hw *hw =3D info->rate_driver_data[0];
>         struct rtl8187_priv *priv =3D hw->priv;
> +       unsigned long flags;
>=20
>         skb_pull(skb, priv->is_rtl8187b ? sizeof(struct rtl8187b_tx_hdr) =
:
>                                           sizeof(struct rtl8187_tx_hdr));
> @@ -196,7 +197,8 @@ static void rtl8187_tx_cb(struct urb *urb)
>=20
>         if (!(urb->status) && !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
>                 if (priv->is_rtl8187b) {
> -                       skb_queue_tail(&priv->b_tx_status.queue, skb);
> +                       spin_lock_irqsave(&priv->b_tx_status.queue.lock, =
flags);
> +                       __skb_queue_tail(&priv->b_tx_status.queue, skb);
>=20
>                         /* queue is "full", discard last items */
>                         while (skb_queue_len(&priv->b_tx_status.queue) > =
5) {
> @@ -205,9 +207,11 @@ static void rtl8187_tx_cb(struct urb *urb)
>                                 dev_dbg(&priv->udev->dev,
>                                         "transmit status queue full\n");
>=20
> -                               old_skb =3D skb_dequeue(&priv->b_tx_statu=
s.queue);

Another simple way could be just to check if old_skb is NULL here.

    if (!old_skb)
       break;

No need to adjust spin_lock.

> +                               old_skb =3D __skb_dequeue(&priv->b_tx_sta=
tus.queue);
>                                 ieee80211_tx_status_irqsafe(hw, old_skb);
>                         }
> +
> +                       spin_unlock_irqrestore(&priv->b_tx_status.queue.l=
ock, flags);
>                         return;
>                 } else {
>                         info->flags |=3D IEEE80211_TX_STAT_ACK;
> @@ -893,6 +897,7 @@ static void rtl8187_work(struct work_struct *work)
>                                     work.work);
>         struct ieee80211_tx_info *info;
>         struct ieee80211_hw *dev =3D priv->dev;
> +       unsigned long flags;
>         static u16 retry;
>         u16 tmp;
>         u16 avg_retry;
> @@ -900,6 +905,8 @@ static void rtl8187_work(struct work_struct *work)
>=20
>         mutex_lock(&priv->conf_mutex);
>         tmp =3D rtl818x_ioread16(priv, (__le16 *)0xFFFA);
> +
> +       spin_lock_irqsave(&priv->b_tx_status.queue.lock, flags);
>         length =3D skb_queue_len(&priv->b_tx_status.queue);
>         if (unlikely(!length))
>                 length =3D 1;
> @@ -909,13 +916,15 @@ static void rtl8187_work(struct work_struct *work)
>         while (skb_queue_len(&priv->b_tx_status.queue) > 0) {
>                 struct sk_buff *old_skb;
>=20
> -               old_skb =3D skb_dequeue(&priv->b_tx_status.queue);
> +               old_skb =3D __skb_dequeue(&priv->b_tx_status.queue);

And here as well.=20

    if (!old_skb)
       break;

>                 info =3D IEEE80211_SKB_CB(old_skb);
>                 info->status.rates[0].count =3D avg_retry + 1;
>                 if (info->status.rates[0].count > RETRY_COUNT)
>                         info->flags &=3D ~IEEE80211_TX_STAT_ACK;
>                 ieee80211_tx_status_irqsafe(dev, old_skb);
>         }
> +       spin_unlock_irqrestore(&priv->b_tx_status.queue.lock, flags);
> +
>         retry =3D tmp;
>         mutex_unlock(&priv->conf_mutex);
>  }
> --
> 2.34.1
>=20


