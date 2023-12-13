Return-Path: <linux-wireless+bounces-733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693CA810EAD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC3C1C209CD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597D22EF3;
	Wed, 13 Dec 2023 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4r2l8nX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75822EEE
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 10:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7BBC433C7;
	Wed, 13 Dec 2023 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702464170;
	bh=h9Jm4NjJwTZw0xLyMaHDvBK708cAUTtuUTHwL1TXShU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=p4r2l8nX/9T7xJYGhBPdVxyd7dTyMBKsBPDQnPlYV1cC2XmU/qk/IvTwoPKffCUBx
	 9hIUn5pfiEfuf8NWWY/i6Ak4XrpYkFde+gmOnLxDPEH8slRwcnQj9vpkeZtydQDIeJ
	 ZGznlrAknCwbo1LBWMozu+/dXJM7IL++r2xwd1UMhyTI8ArNzXBVZ5Pj8f5odEINDX
	 LzOeNyu7VS+VREqFBBiv7Tu2G2Sf7kNzBsTUF4uRs4TklW8DrD1PZvxS96gJqFg1bu
	 k5yAVNobDiee6am8l4I+uOklhBPsGyqo0P5n5gfwOlEDn4WXKOlQ3fS5xBdJKZMTQ0
	 ygyDPIob+ojdw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] ath9k: reset survey of current channel after a scan
 started
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231205170623.3029689-1-hyang@freebox.fr>
References: <20231205170623.3029689-1-hyang@freebox.fr>
To: Hancheng Yang <hyang@freebox.fr>
Cc: toke@toke.dk, hyang@freebox.fr, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170246416722.1034819.1398233208931697231.kvalo@kernel.org>
Date: Wed, 13 Dec 2023 10:42:48 +0000 (UTC)

Hancheng Yang <hyang@freebox.fr> wrote:

> In the `ath_set_channel()` function, we only reset surveys that are not
> from the current channel. This leads to the accumulation of survey data for
> the current channel indefinitely. This may not be the most optimal
> approach, as we want the ACS to rely on the most recent survey.
> So reset the survey data for the current channel at the start of each scan.
> 
> Signed-off-by: Hancheng Yang <hyang@freebox.fr>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4fadce88cb9f wifi: ath9k: reset survey of current channel after a scan started

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231205170623.3029689-1-hyang@freebox.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


