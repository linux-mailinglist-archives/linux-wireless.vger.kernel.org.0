Return-Path: <linux-wireless+bounces-20260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99FA5E4C7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FCF189FDC4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1A25A2A2;
	Wed, 12 Mar 2025 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A5T+OBQ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4921F0E32
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809122; cv=none; b=If4sM1Eh1/TgnUEgcOWllbPS2qOLa2Drd1f69TAxGegbRu++eKZVMWZnsWnVUsl0KeFKhbJBgBfJ6ZXsrOYEVm0uYc3y7tt7nce1HGxxc6vfPm+2CfTg6ukbgxkWLdqMHRtnOPTWtcNj5iOfnx3iTt1UxcjKZI6cvOGPS0+5Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809122; c=relaxed/simple;
	bh=wSiMBD5AqtXDHx2GlaVWuxF1HID01QpW80jbEvrmA7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbDmfl654YN3fb9aYphdYLGk1oCfyGzkFXS+9GdeDm4Km6wuEHEvus9Z3kpDqcZSxaxJWkpVgpTP4FSDgnZZNLJvGF037QH2eeHoINraLvKDrUlL8UZ2YUe15MdZnrCNiyH+XQK9oMXWgrANQmiGjsqa2fvejpzBoAcF+WkKOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A5T+OBQ4; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3cfc8772469so617745ab.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741809119; x=1742413919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muTzcoregwnVliqKKaYAkW7JqJlrboLNG2UCgJcpMGU=;
        b=A5T+OBQ4w+kzpsIa1Ymn0l8mWVvH7FuLP/GuFITbE7ZiMRIQlPB11N7XU/Fmkg9t8d
         LVzwBI227c2iK7Gus8P51vQzls0hR8GZnALKZB77QAlyJHzDOjqdcKaRrQuMdj4HSmJ+
         9pWzhuqYy/vbsoCU+nDDapMr2qh+/dZARB0xqbrMDAi6p1jAfItHVkEbETW8xRNU3oto
         i3YWdOGXeon1bwNXZt2iG27E4SDT8WaX8kFbc65lrIhWSYxhauTwSCm+HtGVo/a5gc5g
         jLmAZMJcNkITXlUGV/bQP3pvXXYaUOjT+PKrLlnsOr+ewHaqy5fW8PlTt7QZLcZSjI8Z
         1/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809119; x=1742413919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muTzcoregwnVliqKKaYAkW7JqJlrboLNG2UCgJcpMGU=;
        b=HngsNj/b7BUH/Z8PiDaACu8YjsJJQ2vnSl3oWy6hO1a40Cp65OfGsHfWgGP38J2/rQ
         5WMkZ0IptYdeahw7TZfrp2CXROzKo/tCi92EcFODOhsNwn4dNuETYjDdOycPjz7lPL2/
         bEQpf61D2PiVIarb0k+8peT+3602zrFz6U5nxQF9mW8qCYkyUrA5w9nR13hd9LsjwZ3N
         7SCJ3k7fEAFDbaORzk7EiBwbwP1l6v/7hqTBLXqvSXUa4Wj58DH8C5PLuUviQpr3cM16
         NY0EijrJHQIl5UzWfAu0tWkYgagbnJQGfnvIbDarAdyoBh0ko4y+YrmE+z1QuFEW55Af
         2J8w==
X-Forwarded-Encrypted: i=1; AJvYcCUTaxMdF1oj3IxfTMFefWNu5bEY7yE/PWGBi/G+3FVUEXLEIHnHAeVcyGEoBENelTkCJaLiyLNUnKxlIaOTQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaNrJYiS9MR8waj59wHAuBGBzuUXNLrU9Yxb4jOpu2F8J2ZYm
	aXr6sCP6DmLPpomxBOPLHcpUN3MoaEkbyqESG96lAZT+G8FN8bbHCSLgEIYxc/dcSJstqh/Iq9B
	x+3izzP+0ucn4icrMdAfJzHcy7ieYL4HG38iRNa8OrV9XQRys
