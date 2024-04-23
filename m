Return-Path: <linux-wireless+bounces-6702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE38ADCB8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 06:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFFE1C21B71
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641431CA89;
	Tue, 23 Apr 2024 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnlNN/yH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADC18AED
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845456; cv=none; b=g1ng56fYfp70POi/Ebjzsfa8EQ8XGF45bQGgAeNYflLTTJHkDzoejxkIsSB+M83sjYaU1jg+p8nmqjvo7G4jHpi543G9EgM6zsRW1JSIujwbSvN2/8S4xnlAKX6Es+eOEbsav2D960YNCh6b3/E1kBGRVHMNvDyxFghVThccSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845456; c=relaxed/simple;
	bh=SZFaChg/IXoup75dLEdwA+ULyJfaOfCsXHtisihaQa8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EZo86tDhA7lFRq6+pd98/bt0HbfAISlZpzjntKl52NwtHbWxfwexHWxFvuhy+BfpC6tdhXEhyxJm0W6QfwlPYSJdwgd9TCQcjtTFw2GZgStmv/IcuazMKpMQXlmA3MrEiU1sOc7Yc6oMmjlLCKL+ERoFx8cHOurOxRXv43pPtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnlNN/yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1522C116B1;
	Tue, 23 Apr 2024 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713845455;
	bh=SZFaChg/IXoup75dLEdwA+ULyJfaOfCsXHtisihaQa8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pnlNN/yHZjQeEO5tiMfx9XqAzPg4jyDP4wblfGjSo5Gy4/87v9c1/0P2QKR4Eoz2W
	 sc1N0ImJlubPYr+MWYaHbRIfoIgzC6uVLzmdJ2WAc2W/z7JUzeQGdcAGMTGhOr91tc
	 srBr0QkI520YMZl4WDA+Egto0vkCtgJYosAJHk6Hbpk1l4AY7/0vy8WPCcMWgMOGlb
	 ry9KhjAQtQf2RBIu7Dfb/oTfid1qAJU900KomPeo+q59vmVw1v9Ke+coIRIeWRmbn5
	 3TfiQ+UWWJaOzRcaIpnqWPG4PiG68F+qQWpjo0YYzjb0+N7NostvwtQMYCc9lIT2p3
	 KUTBqEtm40PXQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
	<87cyqmhtoi.fsf@kernel.org> <87frvivufg.fsf@kernel.org>
	<87h6ftv8w6.fsf@kernel.org>
	<5f63982a-eba9-4c5d-8ac0-52970316f940@quicinc.com>
	<88a1ab50-3dea-406e-adcb-b02786ce7f30@quicinc.com>
	<e409e282-3f6d-42e2-ac6d-7602e3ef1b87@quicinc.com>
Date: Tue, 23 Apr 2024 07:10:52 +0300
In-Reply-To: <e409e282-3f6d-42e2-ac6d-7602e3ef1b87@quicinc.com> (Jeff
	Johnson's message of "Mon, 22 Apr 2024 18:34:16 -0700")
Message-ID: <87cyqgvhv7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/22/2024 11:41 AM, Jeff Johnson wrote:
>> On 4/22/2024 8:41 AM, Jeff Johnson wrote:
>>> On 4/22/2024 6:12 AM, Kalle Valo wrote:
>>>> To avoid breaking git bisect I now reshuffled the pending branch so that
>>>> 'wifi: ath12k: fix kernel crash during resume' is before the suspend
>>>> patchset and my plan is to commit the patches in same order. Does this
>>>> make sense for everyone?
>>>>
>>>> I had a simple conflict in ath12k_core_reset() in these commits:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=052a6a7c74ae4f20a31a632184f4439edcb0f40c
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6bc740619993535cb64c4dcebb83c66acd506763
>>>>
>>>> Please check my changes.
>>>>
>>> These look OK to me.
>>> I'll test the pending branch on my laptop
>> 
>> pending branch crashes on my laptop
>> let me bisect
>
> ok, that was user error.
>
> I had updated my workspace on my VM but not on my actual laptop, and the old
> pending branch on my laptop contained the follow patch which I've already
> flagged as bad (and is not present in the current pending branch):
>
> wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup Failure
>
> I updated my laptop to:
> 5085843538af (origin/pending, pending) wifi: ath12k: report station mode
> signal strength
>
> And everything in that pending branch works fine, including hotspot.

Thanks for testing. Unless no objections from Baochen I'll then apply
this fix and the suspend patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

