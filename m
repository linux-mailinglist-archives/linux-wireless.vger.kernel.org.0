Return-Path: <linux-wireless+bounces-23484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA21AC76E9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 05:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956A2A23570
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E041B6CE3;
	Thu, 29 May 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/OkPjk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823DA24C07F
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491037; cv=none; b=ZfeHC78j47QVgiHx2MqkStX/IugmlLBdOG2YbBhuX9xvUa9qPtjQoNKn3NGUUdAV/gac8MBNXakpVhK10hxsKQjNg2W4WbslymwSRdZyz0ULys3QLgV9BEPRyGiiOAh5KAphdOoCx9E7sf/5CLA61huiTzrVrq81x6KvjzWWV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491037; c=relaxed/simple;
	bh=qeSeweZV4uyYGTBRpljsHzDiuUT9QNThQucSYH9GwD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3O5XwDgOX9DlIMfy8CRNoTNpfQYhVsgx8d9GODLGqTHEnAQQttNizFLzRsvTmqzfZMwXAiG2UprSZgmvDuwqruEjLcc9Rb1mYlE6hGLfPNn+qNviW0/1jaG8a/bvwJX8TQLYafV2Roiotjnp3pvyVVM/mhIZnuMJAviXaTyJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B/OkPjk0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231e8553248so4913975ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748491035; x=1749095835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujQ501UPaq8iguu/+DN99t0pQZyaz+0Ycpf8UljFkFE=;
        b=B/OkPjk0DGFJrnckvysxsmdVZI9uw+Axc+26ONkueUiFNLW66ULZWD4p4K/JfsNvi2
         HEX5D3+oNGtuxJ8k7kVnN7m6mzcrtbXRA0YQx1oJeUPfMt5ctOZUmCPadfM+1Ud6zHsM
         StHNvowleWCipNU/aUcZO2hRJHs/dkArpunv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748491035; x=1749095835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujQ501UPaq8iguu/+DN99t0pQZyaz+0Ycpf8UljFkFE=;
        b=wn1reMtlJ3LrIZ9XSZpDtIk/SBWNyzNwe+Hf0Oc2oyTdvofy49O0kkaaGz/a4LOt3U
         qk7xKT9fsRCxLpeQ8bh7mnl/Sj6V869ojBRDIkfwHZjYH1NMqL2wIW1MOETJxZWHuJ3I
         leaWUocX1ItPwNLqqt9ZISMAA2FAd/yz4ZaEg/5enJfGWK+dhw8PQ00fkUQnHUo5+0U3
         20OXiXDRwLaYCRWM5/Kdx2s4bsq4ZdH5umVhn4P+TwGzOFbueyJExG7FMJxoqAg7Xc5R
         Xq1ObQ+pp9Okn2ITLG7qEBvGjzLILLPqKf9ZdY4Tpj0z5U+3Aig+Nzhx3yLj88WaJnqs
         8q7A==
X-Gm-Message-State: AOJu0YzLFJKKwWSD9GMdh+sUxD5JzIhj4raevd8imtpuMCKB7QpSe3WO
	4XN2g1+bcsqfAhtvvwi2E62gl218NKZ99/ekavVZAGjoJRrWP/QbPoRMWFD+48t/mw==
X-Gm-Gg: ASbGncswuTG2OhT85frUdc4QfgVkq8rHaS6pVx2GCnkZtW50yfiMqvF3JpMaGx3LnAM
	WBg4lNLxU9K9VQ5msmerNv7UHODaPyx+Mu9ehMDeoLqCR45dLilgakPFprrk9K23YF67Oa3Yd/h
	fkeXhy0+Me286D67y9pTj5H+ZKstjf0+HcdETn/j0CwvY3ZjQsltItxUTM2w+FfEFrz+oj0Gl9N
	ObvFf51rslhd3yFB2UINaXGadoNAQIrnQ7JSWOz4vETCOvpCzL2MvjyEjpQkYKpm6OGZxe3CvV3
	aJrLCwe0aJlusShxSWajaeZNnc8wqpOaAWTPORi5J4zfeRi8a4t+xorv7jmOqqtGM6Ad2miSaKh
	UiPKzCtdvwwM=
X-Google-Smtp-Source: AGHT+IGIABTdusK3hOipL/Wbdz4EXI+YD5CIdyPMuRvBzLsXeRqHjKpFqiBUS36SMFASd9Lh/nCNxw==
X-Received: by 2002:a17:902:d2d1:b0:22f:a932:5374 with SMTP id d9443c01a7336-23414fc9852mr336996785ad.48.1748491034584;
        Wed, 28 May 2025 20:57:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c024:f903:4009:8c8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf5179sm3488735ad.190.2025.05.28.20.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 20:57:14 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
Date: Thu, 29 May 2025 12:56:43 +0900
Message-ID: <20250529035708.3136232-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath11k_hal_srng_deinit() frees rdp and wrp which are used
by srng lists.  Mark srng lists as not-initialized.  This
makes sense, for instance, when device fails to resume
and the driver calls ath11k_hal_srng_deinit() from
ath11k_core_reconfigure_on_crash().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v2: fixed subject line and updated commit message

 drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 8cb1505a5a0c..cab11a35f911 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
 void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
+	int i;
+
+	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
+		ab->hal.srng_list[i].initialized = 0;
 
 	ath11k_hal_unregister_srng_key(ab);
 	ath11k_hal_free_cont_rdp(ab);
-- 
2.49.0.1204.g71687c7c1d-goog


