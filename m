Return-Path: <linux-wireless+bounces-33209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBjVNgEPtGlvfwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:20:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF68283A12
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C073201010
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CA038AC85;
	Fri, 13 Mar 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="Iyt7a6ac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333402D63F8;
	Fri, 13 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407955; cv=none; b=KbIRhXcYYibmN04/tQp4WNWl6IdF6Czf2VCwEUzssyqlMd9WHszqUZMAKqNahz6WsybWfvEZxgy5nLGPMbFEq45EdN7jZtsOYQZkQfC8zb6Msuux29hCTvCVKhZ1Kpz8alruSMdlx257nINVpR9EcZkFQSNgf1cuT8vs2g//WDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407955; c=relaxed/simple;
	bh=miOwccwDihMm9tqYMZqvG9CIotwBcwcIzFqggB9iL4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2MXyizuagzpcWe3fLEMTuyZwYyLgE0gv6JbWIf7w6eXpbCy3p1LiHvwB4uJXRZjIzvmNt7Piae8iUltUIViwfRlWbwJ9guvQIlDkxR+rObcpNwBlt6z3ICey9lY7uiRDTCFSAPMjhEIdPueBeGkpyPf2pNnAr/8nUQkE5j+phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=Iyt7a6ac; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773407951; x=1774012751; i=georgmueller@gmx.net;
	bh=tM1X0bl9KZrY2MvKQxIerUvi9OH/1ZYmEGX3GzeprEY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Iyt7a6acAzY8Ph1sE5PzNp6pEiMB0ERHvoQDMD6SM3EOuCUXb49TBXriwRfqnOXg
	 hbmZHiBr9IKcWAQpN9YX/flrWCWebGsBg/QELW+1OhQzTvgzPJKc0q3fPPKEvqGgq
	 nAeZtlPAcMa9+eIjMpv/tdLQBp4fMRYK5xurqecLRgIIZ665ClTqvnRtlJj2ALtvb
	 AsoaKsTNUN+WZUaxgkYEd/CXn1Sh6/IBlJ2dW+vzSO4MlkYZaWCAPnO2W673oLWWp
	 DDnkM9lMN97YC68ofwKsDdO3N2jJQdpZShYZeG6UW2NICtOvahviZZvV4DjbOCK0e
	 BFUmX4Yimvnr54znwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1vb9iQ1VE9-0118fR; Fri, 13
 Mar 2026 14:19:11 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v2 0/4] wifi: rtl8xxxu: implement AP mode for 8188EU
Date: Fri, 13 Mar 2026 14:18:45 +0100
Message-ID: <20260313131849.3148013-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LiGbsVRWHDkmpKazh2DkcfawIU9iCGJ5+eGdjemGT0T3zTfsXp
 E/+Ac2XlpAQVohBieoP/ta45epDsytcu6Ew5u5Tw8e4WBO4jf+cR7uuco0y0qtDS83yjMN6
 Q2/rpQg1kJLwParKf9sx7KRob3OFjBYdQQ2oTfVaCaft1FMCPdfIP6pCschNMhatzlRwjAZ
 /76xGLpJCQQRtQRGdXwKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LHp2ErvjqdU=;WvNzpv0kRjL72A4CmAR2UKWlzt5
 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
 QOoOk5gR8rrowI0shJ2LS5RToV/Ip
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33209-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BF68283A12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series tries to implement AP mode for Realtek RTL8188EU chips.

This is not final. I still have issues connecting to the AP, searching for=
 some
input on what may be the reason or how to further debug issues.

Patch 1 could be picked independently as it shouldn't change anything for =
the
non-AP mode.

=2D--
Changes in v2:
- add patch to move dynamic_tx_rpt_timing_counter from ra_info to priv
- convert ra_info to a dynamic array
- update max report mac id after station add/remove

=2D--
Georg M=C3=BCller (4):
  wifi: rtl8xxxu: move dynamic_tx_rpt_timing_counter from ra_info to
    priv
  wifi: rtl8xxxu: handle rate control for 8188e a per mac_id
  wifi: rtl8xxxu: update max report mac id on station add / remove for
    8188e chips
  wifi: rtl8xxxu: Enable AP mode for RTL8188EU

 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 22 +++++-----
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 41 ++++++++++++++++---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++-
 3 files changed, 50 insertions(+), 18 deletions(-)

=2D-=20
2.53.0


