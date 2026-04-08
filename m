Return-Path: <linux-wireless+bounces-34520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL5hNEIP1mmxAwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 10:18:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEA3B8E3A
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF6CA30054C8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C4939EF12;
	Wed,  8 Apr 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cmz4e1ys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9439DBFE;
	Wed,  8 Apr 2026 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636288; cv=none; b=Oa2auQSPc/li2di8jt8Bs9zmBzy4Xp/OaMZ6kQBPAXlWDZnDqrUobuOpKTBN4ZdRsIGlwDW3eBbu11rszyAwDnMMDTCxARHKPkZPGuUBTNCsBDdRVZLxfjI3Afkof7wEQMwexZ+lEqN9BwFSLmMpdGx1GunXGqxY3zw/P+btq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636288; c=relaxed/simple;
	bh=DK2b0kacowsLuuoSHVuu4eiVQul1MLLSibd37kth9bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6CbORK92oUloHo3AJIQqUdRrC2b8ZJyFlHz6SFZ0SdXlVCUPzGsXkwLZIAVjGcfWnlqVAus9o2Z+JdLuGBqezaPVDS+wqGRNOqgEXljfEMvygNBQRf40l3QQ0eAsw+GEPNSS3zt98Vz4UbT11+s5z6rt9Xe7kW94o8/C7v83DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cmz4e1ys; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=SHqqadEHJrEyHEOAj4yPw2THkIgptJaY7D6Refxd3lE=; t=1775636287; x=1776845887; 
	b=Cmz4e1ysg5Lps5VaZn/0+OZnjjhfrsloe7NBttQP1uf9qRnU3n/30EBbBhgUkCr+wgtuqSu54ZS
	y6BXXoQ2D8YQufS2okHo2AKOaOowNG5DDleGSwPeYDtnsOckjF/FvYTtvrfLFkERWVmFAaeZQXvVa
	F00RRsi3duJk/atPplYZxs9sNdPKNoAI/Mb45bQ/iJyGezuqoFUHyjv+uRzt0pqOTkIM15Sj5JcG1
	PL0Rx4D/Y7+mZOrl08+IGh5uU0Mlqbf4cr8Xa6QRIxtxzYT+RW6xUvSrEjsI+D2h0G0XrRrkpPjWX
	L6mKm3g9Jy7TD+Th+Beg98khijIlkWY6JeKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wAO6v-0000000EAyC-07f8;
	Wed, 08 Apr 2026 10:18:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-04-08
Date: Wed,  8 Apr 2026 10:15:25 +0200
Message-ID: <20260408081802.111623-3-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34520-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DBEA3B8E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

So in a way I'd hoped it wouldn't come to this, but while I
was out last week a couple of things came in that seemed
relevant enough to squeeze in now. I guess it wouldn't be
much of an issue if not, but I figured I'd try anyway :)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f8f5627a8aeab15183eef8930bf75ba88a51622f:

  Merge tag 'net-7.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-04-02 09:57:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-04-08

for you to fetch changes up to ea245d78dec594372e27d8c79616baf49e98a4a1:

  net: rfkill: prevent unlimited numbers of rfkill events from being created (2026-04-07 12:35:04 +0200)

----------------------------------------------------------------
A few last-minute fixes:
 - rfkill: prevent boundless event list
 - rt2x00: fix USB resource management
 - brcmfmac: validate firmware IDs
 - brcmsmac: fix DMA free size

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      net: rfkill: prevent unlimited numbers of rfkill events from being created

Johan Hovold (1):
      wifi: rt2x00usb: fix devres lifetime

Pengpeng Hou (1):
      wifi: brcmfmac: validate bsscfg indices in IF events

Thomas Fourier (1):
      wifi: brcmsmac: Fix dma_free_coherent() size

 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |  5 ++++
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |  2 +-
 net/rfkill/core.c                                  | 35 +++++++++++++++-------
 4 files changed, 31 insertions(+), 13 deletions(-)

