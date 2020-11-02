Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717BE2A28FE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgKBLY2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgKBLY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:26 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF36C061A4D
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:25 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 13so9030636wmf.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FRe1RWMH+Ylu+O6C7UB+7j1JllgJXWWCHgzKpeBizs=;
        b=EjP7BP5M3C9ozo3OlCBonJ+/+JAmTwyGg5DBL+fEJxyatzDpAE1mGujCx4j1CTSiaX
         1cGrEaWSm7RiD5emw5QEsnwVzcqy9bFe+a6aUxjwK1cxg6XStfW7PTU1U9peU3uwn5J1
         T5RuZZhxJOSfZKfobxmGg4+obtpV+2k9z3fChJiazNd9NzuLWyCQivC8VBlcIlY5+qxm
         nlAeOLU4o5aaSh1zvT1oYLSnYw/270827twrimYoyLTeuMILHchjT7hmEb7ounnF7YL5
         i31414KP446eCiZ6oqXyyieceiob/yYrjt/jO6hko0XzLgrG07AplOC6FDkUVeI8HBv5
         zY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FRe1RWMH+Ylu+O6C7UB+7j1JllgJXWWCHgzKpeBizs=;
        b=kJ2zUMMtU0EaTtZ/usGQAozpxlSvqaXX3cTvCa+auPh3XCEi6DXdQrbZJ7I6Eajb6E
         nd/lQAHaCVq/UWaKprRFgIroduLjVOOrvw48jZPpUmeCpJwUeaTuwuhilR93rioFY0ba
         pTHvSoABqtdAn0jUx35gWxs8jPd7/mUOPj+pFQGo6jDW4w8ph5lDbsQWC/1gJJybZ7ku
         TYXZRBDtPMwcCdGUpC/aj6lYeLqpEBwewp5jjOQ9nR3/fJS0HBkrWDiru5K8sEICG+Wm
         fYTaev8pwTv4k1GGSQt9ppyPMi0zRbvkReFGzzfyXDv926/SY1DtQyGw3Mlmal1jiubG
         Db/A==
X-Gm-Message-State: AOAM532McGTBQkjyNXDKTFJQgh2Xk+sd6FtGeDPXWbPdyVF8z1DMW/FC
        S3AiupwlFUiIKfA4TBuFRlOcFQ==
X-Google-Smtp-Source: ABdhPJzc4a5EERRtVUSuIyyhH7uEsVHTARaRs1aPr519ZyLWI5eoxokOiWIe9CFFu7KT3ISPBjgmpQ==
X-Received: by 2002:a1c:3846:: with SMTP id f67mr17643769wma.33.1604316264008;
        Mon, 02 Nov 2020 03:24:24 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 05/41] rtl8192cu: trx: Demote clear abuse of kernel-doc format
Date:   Mon,  2 Nov 2020 11:23:34 +0000
Message-Id: <20201102112410.1049272-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:455: warning: Function parameter or member 'txdesc' not described in '_rtl_tx_desc_checksum'

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index 1ad0cf37f60bb..87f959d5d861d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -448,7 +448,7 @@ static void _rtl_fill_usb_tx_desc(__le32 *txdesc)
 	set_tx_desc_first_seg(txdesc, 1);
 }
 
-/**
+/*
  *	For HW recovery information
  */
 static void _rtl_tx_desc_checksum(__le32 *txdesc)
-- 
2.25.1

