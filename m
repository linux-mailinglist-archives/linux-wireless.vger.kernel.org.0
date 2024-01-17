Return-Path: <linux-wireless+bounces-2094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C78306FA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4986A1C24252
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1085A1EB55;
	Wed, 17 Jan 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDr34NIk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11491EB45
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497757; cv=none; b=bDjymuN+SWMO0Ku3rpQm76qtzpiTtxT+hYZzpRt5HUzoJCusNIEA0mdTm2bhzvJIhe5VG+1fP8eJoK6j/pVseSqhAkl1VbQLAU1dVG75lotdaXqtC6698nC1O6UHbSeJRGzaU5M/GHbWrvNKT/xK2yY1QXrwaJNBAx/EDtge7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497757; c=relaxed/simple;
	bh=5MaC06DyRKdoDd/JrP6Svdd+kkMv0hjjAGKODA055TU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=tRnsPDdBHhs5U+fXo2tzWVuXH2OdStAX4YtzG6sWbpgBeyqy01Rhix8DdCIZJdJux/rWtKHKIHJxx13U/oABPZtWoH1Ufr0vPazDNBolYogcE4wdLSy5PVv7YDVLyKfMzPDAf4lte2O2jBHxtd+fxsi+Yn96G5hOuiPhA//DrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDr34NIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A54C43394;
	Wed, 17 Jan 2024 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705497756;
	bh=5MaC06DyRKdoDd/JrP6Svdd+kkMv0hjjAGKODA055TU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VDr34NIkGaAdf0kdamE+1LFea3I+18FhyIilo4Q17cVR7Dkso0HbY3dLpf3jwEn5i
	 B/PRD/lMnLJ1icgmDvTgp6Bbnbzyul9WyqvuS/Dp4njwVQXOY1zjE/oY4u0A6W2FcV
	 xkfGMvs8SYlnpjjaT51PZMfhUAakS6ioR9PzynRa5uY57hL4BZ1u3rkxTx6g2+MS2J
	 JA4LKfwrQw3keCoacN7DxLfBELbEs6JAi+U4OgiPytqhP29mMlteo1dqrhGxGm8nlj
	 7mOnqFUY6zmVX+aibVRBiPKSGy2Im/Zt+YdRutUxFrY2MIGg+bFZ8nQBjA/v3lcXYl
	 a3sh1TGiznnSQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 03/10] wifi: ath12k: implement handling of P2P NoA event
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
	<20240112092824.7664-4-quic_kangyang@quicinc.com>
Date: Wed, 17 Jan 2024 15:22:33 +0200
In-Reply-To: <20240112092824.7664-4-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Fri, 12 Jan 2024 17:28:17 +0800")
Message-ID: <87h6jc5c2u.fsf@kernel.org>
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

> +static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
> +				      struct ieee80211_vif *vif,
> +				      struct sk_buff *skb,
> +				      bool is_prb_rsp)
> +{
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +
> +	if (likely(!is_prb_rsp))
> +		return;
> +
> +	spin_lock_bh(&ar->data_lock);
> +	if (arvif->u.ap.noa_data)
> +		if (!pskb_expand_head(skb, 0, arvif->u.ap.noa_len,
> +				      GFP_ATOMIC))
> +			skb_put_data(skb, arvif->u.ap.noa_data,
> +				     arvif->u.ap.noa_len);
> +	spin_unlock_bh(&ar->data_lock);
> +}

The if checks can be simplified and please add empty lines:

spin_lock_bh(&ar->data_lock);

if (arvif->u.ap.noa_data &&
    !pskb_expand_head(skb, 0, arvif->u.ap.noa_len, GFP_ATOMIC))
		skb_put_data(skb, arvif->u.ap.noa_data,
			     arvif->u.ap.noa_len);

spin_unlock_bh(&ar->data_lock);

Though I'm not really fond of the idea having pskb_expand_head() call
within the if check but I guess it's the cleanest option here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

