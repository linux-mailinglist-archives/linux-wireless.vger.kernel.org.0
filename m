Return-Path: <linux-wireless+bounces-7734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239CC8C72A9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED231F225C6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9DD6BFBF;
	Thu, 16 May 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdTN5r8j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F043AD1
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847594; cv=none; b=ahEh+Iqo3JrnCsiNc3lYdaEio3HSrkZbzsMHeE0nFIGWNJ/EPZ8ayG1YFynEb9zGRqtywn8I582q5QvtmeGtcfhWpPQIa6ZRwBdnJ0sXvdNOXSAyTV9/WLEvnVTrj9JzxHy1O/Kta9tOlHciOxHaWZH5Aaie2r0dLHX2IiBK2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847594; c=relaxed/simple;
	bh=uKJ0ei/23sbNLAzUj5EOdb5bqG72jG0ee62qjGHzJig=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IewuRHivBm1mhtoQS1BbsETfloveV6JWtAWWOZ28YC4J3QRyRJWZoLTmjc5ACNj2st8k956tU/bwEgyizymMRK+7AinX/+C3JLw6URKJtwUmVp2OWFKvJ4u6ZH3yE33UKdjxC8oizJCbob/K3Fw4oynRe0VU7twTFB9vym0esEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdTN5r8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5A7C113CC;
	Thu, 16 May 2024 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847594;
	bh=uKJ0ei/23sbNLAzUj5EOdb5bqG72jG0ee62qjGHzJig=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HdTN5r8jkkIbGg9Dmx7hVJTK19QMOPN8j3PAUeqTyoMta/VUDoIuwVrumsXhUclNX
	 Bj24PQ8/pEFo8QD1EJ94QEC1X0iFk1KkyD4fHsmn/hI1gg3uGsJK1V9OLzK8C1b37d
	 Uevr9ol7rR2g0Sp3lfDUmIy94Y2Y15urZ3YcU/5yrgJC7+bEodoiKmHd9ozJzXbpp9
	 3WpmBOWPa5Cnz2JXrJsNyKGX4NY60hfK9Tw4139sk9CBK0IyoRBzpINUW6zpYryEv1
	 J8ZcTNJRFJu4iB+xk2f+IQYPQcub7XmVNaTDtVVQdgCZDEf1Sehia6xUM6kJ/r0FWT
	 GgfkAqgYgyUBQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
References: <20240510070427.206152-1-quic_nithp@quicinc.com>
	<13d762da-ad16-43b4-b0ca-15e5e17af5cb@quicinc.com>
Date: Thu, 16 May 2024 11:19:50 +0300
In-Reply-To: <13d762da-ad16-43b4-b0ca-15e5e17af5cb@quicinc.com> (Jeff
	Johnson's message of "Fri, 10 May 2024 10:01:09 -0700")
Message-ID: <87zfsqgod5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/10/2024 12:04 AM, Nithyanantham Paramasivam wrote:
>
>> We observe intermittent ping failures from the access point (AP) to
>> station (STA) in any mode(AP-STA or Mesh) configured. Specifically,
>> the transmission completion status is not received at Tx completion
>> ring id-4(WBM2SW ring4) for the packets transmitted via TCL DATA
>> ring id-3. This prevents freeing up Tx descriptors and leads
>> to buffer exhaustion.
>> 
>> Currently, during initialization of the WBM2SW ring, we are directly
>> mapping the ring number to the ring mask to obtain the ring mask
>> group index. This approach is causing setup failures for WBM2SW
>> ring-4. Similarly, during runtime, when receiving incoming
>> transmission completion status, the validation of the ring number by
>> mapping the interrupted ring mask. This is resulting in
>> validation failure. Thereby preventing entry into the completion
>> handler(ath12k_dp_tx_completion_handler()).
>> 
>> The existing design assumed that the ring numbers would always be
>> sequential and could be directly mapped with the ring mask. However,
>> this assumption does not hold true for WBM2SW ring-4. Therefore,
>> modify the design such that, instead of mapping the ring number,
>> the ring ID is mapped with the ring mask.
>> 
>> According to this design:
>> 1. During initialization of the WBM2SW ring, mapping the ring ID
>> to the ring mask will ensure obtaining the correct ring mask group
>> ID.
>> 2. During runtime, validating the interrupted ring mask group ID
>> within the transmission completion group is sufficient. This
>> approach allows the ring ID to be derived from the interrupted ring
>> mask and enables entry into the completion handler.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> should be
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Kalle can fix this in 'pending'

Fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

