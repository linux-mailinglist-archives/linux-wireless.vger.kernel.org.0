Return-Path: <linux-wireless+bounces-34869-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJslHgxs4GllggAAu9opvQ
	(envelope-from <linux-wireless+bounces-34869-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 06:56:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6E40A3D9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 06:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05AD309FC73
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 04:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD16199E89;
	Thu, 16 Apr 2026 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJvUnUj7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D733C183
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315377; cv=none; b=Sv65Hb2Kc6hLnyUmBqPjM6R57cLznGCYsilPwxCr4Rny4BSgsK1e14z/FzLwEGPzPvSrlO1aFNqOp6532jof8oHkdjuuv4K+eQD4oDdvKhBUrwTIE1FQvQp/chH/nEnzzOoRNAuCW5Jzop9s76aiDflsM0VzUY5kkybRnbztYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315377; c=relaxed/simple;
	bh=COulZOEwfOKfCIa9C8s71cJlBqli43niVe/GII6z5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZo0XW++N//0wGVLuHpqQ/VkMCbbli7BVTYK6wINBX6vET1AfHQWHHVWmbftDPEr4RD30LCglNKi2U9UDSNfJuCHzVcjBC/kmNggMVKBWXGVSDYJWP8hR1yB0LRVIWvs31mIuFsp69/YeLDuWFUoYesmBa8LsZebdu1jcaKhKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJvUnUj7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0046078so72893925e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 21:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315374; x=1776920174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COulZOEwfOKfCIa9C8s71cJlBqli43niVe/GII6z5y0=;
        b=CJvUnUj7PnHMhXHc8PidN0J7eDSlDIs+FfQKBSYPKHjPKFNOUEQ6lb9unjSrZejNBK
         nC4aXtvD2gCx30uJNXlYGZxkyTsDkklnJ9MJGCcB6AADUCXGn9p9W8jZ5gGv8SDmCuVW
         ADJn44J/RkRqVjWW6nEVpB4Q2UPHhONV+jG/mFrd5GGlWmIPx8ua2phSwCAXfZXxND5S
         B3wKpEIMn8ihVAM5O3tm3FFqBolBeh1Ml2PjQTW6mKg2s7Rq6tCWxXpMAfomABguJ/DP
         WlGxOeoI9O7I7SoCwq6Jp+Q7wCZLqu3qj2/3X2Rx5EV9piN+nwnTY6azs4ZxIeXs4udr
         xaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315374; x=1776920174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COulZOEwfOKfCIa9C8s71cJlBqli43niVe/GII6z5y0=;
        b=HpIjaASf41AONDIE8Dm7+/BqvHizEfdUwq5Ot1E9iJizqH1LokiK3MGv0E0Iig6Vzo
         2w1v+MLyZrOSeHwUy6+XeSGSGHX84wdSqtTi/UkD0NhSYB2NCr5foJHMyZELBClimuBv
         FYjZ42z3smwDYhpgYief9LnDkJGNJXU26llzzeMcDDUv2HSc9hmbS+KfUMGuLW8fzdzG
         mzpjp3IyzBZBEYvhB+Sp4nhredzm7hYQxngbPoQ5bVnj95DjRqiep50mziThPKHal8qn
         BnkDPm2RGg6Cdu8/ic9jvkvJwjleLoKPk1GlDde8Iy09Iywu1f69qBg0HQsrMVbJ5fsa
         8q2Q==
X-Gm-Message-State: AOJu0YxXINqojTIn6kK2oRxC/sQZJMKkHyo8wLzHCyUFfOOqe6Iv8Ezk
	SBaZb7VDMrV4oKlX++KQzKfFScKYyBQymHHIP/upMblTGt7S334aIvS6
X-Gm-Gg: AeBDieteqo4UWlHl7QzN7RJexEXfUVHBV1qBtlOmLXwhp3zSD7lR6xuyoF/VjSm30ic
	Hpqajdnr5vy0Qhf+sDL08IJRxWKyIPCO06d9Oj5Sz7HcF2IZdySH7jP8OVJGxJ0AHibqrixqDPs
	8YTa4CJ2BDb96bqgDQv5f143BNYitCp3PStZX47oGVc+1ZoA4m9i+qkJeWd2qNzC5ABHD89S+Fv
	LoC+d/+17adVc561kSQGiT0X0IFv6bQdiim6LkWEIJPquPqkVH97+YzXb4FoU7c3vwyndmWFdKp
	T0DUiDTFTepkt4c5WsdMeHap6qJZTl8Y7R/rNs+rFPWUWe4txryyLXjdrP8XSZAR7tqbeNYQp2e
	RD68ks/YOWhH2i80ysI8jQHVOskjQAbSUA/Ay9htQHSJ24nnqL3+B8/FDQa6rWXxRMNog3pCG9k
	s9iR4PVdSxPyXwPOMa4ZWqy6P+7rT4XBRAfQtAirZyodzsu7xtI/OJ/g6qrQ==
X-Received: by 2002:a05:600c:45c9:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488d689d277mr328531035e9.30.1776315374082;
        Wed, 15 Apr 2026 21:56:14 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813665sm24669235e9.2.2026.04.15.21.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:56:13 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	lucid_duck@justthetip.ca,
	Louis Kotze <loukot@gmail.com>
Subject: Re: [PATCH v2] wifi: rtw89: phy: increase RF calibration timeouts for USB transport
Date: Thu, 16 Apr 2026 06:56:00 +0200
Message-ID: <v3-reply-to-v2-review@loukot.gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1a90ff00d83c47b995cf75165b2a304b@realtek.com>
References: <20260410080017.82946-1-loukot@gmail.com> <20260415111339.453602-1-loukot@gmail.com> <1a90ff00d83c47b995cf75165b2a304b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34869-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,justthetip.ca];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EC6E40A3D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Can we remove this phrase? No need to mention v1 in commit message.

Done -- reworded to stand alone without referencing prior versions.

> I'm not sure this should be called "bug", as Bitterblue has not
> adjusted these timeout time by earlier version.

Fair point -- the timeouts were correct for PCIe; USB was not in
scope yet. Changed to "condition" instead of "bug".

> I'm also not sure if this is correct. The calibration time of DACK
> might rely on WiFi hardware and external components, not only I/O
> speed.

You're right, I overclaimed. Reworded to note that transport
round-trip latency appears to dominate under these test conditions,
but hardware and external component factors may also contribute.

All three changes applied in v3. Also added Tested-by tags from
Devin Wittmayer across RTL8922AU/8852AU/8852BU/8852CU (Framework 13
and Raspberry Pi 5), and Reported-by with a link to his xHCI hard
lockup evidence.

Thank you for the review.


