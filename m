Return-Path: <linux-wireless+bounces-38129-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gjqqDVcePmouAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38129-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:38:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 996376CAB18
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:38:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=ctBha6bD;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38129-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38129-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB4730ABF2C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9313DB337;
	Fri, 26 Jun 2026 06:32:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D53DA7F5
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455543; cv=none; b=iLnK3h5PDQxBjUx2qCPOLwTjooNyQaMhCFUendANP16IA3zzZxHfoOVMo7osPCpl2S6/7cM/hsr7PP40SrViS9Vln6E7vNWqm73fCJrGRUnt9Wh9Lea1ckI9JJktZVft3w3WXIt8/z/HypDwqLUaGo8UCdqwwyI9hWnKtKfILvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455543; c=relaxed/simple;
	bh=to6np16T64xFNAcW1qzYMMT0OV6KhI74RWJmQ3sA+pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxlWztymoQCRi7cHRTem1htHcMNb3bPXRTdfEjKmNuxI0Y0f18os42VHRj/nuPCqwdnknTalMU9gfxVbGNqwj15SseIpTjufKKJSJuyRn/641Qx7koauZRKebaFLrr+Nvusy/qsspNYJKHBmbLPrT14/l1yc6Oftozw6DME/kxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=ctBha6bD; arc=none smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137eb0d76beso919388c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455541; x=1783060341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Yt3MQQ7QZZcK6xo+vjOf0BGbRsje849ZFwtZL+Kfg=;
        b=ctBha6bDaJOJGGZopMqMNXTetFOuGpGBlUwqFm1N0dtr/6BdMNPHKLF7QhQd2p5yVT
         7ensBuMPFiFOa6GenJi2w+BLyKOkK8K65DylkB54SDgEOn9P3Ps0inXH/rophxM0wvOP
         NlAzHgpksyAGdzWDlDL5qrykHrSZp/dVmkg8a8y6z8sj514H3F6xjsT4gOgSiBP7ZwA4
         XXApEvRWpgePxmVk1/QjnJZLIYGuzqbiEuX0beiP0jHp2IeiCnSrt8DCJIjIXEuzyoSl
         C9y9/LUP1JbA5sxTUEH8HcEHkBS9P5j70h1PDxxBno3aSkYqhDm44VtAkOMdIVXXdsDr
         rzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455541; x=1783060341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8Yt3MQQ7QZZcK6xo+vjOf0BGbRsje849ZFwtZL+Kfg=;
        b=KqcyhHikk//DPEWjSN4KBacu3D9VV6cn50/arzMuWUyMj5v6dWQwANLk4ARcetC/CF
         ALWoQPKkwakR27dywcZGK+p/o8SqCJrZ69Cf9fp2aXgwb+TiTaUbPRtXe0BlnHj29/WT
         n4o3xE2ALKUp7+EfibO9CrLE85n0578w3YK3nwvDvkkyehoYhRR1kfLS2Y7FursXEthr
         mtldx/2D9EtgS7TXX1ITTY+4QpyxM+YMg3JBebJU7EumtinUTFqMO+hHPKc9qArrR9VQ
         LSUgW2SB0Nm9UJDtMeDWlxOvMYWq0bGnilBcYhy49faCSn+9pfVzLLYD78oP4TaHyeuz
         zUcw==
X-Forwarded-Encrypted: i=1; AFNElJ+EO2Fa4dQ0m9CAS43xVOL6i2HYs6+9X5tPQq4h0BPwYku50B5Ey49l8UU2sQM6H+DXGZgsHWgA9ECe5N9DXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Yy6MTDNPI3+/BJTkBlMmmrRbAcgKbAi2w2c3s1lXVX+W4wLd
	0qCEzPtyaXcthFBChOwW9cFO6Rl6jCpPQZxf6HFfdfFw4zHfcrLCmzIFt7XGoeTCa/2WrlTWjKA
	2ngy+5lo=
