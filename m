Return-Path: <linux-wireless+bounces-38814-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S3bhLtNcT2rhfAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38814-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:33:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5F72E547
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IvkAtBX7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38814-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38814-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98D13065BD8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC53ED5BB;
	Thu,  9 Jul 2026 08:27:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0B3D6689
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 08:27:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585629; cv=none; b=esJV+A/GDpCDLLNlZ3d5Xfjlkn8jZcPoRCQhlVb9b94mUYKIUrQ1EryxLqfJvbacMXEGLMeflmK4z38qWN6m3sTxfjoSy7V9L8+sNAewBze0/br4wPYYYJqoUTwJM/wycgM5NMKWxw9Y/+N8getNpa6R6otr3kZ3fH46XPIR2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585629; c=relaxed/simple;
	bh=Ozcxg74paKGMYcmWOUg/klUpkUoRpIHONFv46s6QhcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt2VYuijJmbcE4t+Qt6vRc/LQEOxmq9mcFSSkqtTBUrveTPZ4+ENQ88tOdSayjuX8XfMC2hN5LHzIKnSfKJQvJX4zwyKhArjG9UIZqKKwW9JWZeFmCtbXy1prT50f+BITtiwVMPbeaEI7mJenP63O//+awWj/xFZqqSDLLSPwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvkAtBX7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D256B1F000E9;
	Thu,  9 Jul 2026 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585627;
	bh=JRpID3pW1TqSrvHKSgiFpdcZfSecXRzm+wG78gJziLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IvkAtBX7SfrMLePylDJ0qaNdoQLaCvlnLEFbpGGRWpEVXfBqK8vWmUQ0ITuNwOjwb
	 nJBnuSutwDqCl4jwtC7jgG6s1Vd6srSmKMDnfod7+5tzcVStEsEHIROjtJ0US7MBJt
	 gjXYBJRoeyXb1oVh0AbmYpSTPnl/hQBRZ8Zs34lLthmaiBij8Otr8l7CQEVGlolPtF
	 2RArn2QZ8nbHDc4UWAlNh0JWU6RZPc0bJdBYFCSUHIy5NtqUuVAARIysA+snuEexHn
	 74IPe6mr6A2q1f7GtLBE7U0JjJndl/LpgFA0/z1JYyP26wfXG5YSxnmKUVP8BOPOnb
	 5mNc4lzUZppRQ==
Date: Thu, 9 Jul 2026 10:27:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Eason Lai <eason.lai@mediatek.com>
Cc: nbd@nbd.name, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Yf.Luo@mediatek.com,
	kun.wu@mediatek.com, deren.wu@mediatek.com, sean.wang@mediatek.com,
	quan.zhou@mediatek.com, ryder.lee@mediatek.com,
	leon.yen@mediatek.com, litien.chang@mediatek.com,
	jb.tsai@mediatek.com
Subject: Re: [PATCH 2/3] wifi: mt76: mt792x: Add TX page pool support for
 IOMMU-enabled systems
Message-ID: <ak9bWO47T3fo2NkI@lore-desk>
References: <20260709075558.1654164-1-eason.lai@mediatek.com>
 <20260709075558.1654164-3-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="04mVdsiyjwcC3eL5"
Content-Disposition: inline
In-Reply-To: <20260709075558.1654164-3-eason.lai@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:eason.lai@mediatek.com,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38814-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email,vger.kernel.org:from_smtp,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00D5F72E547

--04mVdsiyjwcC3eL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 09, Eason Lai wrote:
> From: Eason Lai <Eason.Lai@mediatek.com>
>=20
> Add support for TX page pool allocation in mt792x devices when IOMMU is
> enabled. This optimization reduces DMA mapping overhead by
> pre-allocating and reusing page pool buffers for TX operations.

Can you please provide some test results here? In particular regarding the
resulting throughput.

>=20
> Key changes:
> - Export DMA helper functions and ops for mt792x usage
>   - Add tx_prealloc_enabled flag to track page pool state
>     - Implement mt792x-specific DMA queue operations with TX page pool
>       - Create page pools per TX queue when IOMMU is detected
>         - Handle page pool buffer cleanup in both success and error
>           paths
> - Add proper skip_unmap flag handling for page pool buffers
>=20
> The page pool path is used for linear skbs without fragments, falling
> back to standard DMA mapping for complex skb structures.
>=20
> Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
> ---

[...]

