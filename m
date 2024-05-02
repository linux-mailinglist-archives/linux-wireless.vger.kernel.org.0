Return-Path: <linux-wireless+bounces-7112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16008B98EE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341011F22896
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247D5C60D;
	Thu,  2 May 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDIg3z8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F95B05E
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646245; cv=none; b=aDoedFP7ilnQQ47BgWNCBglx/goDcahE+ZO6SXm8Cn5Y1aWm0yuo66iWj1/USh9dDdP1UmK/PgQxKIggyTu7eLfwBOh/ky/iNggIPUKq2fjlQEZkGslVuIo7FQKtxLlZysfhC3mhFVCTbc1CGA8rhZqkZ3yLERsRAGm936MANLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646245; c=relaxed/simple;
	bh=WNsB6b1rhLdp1scPWnLRpWHAR+bWWGIuxHzjMoVEX64=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iFPh3PzKkHWrsx9xfQ0IqSPhRA/TUZnwVSJYMIPFA/yZ4p11/G5KxZ507mDm1HUXNzQJGuPswToABT75QLX5GCjD4U66K1E0Hj97UuyLftJt4hB1laTrVUY1RYoTH6+2Sm61ztyuVcKoDrVtOO6B09Y1tWAR2hvlVABsYFgGet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDIg3z8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E346C116B1;
	Thu,  2 May 2024 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714646245;
	bh=WNsB6b1rhLdp1scPWnLRpWHAR+bWWGIuxHzjMoVEX64=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WDIg3z8KlBnOZ5OM4xZauO0NsGOYv5o/MnjsRG0x7E86VYeZhR6uGyCIjhaHHtIYx
	 2pmUh1DH5yUe3UtZB7kQFH7k7UZSBcFK4LHa+aeJLNs5PJPfEqpVh81jdnDg6OqGfJ
	 vfvHnybabIRWobCAL/t85UrjAxD95uw6j2H2rffu6y9abo0Bsm1GG8l+xluPXxcfqU
	 ZdFG58FpeDJIc/1CkNYiJGgbqsy0R1GZgK/3/haahljka+0xZwhVNGA5oBpVbd8lIL
	 qaxyundeRUfYqrNO+WDJ6BAGrVqXKEsRYsu+WZncCOgLiR4f/b7ldxeVfUss10VWYg
	 qg/01haCSzGdQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] wifi: ath12k: add multi device support for WBM
 idle ring buffer setup
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
	<20240430165811.1377182-5-quic_periyasa@quicinc.com>
	<67fdaee8-db68-4eae-897a-63d11f680103@quicinc.com>
Date: Thu, 02 May 2024 13:37:22 +0300
In-Reply-To: <67fdaee8-db68-4eae-897a-63d11f680103@quicinc.com> (Jeff
	Johnson's message of "Tue, 30 Apr 2024 11:46:05 -0700")
Message-ID: <874jbgpkil.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/30/2024 9:58 AM, Karthikeyan Periyasamy wrote:
>> Currently, inter device MLO is not supported. Therefore, the WBM idle ring
>> buffers choose the implicit return buffer manager (DEV0_IDLE_DESC_LIST).
>> However, this implicit return buffer manager design not meeting the
>
> Kalle, can you add the missing word in pending:
> design *is* not meeting

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

