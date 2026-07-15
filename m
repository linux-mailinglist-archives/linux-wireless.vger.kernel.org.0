Return-Path: <linux-wireless+bounces-39137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rlYhByFTV2pFJQEAu9opvQ
	(envelope-from <linux-wireless+bounces-39137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 11:30:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60FB75C821
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 11:30:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infineon.com header.s=IFXMAIL header.b=dqMG1d4g;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39137-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39137-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=infineon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CBD3026C09
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2435AC03;
	Wed, 15 Jul 2026 09:22:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E13F788F;
	Wed, 15 Jul 2026 09:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107373; cv=none; b=PRtAV5kO8zWNs0FYShh6f08PmYBHwLdUeG+43Sj2W9uUrSoNDOS1dEh8pdw9zu7NqVT9to1YRV56//J2iVVMRGERF92SEcqnhd/+r3uyhB95zMBF7CkJmQPdhUvPx25APZt1I6rx/sQlcJdVWCaM6X1ENyBgdPVTI8Gb8SKkA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107373; c=relaxed/simple;
	bh=CVcZzAXEg5AQNn1Q2SUlbxYxKW4xgc0u+95fNoEXqwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbiInSoXt5ItMjK8epUGMaZiyCp3MV9MvLEOSH9p3eiv12y+wrFpn4YewKInkkah4zXynCw0wgCBgZO6n7gdt6pVgr+EIMlmZvteY9Oz4Y3Qi0vGqJod8QV3hm2A5gvF4AA/FJPqD5mmSc9X7If7DffkkF9eIywJBkFAJiBtAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=dqMG1d4g; arc=none smtp.client-ip=217.10.52.105
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1784107368; x=1815643368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CVcZzAXEg5AQNn1Q2SUlbxYxKW4xgc0u+95fNoEXqwE=;
  b=dqMG1d4gJKa+LDtE6tbqKfbq3kBFhoWjmAGR+RryQWCteLlFLBWIpGQW
   TYSdAMQ8LfdELNqhDok1grnB4+dld+GokVBWvHBiWDWNo3GsxtwUcJuKi
   6r5sZIDhFzQ/bAwGz8zQF7VZHhbtWv4Rg//yyQQJdYFA6ZPn2a6E8bLOl
   8=;
X-CSE-ConnectionGUID: iGc+MqDoTRmZj1ywcobxwg==
X-CSE-MsgGUID: NQFGeLNFQ/6P7imSqHQ86A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="151709897"
X-IronPort-AV: E=Sophos;i="6.25,165,1779141600"; 
   d="scan'208";a="151709897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:22:40 +0200
Received: from MUCSE809.infineon.com (172.23.29.35) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 15 Jul
 2026 11:22:40 +0200
Received: from ISCN5CG5251XQT.infineon.com (10.161.6.196) by
 MUCSE809.infineon.com (172.23.29.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:22:37 +0200
Date: Wed, 15 Jul 2026 17:22:29 +0800
From: HungTsung Huang <Jason.Huang2@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] wifi: brcmfmac: add DPP support
Message-ID: <20260715092229.GA667683@ISCN5CG5251XQT.infineon.com>
References: <20260708071230.312836-1-Jason.Huang2@infineon.com>
 <20260712223314.2182929-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260712223314.2182929-1-arend.vanspriel@broadcom.com>
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE809.infineon.com (172.23.29.35)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39137-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infineon.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infineon.com:from_mime,infineon.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B60FB75C821

Hi Arend,

Thanks for the clarification.

Could you please confirm whether it is OK to submit the standalone P2P fix
to wireless in parallel to wireless-next origin/main? My understanding is
that the P2P fix does not need to wait for the DPP support patch to be
accepted, since it fixes pre-existing bugs and the DPP patch no longer
depends on it.

The reason I added:
> > +         p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
> >           p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {

was that DPP public action frames can be sent through the primary interface
without a P2P device vif being created. The existing peer channel search path
assumed the P2P device vif was always available before accessing saved
Probe Request IEs, which could dereference a NULL vif in that case. However,
I agree this is a pre-existing P2P bug rather than part of DPP support, so I
moved it into the standalone P2P fix patch.

Regards,
Jason

