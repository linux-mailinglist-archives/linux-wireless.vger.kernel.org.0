Return-Path: <linux-wireless+bounces-15642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA29D7487
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE89C07E0B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270A1E22FA;
	Sun, 24 Nov 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0nTljYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BC1E22F5;
	Sun, 24 Nov 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456287; cv=none; b=DILG8+W7QS3cfHJhjoIq1uCkSbB1gx/hJzP6BRg1CVXAokz068YmJ4gaCKeL5Hd0058344jUqQ9waUj+q/KC746E4MkLbK3Le6D+P5+f42whITkoBsx9JQOKcg192u3SYGROHdpnxpzz5zroxtP4AxTG/nW1t7JvB9rq3zeaDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456287; c=relaxed/simple;
	bh=0SAsV8xJ0vAVqTm8RfRmM5IVxBUAgPWdLDAkh1FAPkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYF7OrsIGsmhT75+rIfgHH+vJttxjq3VtAvR8mZIW3Kr1wE2MIUFaW2mGKeJhYaRko3xEELWG8hR0kvSwkvVl8at2cJLr1K6DE+2B8qcc4RmxHQULH3IDXfbrzBFTZ0tG5D4Cf1dtycUeV/a1hwUYHn0z4zqzapZKzgiTolXWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0nTljYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B69BC4CED8;
	Sun, 24 Nov 2024 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456287;
	bh=0SAsV8xJ0vAVqTm8RfRmM5IVxBUAgPWdLDAkh1FAPkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0nTljYyESjvJd2hhvGdTnTGCG5D0UvvZwT1Q0z8M+pfWaDU6hgYtMQ75TXVd7qPD
	 IlaVOq+aHkVm6lFtxNiaeeynAzrPeiVlXO7xz5cjCjzd5mo6TOqv5kTX4GRIfhmfRo
	 RFd90UPKCGDi78pDHfr4tSd4vSHueA4o6LguhxvEVTZeSSk1q0t7LZex9xcmz9iJdQ
	 DqtVr8CW6gmNGIcXscmg2I87v7jV4JG/VqUvF7rATDRy/GBY/ySwflUoqhIKbrxpbK
	 C1j2gHpYOc9Q5iOQ2nRak2O6eHSJLdJsg34fkUo3FCo42Bp43tNmDFbQfJOONsYn4r
	 rl9RGAIqTZrIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	stas.yakovlev@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 40/48] wifi: ipw2x00: libipw_rx_any(): fix bad alignment
Date: Sun, 24 Nov 2024 08:49:03 -0500
Message-ID: <20241124134950.3348099-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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


