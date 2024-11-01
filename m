Return-Path: <linux-wireless+bounces-14811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA99B92CB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7F6B21D47
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB42D600;
	Fri,  1 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhZy/pzM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B06168DA
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469972; cv=none; b=cOt19qGUvXlEu+Ho0cngPOl1IFNETGqW4+OuIQbmTl2Set0bVi/5Bcc51rHlAg4M/w4rm+Fzx+P+L9DZq0NTydbWl7agIIZC8ooN/L/aec6p+WdkKrw/sSztG1FZBsZF73bEOllvlv7ztpqcJpubOtmiLlx4rCQjpcqseirB/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469972; c=relaxed/simple;
	bh=hw08P6c0qMmSDif5XWYSxDZ+sFwdJtpv8E3VGa2FsFw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bx4IbMqHMa7PbFFLLFi75c+JAnIdRKVsBIpoiTVl/Hsg8xEIRqe5v+yo9B0k/xnUTTk4XKj3sIncmpjCqHWgmJ71CNa958DhHh59nupNb9MsAR3oFym5XMSnFkcLB/U7A07rGrLcEZO44xVoHQzaaIwY+VgiDhSA5lmUu0XLwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhZy/pzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756B5C4CECD;
	Fri,  1 Nov 2024 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730469972;
	bh=hw08P6c0qMmSDif5XWYSxDZ+sFwdJtpv8E3VGa2FsFw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nhZy/pzMEIYHMDYS6TZg9AEupTSrkrWgLoOdT8/SDEN3sz9s2+yYVY35zqjidsW2Q
	 jSZTEgEUkiFAcl8Wa5EtHkehM6v4EfA6Ydfx23aE2QXHEcfYuwbfD0kKB2pS6prWQT
	 oHi3FucEyG5aTQ4+R1gDwnHAzZyMfBiYOVEBsQhlPmP8NQgSkPxC3k3dRfB33fad3+
	 A65165KIxbQyPXIW0BVwA101HLktzFf+X1zGm5Ow9an+oHRcXA62HqZeEYEaLQv/VS
	 2ul8TCw0TLwH8gfmN0Zemvu3J+lt2PVFcXFShtlCTQsgX/oaM8OtpF3Gi9HwtmpSE1
	 j12dqja2q4a2Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create
 command
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-7-kvalo@kernel.org>
	<f8049c99-c7ac-410c-84fd-ac844041f34c@quicinc.com>
	<87wmhqgb0r.fsf@kernel.org>
	<8d4aca1d-e48d-48e2-bacf-fdfe49c8e212@quicinc.com>
Date: Fri, 01 Nov 2024 16:06:09 +0200
In-Reply-To: <8d4aca1d-e48d-48e2-bacf-fdfe49c8e212@quicinc.com> (Jeff
	Johnson's message of "Tue, 29 Oct 2024 09:01:17 -0700")
Message-ID: <87h68r6oby.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/29/2024 8:54 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>>> @@ -1244,9 +1249,23 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
>>>>  	cmd->peer_type = cpu_to_le32(arg->peer_type);
>>>>  	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>>>>  
>>>> +	ptr = skb->data + sizeof(*cmd);
>>>> +	tlv = ptr;
>>>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>>>> +					 sizeof(*ml_param));
>>>
>>> using the same TLV size both here and for the TLV that follows doesn't seem
>>> logical. is this missing + TLV_HDR_SIZE to account for its own TLV header?

So I assume you are referring to this:

	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
					 sizeof(*ml_param));
	ptr += TLV_HDR_SIZE;
	ml_param = ptr;
	ml_param->tlv_header =
			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
					       sizeof(*ml_param));

I have never figured out how WMI_TAG_ARRAY_STRUCT is supposed to work
but I see a similar pattern also in ath12k_wmi_wow_add_pattern(). Any
ideas?

>>>> +	ptr += TLV_HDR_SIZE;
>>>> +	ml_param = ptr;
>>>> +	ml_param->tlv_header =
>>>> +			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
>>>> +					       sizeof(*ml_param));
>> 
>> But did you notice that here is used ath12k_wmi_tlv_cmd_hdr() and it
>> reduces the header size:
>> 
>> static __le32 ath12k_wmi_tlv_cmd_hdr(u32 cmd, u32 len)
>> {
>> 	return ath12k_wmi_tlv_hdr(cmd, len - TLV_HDR_SIZE);
>> }
>> 
>
> Yes, I missed that since that is evil to use the _cmd_ TLV function on
> something that isn't the command TLV.

Ok, so you are saying that we should have a identical function but with
name ath12k_wmi_tlv_param_hdr() or similar? That makes sense but I think
that's separate cleanup as ath12k_wmi_tlv_cmd_hdr() is already used with
several WMI params, like in ath12k_wmi_wow_add_pattern().

> Please fix to use the standard function and subtract the thv header size from
> the length param

I'm not a fan of manually subtracting lengths, as then it's easy to miss
something. I would prefer to have functions for handling the length
calculation, like ath12k_wmi_tlv_cmd_hdr() ath12k_wmi_tlv_param_hdr().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

