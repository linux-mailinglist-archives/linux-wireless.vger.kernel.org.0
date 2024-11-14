Return-Path: <linux-wireless+bounces-15297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D124C9C8909
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8493A2814C9
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D21F7799;
	Thu, 14 Nov 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlE02iS+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DC18B49F
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584048; cv=none; b=fsu9EmUs3iRctIvNdpOzxGbqNl5juOuCTOiEByj7BjiLZzRWZIUFAL80RfxOtNgHpkWjMYDXvCGM7ljXglqVRuLgv5n8qIwbBLbdQAE+2SfPIR7Gu5Bl5z2vKBHO0NgSRukpClHwf1zxRh5xMcG73ccxi+FYRZqMbJVca2YIrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584048; c=relaxed/simple;
	bh=aItY16j4fLjubP3L0+j69GJGChn5EcSz3OuryUOJVB8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=k3ldaQfz3a2LNy2zvqN4YunDkP29nQ8EsUPk6ROvlyrdm/m4qEQnbx9CAwIdN4dsLNXmcCxaQ745M6Icmv/7Kb2sGXIBVy6UIa9gEPTJUF6Url2hfuiZWgf9z5KYhagheQIo9w7iggiMIr33fX4uQIfytsV43quLjgVkAT1cKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlE02iS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7620CC4CECD;
	Thu, 14 Nov 2024 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584048;
	bh=aItY16j4fLjubP3L0+j69GJGChn5EcSz3OuryUOJVB8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GlE02iS++DBIjn2Sb7fQzS2AgZgc84iVkvbpe38Z7Bt87G1Rx5PyeqhLhKk7l440W
	 NywP223zwFUteRc/QECV/6ALX0Vkfm0aWbqf+J9qZW9apWoaCn985fVdLtwAKOkUhR
	 mgMwPZbQobrMrDA14hMNIzWYD8jdUte+IfIQEBiAELxZ6rh4wB0sEmKxF8C2LOUKP1
	 34RY8zjOcmW+OcuSTnZOCDQu//6nPTZtcm9NFIsMlPozW5TEEjXF6UR0PddhBTH/eU
	 4pfXiiK70GvyWZ9jXV8e2hOz/h775Z365UPyzN7KsjSNk/bQ0FRd0MnSIs0kBitCyp
	 jcnlqqBpjr9Cw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/6] wifi: ath11k: move some firmware stats related
 functions outside of debugfs
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
	<20241113015631.3105-4-quic_bqiang@quicinc.com>
	<8734jv2xnd.fsf@kernel.org>
	<7917a344-82aa-4ef8-9558-554743c5dd15@quicinc.com>
Date: Thu, 14 Nov 2024 13:34:05 +0200
In-Reply-To: <7917a344-82aa-4ef8-9558-554743c5dd15@quicinc.com> (Baochen
	Qiang's message of "Thu, 14 Nov 2024 14:05:28 +0800")
Message-ID: <878qtm1236.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/13/2024 7:14 PM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>> 
>>> Commit b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
>>> and commit c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
>>> call debugfs functions in mac ops. Those functions are no-ops if CONFIG_ATH11K_DEBUGFS is
>>> not enabled, thus cause wrong status reported.
>> 
>> What do you mean exactly with wrong status reported?
>
> ah, thanks for pointing that. actually no wrong values reported, since
> we are not even reporting anything in that case. will be accurate.
>
>> 
>> mac.c is quite large already, making it even bigger is something I would
>> like to avoid.
>
> then can you suggest any other place?

I first need to understand the issue we are fixing. Is it ath11k does
not report rssi and signal via ath11k_mac_op_sta_statistics() when
CONFIG_ATH11K_DEBUGFS is disabled?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

