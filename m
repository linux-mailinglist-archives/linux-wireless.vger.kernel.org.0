Return-Path: <linux-wireless+bounces-18475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19231A27DAF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 22:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849D23A4365
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F172206AA;
	Tue,  4 Feb 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MgWeM643"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381B21C17E
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705314; cv=none; b=uT1LK8l3FBOoORARofihWXfeT0Ks9AHqEeXCR0BNKgqd1Mqh+PFRF9eX6M0X8fFx+ElBMhatXnPWXc3O87L64/ht4Fk1xWNo61irSloZZzkVBhFGsXkYFnLhFRa/vWATj3xv50zddr4skHlXpJpl8RqA/E8x1g3ktTItKBJbYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705314; c=relaxed/simple;
	bh=SkkgRL+aWhhRmH4pjJumNwBZl/4orWE7TU6iXYsD5o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/YnDVKeeZvVbGfNkzwhOurPJLoIO1OizNSJ2k1uDWo13UM/rvbNkl0GqaLlPrbTHda2Meg3pGfkT9Xm+WH3BTj7vEtmp7eR4KNYY1tob6YCeX3IjBAsKzuC0uMQT6796zJ9WnRpXDwbPebW5rDsIjwNjaWPlKXtWk+hTOXUoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MgWeM643; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-54021daa6cbso6431004e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738705308; x=1739310108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YkZDn5aiP46G0YmGmDePlUKCzJbx9gAEyIeepD9Ze8=;
        b=MgWeM6435d1eCDBJBaUGAog7dG8SftIWeb2+0FaTP/YPNyAFe9HB/KEPy2jYiuqAPj
         eXoEaoqlHCHlVtVRHo2lyf7sLkUWl7dVcuSVMAVS4poQTZ6wPdeOwIYLwKxywXQNmpeF
         GqwgQGwuaPmLM4XTz2d49LIIaVVpbDjrukBL92meKEm6ikk/7/ZH5PCJ9GaQn54m3+X0
         ojseNaOlnLAoDa1CG+v07tZUWWvFodpNEuXIIgTg6g0rERVBGxljjKi7svF5zDuveYXr
         09xti8ecVs0vnThXSHMDYC+fOyWViKKYeHCIxEcNYI8kFDSC57LOK2Z89Pnaxo5QjoCD
         9VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738705308; x=1739310108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YkZDn5aiP46G0YmGmDePlUKCzJbx9gAEyIeepD9Ze8=;
        b=VYbNgrUCE6HviBV+2bMF86+bsP7gJBn+Str/34rYCJ63OATlzVPhtZNwP+W1S/h9+4
         CfutlmcRp5HOPhQgaPZLlJDWi+B4OSd/NoPN+X0XLZbeVMxv2TDpxVyMKYavHuV1k/Ba
         FAAkoecd6n2QqR04NqA2lfB/gXo2qWWIXcr5V4XE2bF3/GIbUCFGWuiq+avC02HDEEhU
         Gb3XKYFra6ZAB8g9EcRX/TmybYiK9tUf+qk/aOxPEyQ4+aOUCE3Smecc2z6i5wD3cjZm
         aenT7gfu6XPeFasUwvgCaI++ZcsGpbkRrkugvd18f5fweP/P3EamnbK2VxQ8tYa/4k+Z
         LRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUjl66IN1ZkKmc6oURhqfsmTGwh1aPb+fDMqBIAWPF3yFEfxJb20Dqn4mlHAMyd/LTNc4g6+K693wPqwgTLnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxegQ+pTvdkr6su6SL3rSimXEPYvKL25B5qkapxHhUma0UTSRzU
	+yhEHzKhOfJpssowRXM8m7Ef5XoGOjvmHz2afc8qJ3MprcObJOip4yA6xC8SlX+AGtukjig50Bp
	SyLVem6JNEyPWjAA2U2p/9rt0OOH7ePNn
