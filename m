Return-Path: <linux-wireless+bounces-2179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE88319F5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 14:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA00B2618E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168F250E1;
	Thu, 18 Jan 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te0grm6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1D24B57
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583139; cv=none; b=cfAPA2EI5xoD7JR0FllDkJJbNzDbmLV49bT9wF2YBDEtRHYTO5XtKZniYlEunJRiRaPinajA/LFRDhKcsHM1TauBp8v96ldcgwUdtU9ZWkQJzhlbiqlh5me6ISSi9qJuTZwficJ7AfwldzNXPtstfqPGMnsjl5zHC4o6z/4T8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583139; c=relaxed/simple;
	bh=24zmHdIg4pzOYnnPg0yrJnVfSU5c4j7B1lDcVadahuQ=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=ZaJfzJ5WDMs9TL+aSJmfvRP8uQ+JnGxeNEPV2l/ltYlXtABB/yqfeA4qftI71POirfHbbvA85KwhwIaSX+uTE83EQv4VGhw3xxgoBw1A25yVYs++4gSNY3ZSBY4ZQO1T3HOqN9jcZKw/ESDApH4VzghPCJe5rUPp/r5Che56Umw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te0grm6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609F4C433C7;
	Thu, 18 Jan 2024 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705583138;
	bh=24zmHdIg4pzOYnnPg0yrJnVfSU5c4j7B1lDcVadahuQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=te0grm6G4iIP/jjvtvLNeX9MEcPZdrNRy8M/98OlGrSEbOR9pYrokDSicEIohjJ0e
	 Ak+3mUauK5hva1NU47zgW9UaPZ+pvlFN3IvUtb6yYXWqCWufcJxMf+bEtpSGs7A0AL
	 b1SgGB9uNxpzgHQatsV02U3coVi4cyhVdyD8mQ+5KvaKDpaIyMJPznkbwO5UNFrWym
	 UDlAFvZNmnPCDb0zdRmi9CXjHhn7jHWWQl8KQosXdN3zwV/f9HwvsLPZDaKHW+yHmV
	 W95ofBRXuKz8G+dLaf33OxhZsCnmH4oYXTW+8fvgztrFWRdI4qihP6YsT+MBzoARCm
	 ZnvMoAEJLluIQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 2/2] wifi: mwifiex: Use helpers to check
 multicast
 addresses
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230814124212.302738-3-ruanjinjie@huawei.com>
References: <20230814124212.302738-3-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: <briannorris@chromium.org>, <johannes.berg@intel.com>, <Jason@zx2c4.com>,
 <toke@toke.dk>, <tj@kernel.org>, <mukesh.sisodiya@intel.com>,
 <quic_vjakkam@quicinc.com>, <johannes.wiesboeck@aisec.fraunhofer.de>,
 <linux-wireless@vger.kernel.org>, <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170558313447.2924528.4655629471937055553.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 13:05:36 +0000 (UTC)

Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> Use is_multicast_ether_addr() and is_unicast_ether_addr()
> to check the addresses.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Patch applied to wireless-next.git, thanks.

899c0e8a2219 wifi: mwifiex: Use helpers to check multicast addresses

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230814124212.302738-3-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


