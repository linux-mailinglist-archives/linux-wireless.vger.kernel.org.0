Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE01EDA34
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 02:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgFDA5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 20:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgFDA5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 20:57:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888CC03E96D
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 17:57:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h7so3487191otr.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHmxdlytAA/yDZC81TA8YFy9FryHu1eLzn8YJYHHI6c=;
        b=GXtBK3QvLb37LXsHeN/dnopmM4tNDqagcSK1qNUVli5R+2ElNOL5nqzmgEOcGVKiRo
         AR/0bLFPQWOPASNhq4CzelCoS98GNZEDzPEDYxz1g27Bqzcl/oyFS2wzFzphq6lo5iUd
         7E7VEuirMOS3QTVSkrU4CowwFfPi+9P6DrD9XNSFY2PyIigTr4faAaiOedYp+0heA7ga
         S/Rp0OwtrHJc0dAz4Tk4UZdqx9dxoqTflxQYEbfZNRmaTO281k86dm1PAn9JaTStZ897
         TmPkJaybX9nMs+uXtnc85cwHUL9nVWPxCQKc2+0rQYOGxYTmH7H+oHEFkuZDO7jZ+pZ0
         HveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LHmxdlytAA/yDZC81TA8YFy9FryHu1eLzn8YJYHHI6c=;
        b=ooBo5Ei2+SCB0EDQoUP6qWSR5BAbv4WQdEt3LD18bmwJScOjGoEGZBj55+P9/t7Y1H
         YGn1MiyI10PXocJVfq/kuDtXiCpRzEQ8X+TVZHrrIlQkoNc8kYfM+U4p90q8cBMxjfYa
         Guq8LxWfQaqwG25/iJhmz8QNHO/j3MubskNPj24HyiEQjaAqqT/YZZRWsNa6W6KVr2K+
         cQmlm/F/96GtUTv9FEIJu/VP2HFUNs6H8mDqghmVgCt1kyrnEu6uLtCLeT3lqbdXfIkl
         ZulG64PpkEU9rONZZ5Vhgh7SC98A1Si/CS3tnKDkq2NkZz3Y/JojQXvKcJPW9NtyFv8K
         WFXg==
X-Gm-Message-State: AOAM531mLx9u2AxoQLsFAduVQaDUsteKaQgKQhciv0oDZ8COOSuprYnl
        flk7Zi46SGARyMumKBVttnM=
X-Google-Smtp-Source: ABdhPJwwPlE8dumzpslvH9RK8nZ7bVgFEjFN2W8wvfYNWdZpwn8Dhmbqy/HzInSNrhtKIwV2LCSPFQ==
X-Received: by 2002:a9d:222:: with SMTP id 31mr2001877otb.310.1591232261052;
        Wed, 03 Jun 2020 17:57:41 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id u80sm1011300oia.5.2020.06.03.17.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 17:57:40 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/2] rtlwifi: Fix endian issue in ps.c
Date:   Wed,  3 Jun 2020 19:57:32 -0500
Message-Id: <20200604005733.7905-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604005733.7905-1-Larry.Finger@lwfinger.net>
References: <20200604005733.7905-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse reports the following endian issues:

  CHECK   drivers/net/wireless/realtek/rtlwifi/ps.c
drivers/net/wireless/realtek/rtlwifi/ps.c:772:42: warning: restricted __le32 degrades to integer
drivers/net/wireless/realtek/rtlwifi/ps.c:772:42: warning: cast to restricted __le32
drivers/net/wireless/realtek/rtlwifi/ps.c:775:42: warning: restricted __le32 degrades to integer
drivers/net/wireless/realtek/rtlwifi/ps.c:775:42: warning: cast to restricted __le32
drivers/net/wireless/realtek/rtlwifi/ps.c:778:42: warning: restricted __le32 degrades to integer
drivers/net/wireless/realtek/rtlwifi/ps.c:778:42: warning: cast to restricted __le32
drivers/net/wireless/realtek/rtlwifi/ps.c:867:42: warning: restricted __le32 degrades to integer
drivers/net/wireless/realtek/rtlwifi/ps.c:867:42: warning: cast to restricted __le32
drivers/net/wireless/realtek/rtlwifi/ps.c:870:42: warning: restricted __le32 degrades to integer
drivers/net/wireless/realtek/rtlwifi/ps.c:870:42: warning: cast to restricted __le32
drivers/net/wireless/realtek/rtlwifi/ps.c:873:42: warning: restricted __le32 degrades to integer
drivers/net/wireless/realtek/rtlwifi/ps.c:873:42: warning: cast to restricted __le32

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/ps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index bc0ac96ee615..90f92728e16a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -769,13 +769,13 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 					 *(u8 *)(ie + index);
 					index += 1;
 					p2pinfo->noa_duration[i] =
-					 le32_to_cpu(*(__le32 *)ie + index);
+					 le32_to_cpu(*(__le32 *)(ie + index));
 					index += 4;
 					p2pinfo->noa_interval[i] =
-					 le32_to_cpu(*(__le32 *)ie + index);
+					 le32_to_cpu(*(__le32 *)(ie + index));
 					index += 4;
 					p2pinfo->noa_start_time[i] =
-					 le32_to_cpu(*(__le32 *)ie + index);
+					 le32_to_cpu(*(__le32 *)(ie + index));
 					index += 4;
 				}
 
@@ -864,13 +864,13 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 					 *(u8 *)(ie + index);
 					index += 1;
 					p2pinfo->noa_duration[i] =
-					 le32_to_cpu(*(__le32 *)ie + index);
+					 le32_to_cpu(*(__le32 *)(ie + index));
 					index += 4;
 					p2pinfo->noa_interval[i] =
-					 le32_to_cpu(*(__le32 *)ie + index);
+					 le32_to_cpu(*(__le32 *)(ie + index));
 					index += 4;
 					p2pinfo->noa_start_time[i] =
-					 le32_to_cpu(*(__le32 *)ie + index);
+					 le32_to_cpu(*(__le32 *)(ie + index));
 					index += 4;
 				}
 
-- 
2.26.2

