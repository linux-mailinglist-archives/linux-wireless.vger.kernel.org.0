Return-Path: <linux-wireless+bounces-8487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F18FBA0C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 19:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF27628206A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3C149018;
	Tue,  4 Jun 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auWON5ek"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A6146D6E;
	Tue,  4 Jun 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521074; cv=none; b=PPmOHRhxLKY746hpMlMtRywFxEEje8ftMlWk0+TlEx2ZxDa0WxsctDWLsm0V6mmKFhvv74JVKl7XmrZWWfRW6SDXpehiCLnE/rHh99PEtknSI6UoNN/FOswWTbENxDp5eMb71jUq5BGH5+R5RBKcnR/V3jU4J3HWs1HGEA9mINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521074; c=relaxed/simple;
	bh=H8UiO5YVsMUV3dpcXaV7RJ4HXiezpq63ohVSu9LX0MU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AuFpHLYWwZ6XlezuPXcal83NubXYwJm32/OIgXoFiA/1OU1mPt1ysFn/rEMcNIM32YrrsrIIt8z6ib63Ilcd8gG/WeXOvl25G2YvHvnP/uIK20yh4RHgbB+IN0fq8v3COe4O0yHOF0ipRJSCclFhVoureVRiiVDEa17484FP7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auWON5ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A18C2BBFC;
	Tue,  4 Jun 2024 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717521073;
	bh=H8UiO5YVsMUV3dpcXaV7RJ4HXiezpq63ohVSu9LX0MU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=auWON5ekYAJi+KBpiWfiZcAvVuoLdEU+oVN93tpqLmMP34F4V6FUlsgO7O5eb785I
	 QiKlG8awM4H06dXVJ5XyrV7nsWyhtThT1DenWN4wd3lO29xtF40fvAjijizyjASE4A
	 RsZpKzEcfGAyrz0G/M2fn5sK8KNFz1JstwNN+2/h0+Zdom7B49aJMw58iOQTHLVTAG
	 0MOBVFPMksW6hQlur91MSVRypj5eaClKAsQb1DA9of41jOGLRnaOYc4QyqmM5Cx785
	 4A7V2qJeDFe4hym2soYM0d1g2CrLOmKQgHjIjTO4mCxLykpYbYzzG5/HLyloAGCQlx
	 HhJYfvNwC7fHA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
  <linux-kernel@vger.kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,
  <linux-wireless@vger.kernel.org>,  <ath11k@lists.infradead.org>
Subject: Re: [PATCH 1/6] wifi: ath11k: use 'time_left' variable with
 wait_event_timeout()
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
	<20240603091541.8367-2-wsa+renesas@sang-engineering.com>
	<47cc9455-6efb-4b1c-8743-c992e502633d@quicinc.com>
Date: Tue, 04 Jun 2024 20:11:10 +0300
In-Reply-To: <47cc9455-6efb-4b1c-8743-c992e502633d@quicinc.com> (Jeff
	Johnson's message of "Mon, 3 Jun 2024 15:57:28 -0700")
Message-ID: <87r0dcskep.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 6/3/2024 2:15 AM, Wolfram Sang wrote:
>
>> There is a confusing pattern in the kernel to use a variable named 'timeout' to
>> store the result of wait_event_timeout() causing patterns like:
>> 
>> 	timeout = wait_event_timeout(...)
>> 	if (!timeout) return -ETIMEDOUT;
>> 
>> with all kinds of permutations. Use 'time_left' as a variable to make the code
>> self explaining.
>> 
>> Fix to the proper variable type 'long' while here.
>> 
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/qmi.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index d4a243b64f6c..2fe0ef660456 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -2859,7 +2859,7 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
>>  
>>  int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
>>  {
>> -	int timeout;
>> +	long time_left;
>>  
>>  	if (!ath11k_core_coldboot_cal_support(ab) ||
>>  	    ab->hw_params.cbcal_restart_fw == 0)
>> @@ -2867,11 +2867,11 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
>>  
>>  	ath11k_dbg(ab, ATH11K_DBG_QMI, "wait for cold boot done\n");
>>  
>> -	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
>> -				     (ab->qmi.cal_done == 1),
>> -				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
>> +	time_left = wait_event_timeout(ab->qmi.cold_boot_waitq,
>> +				       (ab->qmi.cal_done == 1),
>> +				       ATH11K_COLD_BOOT_FW_RESET_DELAY);
>>  
>> -	if (timeout <= 0) {
>> +	if (time_left <= 0) {
>>  		ath11k_warn(ab, "Coldboot Calibration timed out\n");
>>  		return -ETIMEDOUT;
>>  	}
>> @@ -2886,7 +2886,7 @@ EXPORT_SYMBOL(ath11k_qmi_fwreset_from_cold_boot);
>>  
>>  static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
>>  {
>> -	int timeout;
>> +	long time_left;
>>  	int ret;
>>  
>>  	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
>> @@ -2897,10 +2897,10 @@ static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
>>  
>>  	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait started\n");
>>  
>> -	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
>> -				     (ab->qmi.cal_done  == 1),
>> -				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
>> -	if (timeout <= 0) {
>> +	time_left = wait_event_timeout(ab->qmi.cold_boot_waitq,
>> +				       (ab->qmi.cal_done  == 1),
>> +				       ATH11K_COLD_BOOT_FW_RESET_DELAY);
>> +	if (time_left <= 0) {
>>  		ath11k_warn(ab, "coldboot calibration timed out\n");
>>  		return 0;
>>  	}
>
> This looks ok to me, but note that changes to ath11k go through the ath tree,
> so, unless Kalle has a different opinion, this should be submitted separately
> from changes that go through the wireless tree.

As there are no dependencies to other patches I can take this directly
to ath.git, so no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

