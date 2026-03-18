Return-Path: <linux-wireless+bounces-33398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICFtOHvAumkGbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:10:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DCC2BDE72
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7EA5300A539
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AA3D8124;
	Wed, 18 Mar 2026 15:03:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADB3BE636
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846190; cv=none; b=aHKkv7X7zEBnekMBHN+RFhl46r6v8ODlfaROtQbM5hAj/lIwNZES6M3J1jEhVmbbgnvVwCDiM2lGtVu9/LKByb7sGCghICXTQksH7yKsHM0PLto2YoYRUGB8+lMTtYh3ZXVtCRmc9uLFDUH+irerokdNg6H3ULYs+xuldqwv4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846190; c=relaxed/simple;
	bh=Jiptg9yDJQrV+D8cHBp3a16G3+cX7N41SQHpo9ylaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aX/8zWqWzBoiQLX6yN95C3s+6WMXacTiHuD7Qu+yQNa22TbJdOIsvrEeC4K2fVLSED0NuCFxgeLew6WJUc8SzXzPp2stSHAlfRnHLfMJOL1dBzq+qX4GataEcBIQICOlaWrnseU38S3RaYe0XHnCwSfP4CdT98tet2MvGqbX5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0ca69532cso520744eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846188; x=1774450988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mel7QAaNVQ/Ezv2Sx36tyZ40BmWBA8rFfywqaIdVMQU=;
        b=f/z5XFH4t4vVlfKd5pMj8P7uKrcpmk7mnr7gmR5VioOukb/yacxwdT5t5ZmroULVMs
         Mu8JS+bBKeukmZ5yIQxwJeys03RoYrsvENj+lQgdrLn8dmHjmCW9i1lBBuw1dUeaCt8L
         SCJWi4FJfnxcUhf/9AaheLQ7BEUnBTfpXuyGnkTfONT/xMKX/tIl0ZwHucUZ0Dmc9T9q
         yFYabJehGklkEg2K9YCEMGuEoaeraDRDgrNbLAatMNU066UNYZ4UfwSaaEPfv+isKbHq
         xk6b7RW9kyxc4ySNYWPUp36KNwjcbV3EFDN2isMVnXaBhehdglixeDWsabG3y6xJKVQ3
         A15g==
X-Forwarded-Encrypted: i=1; AJvYcCUErP7vVAp5amA36+Dhh7GlbzFsXLvGeyQ6qfAEuIUTnZwL9UHs0Zm80ThRdo4C3t6VVJFQ3lDA2BRs3RNttw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxlQZTm5lEaCawR6zOCixcBFlXnUStb7BhoqGSOnlE/6fhK2B
	3I67lsmha99+dJjKlbSpE2YkHiCyVrIvv8fyCbO9nGhYDScNLaCnbCg=
X-Gm-Gg: ATEYQzwtd6zo/CM7qfupMmJ8G0/TL0Zxvb+dxVwkg1uMh0BpMgQPmYtWi5GDcJu8Yty
	T0/WpBFLDfBBbUr+xZNoHR2rARRvH9sn+BFboaEGqPW8uRX/0gV+LclTXuhXLoNWV3N5B9GtkmB
	oDXdtaJoRk+4a9iIZBAEwAhvzbUDA9kifjQk3akqPPnDYm9Z2wJbn0avQJjGdgdVmLb4Cby5kGb
	Qo0HPtFPRVpWE1ENaMHpKo8YQOnOGxfYZk7E9N70Ed875M3krKlEfjRQXz2ynFBkC61JzIGqSbB
	8yc3/rm0L6bVPSbw+aPAqzd0jyhyCdMOFY8KbGYDaYJp16kCibfIjhKybkYvN2yH+gNdSG9Hs0B
	/dRCuK8FqADk9cEYRRCGAU3H6SAbF4zR6VAAJRHqSbL2UdE/y2F/FmKNFEvv6YWu/Tdq6VR8+q2
	tQ9hwhuFTPfl7JBINQOFmi6tThWMrs6SCDGYFLEFF8+8aIEkzclXeshjcwiuvIIwM+V3fdsqKnm
	nqUBhvEanbWX6A/xTXKTzMLTMHG
X-Received: by 2002:a05:7300:dc91:b0:2be:88f2:3c98 with SMTP id 5a478bee46e88-2c0e46d3cd6mr1489917eec.1.1773846186396;
        Wed, 18 Mar 2026 08:03:06 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ee672sm5053621eec.28.2026.03.18.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:06 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 00/13] net: sleepable ndo_set_rx_mode
Date: Wed, 18 Mar 2026 08:02:52 -0700
Message-ID: <20260318150305.123900-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-33398-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.323];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:mid]
X-Rspamd-Queue-Id: A6DCC2BDE72
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  53 +--
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
 net/core/dev.c                                | 175 ++++++++--
 net/core/dev.h                                |   1 +
 net/core/dev_addr_lists.c                     | 110 +++++-
 net/core/dev_addr_lists_test.c                | 321 +++++++++++++++++-
 net/wireless/nl80211.c                        |   2 +-
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 +++
 20 files changed, 761 insertions(+), 93 deletions(-)

-- 
2.53.0


