Return-Path: <linux-wireless+bounces-5194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6365688A825
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A381C3C0E1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E01353E1;
	Mon, 25 Mar 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRYAdW0G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8651350C9
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374270; cv=none; b=EBKQCjOZKXx6xQ+vn6L8/HN0xzfXVFaSxo35KIV3QI3HYv7zHbQ+rjeCKT1CEcZeKEhpVsoXjYtOvWOFGrVj+ZYhrOlAWP7x2+MZZoogpVgmbWt3DOFCVm7nnuYijkDqMjcivTbw9n24Lf66fTAG6AFH6pJN02hPlPRvL7uyTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374270; c=relaxed/simple;
	bh=Q4/5TnJjjKoqGeXbqJpvnZU4C8F1duMYNsfE+TzsNRs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rFq8ymIbgOaC2WskVCT6bqA54djhDu5V/qnxskGJLR6ohpoVzycQn7FpXTZu69itodoFyVVHafzq/jTH7KF09Upq2R38zhKIgZezbJUUygSKAyWAnWPfWPLDurzGoCeQcfgxmWGFdcTie8h5VekNG7i59znNQmWR7qe/5nK1ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRYAdW0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAA5C433C7;
	Mon, 25 Mar 2024 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374269;
	bh=Q4/5TnJjjKoqGeXbqJpvnZU4C8F1duMYNsfE+TzsNRs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BRYAdW0GhXVUv0i+0+mpBYnErPWVv3fVowHaysDZX7kbeZUxTHtXoEoEsWPKyCI7G
	 YDEECHZWt8RbkKkUULRCBze3J2x5EKIU4FnBe5GcJi2cVCgDkR6FecVuU9ex/YQ2z8
	 KCsoYzOkfHXVZPv3D54NJ4F90f+//aJp29fbUhphKuQxNL52CltOeATvj9I5GXV9/B
	 oG7n1FAM07Eqf8mZxg2LqR1DCp8Yb+Uwwq+OPAxSLle6pirhJOHc3EyT/ESnp1tjeY
	 AeHXatQvv5+UxRxNExSeVm5nyblT5UjSnn5c13rlo26lMyMQNeS8KxecYfeFar3dn0
	 vxRzIYkdBE4Sg==
From: Kalle Valo <kvalo@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: fix mlme_link_id_dbg()
References: <20240324160559.18861-1-johan+linaro@kernel.org>
Date: Mon, 25 Mar 2024 15:44:26 +0200
In-Reply-To: <20240324160559.18861-1-johan+linaro@kernel.org> (Johan Hovold's
	message of "Sun, 24 Mar 2024 17:05:59 +0100")
Message-ID: <87le661l51.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johan Hovold <johan+linaro@kernel.org> writes:

> Make sure that the new mlme_link_id_dbg() macro honours
> CONFIG_MAC80211_MLME_DEBUG as intended to avoid spamming the log with
> messages like:
>
> 	wlan0: no EHT support, limiting to HE
> 	wlan0: determined local STA to be HE, BW limited to 160 MHz
> 	wlan0: determined AP xx:xx:xx:xx:xx:xx to be VHT
> 	wlan0: connecting with VHT mode, max bandwidth 160 MHz
>
> Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Thanks, I also noticed the extra messages. It would be good to get this
to v6.9.

Tested-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

