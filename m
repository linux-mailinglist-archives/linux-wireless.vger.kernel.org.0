Return-Path: <linux-wireless+bounces-9324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B87910FE3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41738283FCF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5C1BE856;
	Thu, 20 Jun 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRXaqcR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB01BE840;
	Thu, 20 Jun 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906262; cv=none; b=d9N5yWNgxYswk6Hi02Sc6OCXcAp4xXtWVZkuADBa5O3dWTwa/TDElebelKNUOLJ38CK+Ot4/RD68mZdTCR1qteyhMsxrx1K3tSRtnIXF27UPiRRpM3c5SXdnyCHU08MrEYy7C3W+JdQ2DrvX2OclsXv71ywCqrlz0SJa25Rcedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906262; c=relaxed/simple;
	bh=oWm6wtDkPUXuudaVdlEMN+qr0+C3Zd/WIco5LGbYaIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1XugCCgOsxr6W4HJYPok6PrTi3e2Qprc0O49Cr5dnhPw5xxox5SVXjLANTl4R+94jqMo/lkcbWN9tt3WB+58aw2JGzKtSX85d82Hi2P+QmOetKfO5GKApR8ohcquEO7JV2wLosP2qe2azNvw0U6pHLfmyXEifstR6kAF9DVQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRXaqcR5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70631cd9e50so996929b3a.0;
        Thu, 20 Jun 2024 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906260; x=1719511060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyCbmEERBgdbr2L9cnI5uWj+Q286mUzZnK0ig6JQYFg=;
        b=eRXaqcR5hxFD/igTe/+gznaNKr0e6drSDBzoiknRHGsVwZ/u3fIswf0SEZieOx+gcj
         y5cSdi8j5Cu5QAMdsZJSn/awgVaV6k3lGOR3I9io2P/AC2zcgKzEV+LOpLANVhvj23v3
         OtFS678cInEWEUwXlqo9/H/ZB4cso/VXTwdFsSzlZvArzWYiNRqnpwqgvy3IZzoq3wj5
         oqVHNeWAs2r+UPs3ksm1JzwDJnEedwfKixRJ/dRMGVxW5NokTPjCfDBbY1aEtPh7kj1K
         HDCxwK+xvZskgdkbL9NnGOCUxeXDUnz3o9Jn8gz+fY2ozk/EgwOYSqw95RtiZ6r6KH52
         eHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906260; x=1719511060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyCbmEERBgdbr2L9cnI5uWj+Q286mUzZnK0ig6JQYFg=;
        b=qnliM5k1yKarEyzs5tsHiLwA7KpR4WwXBoPGA+TXK7vXMPvWX3KOwAtn29QeWQdBNC
         4onNHjPRuZcqEjYupvohCTIFP0M7PIU8qaGMwFpuqlSXBUTSnzItMDw746i6IY9z4E9s
         jF0e5HBxy2j2yu+aetnc+ICC/dPEWN+ef4oGP4GWB9NsGxe0XkxqZJlWTTAOlxgn6LnS
         yGpL1Z7UsEcXP8KekB/ScmKkpDIvCurtmOblH7DmiTXS/xt2vWG7OdAnzlJSZBVVgND3
         vMh0DjcdNiIW2EkYkslWTv8rVYrtK7B60NCbT4MLPKLPZ5j4cV8T+JLIhANnWFIMPrCh
         +2dw==
X-Forwarded-Encrypted: i=1; AJvYcCXyE4YI7TkYJ2cuDZM/1Qi7pAYtDoYWxlR6B2n7sBNx72awKsqPeuUKZzua2yuNYqCI8SVf4XReVXnf6NIfjoVPkmyyK1fIr+ua9obaqEA=
X-Gm-Message-State: AOJu0Yy2/GudJgIPyXCfx52RKwyD4kUp9V5jUwTM8Ii+uDzZBtgiNKXg
	gkoQynfCSR8H81XTmhT0HCiuFR0d8by6aAESu8PKCoIgZQRK2bfbuXRdUPwLDMc=
X-Google-Smtp-Source: AGHT+IF6k794+bXj65/GLuqQFCenpTYt6QZL4TjH+FL/9upfIcGTU3RlCoM3IuIh09X+vOAPLBF0ZQ==
X-Received: by 2002:a05:6a00:2f49:b0:706:2acd:405 with SMTP id d2e1a72fcca58-7062acd0449mr5420295b3a.31.1718906259963;
        Thu, 20 Jun 2024 10:57:39 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d65csm12619770b3a.102.2024.06.20.10.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:39 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 11/40] ath10k: optimize ath10k_snoc_napi_poll()
Date: Thu, 20 Jun 2024 10:56:34 -0700
Message-ID: <20240620175703.605111-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath10k_snoc_napi_poll() traverses pending_ce_irqs bitmap bit by bit.
Simplify it by using for_each_test_and_clear_bit() iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 8530550cf5df..d63608e34785 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1237,11 +1238,10 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 		return done;
 	}
 
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
-		if (test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs)) {
-			ath10k_ce_per_engine_service(ar, ce_id);
-			ath10k_ce_enable_interrupt(ar, ce_id);
-		}
+	for_each_test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs, CE_COUNT) {
+		ath10k_ce_per_engine_service(ar, ce_id);
+		ath10k_ce_enable_interrupt(ar, ce_id);
+	}
 
 	done = ath10k_htt_txrx_compl_task(ar, budget);
 
-- 
2.43.0


