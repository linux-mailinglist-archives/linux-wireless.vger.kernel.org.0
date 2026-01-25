Return-Path: <linux-wireless+bounces-31148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLbrKzBwdmnyQgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 20:34:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F07823A1
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 20:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 063F430056C7
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB612F60A2;
	Sun, 25 Jan 2026 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="yWmxOmuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6D2F5461
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369414; cv=none; b=fWNrb7ayX9TOMABWcNC7t7PGYrkDE4jsuhNGH2RNjAuk3hIVqcddKZIyVapCzfdtiKeZt/BBt1a49FQn0izs2vmHHKZHG2Y6/+SnmuNVFSD+JW+MADaMktPyy07HFVaXvS27iYM3NQ3IJ02xcI6C4NHCgTk7MjQno5vvU4EeZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369414; c=relaxed/simple;
	bh=4i4jP7kP2aHf/CxOoLcXrYqiFvB8WBy+y068JRX34WA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KtM1IITjaQU5H+3si/S26WheqQ8zq9WA5KfXB/Tih8j/1kBd0UUFWXWA03/BOb7A27geu/tokY/zCyK0HWGzAhHEE+TQrj9myNrRZKPIUooZXdGCuy27V8RloRActeqVZChgVfS0th9TI+RiuRYnyUN3LDbTtd5DpZ7nBi4sTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=yWmxOmuK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-66103641d76so853136eaf.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769369408; x=1769974208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlSpUCJ3gqRbwg4bt4p5ahC24nJIWE1a9/cK/hf0tbk=;
        b=yWmxOmuKJki10wYruM49zLQUH/uxy77hu2W2vkJpa8PcjhR4K6lvvdDMtQMjiyIHiU
         eOK60rzxKCwPJD2hT9ZMD0c+cf8Hd2/AkXjB+jbShh9dRKCFcVNy4ZC4XkWXb/FDTGpZ
         eEQMqkB+9kQkHo5Z+K7BQ833iu6V/zBUAMsDxA0PkxNUanuMORf1Au2H4IiKaPxQAnF6
         HBGv2MpKfpWSgjZQHgBT09i9cvGLqWQT8nNO6kwW/WbLJajpNwTodn57GFCyHqWx80YI
         71se9HnkGjyVraKOxQZ2/IMyh4xEQrV5lQM9ITpAq/ZILzOrspXVZ4+O3eBoPRQwmRPO
         HdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769369408; x=1769974208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlSpUCJ3gqRbwg4bt4p5ahC24nJIWE1a9/cK/hf0tbk=;
        b=IHLyIJdfGcp/PeasmenZ6R70JEL21ArzuMiHNJs2NlIcKzLOHqq7l/Lmwnc2L3J9Yc
         7EQn/qrKix0OpcCDeBWA1NDYN2S6InkJTTNZoJomiy0C1d4XWxQBnX6aycKPw/iaFFy9
         bDEwsHudEQxzS5Y9a3Gn3fSm3vBydDOVqLXyLvkgi84ku3Ej8q3pA4FFMpkMyJ/rYMBS
         hZb3EiHIwBwoq/97SvZaplGfS0Lv/vY02K1exbWyZUdqbSDKWJfiMx4D49RSLsknpVDI
         inhzkCc3sIgGEt9Yp0ikrEM4fuNYlV+QpUlOwam1aw5cyKBx1P7ezNJggAW7inUsezjp
         7Zsg==
X-Gm-Message-State: AOJu0YztY+ANyClcnmvq8MOTz6MQI1l6W1vW80kl3BnczzzlQ/i6e32P
	1ngXc6W3WP2+6mGjsMmLyNzpQpw8n/n+7gCmsJFdp5ynd8JyHv2CzMdFmJPoepUNWkHdJps2Mle
	YHoJE
X-Gm-Gg: AZuq6aIPDN5muLZVlf/t8APHUtoh45fFPmxHmRwZlwl9XeHlSFjWFgCIDVjhx5WwJCh
	qrvoyhmypFY3tmcNh//LeCCV59DWjRDy/vaNoELHMDxrHW3bWr9Pc1KZT1PwGDHE2HkEc9l7E6A
	xTljog9C1dwRYG5WOvscP/3y9Rm8ndvB6/C4CAxJBsrch0zNYKH4dOVXbxoioswx4pmzCbqxlOA
	ADOJsxgAMX3/PFXDTmwe2kQefQ1MSyq/BDMgKpzmxZPavbDheYna8tKGnC2qbU6U49hZX6Wd+nz
	NgZuuWLflegpbXEKxpVmJ/aM0g9gUAyuw7jMKe2o8ciBLJrG7D+7Ebd5xZq11Vo5UVxGfxzcEP6
	Iax/OPRjnOJUTc+Qf4b2PZr9SzO16dgnFyGl5AtgipWnL5CTzkgvcj4aoDhwjCTG6bQ4t5K2Ytx
	sTDxs3EFAqFKrSw0feXu33R02P3echu6p4mw1cQ3iGurIxEl/9vyIybzcXnpiQyQl2I7E6tZj/C
	AJlNV8zehTG0BEGUvZ2rYRxneLjstk=
X-Received: by 2002:a05:6820:4b14:b0:65d:e58:5041 with SMTP id 006d021491bc7-662e04cca23mr1024396eaf.77.1769369408669;
        Sun, 25 Jan 2026 11:30:08 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb4f24fdsm4320250eaf.5.2026.01.25.11.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:30:08 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] wifi: iwlegacy: add missing mutex protection in il3945_store_measurement()
Date: Sun, 25 Jan 2026 19:30:05 +0000
Message-Id: <20260125193005.1090429-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31148-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u.northwestern.edu:mid,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C8F07823A1
X-Rspamd-Action: no action

il3945_store_measurement() calls il3945_get_measurement() which internally
calls il_send_cmd_sync() without holding il->mutex. However,
il_send_cmd_sync() has lockdep_assert_held(&il->mutex) indicating that
callers must hold this lock.

Other sysfs store functions in the same file properly acquire the mutex:
- il3945_store_flags() acquires mutex at 3945-mac.c:3110
- il3945_store_filter_flags() acquires mutex at 3945-mac.c:3144

Add mutex_lock()/mutex_unlock() around the il3945_get_measurement() call
in the sysfs store function to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 104748fcdc33..54991f31c52c 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3224,7 +3224,9 @@ il3945_store_measurement(struct device *d, struct device_attribute *attr,
 
 	D_INFO("Invoking measurement of type %d on " "channel %d (for '%s')\n",
 	       type, params.channel, buf);
+	mutex_lock(&il->mutex);
 	il3945_get_measurement(il, &params, type);
+	mutex_unlock(&il->mutex);
 
 	return count;
 }
-- 
2.34.1


