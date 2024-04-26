Return-Path: <linux-wireless+bounces-6920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114268B315C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431551C220E6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3213C3C3;
	Fri, 26 Apr 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY5QuWkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767513BC3E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116687; cv=none; b=V4vf9kHTvlTuPTeTnFeNOXRcXbAsaOSTjKkIzV2xA4m0UwgqkGsbF/0iPFzXSgyp06ZEO4kgGtcq6ZLrV+N6uZTxPID6AIcYtAiwVlZKbwyx3UJxttrPYed316E4djXqDCOMTlad6LIlpSL7UQXISdTAahN8074LPrEH3ZGmeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116687; c=relaxed/simple;
	bh=isyzkTMFUUfUJHWC2RVAZbtuOQi2dD5iTcTS2iLN7cE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LskVlSnot9vgasKeUTfehkAux4HrN7EiQtvS0t80dT3T2/WP+LadFy3gmDAt/YSKaJ7EIgtmVnQTpE92/clTh84TO5HPnjaza3N5PQHR7k6imkhb3/iqMxbjOVkSCZHHA0DbxkEgk5W1UzapxpaXp6YDNWu0fcUdhbgXuW+3bHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY5QuWkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB3BC113CD;
	Fri, 26 Apr 2024 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714116687;
	bh=isyzkTMFUUfUJHWC2RVAZbtuOQi2dD5iTcTS2iLN7cE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XY5QuWkcV44TfgMONSLttEq/z7XK6MbVSxZLSX5ziO04TfvnJ9us4QUHwmdKGyjBJ
	 63LRljRq6iW+az1xZnNE+cAJgUENNjV8REkhrX39v2LHxAdZqr9JRfdVlQBT7EMhm1
	 Lujg54U44l86GAkR9MRhXPAa9u3ZkB4f32mGau+1j7qJk/y7KoQ4C1yNPkP2RpiBp8
	 0+3jeYWKzIsYLSdsuJGVsV32vF5J9gGqhrINaOH/tbAcbuuIfwCusuMt7xctBAZAH3
	 L2NZSZ65AJcNZc5CcXJDeZ8IdJXS1kzcBbKqI1Za9vPa9jYY+eDF+2xX+P932IbX5V
	 dsWk//oX0ovWA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Muna
 Sinada <quic_msinada@quicinc.com>
Subject: Re: [PATCH v3 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
	<20240424201959.935-8-quic_pradeepc@quicinc.com>
	<72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
Date: Fri, 26 Apr 2024 10:31:24 +0300
In-Reply-To: <72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com> (Jeff
	Johnson's message of "Thu, 25 Apr 2024 15:32:14 -0700")
Message-ID: <87y190fulv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/24/2024 1:19 PM, Pradeep Kumar Chitrapu wrote:
>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>> Reuse parts of the existing code path already used for HT/VHT
>> to implement the new helpers symmetrically, similar to how
>> HT/VHT is handled.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> 
>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
>
> [...]
>
>> @@ -7753,7 +8034,20 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
>>  			return false;
>>  	}
>>  
>> -	if (ht_nss_mask != vht_nss_mask)
>> +	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
>
> drivers/net/wireless/ath/ath12k/mac.c:8041:22: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    expected struct ieee80211_sta_he_cap const *he_cap
> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *

ALWAYS run ath12k-check, we wrote the tool for a reason. Skipping these
tests is disrespect for maintainers' time and a great way to get your
patches to the bottom of the queue.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

