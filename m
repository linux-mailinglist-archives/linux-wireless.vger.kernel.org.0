Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8710466D01A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 21:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjAPUYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 15:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjAPUYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 15:24:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7826583
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:50 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g23so15804265plq.12
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gauNsz6s5kFu95ogUSHoB2HkvdwI2Yd7FgOC3hoCgaY=;
        b=CVDrCKxTFJ3xT1epe5ulcX04NUVwF5MoYVofUUFheafxF02afSUoo6dhlJ04EQ81IX
         CvdsGvSRoE+5GUXp8xBpM0H0vlpayjeRqYE5qWA0/NJVLlefkMP10RThpjIv63ohAJMe
         YyhCZIbAxh+Rt4DchlRXIazZOiB40+Jbyk96I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gauNsz6s5kFu95ogUSHoB2HkvdwI2Yd7FgOC3hoCgaY=;
        b=gB2fVIl2JpIr4FnYiu2pqwkE6wQruMjGbAv14xbx16/GknsmptBGXrXraRU1orUxr7
         JRuT5iggOcTylB+zetzY5yKEblKY2s8nT6SMQS+j09m6Y5XLjjPqEQlwi+uNXnaoKP7n
         /4nNUvhiZiVTEHhutS1H/iZuvi1+HeEz3BzjW085QiPA5FPfZN2z9xHSR/XSQ2/sJcYe
         PvncY1coyR61DelTCO1E+aAPtfSWoE7w9NGW2BTxCuWLR7RY7LLOB1MajC2SdpDBDX1B
         2AZyKFvjBQk9kCWeRrnUiBsffyDh1JJXlihNIj+MLytOC84W9l/pcPv9VI4avwMcxCt2
         Q24g==
X-Gm-Message-State: AFqh2ko97kYre12Rff5qC4OaT+XturT0lwwpqzAmJ7dD6Tdh8iYc5+Qi
        J5GYJm0G+rH1u5fGVfdb7K6HIA==
X-Google-Smtp-Source: AMrXdXuqW18YgFq/Qjm5kfuN/1kxd8WVFfWKMeZoGCXuxftlEDOF5KstwkozpqayhjNsum3a5NxkzQ==
X-Received: by 2002:a17:902:b105:b0:194:7a89:a436 with SMTP id q5-20020a170902b10500b001947a89a436mr910469plr.27.1673900689434;
        Mon, 16 Jan 2023 12:24:49 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm19782636pla.106.2023.01.16.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:24:49 -0800 (PST)
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
Subject: [PATCH v3 3/4] wifi: libertas: add new TLV type for WPS enrollee IE
Date:   Mon, 16 Jan 2023 12:21:25 -0800
Message-Id: <20230116202126.50400-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116202126.50400-1-doug@schmorgal.com>
References: <20230116202126.50400-1-doug@schmorgal.com>
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

