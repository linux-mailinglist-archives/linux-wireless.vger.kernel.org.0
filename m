Return-Path: <linux-wireless+bounces-19392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD788A4348E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 06:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7534176421
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 05:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9B256C76;
	Tue, 25 Feb 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvWsYNST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B017E4
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461702; cv=none; b=nG2vM7aB8z3ehOlzxseGAXaWGm0IK5FAjsAzOfKkNCBzl0+bNdkJ2eFl0LzXY0bw6EsRpxzJG6SpprBHfENrkUk/EJZOX9U8aS/Fv1sPcaA6DkO6n2FTPVwufM+6WC0trrU53ZJxAQ2iPieiDCtbuP3I7Bw3WeaN9azNrq6+KeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461702; c=relaxed/simple;
	bh=FmjQKYch6XSD5pbW1Tn3YSdPQVc9xHCO/JMUTJbJyPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThAnJDmgrmarKTI7n8EEjNvLr+4KLcXA/X1CHSAGF3Ek/hqsciO1fbDVuzHEztu/xYam/p/MNHpk0o2AO564cIcM5coZUgiUD3q2myf3UZFqTymlpaUBDdKM17bf7Pxx7OZ7O/NiOdYECx8N/YPef+5gq9lP59N0IoKnKl+BTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GvWsYNST; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221050f3f00so117107975ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461700; x=1741066500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6Il8METpmlUQkRbSAgjzH18Gr01cpODvArSkIp0bgs=;
        b=GvWsYNSTIsVy6ueVfKcYCEgMlB5NOeOuS3+/HT+hj66ZyL3SXypWtq/t77Bz7ijcOH
         NhJ0uJ2f9HvlFcPe0sv+R/ycc6PMq+VkLTVVOtigfN5V1ZN4740kicbtlCe3pu7BSby7
         pQRD5lB8LJ5mH5NyeidqnSbqrMD5GiZnpnBCgfia7Fr4wcMQY0g73cKOuNKCAEH65E14
         GdIJVzAHZ9+VtOg/vw7yAkcNEa+FqzxUnFjnnBX9kpPC+dMIaN94GEvWhF5bHjbBCoqL
         N/ZG89QdONEnDblC5FSi00w3RdEsavcCH6cRc84RTPldUwqckCDNs1C9sA84JTmdlgz6
         c18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461700; x=1741066500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6Il8METpmlUQkRbSAgjzH18Gr01cpODvArSkIp0bgs=;
        b=vT3HEBVpVGnAoOlxB9BmqRPAZZOGy0ipev/RsaGC7dCHVSWLkjYdyL3UoC5JH1Ryix
         ww7R5rMm7P35/NXRMVQRaVckAVshrxkGPAxjTXRT8KR2q6VuvOhDhOAObljnYy1VdF4C
         BYGRZXp9E5lqReWRWaT/Gg9ThnvgRCSvzocOOYpW7Q2bWhGJxiswmMAfXDgGkUPBpQb3
         CXKUrubYptxJR1l/UggvJcXcTtSsWjCnVWIzYrQ4b7Tl2NTsfyT2EtsaG8CauRKSVIPL
         bvg//YDyEmWgXFnT3get3HU+im1ZfXaq4FRlM5rp5lVx7GsETBzbyNCuYXz/OcQQ15TT
         iDAw==
X-Gm-Message-State: AOJu0YxX4hECAkZ3aM/sg+6r4ADY53dTxRkRBPSjeG14rs3slNUY2MP0
	kEDILQ0zQxtCu+SFGbpWcN4Hn46WrkUeonEmbaCYyT/lFNIL4tvRJcfIkb04JIWFUpuDDzFrDdo
	=
X-Gm-Gg: ASbGncu4bf9HAI2a83k3ImVKMMDh5QiQC3BVfEDlKoABUlD2fXlKMZpQLLHxg2+tmVZ
	pFIxlel0oUioRcAOtoc1bgNvt8KIJH4JT/GLxwmVC0JHJBvrh7n5ackgQkCFauXe3yBtzcck/jE
	LSplpdKe2r9qPu5xJOXXQC3SwvpdbYW3gsEtRKtnbAgw9FmbzTBh680EdXP1O93Z2M0gnWxWfaf
	XwWPf7PFN2wlHbpJav9BF1BxlTeHpsdT7hYOUjmQ7kYtERDI4OMTUBbs7x1izKa5f2qz5ji4tnM
	53VDHPcWIjdTxf1/FmdAEhhEzCpS2LW+wSLrvTdg3H1/czX7HL3r3g==
X-Google-Smtp-Source: AGHT+IGOuK5WVs/FNS54x208S7fpWZaQq234w5cakUj39RKsU7tmbyu7PT7tpCGWSjC4Q4d8G+DFOQ==
X-Received: by 2002:a05:6a20:a103:b0:1ee:de1d:5abc with SMTP id adf61e73a8af0-1f0fc78bfe1mr2892953637.33.1740461700018;
        Mon, 24 Feb 2025 21:35:00 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:34:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
Date: Tue, 25 Feb 2025 11:04:46 +0530
Message-Id: <20250225053447.16824-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath12k_pci_msi_alloc(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ.

This may end up with a warning from the IRQ core that is expecting the
affinity hint to be cleared before freeing the IRQ:

kernel/irq/manage.c:

	/* make sure affinity_hint is cleaned up */
	if (WARN_ON_ONCE(desc->affinity_hint))
		desc->affinity_hint = NULL;

So to fix this issue, clear the IRQ affinity hint before calling
ath12k_pci_free_irq() in the error path. The affinity will be cleared once
again further down the error path due to code organization, but that does
no harm.

Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 06cff3849ab8..2851f6944b86 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1689,6 +1689,8 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath12k_pci_free_irq(ab);
 
 err_ce_free:
-- 
2.25.1


