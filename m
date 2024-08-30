Return-Path: <linux-wireless+bounces-12255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2264965D4F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712EFB2254C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02116FF44;
	Fri, 30 Aug 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIoSlefj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80F16C86B;
	Fri, 30 Aug 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011378; cv=none; b=ZRqXi0fAuDu2UwHomtX6pYXwgeK5HlMLoY6Hs37T/xKn46hBeVHErLZw6/f2ZLxIacwoWGa4yCeOgWWs4mTeTmzeB37iiWtqt0mg6xDApNLhlcMiEqXpvBROgnV7jw7JMMvDDeZvvhC/rlMk/YYtzO7pLIJe5ZF0fIRBZqR826Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011378; c=relaxed/simple;
	bh=7vWXtQ9E28kRJVjIwVcQQ9i05NPbbMxBj09ldhUAnlk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DWM91OERjhvjWzdfHg5efSRzoT4IAcWIBDp+bWD9+b+BR7832GB2WS6zVwEBEfwC696ZVEBc2hey8j7VHZDR6Yvmv5yo/HfoLxGLK7nxas5uWnwxrz+1OHASuCyyK/1a9lg5dPjR++8t7tAHZ8DU0bhiMVpfvntMQBk7LfpKUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIoSlefj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C9C4CEC2;
	Fri, 30 Aug 2024 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725011377;
	bh=7vWXtQ9E28kRJVjIwVcQQ9i05NPbbMxBj09ldhUAnlk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iIoSlefjE69bNPEToFn7Hve41mYXY+AqFqCQubAPwKxTeUxGEfF+9U78A68GYwa8M
	 1yMaoWt+N0ium7+FEywqo5Z0asoFjN6o2ud9gm72EAr+x8TfBSmWwNplccNeVkOwIU
	 DzUmHfjZZx1335/pB3oR06zLaqC6ePlT/hXJZFOu9OC3cH4P9eghExoTZLek+TDZjU
	 RE2zHifU/QHMagZM88PSwn8L4TMnjP03sby+8JQRkTcUpLGYCHN1Tgk9kDUPs82OE7
	 IKoZEU1e9jxfWSZAYZr5claQqS+iA3TjkV8gS0jG3oir+IVv4ZWm5mbjC4zKRmYd5J
	 ZoxOa80vR5Pwg==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Ensure all STA and AP use the same channel
References: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
Date: Fri, 30 Aug 2024 12:49:34 +0300
In-Reply-To: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
	(Sascha Hauer's message of "Fri, 30 Aug 2024 08:56:40 +0200")
Message-ID: <8734mmuyq9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> The mwifiex chips support simultaneous Accesspoint and station mode,
> but this only works when all are using the same channel. The downstream
> driver uses ECSA which makes the Accesspoint automatically switch to the
> channel the station is going to use.  Until this is implemented in the
> mwifiex driver at least catch this situation and bail out with an error.
> Userspace doesn't have a meaningful way to figure out what went wrong,
> so print an error message to give the user a clue.
>
> Without this patch the driver would timeout on the
> HostCmd_CMD_802_11_ASSOCIATE command when creating a station with a
> channel different from the one that an existing accesspoint uses.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org

Does this mean that iface combination definitions are wrong? For example:

static const struct
ieee80211_iface_combination mwifiex_iface_comb_ap_sta_drcs = {
	.limits = mwifiex_ap_sta_limits,
	.num_different_channels = 2,
	.n_limits = ARRAY_SIZE(mwifiex_ap_sta_limits),
	.max_interfaces = MWIFIEX_MAX_BSS_NUM,
	.beacon_int_infra_match = true,
};

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

