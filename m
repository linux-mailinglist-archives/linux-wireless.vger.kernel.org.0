Return-Path: <linux-wireless+bounces-29633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C42CB2A4D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C2330CFA31
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0093261B9C;
	Wed, 10 Dec 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aOf1XUjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133F302171
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361563; cv=none; b=CTRpY49AZhELvYHo2y6Rx+k2tRbgkNs1x84QpDzX14GXGp6nwQNH4nfupA802m8+kPimC28veVk+8oyYcjDjOyiLphJ/ZyjYxxTrlATVoRm+NCwYCYsJOjyBm+XAykFkxa2L9rG2g2DBCnq024wSwZfbs+KqmN009vBHDqZlVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361563; c=relaxed/simple;
	bh=1g7Qby104a6heJFCreeSktUfDMvnZdKN/c8fq0Qp8Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okMGdL5u82xmfl/MDdJ1l4QcMn9Ovew6JNnqlBySO+RSciLXUmgB8ET+HyVt/4mViK1SIKNPPpHgrWNBia2J0waxJjFpGAjqWbHHXjndRyD2XGs3xS5HLvzE8gWyO2d4eJFnj9Y3yPJjMNWCW2RoLzYDyYpIW4HmTgVY1ENT+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aOf1XUjK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso3729915e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 02:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765361560; x=1765966360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2kuC53OjO9j13W/YXrHIsPq7yVK6fj8/acHPEvVHnI=;
        b=aOf1XUjKuBRAOFfxjOf/qrbtw627Q6fX1YMVGlMdn+VuQQObNAPMjiCNVc4P+Wy7Fj
         lXgo9qn6G3BuWujzxEbkvLxcjvlJTHE+//ac0pT/J/iJqGSFqV7xNrdzOxcHjP5lb7Cl
         UEa/i8HquMXqDrOK5jXqTEQpPA+2Kp5zxjoCAwAuYD+Q7CAGkCE0BwgKNGICmw7iy24f
         cox3kfUo9MYcG9rjEXo4nR+I/oj7XkuUaaKo4tK98KfRfPaV6szboQC8LggkQHnk8qLj
         8pm10+XRpAh6Ib4ecssZZ8PLwtgwxHZU7aveKFQ4wH04DJT3XBJeWm/h8GCJVqv0hBiq
         u9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361560; x=1765966360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2kuC53OjO9j13W/YXrHIsPq7yVK6fj8/acHPEvVHnI=;
        b=JylkBx34ud1JDN/VrV2RBOL4JJkxGnW+bU0It+C7mFNDrqTEmMc8UxDEJgZTiFaMFS
         PdJldTn3CdUuAcl4JHyf3oXrsClEOjHa1i2BPYqaFRL+6xLNwNYd4r7Cd3iFGW0kKh7d
         pJ1MwNh7SfKVJbxusGyssZYz/g1PwmHG4GlpNopAPW7oqEmYudVhwpzzY6pWObfnZfme
         C3E2LhAf1EzhCZe08GYNBImj3wDz9Ajkrapalo2jcHM9wYswPUm/GY4nYO18EpPnVwQ6
         yZLeqT0WqAbmO4Ry5XVy5TVKdbWJq1JNjabkOZa7Z8sPUzModiavQwVUnne2gkf+8hL5
         UGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6fLJZ4D7H55hAeRmsHV3E0sF4nepy3kdoORPNp6F5n6e8zwhlL+hNy4okSNTDLLTW6eVCEExxtNf3Gl0oYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8VajyF7CQc2MLbvEmltwgRqwSJtqESIARz/ddCNxyzvI6bn9
	ZFpKeIVy2d0mixfDBCI4xmPWSi+hyrht0nNbULonLp+bN0swJIicR0W4AY5E2ZAYo9w=
X-Gm-Gg: ASbGncvgVnOZ2B7fnS9O+dTuAhndRfP4yq2QUcOcsgclMpo1YITJ40TYGDvbizckWtn
	NedEw45bO/FfZoE6mAKwro81vLJpy6ZqkLvrEJCL+BVHOqu0xOZtgJ0o8Tm575Igq0F2CvaixH0
	fslVmHexbTw9Y9uKcBLi4z3e76UD0WzmPq6DrPK2kdpEol2hW9V/Dka1pPNjnhl3TRvvs6Lad5t
	dF92QHZM+49ibo+l4SxrkTskqfHn7+0ydlMO2iWHRkwlJ7+1a9OBRa4xISvD0Rh1+X0KTm1ZNUs
	6rVH9DuCInttmaIFh8bdaHdRZztodKJWSSeczIc6PsGgEtl4pAns+TSeZmDPzJGN987XbhT2uGx
	kZP4DZ7GMlYmdcCoKa7vX0cPqytrbeAhpkVQbWWFC8uVUD2Jxfw1XnhVCzS8MbJIHlNKz6iMCec
	Z0IhLlmjvrn75gee7HitMS7sYGYTrtR2SJZ6A=
X-Google-Smtp-Source: AGHT+IGLEWRfVvnzmQMMySfRIGuZZjUtf8UteCnWxLO7dBRgBuDDezKOivFPQrfEZM2rEqBbPvFe7g==
X-Received: by 2002:a05:600c:1550:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47a83934ce5mr18357655e9.14.1765361559691;
        Wed, 10 Dec 2025 02:12:39 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90fdsm35406559f8f.3.2025.12.10.02.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:12:39 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] wifi: rtw89: add WQ_PERCPU to alloc_workqueue users
Date: Wed, 10 Dec 2025 11:12:09 +0100
Message-ID: <20251210101209.47176-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/realtek/rtw89/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index d7d968207a39..e77561a4d971 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -620,7 +620,7 @@ static int rtw89_usb_init_rx(struct rtw89_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw89_usb: rx wq", WQ_BH, 0);
+	rtwusb->rxwq = alloc_workqueue("rtw89_usb: rx wq", WQ_BH | WQ_PERCPU, 0);
 	if (!rtwusb->rxwq) {
 		rtw89_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
-- 
2.52.0


