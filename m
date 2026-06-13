Return-Path: <linux-wireless+bounces-37771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9HXH+/dLWoalwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD067FF3C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37771-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37771-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FF4E3002500
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D125342509;
	Sat, 13 Jun 2026 22:47:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0F2032D
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:47:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390826; cv=none; b=MAsBt63ka0o8+x0hDl3lPk02FNY3OzOuGbyxn+iK89eOFvs+NlC6pb7k6a31bws2gSrMjmgyM0J6ItHH+q2+6w4k9dnmCwOclKTLjY1GgHkb/FTBKAnqKznU1qcZ8b3+OI0bpj9lWQ33SHRewp8/ZuzAfwKMVvZt9BXOoE2932o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390826; c=relaxed/simple;
	bh=Rjomor+VLJ98kL7w2bSIKCOlzEpAc6ojryiD+rxsgJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY/QqCfCBNM+yw8ALod5pxdcac+/kPzd+QK2lzca6NoTEuwzdyA+YFaB0si8GJs+9uq70PNG7V4z3581dYpaC7qTZ4OsoSSpotBH1ulqsrG8L11yh2e3gG9GjKk+QrMnSLwa5En7s6VQyrHNFAbpRm6H+8PTsQBn63UFbNL59zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13721dfd471so2383474c88.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390824; x=1781995624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DREgCFSiVRPA/ISCguieFaPwHHRhAppM9UFQUW3iU0=;
        b=eNSEw5e/3rUtaBGu11cZnkHFrzL3bTH0VmwsP03/w+AxMrZhHC01xxqTPYQFrI56XN
         a7zZ+kExKoxqLhyLyJ7x1y1W7AetBSwTa1u8UwS5GLsy0BvmQbHq8kvmO8MHAQ8z78UR
         Y56Blz5Vto/jiwqI/LgX62YvYKXWir//y8QYFNumWPdaLtsb7Q+MJ519dXd9zg64SEOg
         8W/0poO79KPguRARWVqzWLajekdeneKRa3UMHzaxks0TLPq3R4QyINEhSeH/l4OBNj64
         ii8C6RqYrzDm+asoNbQd0GGuiZmUpwn85TxdcdAqqPFOG5zT1foAri66Umiqb3k/S1ea
         td3Q==
X-Gm-Message-State: AOJu0Yx/lP97ucsdMQ+XH7NovP56r9ko7jimOI8ctkO4ngAp8Zs2c9MJ
	jy3ZzYh/pI/+L0cc411IyN3QY+tbYTytUMygf9PwssHIOQyhhP2M7JTP
X-Gm-Gg: Acq92OFrTW2kTaGfHlM6S98eiCHhb+yxH4ncia1VSsjzQ7YfgD7my2s1x9cEy4cT67/
	Rgx4fCGBM/lfhTb92ATMfopXaWNl1BNDX2lihAV/tmLry1TCvlpf3dcBo+1rdRNeQPwib63cUyL
	Szod0rOX90DZM7EqhhFg3QIntQyXzOYa9PMlqvF9pdWK2qUnp8/pcy4fQY3NpmGfeUAEAAmMHkx
	4dJw+DYQxni0kBhiBOh2BflUxNZw04YjM2Qfu13eM10/3BpJPOoyPwd0OgpsRCcUE92ymN70edO
	k8iiXAJ33aTLEd1av78xTlLAMHy8tsV/9+dHVo4xvanWDSSQXszWSY2o71dCcwEWZ7pn2Si3zz0
	AAK41IGgDUk6otmJHwz2rNtky6p+cTXkf2CfhsmRDZFhZJuqCYU2qExZTADsTHR9DZo3lWxMmCn
	DTv1S46f9mw97uheD0ADOa/u5WbkIV7Yq6zLMS1bV1Z0oM6AS6NtMuS4THEHR64ij4c4FkFZAjT
	ltc5Gp6HcNZDnmIb4i/z7VWJN7COUg0Ic1Y0GxHZZg7qBCT/nQ=
X-Received: by 2002:a05:7022:60e:b0:136:e639:9c22 with SMTP id a92af1059eb24-1386f39567dmr2020156c88.21.1781390824318;
        Sat, 13 Jun 2026 15:47:04 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm6345380c88.14.2026.06.13.15.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:47:03 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH 0/5] wifi: mt76: add USB RX aggregation support
Date: Sat, 13 Jun 2026 17:46:50 -0500
Message-ID: <20260613224655.2405686-1-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37771-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EAD067FF3C

This series adds optional USB RX aggregation support to mt76 and enables
it on mt7927u.

RX aggregation allows multiple RX frames to be received from one USB URB,
reducing USB completion overhead and improving RX efficiency for
high-throughput RX traffic and monitor capture.

The common USB support remains opt-in, so existing USB drivers keep the
current behavior unless they explicitly enable RX aggregation. The same
settings work for both mt7927u and mt7925u, but this series enables the
feature only on mt7927u for now.

This series does the following:

- size RX page-pool pages from the queue buffer size
- support out-of-order RX URB completion
- add optional USB RX aggregation parsing
- add debugfs stats to verify aggregation behavior
- enable USB RX aggregation on mt7927u

The series is based on wireless-next commit:

21352612198c ("b43: add RF power offset for N-PHY r8 + radio 2057 r8")

It also cherry-picks the following patch from patchwork as a dependency:

wifi: mt76: mt76u: use a threaded NAPI for the RX path
Link: https://lore.kernel.org/all/20260609105301.196302-1-phial@phiality.com/

Sean Wang (5):
  wifi: mt76: usb: size RX page-pool pages from queue buffer
  wifi: mt76: usb: support out-of-order RX URB completion
  wifi: mt76: usb: add optional RX aggregation support
  wifi: mt76: usb: add debugfs aggregation stats
  wifi: mt76: mt7927u: enable USB RX aggregation

 drivers/net/wireless/mediatek/mt76/debugfs.c  |  35 +++
 drivers/net/wireless/mediatek/mt76/mac80211.c |   3 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  38 ++-
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt792x_usb.c   |  23 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 251 ++++++++++++++++--
 6 files changed, 335 insertions(+), 33 deletions(-)

-- 
2.43.0


