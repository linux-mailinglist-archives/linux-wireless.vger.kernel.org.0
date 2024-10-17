Return-Path: <linux-wireless+bounces-14156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED789A29B4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A83B2B152
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09781DF27B;
	Thu, 17 Oct 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StHT1WzY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3741DF26E
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183503; cv=none; b=qz8gvyMKP58dlNP8k0IdwTx0s7VR0UM6lFOkCwl3j7i2VaAtQz3K8qr2V6hemvb3qGQuP49ah9JUVuWn6TTbCyVZ6yIpjowe3jpMwbOHwfrUrSDxAmBg4tborrJsDI/e0BdgFvw88cvDeRJv8VEyq3hnK/8rblia/JJG5ZbIrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183503; c=relaxed/simple;
	bh=GZFeJdtBqmG92zHhf0rmJQUUfs/znDmCPvlSPh/qoSY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uTnj29yHbRi9b5RWld5VWhljkfD1VLQUjjcFlLBHZQSHMS13ZQDUFv+qQWh1jYE8d8jOUCBzir8V3Z/VbE3RWknQCBL1dYM6kDoc3IllRrO3yr9esowTEgMq9FOCAbxKlrDZM8rR33ptXAXgQaj1NqRFdRVad9GvzGuZ8HlSl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StHT1WzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D59C4CECD;
	Thu, 17 Oct 2024 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183503;
	bh=GZFeJdtBqmG92zHhf0rmJQUUfs/znDmCPvlSPh/qoSY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=StHT1WzYL9vhHiNVmuMLss5XZMSwpQbMf2YNfUoWbEiE/yTdYDBzFmbKdh4jaCaa+
	 xCjcVsMb1lqn4A3JrKLqX4hmzIGI71H5Z+uS0ifwKj9dEiDMaDHt62QWgnfGaYsk/e
	 RwWuGbqBLoVHkIkJfAzmVGwhcDby7ItJKG+1gNpFFKvHeR7zBaVfTnp/UtN0fxZlSf
	 /NnIfz/bJQKu7BIDYtvJhdm0NBpsl4R3SWUKD57MmCEmthIUZEBhnHYRop/Pc2CTuC
	 x+kfTuqeh4wXy33bGWCRLUW2WYaPf9JlkbMzg+8NoSSySft6vIJyPkucT+8XzWHMxo
	 170miAdWFCXSA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ipw: select CRYPTO_LIB_ARC4
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20241011115820.070c468b271d.Iac76e81b5cd9a5b949b8c154381128e8131d581d@changeid>
References: 
 <20241011115820.070c468b271d.Iac76e81b5cd9a5b949b8c154381128e8131d581d@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918350038.970100.14963797023108027888.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:45:02 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> With the WEP/TKIP code having moved to libipw, it now
> needs to select CRYPTO_LIB_ARC4 to have the dependency,
> and I forgot to move that.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410111727.FxATs8Yj-lkp@intel.com/
> Fixes: 02f220b52670 ("wifi: ipw2x00/lib80211: move remaining lib80211 into libipw")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-next.git, thanks.

5ab202f26746 wifi: ipw: select CRYPTO_LIB_ARC4

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241011115820.070c468b271d.Iac76e81b5cd9a5b949b8c154381128e8131d581d@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


