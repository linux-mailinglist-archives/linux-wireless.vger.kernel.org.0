Return-Path: <linux-wireless+bounces-10115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20192B4E2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5174CB234FB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB24155CA3;
	Tue,  9 Jul 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdMKSAv4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833AD15666B;
	Tue,  9 Jul 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519969; cv=none; b=JL96XLF5F4/8aQn/91Rq6zSiBHA9Hol8eEIxFuW63QhfopD9aYEb7x8Ieq81uiKWhO1izpYlEsIRhwC4rJnxgETUo7IBFTiKl+iCQnj4jEug+2Wr9ZzEN0xpvtgeD1N3J4aslwyI9NBfupKcoQ1hqMWQcFiximlIHnf4AO6e0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519969; c=relaxed/simple;
	bh=/txAUXvXH1N3SCJLGDO6dYAd9ZoJEs1TBxw/O4akJO4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ayN0vQ+U6ieTratTTDweapeuipk6z7eyl195GxKxwjPlCs4QnA+0QfEyc8jBQNrYZyC4QgUODLGwL9PReAmCYLR9ulhvFqOrqFXGl5WBrfP7A5Qqd2Vm2UHuYIBeskfcXpgp/uF7UuGEtmkQjhBSSLmGznOPNzFnLjuOQDdRp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdMKSAv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E76C3277B;
	Tue,  9 Jul 2024 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720519969;
	bh=/txAUXvXH1N3SCJLGDO6dYAd9ZoJEs1TBxw/O4akJO4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CdMKSAv4t1tLjMg+Nfw7j0wom17tjLxpDARo01IK3ixbri6BUhBttpFe2v/GZpxV9
	 QgOaFcFRIAjvdesnQnebleDOgrxTKN8p3yC+DTpZMfQYAIe/gaPL2C7Ry2HRavfqTF
	 mdJmhOgAfTJ2C8SGlfFbE2Xcwz2VD/rfprMkiqldJ2ATcGUQlNOI9Ckji0vmx+6JMk
	 4gZp15SJILMmNqJFVz1bdkxLPlGk/xzoyEPV3ViY5hvOei6qECrKX9qDR9SQDtu6u4
	 BEoB66juqaxjp9hjBACitgNwer2Nz6bucD8RcpTn2w3JtU/LeCU2VEZJU4hYQUTUPI
	 vgVwNEsUDVCPg==
From: Kalle Valo <kvalo@kernel.org>
To: Nikolay Nikolov <dobrev666@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
  linux-wireless@vger.kernel.org,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com,  nikolay.nikolov@bench.com
Subject: Re: [PATCH 1/1] wifi: brcm80211: brcmfmac: Prevent sdio bus going
 to sleep while transfering data
References: <1c6684f6-d3a8-4eaa-842d-c21fa2dd81c1@gmail.com>
	<1908d5acac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<CAHP5HDP_4NrZtQwcLRhj5efbnZiV=PNZcaeye3Gxx6pqFufyAg@mail.gmail.com>
Date: Tue, 09 Jul 2024 13:12:45 +0300
In-Reply-To: <CAHP5HDP_4NrZtQwcLRhj5efbnZiV=PNZcaeye3Gxx6pqFufyAg@mail.gmail.com>
	(Nikolay Nikolov's message of "Sun, 7 Jul 2024 16:37:18 +0200")
Message-ID: <87ed82naaq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolay Nikolov <dobrev666@gmail.com> writes:

> I am really sorry for the spamming !
> I have not sent a patch to the Linux kernel mailing list for more than
> 20 years and mail clients do not behave as I expect. My first email
> was rejected from the mailing lists as it contained HTML. Indentation
> is not correct in the second one. I hope third one is correct.

BTW I recommend reading the documentation from our wiki, link below.
That should save both your and our time.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

