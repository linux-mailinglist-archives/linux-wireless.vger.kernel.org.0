Return-Path: <linux-wireless+bounces-38990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EMsyNuQoVWqzkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 20:05:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 443AC74E49F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 20:05:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BOrOsyE2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38990-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38990-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40160301A41A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B2233A005;
	Mon, 13 Jul 2026 18:05:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F633314A84
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 18:05:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965921; cv=none; b=epstvucGUCXJOJnxteQ7+zPJG78ZDqLavIc4KUAmbpPUmqtlFqKTCy12zj/a6KzZ0TjO4NMEoS0oQnVW4Ve8y5pI7BL/JibCZeYuX5UiBVaUpTxFzBbtAwiiAnV25aGWkv5mt97ECIw5DYYklax1nvkZRYZsZi2ilXAc8UcZftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965921; c=relaxed/simple;
	bh=XeZnVF8VMOIq8NowPgSjmvHb8AkE7i+WvqIK6N6ANjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4dOhVOOQ5GPQeZxgUo5oDiXSKYRB8bjdT1+5k8cAgeOw24H45sE/nxdj02mh8D1M4Yyn+YNydLnfxW41dVDrHLKw10a1mu0BUR84YHQsUl6UTCkwinqBBLgkqAc7St6+dwqQAUWrpGda/9Mm3prn7W6CfLVKEoCvk4IGL8TbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOrOsyE2; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f365afc5aso908243f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965918; x=1784570718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPs2lHQRfpK+TsWOFRy9KnqkkNN7TxB0PRSoapXl1VE=;
        b=BOrOsyE2uxxPpM+zui5vnSpr9UHpb4i+2dHjRQqlNk9zn5KE1MWyDihPWmO8r64qZn
         joQFso2weVNFzGNkZjmAJq+HhHZyS9FpOwq27b8BORtWeljy5xAFWfjeWT1mtxsn6Puo
         +uaXpNzcbHPKdj4KyikDbQ/nJYf9RaaaISxDczqVd40x+OGJ+ibZIfga4nJnx8PAgovm
         NuSCrfXid4+ERkCN4XUMWoHxIn7zhwVGzLowXTXuJ/YYJ6tZH4qHoxIG3lUDPpCG6B9X
         VE/acyvQdqw/e4xz6LZYdc5KWLrMQbFthP9uA5hJdstGuWGYBIGaodCshMeJ0E/bJMf6
         GNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965918; x=1784570718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPs2lHQRfpK+TsWOFRy9KnqkkNN7TxB0PRSoapXl1VE=;
        b=f+6DVzeu4Ur84rDsuH7K3Myd+CyWQczidasp1tky0nmtFmt6IKgYyrBXNv13fhRCZU
         UKdmShNfdURCzqmbzPGcsMEPSomYG1IwhZAw1jm9zmMKFuGWr5mvWoNfft3JZBqSnLup
         g8U3vn1/VslKB394ZCEM1fEgssjanjNIdFp+pj0XhRxpFNAZQ4XW1c2LypmmYqhf1PTv
         eVVXepCo2FO1qNj7tJmSiopGtq9U/5HBMlpSXKP+pJ/FOErJuuLt/TiUx8bdy8F1kcGh
         ARocIKEuqlNStsQI54CK+RT3h5K4QpqPABFBK6+rJ1ae537+WauNsOaLk9QaDK5kAwwi
         6Wow==
X-Forwarded-Encrypted: i=1; AHgh+RophKizsYEYdoPhzkbO0IcGFPYpY+1dSW/WsUklypKlT9YQFFO+YSvB0bf0S9MoZ++xm0wwRwUWbQkHmZ2ynw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1LqEf6vhxFiuezGObqbGhCRGaz510T+vsDTLLSMIBB3HLFk6
	SRxNmTNvq4T4DmCTaBCw6XjM12If/S+4EPPKhzN2Y5QnNRUAuzbrm6+y
