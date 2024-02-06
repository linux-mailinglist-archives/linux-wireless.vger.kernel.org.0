Return-Path: <linux-wireless+bounces-3243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C584BAA4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CDF281E48
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189813474F;
	Tue,  6 Feb 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjKMHjPa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DB13474D
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235902; cv=none; b=BuZeIKuyz8bAtRwYe96CKE25Oi+hggHFAYC5zBUZ/u/m4v4M7X4fnGwjiLiBJICwZ4FtySJrzNc5Zzhh4SYRDWNDJwd8S/q6swHOvPrpn+oyTfbbkoerZ9dkTnNHIZ+MJ64Ta8+qYHjRSWQCcrvJSlS2fiN3WKW2ZxnjLrYvLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235902; c=relaxed/simple;
	bh=dKQfTXfvG8cGa5lY/uzQknr/REsIGK2mbN9pDOH9C5U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SqmPsMSQ08PbiMgTN7VmxD75DzZuREKhLG1AkVvy5WCrAk3Gwq0EX86J3z5yFCI5KXC7ZXb+nMIUI59QLp4d8Sbn0a2JJ+SMJJl2IOxxluXO4ntGDOXmVkYxZ3NK+6blKVaqfn6Q39D7OCurCDNn5wgJKAz++8XOSQxpaS57WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjKMHjPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB7C433C7;
	Tue,  6 Feb 2024 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235901;
	bh=dKQfTXfvG8cGa5lY/uzQknr/REsIGK2mbN9pDOH9C5U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NjKMHjPaLssBXXJSFcRnztAM/ssE0iPsEMvPz69cHHWw1wNplvJY3q/F6cuMFl4gj
	 Tai66IcvasuZP0b6Q8Alco2sOJzOPPTqFNklNlQuq7MXOtOf4KjHQ+/MZjSFfVy4CM
	 wqBJ8MnO3kOLTXxLaAsg3NbWMzj67egu/bJPXeAMg7vKdfbsiOfUy9WclKJb9OLseB
	 ny38hvMhHdJV+XxYMrxr+atxnP9XHp7MaszGB5NsgQFtufeNFxO+DzZRjaFhf8jbHk
	 ozdC0L6e+cuRaGnsyHS3W8z0/bz1g8YgO92nsFXvOu7g/ovRuJOvO9h5wRufC32yKf
	 J+loMTd690U9g==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA event
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-6-quic_kangyang@quicinc.com>
Date: Tue, 06 Feb 2024 18:11:38 +0200
In-Reply-To: <20240130040303.370590-6-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 30 Jan 2024 12:02:57 +0800")
Message-ID: <87plx9r2rp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
> signal its absence due to power save timing, concurrent operation, or
> off-channel scanning. It is also used in the P2P Presence Request-Response
> mechanism.
>
> The NoA attribute shall be present in the P2P IE in the beacon frames
> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
> or when the CTWindow is non-zero.
>
> So add support to update P2P information after P2P GO is up through
> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>
> Create p2p.c and p2p.h for P2P related functions and definitions.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

[...]

> +static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
> +				    struct sk_buff *skb)
> +{
> +	const void **tb;
> +	const struct wmi_p2p_noa_event *ev;
> +	const struct ath12k_wmi_p2p_noa_info *noa;
> +	struct ath12k *ar;
> +	int ret, vdev_id;
> +
> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
> +
> +	if (!ev || !noa) {
> +		kfree(tb);
> +		return -EPROTO;
> +	}
> +
> +	vdev_id = __le32_to_cpu(ev->vdev_id);
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
> +		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
> +	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
> +	if (!ar) {
> +		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
> +			    vdev_id);
> +		return -EINVAL;
> +	}

Aren't we leaking tb here? In this function I revamped the error
handling to use the out label to make sure we are freeing tb in every
error. Please review:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=12e182b47078a48169e873c51d438d7417e7e0c8

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

