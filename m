Return-Path: <linux-wireless+bounces-1753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1982B61B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 21:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FBFB2455E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 20:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1551007;
	Thu, 11 Jan 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6CkQIbT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01382482D8
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 20:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C69C433C7;
	Thu, 11 Jan 2024 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705005502;
	bh=vRdDgyRsKnxPzHcxYChrexN1fX13hfnOre1Td9jWPyQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=b6CkQIbTgKAhRreXZ+7U1VAXvND4zt17FJ+ZqBB8uKtZWXd2K2gsAHcViyIyR2z+n
	 iKwj8O3wzVNaMS1/MQ1nTPBbfznk9vWx0TVe7a0HwmAojy9awL+WlKnyLPup0+oTsY
	 URfmJgUXtiQ0emFNf/hdGcYx3n6e9jV1XJOSx5C13BrvZILqS1qm8SKGffKCfXQt4F
	 B94UF33vIvtrYm2yODExGokP18swJw0dh8m4z1E+84U+40bAcSoPNFICTyjqAUEuW2
	 Q+FreuuTNehA0Gu2zFVg2NYBDcx2C1SEu0qtpSDD98kXbyGFd4mG0OiG+gJdvX7FWW
	 tIjonWzhiLmsA==
From: Kalle Valo <kvalo@kernel.org>
To: benjamin@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,  lenb@kernel.org,  Benjamin Berg
 <benjamin.berg@intel.com>,
    ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: rely on mac80211 debugfs handling for vif
References: <20240111170629.1257217-1-benjamin@sipsolutions.net>
Date: Thu, 11 Jan 2024 22:38:19 +0200
In-Reply-To: <20240111170629.1257217-1-benjamin@sipsolutions.net>
	(benjamin@sipsolutions.net's message of "Thu, 11 Jan 2024 18:06:29
	+0100")
Message-ID: <877ckfip1g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

benjamin@sipsolutions.net writes:

> From: Benjamin Berg <benjamin.berg@intel.com>
>
> mac80211 started to delete debugfs entries in certain cases, causing a
> conflict between ath11k also trying to delete them later on. Fix this by
> relying on mac80211 to delete the entries when appropriate and adding
> them from the vif_add_debugfs handler.
>
> Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218364
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Adding ath11k list so that the whole team sees this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

