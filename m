Return-Path: <linux-wireless+bounces-16608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F5A9F7C2F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E737188F19B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985921A945;
	Thu, 19 Dec 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3M6Ox9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0B39FCE
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614498; cv=none; b=k9P8N6B9I8a4EDtdadZFKRM59Hew7v8N7qs4Pt6jNW2hgtPs6TjhAq6jTW6hIIsCAavqA7h1X05x38HTzuDCQmHdPHhA0VBgaQmVoAMfIb4pay8wC5LUmcysqhrSR2uzhsGT4RzL2TP49IAHwqi/uU4zIyULC549I9q3GDqgGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614498; c=relaxed/simple;
	bh=y1/zEPlqylwaDCsgVUz2dZoDtXxLoO9nh2PfUsMnM4A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=anrws4AaaZx4eYuwLw35CTHfq1b9mvYB/YT8QQ/8CFayGFK/zEYN5QyI5Skb4pIJQHsHs4WOcT0R0QblkxnISjczpK1x54fifFFB9lzUso1mL+QGR3aLe9ME/mDR93NUTzOLhfLD6hGnFCdJhfNB2IMBUAugHfrFpxxlvEVE3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3M6Ox9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F1C4CECE;
	Thu, 19 Dec 2024 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734614497;
	bh=y1/zEPlqylwaDCsgVUz2dZoDtXxLoO9nh2PfUsMnM4A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=l3M6Ox9t/Epk3FPdg6VWSl+rTkxInzE2qRc4JczUObShSNN9i5VzGN0hCm1sEr73x
	 1ws+osEF1XbcqqfsQTCZRA9Hl9z6E0p9jv6xsW8ttE6Or/EuVJmMrKtQc5SKALaaqE
	 JPX19eIgm50UE/YO4d2QX3i5ydLtjUSYZlRwGVt4UGtCJyy042UpX/eKpdiVsel22o
	 d7ph7VLYW1ZXHLQVhO30hmFvbrhU37z/Q86qYJFKxBRUNGKK09FCJzlJD28tKKEOvL
	 +SgUV0GLIt+ZTKbFsTVGMEeEST0ym1CiVfskAcYXFbyU87ZOMyxuBs4exHspS8WaGx
	 EU792M2DsXVyg==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH 6/6] wifi: ath12k: Support Received FSE Stats
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
	<20241217095216.1543923-7-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 15:21:34 +0200
In-Reply-To: <20241217095216.1543923-7-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 15:22:16 +0530")
Message-ID: <87r063hkpt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>
> Add support to request received FSE stats from firmware through
> HTT stats type 28. These stats give software and hardware FSE
> stats such as cache entry count, full cache count, current and
> peak occupancy count, pending search counts, etc.

What does FSE mean? It would be nice to spell that out.

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

