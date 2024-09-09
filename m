Return-Path: <linux-wireless+bounces-12647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9349712CA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80991C22319
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952E1B2507;
	Mon,  9 Sep 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5YHHcDu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2D1AC88E;
	Mon,  9 Sep 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872480; cv=none; b=V7WfgGU1iDGRyQc4aiqtBWmusybghC/L0k+bA0dIyKuGTXCBs3dVuIPcTBU9KO5TQtydWx1RIifeQEIsWZKH7edIL4GYZli733nb5EFdofROu34LZVppRKUq9O8vgeL/D+TvY0IvxA9wy063h6WZ+3j0ecYLUU7Y+R5sniznOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872480; c=relaxed/simple;
	bh=4d9kNtPYicQpBDwPC3UVFcQ+JcCZq+LdEgthPNhOu4U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Dly9KFl7CfyLNhHPz/goejSYTWkaFGw2DM6AbSyLyMZnoSLGeBtiIPJRjFGOqVUdJW/NIh1V2HzVd6n8KozPRIuXYoGGiYM/C7o+NOBxMbevW/sxR+amBGDtgXU5rsoYiLnewHmCDjr95w+xwBuOGEME2csE/6G3zS+JK/7jt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5YHHcDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A442DC4CEC8;
	Mon,  9 Sep 2024 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872480;
	bh=4d9kNtPYicQpBDwPC3UVFcQ+JcCZq+LdEgthPNhOu4U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=K5YHHcDuf7FUVpd+cokb79EzUJ68K6X6euqr/DgSBXNtX00rncScPRJGeUmn4WCIc
	 BakduMd2qwp3nuIFxx+a56jUD3X3u7CLQXOCZ3RJL9FKOmvNqIQb839eSP7cj82NCh
	 139Z8FUupDwIUF7DuoA9W6aTvJIlzJNlEYk9aA8oqlrV7fpwtmngH2sHDD4rXTxo74
	 jPue54+VyZSCgTNWTG6eVhLszQHoPk7rOmY8aDdj4eBddrpY89VeycoaFBPpJtazhQ
	 laQoxCqsjQv8KLk3iWpIvCbUo0mspJRqZT2Qcjc08r+aJh5sD8XB9KVmssQVmRar4I
	 inXx0UzMEl8cQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Johannes Berg <johannes.berg@intel.com>,
  linux-wireless@vger.kernel.org,  Kees Cook <kees@kernel.org>,
  linux-hardening@vger.kernel.org,  lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: wireless: fix two more possible UBSAN-detected
 off-by-one errors
References: <20240909082348.1080511-1-dmantipov@yandex.ru>
Date: Mon, 09 Sep 2024 12:01:16 +0300
In-Reply-To: <20240909082348.1080511-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 9 Sep 2024 11:23:48 +0300")
Message-ID: <87r09tgq03.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Although not reproduced in practice, these two cases may be
> considered by UBSAN as off-by-one errors. So fix them in the
> same way as in commit a26a5107bc52 ("wifi: cfg80211: fix UBSAN
> noise in cfg80211_wext_siwscan()").
>
> Fixes: 807f8a8c3004 ("cfg80211/nl80211: add support for scheduled scans")
> Fixes: 5ba63533bbf6 ("cfg80211: fix alignment problem in scan request")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

The title prefix should be "wifi: cfg80211:", not sure if Johannes can
fix that or not.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