> =20
> -static void
> +void
>  mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
>  {
>  	wmb();
> @@ -409,6 +417,7 @@ mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76=
_queue *q)
>  	else
>  		Q_WRITE(q, cpu_idx, q->head);
>  }
> +EXPORT_SYMBOL_GPL(mt76_dma_kick_queue);

this is already available in mt76_queue_ops struct.

> =20
>  static void
>  mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flu=
sh)
> @@ -1152,7 +1161,7 @@ mt76_dma_init(struct mt76_dev *dev,
>  	return 0;
>  }
> =20
> -static const struct mt76_queue_ops mt76_dma_ops =3D {
> +const struct mt76_queue_ops mt76_dma_ops =3D {
>  	.init =3D mt76_dma_init,
>  	.alloc =3D mt76_dma_alloc_queue,
>  	.reset_q =3D mt76_dma_queue_reset,
> @@ -1164,6 +1173,7 @@ static const struct mt76_queue_ops mt76_dma_ops =3D=
 {
>  	.rx_reset =3D mt76_dma_rx_reset,
>  	.kick =3D mt76_dma_kick_queue,
>  };
> +EXPORT_SYMBOL_GPL(mt76_dma_ops);
> =20
>  void mt76_dma_attach(struct mt76_dev *dev)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 927c21536f4e..25e24fa36eca 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -957,6 +957,8 @@ struct mt76_dev {
>  	int tx_dma_idx[4];
>  	enum mt76_hwrro_mode hwrro_mode;
> =20
> +	bool tx_prealloc_enabled;
> +
>  	struct mt76_worker tx_worker;
>  	struct napi_struct tx_napi;
> =20
> @@ -1785,7 +1787,16 @@ mt76_tx_status_get_hw(struct mt76_dev *dev, struct=
 sk_buff *skb)
> =20
>  void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
>  void mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
> +struct mt76_txwi_cache *mt76_get_txwi(struct mt76_dev *dev);
>  struct mt76_txwi_cache *mt76_get_rxwi(struct mt76_dev *dev);
> +int mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
> +		     struct mt76_queue_buf *buf, int nbufs, u32 info,
> +		     struct sk_buff *skb, void *txwi);
> +void mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q,=
 int idx,
> +			     struct mt76_queue_entry *prev_e);
> +void mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q);
> +void mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q);
> +extern const struct mt76_queue_ops mt76_dma_ops;
>  void mt76_free_pending_rxwi(struct mt76_dev *dev);
>  void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
>  		      struct napi_struct *napi);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index 0339e2e7ab60..d4b36b0832b8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -250,6 +250,12 @@ void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
>  {
>  	struct mt76_connac_txp_common *txp;
> =20
> +	if (t->page_pool_buf) {
> +		mt76_put_page_pool_buf(t->page_pool_buf, false);
> +		t->page_pool_buf =3D NULL;
> +		return;
> +	}
> +
>  	txp =3D mt76_connac_txwi_to_txp(dev, t);
>  	if (is_mt76_fw_txp(dev))
>  		mt76_connac_txp_skb_unmap_fw(dev, &txp->fw);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/pci.c
> index c4161754c01d..3d69d8c67dea 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -214,7 +214,7 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
>  {
>  	int ret;
> =20
> -	mt76_dma_attach(&dev->mt76);
> +	mt792x_dma_attach(&dev->mt76);
> =20
>  	ret =3D mt792x_dma_disable(dev, true);
>  	if (ret)
> @@ -263,6 +263,8 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
>  			  mt792x_poll_tx);
>  	napi_enable(&dev->mt76.tx_napi);
> =20
> +	mt792x_dma_tx_page_pool_init(dev);
> +
>  	return mt792x_dma_enable(dev);
>  }
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wi=
reless/mediatek/mt76/mt792x.h
> index 4ff93f2cd624..7ac0318dc249 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
> @@ -418,8 +418,10 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
>  			   struct station_info *sinfo);
>  void mt792x_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
>  			       s16 coverage_class);
> +void mt792x_dma_attach(struct mt76_dev *dev);
>  void mt792x_dma_cleanup(struct mt792x_dev *dev);
>  int mt792x_dma_enable(struct mt792x_dev *dev);
> +int mt792x_dma_tx_page_pool_init(struct mt792x_dev *dev);
>  int mt792x_wpdma_reset(struct mt792x_dev *dev, bool force);
>  int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev);
>  int mt792x_dma_disable(struct mt792x_dev *dev, bool force);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt792x_dma.c
> index 002aece857b2..b341f1cb3ce0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> @@ -3,6 +3,9 @@
> =20
>  #include <linux/module.h>
>  #include <linux/firmware.h>
> +#include <linux/iommu.h>
> +#include <net/page_pool/helpers.h>
> +#include <linux/of.h>
> =20
>  #include "mt792x.h"
>  #include "dma.h"
> @@ -266,6 +269,323 @@ int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(mt792x_wpdma_reinit_cond);
> =20
> +static int mt792x_create_tx_page_pool(struct mt76_dev *dev, struct mt76_=
queue *q)
> +{
> +	struct page_pool_params pp_params =3D {
> +		.order =3D 0,
> +		.flags =3D 0,
> +		.nid =3D NUMA_NO_NODE,
> +		.dev =3D dev->dma_dev,
> +	};
> +
> +	if (!q || !dev->tx_prealloc_enabled)
> +		return 0;
> +
> +	if (!mt76_is_mmio(dev))
> +		return 0;

do you really need this check? you already check it in
mt792x_dma_tx_page_pool_init().

> +
> +	pp_params.pool_size =3D 256;
> +	pp_params.flags |=3D PP_FLAG_DMA_MAP;
> +	pp_params.dma_dir =3D DMA_BIDIRECTIONAL;
> +	pp_params.max_len =3D PAGE_SIZE;
> +	pp_params.offset =3D 0;
> +
> +	q->page_pool =3D page_pool_create(&pp_params);
> +	if (IS_ERR(q->page_pool)) {
> +		int err =3D PTR_ERR(q->page_pool);
> +
> +		q->page_pool =3D NULL;
> +		dev_warn(dev->dev, "Failed to create TX page pool for queue %d (err=3D=
%d)\n",
> +			 q->hw_idx, err);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +int mt792x_dma_tx_page_pool_init(struct mt792x_dev *dev)
> +{
> +	struct mt76_dev *mdev =3D &dev->mt76;
> +	int i, ret, pool_count =3D 0;
> +
> +	if (!iommu_get_domain_for_dev(mdev->dma_dev))
> +		return 0;
> +
> +	if (!mt76_is_mmio(mdev))
> +		return 0;
> +
> +	mdev->tx_prealloc_enabled =3D true;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mdev->phy.q_tx); i++) {
> +		struct mt76_queue *q =3D mdev->phy.q_tx[i];
> +
> +		if (!q)
> +			continue;
> +
> +		ret =3D mt792x_create_tx_page_pool(mdev, q);
> +		if (ret)
> +			return ret;
> +
> +		if (q->page_pool)
> +			pool_count++;
> +	}
> +
> +	if (pool_count > 0)
> +		dev_info(mdev->dev,
> +			 "IOMMU enabled, created %d TX page pools\n", pool_count);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt792x_dma_tx_page_pool_init);
> +
> +static void mt792x_dma_tx_page_pool_cleanup(struct mt792x_dev *dev)
> +{
> +	struct mt76_dev *mdev =3D &dev->mt76;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mdev->phy.q_tx); i++) {
> +		struct mt76_queue *q =3D mdev->phy.q_tx[i];
> +
> +		if (!q || !q->page_pool)
> +			continue;
> +
> +		page_pool_destroy(q->page_pool);
> +		q->page_pool =3D NULL;
> +	}
> +
> +	mdev->tx_prealloc_enabled =3D false;
> +}
> +
> +static void *
> +mt792x_dma_tx_alloc_page_pool_buf(struct mt76_dev *dev, struct mt76_queu=
e *q,
> +				  struct sk_buff *skb, dma_addr_t *dma_addr,
> +				  int *buf_len)
> +{
> +	struct page *page;
> +	void *buf;
> +	int len;
> +	u32 offset;
> +
> +	if (!q->page_pool || !dev->tx_prealloc_enabled)
> +		return NULL;
> +
> +	len =3D skb_headlen(skb);
> +	if (len > PAGE_SIZE)
> +		return NULL;
> +
> +	buf =3D mt76_get_page_pool_buf(q, &offset, len);
> +	if (!buf)
> +		return NULL;
> +
> +	page =3D virt_to_head_page(buf);
> +	*dma_addr =3D page_pool_get_dma_addr(page) + offset;
> +	if (unlikely(!*dma_addr)) {
> +		dev_warn_ratelimited(dev->dev, "Page pool returned NULL DMA address\n"=
);
> +		mt76_put_page_pool_buf(buf, false);
> +		return NULL;
> +	}
> +
> +	*buf_len =3D len;
> +
> +	dma_sync_single_for_cpu(dev->dma_dev, *dma_addr, len, DMA_TO_DEVICE);
> +	skb_copy_from_linear_data(skb, buf, len);

I would like to see some results here since usually it is not a good idea to
copy all the packets (even if it is just the linear part).

> +	dma_sync_single_for_device(dev->dma_dev, *dma_addr, len, DMA_TO_DEVICE);
> +
> +	return buf;
> +}
> +
> +static int
> +mt792x_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
> +			enum mt76_txq_id qid, struct sk_buff *skb,
> +			struct mt76_wcid *wcid, struct ieee80211_sta *sta)
> +{
> +	struct ieee80211_tx_status status =3D {
> +		.sta =3D sta,
> +	};
> +	struct mt76_tx_info tx_info =3D {
> +		.skb =3D skb,
> +	};
> +	struct mt76_dev *dev =3D phy->dev;
> +	struct ieee80211_hw *hw;
> +	int len, n =3D 0, ret =3D -ENOMEM;
> +	struct mt76_txwi_cache *t;
> +	struct sk_buff *iter;
> +	dma_addr_t addr;
> +	u8 *txwi;
> +
> +	if (test_bit(MT76_RESET, &phy->state))
> +		goto free_skb;
> +
> +	t =3D mt76_get_txwi(dev);
> +	if (!t)
> +		goto free_skb;
> +
> +	txwi =3D mt76_get_txwi_ptr(dev, t);
> +
> +	skb->prev =3D NULL;
> +	skb->next =3D NULL;
> +	if (dev->drv->drv_flags & MT_DRV_TX_ALIGNED4_SKBS)
> +		mt76_insert_hdr_pad(skb);
> +
> +	len =3D skb_headlen(skb);
> +
> +	if (dev->tx_prealloc_enabled && q->page_pool &&
> +	    !skb_has_frag_list(skb) && !skb_shinfo(skb)->nr_frags) {
> +		void *buf;
> +		int pp_len;
> +
> +		buf =3D mt792x_dma_tx_alloc_page_pool_buf(dev, q, skb, &addr, &pp_len);
> +		if (buf) {
> +			t->page_pool_buf =3D buf;
> +			len =3D pp_len;
> +
> +			tx_info.buf[n].addr =3D t->dma_addr;
> +			tx_info.buf[n++].len =3D dev->drv->txwi_size;
> +			tx_info.buf[n].addr =3D addr;
> +			tx_info.buf[n].len =3D len;
> +			tx_info.buf[n].skip_unmap =3D true;
> +			n++;
> +
> +			goto skip_dma_map;
> +		}
> +	}
> +
> +	addr =3D dma_map_single(dev->dma_dev, skb->data, len, DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
> +		goto free;
> +
> +	t->page_pool_buf =3D NULL;
> +
> +	tx_info.buf[n].addr =3D t->dma_addr;
> +	tx_info.buf[n++].len =3D dev->drv->txwi_size;
> +	tx_info.buf[n].addr =3D addr;
> +	tx_info.buf[n++].len =3D len;
> +
> +skip_dma_map:
> +	skb_walk_frags(skb, iter) {
> +		if (n =3D=3D ARRAY_SIZE(tx_info.buf))
> +			goto unmap;
> +
> +		addr =3D dma_map_single(dev->dma_dev, iter->data, iter->len,
> +				      DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
> +			goto unmap;
> +
> +		tx_info.buf[n].addr =3D addr;
> +		tx_info.buf[n].skip_unmap =3D false;
> +		tx_info.buf[n++].len =3D iter->len;
> +	}
> +	tx_info.nbuf =3D n;
> +
> +	if (q->queued + (tx_info.nbuf + 1) / 2 >=3D q->ndesc - 1) {
> +		ret =3D -ENOMEM;
> +		goto unmap;
> +	}
> +
> +	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
> +				DMA_TO_DEVICE);
> +	ret =3D dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
> +	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_si=
ze,
> +				   DMA_TO_DEVICE);
> +	if (ret < 0)
> +		goto unmap;
> +
> +	return mt76_dma_add_buf(dev, q, tx_info.buf, tx_info.nbuf,
> +				tx_info.info, tx_info.skb, t);
> +
> +unmap:
> +	for (n--; n > 0; n--) {
> +		if (!tx_info.buf[n].skip_unmap)
> +			dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
> +					 tx_info.buf[n].len, DMA_TO_DEVICE);
> +	}
> +
> +	if (t->page_pool_buf) {
> +		mt76_put_page_pool_buf(t->page_pool_buf, false);
> +		t->page_pool_buf =3D NULL;
> +	}
> +
> +free:
> +#ifdef CONFIG_NL80211_TESTMODE
> +	if (mt76_is_testmode_skb(dev, skb, &hw)) {
> +		struct mt76_phy *phy =3D hw->priv;
> +
> +		if (tx_info.skb =3D=3D phy->test.tx_skb)
> +			phy->test.tx_done--;
> +	}
> +#endif
> +
> +	mt76_put_txwi(dev, t);
> +
> +free_skb:
> +	status.skb =3D tx_info.skb;
> +	hw =3D mt76_tx_status_get_hw(dev, tx_info.skb);
> +	spin_lock_bh(&dev->rx_lock);
> +	ieee80211_tx_status_ext(hw, &status);
> +	spin_unlock_bh(&dev->rx_lock);
> +
> +	return ret;
> +}
> +
> +static void
> +mt792x_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool f=
lush)

