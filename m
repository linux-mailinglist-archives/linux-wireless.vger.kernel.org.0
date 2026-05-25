Return-Path: <linux-wireless+bounces-36886-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PBiMpJsFGoTNQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36886-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 17:36:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF555CC5E8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BE9304C2E7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC93ECBC3;
	Mon, 25 May 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azwrMXHG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D62F1FD7;
	Mon, 25 May 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723207; cv=none; b=HJyN0mnU2IeL+tlaDmJJpR3wE5OQbTa7lF/T67Xzg9jYaD4JbD0pVz8U20ULEvv4fe3sLTLP/1V36yxbyTRy732oJNicYOYPFhBJnXlAJaVYOcWE+AXzVAPo7qkfdVu3ocjBrSEkStXW5kvNVbWb/lS5KD9K21Rwieo8p2129+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723207; c=relaxed/simple;
	bh=mQTx8+JBjwtGWNdI6X6iCqFOHJjgIcQCDH+F3K8GLIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svZ+Zp9KMnjbHcOPc/fNmZKREgTlR5s3fFI/rBRP+zJOwmNyLnEozOPHJLh4Y8kCGpcjLls2tOejZ/SNpr7kwNioNIQdDwKnud37HMIoulvMekAAyjbKqFZY06GojbclxwtV9Y5fH7MeAxiB+kPVX1Hdm8klzn8wxwRnZ3o9tdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azwrMXHG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07831F00A3A;
	Mon, 25 May 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723201;
	bh=CISIR7dvUTWnzBwx6HUS+J6/gYB4qxLC3p5u6kWh6Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azwrMXHGWHvfkZE8WdMWs1J45ib4tQrjaE7kdf217mEPtxAr26opsAHQ2ONWHYcX9
	 aX8YMmlWgWWTx2Eoq1c78JvAUf2g0wh5uZcrU+gcx7VZ9+DlQ+fU9MAXh7Lsq4nXmV
	 xBuCu81SDF3Q9NtrsEfLRNFgqCutmrIQlIFGTO/vmlMBkMD7WLSa82/MgebTjQU6yD
	 jMTUhqV10K2LL0ZqCDK1XIbBb7cJCWZN1SmaUTySQKZ7aBsx71A/yuJ9WSlB1d/Wq7
	 Q1OpRO3J/MZhZGp87PBdOYyMFjPyvPbE/6MxNq8G9l8H2gHdKdEYlIOE+sMV1B03DF
	 d00ej9iM3TTFA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	kartikey406@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	johannes.berg@intel.com,
	Li hongliang <1468888505@139.com>
Subject: Re: [PATCH 5.15.y] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Mon, 25 May 2026 11:33:07 -0400
Message-ID: <20260525152512.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525060336.2460138-1-1468888505@139.com>
References: <20260525060336.2460138-1-1468888505@139.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-36886-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,sipsolutions.net,davemloft.net,google.com,redhat.com,intel.com,139.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9BF555CC5E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 02:03:36PM +0800, Li hongliang wrote:
> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> [ Upstream commit 7d73872d949c488a1d7c308031d6a9d89b5e0a8b ]
>
> When NL80211_TDLS_ENABLE_LINK is called, the code only checks if the
> station exists but not whether it is actually a TDLS station.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