X-Gm-Gg: ASbGncugtch9bqPYRBs/2fETQIJZqnPzXzJT7FPZuBP3iZWEsQQxnnS4GTrJQ0OgdQg
	uQtmuj8j0qrbfCfi0OZY/g81BsoLNz/Y2b2VQfDqyiS+gQaISpJty13tv1kTXiP3s/aShydjsO0
	rWzrMiZWEKAJ+AXYvu7AeU6DYm0iLKwK4fJ52DHkGtZhuXGMt2jmfU4vDJYLyHqaXQT6OAgd2YC
	Iapf+l5FO/mTNVWRCctzuqwM6ZXxBGEjulrVZNlGFgtHzlHjLlEc63f9SqJEhvoMBCziQFU2RzN
	X2PqmiT2KThmrAMFzbd/EQ24AVp5mvpS9KXxxvs=
X-Google-Smtp-Source: AGHT+IFYytsAx7QnkQuNjUJtxyv3Dx96zeS9SwWEsuo4ceOYnCkESLc0Ls7mDKdivbKiWU1TQz2zgZ3ZQ6LP
X-Received: by 2002:a05:6512:2245:b0:542:6f78:2ace with SMTP id 2adb3069b0e04-54405a68b4cmr81688e87.47.1738705307937;
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-543ebeb0459sm506587e87.89.2025.02.04.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 286A934063A;
	Tue,  4 Feb 2025 14:41:46 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 03F44E41434; Tue,  4 Feb 2025 14:41:46 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 04 Feb 2025 14:41:44 -0700
Subject: [PATCH v2 1/2] net, treewide: define and use MAC_ADDR_LEN
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netconsole-v2-1-5ef5eb5f6056@purestorage.com>
References: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
In-Reply-To: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

There are a few places in the tree which compute the length of the
string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
constant for this and use it where relevant. No functionality changes
are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/net/netconsole.c           | 2 +-
 drivers/nvmem/brcm_nvram.c         | 2 +-
 drivers/nvmem/layouts/u-boot-env.c | 2 +-
 include/linux/if_ether.h           | 3 +++
 lib/net_utils.c                    | 4 +---
 net/mac80211/debugfs_sta.c         | 5 +++--
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..78c143e65a3f337929f91f70b77e5bc88365eea7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -675,7 +675,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 	if (!mac_pton(buf, remote_mac))
 		goto out_unlock;
-	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
+	if (buf[MAC_ADDR_LEN] && buf[MAC_ADDR_LEN] != '\n')
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index b810df727b446b1762a1851750f743e0de6e8788..43608e45c58aa96a505d82733de1b24ef8d18a1b 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -100,7 +100,7 @@ static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 731e6f4f12b2bf28e4547d128954a095545ad461..4a6c0d0e6dc90a138bfbb402d401d41f59c021f8 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -37,7 +37,7 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427ad9cf58b50c79cbfe185615800dcb..afb2fdc0af653626034ae5e19309c8427272a828 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -19,6 +19,9 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/if_ether.h>
 
+/* XX:XX:XX:XX:XX:XX */
+#define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
+
 static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
 {
 	return (struct ethhdr *)skb_mac_header(skb);
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22f977409f7a6792bb1340f4e911c3..0aedd4854d85ba89dbf0e7451b3f6b197cfac1de 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,11 +7,9 @@
 
 bool mac_pton(const char *s, u8 *mac)
 {
-	size_t maxlen = 3 * ETH_ALEN - 1;
 	int i;
 
-	/* XX:XX:XX:XX:XX:XX */
-	if (strnlen(s, maxlen) < maxlen)
+	if (strnlen(s, MAC_ADDR_LEN) < MAC_ADDR_LEN)
 		return false;
 
 	/* Don't dirty result unless string is valid MAC. */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d3160086ac492d77092a0c8a74d2384b28c..29f45382367e4f6cceb0e0b5f04db1c408da712e 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -457,11 +457,12 @@ static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
 				  size_t count, loff_t *ppos)
 {
 	struct link_sta_info *link_sta = file->private_data;
-	u8 mac[3 * ETH_ALEN + 1];
+	u8 mac[MAC_ADDR_LEN + 2];
 
 	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
 
-	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+	return simple_read_from_buffer(userbuf, count, ppos, mac,
+				       MAC_ADDR_LEN + 1);
 }
 
 LINK_STA_OPS(addr);

-- 
2.34.1


