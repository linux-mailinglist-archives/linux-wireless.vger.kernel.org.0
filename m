Return-Path: <linux-wireless+bounces-1793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D11082BC53
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 09:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A10C1F25810
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321825D73C;
	Fri, 12 Jan 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ+u1VSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932D524C0
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 08:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA76C43390;
	Fri, 12 Jan 2024 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705047877;
	bh=wy11WvA+L49StKXUfkcnYNhF7BZlgsmUfBARPZg1eks=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JZ+u1VSLguqGGIZ82VsReCwl2NsxooLCcMBT0ylmVYE14zgxLKNMgzEYHRiEJj+5a
	 D7Sy15HZuP6C2lqLtSWseqVyMZ3QqZngiA5ulCL0xCflbhKPxbQ0zlMyH2RUW5J730
	 h6scMZZA61GcyQkCY/vjUfj7U1iUsNg6gjYcGwtUo9ZpoXZnefy5EXENM4qK+zCJqn
	 pgMaNLEs8oswAUVwOmN82pgtFz4ddfOR1zaNHHv7hqK0lt4ueJ/UZGHCzhR7t54MiF
	 OMfuzCbR2w5zYx38EC63ObkuhqGCdDfnh4t4+GwWsJojxWsAgTdX3HPeh2/aXdhSyw
	 /xYxvUW4gArqw==
From: Kalle Valo <kvalo@kernel.org>
To: benjamin@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,  lenb@kernel.org,  Benjamin Berg
 <benjamin.berg@intel.com>,  ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: rely on mac80211 debugfs handling for vif
References: <20240111170629.1257217-1-benjamin@sipsolutions.net>
	<877ckfip1g.fsf@kernel.org>
Date: Fri, 12 Jan 2024 10:24:34 +0200
In-Reply-To: <877ckfip1g.fsf@kernel.org> (Kalle Valo's message of "Thu, 11 Jan
	2024 22:38:19 +0200")
Message-ID: <87a5pb9cxp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> benjamin@sipsolutions.net writes:
>
>> From: Benjamin Berg <benjamin.berg@intel.com>
>>
>> mac80211 started to delete debugfs entries in certain cases, causing a
>> conflict between ath11k also trying to delete them later on. Fix this by
>> relying on mac80211 to delete the entries when appropriate and adding
>> them from the vif_add_debugfs handler.
>>
>> Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218364
>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>
> Adding ath11k list so that the whole team sees this.

Thanks, this patch passes my ath11k tests and I don't see crashes
anymore. But what about other drivers, can we trust that they don't have
similar problems? I'm just wondering should we consider reverting the
mac80211 commit for the time being?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

