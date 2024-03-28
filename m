Return-Path: <linux-wireless+bounces-4797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B687D77C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 01:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E295B1C211B6
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A45B663;
	Sat, 16 Mar 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCcKMyww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D075B661
	for <linux-wireless@vger.kernel.org>; Sat, 16 Mar 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547216; cv=none; b=rQ7MUQc3YmylOhVOkdZvpT8dkRmgW+8UOvLK7ScxvtaQwIgmvsA0Zf8WiS4Iod/WwSvG2rfY+F89NQan7NwMl4X15xmqsO/Vu95xv/4UZV/IO9GsQc5wFv06/xnGKMMMwdTzIKJVuk0VFfyESK/1rI8rjSvW/qdVuSx2JwOmd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547216; c=relaxed/simple;
	bh=Gh0Va/y91T4s+FSJP7R2zg4Icvktc0uXGb2Apig9cIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtfEMB2LK7nWwJrnLj4VuUzl82c3ltFKujTlYlA7/p2FUqJXX5WL09nDzbPHexTnd9JB16EmtgDDST+zK4LdyMP/jHJu57NqtVtMNvzWg4zRooDW1CtrnJXDBv0nJvRb4eu9btamqlHcc69AbfoJAQPjeodzyBNUsT1Zp/b/SkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SCcKMyww; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ddbad11823so25241715ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710547213; x=1711152013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPhA0gkDJaXu/RqxmHRi72WGUwVG0TNzzAzUmGA6W2E=;
        b=SCcKMywweVSuiRoO8HLXbuVhaxqBxi/GQQ7e3Sh++AcYBC09XLmfFdm8bjdh5Mpj7Z
         K7H0/hxfE7AxfqqtzWzqt5jw/uBFFTyTNJYbGa8bvA+LG4XQshGixY1IkPE1XzrekG59
         mS4pREy+3055+vlS0wpJ/QkdUB5XFpBYU7/pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710547213; x=1711152013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPhA0gkDJaXu/RqxmHRi72WGUwVG0TNzzAzUmGA6W2E=;
        b=OW8q6rNIHFlLH1tWXZo7VWhzYdcbsev0qDbiP/IrcUci4gsR63TyICjvAffsYNoV3p
         mcztcZTP1h5RQ7qtA4PINsB3i3gxCgS3z6MSqX/cqkr80rViCYwNZ4BcV/2ZQI3vI7uB
         BRNXc8K/aTJmo/fgzp7msJsvSqGunAPeXeRud3zLxP80eFVo29WPHS/KC6R98Nj3VVV4
         u3NM0NUi5yP9XCnprRhNFLxGCD9sED5Ni98ksMc1GRvcrHDYNypIFX3ILH/Os3uNtTDV
         V2Tw8wmp9JaaFpZvgAd3TtV/T70h6VrgWEIdkszrvxzWR7cC+9f1kXuBe5LPzenmIEV5
         LKiA==
X-Gm-Message-State: AOJu0Yz2bbsN1q3RTvsYPk3ux+HFfbuz7m3KBJxAKKbVR4Hwev8lYckz
	vKsSspPvLk4uSPToWe9m46+Q/jqXYqSjzfneRJ7LvbTSzxSVSLjFyKVWOimTqg==
X-Google-Smtp-Source: AGHT+IHl5xsUEgEA5o3jXBAEps2KHzgLF4/p9o17+keEwklk/GBx2MzyBL4XxG8D/BrdMj9t+tBdqA==
X-Received: by 2002:a17:902:e88a:b0:1dd:6a2d:e5c8 with SMTP id w10-20020a170902e88a00b001dd6a2de5c8mr7068985plg.55.1710547212764;
        Fri, 15 Mar 2024 17:00:12 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id l8-20020a170903244800b001dd4bc67910sm4493859pls.79.2024.03.15.17.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:00:12 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:00:11 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client mode
Message-ID: <ZfThCwGj-P5Owlsn@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020053.18054-2-yu-hao.lin@nxp.com>

Hi David,

Thanks for the persistence here (and thanks Francesco for all the review
help). I think things are mostly well structured here, but I'll also
admit it's a pretty large bit of work to review at once. So please bear
with me if it takes a bit of time to really get through it. I'll post a
few thoughts now, but it's possible I'll have more after another pass.

On Wed, Mar 06, 2024 at 10:00:52AM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in client mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> 
> v9:
>    - remove redundent code.
> 
> v8:
>    - first full and complete patch to support host based MLME for client
>      mode.
> 
> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 315 ++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  25 ++
>  drivers/net/wireless/marvell/mwifiex/decl.h   |  22 ++
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  33 ++
>  drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/join.c   |  66 +++-
>  drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
>  drivers/net/wireless/marvell/mwifiex/main.h   |  16 +
>  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
>  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
>  .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
>  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
>  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
>  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
>  15 files changed, 671 insertions(+), 14 deletions(-)

