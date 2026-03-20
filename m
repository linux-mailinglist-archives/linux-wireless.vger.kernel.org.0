Return-Path: <linux-wireless+bounces-33536-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A30A/WhvGns1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33536-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:25:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650C2D4A1A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22EF53023A4F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F102BF3E2;
	Fri, 20 Mar 2026 01:25:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C72BE04F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969904; cv=none; b=dLvCyyKCKCNm0t3mrW1L0zmVjxeJpGlyOpyWtVVlLR589VX90tSEMBkw7O7tZ86y+dq8eMqXJUJ90B0RTiDxMbzSC5lmU+XpG9gTybE2jNid0oL+Rc5ldaai3p9wGmzGrNQiGWHcJKp6JwiccWfi9KaF2/bXuSrlRCSa80EEYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969904; c=relaxed/simple;
	bh=k/3MiZh6ObBA2Gh0WgqU7rsQmjvA6q6JXhNX15TphY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7RkQdoQo/XlH2csnYn+XGAxS40o3CYFoMr57tY+BUEp3AfI3DJ1ueI9Fvsc8F7zDYfq1YR5ur6KxAy9aMxdu/+fQmPiRi3G7MZa6SZhuE22m2m3NTxWC7r7J6se4h1s+0cduh/BGpDJb5sLF1b5aTIsRNlp9J4MiEXkU5pRxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso2572784eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969903; x=1774574703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rpuLOskCPApojyOfZj7pXXkMzfKSIlGWmqpeqvyGp0=;
        b=lbxMGgbSe/9UHLoqxq/40xtLRs2YGKMQR7NVXWbMR2qpKUk+PDSluiI5cuZ3H9Woyc
         dX+O8u0Wc/b1mYOsbOF6m8wsqo+FKj3/7mz01y+4MSawDAlLHUSqOucDqGgv+JEvFUWs
         liz3vMDkvPwJlxbL3dLzHw+V5a3MIkhZOEBMxEk4fzp3OdaBqHjlOjhns2jpyletkAm4
         bdC4CFEhDgdO5NL1G7WPORTAPwkF4JvdSfgUTQcNjzYGopcZm+YukZyNwIpk/ulHci5x
         1WuJpfRBgFjMm07LUBpik827Ru2zvj2r9nvrJRkp/M4U1cl7KiP0Y5Ri9yKIOIV0fANp
         qvkA==
X-Forwarded-Encrypted: i=1; AJvYcCXqRSlRVfuEVMjx8iT0H5yExFHy8ULDT1lgQY/hWzJpXOcBVmrGrZ9pHj46NCGLs8m1hoCVaVK37ggcBTHF/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5f0X+KoQJQ3P+s6eS8xzCVgsSARkkEWuP+nm4CtgvVR+mCewO
	Iu3wkFojwAmNR6T8DixoY41ghTZbSDSX639BkGHrW+t2t6kV29Iv/y0=
X-Gm-Gg: ATEYQzzK5yIX0N/D+0lcTyT5zP2otRbEUt7aXEyXNyZUL5YCwHKFBr8DHeRbkZetpIh
	wUW8hx69MPon9vdrucwbqTC5kNGTZ5GGvqUE8i50moNzJJTsVFPvRZB19u4WwesXBX0EHzs08dv
	xv2fyR7rwiRA8EDmfvx4BqCpq2QJRzRQOsW6RNxsBZ7WJmGA02/wwnRmR/2SpQ04kd/oJXuaToL
	aeRlwXLqlQrUTKabE4vwQTxxhb13+i9kVyM7EwCq1VtwJHt3xPR45X5xVvkAj6kd25avqQMvHZS
	hBWcfwZR9m4k2n/DIIF6hC8LftPQPuu0heG5r4HKOGgp+fvsD9gdBiwH4MADcCNItafC4jOuVMa
	FvRNHYaEOFsvyWz7akrK5GsqNT8U6XPjH76TJ1zz0oXv+c2HbJlO8cSzAtrMZIPiQavefoJskre
	5CZIZBE7l46pXlcroEnL+jNIpJTntEKUuGwWXY7DKSS5ZkGJ2mlBsjYho4QA8w+czy/oHeC1roJ
	0TSs+7GJfh+LD5oFQ==
X-Received: by 2002:a05:7301:9f0c:b0:2b8:4c95:365d with SMTP id 5a478bee46e88-2c1095f54afmr757541eec.10.1773969902833;
        Thu, 19 Mar 2026 18:25:02 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b35116bsm1575407eec.30.2026.03.19.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:02 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 00/13] net: sleepable ndo_set_rx_mode
Date: Thu, 19 Mar 2026 18:24:48 -0700
Message-ID: <20260320012501.2033548-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33536-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.409];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7650C2D4A1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a new ndo_set_rx_mode_async callback that enables
drivers to handle address list updates in a sleepable context. The
current ndo_set_rx_mode is called under the netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. This is
problematic for ops-locked drivers that need to sleep.

The approach:
1. Add snapshot/reconcile infrastructure for address lists
2. Introduce dev_rx_mode_work that takes snapshots under the lock,
   drops the lock, calls the driver, then reconciles changes back
3. Move promiscuity handling into the scheduled work as well
4. Convert existing ops-locked drivers to ndo_set_rx_mode_async
5. Add a warning for ops-locked drivers still using ndo_set_rx_mode
6. Add a selftest exercising the team+bridge+macvlan topology that
   triggers the addr_lock -> ops_lock ordering issue

v3:
- module_export(__rtnl_unlock) (nipa)
- s/netdev_uc_count/netdev_hw_addr_list_count/ in bnxt (Aleksandr)

v2:
- wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit (syzbot)
- simplify mlx5e_sync_netdev_addr for !uc (Cosmin)
- switch to snapshot in bnxt_cfg_rx_mode (Michael)
- add team to net/config (Jakub)

Stanislav Fomichev (13):
  net: add address list snapshot and reconciliation infrastructure
  wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit
  net: introduce ndo_set_rx_mode_async and dev_rx_mode_work
  net: move promiscuity handling into dev_rx_mode_work
  fbnic: convert to ndo_set_rx_mode_async
  mlx5: convert to ndo_set_rx_mode_async
  bnxt: convert to ndo_set_rx_mode_async
  bnxt: use snapshot in bnxt_cfg_rx_mode
  iavf: convert to ndo_set_rx_mode_async
  netdevsim: convert to ndo_set_rx_mode_async
  dummy: convert to ndo_set_rx_mode_async
  net: warn ops-locked drivers still using ndo_set_rx_mode
  selftests: net: add team_bridge_macvlan rx_mode test

 Documentation/networking/netdevices.rst       |  12 +
 drivers/net/dummy.c                           |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  55 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  14 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  30 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  16 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  20 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 include/linux/netdevice.h                     |  26 ++
 net/core/dev.c                                | 176 ++++++++--
 net/core/dev.h                                |   1 +
 net/core/dev_addr_lists.c                     | 110 +++++-
 net/core/dev_addr_lists_test.c                | 321 +++++++++++++++++-
 net/core/rtnetlink.c                          |   1 +
 net/wireless/core.c                           |   1 +
 net/wireless/nl80211.c                        |   2 +-
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 +++
 22 files changed, 765 insertions(+), 94 deletions(-)

-- 
2.53.0


