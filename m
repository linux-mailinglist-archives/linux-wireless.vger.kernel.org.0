Return-Path: <linux-wireless+bounces-21041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14787A785E8
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C7A16D9A0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 00:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30126C8E0;
	Wed,  2 Apr 2025 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="xY361tET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4C1853
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555315; cv=none; b=VYS+1r9pjWZJRgeOYNfNOy58+hSs2Huvon2K9b3IJicFDrNAx3/r72WCFP88t7/doq2zQG1W9jtPYlCwWYWruZ4pq0RCuKZ+ruM8AMz9OKxurNlSevddoElewp1YJGxX50pw5CXtEkj2fLupuYoew9KNetONihLynvEnHOITpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555315; c=relaxed/simple;
	bh=vcbb/N719SqerjnEgmY492MYanRbJNvTR7pgs9UQi2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ/grpZUJ5lV3l/M8biSDeCDkdhGWI4rgrIQsUF13tXscuY+2hu6mVOzmrmyb/VGzq7DYtz88HNvtQ7IAz0j2GMfW1oi+VSlwz6ybxSefZZTQqXbWXLgrlD4YvXz3OLlBAR8u/F/ibG1h+59iG5eKBSDSkSrtq3ADDt3OeI7pkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=xY361tET; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 1C53160A06
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 02:46:23 +0200 (CEST)
Received: (qmail 23180 invoked by uid 988); 2 Apr 2025 00:46:23 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 02 Apr 2025 02:46:22 +0200
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] mt7915: mcu: increase command timeout
Date: Wed,  2 Apr 2025 02:45:26 +0200
Message-ID: <20250402004528.1036715-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402004528.1036715-1-mail@david-bauer.net>
References: <20250402004528.1036715-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=vcbb/N719SqerjnEgmY492MYanRbJNvTR7pgs9UQi2g=;
	b=xY361tET6zI12Oo5cMJrqCzaecMWF2wZfEmGKrdaOiWA8pN9bBNW+E/WtSlYfWcFnfL0U/Dcjc
	82GaoEQnAgqrDaheMTPlOfAQDeomqdZ0bOieFeWmb5h0gECxR+XWDZ3j18cq1QaCOhrcBy6mb8O2
	ZpJ7/7CjAhb8qeuOBB2BJ1Mi5aWmrVJFO/HbIWbBcxbQ3uyAccltFSBBOJoIYcbKeaCTIyR+jRL7
	YJ8hhVzgmy+BXshHqgTyAYBmU0Er3bniumqQ6aak6TNJWUdmoXncgDdf6ttFr+6wp1h+a/DdI/zT
	JBtmFU5H2XMEBiqBt03RTZ96XYYOsyOjwxbbe8iXs25Ff9aFeMkote9NxIwSjoCymmx9/27oCJXy
	dJF6dnRZT3fsEOdVleSI/XR8kyC8I/WBqGk+DOUjesS5lVYrgRhlZ6rw6ASpo9G4JUF2Ha9ZFWIW
	OtIUFikYak9Q6tj1RL9cfcem+/+Ka0+/NOjdv8t9ekhLZKNaxg9V2Vw8SnZ5cC7lo6NnQXHu2joN
	Wbe8/Elp/yi4sqTtXiZHhNmovvmSQZ8DJ01p3IPG0oUpItV/hMQ7TY7O6vjmmQWLslkgJ97Sz9v6
	OM06VRh5E/UhzSR2VO4cwZLF9aj2tML4p70zeb3FbawG41p+rCUO/5ELJWZA7wda9u+SpfyQze1G
	c=

Increase the timeout for MCU_EXT_CMD_EFUSE_BUFFER_MODE command.

Regular retries upon hardware-recovery have been observed. Increasing
the timeout slightly remedies this problem.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c1c5afed571f..d93a72d0a78a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -210,6 +210,9 @@ mt7915_mcu_set_timeout(struct mt76_dev *mdev, int cmd)
 	case MCU_EXT_CMD_BSS_INFO_UPDATE:
 		mdev->mcu.timeout = 2 * HZ;
 		return;
+	case MCU_EXT_CMD_EFUSE_BUFFER_MODE:
+		mdev->mcu.timeout = 10 * HZ;
+		return;
 	default:
 		break;
 	}
-- 
2.47.2


