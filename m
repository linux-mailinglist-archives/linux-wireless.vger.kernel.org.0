Return-Path: <linux-wireless+bounces-14927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548009BD022
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7794B1C2175D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C81D6DB9;
	Tue,  5 Nov 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK3PN6Na"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C341D89F3
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819444; cv=none; b=aYfWB1oeQoQ6FHlYnwp4v16B3QKEwSFdlWzpEIEBTX3Z99aRBra4kxe/TCYJhOJ5ZlovY5zopmo5MR79qHXZxKgkoFUhj7GIsut9Tnupxylz0yfw7k3veZaXMSXCiohY+Hbf6vIBHjHFdDE8avInxf6j9tx9aO1nRGlXGsDNp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819444; c=relaxed/simple;
	bh=x9AVAxnLvoDRhBH9dz3b7y/uJdXHrk9+wSQJel0g/i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpMT9Bx+c6+CtHKfPYCb78yw3hzhDt65PKBF/ysy0cmQt6+gJLjo/Gyh9BJrhKspGla5RRxvoEkiCKxqe22zx9dMjL8ujtaGp+ShsS9AqQbaRFk0uNK9AfdpSi5j9wIPc68XQ9vpLBr1DCxKeArIn2RCS/FjkArb80NwiawPpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK3PN6Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E83C4CECF;
	Tue,  5 Nov 2024 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730819443;
	bh=x9AVAxnLvoDRhBH9dz3b7y/uJdXHrk9+wSQJel0g/i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fK3PN6Na0JaAH9k00pBF+zB5GS63VFqXvjrBmhOEhdkC8RwWZw/0JzmJQdAOdjCya
	 bV/xfbdMSa0vnjuBJ/CEH9Pimkmei6A64RpnXz0w0WHiYlhOl9HxfdPxJATO0sh/vI
	 dOWxiV5B+0qPz12gBqv99/NW2nMNuXOhn9hXJ+OC0btRAKA9vR2oMg6iFfk0i2GCQB
	 opOl9mLxMKM6yOI6vdZY36gHzWxz78jc7je7jCQ6ovdpW1cswGMzbvGCtu6Xnboa6t
	 aBcpOmlHbPBpral8nTbPf/xQ0IZTYV1SPpC5hGMuB8NwSrDdxltCJ2nBujvzSnm67v
	 sUeb9KUBnYuHg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 55913164C25B; Tue, 05 Nov 2024 16:10:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, Issam Hamdi
 <ih@simonwunderlich.de>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de,
 Simon Wunderlich <simon.wunderlich@open-mesh.com>, Sven Eckelmann
 <se@simonwunderlich.de>, Issam Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH 2/2] wifi: ath9k: Reset chip on potential deaf state
In-Reply-To: <6688984.G0QQBjFxQf@prime>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241104171627.3789199-2-ih@simonwunderlich.de> <87h68l96l4.fsf@toke.dk>
 <6688984.G0QQBjFxQf@prime>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Nov 2024 16:10:40 +0100
Message-ID: <874j4l90nj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Wunderlich <sw@simonwunderlich.de> writes:

> On Tuesday, November 5, 2024 2:02:31 PM CET Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> Issam Hamdi <ih@simonwunderlich.de> writes:
>> > From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
>> >=20
>> > The chip is switching seemingly random into a state which can be descr=
ibed
>> > as "deaf". No or nearly no interrupts are generated anymore for incomi=
ng
>> > packets. Existing links either break down after a while and new links =
will
>> > not be established.
>> >=20
>> > The driver doesn't know if there is no other device available or if it
>> > ended up in an "deaf" state. Resetting the chip proactively avoids
>> > permanent problems in case the chip really was in its "deaf" state but
>> > maybe causes unnecessary resets in case it wasn't "deaf".
>>=20
>> Proactively resetting the device if there is no traffic on the network
>> for four seconds seems like a tad aggressive. Do you have any
>> information on under which conditions this actually happens in practice?
>> I assume this is a patch that has been lying around in openwrt for a
>> while, or something?
>
> Hi Toke,
>
> this patch has been around for a long time (8 years or so?), and it has b=
een=20
> integrated in various vendor firmwares (at least three I know of) as well=
 as=20
> mesh community firmwares [1]. The circumstances leading to this "deafness=
" is=20
> still unclear, but we see that some particular chips (especially 2-stream=
 11n=20
> SoCs, but also others) can go 'deaf' when running AP or mesh (or both) af=
ter=20
> some time. It's probably a hardware issue, and doing a channel scan to tr=
igger=20
> a chip reset (which one normally can't do on an AP interface) recovers th=
e=20
> hardware. This patch provides a workaround within the kernel.
>
> We submitted it only as RFC back then [2], and since we had colleagues=20
> suffering the same problem again we though we give it another shot to fin=
ally=20
> get it integrated upstream. :)
>
> The idea is that if the radio is idle anyway, a quick reset (which takes =
a few=20
> tens of ms maximum) doesn't hurt much, and it helps to recover non-functi=
onal=20
> APs or mesh points.

Alright, thanks for the extra context (would have been nice if this was
part of the commit message in the initial submission ;)).

(including both your emails in one):

