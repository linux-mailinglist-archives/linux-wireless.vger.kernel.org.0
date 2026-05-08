Return-Path: <linux-wireless+bounces-36117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPjDKdfs/WlJkwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 16:01:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB44F7834
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD0330B8A2B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105733ED123;
	Fri,  8 May 2026 13:55:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8223EC2CD
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248520; cv=none; b=uK5S1uu1kbXa4OI2MdDloGlJm5YkSMqXCswROof1E5LodFmbwqzQ6ap4/2mN+pp5QH2O/a9K5kMFulBIQJDA/MdihxhrR56HqKSAu68jNeemkU2GykAzBsjYJDDBWfyJ0BE2QjbZalx0xBAMMbFj2ZwXo0K6TJO6ioL+hTAxXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248520; c=relaxed/simple;
	bh=/Y4ZcFAe/iEELrNS7QRb0o3eWro+PU6LNBa2mtRWlLY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lQskniyABWLrnwNSnALVm94Vn3buNSe1jOmrgYnJ9OqWBAO8+VsFzmcLKUuworTtL8xIjWtSS+3+/mUNzj8WyjVxTupuv9bXLCsNgo+CDq7SesnLdOhBQRa4sSsQR8HZqeBfXJ930t4KMp83fTvkTffynG3N+yJ7PCc8jiWjtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E7BAD670C
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 15:55:09 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id B854E670A; Fri,  8 May 2026 15:55:09 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (unknown [IPv6:2001:9b1:efc:9600:673b:b32b:2a17:9d71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 00ECA65F9;
	Fri,  8 May 2026 15:55:07 +0200 (CEST)
Date: Fri, 8 May 2026 15:55:07 +0200 (CEST)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Andreas Kemnade <andreas@kemnade.info>
cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: Add support for IGTK key
In-Reply-To: <20260508102403.4e2fb1bc@kemnade.info>
Message-ID: <a2040dcc-af47-1de0-b731-defffe3ce4cd@lysator.liu.se>
References: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se> <20260508102403.4e2fb1bc@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-471329042-1778247882=:903464"
Content-ID: <5092aff2-96bd-bf45-04dc-25bc0d04bb0b@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: EEEB44F7834
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lysator.liu.se : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36117-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[astrand@lysator.liu.se,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liu.se:email]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-471329042-1778247882=:903464
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <409fd941-97eb-4315-d94e-5af72c3c9f7c@lysator.liu.se>

On Fri, 8 May 2026, Andreas Kemnade wrote:

> Hi,
> 
> On Fri, 16 Jan 2026 18:58:58 +0100 (CET)
> Peter Åstrand <astrand@lysator.liu.se> wrote:
> 
> > This change re-applies commit 2b7aadd3b9e1 ("wlcore: Adding suppoprt for IGTK key in
> > wlcore driver") (sic), but only enables WLAN_CIPHER_SUITE_AES_CMAC with modern
> > firmware. This patch is required to support WPA3 connections.
> > 
> 
> I have seen this after this patch:
> [  484.113311] wlcore: WARNING could not set keys
> [  484.117828] wlcore: ERROR Could not add or replace key
> [  484.123016] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardware (-5)
> [  484.123046] wlcore: Hardware recovery in progress. FW ver: Rev 7.3.10.0.142
> [  484.139923] wlcore: pc: 0x0, hint_sts: 0x00000048 count: 1
> [  484.145721] wlcore: down
> [  484.148986] ieee80211 phy0: Hardware restart was requested
> [  484.610473] wlcore: firmware booted (Rev 7.3.10.0.142)
> [  484.633758] wlcore: Association completed.
> [  484.690490] wlcore: ERROR command execute failure 14
> [  484.690490] ------------[ cut here ]------------
> [  484.700195] WARNING: drivers/net/wireless/ti/wlcore/main.c:872 at wl12xx_queue_recovery_work+0x64/0x74 [wlcore], CPU#0: kworker/0:0/892
> 
> This repeats endlessly.
> As soon as I set pmf to 1 in wpa_supplciant, once per second. Reverting this patch helps. Seen this
> on the Epson Moverio BT-200.

Thanks for this feedback. From the firmware version, I assume that this is 
not wl18xx but probably wl12xx? Unfortunately I have no experience with 
that module. So, while my patch is an improvement over the original patch 
because it checks firmware version, it did not consider non-wl18xx 
modules. 

I guess we need to throw in something like:

strcmp(pdev_data->family->name, "wl18xx")

...in the if statement. 

Br,
Peter
--8323329-471329042-1778247882=:903464--

