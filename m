Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE665699EA1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 22:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBPVGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 16:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBPVGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 16:06:32 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E74505D3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 13:06:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s20so2293383pfe.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+dJ8t2gBa9L1R+LAQs9EyaIo7YKVsYcDwELTn6KK5Q=;
        b=FilrPJZqB0r7ThyPmocoNurUexs8Exde+BrUCaWeXP+aFxVUre+effd9mArt5HLP1G
         8jFsydBAXp602d8gkevx7w9dazLIFVVO7H4cT4otcsT6CbI+cUwEF7wYj2HQsWwy4tqt
         wGk9G/JLamgV7vmUKGLQdzYYBTqQLwHgSfto0fiDtLJo4pZn40FFmU5eTiZo1r777k7b
         6hTx1k7c8MSt4bFrnyR0Bn18XcVqIekT2raLDv6p4QUMR+iNTcQwSwh9pPF1fIVHG1v9
         vZI9VrT9bJXL8ni5RjcRCDpiFrw9RWDT3vkGoCpeqcsjz5vTVICwC7nMVU2fRIzSZUZk
         Aaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+dJ8t2gBa9L1R+LAQs9EyaIo7YKVsYcDwELTn6KK5Q=;
        b=BhpohoC5JuYwzlv8xs/OYMLh/GviQ5lqExQnrcpS11UylwRVxlj0pQzVZSM6fydSPM
         ToyzZiplWWR/hXziSpPYssNQkw1OVb5JBeVSda/+/g7wki3lHSGyuk8+FgxpmbWwCPeJ
         5RKXQ7Vk8/NAdGSgfQCdO4v24XNXJ7JcGV2JB2sXBGWZ15u3bdth9v8fTHfUpHyT+/2X
         OFw9ppPN7BJaDGtXB01lONmakbzK9boKx6sKC/i4QA6z5LgHMAeXNAH5kI9YnMCvVzg4
         A0g4j+k98Sr6+LbV7pWbRtWSqhazy1eFuXYpnFBAPElRSZMKg0cqQ9lGJK7SDLCFtEXF
         K9Pg==
X-Gm-Message-State: AO0yUKXOH9JVW6vqubKcxIJkcpaVnpC1/zlgLJ29qY3Bzk0+ziJJ5LlT
        iFtw5G30gPYS2nR1VlRy1I6ek1WnOaHKNA==
X-Google-Smtp-Source: AK7set/qXreUwqGYBtmPklk0nkulMjtMqlIQyLFUwEIJPQAyJw9RsJ4REb7Q5ISCBDXRxYw+tpN0uQ==
X-Received: by 2002:a62:1a56:0:b0:5a8:d407:60f9 with SMTP id a83-20020a621a56000000b005a8d40760f9mr5717512pfa.29.1676581591130;
        Thu, 16 Feb 2023 13:06:31 -0800 (PST)
Received: from localhost.localdomain (2603-8000-0b00-9100-f4e1-a6f1-652b-cfd4.res6.spectrum.com. [2603:8000:b00:9100:f4e1:a6f1:652b:cfd4])
        by smtp.gmail.com with ESMTPSA id j9-20020a62e909000000b005a87d636c66sm1701526pfh.136.2023.02.16.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 13:06:30 -0800 (PST)
From:   Anthony Refuerzo <anthony96922@gmail.com>
To:     anthony96922@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] iw: Add more VHT capabilities reporting
Date:   Thu, 16 Feb 2023 13:06:24 -0800
Message-Id: <20230216210624.10271-1-anthony96922@gmail.com>
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

