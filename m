Return-Path: <linux-wireless+bounces-3624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1718561B2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D0B1F2283E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9B12FB39;
	Thu, 15 Feb 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBuiQTs6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA912FB32
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996764; cv=none; b=XPxlCAJGFDQOPUlPzLDxejCdq0ewLlg5F695+m82MMTfiijn2hN7RaLUhWfZItCUvnKxiQn5SVZn/ClNKW6MOrMbfSTBvoRwZOEyDCov7YyS2nV85ChP+6FBLBVEHN28xcvVcdjXxHhZwD2YfkYqVgC2h2RgG2fO2SqYY+yXf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996764; c=relaxed/simple;
	bh=Y75MeSiVwPc8AkG3sXMXhAT4eHoFE1miiimyMA/OJ7M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uFvrogu0pzDo/bif/eTbqnpeXUyBVw5Wzc33rQEkFOvn26Bb8EpxRKwLU4UBbp3sRUKH8CO0g3tCElHoFKemu0EEBeeGmMAS/AJIGAhWuWwpVY7ID7OHV7xvfC47oFuMU2fJgqjqQbVktYb53kNW6jhz6ZUSI3qK/wnWd6P3u3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBuiQTs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A250C433C7;
	Thu, 15 Feb 2024 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707996764;
	bh=Y75MeSiVwPc8AkG3sXMXhAT4eHoFE1miiimyMA/OJ7M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rBuiQTs6ju7+wsFmHunT5vuKkQT1FKtI8m5SXkyx1vL3Mpecw+3E1EdRwzihtCYZo
	 bIl7HXM0qJ0qqv3tVQYsORBAk++LPn5jrZnZoXnN2ZqCDpq7+p0RtZ72jIL0h+ewmO
	 l9sIn27n5wNC1+QyCZEQ2W2b32Vw3u30kYaPiD6bYK6siPXGbH6WAppY2h+MpOYeP1
	 blh5fVeeeYrKAJGurZ1CMVppgEA7WU/V69YI9RoXiXBgj6KzLu+GV9lQTXTw1UgdXS
	 jcdM0MbF6PZLGb0IzlorhPPGRgz4f+wiQOWty8RjCWc3n14FiWz1rPrOtJ20OcDMJT
	 VLrYlb7rMGDIQ==
From: Kalle Valo <kvalo@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: ath12k@lists.infradead.org,  Raj Kumar Bhagat
 <quic_rajkbhag@quicinc.com>,  linux-wireless@vger.kernel.org,  Ganesh Babu
 Jothiram <quic_gjothira@quicinc.com>
Subject: Re: [PATCH v3 12/13] wifi: ath12k: Read board id to support
 split-PHY QCN9274
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
	<20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
	<23399810.6Emhk5qWAg@ripper>
Date: Thu, 15 Feb 2024 13:32:41 +0200
In-Reply-To: <23399810.6Emhk5qWAg@ripper> (Sven Eckelmann's message of "Wed,
	14 Feb 2024 15:17:11 +0100")
Message-ID: <87bk8inesm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sven Eckelmann <sven@narfation.org> writes:

> On Monday, 29 January 2024 07:57:23 CET Raj Kumar Bhagat wrote:
>> diff --git a/drivers/net/wireless/ath/ath12k/fw.c
>> b/drivers/net/wireless/ath/ath12k/fw.c
>> index fbcf40c97792..5be4b2d4a19d 100644
>> --- a/drivers/net/wireless/ath/ath12k/fw.c
>> +++ b/drivers/net/wireless/ath/ath12k/fw.c
>> @@ -119,6 +119,13 @@ static int
>> ath12k_fw_request_firmware_api_n(struct ath12k_base *ab,
> [...]
>> +		case ATH12K_FW_IE_AMSS_DUALMAC_IMAGE:
>> +			ath12k_dbg(ab, ATH12K_DBG_BOOT,
>> +				   "found dualmac fw image ie (%zd B)\n",
>> +				   ie_len);
>> +			ab->fw.amss_dualmac_data = data;
>> +			ab->fw.amss_dualmac_len = ie_len;
>> +			break;
>>  		default:
>>  			ath12k_warn(ab, "Unknown FW IE: %u\n", ie_id);
>>  			break;
>
>> @@ -371,16 +375,43 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
> [...]
>> +	if (dualmac) {
>> +		if (ab->fw.amss_dualmac_data && ab->fw.amss_dualmac_len > 0) {
>> +			/* use MHI firmware file from firmware-N.bin */
>> +			mhi_ctrl->fw_data = ab->fw.amss_dualmac_data;
>> +			mhi_ctrl->fw_sz = ab->fw.amss_dualmac_len;
>> +		} else {
>> + ath12k_warn(ab, "dualmac firmware IE not present in
>> firmware-N.bin\n");
>> +			ret = -ENOENT;
>> +			goto free_controller;
>> +		}
>
> I saw this now already multiple times that the source code was referencing the 
> firmware-N.bin (like we had with ath10k). But they aren't published anywhere. 
> I can't find a single one at:
>
> *
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k
> *
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath12k
> * https://github.com/kvalo/ath11k-firmware
> * https://github.com/quic/upstream-wifi-fw
>
> So I find it odd that the new code now seems to depend on it without actually 
> providing these files anywhere.

For example, firmware-2.bin will be used for qrtr id to support multiple
devices on the same host.

> Might be good to have these soon in linux-firmware.git.

Yeah, we will but just slowly. We are currently moving
ath1?k-firmware.git repos to a new location, firmware-N.bin files should
start emerging after that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

