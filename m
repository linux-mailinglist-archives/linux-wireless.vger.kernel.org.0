Return-Path: <linux-wireless+bounces-33730-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGcaLBl6wWkQTQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33730-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:36:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EAC2FA10F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DE573028425
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC33BED05;
	Mon, 23 Mar 2026 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV6frrDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97724277C88;
	Mon, 23 Mar 2026 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286418; cv=none; b=L8SY/9NO0FiMkxGAdX1AtjDnIR9lc9FG6yBRl5+GdI2wAXT8HgFRIdFxVZrSuigAtRydx4WZ6sCcGjNvxcCW+o3rCz5jA1JgeDrXwPuZyewmFBIL+J3JtvQlwS/i5mfpXGSIfU/rAndlIFOmviElcaUUt/B+I+zSp/H+X5lXTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286418; c=relaxed/simple;
	bh=koTi9b0X3dRcnxtZiIHUEUiGA0Peg0+3cPdMN4nVIzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tVLUjp46Az9JcZfS9CWrEmjKIVVji0oT9DAWqduKf7MFFV/8WMr6n7yK1n/WE6s50c0jZtuZOLQrhPwwDjWd/RDSBsQ29bk902M03ZbeKeXSUBvsrc21rTVCO7Yn3YrB/iNifPJernHnZIZfdPrfeT9TeWWJQT4JW51kz0Gyk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV6frrDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FF4C4CEF7;
	Mon, 23 Mar 2026 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286418;
	bh=koTi9b0X3dRcnxtZiIHUEUiGA0Peg0+3cPdMN4nVIzk=;
	h=From:To:Cc:Subject:Date:From;
	b=JV6frrDQDJNe/9wT1/5eKqZ795MxuDF7/G7eXdjn9uGiDZHeaKA7vBs7JQrgZiyGx
	 OWkZSMtKlgRmXglck+vGfFd8lwyOMCfO4ebxiL0kmb7Vcgf5sD1CvL18D7VrMGEv6t
	 ji+JmialK2Xllgoi0xlkAWt0dSPtyP2kMC8RFr8QaF9KDt6tgqVNBuFXLDyoOVKr+6
	 dt1vjr/dkVSnFSmCLnDJMdS0/tS+UJvZ0mXeXZ5QnT3cQDNG7n1umeg59DZvIUoEmH
	 KkpuWF52VjpCD5VqTIjzndm2YJpmWoTEMZRweD15ahA3cU0ArpbYWvBzWOdCIj7GSU
	 VowbDpzDmh9rA==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Replace strncpy() with strscpy_pad() in drv_switch_vif_chanctx tracepoint
Date: Mon, 23 Mar 2026 10:20:16 -0700
Message-Id: <20260323172015.work.146-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=kees@kernel.org; h=from:subject:message-id; bh=koTi9b0X3dRcnxtZiIHUEUiGA0Peg0+3cPdMN4nVIzk=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkHywIqy5eWRDIclr7C1fvxY9q3f8yZp7/c9wz6c/Toi f2vXduOdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkpD4jw04drr1+YZtm/HiQ 9L0x/9OKUo1mAbM5nQ18zobhGQYr8xgZPk7/uc3g3OJbSWo5ufu2X7iwMP6h7QznLtG1mqa3mOR z+AE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33730-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84EAC2FA10F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the deprecated[1] strncpy() with strscpy_pad() for copying the
interface name into a tracepoint entry.

The source "sdata->name" is a NUL-terminated char[IFNAMSIZ] buffer
populated via NUL-guaranteeing paths: strscpy() in ieee80211_if_add(),
snprintf() in ieee80211_add_virtual_monitor(), or memcpy() from
ndev->name in ieee80211_if_add() and netdev_notify()
(net/mac80211/iface.c). In the memcpy() cases, the source ndev->name
is itself always NUL-terminated (populated via snprintf() or strscpy()
in __dev_alloc_name() and dev_prep_valid_name() in net/core/dev.c).

The destination "local_vifs[i].vif.vif_name" is a char[IFNAMSIZ] field
in struct trace_vif_entry, stored in a __dynamic_array within the trace
ring buffer. Since ring buffer entries are not zeroed on allocation,
strscpy_pad() is used to zero-fill trailing bytes and prevent exposing
stale ring buffer contents to userspace readers of tracefs.

No behavioral change: since interface names are always at most 15
characters plus a NUL terminator, strscpy_pad() with size IFNAMSIZ (16)
produces identical output to the original strncpy().

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/mac80211/trace.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index c04d4547e8f4..3b139fb67d1b 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1796,9 +1796,8 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 				SWITCH_ENTRY_ASSIGN(vif.vif_type, vif->type);
 				SWITCH_ENTRY_ASSIGN(vif.p2p, vif->p2p);
 				SWITCH_ENTRY_ASSIGN(link_id, link_conf->link_id);
-				strncpy(local_vifs[i].vif.vif_name,
-					sdata->name,
-					sizeof(local_vifs[i].vif.vif_name));
+				strscpy_pad(local_vifs[i].vif.vif_name,
+					    sdata->name);
 				SWITCH_ENTRY_ASSIGN(old_chandef.control_freq,
 						old_ctx->def.chan->center_freq);
 				SWITCH_ENTRY_ASSIGN(old_chandef.freq_offset,
-- 
2.34.1


