Return-Path: <linux-wireless+bounces-37934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B4+DE4MrNmpN8QYAu9opvQ
	(envelope-from <linux-wireless+bounces-37934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 07:56:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 234786A8624
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 07:56:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=stZ+D3tC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37934-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37934-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDE2301952A
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B5371D1F;
	Sat, 20 Jun 2026 05:56:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77188230264
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jun 2026 05:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934976; cv=none; b=c6CDlcQ6ZQaxFCh/ogncP2sHPuupcoMwgJqFGTd2GKfCetLCXwP8vTI2ILDfs2WES6SQ9fD2GvZAoZujCcJYlkrdrDBgZibakCWFOCY7rp2WC4jgI+HA6LP/lXHFo62vf45o9VjxUvOTue/Jsm56iN4AVzBBzV5hzbuX/ol1xFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934976; c=relaxed/simple;
	bh=kZrrfVNFD93NlvT+ynFij6zQtLwaTzMwYCPnIqtb740=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPmDVL56JlwH3odV3F+6aYSzrlZp3UIX6KM9nYbfby7kcOZ17XC/3++MT4OaqJ0zfAlM7SCwOeo4ceut1c4NikYRvSsDzD6xb//BOOoxrwLbbdl8QZhI+xbiJ96Jt2ak56vOi8qCuaqWfJBWEnPAe6swohmpclDB9FQxB9kIGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=stZ+D3tC; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6b3f71648so32290325ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 22:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781934972; x=1782539772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yuzv8yDsj/qISG4lvPB4PHWCiqTUSEXSMNl6v4uCp4w=;
        b=stZ+D3tCYYS0qOoZzQj1gvzKBh3XhVoAzGirE4GPVjwu/TfET8EVanu1XqaHSRntJ9
         rBX0KzPFSVEXht4knZQEqvzILY5UxTCcgq3vCke2HGEyA2Rtjlsyeae/IBZ0gV5QQQnB
         +ECY6tyCr5TwHnpPnT65VL0kEmyHpHJoZ9KOH8CSAvNW/RAHX2tH94C7oQAIqr1jY2et
         Z1L5/97RrUmFQiVT1DbxLO+0ZDnnErRIqH4Tt7aKDI6NM2A3Uqvzd9nSYKAl/ZHpzF74
         5zh8SZL9WZuVzyx1dPZoRJ/b40jjPkq+NYNESvVyClueRrphmhyz5lQb3JOgkvpPdyKV
         +AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781934972; x=1782539772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuzv8yDsj/qISG4lvPB4PHWCiqTUSEXSMNl6v4uCp4w=;
        b=jBFPFtQsqTwcg0R66/KHwQDgMxfLWgt2qIbrdNix+PuMMYVCJ7NIcZzgZ+5OcgvM6K
         qdepAwJWKyVw0AbbAq7QpeVyco5N7oce8xlk8xfExIDO9GixgouLdcpYyM3OKuowEGsT
         1OM57IGeqC1Nh39DtNZeCnylS4qyGM0Fvb3fpeiGba1cPJQGac23ny3CQxTHIbLTMc9b
         nQvZxCshvwjTAlCjtLViEsTlgWc1GNTYmn+xs7Z2cwWgn2DtInvSm8r+91W3knMLWc+w
         T02h3AEAzq8g+HLd2RmrDWMDzmMAgro75cf0AEMAPywfTmrkKarFWtBBzXb7w6ydMSqk
         ZgaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wNQ9POmZXytubNK6rAflvsJJ2vOarfLfucjUBpLmRkj7obEv36SOYxSDposDmRMw/T9pNIi/9oSuvGwbC/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tpZPv9Ec4TLA+h5XKiue/IDw48iVfRDn6ceouN8BBwaiHenV
	EUNCviWhMKvBNGn7i0/yKXXA2Hq0TGSMXRPIVMI1TSSgdLSciwaX2W5AutlJWBtDAEg=
X-Gm-Gg: AfdE7clL1jhjA2/hg4+38j2vMlTgB7pftwJLG9oWx3vEwHQdBPfSEHwja0L4JWOP4wk
	a1t30jeUsNLdDK+snW2Kt3tAmqiFiTymE9SoeUHmjy4w/rHY5wIXIl0MG77xsZfuWbXmaF4Sghc
	XzlAIfRsGNckRZ8ecZ6wsDbdArO9zs9bdp3heBZe/bC4ta5W0yjrhJ3ADKaYSt/U7sNVr9BNUxN
	jT3OCPvqy5jJoQV+/BVvzPZRA+VVIJll+UsFyMNn3Cz1HPZJxtU2kEyszscO/Dzn4ILwUsSj/vt
	VghJlJaJ7U18LtP++8f48w3zaohEok/c1S5wP+3Xsb37LOU1lgMt5efd3QywD6MlsIyN3frq6Iw
	0HXXGFI+mQRZlw79tMXHQSHnQaHI+v8PZHREmbrk9k+M3xXVs/fnCyHd+TNrdZI41cxYO8gBIRi
	RoE6O+EMYNqBgplVLy8MC1hnqLO1GfpK1+ybszZKb13+NPYAzZ24rcIUTb+mX17WE4tw2QuDNtJ
	cXbPPlJQRLievKWt9dXQgAgFkiFkfJAquhIUv4fyO58+Rkl5zNPeEK2Kg==
X-Received: by 2002:a17:902:f687:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c718cb05e9mr76481095ad.5.1781934972555;
        Fri, 19 Jun 2026 22:56:12 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2c7439f8524sm13079295ad.47.2026.06.19.22.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 22:56:12 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: stas.yakovlev@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
Date: Sat, 20 Jun 2026 11:25:54 +0530
Message-ID: <20260620055558.75740-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stas.yakovlev@gmail.com,m:nihaal@cse.iitm.ac.in,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:stasyakovlev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37934-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,linux-wireless@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iitm.ac.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 234786A8624

The memory allocated in the ipw2100_alloc_device() function is not freed
in some of the error paths in ipw2100_pci_init_one(). Fix that by
converting the direct return into a goto to the error path return.

Cc: stable@vger.kernel.org
Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index c11428485dcc..82280890f1c0 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6157,7 +6157,7 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_enable_device.\n");
-		return err;
+		goto fail;
 	}
 
 	priv = libipw_priv(dev);
@@ -6169,16 +6169,14 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_set_dma_mask.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	err = pci_request_regions(pci_dev, DRV_NAME);
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_request_regions.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	/* We disable the RETRY_TIMEOUT register (0x41) to keep
-- 
2.43.0


