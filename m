Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2986774F4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 06:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjAWFcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 00:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAWFb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 00:31:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F1F772
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 21:31:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id lp10so7228285pjb.4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 21:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWC1KMyV1A6Rl/COql8OC8fu95Avmd8JBknQzjt01sI=;
        b=Zf/NDMEwvDxlPca3OM3Bm9bWcAeHNm9tS4PI2VKNDzm/pxcYYTLfLQM8A3HFvzwvM5
         gkBMQkSHGAwcIsVvaQPaJvEpSS0hok9QhRgy/gGOywslUMfjbTfP7kPNiZNwmHrFPIuk
         NxZDOEx7ySl0Ed1NqnAVdO+07VrDoZqPMKApA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWC1KMyV1A6Rl/COql8OC8fu95Avmd8JBknQzjt01sI=;
        b=cpiH4RRz+HjLhK4gI83xZVtg95c2FXDe3OvCRvcSKVuzk60w82lcUBB1VmGGHsUDxK
         3HGDAH3VKLBv1RuwHJOm8qWDpj9gtCbE6f3lQWys99IM9BVYzyqzNi5MDXBLvnMVMRzO
         TQD9DgJ7bf4YZojY4oKdoPZGozI6r9wvgpPr5TGMeAJkoVEM3xIhQ8/wTlwVlEk+oLvb
         yu6MqzR/x1jGukvT2AgedYLFv6kwnkkjc1XwgaqhAvFVVgzvueWzs+HMwDE4Sp2yT8JI
         KO9N0dpr18teG8w6qyMB+NPUEzqZAFO438sv6dffQl66GG0c7KjbWyVyWQ1q9cEAscv8
         i8IQ==
X-Gm-Message-State: AFqh2krJ/B8k+/2j+bBsrVCVJATYnpt09lzX/4ozJC1H4TI6ums1T4Nv
        ai/9GlwyGVWfC1RBxD9HdY/mew==
X-Google-Smtp-Source: AMrXdXuSnQEOljzY6lLfs+YGvp3fwfttCOozHsP9CcvWI1/0DsVhUuMOFjvhBsEacS82f57FARAOSA==
X-Received: by 2002:a17:902:7fc2:b0:194:7ae9:c704 with SMTP id t2-20020a1709027fc200b001947ae9c704mr20251416plb.36.1674451916492;
        Sun, 22 Jan 2023 21:31:56 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018963b8e131sm9125244plx.290.2023.01.22.21.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 21:31:56 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 3/4] wifi: libertas: add new TLV type for WPS enrollee IE
Date:   Sun, 22 Jan 2023 21:31:31 -0800
Message-Id: <20230123053132.30710-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123053132.30710-1-doug@schmorgal.com>
References: <20230123053132.30710-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a define for the TLV type that will be used to add WPS enrollee
information to probe requests.

Suggested-by: Dan Williams <dcbw@redhat.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/net/wireless/marvell/libertas/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/libertas/types.h b/drivers/net/wireless/marvell/libertas/types.h
index de60becaac12..bad38d312d0d 100644
--- a/drivers/net/wireless/marvell/libertas/types.h
+++ b/drivers/net/wireless/marvell/libertas/types.h
@@ -93,6 +93,7 @@ union ieee_phy_param_set {
 #define TLV_TYPE_TSFTIMESTAMP	    (PROPRIETARY_TLV_BASE_ID + 19)
 #define TLV_TYPE_RSSI_HIGH          (PROPRIETARY_TLV_BASE_ID + 22)
 #define TLV_TYPE_SNR_HIGH           (PROPRIETARY_TLV_BASE_ID + 23)
+#define TLV_TYPE_WPS_ENROLLEE       (PROPRIETARY_TLV_BASE_ID + 27)
 #define TLV_TYPE_AUTH_TYPE          (PROPRIETARY_TLV_BASE_ID + 31)
 #define TLV_TYPE_MESH_ID            (PROPRIETARY_TLV_BASE_ID + 37)
 #define TLV_TYPE_OLD_MESH_ID        (PROPRIETARY_TLV_BASE_ID + 291)
-- 
2.34.1

