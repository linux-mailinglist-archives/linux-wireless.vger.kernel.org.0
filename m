Return-Path: <linux-wireless+bounces-35645-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBnvC5638mnLtgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35645-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 03:59:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98449C2B1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 03:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30F93027132
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD427F19F;
	Thu, 30 Apr 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtQ0IYcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D597255F52
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514395; cv=none; b=ki9EyYXohWWZ5w/llXWw1/A3KedpzvAH9vyOES1GGS8e46gOBhJem+oDTiKTWKfzVcGD8IUhXpSf3IFojJJO2nzNEY70q9Na+M72E26If52oJxwQpWboULjprJXjaJfclOq5/0YaWiSGGSHoZRQ54pxtuBHrhFrWUg68LiKppHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514395; c=relaxed/simple;
	bh=GAQF+VIuKNR7JFPN8esnh64K6j2MDtSOsmVGCTMotfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W48JuMiawMW4JZV7xLSxC5nHWH6n1zx5lvWLlG68j9tDzdK4mLJ+ZnhpFQgKv/kNLiCKE4N1XWPJUogIWrZmri5C5bCZq+RxZHgElQWOb8Ri3AIMKJSVPHCarrvhHs6T9W1+tsVf+uotn6qlzDANh/VuDhmibAi+eox/CCEANyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtQ0IYcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A033AC19425;
	Thu, 30 Apr 2026 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777514394;
	bh=GAQF+VIuKNR7JFPN8esnh64K6j2MDtSOsmVGCTMotfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GtQ0IYcG6DC1a79TaS/ffvwpAPBaOIN2Nf2pICYbhAdlw6QtAC4PFA1vFHuzeN1nJ
	 66phJp5WQ+qCqgp9mVJMBCdOq9A530ml+rhx3cFfWqNlsZ4fo1whDwIa2y2vzUqBbC
	 VT5yvjW516nPoNqzy7A3RZm93wzEyzavQPafqaSNsiJQz+THBICIGQn4X2jSQt7RYD
	 AG96z8rQQQeLlqJQvtXvA6IaYQhZeyuLuu37QPO2uHJ4pI7LCqnMDc2OK+V7eS3Bpi
	 A6LOYxNFUs5k3hf2vIN3LTeP7ytM4qx5eC3EEL9OZT8zCqtNpekxYAiixPYxGk8gL3
	 wHUh1d1STJbkA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 4D9A15FE36;
	Thu, 30 Apr 2026 09:59:52 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: K900 <me@0upti.me>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 Louis Kotze <loukot@gmail.com>
In-Reply-To: <20260428093058.3672383-1-me@0upti.me>
References: <20260428093058.3672383-1-me@0upti.me>
Subject: Re: [PATCH v2] wireless-regdb: allow 320MHz channel width for
 Russia
Message-Id: <177751439231.3356117.7542785326182742344.b4-ty@kernel.org>
Date: Thu, 30 Apr 2026 09:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: AA98449C2B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-35645-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 12:30:53 +0300, K900 wrote:
> The entry was added before 11be (and thus 320MHz) was a thing,
> and there is no actual legal restriction on channel width, so
> update it to allow 320MHz channels.
> 
> 

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: allow 320MHz channel width for Russia
      https://git.kernel.org/wens/wireless-regdb/c/62d72c287e99

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


