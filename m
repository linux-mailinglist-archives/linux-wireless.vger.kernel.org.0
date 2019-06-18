Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3A4A9BF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfFRSZO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 14:25:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35797 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbfFRSZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 14:25:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so6060002plo.2;
        Tue, 18 Jun 2019 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZWfAOAxoVbPij4WvtmFyrhlxSXKOQxDJzGR7xW1Qhl4=;
        b=rDDlyAvvtsHMAO0xf644R8e0EQPSxem326pnG6VLJloD9q3ZMMlpOAT4t7gkgQdhM2
         W0iC9W2W+DXCoN3BdpkExKZC8QJVpYhOF4C7WGszSQu+nbKhuZn/4yNEI2JzFzWuCdBC
         2Y4U40rJJVg210CmG/P2ljebo+D3yeS778WgJ/Plevek8DAFFhEv1kpeb21htZJO60FZ
         6X2XaSN+NQnjAd1q9XviYtXbTzX56n9Ro6AVEd8VUeOkvbXTb1Pe0FO2u3bBhX3YsMk0
         DfjjvIYO5U1An9bvFbST4qIVrqRdK2r8SeX9cAG5ewyr/FdHqls6r2bgRd2Lxi20sAiH
         VP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZWfAOAxoVbPij4WvtmFyrhlxSXKOQxDJzGR7xW1Qhl4=;
        b=OqD+z1hzD82mjGQQzhNbwzAwR5DWmpnx03oXi29LgBRw8tcddyOBzEeIPCm5Doxowy
         9IXLOBPauIB6tgqwt+PHnAogrncuLjhAdr7YSZixkObN/0W/aU4ZRM5Xad8ztKwT0MTI
         nZZaY8LAciP17SjtYtLQGlh+zVa69/PHvcvQWqAtEPYKyvj4IzQQy8TwinaynSN93muS
         4vS0CLvFUcxQhH9usHT3RL4fpvKrOsUh0mCLyuDgU5fvF04NxvbMrMSb/XQgeU1EUvK9
         W18FbxOK9Li7r9s5fd1rd0sTbEILXnRPhKZWixrNZIlddzhfHzNsF7vMpSJf7qqc8ORD
         n/1g==
X-Gm-Message-State: APjAAAXoOoeCO9MVA66kKoyBoiXC/tlEy9fqX/pLUH2VJ8Uniz7adhUT
        nNTlCCmyvv2SIGOv1JsqXXY=
X-Google-Smtp-Source: APXvYqz8piH56vYUozmcdQ6KNkkF1F+FrG6bOMilJRTIj1HC6m3jGo47OqTa5F1u9LkmBbos6unY4A==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr32734935pls.318.1560882313798;
        Tue, 18 Jun 2019 11:25:13 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id w14sm10510083pfn.47.2019.06.18.11.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:25:12 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:55:07 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: Remove redundant memset
Message-ID: <20190618182506.GA9007@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

alloc_etherdev function internally calls kvzalloc . So we may not need
explicit memset after this call.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/wilc1000/wilc_netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1000/wilc_netdev.c
index ba78c08..c4efec2 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -1010,7 +1010,6 @@ int wilc_netdev_init(struct wilc **wilc, struct device *dev, int io_type,
 		}
 
 		vif = netdev_priv(ndev);
-		memset(vif, 0, sizeof(struct wilc_vif));
 
 		if (i == 0) {
 			strcpy(ndev->name, "wlan%d");
-- 
2.7.4

