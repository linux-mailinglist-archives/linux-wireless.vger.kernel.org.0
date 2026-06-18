Return-Path: <linux-wireless+bounces-37887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w5uRDPqoM2ouEwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:14:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4D669E5EE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:14:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37887-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37887-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BC0F30135C7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74C282F26;
	Thu, 18 Jun 2026 08:14:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068840D575;
	Thu, 18 Jun 2026 08:14:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770483; cv=none; b=febSYQe83ua9DJPGK9dKs0GFwgu3MQVyPQDwgzA/9NgG+QgUGM2uuFqJdFskwrJIA/8C/u286ItUo2bsTH8ZmIqBVjzt3Kt1MpR0C+lFCGytOq3V9bIPoOTDwXsbL0NN0DyPChNmLVnysKDk5vF6CCT8aAu+3ym+YaLd4wX9qMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770483; c=relaxed/simple;
	bh=NmWXmrXvzYwJAoUXOAT+nNl/N1rkT05SLxF2KGI8uI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKFTkAjyXOKdItZEpm1DfHAbT/rb2+WawMDljhj7shJLw7fD/qxuXIKTGVbKkxLhqGa+sX2sOtRbZ9L4znWmOHuEq3h8fiq/GGbfT2UunMCKQAYDJwiIhz8i4CLAeLLLcOKYbenfNF72PbXR0yspJLwtPxrcI2je2p4mDmaTivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 08AED23383;
	Thu, 18 Jun 2026 11:14:33 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	nbd@nbd.name,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.12.y v3 0/3] mt7921e: backport three mt76 fixes to 6.12.y
Date: Thu, 18 Jun 2026 11:14:10 +0300
Message-ID: <20260618081413.17812-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260617130826.1667503-1-rauty@altlinux.org>
References: <20260617130826.1667503-1-rauty@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37887-lists,linux-wireless=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[altlinux.org:server fail,vger.kernel.org:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[altlinux.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rauty@altlinux.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rauty@altlinux.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C4D669E5EE

This series backports three mt76/mt7921 fixes to 6.12.y. All three are in
mainline; none carried Cc: stable, so they were not auto-selected for
6.12.y.

Per your earlier reply, resending as a three-patch series:
https://lore.kernel.org/all/20260610-stable-reply-0014@kernel.org/

d5059e52 is already in the v6.18.y and v7.0.y stable trees:
https://github.com/gregkh/linux/commit/91e77840bf13de3add125060cf8b32ca24a52c8c
https://github.com/gregkh/linux/commit/35180c772f5e11e2fa4d80d3dfd50906cb6d9646

The three must go together. 5ed54896 adds mt7921_roc_abort_sync() on the
sta-remove path, which runs under dev->mt76.mutex (taken by
mt76_sta_remove()); d5059e52 then turns cancel_work_sync() inside
roc_abort_sync() into cancel_work() to avoid a self-deadlock with
roc_work(). Applying 5ed54896 alone queues a reachable deadlock.

6.12.y note: d5059e52 keeps del_timer_sync() -- the timer_delete_sync()
rename is not in 6.12.y. The other two cherry-pick cleanly.

Tested on MT7921e: Acer Aspire 5 A517-52, ASUS VivoBook S14,
Lenovo IdeaPad Slim 5 14AHP9.

Link to v2:
https://lore.kernel.org/all/20260617130826.1667503-1-rauty@altlinux.org/

v3:
  * subject prefix now carries target branch (6.12.y)
  * cover letter added with stable backport status of d5059e52
  * no code changes

