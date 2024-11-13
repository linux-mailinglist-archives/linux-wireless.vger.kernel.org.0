Return-Path: <linux-wireless+bounces-15243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220FB9C6D58
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE522827C1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933C01FDFB1;
	Wed, 13 Nov 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvV8V1Ad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F21FB899
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495891; cv=none; b=kSMced7kTVyYn7d9V+WJt+ip1NNmZxzgbuG6CwpsNr40X4JgYCTSkD5+LvvwnHno1OElPZj1is96AB+XXk36kJlwNcaXTm3Iqcm+FlO+GJ4HfmrjUnNBpGcoOC/z1ACj2tKoUfp09kCCvKntuRx4KoqXETfZ53OKLC49HJUGKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495891; c=relaxed/simple;
	bh=Vvvg1AH++KyA2a6QcTmIeH3TKjzNmmaOAkeEyTGoVlY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EgyMcbSaJv49otA1COA+hGEJH6aoSj3vtrfEA5rptMPH8k9Q71ELi9CBdhi44bgp+6wH/Qw/hc/FcK0226KzK5pjgjqIClhxe9C5wUCvMq+mP8qRZ8l3KWz+evJ3OUy7Emg8IMxZKsW2LEjgezfj+ebXhN6cbS0dx4ReUVJOQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvV8V1Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E6EC4CED0;
	Wed, 13 Nov 2024 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731495891;
	bh=Vvvg1AH++KyA2a6QcTmIeH3TKjzNmmaOAkeEyTGoVlY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uvV8V1Ad4WeCgMWv9Z2cYd+NbErRsdQA8DdUpp7fm0UfvIpaOLsIaHNYXlxkd3PTd
	 RvgVyn0SLc/v7Cwlq9ZtnGu7YFK0rIroXBbBMQCicbGZtbhp8CCYIk+lQtPUXe43jz
	 x69J/NmrHdZAfX/VsbZ6d+luAWg/odKky9w5z/he0D6JGhVLeZRPN7o0eA7r8GWVS8
	 8Cw9KqCFjNPaAUtEOXFFVtT3dgY9WE4bSEDT6dIw+WTmC/R8lVJ9duktk9M5jtEd3X
	 w4ryKBu4Qs1DLM3adZYMhUXL68fjFnmvLS9cNM9dVPTDI+pG26iAotJDJe6qE3bXnm
	 0aauHfkjdYHsg==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
References: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
Date: Wed, 13 Nov 2024 13:04:48 +0200
In-Reply-To: <20241113072707.3377341-1-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Wed, 13 Nov 2024 12:57:03 +0530")
Message-ID: <87cyiz2y3z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
> These stat types give downlink pager stats, counter and TPC stats, SoC
> common stats and Transmit PER rate stats, respectively.
>
> v5:
>  - Addressed Kalle's comments pertaining to variable declaration order.
> v4:
>  - Addressed Jeff's comments pertaining to data type conversions.
> v3:
>  - Added macros to fix compilation issues.
> v2:
>  - Removed dependencies. No change in code.
>
> Dinesh Karthikeyan (4):
>   wifi: ath12k: Support Downlink Pager Stats
>   wifi: ath12k: Support phy counter and TPC stats
>   wifi: ath12k: Support SoC Common Stats
>   wifi: ath12k: Support Transmit PER Rate Stats
>
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 629 +++++++++++++++++-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
>  2 files changed, 830 insertions(+), 3 deletions(-)
>
>
> base-commit: fc6f018eda7f9054e427f731db1e8b200f22873c

Acked-by: Kalle Valo <kvalo@kernel.org>

Jeff, does b4 pick up Acked-by from the cover letter or should I ack
individual patches?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

