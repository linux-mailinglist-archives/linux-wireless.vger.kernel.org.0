Return-Path: <linux-wireless+bounces-3719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CA858CE4
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5050A1C2153A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B41D528;
	Sat, 17 Feb 2024 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="IO9aafow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A11D537
	for <linux-wireless@vger.kernel.org>; Sat, 17 Feb 2024 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134357; cv=none; b=Byvt3rkBIQUZjeVMmQ4tXQrCls7WVcyYOmm8XcIWr9IJSF5tBr4eM9DGTsASRvKhNV6ZiIK/kdvc6E8tNVRx8IoXShgbm4rQNly5LBorg+LUsNdaJGB36aC9mysfg3sOfSL1Zj+wsg2ukQtv1EqGm1EftU7oq93BbX1nNECCaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134357; c=relaxed/simple;
	bh=LSxnEseiYHJdE/1Gf9aj+Oj+XLYcwdf5Y4YIy+h8BmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rL+Mhk3u3DbvgVjVN480uU5LL65tawDtr3znXYq3tUFlCqOfsuRYEDYkegTTkhcJHAq58Uq+4L3ZpCAx3mDeT95lN+mp5Vf4ZEHTkZAJUs+44lSNWu+tHlltJq666QoI+aA8JHKcXiA/QTw4dNE5efzIaAjrICI9y18uJ36Rz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=IO9aafow; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e11596b2e7so945128b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 17:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1708134354; x=1708739154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wrksPjyjBXXfdC6zCRuDBRWDpaXwCOZ9x27jZO7r4s=;
        b=IO9aafowHLv01ZJcNAPFGy/EvEXiAOAqFPqucGhms+rG01iqiHTP3Iz6VpTog19aan
         vGn+1yaHSM8E3XYLmeZp/F3b8/P5LVA070WAszQCxkkN+mEIwnn/vMGBIbkeNsumsD8I
         GBUhu1RjaTxRWX7YpNhhSxo/bP72GCNYaM84w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708134354; x=1708739154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wrksPjyjBXXfdC6zCRuDBRWDpaXwCOZ9x27jZO7r4s=;
        b=NaNRadYp6vc0vc2sWtdt3QhkfXNCl5FYa4KVPMlI35TaoEvJKgow1hBd+vKhZ486uC
         knegbhaihHHCGb199812IbQ02mCCWQ+aSvPKWRJMQLCJaSDmFnENCLBtf2f8z5th4R8y
         hjkZcIEmo4VUVltRSUkAQoNndPPDMgmeHITbJ2HHkgVydbM2W1/IJpq3ZzQ13XXei37H
         TINKcxS3V5Tz6dLJg/DD8Y50AI7hOOygqZxOfnw2RVEP2Jc5cinZU24HUY4IoqI19iUO
         k23I0ktF2AkP1HzcMn3J9fqinFUsgorqzqov8wcn/ZneG3mO2J0HNMNiu53aTTO9/949
         sfQw==
X-Gm-Message-State: AOJu0YxXRDFrt49SB5aM55eLz84M6vSWaPmVLp0icneOxPq5Uhsng4sv
	jU3i9XmOtpy+qHGQLLWGqUvaUpfBdtMBexMbg+27P0ZlRFOz/icXALHNo317haogIRhezPPSQYO
	g+Q==
X-Google-Smtp-Source: AGHT+IGNMqnsYPReE72SCZFBuoTiLwBDTsRvsL2TFYJ0zGca1vTRYromtAEL/GXerpFq7q+75rlCOg==
X-Received: by 2002:a05:6a00:8010:b0:6e1:1e08:d08 with SMTP id eg16-20020a056a00801000b006e11e080d08mr8950692pfb.23.1708134353765;
        Fri, 16 Feb 2024 17:45:53 -0800 (PST)
Received: from livaq3plus.. ([2401:7400:c808:b52:1829:e776:2919:ee9e])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b005dbd0facb4dsm530515pgc.61.2024.02.16.17.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:45:53 -0800 (PST)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH] Revert "wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)"
Date: Sat, 17 Feb 2024 09:45:42 +0800
Message-ID: <20240217014542.12971-1-me@ndoo.sg>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Singapore's regulatory authority has confirmed that 3 dBm EIRP reduction may be used in lieu of TPC support:

> Dear Mr Yong
>
> We refer to our email of 17 January 2024.
>
> RLAN operations at sub-band 34 and 35 is allowed to transmit at ≤1000mw eirp with TPC and DFS employed. IMDA TS SRD Table 1 sub-band 34 and 35 can take reference from either ETSI EN 301 893 or FCC Part15 §15.407.
>
> As stated earlier, FCC has pointed out that the TPC will not be required if eirp is less than 500mW.
> However, as the latest revision of TS SRD has just been published in Sep 2023, we will consider making modifications to it in the next release.
>
> - IMDA INFO (IMDA) <info@imda.gov.sg> on 2024-01-26

> Dear Andrew
>
> We refer to our email 31 January 2024.
>
> Kindly be informed that IMDA does not issue addendum documents. You may wish to cite this email to the maintainer.
>
> - IMDA INFO (IMDA) <info@imda.gov.sg>	on 2024-02-07

Related wireless-regdb email/thread:
- [[PATCH] wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)](https://lists.infradead.org/pipermail/wireless-regdb/2024-February/001517.html)

This reverts commit d695bf21d1cdf02e64924f452c242f7588469609.

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index ed76600..15b439d 100644
--- a/db.txt
+++ b/db.txt
@@ -1594,7 +1594,10 @@ country SE: DFS-ETSI
 # 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
 # 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
 # 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
+# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz as referenced by IMDA TS SRD
+#  AU and BG regulatory domains use the same interpretation of cited FCC and ETSI standards
 # Note: The transmit power for 5250-5350MHz bands can be raised (by 3dBm) to 200mW when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
+# Note: The transmit power for 5470-5725MHz bands can be raised (by 3dBm) to 1000mW when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34
 
 country SG: DFS-FCC
 	(2400 - 2483.5 @ 40), (200 mW)
@@ -1604,8 +1607,7 @@ country SG: DFS-FCC
         # Since 5725 ~ 5730 MHz belongs to the next range which has looser
         # requirements, we can extend the range by 5 MHz to make the kernel
         # happy and be able to use channel 144.
-	# 5470 - 5730 requires (unimplemented) TPC per legislation
-        #(5470 - 5730 @ 160), (1000 mW), DFS
+	(5470 - 5730 @ 160), (500 mW), DFS
 	(5725 - 5850 @ 80), (1000 mW)
 	(5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (10000 mW)
-- 
2.43.2


