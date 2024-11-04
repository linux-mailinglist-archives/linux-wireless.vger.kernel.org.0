Return-Path: <linux-wireless+bounces-14855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 616669BAD7B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 08:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D111F21BA1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62DB18E054;
	Mon,  4 Nov 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln+DPNx2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3A18C320;
	Mon,  4 Nov 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706868; cv=none; b=R8gs+T16Xp0fAk/J8w6phrofnNMCdB9+p4IKGxqSzbgHGVwLoXCN30ISRcAUqlz3I21+vQsAnix0WExLdTsBy3stwBd7G49pYbzGJq+8wD/wtq3TeTQYBMtaERcRTkn1cYTXU1JpeaiJane0MznC5zEUmP1OkXkV18I9h6S8vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706868; c=relaxed/simple;
	bh=WcJE9u7/cHNDb3aaEpLhI+NLJpDcAK5VkMSewML5Cn4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qBplUT2tqMb0tjuVM+F/PA+HR9ISxb6ZXT5YDMTGZqUX2200Lzi45r2Gk9jowCWRqzN52u2uojvaKyk7/F4M6+UxhWh5y9fMRJPRwSbI0djWj8eMTk4YXJ9QkCh/Kyce5087jX67wXEDVFfLBzzNWxCZZbMRsmxASHnCDwTxtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln+DPNx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CB1C4CECE;
	Mon,  4 Nov 2024 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730706867;
	bh=WcJE9u7/cHNDb3aaEpLhI+NLJpDcAK5VkMSewML5Cn4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ln+DPNx2RsXrQdJlflDw6BpIsToLGbqLKAx6X1BHzSppuaFNY0uDPA6wwufZXF52u
	 a2iHd1i8p2ROeFnPeJyumOL1z2Q97ajkpiCSVqJnkhxQ2Zudo9MTyJookqyLoDZ2VH
	 rSIE0Mx9V6Z267rX9R5Q3b6vlVc/BiN7LmW79zEixfYdIvFaeFlTRzUvWfaRkshJ25
	 mTvIyqd8tb6pofxkYIGlKaM3mgs9f/uNgrAGis6SuOFtYYN+lEmoYcN+PsO0kEEcjC
	 LyvcUWRXhg2LRxJaKdQ7iSEJ7qg5pMB8w1exEPcZI9jSkL8wNji8FF1LJ/QxVZ4ZAg
	 aYwa8PLxUyGrg==
From: Kalle Valo <kvalo@kernel.org>
To: linux@treblig.org
Cc: pkshih@realtek.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtlwifi: Remove more unused functions
References: <20241103153857.255450-1-linux@treblig.org>
	<20241103153857.255450-3-linux@treblig.org>
Date: Mon, 04 Nov 2024 09:54:24 +0200
In-Reply-To: <20241103153857.255450-3-linux@treblig.org> (linux@treblig.org's
	message of "Sun, 3 Nov 2024 15:38:57 +0000")
Message-ID: <87y11zxwlr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

linux@treblig.org writes:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
> exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
> unused since their addition in 2014 by
> commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

'wifi:' missing. Also in both patches the subject could be more unique.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

