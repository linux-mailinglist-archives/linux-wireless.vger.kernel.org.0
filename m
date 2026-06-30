Return-Path: <linux-wireless+bounces-38392-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DRQtAWbSQ2r9jQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38392-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:27:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C006E56DD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:27:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FAKx/t6u";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38392-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38392-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 347A530D2DDC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81945425CE5;
	Tue, 30 Jun 2026 14:23:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83257368D4B;
	Tue, 30 Jun 2026 14:23:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829426; cv=none; b=DEY9ZpmRXpSjLEkul+FfIF/e09r893yXMr2obifP1Gv9Mkp9ODYMkELQhRXTK68gWhFpEsSt4F89m60yyqPH375a24kevQ6eSIf9sEqCUbu6ZAuQ3447qAlbqea6moVc2NUxjGLyRCc0nGHhIk4xc6UUPiF2Gtl8Ae782gp4lqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829426; c=relaxed/simple;
	bh=3O5OEYtoiC/BcR7MNSFFY3fLzuzy0V5o6unbzI7k44Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKObPROSD0CxKSzqLh//LOaUZJhG9DFtGEvtBWAkEGhNhXhQHGaRu00wd6z0Lv11HUGc9yot4a+LcTwU6S3Wo8jye0OXP5IDCCh4/SbxNHZYkgReVa2cP8XEnuxFegIr7BUlzuHSMffhFDBROvaft7TvHhEWceEGSKkN3uLk/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAKx/t6u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4E91F000E9;
	Tue, 30 Jun 2026 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829425;
	bh=4Hhhr2XcfubTUcrvTbwWhwLy7CUCWTZEVOLPtuGC1E4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FAKx/t6uR6e0YnXhUD4OAIvzCSGSFQqB0vFZUhEgy2dgiJnluy0duaFK6NLRYiwtu
	 fVDfi6acLZR+l3CUXlY5hftQWt/eE24AJXi/lvEcSdMFqXuJ4frYnZ0itSCqWXgRpl
	 NkxGX/Z1g2YgctN43YDAMXODPkhFFnXpPr67j43JUyr96RZ4YBioADsYLsm1iFUxvL
	 kodoBEkjnvidKLPf8W0IWgLBeeikaJ/MwZ32d9NW2RcMvE5Z8DmTV/IfxrRD1LrLCw
	 CIGyHDS/uvzs9a2YLUoQJ/+oG9AWfESzK2/RaL5bmBD/3DuJWQPM2GV+9y8JozF2SR
	 aMsyqYRgaYGUQ==
Date: Tue, 30 Jun 2026 07:23:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Brian Norris <briannorris@chromium.org>, Edward Cree
 <ecree.xilinx@gmail.com>, Francesco Dolcini <francesco@dolcini.it>, Manish
 Chopra <manishc@marvell.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, b43-dev@lists.infradead.org,
 intel-wired-lan@lists.osuosl.org, libertas-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-net-drivers@amd.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] drivers/net: replace __get_free_pages()
 with kmalloc()
Message-ID: <20260630072344.159b5d99@kernel.org>
In-Reply-To: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
References: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38392-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:briannorris@chromium.org,m:ecree.xilinx@gmail.com,m:francesco@dolcini.it,m:manishc@marvell.com,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:b43-dev@lists.infradead.org,m:intel-wired-lan@lists.osuosl.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,chromium.org,gmail.com,dolcini.it,marvell.com,intel.com,lists.infradead.org,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61C006E56DD

On Tue, 30 Jun 2026 13:59:19 +0300 Mike Rapoport (Microsoft) wrote:
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c    |  6 +--
>  drivers/net/ethernet/intel/ice/ice_gnss.c         |  5 +-
>  drivers/net/ethernet/sfc/mcdi.c                   |  7 +--
>  drivers/net/ethernet/sfc/siena/mcdi.c             |  7 +--
>  drivers/net/wireless/broadcom/b43/debugfs.c       | 12 ++---
>  drivers/net/wireless/broadcom/b43legacy/debugfs.c | 11 ++--
>  drivers/net/wireless/marvell/libertas/debugfs.c   | 39 ++++++--------
>  drivers/net/wireless/marvell/mwifiex/debugfs.c    | 62 ++++++++++-------------
>  drivers/net/wireless/ti/wlcore/main.c             | 14 +++--

You gotta split this, wireless and ethernet go via separate trees.
BTW cocci also suggests folding in a memset, IDK if it's worth it.

drivers/net/wireless/broadcom/b43legacy/debugfs.c:217:8-15: WARNING: kzalloc should be used for buf, instead of kmalloc/memset
-- 
pw-bot: cr

