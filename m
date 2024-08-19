Return-Path: <linux-wireless+bounces-11637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E551E9576BD
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 23:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B20F284C16
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A21586F2;
	Mon, 19 Aug 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTZ+aLOP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0A25760;
	Mon, 19 Aug 2024 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103923; cv=none; b=RNPyxB8VYcn8qItVacONp3zJZMhuzlS2k7l1iin87v+N7teIZF/VHI7/LQMJ644gRiF+nGiA1XRR43ve7SvP+EQJZDdh3ojKKkqGtNutSM3HuABAfOwCcCHEm32eilKtQLm4PmvGih+Qtcjk1/nV33vIzrfl5IAsNMVIaCU2Uqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103923; c=relaxed/simple;
	bh=0H8+ikLi4lrFZVnF+jXcoxeqTcE8H64NOLNsMmiXH70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TFt8clxxNOSlx/DvOWWSituCWLqCjijazUh5oagqs9nrvljghhvNDs0uR2TWsp1sOf8CsQibpU+CmLn5cXymSkjaqTZJsX0g288z74YFgaHiP0dIcLJHiwe+xWP5kL5W0MZZTtvjR2/UcwD3VSdBCaMJU4S5cpv1gxwALqCnZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTZ+aLOP; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f6e36ea1ebso1589618e0c.0;
        Mon, 19 Aug 2024 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724103920; x=1724708720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaIOdf2ae81aj/Z5O1WuMlZRHKOIrOr89FLA7Smxl7s=;
        b=aTZ+aLOPqFvp54Nc2kxW+N4rRx6qP/R4ovYyUKTACpptvOUPC6qQGik5QeZDUl+PAn
         Ck2bXBcUCeOETmNA+knoWkcEkKulSjAwEdHby/e/Bh8DYYlyLxiP4GH9u/VgOw5Nqoev
         AsMsiAZgEmr8Qim0rE27q7Rxnzz/c8khmlT05i9bNxVM4jFAU8nEteYYbRtLtGpjkGuI
         U3COHzdSBsODwxqA1afc4PTR2ylEjr0eX3LxnC+J0XE6i8bXdWHNUtffq2NooBKsysj6
         jiKMXyMVSP8Z0V5HwZ3OoQsYmaoFP7mlP1pAurhvblmgZNebNR/4SadwTFoUvhg9ksqE
         nfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103920; x=1724708720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaIOdf2ae81aj/Z5O1WuMlZRHKOIrOr89FLA7Smxl7s=;
        b=BDCVdAMyHXRGYyAqBp84BGR9tf/1X1ghnjwKCBhJqsV6hgIYNZiIFYQb+O2TBYxnpm
         vS25ojYeOMTVoi2s6c+jax0R1uHcvNA5zQ5DJbG5L7dHlSmcuARquf+OrH/pgZa6V7O7
         zlAidDe+tyMT29s62MtaPCxySdUP9m+vwR3z1f8py8ODSB6MdRJlpxpdDmfVhQzrmyjh
         k0ege4guynuftOpE4F8B9EGgGyh/eqeC1kEZkEO5hBovZuPDZSlY6kgVDV7WERZaz9Yt
         kw5y0WSfmZfxSsduonr0VF93C4YP974XY/YMbDpEInGM/UmQvudNERRyxfSCJWXUueed
         uzCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwVgJ0Uz5Mw63vR1Fn8glbw2PAyOrprya+MC/fGAyv/Hc6Q67QhIkG3U5wsp+7GnEqgB7+Na8AuljxTa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4D9lM0f348DFKi6uug0tXRoTwYMIjHDpUZoSbPOseDvGIrND
	q/kKfnWdaUgncWH1L91AQA2nIYpbnUt3ZlCaK7nh88MJXWQ1+tzebbsbb/Eq
X-Google-Smtp-Source: AGHT+IH6RbvwYHHK5ciEI0pst6ZQEkJ8YxAi8y1A/ELyuZV7JU/fdwk0mwetYIzCrot0rsD/zfDmgg==
X-Received: by 2002:a05:6122:78f:b0:4f2:a973:8ae with SMTP id 71dfb90a1353d-4fcd8a4d62emr561872e0c.5.1724103920638;
        Mon, 19 Aug 2024 14:45:20 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b9c872fsm1230429e0c.46.2024.08.19.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:45:20 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH v2 0/3] Cleanup: Formatting iwlwifi driver
Date: Mon, 19 Aug 2024 16:45:17 -0500
Message-ID: <cover.1724103043.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Code Style Enhancements:

* Pointer Declarations: Improved spacing consistency.

Macro Improvements:

* Enclosed multi-statement macro in a do-while loop.

Formatting Standardization:

* Replaced spaces with tabs in iwl_mvm_vendor_events_idx.

This V2 fixes the compile issue. I had a small confussion with my kernel
configuration. Now it is tested/compiled.

Best regards,
Juan

Juan José Arboleda (3):
  iwlwifi: mvm: Improve code style in pointer declarations
  iwlwifi: mvm: Enclose multi-statement macro in a do while
  iwlwifi: mvm: Replace spaces for tabs in iwl_mvm_vendor_events_idx

 drivers/net/wireless/intel/iwlwifi/mvm/power.c      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c       | 11 +++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c |  6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.46.0


