Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502677731C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjHJIjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjHJIjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 04:39:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB4B2115
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 01:39:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6874d1c8610so491160b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691656777; x=1692261577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOKNA2qlOmfp6TM6cTiRkm8d2KMNz/7b7e0gnPg2BIc=;
        b=AN1EnhGLU2SS+JsisCCNs7lJyecAuBqcCrp2vf1umSDkMEac9aXJ/6cN5wnrv6NUiL
         XwVNPKe62nVp8fb0zMv+X9vEczzz/a6AR7pjs9wBz2DxbAYGsBnKaLMVvZNjWJ3ow4pc
         NGSrQGln7n/K65Ys3xHbO3RGxHw/QkmV8di1FHHP+0GL8cHZbyGC15RH+9oeGtD02kCZ
         80BuQkmL1JGvynV2hFiQUtuEGMBtZhOGTkSVyC6bVFtfPRoKairjrgljAWUh5kCmHWZz
         XT6+M7IE5RSXuuPLDdC7ITNU9mNCZxOrKYJMkVudHO37Y0yVgyzz4Fw9i3/RVCQQFXRw
         scPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656777; x=1692261577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOKNA2qlOmfp6TM6cTiRkm8d2KMNz/7b7e0gnPg2BIc=;
        b=Xf8EvybhFYrbNl7Xv84f060RbTtUlHJluP3/r82rx9q40y1FDn6g/1v1HiyBT7QZ0C
         NVWbRdMyLHLC27ObHbcnkastHtQ2tM4mBLFcckmZK3Yc4C/UKxJprowfWxF5fQRzqtY0
         o0FixxxxBt0aB8X4tJMw8mPpsn3agTCTrr8IZB3DiC3rwrnqF/fmVnL3iG0cZxteb738
         9MVjrUWziAjHIWkF9UBQofaomeuOviWZDOkgemkplzxJU4PutBXfDG5wcsuB+VU9Kw1N
         ru4SI0gSK592czGInql+jbTtl9oNx4WWG9xs0nc0UzJ1pGOIFDykQKpZdGuyNKxDj5PS
         6AXA==
X-Gm-Message-State: AOJu0Yzzwf8gywZga6JoU+9rDmhWfPOIoBGyLkMvzj13WC0z67oF/N7Q
        tkXevDUz3LdV84x7ShICItA=
X-Google-Smtp-Source: AGHT+IF44vGSVd82MOLF3jd+K8v2Gk8OA7X0GFNG+dc4/34MukQ49Wm4bc3RZVO+1sCSTlPks9FXGw==
X-Received: by 2002:a05:6a20:12c9:b0:138:1980:1e59 with SMTP id v9-20020a056a2012c900b0013819801e59mr1960615pzg.28.1691656777470;
        Thu, 10 Aug 2023 01:39:37 -0700 (PDT)
Received: from localhost.localdomain ([221.231.189.234])
        by smtp.gmail.com with ESMTPSA id l9-20020a62be09000000b00686bb3acfc2sm948533pff.181.2023.08.10.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:39:36 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     johannes@sipsolutions.net, briannorris@chromium.org,
        kuba@kernel.org, kvalo@kernel.org, matthewmwang@chromium.org
Cc:     linux-wireless@vger.kernel.org, pinkperfect2021@gmail.com
Subject: [PATCH] wifi: mwifiex: Fix missed return in oob checks failed path
Date:   Thu, 10 Aug 2023 08:39:11 +0000
Message-Id: <20230810083911.3725248-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
References: <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missed return in mwifiex_uap_queue_bridged_pkt and
mwifiex_process_rx_packet.

Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c   | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index f2899d53a43f..65420ad67416 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -92,6 +92,7 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 			    skb->len, rx_pkt_off);
 		priv->stats.rx_dropped++;
 		dev_kfree_skb_any(skb);
+		return -1;
 	}
 
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 04ff051f5d18..c1b8d41dd753 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -110,6 +110,7 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
 		priv->stats.rx_dropped++;
 		dev_kfree_skb_any(skb);
+		return;
 	}
 
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-- 
2.25.1

