Return-Path: <linux-wireless+bounces-8321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80068D4F74
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587201F2442E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F2B21A04;
	Thu, 30 May 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKM1Tlau"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24F219FD
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084320; cv=none; b=sVvXCXHmePI8xG1VBooBa8kfS2UdUbyD8vaFKlVbiHNcxysW0lO2h1LCPsOqQX1b92tbd+vb7i2PKEAuVxqXXpsNz/JBgMs27LHlOr4WFdiaRSfZpn7GkVsGy0e2CDt10X1jy7ZnUltoAufnpMRI1mL5xLlPSKgE3Y0pJNRbYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084320; c=relaxed/simple;
	bh=+t5wnf/lGU94va9o2dOM/f3oSHWw4legoug0aJRpUCc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=PlrOPHLiCB52C3RMRWab/DZMqzYLRso5OFGgKSE90P9ydQUGmMLSaYLuy1Obmvog4M8XclyMSK3xzHQGWe9Jfrf+1k/Nt/X1ir2zE1nULJwjy69FseM7QJJqjW7SkU66tnZWxS+pkQv5y7H3A9U22k2DxHHnXvrPVBtKBAJO4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKM1Tlau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210FCC2BBFC;
	Thu, 30 May 2024 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717084320;
	bh=+t5wnf/lGU94va9o2dOM/f3oSHWw4legoug0aJRpUCc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jKM1TlauUiPBRYFl7lpoi9a3QAup1A+7Gn+tnKR5djhIVLA9eVW4CRZGZYDc1rkMN
	 OpeVIjh8eUf0+xJP1QEHJUWLJNAlPZA+0N6v4ymFG0vyrbPvtm84tVWMNg8vbylUbG
	 15B4uCytiC5mdOPZa54952hvyrM5eMPp/3fOg86WGbZnAVsrSCezKkQGpl7vUOGLYr
	 6tG9lN7bZT7K5r7zxGkqVnoEeJo2huUsO3NKwILd0gRLXcUIeO3X5ghntE9/lrsClG
	 luZ4AzkS7eu+nQ7vLEgJpDKRPLOK2UbbjGK/KrHsx5QhLafW065x3uc2SbUSGEZ8Zj
	 QTvmNNeOyoKmQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: do not process consecutive RDDM event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240529015357.9846-1-quic_bqiang@quicinc.com>
References: <20240529015357.9846-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171708431707.182911.18020118450282306541.kvalo@kernel.org>
Date: Thu, 30 May 2024 15:51:58 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently we do reset for each RDDM event from MHI, however there are
> cases, see below log, that we get two or more consecutive events, and
> it is pointless to do reset for the subsequent ones. What's more, it
> makes reset process more likely to fail.
> 
> [  103.289864] mhi mhi0: System error detected
> [  103.289871] ath12k_pci 0000:03:00.0: mhi notify status reason MHI_CB_EE_RDDM
> [  103.293144] mhi mhi0: System error detected
> [  103.293150] ath12k_pci 0000:03:00.0: mhi notify status reason MHI_CB_EE_RDDM
> 
> Add a check to avoid reset again and again. This is done by tracking previous
> MHI status: if we receive a new RDDM event while the previous event is
> also the same, we treat it as duplicate and ignore it, because normally
> we should at least receive a MHI_CB_EE_MISSION_MODE event between them.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8233d2716570 wifi: ath12k: do not process consecutive RDDM event

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240529015357.9846-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