X-Gm-Gg: AfdE7clEE/NalYiBUkR147qLxzaqsF5C/vwJfg9hp0WTz5zQrV7FRHkZfguoFuKT+EG
	c0G5NBjeuQfffTzJRVhL5ZWicNmgyaAp+Hzgv6R+kKv1F1wv8byu+tdLM5/tSH8B+r0z7velmPM
	K7RZCuD647Bp8OB9qbl9zJyMqXb66Xk1DBosJvEeZA1HEK4pfUqG3+zqn0Yuw89z1NajZYUMe7B
	ZHSusqex5ATE8K/YrggHz3azuSePHR62F26/TqerME5DSfQ8LkfssISdyZevYe/+iqXq7Io+U34
	DKoP1IOu8RQR6OcQiCNWPe+fUn5axCQITRz/iAuigM3V2EcwTepGdC7gSbjkmJl/IAIZ1zstAcY
	ihGM0ET1aSJGA0ehoJnAY6ftW2VeJRJ+sMcjqjATyAFqMqsUb5I7A3nqBTsKrJ6Xyn2uPWLN/uF
	XtDIkmFV/n3Rl1IiYuyB01P3Jj1moewg+FLDeAon2S8mJZJ4oXaiHv4IqXsAYoogLcIQrHJieGh
	P+kyDhWcOgf2rOQOW+bN2rCy0Ic3YM=
X-Received: by 2002:a05:7022:686:b0:132:d1d:ef5a with SMTP id a92af1059eb24-139c3cbdd14mr11306034c88.12.1782455540868;
        Thu, 25 Jun 2026 23:32:20 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:20 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 18/33] wifi: mm81x: add ps.c
Date: Fri, 26 Jun 2026 16:29:14 +1000
Message-ID: <20260626063014.1275235-19-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38129-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,morsemicro-com.20251104.gappssmtp.com:dkim,delayed_eval_work.work:url,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 996376CAB18

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/ps.c | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/ps.c b/drivers/net/wireless/morsemicro/mm81x/ps.c
new file mode 100644
index 000000000000..ab67823452ee
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/ps.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include "hif.h"
+#include "skbq.h"
+#include "mac.h"
+#include "bus.h"
+#include "ps.h"
+
+static void mm81x_ps_wakeup(struct mm81x_ps *mps)
+{
+	struct mm81x *mors = container_of(mps, struct mm81x, ps);
+
+	if (!mps->enable || !mps->suspended)
+		return;
+
+	mm81x_set_bus_enable(mors, true);
+	mps->suspended = false;
+}
+
+static void mm81x_ps_sleep(struct mm81x_ps *mps)
+{
+	struct mm81x *mors = container_of(mps, struct mm81x, ps);
+
+	if (!mps->enable || mps->suspended)
+		return;
+
+	mps->suspended = true;
+	mm81x_set_bus_enable(mors, false);
+}
+
+static void mm81x_ps_evaluate(struct mm81x_ps *mps)
+{
+	struct mm81x *mors = container_of(mps, struct mm81x, ps);
+	bool needs_wake = false;
+	unsigned long flags_on_entry =
+		(mors->hif.event_flags &
+		 ~BIT(MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND));
+
+	if (!mps->enable)
+		return;
+
+	needs_wake = (mps->wakers > 0);
+	needs_wake |= (flags_on_entry > 0);
+	needs_wake |= (mm81x_hif_get_tx_buffered_count(mors) > 0);
+
+	if (needs_wake) {
+		mm81x_ps_wakeup(mps);
+		return;
+	}
+
+	mm81x_ps_sleep(mps);
+}
+
+static void mm81x_ps_evaluate_work(struct work_struct *work)
+{
+	struct mm81x_ps *mps =
+		container_of(work, struct mm81x_ps, delayed_eval_work.work);
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		mm81x_ps_evaluate(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+void mm81x_ps_enable(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		if (mps->wakers == 0) {
+			WARN_ON_ONCE(1);
+		} else {
+			mps->wakers--;
+			mm81x_ps_evaluate(mps);
+		}
+		mutex_unlock(&mps->lock);
+	}
+}
+
+void mm81x_ps_disable(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		mps->wakers++;
+		mm81x_ps_evaluate(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+int mm81x_ps_init(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	mps->enable = (mors->bus_type == MM81X_BUS_TYPE_USB);
+	mps->suspended = true;
+	mps->wakers = 1; /* we default to being on */
+	mutex_init(&mps->lock);
+	INIT_DELAYED_WORK(&mps->delayed_eval_work, mm81x_ps_evaluate_work);
+
+	return 0;
+}
+
+void mm81x_ps_finish(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	if (mps->enable) {
+		mps->enable = false;
+		cancel_delayed_work_sync(&mps->delayed_eval_work);
+	}
+}
-- 
2.43.0


