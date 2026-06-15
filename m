Return-Path: <linux-wireless+bounces-37800-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00FRO+CkL2quDwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37800-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:08:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8F6840A8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:08:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FacHqPqA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37800-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37800-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D57130048FE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C51D8E01;
	Mon, 15 Jun 2026 07:08:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC413AA2D
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 07:08:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507293; cv=none; b=O6kOU548PmRpLKk+7EkkWV1AfBh86W7UhWiou42tjewQPl/U9OZTECI+NlIml4nO9Rw0++NzOge87TZ3krFHkzyni+HHWUMhLw16Lk/NzrnNuiRHwV2hxhIOeVeDXBq+mx/vyDWIKJb4bu0OdPcDW4CYCDeZeIMWf1XiVH5m02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507293; c=relaxed/simple;
	bh=UA9YF2aUTKYNgnGvlXbCJWQCg1FTd/CZdQ0ZIoqqEKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4t8kkXViDyine0RtB9pTODMxsaKuwUzAsRKt4rsm7kvgfyQUASLHT5O3ESKiVJ701CClzOx2xOb7twrmZ1euvtXE4zqLQ0LlS5VvsKUpgMw+u6Hn5bvTo+BmlF7AbsAxm2iXBYI/pPv76BwG2jvDTz408YsoolLKSE7eDINOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FacHqPqA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1D1F000E9;
	Mon, 15 Jun 2026 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781507291;
	bh=NIeSblO4LrYttlggD2uMIKS5MMzzvzcCqowl0pLtSrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FacHqPqAWLBSmsJcEsRv2I+LayR4HMl8/zmI36rRQWQeGHkK9MrjQtL1LR2cF3+e6
	 Bw7b9IeMn+mMIob4ON3pNgrfJiXvxZ/gVFqB/uYoX6OARTkPlgBqprvppo+oWxLr+a
	 W+cYhuLyb/Y6h3kLJ6fX873ELzzFPTIImlemlRRNRL5FL5rQf6eh4GoT454EsvVVIX
	 dkPfGgGfB42GihSw1rLoEdTJ0tUbXAwasZkwHhvVdTnzIJnWdOfRgWSenJ6KMACQz1
	 pMLtdMUCO9P0NOFK0GhS5dn9N7vZAOZN+5twmvkAK63zeLag7gXur8cAKvJ81cpEjU
	 zo4F9r6HhF0Ug==
Date: Mon, 15 Jun 2026 09:08:07 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 3/5] wifi: mt76: usb: add optional RX aggregation support
Message-ID: <ai-k16yin-ECq6Jh@lore-rh-laptop>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
 <20260613224655.2405686-4-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ix3/N0iw9LxS97E3"
Content-Disposition: inline
In-Reply-To: <20260613224655.2405686-4-sean.wang@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37800-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-rh-laptop:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61C8F6840A8


