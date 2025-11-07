Return-Path: <linux-wireless+bounces-28689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC1C41F23
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 00:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E02B56053F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B92F0678;
	Fri,  7 Nov 2025 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nV/v4ubQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F02ECE9D
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557925; cv=none; b=be/GKNZcXcxQpa3BdYEcp4ngUI4qxNF1TOeWRlqJ+wsFpyfBWkVfMDsGaBM6qDGIsx61Vp8k0HAqyphGiiQAaijtbwrqRCNRo8sZAnEmQML8QIYJI98nV7pihjcfEaOL1jqzyOv22gf486ZCs0iu3zWHipfbZx/HcbmQd2yLFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557925; c=relaxed/simple;
	bh=t+zkSQX569Kum7Wpg8B6qH5F9ZPPc/kv9ljhJlfE/QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjUDfB0VfuBDQ+6ZcYGywyoD5EP0+LqxvSNdmnPhBdRpb04rFpldscx5uCfyCXkvSLco6RrDt7D6rVEisz/oVUrhnGydQ1kyPdSBfPefvMSjRheHd3m2YHB/CUVW4C/HzzgJiq9moFg0GaQyIrpiO9OxfCe8VwhyckpDeInnyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nV/v4ubQ; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C75EF2AE0F2
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 23:16:57 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6AE79B80069;
	Fri,  7 Nov 2025 23:16:48 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E064A13C2B0;
	Fri,  7 Nov 2025 15:16:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E064A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1762557405;
	bh=t+zkSQX569Kum7Wpg8B6qH5F9ZPPc/kv9ljhJlfE/QU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nV/v4ubQjkLBcJde/V7Qo3BuAA2DH5OnPms8Fua4Pt+gPRNSDZ69uRCbjZpKtrgyK
	 +sCIoObZfkppAZqei+SqwUt24gHuO7jWJRT/uQhZ95zKQMoQ1JCC7/yqJCUPRujOM7
	 J6qXxJ95LiCIqxlwqcaqCk7OsnFYrT5cCjSWJsgY=
Message-ID: <11cca5db-28c5-a57c-78c5-7084afd92509@candelatech.com>
Date: Fri, 7 Nov 2025 15:16:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: support for
 COMPRESSED_BA_RES_API_S_VER_7
Content-Language: en-US
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-wireless@vger.kernel.org
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
 <20250430155443.c4be90e242ff.Ie8a0f0d6320613bd8c5cb6c82a063069fffa3b67@changeid>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250430155443.c4be90e242ff.Ie8a0f0d6320613bd8c5cb6c82a063069fffa3b67@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1762557409-TjfndhSMi9gf
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1762557409;TjfndhSMi9gf;<greearb@candelatech.com>;164575d057495991bbcad51b50c00bde
X-PPE-TRUSTED: V=1;DIR=OUT;

On 4/30/25 05:57, Miri Korenblit wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> The rate format changed but since we don't use the rate, just claim
> support for this new API.

Hello Emmanuel,

I'm interested in using the tx_rate to provide tx histogram stats for
mcs, nss, etc.

Could you please share the rate format?  I'm specifically interested in
Intel be200 on kernel 6.18 and higher.

Thanks,
Ben

> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 8 +++++---
>   drivers/net/wireless/intel/iwlwifi/mld/notif.c | 3 ++-
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> index 0a39e4b6eb62..50d1c590044f 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>   /*
> - * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
> + * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
>    * Copyright (C) 2016-2017 Intel Deutschland GmbH
>    */
>   #ifndef __iwl_fw_api_tx_h__
> @@ -701,7 +701,8 @@ enum iwl_mvm_ba_resp_flags {
>    * @rts_retry_cnt: RTS retry count
>    * @reserved: reserved (for alignment)
>    * @wireless_time: Wireless-media time
> - * @tx_rate: the rate the aggregation was sent at
> + * @tx_rate: the rate the aggregation was sent at. Format depends on command
> + *	version.
>    * @tfd_cnt: number of TFD-Q elements
>    * @ra_tid_cnt: number of RATID-Q elements
>    * @tfd: array of TFD queue status updates. See &iwl_compressed_ba_tfd
> @@ -730,7 +731,8 @@ struct iwl_compressed_ba_notif {
>   		DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_tfd, tfd);
>   	};
>   } __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
> -	       COMPRESSED_BA_RES_API_S_VER_5 */
> +	       COMPRESSED_BA_RES_API_S_VER_6,
> +	       COMPRESSED_BA_RES_API_S_VER_7 */

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



