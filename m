Return-Path: <linux-wireless+bounces-11640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357069576C7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 23:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7380284BC1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCCE1DF691;
	Mon, 19 Aug 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0RxjCQV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2981DF684;
	Mon, 19 Aug 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103934; cv=none; b=LnY3gj5k+VHrsZbWET7ZdAw8lTv/qMiL23TD0979oJRA+sY/+oboQsIEpItO0NM6CC2cKwaMorZUif9xO9s+46PWGqujXPuecJL/l7vRJYTu40bdOTIIQuSRYo1vmaQqACB4pJSOhWJtGByoyYf9rfaatsN8Vvn4I3Vs963mS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103934; c=relaxed/simple;
	bh=uFKjpSKWuJr4EH1NYhsVClFE8GCC/v5Fjf55YsSRT2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAQaHWc+wIacClSE2nTJWkodSsGPc9P6vqXdu+eJOgoHeNMlumJG6ZfJofATjshbykVKkbNK3ZKU0EhgJNkYD5XN9Rkl0fnImAEtnQ4YEy5fPFzuysiptSwEsm9rHSQUwwsDjX1K6SJWY2QtJoDAwmpVeR0FORXKcpb5552x/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0RxjCQV; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4fc92316dc1so736354e0c.0;
        Mon, 19 Aug 2024 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724103931; x=1724708731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qcuV1/bhqx2+PhvCkmyGByyF97mh0J56XinoCbmJVs=;
        b=k0RxjCQVjDcQ8g1bFFt4xwZrlu12mhTtiQ9w3MIVFsHeMmsRnRcroB4Jrf/V9ABmN2
         0RiwM3OymTQISdv23w7x1TIOKRpJ7DRSPx0hSRHfhJH/ITU8iUkE7lOPAeq69c/pUT1e
         hyybaDo3BHByrk6uj8tKEFl01U7V1rPlOnDmZpj8eMyK9y0G3TMcipgWYJEGu3x0oDgu
         FHnYR9T6YgRVF1njsBvxwfKq+ZvV+RCOdbNbED0xefIw9rR0JwTUxZUTWqJPtvnpxpNp
         o3E9NuTXqc/k0XTn2iLuWtmNmsN9Nl+rvqKnOATqb13XLPaK3ufnmovWvWCLDno7SsAD
         7knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103931; x=1724708731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qcuV1/bhqx2+PhvCkmyGByyF97mh0J56XinoCbmJVs=;
        b=QG5REMbJLDCBtrMfoFXGBk7qyF4issv4p99HSjaUTJgRTbMRNJCqHr6/1XLBxwah3F
         9EBcWAy7jUkdn0z6pwbzfCife5L2ePXwoxktswVEKtBTzMPfOvgTHLGT78cbV0ExfN60
         0FTnxBYpJYC3zvFJkNJN7a5RqTu95385j1lyMe+lR4MDGMFyVueSiaNNcE0CH0dc6zw0
         ozUHgxYZ/eoomGMHe0P8WjE1EC3FIXX0UPQuozA4omP42kZ6DgJbXAbqT0cc3rMdnxgW
         0OXP5IbU4xS5XS4EkE8z79+yuGmOAARABOrjm6QUc78Y8N/N3N1yoife5S2V/kHckC6F
         W0fw==
X-Forwarded-Encrypted: i=1; AJvYcCUjHpCsICFfjWy5giPvZ8U5zJQ0LWrF+YcOkDykY5tFMhVnObXAZBs5CDQuOHw3KUt4vzCbBmshaMEqs00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiPDmw1mVJ8Nk7v1KZyCsLNE8/Z3tvv7x2F7v53Ba5uf5/LAf
	yjJkj4fw3DC/XVioVefS5hEvB9546zw6sEk1I0riVKKRkKN7MgqpY+SntgAg
X-Google-Smtp-Source: AGHT+IG4fdIKPSGpi6znwnl/h3AS6FOI/WdXtROuRME6Jw3xsWRPAiOCcwMFgbT6xkkgL7eRnITVcA==
X-Received: by 2002:a05:6122:c94:b0:4f5:2c0c:8528 with SMTP id 71dfb90a1353d-4fc6c9d2fd2mr10081343e0c.11.1724103931211;
        Mon, 19 Aug 2024 14:45:31 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b9c872fsm1230429e0c.46.2024.08.19.14.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:45:30 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH v2 3/3] iwlwifi: mvm: Replace spaces for tabs in iwl_mvm_vendor_events_idx
Date: Mon, 19 Aug 2024 16:45:20 -0500
Message-ID: <715c74c74b336bed81e92e1336bd1a6ddb7b90ff.1724103043.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724103043.git.soyjuanarbol@gmail.com>
References: <cover.1724103043.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch replaces spaces with tabs in the affected source files to
adhere to the Linux kernel coding style guidelines.

This change is purely stylistic and do not affect the functionality
of the code.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
index 080a1587caa5..0f7fa6032c66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
@@ -104,9 +104,9 @@ static const struct wiphy_vendor_command iwl_mvm_vendor_commands[] = {
 };
 
 enum iwl_mvm_vendor_events_idx {
-        /* 0x0 - 0x3 are deprecated */
-        IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN = 4,
-        NUM_IWL_MVM_VENDOR_EVENT_IDX
+	/* 0x0 - 0x3 are deprecated */
+	IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN = 4,
+	NUM_IWL_MVM_VENDOR_EVENT_IDX
 };
 
 static const struct nl80211_vendor_cmd_info
-- 
2.46.0


