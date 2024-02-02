Return-Path: <linux-wireless+bounces-3029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A784704B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522B21C21042
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE92A140783;
	Fri,  2 Feb 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZcBYhVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39E140795
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876868; cv=none; b=Wm9gChOpyxEHk8MnTEyXAbA3dEvYpQlswiMscAS+Dk0zmHmmiG89TmZauB7L/9c5j5/Q/NVbG9xb1My+uFIgmJRMq8ZT5cClijvEKbyuVRqWipDIHQK2YGn4bmEbdBL7qxZUq7eiFrUVOtKjdKTbu54vW7XzXCPkTpMR7CJA43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876868; c=relaxed/simple;
	bh=4+Tcqf7flwEe/Wihkl7auL2+mJsPDzRGCARCAnx0HDQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N0VsIH6VTDPc0PLAMcOi7AhRwpQAQXA+5RwgtWiTWJSwOefYN3I64u2fKPhZtDOIZDOnJJcXsgJxPmIzAoti6+CFGg0KjBAc8/RfBQXDjwhykvpDndXMgw1yPxk1pjeTqv+CpcUa6LaAzoCBzNUMRT/kZOKWhYw+zVwu8NtkfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZcBYhVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7710DC43390;
	Fri,  2 Feb 2024 12:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876868;
	bh=4+Tcqf7flwEe/Wihkl7auL2+mJsPDzRGCARCAnx0HDQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oZcBYhVetNgRqy0DqkE0VFQmZDURpoxSzAcn5HzU3GBv79dhEKLb+GHqj5vJqhbJs
	 PEbZ3jOsXZkqGquMNxpjafKCwBibOYys8DC9czykF+zuj1ULc/vvbc49PWKJptles3
	 7Dr3jSulOEcYQ6pinYR9CxlcNGwl3IekRKYaMgd0+DbOlqW+Zi4Gm6FhURtrtiF4Mn
	 pwP3lwF9oCrQYZ3kqXwz490lepFfM+NbOlOYxKCrJaxGKHF5grpqmNgVYdvjdY+b8v
	 N3jXTWVvwGE1XvTlr312+nXpi850pmubDrjTnI7yoLHFEseOjcxRHmjBnvIxM1yDID
	 S7OgaHCh7RFeA==
From: Kalle Valo <kvalo@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: Re: [PATCH v3 09/13] wifi: ath12k: subscribe required word mask
 from rx tlv
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
	<20240129065724.2310207-10-quic_rajkbhag@quicinc.com>
Date: Fri, 02 Feb 2024 14:27:45 +0200
In-Reply-To: <20240129065724.2310207-10-quic_rajkbhag@quicinc.com> (Raj Kumar
	Bhagat's message of "Mon, 29 Jan 2024 12:27:20 +0530")
Message-ID: <87eddvt5j2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>
> Most of the RX descriptors fields are currently not used in the
> ath12k driver. Hence add support to selectively subscribe to the
> required quad words (64 bits) within msdu_end and mpdu_start of
> rx_desc.
>
> Add compact rx_desc structures and configure the bit mask for Rx TLVs
> (msdu_end, mpdu_start, mpdu_end) via registers. With these registers
> SW can configure to DMA the partial TLV struct to Rx buffer.
>
> Each TLV type has its own register to configure the mask value.
> The mask value configured in register will indicate if a particular
> QWORD has to be written to rx buffer or not i.e., if Nth bit is enabled
> in the mask Nth QWORD will be written and it will not be written if the
> bit is disabled in mask. While 0th bit indicates whether TLV tag will be
> written or not.
>
> Advantages of Qword subscription of TLVs
> - Avoid multiple cache-line misses as the all the required fields
> of the TLV are within 128 bytes.
> - Memory optimization as TLVs + DATA + SHINFO can fit in 2k buffer
> even for 64 bit kernel.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

[...]

> +static void
> +ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
> +{
> +	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info10);
> +
> +	info = u32_replace_bits(info, len, RX_MSDU_END_INFO10_MSDU_LENGTH);
> +	desc->u.qcn9274_compact.msdu_end.info10 = __cpu_to_le32(info);
> +}

Don't we have le32_replace_bits()? That would simplify this function.

No need to resend because of this, but a followup patch cleaning this up
would be nice.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

