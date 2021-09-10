Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23001406D7B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Sep 2021 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhIJOTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Sep 2021 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhIJOTX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Sep 2021 10:19:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A226CC061574
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso1550285pjb.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AcpfS24aKz3q+yOljqV3O2C7e9Ts977E3eEPkH8QP8=;
        b=cYcay0RI/qfKk00v0aygiMe3TWyaPEGxl0vaIqxbS2mqPUXLPJBARL8Hxwy+mBDNkO
         0pPh2yp8ittRFRP1ip5g0yCbEienq/Zf2du1+4URZ7kdHs4uK8GAvfSrMP/LKizvo20I
         nGf/9RhFM1hBRbU74fMSrQ/UtvEyZfxqgStqIRAswLNxJsT2X56rbixAnB45UtmmfT4V
         HtQ6vsbj40vAeT3eNWYAOlY9Fj2Mb35QS7TYrJlYxvI7++ySRVVhEyWecq08/Nd30am4
         241jb6QblPQCX9OiojIQcv+qKOTvmL1XUp4QDVqNHP3KUDTuI85taAN4KJqHZZ+SlQbs
         mn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AcpfS24aKz3q+yOljqV3O2C7e9Ts977E3eEPkH8QP8=;
        b=nQ/P6k8SGbwret+xU7MZzdYaohpkcFghdc3SDIHEyc4NEPIQi3zLhoYsrHTaomIMtb
         7BaKCPOAVXM/+QjTUtGKhtWGZZ+B/LBDlwQW3jmkefArXANIqSUSEJCXj6Wa0WWTlKbu
         B0JVG10ZFP2mQ1iLfS2N9ymMQqu95gpuPvZufdhjjJA6Ip8LqGHdNbmXJ+TMsHD9JLIG
         Pflxpy0CfjB1aogr8OzbGSCpwuSEM5EhKVCmw5Np3x3xlZ/TWtE7sPyDWUACWAVvP4//
         1R4ZrWo8pca86ccsF6+jz4kpOwfpcJp9/wQwdpK8Qi84S83LZNT/kGO5AvfQ71vHVAyj
         U0rg==
X-Gm-Message-State: AOAM532I3hirtMKbYf94siUBumpAg1Ypfm9PUpEoZSU7rezIJeZVaE0i
        2sjo1Piemfumq3hgsfMlhLgtuJLgq/w=
X-Google-Smtp-Source: ABdhPJyQZTiobPrVNObh+MAEmXL01Db6e0ojuWe8385RFf60k6T7H3ypeGgsl/pOu+NXGDx0AJRMSg==
X-Received: by 2002:a17:902:6b49:b0:136:3f21:7a9 with SMTP id g9-20020a1709026b4900b001363f2107a9mr7797501plt.81.1631283492095;
        Fri, 10 Sep 2021 07:18:12 -0700 (PDT)
Received: from localhost.localdomain ([49.206.113.222])
        by smtp.googlemail.com with ESMTPSA id q9sm5079519pfs.40.2021.09.10.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:18:11 -0700 (PDT)
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gokul Sivakumar <gokulkumar792@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH iw 3/4] iw: event: add the missing time display format in the "iw event" help menu
Date:   Fri, 10 Sep 2021 19:46:17 +0530
Message-Id: <20210910141618.1594617-3-gokulkumar792@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910141618.1594617-1-gokulkumar792@gmail.com>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The option used to print the events with timestamp in Human readable format
is not listed in the "$ iw event -h" output.

 $ ./iw event -h
 Usage:  ./iw [options] event [-t|-r] [-f] [-n]
 ...

So add "-T" option to the help menu.

 $ ./iw event -h
 Usage:  ./iw [options] event [-t|-T|-r] [-f] [-n]
 ...

Signed-off-by: Gokul Sivakumar <gokulkumar792@gmail.com>
---
 event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/event.c b/event.c
index 14f101b..e0908dd 100644
--- a/event.c
+++ b/event.c
@@ -1457,7 +1457,7 @@ static int print_events(struct nl80211_state *state,
 
 	return __do_listen_events(state, 0, NULL, 0, NULL, &args);
 }
-TOPLEVEL(event, "[-t|-r] [-f]", 0, 0, CIB_NONE, print_events,
+TOPLEVEL(event, "[-t|-T|-r] [-f]", 0, 0, CIB_NONE, print_events,
 	"Monitor events from the kernel.\n"
 	"-t - print timestamp\n"
 	"-T - print absolute, human-readable timestamp\n"
-- 
2.25.1

