Return-Path: <linux-wireless+bounces-985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AAD81845B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3DB1F24DD8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCE134B2;
	Tue, 19 Dec 2023 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTEU+a44"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1854134A7
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 09:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94CC433C7;
	Tue, 19 Dec 2023 09:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702977902;
	bh=9AO51jdrf2iEki3XhxKd8nV8XJIxuCu+1/xlPUCtnFk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cTEU+a44kD8UTtUcIoXhH+s9YWjTANXewf2UjZnQ76mUCTq87FJ58QLoQAIlrwq2W
	 /iC+VM/2lX3s9/6kaCQmuBQ8ZEc39SsSzw0gic5ZUPYAjGMfNU8KudWyoKauZc06Nq
	 C+0xMQ4zJRhf/k99hMHpPSMDEZMjNUuowhWrk4u2uzmFeIqh2ZtBTgBKQlDAUXCADk
	 JmeFccRtG08SDC929116PPrl0qa5zFJVHaeyTmi2pH05CEaKhcYpscXeIVnKLpl/Os
	 5etq4Z40DhL3aoIMG7d0fs3APV6lf6ipZQMgQQTkrvIZe73yB7iYQ4C6cR2UCZVx15
	 EPno68Ou4D7VQ==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Johannes
 Berg <johannes.berg@intel.com>,  Greenman@web.codeaurora.org,  Gregory
 <gregory.greenman@intel.com>,  Berg@web.codeaurora.org,  Benjamin
 <benjamin.berg@intel.com>
Subject: Re: [PATCH 06/15] wifi: mac80211: rework RX timestamp flags
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
	<20231220043149.caaf422c940d.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
Date: Tue, 19 Dec 2023 11:24:58 +0200
In-Reply-To: <20231220043149.caaf422c940d.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
	(Miri Korenblit's message of "Wed, 20 Dec 2023 04:37:54 +0200")
Message-ID: <878r5q4k9h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> We only have a single flag free, and before using that for
> another mactime flag, instead refactor the mactime flags
> to use a 2-bit field.
>
> NOTE: For upstream, ath10k needs to be changed like this:
>  -status->flag &= ~RX_FLAG_MACTIME_END
>  +status->flag &= ~RX_FLAG_MACTIME
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
> Reviewed-by: Berg, Benjamin <benjamin.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  include/net/mac80211.h     | 13 +++++++++----
>  net/mac80211/ieee80211_i.h |  5 +----
>  net/mac80211/util.c        | 16 ++++++++++------
>  3 files changed, 20 insertions(+), 14 deletions(-)

The note mentions ath10k but doesn't actually change it?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

