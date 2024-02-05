Return-Path: <linux-wireless+bounces-3132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10105849F5A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38191F2191E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4B3CF7B;
	Mon,  5 Feb 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHvPP3sb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34E3CF4B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149837; cv=none; b=jl2QUqIe+myPvoVu06kRxMJsPEFBo6E2PWp3lCiQ1t8JuGdlqYQyVDxiAs18ecUrBMrtQQOgQdWhBs2bj793tf0qFxADHWVwYSojLCPdpMXfTla2Waf9bZXbDYKn9EMEAsch630NHU5QuyOprPqEEelJvCNn8NIj7Jt7eQFPSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149837; c=relaxed/simple;
	bh=zlF1znOg4DaD2qj2azQ5lGme9OlhIk2O3oHaH5uFPpI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tTFEtb2Pe99G+tBQpdFupugOyOMzPahKaiZb5Uep/uo5rJOualxeAZxxYy3uTmI9eD8m9fDIq+X3ysNFUduHsHPE6ymFfTFznxb6HR6ZT4uCdxBJoaprNr8KGmjeWJSo2z305OlPvG9lsl5LA1I0JFhBvOuAf9VGra5FkveRCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHvPP3sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6FFC433F1;
	Mon,  5 Feb 2024 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707149837;
	bh=zlF1znOg4DaD2qj2azQ5lGme9OlhIk2O3oHaH5uFPpI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dHvPP3sbpckVuCgj6s1HL+X/rO6HxRqZyaoeMm31VvqdHMKEoyPQUedKgs0p5jVAS
	 TmUGg8VYACmXEnDShszkXATDMxuoM+zaGwyvDehH/kmC0gAxKIHeUFNn8agy2A4PrV
	 a3OVOR4KlhUvpN6gL/NOQkonwC1Cyvefky6xM1Ry39Tc1eRYMznweSMWv2U3KvbdrL
	 PZCLMNM14ovw8sGLMZ6ZQJr12l6TfG2rgqvnLCFRIejekguGd+rFejtiiBZvm1cRkm
	 bfA5SIwjtp9xb2JTie5j7aYC/QFu5D9UFNGZ6LyiJqF6zh/w23KmH+HACO+S3McFT3
	 1ZIXdcnT2SkWw==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] wifi: ath12k: add P2P IE in beacon template
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-5-quic_kangyang@quicinc.com>
Date: Mon, 05 Feb 2024 18:17:14 +0200
In-Reply-To: <20240130040303.370590-5-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 30 Jan 2024 12:02:56 +0800")
Message-ID: <87bk8usx6d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> P2P Element is a necessary component of P2P protocol communication.
> It contains the Vendor Specific Information Element which includes
> the WFA OUI and an OUI Type indicating P2P.
>
> Add P2P IE in beacon template, and implement WMI interface for it.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

[...]

> +static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
> +				       u8 oui_type, size_t ie_offset)
> +{
> +	size_t len;
> +	const u8 *next;
> +	const u8 *end;
> +	u8 *ie;

Reverse xmas tree and you can merge next and end:

const u8 *next, *end;
size_t len;
u8 *ie;

I changed that in the pending branch.

> +	if (WARN_ON(skb->len < ie_offset))
> +		return -EINVAL;
> +
> +	ie = (u8 *)cfg80211_find_vendor_ie(oui, oui_type,
> +					   skb->data + ie_offset,
> +					   skb->len - ie_offset);

So cfg80211_find_vendor_ie() returns:

static inline const u8 *
cfg80211_find_vendor_ie(unsigned int oui, int oui_type,
			const u8 *ies, unsigned int len)

You are casting away the const here. I see that other drivers do the
same as the assumption is that the pointer points to the same buffer,
but I still don't really like casting away const. Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

