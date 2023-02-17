Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88469A72B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 09:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQIlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 03:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQIk7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 03:40:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3245FBF2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 00:40:58 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r11so117324pgu.9
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdEuNBGf/q2On5Lj7U9zc5dVzdIg0cai+qv7AGjRVaY=;
        b=YjHe99LyYwqaNf1arp5wRrpEK/NVEwilumZDSjtK/RXB0BL/iPrrKUpk3jU+A0oLp2
         Auy/hBIrwvs6ZdiFKsFMTZ/NrRhMwwqDBEAoYoIVditLB5hjIR1vxPbMiBGJ6/ONe557
         B46Nsm2as94c+LOmSRXIhNfvgtcY2Jrx2pg6g3ENdVgh3GIgtiPj7FX7GVnd/uKmiTco
         haFlo4ddyuKojIuDnikcb29YjK0+IbwV9l3Vg8cgLxpdxljyLo4qCujcBjw7adPBJGWI
         rbtWMlbSveFyO8effFpZ0fasyIDoYYJZzRuH6zZAmBS+JGSQVEPZO84V0gckx/K+84+B
         QXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdEuNBGf/q2On5Lj7U9zc5dVzdIg0cai+qv7AGjRVaY=;
        b=cL/K7fQcDLizPShdCpnedt1Ujf6PfjRt+xXdJVu5CHFDnxwKAHOcuAuIP/rVDZId2z
         lElvSdjLTkMP4FtIOGulnIlajntPgtgaEgs8DCa7uRR0DC84ZcfdIjZBg7rpb67BGlEU
         AWMoF2U9VF8gHkyVAXmaHUKp6tTf+TaapAQt2GZ6g5ziyWjR1kenzUlGgVp5l3dBUp+y
         6btMjxruNnPvr9J8awcd4r9q5hu02xBFRiJWIfoxuw6NpM3Groza9P22SaLRsQhaX5Vi
         RNL1JofA+OXtzkLNOOycv8B01Tgruc3sbanGtBEwujJ+KMThwERYQM5OqjLHcJ+P/tnl
         2tFw==
X-Gm-Message-State: AO0yUKX+XbAeo59MYy+Gdcd3KtwXw39FM4k+ZzKVZfPqqP/LXLc7mQhV
        bjhcamPLwIKpNA83bxmRjIw=
X-Google-Smtp-Source: AK7set8gBozygHD/K1Ye3YFogp1JLa1UXCRjULGHglPkQ0fBAwu53bl4pjV4Ct6pRWRyXM97DbuMkQ==
X-Received: by 2002:aa7:96a4:0:b0:5a9:c682:831d with SMTP id g4-20020aa796a4000000b005a9c682831dmr2863268pfk.13.1676623257960;
        Fri, 17 Feb 2023 00:40:57 -0800 (PST)
Received: from localhost.localdomain (2603-8000-0b00-9100-59b8-62b0-d0ce-78f9.res6.spectrum.com. [2603:8000:b00:9100:59b8:62b0:d0ce:78f9])
        by smtp.gmail.com with ESMTPSA id n20-20020aa79054000000b005a8da960fa8sm2632688pfo.144.2023.02.17.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:40:57 -0800 (PST)
From:   Anthony Refuerzo <anthony96922@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anthony Refuerzo <anthony96922@gmail.com>
Subject: [PATCH] iw: Add more VHT capabilities reporting
Date:   Fri, 17 Feb 2023 00:40:44 -0800
Message-Id: <20230217084044.11424-1-anthony96922@gmail.com>
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

