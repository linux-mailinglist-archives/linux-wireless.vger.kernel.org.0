Return-Path: <linux-wireless+bounces-3252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047F84BCCC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 19:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D096828957E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF812B8B;
	Tue,  6 Feb 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIoxyOzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185212B71
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243429; cv=none; b=LpxG6ZCJqgvBNiIjm1eylRfYZPwz5Mc929GiM6j0RguxCaQsCzmIp3mBLvQZBAwQucNe/CRef3v1nFAH6riv4hPRTF6clWNSgWZK0fley2lCUs5kqiMG2gyZy8dUfPaUlgU4Zz6vieqkUK5QOjnW7TDs4m+Yxfu79uTMNGdZOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243429; c=relaxed/simple;
	bh=xRt41RhooFxuADCIIziuiKc9zziCs/ZmRVcIu4XkzKA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HUsBzPvGAUczzjt6OsW48Ta3VHEqlfHgzAmya57op5pq7la24/hCr2b5t34roBAk57wMWTx8+yCnZ+ozuyg/mXsHu+XO/3KvpsDDpChRyoE/F7z3jAistf7EUUO+CWO33W9kiq+QtEICOSk+fXfinVx9UWBWqPGACtA2zu9K73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIoxyOzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9960C433C7;
	Tue,  6 Feb 2024 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707243428;
	bh=xRt41RhooFxuADCIIziuiKc9zziCs/ZmRVcIu4XkzKA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LIoxyOzEoxdhwfk2gzwON9tBZO4x4rSvzL7IrhVvRL9h+KZFfAY2ZpxZ6WiZHAzML
	 t0eXd39bjcW6S+VjAw0Oe2RobvsT1u6GMVtmZM+ewpZLE8iHaD8HVeKMBdbh27xQcM
	 e1hf72zlSzmrV14a1sxCDr1hRfsvPwIRvx+XBmmXSBkdzkgcSl8A3GFfU6jF30rkqI
	 Fk9UP/UkOMqb1/LDlWD5epmY6Xo1g+lqkiQ5VmP0SAZR5zP89wG1BGKzpSynF87Wwk
	 gQG4vNBupjepvmVFwDggKDVBmA/A8DJUTK2Hcy1DzCAkPYdqK9ZSBqubZ5VB3lWn31
	 BNAfT6bgQ3mFQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA event
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-6-quic_kangyang@quicinc.com>
	<87plx9r2rp.fsf@kernel.org>
Date: Tue, 06 Feb 2024 20:17:05 +0200
In-Reply-To: <87plx9r2rp.fsf@kernel.org> (Kalle Valo's message of "Tue, 06 Feb
	2024 18:11:38 +0200")
Message-ID: <87eddpqwym.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Kang Yang <quic_kangyang@quicinc.com> writes:
>
>> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
>> signal its absence due to power save timing, concurrent operation, or
>> off-channel scanning. It is also used in the P2P Presence Request-Response
>> mechanism.
>>
>> The NoA attribute shall be present in the P2P IE in the beacon frames
>> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
>> or when the CTWindow is non-zero.
>>
>> So add support to update P2P information after P2P GO is up through
>> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>>
>> Create p2p.c and p2p.h for P2P related functions and definitions.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>
> [...]
>
>> +static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>> +				    struct sk_buff *skb)
>> +{
>> +	const void **tb;
>> +	const struct wmi_p2p_noa_event *ev;
>> +	const struct ath12k_wmi_p2p_noa_info *noa;
>> +	struct ath12k *ar;
>> +	int ret, vdev_id;
>> +
>> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
>> +	if (IS_ERR(tb)) {
>> +		ret = PTR_ERR(tb);
>> +		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
>> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
>> +
>> +	if (!ev || !noa) {
>> +		kfree(tb);
>> +		return -EPROTO;
>> +	}
>> +
>> +	vdev_id = __le32_to_cpu(ev->vdev_id);
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
>> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
>> +		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
>> +	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
>> +	if (!ar) {
>> +		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
>> +			    vdev_id);
>> +		return -EINVAL;
>> +	}
>
> Aren't we leaking tb here? In this function I revamped the error
> handling to use the out label to make sure we are freeing tb in every
> error. Please review:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=12e182b47078a48169e873c51d438d7417e7e0c8

I realised that ret was uninitialised when no error, new version:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=43f3069f6580b8a67969a6f32377d35aa7dd8d9a

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

