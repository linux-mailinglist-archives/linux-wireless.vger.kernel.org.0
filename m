Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8F406D79
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Sep 2021 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhIJOT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Sep 2021 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhIJOTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Sep 2021 10:19:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B63C061574
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1563907pji.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUqMXkCxlPNHudbb/uiPg0FjgZTFGptY3HJFCo4/ZHc=;
        b=WTgqIsGfc4OTPiXlzUSwbukZPfgMo73Zh6V1cMimwctHZR+R4rOhimhMFcmoQEqYQI
         /WlRIfO9EC2sUBK52mvobDPj57ArDxvM5n4ZY6OkroK9e7WlbmOBfiGqU8zPFc5XvXX6
         /oxWG8XKK5nJzHAZmscJyozYGxHImAjB52q/QSSPvk0Yt3YZRuypxN0vISA29ASdTNr/
         vCccgKAbSXlXsTKdpt5df+qKP6+ZnbPYcrGUyRjVAK+luU8GZ/6kFkW1AcZRl9wQm2at
         1ku1r5ZJbgFcZAiZfng4AQDyvpugnxvKtyOQApzqGgtQW0tdXrLpv8jHVLGiUoXxqG72
         9Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUqMXkCxlPNHudbb/uiPg0FjgZTFGptY3HJFCo4/ZHc=;
        b=nT67qNPmtnbI1Q8y2m56LJWyM3o9c06J4dNJbynz/jreCt1HmhU2jJQWNWePxx9QZf
         QcksLc+sseLWEzRmo8tLK0cyoUjTw4/4kQc4y2bu3t2kpl5Xr8Wv4a7j+9/vpv9Zj7Ie
         9H9cHl4iry4jwQaeKmfR517+Y7IaXh+Fct8UVKsnnx6p+0RYmY4sv5E1P+Z98LbCqreD
         0yztxAMiJP87+PCj+d86nrYjhT+tiWmOCLDTi+PDZUaNJYcbFITDNm+l7ZhdovC44tNm
         ZVIBFNy5NNwhZZMsVvD87Zj5iPIjTAtiNYw1OrsM5C1AvSxrxvB347Dz5sS9nOr2Txmu
         A5fw==
X-Gm-Message-State: AOAM532untgX3c8DnZRYY7UwcLcbbBppmFA/OdoHDDZB5PjrUudErG6S
        eIt34FTOtz4ZPzkYBioP8yE=
X-Google-Smtp-Source: ABdhPJymV0vI0sJpipEm1nI+zCoTUdpWBknX9n5i32wTgs2NT8K8GZgav3OaCtyWoVKb5+R1ZOM6jw==
X-Received: by 2002:a17:90b:1d02:: with SMTP id on2mr9762219pjb.21.1631283489836;
        Fri, 10 Sep 2021 07:18:09 -0700 (PDT)
Received: from localhost.localdomain ([49.206.113.222])
        by smtp.googlemail.com with ESMTPSA id q9sm5079519pfs.40.2021.09.10.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:18:09 -0700 (PDT)
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gokul Sivakumar <gokulkumar792@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH iw 2/4] iw: link: mention the need for MAC addr arg in link get_sta cmd usage menu
Date:   Fri, 10 Sep 2021 19:46:16 +0530
Message-Id: <20210910141618.1594617-2-gokulkumar792@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910141618.1594617-1-gokulkumar792@gmail.com>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The usage menu shown when running the hidden "link get_sta" command is not
mentioning the need for the MAC address argument. Without this, the cmd is
always failing with the output shown below.

 $ ./iw dev wlan0 link get_sta
 Usage:  ./iw [options] dev <devname> link get_sta
 ...

To avoid this, let the user know about the mandatory "MAC address" argument
like below.

 $ ./iw dev wlan0 link get_sta
 Usage:  ./iw [options] dev <devname> link get_sta <mac-addr>
 ...

Signed-off-by: Gokul Sivakumar <gokulkumar792@gmail.com>
---
 link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/link.c b/link.c
index 1ed7f63..2074488 100644
--- a/link.c
+++ b/link.c
@@ -273,7 +273,7 @@ static int handle_link(struct nl80211_state *state,
 }
 TOPLEVEL(link, NULL, 0, 0, CIB_NETDEV, handle_link,
 	 "Print information about the current link, if any.");
-HIDDEN(link, get_sta, "", NL80211_CMD_GET_STATION, 0,
+HIDDEN(link, get_sta, "<mac-addr>", NL80211_CMD_GET_STATION, 0,
 	CIB_NETDEV, handle_link_sta);
 HIDDEN(link, get_bss, NULL, NL80211_CMD_GET_SCAN, NLM_F_DUMP,
 	CIB_NETDEV, handle_scan_for_link);
-- 
2.25.1

