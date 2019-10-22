Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1EFDFF07
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfJVIHM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 04:07:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46462 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbfJVIHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 04:07:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so10134562pfg.13
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=M083QU3FFCLRsYAwPqOmsTg54VJTrGwDgDIHjHlPs7g=;
        b=MMXq+l3QZYIod8WYuZqXfcy9d58UcRJr5kGM4JD8q4MOiHbMNfnSevAcOrpHnefopV
         SHw7GpDR5g770zby4H1A5eyUoGSMc2Dc4rgraGJiHZ6kpPJdrEVSfNzZwgXYXhGfsG7f
         yg8Tn6D/5ZjUNFNH3+IVMjxzuX/CbWl0yQ1CkcQOQ77OgEdzOMM25MY78OtcCmDOukOJ
         UFUdPeG/p0jmINDafGp7mlYrimR+vZQrJiyR9qkerzRXcN9qHtJxgHQ7wtPqf8N1w6U8
         mKfvK8pfbM2mnWBDF2FHVHVOh4zdhpTPfnr3yrozbRvb9Q1eXMwT0vVgjvcSvDMX4aBh
         m1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=M083QU3FFCLRsYAwPqOmsTg54VJTrGwDgDIHjHlPs7g=;
        b=adUHHWHMXAVWOSPtHdUhb08n3KjxvAsGjyZ6prG1atbooVgXgxwHZadbXhpNI31k4J
         3JJTkp5krqDBMHvWP/ckem9FdhV2so4gyRRPtdAG7V9Dfh032YqKC2MFp3qdVT+1eANQ
         XG1tLfyp2KvNPF2Z7unSBhEWCb9AvJaoin93NFxwqJVwhCfDgsrcGoIn5K7kDFdXSNXh
         pZO5CCPrApGmPddmc3OwSWT6kkN8tprAkhdLiHjBOgawIZemvh7PT0XaXo7OeQf0zz0A
         zQiQininKuNttvjMGARZ/M5SMb0crcKhx5lATwlfrjPesMN5vqOOCEd2ni/Q2nJnxTGd
         fg4g==
X-Gm-Message-State: APjAAAVPde/Tk7uaqMl57utE3PbLR5lO+UDbJ0KIqC6bQkxpm6sxzTro
        3Z665IQ1qfj5eB6sDXI/j8BbMzMI
X-Google-Smtp-Source: APXvYqzukCw2le1jgBwQUUj5+9kPqgBh33dflTyjQ4qwINW9C7zQ0Ud4Ng4YYBHt9G5Mk+kgyJTMdA==
X-Received: by 2002:a17:90b:d98:: with SMTP id bg24mr2915110pjb.99.1571731630111;
        Tue, 22 Oct 2019 01:07:10 -0700 (PDT)
Received: from xps13 (airbears2-136-152-143-122.airbears2.berkeley.edu. [136.152.143.122])
        by smtp.googlemail.com with ESMTPSA id u7sm18107309pfn.61.2019.10.22.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:07:09 -0700 (PDT)
Message-ID: <79e3b9aba5159d1e7fbf908af6621e9d0fdb57fd.camel@gmail.com>
Subject: [PATCH] iw: Fix typo in iw --help
From:   Ryan Adolf <ryanadolf123@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 22 Oct 2019 01:07:09 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Ryan Adolf <ryanadolf123@gmail.com>
---
 event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/event.c b/event.c
index 100f644..4a932d1 100644
--- a/event.c
+++ b/event.c
@@ -1172,5 +1172,5 @@ static int print_events(struct nl80211_state *state,
 TOPLEVEL(event, "[-t|-r] [-f]", 0, 0, CIB_NONE, print_events,
 	"Monitor events from the kernel.\n"
 	"-t - print timestamp\n"
-	"-r - print relative timstamp\n"
+	"-r - print relative timestamp\n"
 	"-f - print full frame for auth/assoc etc.");
-- 
2.23.0


