Return-Path: <linux-wireless+bounces-33179-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBRbMyWos2kSZgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33179-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:01:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3627D85D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF1C30347B5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3812B94;
	Fri, 13 Mar 2026 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k7nnHI1H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73C186A
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381666; cv=none; b=nU8jaEB/7t0YmolEvOy07s3nhEA9FWdLYJXs77GElX1au0bl4/4PULFat0OQGLE6R+N/wUYPsk7zB3JgaQeDVAv6U/nIyrv7RpfrzgOlAxlE04wi7b4qgEqKvDRcUk3rWWeEBUZwaSUvruFl/bHkgENwQtcCzuTtj9YBqY5mxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381666; c=relaxed/simple;
	bh=buU59C7/levb3gzxb22x3mn2Vlq1vF6o4aoNPQIkNOQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WciRnK9o2komBzmFWirYwW/fO6FnPWqqxyUdvkWtq6hHCz0drDQxBD0ZiPN4F+ruzwHeIYl2em4sJHRIVQ0TAw5/1fIiPgSdg2VZvOnTMH1MucN943eE/L/3DfzW11x7+R4SC7naawqQgzR91XR/sC/Bvl4aQSdkRl92DD6OTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k7nnHI1H; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 020bc6dc1ea211f1a39cd589f645bc18-20260313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=osjqpkcUGH04w/bazaArwGn2fG6Xlho1hcQWsHgcK/E=;
	b=k7nnHI1H7N4d6YDuAFOOImkCIDNCZmQtA5JXQLSJvZFzW209TAavrB2zXsv6kKEZ/gn8rURUNoQ8EP+rFwe1Ov6rOndrp0Pa6gojH9CZj/FNwavtBg7kC3yC2fTl2wwLxjX8VVBcMQUVNvAcaCwRjD/zWXQWFYj81DnQZu+9D9Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2cacb360-c80f-45a8-9969-ceafdf4606b8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6963f6f9-dfaf-419f-9dd3-d093c7e8f968,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 020bc6dc1ea211f1a39cd589f645bc18-20260313
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1238963077; Fri, 13 Mar 2026 14:00:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 13 Mar 2026 14:00:58 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Fri, 13 Mar 2026 14:00:58 +0800
Message-ID: <35014cbb30533d7d73a25540b4b283ee67b87e39.camel@mediatek.com>
Subject: Re: [PATCH mt76 6/6] wifi: mt76: mt7996: fix issues with manually
 triggered radar detection
From: Shayne Chen <shayne.chen@mediatek.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, linux-wireless
	<linux-wireless@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn
 Tsai <evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Date: Fri, 13 Mar 2026 14:00:57 +0800
In-Reply-To: <abKbwL6jgtKtLFdD@lore-desk>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
	 <20260312095724.2117448-6-shayne.chen@mediatek.com>
	 <abKbwL6jgtKtLFdD@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MTK: N
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33179-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7D3627D85D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 11:56 +0100, Lorenzo Bianconi wrote:
> > From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> >=20
> > Disallow triggering radar detection on non-DFS channels to prevent
> > paused
> > TX queues from failing to resume, as a channel switch is not
> > performed in
> > this case.
>=20
> I guess we are missing a Fixes tag here.
>=20
> >=20
> > Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> > Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> > ---
> > =C2=A0.../wireless/mediatek/mt76/mt7996/debugfs.c=C2=A0=C2=A0 | 22
> > +++++++++++++++----
> > =C2=A01 file changed, 18 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
> > b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
> > index 76d623b2cafb..e26bed6b97e7 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
> > @@ -226,14 +226,23 @@ mt7996_radar_trigger(void *data, u64 val)
> > =C2=A0#define RADAR_BACKGROUND	2
> > =C2=A0	struct mt7996_dev *dev =3D data;
> > =C2=A0	struct mt7996_phy *phy =3D mt7996_band_phy(dev,
> > NL80211_BAND_5GHZ);
> > -	int rdd_idx;
> > +	struct cfg80211_chan_def *chandef;
> > +	int rdd_idx, ret;
> > =C2=A0
> > =C2=A0	if (!phy || !val || val > RADAR_BACKGROUND)
> > =C2=A0		return -EINVAL;
> > =C2=A0
> > -	if (val =3D=3D RADAR_BACKGROUND && !dev->rdd2_phy) {
> > -		dev_err(dev->mt76.dev, "Background radar is not
> > enabled\n");
> > -		return -EINVAL;
> > +	if (test_bit(MT76_SCANNING, &phy->mt76->state))
> > +		return -EBUSY;
> > +
> > +	if (val =3D=3D RADAR_BACKGROUND) {
> > +		if (!dev->rdd2_phy ||
> > !cfg80211_chandef_valid(&dev->rdd2_chandef)) {
> > +			dev_err(dev->mt76.dev, "Background radar
> > is not enabled\n");
>=20
> nit: I guess it is better to specify a different error message if
> rdd2_chandef
> is=C2=A0 invalid.
>=20
Will split the error message in v2.

Thanks,
Shayne

> Regards,
> Lorenzo
>=20
> > +			return -EINVAL;
> > +		}
> > +		chandef =3D &dev->rdd2_chandef;
> > +	} else {
> > +		chandef =3D &phy->mt76->chandef;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	rdd_idx =3D mt7996_get_rdd_idx(phy, val =3D=3D
> > RADAR_BACKGROUND);
> > @@ -242,6 +251,11 @@ mt7996_radar_trigger(void *data, u64 val)
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > =C2=A0
> > +	ret =3D cfg80211_chandef_dfs_required(dev->mt76.hw->wiphy,
> > chandef,
> > +					=C2=A0=C2=A0=C2=A0 NL80211_IFTYPE_AP);
> > +	if (ret <=3D 0)
> > +		return ret;
> > +
> > =C2=A0	return mt7996_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE, rdd_idx,
> > 0);
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.51.0
> >=20


