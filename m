Return-Path: <linux-wireless+bounces-3012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29198846F35
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EB0291651
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A01386C4;
	Fri,  2 Feb 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uruEwuBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D683CC7
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874008; cv=none; b=kWlsHjgN3Ddm3V6XEGNyXMyxUDeHwwRvSm6sqjNG3hBKa2lAbuHWA3oifpPKYdmTr6+oll2Npbo0H6TGWWdLSmcGzvUiX//xSsItV2wO7QjJ82OrYcZwI2/KpgaRZANurbvTyPznuZukE4Qs6mCy/43weDJ/B8/+sqkEaVcpjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874008; c=relaxed/simple;
	bh=nltrT2gbTUIAfAfwQ0HWUyAFPMSVCCTAcX1rFV8pSKA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=G1p8TGwInfCagkVsuKM1+8tSNPZqLC13N7uRQ7d/lm7uviTsN1CCt4m+xQ4ohPQQeVXukkinzwTCHvoH88bqA+WvsgOu2sXm/uitO2z7PdxpF6bGd7qg7FGvjtO34VDPZlxSu+tBSgf59L2/VWyIdfJCOajcFtFjGmqq/vlfaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uruEwuBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EEBC433C7;
	Fri,  2 Feb 2024 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874007;
	bh=nltrT2gbTUIAfAfwQ0HWUyAFPMSVCCTAcX1rFV8pSKA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=uruEwuBzr71AuA6Uv0tBEqsQ+vvAlGM4g18zpiD7l6msCeasBv+eNdajFkqJI8lNE
	 fMpQypUt2xZE31oHpTrNMWjujR3sVa3PL6BNmTbJP0tLp/XIUq/acwd0aM9RcVzWEU
	 XZ9+Ja0j0/sp7Adlnwh0Us2YA4x2KOQEam7B5YQZG4cK9xflvfYE7MWFWwnRRlI5Zq
	 p4jAKMspL4HE2MTwSuBgi2f5lmyG80FaitFNUPU2VlSAHtVSSp3743leXy+VE38PK5
	 xKqwgLIP2YffRmGou3hfBEiUFoUhQroiMira2M8ZN/ws5laOrZUtqazgM37iDLo24x
	 uOCZ+6FHHQewA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until
 init is complete
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240126140218.1033443-1-toke@toke.dk>
References: <20240126140218.1033443-1-toke@toke.dk>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Kalle Valo <quic_kvalo@quicinc.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-wireless@vger.kernel.org, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgens?=
	=?utf-8?q?en?= <toke@redhat.com>,
 Ubisectech Sirius <bugreport@ubisectech.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687400420.3200018.14639804341103572305.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 11:40:06 +0000 (UTC)

Toke Høiland-Jørgensen <toke@toke.dk> wrote:

> The ath9k_wmi_event_tasklet() used in ath9k_htc assumes that all the data
> structures have been fully initialised by the time it runs. However, because of
> the order in which things are initialised, this is not guaranteed to be the
> case, because the device is exposed to the USB subsystem before the ath9k driver
> initialisation is completed.
> 
> We already committed a partial fix for this in commit:
> 8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")
> 
> However, that commit only aborted the WMI_TXSTATUS_EVENTID command in the event
> tasklet, pairing it with an "initialisation complete" bit in the TX struct. It
> seems syzbot managed to trigger the race for one of the other commands as well,
> so let's just move the existing synchronisation bit to cover the whole
> tasklet (setting it at the end of ath9k_htc_probe_device() instead of inside
> ath9k_tx_init()).
> 
> Link: https://lore.kernel.org/r/ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com
> Fixes: 8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")
> Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

24355fcb0d4c wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is complete

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240126140218.1033443-1-toke@toke.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


