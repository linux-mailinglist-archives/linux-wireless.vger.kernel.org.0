Return-Path: <linux-wireless+bounces-7047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1168B773F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE31286EDD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F129171E6E;
	Tue, 30 Apr 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAqdjBUk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08559171E66
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484054; cv=none; b=Hcke7Pqy9jTxZp4VOdenPEiIEV/Sq28K5Ix5YaLKwAshRlNLw2+HD7ZQuZTSiWeA1H8ePU/AT07KQhEqzQVqqFpuTkWc17fz1Uga7yDlPEeoSAgm3ABh8JskfCtTDpFQdd+cyb0k6sUFiMF8NZkeYLs0TSiGgJFopiefzgKAMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484054; c=relaxed/simple;
	bh=wzkgOC/aglpW7s76rCyOHqSnMmdZuP+WCPsYrPnKeCI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=abA10PgJsj3tGom2UIsfnHh3YNpQeBSFuJxAJm9Sl1ztsOTvrgZ3MwfI1yYlSZJiAPhGuun/I2EwaAGWGYKnrlyXKaajQfd/VJOAvbBerZQaT5AQlz0SmxLegxGjvCWVORTYYgck7ra62y3H2p1c80cnb9pReVTMrbEbxJRgy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAqdjBUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF01C2BBFC;
	Tue, 30 Apr 2024 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714484053;
	bh=wzkgOC/aglpW7s76rCyOHqSnMmdZuP+WCPsYrPnKeCI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OAqdjBUkiwsyC1dBNip2NOKXIgcstY8Ih155Gn0+4H5UJa/jTkD+/b2g6q5NJk7kO
	 mK/1s4bZV1gdIe0bHLhRl3sR13y8Gmrol5uAiLWfcMIfIXftAW/QoVR2CZ3J56QaXR
	 mSlbksess+JMZvgJnGBgAaYFtAcWbk8WfjxJT5d/hY5anqkIDNBvzIqYJ5QcgUldho
	 DKYwvDbi4xEM5iWcH7+fyoBeq5o7YMA9zp9HUg3X334KqV4Sr2NcjnuQhGAHbJgIuJ
	 LiQjhd2AeteON3Sk5rLKJmx5WpFU6p8d7S2TTYChCGOGrkLTwB/j63crv7uIj7hHb7
	 3/Fm4fLRrD/jw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: check M3 buffer size as well whey trying to
 reuse it
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240425021740.29221-1-quic_bqiang@quicinc.com>
References: <20240425021740.29221-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171448405111.313333.6267220944906708635.kvalo@kernel.org>
Date: Tue, 30 Apr 2024 13:34:12 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently in recovery/resume cases, we do not free M3 buffer but
> instead will reuse it. This is done by checking m3_mem->vaddr: if it
> is not NULL we believe M3 buffer is ready and go ahead to reuse it.
> 
> Note that m3_mem->size is not checked. This is safe for now because
> currently M3 reuse logic only gets executed in recovery/resume cases
> and the size keeps unchanged in either of them.
> 
> However ideally the size should be checked as well, to make the code
> safer. So add the check there. Now if that check fails, free old M3
> buffer and reallocate a new one.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: 303c017821d8 ("wifi: ath12k: fix kernel crash during resume")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

05090ae82f44 wifi: ath12k: check M3 buffer size as well whey trying to reuse it

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240425021740.29221-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


