Return-Path: <linux-wireless+bounces-25553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB9B07D30
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 20:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D4508109
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36248263F5B;
	Wed, 16 Jul 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNxPkrQb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98F21D5B8;
	Wed, 16 Jul 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691859; cv=none; b=Hlj+n13K4PJOUSLTC1edKkv5EyUx6+mO/YAtmT+CANPWAL7nNTayviUDpCZgfPLsI5ZjZ4lDtrma8FyYt1DVhxIz8AlbdU6LmKjCUtgquYl8+JERk+cFPrX2VPb8EsRWrcgdDpSnEsIPRfrPC2cduwaRP/6lAhWPVYC0sEkr6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691859; c=relaxed/simple;
	bh=W6h/SnzT6nbFbhbhY2xWkr/3zxTcOXH+FtMA+8NoBUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DuuKV3Wbi/Vck5ySr7Wyas1cuJ7YqGyo5W559e+SPNW+jpufnIrSKvbxO3kOXv1tUUsodO9/wZ5rhsJ+fHwsKLccfpj8dA8mh95J5NG/8o7GHhh65JGCgrURgHF1R2rxeheF9vheoOmmJ6EVesbA3nxdqDRawU6ldBkmIKhkZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNxPkrQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641ADC4CEE7;
	Wed, 16 Jul 2025 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752691858;
	bh=W6h/SnzT6nbFbhbhY2xWkr/3zxTcOXH+FtMA+8NoBUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iNxPkrQbFhdyfdldCpmAiUuyDQDAUUw4yMZqpzyJdW7BiH0RIZIkSyi0z3r7WBhET
	 iIslmHcqoqawp3pVnQGTCHNG86N7iRosOWtWBdRp8ZsUzvDc/i0Ua0pj8tcdb4/066
	 q9AFJ1Biz378tb55xD7kS9LNt+T1QMJRxCvJLMdStnwEtOsQAms4WSDr2SNWoyv8UB
	 BfJ8QPUlmyp3zjKgglVHjR7blIV4pCp9Lp8MNoPO+I1FcVnl/NWVGz0QRXv1aQ4M5w
	 WQ0I2e2hm/T6GSHtFs575aRFS7HW4ZtgVVaa3R746pbN38eIcbXhsgi3SKnpSikCjl
	 BXpweu0bSvGmA==
Date: Wed, 16 Jul 2025 13:50:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi: suspend failure, bisected
Message-ID: <20250716185057.GA2548435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDsNn70jcX6sDLLT@debian.local>

On Sat, May 31, 2025 at 03:09:35PM +0100, Chris Bainbridge wrote:
> Hi,
> 
> There is a recently introduced iwlwifi regression on suspend. It appears
> the bisected commit was only supposed to fix a warning, but reverting
> the commit (with a small change for revert conflict) does fix the error.
> 
> 7438843df8cf7a484303caee7540a00f0ef972b2 is the first bad commit
> Gustavo A. R. Silva <gustavoars@kernel.org>commit 7438843df8cf7a484303caee7540a00f0ef972b2
> Author: Gustavo A. R. Silva <gustavoars@kernel.org>
> Date:   Wed Mar 26 18:04:02 2025 -0600
> 
>     wifi: iwlwifi: mvm: Avoid -Wflex-array-member-not-at-end warning

https://git.kernel.org/linus/264c844abb29 ("wifi: iwlwifi: mvm: fix
assert on suspend") appeared in v6.16-rc1 and includes a Fixes: tag
for 7438843df8cf.

264c844abb29 is not exactly the same as the patch Miri posted at
https://lore.kernel.org/r/DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com,
but maybe it still fixes this regression?

If so, can somebody send the appropriate regzbot fix command to remove
this regression from the tracker
(https://linux-regtracking.leemhuis.info/regzbot/mainline/)?

(See https://linux-regtracking.leemhuis.info/about/#tldr)

I feel like I might be missing something because there are several
regressions in the tracker that *look* like they should have been
resolved months ago.

Bjorn

