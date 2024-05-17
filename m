Return-Path: <linux-wireless+bounces-7763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C98C809E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 07:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B98282689
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 05:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2A107B2;
	Fri, 17 May 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3RMwNV3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAFD53C
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715923976; cv=none; b=Lsv9aHA2ixHlWqKRsmsIa3G2VrnJFjy06QvtOwrbN8Da2EpiL3oCi2m7RUb4gCou6CfjWQKTdNOT+3wPoAiOWW4LRu9GSJLtspmNzVMpWnjci+EvGMILLF87kszUMhzLYBa+XU3BMvR4Wub3Vy2RPb4g/NgKLcZEAE+58LyZycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715923976; c=relaxed/simple;
	bh=gqa8WlcS1NTz0ZQsjr7949ZxTONjClfCieQGw/F7IFc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N4smydJ4deyFJAoLcqUkA0mBxVP8gow1xrbej13wBrv134IMP2r/Gb/f2iKUHnUKwfubbCmFVv0cZ5UekVcsQuvKGcIkz/cxk7xL7D74bwqtl5WF8VcNjEFSye8jzizcpbxVSfgHZcDP+krs127GL3G0q02zRRx/L+EBhWnGopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3RMwNV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CADAC2BD10;
	Fri, 17 May 2024 05:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715923975;
	bh=gqa8WlcS1NTz0ZQsjr7949ZxTONjClfCieQGw/F7IFc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=p3RMwNV3vjx92tTRehFV6Wv9uc4hoWsV8X3lpoR5M0sYvTjOWjQ5qx6ksgAV05Uyj
	 tmp/nUc8LMM43AYanwoO5GhgljnQCy922ULiB+G5FYyNdmHeCAKAvy8SEou9vpzoZg
	 m7szF/KN9zU7G49wJICp3Vh39Zwmnx5/+R4lRBKWsydKyEv7RzIOD+SatrRxuhmY44
	 Niu0uBszPH2h6+TA9k+ll4KAW4AtATEFUSgcboFJJO2aFp+/SnKVyhXI6dqpT3XVAR
	 MQU9NIt8VCSRv2DP0+hF+KOHm03VUyQUgt9z4jk+PtNUuaRBlV3LzJ4suHV5sBWrpL
	 BiyI4Dorw900w==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k <ath10k@lists.infradead.org>,  ath11k
 <ath11k@lists.infradead.org>,  ath12k <ath12k@lists.infradead.org>,
  linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: New staging repos for ath1*k firmware
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
Date: Fri, 17 May 2024 08:32:52 +0300
In-Reply-To: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com> (Jeff
	Johnson's message of "Wed, 6 Mar 2024 11:23:06 -0800")
Message-ID: <878r09gfzv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> Historically, prior to being incorporated into the linux-firmware
> project, firmware for kernel.org ath1*k drivers has been first published
> to Kalle's GitHub:
> https://github.com/kvalo/ath10k-firmware
> https://github.com/kvalo/ath11k-firmware
> (ath12k firmware was pushed to the ath11k-firmware repo on a temporary
> basis in anticipation of this move)
>
> But in order to have repos with multiple maintainers, as well as to have
> a hosting platform with more control, we have moved to CodeLinaro:
> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>
> Note that most people should not care about this -- normally you should
> use the firmware that is in the official linux-firmware repo:
> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
>
> You should only need to access the staging repos if you need a previous
> version to work around an issue, or if you are testing new firmware that
> is supposed to fix a problem that you've reported.
>
> Please let Kalle & I know if you have any issues with these new repos!

The final reminder that the github.com repositories will be deleted in
two weeks. If someone is still using them switch to the new
git.codelinaro.org location NOW.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

