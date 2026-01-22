Return-Path: <linux-wireless+bounces-31081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L+TE+42cmmadwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 15:40:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAB68083
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC2FD988AC7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1E2E7F2C;
	Thu, 22 Jan 2026 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qtk8j762"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92B2DCBF4
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089912; cv=none; b=EDGBPl1DSPOfj4H2dZw6kaNfc/PkbCIkXVS+y0EMNyzk5DsVWBR/lpx2+JSPl1jm5V1RX21EQYs6xofdnH2dXGK0FBj5fgG4AdGFPId5Bc95E7EtoCswzBqRaiYBVxfuCQL0Drzf2FZtsm+Ji/omSsAq0dTxZcYFa+hpiJVY0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089912; c=relaxed/simple;
	bh=2ovK75HHk76zhj92vAMM51CdwfMHMuCPL77ODcQJ3IE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QHcknVOyEyLSYrvPi9WDlO/s9fta3563OEfhPBAqxW65MKmaZSzs7NIUeofW2JTOEDu/wpfIhRJ7w+jOCRdntkh5vpsp0HBmNdqFqhPUb1kq0uABCYodMw3wFe0h4zOsY8qnhF+6YloKBGVeI5njTYsIk8OpU2TsQ7dGdP+uR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qtk8j762; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0489C116C6;
	Thu, 22 Jan 2026 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089912;
	bh=2ovK75HHk76zhj92vAMM51CdwfMHMuCPL77ODcQJ3IE=;
	h=From:Subject:Date:To:Cc:From;
	b=Qtk8j762n2/gQZqJnlKHjUAULJIxNce6x5Ri5lpG2j5fSf+MvtLt2Sh20km0/t7RP
	 fuHfs36LHrv5pgqqJBmXzjVf1hjNlVKhwRfFdA3GbLcjjl8l26YuLdgdIJyuHhb8qw
	 vNFW1CHgPwIs/ji9qUd2BcPlygX67nBPZGzZShHEIr0k/8MuilWYOnxQHjU3qxdD00
	 WPEAm9dUvqUMsPP+r3JMAUnebY3pRysds4AU83oY7P4XSwqlsR/xzYz7nJoUxdvUg9
	 iQ5O9Y6wZOd2ZwrE9kzN132EtAW5U5dl0U818xP6tHOQf4ljyAFoWpdsJRjnofLAOX
	 IgtaDJxchoNPg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH wireless-next 0/2] wifi: mac80211: Introduce eMLSR/eMLMR
 parsing support in AP mode.
Date: Thu, 22 Jan 2026 14:51:32 +0100
Message-Id: <20260122-mac80211-emlsr-v1-0-f0e43bb6d95a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0auUrC00wU/xKuJCaqoBrdKACOLdL
 S7fYuYB5Sys0JsHMl+icqQCrAyEdUoLW5mLgRy1DgntPgXvCNHyvmm2TdfVzlOMPgQo0Zk5yv0
 Ph/F9P12f0ElgAAAA
X-Change-ID: 20260121-mac80211-emlsr-5774082ff8cc
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
 Shayne Chen <shayne.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-31081-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B3FAB68083
X-Rspamd-Action: no action

Introduce support in AP mode for parsing of the Operating Mode Notification
frame sent by the client to enable/disable MLO eMLSR or eMLMR if supported
by both the AP and the client.
Add drv_set_eml_op_mode mac80211 callback in order to configure underlay
driver with eMLSR info (control and bitmap).

---
Lorenzo Bianconi (2):
      wifi: mac80211: Add EMLSR/EMLMR action frame parsing support
      wifi: mac80211: Add drv_set_eml_op_mode driver callback

 include/linux/ieee80211-eht.h |  5 +++
 include/linux/ieee80211.h     |  6 +++
 include/net/mac80211.h        |  7 ++++
 net/mac80211/driver-ops.h     | 21 ++++++++++
 net/mac80211/eht.c            | 98 +++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h    |  2 +
 net/mac80211/iface.c          | 10 ++++-
 net/mac80211/rx.c             |  8 ++++
 net/mac80211/trace.h          | 31 ++++++++++++++
 9 files changed, 187 insertions(+), 1 deletion(-)
---
base-commit: 1e1dd9eeaab3908746d1dce5db6b0c29e0d28d6d
change-id: 20260121-mac80211-emlsr-5774082ff8cc

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


