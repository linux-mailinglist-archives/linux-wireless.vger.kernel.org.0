Return-Path: <linux-wireless+bounces-27950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF3BD1C3A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 09:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3509C188B953
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608D296BA8;
	Mon, 13 Oct 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZMG2wFnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6422566
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340150; cv=none; b=um9a1pj+9PaeKsRLRlQ1dcUmJYiFtnQFCG9MzxiOKRSFwatH4OZSe9D/I/wINp0+ffiH9VckeMf25pAEiansmaMnL1RzT05+QANnMHoc5/BSrXC6O+HcJruOMJmdPtK84zYiFk1MQi76UwfsKwiduEM72g/4AofP/Wc1HXK02PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340150; c=relaxed/simple;
	bh=DRSpRPtCIIUBosMgZWGGwoJpoSmP9YJhULBkriOGD3s=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XeCcWV8kvy5mCKVJq2JTxvt1/zlQlLIy/Ok5S6B6u78xI2ch3cJ+VR4sLvQrWD/fRLgJuKFa5H7dLUOFa3mqT3Jz5eLrqQm4rti4Aq1HixnVx+2Hp1tY2UZPMyaZgZBtuhYUNGs4WxKg7d62fWHJ8X8zqCmV/mjqhd8fUWunMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZMG2wFnj; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5caa11d4a80511f08d9e1119e76e3a28-20251013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5gyGQbFgGySlpOxkXZfouvvJMVOftDYVGktZ7Zrkifo=;
	b=ZMG2wFnjNhNcIEuHAcS/AjTeLUKz+64H8uEaAterLWqKQTzDNvXQMx8oWx/wh+5L0NPq36CFXaiedt0AovM5CdjagvNa1XlmFDJuWOCjSs9JF4g9WbVFRJUjGwi2EHwwmigM1Knx0bIY81k7KbkPi4H2DvUdj0JjqT2nRWm5l+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a42142da-524a-430d-8c52-4f5d33c44fd8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:39445202-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5caa11d4a80511f08d9e1119e76e3a28-20251013
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 602108610; Mon, 13 Oct 2025 15:22:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Oct 2025 15:22:20 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Oct 2025 15:22:20 +0800
Message-ID: <140420b094604272719a4c414d8487a6ed545b5f.camel@mediatek.com>
Subject: Re: [PATCH wireless-next 03/15] wifi: mac80211: verify state before
 connection
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	<linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Allen <Allen.Ye@mediatek.com>,
	Money <Money.Wang@mediatek.com>, Evelyn <evelyn.tsai@mediatek.com>
Date: Mon, 13 Oct 2025 15:22:21 +0800
In-Reply-To: <20250609213231.f616c7b693df.Ie983155627ad0d2e7c19c30ce642915246d0ed9d@changeid>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
	 <20250609213231.f616c7b693df.Ie983155627ad0d2e7c19c30ce642915246d0ed9d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

We found a potential issue in this patch. Could you help confirm
whether this is expected behavior or an actual problem?
Please check the inline.

On Mon, 2025-06-09 at 21:35 +0300, Miri Korenblit wrote:
> ieee80211_prep_connection is supposed to be called when both bitmaps
> (valid_links and active_links) are cleared.
> Make sure of it and WARN if this is not the case, to avoid weird
> issues.
>=20
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> ---
> =C2=A0net/mac80211/mlme.c | 22 ++++++++++++++--------
> =C2=A01 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index d8953a855ab4..c8bf810ff5d8 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -8694,21 +8694,33 @@ static int ieee80211_prep_connection(struct
> ieee80211_sub_if_data *sdata,
> =C2=A0	bool have_sta =3D false;
> =C2=A0	bool mlo;
> =C2=A0	int err;
> +	u16 new_links;
> =C2=A0
> =C2=A0	if (link_id >=3D 0) {
> =C2=A0		mlo =3D true;
> =C2=A0		if (WARN_ON(!ap_mld_addr))
> =C2=A0			return -EINVAL;
> -		err =3D ieee80211_vif_set_links(sdata, BIT(link_id),
> 0);
> +		new_links =3D BIT(link_id);
> =C2=A0	} else {
> =C2=A0		if (WARN_ON(ap_mld_addr))
> =C2=A0			return -EINVAL;
> =C2=A0		ap_mld_addr =3D cbss->bssid;
> -		err =3D ieee80211_vif_set_links(sdata, 0, 0);
> +		new_links =3D 0;
> =C2=A0		link_id =3D 0;
> =C2=A0		mlo =3D false;
> =C2=A0	}
> =C2=A0
> +	if (assoc) {
> +		rcu_read_lock();
> +		have_sta =3D sta_info_get(sdata, ap_mld_addr);
> +		rcu_read_unlock();
> +	}
> +
> +	if (mlo && !have_sta &&
> +	=C2=A0=C2=A0=C2=A0 WARN_ON(sdata->vif.valid_links || sdata-
> >vif.active_links))
> +		return -EINVAL;

If the STA is performing a re-association, this if clause will evaluate
to true, resulting in a failure return and causing the re-association
to fail.
=20
Based on our analysis, the reason is that before calling
ieee80211_prep_connection(), ieee80211_mgd_assoc() first calls
ieee80211_set_disassoc() to clear the AP's sta_info, which results in
the "have_sta" being false in ieee80211_prep_connection().
Since req->ap_mld_addr is true, at least one link will be set, so
sdata->vif.valid_links is not zero.
As a result, the if-condition in ieee80211_prep_connection() will be
met, causing the re-association to fail.
=20
Have you encountered this issue before? Is this behavior expected?
=20
Additionally, could you please share what kind of issues this patch is
intended to address?

> +
> +	err =3D ieee80211_vif_set_links(sdata, new_links, 0);
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0
> @@ -8729,12 +8741,6 @@ static int ieee80211_prep_connection(struct
> ieee80211_sub_if_data *sdata,
> =C2=A0		goto out_err;
> =C2=A0	}
> =C2=A0
> -	if (assoc) {
> -		rcu_read_lock();
> -		have_sta =3D sta_info_get(sdata, ap_mld_addr);
> -		rcu_read_unlock();
> -	}
> -
> =C2=A0	if (!have_sta) {
> =C2=A0		if (mlo)
> =C2=A0			new_sta =3D sta_info_alloc_with_link(sdata,
> ap_mld_addr,


Best,
Michael

