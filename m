Return-Path: <linux-wireless+bounces-17321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63286A0911D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4126D188DA1B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1E204F85;
	Fri, 10 Jan 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl/Q/O+x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D661E507;
	Fri, 10 Jan 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513500; cv=none; b=nrTBBX0TIHn8rOaQhcPWYHzhx5QX0qjwrEd8cUnalKmYTPoZqp3RVCkoV7C6fPEBmUCQHUU0I5pQLVAtWf5YI+781hhyq+Awx92yfktCknei9X1C2Qc1YbePtgw6WHS+J3uDzEQaOlYan1jbWlrTIMCYdrebaYRahcFTmS0ETEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513500; c=relaxed/simple;
	bh=bmXvyonbAZo9IuyHvZPerWjGMEYdqXGNpJbnxg3gt0c=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=hCid5S4169GYZD203ipOZwVdi9QsVofiUfPPxNgaEhTKjbA0PUxZYX8PCMq98Cz08MO20/3DbZYyVo5SaBCjLRpTyQDeDMQHNaNB1uSSPY70X84V3XJzLvfIQ/oTEIqUOsCefXejfqxVj8MngYoHLi1Ob3CcUxWyEn01ydXqr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl/Q/O+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99194C4CED6;
	Fri, 10 Jan 2025 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513499;
	bh=bmXvyonbAZo9IuyHvZPerWjGMEYdqXGNpJbnxg3gt0c=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bl/Q/O+xDGuD6EPdDA+hbluI4K51Qg6KzzbcnPXVzXqimmOS8SGuuT98JjJYtzjQA
	 mY+UxIAmPNShS4HxAIn3tXRF3nSTv3zGUlpOVyTXVz/8NPREiJwfLTeqRg4gJkgOKI
	 a5YAgaHfO0otq+AfrIcOllPXJm8UjuIlESJcXkxjNEN/5JaQjHoBR0rrkzMs5b5ZzI
	 fgne8d6sZnPsyeS4oO8zO55H6S8+gJlQBSNGXHUNnIFI6BC6KxPu/3ExFF274ShqTP
	 PNKqQBpCD+LED7TlboBb/0hCD9AzqToEyqmmRfVuN7MtbVyKNw8lP1Mrwl9GQHFzps
	 OzI4vwPTjZaKg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wlcore: fix unbalanced pm_runtime calls
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250104195507.402673-1-akemnade@kernel.org>
References: <20250104195507.402673-1-akemnade@kernel.org>
To: akemnade@kernel.org
Cc: rmk+kernel@armlinux.org.uk, johannes.berg@intel.com,
 miriam.rachel.korenblit@intel.com, leitao@debian.org, andreas@kemnade.info,
 emmanuel.grumbach@intel.com, tony@atomide.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651349603.72755.11277093169203058446.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 12:51:37 +0000 (UTC)

akemnade@kernel.org wrote:

> From: Andreas Kemnade <andreas@kemnade.info>
> 
> If firmware boot failes, runtime pm is put too often:
> [12092.708099] wlcore: ERROR firmware boot failed despite 3 retries
> [12092.708099] wl18xx_driver wl18xx.1.auto: Runtime PM usage count underflow!
> Fix that by redirecting all error gotos before runtime_get so that runtime is
> not put.
> 
> Fixes: c40aad28a3cf ("wlcore: Make sure firmware is initialized in wl1271_op_add_interface()")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Michael Nemanov <michael.nemanov@ti.com>

Patch applied to wireless-next.git, thanks.

996c934c8c19 wifi: wlcore: fix unbalanced pm_runtime calls

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250104195507.402673-1-akemnade@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


