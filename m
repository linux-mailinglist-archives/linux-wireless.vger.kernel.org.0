Return-Path: <linux-wireless+bounces-16493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB759F5726
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BF116F13A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36891F892F;
	Tue, 17 Dec 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI0U9e5+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF671F8684
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464735; cv=none; b=BG6qM8cq8z/hjSDrFd8y6YENR8gvvio5LyMOAkpH+dP0qeQ3blVnb90TUeBBySwp+zRLHGQ/nlB6wegRYiqkThb+jG/3PDMu4Zzakz9rdej+2l/TLSmQk3ih51qS36xsuGcdNruGPoz0CoxWrfkLzNA3FF1/R+812bstbBrzyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464735; c=relaxed/simple;
	bh=GLX+xN2bnDAbGaktG0VLB+CLHBDWLkg0D6DmW0YwQLo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FEprSEhgLoHu0WdQRHIOr8DmrBKHhuAyjs+c+T98N2xLozEysGvBL8H5HV1ZEoUsQCzHJGapMfllbeaOYGWp7WMxetEzNMkX+3QMonDMKLLCQ/wyfHQbd3BNIVjRBNk3CA5Hhi5Kjn8NJOAC0H9WmDDpTmh4iODeeyxRA+RIW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI0U9e5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43353C4CED3;
	Tue, 17 Dec 2024 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464735;
	bh=GLX+xN2bnDAbGaktG0VLB+CLHBDWLkg0D6DmW0YwQLo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CI0U9e5+py7R3sAdV+lG2If2BVrIe9nAFuuQ7yBLwP8C3mH2Mw/LCxVjgbRpNfQwA
	 JBvwZE8Hb+4s9xDhKACn/oSzLYmyXzAyvF8tT3Ki4YhStkkF4Y1A+MmRUbTdpOMcEM
	 PsVNGIba9rl6YEcjzpgKSQyLKY79E9Ki9VT9aEZGfkYvLesFfeDaZ+RXySEqeZctyA
	 sS8BKsv2JrfFhRymyre/A+v/A7KyGPvCI1ms/rvSUvwXqmxmFRcfmh3ib/k5jgJlDX
	 FzCCXcUJ04nRns05Ly7vuF7Q+lDubgIAkCE1rbiCfrcsPPV3PmT6GNFFXrc7beiShi
	 snkLwFjtljNfw==
From: Kalle Valo <kvalo@kernel.org>
To: P Praneesh <quic_ppranees@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: Add support for parsing 64-bit TLVs
References: <20241217095058.2725755-1-quic_ppranees@quicinc.com>
Date: Tue, 17 Dec 2024 21:45:32 +0200
In-Reply-To: <20241217095058.2725755-1-quic_ppranees@quicinc.com> (P.
	Praneesh's message of "Tue, 17 Dec 2024 15:20:58 +0530")
Message-ID: <87h672ks9v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

P Praneesh <quic_ppranees@quicinc.com> writes:

> There is mismatch between the format of monitor destination TLVs received
> and the expected format by the current implementation. The received TLVs
> are in 64-bit format, while the implementation is designed to handle
> 32-bit TLVs. This leads to incorrect parsing. Fix it by adding support
> for parsing 64-bit TLVs.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

