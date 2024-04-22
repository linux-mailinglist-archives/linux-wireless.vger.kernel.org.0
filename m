Return-Path: <linux-wireless+bounces-6642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F338AC641
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A91B20B1F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D54F213;
	Mon, 22 Apr 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlIbbEz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4F4D59E
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773120; cv=none; b=uZ/l0fJ7kW5f/4eH52ZauoPk8D3Z6/Owf7U/KwnpCq7yRADN+3EkG/l8A7F6/9ZotYpb3UqjYqyGhKWA4h3q/s6jdNS1RVwZ9N17Nt64meLmwi8zWTfClXLS35cBqs25qN58+YmxP3I6zs8nk5d3jQ6mIoi4/kRIazlMPTDaOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773120; c=relaxed/simple;
	bh=9HOQ5bPJmRBiTt3jg1HvR7fHrxWhTOVAi4sFAxZKtrw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U5ksvOqPx5DgLry2+DGDKpjvmdx6/dKbp3kvCYi5GSHC85T6hZUGogt9HyhPvMTqQwPuBMoqxh3SNH3O7S7ByPaX/IC93kLZTNFjwbrlTUgxsWryk1jLJQtQ63jLwq9FpBc6uDN4Ks0nAWhnAMsdh2p6uhiBWdx4diZ5hZctuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlIbbEz2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso2586885e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713773117; x=1714377917; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s29BLzGYp7Bm8cEbRP6OwjY4YuJ83Rd6mv4uVp6Msc=;
        b=nlIbbEz2Yt9LlrA7uPTA2RiDFH4uTq8Vuo3YQ3prMacw5YUJrfIF/qEJV2vhAjoJCp
         dfXsxaS36mCUuehIUYuSKQnKK3pzme8luxqrD1uiTPwJXrGwhXiCP/+iE2DU/Kg3NNxW
         vHyyqKrtnELLATdg398QaaFi7nggK9Z/c1K1wDOWf91Vj6fQqDHGoAiXljsCkwg6K4HR
         f0/I4hSjRwh4ZdFY3r6HlRt1X26ZSA/DzwZF9GmNS4dhLojp5pGwd3ujU7GQ19iWZwAu
         eYiRfgDDobw820412FD6+6FW+h/wgcRIIUZSXXeRH9xsNR4RVDjOu69Uh3CK43qrX4Pp
         umOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773117; x=1714377917;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8s29BLzGYp7Bm8cEbRP6OwjY4YuJ83Rd6mv4uVp6Msc=;
        b=J0vz1KjrFYpfbfd4hfQHmm/axf3dQHHdFH8RmvsRMGP+Le1JKmkpSKnnGUb6YYclPZ
         JGhvCsQ4y+vCjT2KWrKsuvGo75qSKol+CW6cNtG3BIyKhPxDsEdG7CEwsGX/E0rh0x4U
         KmTFmN0nUrnCiavE/up3DSVtwXtSkjUIjC1Dp+h+xdKqDD3glytIelsnZY0HyfKnhrET
         XqHC0ngypase8ycIIq0Hh25gnREVrQQ1LnWWXEjRQy/idGQrlGczMIR4HLrhWHWNNJ4i
         iQ8kNyduEVTBNsFM+etVhGQIqeAOQP52GOvoRpggf/XPSYG80JEHbBK4D0ERP7FdL3ST
         sq2A==
X-Gm-Message-State: AOJu0Yz9GY0Q+U5Awhe2zZJPDUoiR4i+vuTwN1/71+mQQX304nSVuAl0
	GWbR3TIMnl1NJIfpD95vRch6d0VIo33Pg2GHuHabW9OppR+rxo5U
X-Google-Smtp-Source: AGHT+IH29kPFT629rzGfG3WWj0i6IBffylSNx7YQAIdH4ZQUoGK15aJCeZEU5NWQ+lVn+dh0nMzMsw==
X-Received: by 2002:a05:600c:3153:b0:41a:7c99:cb40 with SMTP id h19-20020a05600c315300b0041a7c99cb40mr492695wmo.15.1713773117194;
        Mon, 22 Apr 2024 01:05:17 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm19548875wms.32.2024.04.22.01.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Apr 2024 10:05:16 +0200
Message-Id: <D0QHV8UV73N5.2N5E3MH37JQW7@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: drop failed transmitted frames from
 metric calculation.
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Kathirvel" <quic_kathirve@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240419170314.3117623-1-quic_kathirve@quicinc.com>
In-Reply-To: <20240419170314.3117623-1-quic_kathirve@quicinc.com>

On Fri Apr 19, 2024 at 7:03 PM CEST, Karthikeyan Kathirvel wrote:
[...]
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wirele=
ss/ath/ath12k/dp_tx.c
> index 9b6d7d72f57c..164431b7eb4e 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -481,18 +481,36 @@ static void ath12k_dp_tx_complete_msdu(struct ath12=
k *ar,
>  	/* skip tx rate update from ieee80211_status*/
>  	info->status.rates[0].idx =3D -1;
> =20
> -	if (ts->status =3D=3D HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
> -	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
> -		info->flags |=3D IEEE80211_TX_STAT_ACK;
> -		info->status.ack_signal =3D ATH12K_DEFAULT_NOISE_FLOOR +
> -					  ts->ack_rssi;
> -		info->status.flags =3D IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
> +	switch (ts->status) {
> +	case HAL_WBM_TQM_REL_REASON_FRAME_ACKED:
> +		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
> +			info->flags |=3D IEEE80211_TX_STAT_ACK;
> +			info->status.ack_signal =3D ATH12K_DEFAULT_NOISE_FLOOR +
> +						  ts->ack_rssi;
> +			info->status.flags =3D IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
> +		}
> +		break;
> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX:
> +		if (info->flags & IEEE80211_TX_CTL_NO_ACK) {
> +			info->flags |=3D IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> +			break;
> +		}
> +		fallthrough;
> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
> +	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
> +		/* The failure status is due to internal firmware tx failure
> +		 * hence drop the frame do not update the status of frame to
> +		 * the upper layer
> +		 */
> +		dev_kfree_skb_any(msdu);
Shouldn't this be ieee80211_free_txskb ? I'm not clear when to use which.
> +		goto exit;
> +	default:
> +		ath12k_dbg(ab, ATH12K_DBG_DP_TX, "tx frame is not acked status %d\n",
> +			   ts->status);
> +		break;
>  	}
> =20
> -	if (ts->status =3D=3D HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX &&
> -	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
> -		info->flags |=3D IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> -
>  	/* NOTE: Tx rate status reporting. Tx completion status does not have
>  	 * necessary information (for example nss) to build the tx rate.
>  	 * Might end up reporting it out-of-band from HTT stats.

Thanks

