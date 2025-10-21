Return-Path: <linux-wireless+bounces-28154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A32BF8CD7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 774904F9D76
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416E27FD76;
	Tue, 21 Oct 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwfxeRLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435B27E05E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079904; cv=none; b=QXHjL657Zm8eSiOc1NfXmhqh0t2n9o8zjUMw9NsSxZlyPvW8vD3Q1b60PYSx5rWFOzJKL8TnD8h1CQiRPCWVsM0RrN/3bOJPvXsi6opUEuhhp3aQdjFY+hEUokvkC0ppxaacsVEbQA5wIxkeia/PPLkmfMjSzQDGCj6mMGyaNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079904; c=relaxed/simple;
	bh=+Y2Jj1GiO+s75T0TzpWNxFqw32RHNdRzBO5edrMZxrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML4/EY/LY/uC+DhnaG0Wek7eW2ajpkAnn2N00U4T+cvDQ+5v+m2y4Zsg8n/viyo4V3J8QDoEiW8c+GYsZffUokwAV2HNdU5wMBW33RyD0iDWaybZak2OXvtf0E2O/2zAYeUpLKB19/P4KEZYJl1JLhldv9vWo0IwO+XGV1CQRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwfxeRLs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so5664089a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079902; x=1761684702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ispyJRtg+4scBOZLQOW+pAI0FhDXiD6SPK31MSEUGxk=;
        b=lwfxeRLsGcfSKgEgvnQ9fAEhoH534sOWTPp3oYqgS+gpAM9yNB8s2RnOkLnc7/RZj1
         R+wq8fLXGyCe4NT2xxp89S5FZRnpgUP1tOoCAzeaHgdEnVSynfA8OqVok0Nnu5/53gO6
         Y072qQ0Ld3hqxoC7L9bFF156Uvtnb0gxRvwJmd5lL6xmEonx9QHSfGXllAY1zpTjq4Wc
         4N9f+6NX78dsFGpr3RZo3ew9bcESHUizwQp546eXE/na7ckuI73+fDA5+j/hLMzRafm0
         XoV4Z+RtF5EJcjyEmFqnkIrut6k0E4t2tgZ5GH6iOGVyMVXBROzfHBQ+bEs195v6yAUf
         BBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079902; x=1761684702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ispyJRtg+4scBOZLQOW+pAI0FhDXiD6SPK31MSEUGxk=;
        b=Co2EPrQw+qnh+6mNKTuMDIdly8jSdoIX6UgX+o8UC7zVY79Tb8faRpKxRRM/KTBEF1
         FL2C5nqUBM+RO31F6zAusnzWoGlrreQ8+IDjixsXepwdtgoqRLzOKbpqxpXGIzNsZAUy
         mc8+Z1oG+XfZZcoBzRofba1sYv4uHA1rmMU1cXbc8SGLBJOxNL0LsKzjLaFdK+5qKepR
         PwsPdaf5Lc3bIyLQA9xdLDgJp5QIF+xIsTRrqtYGvSqBJf/GVrE5bqXuyRSweztMHH4m
         41vF9NpaFxdZzWrTk7TeeaHQEwr4y2B2CUwgB3KhhjY1qPNDy6D8u2zH1lSxDhB4AHNy
         ls9w==
X-Gm-Message-State: AOJu0Yw1BAT3qmmQryrsvIZvcl4x1tfs6+0ECveocoPhvW9zoko9F40+
	iSWmse/5H2sOmUmJk3g0fjZOSH0SPhmYzT4zHik5b5a3Pz5vmQqCk8AP
X-Gm-Gg: ASbGnctj67CHopozegVXXAGw14CZUHlZLPYsQH11sNoW8sGw+ZO2h1/ReDbfF2adXAh
	aBX7v+LB+I48OIiKJHOvhOtTfjZySxzR9DMDzycxqpSMo/8C3jDihrE+zNiDGqvgtWJhPys/fNQ
	xuxtWIPzseuv0MMZQ1fGEAUZD/AgKgDC6YS2zdmJUYNT674H4KYORH/w0HJCVhe3w9TkrAeq/bK
	Sv1AMzOgIu4qsHpVdQ3NktleHOxyuorRkkOl/SQd0UIpmBw1adrGmoFCh+jmDmtFXdXYHE4jdo7
	fua43tfyPAzUeThwgQRQv6+CdUCTn+cFSkcR3BE/AMbSr89ZWt0Dyb7744iZkbL0z9TBjvxOrw9
	wF1v7CF6dwuKNIKE0USt5O8GOe6b0RzVI5Wb2lm3Xqyn4+jFYt+WFhmqX0/JTOjFVpnqFZsc0aM
	nQGw==
X-Google-Smtp-Source: AGHT+IE5cDGX7uh03rUXZxOZ+SUlEl4tKmukqRwyajWbA2vLSnL2ojw+WYxhnMeLzTY4g0skCcbpQQ==
X-Received: by 2002:a17:90a:e70d:b0:330:9c0b:5494 with SMTP id 98e67ed59e1d1-33bcf8e94f2mr23933561a91.22.1761079902401;
        Tue, 21 Oct 2025 13:51:42 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e222d8668sm480048a91.0.2025.10.21.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:41 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 1/4] wifi: mac80211_hwsim: remove explicit initialization of statics to false
Date: Tue, 21 Oct 2025 20:50:23 +0000
Message-ID: <f7e299026eec46adcf76cc94b7f0eb9d34edcb75.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: do not initialise statics to false

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9f856042a67a..95582345cffc 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -53,11 +53,11 @@ static int channels = 1;
 module_param(channels, int, 0444);
 MODULE_PARM_DESC(channels, "Number of concurrent channels");
 
-static bool paged_rx = false;
+static bool paged_rx;
 module_param(paged_rx, bool, 0644);
 MODULE_PARM_DESC(paged_rx, "Use paged SKBs for RX instead of linear ones");
 
-static bool rctbl = false;
+static bool rctbl;
 module_param(rctbl, bool, 0444);
 MODULE_PARM_DESC(rctbl, "Handle rate control table");
 
-- 
2.43.0


