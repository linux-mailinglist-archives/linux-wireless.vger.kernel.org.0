Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04302355F31
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhDFXCk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhDFXCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 19:02:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B5C06175F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Apr 2021 16:02:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x17so17329031iog.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Apr 2021 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rj2YYKWiwju3STdIjVvck7gwFTWKqKlbS/8vOJQzblA=;
        b=LjPAMgX4jEAvs46Pjf+qHRP61100oZ9gBFh8LuXJOqZ/+4s8Zd7eKgheo4sK3oKHxp
         sERChtROH5w8X7WVNvCbc9ajll7IY7lboMEg6i3jClONPUzB2iYndamvcV+rGEXvyM0V
         /w8r4v1KClZJ774YmtCVlMsESIJiTR57hldq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rj2YYKWiwju3STdIjVvck7gwFTWKqKlbS/8vOJQzblA=;
        b=m9Gj/nBAXr6NqMh5IAbNYv+FCNpNBz0SVANwl26XOGRQG0LtOYXItaAG6fcvT7ppU8
         FkozCmKSfElBtT8Z+vyJR+u22s15i7VqXc2LDrvMPsnHI2jK/MJWlSq/FctX6lf0EdUU
         AJhwlC9+9YWjakrqRyLiO2C45AFhFhA5218STGTuja3YSN9hGbsGPdqnZaxT/niUUBDv
         5jv1JJ/ChEtPJ6PvieqQ3cbZroZ7kToqUPnTeZLrgtkfJ5wkYN1hJHXW0kE6KjosPTyZ
         zwWiMdaKMmVGAkUSWQRHmOUQaFyEd5/rZyNT/XiZAH3YpYoyeD+0Y2nbI4lDYDLDNYK4
         f7Tw==
X-Gm-Message-State: AOAM530BD+7m9SIIPL/gXTWFTk9KVcODZL7KHd12FTmYfvrKINgeg4Rt
        sQFvMYbpm+qmn+KKZWZl8f4m+g==
X-Google-Smtp-Source: ABdhPJyIpJDK8H7I6Uevy94NM3CzpZpJax71iCAYlQWB3ZvcOLnBm9cU/gL+ZTjIV0swPVXh0JIGew==
X-Received: by 2002:a05:6638:343:: with SMTP id x3mr522607jap.44.1617750151432;
        Tue, 06 Apr 2021 16:02:31 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm13186097ilq.38.2021.04.06.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:02:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: [PATCH] ath10k: Fix ath10k_wmi_tlv_op_pull_peer_stats_info() unlock without lock
Date:   Tue,  6 Apr 2021 17:02:28 -0600
Message-Id: <20210406230228.31301-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_wmi_tlv_op_pull_peer_stats_info() could try to unlock RCU lock
winthout locking it first when peer reason doesn't match the valid
cases for this function.

Add a default case to return without unlocking.

Fixes: 09078368d516 ("ath10k: hold RCU lock when calling ieee80211_find_sta_by_ifaddr()")
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index d97b33f789e4..7efbe03fbca8 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -592,6 +592,9 @@ static void ath10k_wmi_event_tdls_peer(struct ath10k *ar, struct sk_buff *skb)
 					GFP_ATOMIC
 					);
 		break;
+	default:
+		kfree(tb);
+		return;
 	}
 
 exit:
-- 
2.27.0

