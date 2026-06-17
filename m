Return-Path: <linux-wireless+bounces-37876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y2rjI2ApM2o3+AUAu9opvQ
	(envelope-from <linux-wireless+bounces-37876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 01:10:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9CB69CC52
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 01:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HYirRgva;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37876-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37876-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6852E302B741
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983C3AF675;
	Wed, 17 Jun 2026 23:10:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92098388396
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 23:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737821; cv=none; b=qGvIQttGTCX6InJlUuTfQnPS/XZBZvnuvZiOrzehEOuFC7cV+4ft2YLiPeCWt6HFH+C+oHQJm7ROHjTk2/OxYmngX7QOs7/2Cld9Fmbcsv/YouG+hk0A7QyWugtRHA9W9x0siPjkkqV6i3qe7x+z59iVy+5CoT5p47MLLCOVGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737821; c=relaxed/simple;
	bh=u6wUHnxvwivQwuzu3HKhXhyqnsF7vcLu9HeL0jOJUk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPa6xAS/xNZ6wWn0mCLHDr3816E01UuUi2eVxGAuxIIDXZiXPkf2+XmlqC8UvTKc+v/lsE4BkUsw5CEJRy3jGkW+AWGVaWXOxnToD9ihAUlbErHWrCrGAuvpxHUkWZfZA/zbpNN4WTbM7MdS9bgoDukHaH7mvSjuv804/ZiFINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYirRgva; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842d37438d8so70994b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781737820; x=1782342620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gor21PaBldXAdPuL5q1IPXFVFpwunO3DWx10Zn+d6L4=;
        b=HYirRgvaEK8OOyF3+HcVFSvfGL05KyLeg6SgQJwH6fIixHOuLV6nNI4LRVfbq1qpba
         jT1OIVU7NAfzNCVngxj2reel2Mg/RnOStj5o+K38JUsS2v7b1Pqkx4udZsiYDPI3qcTB
         9lok3ynpoWu0GQ+JaV17ljPIbGSM3LsnCy7A2j9vlQ7aZBjWb7RBA3DnE4FXGWcOW7nB
         dYWy0NOyPRj64VFKdhgmt06txyTi2ssVgOTK7/KBWjTTecUsyH3jMb8feeyUw6DHSbFn
         EXTQwSTPiaBCEwANWpvgzWUATonI7tpyQeGujAQJ2Mv/HC+5NBaXuFEMah7L2Dm/4s8B
         dr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781737820; x=1782342620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gor21PaBldXAdPuL5q1IPXFVFpwunO3DWx10Zn+d6L4=;
        b=lqmCCZS1DdpclIcQHSftAW0pEog8sTiFgXr2f6Hftcnl4jQLExKREUK742xRBU+m6z
         kSpJsUmK5HifHhQ8Y/51iQzpG/sqwaW5OzNQYrdfOvKW+aWrq1ley9RsK5ON8E++jyxw
         zAnAEzlxUOUpxjkvZGoE92zmvcxCXNpqKRodV1bIMUvyPvnidsjztFus6xgGjJSijpM5
         m6QxcUj0m/lRVoDHhvVtbEQL6d0vS7jZcDB3S/9Zg4wzWM0RJZ9D2nGjm1Gg6Vyfcir+
         9vGePaNStVKDbV2z/n1TujmKEH+0rDNBrEKxWJSI207h3DUaeD6bhil7+Nvx7yv/SWE3
         9bVw==
X-Gm-Message-State: AOJu0YzuiZ3J9wReiowog2li4DsTD5DqI8+xJgdFuC42Dj665O2NkAKX
	h1L2NbIqjgZ1c7udfkVOPwwY8H+V6AOrevX0UdamBfF+SZ44Mt4xht6CzWMtkg==
X-Gm-Gg: Acq92OG2iu0ieOkpmkR8ZUWfGiurRYewkUOD/s4fN86+qJlCpnUPU9/c9ZY/IPrR1hG
	uZbl3SKcZf2UtQy//kON6S+1zOMT0OF64EPC/kl5pCRr91gbP+bDnLsEcl64YvxmyB6yVyDs0Nv
	8o0985QYiyZyIJERiE/tR/g1yPrJDHWhrNdsVbVGxksoahdO+6siT/b1p7O6ZrXIEWZzJh+/kkc
	sxYvN0G0+VdQfSNVQrv9S9YRjSE5/ZaYchzIgPwQ8+l+gu5t4sRUku1Jx0lp96JL8NIC5GuL0OV
	IKYgL1WI1/DQC9gCMhO0jUHpUTQSh7dbf5s/TlKnL3hcRk+aOAPALCAk8KGuIAwKxm4kvHqg7K7
	Ckosx8pRuX6zbVweTyWeUHLg4KlkaGkVYbZS/KO8bFv/8O+V30jwqt2uR1N4uppT6bkQyrIFD5S
	osrrdO53nMa/eYv66FTIqrlcvLx8CcxoyC9gVg8lfTMM+ud6t39BZQOC/jDnWJjEt92Hf1S47mk
	10O+95FT9ZOyFqGGdcuB1L9
X-Received: by 2002:a05:6a00:2d85:b0:842:2382:a0ea with SMTP id d2e1a72fcca58-8452445d70bmr6060758b3a.14.1781737819864;
        Wed, 17 Jun 2026 16:10:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7305:54ba:2fb4:e198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acca7ecsm17640525b3a.13.2026.06.17.16.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 16:10:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 ath-next] wifi: ath5k: ahb: use devm for ioremap
Date: Wed, 17 Jun 2026 16:10:02 -0700
Message-ID: <20260617231002.262820-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37876-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:jirislaby@kernel.org,m:mickflemm@gmail.com,m:mcgrof@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF9CB69CC52

Simplifies the code by quite a bit in probe.

Also allows removing a goto and returning directly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix typo and remove error message
 drivers/net/wireless/ath/ath5k/ahb.c | 33 ++++++----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index cb3e891ee1bd..8d28e02c3418 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -87,7 +87,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	struct ar231x_board_config *bcfg = dev_get_platdata(&pdev->dev);
 	struct ath5k_hw *ah;
 	struct ieee80211_hw *hw;
-	struct resource *res;
 	void __iomem *mem;
 	int irq;
 	int ret = 0;
@@ -95,35 +94,21 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-		ret = -EINVAL;
-		goto err_out;
+		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource found\n");
-		ret = -ENXIO;
-		goto err_out;
-	}
-
-	mem = ioremap(res->start, resource_size(res));
-	if (mem == NULL) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_out;
-	}
+	mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_iounmap;
-	}
+	if (irq < 0)
+		return irq;
 
 	hw = ieee80211_alloc_hw(sizeof(struct ath5k_hw), &ath5k_hw_ops);
 	if (hw == NULL) {
 		dev_err(&pdev->dev, "no memory for ieee80211_hw\n");
-		ret = -ENOMEM;
-		goto err_iounmap;
+		return -ENOMEM;
 	}
 
 	ah = hw->priv;
@@ -179,9 +164,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
  err_free_hw:
 	ieee80211_free_hw(hw);
- err_iounmap:
-        iounmap(mem);
- err_out:
 	return ret;
 }
 
@@ -213,7 +195,6 @@ static void ath_ahb_remove(struct platform_device *pdev)
 	}
 
 	ath5k_deinit_ah(ah);
-	iounmap(ah->iobase);
 	ieee80211_free_hw(hw);
 }
 
-- 
2.54.0


