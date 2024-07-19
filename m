Return-Path: <linux-wireless+bounces-10390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834393781E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AAA281E2A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B513C9A9;
	Fri, 19 Jul 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="CSEvwZUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSExF9+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52383CC7;
	Fri, 19 Jul 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394462; cv=none; b=kCjF7j/GzSR8NiVKDH025A61XGG5djADGMaZLlFvtgVmO8ruoAElSe7mSI+z5P8J7JKH8kky7VO6Mzqu29usqFMV8rGC5sPSf8mkiKu4pIiSV88a50kPkJijSkmKwmbBqvrBuIpa55xGYtwabtj67LT+mIoMpG3moDHfIIBNxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394462; c=relaxed/simple;
	bh=iLxnxhzlc/hqtixIoP9wCXXRxauEVOvT0+noWpLVgnU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=V1WWkjSTBefsjn0kqKE+aTHx4hl1g+YIVWCZPf5gs6h2xDOFeJq6EmLO2/NhHoHxk1JVIV963XTmZuKFlKvbuQh/1wWLAYYz/3J21UqbVjkF5+qOVw9YgVPek4bkPt+biBIgI00JiHL/ZHxpBD6aqUOaq42s7cVbSynYY6JWTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=CSEvwZUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSExF9+9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 142AF1140592;
	Fri, 19 Jul 2024 09:07:39 -0400 (EDT)
Received: from wimap25 ([10.202.2.85])
  by compute5.internal (MEProxy); Fri, 19 Jul 2024 09:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721394459; x=1721480859; bh=5oOS1jK3dU
	GUkbOI8kCpb5VD+vZM4dIqmVl+yS2Gb6A=; b=CSEvwZUw6IGr5ZwguY/AXOeyEy
	xEWg1GWvlqJtdsKIuNIIIeesYU1tpN5Q9rnEOTzIcq6+HZoTNRuczyAWdqqL7Frw
	ZMTBmiqFUF5mnQxFHDxHiAMIR9yfNJ5/FP6CVoENKDlwESjI6HegHn55GaR/ufgV
	D9PARHcn79Nvr2yo2YB40bmHOEymaWtSrD1pYB9LMpXhBh5R7IeLhR7cKLQkdKWO
	Gtuw/LpWrPVjSU5pqMwuVXWrHNl8Rd7sdMbEIa3Ufw3hmnISKunF8SbRX5A8iZMX
	mIZviyAABN/RoZL8UAGKr3OSSWHnTe/1fHHK1IWIUBsh0+f0neVK8xZ8wePA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721394459; x=1721480859; bh=5oOS1jK3dUGUkbOI8kCpb5VD+vZM
	4dIqmVl+yS2Gb6A=; b=tSExF9+9aEq8KSQ5h4l9G6lObUQH2+/NK28eWBDNkdHI
	JD2TAzmzlpKWDJRggrVVp2U9Ulexy0+X0sNPgMzi3PqppumQbvceZrf1KCxG0lFz
	x8GbF1BOhfkeEix9VIXZV/Skr2HTZkvcVjsZEYB+JF1zZQlHm5Z1PhF71cHgIO/k
	x4Vz+Eaq/boPUvuUVtuMowX1U13V0lFtGNxykkEBGIeVsFyRciOKvadp4ADhP5CY
	I+1u3hXhXkxrGACsOPPhtpOC08XMtluBQvUyI0qLGeJo7/1iXVs6DX+F1WhWss0o
	QBWdepfzXbYano51qGfd7g1qykpmy+jplsLNV+Ui+Q==
X-ME-Sender: <xms:GmWaZld2p54E1GWiUETdjUYg4SrPm7DNvoTVnOg8NdwLUBHPeIML7g>
    <xme:GmWaZjOpydOFg9dGfteXsLnQrdOmAZwcn8oxgEyrbjdR22n-CHnhF627hqSrn7ZBM
    34A0A4dQC9ye_YXqPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdforghr
    khcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrd
    gtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffveduheff
    feejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:GmWaZug0RYdrqDWslFglQCJkSU-Jff4sfXNPLsEKT08qPzccQusdcQ>
    <xmx:GmWaZu9iwwDSlouNpGTizuIEfyE7QYWXoah0vjCdzvEmf9dz0m_nAQ>
    <xmx:GmWaZhueq5Drtml5F1GNnCONq6bNlPMMO5oZTe_6NmfGOVUvJJNoiA>
    <xmx:GmWaZtEv6XS_n3kJxayAvqFXACvYFt2k0ByU2JY-A6gtX8XTdyIijQ>
    <xmx:G2WaZrIP_kndas84E5wOow_YhhMvMb8feRoYfhZ7_OUkrSVWGIYTz4d4>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BADE31040061; Fri, 19 Jul 2024 09:07:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2cdac1e1-dff4-451c-a214-510c4736160a@app.fastmail.com>
