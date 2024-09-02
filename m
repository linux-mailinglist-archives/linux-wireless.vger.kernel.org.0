Return-Path: <linux-wireless+bounces-12339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459A968C04
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A63DB20957
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0B1A263D;
	Mon,  2 Sep 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBeSTAKB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00881428E8
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294434; cv=none; b=EeFGXIll+ul7erMaUkS15bqcvVbOKhVuZ2L3/mJJIIsQQsSpMCkXqOHRLm3lIE5F4O1T+xq9yTzjYsUZ+IbJ4U2L+/PJ7y3dxTy+HXhrHwfN5ARTx/PfsO4+2o48JQWC/8gdVmB7KUpYYKrcUVnAAAyR/4YMAJhgVDsv4PGUYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294434; c=relaxed/simple;
	bh=XZwIoL+8dk+OXHwqAwWkDKH34tbPcv9dY3lLJqneptE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=WhQIuREUhr4pShSKDpr84UuNkeVyJwUCe/zfwYN/mkaT9YAWSgiBNLy4wpdhhJfJubhbabPuw5HXBlnqZI9px1DFlLouyNPwhTwsYYj108SAbdL6mFdg98etkmVVDOLepknwqU8uTddhM6VJh2mwSeYi0Kgam5TIOPJdiLwxZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBeSTAKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128CC4CEC2;
	Mon,  2 Sep 2024 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725294433;
	bh=XZwIoL+8dk+OXHwqAwWkDKH34tbPcv9dY3lLJqneptE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DBeSTAKB4OI8SeN5amSno7wQkFMUhma6f6K6p2pG2fDjCuph1aVJs2Y7qX2neRYv5
	 b04oScB6swLYFG9t7gg920BhbjvE/ng9HzkRFNYXgq5B4avkO1pNaDsMKPZQvRONIx
	 vLMXoqaQ41xxGTgrGUdG2BUXoxKL1lQ8UgDv8OP3GxnFLftYLciPELVL24/vnjUJDX
	 BTmnnNNdsUn/1SWdIDA/A46Uj+PPo2Om5/Xdm6v040CxyFKziY9zCvieGXBEPP30D5
	 +F8rDrG+YddVQky5aXgFQEt8u++tdrAvg3JloFP+wcHIjxskh+tHRcOX0jlo9E4a5V
	 GVuksHBB7wlww==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH ath-current 1/2] Revert "wifi: ath11k: restore country
 code
 during resume"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240830073420.5790-2-quic_bqiang@quicinc.com>
References: <20240830073420.5790-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172529443048.651366.12916100512214985821.kvalo@kernel.org>
Date: Mon,  2 Sep 2024 16:27:12 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> This reverts commit 7f0343b7b8710436c1e6355c71782d32ada47e0c.
> 
> We are going to revert commit 166a490f59ac ("wifi: ath11k: support hibernation"), on
> which this commit depends. With that commit reverted, this one is not needed any
> more, so revert this commit first.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

d3e154d7776b Revert "wifi: ath11k: restore country code during resume"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240830073420.5790-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


