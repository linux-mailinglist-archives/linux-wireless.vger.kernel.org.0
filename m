Return-Path: <linux-wireless+bounces-21930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22CA99421
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFB31B66E71
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE02857E4;
	Wed, 23 Apr 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="So8kcJYK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CF2853E0;
	Wed, 23 Apr 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423092; cv=none; b=kUPnUUBdmrAN8VFfK1w569vsexl5i3V/fSI5O89Y9VZl+qLL3jeKeODFYogDnCpuK40Lpq875wvMHRi7pFc0n+CCUkVUvxzNxP3r9Ub/nLaweKnF1Dyry9aL/MrlFmvwUwrSUs+KjsqWf3HScspWoYEBrRqwXvtJzyyvryfI8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423092; c=relaxed/simple;
	bh=RvH5FgF81bFkw2pxOgwseRZAgpOXsvqHOEmUofvT3cA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Id8fY9wgc6b1RG+mKCXYbRV01itshQOWkv+ptoL1OnyBbzzyk378pM9roNrCDT7yaBWcXKjUaujXCmwMQznjtv4pg09FPYmA6uygQNTA4i1ML9YYGWwhbh8Yk9gPwVvLgzXHqJWPciZv0QhUzBDgr9LBhNZSmAyZniGQafMYnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=So8kcJYK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RvH5FgF81bFkw2pxOgwseRZAgpOXsvqHOEmUofvT3cA=;
	t=1745423091; x=1746632691; b=So8kcJYKTAbL/D1EBRPJIu5p95H6F7AL1cE/SN9LvsQ87fT
	apYp2+oagzgYrHAKks7YB7dqaJWE6uBtA4HQ6Rnru2RQ/mJfyO0Pzdm5hv+xQLhYgOfV1ELmweBEa
	MR1hXz5tl48BKBmkFkZ10Z3fIUEjNXn5sHmJR2bs9OlDsgr360aAlb/4ysGVAKNQc5fBkiKZDsrx7
	u8h6Mh4nHfyVeRDpFrOG1F6KBWXMvUDbHbz15n0osFxHIH6rD2eDmw1QgAYGKjR7etR7H2wwjpfw9
	538RJ+8uZfTcZN7FsQ8+TQySTp8KkSVd/rzbBXhIfFbJzqiugiph+GwXIXrHt6Yw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7cHI-0000000Ensa-0njz;
	Wed, 23 Apr 2025 17:44:48 +0200
Message-ID: <4a91f731c49d3449632f19dcf4a1a8f5a9eb847b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] cfg80211: Restore initial state on failed
 device_rename() in cfg80211_switch_netns()
From: Johannes Berg <johannes@sipsolutions.net>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	netdev@vger.kernel.org
Date: Wed, 23 Apr 2025 17:44:45 +0200
In-Reply-To: <20250407125345.1238818-2-i.abramov@mt-integration.ru>
References: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
	 <20250407125345.1238818-2-i.abramov@mt-integration.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-04-07 at 15:53 +0300, Ivan Abramov wrote:
> Currently, the return value of device_rename() is not acted upon.
>=20
> To avoid an inconsistent state in case of failure, roll back the changes
> made before the device_rename() call.

This kind of seems complicated for something that ought to not happen
...

And also (+netdev), what do we do in case this is called from
cfg80211_pernet_exit() - leak the whole network namespace because we
couldn't allocate memory for the name? That seems counterproductive.

I'm really not convinced of this whole patchset.

johannes


