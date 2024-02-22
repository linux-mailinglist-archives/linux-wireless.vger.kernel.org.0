Return-Path: <linux-wireless+bounces-3909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2385F652
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 11:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C402A1F2777B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94D3FB39;
	Thu, 22 Feb 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omRjDJem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121E93FB29;
	Thu, 22 Feb 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599552; cv=none; b=ohcMyYZBpyFgLTMsq8t1EU+RBnZyndEN7RvmxT+tsZRezmjtmX/5zvm9UBmP8zumtGyAhstUAObWQoyGIknaSNrN70cJ/CoxKtfCl+hCDrNJZbFsnnSLaQgAhnzztMEvhk2WtMC/OmyHz2kBmYzSZN145vSAxWWDGYeHAREg8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599552; c=relaxed/simple;
	bh=8uKXIIq+57AP92dwfZNmDVdF4jqKSHFIMjUXeV36MpM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ABGyiWbSL9jrX3dbxrh4fIzKQxp8NzL2zM34MyYWlSrfuuhOMZPV1E8zY4/agURi1MRvwoEom84ettfOhqny1K70q+FsaJhlrOOSNih6Oe17y2DLGWfKFJKJXZ8CujG3xx9bhdwUODKDSIPCe5VX6gTbr5u8mFMEd98/00Vrvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omRjDJem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885F8C433F1;
	Thu, 22 Feb 2024 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708599551;
	bh=8uKXIIq+57AP92dwfZNmDVdF4jqKSHFIMjUXeV36MpM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=omRjDJem6uP+DLeBOLh3O4B+YqjAoiLdHAYWnMiRuXqGgthmpPmu2VM4MWZirmnx/
	 iodb8N78PlcIP8D3auMBLfHIvwEaemts2P5qOL4hcBMxvSeWvYPZbw6l5KEKUod2d9
	 4Rj3Gu0AoCIZLCxQYOPMbHdDCDB/nmw/H30WgTofJJ9HLqyU32xNhBy4CEamnUbZ1D
	 P0LBwL2Nud7Bp2oBuQiyzBnda7w/8bUCI7R2/CvoBoY0Y4N8IkImpBpK24BNzA4aSj
	 1DTg8Bid6jM0ElzWW4dFNnjhz0zPjrYr9HBczpX/18aIet1p1dnk1QdBA/ixFdugDg
	 3Fo21g9/XzS/g==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>,  <netdev@vger.kernel.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-02-20
References: <20240220165842.917CDC433F1@smtp.kernel.org>
	<20240221143531.56942c6e@kernel.org>
	<2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
	<b25a5783-a9ca-4356-ae17-bbda1340b522@quicinc.com>
	<20240221172521.4dcb382c@kernel.org> <875xyhaxs2.fsf@kernel.org>
Date: Thu, 22 Feb 2024 12:59:08 +0200
In-Reply-To: <875xyhaxs2.fsf@kernel.org> (Kalle Valo's message of "Thu, 22 Feb
	2024 07:11:25 +0200")
Message-ID: <87wmqwahoj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Wed, 21 Feb 2024 17:18:41 -0800 Jeff Johnson wrote:
>>> > definitely a flaw in 6db6e70a17f6 ("wifi: ath12k: Introduce the
>>> > container for mac80211 hw")
>>> > 
>>> > my setup is using gcc which isn't flagging this :(
>>> > 
>>> > Karthikeyan, can you submit a patch?
>>>
>>> I see this was already fixed by:
>>> 04edb5dc68f4 ("wifi: ath12k: Fix uninitialized use of ret in
>>> ath12k_mac_allocate()")
>>
>> In wireless-next? Could you do a quick follow up PR so that
>> it gets into net-next before the warning propagates into more
>> of the networking sub-trees?
>
> The fix is in ath-next but I'll pull ath-next into wireless-next and
> then send a wireless-next pull request. So you should have the pull
> request in few hours.

The pull request is sent:

https://patchwork.kernel.org/project/netdevbpf/patch/20240222105205.CEC54C433F1@smtp.kernel.org/

Of course the ath patches haven't been in linux-next yet so let's hope
that we are not introducing new problems. We need to add ath-next into
linux-next to catch problems as early as possible.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

