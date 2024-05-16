Return-Path: <linux-wireless+bounces-7736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF31D8C72D4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C8A28402D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010A13792A;
	Thu, 16 May 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPxbWDQR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE141137925
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848092; cv=none; b=aYwbid+TjxuRxlwRukOjlMMWR9yFqya2jjfF/l8B3kFDb0Ea6jmqkyLBysofwsy0xlt5V3wN7blT8ZMqAIlNcLJG74QMRFDj1PuoJ5g4TS22ZRCmDCy06iGiPcI7/4qgnHEgeY3LLFTxXJApZ3MbhIwy2+cK2Pky5bD1qVDNTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848092; c=relaxed/simple;
	bh=ggjW04lfdhLtlVTx4tcwW8wmdPIkydrWTgyuQzrr6f4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=EHrV1XYzMoMMEhMhcGMhcvOlRZx7ZoQQcG3DiP/pD8BNn8Bps1i0WYwmrI048ijgJnRo+OYq17tgnwObZ4iiyCfw7KlWmHJ92cZ3wW2r2Ls83Aal5p3YxKWi4VZuJp/jnNWe9/PGzaOdCGC23DT19KWrY6Rt0/D5liriy8oWtpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPxbWDQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884E4C32781;
	Thu, 16 May 2024 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848091;
	bh=ggjW04lfdhLtlVTx4tcwW8wmdPIkydrWTgyuQzrr6f4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NPxbWDQRpA/EYE4skb6yU0DIkgpvA47+8KFq+2qFumiWAcYliyWqhk0w8xThL9uSp
	 VC6duIor6PlB9gsTW0DSuOyYO6ngtkt6UMzYjaIB+hLLL4uhtrvs6YB5Zx5tjgNtqL
	 d0xEae30sOc/1iJGF0AYipGkcRSMXCf1qy2A+3Nwlwhzss0u6DXnbU+Xlb6qzIz23B
	 Qphp2EQMBbXjdEvDfsYBLn0YRzo4PTS/QpteUz6hzrMIS873zTcQ/uJsO2doL1Nsxm
	 2DbnuEZlntPtn3XtP/LPYZ3THD1b2qsPfe57eaK810iGt40PM+G4A6gBK/RaF24bYj
	 pqravyAw6KxRQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: remove redundant peer delete for WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240510111238.1113-1-quic_kangyang@quicinc.com>
References: <20240510111238.1113-1-quic_kangyang@quicinc.com>
To: kangyang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171584808882.2786544.12095654919526676063.kvalo@kernel.org>
Date: Thu, 16 May 2024 08:28:10 +0000 (UTC)

kangyang <quic_kangyang@quicinc.com> wrote:

> ath12k_mac_op_unassign_vif_chanctx() will do peer delete for WCN7850's monitor
> interface. But for host no need to do peer create/delete for monitor interface
> because firmware doesn't require it, QCN9274 is the same. Also, the first
> judgement is true only for WCN7850, so this logic won't affect QCN9274 at any
> time.
> 
> So remove this peer delete.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3a29442a1741 wifi: ath12k: remove redundant peer delete for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240510111238.1113-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