In-Reply-To: <20240715023814.20242-1-quic_bqiang@quicinc.com>
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
Date: Fri, 19 Jul 2024 09:07:18 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Baochen Qiang" <quic_bqiang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kernel@quicinc.com, netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path for
 WCN7850
Content-Type: text/plain

On Sun, Jul 14, 2024, at 10:38 PM, Baochen Qiang wrote:
> In transmit path, it is likely that the iova is not aligned to PCIe TLP
> max payload size, which is 128 for WCN7850. Normally in such cases hardware
> is expected to split the packet into several parts in a manner such that
> they, other than the first one, have aligned iova. However due to hardware
> limitations, WCN7850 does not behave like that properly with some specific
> unaligned iova in transmit path. This easily results in target hang in a
> KPI transmit test: packet send/receive failure, WMI command send timeout
> etc. Also fatal error seen in PCIe level:
>
> 	...
> 	Capabilities: ...
> 		...
> 		DevSta: ... FatalErr+ ...
> 		...
> 	...
>
> Work around this by manually moving/reallocating payload buffer such that
> we can map it to a 128 bytes aligned iova. The moving requires sufficient
> head room or tail room in skb: for the former we can do ourselves a favor
> by asking some extra bytes when registering with mac80211, while for the
> latter we can do nothing.
>
> Moving/reallocating buffer consumes additional CPU cycles, but the good news
> is that an aligned iova increases PCIe efficiency. In my tests on some X86
> platforms the KPI results are almost consistent.
>
> Since this is seen only with WCN7850, add a new hardware parameter to
> differentiate from others.
>
> Tested-on: WCN7850 hw2.0 PCI 
> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_tx.c | 72 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/hw.c    |  6 +++
>  drivers/net/wireless/ath/ath12k/hw.h    |  4 ++
>  drivers/net/wireless/ath/ath12k/mac.c   |  1 +
>  4 files changed, 83 insertions(+)
>
>
> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c 
> b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index d08c04343e90..00475d0848e1 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -162,6 +162,60 @@ static int ath12k_dp_prepare_htt_metadata(struct 
> sk_buff *skb)
>  	return 0;
>  }
> 
> +static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
> +				      unsigned long delta,
> +				      bool head)
> +{
> +	unsigned long len = skb->len;
> +
> +	if (head) {
> +		skb_push(skb, delta);
> +		memmove(skb->data, skb->data + delta, len);
> +		skb_trim(skb, len);
> +	} else {
> +		skb_put(skb, delta);
> +		memmove(skb->data + delta, skb->data, len);
> +		skb_pull(skb, delta);
> +	}
> +}
> +
> +static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
> +				      struct sk_buff **pskb)
> +{
> +	u32 iova_mask = ab->hw_params->iova_mask;
> +	unsigned long offset, delta1, delta2;
> +	struct sk_buff *skb2, *skb = *pskb;
> +	unsigned int headroom = skb_headroom(skb);
> +	int tailroom = skb_tailroom(skb);
> +	int ret = 0;
> +
> +	offset = (unsigned long)skb->data & iova_mask;
> +	delta1 = offset;
> +	delta2 = iova_mask - offset + 1;
> +
> +	if (headroom >= delta1) {
> +		ath12k_dp_tx_move_payload(skb, delta1, true);
> +	} else if (tailroom >= delta2) {
> +		ath12k_dp_tx_move_payload(skb, delta2, false);
> +	} else {
> +		skb2 = skb_realloc_headroom(skb, iova_mask);
> +		if (!skb2) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		dev_kfree_skb_any(skb);
> +
> +		offset = (unsigned long)skb2->data & iova_mask;
> +		if (offset)
> +			ath12k_dp_tx_move_payload(skb2, offset, true);
> +		*pskb = skb2;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>  int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
>  		 struct sk_buff *skb)
>  {
> @@ -184,6 +238,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct 
> ath12k_vif *arvif,
>  	bool tcl_ring_retry;
>  	bool msdu_ext_desc = false;
>  	bool add_htt_metadata = false;
> +	u32 iova_mask = ab->hw_params->iova_mask;
> 
>  	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
>  		return -ESHUTDOWN;
> @@ -279,6 +334,23 @@ int ath12k_dp_tx(struct ath12k *ar, struct 
> ath12k_vif *arvif,
>  		goto fail_remove_tx_buf;
>  	}
> 
> +	if (iova_mask &&
> +	    (unsigned long)skb->data & iova_mask) {
> +		ret = ath12k_dp_tx_align_payload(ab, &skb);
> +		if (ret) {
> +			dev_warn_once(ab->dev, "failed to align TX buffer %d\n", ret);
> +			/* don't bail out, give original buffer
> +			 * a chance even unaligned.
> +			 */
> +			goto map;
> +		}
> +
> +		/* hdr is pointing to a wrong place after alignment,
> +		 * so refresh it for later use.
> +		 */
> +		hdr = (void *)skb->data;
> +	}
> +map:
>  	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, 
> DMA_TO_DEVICE);
>  	if (dma_mapping_error(ab->dev, ti.paddr)) {
>  		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c 
> b/drivers/net/wireless/ath/ath12k/hw.c
> index 2e11ea763574..7b3e2420e3c5 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -924,6 +924,8 @@ static const struct ath12k_hw_params 
> ath12k_hw_params[] = {
> 
>  		.acpi_guid = NULL,
>  		.supports_dynamic_smps_6ghz = true,
> +
> +		.iova_mask = 0,
>  	},
>  	{
>  		.name = "wcn7850 hw2.0",
> @@ -1000,6 +1002,8 @@ static const struct ath12k_hw_params 
> ath12k_hw_params[] = {
> 
>  		.acpi_guid = &wcn7850_uuid,
>  		.supports_dynamic_smps_6ghz = false,
> +
> +		.iova_mask = PCIE_MAX_PAYLOAD_SIZE - 1,
>  	},
>  	{
>  		.name = "qcn9274 hw2.0",
> @@ -1072,6 +1076,8 @@ static const struct ath12k_hw_params 
> ath12k_hw_params[] = {
> 
>  		.acpi_guid = NULL,
>  		.supports_dynamic_smps_6ghz = true,
> +
> +		.iova_mask = 0,
>  	},
>  };
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hw.h 
> b/drivers/net/wireless/ath/ath12k/hw.h
> index e792eb6b249b..49668aa0efc8 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.h
> +++ b/drivers/net/wireless/ath/ath12k/hw.h
> @@ -96,6 +96,8 @@
>  #define ATH12K_M3_FILE			"m3.bin"
>  #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
> 
> +#define PCIE_MAX_PAYLOAD_SIZE		128
> +
>  enum ath12k_hw_rate_cck {
>  	ATH12K_HW_RATE_CCK_LP_11M = 0,
>  	ATH12K_HW_RATE_CCK_LP_5_5M,
> @@ -215,6 +217,8 @@ struct ath12k_hw_params {
> 
>  	const guid_t *acpi_guid;
>  	bool supports_dynamic_smps_6ghz;
> +
> +	u32 iova_mask;
>  };
> 
>  struct ath12k_hw_ops {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c 
> b/drivers/net/wireless/ath/ath12k/mac.c
> index 8106297f0bc1..ce41c8153080 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -9193,6 +9193,7 @@ static int ath12k_mac_hw_register(struct 
> ath12k_hw *ah)
> 
>  	hw->vif_data_size = sizeof(struct ath12k_vif);
>  	hw->sta_data_size = sizeof(struct ath12k_sta);
> +	hw->extra_tx_headroom = ab->hw_params->iova_mask;
> 
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);

We've tested this in the Lenovo lab using the T14 G5 AMD with a 6.10.0-rc7+ kernel from wireless-next and this patch applied.
Previously we had stability issues under traffic load. With the patch applied we can no longer reproduce the issue.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Can this be tagged for stable backporting? It's an important fix.

Thanks for getting this fix done. Very much appreciated.

Mark

