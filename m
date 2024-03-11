Return-Path: <linux-wireless+bounces-4559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F187D87802A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 13:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A73283A15
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3D36AE4;
	Mon, 11 Mar 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CahyvtN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE422064
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161647; cv=none; b=JMjc1fjhPXW0M2K/9JEB84vLpB7kFdwpmgrJCPYraKkP7iiAsEjQzxU2fzkuoV8huJns6EfGL/lahxTh24UWiW3oeRaRcF3yqOhfiCfEB7QY5qpVNb+uC/HxmfTte1gMEUsW7AThaCXNpAqLz3jt4VmpCkcWOUD0A1j1wTKljWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161647; c=relaxed/simple;
	bh=MmRmSMYDdBBytU1bQlovE5mbYXTLKDuy1pvF9chw3b0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oM48/sQYLMPq6qqkl17DfaPLyvLuaS1wxoVCaazA778gY6mc/wC90Xlv3j761anxdLdp2+qi+1hdeI854oMNUt5jKjjrs96GsWdgb2kAj58z6s1xr4GGCWhcNdLEufMQHJYcmajztJIYM/fOxTDWcik1UvaaR22kC70MnXyChMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CahyvtN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B395C433F1;
	Mon, 11 Mar 2024 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710161647;
	bh=MmRmSMYDdBBytU1bQlovE5mbYXTLKDuy1pvF9chw3b0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CahyvtN6pceNp/tgBfiFYWCL9zQG0RRmPuFNBU77kBNdhgHT6VMtN48ndf41GTpCI
	 I+CJOpBz6oywYKYkgY7RA26N4CrzCcHbQTJYxB9oxZQnb6qObzVJ4Sq1WRL3ORdAgR
	 x+Iqx2fWvMRkcG0oldPi64ZPtgkdQ7u6xBhoOzikNe4RcBI7GKhf3MsYfKfgG1pHt3
	 d7+e4nts+lLHfmvaaEyjX+4mmZuGHXAwlW9KoaO3qPkSN/ztPGsFnsAsoCUMuylYc4
	 cyp09VeRh3oOSDIwTUWS9be8NC22VfKZX3Z3YhhMFoIes9ZoUePhn3N7nxto7hl/c1
	 YoSim1JoHKAvw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: adjust a comment to reflect reality
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZeWEqGVibkMg2APi@ns.kevlo.org>
References: <ZeWEqGVibkMg2APi@ns.kevlo.org>
To: Kevin Lo <kevlo@kevlo.org>
Cc: ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171016164435.1596381.210173282754394983.kvalo@kernel.org>
Date: Mon, 11 Mar 2024 12:54:06 +0000 (UTC)

Kevin Lo <kevlo@kevlo.org> wrote:

> On QCA6390/QCN9074/WCN6855, MHISTATUS may still have SYSERR bit set
> after SOC_GLOBAL_RESET.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a368b0a9854e wifi: ath11k: adjust a comment to reflect reality

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZeWEqGVibkMg2APi@ns.kevlo.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


