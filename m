Return-Path: <linux-wireless+bounces-3953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A27860FB4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164ED1C22E67
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B37AE72;
	Fri, 23 Feb 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j/sWPWyU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650B6518F
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684829; cv=none; b=tY5khj6/SZjmHIwW5htH8V3f+tek0NLtfMOQDB7jpfIzlV7krngwd8xOGtL5x8/IcfP/7nS+rIB6JipgHWl5ouw2GMnj6gLCsVYDRudsUCSzP3XL5QMpvxNYdhK6uNBg6CSkIoHT7iANJjYE88ebws2dnSypQpacnAzTqmk/grI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684829; c=relaxed/simple;
	bh=rQr6Dy9x+klZ7X5zTO2b/9ItmRu2KDIQpqzj/gZTXoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKgUBdkNBUsV78+lqW7EfhBtzxfULkZOTSCX6rsJXNV7YmKQpRosN+0nnKzNq1QG3SHWOFoxdaeWET2YKlEZeYD0FIsJSis8S7beBODgrnun68TvTvBFJqwt5Q2SOdRWfKNYfAEIQDdBtvKBdLtlVkH4jOxc+2jVL9v581FdAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j/sWPWyU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kVVoD+Zb1UNXE4wHYDblk/3nRXQAcnY+p2WV3o6Aq90=; t=1708684828; x=1709894428; 
	b=j/sWPWyU02XYdI+5KVT3GYG5FTiWaiP7LP7JBh04I04eGRWaeHqg5XKh1OebsyQx7a08U6NxMwq
	djlrLf1WtvGvR//I3it1FuS3sHTWSkvBV1LW0ZbRCQ2MwQyWV9CiR6cVDNm+QO6DxuPkjOvx7OryA
	rR7bRctaQHIC6vnCU/+avQEQ/fEERR7PkDfY7YG2RgmLWX9DLKGc9PHRg68euvCpK3owLMLuV6NnP
	rbKQGGoIUxj346Q6y6+9T1MkCNm9SibqvKrlv13ZuGrvkBZaGe+GKfEP+XoO0Xt4TOSjmgLcHZ5W8
	MEYXt5U16NlTSjIy3QsvU9KoJybcy8T4SJlw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSyf-000000051om-0yQ0;
	Fri, 23 Feb 2024 11:40:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] wifi: b43: silence sparse warnings
Date: Fri, 23 Feb 2024 11:40:23 +0100
Message-ID: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

sparse complains on this code about casts that lose bits
due to the usage of bitwise not, but really we do want
16 bits only, so clarify that by using masks.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/broadcom/b43/phy_ht.c | 6 +++---
 drivers/net/wireless/broadcom/b43/phy_n.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_ht.c b/drivers/net/wireless/broadcom/b43/phy_ht.c
index d050971d150a..26a226126bc4 100644
--- a/drivers/net/wireless/broadcom/b43/phy_ht.c
+++ b/drivers/net/wireless/broadcom/b43/phy_ht.c
@@ -322,8 +322,8 @@ static void b43_phy_ht_bphy_reset(struct b43_wldev *dev, bool reset)
 			    B43_PHY_B_BBCFG_RSTCCA | B43_PHY_B_BBCFG_RSTRX);
 	else
 		b43_phy_mask(dev, B43_PHY_B_BBCFG,
-			     (u16)~(B43_PHY_B_BBCFG_RSTCCA |
-				    B43_PHY_B_BBCFG_RSTRX));
+			     0xffff & ~(B43_PHY_B_BBCFG_RSTCCA |
+					B43_PHY_B_BBCFG_RSTRX));
 
 	b43_write16(dev, B43_MMIO_PSM_PHY_HDR, tmp);
 }
@@ -551,7 +551,7 @@ static void b43_phy_ht_tx_power_ctl(struct b43_wldev *dev, bool enable)
 				phy_ht->tx_pwr_idx[i] =
 					b43_phy_read(dev, status_regs[i]);
 		}
-		b43_phy_mask(dev, B43_PHY_HT_TXPCTL_CMD_C1, ~en_bits);
+		b43_phy_mask(dev, B43_PHY_HT_TXPCTL_CMD_C1, 0xffff & ~en_bits);
 	} else {
 		b43_phy_set(dev, B43_PHY_HT_TXPCTL_CMD_C1, en_bits);
 
diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index 2c0c019a815d..4bb005b93f2c 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -6246,7 +6246,7 @@ static void b43_nphy_channel_setup(struct b43_wldev *dev,
 		b43_write16(dev, B43_MMIO_PSM_PHY_HDR, tmp16 | 4);
 		/* Take BPHY out of the reset */
 		b43_phy_mask(dev, B43_PHY_B_BBCFG,
-			     (u16)~(B43_PHY_B_BBCFG_RSTCCA | B43_PHY_B_BBCFG_RSTRX));
+			     ~(B43_PHY_B_BBCFG_RSTCCA | B43_PHY_B_BBCFG_RSTRX) & 0xffff);
 		b43_write16(dev, B43_MMIO_PSM_PHY_HDR, tmp16);
 	}
 
@@ -6377,7 +6377,7 @@ static int b43_nphy_set_channel(struct b43_wldev *dev,
 	} else if (channel_type == NL80211_CHAN_HT40MINUS) {
 		b43_phy_mask(dev, B43_NPHY_RXCTL, ~B43_NPHY_RXCTL_BSELU20);
 		if (phy->rev >= 7)
-			b43_phy_mask(dev, 0x310, (u16)~0x8000);
+			b43_phy_mask(dev, 0x310, 0x7fff);
 	}
 
 	if (phy->rev >= 19) {
-- 
2.43.2