X-Gm-Gg: ASbGncvffd7gq8NwdXN+DDSg+S55O4EAulgmEU+A+HBzEP3LoDxrHd7H8JXPfwZZxtn
	aKZRvmigDW+pLH02ApfZCzw6wMyEPEIDq2HoB/MvxBrQp1lPDhzZROB6zNWRY+hOXGCGMT4E5nM
	7VQxIXmmIY3sFSh1x0zN0IGOCdUBZLWmWZvP1hzjYc4Tp1vjeYJg+Pki+D0ZRHHo5azg4LvGk12
	fAfQtYcbzgQTeFBEN9nwxP6AbviN1NOSjjV4sQCiDifsUphRCwcc9CkGibuTvAqY9SyhZZay4rL
	n57bOiuqaaajG4VVySsfTLHVWJJp3PjIQ3E=
X-Google-Smtp-Source: AGHT+IFhaAbzgTyOFlskxr7PLndaRsOfrMp5ujI0F9e+vEmischNAW00O7L1KKXQq+wYruJuQ+pVWNpaUkhq
X-Received: by 2002:a92:ca07:0:b0:3d1:9236:ca52 with SMTP id e9e14a558f8ab-3d44186fe89mr232875675ab.0.1741809118922;
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d45121380fsm5799805ab.3.2025.03.12.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 44CD83405D5;
	Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3685DE4054F; Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 12 Mar 2025 13:51:47 -0600
Subject: [PATCH net-next v6 2/2] netconsole: allow selection of egress
 interface via MAC address
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-netconsole-v6-2-3437933e79b8@purestorage.com>
References: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
In-Reply-To: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
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

Currently, netconsole has two methods of configuration - module
parameter and configfs. The former interface allows for netconsole
activation earlier during boot (by specifying the module parameter on
the kernel command line), so it is preferred for debugging issues which
arise before userspace is up/the configfs interface can be used. The
module parameter syntax requires specifying the egress interface name.
This requirement makes it hard to use for a couple reasons:
- The egress interface name can be hard or impossible to predict. For
  example, installing a new network card in a system can change the
  interface names assigned by the kernel.
- When constructing the module parameter, one may have trouble
  determining the original (kernel-assigned) name of the interface
  (which is the name that should be given to netconsole) if some stable
  interface naming scheme is in effect. A human can usually look at
  kernel logs to determine the original name, but this is very painful
  if automation is constructing the parameter.

For these reasons, allow selection of the egress interface via MAC
address when configuring netconsole using the module parameter. Update
the netconsole documentation with an example of the new syntax.
Selection of egress interface by MAC address via configfs is far less
interesting (since when this interface can be used, one should be able
to easily convert between MAC address and interface name), so it is left
unimplemented.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Tested-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/networking/netconsole.rst |  6 +++-
 include/linux/netpoll.h                 |  6 ++++
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index ae82a6337a8d8a07a0d691e2da170f6cf70ae86f..ec740ba127976bf9c978d7b2811fb1735c1a004e 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -47,7 +47,7 @@ following format::
 	r             if present, prepend kernel version (release) to the message
 	src-port      source for UDP packets (defaults to 6665)
 	src-ip        source IP to use (interface address)
-	dev           network interface (eth0)
+	dev           network interface name (eth0) or MAC address
 	tgt-port      port for logging agent (6666)
 	tgt-ip        IP address for logging agent
 	tgt-macaddr   ethernet MAC address for logging agent (broadcast)
@@ -64,6 +64,10 @@ or using IPv6::
 
  insmod netconsole netconsole=@/,@fd00:1:2:3::1/
 
