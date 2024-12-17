Return-Path: <linux-wireless+bounces-16494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAFF9F5739
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1147B1895E8B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D921F9A8D;
	Tue, 17 Dec 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6twfzm1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8691F9A86
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464790; cv=none; b=ncv/Mvx3I9TRIlTC7UlxXeK1u/kyNtEVZXi3G1eeEQDQ2MW9HOh94xRqlyalRAubkTyaqt4cWg6U10F9nyphXZnJ6Ql1nI9cbj4q7pFwP0HDJBjaVmZYj4L9/iAy2qb3Teh6l5p0bzHPWqMJLAjLeiuFiUaOclEH7ObQ+DLqvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464790; c=relaxed/simple;
	bh=5sVAcDPFSVsRqsIR9lmQUKYZwWMmNvGk01uv0xvSKB0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NWhQ+/mPXs0yOmLlpyHjBy2fPiS8TRu0hk19ZxupEKsdABeKUGqf/08we1Q4qlXmJ1w9xgX9PhMn+jeP7HjS/Jb8q5x5/3Uc056LXFG+Q8VNGvhdDAen+n2G2IAswRakmZCzKj0moQmsDOil4hYIzrc1W9bcUGnaEnEDWhpkpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6twfzm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393BDC4CED3;
	Tue, 17 Dec 2024 19:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464790;
	bh=5sVAcDPFSVsRqsIR9lmQUKYZwWMmNvGk01uv0xvSKB0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=L6twfzm1ksjxZEWdIAyMGA6F18H18jc8BokuQlJm/B6eJGhxDHP0h2iWYJAfz/mUU
	 ZsA+nmDhM0PSch/jj0rTM0CIywWUjq1+JNgsn7zOM5AlIgLLWGEecQOkLt7jFrFAiT
	 Q7W7Lxyd0MEj26sl0ZgD8+rPLftdFKXSLVj8SOZXOcmRlfq0GKvG9S3S8xHOa2smcW
	 seKIwWPlS4RdWH6fUNeo1hxA/XyunTJao++bKlAzLabCt9P2GvzSaMBTb6CoWPf+++
	 yRV9Hch0m9gx9CNg2D9f6IIvi2b/as4+mNa3kEUT3vTIlWQK3epCEP4q3oaDDcqiXg
	 Db/1UdcI8HLpQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 1/8] wifi: ath12k: Add documentation
 HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-2-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:46:27 +0200
In-Reply-To: <20241217084511.2981515-2-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:04 +0530")
Message-ID: <87cyhqks8c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Add missing field documentation for HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
> command with indentation alignment.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

