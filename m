Return-Path: <linux-wireless+bounces-9287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95391023B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A01AB20D91
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8231AAE1E;
	Thu, 20 Jun 2024 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnodb2Vh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473321A19
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881855; cv=none; b=h8Kkykwn2QadvUiIUtRz4YGm+MVTPJlf/w4i/zHiK7zxsKGNRg8JDWYGNHwLkIWbTSMqnDdtEUkpF8+qbUKzFDwYa9C9uKLJl9AIZMDlVJHtyp7worcNF2oWLgyJCdr4zBa6nrZiVmpaR99ZrY5sknBOEY6R6WIctDMPjma3WT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881855; c=relaxed/simple;
	bh=HaRyeGCSmJfjAMezDKhTuUXcvEjf+Qs3/osMB2Fr9Uc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UffScu0nTyPfc1qOj45qy2viGkRfRrcPSknSPAmbFj5aegMbKRyanpAvsS1MStM9LKcQH2hD5HZzjMnEycumiO5QobIANpT+eYljbYIAyrq3CW2B0CPvGdB8WwBsNeDd3xDs6bgqJuxK+Y8nLcN7Yu3u3pCJORAiIUyUPhIpNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnodb2Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBA7C2BD10;
	Thu, 20 Jun 2024 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718881855;
	bh=HaRyeGCSmJfjAMezDKhTuUXcvEjf+Qs3/osMB2Fr9Uc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bnodb2Vhu81Hg96+7GH1ZyvE770Un6qWmTRIoC2J1jN6zBF89XE+ATY17qxe+tC01
	 kNlrFIpbc9mPnRIuL3zLoTC8UgovaVs/FmRVs4XLxLcLR/547BozKHl6kRqJllgFdp
	 R7C5Y5TvDKaQOD4U1lReJAysdZGc5WXcfR0Vjo82ypTNnJfxX9bmFQDW1eCMslar5p
	 xu97TpDxYBAUddC+qIPEKjlxwiHpNC1NQwONaFSdmDlyxtyhl+b8JsRYYwOSdxavHW
	 8P9HeNI5I1aSW5/rnGu0DVQGGr93AyC2gdu2oX532oQ7vIFoCr8JpxbNcKAeEbOiXA
	 qASJvyxqGLP+w==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] wifi: ath12k: add WoW net-detect functionality
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
	<20240530072714.25671-5-quic_bqiang@quicinc.com>
Date: Thu, 20 Jun 2024 14:10:52 +0300
In-Reply-To: <20240530072714.25671-5-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Thu, 30 May 2024 15:27:10 +0800")
Message-ID: <87le2zkgxv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Implement net-detect feature by setting flag
> WIPHY_WOWLAN_NET_DETECT if firmware supports this
> feature. Driver sets the related PNO configuration
> to firmware before entering WoW and firmware then
> scans periodically and wakes up host if a specific
> SSID is found.
>
> Note that firmware crashes if we enable it for both
> P2P vdev and station vdev simultaneously because
> firmware can only support one vdev at a time. Since
> there is rare scenario for a P2P vdev to do net-detect,
> skip it for P2P vdevs.
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

[...]