--ix3/N0iw9LxS97E3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 13, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add common USB RX aggregation support and let drivers opt in by programmi=
ng
> the UDMA RX aggregation limit and timeout.
>=20
> RX aggregation allows the device to pack multiple RX packets into one USB
> transfer, reducing URB completion rate, USB interrupt/IO overhead, and ho=
st
> RX scheduling pressure. This is especially useful at high throughput, whe=
re
> per-packet USB RX handling can become a CPU bottleneck.
>=20
> Keep it disabled by default so existing USB drivers keep the current RX
> behavior unless they explicitly enable aggregation.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  21 ++-
>  .../net/wireless/mediatek/mt76/mt7925/usb.c   |  12 ++
>  .../net/wireless/mediatek/mt76/mt792x_usb.c   |  23 +++-
>  drivers/net/wireless/mediatek/mt76/usb.c      | 124 +++++++++++++++++-
>  4 files changed, 169 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 81740aa7df71..125c97dc1f28 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -680,6 +680,13 @@ struct mt76_usb {
>  	void (*ctrl_timeout)(struct mt76_dev *dev, int err);
>  	bool sg_en;
> =20
> +	struct {
> +		bool enable;
> +		int align;
> +		int padding;
> +		int buf_size;
> +	} rx_aggr;
> +
>  	struct mt76u_mcu {
>  		u8 *data;
>  		/* multiple reads */
> @@ -1857,6 +1864,17 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, i=
nt len, int *actual_len,
>  	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
>  }
> =20
> +static inline int
> +mt76u_rx_aggr_buf_size(int max_mpdu, int aggr_limit, int aggr_pkt_limit,
> +		       int padding)
> +{
> +	int aggr_size;
> +
> +	aggr_size =3D min(aggr_limit, aggr_pkt_limit * (max_mpdu + padding));
> +
> +	return PAGE_ALIGN(max_mpdu + aggr_size);
> +}
> +
>  void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *=
index);
>  void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
>  			 struct mt76_sta_stats *stats, bool eht);
> @@ -1882,7 +1900,8 @@ void mt76u_stop_tx(struct mt76_dev *dev);
>  void mt76u_stop_rx(struct mt76_dev *dev);
>  int mt76u_resume_rx(struct mt76_dev *dev);
>  void mt76u_queues_deinit(struct mt76_dev *dev);
> -
> +void mt76u_enable_rx_aggr(struct mt76_dev *dev, int align, int padding,
> +			  int buf_size);
>  int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
>  	       const struct mt76_bus_ops *bus_ops);
>  int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/usb.c
> index 49ad4fe9eb1b..a0bfe6f09ae4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
> @@ -3,12 +3,24 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/sizes.h>
>  #include <linux/usb.h>
> =20
>  #include "mt7925.h"
>  #include "mcu.h"
>  #include "mac.h"
> =20
> +#define MT7927_USB_RX_AGGR_ALIGN	16
> +#define MT7927_USB_RX_AGGR_PADDING	12
> +#define MT7927_USB_RX_AGGR_LIMIT	SZ_32K
> +#define MT7927_USB_RX_AGGR_PKT_LIMIT	30
> +#define MT7927_USB_RX_MAX_MPDU		(13 * SZ_1K)
> +#define MT7927_USB_RX_AGGR_BUF_SIZE \
> +	mt76u_rx_aggr_buf_size(MT7927_USB_RX_MAX_MPDU, \
> +			       MT7927_USB_RX_AGGR_LIMIT, \
> +			       MT7927_USB_RX_AGGR_PKT_LIMIT, \
> +			       MT7927_USB_RX_AGGR_PADDING)

If I do the math correctly, it will use an order-5 buffer for each urb, rig=
ht?
If so, this approach is not very unrecommended, please take a look at [0]

[0] https://lore.kernel.org/netdev/CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfe=
Gq5Zm6h9e=3DQ@mail.gmail.com/

