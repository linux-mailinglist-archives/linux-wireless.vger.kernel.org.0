Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731DA48FD7A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiAPOmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 09:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235446AbiAPOmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 09:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642344138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JRRT3Yl7+f6HbkWI411SEh1HSKqxqkLW8Pqe76fS2Gs=;
        b=c9r1HtrTQmy2v1uvmEc51TO9JD0VGcGfRwEieTTj7+/i7fW8hSvp01ZMXM3nTS/kGfxhdU
        dPmJWURTG5V8dFDz9Hye8ztv24Sq/YvlqUo5undOKcVRvhzNTzP5CdeoexEARaIVvqrJ+I
        g2m/w3pCCrCpIhCfnyTSXwDUZ6I8os0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-r9cj2sq4OhSpkIV3dSnjRA-1; Sun, 16 Jan 2022 09:42:17 -0500
X-MC-Unique: r9cj2sq4OhSpkIV3dSnjRA-1
Received: by mail-ot1-f70.google.com with SMTP id 30-20020a9d0a21000000b00594d9ed4bf1so2731869otg.23
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 06:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRRT3Yl7+f6HbkWI411SEh1HSKqxqkLW8Pqe76fS2Gs=;
        b=AwNCI2Y8hgHrYHBhxSyhw5UrcTsuN2f4MxWCsS6z+3uKdaLFENJV7IUcn2SjZHjXex
         3FIpVaJHcfRFMEVXosA/7hlH1tl3N1VGsLXidIWJnaSXxU/WmGsioPVHkWtWyzx3czS3
         NgeRYAUJ/uNlIKtuu/keg8y/FMekUdGcE5Ss4qwNrvOQ6vWwsOoc3t4zwhz56qNcyJEl
         z8b4yhKbWsHx+pgw63So12Eln5FfLUNV5nmJ10nHPp2AdMzma4r+Vi4FlgRKVKh23V09
         sraqgrIg1oTlRXg7eah+RuDoi/WwYT+qExTTGNEOgf0ZELLPqHtPuqtQQ9kWbgWobT/S
         uCHA==
X-Gm-Message-State: AOAM531jF/E39a7zn20iTafFRhURJKjULakPY8eTUiv8ddNetTanmSiO
        OCo13boegsmudzIxbpDVj3uheHQvjIqVSC/DcrPTBh5PfgPiaHZpF8hwLDaAIgqURoRiZmkgCtE
        3uP9TNqcLwECDpsSHyxih+WGHcM8=
X-Received: by 2002:aca:1c16:: with SMTP id c22mr4588770oic.83.1642344136529;
        Sun, 16 Jan 2022 06:42:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrmwZp7l+rQuzj7d+eeD89HQdHOy2AEvZ4lDFXM1Xjeb9/2maMuS4teFTtAREUYd6VJgPcwQ==
X-Received: by 2002:aca:1c16:: with SMTP id c22mr4588753oic.83.1642344136355;
        Sun, 16 Jan 2022 06:42:16 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b22sm2168045otl.24.2022.01.16.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 06:42:15 -0800 (PST)
From:   trix@redhat.com
To:     kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, akolli@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ath11k: fix error handling in ath11k_qmi_assign_target_mem_chunk()
Date:   Sun, 16 Jan 2022 06:42:06 -0800
Message-Id: <20220116144206.399385-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
qmi.c:1935:5: warning: Undefined or garbage value returned to caller
  return ret;
  ^~~~~~~~~~

ret is uninitialized.  When of_parse_phandle() fails, garbage is
returned.  So return -EINVAL.

Fixes: 6ac04bdc5edb ("ath11k: Use reserved host DDR addresses from DT for PCI devices")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 65d3c6ba35ae6..81b2304b1fdeb 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1932,7 +1932,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			if (!hremote_node) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
 					   "qmi fail to get hremote_node\n");
-				return ret;
+				return -EINVAL;
 			}
 
 			ret = of_address_to_resource(hremote_node, 0, &res);
-- 
2.26.3