> Forgot to comment here: On the AR934x hardware we worked on in the very=20
> beginning, we actually still had a few interrupts coming even if the hard=
ware=20
> was 'deaf'. This why we did not implement it with a timer, but counted th=
e=20
> number of interrupts for a given time and compared it to a minimum expect=
ed=20
> ratio, as done in this patch.
>
> I understand your argument for the TX part, but I think it actually break=
s the=20
> AP mode and prevents the recovery: if we can't hear any clients, they wil=
l not=20
> use the Internet and the AP has not much to TX either. So an already deaf=
 AP=20
> has nothing to transmit just as an idle AP, but for a different reason ...

Right, okay. I guess that is also why you prefer this one to Felix'
similar patch that was also linked from that gluon issue[0]?

However, I still don't like tying this to the debugfs: if this is
something that the driver needs to react to, it should not depend on
debug features. Even if OpenWrt and derivatives always compile-in the
debugfs, not everyone does, as we discovered back when we accidentally
broke the driver when it wasn't there :)

So how about something like the patch below - it keeps the "average per
time interval" behaviour, but uses the same approach as Felix' patch to
avoid relying on debugfs. WDYT?

-Toke


[0] https://github.com/freifunk-gluon/gluon/commit/fa0740cca4683f90bbf05157=
fd80109d2c40aa84



diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/=
ath/ath9k/ath9k.h
index 29ca65a732a6..bcfc8df0efe5 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1018,6 +1018,8 @@ struct ath_softc {
=20
 	u8 gtt_cnt;
 	u32 intrstatus;
+	u32 rx_active_check_time;
+	u32 rx_active_count;
 	u16 ps_flags; /* PS_* */
 	bool ps_enabled;
 	bool ps_idle;
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/=
ath/ath9k/debug.c
index 51abc470125b..a1e3bcf796f2 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -750,6 +750,7 @@ static int read_file_reset(struct seq_file *file, void =
*data)
 		[RESET_TYPE_CALIBRATION] =3D "Calibration error",
 		[RESET_TX_DMA_ERROR] =3D "Tx DMA stop error",
 		[RESET_RX_DMA_ERROR] =3D "Rx DMA stop error",
+		[RESET_TYPE_RX_INACTIVE] =3D "Rx path inactive",
 	};
 	int i;
=20
diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/=
ath/ath9k/debug.h
index 389459c04d14..cb3e75969875 100644
--- a/drivers/net/wireless/ath/ath9k/debug.h
+++ b/drivers/net/wireless/ath/ath9k/debug.h
@@ -53,6 +53,7 @@ enum ath_reset_type {
 	RESET_TYPE_CALIBRATION,
 	RESET_TX_DMA_ERROR,
 	RESET_RX_DMA_ERROR,
+	RESET_TYPE_RX_INACTIVE,
 	__RESET_TYPE_MAX
 };
=20
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/a=
th/ath9k/link.c
index d1e5767aab3c..054c0781287e 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -50,7 +50,36 @@ static bool ath_tx_complete_check(struct ath_softc *sc)
 		"tx hung, resetting the chip\n");
 	ath9k_queue_reset(sc, RESET_TYPE_TX_HANG);
 	return false;
+}
+
+#define RX_INACTIVE_CHECK_INTERVAL (4 * MSEC_PER_SEC)
+
+static bool ath_hw_rx_inactive_check(struct ath_softc *sc)
+{
+	struct ath_common *common =3D ath9k_hw_common(sc->sc_ah);
+	u32 interval, count;
+
+	interval =3D jiffies_to_msecs(jiffies - sc->rx_active_check_time);
+	count =3D sc->rx_active_count;
+
+	if (interval < RX_INACTIVE_CHECK_INTERVAL)
+		return true; /* too soon to check */
=20
+	sc->rx_active_count =3D 0;
+	sc->rx_active_check_time =3D jiffies;
+
+	/* Need at least one interrupt per second, and we should only react if
+	 * we are within a factor two of the expected interval
+	 */
+	if (interval > RX_INACTIVE_CHECK_INTERVAL * 2 ||
+	    count >=3D interval / MSEC_PER_SEC)
+		return true;
+
+	ath_dbg(common, RESET,
+		"RX inactivity is detected. Schedule chip reset\n");
+	ath9k_queue_reset(sc, RESET_TYPE_RX_INACTIVE);
+
+	return false;
 }
=20
 void ath_hw_check_work(struct work_struct *work)
@@ -58,8 +87,8 @@ void ath_hw_check_work(struct work_struct *work)
 	struct ath_softc *sc =3D container_of(work, struct ath_softc,
 					    hw_check_work.work);
=20
-	if (!ath_hw_check(sc) ||
-	    !ath_tx_complete_check(sc))
+	if (!ath_hw_check(sc) || !ath_tx_complete_check(sc) ||
+	    !ath_hw_rx_inactive_check(sc))
 		return;
=20
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/a=
th/ath9k/main.c
index b92c89dad8de..998f717a1a86 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -453,6 +453,7 @@ void ath9k_tasklet(struct tasklet_struct *t)
 			ath_rx_tasklet(sc, 0, true);
=20
 		ath_rx_tasklet(sc, 0, false);
+		sc->rx_active_count++;
 	}
=20
 	if (status & ATH9K_INT_TX) {

