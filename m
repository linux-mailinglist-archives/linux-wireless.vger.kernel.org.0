Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B0462EDF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 09:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhK3Ivm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 03:51:42 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45026 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbhK3Ivm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 03:51:42 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 03:51:42 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3G2T0zRrz9vBtt
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 08:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VH24IJHaAFRa for <linux-wireless@vger.kernel.org>;
        Tue, 30 Nov 2021 02:43:13 -0600 (CST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3G2S64kgz9vBt2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 02:43:12 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3G2S64kgz9vBt2
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3G2S64kgz9vBt2
Received: by mail-pj1-f72.google.com with SMTP id p12-20020a17090b010c00b001a65bfe8054so9415268pjz.8
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 00:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2+HpAwDa/HBxXc2VVtjYSYS1Y8V8tVj3abGe9wGHDk=;
        b=EdYA5Q2GIemYjDJPqF+oyaUvV3P5LSX4m2c2Kd71J8lrsdewKdAelfbMsXMWGixvrE
         ceKGqkzdfu8BTzITpU7Bm7eMLDRwZt88KJfPHAoCldicPib4kTbctWhbM4Z0CVSrYQ/8
         vGzBDlg9UraEEmBUNVNcH8xEhdqXIh/XQsxbCHVdsGRvu4JXwsVeyXY975BWku96n/c9
         5AzccnN4ccJtbQUCTa1LR8sTLof+wAgnBHqGPsmURKhn5E9qvuMok2t9/t+ywJdKUv8x
         avhvMdfqPYAzobUSeT6iNOln3B8KwSyqpIXxQCh34ZTuPOoxxHEFw/CLdOrLZt35x+S1
         MAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2+HpAwDa/HBxXc2VVtjYSYS1Y8V8tVj3abGe9wGHDk=;
        b=0BIZi3FQ+Tn+aYPiVYSNu+ZvM/YwNFoKjdO1t/bn98q9+oJ1a2Mz+yx8rrNk8KeAfM
         Gz/5E0yISTKayGlwGKK7dt1uBUm63LxGFk1hfum3eAm+RjX0JeMmGam/yzToIc52Whlm
         JZ0YjI3c45QaXERutXpz5bBvPkIhWu1si2vIYQ4HZ7bzn1A+CEPRuCin+Mkh6vTbv6jG
         BsgFA6Zj8m4/58EUMnaF7Y9IgmxmD6IzdVj5kOFvXMOl7kjfqSW3ya8kG9kebEE/u21j
         HCYJ+tsICBqj7OCUvYCLJIHfQQfuMDBnX5rsr6MJJkacwL4XpdK9ejRHnPnvZpCP47li
         t6SQ==
X-Gm-Message-State: AOAM530HsDGGY3sCk7oKD1loFfTraetQDi1pnWpIBaZQDe0KHTMVi6/z
        WXAKlO9C0ZQumXXHcrhYmXF0mkMbzAtLrrnL4UgnDe5TLpcalDQZEbRsiilgvrIyhnRu48HdU8p
        mWk2M0FZqH+87yQMYOI00Vz0fSwJ0bsQ=
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr4344413pjt.168.1638261790916;
        Tue, 30 Nov 2021 00:43:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0xFxpS2KHZUTUB75/FtM3PAAx67zjQxerMVpND32xQFqaPgXo3bBmJYOsoiUb/JCP/+UwFQ==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr4344381pjt.168.1638261790641;
        Tue, 30 Nov 2021 00:43:10 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id d2sm20962168pfj.42.2021.11.30.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:43:10 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath11k: Fix a NULL pointer dereference in ath11k_mac_op_hw_scan()
Date:   Tue, 30 Nov 2021 16:43:04 +0800
Message-Id: <20211130084304.72160-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ath11k_mac_op_hw_scan(), the return value of kzalloc() is directly
used in memcpy(), which may lead to a NULL pointer dereference on
failure of kzalloc().

Fix this bug by adding a check of arg.extraie.ptr.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_ATH11K=m show no new warnings, and our static
analyzer no longer warns about this code.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/net/wireless/ath/ath11k/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cc55602787b..095f1f9b7611 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3237,8 +3237,13 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	arg.scan_id = ATH11K_SCAN_ID;
 
 	if (req->ie_len) {
-		arg.extraie.len = req->ie_len;
 		arg.extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
+		if (!arg.extraie.ptr) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		arg.extraie.len = req->ie_len;
 		memcpy(arg.extraie.ptr, req->ie, req->ie_len);
 	}
 
-- 
2.25.1

