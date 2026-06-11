Return-Path: <linux-wireless+bounces-37642-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ELEeBekFKmqlhQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37642-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:48:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39666D8DB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J4crrjwN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37642-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37642-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5686930D72BF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE071C84CB;
	Thu, 11 Jun 2026 00:45:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02D219A8A;
	Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=JP+j3d6Czplg/QvJ32wSad+ornfB04U4ZXGp/3hJUOnIB7lcQ6l8Ewx1zkfO5cFan16pxssghsdGce3DmyldLjLCm4mgSujNncgrIsFuAtNhgqoM/km4Q+ZESBxo00qYH3hGLFFtIzAXoSmtnUj/+Q+JfiEJyRmhCsmi6E9NCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=75GYiiCJml/IjuqDXcFZdCtlD1QjDgbuAoiVD6MVm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnsIRzsnjS32KcHPQ7l/jm4LQdOrv6WhIzNlpEgqdBWmjA0pSlgJyO7kHstqZFH5Sz/IxHe64odNu6qtbYPFGkQx9tcJrZmlwNOaDr99KayKJ4ZQyRbCAjXZQjT5OSg17X3Uxcc4hmZf9V8iLfavRNX0PhgG6XsNiNpv+LjWr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4crrjwN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BFE1F00899;
	Thu, 11 Jun 2026 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138741;
	bh=75GYiiCJml/IjuqDXcFZdCtlD1QjDgbuAoiVD6MVm3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4crrjwNWrRttTx1gI189T+dtVD/Jf1hTjf/xUSZwY00s1CYzR8hS/OoWZtF2rJYU
	 vDMle6JnZzzNwzsmWHEghJsOD+Rl+OOs3JsOxyacs5Mw88hk3qeNrpIvcvpvRP87nT
	 rAFSqNbY2REBCUjuqvy0DB2KXkVaYGGnZW+Lq/ykIQrkvWofCFkwpT+ROM0B5uUfUO
	 Y5OeBC1ernA+Q9njF72Gn8NwiTnYgZO0iwlniPVMaq/N28GHOoO02hcmVjrdmg2O+5
	 ksaq66SJeYjl2AypfbRFpfC73eNn27fIRVvYnsayqNVa4x1/gymxtngFKwi1+DgDDE
	 5sYIx7vrKnE3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 5.10] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Wed, 10 Jun 2026 20:45:23 -0400
Message-ID: <20260610-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609181108.29138-1-apanov@astralinux.ru>
References: <20260609181108.29138-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:apanov@astralinux.ru,m:johannes@sipsolutions.net,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com,m:kartikey406@gmail.com,m:johannes.berg@intel.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37642-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,astralinux.ru,sipsolutions.net,davemloft.net,vger.kernel.org,linuxtesting.org,syzkaller.appspotmail.com,gmail.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,56b6a844a4ea74487b7b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B39666D8DB

On Mon, Jun 09, 2026 at 09:11:08PM +0300, Alexey Panov wrote:
> [PATCH 5.10] wifi: mac80211: check tdls flag in ieee80211_tdls_oper

Queued for 5.10, thanks.

--
Thanks,
Sasha

