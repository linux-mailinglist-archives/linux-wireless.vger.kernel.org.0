Return-Path: <linux-wireless+bounces-3889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A685EEA6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 02:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE914284826
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250311CBE;
	Thu, 22 Feb 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZrrjN+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E4F516;
	Thu, 22 Feb 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565123; cv=none; b=bfXuilnt6AqhpyNJcFz/bRVXax8kHMbn0sUbS8/rmSa7xzwDvmTkT42EwsnBexRDAFYpjZt1eOtGiym0ELuCuFFkzT/NgEhqxs31p35+CRlVOD+8TAWhDMFYi2+1/4MTGt3H0NZn+mPAe+qV8k6dEa2Xjwa47W8QPO83PxikByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565123; c=relaxed/simple;
	bh=/dYw1HVm7aHLHegHx8OCnBmMHZnyiBRA074h1zbQSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT08KcRc11zh2xOPB1hTkrE+9qm8gsLpFYTPKJA07Jr+t00jvTAkLH6wByin1NER40Qazc2Q9v4SFHqvLN1K5fZFxtA6YNckTnKYHWtAAcLawp5p/CpN9L0dtEUQR/NllfV2gYth7L2oCIhzPFFPcu4buSlCCc6GgsrEBH5SBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZrrjN+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A17BC433C7;
	Thu, 22 Feb 2024 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708565122;
	bh=/dYw1HVm7aHLHegHx8OCnBmMHZnyiBRA074h1zbQSrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZrrjN+sxWFAHZgS3sS1SVmQyXuyfwsT7Td1rUwz+nqAPnQ5+cIXFnzkczZCSUcrU
	 nNwIfWCPkQA0IuV3xVO6zK3STmYAxPM06XlggWzvCHX2qJhUI2imJ3kmmZE9qMurzO
	 Nr6skMMSRu8Z5pL2T3es93lxl5GGAm9tCSl6ccNjir0udL74pFuMo+oBvdiXeye5Om
	 eYQf9O3/IKG6sKjS41DVLzvr44rNUShFsGsogXYgjHLSM8NJjgf+yBpsAzQo9WxlU1
	 7DgMyMAp4Omt52mT1V7pZRZOvjpw1bw4nfYuIHFTkYCPvC6c9qpE10QkwvBlxuXGrO
	 BnskCZ6LnQKqg==
Date: Wed, 21 Feb 2024 17:25:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>, <netdev@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-02-20
Message-ID: <20240221172521.4dcb382c@kernel.org>
In-Reply-To: <b25a5783-a9ca-4356-ae17-bbda1340b522@quicinc.com>
References: <20240220165842.917CDC433F1@smtp.kernel.org>
	<20240221143531.56942c6e@kernel.org>
	<2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
	<b25a5783-a9ca-4356-ae17-bbda1340b522@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 17:18:41 -0800 Jeff Johnson wrote:
> > definitely a flaw in 6db6e70a17f6 ("wifi: ath12k: Introduce the
> > container for mac80211 hw")
> > 
> > my setup is using gcc which isn't flagging this :(
> > 
> > Karthikeyan, can you submit a patch?
>
> I see this was already fixed by:
> 04edb5dc68f4 ("wifi: ath12k: Fix uninitialized use of ret in
> ath12k_mac_allocate()")

In wireless-next? Could you do a quick follow up PR so that
it gets into net-next before the warning propagates into more
of the networking sub-trees?

