Return-Path: <linux-wireless+bounces-18573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2AA2A00F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 06:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0683A61DF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF622333F;
	Thu,  6 Feb 2025 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W8xuRfyj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8222258A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819298; cv=none; b=t+dTnh3GRQGXosZxD5HDXX93xcY2Uz526wv/7HU1QhNsIA34Kfi0SM8HkwkncC/EX4eXXpCAboEjNcuwQJZYpinXJ+jD1BOW8Oj2Qc4fzNeKtjnMUDR49qX3zbv6aN4ZN8MoNEezMOOQw4eoRByEfXFeonQjmeKzN+FH8r1TmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819298; c=relaxed/simple;
	bh=fMVr7qFL+cRYpNCU1acUph+KfjFdj44f7OgeU21s32E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ga2I92/kzqE5IPK6qlALXpYxG3pckT9lzopUtvTdJcqXcY88z9Lc2yTTzbOzjVr7ABrhRifcC4n5ajnzq03gDw+5wKz72oBt5CQur7wMhW6QV/9XN4xUUr297gbYA5qvRP6xOZtWdw6t8pfuRlnVLhNUK7AyC7FXPCHaJIhMyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W8xuRfyj; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-5dce4a5d8a0so937139a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 21:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738819293; x=1739424093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdHVYTQfcccNoKDFaDK7nnVwIj0vWvmHUufF6M15JVk=;
        b=W8xuRfyj+jYzC5bbCKR2wje3v3pSVLpQfTB8H9CMwfb4GcOA83LsuPyOhemOcW5QfH
         xocRl53Ett0OqyQTBTO0Yj+qUeb1T63zb4DHtRSXJls0OMxsDoCzAaZodeIYxZx4oiTB
         sl0UIitmoQNtoTIWtcOqYOkCSkpe0MdG5wk+RjtbUNP0gCrb9crEqaiTG9Fthc21Vb5G
         5EDA2BoAKLpwF/8RJskFzog3nXgdoiiLWnxGPZIor+1QEMwWlz8UK/SM1L592Pd2PeT+
         /E7eQ5Djbwb9C8fPxf/Uk5HgAW5//usImW5Exp2ztE/ILaMo7N+gF4j36nvfrQcG/G3z
         Or8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819293; x=1739424093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdHVYTQfcccNoKDFaDK7nnVwIj0vWvmHUufF6M15JVk=;
        b=aqpivVSrG86fjI3xE6S2Vl7qcORCgqW6EU/f9DAJ2wP6Q3xj4J5T0cXj9EA1Jh1/aG
         ErRAsQerVw8VMzdemocFuu21cmqztxZbb04e9dIZjMdt4M0y8bbPzey1tssyIuPx9qZZ
         sfVFktI/ezpP+h1jW1sSpWmsigU1eusPiUs4+jutzOVvp7F+fheJ68bLbsX7oRjnJvy9
         j+LVLnr6iR4h8CRXBJlGfsozuXJ0tBsXA5DVh9jSn5HgmQNoiX0es/SDYx1rVzDZYkg9
         /SoFSy5CgUGHzdVjSPIcGLRWimV/321J5qW+M7KSCbUmMvZCxo7NRbl5u477XcllXVD1
         MW8w==
X-Forwarded-Encrypted: i=1; AJvYcCUvF1LZjtx0z6n+9hd/i3XmBiNUzBj2MJ6b+I2Cf64tYUNYt3TMMSqpm4fapTe8rI/SJXPzzuKSW54p3HsCAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWCsIvLIXHF8m23EnRM6doSrB0RzAN1jBxLiYZEEEyT87S465
	0J2AUUIdm9J5ZEYUFjo8cHP5WAx0xARpEq43W45ZW4acfoRGRGHctlTxKkvEdX6LWFxHy5fiY5H
	29DUwne8dRRS3rkPVMcmJ2hMcHSDFIN+24GB8QbCn5p45wibR
X-Gm-Gg: ASbGnct0AylWOJ1BQyT7wFpsm5ooFyB7IcWSWHCTBb6UfpGMOoZZzyYrWc1Nb6ErY+N
	MR1PJe4uOVPBO/GIAmBrbArY4555G3v9sTQYr8vwMIqVYLntLaZGUZjrX5OUnIU3+UQK66wc7Gk
	uLUIX/y1I3HLIwV+x1xV/A9VyeHiKyzcJBxHE6RUv0yuAqhvE2YaFNK+RUDGPy8BWm86h58xVtu
	9nWTOvjQWAAgojPAz/uWxxnzhoHnIWKNop+WcjM90wD4Rn0MIw5uYZ28QzCQFEsHR1FqzgfVhTz
	EyPUQo+aSZSIAmP8tLLAlWE9
X-Google-Smtp-Source: AGHT+IFl089+rm1zmjN8iG+9/13B8VrWSPOdNpDBwWTsJRYlUmvKdrLpWygnLduVxQtW4kKWbhPWJgyCJ0BB
X-Received: by 2002:a05:6402:4404:b0:5d9:ad1:dafc with SMTP id 4fb4d7f45d1cf-5dcdb762de1mr11066307a12.25.1738819292786;
        Wed, 05 Feb 2025 21:21:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-ab773548c81sm1221366b.204.2025.02.05.21.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:21:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8A789340576;
	Wed,  5 Feb 2025 22:21:31 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 366DAE40ECA; Wed,  5 Feb 2025 22:21:31 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 05 Feb 2025 22:21:30 -0700
Subject: [PATCH v3 1/2] net, treewide: define and use MAC_ADDR_STR_LEN
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-netconsole-v3-1-132a31f17199@purestorage.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
In-Reply-To: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
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
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..6db5af2d8d059fa5c072194545d4408eec19b4a9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -675,7 +675,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 	if (!mac_pton(buf, remote_mac))
 		goto out_unlock;
-	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
+	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index b810df727b446b1762a1851750f743e0de6e8788..b4cf245fb2467d281111001bb7ed8db5993a09b2 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -100,7 +100,7 @@ static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_STR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 731e6f4f12b2bf28e4547d128954a095545ad461..436426d4e8f910b51b92f88acddfbb40d374587a 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -37,7 +37,7 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_STR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427ad9cf58b50c79cbfe185615800dcb..61b7335aa037c7232a0caa45572043057c02dde3 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -19,6 +19,9 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/if_ether.h>
 
+/* XX:XX:XX:XX:XX:XX */
+#define MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1)
+
 static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
 {
 	return (struct ethhdr *)skb_mac_header(skb);
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22f977409f7a6792bb1340f4e911c3..215cda672fee1b5a029c2b61529c6813c0edab11 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,11 +7,9 @@
 
 bool mac_pton(const char *s, u8 *mac)
 {
-	size_t maxlen = 3 * ETH_ALEN - 1;
 	int i;
 
-	/* XX:XX:XX:XX:XX:XX */
-	if (strnlen(s, maxlen) < maxlen)
+	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
 		return false;
 
 	/* Don't dirty result unless string is valid MAC. */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d3160086ac492d77092a0c8a74d2384b28c..11d51e348339f1eec1a7d3fd04b1439aaed64593 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -457,11 +457,12 @@ static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
 				  size_t count, loff_t *ppos)
 {
 	struct link_sta_info *link_sta = file->private_data;
-	u8 mac[3 * ETH_ALEN + 1];
+	u8 mac[MAC_ADDR_STR_LEN + 2];
 
 	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
 
-	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+	return simple_read_from_buffer(userbuf, count, ppos, mac,
+				       MAC_ADDR_STR_LEN + 1);
 }
 
 LINK_STA_OPS(addr);

-- 
2.34.1


