Return-Path: <linux-wireless+bounces-11067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254994A265
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9002F1C20A84
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2110F1B86C9;
	Wed,  7 Aug 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2RVAzLG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA21B86E5
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018166; cv=none; b=lWQZEIN5f5wZSghEmh+26qh1Ez+xU/bEfcbtwQRtSRHIDfjCsgTWaHco4yVRmqMp7YlwMg0NTHq5Eh+rBbfTgWTLAuY3ReFA99H56B8e7MbegfFjdF3OMRQmIcY8nPN1VpPEtCqLCHplJ8sCxXkvLDKi9MLDaHioDhLOkYIXr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018166; c=relaxed/simple;
	bh=EJ9VBAMc/aqoyTTd5h2qrW7d/km7rQAEKPTXQ3Cfr84=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=iM6oWscOyXIBXrGYJHzXn/uKNlFQleU0wmG1K5TGuGWWPzCjw9RINpMflD4uOOIVjYKJ5Q44cjeo9JdZSEG+B6imm/rnQF46XXsre7lZuN1VSWa+Alfq4BUKWtj0KVysYgLKNVoCLIdbxjtHhlRz5BKQ0k8FX1A4ubOfG/AsaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2RVAzLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AB1C32782;
	Wed,  7 Aug 2024 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018165;
	bh=EJ9VBAMc/aqoyTTd5h2qrW7d/km7rQAEKPTXQ3Cfr84=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=F2RVAzLGmFka1Gnk+3bGzXGG4Vg3AJrr34jDoEI0J1wHVEuaYAwY2Lj7v6Lk84jQT
	 f/enDga1CFkLwx7D6INgDsa0uSitF2LUBOUbA2se6JOB3/SRidaBXHBVVPSYnnC5kB
	 1uVv320SR3lpFLUTRI5QCEJ1HjlDr036ZYFMorkEdgw6sx1qMF2oziWqxPgAhpp1Kr
	 NUGzShFGi38IJ1zujDXMxqgH941dWYk7q9nGLdMhTGfC9byso9larVBrA66WtrpvHg
	 aF8ev02MFQHBX8SsNwIdq29//VtVFz9Gu7siKPPRElGUiw33VWllZP3AKGU7HgGU4c
	 /lGbJiasK2KNA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: Remove error checks when creating debugfs
 entries
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240805110225.19690-1-toke@toke.dk>
References: <20240805110225.19690-1-toke@toke.dk>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Wang Ming <machel@vivo.com>, Kalle Valo <quic_kvalo@quicinc.com>,
 Minjie Du <duminjie@vivo.com>, linux-wireless@vger.kernel.org,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgens?=
	=?utf-8?q?en?= <toke@redhat.com>, dan.g.tob@gmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172301816225.3837211.6304660014804789984.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 08:09:23 +0000 (UTC)

Toke Høiland-Jørgensen <toke@toke.dk> wrote:

> We should not be checking the return values from debugfs creation at all: the
> debugfs functions are designed to handle errors of previously called functions
> and just transparently abort the creation of debugfs entries when debugfs is
> disabled. If we check the return value and abort driver initialisation, we break
> the driver if debugfs is disabled (such as when booting with debugfs=off).
> 
> Earlier versions of ath9k accidentally did the right thing by checking the
> return value, but only for NULL, not for IS_ERR(). This was "fixed" by the two
> commits referenced below, breaking ath9k with debugfs=off starting from the 6.6
> kernel (as reported in the Bugzilla linked below).
> 
> Restore functionality by just getting rid of the return value check entirely.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219122
> Fixes: 1e4134610d93 ("wifi: ath9k: use IS_ERR() with debugfs_create_dir()")
> Fixes: 6edb4ba6fb5b ("wifi: ath9k: fix parameter check in ath9k_init_debug()")
> Reported-by: Daniel Tobias <dan.g.tob@gmail.com>
> Tested-by: Daniel Tobias <dan.g.tob@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f6ffe7f01847 wifi: ath9k: Remove error checks when creating debugfs entries

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240805110225.19690-1-toke@toke.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


