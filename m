Return-Path: <linux-wireless+bounces-14654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A909B4EDB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7119283FB2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD512191F66;
	Tue, 29 Oct 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWaiNASh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E91917E7
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217947; cv=none; b=X9kVxu+poPUfCVGt72kifiW93i4BWSPGZfXYfVmqmSN8R9ftKLx5E+4OxhQGmOCyawjogYpWN67s1ullr28yMVraqMorMGaGeynxBu6juQePyPkIGjRreVgIpdnyxRgJY+dVLu3o0cGImjufKBysXOTi1/IUFel12syJQD9MmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217947; c=relaxed/simple;
	bh=XL2+U+EzgMjaP48cjHi1XHjDe4cfV6tfigF6VPzXcxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Qby/1kYoPFi7u4XW0/UBmvqYzeC7WoMxH3yc8DOHQylXYIiPJNqb/Yb2MlfpZ+RB3pdznC3d2esuByNht/5Y4CzXbasIaHSbTKGE1pslSo4qZG03//3T1XsYX64LwN9x6jcr8MqrY173V1KgUfY0nau9TnYp22jxK1r0CUpbdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWaiNASh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7588AC4CECD;
	Tue, 29 Oct 2024 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217947;
	bh=XL2+U+EzgMjaP48cjHi1XHjDe4cfV6tfigF6VPzXcxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MWaiNAShUDKh4Z+qpU1IS8mMXXbSuv+9YVPptx6qPX2aohxSqTOt/oM3VNd2GKnz1
	 G+g4OOCaNTbjTINxYplv7QRC4HoELDnVn1N3iDW7YbieAgnIBCSiHyBpFuQI9nFBor
	 ikOYfMqpsSTDzBpQk2C0rlQz4Iu4lknMQMTAReqM7sIt6fZJS000CnNz8yTl42F/Qf
	 K1K6hzaSt5t9leVMq2MVvVK5ADw5WKjG8dPFu9PckG6f0xecLCEK3ExMF9g6Qd5IuH
	 +Wx3HTaqTVSgLS26eajMIJfmEQinZvs6PpELJaPZqsqvYyO+ERiY+4NQdvZq8PBKo9
	 mjXij+Yjj47nQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 8/8] wifi: ath12k: Add MLO peer assoc command support
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-9-kvalo@kernel.org>
	<cb386a9b-2290-4640-8f08-7834cf4e79df@quicinc.com>
Date: Tue, 29 Oct 2024 18:05:44 +0200
In-Reply-To: <cb386a9b-2290-4640-8f08-7834cf4e79df@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 09:10:09 -0700")
Message-ID: <87o732gahz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/23/2024 6:30 AM, Kalle Valo wrote:
>
>> +	rcu_read_lock();
>> +
>> +	i = 0;
>
> nit: setting i=0 doesn't need to be RCU protected

Yeah, but that doesn't cause any issues and this way it's closer to the
for loop where it's used:

>> +	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
>> +		if (i >= ATH12K_WMI_MLO_MAX_LINKS)
>> +			break;

[...]

>> @@ -2243,12 +2251,38 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>>  		ptr += sizeof(*he_mcs);
>>  	}
>>  
>> -	/* MLO header tag with 0 length */
>> -	len = 0;
>>  	tlv = ptr;
>> +	len = arg->ml.enabled ? sizeof(*ml_params) : 0;
>>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
>>  	ptr += TLV_HDR_SIZE;
>> +	if (!len)
>> +		goto skip_ml_params;
>>  
>> +	ml_params = ptr;
>> +	ml_params->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_ASSOC_PARAMS,
>> +						       len);
>
> this is another instance where we are using the same length for two
> consecutive TLVs -- that doesn't seem right

This is also a similar case of _hdr() vs _cmd_hdr(), does that look ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

