Return-Path: <linux-wireless+bounces-34460-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPINAA7j1Gn0yQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34460-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:57:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECD3AD5D1
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C27E3037982
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C409387367;
	Tue,  7 Apr 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Qq+wO85/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245533A75B5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559125; cv=none; b=t01+kgrm2/pdIFjBYtoUTP52ZcJm9hsm2lAGEGf2qwmgqkI0Z1xY0e1ucgdmZB620A7hWy1A3gRicWIJDManLDwpk4SJSYDdvsUtdpbuvFFNc6ANoRsArSj5bz/LchiM+YpJGKpvLAAtwzMEOLaVSuz+TFiYZQg6dZU/Eb4jImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559125; c=relaxed/simple;
	bh=DEutK+HG/Fz7ZD3uQb1tBH3pvxlhBheyGhwpx7G3jpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pb+eCQSJLjERuKHjdOZiR7Ce0THPB2JDUbektB18E5shLNSuR2F41tlIAOlGWm9hJeGDNMB9Z1TH6dOyeXavdyPX7zDkTcERzwlrl70SKbdRkJ0DFopAGpzn/3okz5/CCfQ4WKCWADDjfFRD7BEIkj8f5YZrQH1prwOtYTd2guA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Qq+wO85/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DEutK+HG/Fz7ZD3uQb1tBH3pvxlhBheyGhwpx7G3jpE=;
	t=1775559124; x=1776768724; b=Qq+wO85/zS/0rtXzyRD+s8QX6oxUd0NCBqxFoiERcAKZ0Lf
	topIAx98rJx+wXScQUg49pjeOdGWwCxCCOxX7AEeCpWD4SBk6DNtdklB3s5jDiIQ19gpf8oGW8A1A
	jz1ynA7p0jf1uOLSTkY32H68GEHpGj5J0MvLwTwzjngZcYxg87ZG8842Qucf/dQxHOtvZFibdCClU
	YXVeitEauTvb7nZgGz1WZ5hozYRsZcfJmFcZLNSYB/BLAl9ehkICVjlgpwp6Zt5f0pHHHxlddM5U5
	eE4CcQY332aMRbZnSC185tQP9RlpHvkAwvnHIYAKYmPV6Dm344GZPwRDDeS/pzVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA42K-0000000CGfo-40wH;
	Tue, 07 Apr 2026 12:52:01 +0200
Message-ID: <9d093d8a8df188c99b9b652bb56a5c1faecef6c7.camel@sipsolutions.net>
Subject: Re: [PATCH] carl9170: main: track sw_scan state and suppress
 transient channel-change errors
From: Johannes Berg <johannes@sipsolutions.net>
To: Masi Osmani <mas-i@hotmail.de>, Christian Lamparter
	 <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Date: Tue, 07 Apr 2026 12:52:00 +0200
In-Reply-To: <GVYP280MB15183AA20A65C0C5C03D09699453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
References: 
	<GVYP280MB15183AA20A65C0C5C03D09699453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34460-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EECD3AD5D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

FWIW, all wifi patches should have "wifi: " prefix.

(but I think you're not going to get my email, hotmail doesn't like me)

johannes

