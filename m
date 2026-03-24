Return-Path: <linux-wireless+bounces-33792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PDvJiAVw2lCoAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 23:50:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3831D75A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C253311B69B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087663C65E1;
	Tue, 24 Mar 2026 22:46:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9038F635
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392395; cv=none; b=D1HX/vCua6yXtzQ5aYXyGVdU2zSzBGgVY01pN5vYrtL9kHwIJP+XRJ8t8qCLnN5n1VGaEAF+g/DoAQSDRreS3bylDlYtmb/yhpAspTX2bgehd8lX3bQU7Kbk4gD8tMAb+HXPJ0ppym0hRvoJDMDDAJs2j+wReFSwItb01dO/MoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392395; c=relaxed/simple;
	bh=3YDYe+eKvpUXHiyvLACVGcDJXT1eIj28IFAVn7VoE+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8bGT8WHBeNgOBU52P6j4jhEnijtNy865bibOe781vdEiMfXqnl8KsVMl8X0zkeECR+S/GPMzAdQJ9RnQ2+KQcggbWMjpW6vnZbABs5IEMYrg4/2Mtjr1a0P51koOZqhyLmxH0nDGjVoIN+uO/40p6NEiwZJheUrE3t3SJcAwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so5226520e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 15:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392392; x=1774997192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwV/BjEvjB+2xLn3P/yF4TbYfG+FKFLU/kxsrZgmYEA=;
        b=jJIfANjrXbEzG+nIk9rKNLEE3j1K+12Ai3slWtPzGcnD4mTV5ic/sUtlaSwhnk8BdA
         veb1c3PE3GMaIhNGB//thkG2JeBrOCfKSbWi7/yxPg2btAzpofBavDgD64o2vHaXlp0Q
         XcEGxMsa3rWC1tc2UvIDMFVFvdnbFyavv5/NNzSu0c3R/tZR9Th3zCVgnri01ATIt+7Y
         Peh3GhjRa/KziIdh6qUbWVbjTE1qTGGLidUcp36llHkBYOvWfjAiVSljoLqLAqd6KcbH
         EgjjHsLDaMYlkwqUI4AwS9+ZBwXZSgISBwEhM49M4RNxRArNvQxdICVFRss4jrNXbXK3
         Bmwg==
X-Forwarded-Encrypted: i=1; AJvYcCWttvaZYZ9suxgRgrzg8EguBS9qETCW9gEyrEsB3IWiHxnpwmPtafbaXgtR/YtGcUrzbfzbufzCpEGtUaKRhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCkih5HG5WxdH7rSzBEaZkR6VpgB8GYC6BatxHWFzBLD1810E
	Yws435kRe2bb+BqMSstXIbslcHIl0WJvuX85tJv/qkRVWOoRLD8XoTIh
X-Gm-Gg: ATEYQzx5bPLdeVnOERYNWUqwnb/gcObZd+KIzVwvlJhHI7Z3Mzy/VlrZy1SYK/wUAiJ
	fDwnBf5TDuBvkh/9SPuD6MTQ5Vfc70Flw8wuWtmIRd5nyl7kfU4HoqM1tyKQo8sEO4pub+P2U5B
	YI7dV7NcRNSOUvF0S9NA3bEOcYsJoTyaCddoC2/1uHoxiuNLu8dESeXfqaRHANPukVZDqsgyipG
	+BqDMyn4kmvlG7n8uhUyWzaHcHLkhc7ppe0NbU5b5qQ3+dbWK4v8IrrzMTP+ovwv7KB18XzPGK+
	qJmNQ6tyTpUa0tnMHU2VUBsj7DmjRXgx0HOUwanJki2/yvs7Y1Tiu+V8QuVi/g7wZgJQuijW6Vj
	ft+DnwP5WRDY8kMemP7ymULMouOnltC5Dsn3WZTYv8u6BLQXqmEkXIAVz8Ct+eY/CIxFYuUchS8
	ux8QsGmkD0YmWjzZfuA/Ns
X-Received: by 2002:a05:6512:1250:b0:5a2:86bf:28cf with SMTP id 2adb3069b0e04-5a29b990918mr350145e87.29.1774392392094;
        Tue, 24 Mar 2026 15:46:32 -0700 (PDT)
Received: from hackbase ([213.87.129.220])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a298fe3383sm626971e87.9.2026.03.24.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:30 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Gal Pressman <gal@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	James Guan <guan_yufei@163.com>,
	Kees Cook <kees@kernel.org>,
	Paul Moses <p@1g4.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Popov <alex.popov@linux.com>
