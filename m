Return-Path: <linux-wireless+bounces-939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5EB8177BD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F6A1C21CD1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F91E4B0;
	Mon, 18 Dec 2023 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwKCxmKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E01E486
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724A3C433C8;
	Mon, 18 Dec 2023 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702917729;
	bh=aagN5LsIRhwkVrkSFMXW3KVPyYcHS7ZxnLoDXRysDvg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CwKCxmKMq4uadRfQLX3II670KfjrDudWlsjreUQBgWxd6cimzOM79Rtlr1WdLb9gM
	 wQ8v73IpKK4f0Yodw30Jll3COG9w3fKtOLix++u6+lQhBsql05Ag5shDvmaiCi0pFz
	 rI2aZwtzUF1aA5zue31vSDE/+Bz3eIBHj6mN1xASiG46TnLbddn1On1RXb34q5M0L1
	 4xyi4jnYF/TTe2VoVqjbI78Nk3JXTxKk6dqKe0emjEDGPP1Sje5GJF6jJQ9+QDawxZ
	 7LQx8ulDR8TBAwk7tShvt12P2+H78OrMHK9xSJHfmqPUsC6bCTAyNSWwkcKOZyWXHy
	 wn5vT0te924Xg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231215111335.59aab00baed7.Iadfe154d6248e7f9dfd69522e5429dbbd72925d7@changeid>
References: 
 <20231215111335.59aab00baed7.Iadfe154d6248e7f9dfd69522e5429dbbd72925d7@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170291772631.360676.241613506722082972.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 16:42:08 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> On older devices (before unified image!) we can end up calling
> stop_device from an rfkill interrupt. However, in stop_device
> we attempt to synchronize IRQs, which then of course deadlocks.
> 
> Avoid this by checking the context, if running from the IRQ
> thread then don't synchronize. This wouldn't be correct on a
> new device since RSS is supported, but older devices only have
> a single interrupt/queue.
> 
> Fixes: 37fb29bd1f90 ("wifi: iwlwifi: pcie: synchronize IRQs before NAPI")
> Reviewed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless.git, thanks.

400f6ebbc175 wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231215111335.59aab00baed7.Iadfe154d6248e7f9dfd69522e5429dbbd72925d7@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


