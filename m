Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D427A24492A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHNLoF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgHNLjy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2674C061385
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:39:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so8084142wro.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CIaL9kwctZltECceeOkMasHCAXmIM+a/cYObSy4ff4=;
        b=MmCFyrglks64su5tIBCIBbKp02c/3IxLmE2VWCQNGkN+nu7SA1AiyusR5q/f41X9pW
         cArMJ9rMffav9+UF5+u7lq5rZtTrZI0W0KMBmWTMsb605BjYmW7sXr1A/dYMJz6vrUla
         4dPxEAssYLx9/SKjKI/9sDVekVpdNLwgmiDVb4EuYYeoqBAlV8aT7rWGGynALuJzeBiT
         i0JGOrO1Nj9aWClAcmFhvE9J59UF3SnDGDhv8TBukXzNiCGCYcU4DmNn3BL1Ddob1D8F
         oRZm0lzH6JcJ/d4JALvBoF0iSnyuXaRQrGgzSY7zWqspHBA7fRAw1rfVdUWcyoqfZAth
         mUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CIaL9kwctZltECceeOkMasHCAXmIM+a/cYObSy4ff4=;
        b=fgj+dOVFGybWFjmYcUSlDgDKRUAfySH7oamS81oqRdq2XGH9UnYJJpmfJbT0Z/9I9w
         2fE/0zYz/15OT9eWZwpjXJbgArgJye3z2n3+HQGLCTuH/EVhMPub3XB9x+2fnSpiEDp9
         6jAr6wCsEREHtSXnAOT2KmP21IzldIOXdnjA/rEoR9RjCpERtU5rkdVfjwVVueC3wnEQ
         c0tN7Hi/uD3Z3V7DsesVEueH3zpBpN2lZCDm7/QqQ4jMiuByxjLpfFUAwLjxw8niNlT5
         mYyauZXqbk1bg8etjQdoZQz+bMzDiQiIs/c9nHvzlKGr+RduDnCP04/bQyJeUoajpwnu
         dEsQ==
X-Gm-Message-State: AOAM531qil5WRduv4SWivjddKAiCd2nrJUUpGxWnnCP8Do8ptayWvOdt
        5zKWC6rxsPqJzCP8ZYdUdbyXTw==
X-Google-Smtp-Source: ABdhPJwYYxsy14mnQDgzv7nCyt5+IIP2KulipeI/kMbK+FmmiJ08CPwhxf+74vWSEAWVYyOnNQnyfw==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr2338935wrq.199.1597405192700;
        Fri, 14 Aug 2020 04:39:52 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 08/30] net: wireless: ath: carl9170: Mark 'ar9170_qmap' as __maybe_unused
Date:   Fri, 14 Aug 2020 12:39:11 +0100
Message-Id: <20200814113933.1903438-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

'ar9170_qmap' is used in some source files which include carl9170.h,
but not all of them.  Mark it as __maybe_unused to show that this is
not only okay, it's expected.

Fixes the following W=1 kernel build warning(s)

 from drivers/net/wireless/ath/carl9170/carl9170.h:57,
 In file included from drivers/net/wireless/ath/carl9170/carl9170.h:57,
 drivers/net/wireless/ath/carl9170/carl9170.h:71:17: warning: ‘ar9170_qmap’ defined but not used [-Wunused-const-variable=]

 NB: Snipped - lots of these repeat

Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/carl9170/carl9170.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index 237d0cda1bcb0..9d86253081bce 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -68,7 +68,7 @@
 
 #define PAYLOAD_MAX	(CARL9170_MAX_CMD_LEN / 4 - 1)
 
-static const u8 ar9170_qmap[__AR9170_NUM_TXQ] = { 3, 2, 1, 0 };
+static const u8 __maybe_unused ar9170_qmap[__AR9170_NUM_TXQ] = { 3, 2, 1, 0 };
 
 #define CARL9170_MAX_RX_BUFFER_SIZE		8192
 
-- 
2.25.1

