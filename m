Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A596612E9
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 02:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjAHBbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Jan 2023 20:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAHBbC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Jan 2023 20:31:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC637270
        for <linux-wireless@vger.kernel.org>; Sat,  7 Jan 2023 17:31:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b2so5781156pld.7
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jan 2023 17:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gauNsz6s5kFu95ogUSHoB2HkvdwI2Yd7FgOC3hoCgaY=;
        b=d7jWKen1UBmJo4xKDMqEumwrLLmvakr7YusikAYbcgcpPa9q295WFntzAmuHeUN1VD
         3MID3tH/XlEQesAsft43vpTTBnvQneZz4iQbnKeFUeDpUqIfhyG3khwsXfHRV3dA2IvD
         5//lOkMbdGQPBHdJxupXrMiBje8XbtNe/sQ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gauNsz6s5kFu95ogUSHoB2HkvdwI2Yd7FgOC3hoCgaY=;
        b=YuEQxWuAJ09N7mZYJBN2Bl9kgW7M56FK1xLpDdwHqUbXTRSYop71THBK/f07p6kTvf
         aD0ntYjj9qy/qHm7Jj9dUkxDvssPRB3owVxFjt0x8vQuzR4hCS8uEuTgm4p/bDxgQBD8
         gb6pE6J8r1Fmk2DAsGy88HTpTRkiY7vF3tO9NTsKsCWeCenIhs5RfEr7cMJMh85w6wqe
         QCpFdUAk9m2ub20J34i1wKGgI1Rr8LwjHF/O8mwOi49roqbPII5R9LVKFXGhMhOoT0Tb
         VTaeibZmOIG8hmQLL6GwlyyWCyb239BEP9Vs3uD+c3FWFvhLPBizQVyFMLc0B82Lg5L9
         zzJA==
X-Gm-Message-State: AFqh2krtmcWfSyDYCAdrHzOeZlUYunlBEoe/k+uiMQ70sTuNlKX02lXm
        cXSITbCtDldtP6ixPgy19DBcQw==
X-Google-Smtp-Source: AMrXdXvcEJL08ILiRjMh3tq2yXtYlomndnblK8Cn6RILuziDx19TkGZBoy724VK5Lx7/9OBtxUuz5A==
X-Received: by 2002:a05:6a20:3c8f:b0:a3:bdd3:8cb0 with SMTP id b15-20020a056a203c8f00b000a3bdd38cb0mr88573133pzj.56.1673141461188;
        Sat, 07 Jan 2023 17:31:01 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79a4e000000b005811c421e6csm3323714pfj.162.2023.01.07.17.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 17:31:00 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Dan Williams <dcbw@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 3/4] wifi: libertas: add new TLV type for WPS enrollee IE
Date:   Sat,  7 Jan 2023 17:30:15 -0800
Message-Id: <20230108013016.222494-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108013016.222494-1-doug@schmorgal.com>
References: <20230108013016.222494-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 398e3272e85f..39deb2b8bc82 100644
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

