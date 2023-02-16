Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E9699E25
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 21:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBPUqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 15:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPUqA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 15:46:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD324ECDC
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 12:45:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso7120161pjn.5
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 12:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+dJ8t2gBa9L1R+LAQs9EyaIo7YKVsYcDwELTn6KK5Q=;
        b=UZDuDSzm+NkP3sFwV58iysHHJeGVMAubX+I+oyv/D1J5/PAr7CiY2dUAyBiSU5kmSB
         n8H3ksZReCvWQoOToeh1SNtBr8XKkUGo9kHU9ip8oKZyKXW7eSJ4nSJdnzB0ekduNKLW
         pHGjWDkm1ygb4m7AyZFRsfUtDMU7/Vxy8gnTYPNa8njgsvQutU/nZYmEj8bL9i6CsxmW
         Uttayc04IEgVihUA6kwbpT00Q0ZVr9EgBbYh0UmpIK39o2uQSe0fJ1kkSNifBS5jmcRE
         6cKA9ZInAVXMpndZqW+nmaSMGfuUXrH0optuQ3rRP7cOjVENkO0v5j3z7ClVYKY3gDYs
         8c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+dJ8t2gBa9L1R+LAQs9EyaIo7YKVsYcDwELTn6KK5Q=;
        b=SjZaHuc57P7nEBYQ5uCl9u+TQ6QIijuZ7lVF8SR5cZ4+Ll7TM/n3Pj4IoVtJ963Db3
         csbQaIEph+SAoziDfLRUQpZPHEBH0a19x3c9uHtrSyPzCuzvWpxZE9KXtjusmwaBP5Ta
         AOqWiBPxjUQhChwNVtqCHmpvUv0Mx0JkH+vQfAAW7mZpAkQFvG9d0G9hWWPX13TtFs/p
         InJzBA84pv8M/BIerJvXPE1wJTtNo0e/Ace8QZNQ021fFha3RitIJ//VyNIX6H7SV/oX
         Xk6fy+wRqHpGTxltjHHOq4suLhAT++g9VAa+T8SJgvHVkPeAOag8yO71sN4uwbWonNt0
         jWAw==
X-Gm-Message-State: AO0yUKWta46AHr/N+hvXrJwNA+TksXyD5MK7aJ79QYYQqh+sgMQRo9RB
        HhlqwK7uDl0kyhM9NRA0H8mVxpo1QgGX8w==
X-Google-Smtp-Source: AK7set8L/OSAGmB+yncP8awgrinIkZ83EHNUUDox3Gjx31qxIF+EsEOOF6Zc97xSNNiqpIV4KXIxdw==
X-Received: by 2002:a05:6a21:3017:b0:c6:7673:f384 with SMTP id yd23-20020a056a21301700b000c67673f384mr6092459pzb.14.1676580359037;
        Thu, 16 Feb 2023 12:45:59 -0800 (PST)
Received: from localhost.localdomain (2603-8000-0b00-9100-f4e1-a6f1-652b-cfd4.res6.spectrum.com. [2603:8000:b00:9100:f4e1:a6f1:652b:cfd4])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00183c67844aesm1744391plb.22.2023.02.16.12.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:45:58 -0800 (PST)
From:   Anthony Refuerzo <anthony96922@gmail.com>
To:     anthony96922@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] iw: Add more VHT capabilities reporting
Date:   Thu, 16 Feb 2023 12:45:46 -0800
Message-Id: <20230216204546.9870-1-anthony96922@gmail.com>
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

