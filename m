Return-Path: <linux-wireless+bounces-24046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2352AD6B3E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A8B3AA0F6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706631C861B;
	Thu, 12 Jun 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bi7pELAc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E71B412A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717961; cv=none; b=Rz/Hs+w20gjAjM/sRSkkFyecMywOAbYjO2ZrLU+pFkAUCHTDPnDXSRudoT0MVrfmB0IRKY98ChR40KOHAoEMbt2yDf7Rfi3W9wP2mhKndHZCUMPjsmrQVNysv4ktIA2K+Rj8ZiXYQmIHi9Z4JotAPf4gMIN9o1gskE8EmvTfN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717961; c=relaxed/simple;
	bh=N5wcwfcLu9AlsbJtqb6p3PuoyNM8HmZGrqcbr9Db6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U49sLON687v82KJuqKolOTLincnm/RAlCPlSbxaabkapG6WBaEqNA0BM3fW/mCbThRc5qfgRyz9XC+wH/lNTGZKJv7mLF/D0OaNmxjALpBJbQqCbs4WVkhM94giFY1K+EHWCftahxPQHvEg+bBqp/jnYJibQH38p+m6EcF4tXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bi7pELAc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c73f82dfso694383b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749717959; x=1750322759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpZLNWW0DOhsGzvSZThrO5Z24o9vsj5Ub5xo7XurfUA=;
        b=bi7pELAcLeHocAyOixA7yk/JIqU2qOQ1iD9UIHCEYMhyYIKPqSoFaQYmwpRM8PwlNM
         rBOWUffHCpse9GePdywFQ25luVlmVHEu83GsG2H7K6DShRCFjzr3SFuCHSTfXg8Ty9QD
         gi5CDlW9P565XyHBzNn61rVuqDkWoL0Hzn8fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717959; x=1750322759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpZLNWW0DOhsGzvSZThrO5Z24o9vsj5Ub5xo7XurfUA=;
        b=CFd3LdIfiEOXaP+FsBFGVbEgLTuWfxSlpJy6+DtbnAojOYbrjLLu+icK7TYGLqQote
         uLfKmQa+R2XEIAHIWxuaD7ARj7w8Lslzl/db8Tv7EGYwzHVGxJ8lRPiPmu+ARPcQ6+Pm
         jUW1DHyDAKlMwm129999+OqWFgk3F3UFAsDBoIr7KZpwtGZrsj1ClFovLe070wHLLctQ
         MLWVm8LHeW0RgzrwA3rFhT3E7POLmu1AxIwnH1tGXIVQ7y+WwxwUE5Xt8Ja3VKR69ZZM
         vXkx3zUK2wjZbbbSWcTgO1tQerxoP0bk9KbRUYg8Ng9q4jJxmi+bEfZ6kBtbWugpCZuw
         fnjg==
X-Gm-Message-State: AOJu0YwyYAu0Js9QkxwgD+72G9V7hCRFFJWXnIz7lme5HlVqk25hDyLS
	qjcQtY4HjHCA5Gx4J0pKf1G7G2o7VTO7zea5gIwtlIKToI+R4Gh4NxQm1PBnFKwo4dU+GHi9jwl
	ZRA0=
X-Gm-Gg: ASbGncucEXm40fWZINwbG0q6oAPGyUJoWW5NDLgZj9zib1iVtwueai4RGtj9RV5R62v
	cdQ6u/NQK4gKhmYDHwCUrNebkv9KYT4g5rTZaISGScrVVl7cW8pHhsABuO8huhiAEjRmSzwhC9B
	PuvvDPZhK3foQrCXNjeN9r0/TcHWG7EoaNGURy3mf6vVPOSWwGwdLcEGJj3I8FOeH9K8Lcx6ugu
	nvIl6OihBnZkf8CW0/bfdI21hnJw8+Gu087n34TbnSjc6QEwgM3ic/gU93HHmSccYye1KuEy7r3
	jA6svY0jzVxmYd6Dw77IQmnTbteHyfG1+Kr0m10piFquFiKJq1khmdmXibUONS9xk+KKO5oK02V
	FAnc+jh9DEBw=
X-Google-Smtp-Source: AGHT+IH+WHMtXn8bwbKfQnFjtwXx1iGxMWnJkL+ndCJJX/b5xWKBlUyZSGGvyl1WSRHTr2d/Tewnww==
X-Received: by 2002:a05:6a00:8593:b0:746:1e35:3307 with SMTP id d2e1a72fcca58-7487e22c268mr2650354b3a.14.1749717959076;
        Thu, 12 Jun 2025 01:45:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:fcb5:79e0:99d6:8d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74880a10152sm933200b3a.172.2025.06.12.01.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:45:58 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed srng lists
Date: Thu, 12 Jun 2025 17:45:06 +0900
Message-ID: <20250612084551.702803-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a number of cases we see kernel panics on resume due
to ath11k kernel page fault, which happens under the
following circumstances:

1) First ath11k_hal_dump_srng_stats() call

 Last interrupt received for each group:
 ath11k_pci 0000:01:00.0: group_id 0 22511ms before
 ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
 [..]
 ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
 ath11k_pci 0000:01:00.0: Service connect timeout
 ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
 ath11k_pci 0000:01:00.0: failed to start core: -110
 ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
 ath11k_pci 0000:01:00.0: already resetting count 2
 ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
 ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
 ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
 [..]

2) At this point reconfiguration fails (we have 2 resets) and
  ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit()
  which destroys srng lists.  However, it does not reset per-list
  ->initialized flag.

3) Second ath11k_hal_dump_srng_stats() call sees stale ->initialized
  flag and attempts to dump srng stats:

 Last interrupt received for each group:
 ath11k_pci 0000:01:00.0: group_id 0 66785ms before
 ath11k_pci 0000:01:00.0: group_id 1 14485062ms before
 ath11k_pci 0000:01:00.0: group_id 2 14485062ms before
 ath11k_pci 0000:01:00.0: group_id 3 14485062ms before
 ath11k_pci 0000:01:00.0: group_id 4 14780845ms before
 ath11k_pci 0000:01:00.0: group_id 5 14780845ms before
 ath11k_pci 0000:01:00.0: group_id 6 14485062ms before
 ath11k_pci 0000:01:00.0: group_id 7 66814ms before
 ath11k_pci 0000:01:00.0: group_id 8 68997ms before
 ath11k_pci 0000:01:00.0: group_id 9 67588ms before
 ath11k_pci 0000:01:00.0: group_id 10 69511ms before
 BUG: unable to handle page fault for address: ffffa007404eb010
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 100000067 P4D 100000067 PUD 10022d067 PMD 100b01067 PTE 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
 Call Trace:
 <TASK>
 ? __die_body+0xae/0xb0
 ? page_fault_oops+0x381/0x3e0
 ? exc_page_fault+0x69/0xa0
 ? asm_exc_page_fault+0x22/0x30
 ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:6cea 4)]
 ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
 worker_thread+0x389/0x930
 kthread+0x149/0x170

Clear per-list ->initialized flag in ath11k_hal_srng_deinit().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v3:
- updated commit message and subject line (Baochen Qiang)

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
2.50.0.rc1.591.g9c95f17f64-goog


