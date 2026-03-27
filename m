Return-Path: <linux-wireless+bounces-34033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH8QJOxPxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:37:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03437341D18
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93BDF302D5B5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A43CEB80;
	Fri, 27 Mar 2026 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="I4tR9obG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA723CE481
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604230; cv=none; b=uMWUyVhHttyPVI7nn0betcRuxWCOup/PnRcY4kn+5B2R/mmntUbeAoCgvOr7rsqHbnAGrxNhpOio28IQ2OZLt4hoaeZLA9wDXy8ligl2uq9VaG9JaeD21hYYDY9vPDyPEFhc3oYwluDw8yxToIrb2L0ObyyYumKLXikJ5V3xi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604230; c=relaxed/simple;
	bh=E1PcM15RxmOaBqT7WRE1D4jNZIY7hX8Xm9GbshazzOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hTvzmLi38AmX0Oxv0OaQA9PJ8peb9EOPH5McQ+OXz1H0eOwwmxitW9uA8C4sigQbB3iAgOF4kJ2Zo0m4NwpC/sFHpXaxTTL74+X1KLjn9GRwur2zKcF+7NDzGpztN0nYrTVkegAUlFmoZFfiEaTDmGqtjXnLzAM0ZGsU3e7tF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I4tR9obG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=E1PcM15RxmOaBqT7WRE1D4jNZIY7hX8Xm9GbshazzOw=; t=1774604229; x=1775813829; 
	b=I4tR9obG2C5vZi021r9N8JqwfO/bWPevBM21sf98qzyapZowbsri7YCOylSigk9PztDXyr5c+hz
	GY+aHG3tVuCtAZpfZhBYz26KFChZX7c1hjxAFCVz97VUXzTYZXyaoTAivHYb894SoaF+ExZuACWSp
	G+QiGECjRkJo9BakdYLC4bUT3qm+Tu5kGcbcoJnlNyQwjYLfXm3z1cHPW3qphpUcUioq8kJ2RTaz2
	zWPUvRuhavZbFIjxe+hvqKZViCrTed75+6Un2dL8hevDq1GVvK26Ee+HPVzoJCA+9P6Q7qMzU+U4f
	nCbZ1ZLyjo7GqZIZ9J+KUVzyGsICvkp6qspA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63ck-0000000E83L-0kVY
	for linux-wireless@vger.kernel.org;
	Fri, 27 Mar 2026 10:37:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [RFC PATCH 00/19] wifi: mac80211: per-STA bandwidth cleanups/fixes
Date: Fri, 27 Mar 2026 10:31:26 +0100
Message-ID: <20260327093659.711584-21-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34033-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 03437341D18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

First, I should say this is more of a rough draft. As I noted in my
pull request, I'll be mostly offline next week through April 6th,
and this was something I had discussed with folks about a week and
a half ago, and wanted to get out for everyone to look. But it's a
rough draft because I cherry-picked it from our tree which has some
additional work and had a bunch of conflicts, and I don't know if
now (in a hurry) I resolved it all correctly, and if it'll come in
before all that other work (e.g. the NAN work Miri already posted
has conflicts with this, and NAN work will probably go first.)

In discussions about a week and a half ago, we noticed that station
bandwidth handling is broken if we have an AP with EHT with e.g.
160 MHz with puncturing, making HE e.g. 80 MHz, but now a station
connects that has 160 MHz HE capability - we'll set it to have a
bandwidth of 160 MHz, which is clearly wrong.

This is what I'm currently trying to do to fix this, but I did a
lot of cleanups to get there, and also had to have the AP be more
strict so we can actually have the right information about the HT,
VHT and HE operation.

johannes


