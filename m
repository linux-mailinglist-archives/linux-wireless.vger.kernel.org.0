Return-Path: <linux-wireless+bounces-35221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM/JIZj56GnLSQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:38:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D779F448C65
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD21130581B2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711937F8DA;
	Wed, 22 Apr 2026 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKGAJ94v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85313563FA
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875532; cv=none; b=PGcJMYrTiNTyvUlqf84d6xZpooREQbn06y1iOWJFnClbQrs+ZmiaMi/kM5CSszdqz31D98i7lhX2S+RuTMJn5osgg9va6eXQ1T0byYRDQaXs8teKRfO6B+Ul5D6XvXEAYwPTFwuuVEPfXiPDFlz5G/jGk8LpvGm1TZssB2N3Xlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875532; c=relaxed/simple;
	bh=b52FPfruaqC7OkpqGWtNuQPoUbeqJ/xmXVvC+zMc76Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBOQWXCc/uoZPlSLDst4oMvuy+aowNZw9s7euzxo27DG0mVbOW6psHyPyENm9VRw8t9OITZp375Vjs0p2NDOnluvUWXE1G7aR6vV7FRP4zS9S43Bqb0DJ6e2gZbIL2fTNO60Mxb3UMU7nK3yOV+uYsb9EQ6NoUtpx2d+B9xRWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKGAJ94v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so49347405e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875529; x=1777480329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5KzLQvcvG3E9iSzYk3XJze4x7fJp0aGFxlrrvbdfr4=;
        b=WKGAJ94vHpXVjDw1AK8vnQJhs6Xtd2plVZIn7oTtzRfQ20fPmJYmNi0vh6YRI7lPKD
         uV+ETXHTqs1e6ac0QLYXr+WA21cjQ6P1hleMgzz/jN5m8nNpM6yyBh7AZmw+vQ7wsW5S
         PAAEXGzOkVr5W86DOa+0WHZ8cG09E2h1jfC58Usv6ALsKNnlNrOK50Osvv83O/VUByJu
         QhZ/U0p6IaFlD78Pyf4lx9Swsx4pEYA1gbGA+j8Neuj+36rAQQvbfuyp9hhfdPbf/N7h
         PJy5VHkN6sJWcjvtuffsHLu+T09nnuRY6rb5IPbk+2OrvfpV6uMXuzUqvM/aDj+uVHV5
         1tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875529; x=1777480329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5KzLQvcvG3E9iSzYk3XJze4x7fJp0aGFxlrrvbdfr4=;
        b=JwKV8pKRurmXQwGSR9yTwHpy5HoDezLbDlVRA9uVqHc5B4ocXohj3/qTOklR9sRX+H
         f6WwNiVsW5Ns6697I3l7OMSy6bR7Q67z9KywoY4pdT6+f6d1cjui+uZkHJVjnGZlsdVr
         f+6PwOM1w5f8UuFp7X4ssi5eXXMS91IRi/XAi99r04WpRMurxLQbkhyAKKfu2VBp9UaU
         kP2mPnKF5EaMsMpatlN5tiSmKZSpUP8Lugyyw9VwCj3T4zE745ZZD+0+UI9a4VoFn+rp
         uAunc+T+dF9x/9H3mjjWYYrmOHN2V62rx1JUU4JGH4a3AeO8nv+yjf2Ps7YHC9u/4I2Q
         4kDA==
X-Gm-Message-State: AOJu0YxnWO9XawNvEPGyDrN85VOY0GNWQFUJiS+WKFIpA6UenI2ZrSY6
	W6m5R6lG7zNy2/m+NvXz4uHMPiEmU/gg1mnsk02ekiFvq2i9nZtvKW34
X-Gm-Gg: AeBDietYdeg0t2E5lnalSFOiqMEYhcAh2DuFTtTLzn8PoYyRkWHoCwJflt4WJU+eyXN
	ZCoEFvxt1uMPhlGunS2rhEbLBPdGx3AYxwbIlXrPe58stNBJOecrZkM9ynsGoNaG2kN90Zy8/dy
	UA0GoNAIk4zBqi54nBYhL9zt4mo1zSAEOnjWmIDEqiULb1nUHde8cMMzGsy5/VrDhjAnSMFkmWG
	sRjQBvMR/PSa2MHFE3P2m3pWOWp5kRqf4u5eI7axmUMF5nYHF95OZ5a7XKNIoNOqctaDgVvxuEe
	nmWNunl987fuKdpFHMyiRnmo6VUheKyT+rSBIGgq1IdBeokbCh3qovBC9LK2d8MDioO5cIZhv+8
	ev+lusDV0HZue098dRpqErEkQLBXANtihB0N3jb3DzLp/G9FKVclJ8QpPN8w4tyJmyYyjhVyhvA
	Ildb38LRdvjt8vMLxg2WBmSBemiXss1e8qBl4Lk3eCj0Dz5y/0CTFEo59JbnQb+ewNOPU=
