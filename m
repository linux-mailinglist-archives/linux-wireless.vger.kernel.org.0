Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF11E6D2E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407446AbgE1VGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 17:06:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42981 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407447AbgE1VGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 17:06:12 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jePj8-0002NG-4z
        for linux-wireless@vger.kernel.org; Thu, 28 May 2020 21:06:10 +0000
Received: by mail-il1-f200.google.com with SMTP id d8so412908ilo.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 14:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgiFkeRWD1iklOGUCKi1k5UpEEQVr9kuLl9WkT7Km5E=;
        b=CPKGXUbde2tzEr3j3XMhcGhyXWZRNJ8zvIzf4mEy2uyKdwrZ53qJRl1m0Y2EgzHoZZ
         gVFmaHdXZkA/uSPlRSO5PHmeqZvkF7yzKCv61ZkFKA0PADQpaOziIIH0zbz6DVzxpWgk
         Yu9FofRcnGVJEOqiN5pf+lG6vFgceKzILBwNHVIrFS5WiMyKQuE8VLhTjyZXvTp4BSUM
         9jZv0oxqSTqR3UV+6kKhm7gBPC7OLemkxyWPqbabTy8XATPtqy9BjWAyHBRFheVKKGYN
         KqB+HuxAezfhiZy2w1ApKqgiwsF/GOatVF3gHaJEZCgej9L/ZKTFp4J5jtlMpokJloFN
         T16Q==
X-Gm-Message-State: AOAM532uFukny0I39qhiL7gIXRs8zPs4yabf1uDIeA1FdL2bYJZAVMLB
        YsF+IZT/ANBpqwmAWw9b+RcrPjJaovaPhavfTizvMXnJQ1a8N7fuqSeBDHV7/idRWHhF3k1TeN1
        RXBQ7vrYGmAs2eijzHMH59ImGn7rIsGYp8oq1gdTIcayn
X-Received: by 2002:a92:9142:: with SMTP id t63mr3515275ild.191.1590699968868;
        Thu, 28 May 2020 14:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymNf8Q25hGDDOx7WU6DwowM9bUHDZ/YKZgmxn04UQN5VITUXhtmHG0kJecbA569o+dkoe0kA==
X-Received: by 2002:a92:9142:: with SMTP id t63mr3515264ild.191.1590699968612;
        Thu, 28 May 2020 14:06:08 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:c019:a923:c100:fcca])
        by smtp.gmail.com with ESMTPSA id 199sm3936928ilb.11.2020.05.28.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:06:08 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ahmed Kamal <email.ahmedkamal@googlemail.com>
Subject: [PATCH] wireless-regdb: update regulatory rules for Egypt (EG)
Date:   Thu, 28 May 2020 16:06:07 -0500
Message-Id: <20200528210607.16154-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the rules to the frequency ranges and power limits
documented in [1], and update 5GHz rules to comply with
EN 301 893.

[1] https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 db.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index ac3248350956..699bce9fb9d8 100644
--- a/db.txt
+++ b/db.txt
@@ -516,10 +516,11 @@ country EE: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx
 country EG: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 40), (20)
-	(5250 - 5330 @ 40), (20), DFS
+	(2402 - 2483.5 @ 40), (20)
+	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5330 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 
 # ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1

