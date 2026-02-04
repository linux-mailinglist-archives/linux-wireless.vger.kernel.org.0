Return-Path: <linux-wireless+bounces-31530-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKS5KUo3g2kwjAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31530-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:10:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4BE599A
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9323014971
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1E3D3D1F;
	Wed,  4 Feb 2026 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aJjQhrvl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243F2BE639
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206749; cv=none; b=L09zEXYWIhW5XjdaKIfPFXvdfD1KjCZePBW4VKXHI+8dSdJcFMtZJOfXMbz1wV6vIOLUjIVcmh/M0XLTGqoivgT1jAg8YaQ9kArVPAvYOJTkJgHSn1tvM+CsjuyloWwSBkNKLFELUQiMkUgcuL/dWnisVM01rVhwSoN9yNIlyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206749; c=relaxed/simple;
	bh=8draj2+XKXYqJuJ0+OMFjNtUAyIyqg64fJ8mffjZ8v0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bC2xTHLbSfRnfwhpL0bOFyT44Tu4pW4wb72ODR6M8TsOxhJTuDFmWunZnV12l6bMPRCe/CyBKKgiFqVTf2c0Y+TDON6GhW2OTygVwrAKSMzUWig8THsINsGlQBK8rqxScP1xdMChOkPEO4JvLc4LnYCdu2Td0iZugZxiBV3XGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aJjQhrvl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8draj2+XKXYqJuJ0+OMFjNtUAyIyqg64fJ8mffjZ8v0=;
	t=1770206749; x=1771416349; b=aJjQhrvldHDNiDowrjx2TbKb6C2pz16py8Be+qzk0Ed8P9C
	QhtNv6yOzChbaLSdKcyx6WQAjDWi/Omcf+m2a5KFHBsKO3GO8pHWa1y2nSm7iF9uPfLubE0OKGr1b
	m99I/CzSGRorVGQhwG2DZSleE7pwZn8sscpsrT6aegsuuirc19u9nbfC5UtHkeqxeRxSy0VfAwsKs
	nZP9rixZFpDC/OVOM41GVHN3w+ewYhlDzGG+CnFSpCo32/NPcR7QCpZ3wNnBvdBTLaASwp4cAc7zP
	4BpJq7eFfwz2WWfO07vg6wTILl7Tad7F7sHvQd3hKmU8jRI8lHmUYgMDkWeIQaEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnbdj-0000000ELTj-19Ks;
	Wed, 04 Feb 2026 13:05:47 +0100
Message-ID: <6c4341040006e667e0bda79aa8a46111c6ca9ae3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/4] DFS/CAC changes
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 04 Feb 2026 13:05:46 +0100
In-Reply-To: <20260203185717.103810-1-janusz.dziedzic@gmail.com> (sfid-20260203_195733_222042_8F0E51FD)
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
	 (sfid-20260203_195733_222042_8F0E51FD)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31530-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09E4BE599A
X-Rspamd-Action: no action

Hmm.

This patchset causes dfs_cac_restart_on_enable and
dfs_us_chan_switch_precac tests from upstream hostap to fail for me, so
I'm dropping it for now.

johannes

