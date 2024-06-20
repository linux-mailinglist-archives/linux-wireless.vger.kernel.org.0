Return-Path: <linux-wireless+bounces-9277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E190FFAD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E75285FD0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6843D994;
	Thu, 20 Jun 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL70s2uA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A532D05D;
	Thu, 20 Jun 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873792; cv=none; b=HVjRRB0GLC7bXBq98hBHIcMvRsLYDaaviPR1YFvlyYEKVUk5X2LnsJKLvc5pi3PEZkUD41PpOwAG8tVBuyQ1Nm1SrY59wI08RMnuL9q4a+S2kkNv1Z4jHDOSi0V0dNNUjc6NftbiAqQs4gk8Vafvhi+geoFMN3I/N6cjm3ZTXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873792; c=relaxed/simple;
	bh=D8JkAvyTJRKTs9phf53QlPYRnQ/7w53n6hrOpwgwzuI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YFYJ3sa5lk6qY3UCV8E2+X9mFwaKEGwTnnlMV3vLOj7CHILKFokai5f5byWjl0IlXezSGgsSojymZ3As7NQi6seS8S5BFFI1lAxpOe0QAPYIYj3vyaKTo7NzDy4OMHHU2YDynXh/InmcZlFySXVQRZ67GQdSzlpiCPHpCn7EacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL70s2uA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A13C2BD10;
	Thu, 20 Jun 2024 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718873790;
	bh=D8JkAvyTJRKTs9phf53QlPYRnQ/7w53n6hrOpwgwzuI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RL70s2uAd+Gl4U4lMnjvdt1egt16wD1RBIltCoNgLzFBKvBuUSOpLuM6n8XtCYYw2
	 dENUtpGMzEzBH0HilFTv2//LL/wWRnQkhZGvYyj97IPiF99Qnwr2rCbAkgDLAJPHaU
	 xNGlRIcryZDD2rH2qNG31O6XsZttgaRcSGk5ing87S5wlVuUPtpQa0C9+mmZ0tfC2k
	 OkHw37cYmfrUFwHJ1rU7IIXbAN8vIlyViG/tQzdQuGs9MBnGSfxfAFNCBmaoghOXn/
	 FG4K1tOJdy59oQ7KBKlhRW/rRRTsVTjNTuCjgtLTBQ+39s4LuRA0YJ9eByuux+NRTp
	 B8lJgnPWT9dWQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Forty Five <mathewegeorge@gmail.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,  Bernie Huang <phhuang@realtek.com>,
  "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Freeze on resume from S3 (bisected)
References: <87tthpwkqf.fsf@gmail.com>
	<2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com>
	<87sex93s63.fsf@gmail.com>
	<6970398610c546b1b62e599902c67572@realtek.com>
Date: Thu, 20 Jun 2024 11:56:27 +0300
In-Reply-To: <6970398610c546b1b62e599902c67572@realtek.com> (Ping-Ke Shih's
	message of "Thu, 20 Jun 2024 08:16:21 +0000")
Message-ID: <87v824j8lg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Forty Five <mathewegeorge@gmail.com> wrote:
>> > Please try [1] that fixed "wifi: rtw89: add wait/completion for abort" for
>> > certain cases.
>> >
>> > [1]
>> > https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshih@realtek.com/
>> 
>> Doesn't fix the issue. I get a freeze on the first suspend+resume.
>> I've attached the crash log.
>
> I tried 4.10-rc4 + the patch on ubuntu. Never reproduce the symptom.

I guess you mean v6.10-rc4?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

