Return-Path: <linux-wireless+bounces-2455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107183B15F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 19:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3851628C10B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40A12A166;
	Wed, 24 Jan 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="qoGd7ypk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3308002E
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121930; cv=none; b=WbgUriapj/emmSNngITdJy3F2L8jtfGLxBfK33oa1r7NquHeS2Gw8W9u/6rj+ykf5KUNcuPAKOgsbVCm9RIM5g4CMz0W9f7hvDMnKKizhceEcv8m9Osx8m2D5MRaeWVwUMaAOws/375cBpUUruTh/T1VfbVMOam3CsEsVlXcuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121930; c=relaxed/simple;
	bh=9x6wU+tfXBcrFsfSdCCh+fbQAkExaYXczq0YYw2pNjQ=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=tl/HF5mpCgaCkbPak0u9MYx6SASdnvuOBIMmmIAnX2mYtrurHS1R7EWAefWIJ77Hu4M8uybx9/m6zzxiHn1EwAE0Cwjh4v8isp01bRxusiGHZx/grJdFVK5HqGVdefUPsb0DSSJDiWtowzyFBCueXJFtxdERE6pTHOAsts4zRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=qoGd7ypk; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=aF7m+tfN8g6RPuUFvmo9ESlJtzfvEk5zFKsA/qbgRZw=;
	b=qoGd7ypkHJf/7DAMeOHCRxh+XBn+bqjdg7mzRRzJ84aCAXNbF9q1iLT+d5gk7niGMGRQ
	SJUaOMIeky8XGB8D/TdRxNaxsj8dXpPh95BpsYNE8iRptJNk1JKZ45+GwlUqkSy5gSGm/y
	cO/JwyVc2vNSGkTOQaVJ1/4grat0zz5TPmTxS1Wwj96PnxZ7LwPUfwsGxauIyA3mHXD2bz
	oIsYBOUj5qvYHSY3Tg0Qr9fCjPpR+JvD9tT1AP9wI3Pj6M2Ln889UgYM3nj/jutyvDpNB5
	mypoN4J0lXdRcFr/tHPve8X+kipjlmhFAZWqJ9bMfQqb0blufj4GQFp+fYhbC+eA==
Received: by filterdrecv-655bd866f5-c4wvc with SMTP id filterdrecv-655bd866f5-c4wvc-1-65B15AC7-1C
        2024-01-24 18:45:27.297262808 +0000 UTC m=+1142910.120992772
Received: from bixby.lan (unknown)
	by geopod-ismtpd-22 (SG) with ESMTP
	id qGP6ZeFcRquDUoeQsFIIaQ
	Wed, 24 Jan 2024 18:45:27.065 +0000 (UTC)
Message-ID: <eb20373c68936f032c322174fbbd3353167d898a.camel@egauge.net>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
Date: Wed, 24 Jan 2024 18:45:27 +0000 (UTC)
In-Reply-To: <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
References: <20240122211315.1444880-2-davidm@egauge.net>
	 <20240122220350.1449413-1-davidm@egauge.net>
	 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
	 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
	 <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
	 <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvBy1k6LyRUfRc5Hz3?=
 =?us-ascii?Q?huu0NoXvSB7ZLpzJ6h6QMhvr0cdt9aabmxQSzJi?=
 =?us-ascii?Q?4Uxj+K6ST+BMMtNC0Z4ZKuFm2bkqj1a84D+=2FLDw?=
 =?us-ascii?Q?cHgw+uoeC+PgQflnKVxlnMxiBG=2FJO52aXCeoIH0?=
 =?us-ascii?Q?HsoHu+nzcv3XVQUTiaaQ9QzZYX6oJEUl1vWsFlz?=
 =?us-ascii?Q?vUzXI1dFm7Ja28RGDJZOw=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Wed, 2024-01-24 at 10:31 -0700, David Mosberger-Tang wrote:
> Alexis,
>=20
> On Wed, 2024-01-24 at 10:01 +0100, Alexis Lothor=E9 wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x294/0x2c0
> > Read of size 4 at addr c3c91ce8 by task swapper/1
>=20
> OK, I think I see what's going on: it's the list traversal.  Here is what
> wilc_netdev_cleanup() does:
>=20
> 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
> 		if (vif->ndev)
> 			unregister_netdev(vif->ndev);
> 	}
>=20
> The problem is that "vif" is the private part of the netdev, so when the =
netdev
> is freed, the vif structure is no longer valid and list_for_each_entry_rc=
u()
> ends up dereferencing a dangling pointer.
>=20
> Ajay or Alexis, could you propose a fix for this - this is not something =
I'm
> familiar with.

Actually, after staring at the code a little longer, is there anything wron=
g
with delaying the unregister_netdev() call until after the vif has been rem=
oved
from the vif-list?  Something along the lines of the below.

  --david

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c
b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 0bf6aef4661e..e78e7d971243 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -884,7 +884,7 @@ static const struct net_device_ops wilc_netdev_ops =3D =
{
 void wilc_netdev_cleanup(struct wilc *wilc)
 {
 	struct wilc_vif *vif;
-	int srcu_idx, ifc_cnt =3D 0;
+	int ifc_cnt =3D 0;
=20
 	if (!wilc)
 		return;
@@ -894,13 +894,6 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 		wilc->firmware =3D NULL;
 	}
=20
-	srcu_idx =3D srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
-		if (vif->ndev)
-			unregister_netdev(vif->ndev);
-	}
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
-
 	wilc_wfi_deinit_mon_interface(wilc, false);
 	destroy_workqueue(wilc->hif_workqueue);
=20
@@ -918,6 +911,10 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 		mutex_unlock(&wilc->vif_mutex);
 		synchronize_srcu(&wilc->srcu);
 		ifc_cnt++;
+
+		if (vif->ndev)
+			/* vif gets freed as part of this call: */
+			unregister_netdev(vif->ndev);
 	}
=20
 	wilc_wlan_cfg_deinit(wilc);


