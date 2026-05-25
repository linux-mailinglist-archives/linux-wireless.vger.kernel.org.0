Return-Path: <linux-wireless+bounces-36885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LHNDEFsFGoTNQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 17:35:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA25CC57F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CC2303C4F3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881C385D71;
	Mon, 25 May 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWmecoUh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0473EFFDE;
	Mon, 25 May 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723201; cv=none; b=OxLdW1Kv4DVMhlCYR/1mrjfbRvlmg1qwLZMszTxH2ZqtTRc5JcwjNjtTDG16BI7mTwrWJ2nYrolsTqFucsExHikwX/w2CX8wyWBHZrtodGUde59dpeDz6pLsmmGefZX9nU07uDuLSke9nhAYAiRMDKIJxx6ioC6VDeytPj4ZEKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723201; c=relaxed/simple;
	bh=e/BbEQFQadqKlWxSW3cVYJklg4L0FK9pv2nJzfVI144=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hekeFy6USkur8JpvWVCGGseFMBzpme5Ua5cGUnIDuYXYS0EO8EFuY2H5B4DGEhtWsEiS+tpHXH3IhVh2H2Wj3XpCNkaeIDYQ0Pl+g9BNI/byfB1+QuHRbJlIXhSFg9PSxwMkFr/AXmlROe4N3fqLctQ71mkMlNroaQ1HmdKgTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWmecoUh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1541F000E9;
	Mon, 25 May 2026 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723199;
	bh=esStYFOQR8NhoKDZnT5/YGxFs/hefqFxsM2v41z0o+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DWmecoUhOrRhfDi3LaP0alxMe9hYw8eyCUiuk0EhMTeYrPFeboEB24ULpzc7lNJUl
	 MDcj5I6vniIBEh3LHtHpeJ95sIMguueXV06siPGcfPsKPEMoq5mRqQ1I+P6qzU3oNi
	 fwxAENal+bcPBuAGlYDYOrWIKHDnjuPCBVqZw+zCXpSiV4DAEmNSjD3Z8q0uMa7TOo
	 cZCKDpO1bBDsrPpgFHx3F8nvkVWYO41WPdiXZNjMtvH/Jt54csuhu0XzBV3pRNeabv
	 rEL6WTPmcJHaIVVlaXr+OuNN2BLreqWVGTm6L27A08zRQ3raHSVpmaEQwrNkVF9KiL
	 wsDgdc9PLEPMA==
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
Subject: Re: [PATCH 6.1.y] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Mon, 25 May 2026 11:33:06 -0400
Message-ID: <20260525152512.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525054854.2457807-1-1468888505@139.com>
References: <20260525054854.2457807-1-1468888505@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-36885-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,sipsolutions.net,davemloft.net,google.com,redhat.com,intel.com,139.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A8AA25CC57F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:48:54PM +0800, Li hongliang wrote:
> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> [ Upstream commit 7d73872d949c488a1d7c308031d6a9d89b5e0a8b ]
>
> When NL80211_TDLS_ENABLE_LINK is called, the code only checks if the
> station exists but not whether it is actually a TDLS station.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