> +
>  static const struct usb_device_id mt7925u_device_table[] =3D {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x6639, 0xff, 0xff, 0xff),
>  		.driver_info =3D (kernel_ulong_t)MT7925_FIRMWARE_WM },
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt792x_usb.c
> index 6280bc4bf78d..769e828e9449 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> @@ -13,6 +13,9 @@
> =20
>  #define MT792X_USB_TX_TIMEOUT_LIMIT	50000
>  #define MT792X_USB_UDMA_IDLE_TIMEOUT	1000
> +#define MT792X_USB_RX_AGG_LIMIT		32
> +#define MT792X_USB_RX_AGG_TIMEOUT	100
> +#define MT792X_USB_RX_AGG_PKT_LIMIT	30
> =20
>  static int mt792xu_read32(struct mt76_dev *dev, u32 addr, void *buf)
>  {
> @@ -403,9 +406,23 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool re=
sume)
>  		 FIELD_PREP(MT_WL_TX_TMOUT_LMT,
>  			    MT792X_USB_TX_TIMEOUT_LIMIT));
>  	mt76_set(dev, MT_UDMA_WLCFG_0, MT_WL_TX_TMOUT_FUNC_EN);
> -	mt76_clear(dev, MT_UDMA_WLCFG_0,
> -		   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
> -	mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
> +
> +	if (dev->mt76.usb.rx_aggr.enable) {
> +		mt76_set(dev, MT_UDMA_WLCFG_0, MT_WL_RX_AGG_EN);
> +		mt76_rmw(dev, MT_UDMA_WLCFG_0,
> +			 MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT,
> +			 FIELD_PREP(MT_WL_RX_AGG_TO,
> +				    MT792X_USB_RX_AGG_TIMEOUT) |
> +			 FIELD_PREP(MT_WL_RX_AGG_LMT,
> +				    MT792X_USB_RX_AGG_LIMIT));
> +		mt76_rmw(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT,
> +			 FIELD_PREP(MT_WL_RX_AGG_PKT_LMT,
> +				    MT792X_USB_RX_AGG_PKT_LIMIT));
> +	} else {
> +		mt76_clear(dev, MT_UDMA_WLCFG_0, MT_WL_RX_AGG_EN |
> +			   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
> +		mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
> +	}
> =20
>  	if (resume)
>  		return 0;
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index cab36630c978..cbdd663fbb25 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -371,6 +371,14 @@ mt76u_refill_rx(struct mt76_dev *dev, struct mt76_qu=
eue *q,
>  		return mt76u_fill_rx_sg(dev, q, urb, nsgs);
> =20
>  	urb->transfer_buffer_length =3D q->buf_size;
> +	if (qid =3D=3D MT_RXQ_MAIN && dev->usb.rx_aggr.enable) {
> +		if (!urb->transfer_buffer)
> +			urb->transfer_buffer =3D
> +				mt76_get_page_pool_buf(q, &offset, q->buf_size);
> +
> +		return urb->transfer_buffer ? 0 : -ENOMEM;

maybe I am missing something, but this chunk of code seems unnecessary

> +	}
> +
>  	urb->transfer_buffer =3D mt76_get_page_pool_buf(q, &offset, q->buf_size=
);
> =20
>  	return urb->transfer_buffer ? 0 : -ENOMEM;
> @@ -538,18 +546,113 @@ mt76u_build_rx_skb(struct mt76_dev *dev, void *dat=
a,
>  	return skb;
>  }
> =20
> +static struct sk_buff *
> +mt76u_build_rx_skb_aggr(struct mt76_dev *dev, void *data, int data_len,
> +			int buf_len)
> +{

Can we integrate it better with mt76u_build_rx_skb()?

> +	int head_room, drv_flags =3D dev->drv->drv_flags;
> +	int len =3D min_t(int, data_len, MT_SKB_HEAD_LEN);
> +	struct sk_buff *skb;
> +
> +	if (data_len <=3D 0)
> +		return NULL;
> +
> +	head_room =3D drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
> +	skb =3D alloc_skb(len, GFP_ATOMIC);
> +	if (!skb)
> +		return NULL;
> +
> +	data +=3D head_room;
> +	skb_put_data(skb, data, len);
> +	if (data_len > len) {
> +		struct page *page;
> +
> +		data +=3D len;
> +		page =3D virt_to_head_page(data);
> +		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +				page, data - page_address(page),
> +				data_len - len, buf_len);
> +		get_page(page);
> +	}
> +
> +	return skb;
> +}
> +
> +static int mt76u_process_rx_agg_entry(struct mt76_dev *dev, struct urb *=
urb)
> +{
> +	int offset =3D 0, head_room, drv_flags =3D dev->drv->drv_flags;
> +	int align =3D dev->usb.rx_aggr.align ?: 4;
> +	int padding =3D dev->usb.rx_aggr.padding ?: 4;
> +	u8 *data =3D urb->transfer_buffer;
> +	int min_len;
> +	int nframes =3D 0;
> +
> +	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state) ||
> +	    test_bit(MT76_REMOVED, &dev->phy.state))
> +		return 0;
> +
> +	head_room =3D drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
> +	min_len =3D head_room + MT_RX_RXWI_LEN;
> +
> +	while (urb->actual_length - offset >=3D min_len) {
> +		struct sk_buff *skb;
> +		int len, frame_len, agg_len;
> +
> +		len =3D mt76u_get_rx_entry_len(dev, data + offset,
> +					     urb->actual_length - offset);
> +		if (len < 0) {
> +			dev_warn_ratelimited(dev->dev,
> +					     "invalid USB RX aggregate at offset %d\n",
> +					     offset);
> +			break;
> +		}
> +
> +		frame_len =3D head_room + len;
> +		if (frame_len > urb->actual_length - offset) {
> +			dev_warn_ratelimited(dev->dev,
> +					     "truncated USB RX aggregate at offset %d\n",
> +					     offset);
> +			break;
> +		}
> +
> +		agg_len =3D ALIGN(frame_len, align) + padding;
> +		if (dev->drv->rx_check &&
> +		    !dev->drv->rx_check(dev, data + offset + head_room, len))
> +			goto next;
> +
> +		skb =3D mt76u_build_rx_skb_aggr(dev, data + offset, len,
> +					      agg_len);
> +		if (skb) {
> +			dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb, NULL);
> +			nframes++;
> +		}
> +
> +next:
> +		offset +=3D agg_len;
> +	}
> +
> +	mt76_put_page_pool_buf(urb->transfer_buffer, false);
> +	urb->transfer_buffer =3D NULL;
> +
> +	return max(nframes, 1);
> +}
> +
>  static int
>  mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
> -		       int buf_size)
> +		       enum mt76_rxq_id qid, int buf_size)
>  {
>  	u8 *data =3D urb->num_sgs ? sg_virt(&urb->sg[0]) : urb->transfer_buffer;
>  	int data_len =3D urb->num_sgs ? urb->sg[0].length : urb->actual_length;
>  	int len, nsgs =3D 1, head_room, drv_flags =3D dev->drv->drv_flags;
>  	struct sk_buff *skb;
> =20
> -	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
> +	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state) ||
> +	    test_bit(MT76_REMOVED, &dev->phy.state))

