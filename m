Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6B2A32E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2019 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEYG2D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 May 2019 02:28:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42504 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYG2D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 May 2019 02:28:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id r22so3692214pfh.9
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2019 23:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UfLxhCRU0Qk56sAzET0S82rUG0xDTXTxGSmZ9LvlCRs=;
        b=z75VKWDeqMNv2bEum4lV0fE61PNvK/EdKL/OrWZH80quBeWsTOuYqhT/UdJnkUbSqc
         qwua07kljYJPDOMm6HUAkDYS7ypK4qsxiveuMyOfQ5V+Q3GeHiGGqm2OzFtPafXPKNgk
         BihGwIV9v1EqAl7hPsjS6YG7GMwwgEF4SV5f2nJ6SY4/h41Jw0QIhM8IQ44qt/pEMOfL
         FeO69kIa3ncRv+gmMZKLVRHQG6ZLtsC0AXBq2ngRWkxE9w0CCRMZDhZmn/OKVR77xNQX
         oNy21iSQaLU86QUh9xsAKBO5ApzN4AAvhqyX6+ZMlFs79sfQcQJmNcx+qmIyVHfU1dBd
         mmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UfLxhCRU0Qk56sAzET0S82rUG0xDTXTxGSmZ9LvlCRs=;
        b=mvdxw+asxQyyFT0JwuBn2fc14AG31e7dDrd4BcJuxSPeFeNWwlN6exE18Kn+CazAva
         OQv0c7RhTrhv8Hl/EzE3RlD1WVDN8FsRTZkE+13GNvKNYKIBZf5+7+azeENN66irAsUV
         q3ckjJFn7RcfHOisBq29YXgte6gCL2lSkDWO2V/C8KVTZMT2Nm6Ubg9npFEbmztVMNvA
         PhzHESCkBUlly03+3nb9xAA+TLCT4WF/UgnD8N6mNX4tFx0cLJ8HWq2EtKgumuBiVbkp
         E+A3Ly8jqvSTS2i+WUIvxtJUGqdD02L5/O15EXSnVBrcUf8kFrl9MNkTkiIS2Q/uP6dh
         KZCg==
X-Gm-Message-State: APjAAAVDuBLWI6aOVXfNAx6JUyBaLWKAeyRtQVXw2rIEN4EXqB8v5hGe
        WkZUq5Oz1G62HsTp5SCiBgAe93Btt2A=
X-Google-Smtp-Source: APXvYqwzhPvdyy4kxXR74V2aFvdzLx5CmmC6bh+gXOqFV7MNNorz9G974bH4r1snV8Ld0DPMPhFlJw==
X-Received: by 2002:a63:1f55:: with SMTP id q21mr49710482pgm.51.1558765682984;
        Fri, 24 May 2019 23:28:02 -0700 (PDT)
Received: from xps.stroh ([174.127.216.63])
        by smtp.gmail.com with ESMTPSA id 8sm4605950pfj.93.2019.05.24.23.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 23:28:02 -0700 (PDT)
From:   Andy Strohman <andrew@andrewstrohman.com>
X-Google-Original-From: Andy Strohman <andy@uplevelsystems.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Andy Strohman <andy@uplevelsystems.com>
Subject: [PATCH] netlink: fix station_info pertid memory leak
Date:   Fri, 24 May 2019 23:27:29 -0700
Message-Id: <20190525062729.8504-1-andy@uplevelsystems.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When dumping stations, memory allocated for station_info's
pertid member will leak if the nl80211 header cannot be added to
the sk_buff due to insufficient tail room.

I noticed this leak in the kmalloc-2048 cache.

Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
Signed-off-by: Andy Strohman <andy@uplevelsystems.com>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fffe4b371e23..a82ecfe14d8d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4855,8 +4855,10 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	struct nlattr *sinfoattr, *bss_param;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
-	if (!hdr)
+	if (!hdr) {
+		cfg80211_sinfo_release_content(sinfo);
 		return -1;
+	}
 
 	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
-- 
2.17.1

