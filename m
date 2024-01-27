Return-Path: <linux-wireless+bounces-2599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6A83ECA2
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 11:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274D21F237E4
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4E1EA72;
	Sat, 27 Jan 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7DpGUGb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529021118;
	Sat, 27 Jan 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350142; cv=none; b=KEjVoXeUAMpqpJTixGm6ODb8caSYuPRZ1Y/JGuxwLYB+NbMw7GyUezXMumkWXVkYIpLwCHXB6Pn7/qkp0095tVr5e8MuHh46PNOgcNzHW/VeHVRd6J2sZ1rukFYtnJLE/IqSYtWC62OXyfgLk3kjpbQHgzI4cu6VWTzBI+HWhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350142; c=relaxed/simple;
	bh=S9BS/+g4oILp6iKIv7aziRZFylhE+ko3fNGK/iHil3A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=K78T4+NkSwRhnLaWmwD9h4Jl8aUGaNIWSS4G4xD54KbVhDFFr8Erwu4SsqeSSHAMyvgo8UMCmz47qq70X6e6n7Vk7g57HVj9RnO9o4tf8uuvxnMVVDuTX3Fogj/zhSWA5A1zshz00Ps0HEtA6p2lA98TzJlwEGOu8dIOFMWWRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7DpGUGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456EDC433F1;
	Sat, 27 Jan 2024 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706350142;
	bh=S9BS/+g4oILp6iKIv7aziRZFylhE+ko3fNGK/iHil3A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=I7DpGUGbXy/Ew4Ayg88bMJmE9NwJWHrj10GEYlkob4pWPc4BShVQAsvNkjC4XLhlG
	 getqNTNPIQWBA3qs5Nd94J6bjwB9TCyCbdJeIHf7kPfzOHjrY6viBmDgRkuukWUyBK
	 0qlL9kry9TzTrqFgW/ZXY1P08f6IaIyLpd+ABhprYKPSuh5JheJDZK7cXHxg5zD0nz
	 PBw8e71kpmaH1rsKZeGiAstGV1PQ1DOP/MrJySycPuFDpRuz6oXimkYKYa40YpfhMj
	 iRCmCA51PGQZNjmF8WFq9bRkgOHVUORFtbNBpXNiC0hitahjawoj4IvQTXTc+o78vV
	 pRldn+w4HkMYQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
  <netdev@vger.kernel.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-01-25
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
	<20240125165128.7e43a1f3@kernel.org> <87r0i4zl92.fsf@kernel.org>
	<18d447cc0b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<877cjwz9ya.fsf@kernel.org> <20240126105255.5476cf85@kernel.org>
Date: Sat, 27 Jan 2024 12:08:59 +0200
In-Reply-To: <20240126105255.5476cf85@kernel.org> (Jakub Kicinski's message of
	"Fri, 26 Jan 2024 10:52:55 -0800")
Message-ID: <87mssrxf44.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 26 Jan 2024 12:05:17 +0200 Kalle Valo wrote:
>> > I thought checkpatch would signal that or is it a sparse warning.  
>> 
>> I don't run checkpatch except for ath10k/ath11k/ath12k, too much noise.
>> I ended up adding this to my script:
>
> We run build with sparse and W=1 and then diff the number of warnings 
> to weed out the pre-existing ones, FWIW. 

So for wireless and wireless-next I now check W=1 warnings every time I
push. We are mostly warning free now but I'm not checking the linker
warnings, for example the current MODULE_DESCRIPTION() warnings.

It's really annoying, and extra work, that people enable new W=1
warnings before fixing them. Could we somehow push back on those and
require that warnings are fixed before enabling with W=1 level?

In wireless there is a significant number of sparse warnings. I have
tried the cleanup people to fix them but it seems there's no interest,
instead we get to receive pointless cleanups wasting our time. <loud sigh>

BTW the 'no new line at end of file' warning is indeed from sparse, like
Arend suspected:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49: warning: no newline at end of file

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

