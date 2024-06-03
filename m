Return-Path: <linux-wireless+bounces-8423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F1C8D83A9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113F11F22725
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27312CD9D;
	Mon,  3 Jun 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggo1yQBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43C1272A7
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420454; cv=none; b=Qyohas2PX02Up9ythFsStTwG/fQZFc53WifClF6Tz/f1/dxDmAWATUkR0E8eOctzspzU3rSksERHlY24p18SoEQERXGeE3R0QxQ+thrQSOXTyjeqwVIvaeScbYA9+p+ZT4l7Dniv4vnPZ1kbS6cBv3U2ubWBvorMEelhJ9ybS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420454; c=relaxed/simple;
	bh=WW6dGlXKLeOoL1hqzQ1d1JJ/1RgcIKTS3/T/1bLcvQQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rSZabSZ89mN2jgmDCtTf89AqDJ0v5fUtvJ3DSuGnWBqyPkfYWA/dEOGanNsvSuZNzylsPGlXRNnsysb2yq+bIxS4OXtNmHnTaqoRU/iWL0f6znTx+Kh6S4WX0f1Hw1dA1QdtqMyWXOMrQGgx5mbcxnyMusFOKA+5oE47faoq2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggo1yQBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89381C2BD10;
	Mon,  3 Jun 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717420453;
	bh=WW6dGlXKLeOoL1hqzQ1d1JJ/1RgcIKTS3/T/1bLcvQQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ggo1yQBkBMceBtsQBu1YGjyZi0AGqHJaMcrf+mTYNlEzR04198TBXrArF9DxoeDMd
	 553N7gp2NhMJNhNZmEsyQgu+9ccRC3P4wsFeX5STZe+h3kE5ZixBX0urb7uZxpvG89
	 ZKpf7YpSPfaDb65KkyOVTSBECLqqXxnq4e+7ugA4oMGGGHEhYvlwSscmqmcaKcXMd0
	 PdyZ2oRUOY+o2PvAKshOBwPLU5aQQSiZ+j+zTXGx6a+evbd9Bllxn05+WL8fWlEYgO
	 f/ms3yz995os8/qun7PI8KR/ls86qSx58DgiuieNEtlhVkRmwoSZ1qk42qpVVgdl4M
	 HrzKP3IrQz9TA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add panic handler
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240529021533.10861-1-quic_bqiang@quicinc.com>
References: <20240529021533.10861-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171742045096.1515473.13427996557283949873.kvalo@kernel.org>
Date: Mon,  3 Jun 2024 13:14:12 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently for ath12k PCI devices, firmware could be running in one of
> several execution environments, e.g., PBL, SBL and mission mode etc. Among
> which PBL is the only stage where PCIe link negotiation could happen. So
> normally firmware runs in PBL in order to be enumerated during system reboot.
> 
> However it might not work in kernel crash scenario: ath12k target is not
> found after warm reboot from kernel crash. This is because when kernel crashes,
> ath12k host does nothing to firmware. And during warm reboot, WLAN power
> is sustained. So firmware is likely to keep running in mission mode throughout
> the bootup process. As a result PCIe link is not established and thus target
> not enumerated.
> 
> So add a handler in panic notification list for ath12k. When kernel crashes,
> this handler gets called and tries to reset target to PBL state. Then PCIe
> link negotiation could happen and target gets enumerated.
> 
> This change applies to all PCI devices including WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

809055628bce wifi: ath12k: add panic handler

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240529021533.10861-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


