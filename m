Return-Path: <linux-wireless+bounces-34176-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INkfMqRLymmb7QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34176-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:08:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9876E358E2B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E474300621E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092C3A6B72;
	Mon, 30 Mar 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zt69Es65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A623B7B74;
	Mon, 30 Mar 2026 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865167; cv=none; b=PqZ2+jPCeg+dCQ9Ugbg82ROBzn5M0ulTjJ4jhxmJtAPYzRzDZF7ewvspBUlW+a9CJGv9GMQv6sjbJo6vGnqni3GbGxbLQ/47Pj+3YlGXMOM8aFkdTIML30BfNYFGwC5N+HqaAKaz/wX05Q8o+R367AwJrmpP655wFtkrfcSVVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865167; c=relaxed/simple;
	bh=+T1KB1PRAcDpvQuuJjtTEvpIKvPWqc1Ds4Px12LBTP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YN9ukKiKQDJ5EqnO7udRfx05ZUFlDjXCwDPdeAAT/MDPWrnc5BqWcO1UCRcJsNnRhM/G1jClpjG5ERsVoHwlbmLZ00P9JsQNkCF60sI9L1tYpBPcsJxGedWll7N2ZGp6EYXcx9P6KW9W0cTsA5LZ42Wtjl3riRuQaQlqZdvIM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zt69Es65; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774865158;
	bh=+T1KB1PRAcDpvQuuJjtTEvpIKvPWqc1Ds4Px12LBTP8=;
	h=From:Subject:Date:To:Cc:From;
	b=Zt69Es65XnjFRPtzrPcIbf7sKLof+bmYywkQtn30x30MLp7a91AtyYxoz8eOAV+CX
	 hbklTsqjnglLljukrwIBc6BVJjgtVM+AogbDeIFJcetHc68fCH6M4wbW3uZ0IX84gd
	 jGgDqPqBs5exbtcOSc0CxdnmsI+e1f+HfWFyCqvfWue10GLcG9SdCsryL7IE8MmhvR
	 WshiF1/YAis+PWvUYPVYfiQ54ZuT7NdUoEGfB6YPQiwI1EH/oD9OZJg9x3PVUpYdjF
	 AmmXgXn/qge4tpbJ1eKknmRNozMNzbZqe+Rv0/kwBcCoMicuMDRs5p7BvY5lsYP/JK
	 g744fsyMnsE3A==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:628:0:43ea:f64d:fc7e:3a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E104D17E418F;
	Mon, 30 Mar 2026 12:05:57 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Subject: [RFC PATCH RESEND 0/3] net: ath11k: Firmware lockup detection &
 mitigation
Date: Mon, 30 Mar 2026 11:05:30 +0100
Message-Id: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34176-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:email,collabora.com:mid,ntp.org:url]
X-Rspamd-Queue-Id: 9876E358E2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When sat idle for approx 24 hours, a user experienced a firmware lockup on a
ath11k chip, resulting in the following log output:

  systemd-timesyncd[558]: Timed out waiting for reply from 23.95.49.216:123 (2.arch.pool.ntp.org).
  systemd-timesyncd[558]: Timed out waiting for reply from 23.186.168.125:123 (2.arch.pool.ntp.org).
  systemd-timesyncd[558]: Timed out waiting for reply from 64.79.100.197:123 (2.arch.pool.ntp.org).
  systemd-timesyncd[558]: Timed out waiting for reply from 69.89.207.199:123 (2.arch.pool.ntp.org).
  kernel: ath11k_pci 0000:03:00.0: failed to transmit frame -12
  kernel: ath11k_pci 0000:03:00.0: failed to transmit frame -12
  kernel: ath11k_pci 0000:03:00.0: failed to transmit frame -12

  [...]

  kernel: ath11k_pci 0000:03:00.0: failed to flush transmit queue, data pkts pending 564
  kernel: ath11k_pci 0000:03:00.0: wmi command 20486 timeout
  kernel: ath11k_pci 0000:03:00.0: failed to submit WMI_VDEV_STOP cmd
  kernel: ath11k_pci 0000:03:00.0: failed to stop WMI vdev 0: -11
  kernel: ath11k_pci 0000:03:00.0: failed to stop vdev 0: -11
  kernel: ath11k_pci 0000:03:00.0: failed to do early vdev stop: -11
  kernel: ath11k_pci 0000:03:00.0: Failed to remove station: xx:xx:xx:xx:xx:xx for VDEV: 0
  kernel: ath11k_pci 0000:03:00.0: Found peer entry xx:xx:xx:xx:xx:xx n vdev 0 after it was supposedly removed
  kernel: ------------[ cut here ]------------
  kernel: WARNING: CPU: 0 PID: 1229 at net/mac80211/sta_info.c:1490 __sta_info_destroy_part2+0x14e/0x180 [mac80211]

This patch series:

 - Fixes a bug in the core reset logic which could cause a second redundant reset
   after the original reset completes.
 - Implements the error correlation logic and queues a chip reset when detected.
 - Adds a simulation to the simulate_fw_crash debugfs file to test the
   detection logic.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
Matthew Leach (3):
      net: ath11k: fix redundant reset from stale pending workqueue bit
      net: ath11k: add firmware lockup detection and recovery
      net: ath11k: add lockup simulation via debugfs

 drivers/net/wireless/ath/ath11k/core.h    |  3 +++
 drivers/net/wireless/ath/ath11k/debugfs.c |  7 ++++++-
 drivers/net/wireless/ath/ath11k/hal.c     |  7 +++++--
 drivers/net/wireless/ath/ath11k/htc.c     |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c     | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     | 28 +++++++++++++++++++++++++++-
 6 files changed, 52 insertions(+), 5 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260304-ath11k-lockup-fixes-b808b5c7318b

Best regards,
-- 
Matt


