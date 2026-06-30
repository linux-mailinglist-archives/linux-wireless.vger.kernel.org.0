Return-Path: <linux-wireless+bounces-38393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4CVUK2HWQ2qJjwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:44:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6E6E5898
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UaRdoyQZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38393-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38393-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A84C3030120
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5C43C067;
	Tue, 30 Jun 2026 14:40:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFE40E8E1;
	Tue, 30 Jun 2026 14:40:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830442; cv=none; b=recVc5TNmnq7iFz9Hghoy7i+zRKtxbqKlvXF+sCIJRZnpo42g5IMHjKzziT8vOan/539OBBxFbWCENfk6h6Oh3JFE2D6lFqhGHARMamSapBjUMLRSBCiCDWLy79+nJOJ7x2rCj0q+QxLreOSGm8UzF7olHxUCFATyJySk4ZZMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830442; c=relaxed/simple;
	bh=k2Gx1TGx8N/jRMuMnS7S+0n8kwKWGU8OEzpkiR0pcTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko7PLMmzboTCEv81XpigQZgqBD8z2vcBIrmNgBCsjP3PmxCdgvyLQco7/mn8jCmAGkV5wNYMOL9EFItdaCd8PyLDZ0K9W+ipyI12y/0LwXrHgdiA8B9qdVa1XqSwTecxCa0yJtUTYbn3feoIpkuRVR5xOajYdsYo6Hm8k9ewHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaRdoyQZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097601F000E9;
	Tue, 30 Jun 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830441;
	bh=dvgyW8X4QaOk9VN18ZFlTY30npYMh5LShKDCXGOsMxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UaRdoyQZ1fTRKLAcvtRM8pCPos/hNLQhMFDTOXBDrPIVVOLNJRA7cU6ka14RHMRFR
	 qWpfgLvKeAkf3XDjCuN2u6VoExWRrn+k9PHdw1xwsfaFYRW6apiRDH/bzW3S/vPXox
	 NDxnR8QhAiI/zPphXPkt1KolvI83eq3Oxp7pH6P8fycRjVpGLO0mOiNQvzLLw+uZ8w
	 WRnUBYhp2jcwsX+8wxOOiEB4mT754vZ1T4aD/zr4L6UdrtAvPeJdD/EC+QwUvwBkRC
	 yr2g0tFvuReybfsvjS3lYxCtUKPjJPqHyXPEmCx9cYMHhnzg+aQfCesR1JnXw5Gekk
	 GQ0tpKu3Pqrmg==
Date: Tue, 30 Jun 2026 17:40:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Brian Norris <briannorris@chromium.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	b43-dev@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-net-drivers@amd.com,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] drivers/net: replace __get_free_pages()
 with kmalloc()
Message-ID: <akPVYpzxwP8CIQxu@kernel.org>
References: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
 <20260630072344.159b5d99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630072344.159b5d99@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38393-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:briannorris@chromium.org,m:ecree.xilinx@gmail.com,m:francesco@dolcini.it,m:manishc@marvell.com,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:b43-dev@lists.infradead.org,m:intel-wired-lan@lists.osuosl.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,chromium.org,gmail.com,dolcini.it,marvell.com,intel.com,lists.infradead.org,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AB6E6E5898

On Tue, Jun 30, 2026 at 07:23:44AM -0700, Jakub Kicinski wrote:
> On Tue, 30 Jun 2026 13:59:19 +0300 Mike Rapoport (Microsoft) wrote:
> >  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c    |  6 +--
> >  drivers/net/ethernet/intel/ice/ice_gnss.c         |  5 +-
> >  drivers/net/ethernet/sfc/mcdi.c                   |  7 +--
> >  drivers/net/ethernet/sfc/siena/mcdi.c             |  7 +--
> >  drivers/net/wireless/broadcom/b43/debugfs.c       | 12 ++---
> >  drivers/net/wireless/broadcom/b43legacy/debugfs.c | 11 ++--
> >  drivers/net/wireless/marvell/libertas/debugfs.c   | 39 ++++++--------
> >  drivers/net/wireless/marvell/mwifiex/debugfs.c    | 62 ++++++++++-------------
> >  drivers/net/wireless/ti/wlcore/main.c             | 14 +++--
> 
> You gotta split this, wireless and ethernet go via separate trees.

Sure.

> BTW cocci also suggests folding in a memset, IDK if it's worth it.

Same churn, less lines :)
 
> drivers/net/wireless/broadcom/b43legacy/debugfs.c:217:8-15: WARNING: kzalloc should be used for buf, instead of kmalloc/memset
> -- 
> pw-bot: cr

-- 
Sincerely yours,
Mike.