> +struct wmi_wow_nlo_config_cmd {
> +	__le32 tlv_header;
> +	__le32 flags;
> +	__le32 vdev_id;
> +	__le32 fast_scan_max_cycles;
> +	__le32 active_dwell_time;
> +	__le32 passive_dwell_time;
> +	__le32 probe_bundle_size;
> +
> +	/* ART = IRT */
> +	__le32 rest_time;

What's ART and IRT in this context? The comments are supposed to answer
to questions but this is just adding more questions.

> +
> +	/* Max value that can be reached after SBM */
> +	__le32 max_rest_time;

It's good to avoid acronyms so I changed this to:

	/* max value that can be reached after scan_backoff_multiplier */
	__le32 max_rest_time;

> +	/* SBM */
> +	__le32 scan_backoff_multiplier;
> +
> +	/* SCBM */
> +	__le32 fast_scan_period;

These two comments are not really providing any extra information I
removed them.

> +static int
> +ath12k_wow_pno_check_and_convert(struct ath12k *ar, u32 vdev_id,
> +				 const struct cfg80211_sched_scan_request *nd_config,
> +				 struct wmi_pno_scan_req_arg *pno)
> +{
> +	int i, j;
> +	u8 ssid_len;
> +
> +	pno->enable = 1;
> +	pno->vdev_id = vdev_id;
> +	pno->uc_networks_count = nd_config->n_match_sets;
> +
> +	if (!pno->uc_networks_count ||
> +	    pno->uc_networks_count > WMI_PNO_MAX_SUPP_NETWORKS)
> +		return -EINVAL;
> +
> +	if (nd_config->n_channels > WMI_PNO_MAX_NETW_CHANNELS_EX)
> +		return -EINVAL;
> +
> +	/* Filling per profile params */
> +	for (i = 0; i < pno->uc_networks_count; i++) {
> +		ssid_len = nd_config->match_sets[i].ssid.ssid_len;
> +
> +		if (ssid_len == 0 || ssid_len > 32)
> +			return -EINVAL;
> +
> +		pno->a_networks[i].ssid.ssid_len = ssid_len;
> +
> +		memcpy(pno->a_networks[i].ssid.ssid,
> +		       nd_config->match_sets[i].ssid.ssid,
> +		       ssid_len);
> +		pno->a_networks[i].authentication = 0;
> +		pno->a_networks[i].encryption     = 0;
> +		pno->a_networks[i].bcast_nw_type  = 0;
> +
> +		/* Copying list of valid channel into request */
> +		pno->a_networks[i].channel_count = nd_config->n_channels;
> +		pno->a_networks[i].rssi_threshold = nd_config->match_sets[i].rssi_thold;
> +
> +		for (j = 0; j < nd_config->n_channels; j++) {
> +			pno->a_networks[i].channels[j] =
> +					nd_config->channels[j]->center_freq;
> +		}
> +	}
> +
> +	/* set scan to passive if no SSIDs are specified in the request */
> +	if (nd_config->n_ssids == 0)
> +		pno->do_passive_scan = true;
> +	else
> +		pno->do_passive_scan = false;
> +
> +	for (i = 0; i < nd_config->n_ssids; i++) {
> +		j = 0;
> +		while (j < pno->uc_networks_count) {
> +			if (pno->a_networks[j].ssid.ssid_len ==
> +				nd_config->ssids[i].ssid_len &&
> +			    !memcmp(pno->a_networks[j].ssid.ssid,
> +				    nd_config->ssids[i].ssid,
> +				    pno->a_networks[j].ssid.ssid_len)) {
> +				pno->a_networks[j].bcast_nw_type = BCAST_HIDDEN;
> +				break;
> +			}
> +			j++;
> +		}
> +	}

The while loop is just a simple for loop so I changed it to use for statement.

> +
> +	if (nd_config->n_scan_plans == 2) {
> +		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
> +		pno->fast_scan_max_cycles = nd_config->scan_plans[0].iterations;
> +		pno->slow_scan_period =
> +			nd_config->scan_plans[1].interval * MSEC_PER_SEC;
> +	} else if (nd_config->n_scan_plans == 1) {
> +		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
> +		pno->fast_scan_max_cycles = 1;
> +		pno->slow_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
> +	} else {
> +		ath12k_warn(ar->ab, "Invalid number of scan plans %d !!",
> +			    nd_config->n_scan_plans);
> +	}

I cleaned up the error message here.

> +static int ath12k_wow_vdev_clean_nlo(struct ath12k *ar, u32 vdev_id)
> +{
> +	int ret = 0;
> +
> +	if (ar->nlo_enabled) {
> +		struct wmi_pno_scan_req_arg *pno =
> +			kzalloc(sizeof(*pno), GFP_KERNEL);
> +		if (!pno)
> +			return -ENOMEM;
> +
> +		pno->enable = 0;
> +		ar->nlo_enabled = false;
> +		ret = ath12k_wmi_wow_config_pno(ar, vdev_id, pno);
> +		kfree(pno);
> +	}
> +
> +	return ret;
> +}

Avoid initialising ret variables and minimise the indentation. I changed
this to:

static int ath12k_wow_vdev_clean_nlo(struct ath12k *ar, u32 vdev_id)
{
	struct wmi_pno_scan_req_arg *pno;
	int ret;

	if (!ar->nlo_enabled)
		return 0;

	pno = kzalloc(sizeof(*pno), GFP_KERNEL);
	if (!pno)
		return -ENOMEM;

	pno->enable = 0;
	ret = ath12k_wmi_wow_config_pno(ar, vdev_id, pno);
	if (ret) {
		ath12k_warn(ar->ab, "failed to disable PNO: %d", ret);
		goto out;
	}

	ar->nlo_enabled = false;

out:
	kfree(pno);
	return ret;
}

> +static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	int ret = 0;
> +
> +	switch (arvif->vdev_type) {
> +	case WMI_VDEV_TYPE_STA:
> +		ret = ath12k_wow_vdev_clean_nlo(ar, arvif->vdev_id);
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}

ret variable is not really needed:

static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
{
	struct ath12k *ar = arvif->ar;

	switch (arvif->vdev_type) {
	case WMI_VDEV_TYPE_STA:
		return ath12k_wow_vdev_clean_nlo(ar, arvif->vdev_id);
	default:
		return 0;
	}
}

In the pending branch I did also some minor cosmetic changes to this and
earlier patches, too many to list here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