This seems a fix to me.

>  		return 0;
> =20
> +	if (qid =3D=3D MT_RXQ_MAIN && dev->usb.rx_aggr.enable && !urb->num_sgs)
> +		return mt76u_process_rx_agg_entry(dev, urb);
> +
>  	len =3D mt76u_get_rx_entry_len(dev, data, urb->actual_length);
>  	if (len < 0)
>  		return 0;
> @@ -594,6 +697,9 @@ static void mt76u_complete_rx(struct urb *urb)
> =20
>  	trace_rx_urb(dev, urb);
> =20
> +	if (test_bit(MT76_REMOVED, &dev->phy.state))
> +		return;

same here.

> +
>  	switch (urb->status) {
>  	case -ECONNRESET:
>  	case -ESHUTDOWN:
> @@ -658,12 +764,14 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct=
 mt76_queue *q)
>  		if (!urb)
>  			break;
> =20
> -		count =3D mt76u_process_rx_entry(dev, urb, q->buf_size);
> +		count =3D mt76u_process_rx_entry(dev, urb, qid, q->buf_size);
>  		if (count > 0) {
>  			err =3D mt76u_refill_rx(dev, q, urb, count);
>  			if (err < 0)
>  				break;
>  		}
> +		if (test_bit(MT76_REMOVED, &dev->phy.state))
> +			break;
>  		mt76u_submit_rx_buf(dev, qid, urb);
>  	}
>  }
> @@ -729,10 +837,6 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76=
_rxq_id qid)
>  	struct mt76_queue *q =3D &dev->q_rx[qid];
>  	int i, err;
> =20
> -	err =3D mt76_create_page_pool(dev, q);
> -	if (err)
> -		return err;
> -
>  	spin_lock_init(&q->lock);
>  	q->entry =3D devm_kcalloc(dev->dev,
>  				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
> @@ -742,6 +846,12 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76=
_rxq_id qid)
> =20
>  	q->ndesc =3D MT_NUM_RX_ENTRIES;
>  	q->buf_size =3D PAGE_SIZE;
> +	if (qid =3D=3D MT_RXQ_MAIN && dev->usb.rx_aggr.enable)
> +		q->buf_size =3D dev->usb.rx_aggr.buf_size ?: PAGE_SIZE;
> +
> +	err =3D mt76_create_page_pool(dev, q);
> +	if (err)
> +		return err;
> =20
>  	for (i =3D 0; i < q->ndesc; i++) {
>  		err =3D mt76u_rx_urb_alloc(dev, q, &q->entry[i]);
> --=20
> 2.43.0
>=20

--ix3/N0iw9LxS97E3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai+k1QAKCRA6cBh0uS2t
rBAHAQDoBzGPSwYSprmPxmqKZF0kOSU72zc0Rq+5gmCvQU7WJQD+Odf16uy5ykSJ
12rR/wziZac1VPrOdyqL3MSf84gvPgk=
=6upg
-----END PGP SIGNATURE-----

--ix3/N0iw9LxS97E3--

