Return-Path: <linux-wireless+bounces-8415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623508D7E4E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C903282125
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA97E765;
	Mon,  3 Jun 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="f9nfNXnb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6E82892
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406155; cv=none; b=UbOTpBDTEZQUAq7NouS6cSH65ip/ba0h21k89p2DrJVsubvg95kVshHqoPYMVx76PVdkYFUEYyx5Yyfp8CQoMENXwRtjYpsUYALbElbsuF7kXcIfFel9M85xK7zukGe1iezsJhG8maoETT3ojqfAkiGc0MxqJHH0Rb5+H4Yj83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406155; c=relaxed/simple;
	bh=Om8B2tw6oLgLo6pQmOUkw1WeVfy+tuh0XVXmWZ3xuSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVjOnulnud/a5R1m/zCa+jCTvkQwsgXeAoMPZxZYhJeE7zg4DCx+UK6KL9C0M5HOCGjCpgjJgFC1I4gTUMT4jadWMGBDb0PgwXmEtEk6QJvtfhgkl+oyww205wed+NQYxN/DIcgDLEX9qHhzcTwQvyqIsD+XYAEvohVEaZqunCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=f9nfNXnb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=a2w0z/yBvhC10ZMyIkCZ0cl+k3B1H+tJUlvwth1QMmY=; b=f9nfNX
	nbl81Z6mr7AKzd/YPYUC3rxKgwfWsN67Lh8R2vqKYww5uOkClxOupq5mOozv4Ncy
	1pJ60M+IMzpYeieGhlaGXdBjDrpKwA619I43dK7+Fy5G14qS0/hBv3LJQ087oMUr
	Ki97yUirYSNbCKgayUuIVcxga9yotwtYwITGVXZ38kMjKcm296ddweZChi1JjGrk
	+QbIZJJtZBs0SYSUnXwkgS9OLgAmjYIbwJz1S4A+LBvqtsJLqcYnRbYyESrlLjcz
	A2D8NnUInoF59lsSOEG0VqATUDw43Qy27RTDynx1rOjULt8NKpAfWF/62c72jOMl
	1g6g8n+yQH5e3ayQ==
Received: (qmail 1899381 invoked from network); 3 Jun 2024 11:15:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:49 +0200
X-UD-Smtp-Session: l3s3148p1@5Q1yx/gZIIYgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  3 Jun 2024 11:15:38 +0200
Message-ID: <20240603091541.8367-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ddc390d24ec1..16ab834185b4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4022,15 +4022,15 @@ void rtw89_core_update_beacon_work(struct work_struct *work)
 int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond)
 {
 	struct completion *cmpl = &wait->completion;
-	unsigned long timeout;
+	unsigned long time_left;
 	unsigned int cur;
 
 	cur = atomic_cmpxchg(&wait->cond, RTW89_WAIT_COND_IDLE, cond);
 	if (cur != RTW89_WAIT_COND_IDLE)
 		return -EBUSY;
 
-	timeout = wait_for_completion_timeout(cmpl, RTW89_WAIT_FOR_COND_TIMEOUT);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(cmpl, RTW89_WAIT_FOR_COND_TIMEOUT);
+	if (time_left == 0) {
 		atomic_set(&wait->cond, RTW89_WAIT_COND_IDLE);
 		return -ETIMEDOUT;
 	}
-- 
2.43.0


