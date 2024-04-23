Return-Path: <linux-wireless+bounces-6710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B58AE135
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718CD1F22AFE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C25915C;
	Tue, 23 Apr 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXDtNpoB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E859151
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865371; cv=none; b=oS8gQw+yaslg5Qkhkt+HFGgwR247OrgYv4oapCH0uIa2WT62cVg+QVB/C3StXCC8TxX7Lv4ZKmQHKzfAubmp2DQdqXq4HBjoX/t/xvbzvzrsWX5Ma5o1pjGDaxugFo7C9scQb6GtIHbjcvO/U3GDN3IcpNpGoKSKd6oKxDK+LRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865371; c=relaxed/simple;
	bh=0NEJcL4Fu4kFtcHzsuxbPRyIY+LtD3O0HgV9YNRZ+30=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O8yFgaTsfbLPK/naHLANRvApQCU9m7RhiuJ+FRMwxb4WaFhr0fVRKdAOMSOETVCy1ij+ZL6/sAuIQ2xwHKVHoBGeuaNeqN/w3ewwNngp6LKEvfZu1/nTtN70OCulto6ctEkktAaYjOjeV9tnT/nZTnNrSQ3AgWI+EGO+c7ccVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXDtNpoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C8C116B1;
	Tue, 23 Apr 2024 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865371;
	bh=0NEJcL4Fu4kFtcHzsuxbPRyIY+LtD3O0HgV9YNRZ+30=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EXDtNpoBkeaGMvmR58Cp8HKlK7Y+VEj7m0q4Z2wFw/L3xmcTS0NjD8P4mN7Wfwc7a
	 S1dRwwOFlFqXF9ZXeuy/IhEU3s7a5LdpzWiIYdb7rmLUQp5DiszD3qcMDYcy6nXqvB
	 nGtYAVmTU1gMlMzvgK5aEUoRC7W9VT4vYObxANT9U89A5/4qzrjNujnczJF2Ypa3XL
	 rVfDopcUdqFA3XCKMzUUpNztu5/2XffZN9RBkIPLbt81uBuRBjz0hTzOmMQ70Gj8ZQ
	 HvewLxMTozHPJMK6l2TCbhQ7mOsWI4RCs1xek3RJrXhojPtyh1rYxS5+WFf35xTueT
	 XPd56HJhjEFkQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: Nicolas Escande <nico.escande@gmail.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: drop failed transmitted frames from
 metric calculation.
References: <20240419170314.3117623-1-quic_kathirve@quicinc.com>
	<D0QHV8UV73N5.2N5E3MH37JQW7@gmail.com>
	<f4c65f7e-ccc7-4a0b-a6e8-df56d5c19d7f@quicinc.com>
Date: Tue, 23 Apr 2024 12:42:48 +0300
In-Reply-To: <f4c65f7e-ccc7-4a0b-a6e8-df56d5c19d7f@quicinc.com> (Karthikeyan
	Kathirvel's message of "Mon, 22 Apr 2024 22:27:45 +0530")
Message-ID: <874jbsv2hz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> On 4/22/2024 1:35 PM, Nicolas Escande wrote:
>> On Fri Apr 19, 2024 at 7:03 PM CEST, Karthikeyan Kathirvel wrote:
>>
>>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
>>> +	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
>>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
>>> +		/* The failure status is due to internal firmware tx failure
>>> +		 * hence drop the frame do not update the status of frame to
>>> +		 * the upper layer
>>> +		 */
>>> +		dev_kfree_skb_any(msdu);
>>
>> Shouldn't this be ieee80211_free_txskb ? I'm not clear when to use
>> which.
>
> Yes, there is an internal patch is in pipeline, that will take care of
> addressing all dev_kfree_skb_any() to ieee80211_free_txskb() in
> ath12k_dp_tx_complete_msdu(), this patch doesn't take care of that.

Let's not add new bugs knowingly. Please fix this patch to use
ieee80211_free_txskb(), that is much more reliable than waiting for some
other patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

