Return-Path: <linux-wireless+bounces-29161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA89C73456
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D631D2E8A7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC942E2F14;
	Thu, 20 Nov 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WTqg4dzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C6217F31
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631936; cv=none; b=MZsDgEMA7q56g76k/QdPOu11FYrcXt6I98IEDu63PljPPbG8DoXwS9lAfTMKOpYDKtjE0s54aDLVcXBylUCQCmXB1z6RvrxwHUGM9yn5a/XfkLutu1F5g08KGwSxtzF7Yq+nMqtY3M9CHUK922ME6ryEH5GuKuvyJ80XrSlb6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631936; c=relaxed/simple;
	bh=5XPPGGBoCbHGefEO+FRoaO6DX20WPtSmcpQHNUj6x+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXPG1SvZH7GtlFOvcCvZDUGuoz7e0nPWhc67UByF++qb4v029nXQZxa9TCN2Z1TyA0YfOSomikYHXwqqpA5ZCMv5WEGaB/iAge0eWTy3tq6OhEa2S903dy0/qGFq+R4G7l5fwYEDq8VrCslFl5EI8tWUP+7xt7YD5jKO71PJhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WTqg4dzv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so4328095e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 01:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763631932; x=1764236732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zjA/VyTqMIsiRf3epsUZxITmAB9n8+/j+Xkg9KSAtk=;
        b=WTqg4dzvx8+VTV9rYMreSwT4fyBFq8pngHhlTik4A73bwIEgkeBLqL6uLmyWYmqRfE
         P1HwmvKbbq3p6LC2S57XKlC9DjKKDd0rTfhlAMwWgvuuapatggi6s+64kPTXEr8KUuOB
         PW1fEiflD2LqPZnAi5SsI1O18ZbqVg4Qj6iFTTKTxUXFyfp+QUtrmzKDJ8nj/As09A2V
         zdhFhNTzEqJD/x19dNWz5RaQeeDfGyynX1YdlT2+CsdKEASpjlyQuaJnjXla+LStJkTt
         CjYf++FcSElTtaWC3nJGrpA9qtuv5Ldbf4U0qXuTqYBT3PAlDD3gmedMJqDV0Hr4N+mK
         X+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763631932; x=1764236732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zjA/VyTqMIsiRf3epsUZxITmAB9n8+/j+Xkg9KSAtk=;
        b=s/Py2JauyTg3rXQfNvKyekjfyJto1CidsgBbcTZeFJNMkbJSTZ6VcL/r8JMWqGQiAw
         OpWXViH+srHnuuLzcuSve9TjQxqU17TzntGdVYq6+8qqlgayeBwX08WnmfXxbL4/tNVx
         hr3kzI7Uuatjbqj92pgEvM5i6pvi3buA95QFFmeKG3aGItmegM1MCPifSzw0UCQgt6pl
         RA+uF8bYNsqhBUu3in35nB2wKPG67Nuypk99l6WUpc83diUFYht5Ad71rVoXllCy6gT8
         PMBhnSQmpdH591cUVbGXUSWwUKr2YDY7tXztbwoGczXGCm5oXoCWz3UyINpAWSDcZRx/
         klfg==
X-Forwarded-Encrypted: i=1; AJvYcCXZXHaYiJtzHXDD5vmOz6G9CVzXOg/y9npyb21UvUNZ0qDVJyBbZM5D+2K8w/a3VPbgcoSxv1EgU0rvvbw80A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zk/G43SJI13gyO6j2ceLlGE0+afPsPXV4UN/nCfALav8URIY
	gcpmpokcuOCkVs5QeimT/jju26nZD1oi6QBCdIhSnzBxBkPNRI0/ZV+h0Bcb1kP4RL4=
X-Gm-Gg: ASbGnctD6gemPK/76mQM4/itJ7wBsO6y1DAk35jxwwhHtGqFPioyqswcN/WH+xqRaIu
	XmdBLzvB2NbQ9IC2p9OWmZ1r3ronR+a6sX7NQOHZ+aJx1CrNQQ44UjBSP/EPDLKJBfDq3m332gA
	P1jfVoXMGKuy6ZWRIKBX+Cn6LwarEkha5DsDMiHCGfvTGWrvx4nDJDlyh6iNhmFX1jk9XxTfvtZ
	AMahvdpG3gMmPSxVq23Exwbg1hDV2ApUmD5XJbImuSZD18i2hvW6nGTULu3j2V7nvquYZT1tZZK
	kObPrd+JCwt+LD1pKsXy50mTH9+1ZqzVD1djIg7PPSjmeV4BPnMuca0L2eIhyxCSTBJL2b0ds0H
	qry28M8ycpZe8vwL/XjFpMdYlLNtwgkgIZd3XKZQ5yTWeCKPvAEZrhR3aDacTL/SK0pB2pb2FLk
	8tJqalkBPFyItLoBFRVupHl+92iXO3bHATzzc=
X-Google-Smtp-Source: AGHT+IFhYm/siJFOPAjAq/6cMGu7T/hopEb0oUxkkJZQIc7Xz6aU0nuhBE+FQ85paMwyFHBCDL8XFA==
X-Received: by 2002:a05:600c:1d20:b0:477:7b30:a6fc with SMTP id 5b1f17b1804b1-477b8aa06f6mr31942855e9.30.1763631932409;
        Thu, 20 Nov 2025 01:45:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9739964sm63030145e9.1.2025.11.20.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 01:45:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>
Subject: [PATCH v2] wifi: ipw2x00: replace use of system_wq with system_percpu_wq
Date: Thu, 20 Nov 2025 10:45:24 +0100
Message-ID: <20251120094524.45264-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> systemd_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 215814861cbd..c7c5bc0f1650 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -2143,7 +2143,7 @@ static void isr_indicate_rf_kill(struct ipw2100_priv *priv, u32 status)
 
 	/* Make sure the RF Kill check timer is running */
 	priv->stop_rf_kill = 0;
-	mod_delayed_work(system_wq, &priv->rf_kill, round_jiffies_relative(HZ));
+	mod_delayed_work(system_percpu_wq, &priv->rf_kill, round_jiffies_relative(HZ));
 }
 
 static void ipw2100_scan_event(struct work_struct *work)
@@ -2170,7 +2170,7 @@ static void isr_scan_complete(struct ipw2100_priv *priv, u32 status)
 				      round_jiffies_relative(msecs_to_jiffies(4000)));
 	} else {
 		priv->user_requested_scan = 0;
-		mod_delayed_work(system_wq, &priv->scan_event, 0);
+		mod_delayed_work(system_percpu_wq, &priv->scan_event, 0);
 	}
 }
 
@@ -4252,7 +4252,7 @@ static int ipw_radio_kill_sw(struct ipw2100_priv *priv, int disable_radio)
 					  "disabled by HW switch\n");
 			/* Make sure the RF_KILL check timer is running */
 			priv->stop_rf_kill = 0;
-			mod_delayed_work(system_wq, &priv->rf_kill,
+			mod_delayed_work(system_percpu_wq, &priv->rf_kill,
 					 round_jiffies_relative(HZ));
 		} else
 			schedule_reset(priv);
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 24a5624ef207..09035a77e775 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -4415,7 +4415,7 @@ static void handle_scan_event(struct ipw_priv *priv)
 				      round_jiffies_relative(msecs_to_jiffies(4000)));
 	} else {
 		priv->user_requested_scan = 0;
-		mod_delayed_work(system_wq, &priv->scan_event, 0);
+		mod_delayed_work(system_percpu_wq, &priv->scan_event, 0);
 	}
 }
 
-- 
2.51.1


