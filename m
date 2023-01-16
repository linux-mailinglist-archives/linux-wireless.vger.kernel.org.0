Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337D66D01C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 21:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjAPUYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 15:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjAPUYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 15:24:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB8241D3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so13418153pjm.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSiLXb9WJcajlY3pp2A6uRr9twRUEMwHYlZPISHDuv0=;
        b=XsFNuH67bnTw8UEEBNfdHE2Vcgqz23IF9D2M870dn4gSTgx06BaEVaJsExIs47mnz8
         T+1zXS5SoutgfuvA6NhBNXgCPtC3nq43mDxKiISv5BzRM/2/jG9SIX/v7n1likkChona
         ng51M+ucV9xqMHLJco+HSEJihIooXhahUBQhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSiLXb9WJcajlY3pp2A6uRr9twRUEMwHYlZPISHDuv0=;
        b=YTI0nTuJxXkq7gmxOTxGYlTjr8rEvxf+R1WDsc7jp/i/R94bTN1yc32x22+FsfqfiS
         cNpNQGscnzIHMeYNcQjsxURwoH7sxQd9UDL+U1hIskb9x5PEtHWx82XFlaqO5tc+oxWg
         xQIxks4zMpbFupKCG47vwMJuFf6hnZjH/pYX1zecJ4a4KoYizugDLyQevAtlZObHoKd2
         IEigTF3Fl4Gqb6kQqVUjUDDiBLLvTj8ClnSvEViXIi0KSIbYQ0qdpO/yuQ0l0zjHL2es
         6P/Y90XvZ0ficM3Zhn3cedhBbBBz4h+5nzZ4c/dbm4s18bvMCGqrszu8UoLkwUnwuDnZ
         NXVw==
X-Gm-Message-State: AFqh2krC8QjO28scu4N3wLLzTCNAIhGyH5InMN5TXy/zTrtyB0joy+rS
        QuqwOKKLATNtlMZFFsg+aoZG9w==
X-Google-Smtp-Source: AMrXdXt9oe/8F3xPCM5wYGBCGrW+8/kYP//0TDcFXVVJhEeyTa/3Tq0q5sx8H89hTDujmw8X/bzfWw==
X-Received: by 2002:a17:903:3312:b0:194:85db:e224 with SMTP id jk18-20020a170903331200b0019485dbe224mr1013562plb.7.1673900684529;
        Mon, 16 Jan 2023 12:24:44 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm19782636pla.106.2023.01.16.12.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:24:44 -0800 (PST)
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
Subject: [PATCH v3 1/4] wifi: libertas: fix capitalization in mrvl_ie_data struct
Date:   Mon, 16 Jan 2023 12:21:23 -0800
Message-Id: <20230116202126.50400-2-doug@schmorgal.com>
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

This struct is currently unused, but it will be used in future patches.
Fix the code style to not use camel case.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/net/wireless/marvell/libertas/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/types.h b/drivers/net/wireless/marvell/libertas/types.h
index cd4ceb6f885d..398e3272e85f 100644
--- a/drivers/net/wireless/marvell/libertas/types.h
+++ b/drivers/net/wireless/marvell/libertas/types.h
@@ -105,7 +105,7 @@ struct mrvl_ie_header {
 
 struct mrvl_ie_data {
 	struct mrvl_ie_header header;
-	u8 Data[1];
+	u8 data[1];
 } __packed;
 
 struct mrvl_ie_rates_param_set {
-- 
2.34.1