(Per the above, I'd normally consider whether ~671 new lines is worth
splitting into multiple patches. But I don't see any great logical ways
to do that.)

> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index b909a7665e9c..bcf4f87dcaab 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c

> @@ -4204,6 +4210,302 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
>  	return ret;
>  }
>  
> +static int
> +mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
> +			      struct net_device *dev,
> +			      struct cfg80211_auth_request *req)
> +{
> +	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
> +	struct mwifiex_adapter *adapter = priv->adapter;
> +	struct sk_buff *skb;
> +	u16 pkt_len, auth_alg;
> +	int ret;
> +	struct mwifiex_ieee80211_mgmt *mgmt;
> +	struct mwifiex_txinfo *tx_info;
> +	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
> +	u8 addr[ETH_ALEN] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};


> +	memcpy(mgmt->addr4, addr, ETH_ALEN);

	eth_broadcast_addr(mgmt->addr4);

> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c

> @@ -1558,6 +1596,14 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
>  		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
>  	}
>  
> +	adapter->host_mlme_workqueue =
> +		alloc_workqueue("MWIFIEX_HOST_MLME_WORK_QUEUE",
> +				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);

Hmm, why do you need a whole new workqueue? This driver is already full
of race conditions, while many race conditions are avoided simply
because most work is sequentialized onto the main work queue. If you
don't have a good reason here, I'd probably prefer you share the
existing queue.

Or otherwise, if this is *truly* independent and race-free, do you
actually need to create a new queue? We could just use schedule_work(),
which uses the system queue.

If you do really need it, is it possible to key off 'host_mlme_enabled'
or similar? There's no need to allocate the queue if we're not using it.

> +	if (!adapter->host_mlme_workqueue)
> +		goto err_kmalloc;
> +
> +	INIT_WORK(&adapter->host_mlme_work, mwifiex_host_mlme_work_queue);
> +
>  	/* Register the device. Fill up the private data structure with
>  	 * relevant information from the card. Some code extracted from
>  	 * mwifiex_register_dev()


> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -370,6 +370,46 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
>  
>  	return 0;
>  }
> +
> +/* This function sends deauth packet to the kernel. */
> +void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
> +				  u16 reason_code, u8 *sa)
> +{
> +	u8 broadcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
> +	u8 frame_buf[100];
> +	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)frame_buf;
> +
> +	memset(frame_buf, 0, sizeof(frame_buf));
> +	mgmt->frame_control = (__force __le16)IEEE80211_STYPE_DEAUTH;

Hmm, "__force" is a pretty good sign that you're doing something wrong.
Please think twice before using it.

I believe the right answer here is cpu_to_le16(). It's a no-op on little
endian architectures, but it'll make big-endian work.

> +	mgmt->duration = 0;
> +	mgmt->seq_ctrl = 0;
> +	mgmt->u.deauth.reason_code = (__force __le16)reason_code;

Same here.

> +
> +	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA) {
> +		memcpy(mgmt->da, broadcast_addr, ETH_ALEN);

		eth_broadcast_addr(mgmt->da);

> +		memcpy(mgmt->sa,
> +		       priv->curr_bss_params.bss_descriptor.mac_address,
> +		       ETH_ALEN);
> +		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
> +		priv->auth_flag = 0;
> +		priv->auth_alg = WLAN_AUTH_NONE;


> @@ -417,6 +457,46 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
>  	pkt_len -= ETH_ALEN;
>  	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
>  
> +	if (priv->host_mlme_reg &&
> +	    (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP) &&
> +	    (ieee80211_is_auth(ieee_hdr->frame_control) ||
> +	     ieee80211_is_deauth(ieee_hdr->frame_control) ||
> +	     ieee80211_is_disassoc(ieee_hdr->frame_control))) {
> +		if (ieee80211_is_auth(ieee_hdr->frame_control)) {
> +			if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
> +				if (priv->auth_alg != WLAN_AUTH_SAE) {
> +					priv->auth_flag &=
> +						~HOST_MLME_AUTH_PENDING;
> +					priv->auth_flag |=
> +						HOST_MLME_AUTH_DONE;
> +				}
> +			} else {
> +				return 0;
> +			}
> +
> +			mwifiex_dbg(priv->adapter, MSG,
> +				    "auth: receive authentication from %pM\n",
> +				    ieee_hdr->addr3);
> +		} else {
> +			if (!priv->wdev.connected)
> +				return 0;
> +
> +			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> +				mwifiex_dbg(priv->adapter, MSG,
> +					    "auth: receive deauth from %pM\n",
> +					    ieee_hdr->addr3);
> +				priv->auth_flag = 0;
> +				priv->auth_alg = WLAN_AUTH_NONE;
> +			} else {
> +				mwifiex_dbg(priv->adapter, MSG,
> +					    "assoc: receive disasso from %pM\n",

I get that sometimes abbreviations are nice, but perhaps at least use a
consistent one? I see "disassoc" elsewhere.

> +					    ieee_hdr->addr3);

Brian

