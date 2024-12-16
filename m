Return-Path: <linux-wireless+bounces-16410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91209F2F52
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3F87A11A2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A3204597;
	Mon, 16 Dec 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VHI0wlCD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010C204088;
	Mon, 16 Dec 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348612; cv=none; b=bfHzIxVKqksnh56S3aaHxIRxxLDc3aJLyE8tFCwuBzoQO17vJWxtuaf0x3OeAWgGgpBNAwrvMSk+R7TMMSWPqVytuFcR4hXnbIYvZmabSOvrSz6TmAJ4e9IC/r5y32QVzr75hvP3R43VpDIrZJLENaWimhPX8oxKzAdupG7YeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348612; c=relaxed/simple;
	bh=JUvh5Dx2l/+Mrwzrx/iMp7KZDIeHbhdYYiSmxE4g8fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cE2v1CgYxetJ2gK7hjWzTiF6oqmtj2uZ4Ls0r6LGxDuQLlIEPgYcdRke5b/6GrGOCSVE2/jTXqMnFrT/ZVcY4P7A98fpE/5qnG5/gGPNFOAE0EYLA7lao/KS97ocpP1wT2ighW1m4bbq6Ci9idsrynfhbrW4nz8+P/8bhv0J2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VHI0wlCD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348609;
	bh=JUvh5Dx2l/+Mrwzrx/iMp7KZDIeHbhdYYiSmxE4g8fA=;
	h=From:Subject:Date:To:Cc:From;
	b=VHI0wlCDyW/jP9DialLz+I7jJmwLuU0INHcOgoxx/dquSdJPNqqYpC1osbUbCCf1k
	 YuI0B8ZeNmbPpXscQLlKZWW9RnhcH26QxgrZrUnA4FT8skHUQueYWiuPOEjc6jAPqD
	 DuwJtIByFlMi0O3ohQMQSzdAt0ZM71JGl8XjVmDk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH net-next 0/5] net: constify 'struct bin_attribute'
Date: Mon, 16 Dec 2024 12:30:07 +0100
Message-Id: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD8PYGcC/x2MQQqEMAwAvyI5G2hLFfEri4jWuJtLXJogivh3u
 3scmJkLlDKTQl9dkGln5U0K+LqC9JnkTchLYQguRB98g3rqqpg2UcOZZZzMMgoZxqVLzlHTti5
 Cyb+ZVj7+6xf8BKHDYLjvB7d7I5d0AAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-net-4d8c00e56604
To: Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348609; l=1098;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JUvh5Dx2l/+Mrwzrx/iMp7KZDIeHbhdYYiSmxE4g8fA=;
 b=VkfVs0bcajaHYCJYMGf9Uh3Fo9j3++fEj5L1Y8PZ5nJx3J6SLn5P/kvsiUQiSg6m4AB/JybSr
 uF0lPdTef1YC912T6IhcTwpm5L3RkuTWFt7FxFX53/W7qemshagi0Ls
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      net: bridge: constify 'struct bin_attribute'
      net: phy: ks8995: constify 'struct bin_attribute'
      wlcore: sysfs: constify 'struct bin_attribute'
      netxen_nic: constify 'struct bin_attribute'
      qlcnic: constify 'struct bin_attribute'

 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   | 20 +++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  | 70 +++++++++++-----------
 drivers/net/phy/spi_ks8995.c                       |  8 +--
 drivers/net/wireless/ti/wlcore/sysfs.c             |  4 +-
 net/bridge/br_sysfs_br.c                           |  6 +-
 5 files changed, 54 insertions(+), 54 deletions(-)
---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-net-4d8c00e56604

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


