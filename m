Return-Path: <linux-wireless+bounces-34920-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJYxOYDo4WmKzgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34920-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 10:00:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A753941853D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712EF305650F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E936C9C2;
	Fri, 17 Apr 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cqknvmtr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C148367F58;
	Fri, 17 Apr 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412774; cv=none; b=QNHDP87o8wtz8vZMOOsOp22YiVI+QuFKPA8X/sdsZMWMA9rrkb38GPpVtP+9+a75C6itSmCasKf+h0ep7Zk6HdX3II4CCo3H7MNBbS6JPUMmX8q2ROkglS7k4EY1A4BteKbJAlxoTNJcR99uu9P67LpUvxKuiZzVN8F4MexCpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412774; c=relaxed/simple;
	bh=1Oo25sNWeqw0+FwLB3rRPnUvANXt4/KqwDLC1UVCdU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AIwF9Yya6K9g33AjQh0QRdBrAWsRLC6Y1Q1mHfzOGog7WG2WN50/4sNq0KdJLwVbhS/mnSmjFRYR2OfnzEWISBHopGIUbdoEUh+n1nAzkdHXhovJx5XEZtT1bVbxoTytCL8/0d9/lLfDAwdno2bi88a6/aTNdT6gROW7PwgN8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cqknvmtr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1Oo25sNWeqw0+FwLB3rRPnUvANXt4/KqwDLC1UVCdU8=;
	t=1776412772; x=1777622372; b=CqknvmtrKXtVD7EB5u5U71rBDV2/uNzQbBtWTq7YgP10+PR
	9CL0A2j2GvTyDKOHxwvTA1FgyFDei7p9CgbBQ1M2CrbH7F8XLJbB5K7grcsycqqIVCwogtlp31NpU
	DT7dOl4BKnekHAn4CTqegsAZ1P9RvnEJ1lMcjMyz/SaP3L4M42EB3Bc34ZUqdsnA1kpbY7u9DoBdc
	VLL2vsqiBNyjQpJ0tme2sHXNs1turOkuIbFuODf1ndIW4IK77d4/D/Wi9BYn/xe4jcjFNFT/ntRlJ
	XyQaNhTD/2+o5QxHaLJCIioGtnq62hWwi8zvzPk++Cf18QPEMxPI4O6WG50pq3RA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDe6q-00000008Mqk-1Zzs;
	Fri, 17 Apr 2026 09:59:28 +0200
Message-ID: <740c347308a58ee710d85f8e0727b24f67cee9e6.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: minstrel_ht: bound debugfs stats output
 construction
From: Johannes Berg <johannes@sipsolutions.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 09:59:27 +0200
In-Reply-To: <20260417075642.32502-1-pengpeng@iscas.ac.cn>
References: <20260417075642.32502-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34920-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: A753941853D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 15:56 +0800, Pengpeng Hou wrote:
> minstrel_ht_stats_open() and minstrel_ht_stats_csv_open() build their
> entire debugfs outputs in a fixed 32 KiB heap buffer and append each row
> with raw sprintf() calls.
>=20
> The number of rows depends on the current-tree minstrel group/rate
> layout, and the final WARN_ON() only checks the accumulated length after
> the writes have already happened.

Which statically cannot happen, so no.

Please review your changes for actually being relevant *before* posting
them, otherwise I'm just going to start rejecting *all* your patches
without looking.

johannes

