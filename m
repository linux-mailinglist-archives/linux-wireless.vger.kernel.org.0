Return-Path: <linux-wireless+bounces-32996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKWhGbHGsWnvFAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 20:46:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E236326998C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 20:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF100307410C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6D2D0C7B;
	Wed, 11 Mar 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhKcQYAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578940DFBA
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258347; cv=none; b=F7f7K4va1appVlrSu0RZ+Efyr5812D5ZPMxTwwnSWuqjzehhhis8oQ6GuPvHD2LKQv24EKZQ/XMKt3BoPA1y56NFZckG5MASNjzJ/BcjrCGEl/rox4uyEQ3+JwFgu1sKX59X3c862m5g4FJ1ru0uBRC1AxKFY2Spxxx22it3J8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258347; c=relaxed/simple;
	bh=VwQ56VXUaPri4KW77dpEQUYsi6yUrAih166WCrpBKTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2btqSe+1GZoUeaoggLrIhmBml69Mmy9aEwGfSVfZrxC6ExWchf6gt57tYswKyDqsp5vdzpaqsE40HhOtCEShMgbsrCioKw1A/tYI/WiArlYo2jcZtADcQNeb01Yy6kXJ2N+Cg5RAb3BWEn9G8jSNQdoBph+Oqnr/LGKRYu4FAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhKcQYAp; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128e4d0cc48so310702c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258345; x=1773863145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1uUn/7K9WlWtyyo40gm+4/cEvjyqXdggwfumhJO2Xg=;
        b=RhKcQYAp/d4i27uiOoywCFdDoFJz4aDr8HI05def/NuCtifB6Ydtqhav6hKi8RUsBL
         WLUiYZf0KsJ9scCdcNhsS7eoOu7utx2dRB1mH73KjfXATZLY5+X+Gx/jAzhnx9HxJks/
         jvOYwXSs9KbcsejTV2ERpVqCJn/IL+2hjM+/l+fzhuVutGOuPB0BLCkV/LafIh5RtzPG
         r4m7bxg3SsZQlmKhDEVE9UJMpeQVq+/6U0FZHS6bRQ5qCBbRolvQnqZ6Anw+FjOMz+HK
         BWlrfQg6Gi7yN2sDydETYQht7wvNohD8ZneEcHKF4o4F0J/w9p+rUZfD4EGwuGDWqq3L
         jbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258345; x=1773863145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1uUn/7K9WlWtyyo40gm+4/cEvjyqXdggwfumhJO2Xg=;
        b=tbvRzlLTcrjo8I14ASGUTxbWXPPbn9znoKKNPX6x3hI1rp2tAo1d7scGq4ajAtLpUb
         ADNDhQcsbEe0DufFNrKdtG6GCZRLiw5IWXHtVdIpc25/ywwHwUwN0LF4wtJ72xqBqJzZ
         9uihdMiUlD1tCxNPY0XNhG0MorZ0YS79rREY5gMKdjFitHkEucJWjiP7O/Vf1KUgL4we
         /MVw+L8r4pUNPwhcvThUh418anawmc0iSG/Ou9HkStDBD/HEZp9+GZJ5evfHIMbH9+zQ
         vBkcz0+x+N44pZ0FGCpxiz7Z+nOuSpU03YxLz3+vyUG/cW+CyzjFpyFhTUTOkbrPmWWm
         a/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaf59NHlTlcpPkypZU2kvRgk69Hpbfnj2Kohyl6+dcMlh41x5LJ00RzNz0tVWtO+BP9do9+ckvqX6WgdwPWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzd6dxxtzbUEWUGQSB3GXxD0+8FqsYo2jE2YGdP3t3JG7aMp7
	Qc2Gcz2wUpMRMwetwfGaWSN+ewboey6bkGSIxD6MHSqLLcZ72PZ0Sh43
X-Gm-Gg: ATEYQzxYsTTyJ8zuSvVz/4QAqFGpKuB6viVvGTopK3HvHghfx4KcFDrdf8W6QKuMW2A
	qqOAMFJUeMWykJVVc9DXYrA/KmGpED8Uuujgzp4q+pdON08coR1ZkpeyGatytOoqK+Ka6k01kQz
	IGwzMWMy5qSJqUQXxtLDdTSQPc2jtdR+kSKaQ8rfglCO4zWiEbgYLnrURudxW9T5wNtWHNea29y
	73TamEBn+Himu1gm9YcmMEQcWPZ9vfDesVw8rChUicQaTSa1IBzeFSMhk9xoySSynRXCSVKpMVg
	2mjPDD45jBHss51sKq379OAKCc5Bdb9Yy/Rx6IpKX8r8SMR2lnPpV1xDiy48OIC4l2dif5nJ8MR
	Fb/m+N4/ANa6ehPDZH/YY294YzBtOtEZFybyFYTV+E5TFnOGzTxbLW3SHjmgTJmay6yCSPxwXoC
	zpzNza12n/uEiyaVFSjhUgxMUOcbrvti4Pl44yu7B47RHbAJLnPjQyJnb3+ROD1FFGCf85A51Di
	sPNjXb7
X-Received: by 2002:a05:7300:dc87:b0:2ba:6a79:f04c with SMTP id 5a478bee46e88-2be8a2ea792mr1389351eec.18.1773258345011;
        Wed, 11 Mar 2026 12:45:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a803:148f:866b:f519:b5db:1242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa96fdcsm3739660eec.30.2026.03.11.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:45:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: johannes@sipsolutions.net
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	briannorris@chromium.org,
	Frank.Li@nxp.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: net: wireless: marvell,sd8787: Relax length constraints
Date: Wed, 11 Mar 2026 16:45:31 -0300
Message-ID: <20260311194531.70441-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,nxp.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32996-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E236326998C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 31ed9d9d71ec ("ARM: dts: rockchip: Limit WiFi TX power on
rk3288-veyron-jerry") added calibration data for the rk3288-veyron-jerry
platform. The commit message explicitly notes that "the length can vary
between hw versions", as documented in the original text binding.

The current YAML schema enforces fixed maximum lengths for calibration
data arrays, which causes dtbs_check warnings for rk3288-veyron-jerry.dts.

Relax the constraints for the two properties that have
variable-length data in this platform by adding minItems based on the
actual data used in the downstream kernel:

- marvell,caldata-txpwrlimit-2g: 508 bytes (from rk3288-veyron-jerry.dts)
- marvell,caldata-txpwrlimit-5g-sub2: 744 bytes (from 
rk3288-veyron-jerry.dts)

The original maxItems values are preserved as upper bounds to maintain
validation for other platforms while accommodating this specific
hardware variant.

Fixes: 25f855413885 ("dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/net/wireless/marvell,sd8787.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
index 930b700b73d0..0d5b4274f151 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
@@ -37,6 +37,7 @@ properties:
   marvell,caldata-txpwrlimit-2g:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description: Calibration data for the 2GHz band.
+    minItems: 508
     maxItems: 566
 
   marvell,caldata-txpwrlimit-5g-sub0:
@@ -52,6 +53,7 @@ properties:
   marvell,caldata-txpwrlimit-5g-sub2:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description: Calibration data for sub-band 2 in the 5GHz band.
+    minItems: 316
     maxItems: 750
 
   marvell,caldata-txpwrlimit-5g-sub3:
-- 
2.43.0