X-Gm-Gg: AfdE7cnNKXIbt/F1/o3wsyCshtrEdsRZ/FiSEGf7tO/1413MYFkVZYFyrsIhtRAGB2Q
	NWSqonZ3ExEVCX2DePbdkfBB9UFfAR4JYJnDQPjDlD3BJOEdBgZ0OBDHy+WjgGc0rJkHY7I/IU+
	xpfWT2/ixZm0jsTrWKgPqU3epUo9BGcwd8ZuKlDBvBgvcbLc2zsdcJf1+5aL8zvz9TMEL2lGlDW
	sjfKEj1NIt+BNvYEjrm+fq5UHMyMAfPXEenCAHHjg75QEGIMNOy5qQu90R6VutHi4SIV6Wrc1vW
	U3fgL4L19ll0/13JjwQ7vUDJ/rj32hqWdQpinD4NoxzKH/pedStsd8M5ImW+3cS/B+MLM7X7zf3
	KTm0xC4BlERDNhuw86/MuHp4hx5JMB/hr6O0DL+52NhZtRAPLw6ReNx65VeLHCBYvKTmXvjAi1p
	0ry9e2h9F7OGTpH4HomOmnDHygx/wt84kKew==
X-Received: by 2002:a5d:64c4:0:b0:462:e086:35f with SMTP id ffacd0b85a97d-47f2dc88af5mr12536623f8f.21.1783965918210;
        Mon, 13 Jul 2026 11:05:18 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([46.1.111.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm1230690f8f.15.2026.07.13.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:05:17 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [stable backport request] wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon
Date: Mon, 13 Jul 2026 21:01:37 +0300
Message-ID: <20260713180433.52394-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38990-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ismailtarim7@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ismailtarim7@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 443AC74E49F

Hi,

Please consider backporting the following mainline commit to the stable
trees:

  commit 351dd7d2c80d ("wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon")

The commit carries a Fixes: tag but was not marked Cc: stable, so it has
not been picked up for the stable trees automatically. The tip of
linux-7.1.y still lacks it.

Why it should be applied:

It fixes a NULL pointer dereference in mt7921_channel_switch_rx_beacon()
(and the identical mt7925 path). When an AP sends a Channel Switch
Announcement (CSA) beacon, cfg80211 queues a wiphy work item that later
calls the driver's channel_switch_rx_beacon(); if the station
disconnects or the channel context is torn down in between,
dev->new_ctx has already been cleared to NULL and is then dereferenced
unconditionally. This is triggered by ordinary AP behaviour (channel
switch / DFS), so it is easy to hit in the field, and it hangs the
machine: the crash happens in a workqueue worker that exits with IRQs
disabled, wedging the cfg80211 workqueue and progressively locking up
userspace until a hard reboot. It affects the very common MT7921 /
MT7922 / MT7902 chipsets.

Reproduced on linux-7.1.y (Arch Linux 7.1.3-arch1-1), MT7902
[14c3:7902] driven by mt7921e:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:mt7921_channel_switch_rx_beacon+0x18/0xa0 [mt7921_common]
  Call Trace:
   ieee80211_sta_process_chanswitch+0x682/0xc30 [mac80211]
   ieee80211_rx_mgmt_beacon+0x7ec/0x19c0 [mac80211]
   ieee80211_iface_work+0x4c4/0x630 [mac80211]
   cfg80211_wiphy_work+0x13f/0x1e0 [cfg80211]
   process_one_work+0x19f/0x390
   worker_thread+0x1b1/0x310
   kthread+0xe4/0x120
  note: kworker/u64:15 exited with irqs disabled

The offending code was introduced by
  8aa2f59260eb ("wifi: mt76: mt7921: introduce CSA support")

Please apply 351dd7d2c80d to linux-7.1.y and any other supported stable
tree that contains 8aa2f59260eb.

Thanks,
Ismail Tarim

