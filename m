Return-Path: <linux-wireless+bounces-6707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005538AE0FD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9350B1F22D07
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C95C61C;
	Tue, 23 Apr 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebe3wOk2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E253E5C613
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864467; cv=none; b=RTkvYUXHmjXs84UvT8lhe868HESgtuD6dP0yXxHgwpGQsFPoyfQS7aPHbKPXsvWOPkimlm+Lav8PzMGWNB5EtvYdESK1MaUGeF1TeVV0qCv4bCP+UymwD4LDAOsFqByyr8V9YwuPHULiTxa0q9aaqFLA4jmFjdpy1hwn5wdiuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864467; c=relaxed/simple;
	bh=ECWTb2iE+CGBQc8OeI8roPjx2FSWW579wCFKlUd/JVo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=t5+MsAqI4+OUu+Qvj5DZlSguf50kpa1wuSxTodjiBLojUxPRxExVFhStR5f34FRpWlwBqFEW6BFnwsQr8KMVX+D+uv5x25XqwquYrBzZQb9XrkSIm2WcUBKHO7i2aN5pOddaqJJpQI82Sg8Auvs75Em+Lm57GeFtQdZixzkWDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebe3wOk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F9EC116B1;
	Tue, 23 Apr 2024 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713864466;
	bh=ECWTb2iE+CGBQc8OeI8roPjx2FSWW579wCFKlUd/JVo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ebe3wOk2BP6th2xKZ58hHBzDRuuhSpeUKE1BzA8siqnB79eZ0bQz6L7R0aOt7Em/G
	 5KIGGiqj9QsXXCurBV1mN+zeqspypzKwK/CzPFGmAxEglRA2O/UTUIGjY0daKgLWeH
	 1yfCU4FpXjALHinBcabWahhkeEgOELow/x/px8ywJNfUrlsU6LyhrgcmexznecRkmd
	 gZcLAm552qoXMJCT/TYV9JwwQjz9ooKuaHPpJ0q3UIoGKkKYNWFtTHbg5B0MkYFfZz
	 B+XeY/Owo9EjNyGTqxQlqOvJjk++6DlIRWsTEoYJp3DWyMx6sYp9EmNqnYba/a5mRv
	 GaCrLW9Zl9H+w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] wifi: ath12k: rearrange IRQ enable/disable in reset
 path
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240412060620.27519-2-quic_bqiang@quicinc.com>
References: <20240412060620.27519-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171386446361.1790113.11680836995300295379.kvalo@kernel.org>
Date: Tue, 23 Apr 2024 09:27:45 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> For non-WoW suspend/resume, ath12k host powers down whole hardware
> when suspend and powers up it when resume, the code path it goes
> through is very like the ath12k reset logic.
> 
> In order to reuse that logic, rearrange IRQ handling in the reset
> path.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

10 patches applied to ath-next branch of ath.git, thanks.

c7b2da3c0a57 wifi: ath12k: rearrange IRQ enable/disable in reset path
b8b50a489d51 wifi: ath12k: remove MHI LOOPBACK channels
8591b2baaee4 wifi: ath12k: do not dump SRNG statistics during resume
1623bf78c846 wifi: ath12k: fix warning on DMA ring capabilities event
7b3d4eb283d2 wifi: ath12k: decrease MHI channel buffer length to 8KB
692921ead832 wifi: ath12k: flush all packets before suspend
b1c9992c675b wifi: ath12k: no need to handle pktlog during suspend/resume
2652f6b472ff wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
8d5f4da8d70b wifi: ath12k: support suspend/resume
2b0028458996 wifi: ath12k: change supports_suspend to true for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240412060620.27519-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


