Return-Path: <linux-wireless+bounces-6831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E688B1F4F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DE11F21EA3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866C20DD3;
	Thu, 25 Apr 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPXU9OaD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0120B34
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041468; cv=none; b=tUL6YnKxVCwMw0joS47VPImEZs3SJ2LufI6xBBdxa71Kpn36whQxtlZPOjlEoq07hy+Ks9XTnJUkw1pJM5rKE77XefuJ3cjcPdy1Z/HZZVoqzsqP/woERM7ewXjRBU6I3J5u6wYf8HqLaxsy/a/yOz13rUtov/Hdt5NYJPXi5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041468; c=relaxed/simple;
	bh=/8CPFyEvI16oarvHvyC+EjrRq2/ekQV6u/DnvDlK3Qw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=r8E8bEaOECKi0RdbX2Nm9JrA+i7LquCLgm+c2WQ64/GomouDybJLBnXu7Ff8BldM7aykc/xLj+bPOLpIq+lXB9J+jymYdFBU4Hv+X/3sbvpRPmDYqhNNivAslbkRH+x7M28RALgw7RK2Y3evhN54Qy06bOU7lq5GxxDn//tCWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPXU9OaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F113C2BD10;
	Thu, 25 Apr 2024 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714041468;
	bh=/8CPFyEvI16oarvHvyC+EjrRq2/ekQV6u/DnvDlK3Qw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fPXU9OaDsgRmqOFd2veHHOfncZYF7oySXSfocOXsDjTVqJzH9RtIvgZrvaz98fsLe
	 aGGhIx7/deDTIxNPJGQHI8c6lAMgRIuOLwblvBxIY6ub9YSPKFR/TqydHqQ1twr23J
	 yzxL11hn7NSr8Wu5z9m7im7nBXHJPZ3q00x7MpolM9KlC+lS32Ji9W2OQeVtTXbvUE
	 lKeSwtOfgIVE2cb9EYk75SXMDv3Sh05udC2MwNuODkZ4doL77ly8IUYcRa6cVg/wXk
	 DWHhIh/S7l1DCtI/mtvg1jIUifDDZaOiaZwg9JeGVgslBQKdw5UCSgXESxQ/JjmrS2
	 3ov29XOdZcQEg==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
	<20240419032122.7009-2-quic_lingbok@quicinc.com>
Date: Thu, 25 Apr 2024 13:37:45 +0300
In-Reply-To: <20240419032122.7009-2-quic_lingbok@quicinc.com> (Lingbo Kong's
	message of "Fri, 19 Apr 2024 11:21:20 +0800")
Message-ID: <87r0etsp6u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
>
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
>
> This patch affects the station mode of WCN7850 and QCN9274.
>
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
>
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  872 ms
>         rx bytes:       219111
>         rx packets:     1133
>         tx bytes:       53767
>         tx packets:     462
>         tx retries:     51
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      403
>         rx drop misc:   74
>         signal:         -95 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

[...]

> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
> +{
> +	if (ar->last_ppdu_id != 0) {
> +		if (ar->last_ppdu_id == ts->ppdu_id ||
> +		    ar->cached_ppdu_id == ar->last_ppdu_id)
> +			ar->cached_ppdu_id = ar->last_ppdu_id;
> +
> +		ath12k_dp_tx_update_txcompl(ar, ts);
> +	}
> +
> +	ar->last_ppdu_id = ts->ppdu_id;
> +}

A code comment would help a lot. Why is ar->cached_ppdu_id needed here?

And if 'ar->cached_ppdu_id == ar->last_ppdu_id' is true why do then do
'ar->cached_ppdu_id = ar->last_ppdu_id'? The value of ar->cached_ppdu_id
is not changing here (unless I'm missing something).

Also I'm worried about locking. How is access to ar->last_ppdu_id and
ar->cached_ppdu_id protected?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

