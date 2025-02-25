Return-Path: <linux-wireless+bounces-19390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38391A4348B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 06:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59797A9D13
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 05:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB11B7F4;
	Tue, 25 Feb 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grf/fUEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB92571A3
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461696; cv=none; b=i/HbaXkl1f0xAg2EBj2Tlfocau1sPhvQq4hY1IxWLwFpnToycAoUHqd3VTfRS2OcPbL/gii88dDnX3Ytqv3ImoAFLJlsUCvxlGA0dIC2dsBPWhHsdqC6Ch8MhcH4bQ5TAcTRFyEt5lRsutGco2Ta+fCAygC4wkMml0B8V9TXvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461696; c=relaxed/simple;
	bh=mmG+LHSr5wQDq0zrxPGlfjS43+NwfjSyToS3LM1GNsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E2SSDZuz0+gzzHHgpYdW13fPQB3CgVbtlodmyic9SVatkmSYZn2x2K/co7L1cMkA90B10vEK7B4Gr034q51BkMWrgAwvhCgtnv4HPvVXz4qzgbYNe9nGakfvM0vzE/U89Db7phz4Q/jLAiKGxNOSA6zHEua4TSyorPuTKzW6uYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grf/fUEi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211cd4463cso104061435ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461695; x=1741066495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COFBXMHPskIsoIit0YmVND2fstaviJl+t/pdbf0Dt6Q=;
        b=grf/fUEijyXm7cdF4rfiALoJX1KlFNYcQRFjraipbtaOVT7Zu44yZFIvONOrAcW3S3
         WWpv7LPztVoEKntFjoyIRNs7HaEw4hpYVFPrKlQGYHS4EsFMg0Hmpacr/Ko/x4OGMZCT
         X9SaYfwKxv45WZdcRjNmYdCVn06LwCvuPVfoduWNHxwCTBP9V/nriGCajgOCB6wUG34v
         fuoMmN/ZYonehhZiFtkX9wOd/ERkv0dnbSbWgsnKa+cx2GsXnCUsyIZfO7ECi99atoB1
         +e8rDhqE6SNRGVFy8HmVzEtdpnHU7H7cNlEiAI0Wid/9lOyHZ44hAruuxC+o23bxDIYo
         ZRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461695; x=1741066495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COFBXMHPskIsoIit0YmVND2fstaviJl+t/pdbf0Dt6Q=;
        b=L416OUjHSwenjIQbuHIAOkNeAQsxNp4VZpzNqf97zFXS7Y9BWTEl8+LmSBEyihhtg8
         3dnANPmLu2uNJkSjA9MpL85uyub6RIG1jMuI36byuEmjegB37qlepCnkrOENrxXrf2wV
         EgPMosI++ZoTsnlFKAbuks+PWkdnpD9AiIg9OKtQVhlK5wM3SsduQ01NjQ7VeccaqLGy
         WRtMb1ScBctc0RqsZSuItVtzIz1ANX6bVh0oqYBLr64E44S5DtRDlhQ7gg4V5qb1VCdz
         qcCTkFyzGFofaBdIWsgkAmzlYi8w+NXkD0RkC16wv0PFqR/0+bzKuMM7KAzWn3j38QN8
         w1Kg==
X-Gm-Message-State: AOJu0YyfLhJe41CWY0M5BDzA2ljMesps6CaYpKUCnYFPDkbdBSpKpL6W
	6REtoZCSVkIzGZNJvhYtwGdvNoLe9xGj5abHYZh50+3Ugd26Gw9cZL32YZR4VvIETsdxi/3PVag
	=
X-Gm-Gg: ASbGnct4U3j5FuF1cE3j3Bvro6wQfwI+POTbqMjzFPrhvOPAPKLwAlOok5uoWC4es6Q
	g1bv2Mdz5+lBk9Bvs9BcjuCIe0a9NQjfspXBVk1uW5bHlFSOu08fktZ70i8iJbVE3AKzYDJZ/fe
	C2YJqo53htM6NDGwtti4Ul5vV2rFwFgt3fsklmKpZrs/GELfaBkPDN4EDsaEgKpvcfyludrJIMV
	spCRb+p3/mncWbM/Pb/lsSqp7SoW9ZLay6XjnX4iPwXOKFboIqTbcktg7UV7WVEsS0LXfzCaErO
	E7DWoSbGWMXocyixxaj76+iQ2BdQ21wrjYpsnZmymErJqywra+SZcw==
X-Google-Smtp-Source: AGHT+IEcKJ/dXx95j55XEtJ2Yr2v+/ULOkI6H8gKJVMhyZk/j4JRz3SW0id9uRnQMpLfQLa1g1/udg==
X-Received: by 2002:a05:6a00:228c:b0:730:8ad5:90c1 with SMTP id d2e1a72fcca58-73479101286mr3756467b3a.14.1740461694618;
        Mon, 24 Feb 2025 21:34:54 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:34:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] wifi: ath11k/ath12k: IRQ affinity fixes
Date: Tue, 25 Feb 2025 11:04:44 +0530
Message-Id: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a warning from kernel IRQ core that gets triggered in the
error path of QCA6390 probe. While fixing that I also noticed the same issue in
the ath12k driver, so added an untested patch for the same.

Finally, updated the irq_set_affinity_hint() API in both drivers as it was
deprecated.

- Mani

Changes in v2:

- Instead of moving the affinity setting, cleared the affinity hint in the error
  path before freeing the IRQs
- Rebased on top of v6.14-rc1

Manivannan Sadhasivam (3):
  wifi: ath11k: Clear affinity hint before calling
    ath11k_pcic_free_irq() in error path
  wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq()
    in error path
  wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with
    irq_set_affinity_and_hint()

 drivers/net/wireless/ath/ath11k/pci.c | 4 +++-
 drivers/net/wireless/ath/ath12k/pci.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


