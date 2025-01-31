Return-Path: <linux-wireless+bounces-18246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D47A240FC
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 17:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD2E1882170
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB11E503D;
	Fri, 31 Jan 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKHbWpjH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590953D66;
	Fri, 31 Jan 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342014; cv=none; b=I/G3bTiToHA4vEMe6Vt2ARawQsxLo3Pol1VWdBNuTdr8CqV1hAjTtaKx/9frUVkhvEbeHXc3kJ09Panl6Ll60qTzAuxsRjyx8gpryT0lIXLyKlHNAVgjKGyjaYZHx7Cw1/jtadpFqP9AOn09D2hn7qin7nYmWL8coLckh94rHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342014; c=relaxed/simple;
	bh=vENTkhAyyWu3ElGHpdhddiC1S+MyS5AcNV/4io49NuA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ljq1il7QDXpWI4V4BlA20G9roZLsnk9yn06+2ocex0BLYBKpT0xCowomTv6ppaSAL0RZuef7l2Bm6v4PZwaykS2n8KEds4JlcFhdNAr/bG9wCkqgBX9Ex19btxH+1eWf12k29xYBiNQFjr1qrIRd9LgmmnH8/RxVRse80t/edYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKHbWpjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F6C4CED1;
	Fri, 31 Jan 2025 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738342012;
	bh=vENTkhAyyWu3ElGHpdhddiC1S+MyS5AcNV/4io49NuA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NKHbWpjHn+AWnlAkf2fD20ABO13nWSriwVDbGYKlXdoSQ1tZ/YSs93iZ1nw2AVyva
	 uzrIE+h7qNyPpAk+kKI3JuzKWyYNoLHRaMm4Y7Eh9cSsscsnE5yWdmudxKt+Ym4tZD
	 fwGcKxCBrvT22QsMt5ArzTqkqBCt8NVorFxe1QMNOYAgbKILHEdup4cZLoBYa979Rk
	 +8qR/SoLZ6nQNVIR96otwuoj8ddURBT32bLSO3SNzZmgiR9NMxLlZEy7wRut7/kwE8
	 NuFNBfYbozBVKAB5ww9mAF2C6IATM7KtgQKr6PbEydIwNIeZO5TW3hYq2eEQ0CnC+t
	 FWzvklWUImeHw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,  Remi Pommarel
 <repk@triplefau.lt>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jeff
 Johnson <jjohnson@kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
References: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
	<9c12e9b9-35a4-47f1-bd17-6b4641de92a4@oss.qualcomm.com>
	<Z5s9CO_mmazq2Kg1@pilgrim>
	<94db4020-b1c7-4aee-b22c-6fe6d357e593@oss.qualcomm.com>
	<a1a65ff7-bb5c-4c90-98b6-7155b58e89c0@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 18:46:49 +0200
In-Reply-To: <a1a65ff7-bb5c-4c90-98b6-7155b58e89c0@oss.qualcomm.com> (Jeff
	Johnson's message of "Thu, 30 Jan 2025 10:57:30 -0800")
Message-ID: <874j1fgccm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 1/30/2025 1:18 AM, Aditya Kumar Singh wrote:
>
>> On 1/30/25 14:19, Remi Pommarel wrote:
>>> On Thu, Jan 30, 2025 at 12:21:54PM +0530, Aditya Kumar Singh wrote:
>>>> On 1/29/25 22:25, Remi Pommarel wrote:
>>>>> Currently in ath12k_mac_op_sta_statistics() there is the following
>>>>> logic:
>>>>>
>>>>>       if (!arsta->txrate.legacy && !arsta->txrate.nss)
>>>>>           return;
>>>>>
>>>>> Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
>>>>> if it return for empty legacy and nss of arsta->txrate, then the other
>>>>> stats after it will not be set.
>>>>>
>>>>> To address this issue remove the return and instead invert the logic to set
>>>>> the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).
>>>>>
>>>>> The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
>>>>> remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
>>>>> commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
>>>>> mac_op_sta_statistics").
>>>>>
>>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>>
>>>> MISSING_BLANK_LINE
>>>> 'Tested-on:' tag missing blank line after it.
>>>>
>>>> You missed v1 comment? :)
>>>
>>> Yes sorry I think your mail never reached me, did you CC me ? Do you
>>> need a respin ?
>>>
>> 
>> No problem. No need of respin just because of this. I think Jeff can fix 
>> in pending?
>> 
>> It's strange that the v1 reply appears to be delivered from my mail box 
>> and it is sent to the list. I see even Jeff replying to that. But none 
>> of those are captured in patchwork. Not sure.
>
> it was only sent to the ath12k list
> perhaps you need to include linux-wireless@vger.kernel.org

Yeah, patchwork only follows linux-wireless.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