this is almost a copy of mt76_dma_tx_cleanup(). Can we do something better
here?

> +{
> +	struct mt76_queue_entry entry;
> +	int last;
> +
> +	if (!q || !q->ndesc)
> +		return;
> +
> +	spin_lock_bh(&q->cleanup_lock);
> +	if (flush)
> +		last =3D -1;
> +	else
> +		last =3D Q_READ(q, dma_idx);
> +
> +	while (q->queued > 0 && q->tail !=3D last) {
> +		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
> +		mt76_npu_txdesc_cleanup(q, q->tail);
> +		mt76_queue_tx_complete(dev, q, &entry);
> +
> +		if (entry.txwi) {
> +			if (entry.skb && entry.txwi->page_pool_buf) {
> +				mt76_put_page_pool_buf(entry.txwi->page_pool_buf, false);
> +				entry.txwi->page_pool_buf =3D NULL;
> +			}
> +
> +			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
> +				mt76_put_txwi(dev, entry.txwi);
> +		}
> +
> +		if (!flush && q->tail =3D=3D last)
> +			last =3D Q_READ(q, dma_idx);
> +	}
> +	spin_unlock_bh(&q->cleanup_lock);
> +
> +	if (flush) {
> +		spin_lock_bh(&q->lock);
> +		mt76_dma_sync_idx(dev, q);
> +		mt76_dma_kick_queue(dev, q);
> +		spin_unlock_bh(&q->lock);
> +	}
> +
> +	if (!q->queued)
> +		wake_up(&dev->tx_wait);
> +}
> +
> +static struct mt76_queue_ops mt792x_queue_ops;
> +
> +void mt792x_dma_attach(struct mt76_dev *dev)
> +{
> +	mt792x_queue_ops =3D mt76_dma_ops;

can you please take a look to mt7615_mmio_probe()?

Regards,
Lorenzo

> +
> +	mt792x_queue_ops.tx_queue_skb =3D mt792x_dma_tx_queue_skb;
> +	mt792x_queue_ops.tx_cleanup =3D mt792x_dma_tx_cleanup;
> +
> +	dev->queue_ops =3D &mt792x_queue_ops;
> +}
> +EXPORT_SYMBOL_GPL(mt792x_dma_attach);
> +
>  int mt792x_dma_disable(struct mt792x_dev *dev, bool force)
>  {
>  	/* disable WFDMA0 */
> @@ -326,6 +646,8 @@ void mt792x_dma_cleanup(struct mt792x_dev *dev)
>  		 MT_WFDMA0_RST_LOGIC_RST);
> =20
>  	mt76_dma_cleanup(&dev->mt76);
> +
> +	mt792x_dma_tx_page_pool_cleanup(dev);
>  }
>  EXPORT_SYMBOL_GPL(mt792x_dma_cleanup);
> =20
> --=20
> 2.45.2
>=20

--04mVdsiyjwcC3eL5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak9bWAAKCRA6cBh0uS2t
rH7kAP9wxmTIqEq2H9+NhrixSdyMWGZdSTb6/VtPr8OatEFU1QD7BLhhs9ReGoAh
6pzDD9zJC1Nf+RTioRaLGM5yFGW8FA0=
=Zdkn
-----END PGP SIGNATURE-----

--04mVdsiyjwcC3eL5--

