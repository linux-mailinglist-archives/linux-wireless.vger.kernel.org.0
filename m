Return-Path: <linux-wireless+bounces-3690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE8858355
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2431F220D6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751C13172C;
	Fri, 16 Feb 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcEbXpC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC609130E27
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102943; cv=none; b=Vx2KqBDiJS7vcipr3Ke9L2tR2ZO4Lnj6SrO4nQgFxFd5Wb43s0h6mSU8pbbiBUxM06VUl2aRt3DS8fWrL6ygEmxl5z29gUFxSd6LerpfAe6AJOisjs97NgNfJesdeN84jGQiNbAG0ZdudZ8fRGRKURB9UJyMvFISf5WApJr3ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102943; c=relaxed/simple;
	bh=Xd1k6B3rpvnjzH8dFWRFqXG1PC4qd/CXfj52QbnAOJA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VYq2ry/YSLxz5plQOcrg69ywZkDWaukrK9j0CK1L0uY/4+Nq0cXZyYcbhnz9Lv8AZAaZzp1ugXyyBAgasuyQLJ6rBx42pHUTWs/OMSS95lX9/qVFTzza5eJz82AoQ/nGyqNdEnX/PO5vRQQfJcw2TsS8FbE1sTgce0QLUDhkiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcEbXpC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A94C433F1;
	Fri, 16 Feb 2024 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102943;
	bh=Xd1k6B3rpvnjzH8dFWRFqXG1PC4qd/CXfj52QbnAOJA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jcEbXpC7e4fSVcPe1/JrT3CbiRRmmg3veIxCcQa27RQSPwTAY+0DerAzQv+3fdXWl
	 zT1ldA09oy3qud4JrJ+ux4CxWbelYIoILkPIQ2EnRXHOpbfCdNmw9rUqd9AW8lWdWg
	 o6z7w7zmfgER1H23ayhPHGX10a9so8kEC0YtRiX1EZggSWEipqPDVtfTPwQMuXlSUK
	 C2rp43VGYM2CDqfRQmmhsCKxXWbl7djk+ZF8zhqu3k/ZRenXe65FEdJXLX6zHUbxw0
	 EMZiIkWYlk52otP8K2gzAhe+lRYUUUdUo0VA0u02oteuZthpUbRC1zwdYPqiFpwa3V
	 /uze4iPUBDiRQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
	<20240206091954.4144454-4-quic_ramess@quicinc.com>
	<8734tsnz8i.fsf@kernel.org>
	<2368ff4c-374c-4203-b0f8-f8a761370310@quicinc.com>
Date: Fri, 16 Feb 2024 19:02:20 +0200
In-Reply-To: <2368ff4c-374c-4203-b0f8-f8a761370310@quicinc.com> (Jeff
	Johnson's message of "Fri, 16 Feb 2024 08:45:56 -0800")
Message-ID: <87y1bkmjfn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 2/16/2024 8:35 AM, Kalle Valo wrote:
>> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>> 
>>> From: Sriram R <quic_srirrama@quicinc.com>
>>>
>>> When mac80211 does drv start/stop, apply the state change
>>> for all the radios within the wiphy in ath12k.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> 
>> I haven't reviewed the patchset fully yet, first quick impressions:
>
> I didn't review it at all since it has a dependency upon a series that
> needs rework, and hence I figure this series will require rework.

Makes sense, I'll then mark this as Changes Requested in patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