+or using a MAC address to select the egress interface::
+
+   linux netconsole=4444@10.0.0.1/22:33:44:55:66:77,9353@10.0.0.2/12:34:56:78:9a:bc
+
 It also supports logging to multiple remote agents by specifying
 parameters for the multiple agents separated by semicolons and the
 complete string enclosed in "quotes", thusly::
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f6e8abe0b1f19a34a35ec976c127be468d863028..0477208ed9ffa5cc57b072dce35f0789169fc37b 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -25,7 +25,13 @@ union inet_addr {
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	/*
+	 * Either dev_name or dev_mac can be used to specify the local
+	 * interface - dev_name is used if it is a nonempty string, else
+	 * dev_mac is used.
+	 */
 	char dev_name[IFNAMSIZ];
+	u8 dev_mac[ETH_ALEN];
 	const char *name;
 
 	union inet_addr local_ip, remote_ip;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 8a0df2b274a88213f4ca4632ecbb66d74ac960a9..976202d10297a6d7687b8251561ae73c64118f57 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -502,7 +502,8 @@ void netpoll_print_options(struct netpoll *np)
 		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
 	else
 		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
-	np_info(np, "interface '%s'\n", np->dev_name);
+	np_info(np, "interface name '%s'\n", np->dev_name);
+	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
 	np_info(np, "remote port %d\n", np->remote_port);
 	if (np->ipv6)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
@@ -572,11 +573,18 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
 	cur++;
 
 	if (*cur != ',') {
-		/* parse out dev name */
+		/* parse out dev_name or dev_mac */
 		if ((delim = strchr(cur, ',')) == NULL)
 			goto parse_failed;
 		*delim = 0;
-		strscpy(np->dev_name, cur, sizeof(np->dev_name));
+
+		np->dev_name[0] = '\0';
+		eth_broadcast_addr(np->dev_mac);
+		if (!strchr(cur, ':'))
+			strscpy(np->dev_name, cur, sizeof(np->dev_name));
+		else if (!mac_pton(cur, np->dev_mac))
+			goto parse_failed;
+
 		cur = delim;
 	}
 	cur++;
@@ -690,27 +698,45 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/*
+ * Returns a pointer to a string representation of the identifier used
+ * to select the egress interface for the given netpoll instance. buf
+ * must be a buffer of length at least MAC_ADDR_STR_LEN + 1.
+ */
+static char *egress_dev(struct netpoll *np, char *buf)
+{
+	if (np->dev_name[0])
+		return np->dev_name;
+
+	snprintf(buf, MAC_ADDR_STR_LEN, "%pM", np->dev_mac);
+	return buf;
+}
+
 int netpoll_setup(struct netpoll *np)
 {
+	struct net *net = current->nsproxy->net_ns;
+	char buf[MAC_ADDR_STR_LEN + 1];
 	struct net_device *ndev = NULL;
 	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
 	rtnl_lock();
-	if (np->dev_name[0]) {
-		struct net *net = current->nsproxy->net_ns;
+	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);
-	}
+	else if (is_valid_ether_addr(np->dev_mac))
+		ndev = dev_getbyhwaddr(net, ARPHRD_ETHER, np->dev_mac);
+
 	if (!ndev) {
-		np_err(np, "%s doesn't exist, aborting\n", np->dev_name);
+		np_err(np, "%s doesn't exist, aborting\n", egress_dev(np, buf));
 		err = -ENODEV;
 		goto unlock;
 	}
 	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
 
 	if (netdev_master_upper_dev_get(ndev)) {
-		np_err(np, "%s is a slave device, aborting\n", np->dev_name);
+		np_err(np, "%s is a slave device, aborting\n",
+		       egress_dev(np, buf));
 		err = -EBUSY;
 		goto put;
 	}
@@ -718,7 +744,8 @@ int netpoll_setup(struct netpoll *np)
 	if (!netif_running(ndev)) {
 		unsigned long atmost;
 
-		np_info(np, "device %s not up yet, forcing it\n", np->dev_name);
+		np_info(np, "device %s not up yet, forcing it\n",
+			egress_dev(np, buf));
 
 		err = dev_open(ndev, NULL);
 
@@ -752,7 +779,7 @@ int netpoll_setup(struct netpoll *np)
 			if (!ifa) {
 put_noaddr:
 				np_err(np, "no IP address for %s, aborting\n",
-				       np->dev_name);
+				       egress_dev(np, buf));
 				err = -EDESTADDRREQ;
 				goto put;
 			}
@@ -783,13 +810,13 @@ int netpoll_setup(struct netpoll *np)
 			}
 			if (err) {
 				np_err(np, "no IPv6 address for %s, aborting\n",
-				       np->dev_name);
+				       egress_dev(np, buf));
 				goto put;
 			} else
 				np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
 #else
 			np_err(np, "IPv6 is not supported %s, aborting\n",
-			       np->dev_name);
+			       egress_dev(np, buf));
 			err = -EINVAL;
 			goto put;
 #endif

-- 
2.34.1


