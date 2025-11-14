Return-Path: <linux-wireless+bounces-28965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7DBC5C736
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0B4F54D8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EA3090E2;
	Fri, 14 Nov 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LSot4ffr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C1306D3F
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113846; cv=none; b=CvU1Bv4AVuA84Ew7+Fqr3/48TlMKCm4fPvH4foFd18zyO+uTyzLTzjVks4R/eBs9RdQWGQkCSdiUT3kPYaTSDy5I2bOuo3hHVV1sJbz4RRPNUX/ZNX8zHKlTJaBmpAx0uTTb2a0c9gwqPgjCgu67xlRpi2EURRghuegNezn/RCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113846; c=relaxed/simple;
	bh=PE6VO0uRFn+tr2Xl0ANytSUNsua9pk0mDP1s53cRXBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ytn75EJa91yRwZA34BvQrUmwbu23gPLyf9nDKl8TO5O9/oeqg5cqDhLMWq5xrhl37nBivHsdCgzV3lj84YzHEVO36zHQTJj8nOmP6DXvtvrm9kRZbMp9O8ojZRqQ2k1+v7OpJRQ6pc25bXl4KwS5/IXEGNNcpeskFjlrSfpXvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LSot4ffr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so907958f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 01:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763113841; x=1763718641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1DX+q1uR6gc1I05qlwVA/APKBUcVyv5tREJfQ7NRX8=;
        b=LSot4ffr7zWYNj81nWmS7bp8hKHVFuGPHfWj78EzBfkmrN69hft0/rVA6RCs7Q9Sg7
         X8FRDMyUa4BUk3OPlxr8RXo1kDwiVnYOCthqpCBRYJ4l4YnXt/Val9bbVO4B/c/cpK6W
         V/8hhmYcEz65WbGCLz4jlYRvn5ArSqo7DMnIaoHVmivbwBZsKk6G6Tvd2YnWUYKuNlgM
         Dk2nwjJFe4EeriOrgNolMz/kaHL0xDU1UOSIrQ2LoZkLitVncgXFKn1EQzZhS3B/cfsc
         en/VyITkbj25C6Rz/yk72DAd1Mrl73+GER0rmA5OzxiOAoy3hylB1lFT5VuDAdisqqmA
         OkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763113841; x=1763718641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1DX+q1uR6gc1I05qlwVA/APKBUcVyv5tREJfQ7NRX8=;
        b=SK+OXe+yyC4WQESegbVKUh4N7R9wbBBw63u5lAHR2RF13unQVkyEM7NQmO+xZQjaaV
         gkpvJKwsxYhp8abPPDPh5xwk5czD6X09TnVpkV4P+cFso4zO1Lhd9MoEcKfrZTRF+tI5
         NabpRrOvD958gRp2gWiiIO/oHKN7ZafpuIg+XpVJ7ymqfgyWNfmsXAxuYaSMJL5XEENB
         fqATpiLW7yU63oNqqVCcsv1cddtzqszWed0z0YxeBxjEodSyDMcZX1vRBp6FlFOI69WI
         ASfVy8+H/RMHFoMU+6PJzGkrESUP3EwOV8+jeE+nIL74fZg0pMFH1713RQ3fnNTfEKHl
         OUZg==
X-Forwarded-Encrypted: i=1; AJvYcCVUZY5PRQ7ua763z09DBPqXNuzRRwOplGm0Bw1Lrcx4VZ0ugJWj/rNGDszUo92UfwTrpeBKLenlelDVBool9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZmtmsL0HHwnw7iYSvkZQgTzPFkwd19Grw4UtzB2LaJen9OgG
	2xQ8vBmwd5S9diK1y2bpv2IOtdoIVYB3/c+IzGZcMaeyBTQPzmhaBlLCQL27u2BLO+g=
X-Gm-Gg: ASbGncst04HgLLaRoh53ChjUp8hLOMnDwRahXopgXokAlZQ5C1NlRal2SY97TrYVAdd
	ev3+GsniFI/Qdw/JyTDPf8768rg0IRJ9YXIwRQfcmJzViGXL0ROgY9NTTg5b0LGEKeiq0cHPlsj
	yXMAyszsEQGBcx+zdqHZBt2BfnBrg78bxOmFnAWfwyc/GByC3byXZg4euflRAw97CNV9S6xar9X
	tYiZ6zZGrL2Vg3pVDLPAB9zRvaLwfcCAissDmrT+dkaKS8u72GXWWM2qnCtely9EpEA6Brgekd8
	jhfZtUpgdhQQRTkg6ObxpWRpJe3pbIdDk373mrgkWS4LJ6/pVwsEmmrWFA/oyN9rHAHDAnDeaBS
	mtiFMKF/lv5dy+3cQiyUNyKxRq++EdmN+Utlz5Ql8qve2djWfYxJLvAFJuSsAJRy46AmIGmyQdH
	e0K51zXOilyeHb7/D5f7R0hxkxj/5qqFtnmvQ=
X-Google-Smtp-Source: AGHT+IEL2Ofd5biLRPD37kVecsR8CM9XEJnnBSUCg9QHnFbIv+c84JIR54hworNR47DBLUx09+falg==
X-Received: by 2002:a05:6000:26c6:b0:429:8bb2:d0ce with SMTP id ffacd0b85a97d-42b528147c7mr5981000f8f.18.1763113841316;
        Fri, 14 Nov 2025 01:50:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e442c2sm143853775e9.7.2025.11.14.01.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:50:41 -0800 (PST)
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
Subject: [PATCH] wifi: ipw2x00: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 14 Nov 2025 10:50:35 +0100
Message-ID: <20251114095035.70765-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq because system_unbound_wq is going away as
part of a workqueue restructuring.

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


