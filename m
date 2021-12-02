Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08346674C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359269AbhLBP5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 10:57:22 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:52994 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359241AbhLBP5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 10:57:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J4gVX6Wb2z9w99D
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 15:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zYm4366kgeyB for <linux-wireless@vger.kernel.org>;
        Thu,  2 Dec 2021 09:53:56 -0600 (CST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J4gVX4mjcz9w98x
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 09:53:56 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J4gVX4mjcz9w98x
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J4gVX4mjcz9w98x
Received: by mail-pg1-f198.google.com with SMTP id 14-20020a63144e000000b0032f07c8df95so58807pgu.9
        for <linux-wireless@vger.kernel.org>; Thu, 02 Dec 2021 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3zoBlZxTPRde+g9siLNuGgPLd+nbCtyGK7PJZtAzXw=;
        b=pW66DglKGJex4eJG5S3bkebOToXrAxAMRF7n4cPv4eCwz/vzdbuLvxm2zn7D9QQexs
         eh2wLt3b5PZNHt9uCChMdSQOsxJ+0MtpTROcQ4bOQkyxv/sfgmqyWYx5yfjbRnglUybE
         6smFSTVOURVlEb6CwGbmknMJ1OSPph3xAeH/o+32vFW/zfJGhnGWbQy64kApRtqtVJBH
         BGn+DydsJGixzmeedfGDJDPc057n3UY3hqqiaaA8fU2D+pYzmelOqarKO0GpjIxhbWp3
         pYI1XOdujSpjtrbilM8atNfSJ3yuFa9521QK3zWgoresL76ctEItdU209ujAtDnrCIqY
         1n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3zoBlZxTPRde+g9siLNuGgPLd+nbCtyGK7PJZtAzXw=;
        b=yWqAK0yTMEScmomEZhwVWEExERzr8+wbwxtVSdptdAhrgaid6kP+V8jMtQMGCE831G
         5upsjU6BYbegAC6F5CjWvuVjMQvAdtAqj3CEbvdAs1KuWEr5YlX7Wt0kTUdQgeQlMcHn
         cDV2ae0UUggUq2/EHETPC8zYW++P8hfQ9idMBLQC/N1ePjBcwg36qEx+LD65EZZSwH/t
         NSUAdEgXemvwLHVcltADfGzhokrn82wQvlvTUAJvSTdAcU+PGGih/XDtnYr1MZpA2+sW
         YOics2RzwVpvcoWZJ085tD2d3XJIJ6QIcmN7F+WuFtgBKz47wGLTN2RtXg1jzejQVqcu
         ZAYg==
X-Gm-Message-State: AOAM5330UyvqF8tBkEZDHDMDeMKGd1HAtProNAG/0ohcipM8ruZGxKrg
        EUdMo0m3TNr5giXRywdqlI6WDtVKfl8ujCW/nFZPDyn2qIFFYxwVqimk2eOFtml83kJqIGa5Fba
        x6FNoJGPZ2OLexW0I30tWzG87EW4+D94=
X-Received: by 2002:a62:7a54:0:b0:494:6e78:994b with SMTP id v81-20020a627a54000000b004946e78994bmr13252855pfc.5.1638460435882;
        Thu, 02 Dec 2021 07:53:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXmzC6zPzMQWzj5Zn4utpm5MsgA8OcVZjno+y9o8C7JA4+WJDkDp/FfzK2BpQf1slpLD7V9Q==
X-Received: by 2002:a62:7a54:0:b0:494:6e78:994b with SMTP id v81-20020a627a54000000b004946e78994bmr13252830pfc.5.1638460435652;
        Thu, 02 Dec 2021 07:53:55 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.212])
        by smtp.gmail.com with ESMTPSA id s21sm240877pfk.3.2021.12.02.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 07:53:55 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        kbuild test robot <lkp@intel.com>,
        John Crispin <john@phrozen.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ath11k: Fix a NULL pointer dereference in ath11k_mac_op_hw_scan()
Date:   Thu,  2 Dec 2021 23:53:48 +0800
Message-Id: <20211202155348.71315-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a29a8153-2a4f-1876-ec48-47e08db00a98@quicinc.com>
References: <a29a8153-2a4f-1876-ec48-47e08db00a98@quicinc.com>
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
Changes in v2:
  -  Use kmemdup() instead of kzalloc()

 drivers/net/wireless/ath/ath11k/mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cc55602787b..dcefe444e7e3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3237,9 +3237,12 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	arg.scan_id = ATH11K_SCAN_ID;
 
 	if (req->ie_len) {
+		arg.extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
+		if (!arg.extraie.ptr) {
+			ret = -ENOMEM;
+			goto exit;
+		}
 		arg.extraie.len = req->ie_len;
-		arg.extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
-		memcpy(arg.extraie.ptr, req->ie, req->ie_len);
 	}
 
 	if (req->n_ssids) {
-- 
2.25.1

