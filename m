Return-Path: <linux-wireless+bounces-34772-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJt0DpiI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34772-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE5404651
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B32A307172F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8661DC198;
	Wed, 15 Apr 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ObtWVJGD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2E218E91
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257120; cv=none; b=bVKChHzirzD5rOs0XeMHtenFpVFcY+hT2gbKK68Z+H40Z3cZDFbC+t4XnzMFWG7wnBANwKPzclW9nrCzKzU5MN96nfZ7PaAXjS7yPCVDQcxA8wjefwhtFYi+hvg8+Bf3nEo0TXtBaZkM6y02nfOUa+N36ORcpmLCsI9hzdymLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257120; c=relaxed/simple;
	bh=vlVavgi0ez+rFVI8W6Gp4tep2HA81WtwgA+yglLSwY0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T/cpNveVg+AvsO6AlzpRmvATKIXEPckw0ybwJ2oLZwsX3QFo0ChYOM96kO3s5sl+gnfSXDKLAQRBFSugvz/yEvE5FhtiNZsYwU6CIUa9lfnGYLAjZUCTa6HfOSWfdiHGbwD549GCqhpsegblIQG9AHjBrxoyvuGdEqF7wZHm6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ObtWVJGD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vlVavgi0ez+rFVI8W6Gp4tep2HA81WtwgA+yglLSwY0=; t=1776257119; x=1777466719; 
	b=ObtWVJGDNMaWBytPxiO314WwS9tz9I/QfZkagTeGUSdPfN6DVMiu8pdlX8s/WgGTVGf22Wgs4KD
	iPzr65yoSZrMa1ndW4kSPquiQfw1r7yJUAxmKzqFJnLkBxklL63DoP4QD+xRnChH2sRZS9QGG7/hJ
	D7pXtFPNGMINE4zi9+for97SNyVLgW2RM9ywTr+NbXiPQ3FBXlnKXTb3xtyuRXkcBZSP/7dGEQdIt
	mDci8Ht82/NF8IyMKGbOG4vVJLSstWe6UQmj/5xxGO0AMHJJW8Npop2WSQ/JRmcSot9lGulRLk+2A
	cxkkbPSyXpUVb2n9V0PB45vAy33OMnm7Oj8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcL-00000006OgW-2hst
	for linux-wireless@vger.kernel.org;
	Wed, 15 Apr 2026 14:45:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 00/20] wifi: mac80211: clean up and fix per-STA BW handling
Date: Wed, 15 Apr 2026 14:41:58 +0200
Message-ID: <20260415124514.284345-22-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34772-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 8AEE5404651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here's a better version of the previous RFC set [1], the rationale and
description of the issue I wrote there still holds.

Compared to that, I've mostly done minor cleanups (such as the kernel-doc
issue Pablo found), and some renaming in the last patch. The first patch
is new, since it wasn't needed in the tree before, and I guess I mixed it
up and merged that thing without this patch squashed in.

johannes

[1] https://lore.kernel.org/r/20260327093659.711584-21-johannes@sipsolutions.net/


