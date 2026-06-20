Return-Path: <linux-wireless+bounces-37936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id byC+Fc04Nmqw8gYAu9opvQ
	(envelope-from <linux-wireless+bounces-37936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 08:53:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1CD6A8750
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 08:53:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=bFe+nWEH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37936-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37936-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66D823018C17
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D14374A15;
	Sat, 20 Jun 2026 06:52:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70625374A0B
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jun 2026 06:52:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938377; cv=none; b=tP/JnRCw4yHaF3j3OtkZVm94W0aYqW9aVZJpMH0TVeQLBo3TZ7qHz3T2qshSZ+mecCZmWvSze2yDqfhY6cBH2iDkrUmQlpbnn83hcMaCoAO0+26DmI87jRFNJCyvz0pDQL4JZF314MmxZWlLlpt/zDDqU0zMY+cmkkLYzRoIHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938377; c=relaxed/simple;
	bh=2s0xvYMHNV3vbXplIoTi8wVcJPWVN0juzhUkxxloMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBEHYZsl5wSr5axLaexbgwCKOG7lcybaNTcV8tp43BHZfPuR4GnuY2pEEsSTHAoFYBdo6pqMHJro8TgXkevE/UkAzD4sZSZ1C1vAJfb7e7upEuEnoMihCHx6Bj7jEinwOzR03HJNyG83YXUsLgkG8MuKtJP5cqMDe3/NxlnOtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bFe+nWEH; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1542121a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 23:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781938376; x=1782543176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWrAPVVPXK8Wz+6M4TACvlC6LCQEyIdcBgZX+P4A3lE=;
        b=bFe+nWEHP7aOT3AeyhgdemqrxcPwj0FRayHCIXuV9j6oqE9BjlcoBA++NhlqEo/WXj
         atrjp0qgFxzGoXX1JjfpW9e85gMfMkuyi/SgFIcr+ObQrDFBtcGLWFZXS6cRtfRp5s9y
         cq/Madx0greD0+TGCHiZBR9fyY+/IVoppCaTuolv0AlmPo7CbGtbkunoeJD700LJEskX
         1cX++k9mwqDtelhmPqstrQVjOCKPXrJ3Amos25T3Ffmyq2aGWLeyrJ5cYhFEWT3s8nFo
         /vTKnOxG9KCtsYagCMzvvDHudlnun4CWdAgh9nv4LfEqT68Ddd3V8ls1KdtcE6bA2sBS
         ZD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938376; x=1782543176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWrAPVVPXK8Wz+6M4TACvlC6LCQEyIdcBgZX+P4A3lE=;
        b=MXVn0iSyAW1QQq6MFSPzQwF8AljXqj8zecISsNUvX+E9YlQ5TWi5f3Ev0J2k0Cp3KR
         39FPqiBLoGxk0ky07DxhhvEMA3slFa4d/JyidFdrVLXX0UXlkj6Bbmc0nbp+y1vWDI7t
         OQasllDNZepENBVeoKau6gHrcRQEbmToZJuIk46tXvkip9MIWSgUlwELI2VyKH6q5vCR
         UGUUzQqJa7G5dvSQYgTtg35OWhNe50SAsCMSqep51R7zzNGbSJnVkhTrfqo4uYCbHqSf
         pp7CyBTWHfdmcUTrQYg4OTx5YSdNdFuVyAjaEdfvSD6cXAFyMTrP8vdn/BE/Fj10deCB
         JFCg==
X-Forwarded-Encrypted: i=1; AFNElJ+NxU41F8rhBM+njCuQYUloIbH4UzbkGEKUt++LqZIfZ1DYzO3sQB9quvLldLfu0n3ql7bEGWRHLGgVvDw9Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAq+TBOtVLMGZ+O4J9iCRCNZ7C6TUsDykcdH8fxW2hEar0e8jr
	H42apd4WtGMs7LqxzFMVws70y5BBpapfNXXFfGs3mg/As4465D+/rdqz59NGXV/pHjthpoqegVo
	NsDTa
X-Gm-Gg: AfdE7cm2KeEvFds5/lcn3if6ItHBVLwhO/Nk7O62t0KRt7tRCmcfj7lpOukkVhle1P5
	BRIpcAmSgXV9c+vRYEFNyuh0XQAP2PdAfi/r00eVOYlIgJZa+4SFISYQ9pUj72f40+N+JAcmCUE
	5M+92d41Hs0pmTK1shwAg3q4HILbFGRV2h7SOo42NG76TxxFYE9Oj1xkVeGCYqjnrY6kx4MGUxA
	bur1MMN/M4h+6ubEREF02rDM3gOhMLPmyWWkmRUq3x/rieK5A4kQH3cxnI/3qjQsPhW7NP1KawA
	NmbsFa+UU8HwqidhCFUTDzXg89lMIFttzsOyCg3JA03WuNuCldRaQuwDq42y/RqjVO0FX4nTrak
	FgzRjU1+zdfVAaDx01APwyrW3GmdVQfrDeZtoV2RPMybDSeYwsx8CZpunO0oX4W+lLtTtS5U0ug
	LH41e52NZ6VS/wUq6JGb8vyfbvhBhz4iIqdmtVbOcrR4LJoeMXyg+aBQOmEYhsj2RSVVMwfaf2w
	vZLMxx1rHitZvJ91DZ9SpLwt54j6cmALJ4l8IYcXEi0QX0=
X-Received: by 2002:a17:90b:4b81:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-37d18637020mr5382239a91.0.1781938375682;
        Fri, 19 Jun 2026 23:52:55 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37d1536b541sm4428857a91.1.2026.06.19.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:52:55 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: stas.yakovlev@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
Date: Sat, 20 Jun 2026 12:22:39 +0530
Message-ID: <20260620065242.93798-1-nihaal@cse.iitm.ac.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stas.yakovlev@gmail.com,m:nihaal@cse.iitm.ac.in,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:stasyakovlev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37936-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,linux-wireless@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cse.iitm.ac.in:mid,cse.iitm.ac.in:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE1CD6A8750

The memory allocated in the ipw2100_alloc_device() function is not freed
in some of the error paths in ipw2100_pci_init_one(). Fix that by
converting the direct return into a goto to the error path return.

The error path when pci_enable_device() fails cannot jump to fail, since
at this point priv is not set, so perform error handling inline.

Cc: stable@vger.kernel.org
Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Converted the added goto fail statement into an inline error handling
  when pci_enable_device() fails, because Sashiko pointed out that there
  could be a null pointer dereference as the priv is only set after, but
  is dereferenced in the 'fail' error path.

Link to v1: https://patchwork.kernel.org/project/linux-wireless/patch/20260620055558.75740-1-nihaal@cse.iitm.ac.in/

 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index c11428485dcc..2b8a23865bfb 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6157,6 +6157,8 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_enable_device.\n");
+		free_libipw(dev, 0);
+		pci_iounmap(pci_dev, ioaddr);
 		return err;
 	}
 
@@ -6169,16 +6171,14 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
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


