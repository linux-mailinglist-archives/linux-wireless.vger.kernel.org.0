Return-Path: <linux-wireless+bounces-32468-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD+0AToqqGkdpAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32468-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 13:48:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF111FFD45
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 13:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94ED43042752
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133B1E633C;
	Wed,  4 Mar 2026 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L4wShVIq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B51E98EF;
	Wed,  4 Mar 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628476; cv=none; b=PXpOzHKLvjwjgOk6PE8TdeHk7j9pb3Y/DN95fxj89NqZ6Y5EASx9OBYIBfSJ9AIiS7NvmPDnzF6lJCgIqJH5oOKYZpy06DV2igiuoOzGcqvL/h6d39LemIWKVA3Sz7PiHTSO9LFc6jj7eEer7TCrgiieuzKPrwbwCgU0El5Vdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628476; c=relaxed/simple;
	bh=VSlYb3du74hsNmTtTtO0NkW7h5OmhCaYzsaAbhsMwho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AWe/UlGbZdhyBb9ZKMATcmHHVAeRQpMft8YJ4d+6ZBweJbmwna4CyURm+J7E+aze1aGbEoRO7H3BmcVNqvfPTJqTSyyX41fJtO5GFtKslPQjMomIsWheKMsxirGlLwNsJIO3VMN2ZMc/ApYnU9poEXqkb0EKpZ54hug2c7Kjn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L4wShVIq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772628473;
	bh=VSlYb3du74hsNmTtTtO0NkW7h5OmhCaYzsaAbhsMwho=;
	h=From:Subject:Date:To:Cc:From;
	b=L4wShVIqz4qUu/Ek1Ogqw8KNpBuwjpLP/2K21tCGztyAPsGHKM2tHYQY7rUWx5lTH
	 Qg6Rq4rYkQhNxzvlCEkPkYKn9MoKcVrtHwcvoUN0cZXvBEi/qeK8GVU1o3Ep8dxisP
	 ek5TyQ9o8HqMfmt1U0t7rK2nAAdbGNSMjJvp8qruLFb06qkNK4VskpvnUD4UG/PTl9
	 bgxOhSUJt/neKI1fwHFaPBc/fv5GWpgz2JafJdCv3aE7pjZeVxjGgr4M34qdodW1Kp
	 /i30+s2Tzym8Gu/AexNit8y3NRQdQ4Dr3zE0A4AHQhoOssC/awwy6I0IOy+vXM9YO4
	 A+HYASDePimoQ==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:64f:0:a5a5:9171:d9e9:ce23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 55D8A17E0454;
	Wed,  4 Mar 2026 13:47:53 +0100 (CET)
From: Matthew Leach <matthew.leach@collabora.com>
Subject: [PATCH RFC 0/3] net: ath11k: Firmware lockup detection &
 mitigation
Date: Wed, 04 Mar 2026 12:47:12 +0000
Message-Id: <20260304-ath11k-lockup-fixes-v1-0-67143c2fe2a1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMT3cSSDEPDbN2c/OTs0gLdtMyK1GLdJAsDiyTTZHNjQ4skJaDOgqJ
 UsARQY7RSkJuzUmxtLQC25+UTagAAAA==
X-Change-ID: 20260304-ath11k-lockup-fixes-b808b5c7318b
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 7EF111FFD45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32468-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,ntp.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
Matthew Leach <matthew.leach@collabora.com>