Cc: security@kernel.org,
	notify@kernel.org
Subject: [PATCH] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free
Date: Wed, 25 Mar 2026 01:46:02 +0300
Message-ID: <20260324224607.374327-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33792-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,sipsolutions.net,163.com,1g4.org,vger.kernel.org,linux.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.com:email,linux.com:mid]
X-Rspamd-Queue-Id: 16C3831D75A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we execute `SET_NETDEV_DEV(dev, &priv->lowerdev->dev)` for
the virt_wifi net devices. However, unregistering a virt_wifi device in
netdev_run_todo() can happen together with the device referenced by
SET_NETDEV_DEV().

It can result in use-after-free during the ethtool operations performed
on a virt_wifi device that is currently being unregistered. Such a net
device can have the `dev.parent` field pointing to the freed memory,
but ethnl_ops_begin() calls `pm_runtime_get_sync(dev->dev.parent)`.

Let's remove SET_NETDEV_DEV for virt_wifi to avoid bugs like this:

 ==================================================================
 BUG: KASAN: slab-use-after-free in __pm_runtime_resume+0xe2/0xf0
 Read of size 2 at addr ffff88810cfc46f8 by task pm/606

 Call Trace:
  <TASK>
  dump_stack_lvl+0x4d/0x70
  print_report+0x170/0x4f3
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  kasan_report+0xda/0x110
  ? __pm_runtime_resume+0xe2/0xf0
  ? __pm_runtime_resume+0xe2/0xf0
  __pm_runtime_resume+0xe2/0xf0
  ethnl_ops_begin+0x49/0x270
  ethnl_set_features+0x23c/0xab0
  ? __pfx_ethnl_set_features+0x10/0x10
  ? kvm_sched_clock_read+0x11/0x20
  ? local_clock_noinstr+0xf/0xf0
  ? local_clock+0x10/0x30
  ? kasan_save_track+0x25/0x60
  ? __kasan_kmalloc+0x7f/0x90
  ? genl_family_rcv_msg_attrs_parse.isra.0+0x150/0x2c0
  genl_family_rcv_msg_doit+0x1e7/0x2c0
  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
  ? __pfx_cred_has_capability.isra.0+0x10/0x10
  ? stack_trace_save+0x8e/0xc0
  genl_rcv_msg+0x411/0x660
  ? __pfx_genl_rcv_msg+0x10/0x10
  ? __pfx_ethnl_set_features+0x10/0x10
  netlink_rcv_skb+0x121/0x380
  ? __pfx_genl_rcv_msg+0x10/0x10
  ? __pfx_netlink_rcv_skb+0x10/0x10
  ? __pfx_down_read+0x10/0x10
  genl_rcv+0x23/0x30
  netlink_unicast+0x60f/0x830
  ? __pfx_netlink_unicast+0x10/0x10
  ? __pfx___alloc_skb+0x10/0x10
  netlink_sendmsg+0x6ea/0xbc0
  ? __pfx_netlink_sendmsg+0x10/0x10
  ? __futex_queue+0x10b/0x1f0
  ____sys_sendmsg+0x7a2/0x950
  ? copy_msghdr_from_user+0x26b/0x430
  ? __pfx_____sys_sendmsg+0x10/0x10
  ? __pfx_copy_msghdr_from_user+0x10/0x10
  ___sys_sendmsg+0xf8/0x180
  ? __pfx____sys_sendmsg+0x10/0x10
  ? __pfx_futex_wait+0x10/0x10
  ? fdget+0x2e4/0x4a0
  __sys_sendmsg+0x11f/0x1c0
  ? __pfx___sys_sendmsg+0x10/0x10
  do_syscall_64+0xe2/0x570
  ? exc_page_fault+0x66/0xb0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

This fix may be combined with another one in the ethtool subsystem:
https://lore.kernel.org/all/20260322075917.254874-1-alex.popov@linux.com/T/#u

Fixes: d43c65b05b848e0b ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/net/wireless/virtual/virt_wifi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 885dc7243e8d..97bd39d89e98 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -557,7 +557,6 @@ static int virt_wifi_newlink(struct net_device *dev,
 	eth_hw_addr_inherit(dev, priv->lowerdev);
 	netif_stacked_transfer_operstate(priv->lowerdev, dev);
 
-	SET_NETDEV_DEV(dev, &priv->lowerdev->dev);
 	dev->ieee80211_ptr = kzalloc_obj(*dev->ieee80211_ptr);
 
 	if (!dev->ieee80211_ptr) {
-- 
2.53.0


