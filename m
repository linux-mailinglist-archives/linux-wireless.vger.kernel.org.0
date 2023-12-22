Return-Path: <linux-wireless+bounces-1248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6E81C8E4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 12:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE48C1F227FF
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E11642B;
	Fri, 22 Dec 2023 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0sqN2mn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F415ACC
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 11:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7123FC433C8;
	Fri, 22 Dec 2023 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703243771;
	bh=CYXSLlFqvBHfZEc+Lu3mYNceXKCFOBBD/skhfedlFvE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=u0sqN2mnep+Rvc8hkpb7OtBup8aC8DfuwnkdMpJIcxzyKBRv/MVC0OXpSi8ZgVsY6
	 97vOKb3VtVavMpllji7GqYdypq3NYtw2x5YYkiQA8K2rpFjgb/5WPByMy8oEZxIHC3
	 ghigguHOnPkbnRfnQt2igGGK/TtWnptficqN0AEKg/h9A6j2N2BElOJlrghtGcAt9K
	 S5tlXPuoICHS1Uo3mZ0OLPvqS7nC4Y54SSbjQqpGTJ21EvdPblq1T5IPcP21LcuhRE
	 2KyPrguTLtbTHxqchqJDjvss1HTTEVOAIIUrEDwzEW7L//dlpcOCMMtOQHLOgBikM8
	 YPY2rbQH2pthw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,  Jakub Kicinski
 <kuba@kernel.org>,  David Miller <davem@davemloft.net>,  Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: Kalle taking a two week break
References: <87msu6qlup.fsf@kernel.org>
Date: Fri, 22 Dec 2023 13:16:08 +0200
In-Reply-To: <87msu6qlup.fsf@kernel.org> (Kalle Valo's message of "Tue, 19 Dec
	2023 16:59:42 +0200")
Message-ID: <87edfe1o93.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Starting from Friday December 22nd I will be offline for two weeks. If
> the weather is bad (read: not cold enough) I might sporadically do some
> upstream work but don't expect on it.
>
> Our plan is to submit a wireless-next pull request on Friday so if
> there's something you definitely want to have in v6.8 send it now.
>
> I will be back on Monday January 8th.

A reminder. wireless-next pull request is just sent so from wireless
point of view everything should be all set for our break.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

