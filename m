Return-Path: <linux-wireless+bounces-6555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A020C8AA794
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 06:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEAD1C242AD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41E946C;
	Fri, 19 Apr 2024 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyikg3T9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7679F9
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713500170; cv=none; b=sS8MIP/+zj+N3SS/T7ZLJOaffGszKnpccNmTWKOadtPchck/el2Im/ZsYC+ZuGgtSIOT/lqpeth1nyIdEew50O/9BTTSVarxyNM99YKWpqrDNKNyjWzRIwvBCCT9Ll9Gbe/Yispi4NKeo06/C9Ab+JY8DzFSbW77FNvWwTaN+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713500170; c=relaxed/simple;
	bh=VDSdyBPL2K1RF8ChwR1cpTQb7PqWJtUVtC/o9MaNRHY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YMky9LqEaIChAOPrl6GvJVlNz+DGTNrEydzYCxSnlvb5AtjGJmv4VASx/TIV8uYXNX5H/9zpfHqM6zdawyhr5LgviXLeYuv2yGynAeBvJGaGab/1jEJ+xg3sWtgmUhLO2aL0Sh3UBxEA5lJTJMrxGSMIIOdwRLfARE3IeS5dNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyikg3T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F339C072AA;
	Fri, 19 Apr 2024 04:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713500169;
	bh=VDSdyBPL2K1RF8ChwR1cpTQb7PqWJtUVtC/o9MaNRHY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Lyikg3T9ZGTR/cBFvFx5NBZUrNjHjoWGwpDZBdSVwOKYmm2kuLJqK/yYUA5xUQgd8
	 omRJ8+xKjLUWY+J0gdy0KzAp4Y4FGQjvIE19qYyIFygzbygwrCfaT0bQYjrMZJQAk5
	 yLy9k7viENv1IdCm39K3+Tz3lubqTL+6q9qQq+atfS0Gk04sNE5N0XmHK80TTrPDK/
	 dhCMphSnDCzccPyzngC1kZXCIBa9vv2dba88RkKxxG4DzrNHpXIzG85iJhtEmkE6tx
	 Q3ll7mt6mEE/2A74EKtmlzaouMb6Eb1z3CEVD+4JI3H5TwBFEG3epwrkEtIgN5LG90
	 E2ao8PCbmJfHQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
References: <20240418162019.1246749-1-kvalo@kernel.org>
	<71414c51-26b2-4ce7-898c-5df0e8e31825@quicinc.com>
Date: Fri, 19 Apr 2024 07:16:07 +0300
In-Reply-To: <71414c51-26b2-4ce7-898c-5df0e8e31825@quicinc.com> (Jeff
	Johnson's message of "Thu, 18 Apr 2024 15:23:48 -0700")
Message-ID: <87h6fyhtrs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/18/2024 9:20 AM, Kalle Valo wrote:
>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> Through reading ACPI tables, implement Time-Average-SAR(TAS), BIOS SAR,
>> configuration of CCA threshold and band edge channel power functionalities.
>> This is enabled only on WCN7850.
>> 
>> TODO:
>> 
>> * test with ACPI support in hardware (I don't have such hardware), especially
>>   suspend and hibernation

[...]

> I can verify this doesn't crash my system, but apparently my ACPI doesn't have
> the underlying settings, so cannot verify actual functionality

Thanks for testing. I hope Lingbo has a device with proper ACPI settings.

> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi_evaluate_dsm() failed
> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: failed to get ACPI DSM data: -2
> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi failed: -2

I just want to verify that these are debug messages, right? Normal users
shouldn't see any ACPI errors if there are no ACPI settings in the system.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

