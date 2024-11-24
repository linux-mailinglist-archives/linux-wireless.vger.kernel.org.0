Return-Path: <linux-wireless+bounces-15627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B703B9D71E1
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE63282C97
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D418660A;
	Sun, 24 Nov 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ5wFG4q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A01E633E;
	Sun, 24 Nov 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455502; cv=none; b=JciUCjxl8Gk/OWR7oRk8xHxnTbV/RwXKpM3Oq3NopRJKmbWCnRzVoN6YBFjQ9tbOOw0+Wk2Llu86bYb832dp9cacu4TCw+J8PZeClJE9mETlttss+ER19k7f6PKelyVfeEe1u3ucm/hDTHTMEEqUGLVqt9UGFj+yoTtBtvb+6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455502; c=relaxed/simple;
	bh=0SAsV8xJ0vAVqTm8RfRmM5IVxBUAgPWdLDAkh1FAPkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sjg3YmKfuNHPP47ExDUNevPEldvk1zauf6zrJJuBjqquhuenUBgukgk7HgmxqRjI+xfpthyH1F8jOoCIFgZb5yG0qg8pdBoxo42UohYj7vkcUyWxQETeNFQZhDcNyc0uRGHlwwGwDb2iqVGU7gycgOStlXCyxMq0sjR2R1ABmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ5wFG4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A941AC4CED3;
	Sun, 24 Nov 2024 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455501;
	bh=0SAsV8xJ0vAVqTm8RfRmM5IVxBUAgPWdLDAkh1FAPkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZ5wFG4qKq2QtAUm2lsZ1WxjsUIZ+tkS3I6cWuwhzESs6+hVzO8pMugNXQjTMAXAr
	 5bkhC8qau1SMVXdjoP3OsqPcJqS0cxxD8Rizk15RIEshCGylCRqRPYON8pBXKCbvu7
	 OsXCNvbmbJEe3+fDoE3vs/jABZSDO+syIkxj5gl/1Zu8cd/Q/FtyBmz8TGepGvVK8+
	 AyAJpdJ2mk5d401wTm1lzr5JlxmNFPYgseCIUlC3nWSP3N3WLSkxV57ex/aYSMGOZT
	 EQ570MptWHMJAtiCGnoEt+T5dHFf9eVwq/I618ymX/2l7OJ5OmVFkz4PXA4BwhW+dP
	 uZG2PUEFwZ7rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	stas.yakovlev@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 087/107] wifi: ipw2x00: libipw_rx_any(): fix bad alignment
Date: Sun, 24 Nov 2024 08:29:47 -0500
Message-ID: <20241124133301.3341829-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 4fa4f049dc0d9741b16c96bcbf0108c85368a2b9 ]

This patch fixes incorrect code alignment.

./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241101060725.54640-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 48d6870bbf4e2..9a97ab9b89ae8 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -870,8 +870,8 @@ void libipw_rx_any(struct libipw_device *ieee,
 	switch (ieee->iw_mode) {
 	case IW_MODE_ADHOC:
 		/* our BSS and not from/to DS */
-		if (ether_addr_equal(hdr->addr3, ieee->bssid))
-		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == 0) {
+		if (ether_addr_equal(hdr->addr3, ieee->bssid) &&
+		    ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0)) {
 			/* promisc: get all */
 			if (ieee->dev->flags & IFF_PROMISC)
 				is_packet_for_us = 1;
@@ -885,8 +885,8 @@ void libipw_rx_any(struct libipw_device *ieee,
 		break;
 	case IW_MODE_INFRA:
 		/* our BSS (== from our AP) and from DS */
-		if (ether_addr_equal(hdr->addr2, ieee->bssid))
-		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS) {
+		if (ether_addr_equal(hdr->addr2, ieee->bssid) &&
+		    ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS)) {
 			/* promisc: get all */
 			if (ieee->dev->flags & IFF_PROMISC)
 				is_packet_for_us = 1;
-- 
2.43.0


