Return-Path: <linux-wireless+bounces-14875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1B9BB310
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E7A282426
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080541B4F0F;
	Mon,  4 Nov 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAEsJC+4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0D1B3933
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718832; cv=none; b=Rn+jQztjMr/nc/Wvzxv0BHdm6CElPV4N8NhD7x8xaxcNBzNppuI71I8t+yhtSd3gFdl8hDbJMGpYU0ltdGsge6LTO4Fgeij8bkbzoJtkuZGZMlk7+6vnlr2ZQbfFNpnzJMCfEDF/4av1gw+nFq9yDgz/UYoACo51/Nyt8xjyeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718832; c=relaxed/simple;
	bh=X9Es2YNbaqU6K64HSrwfnFwfae6RM4V8eJVc5Imb+DI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oXUu3rDrgl6/DGb7BXznVpC4meCIDwImsOMUW4vGA2BeK/rwEeK72pYSeSYf0xho1Ty9+dqizwatgqv89Dxum+qxel5j7USGXS1Z9AdroyrkgK0VdEgXgh870+KTBmfD6BcKMK0aEmtxl6u0wO0pSJ9OC2CCSEoKV4+iV9iWRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAEsJC+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB56C4CECE;
	Mon,  4 Nov 2024 11:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730718832;
	bh=X9Es2YNbaqU6K64HSrwfnFwfae6RM4V8eJVc5Imb+DI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aAEsJC+4lnHKbqlEpohYUwFCxUQk+VHwRzxM/glkoGCJoOuM12qSB94A7w7KyfRf8
	 Ifsp10ok8E3WeM+MTjyNe9DW1X6duAEABzIbGZEXrg8SU12uMBrkwZEqgiTiEUfXqu
	 DEd7V7XhyDU3IJy4+QR/Pooh0Q5SmjC20nmObRJRaqxF8/3ekLj40T1yBOYLZ9Eks0
	 5/a5TwMAVVFJ6+X++CTnYBZALIwP9kheUjrq+WbXsMM5U8zUy//SJUfAXxLfVVINkX
	 3ZYKPOesthI58+vNUb1/2HKmDfnot68ZIGaucg5Gb7fbvPgASBJb3eUB1X3FtdMUa4
	 1bTnvHVq2Mftg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] wifi: ath12k: MLO support part 2
References: <20241101151705.165987-1-kvalo@kernel.org>
	<935b7f88-a48f-48b5-9e5b-b333cafec25f@quicinc.com>
Date: Mon, 04 Nov 2024 13:13:49 +0200
In-Reply-To: <935b7f88-a48f-48b5-9e5b-b333cafec25f@quicinc.com> (Jeff
	Johnson's message of "Fri, 1 Nov 2024 09:51:59 -0700")
Message-ID: <87ttcn6yky.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/1/2024 8:16 AM, Kalle Valo wrote:
>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> Here we continue to refactor mac.c to support multiple links and extend peer
>> assoc WMI command to support MLO.
>> 
>> Please review.
>> 
>> v2:
>> 
>> * patch 1: use err_vdev_del
>> 
>> * patch 2: ath12k_mac_mlo_get_vdev_args(): switch
>> wiphy_dereference()
>> 
>> * patch 2: use struct ath12k_wmi_mac_addr_params instead adding struct wmi_mac_addr
>> 
>> * patch 3: ath12k_mac_station_post_remove(): assign
>> ahsta->links_map before rcu_assign_pointer()
>> 
>> * patch 3: ath12k_mac_station_unauthorize(): fi* confusing comment about __sta_info_destroy_part2()
>> 
>> * patch 4: debugfs.c: copyright year
>> 
>> * patch 5: ath12k_peer_mlo_create(): remove parenthesis from the
>>   warning message
>> 
>> * patch 5: ATH12K_ML_PEER_ID_VALID: move to peer.h and rename to ATH12K_PEER_ML_ID_VALID
>> 
>> * patch 5: rename struct ath12k_peer::ml_peer_id to peer_id
>> 
>> * patch 5: use ath12k_peer_ml_*() naming style in peer.c
>> 
>> * patch 7: improve commit message a bit
>> 
>> * patch 7: struct wmi_peer_assoc_mlo_partner_info: add _params to name
>> 
>> v1: https://patchwork.kernel.org/project/linux-wireless/cover/20241023133004.2253830-1-kvalo@kernel.org/
>> 
>> Kalle Valo (2):
>>   wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
>>   wifi: ath12k: introduce ath12k_hw_warn()
>> 
>> Sriram R (6):
>>   wifi: ath12k: MLO vdev bringup changes
>>   wifi: ath12k: Refactor sta state machine
>>   wifi: ath12k: Add helpers for multi link peer creation and deletion
>>   wifi: ath12k: add multi-link flag in peer create command
>>   wifi: ath12k: add helper to find multi-link station
>>   wifi: ath12k: Add MLO peer assoc command support
>> 
>>  drivers/net/wireless/ath/ath12k/core.h  |  25 ++
>>  drivers/net/wireless/ath/ath12k/debug.c |   6 +-
>>  drivers/net/wireless/ath/ath12k/debug.h |   5 +-
>>  drivers/net/wireless/ath/ath12k/mac.c   | 504 +++++++++++++++++++-----
>>  drivers/net/wireless/ath/ath12k/peer.c  | 115 ++++++
>>  drivers/net/wireless/ath/ath12k/peer.h  |  12 +
>>  drivers/net/wireless/ath/ath12k/wmi.c   | 191 ++++++++-
>>  drivers/net/wireless/ath/ath12k/wmi.h   | 115 ++++++
>>  8 files changed, 848 insertions(+), 125 deletions(-)
>> 
>> 
>> base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2
>
> with this series I see a new warning with gcc:
> drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_bss_assoc':
> drivers/net/wireless/ath/ath12k/mac.c:3080:1: warning: the frame size
> of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

What GCC version are you using and can you privately share your .config?
I'm guessing it's coming from peer_arg which was already in
ath12k_bss_assoc() before this patchset:

	struct ath12k_wmi_peer_assoc_arg peer_arg;

And indeed it's a large struct, we shouldn't allocate that from the
stack.

> we should clean this up with a subsequent patch

Agreed.

> I'm taking the current series into 'pending'

Thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

