Return-Path: <linux-wireless+bounces-3416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D808509BF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 15:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3655C1F21A22
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812105B20C;
	Sun, 11 Feb 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTBj51uI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E15A786
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663354; cv=none; b=iEaQWXUq9W8CI+tr9Ap8Ll6E5hqDlK0ps2kbArL+jgeCwj1xqgkN3T/BdqZNsim/7y9+xRWEnNctCeZltkna2eVADogujJPOfS1PZb0bwHKX58LCV4iPpsv1qVRTnUf5G9R3PooLBRCD5zTELzJNf5wsxvRTW4MGZKthgMk9X+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663354; c=relaxed/simple;
	bh=J4m1OK+tYgdtWu7sG5YOE0xhk4pWV7NF+eI/it9xjCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMScD3hpFRp0h/wk6a6ze/JrGRLg+csLZeX9aJd3cr+ZDcqs98JozYcoR1WrdbRTx6YfiRmUpM0ydjE07ZpNBZBZvvuMeXPxXAwXRlQZ/2SO+cYgPPI5Fs+YGRJYm05jwFPXwVXPy/s2GduyttLc12b1Ee8TPq3iK3KZNmBp9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTBj51uI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410cb93185dso1647525e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707663351; x=1708268151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLCtixCKrCF9DWrHtDqiQi9nNKYBgVJawTIFD8ZaWco=;
        b=aTBj51uIaB1bNxB7ztM+ZeS+jJKsGKl5aBauIfPXu8BBAsY1C/VHjMaoAx2DruEK4y
         qeYtfQVfwQMJ90pvD+D01sj1NSKh0wd8FiE51UhFPSOU7A3pz+KaB8PKMQsqLQoEJUPe
         yBEcykkiY65vMrUV4L2e9VQxCen6O/BX7Ft0ed39O0anOTGHwPDZqQmgBRkSvMd3vOE4
         ddJijlJ2sD87HraWvZV9NLNW4w8kiKhQ/JczqCCNgoWlzuYbr9qyxLiOHjNt3jbI9NmA
         LzO4/g+QAkW4un4xQzCDtUL50AStYRza2hSNQrruRfGUc/Ikv6Ja/rVr/Mqqkqjd4D7J
         VZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707663351; x=1708268151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLCtixCKrCF9DWrHtDqiQi9nNKYBgVJawTIFD8ZaWco=;
        b=uouQqJm0FgrGNpWzhFn1M0yGIxPsvfYxVYAbo8bTbCVkDz8XHb6bq5aomLecxwiqWH
         tYw5yp2V9835j+9qIsgE5rJxFu3uRuAsiTTL+oUcb0Jw+ty9B5JazOyMTy4FBMp8EM5i
         m6hqMOU7cxpTQJ0EzhUnWXus837RNCyaqQEEChFbNPvwJRNUArByKhT/AhzrDeEpBiOW
         uW1ZSJNaN+UDebyzGIByWiMGSHgZ8y7kH4fp1aWYsRVywSMk+hvLyVjksZyT8exBK8bK
         5RpIoy8lFVNkBZLN2wGj4NZCKEwOF6JWbLY/SK2hGehwn3/0dR0dmhLEFcke1ahukkMu
         H55w==
X-Gm-Message-State: AOJu0YzRY+2bc1noYk9zPf+ZN0D5Y+78t+tqqqaDUbyrUdxmn343crsW
	JMO9euu7EhJEpQBBE0FVNDob5XVAurOXyC70Q6E6WuxV84dyQeUk
X-Google-Smtp-Source: AGHT+IH5eGK62dyD65QQzY0/cVLkLg+3MRXkexDMrc3/fOEitnSW6BI9Z68fT7+uzJ60flw/CEzszg==
X-Received: by 2002:a5d:6c63:0:b0:33b:3fc4:3ac9 with SMTP id r3-20020a5d6c63000000b0033b3fc43ac9mr4381386wrz.32.1707663350602;
        Sun, 11 Feb 2024 06:55:50 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id cf2-20020a5d5c82000000b0033b7263702csm3779424wrb.29.2024.02.11.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 06:55:49 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] CLeanup scan_flags from struct ath12k_wmi_scan_req_arg
Date: Sun, 11 Feb 2024 15:55:46 +0100
Message-ID: <20240211145548.1939610-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As previously done for ath11k (see [1] lets fixup struct ath12k_wmi_scan_req_arg
to remove the scan_flags member. This prevent future use of out of sync
WMI_SCAN_XXX defines & their corresponding scan_f_xxx corresponding bitfields

[1] https://lore.kernel.org/all/20240209113536.266822-1-nico.escande@gmail.com/

Nicolas Escande (2):
  wifi: ath12k: do not use scan_flags from struct
  wifi: ath12k: Remove unused scan_flags from struct

 drivers/net/wireless/ath/ath12k/mac.c |  4 +-
 drivers/net/wireless/ath/ath12k/wmi.c |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.h | 55 ++++++++++++---------------
 3 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.43.0