X-Received: by 2002:a05:600c:8b2e:b0:488:b749:8482 with SMTP id 5b1f17b1804b1-488fb7469b3mr356008235e9.4.1776875528953;
        Wed, 22 Apr 2026 09:32:08 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm514056465e9.12.2026.04.22.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:32:08 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: unify error handling in some ath12k_wmi_xxx() functions
Date: Wed, 22 Apr 2026 18:32:07 +0200
Message-ID: <20260422163208.3013496-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35221-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D779F448C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is purely cosmetic changes that simplifies & standardizes error
handling for functions that ends with a ath12k_wmi_cmd_send() followed
by trivial error handling. Saves a few lines of code too.

Compile tested only.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 32 +++++++--------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 350f249f5ba6..bfe4af76304c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4199,12 +4199,9 @@ int ath12k_wmi_pdev_lro_cfg(struct ath12k *ar,
 	if (ret) {
 		ath12k_warn(ar->ab,
 			    "failed to send lro cfg req wmi cmd\n");
-		goto err;
+		dev_kfree_skb(skb);
 	}
 
-	return 0;
-err:
-	dev_kfree_skb(skb);
 	return ret;
 }
 
@@ -4335,12 +4332,9 @@ int ath12k_wmi_vdev_spectral_conf(struct ath12k *ar,
 	if (ret) {
 		ath12k_warn(ar->ab,
 			    "failed to send spectral scan config wmi cmd\n");
-		goto err;
+		dev_kfree_skb(skb);
 	}
 
-	return 0;
-err:
-	dev_kfree_skb(skb);
 	return ret;
 }
 
@@ -4372,12 +4366,9 @@ int ath12k_wmi_vdev_spectral_enable(struct ath12k *ar, u32 vdev_id,
 	if (ret) {
 		ath12k_warn(ar->ab,
 			    "failed to send spectral enable wmi cmd\n");
-		goto err;
+		dev_kfree_skb(skb);
 	}
 
-	return 0;
-err:
-	dev_kfree_skb(skb);
 	return ret;
 }
 
@@ -4418,12 +4409,9 @@ int ath12k_wmi_pdev_dma_ring_cfg(struct ath12k *ar,
 	if (ret) {
 		ath12k_warn(ar->ab,
 			    "failed to send dma ring cfg req wmi cmd\n");
-		goto err;
+		dev_kfree_skb(skb);
 	}
 
-	return 0;
-err:
-	dev_kfree_skb(skb);
 	return ret;
 }
 
@@ -10874,10 +10862,9 @@ int ath12k_wmi_mlo_setup(struct ath12k *ar, struct wmi_mlo_setup_arg *mlo_params
 		ath12k_warn(ar->ab, "failed to submit WMI_MLO_SETUP_CMDID command: %d\n",
 			    ret);
 		dev_kfree_skb(skb);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 int ath12k_wmi_mlo_ready(struct ath12k *ar)
@@ -10902,10 +10889,9 @@ int ath12k_wmi_mlo_ready(struct ath12k *ar)
 		ath12k_warn(ar->ab, "failed to submit WMI_MLO_READY_CMDID command: %d\n",
 			    ret);
 		dev_kfree_skb(skb);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 int ath12k_wmi_mlo_teardown(struct ath12k *ar)
@@ -10931,10 +10917,9 @@ int ath12k_wmi_mlo_teardown(struct ath12k *ar)
 		ath12k_warn(ar->ab, "failed to submit WMI MLO teardown command: %d\n",
 			    ret);
 		dev_kfree_skb(skb);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 bool ath12k_wmi_supports_6ghz_cc_ext(struct ath12k *ar)
@@ -10997,10 +10982,9 @@ int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to send WMI_VDEV_SET_TPC_POWER_CMDID\n");
 		dev_kfree_skb(skb);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.53.0


