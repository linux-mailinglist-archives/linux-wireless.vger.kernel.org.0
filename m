Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA346CA8B5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjC0PMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 11:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0PMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 11:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A402D60
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679929918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DYh+IUQKnsNavgY4j1iAAQrUA1J5asaTGD0FKGxhaXM=;
        b=I02Ey8IdVwsc7xO7IKnify4r9LP+rGt29FfDY4r8BalcNG9dnCjcO7lTMs+vA/9enCOgEL
        v+cxglkxdAEPRmlfigt+MoVl3V5sjWQb8Edylc6p0C45+G/GUw4TLr1F36XNIcuRJmmR2s
        Igt3/3Gwz5jNfWOMAcJ9/w4HbelBpy4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-d6QDj_ZeOnW0OFPR5103yA-1; Mon, 27 Mar 2023 11:11:56 -0400
X-MC-Unique: d6QDj_ZeOnW0OFPR5103yA-1
Received: by mail-qt1-f200.google.com with SMTP id e4-20020a05622a110400b003e4e915a164so1964860qty.4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 08:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYh+IUQKnsNavgY4j1iAAQrUA1J5asaTGD0FKGxhaXM=;
        b=TYgcNc3HpKzCzy8yQKs1/aqPU495iUP0hnR/t9UiWwdHexVBcXu58egSjpCfpo9qPL
         OonJjbB/l/4HY7B2UIE9AqhxyRPB4kIZ2FOm5A/ruv4SsMMWcnP7T6ZGp8QvEQFmLEfi
         rGpgNP714jsSRvKQT3DGjzw/G8lVUDKDcqgJE41Yis/E4yriJgMrrKrp4Kcmrqou9k3K
         3Y+B2AaotBmj78JOyaRRUZlgW7hRDqlZSjcuOshcOwuWjZTppC9Q13tehQRP+Fs6DzoS
         jlf0ij92WKJ0Ss6soL4G2Vu8OU0HtLX6UXCuMgluvjE13Jo7zJXai7CHq3ZFUegPw7vi
         ctEQ==
X-Gm-Message-State: AO0yUKUJ2vV7DgOc/af0SjaM3D7rxhCMWG1AepgZPxvvUx7RkSaYDZ+o
        y7qkexOwNj73q383bnU6ewqR0y6AIuid7rswAj2X7wg5RVAeOC+gK/vxEjGoRuehf8qW+lIqyDL
        fsZAhf5dxpnkhMfryrzZUk/rbYGg=
X-Received: by 2002:ac8:57c2:0:b0:3e1:6c7e:2ee0 with SMTP id w2-20020ac857c2000000b003e16c7e2ee0mr22110180qta.11.1679929915685;
        Mon, 27 Mar 2023 08:11:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set9BAzNnvmMx3UPAztYRtfcEZS/JC0Zbgk59lkyKNRW1O3h/77E7anPa59QcSLU+bg9VrGKy2w==
X-Received: by 2002:ac8:57c2:0:b0:3e1:6c7e:2ee0 with SMTP id w2-20020ac857c2000000b003e16c7e2ee0mr22110133qta.11.1679929915395;
        Mon, 27 Mar 2023 08:11:55 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l6-20020ac848c6000000b003bfb0ea8094sm8328255qtr.83.2023.03.27.08.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:11:55 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] brcmsmac: ampdu: remove unused suc_mpdu variable
Date:   Mon, 27 Mar 2023 11:11:51 -0400
Message-Id: <20230327151151.1771350-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

clang with W=1 reports
drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:848:5: error: variable
  'suc_mpdu' set but not used [-Werror,-Wunused-but-set-variable]
        u8 suc_mpdu = 0, tot_mpdu = 0;
           ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index 2631eb7569eb..e24228e60027 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -845,7 +845,7 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 	u16 seq, start_seq = 0, bindex, index, mcl;
 	u8 mcs = 0;
 	bool ba_recd = false, ack_recd = false;
-	u8 suc_mpdu = 0, tot_mpdu = 0;
+	u8 tot_mpdu = 0;
 	uint supr_status;
 	bool retry = true;
 	u16 mimoantsel = 0;
@@ -975,7 +975,6 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 				ieee80211_tx_status_irqsafe(wlc->pub->ieee_hw,
 							    p);
 				ack_recd = true;
-				suc_mpdu++;
 			}
 		}
 		/* either retransmit or send bar if ack not recd */
-- 
2.27.0

