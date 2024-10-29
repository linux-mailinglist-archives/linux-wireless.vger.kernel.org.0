Return-Path: <linux-wireless+bounces-14646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316379B4E98
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15561F238CE
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B7191F7C;
	Tue, 29 Oct 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvVN1ypp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D21917F9
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217271; cv=none; b=dmog3DwNTmb7dT2viJDR+02klw9KmNrv/mUt9WVEClm7/PA+Xu78NNKbwn/Qv5oaG5mcLkDCxi2U7ZkpwQ9O5hn0PB/d2fWBJKCF4PlGuw6byj/7dW0atPWWYDZ5UykNZJ633x3kpeJTrtOTUfKEygPkeZj4+yGqrXGu2VADBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217271; c=relaxed/simple;
	bh=srsnDLnEeJ7XyGHDK/41YabXF9Jl8wpwJsAC+fdbuzU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MshY54quTacm6PGPBqpPvqwM4FJ7CRTtyeSltjtENYq9D32mb66loEeIV3Lmoi2JIpEq4LKvsNlrh6iKah/cIRtj68DBLy7EDAaDgUhAistMhgxb/Mx1YromvC/g07GWTqgvNkd+0g1puCHskinTyDVnSXNJIqpFZ1uGNP5DSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvVN1ypp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C11C4CECD;
	Tue, 29 Oct 2024 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217270;
	bh=srsnDLnEeJ7XyGHDK/41YabXF9Jl8wpwJsAC+fdbuzU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VvVN1yppsQiietu2ZuwKt/4AyemtAZZcILU4Wj/x2I3SA3pePbCN/hBwo+qsX28ie
	 g/m5ZmivySEUXRtO4UDOslmPtdG1S0NPQIrCFcplJCE+8YgmN/TZ2J/Nvza7RdTatK
	 z9+ncl+Pmn4gaTlz9SMNRaKxysUiyumo8BQfcnhEo5YlsnzGilhtjp2T0WDLU/jw5u
	 wdV89ZB7Gi8LdNAh1h2y/T6sUzIP2Zlwm0hrbqdoQ7bBCq9ioLl2pnv02Ao4eXAkr7
	 nn6nuyAA75ZDxqadufJUMPM4G2Dt78jFZWnqiOjpDbpwNHtmhPrNz9uY0qPsHnwtBR
	 5O4kFCqpyfNbg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create
 command
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-7-kvalo@kernel.org>
	<f8049c99-c7ac-410c-84fd-ac844041f34c@quicinc.com>
Date: Tue, 29 Oct 2024 17:54:28 +0200
In-Reply-To: <f8049c99-c7ac-410c-84fd-ac844041f34c@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:54:51 -0700")
Message-ID: <87wmhqgb0r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>> @@ -1244,9 +1249,23 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
>>  	cmd->peer_type = cpu_to_le32(arg->peer_type);
>>  	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>>  
>> +	ptr = skb->data + sizeof(*cmd);
>> +	tlv = ptr;
>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>> +					 sizeof(*ml_param));
>
> using the same TLV size both here and for the TLV that follows doesn't seem
> logical. is this missing + TLV_HDR_SIZE to account for its own TLV header?

I have forgotten the details of WMI voodoo so I can't really comment
right now :)

>> +	ptr += TLV_HDR_SIZE;
>> +	ml_param = ptr;
>> +	ml_param->tlv_header =
>> +			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
>> +					       sizeof(*ml_param));

But did you notice that here is used ath12k_wmi_tlv_cmd_hdr() and it
reduces the header size:

static __le32 ath12k_wmi_tlv_cmd_hdr(u32 cmd, u32 len)
{
	return ath12k_wmi_tlv_hdr(cmd, len - TLV_HDR_SIZE);
}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

