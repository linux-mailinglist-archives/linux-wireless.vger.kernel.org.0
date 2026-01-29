Return-Path: <linux-wireless+bounces-31316-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMwxHvU/e2mNCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31316-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:09:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184FAF6E7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E66FD3012943
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096903859C0;
	Thu, 29 Jan 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kd5WOcNu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1F286416;
	Thu, 29 Jan 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684649; cv=none; b=SDcyELGzol2by1PhuJydCDE3CwLLkk1Gb3IA0Vy2tnZMb+nRvcPhiCuAz2WbugsSJcCzlaACPeKI/BKyHnjV/QuJZyzRSniM0EZ4vUnPk2RqlPhQu4OGW0sHVNeZ64e+4pc3U3Pxw/6SVzuGFELL9oXCFIDPGIBWFXjNqulZemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684649; c=relaxed/simple;
	bh=fT819fHmUQNtC1/AN3XQjzL4y4SFFDwALti5WAba30Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpAPifsP7902inWcn7l7mMcMGnHF4fFcmS7QKwj5eKY5xenjBrzlkzWe1Z0H9skTO46GefGsWBP0W+hV655bbmC5BJJCc4f+tv4sfoW8FcKlrIQhdHKn/FkhRLX3MHjJBu18X30urO34nRQH5esXKQS99FvIYZpFAqXb5p5cpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kd5WOcNu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QBj7p2HXiY/2SPBuNaDysPFNJbu0/i+9e278kNDvjpY=; t=1769684648; x=1770894248; 
	b=Kd5WOcNuXFa4qy9JFGDjWoMfRGEGh3wCFEzHQRdtZD6iqXOVwCK8aLofAAlFgMP6VDtie0jxUiS
	WB5/7z3MpN5Zr7VC3QaHVDeTr6U0BN6GUj+uPJiJAPXVBPGFXCT8cYT9ITclPMpxWSnms+/IBgLah
	wb37sqPKI79apcNbjqD0ER+xP0RENA5TcI6oq8Z4+vLJwytRXXJ2Cp9N09ZDx60pa+EkYG5Cup7jh
	QeEe7zPfT1ss9HFXPozSokHNUzgq00NdYr4cvEgK+xnKpqQtoSaYu41QbKp5ajtiuICwPrqBiKJMk
	X86S7nHoTmYe5n9hqBACPRpzrY4vAJRZ7oQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlPok-00000006ns5-1bsn;
	Thu, 29 Jan 2026 12:04:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-01-29
Date: Thu, 29 Jan 2026 12:03:45 +0100
Message-ID: <20260129110403.178036-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31316-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9184FAF6E7
X-Rspamd-Action: no action

Hi,

Here's just a single potential out-of-bounds read fix,
and I really hope that's the last for this cycle.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0a80e38d0fe1fe7b59c1e93ad908c4148a15926a:

  Merge tag 'net-6.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-01-22 09:32:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-01-29

for you to fetch changes up to 1eab33aa63c993685dd341e03bd5b267dd7403fa:

  wifi: mac80211: correctly decode TTLM with default link map (2026-01-29 11:46:43 +0100)

----------------------------------------------------------------
Just one fix, for a parsing error in mac80211 that might
result in a one byte out-of-bounds read.

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: mac80211: correctly decode TTLM with default link map

 net/mac80211/mlme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

