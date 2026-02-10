Return-Path: <linux-wireless+bounces-31690-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMORD3cDi2kMPQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31690-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:07:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BAC119699
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545E7304AD92
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB724344D8E;
	Tue, 10 Feb 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DCvLrc4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD32342534
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717833; cv=none; b=Fvgit+Rg5JLAdH2Lb/9ePlstgT+qHJXawI/tRV+f/fKfG0AhHrT0auwYNiCymWMH2Wqurvjm/XaX5ODDwChKD1PauuRRgK3D+wV2VD5sIjADNOl2/s0TnAS02q9ZT36oqFmPj+Ug37GuvNdTt2PzAzh5fq91xqKdEgaGp7l96xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717833; c=relaxed/simple;
	bh=S3/6N4SOvYS7aSgee11rTdBONAdaMtKZy4RNbCy1m6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9NV695TXOoxAV1meRH5JDTLw6qQAO3JlEEwbzDhZ7n1dkncfSSKhbn6SSnvh2s7RW/JK/z3oc1r0BZnoT1HUbY523mtyP3rTxXyuLmARbdE+jtAcaQu4YZHc3K/SekeI2J0RXBVkJmsxB7VS1kW3J9g0f9RmGMkRPiG4y6fkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DCvLrc4a; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a9057b2ec3so3139625ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770717832; x=1771322632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHVJixIP8UMg5ol65T77X2qIxHiSjwoDF2HJwmtsqKc=;
        b=DCvLrc4aEFMgnfaavDU2YF9duTaekLpc+xreI9JrZ7h+AmzN+b4wi+w/lBNGhBv3kM
         kmdEmiTWK2fS1z3YMMMz21iswccMwhGX5noPOYVqn4e32I8UfPkwq1larRNjMttQy2bX
         gPtqmW+fY+1D9JFH3qOd3EQausw75b84GoITc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717832; x=1771322632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHVJixIP8UMg5ol65T77X2qIxHiSjwoDF2HJwmtsqKc=;
        b=rEgsSTOtm8x/jF8jtEUL3uxmR9OXMaK2DPz2nt9yR9RieRko8a0cXcm9FahWqZgXjT
         pUdXlFGzGLHVUbeQzhk3hnYOsWvMAmEKMag/ANGrIJGubM8OnAlctDZrXx9BjmddT9c9
         cffyajcRvRP+y0SlvxQFXT+T5t/ckCm1wU8GXG2D8Gh/c3Zda6cIZbDah3dCWgvHzCfe
         l3XBivhYX1OU+VfsuABmqtiykQ8Wvx6+PvG/WTpLeRkymFy+c7pr9q9qmKawz0e44Y7r
         2NzcYBm+OPwfxt67cr0H7hgj+lOwKpCQivQILvNpPjcpEv6+xK82ROvglznlKDlNnVSc
         0oMw==
X-Forwarded-Encrypted: i=1; AJvYcCXlIeI4ZYQrkSSBWp+VJfWu1Wfp8xoxuXYOEHWND8ZtuT5GkrwSoH+H8jZnI6tT6A0XB5K0sHwUjjXyXRvb2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZhtRQC7KDLRjs0MQNvTFrbL6BOQf9lgwnJsdpz6hTqDEBmZp
	2G62NLX+/sg5xD1TjtFDadgl6XaUeG6ZaA7wQpNjkIG2YeoIyKL7CJrx8VlFaTCOuQ==
X-Gm-Gg: AZuq6aKXhc8olqxN9B3if46iFFPoSQ2rDraCaVY1J0M7ubG/DRCBJFw9PYSHv7JNseT
	OIeen6TNA28dkeV2hBVtT+FbnX8zEV7LQ5vFNF5F4aSrTUIlCsNddVU22eEQi6KF0vHOn9m/Jkk
	XY62/Y0ZikaNlPDmWfgeXlrrnSfiEgroPPi6Z4hufS7QlKx9u4GkydOrT/tenb72WycXEPL7Ogm
	YNCGykKa/VYASqO4zQ+kqsVuKWFVamKwpmYtKrbqLtRMvS5/inO4T4fEgzooobzR9VHe7xkePTO
	kRd7RTlzW2cD73ENufiHqMaoJbF41dTW3Ji1Utik5N7Q0Gm/JDjkliwSeu4MjiPb6+Xf5pWCwDX
	S3Ly4hkUdGIxQch8jzpu5AXb04sqDfnTl4LpsWaHx0cWswsUCUB3QeVm46iUMz6zclHgjfOgy+p
	Cgr02m4tP2ViTjM4/Q6d1gJeHDhb1EqMpvBcU+e6U/QI/d/zvjg9SN/gPM2b3/cvHP0nbqFVgQz
	+JHEcEi
X-Received: by 2002:a17:902:ea11:b0:2aa:ffa0:4454 with SMTP id d9443c01a7336-2aaffa04758mr46974475ad.31.1770717831890;
        Tue, 10 Feb 2026 02:03:51 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:822c:995b:f23f:e04e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a636aasm129318065ad.12.2026.02.10.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:03:51 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] wifi: mwifiex: Fix dev_alloc_name() return value check
Date: Tue, 10 Feb 2026 18:03:34 +0800
Message-ID: <20260210100337.1131279-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31690-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenst@chromium.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:mid,chromium.org:dkim,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 67BAC119699
X-Rspamd-Action: no action

dev_alloc_name() returns the allocated ID on success, which could be
over 0.

Fix the return value check to check for negative error codes.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aYmsQfujoAe5qO02@stanley.mountain/
Fixes: 7bab5bdb81e3 ("wifi: mwifiex: Allocate dev name earlier for interface workqueue name")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a66d18e380fc..bc0a946e8e6e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3148,7 +3148,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	SET_NETDEV_DEV(dev, adapter->dev);
 
 	ret = dev_alloc_name(dev, name);
-	if (ret)
+	if (ret < 0)
 		goto err_alloc_name;
 
 	priv->dfs_cac_workqueue = alloc_workqueue("MWIFIEX_DFS_CAC-%s",
-- 
2.53.0.rc2.204.g2597b5adb4-goog


