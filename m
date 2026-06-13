Return-Path: <linux-wireless+bounces-37764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4nH+IK7cLWqulgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:41:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9649267FF08
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37764-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37764-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0F5300D16A
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3624342509;
	Sat, 13 Jun 2026 22:41:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF756223DCE
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:41:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390506; cv=none; b=uXb/lU3mogZCE15mBu6zTTNxHBAGH1ayzmJZxC17+inOWpdtg1qVJDQcGujuOruD+EDjEK/+DH2hBtqsaJ/XrGobNn7jcRymSAia99weAd8nfoBMuRpks2KQtVLGHq4+CComfN/8imxKJVMLdp8MnJhaa1ICK5/L8ZZ/Vz7Lw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390506; c=relaxed/simple;
	bh=CV/nENwe3r6Wqt7osQEqCocgUQWamToICrWfBSiGRnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QendRvbGJ17FAFMjeDX1xqLsebvoN5+YLnR9cNtXx+4qC4UvNqNB71tJKYsV4U/DVmPNl6APh3bnt1ZbZ9irZDhQ6OKkb2goXGc4lC7t/RX/u8ZmZ5+Z6yzE4yy9iiWT2HD1tbTS1GljfWzz+sh+wvqUlsKu9UMlThPF1xpjkeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.50
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1370417c01cso2714777c88.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390505; x=1781995305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFgM6pr1Jw6qKLoJhWrWpbUwhYhQ+a8Qd9W54UiixL4=;
        b=K1KNrAlRebcfRdSNoZvfomEyWRdN2efZEyPQjG+QjyVnKOF65d+5W/0B/0UmGe+JN8
         BuIY6bNhJRRIdFmeIjHFrEpE9gIKklSjVOCHyxZ3YrW9+qCx089VQZ1YLgdqbJ7yO7yq
         /pjq/oP1YqkPg9yK89pd8i8svzlbdaQheWbd4Q+kNRo4E4nyco4QdjYQxTmJ7egwiDNd
         6zN01Om4acxOhwJ+BQwTnRJWp+/hvGEV46wxp6D0zOoYs7WKkP8pv3r8K9tD3qDx2RnC
         wRhkCUf4E3cnIaoxkGedUjcQmYGWGOBXLlL17++7IucQTeH/8aS8FoDgX1M7NqrI0XYc
         wLew==
X-Gm-Message-State: AOJu0Yyhsy04Dg19CHe5CwDVBeSQdtSlBXkYHaPRVgjQyjYjOxqGvO5U
	DTHR8A6gF+gNMT2rOPOH/IXGj1oYUGWaNw2J44qapA0l8dF9rKZ4Hd4x
X-Gm-Gg: Acq92OGQlxCfbgjDokyNA8ZrUcU3JC3KQLku7b9whd9UHyJjbBGE0gK+Uqbi+vclm4b
	zmqruQ+Kf3QGfmyof+rN6aOFQs8WFEvxW4235kXnjpHszgOQX7fOo28CEsuch1I+1on+k3aN+dL
	60jKA/oRsg8+v9ClkKfH2+VYKPQ1yCWmtpUkj/QR/Yk0jF5UYlnYpmskYhbVWeaMwBTzczLinVX
	TjoJa08PFJpizKPHOYqSpGD4uoZYb7Umh30l9Yv7EyODKBW76Y87SURHXddEr1+hdAxuW6m+aek
	88AELYUqgcaxPSmoUtQkC/vsHXGOxL4tkJihCuvH/3DUTu4bNjjPmxgOFz+S2MifwWhCOFscd8c
	P2MJV2EN/rGXJBxVRlkOZ2siaZ0bBNIfRQ+evw4qvEuwfpIRTzHho0aVF1kAhuGdBUDQ9oSpjOP
	2EOlxRyHSRI/E13Fjjdkfj3y3jDWf5YPJ7xDI53z/3exe5pKHQp6ERTmvPcPv4R1kNwElhvo3L7
	hIZG0YcrYv+KTLX/XqoXtWuZezV39gGUtXV+FoA
X-Received: by 2002:a05:7300:d513:b0:304:54d6:20f3 with SMTP id 5a478bee46e88-3081ff3da47mr4390011eec.4.1781390504780;
        Sat, 13 Jun 2026 15:41:44 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm11104825eec.28.2026.06.13.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:41:44 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH 0/6] wifi: mt76: mt792x: harden USB reset and disconnect paths
Date: Sat, 13 Jun 2026 17:41:25 -0500
Message-ID: <20260613224131.2396026-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37764-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9649267FF08

This series hardens mt792x USB reset and disconnect handling.

When the USB control path starts timing out, later register accesses can
keep entering the same dead transport. Each timed-out vendor request may
block for seconds, so reset or disconnect can be delayed by repeated
accesses that can no longer make progress.

Avoid this by failing fast once the USB bus is known to be hung, stopping
reset/init retry paths that cannot recover the device, draining UDMA before
WFSYS reset, and quiescing USB activity before unregistering the device.

This series does the following:
- stop mt7925 init retries once the USB bus is hung
- skip mt7925 reset work once the USB bus is hung
- switch later USB register accesses to no-op bus ops after bus hang
- drain USB UDMA before WFSYS reset
- enable the USB UDMA TX timeout limit
- stop pending USB work and TX paths before unregistering the device

The series is based on wireless-next commit:

21352612198c ("b43: add RF power offset for N-PHY r8 + radio 2057 r8")

It also cherry-picks the following patch from patchwork as a dependency:

wifi: mt76: mt76u: use a threaded NAPI for the RX path
Link: https://lore.kernel.org/all/20260609105301.196302-1-phial@phiality.com/

Sean Wang (6):
  wifi: mt76: mt7925: stop init retries on hung bus
  wifi: mt76: mt7925: skip reset work on hung bus
  wifi: mt76: mt792x: stop USB register access after bus hang
  wifi: mt76: mt792x: drain USB UDMA before WFSYS reset
  wifi: mt76: mt792x: enable USB UDMA TX timeout
  wifi: mt76: mt792x: quiesce USB paths on disconnect

 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7925/init.c  |   8 ++
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |   6 +
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |   7 +
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 124 ++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/usb.c      |  11 ++
 6 files changed, 145 insertions(+), 12 deletions(-)

-- 
2.43.0


