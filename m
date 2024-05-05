Return-Path: <linux-wireless+bounces-7194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4E8BBF80
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544A6B21039
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD623B0;
	Sun,  5 May 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="TUNoZ7RS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A62F2E
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714891385; cv=none; b=hb18tscUCynSE2Hy+Ffge0wq6SXxmEaGbxiG7FVfzQ5RbXoqmwclCCyjOjjgSr4A4RB6FvM/iNVot+1oWRy2sYnDzDQIGFedotgGxZnLPALPJtiwZ+SBZpVJuLHofc4IPksAaoZiyOcVMyvPy1tVfh0wpXNX34ipxo36Gyoet3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714891385; c=relaxed/simple;
	bh=fmHo1PLbHgjfJSGAK+2e+Eh928jGQrU5NW7xx5vVsow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0xduNqxxj2nJAR9SgjSp1M5dOeoHK60fjwm2EE91fIGPugZ4eqqtLT3ovuMDuepvu+4rzmEvhMcd2N80QC2hNdQTfvCsvzuUFLvZ+mngn+jW9lkMLG44YrLp7mBawcEelmrFhq/NB183L/IoH1FEOA+1DCrZzNvQTQPqqokcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=TUNoZ7RS; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F107E301070
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:43:02 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D1D7380006F;
	Sun,  5 May 2024 06:42:54 +0000 (UTC)
Received: from [192.168.2.14] (80-61-14-254.fixed.kpn.net [80.61.14.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BE97113C2B0;
	Sat,  4 May 2024 23:42:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BE97113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1714891373;
	bh=fmHo1PLbHgjfJSGAK+2e+Eh928jGQrU5NW7xx5vVsow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TUNoZ7RSdNFaw6l5FUw7Kvd3v62yX/nmgHS7k3Zq5Xx0S/+oAA6AWlRTJUl8IYBOA
	 /7pAeDfLP2BJHT+2FdWJc611PHCgP9ns3etbvguFYBzHymV/chRv0gPgIaXS/DkzQ9
	 AVxtrixo91AfGdXhcEx3mQgX98hFpSML/1+feoMY=
Message-ID: <eddcf755-361e-16ee-b21d-dd261882be98@candelatech.com>
Date: Sat, 4 May 2024 23:42:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 07/15] wifi: iwlwifi: mvm: consider FWs recommendation for
 EMLSR
Content-Language: en-MW
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
 <20240505091420.2fd3387882eb.I7a8a5b24658744ed732bfc03b1872c9298483d62@changeid>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240505091420.2fd3387882eb.I7a8a5b24658744ed732bfc03b1872c9298483d62@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1714891375-YhyJMj9JCyB6
X-MDID-O:
 us5;at1;1714891375;YhyJMj9JCyB6;<greearb@candelatech.com>;775c70c271bd600af4f0283363b2f3c0

On 5/4/24 23:19, Miri Korenblit wrote:
> FW sends a notification indicating whether activating EMLSR mode is
> recommended or not.
> Support the notification and enter EMLSR only if recommended.
> 
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   .../wireless/intel/iwlwifi/fw/api/datapath.h  |  7 ++++++
>   .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 23 +++++++++++++++++-
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +++
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
>   drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 24 +++++++++++++++++++
>   5 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
> index 0f7903c5a4df..faa7b38df9e5 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
> @@ -1,5 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>   /*
> + * Copyright (C) 2024 Intel Corporation
>    * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
>    * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
>    * Copyright (C) 2016-2017 Intel Deutschland GmbH
> @@ -89,6 +90,12 @@ enum iwl_data_path_subcmd_ids {
>   	 */
>   	SEC_KEY_CMD = 0x18,
>   
> +	/**
> +	 * @ESR_MODE_NOTIF: notification to recommend/forct a wanted esr mode,

There is a typo above 'forct'
Maybe worth fixing if you respin for other reasons.


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

