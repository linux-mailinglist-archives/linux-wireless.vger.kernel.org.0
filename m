Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE12639F8B3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFHOPh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 10:15:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36143 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhFHOPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 10:15:37 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lqcUB-0008FV-Nf
        for linux-wireless@vger.kernel.org; Tue, 08 Jun 2021 14:13:43 +0000
Received: by mail-ot1-f70.google.com with SMTP id r16-20020a0568301350b0290363e6a9392fso14062915otq.13
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 07:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Scz/+2FaJaPFCaHDCYYvhrds7lqoHwfgQbOXOjYUeTM=;
        b=KGZICOwJxZOTbzsIhI16yB3ornDSsnoxi95jZv+VEOZIRm791+xDyTY+KBqKRdl1wS
         WsaEPkufMMIOkKQkPi1815VE0MFO4IDsHlQm36Kn95XKf3N5/CfigtSRq78Y+cMtWonz
         XEIysx7p8KEWZV6qGiME6ug7R6o+eOclBRSd99XE4pgCvsTt2XmOPdewb1Y4mzzjjJUN
         CoK0BVIa7XfqK7Du8MHIEwtNkNZximmvkf1QhPGWP3Wrjpx7Q5glaOPH06Di3Ab5hxvE
         6p1v0NKnf/8Fo1qdGdnr2D/ib1MjYkRgN5tYMrGTkyUB2Qhll8dcuhhS6rZhf4/0iXEs
         lmBw==
X-Gm-Message-State: AOAM532IxBeguCfYvl1nMJCqHCx2752bBm8yjseQEr2UD3jnx8PdTkAw
        Vbxu6A2yABI7UTNdckTFFSAeoK+flIiWO28wfwGgQLxAgUq/E5HsRBXTYrDNKQKwKiu16VKXXqI
        XBNGHHKu4ieMvLqjMmlDOivnhpbfJLz4n9VwtQK8Adc3Z
X-Received: by 2002:aca:5889:: with SMTP id m131mr2906031oib.140.1623161622733;
        Tue, 08 Jun 2021 07:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoIusiyr0h53VGa+4duvirf3QCHghI1XCdPXs3sh5I8NRHZs8wrMBI84wnTlE8uKIsjF2eiw==
X-Received: by 2002:aca:5889:: with SMTP id m131mr2906016oib.140.1623161622464;
        Tue, 08 Jun 2021 07:13:42 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:7771:da70:ed55:6011])
        by smtp.gmail.com with ESMTPSA id m23sm2747804otk.55.2021.06.08.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:13:42 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     mj888@mail.co.uk, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: update 5725-5850 MHz rule for GB
Date:   Tue,  8 Jun 2021 09:13:41 -0500
Message-Id: <20210608141341.86462-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Based on the latest IR 2030 update [1], update this range to cover
5725-5850 MHz rather than 5725-5875 MHz, increase the max EIRP to
200 mW, remove the DFS requirement, and add NO-OUTDOOR.

[1] https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index ddf9e1434cc7..a5829e074efd 100644
--- a/db.txt
+++ b/db.txt
@@ -599,7 +599,7 @@ country GB: DFS-ETSI
 	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
-	(5725 - 5875 @ 80), (100 mW), DFS
+	(5725 - 5850 @ 80), (200 mW), NO-OUTDOOR
 	# 60 GHz band channels 1-6
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.31.1

