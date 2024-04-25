Return-Path: <linux-wireless+bounces-6856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03388B2717
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA741F216CC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387F14D6F5;
	Thu, 25 Apr 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhfo4OsR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EC14D6F1
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064616; cv=none; b=kbt75mW11ybrhhBEI74IaR06RakQ9HC/oc1Ff+i6YaRHvFQvYyD9wJu52cmWboYSRMGNpcMPPQIvIgQn9681rKH9dRQsIlbt20dr1ryaaTtxF3n5iV8UEsy2BD5dNNkM5key1X9rnphm9Yy0Wm9zOlQvAzVYI0B2JIeIBQ/KnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064616; c=relaxed/simple;
	bh=ZyoqEPbEvn8/zC/o4LKp22S1ZTGNejLzpE70/PethaA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l9jRwT2/Zdbzd4LK3FtmbN8XIosqaKWLE0nrTI7+Vsf7+1ahe2Otxeds/cKeu1N+Y3n9f7Zqvt0EdvXTUyrPx6MOaCVD2n8IWMxkwxASdMVSaAUrTpLeQH7sgJMHNLJZ/4j4SwOV9K4YJIIvujUGZSWTvtRY3MhRjjNcRvbV4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhfo4OsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CE0C113CC;
	Thu, 25 Apr 2024 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714064616;
	bh=ZyoqEPbEvn8/zC/o4LKp22S1ZTGNejLzpE70/PethaA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bhfo4OsR+JvB5m1R56auuAfC8CrTymXT0Wyf7YptzzOAjhloTMw/E5f+5BqLQIOBG
	 30hlmlEPwEt87B9muHLTmbp4kMEl4xlWXRq9Wo5wZMtFNm/6K4QjH0KMhuM5TDHgkn
	 3O4Zg+bu95Kpc1M2TRoT1KhHdZtOzoFtehA0xbTLILZFIEUaVBePODlSz6JwoaBbRI
	 qdRxhSp864GS0jpTJNBmyY3t4+gfn+ym632Hymew37yX76kLUiP6e/AHAr5Yj4g1SN
	 ZCD0iSVbfBfGAMNQGXUvhy7KBV56cSa0/rArQ5eLStiP10y/95M0WI29Pq52cpWvS3
	 awpO8gYJW6/MA==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] wifi: ath12k: report station mode signal strength
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
	<20240419032122.7009-4-quic_lingbok@quicinc.com>
Date: Thu, 25 Apr 2024 20:03:17 +0300
In-Reply-To: <20240419032122.7009-4-quic_lingbok@quicinc.com> (Lingbo Kong's
	message of "Fri, 19 Apr 2024 11:21:22 +0800")
Message-ID: <877cgls7ca.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> Currently, the signal strength of "iw dev xxx station dump" always show an
> invalid value.
>
> This is because signal strength is only set in ath12k_mgmt_rx_event()
> function, and not set for received data packet. So, change to get signal
> from firmware and report to mac80211.
>
> After that, "iw dev xxx station dump" show the correct signal strength.
> Such as:
>
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  36 ms
>         rx bytes:       61571
>         rx packets:     336
>         tx bytes:       28204
>         tx packets:     205
>         tx retries:     49
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      83
>         rx drop misc:   66
>         signal:         -24 dBm
>         beacon signal avg:      -22 dBm
>
> For WCN7850, the firmware supports db2dbm, so not need to add noise floor.
> For QCN9274, the firmware not support db2dbm, so need to add noise floor.
>
> This patch affects the station mode of WCN7850 and QCN9274.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

[...]

> +static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
> +				   u32 vdev_id, u32 stats_id)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	int ret, left;
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	if (ar->state != ATH12K_STATE_ON) {
> +		ret = -ENETDOWN;
> +		goto err_unlock;
> +	}
> +
> +	reinit_completion(&ar->fw_stats_complete);
> +
> +	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
> +
> +	if (ret) {
> +		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
> +		goto err_unlock;
> +	}
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> +		   pdev_id, vdev_id, stats_id);
> +
> +	left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
> +
> +	if (!left)
> +		ath12k_warn(ab, "time out while waiting for get fw stats\n");
> +err_unlock:
> +
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}

Shouldn't we return an error if there's a timeout?

> @@ -8202,8 +8242,18 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
>  
>  	/* TODO: Use real NF instead of default one. */
> -	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
> -	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	signal = arsta->rssi_comb;
> +
> +	if (!signal &&
> +	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
> +	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
> +				      WMI_REQUEST_VDEV_STAT)))
> +		signal = arsta->rssi_beacon;
> +
> +	if (signal) {
> +		sinfo->signal = db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;

Can this be simplified to:

if (db2dbm)
        signal += ATH12K_DEFAULT_NOISE_FLOOR;

A lot more readable.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

