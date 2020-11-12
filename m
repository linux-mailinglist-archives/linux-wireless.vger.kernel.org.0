Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30A2B0C67
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKLSOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 13:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgKLSOp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 13:14:45 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048BC0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 12 Nov 2020 10:14:44 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so3209690pll.8
        for <linux-wireless@vger.kernel.org>; Thu, 12 Nov 2020 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN86W4Q0B86VjjCvN39kw93yFaoysD05wk4PDQ13B7Y=;
        b=llolQTmSsESCEIRRcKpjVmK40GjV+2WjJYlCG9cIjGFFK10F5WwIhW2bNKB67jIPuB
         a19yh2lkVEEtMhXc8hjAL4TegnAzUtFcd4Spq4zH3JK/C+ODg9gHo6bcoATdM3hJJN6Y
         XSdjFFkilVxEQgECsjKiylzjEzQmaqwRYO2qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN86W4Q0B86VjjCvN39kw93yFaoysD05wk4PDQ13B7Y=;
        b=P2IJsCGmRrBhPWVKYIqP6jbKT6qvL1rKpwX5l66fjFU181idWnxuhEAXLCZj0mvAbN
         wACvpdE2k9jUfc37OXfUeJU4hQ6yJuShIv3qA4QHgQdeiEHdL8XBOvKwoh+FfiKf895d
         pft56+UkGu3runAT/zFCY3pKHZPSn8ZLWnBLaLnUCKM5AgetoFn56kCqSMD+TM/y7TQZ
         YfwQuunEKPWb40A9i82FECxwRhn/cQUkaMvLcf2tVx072LQKIYXQq6voBWu6LN/rncvz
         QjG3Ubfajvv+5s7OYHYawT0A9ma0q0iEsxRTLYdQA7M0zTOh++c+Rnes5WuPgnb6H8Gb
         OVjg==
X-Gm-Message-State: AOAM530EwX7oh8Qvex2mc4B4zmusH0xFnIGsfgAMT7Ggbzk4fQKEzIBp
        QpW/kvjh54funV1YPTaYXyNdB8K3VBd3sw==
X-Google-Smtp-Source: ABdhPJxLit4KXU4p3mq2CASQZkU07X+nxROEU5ULBjWEFJKyWn3bfoyhXKOdplxNVNkKd2Ju2Vi/qQ==
X-Received: by 2002:a17:902:ba90:b029:d7:e80e:753a with SMTP id k16-20020a170902ba90b02900d7e80e753amr546098pls.35.1605204883750;
        Thu, 12 Nov 2020 10:14:43 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id m68sm6456475pga.46.2020.11.12.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 10:14:42 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtw88: wow: print key type when failing
Date:   Thu, 12 Nov 2020 10:14:32 -0800
Message-Id: <20201112181432.2958021-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's much easier to spot what went wrong when you print out the
unhandled key type.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/wow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index b419bc28861f..fc9544f4e5e4 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -332,7 +332,8 @@ static void rtw_wow_fw_security_type_iter(struct ieee80211_hw *hw,
 		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		break;
 	default:
-		rtw_err(rtwdev, "Unsupported key type for wowlan mode\n");
+		rtw_err(rtwdev, "Unsupported key type for wowlan mode: %#x\n",
+			key->cipher);
 		hw_key_type = 0;
 		break;
 	}
-- 
2.29.2.222.g5d2a92d10f8-goog

