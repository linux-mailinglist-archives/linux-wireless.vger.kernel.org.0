Return-Path: <linux-wireless+bounces-4560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F65878046
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497E41C211B6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88438F9C;
	Mon, 11 Mar 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXRZwXFN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27B33070
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162355; cv=none; b=qdOCmGsz85+J6e2CFbne+Ys/P4Rl2zLB0NElIX30kRp0VeHbwxEIk7da2WWvzXLlEoCFDF9f8izd2aNrTMk+xZp6R+4AYNz8Mm8/DhSskXSVmfSmA3JSPH9Qs9Hj9gjhJzjZc17ZAv9nQLeWS0s4Zrv8xsUKXLxvw24df/fe0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162355; c=relaxed/simple;
	bh=sY2aZjoVcuD10saQ+X4Mufz+T7UFLiCtz8ISoPvBb6o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cNsiheF3NpJvE9JvcGPk2FWA4lJqeuEk55+RwKDGYgyh+kQ4b/NRH9gULEpAsgX3LBiv+8Ww4aRnNj3/lC6ZJ0NpRPWZUI8RxpA3jFojLJqhpsyrDHQM5a0mvzwgt4Snx38KY26Kd+IKxBXK0NgSTVppjoo7HbNmJjM5y5fY/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXRZwXFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD78C433F1;
	Mon, 11 Mar 2024 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710162354;
	bh=sY2aZjoVcuD10saQ+X4Mufz+T7UFLiCtz8ISoPvBb6o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jXRZwXFNS3Ur55NfAET7PVqXesG1NUU3SDI/9RZAltqgpakO/kbF2ajVfls1mAAhI
	 S8poL8faVGFYlh8IlBXPBjC6g/zORsaWzhx8evzeMOuR5vy6bX1jxkuDyqygQSh/es
	 RAP6NcX717wu+kNSNzT6hKHHCzlo7uQhcC8/UzJGarCqrCTfcLDPdG1BxtcElEPyPU
	 7Juac/cLfso9pA0hQe56iHZH3jWKuOJxq3KZq3rhVuZUKM2iEZiSDqfcW6j4FxolyP
	 eGDpwjHyYSRarZxioLNWp9z1FCRp2xesDtrD5LrQ/wxEPEWa7x2/dEPz+F/NPp/Fw8
	 tQfkMkCpKyYMQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: Optimize the lock contention of used
 list in Rx data path
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
	<20240226162310.629162-3-quic_periyasa@quicinc.com>
Date: Mon, 11 Mar 2024 15:05:51 +0200
In-Reply-To: <20240226162310.629162-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Mon, 26 Feb 2024 21:53:09 +0530")
Message-ID: <87msr4gbps.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> When a packet arrives in Rx rings, the RX descriptor moves from the used
> list to the free list. Then, the rxdma ring gets replenished, where the Rx
> descriptor again moves from the free list to the used list. At the end, the
> descriptor came to the used list with unnecessary list movement. The
> descriptor used list is maintained in the Rxdma ring structure, which
> creates lock contention for the list operations (add, delete) in the Rx
> data path. Optimize the Rx data path by removing the used list from the
> common Rxdma ring and maintain as a local variable in the Rx ring handler
> itself, which avoid lock contention. Now, to find the used list descriptor
> during descriptor cleanup, we need to check the in_use flag for each Rx
> descriptor.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Before looking at this in detail: When optimising something it would be
good to have before and after numbers showing the improvement. Otherwise
it's just wishful thinking.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

