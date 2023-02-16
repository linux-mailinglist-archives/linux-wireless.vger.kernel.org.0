Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4184699EAA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBPVID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 16:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjBPVIC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 16:08:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89C2BF28
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 13:08:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k13so3500342plg.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 13:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdEuNBGf/q2On5Lj7U9zc5dVzdIg0cai+qv7AGjRVaY=;
        b=hEK4alHo7ja6WL821P0Pd1YApzxmXk0XuarrxL8kkBKi2Vh3ry4vrdPJfTUhTuFtQ5
         D5EUDm/EfmXo2r09kv2B2QCE30LzSmAbd3bEK63anPpKtaFZJGl1qZ/m8Fy/SC4ctti+
         Oz70RLRORNTeJIo5MFr/lpAWtaJUXbcmWPJzvsv7tHfPs4mQT4NREort8zcGWfCUOHkC
         EsvUMhY+HUfigVjatjYlNKx+avxUn6BwTFarVCaCDvX5p5rAktFPQv4/QCczuHzxyGqb
         PWj+nVHc6XHLFLykFXHGuwFaqT0cYWi5nNPMnFPFGJ0qIWpTrKbEYSs4ZdG1g6QQkFei
         qKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdEuNBGf/q2On5Lj7U9zc5dVzdIg0cai+qv7AGjRVaY=;
        b=Oop8/czAYzZ+cfIzYl6e0eywxTBVF1D/Z8xgdOwu9jNwGayWo7X7JaCsCSdra51oYx
         NWxLsmCH057ORUTIc312EqxyqdYBN3asr51QfjuR30SZpcI+UeZ8wTyFAirmrB+rbOJu
         asLHjyAmkfKC4PN+PoQj6/+jy4CDObxcLiboKybATBFZPwe9p7jQUH9x/JetLRvmQwBD
         WYm76wnmRIaGOr0CiR0jWqeOKRQDRKcS2w+yJT4efhfb5wT2u/3oWzJ6tov5DK7ISJad
         xpQZwZPqBMwZDrnK6SYEmIMTHY2IqdtC+8qFvvCcheKrCzYeGPfLAjYvz7IZU5PyRpoY
         9e1A==
X-Gm-Message-State: AO0yUKXQjv/oLN3hsjTCn5kcH7YT1J7UCErdGs5u/bwbKIkgfrc+48hS
        AdSA91YbnzRYobrQ9dlAhgs=
X-Google-Smtp-Source: AK7set+Ry8Wk4yBl/JAlCdfHeCcAh/kraFVtolSLU6CFG8LzJM6j7CmrOufqMQLQ22aVygB+sSN/bA==
X-Received: by 2002:a05:6a20:938f:b0:c0:1faa:9b69 with SMTP id x15-20020a056a20938f00b000c01faa9b69mr8959256pzh.58.1676581680934;
        Thu, 16 Feb 2023 13:08:00 -0800 (PST)
Received: from localhost.localdomain (2603-8000-0b00-9100-f4e1-a6f1-652b-cfd4.res6.spectrum.com. [2603:8000:b00:9100:f4e1:a6f1:652b:cfd4])
        by smtp.gmail.com with ESMTPSA id w24-20020aa78598000000b005a91adff67asm1752411pfn.175.2023.02.16.13.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 13:08:00 -0800 (PST)
From:   Anthony Refuerzo <anthony96922@gmail.com>
To:     anthony96922@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] iw: Add more VHT capabilities reporting
Date:   Thu, 16 Feb 2023 13:07:44 -0800
Message-Id: <20230216210744.10388-1-anthony96922@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add extra reporting for VHT capabilities. These were not previously shown.

Signed-off-by: Anthony Refuerzo <anthony96922@gmail.com>
---
 scan.c | 12 ++++++++++++
 util.c | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/scan.c b/scan.c
index dfc136a..9bfa014 100644
--- a/scan.c
+++ b/scan.c
@@ -1508,6 +1508,8 @@ static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
+	__u16 tmp;
+	int i;
 	const char *chandwidths[] = {
 		[0] = "20 or 40 MHz",
 		[1] = "80 MHz",
@@ -1521,6 +1523,16 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 	printf("\t\t * center freq segment 1: %d\n", data[1]);
 	printf("\t\t * center freq segment 2: %d\n", data[2]);
 	printf("\t\t * VHT basic MCS set: 0x%.2x%.2x\n", data[4], data[3]);
+	tmp = data[3] | (data[4] << 8);
+	for (i = 1; i <= 8; i++) {
+		printf("\t\t\t%d streams: ", i);
+		switch ((tmp >> ((i-1)*2) ) & 3) {
+		case 0: printf("MCS 0-7\n"); break;
+		case 1: printf("MCS 0-8\n"); break;
+		case 2: printf("MCS 0-9\n"); break;
+		case 3: printf("not supported\n"); break;
+		}
+	}
 }
 
 static void print_supp_op_classes(const uint8_t type, uint8_t len,
diff --git a/util.c b/util.c
index 8a2ba10..c026f8b 100644
--- a/util.c
+++ b/util.c
@@ -1125,16 +1125,42 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	PRINT_VHT_CAPA(6, "short GI (160/80+80 MHz)");
 	PRINT_VHT_CAPA(7, "TX STBC");
 	/* RX STBC */
+	switch ((capa & 0x700) >> 8) {
+	case 1: printf("\t\t\tRX STBC 1-stream\n"); break;
+	case 2: printf("\t\t\tRX STBC 2-streams\n"); break;
+	case 3: printf("\t\t\tRX STBC 3-streams\n"); break;
+	case 4: printf("\t\t\tRX STBC 4-streams\n"); break;
+	case 5: printf("\t\t\tRX STBC 5-streams\n"); break;
+	case 6: printf("\t\t\tRX STBC 6-streams\n"); break;
+	case 7: printf("\t\t\tRX STBC 7-streams\n"); break;
+	default: printf("\t\t\tNo RX STBC\n");
+	}
 	PRINT_VHT_CAPA(11, "SU Beamformer");
 	PRINT_VHT_CAPA(12, "SU Beamformee");
 	/* compressed steering */
+	printf("\t\t\tCompressed Steering Number of Beamformer Antennas: %d\n",
+		((capa & 0xe000) >> 13) + 1);
 	/* # of sounding dimensions */
+	printf("\t\t\tNumber of Sounding Dimensions: %d\n",
+		((capa & 0x70000) >> 16) + 1);
 	PRINT_VHT_CAPA(19, "MU Beamformer");
 	PRINT_VHT_CAPA(20, "MU Beamformee");
 	PRINT_VHT_CAPA(21, "VHT TXOP PS");
 	PRINT_VHT_CAPA(22, "+HTC-VHT");
 	/* max A-MPDU */
+	printf("\t\t\tMax A-MPDU Length: %d (exponent: %d)\n",
+		(1 << (((capa & 0x3800000) >> 23) + 13)) - 1,
+		((capa & 0x3800000) >> 23));
 	/* VHT link adaptation */
+	if (capa & 0xc000000) {
+		printf("\t\t\tVHT Link Adaptation: ");
+		switch ((capa & 0xc000000) >> 26) {
+		case 1: printf("(reserved)\n"); break;
+		case 2: printf("Unsolicited\n"); break;
+		case 3: printf("Both Solicited and Unsolicited\n"); break;
+		default: printf("No Feedback\n"); break;
+		}
+	}
 	PRINT_VHT_CAPA(28, "RX antenna pattern consistency");
 	PRINT_VHT_CAPA(29, "TX antenna pattern consistency");
 
-- 
2.30.2

