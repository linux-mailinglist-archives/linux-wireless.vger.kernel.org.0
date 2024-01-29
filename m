Return-Path: <linux-wireless+bounces-2738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7AE8413ED
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A5C1F24AAE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044C7603F;
	Mon, 29 Jan 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS44bL+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66615696E;
	Mon, 29 Jan 2024 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558107; cv=none; b=OLQbd0JVxi7sdefoSWm1/+Z1L8TSJd/axxhPnjKi8cVB0+Sz7kPCPLed+UU8CBDxzMcDmaDMVEixumAS0n+Ho4qPsczp0YaySIDV6teUtHtnwhzHSSsuyvNfNHBz8+fsdtMUT64VWn7zdo656tdmva5dImenX2RQNm2yfqw7F58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558107; c=relaxed/simple;
	bh=0CIB0/TlrT+oPT3ZqRHquCd+EJ3N1LFnuMsYqCwim6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jD13hhgYbunR4zyPy0XxLVkacMIAno4IOpaFpF8QKLCIKhmJKlK6SCSdNtKQf38863jRQ8QAYjnxtvnBp5VTxj9i4kWy1tresNlcTpXd1c1XZ/En/tA5SXRuqsrnbC6v7vngz8RPQyfYoCe1C8TsRONcWv3bImr+9Z58GaA0yUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS44bL+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3478CC433C7;
	Mon, 29 Jan 2024 19:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558106;
	bh=0CIB0/TlrT+oPT3ZqRHquCd+EJ3N1LFnuMsYqCwim6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RS44bL+n3cWWI3YmR+NKdfZUD1FMgwtFVMDo+YkeK/PsEj/HC9zP0r0PGQ0zzS+ZC
	 0XGNulIQK8xzir+f3JRroE/90GaAJ1+ICttRODDqCT8PJClVQ/dik3ZR5JTm1PEqdF
	 DuFjtxi74OXPi6GfuBrg7hAUqBZatGq4IyN7E3v3P6KSlfc9BIC1/vArZEld5ClULi
	 54yihZl51XqGF1kea/if9S2u1pNCjT4+/z7x5KsHFSpPBhu73FliT7E0wX9pSY0/io
	 Pl0BdTZlCsFXhlrwClK12UiJ0sMXdQjsevZ3Qxpw0dWsBmdrohQgHHW5AJdnoQQzsC
	 Z7jGK/vKSaUTw==
Date: Mon, 29 Jan 2024 11:55:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-01-25
Message-ID: <20240129115505.76d35e31@kernel.org>
In-Reply-To: <87mssrxf44.fsf@kernel.org>
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
	<20240125165128.7e43a1f3@kernel.org>
	<87r0i4zl92.fsf@kernel.org>
	<18d447cc0b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<877cjwz9ya.fsf@kernel.org>
	<20240126105255.5476cf85@kernel.org>
	<87mssrxf44.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 12:08:59 +0200 Kalle Valo wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> >> I don't run checkpatch except for ath10k/ath11k/ath12k, too much noise.
> >> I ended up adding this to my script:  
> >
> > We run build with sparse and W=1 and then diff the number of warnings 
> > to weed out the pre-existing ones, FWIW.   
> 
> So for wireless and wireless-next I now check W=1 warnings every time I
> push. We are mostly warning free now but I'm not checking the linker
> warnings, for example the current MODULE_DESCRIPTION() warnings.
> 
> It's really annoying, and extra work, that people enable new W=1
> warnings before fixing them. Could we somehow push back on those and
> require that warnings are fixed before enabling with W=1 level?

My quite possibly incorrect understanding is that "giving people time
to fix" is the main point of W=1 :( W=2 is for stuff which may false
positive, W=1 is for stuff which does not false positive but we can't
enable it in formal builds because the tree is full of it.

> In wireless there is a significant number of sparse warnings. I have
> tried the cleanup people to fix them but it seems there's no interest,
> instead we get to receive pointless cleanups wasting our time. <loud sigh>

Tell me about it.. :)

> BTW the 'no new line at end of file' warning is indeed from sparse, like
> Arend suspected:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49: warning: no newline at end of file

BTW I'd happy to help you set up an instance of our build testing bot,
if you have a VM that can be used. It does take a bit of care and
feeding, but seeing the build failures in patchwork pays the time back.

