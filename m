Return-Path: <linux-wireless+bounces-22693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D1AACED8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 22:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF237B3133
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220717D2;
	Tue,  6 May 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o8b2u6h+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B557376;
	Tue,  6 May 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563713; cv=none; b=Hpcw/r36xXMooMaChptyoGUtCb3yIFfXDbSQrdsxhwAqLgPTBrzhZaQdbPtang9Qb90C5llM7tXLOu63yOC84m3Mi86S9f+o42mDkxzHNci55JYtD7uA448BNgoxupw6NElGHe7kdjysCoWKmHRc3V92sPMAePPwbcroxuSRxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563713; c=relaxed/simple;
	bh=xSh2thmLjVVk5UUvW7JPsibAXpxOu+YieUAxYQu3Tt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu5+6C3V0aovad0pyNtDG1zpHz+YEmvxjmMSwntGL8nst0hzU+dOS3KsQYe6zRbb5SaxANluAVdfRNDgwQJI7F15X6a+bygjsCI0NiK+c7vBFpywOKpNk8dvGLdG0IVpjZKdk0s6/lhhulOOECOC766r7YSQn/bnPAtjcYgcS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o8b2u6h+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8HZY0uPsXCl4a9MDq72cUwjhUqSkV5rr2KaWLadzDRQ=; t=1746563711; x=1747773311; 
	b=o8b2u6h+EvwnzJujiJK3ohHnbrQjgXZUJlIRAiE8wvYrre3/5lLQ0FXUmdFTS+PthUp8ZnCReHq
	B3Jle0/wAyI6H9Maab9ZuwdhfhUIGyASrr3sCF1DJSgi00bqBvvypa1tcs/VdXORO+hOzo2bZC4OJ
	PCK1k6xroEmw5JLXbB77JhK6BcpfC1XnVWnql4qbvaFVAWQQZiF0HCaUi5/6/9KEVwGwGA30R+ZQB
	BcidNz7R/i7qbVT3bwSrxZfq9e3yR1V+4BippRfIiGb0QKFFIsVv5YVIAlVpO3r/lnxDJm/qjn0YS
	6Dds1tf47ffucxkUNYDI8yxeHVAKCF/QsC6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCP0P-00000006LZ9-10KB;
	Tue, 06 May 2025 22:35:09 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-05-06
Date: Tue,  6 May 2025 22:33:39 +0200
Message-ID: <20250506203506.158818-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Couple more fixes, that's probably all for 6.15, I don't
really see anything more coming. Never say never though,
I guess.

The whole device ID management in iwlwifi is in a bit of
a rework right now for -next, so there will be conflicts.
I'm trying to get as much of that resolved in my tree,
but with this new commit we'll have to see where it'll
need to be resolved.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 30763f1adf69233fcfdc836370f69056a1be9d27:

  Merge tag 'wireless-2025-04-24' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-04-24 11:10:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-05-06

for you to fetch changes up to ebedf8b7f05b9c886d68d63025db8d1b12343157:

  wifi: iwlwifi: add support for Killer on MTL (2025-05-06 21:50:19 +0200)

----------------------------------------------------------------
Couple of fixes:
 * iwlwifi: add two missing device entries
 * cfg80211: fix a potential out-of-bounds access
 * mac80211: fix format of TID to link mapping action frames

----------------------------------------------------------------
Johannes Berg (1):
      wifi: iwlwifi: add support for Killer on MTL

Michael-CY Lee (1):
      wifi: mac80211: fix the type of status_code for negotiated TID to Link Mapping

Veerendranath Jakkam (1):
      wifi: cfg80211: fix out-of-bounds access during multi-link element defragmentation

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  2 ++
 include/linux/ieee80211.h                     |  2 +-
 net/mac80211/mlme.c                           | 12 ++++++------
 net/wireless/scan.c                           |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

