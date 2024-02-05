Return-Path: <linux-wireless+bounces-3133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A090F849F69
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FD81C22019
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DE3FB32;
	Mon,  5 Feb 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGh1UuRU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC03FB02
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150248; cv=none; b=KfYw4TNdo1vW9XyP8Z97syGgxSYURSNhVB6/FC5xRNFND+xr1FKlrvSyVX3bZTsL3awm4+KGM1ZebAuTuz8q9igUNx9+s0R+lQCmiMemhrjXWwOCnJjZe0DuYUcmQR1s4udVE//bXyuMQ/YY4jI+XLuxwjUfe9R07CCD3sDma2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150248; c=relaxed/simple;
	bh=v7AU24VzKraCBd9j291earvac56Soww+i2i5g1Bnvuw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WObJIKx1SjD34VFslEYhW922Rww1lESkMU1kNYv2Z8G7OjOFj+rvoaQvkqcq+/xXJmXiA+9U4xkSBLA8S6AdnKM4FSm93JPx3dWudTfpVjI1rI/mmTv3/p0O0wux9o51NoDG2A5vPnPGC8NYh0za/Ptwb5LvWxVDJ/zoNKMsUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGh1UuRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BB7C433C7;
	Mon,  5 Feb 2024 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707150247;
	bh=v7AU24VzKraCBd9j291earvac56Soww+i2i5g1Bnvuw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nGh1UuRUeJrxTP+hguCUJezPFeTVkzHZVyBfTMid8io5kVcZyCddMWRVOu45s/G/n
	 D+a2MK4amj8FLxM9WV9XvFRTH/KNge/hbB4IsVyakeOKGxa6qwtCf5oannU9/bm1tZ
	 f1+8Bc0Kfq4G1E4KnDWF4LBcFNz6rfHLQlC+d6QMVtBaIMHGm79KUmMitDMzrEv6A6
	 oJ5iOPFA2KtBaJ64d8nSm9tpMTdC7F03mUUxMrE2HPVAsQZri7ZpeqEvw5b9J9FG6u
	 5WLPBZe0ocOpnyehmGBHHiU+ghtmNRWXIIUImiNd++WShTyX8l+xQcuXez6AT34B02
	 TtF32duCnAsVA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kang Yang <quic_kangyang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] wifi: ath12k: add P2P IE in beacon template
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-5-quic_kangyang@quicinc.com>
	<f947f804-6fd1-41eb-8b6f-c562d51e5441@quicinc.com>
Date: Mon, 05 Feb 2024 18:24:04 +0200
In-Reply-To: <f947f804-6fd1-41eb-8b6f-c562d51e5441@quicinc.com> (Jeff
	Johnson's message of "Tue, 30 Jan 2024 09:02:54 -0800")
Message-ID: <877cjiswuz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/29/2024 8:02 PM, Kang Yang wrote:
>
>> P2P Element is a necessary component of P2P protocol communication.
>> It contains the Vendor Specific Information Element which includes
>> the WFA OUI and an OUI Type indicating P2P.
>> 
>> Add P2P IE in beacon template, and implement WMI interface for it.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

[...]

>> +int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
>> +			     const u8 *p2p_ie)
>> +{
> ...
>> +	ptr = skb->data;
>> +	cmd = ptr;
>> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_P2P_GO_SET_BEACON_IE,
>> +						 sizeof(*cmd));
>> +	cmd->vdev_id = cpu_to_le32(vdev_id);
>> +	cmd->ie_buf_len = cpu_to_le32(p2p_ie_len);
>> +
>> +	ptr = skb->data + sizeof(*cmd);
>
> IMO better would be: ptr += sizeof(*cmd);
>
> Kalle can probably adjust this in the pending branch

Yeah, I changed that.

But I think even better would be to avoid pointer arightmetic and do something
like this:

struct wmi_p2p_go_set_beacon_ie_cmd {
	__le32 tlv_header;
	__le32 vdev_id;
	__le32 ie_buf_len;
        u8 tlv[];
} __packed;

tlv = cmd->tlv;
tlv->header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARRAY_BYTE,
					     aligned_len);

But that's separate cleanup, I see pointer arithmetic used quite a lot
in wmi.c.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

