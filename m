Return-Path: <linux-wireless+bounces-35689-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBTFL0QK82l0wwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35689-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:52:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81649EE86
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA81300DA5B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039013DE435;
	Thu, 30 Apr 2026 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzohliYs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC336E467
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535550; cv=none; b=XwlJJmOof/QRI5XMOFuB1swaLwki9o94Gl3tD9PS0Zyh/+QP1d29+VZBauRqJ+XPmdqhAZinf8Dku9OxfrRPo2xiYa1BK5RoB97QKvvNjSBFa/CU1BD4aYNWbv2QFl/l05GiPpwClBAv9raZAyeNYfMzlM/R+jh66hijhk4sguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535550; c=relaxed/simple;
	bh=LNI10YJyZvJ1yuxQYKKVFXk8/kFY+3q7VWLxYyrpXZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nav1rzO3IYe9kcncErpa3we34rhc4gYHQzzQdriBKWeMJiSLKGwti8vF71tcvNkwX8Cl1s+cN/QLmfKAovYlTDCOZVm699UjrrOclDHkZEFoQ6JuVKDSg0hBVLHVKZirUUwOJCym4efIDZypUULmgPc7DI0sOM4/scd1ge9V2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzohliYs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so7829165e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535548; x=1778140348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2qUXgIUCBo1318jUIo2mYxNd+0eNFEYCws8Uf63UI=;
        b=gzohliYsU/C1iPG+hgVHKJmYXXl6o1w9LuYQxT5SY/mc9XRrUQzf29dSQmQQgE1BzE
         nGPuldSxhwRC/5YVswCnm6B5VN1dKqe22ks8qt2tjx/ETSKcPjNqrAigptZEs/LO7+eY
         etNSTOp5hEqNx7NZysM7V56qoysKwS00LLfrDn13hgQGpc8DV1nVhMNtQAdXMcWAU1VS
         MVSz4z+y1FMihqumM3wWh8bSwbU0AS2ZwVfWqoPoE2r6vbGO3zBPYx1t2rNs35eUjGSi
         Pdyq9RukQb7GmE94dHrHpjIM591PUwMIfzYMbXp/7jzzSqZnisIHjRvAEy0UJ3/np5RL
         gdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535548; x=1778140348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb2qUXgIUCBo1318jUIo2mYxNd+0eNFEYCws8Uf63UI=;
        b=QA7tOe2JSFOohXM3nQD0wHFHhQYK8QvQts5P/4WKFD5sjCcrYCAXPF6UOpEgMLd9YW
         V6gHD+nri9oUdxg8wHH5YowSk65Fq8cmJbNKT9DkiGFCevR1gpmsgZIjwtkxSyUL1G4B
         yoPxxqitKUJn22l+nmAgnUJECdCY78BV+HaI7X7CetEC2u5GDrZozffjL01z4D4yzZbg
         O3TAVo2ko8e6Up0SLL7NNyK2vI2CtsQI4Prnw6UUPSRsX1UdHla/gx39LDcrDdpatl4n
         WJl63eCayURAD0Q4XtNaGvsI1VT+B17tUj3hC7JgcWOMQt7g0azzDWUBVKZXbcsz8rXc
         Ge4A==
X-Forwarded-Encrypted: i=1; AFNElJ8GANprMg+KUwgT7yn6MKUHM6MYOzNvzmpkJnYmCP/+o8M4KpeGT0zXSOwzdatpUdK+qG2td1F5PryllS/iVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynVhZpZ2KlC3kvBPMdfWxkmxc4vGNp8wyD0GZK3u1TYja4voC1
	F8KBY5exwDIYfdpX3hSQ8Z7/RO5/9U35csTQiTvQyWEqk+hhu7Zs6NlYMhsBUQ==
X-Gm-Gg: AeBDieuojZXzkgvhLwKmUZn5drJ4fPZEHHjNaTOVBtD8QpQrZQwUduZ5hB1MUC4Uw2j
	M/yeNw5GD6l5f7b0WgAVmniWd0CK3fUIrhI3vasxQOPengXguDEgvTrquDArd1474zNVSBuwiEr
	qEU+aK6sEuuxCStT5ofKLxs4ie+gZEu5LtA0DDkE8NPdn9ujjDhXveOoZe4vfmhJiUU9jyWHn7q
	b7NAkOAG3Zq3AXLpxkAYgYmwybjVNU/9lMDs5Lhj22HGetD52Udq83rb6+L8Z4jceR2DOWAcnyF
	tUbihlAA7feVzoUnDCke9Obg+STwsSjihn6NorhkZ8LAkKwUQEzrFyOm7J519OjBrGntx2Ka2PE
	Ef5IqP8pWeYw7USxa7DZKyJaKYn1srCIhVFbs3rmH+5MYCMo4VUswrqn5eboTD+Eb8SWPLgAZZj
	hMaYk8Iz48Uh/DRWiQx2OfOR9EQ8O55Q==
X-Received: by 2002:a05:6000:144b:b0:43d:7e6f:3816 with SMTP id ffacd0b85a97d-4493f42c2c2mr2632064f8f.40.1777535547523;
        Thu, 30 Apr 2026 00:52:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c00sm11298821f8f.25.2026.04.30.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:52:26 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:52:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@qca.qualcomm.com>, Raja Mani <rmani@qca.qualcomm.com>,
	Vasanthakumar Thiagarajan <vthiagar@qca.qualcomm.com>,
	Jouni Malinen <jouni@qca.qualcomm.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: don't allow negative key_len values
Message-ID: <afMKN7JK-E6lIsuC@stanley.mountain>
References: <afLzlDT5VF4D746w@stanley.mountain>
 <fd142d26dbc632b26fe39ba8be29d4915a9f92d6.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd142d26dbc632b26fe39ba8be29d4915a9f92d6.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 3B81649EE86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35689-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]

On Thu, Apr 30, 2026 at 09:05:35AM +0200, Johannes Berg wrote:
> On Thu, 2026-04-30 at 09:15 +0300, Dan Carpenter wrote:
> > The ath6kl_cfg80211_add_key() function has an upper bounds check on
> > params->key_len which ensures that it can't go over WLAN_MAX_KEY_LEN but
> > it doesn't check for negatives.  This could potentially lead to memory
> > corruption.
> > 
> > Put a bounds check on negative values in cfg80211_validate_key_settings()
> > to prevent this sort of bug in the future.
> 
> Clearly this commit doesn't seem problematic, but I'm not sure I see the
> path to it mattering? The key_len should only ever be set by
> wext/nl80211, and that can't really end up with a negative length?
> 
> We should probably just make it a u8 there, no way it's ever bigger than
> that, but I'm not seeing through why this would matter much right now.

Ah.  Yeah.  You're right.  :/  Sorry for the noise.

regards,
dan carpenter


