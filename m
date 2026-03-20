Return-Path: <linux-wireless+bounces-33548-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HtjJm+jvGkI1wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33548-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:31:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4280B2D4C96
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906D13252C81
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6231A061;
	Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA43101C0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969921; cv=none; b=EIPL77j/rV5BX2qjXVRIgBqavIyQbQqt/JVYIZl7jJTByzTD40o5QgiKl+kyQbLYuev6dFzfmaOveLjsCR2l/LERr6IagSTW960oHzo2AfOKILnxxuEgGeuHhCsMA/iG0pQAfljkX6DHOV1Z95tgTOA60a5kFI7VhMR23e5IyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969921; c=relaxed/simple;
	bh=VK90M3+EGSzjVfsemFKOmNIILll+ZAdpTFJtqe6Y2Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu33Xj9xTvy/nD32dVfSNDwrDM1jnKeJmYNvikgldCbbW8paBDxf5MbhBTb7FTZq7wiUQKHU1UMXEwJtHoyOYY5D6K/CJebIVGFsZHfmlT50RGzSk8IYwzrOxT+Zl8ihfWu8tS/P0DHEIQSx03VuDuAddy5gswEJlpLm+EddQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128b9b7e3edso2688610c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969918; x=1774574718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWBQoO52uK1jdWWUCzjHOfQ7E5wdgkDdRoNSlPpZPUc=;
        b=hDAj3O4C14d+NeeFkxRWkGbECX4w8CDwKXmMZ/C2v+rTzUUntF/xR6ILxqTpu8ool/
         MBmy/xcm8rOxRRvvwUkEN4yjvoxZmehVwQBYMyLFPYu98Ts35yjJOa3DnMpepCLh8zx1
         6boA9QFB9PNgX/+9ajuM7YOhBySyalnws+2wMK98NlRY6/MKB1LwiABQAmunll0DxMfh
         eo6ccxN6FURPGBSKMwVzv2Tb+cr3RSRCq5F9iQGJ67j9t/XsbqaWHmrFJfVQ/tOZW0rH
         XfiJ1/mJzZV5lb2sV4hbb/V800UtXdIVq8b7Cm2MTIVkEKdXfXr1WRXQq3jCJca3OJkc
         4Dng==
X-Forwarded-Encrypted: i=1; AJvYcCWTrQhcpAZJa16X2EzIjOkhMO+xWLa72zdcUQ/jWKo5XsJlUbCj6om6wosiaT9pFe2EUzjw2zVHlhyz1W5U9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaK9191E3s67qld/IMmf1YV+k5o/sZD9d7zLvhI0APS73Ria7
	KhnCs5Z0T8pVgHUrQXn2IVt7OdHZIzOtZ7RLaTn6ep8TrIngZ7UxlAo=
X-Gm-Gg: ATEYQzxYv6hdiroq03fLZQ3v7KOlPEI11S7Lf4arNPQoGAWCZjxrTxpZPISvZmoNiU+
	iQeSpr9EUdhym8h7NUAWgwAgSZqs2nJX3e1Y0Ia3CzSpEyoj6NReEZ/N1/XIdfKRqAtXAUwTZpy
	tOK6Mw9Wa8FTZlUrrRwEC5YJFF9NUdY1ehvGOuKK2/ohmBT3vQBz4/l9vlo7p7TPUZFIs3kmUJV
	d8EkktAUG3XHW2CFaTkKBp77dlDEAjY+DEn8LIRNXMEsJKhuACaBkpZhIJixaJl1zDz4LFWkKot
	eFGhk5kQKkgYQvxrEjtfAVTQN+yMyQ+yVbPmp49/AfaHxQ8QruR84NRoce1EtlC4+G+CdrL3bLo
	kg7PGzZF4NesdG3xbTCKQtiMPiabQf6gCqr3EXWLzPd1Bbyy0HG0T5gw7y4sJOWP3+dQ56gXHFB
	fwl2D9NdrMKa9fh0G12a4IHgSxjOaOB+jOJ25nanuQnltXAuNzlSHz2XRlKCYXJH0xa+Jjumugg
	DLIGPY6BkCjVqg0iw==
X-Received: by 2002:a05:7022:e08:b0:128:d737:d7a6 with SMTP id a92af1059eb24-12a7266cdddmr651698c88.3.1773969917836;
        Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbbc5sm747251c88.11.2026.03.19.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
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
Subject: [PATCH net-next v3 12/13] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Thu, 19 Mar 2026 18:25:00 -0700
Message-ID: <20260320012501.2033548-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33548-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.071];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4280B2D4C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all in-tree ops-locked drivers have been converted to
ndo_set_rx_mode_async, add a warning in register_netdevice to catch
any remaining or newly added drivers that use ndo_set_rx_mode with
ops locking. This ensures future driver authors are guided toward
the async path.

Also route ops-locked devices through dev_rx_mode_work even if they
lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
on the legacy path where only RTNL is held.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fc5c9b14faa0..f38ab254708b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9779,7 +9779,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
@@ -11471,6 +11472,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (netdev_need_ops_lock(dev) &&
+	    dev->netdev_ops->ndo_set_rx_mode &&
+	    !dev->netdev_ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)
 		goto err_uninit;
-- 
2.53.0


