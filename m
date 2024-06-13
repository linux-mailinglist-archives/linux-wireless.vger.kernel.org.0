Return-Path: <linux-wireless+bounces-8973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9B9073BD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFFB24E17
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49211422DD;
	Thu, 13 Jun 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTm/+VA2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801381422AB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285437; cv=none; b=jqrDdIx/twsl9aD68ywSlfSIYeICJKuXxIT4bAs0yMfFg1JAPLue7yUhjk4qzOqGvTy2FEd6oZERHE8ZSKWpBEvZFaFurLPCu1ZZ7/1G3B23352sO1/+Bt1X/7+GJWIEQvsnhx0ZVVBOy0N1BJ31FKchq0jjf8CGh1ZQZqWBUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285437; c=relaxed/simple;
	bh=OEAhHd+pUhFkMT+aGEvAyJitpB0TMqS13pSWrHHwhao=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fvgfdzG+q9JzNtH7RfurCPSRWzF8iyg7Siict3K0JuxnsE303KHHQE8ywVkWoSPOaJG4clfrpBX3wDefUi7ziW/ujpu14+AhEkTFRpnJA6RhXluXsVJOpYv894ZrYkXg6BCrZLbLmcoq9mLP2T+Vbc3ol/F7/KO5rAeuRXF8dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTm/+VA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CDC2BBFC;
	Thu, 13 Jun 2024 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718285437;
	bh=OEAhHd+pUhFkMT+aGEvAyJitpB0TMqS13pSWrHHwhao=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eTm/+VA2ROb2ec3EV6ZCggZrv2b3mQfO9VRGY8x6Id6yzcXYxmraWpe6/sJCWoqHD
	 lraG6DgVyqPpDyqQN6p3f6gAuM3Rx2jrjRDqul7b8n5oaV/ug3XCS3ltOo07n5iSKD
	 PZLWoMi1Fz2v98IJmQ34AlabRFrAtNdvp3eLapDVgvkzoLDStK8hXYAa8nwxKZLLtb
	 7PG8Rcw65IG3Id0ei5Rqz0cAvNwdSwJV9CEaXbzIfGASdIJuddQM5xvZ+42oPjSHw8
	 Ukynh0yqzDFCnC+S6wmfam7Heoqs33QiGjCue4L6RkkFyV4GtkMi4UOvGA9rvPH9uG
	 9NUrmRR8ROkEw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Aaradhana Sahu <quic_aarasahu@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] ath12k: Factory test mode support
References: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
	<cd77058f-7165-4342-893b-a59a3a18c3c5@quicinc.com>
Date: Thu, 13 Jun 2024 16:30:34 +0300
In-Reply-To: <cd77058f-7165-4342-893b-a59a3a18c3c5@quicinc.com> (Jeff
	Johnson's message of "Wed, 12 Jun 2024 09:51:32 -0700")
Message-ID: <875xudnf5x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 6/11/2024 1:34 AM, Aaradhana Sahu wrote:
>
>> Device is booted in factory test mode for calibration.
>> The commands are sent from userspace application, which
>> is sent to firmware using wmi commands. Firmware sends
>> the response to driver as wmi events and driver sends
>> these events to the application via netlink message.
>> 
>> Also added changes related to correct pdev id access for
>> fw test cmd.
>> 
>> Aaradhana Sahu (3):
>>   wifi: ath: create common testmode_i.h file for ath drivers
>>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>   wifi: ath12k: add factory test mode support
>> 
>> Rajat Soni (1):
>>   wifi: ath12k: Fill pdev id for fw test cmd
>> 
>> ---
>> v3:
>>   -Rebased on latest ToT
>>   -Updated Tested-on Tag
>>   -Removed second parameter of ath12k_core_start()
>>   -Updated copyright
>> v2:
>>   -Rebased on latest ath ToT
>> ---
>> 
>>  drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>  drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>>  drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>  drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>  drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>  drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>>  drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>  drivers/net/wireless/ath/ath12k/testmode.c    | 422 ++++++++++++++++++
>>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>  drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>>  drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>>  .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
>>  13 files changed, 634 insertions(+), 74 deletions(-)
>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)
>> 
>> 
>> base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
>
> FYI this series is not applying cleanly in my tree for validation:
>
> Base: using specified base-commit a116bf2be795eb1db75fa6a48aa85c397be001a6
> Applying: wifi: ath: create common testmode_i.h file for ath drivers
> Using index info to reconstruct a base tree...
> Patch failed at 0001 wifi: ath: create common testmode_i.h file for ath drivers
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> error: patch failed: drivers/net/wireless/ath/ath11k/testmode_i.h:4
> error: drivers/net/wireless/ath/ath11k/testmode_i.h: patch does not apply
> error: Did you hand edit your patch?
> It does not apply to blobs recorded in its index.
>
> I initially used b4, but tried again directly with git, and it failed for me 
> with both mechanisms.
> Kalle, do you have any issues with this series?

Also fails for me on top of commit a116bf2be795:

Applying: wifi: ath: create common testmode_i.h file for ath drivers
Using index info to reconstruct a base tree...
error: patch failed: drivers/net/wireless/ath/ath11k/testmode_i.h:4
error: drivers/net/wireless/ath/ath11k/testmode_i.h: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 wifi: ath: create common testmode_i.h file for ath drivers

Setting the patchset to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

