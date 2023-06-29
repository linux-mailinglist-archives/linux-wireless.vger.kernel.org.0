Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F87430FA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjF2XRF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:17:05 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231305AbjF2XQ7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz1UTKCPYsXNyAXNYJePgPp5OAUuFTAPuuYBnUUOA6wEeqQhjNXBNVYgFD8sTIDJBADl7PFZMi6HePTQwZ+0apGJLn4H9MOvO6HFC9HxXXI4CpHqurne3iLN/GyrBWBAFBPS3In1cidEg6+IKCeTah2rD4OQOO52jDYXqPdNg4DfJOGfY8x60iMA2Pp1dPvg8SkqUHKLjQ4D34cF0WSHHfyN8aYB7qtRRkm7SJ8AUbRl9JAP8y/jV9OSO9fNCo+reabFRDX23P3dQvoco0QJOxNmJ6g9pLBONZHeizZoiw+3SAODhytBAzA3s9ykyBB6nriwH/ZO55eES/iFBt10Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZBFcS7qaTGVHy3wywWFfOaESH0onhkR5/dOj/xOEjc=;
 b=MEhKMbsnZZCxSsxKbZ0YlIf0DJp2RlgPjrO7FS1iJuUnB2KjCZgwon5IrF/DR2b5UWu+8OyR7q5sYRyeYQssBGWz+B/fCVGOLbFTyQ4hjQ/scXrnIa9ZgTEAoOp/c56xeuVw+PrAXmwOs0F3xq8OoxMI9GTbXAZIPyJQFZx2NuwxNKAW/kKdLiKa/RfPvZ5Sj/57Bc/pmB0cjFjugtAY5XqK9GdmRbSobP2K7RwzqVr7fyckuEkUi9MvYYiEPBJEsko3RQQxzWYyLpIT6f9DR3Y1t5mXw4uKtjSq9jvEeEys364uAep+Qq/Day8LzmsblcF+1LPyyPPUkFkCIpDAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:49 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:49 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 03/11] wifi: ath9k: add _ah parameter to certain macros
Date:   Thu, 29 Jun 2023 16:16:17 -0700
Message-Id: <20230629231625.951744-4-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT3PR01MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b2af67-a304-4a1b-f0f7-08db78f6ea56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuE/O6LRG1VkZKNo/FAJSLnKiUQXyD7WRuUu1Yz3PaL9O7OXzRIPW4jtOezHs7kZBpq6ws9T4TopKEqkYC0OBdLYcjTqC+9HQ9noOFv1JR0E6tTpYOosD2de/pxq2T17otcMMtryS6hpE97fNslpn7odGwbSc5m0cFfnInsIpmFnm2sD7fkgZM1Jk6hjr4+ynuNvsnQw1v1J0CcHfIGLnu2q0tbRTnxK/6gtBGEqafXwJFqDMPkRN1M4o/vTStDKw2KsuVUzhj4zeKGlSADgzOzo2wh+xSUBTLhKz3NV4DwproIExfr1ROIGA+Bniw1yNVcLa9ySmJaEAxhqSkW36JelPRkbGI0qfEEjCx2dCNusjyIFJto3JM1bVd2S24RwmiQO33L6ySrn0UWH4F2PzlUEMDOJ8hrtfEZAyu5FBN7NhVgTSBhp7iCp7tnRtR3LlO+Y12mp+VlYbwJOXiWwMTxSbU1P4H3niJb43rwN4rDmuy3zkYAszF04orA8ZXALI5qNudlFPztcl8y/Ui00lCNH/TTcRPI4TE2spXVFbKe+ltsSlrn4pSU8gujcur+fbxWzmA+P5InvoEyc98CFHWj2fUTRNSJ7VvtoYAnlsCOvGIe2uQ5H9xR1+5av/4dB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(30864003)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMrjJXiLUtW0WMN8yHLbw2wu45SlX2qVhUac5uLSgjmRHVM551KkhVXrk332?=
 =?us-ascii?Q?aT/gwFub1BKkTu7JryIla1fTvwEpZl6Spg+VLVAGikOBNEHDa3hOPWpvcabc?=
 =?us-ascii?Q?t6/73Uy2eLEhiAZQ6IKECQXf8ciuhAqHNR6OPWonOOrD9EnnAC46o1IpO/oT?=
 =?us-ascii?Q?15SqrkDXHQ9ldOMIT+YZ/N3ztamDKd4GoEWmoGsy2OJLY5shjnTdC2K1LUgF?=
 =?us-ascii?Q?CQrouiibOrV983K6HFTKpIomqk0/tLXQSEWYsGykEu29KS5Czym4SY+nB+d0?=
 =?us-ascii?Q?QlCoBlr3/huaJTeYoUTuskub+fILwlqarkXYJhQdmNdskamEnDqbspTegqUx?=
 =?us-ascii?Q?NUAW4C2kllbtPP5fbow7QEIEJ4fdFgHUA+stSYjUp5tru3HrdhqSC1tz0weg?=
 =?us-ascii?Q?076ODgQ9/GMyu4ZV90G/+SxIBUVvQtBvzEm0VfHzRILwZUD6KjeOiJLEfWra?=
 =?us-ascii?Q?5pY2TraSgRxU8eWjVPPQjsr9SVRPidJ9dNE57i8MWD94KOlQsx447DYAmZ/4?=
 =?us-ascii?Q?N/cMFLGOMufUhCBTT6eqrsvqfIf0msKK8fHghY/rsWyKMfxEFUP9bl9Qh0IC?=
 =?us-ascii?Q?T93I0hsy6Y5oymjPkUZpZxqleXsn5ejWci4ZreR8MuYRlS+/fQlT609Ile4w?=
 =?us-ascii?Q?bllzfKndEnnufjKpze4z54sTSSZv7kr1/JCWznTF2d00Li9JYFDMhrUiSXeX?=
 =?us-ascii?Q?mNtr0C+bnejqWEjVl/D1DqR56EnO4vPscMpe6MuTdn9jgONxi7WGf23cz9UC?=
 =?us-ascii?Q?tAez1zPnTGqoWBIUhlr2Q6HCLllxpVqy/yVRCZV8+EFdQLx9ub0dCl0InjbE?=
 =?us-ascii?Q?DY/lUAxUmuvLADNH5YwK+/SEt8amV9m6yc1Ye43wUAF4mCG3Nr+1XIHuv8hz?=
 =?us-ascii?Q?pnitUUlpn2A0KkJeA2l7mOE1c79MgW+QVcQwu4zowfB/GEcwD89hNK6MHeuq?=
 =?us-ascii?Q?i9LQYQ6PrDuv4UpyOZ6OLBdBlM1+S9FlwcFPlS4RdvlOhzkJDdJGWG/mOJ53?=
 =?us-ascii?Q?5ubXMIkrnF7nQIN4D0OGLmioL4dLiiIsDCWH8+wTHK4XVdfr6zDqKLds5z+x?=
 =?us-ascii?Q?mW1xQ4t2/ACVGWABb2z3jrRnkXF/iOrofyViy2TgPSTwGoemOXBKVKWtD05k?=
 =?us-ascii?Q?qkZeQWVwno1QLzXuCKNSshl7bYOOIPlGLOEQ94hTCeycPZUY9zoe88kSVwEu?=
 =?us-ascii?Q?uxT8F0GM5XF/zLYI44rKdFBHnsNENiudYQyiS8YLRYb7sZXuEX9GDzd2T0pA?=
 =?us-ascii?Q?3CbXadC5t/dHaBdDltPun0b4CEqfyAmOLGSh8jQ6SY7RM9tXfZ95TEmPqPcW?=
 =?us-ascii?Q?rb6qn92PfreD6WAKJlqifrNeUFY5r7n3OLM4OdjZlKInV2dSnd7ZFh8qhhjf?=
 =?us-ascii?Q?0SOxLhJjgTPgryuhj9iOHkOWZEHXu3CX758puBU4FkDdbFMgHlynow5vHK3E?=
 =?us-ascii?Q?/Hve07W2OkfqvuN2vTHPXVfPD2ZGWwJwa3qztn+V38aqv95fmDnmrwKO83cK?=
 =?us-ascii?Q?k7WobVqxzGmJAoHzW8kgrdwxzh+u91+5QuifA+/8JoTjADB6CU0r0y3r2oRn?=
 =?us-ascii?Q?29aQbbHGruS868pQ+KJjctN+eQ4oNVAJuGaSvZ4G?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b2af67-a304-4a1b-f0f7-08db78f6ea56
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:49.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAC352baqhmXUHpRUvZJcbEM26owwSEwv3DYYIb7yk3F+3DHKnuJtsxiTAowJiPpR8ojI0zUjBIta5d4zS00FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These macros will have different values for QCN5502.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_aic.c   |  52 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |  94 +--
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 130 ++---
 drivers/net/wireless/ath/ath9k/ar9003_mci.c   |   4 +-
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c | 116 ++--
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   | 322 +++++-----
 drivers/net/wireless/ath/ath9k/ar9003_phy.h   | 550 +++++++++---------
 drivers/net/wireless/ath/ath9k/ar9003_rtt.c   |  32 +-
 drivers/net/wireless/ath/ath9k/reg.h          |   6 +-
 drivers/net/wireless/ath/ath9k/reg_aic.h      |  40 +-
 drivers/net/wireless/ath/ath9k/rng.c          |   4 +-
 11 files changed, 675 insertions(+), 675 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_aic.c b/drivers/net/wireless/ath/ath9k/ar9003_aic.c
index d0f1e8bcc8..9ba55fea67 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_aic.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_aic.c
@@ -108,8 +108,8 @@ static void ar9003_aic_gain_table(struct ath_hw *ah)
 	u32 aic_atten_word[19], i;
 
 	/* Config LNA gain difference */
-	REG_WRITE(ah, AR_PHY_BT_COEX_4, 0x2c200a00);
-	REG_WRITE(ah, AR_PHY_BT_COEX_5, 0x5c4e4438);
+	REG_WRITE(ah, AR_PHY_BT_COEX_4(ah), 0x2c200a00);
+	REG_WRITE(ah, AR_PHY_BT_COEX_5(ah), 0x5c4e4438);
 
 	/* Program gain table */
 	aic_atten_word[0] = (0x1 & 0xf) << 14 | (0x1f & 0x1f) << 9 | (0x0 & 0xf) << 5 |
@@ -152,12 +152,12 @@ static void ar9003_aic_gain_table(struct ath_hw *ah)
 		(0x1 & 0x1f);  /* -37 dB: 4'd7, 5'd01, -36 dB: 4'd6, 5'd01 */
 
 	/* Write to Gain table with auto increment enabled. */
-	REG_WRITE(ah, (AR_PHY_AIC_SRAM_ADDR_B0 + 0x3000),
+	REG_WRITE(ah, (AR_PHY_AIC_SRAM_ADDR_B0(ah) + 0x3000),
 		  (ATH_AIC_SRAM_AUTO_INCREMENT |
 		   ATH_AIC_SRAM_GAIN_TABLE_OFFSET));
 
 	for (i = 0; i < 19; i++) {
-		REG_WRITE(ah, (AR_PHY_AIC_SRAM_DATA_B0 + 0x3000),
+		REG_WRITE(ah, (AR_PHY_AIC_SRAM_DATA_B0(ah) + 0x3000),
 			  aic_atten_word[i]);
 	}
 }
@@ -168,16 +168,16 @@ static u8 ar9003_aic_cal_start(struct ath_hw *ah, u8 min_valid_count)
 	int i;
 
 	/* Write to Gain table with auto increment enabled. */
-	REG_WRITE(ah, (AR_PHY_AIC_SRAM_ADDR_B0 + 0x3000),
+	REG_WRITE(ah, (AR_PHY_AIC_SRAM_ADDR_B0(ah) + 0x3000),
 		  (ATH_AIC_SRAM_AUTO_INCREMENT |
 		   ATH_AIC_SRAM_CAL_OFFSET));
 
 	for (i = 0; i < ATH_AIC_MAX_BT_CHANNEL; i++) {
-		REG_WRITE(ah, (AR_PHY_AIC_SRAM_DATA_B0 + 0x3000), 0);
+		REG_WRITE(ah, (AR_PHY_AIC_SRAM_DATA_B0(ah) + 0x3000), 0);
 		aic->aic_sram[i] = 0;
 	}
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_0_B0,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_0_B0(ah),
 		  (SM(0, AR_PHY_AIC_MON_ENABLE) |
 		   SM(127, AR_PHY_AIC_CAL_MAX_HOP_COUNT) |
 		   SM(min_valid_count, AR_PHY_AIC_CAL_MIN_VALID_COUNT) |
@@ -187,14 +187,14 @@ static u8 ar9003_aic_cal_start(struct ath_hw *ah, u8 min_valid_count)
 		   SM(0x40, AR_PHY_AIC_BTTX_PWR_THR) |
 		   SM(0, AR_PHY_AIC_ENABLE)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_0_B1,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_0_B1(ah),
 		  (SM(0, AR_PHY_AIC_MON_ENABLE) |
 		   SM(1, AR_PHY_AIC_CAL_CH_VALID_RESET) |
 		   SM(0, AR_PHY_AIC_CAL_ENABLE) |
 		   SM(0x40, AR_PHY_AIC_BTTX_PWR_THR) |
 		   SM(0, AR_PHY_AIC_ENABLE)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_1_B0,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_1_B0(ah),
 		  (SM(8, AR_PHY_AIC_CAL_BT_REF_DELAY) |
 		   SM(0, AR_PHY_AIC_BT_IDLE_CFG) |
 		   SM(1, AR_PHY_AIC_STDBY_COND) |
@@ -203,11 +203,11 @@ static u8 ar9003_aic_cal_start(struct ath_hw *ah, u8 min_valid_count)
 		   SM(15, AR_PHY_AIC_RSSI_MAX) |
 		   SM(0, AR_PHY_AIC_RSSI_MIN)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_1_B1,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_1_B1(ah),
 		  (SM(15, AR_PHY_AIC_RSSI_MAX) |
 		   SM(0, AR_PHY_AIC_RSSI_MIN)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_2_B0,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_2_B0(ah),
 		  (SM(44, AR_PHY_AIC_RADIO_DELAY) |
 		   SM(8, AR_PHY_AIC_CAL_STEP_SIZE_CORR) |
 		   SM(12, AR_PHY_AIC_CAL_ROT_IDX_CORR) |
@@ -217,7 +217,7 @@ static u8 ar9003_aic_cal_start(struct ath_hw *ah, u8 min_valid_count)
 		   SM(0, AR_PHY_AIC_CAL_SYNTH_AFTER_BTRX) |
 		   SM(200, AR_PHY_AIC_CAL_SYNTH_SETTLING)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_3_B0,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_3_B0(ah),
 		  (SM(2, AR_PHY_AIC_MON_MAX_HOP_COUNT) |
 		   SM(1, AR_PHY_AIC_MON_MIN_STALE_COUNT) |
 		   SM(1, AR_PHY_AIC_MON_PWR_EST_LONG) |
@@ -227,14 +227,14 @@ static u8 ar9003_aic_cal_start(struct ath_hw *ah, u8 min_valid_count)
 		   SM(1, AR_PHY_AIC_CAL_PERF_CHECK_FACTOR) |
 		   SM(1, AR_PHY_AIC_CAL_PWR_EST_LONG)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_4_B0,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_4_B0(ah),
 		  (SM(2, AR_PHY_AIC_CAL_ROT_ATT_DB_EST_ISO) |
 		   SM(3, AR_PHY_AIC_CAL_COM_ATT_DB_EST_ISO) |
 		   SM(0, AR_PHY_AIC_CAL_ISO_EST_INIT_SETTING) |
 		   SM(2, AR_PHY_AIC_CAL_COM_ATT_DB_BACKOFF) |
 		   SM(1, AR_PHY_AIC_CAL_COM_ATT_DB_FIXED)));
 
-	REG_WRITE(ah, AR_PHY_AIC_CTRL_4_B1,
+	REG_WRITE(ah, AR_PHY_AIC_CTRL_4_B1(ah),
 		  (SM(2, AR_PHY_AIC_CAL_ROT_ATT_DB_EST_ISO) |
 		   SM(3, AR_PHY_AIC_CAL_COM_ATT_DB_EST_ISO) |
 		   SM(0, AR_PHY_AIC_CAL_ISO_EST_INIT_SETTING) |
@@ -251,9 +251,9 @@ static u8 ar9003_aic_cal_start(struct ath_hw *ah, u8 min_valid_count)
 	aic->aic_cal_start_time = REG_READ(ah, AR_TSF_L32);
 
 	/* Start calibration */
-	REG_CLR_BIT(ah, AR_PHY_AIC_CTRL_0_B1, AR_PHY_AIC_CAL_ENABLE);
-	REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1, AR_PHY_AIC_CAL_CH_VALID_RESET);
-	REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1, AR_PHY_AIC_CAL_ENABLE);
+	REG_CLR_BIT(ah, AR_PHY_AIC_CTRL_0_B1(ah), AR_PHY_AIC_CAL_ENABLE);
+	REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1(ah), AR_PHY_AIC_CAL_CH_VALID_RESET);
+	REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1(ah), AR_PHY_AIC_CAL_ENABLE);
 
 	aic->aic_caled_chan = 0;
 	aic->aic_cal_state = AIC_CAL_STATE_STARTED;
@@ -465,7 +465,7 @@ static u8 ar9003_aic_cal_continue(struct ath_hw *ah, bool cal_once)
 
 	if (cal_once) {
 		for (i = 0; i < 10000; i++) {
-			if ((REG_READ(ah, AR_PHY_AIC_CTRL_0_B1) &
+			if ((REG_READ(ah, AR_PHY_AIC_CTRL_0_B1(ah)) &
 			     AR_PHY_AIC_CAL_ENABLE) == 0)
 				break;
 
@@ -477,19 +477,19 @@ static u8 ar9003_aic_cal_continue(struct ath_hw *ah, bool cal_once)
 	 * Use AR_PHY_AIC_CAL_ENABLE bit instead of AR_PHY_AIC_CAL_DONE.
 	 * Sometimes CAL_DONE bit is not asserted.
 	 */
-	if ((REG_READ(ah, AR_PHY_AIC_CTRL_0_B1) &
+	if ((REG_READ(ah, AR_PHY_AIC_CTRL_0_B1(ah)) &
 	     AR_PHY_AIC_CAL_ENABLE) != 0) {
 		ath_dbg(common, MCI, "AIC cal is not done after 40ms");
 		goto exit;
 	}
 
-	REG_WRITE(ah, AR_PHY_AIC_SRAM_ADDR_B1,
+	REG_WRITE(ah, AR_PHY_AIC_SRAM_ADDR_B1(ah),
 		  (ATH_AIC_SRAM_CAL_OFFSET | ATH_AIC_SRAM_AUTO_INCREMENT));
 
 	for (i = 0; i < ATH_AIC_MAX_BT_CHANNEL; i++) {
 		u32 value;
 
-		value = REG_READ(ah, AR_PHY_AIC_SRAM_DATA_B1);
+		value = REG_READ(ah, AR_PHY_AIC_SRAM_DATA_B1(ah));
 
 		if (value & 0x01) {
 			if (aic->aic_sram[i] == 0)
@@ -506,10 +506,10 @@ static u8 ar9003_aic_cal_continue(struct ath_hw *ah, bool cal_once)
 		ar9003_aic_cal_done(ah);
 	} else {
 		/* Start calibration */
-		REG_CLR_BIT(ah, AR_PHY_AIC_CTRL_0_B1, AR_PHY_AIC_CAL_ENABLE);
-		REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1,
+		REG_CLR_BIT(ah, AR_PHY_AIC_CTRL_0_B1(ah), AR_PHY_AIC_CAL_ENABLE);
+		REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1(ah),
 			    AR_PHY_AIC_CAL_CH_VALID_RESET);
-		REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1, AR_PHY_AIC_CAL_ENABLE);
+		REG_SET_BIT(ah, AR_PHY_AIC_CTRL_0_B1(ah), AR_PHY_AIC_CAL_ENABLE);
 	}
 exit:
 	return aic->aic_cal_state;
@@ -548,10 +548,10 @@ u8 ar9003_aic_start_normal(struct ath_hw *ah)
 
 	ar9003_aic_gain_table(ah);
 
-	REG_WRITE(ah, AR_PHY_AIC_SRAM_ADDR_B1, ATH_AIC_SRAM_AUTO_INCREMENT);
+	REG_WRITE(ah, AR_PHY_AIC_SRAM_ADDR_B1(ah), ATH_AIC_SRAM_AUTO_INCREMENT);
 
 	for (i = 0; i < ATH_AIC_MAX_BT_CHANNEL; i++) {
-		REG_WRITE(ah, AR_PHY_AIC_SRAM_DATA_B1, aic->aic_sram[i]);
+		REG_WRITE(ah, AR_PHY_AIC_SRAM_DATA_B1(ah), aic->aic_sram[i]);
 	}
 
 	/* FIXME: Replace these with proper register names */
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
index 2224cb74b1..6d1f1242e6 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -47,16 +47,16 @@ static void ar9003_hw_setup_calibration(struct ath_hw *ah,
 		 * Start calibration with
 		 * 2^(INIT_IQCAL_LOG_COUNT_MAX+1) samples
 		 */
-		REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+		REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 			      AR_PHY_TIMING4_IQCAL_LOG_COUNT_MAX,
 			      currCal->calData->calCountMax);
-		REG_WRITE(ah, AR_PHY_CALMODE, AR_PHY_CALMODE_IQ);
+		REG_WRITE(ah, AR_PHY_CALMODE(ah), AR_PHY_CALMODE_IQ);
 
 		ath_dbg(common, CALIBRATE,
 			"starting IQ Mismatch Calibration\n");
 
 		/* Kick-off cal */
-		REG_SET_BIT(ah, AR_PHY_TIMING4, AR_PHY_TIMING4_DO_CAL);
+		REG_SET_BIT(ah, AR_PHY_TIMING4(ah), AR_PHY_TIMING4_DO_CAL);
 		break;
 	default:
 		ath_err(common, "Invalid calibration type\n");
@@ -80,7 +80,7 @@ static bool ar9003_hw_per_calibration(struct ath_hw *ah,
 	/* Calibration in progress. */
 	if (currCal->calState == CAL_RUNNING) {
 		/* Check to see if it has finished. */
-		if (REG_READ(ah, AR_PHY_TIMING4) & AR_PHY_TIMING4_DO_CAL)
+		if (REG_READ(ah, AR_PHY_TIMING4(ah)) & AR_PHY_TIMING4_DO_CAL)
 			return false;
 
 		/*
@@ -180,11 +180,11 @@ static void ar9003_hw_iqcal_collect(struct ath_hw *ah)
 	for (i = 0; i < AR9300_MAX_CHAINS; i++) {
 		if (ah->txchainmask & BIT(i)) {
 			ah->totalPowerMeasI[i] +=
-				REG_READ(ah, AR_PHY_CAL_MEAS_0(i));
+				REG_READ(ah, AR_PHY_CAL_MEAS_0(ah, i));
 			ah->totalPowerMeasQ[i] +=
-				REG_READ(ah, AR_PHY_CAL_MEAS_1(i));
+				REG_READ(ah, AR_PHY_CAL_MEAS_1(ah, i));
 			ah->totalIqCorrMeas[i] +=
-				(int32_t) REG_READ(ah, AR_PHY_CAL_MEAS_2(i));
+				(int32_t) REG_READ(ah, AR_PHY_CAL_MEAS_2(ah, i));
 			ath_dbg(ath9k_hw_common(ah), CALIBRATE,
 				"%d: Chn %d pmi=0x%08x;pmq=0x%08x;iqcm=0x%08x;\n",
 				ah->cal_samples, i, ah->totalPowerMeasI[i],
@@ -202,9 +202,9 @@ static void ar9003_hw_iqcalibrate(struct ath_hw *ah, u8 numChains)
 	int32_t qCoff, iCoff;
 	int iqCorrNeg, i;
 	static const u_int32_t offset_array[3] = {
-		AR_PHY_RX_IQCAL_CORR_B0,
-		AR_PHY_RX_IQCAL_CORR_B1,
-		AR_PHY_RX_IQCAL_CORR_B2,
+		AR_PHY_RX_IQCAL_CORR_B0(ah),
+		AR_PHY_RX_IQCAL_CORR_B1(ah),
+		AR_PHY_RX_IQCAL_CORR_B2(ah),
 	};
 
 	for (i = 0; i < numChains; i++) {
@@ -297,13 +297,13 @@ static void ar9003_hw_iqcalibrate(struct ath_hw *ah, u8 numChains)
 		}
 	}
 
-	REG_SET_BIT(ah, AR_PHY_RX_IQCAL_CORR_B0,
+	REG_SET_BIT(ah, AR_PHY_RX_IQCAL_CORR_B0(ah),
 		    AR_PHY_RX_IQCAL_CORR_IQCORR_ENABLE);
 	ath_dbg(common, CALIBRATE,
 		"IQ Cal and Correction (offset 0x%04x) enabled (bit position 0x%08x). New Value 0x%08x\n",
-		(unsigned) (AR_PHY_RX_IQCAL_CORR_B0),
+		(unsigned) (AR_PHY_RX_IQCAL_CORR_B0(ah)),
 		AR_PHY_RX_IQCAL_CORR_IQCORR_ENABLE,
-		REG_READ(ah, AR_PHY_RX_IQCAL_CORR_B0));
+		REG_READ(ah, AR_PHY_RX_IQCAL_CORR_B0(ah)));
 }
 
 static const struct ath9k_percal_data iq_cal_single_sample = {
@@ -369,7 +369,7 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 	 */
 	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_OFFSET_CAL);
-	REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL,
+	REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL(ah),
 		    AR_PHY_CL_CAL_ENABLE);
 	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_FLTR_CAL);
@@ -385,7 +385,7 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 		osdac_ch1 = (REG_READ(ah, AR_PHY_65NM_CH1_BB1) >> 30) & 0x3;
 		osdac_ch2 = (REG_READ(ah, AR_PHY_65NM_CH2_BB1) >> 30) & 0x3;
 
-		REG_SET_BIT(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
+		REG_SET_BIT(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_EN);
 
 		REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah),
 			  REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) | AR_PHY_AGC_CONTROL_CAL);
@@ -399,7 +399,7 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 			return false;
 		}
 
-		REG_CLR_BIT(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
+		REG_CLR_BIT(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_EN);
 
 		/*
 		 * High gain.
@@ -533,7 +533,7 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 
 	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_OFFSET_CAL);
-	REG_SET_BIT(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
+	REG_SET_BIT(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_EN);
 
 	/*
 	 * We don't need to check txiqcal_done here since it is always
@@ -901,11 +901,11 @@ static void ar9003_hw_tx_iq_cal_outlier_detection(struct ath_hw *ah,
 		if (!AR_SREV_9485(ah)) {
 			tx_corr_coeff[i * 2][1] =
 			tx_corr_coeff[(i * 2) + 1][1] =
-					AR_PHY_TX_IQCAL_CORR_COEFF_B1(i);
+					AR_PHY_TX_IQCAL_CORR_COEFF_B1(ah, i);
 
 			tx_corr_coeff[i * 2][2] =
 			tx_corr_coeff[(i * 2) + 1][2] =
-					AR_PHY_TX_IQCAL_CORR_COEFF_B2(i);
+					AR_PHY_TX_IQCAL_CORR_COEFF_B2(ah, i);
 		}
 	}
 
@@ -962,9 +962,9 @@ static void ar9003_hw_tx_iq_cal_outlier_detection(struct ath_hw *ah,
 			caldata->num_measures[i] = nmeasurement;
 	}
 
-	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_3,
+	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_3(ah),
 		      AR_PHY_TX_IQCAL_CONTROL_3_IQCORR_EN, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_RX_IQCAL_CORR_B0,
+	REG_RMW_FIELD(ah, AR_PHY_RX_IQCAL_CORR_B0(ah),
 		      AR_PHY_RX_IQCAL_CORR_B0_LOOPBACK_IQCORR_EN, 0x1);
 
 	if (caldata) {
@@ -982,10 +982,10 @@ static bool ar9003_hw_tx_iq_cal_run(struct ath_hw *ah)
 	struct ath_common *common = ath9k_hw_common(ah);
 	u8 tx_gain_forced;
 
-	tx_gain_forced = REG_READ_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	tx_gain_forced = REG_READ_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 					AR_PHY_TXGAIN_FORCE);
 	if (tx_gain_forced)
-		REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+		REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 			      AR_PHY_TXGAIN_FORCE, 0);
 
 	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_START(ah),
@@ -1057,13 +1057,13 @@ static void ar9003_hw_tx_iq_cal_post_proc(struct ath_hw *ah,
 	struct ath_common *common = ath9k_hw_common(ah);
 	const u32 txiqcal_status[AR9300_MAX_CHAINS] = {
 		AR_PHY_TX_IQCAL_STATUS_B0(ah),
-		AR_PHY_TX_IQCAL_STATUS_B1,
-		AR_PHY_TX_IQCAL_STATUS_B2,
+		AR_PHY_TX_IQCAL_STATUS_B1(ah),
+		AR_PHY_TX_IQCAL_STATUS_B2(ah),
 	};
 	const u_int32_t chan_info_tab[] = {
-		AR_PHY_CHAN_INFO_TAB_0,
-		AR_PHY_CHAN_INFO_TAB_1,
-		AR_PHY_CHAN_INFO_TAB_2,
+		AR_PHY_CHAN_INFO_TAB_0(ah),
+		AR_PHY_CHAN_INFO_TAB_1(ah),
+		AR_PHY_CHAN_INFO_TAB_2(ah),
 	};
 	static struct coeff coeff;
 	s32 iq_res[6];
@@ -1165,11 +1165,11 @@ static void ar9003_hw_tx_iq_cal_reload(struct ath_hw *ah)
 		if (!AR_SREV_9485(ah)) {
 			tx_corr_coeff[i * 2][1] =
 			tx_corr_coeff[(i * 2) + 1][1] =
-					AR_PHY_TX_IQCAL_CORR_COEFF_B1(i);
+					AR_PHY_TX_IQCAL_CORR_COEFF_B1(ah, i);
 
 			tx_corr_coeff[i * 2][2] =
 			tx_corr_coeff[(i * 2) + 1][2] =
-					AR_PHY_TX_IQCAL_CORR_COEFF_B2(i);
+					AR_PHY_TX_IQCAL_CORR_COEFF_B2(ah, i);
 		}
 	}
 
@@ -1189,9 +1189,9 @@ static void ar9003_hw_tx_iq_cal_reload(struct ath_hw *ah)
 		}
 	}
 
-	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_3,
+	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_3(ah),
 		      AR_PHY_TX_IQCAL_CONTROL_3_IQCORR_EN, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_RX_IQCAL_CORR_B0,
+	REG_RMW_FIELD(ah, AR_PHY_RX_IQCAL_CORR_B0(ah),
 		      AR_PHY_RX_IQCAL_CORR_B0_LOOPBACK_IQCORR_EN, 0x1);
 }
 
@@ -1336,9 +1336,9 @@ static void ar9003_hw_do_pcoem_manual_peak_cal(struct ath_hw *ah,
 
 static void ar9003_hw_cl_cal_post_proc(struct ath_hw *ah, bool is_reusable)
 {
-	u32 cl_idx[AR9300_MAX_CHAINS] = { AR_PHY_CL_TAB_0,
-					  AR_PHY_CL_TAB_1,
-					  AR_PHY_CL_TAB_2 };
+	u32 cl_idx[AR9300_MAX_CHAINS] = { AR_PHY_CL_TAB_0(ah),
+					  AR_PHY_CL_TAB_1(ah),
+					  AR_PHY_CL_TAB_2(ah) };
 	struct ath9k_hw_cal_data *caldata = ah->caldata;
 	bool txclcal_done = false;
 	int i, j;
@@ -1438,10 +1438,10 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 
 	if (ah->enabled_cals & TX_CL_CAL) {
 		if (caldata && test_bit(TXCLCAL_DONE, &caldata->cal_flags))
-			REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL,
+			REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL(ah),
 				    AR_PHY_CL_CAL_ENABLE);
 		else {
-			REG_SET_BIT(ah, AR_PHY_CL_CAL_CTL,
+			REG_SET_BIT(ah, AR_PHY_CL_CAL_CTL(ah),
 				    AR_PHY_CL_CAL_ENABLE);
 			run_agc_cal = true;
 		}
@@ -1474,13 +1474,13 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 	if (ath9k_hw_mci_is_enabled(ah) && IS_CHAN_2GHZ(chan) && run_agc_cal)
 		ar9003_mci_init_cal_req(ah, &is_reusable);
 
-	if (REG_READ(ah, AR_PHY_CL_CAL_CTL) & AR_PHY_CL_CAL_ENABLE) {
-		rx_delay = REG_READ(ah, AR_PHY_RX_DELAY);
+	if (REG_READ(ah, AR_PHY_CL_CAL_CTL(ah)) & AR_PHY_CL_CAL_ENABLE) {
+		rx_delay = REG_READ(ah, AR_PHY_RX_DELAY(ah));
 		/* Disable BB_active */
-		REG_WRITE(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_DIS);
+		REG_WRITE(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_DIS);
 		udelay(5);
-		REG_WRITE(ah, AR_PHY_RX_DELAY, AR_PHY_RX_DELAY_DELAY);
-		REG_WRITE(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
+		REG_WRITE(ah, AR_PHY_RX_DELAY(ah), AR_PHY_RX_DELAY_DELAY);
+		REG_WRITE(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_EN);
 	}
 
 	if (run_agc_cal || !(ah->ah_flags & AH_FASTCC)) {
@@ -1497,8 +1497,8 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 		ar9003_hw_do_pcoem_manual_peak_cal(ah, chan, run_rtt_cal);
 	}
 
-	if (REG_READ(ah, AR_PHY_CL_CAL_CTL) & AR_PHY_CL_CAL_ENABLE) {
-		REG_WRITE(ah, AR_PHY_RX_DELAY, rx_delay);
+	if (REG_READ(ah, AR_PHY_CL_CAL_CTL(ah)) & AR_PHY_CL_CAL_ENABLE) {
+		REG_WRITE(ah, AR_PHY_RX_DELAY(ah), rx_delay);
 		udelay(5);
 	}
 
@@ -1588,7 +1588,7 @@ static bool ar9003_hw_init_cal_soc(struct ath_hw *ah,
 	ar9003_hw_set_chain_masks(ah, ah->caps.rx_chainmask, ah->caps.tx_chainmask);
 
 	if (ah->enabled_cals & TX_CL_CAL) {
-		REG_SET_BIT(ah, AR_PHY_CL_CAL_CTL, AR_PHY_CL_CAL_ENABLE);
+		REG_SET_BIT(ah, AR_PHY_CL_CAL_CTL(ah), AR_PHY_CL_CAL_ENABLE);
 		run_agc_cal = true;
 	}
 
@@ -1622,9 +1622,9 @@ static bool ar9003_hw_init_cal_soc(struct ath_hw *ah,
 	 */
 	if (sep_iq_cal) {
 		txiqcal_done = ar9003_hw_tx_iq_cal_run(ah);
-		REG_WRITE(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_DIS);
+		REG_WRITE(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_DIS);
 		udelay(5);
-		REG_WRITE(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
+		REG_WRITE(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_EN);
 	}
 
 	if (AR_SREV_9550(ah) && IS_CHAN_2GHZ(chan)) {
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 58dce556b0..3dab290d8a 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3649,9 +3649,9 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 	int chain;
 	u32 regval, value, gpio;
 	static const u32 switch_chain_reg[AR9300_MAX_CHAINS] = {
-			AR_PHY_SWITCH_CHAIN_0,
-			AR_PHY_SWITCH_CHAIN_1,
-			AR_PHY_SWITCH_CHAIN_2,
+			AR_PHY_SWITCH_CHAIN_0(ah),
+			AR_PHY_SWITCH_CHAIN_1(ah),
+			AR_PHY_SWITCH_CHAIN_2(ah),
 	};
 
 	if (AR_SREV_9485(ah) && (ar9003_hw_get_rx_gain_idx(ah) == 0)) {
@@ -3667,13 +3667,13 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 	value = ar9003_hw_ant_ctrl_common_get(ah, is2ghz);
 
 	if (AR_SREV_9462(ah) || AR_SREV_9565(ah)) {
-		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM,
+		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM(ah),
 				AR_SWITCH_TABLE_COM_AR9462_ALL, value);
 	} else if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
-		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM,
+		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM(ah),
 				AR_SWITCH_TABLE_COM_AR9550_ALL, value);
 	} else
-		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM,
+		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM(ah),
 			      AR_SWITCH_TABLE_COM_ALL, value);
 
 
@@ -3703,7 +3703,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 		value |= ah->config.ant_ctrl_comm2g_switch_enable;
 
 	}
-	REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM_2, AR_SWITCH_TABLE_COM2_ALL, value);
+	REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM_2(ah), AR_SWITCH_TABLE_COM2_ALL, value);
 
 	if ((AR_SREV_9462(ah)) && (ah->rxchainmask == 0x2)) {
 		value = ar9003_hw_ant_ctrl_chain_get(ah, 1, is2ghz);
@@ -3727,7 +3727,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 		 * main_lnaconf, alt_lnaconf, main_tb, alt_tb
 		 * are the fields present
 		 */
-		regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+		regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 		regval &= (~AR_ANT_DIV_CTRL_ALL);
 		regval |= (value & 0x3f) << AR_ANT_DIV_CTRL_ALL_S;
 		/* enable_lnadiv */
@@ -3741,7 +3741,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 			if (common->bt_ant_diversity) {
 				regval |= (1 << AR_PHY_ANT_SW_RX_PROT_S);
 
-				REG_SET_BIT(ah, AR_PHY_RESTART,
+				REG_SET_BIT(ah, AR_PHY_RESTART(ah),
 					    AR_PHY_RESTART_ENABLE_DIV_M2FLAG);
 
 				/* Force WLAN LNA diversity ON */
@@ -3751,7 +3751,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 				regval &= ~(1 << AR_PHY_ANT_DIV_LNADIV_S);
 				regval &= ~(1 << AR_PHY_ANT_SW_RX_PROT_S);
 
-				REG_CLR_BIT(ah, AR_PHY_MC_GAIN_CTRL,
+				REG_CLR_BIT(ah, AR_PHY_MC_GAIN_CTRL(ah),
 					    (1 << AR_PHY_ANT_SW_RX_PROT_S));
 
 				/* Force WLAN LNA diversity OFF */
@@ -3760,10 +3760,10 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 			}
 		}
 
-		REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+		REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 
 		/* enable fast_div */
-		regval = REG_READ(ah, AR_PHY_CCK_DETECT);
+		regval = REG_READ(ah, AR_PHY_CCK_DETECT(ah));
 		regval &= (~AR_FAST_DIV_ENABLE);
 		regval |= ((value >> 7) & 0x1) << AR_FAST_DIV_ENABLE_S;
 
@@ -3771,10 +3771,10 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 		    && common->bt_ant_diversity)
 			regval |= AR_FAST_DIV_ENABLE;
 
-		REG_WRITE(ah, AR_PHY_CCK_DETECT, regval);
+		REG_WRITE(ah, AR_PHY_CCK_DETECT(ah), regval);
 
 		if (pCap->hw_caps & ATH9K_HW_CAP_ANT_DIV_COMB) {
-			regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+			regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 			/*
 			 * clear bits 25-30 main_lnaconf, alt_lnaconf,
 			 * main_tb, alt_tb
@@ -3788,7 +3788,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 				   AR_PHY_ANT_DIV_MAIN_LNACONF_S);
 			regval |= (ATH_ANT_DIV_COMB_LNA2 <<
 				   AR_PHY_ANT_DIV_ALT_LNACONF_S);
-			REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+			REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 		}
 	}
 }
@@ -3894,9 +3894,9 @@ static void ar9003_hw_atten_apply(struct ath_hw *ah, struct ath9k_channel *chan)
 {
 	int i;
 	u16 value;
-	unsigned long ext_atten_reg[3] = {AR_PHY_EXT_ATTEN_CTL_0,
-					  AR_PHY_EXT_ATTEN_CTL_1,
-					  AR_PHY_EXT_ATTEN_CTL_2,
+	unsigned long ext_atten_reg[3] = {AR_PHY_EXT_ATTEN_CTL_0(ah),
+					  AR_PHY_EXT_ATTEN_CTL_1(ah),
+					  AR_PHY_EXT_ATTEN_CTL_2(ah),
 					 };
 
 	if ((AR_SREV_9462(ah)) && (ah->rxchainmask == 0x2)) {
@@ -3925,7 +3925,7 @@ static void ar9003_hw_atten_apply(struct ath_hw *ah, struct ath9k_channel *chan)
 				value = ar9003_hw_atten_chain_get_margin(ah, i, chan);
 
 			if (ah->config.alt_mingainidx)
-				REG_RMW_FIELD(ah, AR_PHY_EXT_ATTEN_CTL_0,
+				REG_RMW_FIELD(ah, AR_PHY_EXT_ATTEN_CTL_0(ah),
 					      AR_PHY_EXT_ATTEN_CTL_XATTEN1_MARGIN,
 					      value);
 
@@ -4081,7 +4081,7 @@ static void ar9003_hw_quick_drop_apply(struct ath_hw *ah, u16 freq)
 			t[2] = eep->base_ext1.quick_drop_high;
 			quick_drop = ar9003_hw_power_interpolate(freq, f, t, 3);
 		}
-		REG_RMW_FIELD(ah, AR_PHY_AGC, AR_PHY_AGC_QUICK_DROP, quick_drop);
+		REG_RMW_FIELD(ah, AR_PHY_AGC(ah), AR_PHY_AGC_QUICK_DROP, quick_drop);
 	}
 }
 
@@ -4091,9 +4091,9 @@ static void ar9003_hw_txend_to_xpa_off_apply(struct ath_hw *ah, bool is2ghz)
 
 	value = ar9003_modal_header(ah, is2ghz)->txEndToXpaOff;
 
-	REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL,
+	REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL(ah),
 		      AR_PHY_XPA_TIMING_CTL_TX_END_XPAB_OFF, value);
-	REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL,
+	REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL(ah),
 		      AR_PHY_XPA_TIMING_CTL_TX_END_XPAA_OFF, value);
 }
 
@@ -4114,10 +4114,10 @@ static void ar9003_hw_xpa_timing_control_apply(struct ath_hw *ah, bool is2ghz)
 
 	xpa_ctl = ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
 	if (is2ghz)
-		REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL,
+		REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL(ah),
 			      AR_PHY_XPA_TIMING_CTL_FRAME_XPAB_ON, xpa_ctl);
 	else
-		REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL,
+		REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL(ah),
 			      AR_PHY_XPA_TIMING_CTL_FRAME_XPAA_ON, xpa_ctl);
 }
 
@@ -4193,9 +4193,9 @@ static void ar9003_hw_thermo_cal_apply(struct ath_hw *ah)
 	ko = data & 0xff;
 	kg = (data >> 8) & 0xff;
 	if (ko || kg) {
-		REG_RMW_FIELD(ah, AR_PHY_BB_THERM_ADC_3,
+		REG_RMW_FIELD(ah, AR_PHY_BB_THERM_ADC_3(ah),
 			      AR_PHY_BB_THERM_ADC_3_THERM_ADC_OFFSET, ko);
-		REG_RMW_FIELD(ah, AR_PHY_BB_THERM_ADC_3,
+		REG_RMW_FIELD(ah, AR_PHY_BB_THERM_ADC_3(ah),
 			      AR_PHY_BB_THERM_ADC_3_THERM_ADC_SCALE_GAIN,
 			      kg + 256);
 	}
@@ -4206,9 +4206,9 @@ static void ar9003_hw_apply_minccapwr_thresh(struct ath_hw *ah,
 {
 	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
 	const u_int32_t cca_ctrl[AR9300_MAX_CHAINS] = {
-		AR_PHY_CCA_CTRL_0,
-		AR_PHY_CCA_CTRL_1,
-		AR_PHY_CCA_CTRL_2,
+		AR_PHY_CCA_CTRL_0(ah),
+		AR_PHY_CCA_CTRL_1(ah),
+		AR_PHY_CCA_CTRL_2(ah),
 	};
 	int chain;
 	u32 val;
@@ -4476,19 +4476,19 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 {
 #define POW_SM(_r, _s)     (((_r) & 0x3f) << (_s))
 	/* make sure forced gain is not set */
-	REG_WRITE(ah, AR_PHY_TX_FORCED_GAIN, 0);
+	REG_WRITE(ah, AR_PHY_TX_FORCED_GAIN(ah), 0);
 
 	/* Write the OFDM power per rate set */
 
 	/* 6 (LSB), 9, 12, 18 (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(0),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 0),
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_6_24], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_6_24], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_6_24], 8) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_6_24], 0));
 
 	/* 24 (LSB), 36, 48, 54 (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(1),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 1),
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_54], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_48], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_36], 8) |
@@ -4497,14 +4497,14 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	/* Write the CCK power per rate set */
 
 	/* 1L (LSB), reserved, 2L, 2S (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(2),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 2),
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_1L_5L], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_1L_5L], 16) |
 		  /* POW_SM(txPowerTimes2,  8) | this is reserved for AR9003 */
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_1L_5L], 0));
 
 	/* 5.5L (LSB), 5.5S, 11L, 11S (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(3),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 3),
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_11S], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_11L], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_5S], 8) |
@@ -4514,7 +4514,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
         /* Write the power for duplicated frames - HT40 */
 
         /* dup40_cck (LSB), dup40_ofdm, ext20_cck, ext20_ofdm (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(8),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 8),
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_6_24], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_1L_5L], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_LEGACY_6_24],  8) |
@@ -4524,7 +4524,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	/* Write the HT20 power per rate set */
 
 	/* 0/8/16 (LSB), 1-3/9-11/17-19, 4, 5 (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(4),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 4),
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_5], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_4], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_1_3_9_11_17_19], 8) |
@@ -4532,7 +4532,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	    );
 
 	/* 6 (LSB), 7, 12, 13 (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(5),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 5),
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_13], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_12], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_7], 8) |
@@ -4540,7 +4540,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	    );
 
 	/* 14 (LSB), 15, 20, 21 */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(9),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 9),
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_21], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_20], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_15], 8) |
@@ -4550,7 +4550,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	/* Mixed HT20 and HT40 rates */
 
 	/* HT20 22 (LSB), HT20 23, HT40 22, HT40 23 (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(10),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 10),
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_23], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_22], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT20_23], 8) |
@@ -4562,7 +4562,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	 * correct PAR difference between HT40 and HT20/LEGACY
 	 * 0/8/16 (LSB), 1-3/9-11/17-19, 4, 5 (MSB)
 	 */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(6),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 6),
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_5], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_4], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_1_3_9_11_17_19], 8) |
@@ -4570,7 +4570,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	    );
 
 	/* 6 (LSB), 7, 12, 13 (MSB) */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(7),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 7),
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_13], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_12], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_7], 8) |
@@ -4578,7 +4578,7 @@ int ar9003_hw_tx_power_regwrite(struct ath_hw *ah, u8 * pPwrArray)
 	    );
 
 	/* 14 (LSB), 15, 20, 21 */
-	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(11),
+	REG_WRITE(ah, AR_PHY_POWER_TX_RATE(ah, 11),
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_21], 24) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_20], 16) |
 		  POW_SM(pPwrArray[ALL_TARGET_HT40_15], 8) |
@@ -4809,28 +4809,28 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
 	int f[8], t[8], t1[3], t2[3], i;
 
-	REG_RMW(ah, AR_PHY_TPC_11_B0,
+	REG_RMW(ah, AR_PHY_TPC_11_B0(ah),
 		(correction[0] << AR_PHY_TPC_OLPC_GAIN_DELTA_S),
 		AR_PHY_TPC_OLPC_GAIN_DELTA);
 	if (ah->caps.tx_chainmask & BIT(1))
-		REG_RMW(ah, AR_PHY_TPC_11_B1,
+		REG_RMW(ah, AR_PHY_TPC_11_B1(ah),
 			(correction[1] << AR_PHY_TPC_OLPC_GAIN_DELTA_S),
 			AR_PHY_TPC_OLPC_GAIN_DELTA);
 	if (ah->caps.tx_chainmask & BIT(2))
-		REG_RMW(ah, AR_PHY_TPC_11_B2,
+		REG_RMW(ah, AR_PHY_TPC_11_B2(ah),
 			(correction[2] << AR_PHY_TPC_OLPC_GAIN_DELTA_S),
 			AR_PHY_TPC_OLPC_GAIN_DELTA);
 
 	/* enable open loop power control on chip */
-	REG_RMW(ah, AR_PHY_TPC_6_B0,
+	REG_RMW(ah, AR_PHY_TPC_6_B0(ah),
 		(3 << AR_PHY_TPC_6_ERROR_EST_MODE_S),
 		AR_PHY_TPC_6_ERROR_EST_MODE);
 	if (ah->caps.tx_chainmask & BIT(1))
-		REG_RMW(ah, AR_PHY_TPC_6_B1,
+		REG_RMW(ah, AR_PHY_TPC_6_B1(ah),
 			(3 << AR_PHY_TPC_6_ERROR_EST_MODE_S),
 			AR_PHY_TPC_6_ERROR_EST_MODE);
 	if (ah->caps.tx_chainmask & BIT(2))
-		REG_RMW(ah, AR_PHY_TPC_6_B2,
+		REG_RMW(ah, AR_PHY_TPC_6_B2(ah),
 			(3 << AR_PHY_TPC_6_ERROR_EST_MODE_S),
 			AR_PHY_TPC_6_ERROR_EST_MODE);
 
@@ -4899,28 +4899,28 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 		if (eep->baseEepHeader.featureEnable & 0x1) {
 			if (frequency < 4000) {
 				if (txmask & BIT(0))
-					REG_RMW_FIELD(ah, AR_PHY_TPC_19,
+					REG_RMW_FIELD(ah, AR_PHY_TPC_19(ah),
 						      AR_PHY_TPC_19_ALPHA_THERM,
 						      eep->base_ext2.tempSlopeLow);
 				if (txmask & BIT(1))
-					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1,
+					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1(ah),
 						      AR_PHY_TPC_19_ALPHA_THERM,
 						      temp_slope);
 				if (txmask & BIT(2))
-					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2,
+					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2(ah),
 						      AR_PHY_TPC_19_ALPHA_THERM,
 						      eep->base_ext2.tempSlopeHigh);
 			} else {
 				if (txmask & BIT(0))
-					REG_RMW_FIELD(ah, AR_PHY_TPC_19,
+					REG_RMW_FIELD(ah, AR_PHY_TPC_19(ah),
 						      AR_PHY_TPC_19_ALPHA_THERM,
 						      temp_slope);
 				if (txmask & BIT(1))
-					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1,
+					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1(ah),
 						      AR_PHY_TPC_19_ALPHA_THERM,
 						      temp_slope1);
 				if (txmask & BIT(2))
-					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2,
+					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2(ah),
 						      AR_PHY_TPC_19_ALPHA_THERM,
 						      temp_slope2);
 			}
@@ -4930,26 +4930,26 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 			 * set all registers to 0.
 			 */
 			if (txmask & BIT(0))
-				REG_RMW_FIELD(ah, AR_PHY_TPC_19,
+				REG_RMW_FIELD(ah, AR_PHY_TPC_19(ah),
 					      AR_PHY_TPC_19_ALPHA_THERM, 0);
 			if (txmask & BIT(1))
-				REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1,
+				REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1(ah),
 					      AR_PHY_TPC_19_ALPHA_THERM, 0);
 			if (txmask & BIT(2))
-				REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2,
+				REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2(ah),
 					      AR_PHY_TPC_19_ALPHA_THERM, 0);
 		}
 	} else {
-		REG_RMW_FIELD(ah, AR_PHY_TPC_19,
+		REG_RMW_FIELD(ah, AR_PHY_TPC_19(ah),
 			      AR_PHY_TPC_19_ALPHA_THERM, temp_slope);
 	}
 
 	if (AR_SREV_9462_20_OR_LATER(ah))
-		REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1,
+		REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1(ah),
 			      AR_PHY_TPC_19_B1_ALPHA_THERM, temp_slope);
 
 
-	REG_RMW_FIELD(ah, AR_PHY_TPC_18, AR_PHY_TPC_18_THERM_CAL_VALUE,
+	REG_RMW_FIELD(ah, AR_PHY_TPC_18(ah), AR_PHY_TPC_18_THERM_CAL_VALUE,
 		      temperature[0]);
 }
 
@@ -5540,19 +5540,19 @@ static void ath9k_hw_ar9300_set_txpower(struct ath_hw *ah,
 		ar9003_hw_init_rate_txpower(ah, targetPowerValT2_tpc, chan);
 
 		/* Enable TPC */
-		REG_WRITE(ah, AR_PHY_PWRTX_MAX,
+		REG_WRITE(ah, AR_PHY_PWRTX_MAX(ah),
 			  AR_PHY_POWER_TX_RATE_MAX_TPC_ENABLE);
 		/* Disable per chain power reduction */
-		val = REG_READ(ah, AR_PHY_POWER_TX_SUB);
+		val = REG_READ(ah, AR_PHY_POWER_TX_SUB(ah));
 		if (AR_SREV_9340(ah))
-			REG_WRITE(ah, AR_PHY_POWER_TX_SUB,
+			REG_WRITE(ah, AR_PHY_POWER_TX_SUB(ah),
 				  val & 0xFFFFFFC0);
 		else
-			REG_WRITE(ah, AR_PHY_POWER_TX_SUB,
+			REG_WRITE(ah, AR_PHY_POWER_TX_SUB(ah),
 				  val & 0xFFFFF000);
 	} else {
 		/* Disable TPC */
-		REG_WRITE(ah, AR_PHY_PWRTX_MAX, 0);
+		REG_WRITE(ah, AR_PHY_PWRTX_MAX(ah), 0);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mci.c b/drivers/net/wireless/ath/ath9k/ar9003_mci.c
index 2b9c07961c..fdde6fb979 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mci.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mci.c
@@ -762,7 +762,7 @@ int ar9003_mci_end_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 
 	mci_hw->bt_state = MCI_BT_AWAKE;
 
-	REG_CLR_BIT(ah, AR_PHY_TIMING4,
+	REG_CLR_BIT(ah, AR_PHY_TIMING4(ah),
 		    1 << AR_PHY_TIMING_CONTROL4_DO_GAIN_DC_IQ_CAL_SHIFT);
 
 	if (caldata) {
@@ -774,7 +774,7 @@ int ar9003_mci_end_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	if (!ath9k_hw_init_cal(ah, chan))
 		return -EIO;
 
-	REG_SET_BIT(ah, AR_PHY_TIMING4,
+	REG_SET_BIT(ah, AR_PHY_TIMING4(ah),
 		    1 << AR_PHY_TIMING_CONTROL4_DO_GAIN_DC_IQ_CAL_SHIFT);
 
 exit:
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
index 83d993fff6..28192df046 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
@@ -57,13 +57,13 @@ void ar9003_paprd_enable(struct ath_hw *ah, bool val)
 		ath9k_hw_apply_txpower(ah, chan, false);
 	}
 
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL0_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL0_B0(ah),
 		      AR_PHY_PAPRD_CTRL0_PAPRD_ENABLE, !!val);
 	if (ah->caps.tx_chainmask & BIT(1))
-		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL0_B1,
+		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL0_B1(ah),
 			      AR_PHY_PAPRD_CTRL0_PAPRD_ENABLE, !!val);
 	if (ah->caps.tx_chainmask & BIT(2))
-		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL0_B2,
+		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL0_B2(ah),
 			      AR_PHY_PAPRD_CTRL0_PAPRD_ENABLE, !!val);
 }
 EXPORT_SYMBOL(ar9003_paprd_enable);
@@ -81,7 +81,7 @@ static int ar9003_get_training_power_2g(struct ath_hw *ah)
 	} else if (AR_SREV_9485(ah)) {
 		power = 25;
 	} else {
-		power = REG_READ_FIELD(ah, AR_PHY_POWERTX_RATE5,
+		power = REG_READ_FIELD(ah, AR_PHY_POWERTX_RATE5(ah),
 				       AR_PHY_POWERTX_RATE5_POWERTXHT20_0);
 
 		delta = abs((int) ah->paprd_target_power - (int) power);
@@ -104,10 +104,10 @@ static int ar9003_get_training_power_5g(struct ath_hw *ah)
 	scale = ar9003_get_paprd_scale_factor(ah, chan);
 
 	if (IS_CHAN_HT40(chan))
-		power = REG_READ_FIELD(ah, AR_PHY_POWERTX_RATE8,
+		power = REG_READ_FIELD(ah, AR_PHY_POWERTX_RATE8(ah),
 			AR_PHY_POWERTX_RATE8_POWERTXHT40_5);
 	else
-		power = REG_READ_FIELD(ah, AR_PHY_POWERTX_RATE6,
+		power = REG_READ_FIELD(ah, AR_PHY_POWERTX_RATE6(ah),
 			AR_PHY_POWERTX_RATE6_POWERTXHT20_5);
 
 	power += scale;
@@ -139,14 +139,14 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
 	static const u32 ctrl0[3] = {
-		AR_PHY_PAPRD_CTRL0_B0,
-		AR_PHY_PAPRD_CTRL0_B1,
-		AR_PHY_PAPRD_CTRL0_B2
+		AR_PHY_PAPRD_CTRL0_B0(ah),
+		AR_PHY_PAPRD_CTRL0_B1(ah),
+		AR_PHY_PAPRD_CTRL0_B2(ah)
 	};
 	static const u32 ctrl1[3] = {
-		AR_PHY_PAPRD_CTRL1_B0,
-		AR_PHY_PAPRD_CTRL1_B1,
-		AR_PHY_PAPRD_CTRL1_B2
+		AR_PHY_PAPRD_CTRL1_B0(ah),
+		AR_PHY_PAPRD_CTRL1_B1(ah),
+		AR_PHY_PAPRD_CTRL1_B2(ah)
 	};
 	int training_power;
 	int i, val;
@@ -170,11 +170,11 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 	if (AR_SREV_9330(ah))
 		am2pm_mask = 0;
 
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_AM2AM, AR_PHY_PAPRD_AM2AM_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_AM2AM(ah), AR_PHY_PAPRD_AM2AM_MASK,
 		      ah->paprd_ratemask);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_AM2PM, AR_PHY_PAPRD_AM2PM_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_AM2PM(ah), AR_PHY_PAPRD_AM2PM_MASK,
 		      am2pm_mask);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_HT40, AR_PHY_PAPRD_HT40_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_HT40(ah), AR_PHY_PAPRD_HT40_MASK,
 		      ah->paprd_ratemask_ht40);
 
 	ath_dbg(common, CALIBRATE, "PAPRD HT20 mask: 0x%x, HT40 mask: 0x%x\n",
@@ -269,21 +269,21 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_NUM_TRAIN_SAMPLES,
 		      100);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_0_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_0_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 261376);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_1_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_1_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 248079);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_2_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_2_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 233759);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_3_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_3_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 220464);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_4_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_4_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 208194);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_5_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_5_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 196949);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_6_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_6_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 185706);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_7_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_7_B0(ah),
 		      AR_PHY_PAPRD_PRE_POST_SCALING, 175487);
 	return 0;
 }
@@ -292,7 +292,7 @@ static void ar9003_paprd_get_gain_table(struct ath_hw *ah)
 {
 	u32 *entry = ah->paprd_gain_table_entries;
 	u8 *index = ah->paprd_gain_table_index;
-	u32 reg = AR_PHY_TXGAIN_TABLE;
+	u32 reg = AR_PHY_TXGAIN_TABLE(ah);
 	int i;
 
 	for (i = 0; i < PAPRD_GAIN_TABLE_ENTRIES; i++) {
@@ -315,33 +315,33 @@ static unsigned int ar9003_get_desired_gain(struct ath_hw *ah, int chain,
 
 	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1(ah),
 		    AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE);
-	desired_scale = REG_READ_FIELD(ah, AR_PHY_TPC_12,
+	desired_scale = REG_READ_FIELD(ah, AR_PHY_TPC_12(ah),
 				       AR_PHY_TPC_12_DESIRED_SCALE_HT40_5);
-	alpha_therm = REG_READ_FIELD(ah, AR_PHY_TPC_19,
+	alpha_therm = REG_READ_FIELD(ah, AR_PHY_TPC_19(ah),
 				     AR_PHY_TPC_19_ALPHA_THERM);
-	alpha_volt = REG_READ_FIELD(ah, AR_PHY_TPC_19,
+	alpha_volt = REG_READ_FIELD(ah, AR_PHY_TPC_19(ah),
 				    AR_PHY_TPC_19_ALPHA_VOLT);
-	therm_cal_value = REG_READ_FIELD(ah, AR_PHY_TPC_18,
+	therm_cal_value = REG_READ_FIELD(ah, AR_PHY_TPC_18(ah),
 					 AR_PHY_TPC_18_THERM_CAL_VALUE);
-	volt_cal_value = REG_READ_FIELD(ah, AR_PHY_TPC_18,
+	volt_cal_value = REG_READ_FIELD(ah, AR_PHY_TPC_18(ah),
 					AR_PHY_TPC_18_VOLT_CAL_VALUE);
-	therm_value = REG_READ_FIELD(ah, AR_PHY_BB_THERM_ADC_4,
+	therm_value = REG_READ_FIELD(ah, AR_PHY_BB_THERM_ADC_4(ah),
 				     AR_PHY_BB_THERM_ADC_4_LATEST_THERM_VALUE);
-	volt_value = REG_READ_FIELD(ah, AR_PHY_BB_THERM_ADC_4,
+	volt_value = REG_READ_FIELD(ah, AR_PHY_BB_THERM_ADC_4(ah),
 				    AR_PHY_BB_THERM_ADC_4_LATEST_VOLT_VALUE);
 
 	switch (chain) {
 	case 0:
-		reg_olpc = AR_PHY_TPC_11_B0;
-		reg_cl_gain = AR_PHY_CL_TAB_0;
+		reg_olpc = AR_PHY_TPC_11_B0(ah);
+		reg_cl_gain = AR_PHY_CL_TAB_0(ah);
 		break;
 	case 1:
-		reg_olpc = AR_PHY_TPC_11_B1;
-		reg_cl_gain = AR_PHY_CL_TAB_1;
+		reg_olpc = AR_PHY_TPC_11_B1(ah);
+		reg_cl_gain = AR_PHY_CL_TAB_1(ah);
 		break;
 	case 2:
-		reg_olpc = AR_PHY_TPC_11_B2;
-		reg_cl_gain = AR_PHY_CL_TAB_2;
+		reg_olpc = AR_PHY_TPC_11_B2(ah);
+		reg_cl_gain = AR_PHY_CL_TAB_2(ah);
 		break;
 	default:
 		ath_dbg(ath9k_hw_common(ah), CALIBRATE,
@@ -382,26 +382,26 @@ static void ar9003_tx_force_gain(struct ath_hw *ah, unsigned int gain_index)
 	padrvgnC = (selected_gain_entry >> 17) & 0xf;
 	padrvgnD = (selected_gain_entry >> 21) & 0x3;
 
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_TXBB1DBGAIN, txbb1dbgain);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_TXBB6DBGAIN, txbb6dbgain);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_TXMXRGAIN, txmxrgain);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_PADRVGNA, padrvgnA);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_PADRVGNB, padrvgnB);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_PADRVGNC, padrvgnC);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_PADRVGND, padrvgnD);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCED_ENABLE_PAL, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
+	REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN(ah),
 		      AR_PHY_TX_FORCED_GAIN_FORCE_TX_GAIN, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TPC_1, AR_PHY_TPC_1_FORCED_DAC_GAIN, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TPC_1, AR_PHY_TPC_1_FORCE_DAC_GAIN, 0);
+	REG_RMW_FIELD(ah, AR_PHY_TPC_1(ah), AR_PHY_TPC_1_FORCED_DAC_GAIN, 0);
+	REG_RMW_FIELD(ah, AR_PHY_TPC_1(ah), AR_PHY_TPC_1_FORCE_DAC_GAIN, 0);
 }
 
 static inline int find_expn(int num)
@@ -759,11 +759,11 @@ void ar9003_paprd_populate_single_table(struct ath_hw *ah,
 	int i;
 
 	if (chain == 0)
-		reg = AR_PHY_PAPRD_MEM_TAB_B0;
+		reg = AR_PHY_PAPRD_MEM_TAB_B0(ah);
 	else if (chain == 1)
-		reg = AR_PHY_PAPRD_MEM_TAB_B1;
+		reg = AR_PHY_PAPRD_MEM_TAB_B1(ah);
 	else if (chain == 2)
-		reg = AR_PHY_PAPRD_MEM_TAB_B2;
+		reg = AR_PHY_PAPRD_MEM_TAB_B2(ah);
 
 	for (i = 0; i < PAPRD_TABLE_SZ; i++) {
 		REG_WRITE(ah, reg, paprd_table_val[i]);
@@ -771,26 +771,26 @@ void ar9003_paprd_populate_single_table(struct ath_hw *ah,
 	}
 
 	if (chain == 0)
-		reg = AR_PHY_PA_GAIN123_B0;
+		reg = AR_PHY_PA_GAIN123_B0(ah);
 	else if (chain == 1)
-		reg = AR_PHY_PA_GAIN123_B1;
+		reg = AR_PHY_PA_GAIN123_B1(ah);
 	else
-		reg = AR_PHY_PA_GAIN123_B2;
+		reg = AR_PHY_PA_GAIN123_B2(ah);
 
 	REG_RMW_FIELD(ah, reg, AR_PHY_PA_GAIN123_PA_GAIN1, small_signal_gain);
 
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL1_B0,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL1_B0(ah),
 		      AR_PHY_PAPRD_CTRL1_PAPRD_POWER_AT_AM2AM_CAL,
 		      training_power);
 
 	if (ah->caps.tx_chainmask & BIT(1))
-		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL1_B1,
+		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL1_B1(ah),
 			      AR_PHY_PAPRD_CTRL1_PAPRD_POWER_AT_AM2AM_CAL,
 			      training_power);
 
 	if (ah->caps.tx_chainmask & BIT(2))
 		/* val AR_PHY_PAPRD_CTRL1_PAPRD_POWER_AT_AM2AM_CAL correct? */
-		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL1_B2,
+		REG_RMW_FIELD(ah, AR_PHY_PAPRD_CTRL1_B2(ah),
 			      AR_PHY_PAPRD_CTRL1_PAPRD_POWER_AT_AM2AM_CAL,
 			      training_power);
 }
@@ -935,7 +935,7 @@ int ar9003_paprd_create_curve(struct ath_hw *ah,
 	REG_CLR_BIT(ah, AR_PHY_CHAN_INFO_MEMORY(ah),
 		    AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ);
 
-	reg = AR_PHY_CHAN_INFO_TAB_0;
+	reg = AR_PHY_CHAN_INFO_TAB_0(ah);
 	for (i = 0; i < 48; i++)
 		data_L[i] = REG_READ(ah, reg + (i << 2));
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index a29c11f944..7944d12f2e 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -203,7 +203,7 @@ static int ar9003_hw_set_channel(struct ath_hw *ah, struct ath9k_channel *chan)
 	loadSynthChannel = 0;
 
 	reg32 = (bMode << 29);
-	REG_WRITE(ah, AR_PHY_SYNTH_CONTROL, reg32);
+	REG_WRITE(ah, AR_PHY_SYNTH_CONTROL(ah), reg32);
 
 	/* Enable Long shift Select for Synthesizer */
 	REG_RMW_FIELD(ah, AR_PHY_65NM_CH0_SYNTH4,
@@ -256,7 +256,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 		max_spur_cnts = 5;
 		if (IS_CHAN_HT40(chan)) {
 			range = 19;
-			if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL,
+			if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL(ah),
 					   AR_PHY_GC_DYN2040_PRI_CH) == 0)
 				synth_freq = chan->channel + 10;
 			else
@@ -298,15 +298,15 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 
 			REG_RMW_FIELD(ah, AR_PHY_AGC_CONTROL(ah),
 				      AR_PHY_AGC_CONTROL_YCOK_MAX, 0x7);
-			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
+			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT(ah),
 				      AR_PHY_CCK_SPUR_MIT_SPUR_RSSI_THR, 0x7f);
-			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
+			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT(ah),
 				      AR_PHY_CCK_SPUR_MIT_SPUR_FILTER_TYPE,
 				      0x2);
-			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
+			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT(ah),
 				      AR_PHY_CCK_SPUR_MIT_USE_CCK_SPUR_MIT,
 				      0x1);
-			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
+			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT(ah),
 				      AR_PHY_CCK_SPUR_MIT_CCK_SPUR_FREQ,
 				      cck_spur_freq);
 
@@ -316,53 +316,53 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 
 	REG_RMW_FIELD(ah, AR_PHY_AGC_CONTROL(ah),
 		      AR_PHY_AGC_CONTROL_YCOK_MAX, 0x5);
-	REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
+	REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT(ah),
 		      AR_PHY_CCK_SPUR_MIT_USE_CCK_SPUR_MIT, 0x0);
-	REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
+	REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT(ah),
 		      AR_PHY_CCK_SPUR_MIT_CCK_SPUR_FREQ, 0x0);
 }
 
 /* Clean all spur register fields */
 static void ar9003_hw_spur_ofdm_clear(struct ath_hw *ah)
 {
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_SPUR_FILTER, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_SPUR_FREQ_SD, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_SPUR_DELTA_PHASE, 0);
-	REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT,
+	REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT(ah),
 		      AR_PHY_SFCORR_EXT_SPUR_SUBCHANNEL_SD, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_USE_SPUR_FILTER_IN_AGC, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_USE_SPUR_FILTER_IN_SELFCOR, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_SPUR_RSSI, 0);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_EN_VIT_SPUR_RSSI, 0);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_ENABLE_NF_RSSI_SPUR_MIT, 0);
 
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_ENABLE_MASK_PPM, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_PILOT_MASK, 0);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_CHAN_MASK, 0);
-	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK(ah),
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_A, 0);
 	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_IDX_A, 0);
-	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK(ah),
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_IDX_A, 0);
-	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK(ah),
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_A, 0);
-	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK(ah),
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_A, 0);
 	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A, 0);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_MASK_RATE_CNTL, 0);
 }
 
@@ -377,32 +377,32 @@ static void ar9003_hw_spur_ofdm(struct ath_hw *ah,
 	int mask_index = 0;
 
 	/* OFDM Spur mitigation */
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		 AR_PHY_TIMING4_ENABLE_SPUR_FILTER, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_SPUR_FREQ_SD, spur_freq_sd);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_SPUR_DELTA_PHASE, spur_delta_phase);
-	REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT,
+	REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT(ah),
 		      AR_PHY_SFCORR_EXT_SPUR_SUBCHANNEL_SD, spur_subchannel_sd);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 		      AR_PHY_TIMING11_USE_SPUR_FILTER_IN_AGC, 0x1);
 
 	if (!(AR_SREV_9565(ah) && range == 10 && synth_freq == 2437))
-		REG_RMW_FIELD(ah, AR_PHY_TIMING11,
+		REG_RMW_FIELD(ah, AR_PHY_TIMING11(ah),
 			      AR_PHY_TIMING11_USE_SPUR_FILTER_IN_SELFCOR, 0x1);
 
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_SPUR_RSSI, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_SPUR_RSSI_THRESH, 34);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_EN_VIT_SPUR_RSSI, 1);
 
 	if (!AR_SREV_9340(ah) &&
-	    REG_READ_FIELD(ah, AR_PHY_MODE,
+	    REG_READ_FIELD(ah, AR_PHY_MODE(ah),
 			   AR_PHY_MODE_DYNAMIC) == 0x1)
-		REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+		REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 			      AR_PHY_SPUR_REG_ENABLE_NF_RSSI_SPUR_MIT, 1);
 
 	mask_index = (freq_offset << 4) / 5;
@@ -411,25 +411,25 @@ static void ar9003_hw_spur_ofdm(struct ath_hw *ah,
 
 	mask_index = mask_index & 0x7f;
 
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_ENABLE_MASK_PPM, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_PILOT_MASK, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING4,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING4(ah),
 		      AR_PHY_TIMING4_ENABLE_CHAN_MASK, 0x1);
-	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK(ah),
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_A, mask_index);
 	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_IDX_A, mask_index);
-	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK(ah),
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_IDX_A, mask_index);
-	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK(ah),
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_A, 0xc);
-	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK(ah),
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_A, 0xc);
 	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A, 0xa0);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG(ah),
 		      AR_PHY_SPUR_REG_MASK_RATE_CNTL, 0xff);
 }
 
@@ -444,7 +444,7 @@ static void ar9003_hw_spur_ofdm_9565(struct ath_hw *ah,
 
 	mask_index = mask_index & 0x7f;
 
-	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK(ah),
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_B,
 		      mask_index);
 
@@ -453,12 +453,12 @@ static void ar9003_hw_spur_ofdm_9565(struct ath_hw *ah,
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_IDX_A,
 		      mask_index);
 
-	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK(ah),
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_IDX_B,
 		      mask_index);
-	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK(ah),
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_B, 0xe);
-	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
+	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK(ah),
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_B, 0xe);
 
 	/* A == B */
@@ -478,7 +478,7 @@ static void ar9003_hw_spur_ofdm_work(struct ath_hw *ah,
 
 	if (IS_CHAN_HT40(chan)) {
 		if (freq_offset < 0) {
-			if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL,
+			if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL(ah),
 					   AR_PHY_GC_DYN2040_PRI_CH) == 0x0)
 				spur_subchannel_sd = 1;
 			else
@@ -487,7 +487,7 @@ static void ar9003_hw_spur_ofdm_work(struct ath_hw *ah,
 			spur_freq_sd = ((freq_offset + 10) << 9) / 11;
 
 		} else {
-			if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL,
+			if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL(ah),
 			    AR_PHY_GC_DYN2040_PRI_CH) == 0x0)
 				spur_subchannel_sd = 0;
 			else
@@ -531,7 +531,7 @@ static void ar9003_hw_spur_mitigate_ofdm(struct ath_hw *ah,
 
 	if (IS_CHAN_HT40(chan)) {
 		range = 19;
-		if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL,
+		if (REG_READ_FIELD(ah, AR_PHY_GEN_CTRL(ah),
 				   AR_PHY_GC_DYN2040_PRI_CH) == 0x0)
 			synth_freq = chan->channel - 10;
 		else
@@ -614,7 +614,7 @@ static void ar9003_hw_set_channel_regs(struct ath_hw *ah,
 	u32 enableDacFifo = 0;
 
 	enableDacFifo =
-		(REG_READ(ah, AR_PHY_GEN_CTRL) & AR_PHY_GC_ENABLE_DAC_FIFO);
+		(REG_READ(ah, AR_PHY_GEN_CTRL(ah)) & AR_PHY_GC_ENABLE_DAC_FIFO);
 
 	/* Enable 11n HT, 20 MHz */
 	phymode = AR_PHY_GC_HT_EN | AR_PHY_GC_SHORT_GI_40 | enableDacFifo;
@@ -632,11 +632,11 @@ static void ar9003_hw_set_channel_regs(struct ath_hw *ah,
 	}
 
 	/* make sure we preserve INI settings */
-	phymode |= REG_READ(ah, AR_PHY_GEN_CTRL);
+	phymode |= REG_READ(ah, AR_PHY_GEN_CTRL(ah));
 	/* turn off Green Field detection for STA for now */
 	phymode &= ~AR_PHY_GC_GF_DETECT_EN;
 
-	REG_WRITE(ah, AR_PHY_GEN_CTRL, phymode);
+	REG_WRITE(ah, AR_PHY_GEN_CTRL(ah), phymode);
 
 	/* Configure MAC for 20/40 operation */
 	ath9k_hw_set11nmac2040(ah, chan);
@@ -657,21 +657,21 @@ static void ar9003_hw_init_bb(struct ath_hw *ah,
 	 * via AR_PHY_ACTIVE_EN).  Read the phy active delay register.
 	 * Value is in 100ns increments.
 	 */
-	synthDelay = REG_READ(ah, AR_PHY_RX_DELAY) & AR_PHY_RX_DELAY_DELAY;
+	synthDelay = REG_READ(ah, AR_PHY_RX_DELAY(ah)) & AR_PHY_RX_DELAY_DELAY;
 
 	/* Activate the PHY (includes baseband activate + synthesizer on) */
-	REG_WRITE(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
+	REG_WRITE(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_EN);
 	ath9k_hw_synth_delay(ah, chan, synthDelay);
 }
 
 void ar9003_hw_set_chain_masks(struct ath_hw *ah, u8 rx, u8 tx)
 {
 	if (ah->caps.tx_chainmask == 5 || ah->caps.rx_chainmask == 5)
-		REG_SET_BIT(ah, AR_PHY_ANALOG_SWAP,
+		REG_SET_BIT(ah, AR_PHY_ANALOG_SWAP(ah),
 			    AR_PHY_SWAP_ALT_CHAIN);
 
-	REG_WRITE(ah, AR_PHY_RX_CHAINMASK, rx);
-	REG_WRITE(ah, AR_PHY_CAL_CHAINMASK, rx);
+	REG_WRITE(ah, AR_PHY_RX_CHAINMASK(ah), rx);
+	REG_WRITE(ah, AR_PHY_CAL_CHAINMASK(ah), rx);
 
 	if ((ah->caps.hw_caps & ATH9K_HW_CAP_APM) && (tx == 0x7))
 		tx = 3;
@@ -718,7 +718,7 @@ static void ar9003_hw_override_ini(struct ath_hw *ah)
 
 	}
 
-	if (REG_READ(ah, AR_PHY_CL_CAL_CTL) & AR_PHY_CL_CAL_ENABLE)
+	if (REG_READ(ah, AR_PHY_CL_CAL_CTL(ah)) & AR_PHY_CL_CAL_ENABLE)
 		ah->enabled_cals |= TX_CL_CAL;
 	else
 		ah->enabled_cals &= ~TX_CL_CAL;
@@ -954,7 +954,7 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
 		ar9003_hw_prog_ini(ah, &ah->iniCckfirJapan2484, 1);
 
 		if (AR_SREV_9531(ah))
-			REG_RMW_FIELD(ah, AR_PHY_FCAL_2_0,
+			REG_RMW_FIELD(ah, AR_PHY_FCAL_2_0(ah),
 				      AR_PHY_FLC_PWR_THRESH, 0);
 	}
 
@@ -984,15 +984,15 @@ static void ar9003_hw_set_rfmode(struct ath_hw *ah,
 		rfMode |= (AR_PHY_MODE_DYNAMIC | AR_PHY_MODE_DYN_CCK_DISABLE);
 
 	if (IS_CHAN_HALF_RATE(chan) || IS_CHAN_QUARTER_RATE(chan))
-		REG_RMW_FIELD(ah, AR_PHY_FRAME_CTL,
+		REG_RMW_FIELD(ah, AR_PHY_FRAME_CTL(ah),
 			      AR_PHY_FRAME_CTL_CF_OVERLAP_WINDOW, 3);
 
-	REG_WRITE(ah, AR_PHY_MODE, rfMode);
+	REG_WRITE(ah, AR_PHY_MODE(ah), rfMode);
 }
 
 static void ar9003_hw_mark_phy_inactive(struct ath_hw *ah)
 {
-	REG_WRITE(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_DIS);
+	REG_WRITE(ah, AR_PHY_ACTIVE(ah), AR_PHY_ACTIVE_DIS);
 }
 
 static void ar9003_hw_set_delta_slope(struct ath_hw *ah,
@@ -1021,9 +1021,9 @@ static void ar9003_hw_set_delta_slope(struct ath_hw *ah,
 	ath9k_hw_get_delta_slope_vals(ah, coef_scaled, &ds_coef_man,
 				      &ds_coef_exp);
 
-	REG_RMW_FIELD(ah, AR_PHY_TIMING3,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING3(ah),
 		      AR_PHY_TIMING3_DSC_MAN, ds_coef_man);
-	REG_RMW_FIELD(ah, AR_PHY_TIMING3,
+	REG_RMW_FIELD(ah, AR_PHY_TIMING3(ah),
 		      AR_PHY_TIMING3_DSC_EXP, ds_coef_exp);
 
 	/*
@@ -1036,16 +1036,16 @@ static void ar9003_hw_set_delta_slope(struct ath_hw *ah,
 				      &ds_coef_exp);
 
 	/* for short gi */
-	REG_RMW_FIELD(ah, AR_PHY_SGI_DELTA,
+	REG_RMW_FIELD(ah, AR_PHY_SGI_DELTA(ah),
 		      AR_PHY_SGI_DSC_MAN, ds_coef_man);
-	REG_RMW_FIELD(ah, AR_PHY_SGI_DELTA,
+	REG_RMW_FIELD(ah, AR_PHY_SGI_DELTA(ah),
 		      AR_PHY_SGI_DSC_EXP, ds_coef_exp);
 }
 
 static bool ar9003_hw_rfbus_req(struct ath_hw *ah)
 {
-	REG_WRITE(ah, AR_PHY_RFBUS_REQ, AR_PHY_RFBUS_REQ_EN);
-	return ath9k_hw_wait(ah, AR_PHY_RFBUS_GRANT, AR_PHY_RFBUS_GRANT_EN,
+	REG_WRITE(ah, AR_PHY_RFBUS_REQ(ah), AR_PHY_RFBUS_REQ_EN);
+	return ath9k_hw_wait(ah, AR_PHY_RFBUS_GRANT(ah), AR_PHY_RFBUS_GRANT_EN,
 			     AR_PHY_RFBUS_GRANT_EN, AH_WAIT_TIMEOUT);
 }
 
@@ -1055,11 +1055,11 @@ static bool ar9003_hw_rfbus_req(struct ath_hw *ah)
  */
 static void ar9003_hw_rfbus_done(struct ath_hw *ah)
 {
-	u32 synthDelay = REG_READ(ah, AR_PHY_RX_DELAY) & AR_PHY_RX_DELAY_DELAY;
+	u32 synthDelay = REG_READ(ah, AR_PHY_RX_DELAY(ah)) & AR_PHY_RX_DELAY_DELAY;
 
 	ath9k_hw_synth_delay(ah, ah->curchan, synthDelay);
 
-	REG_WRITE(ah, AR_PHY_RFBUS_REQ, 0);
+	REG_WRITE(ah, AR_PHY_RFBUS_REQ(ah), 0);
 }
 
 static bool ar9003_hw_ani_control(struct ath_hw *ah,
@@ -1110,42 +1110,42 @@ static bool ar9003_hw_ani_control(struct ath_hw *ah,
 		m2ThreshExt = on ?
 			aniState->iniDef.m2ThreshExt : m2ThreshExt_off;
 
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_LOW,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_LOW(ah),
 			      AR_PHY_SFCORR_LOW_M1_THRESH_LOW,
 			      m1ThreshLow);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_LOW,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_LOW(ah),
 			      AR_PHY_SFCORR_LOW_M2_THRESH_LOW,
 			      m2ThreshLow);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR(ah),
 			      AR_PHY_SFCORR_M1_THRESH,
 			      m1Thresh);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR(ah),
 			      AR_PHY_SFCORR_M2_THRESH,
 			      m2Thresh);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR(ah),
 			      AR_PHY_SFCORR_M2COUNT_THR,
 			      m2CountThr);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_LOW,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_LOW(ah),
 			      AR_PHY_SFCORR_LOW_M2COUNT_THR_LOW,
 			      m2CountThrLow);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT(ah),
 			      AR_PHY_SFCORR_EXT_M1_THRESH_LOW,
 			      m1ThreshLowExt);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT(ah),
 			      AR_PHY_SFCORR_EXT_M2_THRESH_LOW,
 			      m2ThreshLowExt);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT(ah),
 			      AR_PHY_SFCORR_EXT_M1_THRESH,
 			      m1ThreshExt);
-		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT,
+		REG_RMW_FIELD(ah, AR_PHY_SFCORR_EXT(ah),
 			      AR_PHY_SFCORR_EXT_M2_THRESH,
 			      m2ThreshExt);
 skip_ws_det:
 		if (on)
-			REG_SET_BIT(ah, AR_PHY_SFCORR_LOW,
+			REG_SET_BIT(ah, AR_PHY_SFCORR_LOW(ah),
 				    AR_PHY_SFCORR_LOW_USE_SELF_CORR_LOW);
 		else
-			REG_CLR_BIT(ah, AR_PHY_SFCORR_LOW,
+			REG_CLR_BIT(ah, AR_PHY_SFCORR_LOW(ah),
 				    AR_PHY_SFCORR_LOW_USE_SELF_CORR_LOW);
 
 		if (on != aniState->ofdmWeakSigDetect) {
@@ -1184,7 +1184,7 @@ static bool ar9003_hw_ani_control(struct ath_hw *ah,
 			value = ATH9K_SIG_FIRSTEP_SETTING_MIN;
 		if (value > ATH9K_SIG_FIRSTEP_SETTING_MAX)
 			value = ATH9K_SIG_FIRSTEP_SETTING_MAX;
-		REG_RMW_FIELD(ah, AR_PHY_FIND_SIG,
+		REG_RMW_FIELD(ah, AR_PHY_FIND_SIG(ah),
 			      AR_PHY_FIND_SIG_FIRSTEP,
 			      value);
 		/*
@@ -1200,7 +1200,7 @@ static bool ar9003_hw_ani_control(struct ath_hw *ah,
 		if (value2 > ATH9K_SIG_FIRSTEP_SETTING_MAX)
 			value2 = ATH9K_SIG_FIRSTEP_SETTING_MAX;
 
-		REG_RMW_FIELD(ah, AR_PHY_FIND_SIG_LOW,
+		REG_RMW_FIELD(ah, AR_PHY_FIND_SIG_LOW(ah),
 			      AR_PHY_FIND_SIG_LOW_FIRSTEP_LOW, value2);
 
 		if (level != aniState->firstepLevel) {
@@ -1248,12 +1248,12 @@ static bool ar9003_hw_ani_control(struct ath_hw *ah,
 			value = ATH9K_SIG_SPUR_IMM_SETTING_MIN;
 		if (value > ATH9K_SIG_SPUR_IMM_SETTING_MAX)
 			value = ATH9K_SIG_SPUR_IMM_SETTING_MAX;
-		REG_RMW_FIELD(ah, AR_PHY_TIMING5,
+		REG_RMW_FIELD(ah, AR_PHY_TIMING5(ah),
 			      AR_PHY_TIMING5_CYCPWR_THR1,
 			      value);
 
 		/*
-		 * set AR_PHY_EXT_CCA for extension channel
+		 * set AR_PHY_EXT_CCA(ah) for extension channel
 		 * make register setting relative to default
 		 * from INI file & cap value
 		 */
@@ -1264,7 +1264,7 @@ static bool ar9003_hw_ani_control(struct ath_hw *ah,
 			value2 = ATH9K_SIG_SPUR_IMM_SETTING_MIN;
 		if (value2 > ATH9K_SIG_SPUR_IMM_SETTING_MAX)
 			value2 = ATH9K_SIG_SPUR_IMM_SETTING_MAX;
-		REG_RMW_FIELD(ah, AR_PHY_EXT_CCA,
+		REG_RMW_FIELD(ah, AR_PHY_EXT_CCA(ah),
 			      AR_PHY_EXT_CYCPWR_THR1, value2);
 
 		if (level != aniState->spurImmunityLevel) {
@@ -1302,9 +1302,9 @@ static bool ar9003_hw_ani_control(struct ath_hw *ah,
 		if (ah->caps.rx_chainmask == 1)
 			break;
 
-		REG_RMW_FIELD(ah, AR_PHY_MRC_CCK_CTRL,
+		REG_RMW_FIELD(ah, AR_PHY_MRC_CCK_CTRL(ah),
 			      AR_PHY_MRC_CCK_ENABLE, is_on);
-		REG_RMW_FIELD(ah, AR_PHY_MRC_CCK_CTRL,
+		REG_RMW_FIELD(ah, AR_PHY_MRC_CCK_CTRL(ah),
 			      AR_PHY_MRC_CCK_MUX_REG, is_on);
 		if (is_on != aniState->mrcCCK) {
 			ath_dbg(common, ANI, "** ch %d: MRC CCK: %s=>%s\n",
@@ -1406,32 +1406,32 @@ static void ar9003_hw_ani_cache_ini_regs(struct ath_hw *ah)
 		ah->opmode,
 		chan->channel);
 
-	val = REG_READ(ah, AR_PHY_SFCORR);
+	val = REG_READ(ah, AR_PHY_SFCORR(ah));
 	iniDef->m1Thresh = MS(val, AR_PHY_SFCORR_M1_THRESH);
 	iniDef->m2Thresh = MS(val, AR_PHY_SFCORR_M2_THRESH);
 	iniDef->m2CountThr = MS(val, AR_PHY_SFCORR_M2COUNT_THR);
 
-	val = REG_READ(ah, AR_PHY_SFCORR_LOW);
+	val = REG_READ(ah, AR_PHY_SFCORR_LOW(ah));
 	iniDef->m1ThreshLow = MS(val, AR_PHY_SFCORR_LOW_M1_THRESH_LOW);
 	iniDef->m2ThreshLow = MS(val, AR_PHY_SFCORR_LOW_M2_THRESH_LOW);
 	iniDef->m2CountThrLow = MS(val, AR_PHY_SFCORR_LOW_M2COUNT_THR_LOW);
 
-	val = REG_READ(ah, AR_PHY_SFCORR_EXT);
+	val = REG_READ(ah, AR_PHY_SFCORR_EXT(ah));
 	iniDef->m1ThreshExt = MS(val, AR_PHY_SFCORR_EXT_M1_THRESH);
 	iniDef->m2ThreshExt = MS(val, AR_PHY_SFCORR_EXT_M2_THRESH);
 	iniDef->m1ThreshLowExt = MS(val, AR_PHY_SFCORR_EXT_M1_THRESH_LOW);
 	iniDef->m2ThreshLowExt = MS(val, AR_PHY_SFCORR_EXT_M2_THRESH_LOW);
 	iniDef->firstep = REG_READ_FIELD(ah,
-					 AR_PHY_FIND_SIG,
+					 AR_PHY_FIND_SIG(ah),
 					 AR_PHY_FIND_SIG_FIRSTEP);
 	iniDef->firstepLow = REG_READ_FIELD(ah,
-					    AR_PHY_FIND_SIG_LOW,
+					    AR_PHY_FIND_SIG_LOW(ah),
 					    AR_PHY_FIND_SIG_LOW_FIRSTEP_LOW);
 	iniDef->cycpwrThr1 = REG_READ_FIELD(ah,
-					    AR_PHY_TIMING5,
+					    AR_PHY_TIMING5(ah),
 					    AR_PHY_TIMING5_CYCPWR_THR1);
 	iniDef->cycpwrThr1Ext = REG_READ_FIELD(ah,
-					       AR_PHY_EXT_CCA,
+					       AR_PHY_EXT_CCA(ah),
 					       AR_PHY_EXT_CYCPWR_THR1);
 
 	/* these levels just got reset to defaults by the INI */
@@ -1448,7 +1448,7 @@ static void ar9003_hw_set_radar_params(struct ath_hw *ah,
 	u32 radar_0 = 0, radar_1;
 
 	if (!conf) {
-		REG_CLR_BIT(ah, AR_PHY_RADAR_0, AR_PHY_RADAR_0_ENA);
+		REG_CLR_BIT(ah, AR_PHY_RADAR_0(ah), AR_PHY_RADAR_0_ENA);
 		return;
 	}
 
@@ -1459,7 +1459,7 @@ static void ar9003_hw_set_radar_params(struct ath_hw *ah,
 	radar_0 |= SM(conf->pulse_rssi, AR_PHY_RADAR_0_PRSSI);
 	radar_0 |= SM(conf->pulse_inband, AR_PHY_RADAR_0_INBAND);
 
-	radar_1 = REG_READ(ah, AR_PHY_RADAR_1);
+	radar_1 = REG_READ(ah, AR_PHY_RADAR_1(ah));
 	radar_1 &= ~(AR_PHY_RADAR_1_MAXLEN | AR_PHY_RADAR_1_RELSTEP_THRESH |
 		     AR_PHY_RADAR_1_RELPWR_THRESH);
 	radar_1 |= AR_PHY_RADAR_1_MAX_RRSSI;
@@ -1468,12 +1468,12 @@ static void ar9003_hw_set_radar_params(struct ath_hw *ah,
 	radar_1 |= SM(conf->pulse_inband_step, AR_PHY_RADAR_1_RELSTEP_THRESH);
 	radar_1 |= SM(conf->radar_inband, AR_PHY_RADAR_1_RELPWR_THRESH);
 
-	REG_WRITE(ah, AR_PHY_RADAR_0, radar_0);
-	REG_WRITE(ah, AR_PHY_RADAR_1, radar_1);
+	REG_WRITE(ah, AR_PHY_RADAR_0(ah), radar_0);
+	REG_WRITE(ah, AR_PHY_RADAR_1(ah), radar_1);
 	if (conf->ext_channel)
-		REG_SET_BIT(ah, AR_PHY_RADAR_EXT, AR_PHY_RADAR_EXT_ENA);
+		REG_SET_BIT(ah, AR_PHY_RADAR_EXT(ah), AR_PHY_RADAR_EXT_ENA);
 	else
-		REG_CLR_BIT(ah, AR_PHY_RADAR_EXT, AR_PHY_RADAR_EXT_ENA);
+		REG_CLR_BIT(ah, AR_PHY_RADAR_EXT(ah), AR_PHY_RADAR_EXT_ENA);
 
 	if (AR_SREV_9300(ah) || AR_SREV_9340(ah) || AR_SREV_9580(ah)) {
 		REG_WRITE_ARRAY(&ah->ini_dfs,
@@ -1500,7 +1500,7 @@ static void ar9003_hw_antdiv_comb_conf_get(struct ath_hw *ah,
 {
 	u32 regval;
 
-	regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+	regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 	antconf->main_lna_conf = (regval & AR_PHY_ANT_DIV_MAIN_LNACONF) >>
 				  AR_PHY_ANT_DIV_MAIN_LNACONF_S;
 	antconf->alt_lna_conf = (regval & AR_PHY_ANT_DIV_ALT_LNACONF) >>
@@ -1532,7 +1532,7 @@ static void ar9003_hw_antdiv_comb_conf_set(struct ath_hw *ah,
 {
 	u32 regval;
 
-	regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+	regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 	regval &= ~(AR_PHY_ANT_DIV_MAIN_LNACONF |
 		    AR_PHY_ANT_DIV_ALT_LNACONF |
 		    AR_PHY_ANT_FAST_DIV_BIAS |
@@ -1549,7 +1549,7 @@ static void ar9003_hw_antdiv_comb_conf_set(struct ath_hw *ah,
 	regval |= ((antconf->alt_gaintb << AR_PHY_ANT_DIV_ALT_GAINTB_S)
 		   & AR_PHY_ANT_DIV_ALT_GAINTB);
 
-	REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+	REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 }
 
 #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
@@ -1570,7 +1570,7 @@ static void ar9003_hw_set_bt_ant_diversity(struct ath_hw *ah, bool enable)
 			regval &= ~AR_SWITCH_TABLE_COM2_ALL;
 			regval |= ah->config.ant_ctrl_comm2g_switch_enable;
 		}
-		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM_2,
+		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM_2(ah),
 			      AR_SWITCH_TABLE_COM2_ALL, regval);
 	}
 
@@ -1580,36 +1580,36 @@ static void ar9003_hw_set_bt_ant_diversity(struct ath_hw *ah, bool enable)
 	 * Set MAIN/ALT LNA conf.
 	 * Set MAIN/ALT gain_tb.
 	 */
-	regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+	regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 	regval &= (~AR_ANT_DIV_CTRL_ALL);
 	regval |= (ant_div_ctl1 & 0x3f) << AR_ANT_DIV_CTRL_ALL_S;
-	REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+	REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 
 	if (AR_SREV_9485_11_OR_LATER(ah)) {
 		/*
 		 * Enable LNA diversity.
 		 */
-		regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+		regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 		regval &= ~AR_PHY_ANT_DIV_LNADIV;
 		regval |= ((ant_div_ctl1 >> 6) & 0x1) << AR_PHY_ANT_DIV_LNADIV_S;
 		if (enable)
 			regval |= AR_ANT_DIV_ENABLE;
 
-		REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+		REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 
 		/*
 		 * Enable fast antenna diversity.
 		 */
-		regval = REG_READ(ah, AR_PHY_CCK_DETECT);
+		regval = REG_READ(ah, AR_PHY_CCK_DETECT(ah));
 		regval &= ~AR_FAST_DIV_ENABLE;
 		regval |= ((ant_div_ctl1 >> 7) & 0x1) << AR_FAST_DIV_ENABLE_S;
 		if (enable)
 			regval |= AR_FAST_DIV_ENABLE;
 
-		REG_WRITE(ah, AR_PHY_CCK_DETECT, regval);
+		REG_WRITE(ah, AR_PHY_CCK_DETECT(ah), regval);
 
 		if (pCap->hw_caps & ATH9K_HW_CAP_ANT_DIV_COMB) {
-			regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+			regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 			regval &= (~(AR_PHY_ANT_DIV_MAIN_LNACONF |
 				     AR_PHY_ANT_DIV_ALT_LNACONF |
 				     AR_PHY_ANT_DIV_ALT_GAINTB |
@@ -1622,33 +1622,33 @@ static void ar9003_hw_set_bt_ant_diversity(struct ath_hw *ah, bool enable)
 				   AR_PHY_ANT_DIV_MAIN_LNACONF_S);
 			regval |= (ATH_ANT_DIV_COMB_LNA2 <<
 				   AR_PHY_ANT_DIV_ALT_LNACONF_S);
-			REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+			REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 		}
 	} else if (AR_SREV_9565(ah)) {
 		if (enable) {
-			REG_SET_BIT(ah, AR_PHY_MC_GAIN_CTRL,
+			REG_SET_BIT(ah, AR_PHY_MC_GAIN_CTRL(ah),
 				    AR_ANT_DIV_ENABLE);
-			REG_SET_BIT(ah, AR_PHY_MC_GAIN_CTRL,
+			REG_SET_BIT(ah, AR_PHY_MC_GAIN_CTRL(ah),
 				    (1 << AR_PHY_ANT_SW_RX_PROT_S));
-			REG_SET_BIT(ah, AR_PHY_CCK_DETECT,
+			REG_SET_BIT(ah, AR_PHY_CCK_DETECT(ah),
 				    AR_FAST_DIV_ENABLE);
-			REG_SET_BIT(ah, AR_PHY_RESTART,
+			REG_SET_BIT(ah, AR_PHY_RESTART(ah),
 				    AR_PHY_RESTART_ENABLE_DIV_M2FLAG);
 			REG_SET_BIT(ah, AR_BTCOEX_WL_LNADIV,
 				    AR_BTCOEX_WL_LNADIV_FORCE_ON);
 		} else {
-			REG_CLR_BIT(ah, AR_PHY_MC_GAIN_CTRL,
+			REG_CLR_BIT(ah, AR_PHY_MC_GAIN_CTRL(ah),
 				    AR_ANT_DIV_ENABLE);
-			REG_CLR_BIT(ah, AR_PHY_MC_GAIN_CTRL,
+			REG_CLR_BIT(ah, AR_PHY_MC_GAIN_CTRL(ah),
 				    (1 << AR_PHY_ANT_SW_RX_PROT_S));
-			REG_CLR_BIT(ah, AR_PHY_CCK_DETECT,
+			REG_CLR_BIT(ah, AR_PHY_CCK_DETECT(ah),
 				    AR_FAST_DIV_ENABLE);
-			REG_CLR_BIT(ah, AR_PHY_RESTART,
+			REG_CLR_BIT(ah, AR_PHY_RESTART(ah),
 				    AR_PHY_RESTART_ENABLE_DIV_M2FLAG);
 			REG_CLR_BIT(ah, AR_BTCOEX_WL_LNADIV,
 				    AR_BTCOEX_WL_LNADIV_FORCE_ON);
 
-			regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL);
+			regval = REG_READ(ah, AR_PHY_MC_GAIN_CTRL(ah));
 			regval &= ~(AR_PHY_ANT_DIV_MAIN_LNACONF |
 				    AR_PHY_ANT_DIV_ALT_LNACONF |
 				    AR_PHY_ANT_DIV_MAIN_GAINTB |
@@ -1657,7 +1657,7 @@ static void ar9003_hw_set_bt_ant_diversity(struct ath_hw *ah, bool enable)
 				   AR_PHY_ANT_DIV_MAIN_LNACONF_S);
 			regval |= (ATH_ANT_DIV_COMB_LNA2 <<
 				   AR_PHY_ANT_DIV_ALT_LNACONF_S);
-			REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL, regval);
+			REG_WRITE(ah, AR_PHY_MC_GAIN_CTRL(ah), regval);
 		}
 	}
 }
@@ -1736,13 +1736,13 @@ static void ar9003_hw_spectral_scan_config(struct ath_hw *ah,
 	u8 count;
 
 	if (!param->enabled) {
-		REG_CLR_BIT(ah, AR_PHY_SPECTRAL_SCAN,
+		REG_CLR_BIT(ah, AR_PHY_SPECTRAL_SCAN(ah),
 			    AR_PHY_SPECTRAL_SCAN_ENABLE);
 		return;
 	}
 
-	REG_SET_BIT(ah, AR_PHY_RADAR_0, AR_PHY_RADAR_0_FFT_ENA);
-	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN, AR_PHY_SPECTRAL_SCAN_ENABLE);
+	REG_SET_BIT(ah, AR_PHY_RADAR_0(ah), AR_PHY_RADAR_0_FFT_ENA);
+	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN(ah), AR_PHY_SPECTRAL_SCAN_ENABLE);
 
 	/* on AR93xx and newer, count = 0 will make the chip send
 	 * spectral samples endlessly. Check if this really was intended,
@@ -1755,17 +1755,17 @@ static void ar9003_hw_spectral_scan_config(struct ath_hw *ah,
 		count = 1;
 
 	if (param->short_repeat)
-		REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN,
+		REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN(ah),
 			    AR_PHY_SPECTRAL_SCAN_SHORT_REPEAT);
 	else
-		REG_CLR_BIT(ah, AR_PHY_SPECTRAL_SCAN,
+		REG_CLR_BIT(ah, AR_PHY_SPECTRAL_SCAN(ah),
 			    AR_PHY_SPECTRAL_SCAN_SHORT_REPEAT);
 
-	REG_RMW_FIELD(ah, AR_PHY_SPECTRAL_SCAN,
+	REG_RMW_FIELD(ah, AR_PHY_SPECTRAL_SCAN(ah),
 		      AR_PHY_SPECTRAL_SCAN_COUNT, count);
-	REG_RMW_FIELD(ah, AR_PHY_SPECTRAL_SCAN,
+	REG_RMW_FIELD(ah, AR_PHY_SPECTRAL_SCAN(ah),
 		      AR_PHY_SPECTRAL_SCAN_PERIOD, param->period);
-	REG_RMW_FIELD(ah, AR_PHY_SPECTRAL_SCAN,
+	REG_RMW_FIELD(ah, AR_PHY_SPECTRAL_SCAN(ah),
 		      AR_PHY_SPECTRAL_SCAN_FFT_PERIOD, param->fft_period);
 
 	return;
@@ -1773,10 +1773,10 @@ static void ar9003_hw_spectral_scan_config(struct ath_hw *ah,
 
 static void ar9003_hw_spectral_scan_trigger(struct ath_hw *ah)
 {
-	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN,
+	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN(ah),
 		    AR_PHY_SPECTRAL_SCAN_ENABLE);
 	/* Activate spectral scan */
-	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN,
+	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN(ah),
 		    AR_PHY_SPECTRAL_SCAN_ACTIVE);
 }
 
@@ -1785,7 +1785,7 @@ static void ar9003_hw_spectral_scan_wait(struct ath_hw *ah)
 	struct ath_common *common = ath9k_hw_common(ah);
 
 	/* Poll for spectral scan complete */
-	if (!ath9k_hw_wait(ah, AR_PHY_SPECTRAL_SCAN,
+	if (!ath9k_hw_wait(ah, AR_PHY_SPECTRAL_SCAN(ah),
 			   AR_PHY_SPECTRAL_SCAN_ACTIVE,
 			   0, AH_WAIT_TIMEOUT)) {
 		ath_err(common, "spectral scan wait failed\n");
@@ -1923,12 +1923,12 @@ void ar9003_hw_attach_phy_ops(struct ath_hw *ah)
 	struct ath_hw_private_ops *priv_ops = ath9k_hw_private_ops(ah);
 	struct ath_hw_ops *ops = ath9k_hw_ops(ah);
 	static const u32 ar9300_cca_regs[6] = {
-		AR_PHY_CCA_0,
-		AR_PHY_CCA_1,
-		AR_PHY_CCA_2,
-		AR_PHY_EXT_CCA,
-		AR_PHY_EXT_CCA_1,
-		AR_PHY_EXT_CCA_2,
+		AR_PHY_CCA_0(ah),
+		AR_PHY_CCA_1(ah),
+		AR_PHY_CCA_2(ah),
+		AR_PHY_EXT_CCA(ah),
+		AR_PHY_EXT_CCA_1(ah),
+		AR_PHY_EXT_CCA_2(ah),
 	};
 
 	priv_ops->rf_set_freq = ar9003_hw_set_channel;
@@ -2004,15 +2004,15 @@ bool ar9003_hw_bb_watchdog_check(struct ath_hw *ah)
 
 	switch(ah->bb_watchdog_last_status) {
 	case 0x04000539:
-		val = REG_READ(ah, AR_PHY_RADAR_0);
+		val = REG_READ(ah, AR_PHY_RADAR_0(ah));
 		val &= (~AR_PHY_RADAR_0_FIRPWR);
 		val |= SM(0x7f, AR_PHY_RADAR_0_FIRPWR);
-		REG_WRITE(ah, AR_PHY_RADAR_0, val);
+		REG_WRITE(ah, AR_PHY_RADAR_0(ah), val);
 		udelay(1);
-		val = REG_READ(ah, AR_PHY_RADAR_0);
+		val = REG_READ(ah, AR_PHY_RADAR_0(ah));
 		val &= ~AR_PHY_RADAR_0_FIRPWR;
 		val |= SM(AR9300_DFS_FIRPWR, AR_PHY_RADAR_0_FIRPWR);
-		REG_WRITE(ah, AR_PHY_RADAR_0, val);
+		REG_WRITE(ah, AR_PHY_RADAR_0(ah), val);
 
 		return false;
 	case 0x1300000a:
@@ -2043,14 +2043,14 @@ void ar9003_hw_bb_watchdog_config(struct ath_hw *ah)
 
 	if (!idle_tmo_ms) {
 		/* disable IRQ, disable chip-reset for BB panic */
-		REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_2,
-			  REG_READ(ah, AR_PHY_WATCHDOG_CTL_2) &
+		REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_2(ah),
+			  REG_READ(ah, AR_PHY_WATCHDOG_CTL_2(ah)) &
 			  ~(AR_PHY_WATCHDOG_RST_ENABLE |
 			    AR_PHY_WATCHDOG_IRQ_ENABLE));
 
 		/* disable watchdog in non-IDLE mode, disable in IDLE mode */
-		REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_1,
-			  REG_READ(ah, AR_PHY_WATCHDOG_CTL_1) &
+		REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_1(ah),
+			  REG_READ(ah, AR_PHY_WATCHDOG_CTL_1(ah)) &
 			  ~(AR_PHY_WATCHDOG_NON_IDLE_ENABLE |
 			    AR_PHY_WATCHDOG_IDLE_ENABLE));
 
@@ -2059,8 +2059,8 @@ void ar9003_hw_bb_watchdog_config(struct ath_hw *ah)
 	}
 
 	/* enable IRQ, disable chip-reset for BB watchdog */
-	val = REG_READ(ah, AR_PHY_WATCHDOG_CTL_2) & AR_PHY_WATCHDOG_CNTL2_MASK;
-	REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_2,
+	val = REG_READ(ah, AR_PHY_WATCHDOG_CTL_2(ah)) & AR_PHY_WATCHDOG_CNTL2_MASK;
+	REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_2(ah),
 		  (val | AR_PHY_WATCHDOG_IRQ_ENABLE) &
 		  ~AR_PHY_WATCHDOG_RST_ENABLE);
 
@@ -2085,7 +2085,7 @@ void ar9003_hw_bb_watchdog_config(struct ath_hw *ah)
 	 * enable watchdog in non-IDLE mode, disable in IDLE mode,
 	 * set idle time-out.
 	 */
-	REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_1,
+	REG_WRITE(ah, AR_PHY_WATCHDOG_CTL_1(ah),
 		  AR_PHY_WATCHDOG_NON_IDLE_ENABLE |
 		  AR_PHY_WATCHDOG_IDLE_MASK |
 		  (AR_PHY_WATCHDOG_NON_IDLE_MASK & (idle_count << 2)));
@@ -2100,13 +2100,13 @@ void ar9003_hw_bb_watchdog_read(struct ath_hw *ah)
 	 * we want to avoid printing in ISR context so we save the
 	 * watchdog status to be printed later in bottom half context.
 	 */
-	ah->bb_watchdog_last_status = REG_READ(ah, AR_PHY_WATCHDOG_STATUS);
+	ah->bb_watchdog_last_status = REG_READ(ah, AR_PHY_WATCHDOG_STATUS(ah));
 
 	/*
 	 * the watchdog timer should reset on status read but to be sure
 	 * sure we write 0 to the watchdog status bit.
 	 */
-	REG_WRITE(ah, AR_PHY_WATCHDOG_STATUS,
+	REG_WRITE(ah, AR_PHY_WATCHDOG_STATUS(ah),
 		  ah->bb_watchdog_last_status & ~AR_PHY_WATCHDOG_STATUS_CLR);
 }
 
@@ -2134,10 +2134,10 @@ void ar9003_hw_bb_watchdog_dbg_info(struct ath_hw *ah)
 		MS(status, AR_PHY_WATCHDOG_SRCH_SM));
 
 	ath_dbg(common, RESET, "** BB WD cntl: cntl1=0x%08x cntl2=0x%08x **\n",
-		REG_READ(ah, AR_PHY_WATCHDOG_CTL_1),
-		REG_READ(ah, AR_PHY_WATCHDOG_CTL_2));
+		REG_READ(ah, AR_PHY_WATCHDOG_CTL_1(ah)),
+		REG_READ(ah, AR_PHY_WATCHDOG_CTL_2(ah)));
 	ath_dbg(common, RESET, "** BB mode: BB_gen_controls=0x%08x **\n",
-		REG_READ(ah, AR_PHY_GEN_CTRL));
+		REG_READ(ah, AR_PHY_GEN_CTRL(ah)));
 
 #define PCT(_field) (common->cc_survey._field * 100 / common->cc_survey.cycles)
 	if (common->cc_survey.cycles)
@@ -2163,9 +2163,9 @@ void ar9003_hw_disable_phy_restart(struct ath_hw *ah)
 
 	if ((result == 0xb) || ah->bb_hang_rx_ofdm) {
 		ah->bb_hang_rx_ofdm = true;
-		val = REG_READ(ah, AR_PHY_RESTART);
+		val = REG_READ(ah, AR_PHY_RESTART(ah));
 		val &= ~AR_PHY_RESTART_ENA;
-		REG_WRITE(ah, AR_PHY_RESTART, val);
+		REG_WRITE(ah, AR_PHY_RESTART(ah), val);
 	}
 }
 EXPORT_SYMBOL(ar9003_hw_disable_phy_restart);
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index ad72a30b67..ce7c398b8c 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -20,18 +20,18 @@
 /*
  * Channel Register Map
  */
-#define AR_CHAN_BASE	0x9800
-
-#define AR_PHY_TIMING1      (AR_CHAN_BASE + 0x0)
-#define AR_PHY_TIMING2      (AR_CHAN_BASE + 0x4)
-#define AR_PHY_TIMING3      (AR_CHAN_BASE + 0x8)
-#define AR_PHY_TIMING4      (AR_CHAN_BASE + 0xc)
-#define AR_PHY_TIMING5      (AR_CHAN_BASE + 0x10)
-#define AR_PHY_TIMING6      (AR_CHAN_BASE + 0x14)
-#define AR_PHY_TIMING11     (AR_CHAN_BASE + 0x18)
-#define AR_PHY_SPUR_REG     (AR_CHAN_BASE + 0x1c)
-#define AR_PHY_RX_IQCAL_CORR_B0    (AR_CHAN_BASE + 0xdc)
-#define AR_PHY_TX_IQCAL_CONTROL_3  (AR_CHAN_BASE + 0xb0)
+#define AR_CHAN_BASE(_ah)	0x9800
+
+#define AR_PHY_TIMING1(_ah)      (AR_CHAN_BASE(_ah) + 0x0)
+#define AR_PHY_TIMING2(_ah)      (AR_CHAN_BASE(_ah) + 0x4)
+#define AR_PHY_TIMING3(_ah)      (AR_CHAN_BASE(_ah) + 0x8)
+#define AR_PHY_TIMING4(_ah)      (AR_CHAN_BASE(_ah) + 0xc)
+#define AR_PHY_TIMING5(_ah)      (AR_CHAN_BASE(_ah) + 0x10)
+#define AR_PHY_TIMING6(_ah)      (AR_CHAN_BASE(_ah) + 0x14)
+#define AR_PHY_TIMING11(_ah)     (AR_CHAN_BASE(_ah) + 0x18)
+#define AR_PHY_SPUR_REG(_ah)     (AR_CHAN_BASE(_ah) + 0x1c)
+#define AR_PHY_RX_IQCAL_CORR_B0(_ah)    (AR_CHAN_BASE(_ah) + 0xdc)
+#define AR_PHY_TX_IQCAL_CONTROL_3(_ah)  (AR_CHAN_BASE(_ah) + 0xb0)
 #define AR_PHY_TIMING_CONTROL4_DO_GAIN_DC_IQ_CAL_SHIFT 16
 
 #define AR_PHY_TIMING11_SPUR_FREQ_SD    0x3FF00000
@@ -64,38 +64,38 @@
 #define AR_PHY_TX_IQCAL_CONTROL_3_IQCORR_EN   0x80000000
 #define AR_PHY_TX_IQCAL_CONTROL_3_IQCORR_EN_S         31
 
-#define AR_PHY_FIND_SIG_LOW  (AR_CHAN_BASE + 0x20)
+#define AR_PHY_FIND_SIG_LOW(_ah)  (AR_CHAN_BASE(_ah) + 0x20)
 
-#define AR_PHY_SFCORR           (AR_CHAN_BASE + 0x24)
-#define AR_PHY_SFCORR_LOW       (AR_CHAN_BASE + 0x28)
-#define AR_PHY_SFCORR_EXT       (AR_CHAN_BASE + 0x2c)
+#define AR_PHY_SFCORR(_ah)           (AR_CHAN_BASE(_ah) + 0x24)
+#define AR_PHY_SFCORR_LOW(_ah)       (AR_CHAN_BASE(_ah) + 0x28)
+#define AR_PHY_SFCORR_EXT(_ah)       (AR_CHAN_BASE(_ah) + 0x2c)
 
-#define AR_PHY_EXT_CCA              (AR_CHAN_BASE + 0x30)
-#define AR_PHY_RADAR_0              (AR_CHAN_BASE + 0x34)
-#define AR_PHY_RADAR_1              (AR_CHAN_BASE + 0x38)
-#define AR_PHY_RADAR_EXT            (AR_CHAN_BASE + 0x3c)
-#define AR_PHY_MULTICHAIN_CTRL      (AR_CHAN_BASE + 0x80)
-#define AR_PHY_PERCHAIN_CSD         (AR_CHAN_BASE + 0x84)
+#define AR_PHY_EXT_CCA(_ah)              (AR_CHAN_BASE(_ah) + 0x30)
+#define AR_PHY_RADAR_0(_ah)              (AR_CHAN_BASE(_ah) + 0x34)
+#define AR_PHY_RADAR_1(_ah)              (AR_CHAN_BASE(_ah) + 0x38)
+#define AR_PHY_RADAR_EXT(_ah)            (AR_CHAN_BASE(_ah) + 0x3c)
+#define AR_PHY_MULTICHAIN_CTRL(_ah)      (AR_CHAN_BASE(_ah) + 0x80)
+#define AR_PHY_PERCHAIN_CSD(_ah)         (AR_CHAN_BASE(_ah) + 0x84)
 
-#define AR_PHY_TX_PHASE_RAMP_0      (AR_CHAN_BASE + 0xd0)
-#define AR_PHY_ADC_GAIN_DC_CORR_0   (AR_CHAN_BASE + 0xd4)
-#define AR_PHY_IQ_ADC_MEAS_0_B0     (AR_CHAN_BASE + 0xc0)
-#define AR_PHY_IQ_ADC_MEAS_1_B0     (AR_CHAN_BASE + 0xc4)
-#define AR_PHY_IQ_ADC_MEAS_2_B0     (AR_CHAN_BASE + 0xc8)
-#define AR_PHY_IQ_ADC_MEAS_3_B0     (AR_CHAN_BASE + 0xcc)
+#define AR_PHY_TX_PHASE_RAMP_0(_ah)      (AR_CHAN_BASE(_ah) + 0xd0)
+#define AR_PHY_ADC_GAIN_DC_CORR_0(_ah)   (AR_CHAN_BASE(_ah) + 0xd4)
+#define AR_PHY_IQ_ADC_MEAS_0_B0(_ah)     (AR_CHAN_BASE(_ah) + 0xc0)
+#define AR_PHY_IQ_ADC_MEAS_1_B0(_ah)     (AR_CHAN_BASE(_ah) + 0xc4)
+#define AR_PHY_IQ_ADC_MEAS_2_B0(_ah)     (AR_CHAN_BASE(_ah) + 0xc8)
+#define AR_PHY_IQ_ADC_MEAS_3_B0(_ah)     (AR_CHAN_BASE(_ah) + 0xcc)
 
 /* The following registers changed position from AR9300 1.0 to AR9300 2.0 */
-#define AR_PHY_TX_PHASE_RAMP_0_9300_10      (AR_CHAN_BASE + 0xd0 - 0x10)
-#define AR_PHY_ADC_GAIN_DC_CORR_0_9300_10   (AR_CHAN_BASE + 0xd4 - 0x10)
-#define AR_PHY_IQ_ADC_MEAS_0_B0_9300_10     (AR_CHAN_BASE + 0xc0 + 0x8)
-#define AR_PHY_IQ_ADC_MEAS_1_B0_9300_10     (AR_CHAN_BASE + 0xc4 + 0x8)
-#define AR_PHY_IQ_ADC_MEAS_2_B0_9300_10     (AR_CHAN_BASE + 0xc8 + 0x8)
-#define AR_PHY_IQ_ADC_MEAS_3_B0_9300_10     (AR_CHAN_BASE + 0xcc + 0x8)
-
-#define AR_PHY_TX_CRC               (AR_CHAN_BASE + 0xa0)
-#define AR_PHY_TST_DAC_CONST        (AR_CHAN_BASE + 0xa4)
-#define AR_PHY_SPUR_REPORT_0        (AR_CHAN_BASE + 0xa8)
-#define AR_PHY_CHAN_INFO_TAB_0      (AR_CHAN_BASE + 0x300)
+#define AR_PHY_TX_PHASE_RAMP_0_9300_10(_ah)      (AR_CHAN_BASE(_ah) + 0xd0 - 0x10)
+#define AR_PHY_ADC_GAIN_DC_CORR_0_9300_10(_ah)   (AR_CHAN_BASE(_ah) + 0xd4 - 0x10)
+#define AR_PHY_IQ_ADC_MEAS_0_B0_9300_10(_ah)     (AR_CHAN_BASE(_ah) + 0xc0 + 0x8)
+#define AR_PHY_IQ_ADC_MEAS_1_B0_9300_10(_ah)     (AR_CHAN_BASE(_ah) + 0xc4 + 0x8)
+#define AR_PHY_IQ_ADC_MEAS_2_B0_9300_10(_ah)     (AR_CHAN_BASE(_ah) + 0xc8 + 0x8)
+#define AR_PHY_IQ_ADC_MEAS_3_B0_9300_10(_ah)     (AR_CHAN_BASE(_ah) + 0xcc + 0x8)
+
+#define AR_PHY_TX_CRC(_ah)               (AR_CHAN_BASE(_ah) + 0xa0)
+#define AR_PHY_TST_DAC_CONST(_ah)        (AR_CHAN_BASE(_ah) + 0xa4)
+#define AR_PHY_SPUR_REPORT_0(_ah)        (AR_CHAN_BASE(_ah) + 0xa8)
+#define AR_PHY_CHAN_INFO_TAB_0(_ah)      (AR_CHAN_BASE(_ah) + 0x300)
 
 /*
  * Channel Field Definitions
@@ -214,17 +214,17 @@
 /*
  * MRC Register Map
  */
-#define AR_MRC_BASE	0x9c00
-
-#define AR_PHY_TIMING_3A       (AR_MRC_BASE + 0x0)
-#define AR_PHY_LDPC_CNTL1      (AR_MRC_BASE + 0x4)
-#define AR_PHY_LDPC_CNTL2      (AR_MRC_BASE + 0x8)
-#define AR_PHY_PILOT_SPUR_MASK (AR_MRC_BASE + 0xc)
-#define AR_PHY_CHAN_SPUR_MASK  (AR_MRC_BASE + 0x10)
-#define AR_PHY_SGI_DELTA       (AR_MRC_BASE + 0x14)
-#define AR_PHY_ML_CNTL_1       (AR_MRC_BASE + 0x18)
-#define AR_PHY_ML_CNTL_2       (AR_MRC_BASE + 0x1c)
-#define AR_PHY_TST_ADC         (AR_MRC_BASE + 0x20)
+#define AR_MRC_BASE(_ah)	0x9c00
+
+#define AR_PHY_TIMING_3A(_ah)       (AR_MRC_BASE(_ah) + 0x0)
+#define AR_PHY_LDPC_CNTL1(_ah)      (AR_MRC_BASE(_ah) + 0x4)
+#define AR_PHY_LDPC_CNTL2(_ah)      (AR_MRC_BASE(_ah) + 0x8)
+#define AR_PHY_PILOT_SPUR_MASK(_ah) (AR_MRC_BASE(_ah) + 0xc)
+#define AR_PHY_CHAN_SPUR_MASK(_ah)  (AR_MRC_BASE(_ah) + 0x10)
+#define AR_PHY_SGI_DELTA(_ah)       (AR_MRC_BASE(_ah) + 0x14)
+#define AR_PHY_ML_CNTL_1(_ah)       (AR_MRC_BASE(_ah) + 0x18)
+#define AR_PHY_ML_CNTL_2(_ah)       (AR_MRC_BASE(_ah) + 0x1c)
+#define AR_PHY_TST_ADC(_ah)         (AR_MRC_BASE(_ah) + 0x20)
 
 #define AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_A      0x00000FE0
 #define AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_A_S    5
@@ -255,28 +255,28 @@
 /*
  * BBB Register Map
  */
-#define AR_BBB_BASE	0x9d00
+#define AR_BBB_BASE(_ah)	0x9d00
 
 /*
  * AGC Register Map
  */
-#define AR_AGC_BASE	0x9e00
-
-#define AR_PHY_SETTLING         (AR_AGC_BASE + 0x0)
-#define AR_PHY_FORCEMAX_GAINS_0 (AR_AGC_BASE + 0x4)
-#define AR_PHY_GAINS_MINOFF0    (AR_AGC_BASE + 0x8)
-#define AR_PHY_DESIRED_SZ       (AR_AGC_BASE + 0xc)
-#define AR_PHY_FIND_SIG         (AR_AGC_BASE + 0x10)
-#define AR_PHY_AGC              (AR_AGC_BASE + 0x14)
-#define AR_PHY_EXT_ATTEN_CTL_0  (AR_AGC_BASE + 0x18)
-#define AR_PHY_CCA_0            (AR_AGC_BASE + 0x1c)
-#define AR_PHY_CCA_CTRL_0       (AR_AGC_BASE + 0x20)
-#define AR_PHY_RESTART          (AR_AGC_BASE + 0x24)
+#define AR_AGC_BASE(_ah)	0x9e00
+
+#define AR_PHY_SETTLING(_ah)         (AR_AGC_BASE(_ah) + 0x0)
+#define AR_PHY_FORCEMAX_GAINS_0(_ah) (AR_AGC_BASE(_ah) + 0x4)
+#define AR_PHY_GAINS_MINOFF0(_ah)    (AR_AGC_BASE(_ah) + 0x8)
+#define AR_PHY_DESIRED_SZ(_ah)       (AR_AGC_BASE(_ah) + 0xc)
+#define AR_PHY_FIND_SIG(_ah)         (AR_AGC_BASE(_ah) + 0x10)
+#define AR_PHY_AGC(_ah)              (AR_AGC_BASE(_ah) + 0x14)
+#define AR_PHY_EXT_ATTEN_CTL_0(_ah)  (AR_AGC_BASE(_ah) + 0x18)
+#define AR_PHY_CCA_0(_ah)            (AR_AGC_BASE(_ah) + 0x1c)
+#define AR_PHY_CCA_CTRL_0(_ah)       (AR_AGC_BASE(_ah) + 0x20)
+#define AR_PHY_RESTART(_ah)          (AR_AGC_BASE(_ah) + 0x24)
 
 /*
  * Antenna Diversity  settings
  */
-#define AR_PHY_MC_GAIN_CTRL     (AR_AGC_BASE + 0x28)
+#define AR_PHY_MC_GAIN_CTRL(_ah)     (AR_AGC_BASE(_ah) + 0x28)
 #define AR_ANT_DIV_CTRL_ALL	0x7e000000
 #define AR_ANT_DIV_CTRL_ALL_S	25
 #define AR_ANT_DIV_ENABLE	0x1000000
@@ -298,25 +298,25 @@
 #define AR_PHY_ANT_DIV_MAIN_GAINTB              0x40000000
 #define AR_PHY_ANT_DIV_MAIN_GAINTB_S            30
 
-#define AR_PHY_EXTCHN_PWRTHR1   (AR_AGC_BASE + 0x2c)
-#define AR_PHY_EXT_CHN_WIN      (AR_AGC_BASE + 0x30)
-#define AR_PHY_20_40_DET_THR    (AR_AGC_BASE + 0x34)
-#define AR_PHY_RIFS_SRCH        (AR_AGC_BASE + 0x38)
-#define AR_PHY_PEAK_DET_CTRL_1  (AR_AGC_BASE + 0x3c)
-#define AR_PHY_PEAK_DET_CTRL_2  (AR_AGC_BASE + 0x40)
-#define AR_PHY_RX_GAIN_BOUNDS_1 (AR_AGC_BASE + 0x44)
-#define AR_PHY_RX_GAIN_BOUNDS_2 (AR_AGC_BASE + 0x48)
-#define AR_PHY_RSSI_0           (AR_AGC_BASE + 0x180)
-#define AR_PHY_SPUR_CCK_REP0    (AR_AGC_BASE + 0x184)
-
-#define AR_PHY_CCK_DETECT       (AR_AGC_BASE + 0x1c0)
+#define AR_PHY_EXTCHN_PWRTHR1(_ah)   (AR_AGC_BASE(_ah) + 0x2c)
+#define AR_PHY_EXT_CHN_WIN(_ah)      (AR_AGC_BASE(_ah) + 0x30)
+#define AR_PHY_20_40_DET_THR(_ah)    (AR_AGC_BASE(_ah) + 0x34)
+#define AR_PHY_RIFS_SRCH(_ah)        (AR_AGC_BASE(_ah) + 0x38)
+#define AR_PHY_PEAK_DET_CTRL_1(_ah)  (AR_AGC_BASE(_ah) + 0x3c)
+#define AR_PHY_PEAK_DET_CTRL_2(_ah)  (AR_AGC_BASE(_ah) + 0x40)
+#define AR_PHY_RX_GAIN_BOUNDS_1(_ah) (AR_AGC_BASE(_ah) + 0x44)
+#define AR_PHY_RX_GAIN_BOUNDS_2(_ah) (AR_AGC_BASE(_ah) + 0x48)
+#define AR_PHY_RSSI_0(_ah)           (AR_AGC_BASE(_ah) + 0x180)
+#define AR_PHY_SPUR_CCK_REP0(_ah)    (AR_AGC_BASE(_ah) + 0x184)
+
+#define AR_PHY_CCK_DETECT(_ah)       (AR_AGC_BASE(_ah) + 0x1c0)
 #define AR_FAST_DIV_ENABLE	0x2000
 #define AR_FAST_DIV_ENABLE_S	13
 
-#define AR_PHY_DAG_CTRLCCK      (AR_AGC_BASE + 0x1c4)
-#define AR_PHY_IQCORR_CTRL_CCK  (AR_AGC_BASE + 0x1c8)
+#define AR_PHY_DAG_CTRLCCK(_ah)      (AR_AGC_BASE(_ah) + 0x1c4)
+#define AR_PHY_IQCORR_CTRL_CCK(_ah)  (AR_AGC_BASE(_ah) + 0x1c8)
 
-#define AR_PHY_CCK_SPUR_MIT     (AR_AGC_BASE + 0x1cc)
+#define AR_PHY_CCK_SPUR_MIT(_ah)     (AR_AGC_BASE(_ah) + 0x1cc)
 #define AR_PHY_CCK_SPUR_MIT_SPUR_RSSI_THR                           0x000001fe
 #define AR_PHY_CCK_SPUR_MIT_SPUR_RSSI_THR_S                                  1
 #define AR_PHY_CCK_SPUR_MIT_SPUR_FILTER_TYPE                        0x60000000
@@ -326,13 +326,13 @@
 #define AR_PHY_CCK_SPUR_MIT_CCK_SPUR_FREQ                           0x1ffffe00
 #define AR_PHY_CCK_SPUR_MIT_CCK_SPUR_FREQ_S                                  9
 
-#define AR_PHY_MRC_CCK_CTRL         (AR_AGC_BASE + 0x1d0)
+#define AR_PHY_MRC_CCK_CTRL(_ah)         (AR_AGC_BASE(_ah) + 0x1d0)
 #define AR_PHY_MRC_CCK_ENABLE       0x00000001
 #define AR_PHY_MRC_CCK_ENABLE_S              0
 #define AR_PHY_MRC_CCK_MUX_REG      0x00000002
 #define AR_PHY_MRC_CCK_MUX_REG_S             1
 
-#define AR_PHY_RX_OCGAIN        (AR_AGC_BASE + 0x200)
+#define AR_PHY_RX_OCGAIN(_ah)        (AR_AGC_BASE(_ah) + 0x200)
 
 #define AR_PHY_CCA_NOM_VAL_9300_2GHZ          -110
 #define AR_PHY_CCA_NOM_VAL_9300_5GHZ          -115
@@ -448,44 +448,44 @@
 /*
  * SM Register Map
  */
-#define AR_SM_BASE	0xa200
-
-#define AR_PHY_D2_CHIP_ID        (AR_SM_BASE + 0x0)
-#define AR_PHY_GEN_CTRL          (AR_SM_BASE + 0x4)
-#define AR_PHY_MODE              (AR_SM_BASE + 0x8)
-#define AR_PHY_ACTIVE            (AR_SM_BASE + 0xc)
-#define AR_PHY_SPUR_MASK_A(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x18 : 0x20))
-#define AR_PHY_SPUR_MASK_B(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x1c : 0x24))
-#define AR_PHY_SPECTRAL_SCAN     (AR_SM_BASE + 0x28)
-#define AR_PHY_RADAR_BW_FILTER   (AR_SM_BASE + 0x2c)
-#define AR_PHY_SEARCH_START_DELAY (AR_SM_BASE + 0x30)
-#define AR_PHY_MAX_RX_LEN        (AR_SM_BASE + 0x34)
-#define AR_PHY_FRAME_CTL         (AR_SM_BASE + 0x38)
-#define AR_PHY_RFBUS_REQ         (AR_SM_BASE + 0x3c)
-#define AR_PHY_RFBUS_GRANT       (AR_SM_BASE + 0x40)
-#define AR_PHY_RIFS              (AR_SM_BASE + 0x44)
-#define AR_PHY_RX_CLR_DELAY      (AR_SM_BASE + 0x50)
-#define AR_PHY_RX_DELAY          (AR_SM_BASE + 0x54)
-
-#define AR_PHY_XPA_TIMING_CTL    (AR_SM_BASE + 0x64)
-#define AR_PHY_MISC_PA_CTL       (AR_SM_BASE + 0x80)
-#define AR_PHY_SWITCH_CHAIN_0    (AR_SM_BASE + 0x84)
-#define AR_PHY_SWITCH_COM        (AR_SM_BASE + 0x88)
-#define AR_PHY_SWITCH_COM_2      (AR_SM_BASE + 0x8c)
-#define AR_PHY_RX_CHAINMASK      (AR_SM_BASE + 0xa0)
-#define AR_PHY_CAL_CHAINMASK     (AR_SM_BASE + 0xc0)
-#define AR_PHY_CALMODE           (AR_SM_BASE + 0xc8)
-#define AR_PHY_FCAL_1            (AR_SM_BASE + 0xcc)
-#define AR_PHY_FCAL_2_0          (AR_SM_BASE + 0xd0)
-#define AR_PHY_DFT_TONE_CTL_0    (AR_SM_BASE + 0xd4)
-#define AR_PHY_CL_CAL_CTL        (AR_SM_BASE + 0xd8)
-#define AR_PHY_CL_TAB_0          (AR_SM_BASE + 0x100)
-#define AR_PHY_SYNTH_CONTROL     (AR_SM_BASE + 0x140)
-#define AR_PHY_ADDAC_CLK_SEL     (AR_SM_BASE + 0x144)
-#define AR_PHY_PLL_CTL           (AR_SM_BASE + 0x148)
-#define AR_PHY_ANALOG_SWAP       (AR_SM_BASE + 0x14c)
-#define AR_PHY_ADDAC_PARA_CTL    (AR_SM_BASE + 0x150)
-#define AR_PHY_XPA_CFG           (AR_SM_BASE + 0x158)
+#define AR_SM_BASE(_ah)	0xa200
+
+#define AR_PHY_D2_CHIP_ID(_ah)        (AR_SM_BASE(_ah) + 0x0)
+#define AR_PHY_GEN_CTRL(_ah)          (AR_SM_BASE(_ah) + 0x4)
+#define AR_PHY_MODE(_ah)              (AR_SM_BASE(_ah) + 0x8)
+#define AR_PHY_ACTIVE(_ah)            (AR_SM_BASE(_ah) + 0xc)
+#define AR_PHY_SPUR_MASK_A(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x18 : 0x20))
+#define AR_PHY_SPUR_MASK_B(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x1c : 0x24))
+#define AR_PHY_SPECTRAL_SCAN(_ah)     (AR_SM_BASE(_ah) + 0x28)
+#define AR_PHY_RADAR_BW_FILTER(_ah)   (AR_SM_BASE(_ah) + 0x2c)
+#define AR_PHY_SEARCH_START_DELAY(_ah) (AR_SM_BASE(_ah) + 0x30)
+#define AR_PHY_MAX_RX_LEN(_ah)        (AR_SM_BASE(_ah) + 0x34)
+#define AR_PHY_FRAME_CTL(_ah)         (AR_SM_BASE(_ah) + 0x38)
+#define AR_PHY_RFBUS_REQ(_ah)         (AR_SM_BASE(_ah) + 0x3c)
+#define AR_PHY_RFBUS_GRANT(_ah)       (AR_SM_BASE(_ah) + 0x40)
+#define AR_PHY_RIFS(_ah)              (AR_SM_BASE(_ah) + 0x44)
+#define AR_PHY_RX_CLR_DELAY(_ah)      (AR_SM_BASE(_ah) + 0x50)
+#define AR_PHY_RX_DELAY(_ah)          (AR_SM_BASE(_ah) + 0x54)
+
+#define AR_PHY_XPA_TIMING_CTL(_ah)    (AR_SM_BASE(_ah) + 0x64)
+#define AR_PHY_MISC_PA_CTL(_ah)       (AR_SM_BASE(_ah) + 0x80)
+#define AR_PHY_SWITCH_CHAIN_0(_ah)    (AR_SM_BASE(_ah) + 0x84)
+#define AR_PHY_SWITCH_COM(_ah)        (AR_SM_BASE(_ah) + 0x88)
+#define AR_PHY_SWITCH_COM_2(_ah)      (AR_SM_BASE(_ah) + 0x8c)
+#define AR_PHY_RX_CHAINMASK(_ah)      (AR_SM_BASE(_ah) + 0xa0)
+#define AR_PHY_CAL_CHAINMASK(_ah)     (AR_SM_BASE(_ah) + 0xc0)
+#define AR_PHY_CALMODE(_ah)           (AR_SM_BASE(_ah) + 0xc8)
+#define AR_PHY_FCAL_1(_ah)            (AR_SM_BASE(_ah) + 0xcc)
+#define AR_PHY_FCAL_2_0(_ah)          (AR_SM_BASE(_ah) + 0xd0)
+#define AR_PHY_DFT_TONE_CTL_0(_ah)    (AR_SM_BASE(_ah) + 0xd4)
+#define AR_PHY_CL_CAL_CTL(_ah)        (AR_SM_BASE(_ah) + 0xd8)
+#define AR_PHY_CL_TAB_0(_ah)          (AR_SM_BASE(_ah) + 0x100)
+#define AR_PHY_SYNTH_CONTROL(_ah)     (AR_SM_BASE(_ah) + 0x140)
+#define AR_PHY_ADDAC_CLK_SEL(_ah)     (AR_SM_BASE(_ah) + 0x144)
+#define AR_PHY_PLL_CTL(_ah)           (AR_SM_BASE(_ah) + 0x148)
+#define AR_PHY_ANALOG_SWAP(_ah)       (AR_SM_BASE(_ah) + 0x14c)
+#define AR_PHY_ADDAC_PARA_CTL(_ah)    (AR_SM_BASE(_ah) + 0x150)
+#define AR_PHY_XPA_CFG(_ah)           (AR_SM_BASE(_ah) + 0x158)
 
 #define AR_PHY_FLC_PWR_THRESH		7
 #define AR_PHY_FLC_PWR_THRESH_S		0
@@ -498,7 +498,7 @@
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A                       0x3FF
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A_S                     0
 
-#define AR_PHY_TEST(_ah)         (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x15c : 0x160))
+#define AR_PHY_TEST(_ah)         (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x15c : 0x160))
 
 #define AR_PHY_TEST_BBB_OBS_SEL       0x780000
 #define AR_PHY_TEST_BBB_OBS_SEL_S     19
@@ -509,7 +509,7 @@
 #define AR_PHY_TEST_CHAIN_SEL      0xC0000000
 #define AR_PHY_TEST_CHAIN_SEL_S    30
 
-#define AR_PHY_TEST_CTL_STATUS(_ah) (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x160 : 0x164))
+#define AR_PHY_TEST_CTL_STATUS(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x160 : 0x164))
 #define AR_PHY_TEST_CTL_TSTDAC_EN         0x1
 #define AR_PHY_TEST_CTL_TSTDAC_EN_S       0
 #define AR_PHY_TEST_CTL_TX_OBS_SEL        0x1C
@@ -524,69 +524,69 @@
 #define AR_PHY_TEST_CTL_DEBUGPORT_SEL_S	  29
 
 
-#define AR_PHY_TSTDAC(_ah)       (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x164 : 0x168))
+#define AR_PHY_TSTDAC(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x164 : 0x168))
 
-#define AR_PHY_CHAN_STATUS(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x168 : 0x16c))
+#define AR_PHY_CHAN_STATUS(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x168 : 0x16c))
 
-#define AR_PHY_CHAN_INFO_MEMORY(_ah) (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x16c : 0x170))
+#define AR_PHY_CHAN_INFO_MEMORY(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x16c : 0x170))
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ	0x00000008
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ_S	3
 
-#define AR_PHY_CHNINFO_NOISEPWR(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x170 : 0x174))
-#define AR_PHY_CHNINFO_GAINDIFF(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x174 : 0x178))
-#define AR_PHY_CHNINFO_FINETIM(_ah)   (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x178 : 0x17c))
-#define AR_PHY_CHAN_INFO_GAIN_0(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x17c : 0x180))
-#define AR_PHY_SCRAMBLER_SEED(_ah)    (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x184 : 0x190))
-#define AR_PHY_CCK_TX_CTRL(_ah)       (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x188 : 0x194))
-
-#define AR_PHY_HEAVYCLIP_CTL(_ah) (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x198 : 0x1a4))
-#define AR_PHY_HEAVYCLIP_20      (AR_SM_BASE + 0x1a8)
-#define AR_PHY_HEAVYCLIP_40      (AR_SM_BASE + 0x1ac)
-#define AR_PHY_HEAVYCLIP_1	 (AR_SM_BASE + 0x19c)
-#define AR_PHY_HEAVYCLIP_2	 (AR_SM_BASE + 0x1a0)
-#define AR_PHY_HEAVYCLIP_3	 (AR_SM_BASE + 0x1a4)
-#define AR_PHY_HEAVYCLIP_4	 (AR_SM_BASE + 0x1a8)
-#define AR_PHY_HEAVYCLIP_5	 (AR_SM_BASE + 0x1ac)
-#define AR_PHY_ILLEGAL_TXRATE    (AR_SM_BASE + 0x1b0)
-
-#define AR_PHY_POWER_TX_RATE(_d) (AR_SM_BASE + 0x1c0 + ((_d) << 2))
-
-#define AR_PHY_PWRTX_MAX         (AR_SM_BASE + 0x1f0)
-#define AR_PHY_POWER_TX_SUB      (AR_SM_BASE + 0x1f4)
-
-#define AR_PHY_TPC_1				(AR_SM_BASE + 0x1f8)
+#define AR_PHY_CHNINFO_NOISEPWR(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x170 : 0x174))
+#define AR_PHY_CHNINFO_GAINDIFF(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x174 : 0x178))
+#define AR_PHY_CHNINFO_FINETIM(_ah)   (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x178 : 0x17c))
+#define AR_PHY_CHAN_INFO_GAIN_0(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x17c : 0x180))
+#define AR_PHY_SCRAMBLER_SEED(_ah)    (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x184 : 0x190))
+#define AR_PHY_CCK_TX_CTRL(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x188 : 0x194))
+
+#define AR_PHY_HEAVYCLIP_CTL(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x198 : 0x1a4))
+#define AR_PHY_HEAVYCLIP_20(_ah)      (AR_SM_BASE(_ah) + 0x1a8)
+#define AR_PHY_HEAVYCLIP_40(_ah)      (AR_SM_BASE(_ah) + 0x1ac)
+#define AR_PHY_HEAVYCLIP_1(_ah)	 (AR_SM_BASE(_ah) + 0x19c)
+#define AR_PHY_HEAVYCLIP_2(_ah)	 (AR_SM_BASE(_ah) + 0x1a0)
+#define AR_PHY_HEAVYCLIP_3(_ah)	 (AR_SM_BASE(_ah) + 0x1a4)
+#define AR_PHY_HEAVYCLIP_4(_ah)	 (AR_SM_BASE(_ah) + 0x1a8)
+#define AR_PHY_HEAVYCLIP_5(_ah)	 (AR_SM_BASE(_ah) + 0x1ac)
+#define AR_PHY_ILLEGAL_TXRATE(_ah)    (AR_SM_BASE(_ah) + 0x1b0)
+
+#define AR_PHY_POWER_TX_RATE(_ah, _d) (AR_SM_BASE(_ah) + 0x1c0 + ((_d) << 2))
+
+#define AR_PHY_PWRTX_MAX(_ah)         (AR_SM_BASE(_ah) + 0x1f0)
+#define AR_PHY_POWER_TX_SUB(_ah)      (AR_SM_BASE(_ah) + 0x1f4)
+
+#define AR_PHY_TPC_1(_ah)			(AR_SM_BASE(_ah) + 0x1f8)
 #define AR_PHY_TPC_1_FORCED_DAC_GAIN		0x0000003e
 #define AR_PHY_TPC_1_FORCED_DAC_GAIN_S		1
 #define AR_PHY_TPC_1_FORCE_DAC_GAIN		0x00000001
 #define AR_PHY_TPC_1_FORCE_DAC_GAIN_S		0
 
-#define AR_PHY_TPC_4_B0				(AR_SM_BASE + 0x204)
-#define AR_PHY_TPC_5_B0				(AR_SM_BASE + 0x208)
-#define AR_PHY_TPC_6_B0				(AR_SM_BASE + 0x20c)
+#define AR_PHY_TPC_4_B0(_ah)			(AR_SM_BASE(_ah) + 0x204)
+#define AR_PHY_TPC_5_B0(_ah)			(AR_SM_BASE(_ah) + 0x208)
+#define AR_PHY_TPC_6_B0(_ah)			(AR_SM_BASE(_ah) + 0x20c)
 
-#define AR_PHY_TPC_11_B0			(AR_SM_BASE + 0x220)
-#define AR_PHY_TPC_11_B1			(AR_SM1_BASE + 0x220)
-#define AR_PHY_TPC_11_B2			(AR_SM2_BASE + 0x220)
+#define AR_PHY_TPC_11_B0(_ah)			(AR_SM_BASE(_ah) + 0x220)
+#define AR_PHY_TPC_11_B1(_ah)			(AR_SM1_BASE(_ah) + 0x220)
+#define AR_PHY_TPC_11_B2(_ah)			(AR_SM2_BASE(_ah) + 0x220)
 #define AR_PHY_TPC_11_OLPC_GAIN_DELTA		0x00ff0000
 #define AR_PHY_TPC_11_OLPC_GAIN_DELTA_S		16
 
-#define AR_PHY_TPC_12				(AR_SM_BASE + 0x224)
+#define AR_PHY_TPC_12(_ah)			(AR_SM_BASE(_ah) + 0x224)
 #define AR_PHY_TPC_12_DESIRED_SCALE_HT40_5	0x3e000000
 #define AR_PHY_TPC_12_DESIRED_SCALE_HT40_5_S	25
 
-#define AR_PHY_TPC_18				(AR_SM_BASE + 0x23c)
+#define AR_PHY_TPC_18(_ah)			(AR_SM_BASE(_ah) + 0x23c)
 #define AR_PHY_TPC_18_THERM_CAL_VALUE           0x000000ff
 #define AR_PHY_TPC_18_THERM_CAL_VALUE_S         0
 #define AR_PHY_TPC_18_VOLT_CAL_VALUE		0x0000ff00
 #define AR_PHY_TPC_18_VOLT_CAL_VALUE_S		8
 
-#define AR_PHY_TPC_19				(AR_SM_BASE + 0x240)
+#define AR_PHY_TPC_19(_ah)			(AR_SM_BASE(_ah) + 0x240)
 #define AR_PHY_TPC_19_ALPHA_VOLT		0x001f0000
 #define AR_PHY_TPC_19_ALPHA_VOLT_S		16
 #define AR_PHY_TPC_19_ALPHA_THERM		0xff
 #define AR_PHY_TPC_19_ALPHA_THERM_S		0
 
-#define AR_PHY_TX_FORCED_GAIN				(AR_SM_BASE + 0x258)
+#define AR_PHY_TX_FORCED_GAIN(_ah)			(AR_SM_BASE(_ah) + 0x258)
 #define AR_PHY_TX_FORCED_GAIN_FORCE_TX_GAIN		0x00000001
 #define AR_PHY_TX_FORCED_GAIN_FORCE_TX_GAIN_S		0
 #define AR_PHY_TX_FORCED_GAIN_FORCED_TXBB1DBGAIN	0x0000000e
@@ -607,42 +607,42 @@
 #define AR_PHY_TX_FORCED_GAIN_FORCED_ENABLE_PAL_S	24
 
 
-#define AR_PHY_PDADC_TAB_0       (AR_SM_BASE + 0x280)
+#define AR_PHY_PDADC_TAB_0(_ah)       (AR_SM_BASE(_ah) + 0x280)
 
-#define AR_PHY_TXGAIN_TABLE      (AR_SM_BASE + 0x300)
+#define AR_PHY_TXGAIN_TABLE(_ah)      (AR_SM_BASE(_ah) + 0x300)
 
-#define AR_PHY_TX_IQCAL_CONTROL_0(_ah)   (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
+#define AR_PHY_TX_IQCAL_CONTROL_0(_ah)   (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? \
 						 0x3c4 : 0x444))
-#define AR_PHY_TX_IQCAL_CONTROL_1(_ah)   (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
+#define AR_PHY_TX_IQCAL_CONTROL_1(_ah)   (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? \
 						 0x3c8 : 0x448))
-#define AR_PHY_TX_IQCAL_START(_ah)       (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
+#define AR_PHY_TX_IQCAL_START(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? \
 						 0x3c4 : 0x440))
-#define AR_PHY_TX_IQCAL_STATUS_B0(_ah)   (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
+#define AR_PHY_TX_IQCAL_STATUS_B0(_ah)   (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? \
 						 0x3f0 : 0x48c))
-#define AR_PHY_TX_IQCAL_CORR_COEFF_B0(_ah, _i)    (AR_SM_BASE + \
+#define AR_PHY_TX_IQCAL_CORR_COEFF_B0(_ah, _i)    (AR_SM_BASE(_ah) + \
 					     (AR_SREV_9485(_ah) ? \
 					      0x3d0 : 0x450) + ((_i) << 2))
-#define AR_PHY_RTT_CTRL			(AR_SM_BASE + 0x380)
+#define AR_PHY_RTT_CTRL(_ah)			(AR_SM_BASE(_ah) + 0x380)
 
-#define AR_PHY_WATCHDOG_STATUS      (AR_SM_BASE + 0x5c0)
-#define AR_PHY_WATCHDOG_CTL_1       (AR_SM_BASE + 0x5c4)
-#define AR_PHY_WATCHDOG_CTL_2       (AR_SM_BASE + 0x5c8)
-#define AR_PHY_WATCHDOG_CTL         (AR_SM_BASE + 0x5cc)
-#define AR_PHY_ONLY_WARMRESET       (AR_SM_BASE + 0x5d0)
-#define AR_PHY_ONLY_CTL             (AR_SM_BASE + 0x5d4)
-#define AR_PHY_ECO_CTRL             (AR_SM_BASE + 0x5dc)
+#define AR_PHY_WATCHDOG_STATUS(_ah)      (AR_SM_BASE(_ah) + 0x5c0)
+#define AR_PHY_WATCHDOG_CTL_1(_ah)       (AR_SM_BASE(_ah) + 0x5c4)
+#define AR_PHY_WATCHDOG_CTL_2(_ah)       (AR_SM_BASE(_ah) + 0x5c8)
+#define AR_PHY_WATCHDOG_CTL(_ah)         (AR_SM_BASE(_ah) + 0x5cc)
+#define AR_PHY_ONLY_WARMRESET(_ah)       (AR_SM_BASE(_ah) + 0x5d0)
+#define AR_PHY_ONLY_CTL(_ah)             (AR_SM_BASE(_ah) + 0x5d4)
+#define AR_PHY_ECO_CTRL(_ah)             (AR_SM_BASE(_ah) + 0x5dc)
 
-#define AR_PHY_BB_THERM_ADC_1				(AR_SM_BASE + 0x248)
+#define AR_PHY_BB_THERM_ADC_1(_ah)			(AR_SM_BASE(_ah) + 0x248)
 #define AR_PHY_BB_THERM_ADC_1_INIT_THERM		0x000000ff
 #define AR_PHY_BB_THERM_ADC_1_INIT_THERM_S		0
 
-#define AR_PHY_BB_THERM_ADC_3				(AR_SM_BASE + 0x250)
+#define AR_PHY_BB_THERM_ADC_3(_ah)			(AR_SM_BASE(_ah) + 0x250)
 #define AR_PHY_BB_THERM_ADC_3_THERM_ADC_SCALE_GAIN	0x0001ff00
 #define AR_PHY_BB_THERM_ADC_3_THERM_ADC_SCALE_GAIN_S	8
 #define AR_PHY_BB_THERM_ADC_3_THERM_ADC_OFFSET		0x000000ff
 #define AR_PHY_BB_THERM_ADC_3_THERM_ADC_OFFSET_S	0
 
-#define AR_PHY_BB_THERM_ADC_4				(AR_SM_BASE + 0x254)
+#define AR_PHY_BB_THERM_ADC_4(_ah)			(AR_SM_BASE(_ah) + 0x254)
 #define AR_PHY_BB_THERM_ADC_4_LATEST_THERM_VALUE	0x000000ff
 #define AR_PHY_BB_THERM_ADC_4_LATEST_THERM_VALUE_S	0
 #define AR_PHY_BB_THERM_ADC_4_LATEST_VOLT_VALUE		0x0000ff00
@@ -923,15 +923,15 @@
 /*
  * Channel 1 Register Map
  */
-#define AR_CHAN1_BASE	0xa800
+#define AR_CHAN1_BASE(_ah)	0xa800
 
-#define AR_PHY_EXT_CCA_1            (AR_CHAN1_BASE + 0x30)
-#define AR_PHY_TX_PHASE_RAMP_1      (AR_CHAN1_BASE + 0xd0)
-#define AR_PHY_ADC_GAIN_DC_CORR_1   (AR_CHAN1_BASE + 0xd4)
+#define AR_PHY_EXT_CCA_1(_ah)            (AR_CHAN1_BASE(_ah) + 0x30)
+#define AR_PHY_TX_PHASE_RAMP_1(_ah)      (AR_CHAN1_BASE(_ah) + 0xd0)
+#define AR_PHY_ADC_GAIN_DC_CORR_1(_ah)   (AR_CHAN1_BASE(_ah) + 0xd4)
 
-#define AR_PHY_SPUR_REPORT_1        (AR_CHAN1_BASE + 0xa8)
-#define AR_PHY_CHAN_INFO_TAB_1      (AR_CHAN1_BASE + 0x300)
-#define AR_PHY_RX_IQCAL_CORR_B1     (AR_CHAN1_BASE + 0xdc)
+#define AR_PHY_SPUR_REPORT_1(_ah)        (AR_CHAN1_BASE(_ah) + 0xa8)
+#define AR_PHY_CHAN_INFO_TAB_1(_ah)      (AR_CHAN1_BASE(_ah) + 0x300)
+#define AR_PHY_RX_IQCAL_CORR_B1(_ah)     (AR_CHAN1_BASE(_ah) + 0xdc)
 
 /*
  * Channel 1 Field Definitions
@@ -942,15 +942,15 @@
 /*
  * AGC 1 Register Map
  */
-#define AR_AGC1_BASE	0xae00
+#define AR_AGC1_BASE(_ah)	0xae00
 
-#define AR_PHY_FORCEMAX_GAINS_1      (AR_AGC1_BASE + 0x4)
-#define AR_PHY_EXT_ATTEN_CTL_1       (AR_AGC1_BASE + 0x18)
-#define AR_PHY_CCA_1                 (AR_AGC1_BASE + 0x1c)
-#define AR_PHY_CCA_CTRL_1            (AR_AGC1_BASE + 0x20)
-#define AR_PHY_RSSI_1                (AR_AGC1_BASE + 0x180)
-#define AR_PHY_SPUR_CCK_REP_1        (AR_AGC1_BASE + 0x184)
-#define AR_PHY_RX_OCGAIN_2           (AR_AGC1_BASE + 0x200)
+#define AR_PHY_FORCEMAX_GAINS_1(_ah)      (AR_AGC1_BASE(_ah) + 0x4)
+#define AR_PHY_EXT_ATTEN_CTL_1(_ah)       (AR_AGC1_BASE(_ah) + 0x18)
+#define AR_PHY_CCA_1(_ah)                 (AR_AGC1_BASE(_ah) + 0x1c)
+#define AR_PHY_CCA_CTRL_1(_ah)            (AR_AGC1_BASE(_ah) + 0x20)
+#define AR_PHY_RSSI_1(_ah)                (AR_AGC1_BASE(_ah) + 0x180)
+#define AR_PHY_SPUR_CCK_REP_1(_ah)        (AR_AGC1_BASE(_ah) + 0x184)
+#define AR_PHY_RX_OCGAIN_2(_ah)           (AR_AGC1_BASE(_ah) + 0x200)
 
 /*
  * AGC 1 Field Definitions
@@ -961,41 +961,41 @@
 /*
  * SM 1 Register Map
  */
-#define AR_SM1_BASE	0xb200
-
-#define AR_PHY_SWITCH_CHAIN_1   (AR_SM1_BASE + 0x84)
-#define AR_PHY_FCAL_2_1         (AR_SM1_BASE + 0xd0)
-#define AR_PHY_DFT_TONE_CTL_1   (AR_SM1_BASE + 0xd4)
-#define AR_PHY_CL_TAB_1         (AR_SM1_BASE + 0x100)
-#define AR_PHY_CHAN_INFO_GAIN_1 (AR_SM1_BASE + 0x180)
-#define AR_PHY_TPC_4_B1         (AR_SM1_BASE + 0x204)
-#define AR_PHY_TPC_5_B1         (AR_SM1_BASE + 0x208)
-#define AR_PHY_TPC_6_B1         (AR_SM1_BASE + 0x20c)
-#define AR_PHY_TPC_11_B1        (AR_SM1_BASE + 0x220)
-#define AR_PHY_PDADC_TAB_1(_ah)	(AR_SM1_BASE + (AR_SREV_9462_20_OR_LATER(_ah) ? \
+#define AR_SM1_BASE(_ah)	0xb200
+
+#define AR_PHY_SWITCH_CHAIN_1(_ah)   (AR_SM1_BASE(_ah) + 0x84)
+#define AR_PHY_FCAL_2_1(_ah)         (AR_SM1_BASE(_ah) + 0xd0)
+#define AR_PHY_DFT_TONE_CTL_1(_ah)   (AR_SM1_BASE(_ah) + 0xd4)
+#define AR_PHY_CL_TAB_1(_ah)         (AR_SM1_BASE(_ah) + 0x100)
+#define AR_PHY_CHAN_INFO_GAIN_1(_ah) (AR_SM1_BASE(_ah) + 0x180)
+#define AR_PHY_TPC_4_B1(_ah)         (AR_SM1_BASE(_ah) + 0x204)
+#define AR_PHY_TPC_5_B1(_ah)         (AR_SM1_BASE(_ah) + 0x208)
+#define AR_PHY_TPC_6_B1(_ah)         (AR_SM1_BASE(_ah) + 0x20c)
+#define AR_PHY_TPC_11_B1(_ah)        (AR_SM1_BASE(_ah) + 0x220)
+#define AR_PHY_PDADC_TAB_1(_ah)	(AR_SM1_BASE(_ah) + (AR_SREV_9462_20_OR_LATER(_ah) ? \
 					0x280 : 0x240))
-#define AR_PHY_TPC_19_B1	(AR_SM1_BASE + 0x240)
+#define AR_PHY_TPC_19_B1(_ah)	(AR_SM1_BASE(_ah) + 0x240)
 #define AR_PHY_TPC_19_B1_ALPHA_THERM		0xff
 #define AR_PHY_TPC_19_B1_ALPHA_THERM_S		0
-#define AR_PHY_TX_IQCAL_STATUS_B1   (AR_SM1_BASE + 0x48c)
-#define AR_PHY_TX_IQCAL_CORR_COEFF_B1(_i)    (AR_SM1_BASE + 0x450 + ((_i) << 2))
+#define AR_PHY_TX_IQCAL_STATUS_B1(_ah)   (AR_SM1_BASE(_ah) + 0x48c)
+#define AR_PHY_TX_IQCAL_CORR_COEFF_B1(_ah, _i)    (AR_SM1_BASE(_ah) + 0x450 + ((_i) << 2))
 
-#define AR_PHY_RTT_TABLE_SW_INTF_B(i)	(0x384 + ((i) ? \
-					AR_SM1_BASE : AR_SM_BASE))
-#define AR_PHY_RTT_TABLE_SW_INTF_1_B(i)	(0x388 + ((i) ? \
-					AR_SM1_BASE : AR_SM_BASE))
+#define AR_PHY_RTT_TABLE_SW_INTF_B(_ah, i)	(0x384 + ((i) ? \
+					AR_SM1_BASE(_ah) : AR_SM_BASE(_ah)))
+#define AR_PHY_RTT_TABLE_SW_INTF_1_B(_ah, i)	(0x388 + ((i) ? \
+					AR_SM1_BASE(_ah) : AR_SM_BASE(_ah)))
 /*
  * Channel 2 Register Map
  */
-#define AR_CHAN2_BASE	0xb800
+#define AR_CHAN2_BASE(_ah)	0xb800
 
-#define AR_PHY_EXT_CCA_2            (AR_CHAN2_BASE + 0x30)
-#define AR_PHY_TX_PHASE_RAMP_2      (AR_CHAN2_BASE + 0xd0)
-#define AR_PHY_ADC_GAIN_DC_CORR_2   (AR_CHAN2_BASE + 0xd4)
+#define AR_PHY_EXT_CCA_2(_ah)            (AR_CHAN2_BASE(_ah) + 0x30)
+#define AR_PHY_TX_PHASE_RAMP_2(_ah)      (AR_CHAN2_BASE(_ah) + 0xd0)
+#define AR_PHY_ADC_GAIN_DC_CORR_2(_ah)   (AR_CHAN2_BASE(_ah) + 0xd4)
 
-#define AR_PHY_SPUR_REPORT_2        (AR_CHAN2_BASE + 0xa8)
-#define AR_PHY_CHAN_INFO_TAB_2      (AR_CHAN2_BASE + 0x300)
-#define AR_PHY_RX_IQCAL_CORR_B2     (AR_CHAN2_BASE + 0xdc)
+#define AR_PHY_SPUR_REPORT_2(_ah)        (AR_CHAN2_BASE(_ah) + 0xa8)
+#define AR_PHY_CHAN_INFO_TAB_2(_ah)      (AR_CHAN2_BASE(_ah) + 0x300)
+#define AR_PHY_RX_IQCAL_CORR_B2(_ah)     (AR_CHAN2_BASE(_ah) + 0xdc)
 
 /*
  * Channel 2 Field Definitions
@@ -1005,13 +1005,13 @@
 /*
  * AGC 2 Register Map
  */
-#define AR_AGC2_BASE	0xbe00
+#define AR_AGC2_BASE(_ah)	0xbe00
 
-#define AR_PHY_FORCEMAX_GAINS_2      (AR_AGC2_BASE + 0x4)
-#define AR_PHY_EXT_ATTEN_CTL_2       (AR_AGC2_BASE + 0x18)
-#define AR_PHY_CCA_2                 (AR_AGC2_BASE + 0x1c)
-#define AR_PHY_CCA_CTRL_2            (AR_AGC2_BASE + 0x20)
-#define AR_PHY_RSSI_2                (AR_AGC2_BASE + 0x180)
+#define AR_PHY_FORCEMAX_GAINS_2(_ah)      (AR_AGC2_BASE(_ah) + 0x4)
+#define AR_PHY_EXT_ATTEN_CTL_2(_ah)       (AR_AGC2_BASE(_ah) + 0x18)
+#define AR_PHY_CCA_2(_ah)                 (AR_AGC2_BASE(_ah) + 0x1c)
+#define AR_PHY_CCA_CTRL_2(_ah)            (AR_AGC2_BASE(_ah) + 0x20)
+#define AR_PHY_RSSI_2(_ah)                (AR_AGC2_BASE(_ah) + 0x180)
 
 /*
  * AGC 2 Field Definitions
@@ -1022,20 +1022,20 @@
 /*
  * SM 2 Register Map
  */
-#define AR_SM2_BASE	0xc200
-
-#define AR_PHY_SWITCH_CHAIN_2    (AR_SM2_BASE + 0x84)
-#define AR_PHY_FCAL_2_2          (AR_SM2_BASE + 0xd0)
-#define AR_PHY_DFT_TONE_CTL_2    (AR_SM2_BASE + 0xd4)
-#define AR_PHY_CL_TAB_2          (AR_SM2_BASE + 0x100)
-#define AR_PHY_CHAN_INFO_GAIN_2  (AR_SM2_BASE + 0x180)
-#define AR_PHY_TPC_4_B2          (AR_SM2_BASE + 0x204)
-#define AR_PHY_TPC_5_B2          (AR_SM2_BASE + 0x208)
-#define AR_PHY_TPC_6_B2          (AR_SM2_BASE + 0x20c)
-#define AR_PHY_TPC_11_B2         (AR_SM2_BASE + 0x220)
-#define AR_PHY_TPC_19_B2         (AR_SM2_BASE + 0x240)
-#define AR_PHY_TX_IQCAL_STATUS_B2   (AR_SM2_BASE + 0x48c)
-#define AR_PHY_TX_IQCAL_CORR_COEFF_B2(_i)    (AR_SM2_BASE + 0x450 + ((_i) << 2))
+#define AR_SM2_BASE(_ah)	0xc200
+
+#define AR_PHY_SWITCH_CHAIN_2(_ah)    (AR_SM2_BASE(_ah) + 0x84)
+#define AR_PHY_FCAL_2_2(_ah)          (AR_SM2_BASE(_ah) + 0xd0)
+#define AR_PHY_DFT_TONE_CTL_2(_ah)    (AR_SM2_BASE(_ah) + 0xd4)
+#define AR_PHY_CL_TAB_2(_ah)          (AR_SM2_BASE(_ah) + 0x100)
+#define AR_PHY_CHAN_INFO_GAIN_2(_ah)  (AR_SM2_BASE(_ah) + 0x180)
+#define AR_PHY_TPC_4_B2(_ah)          (AR_SM2_BASE(_ah) + 0x204)
+#define AR_PHY_TPC_5_B2(_ah)          (AR_SM2_BASE(_ah) + 0x208)
+#define AR_PHY_TPC_6_B2(_ah)          (AR_SM2_BASE(_ah) + 0x20c)
+#define AR_PHY_TPC_11_B2(_ah)         (AR_SM2_BASE(_ah) + 0x220)
+#define AR_PHY_TPC_19_B2(_ah)         (AR_SM2_BASE(_ah) + 0x240)
+#define AR_PHY_TX_IQCAL_STATUS_B2(_ah)   (AR_SM2_BASE(_ah) + 0x48c)
+#define AR_PHY_TX_IQCAL_CORR_COEFF_B2(_ah, _i)    (AR_SM2_BASE(_ah) + 0x450 + ((_i) << 2))
 
 #define AR_PHY_TX_IQCAL_STATUS_B2_FAILED    0x00000001
 
@@ -1050,7 +1050,7 @@
 /*
  * Misc helper defines
  */
-#define AR_PHY_CHAIN_OFFSET     (AR_CHAN1_BASE - AR_CHAN_BASE)
+#define AR_PHY_CHAIN_OFFSET     0x1000
 
 #define AR_PHY_NEW_ADC_DC_GAIN_CORR(_i) (AR_PHY_ADC_GAIN_DC_CORR_0 + (AR_PHY_CHAIN_OFFSET * (_i)))
 #define AR_PHY_NEW_ADC_DC_GAIN_CORR_9300_10(_i) (AR_PHY_ADC_GAIN_DC_CORR_0_9300_10 + (AR_PHY_CHAIN_OFFSET * (_i)))
@@ -1061,10 +1061,10 @@
 #define AR_PHY_TPCRG5(_i)           (AR_PHY_TPC_5_B0 + (AR_PHY_CHAIN_OFFSET * (_i)))
 #define AR_PHY_PDADC_TAB(_i)        (AR_PHY_PDADC_TAB_0 + (AR_PHY_CHAIN_OFFSET * (_i)))
 
-#define AR_PHY_CAL_MEAS_0(_i)       (AR_PHY_IQ_ADC_MEAS_0_B0 + (AR_PHY_CHAIN_OFFSET * (_i)))
-#define AR_PHY_CAL_MEAS_1(_i)       (AR_PHY_IQ_ADC_MEAS_1_B0 + (AR_PHY_CHAIN_OFFSET * (_i)))
-#define AR_PHY_CAL_MEAS_2(_i)       (AR_PHY_IQ_ADC_MEAS_2_B0 + (AR_PHY_CHAIN_OFFSET * (_i)))
-#define AR_PHY_CAL_MEAS_3(_i)       (AR_PHY_IQ_ADC_MEAS_3_B0 + (AR_PHY_CHAIN_OFFSET * (_i)))
+#define AR_PHY_CAL_MEAS_0(_ah, _i)  (AR_PHY_IQ_ADC_MEAS_0_B0(_ah) + (AR_PHY_CHAIN_OFFSET * (_i)))
+#define AR_PHY_CAL_MEAS_1(_ah, _i)  (AR_PHY_IQ_ADC_MEAS_1_B0(_ah) + (AR_PHY_CHAIN_OFFSET * (_i)))
+#define AR_PHY_CAL_MEAS_2(_ah, _i)  (AR_PHY_IQ_ADC_MEAS_2_B0(_ah) + (AR_PHY_CHAIN_OFFSET * (_i)))
+#define AR_PHY_CAL_MEAS_3(_ah, _i)  (AR_PHY_IQ_ADC_MEAS_3_B0(_ah) + (AR_PHY_CHAIN_OFFSET * (_i)))
 #define AR_PHY_CAL_MEAS_0_9300_10(_i) (AR_PHY_IQ_ADC_MEAS_0_B0_9300_10 + (AR_PHY_CHAIN_OFFSET * (_i)))
 #define AR_PHY_CAL_MEAS_1_9300_10(_i) (AR_PHY_IQ_ADC_MEAS_1_B0_9300_10 + (AR_PHY_CHAIN_OFFSET * (_i)))
 #define AR_PHY_CAL_MEAS_2_9300_10(_i) (AR_PHY_IQ_ADC_MEAS_2_B0_9300_10 + (AR_PHY_CHAIN_OFFSET * (_i)))
@@ -1103,23 +1103,23 @@
 /*
  * PAPRD registers
  */
-#define AR_PHY_XPA_TIMING_CTL		(AR_SM_BASE + 0x64)
+#define AR_PHY_XPA_TIMING_CTL(_ah)	(AR_SM_BASE(_ah) + 0x64)
 
-#define AR_PHY_PAPRD_AM2AM		(AR_CHAN_BASE + 0xe4)
+#define AR_PHY_PAPRD_AM2AM(_ah)		(AR_CHAN_BASE(_ah) + 0xe4)
 #define AR_PHY_PAPRD_AM2AM_MASK		0x01ffffff
 #define AR_PHY_PAPRD_AM2AM_MASK_S	0
 
-#define AR_PHY_PAPRD_AM2PM		(AR_CHAN_BASE + 0xe8)
+#define AR_PHY_PAPRD_AM2PM(_ah)		(AR_CHAN_BASE(_ah) + 0xe8)
 #define AR_PHY_PAPRD_AM2PM_MASK		0x01ffffff
 #define AR_PHY_PAPRD_AM2PM_MASK_S	0
 
-#define AR_PHY_PAPRD_HT40		(AR_CHAN_BASE + 0xec)
+#define AR_PHY_PAPRD_HT40(_ah)		(AR_CHAN_BASE(_ah) + 0xec)
 #define AR_PHY_PAPRD_HT40_MASK		0x01ffffff
 #define AR_PHY_PAPRD_HT40_MASK_S	0
 
-#define AR_PHY_PAPRD_CTRL0_B0				(AR_CHAN_BASE + 0xf0)
-#define AR_PHY_PAPRD_CTRL0_B1				(AR_CHAN1_BASE + 0xf0)
-#define AR_PHY_PAPRD_CTRL0_B2				(AR_CHAN2_BASE + 0xf0)
+#define AR_PHY_PAPRD_CTRL0_B0(_ah)			(AR_CHAN_BASE(_ah) + 0xf0)
+#define AR_PHY_PAPRD_CTRL0_B1(_ah)			(AR_CHAN1_BASE(_ah) + 0xf0)
+#define AR_PHY_PAPRD_CTRL0_B2(_ah)			(AR_CHAN2_BASE(_ah) + 0xf0)
 #define AR_PHY_PAPRD_CTRL0_PAPRD_ENABLE			0x00000001
 #define AR_PHY_PAPRD_CTRL0_PAPRD_ENABLE_S		0
 #define AR_PHY_PAPRD_CTRL0_USE_SINGLE_TABLE_MASK	0x00000002
@@ -1127,9 +1127,9 @@
 #define AR_PHY_PAPRD_CTRL0_PAPRD_MAG_THRSH		0xf8000000
 #define AR_PHY_PAPRD_CTRL0_PAPRD_MAG_THRSH_S		27
 
-#define AR_PHY_PAPRD_CTRL1_B0				(AR_CHAN_BASE + 0xf4)
-#define AR_PHY_PAPRD_CTRL1_B1				(AR_CHAN1_BASE + 0xf4)
-#define AR_PHY_PAPRD_CTRL1_B2				(AR_CHAN2_BASE + 0xf4)
+#define AR_PHY_PAPRD_CTRL1_B0(_ah)			(AR_CHAN_BASE(_ah) + 0xf4)
+#define AR_PHY_PAPRD_CTRL1_B1(_ah)			(AR_CHAN1_BASE(_ah) + 0xf4)
+#define AR_PHY_PAPRD_CTRL1_B2(_ah)			(AR_CHAN2_BASE(_ah) + 0xf4)
 #define AR_PHY_PAPRD_CTRL1_ADAPTIVE_SCALING_ENA		0x00000001
 #define AR_PHY_PAPRD_CTRL1_ADAPTIVE_SCALING_ENA_S	0
 #define AR_PHY_PAPRD_CTRL1_ADAPTIVE_AM2AM_ENABLE	0x00000002
@@ -1143,7 +1143,7 @@
 #define AR_PHY_PAPRD_CTRL1_PAPRD_MAG_SCALE_FACT		0x0ffe0000
 #define AR_PHY_PAPRD_CTRL1_PAPRD_MAG_SCALE_FACT_S	17
 
-#define AR_PHY_PAPRD_TRAINER_CNTL1(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x580 : 0x490))
+#define AR_PHY_PAPRD_TRAINER_CNTL1(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x580 : 0x490))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_CF_PAPRD_TRAIN_ENABLE	0x00000001
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_CF_PAPRD_TRAIN_ENABLE_S	0
@@ -1160,12 +1160,12 @@
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_LB_SKIP		0x0003f000
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_LB_SKIP_S		12
 
-#define AR_PHY_PAPRD_TRAINER_CNTL2(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x584 : 0x494))
+#define AR_PHY_PAPRD_TRAINER_CNTL2(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x584 : 0x494))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL2_CF_PAPRD_INIT_RX_BB_GAIN	0xFFFFFFFF
 #define AR_PHY_PAPRD_TRAINER_CNTL2_CF_PAPRD_INIT_RX_BB_GAIN_S	0
 
-#define AR_PHY_PAPRD_TRAINER_CNTL3(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x588 : 0x498))
+#define AR_PHY_PAPRD_TRAINER_CNTL3(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x588 : 0x498))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_ADC_DESIRED_SIZE	0x0000003f
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_ADC_DESIRED_SIZE_S	0
@@ -1182,7 +1182,7 @@
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_BBTXMIX_DISABLE	0x20000000
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_BBTXMIX_DISABLE_S	29
 
-#define AR_PHY_PAPRD_TRAINER_CNTL4(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x58c : 0x49c))
+#define AR_PHY_PAPRD_TRAINER_CNTL4(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x58c : 0x49c))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_NUM_TRAIN_SAMPLES	0x03ff0000
 #define AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_NUM_TRAIN_SAMPLES_S	16
@@ -1191,18 +1191,18 @@
 #define AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_MIN_CORR		0x00000fff
 #define AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_MIN_CORR_S		0
 
-#define AR_PHY_PAPRD_PRE_POST_SCALE_0_B0			(AR_CHAN_BASE + 0x100)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_1_B0			(AR_CHAN_BASE + 0x104)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_2_B0			(AR_CHAN_BASE + 0x108)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_3_B0			(AR_CHAN_BASE + 0x10c)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_4_B0			(AR_CHAN_BASE + 0x110)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_5_B0			(AR_CHAN_BASE + 0x114)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_6_B0			(AR_CHAN_BASE + 0x118)
-#define AR_PHY_PAPRD_PRE_POST_SCALE_7_B0			(AR_CHAN_BASE + 0x11c)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_0_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x100)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_1_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x104)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_2_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x108)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_3_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x10c)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_4_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x110)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_5_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x114)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_6_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x118)
+#define AR_PHY_PAPRD_PRE_POST_SCALE_7_B0(_ah)			(AR_CHAN_BASE(_ah) + 0x11c)
 #define AR_PHY_PAPRD_PRE_POST_SCALING				0x3FFFF
 #define AR_PHY_PAPRD_PRE_POST_SCALING_S				0
 
-#define AR_PHY_PAPRD_TRAINER_STAT1(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x590 : 0x4a0))
+#define AR_PHY_PAPRD_TRAINER_STAT1(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x590 : 0x4a0))
 
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE		0x00000001
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE_S		0
@@ -1217,7 +1217,7 @@
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_AGC2_PWR		0x0001fe00
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_AGC2_PWR_S		9
 
-#define AR_PHY_PAPRD_TRAINER_STAT2(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x594 : 0x4a4))
+#define AR_PHY_PAPRD_TRAINER_STAT2(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x594 : 0x4a4))
 
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_VAL		0x0000ffff
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_VAL_S		0
@@ -1226,30 +1226,30 @@
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_IDX		0x00600000
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_IDX_S		21
 
-#define AR_PHY_PAPRD_TRAINER_STAT3(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x598 : 0x4a8))
+#define AR_PHY_PAPRD_TRAINER_STAT3(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9485(_ah) ? 0x598 : 0x4a8))
 
 #define AR_PHY_PAPRD_TRAINER_STAT3_PAPRD_TRAIN_SAMPLES_CNT	0x000fffff
 #define AR_PHY_PAPRD_TRAINER_STAT3_PAPRD_TRAIN_SAMPLES_CNT_S	0
 
-#define AR_PHY_PAPRD_MEM_TAB_B0			(AR_CHAN_BASE + 0x120)
-#define AR_PHY_PAPRD_MEM_TAB_B1			(AR_CHAN1_BASE + 0x120)
-#define AR_PHY_PAPRD_MEM_TAB_B2			(AR_CHAN2_BASE + 0x120)
+#define AR_PHY_PAPRD_MEM_TAB_B0(_ah)		(AR_CHAN_BASE(_ah) + 0x120)
+#define AR_PHY_PAPRD_MEM_TAB_B1(_ah)		(AR_CHAN1_BASE(_ah) + 0x120)
+#define AR_PHY_PAPRD_MEM_TAB_B2(_ah)		(AR_CHAN2_BASE(_ah) + 0x120)
 
-#define AR_PHY_PA_GAIN123_B0			(AR_CHAN_BASE + 0xf8)
-#define AR_PHY_PA_GAIN123_B1			(AR_CHAN1_BASE + 0xf8)
-#define AR_PHY_PA_GAIN123_B2			(AR_CHAN2_BASE + 0xf8)
+#define AR_PHY_PA_GAIN123_B0(_ah)		(AR_CHAN_BASE(_ah) + 0xf8)
+#define AR_PHY_PA_GAIN123_B1(_ah)		(AR_CHAN1_BASE(_ah) + 0xf8)
+#define AR_PHY_PA_GAIN123_B2(_ah)		(AR_CHAN2_BASE(_ah) + 0xf8)
 #define AR_PHY_PA_GAIN123_PA_GAIN1		0x3FF
 #define AR_PHY_PA_GAIN123_PA_GAIN1_S		0
 
-#define AR_PHY_POWERTX_RATE5			(AR_SM_BASE + 0x1d0)
+#define AR_PHY_POWERTX_RATE5(_ah)		(AR_SM_BASE(_ah) + 0x1d0)
 #define AR_PHY_POWERTX_RATE5_POWERTXHT20_0	0x3F
 #define AR_PHY_POWERTX_RATE5_POWERTXHT20_0_S	0
 
-#define AR_PHY_POWERTX_RATE6			(AR_SM_BASE + 0x1d4)
+#define AR_PHY_POWERTX_RATE6(_ah)		(AR_SM_BASE(_ah) + 0x1d4)
 #define AR_PHY_POWERTX_RATE6_POWERTXHT20_5	0x3F00
 #define AR_PHY_POWERTX_RATE6_POWERTXHT20_5_S	8
 
-#define AR_PHY_POWERTX_RATE8			(AR_SM_BASE + 0x1dc)
+#define AR_PHY_POWERTX_RATE8(_ah)		(AR_SM_BASE(_ah) + 0x1dc)
 #define AR_PHY_POWERTX_RATE8_POWERTXHT40_5	0x3F00
 #define AR_PHY_POWERTX_RATE8_POWERTXHT40_5_S	8
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_rtt.c b/drivers/net/wireless/ath/ath9k/ar9003_rtt.c
index e4d11fa7fe..99b1ef2aaa 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_rtt.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_rtt.c
@@ -37,31 +37,31 @@
 
 void ar9003_hw_rtt_enable(struct ath_hw *ah)
 {
-	REG_WRITE(ah, AR_PHY_RTT_CTRL, 1);
+	REG_WRITE(ah, AR_PHY_RTT_CTRL(ah), 1);
 }
 
 void ar9003_hw_rtt_disable(struct ath_hw *ah)
 {
-	REG_WRITE(ah, AR_PHY_RTT_CTRL, 0);
+	REG_WRITE(ah, AR_PHY_RTT_CTRL(ah), 0);
 }
 
 void ar9003_hw_rtt_set_mask(struct ath_hw *ah, u32 rtt_mask)
 {
-	REG_RMW_FIELD(ah, AR_PHY_RTT_CTRL,
+	REG_RMW_FIELD(ah, AR_PHY_RTT_CTRL(ah),
 		      AR_PHY_RTT_CTRL_RESTORE_MASK, rtt_mask);
 }
 
 bool ar9003_hw_rtt_force_restore(struct ath_hw *ah)
 {
-	if (!ath9k_hw_wait(ah, AR_PHY_RTT_CTRL,
+	if (!ath9k_hw_wait(ah, AR_PHY_RTT_CTRL(ah),
 			   AR_PHY_RTT_CTRL_FORCE_RADIO_RESTORE,
 			   0, RTT_RESTORE_TIMEOUT))
 		return false;
 
-	REG_RMW_FIELD(ah, AR_PHY_RTT_CTRL,
+	REG_RMW_FIELD(ah, AR_PHY_RTT_CTRL(ah),
 		      AR_PHY_RTT_CTRL_FORCE_RADIO_RESTORE, 1);
 
-	if (!ath9k_hw_wait(ah, AR_PHY_RTT_CTRL,
+	if (!ath9k_hw_wait(ah, AR_PHY_RTT_CTRL(ah),
 			   AR_PHY_RTT_CTRL_FORCE_RADIO_RESTORE,
 			   0, RTT_RESTORE_TIMEOUT))
 		return false;
@@ -75,28 +75,28 @@ static void ar9003_hw_rtt_load_hist_entry(struct ath_hw *ah, u8 chain,
 	u32 val;
 
 	val = SM(data28, AR_PHY_RTT_SW_RTT_TABLE_DATA);
-	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_1_B(chain), val);
+	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_1_B(ah, chain), val);
 
 	val = SM(0, AR_PHY_RTT_SW_RTT_TABLE_ACCESS) |
 	      SM(1, AR_PHY_RTT_SW_RTT_TABLE_WRITE) |
 	      SM(index, AR_PHY_RTT_SW_RTT_TABLE_ADDR);
-	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain), val);
+	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain), val);
 	udelay(1);
 
 	val |= SM(1, AR_PHY_RTT_SW_RTT_TABLE_ACCESS);
-	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain), val);
+	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain), val);
 	udelay(1);
 
-	if (!ath9k_hw_wait(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain),
+	if (!ath9k_hw_wait(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain),
 			   AR_PHY_RTT_SW_RTT_TABLE_ACCESS, 0,
 			   RTT_ACCESS_TIMEOUT))
 		return;
 
 	val &= ~SM(1, AR_PHY_RTT_SW_RTT_TABLE_WRITE);
-	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain), val);
+	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain), val);
 	udelay(1);
 
-	ath9k_hw_wait(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain),
+	ath9k_hw_wait(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain),
 		      AR_PHY_RTT_SW_RTT_TABLE_ACCESS, 0,
 		      RTT_ACCESS_TIMEOUT);
 }
@@ -147,19 +147,19 @@ static int ar9003_hw_rtt_fill_hist_entry(struct ath_hw *ah, u8 chain, u32 index)
 	      SM(0, AR_PHY_RTT_SW_RTT_TABLE_WRITE) |
 	      SM(index, AR_PHY_RTT_SW_RTT_TABLE_ADDR);
 
-	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain), val);
+	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain), val);
 	udelay(1);
 
 	val |= SM(1, AR_PHY_RTT_SW_RTT_TABLE_ACCESS);
-	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain), val);
+	REG_WRITE(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain), val);
 	udelay(1);
 
-	if (!ath9k_hw_wait(ah, AR_PHY_RTT_TABLE_SW_INTF_B(chain),
+	if (!ath9k_hw_wait(ah, AR_PHY_RTT_TABLE_SW_INTF_B(ah, chain),
 			   AR_PHY_RTT_SW_RTT_TABLE_ACCESS, 0,
 			   RTT_ACCESS_TIMEOUT))
 		return RTT_BAD_VALUE;
 
-	val = MS(REG_READ(ah, AR_PHY_RTT_TABLE_SW_INTF_1_B(chain)),
+	val = MS(REG_READ(ah, AR_PHY_RTT_TABLE_SW_INTF_1_B(ah, chain)),
 		 AR_PHY_RTT_SW_RTT_TABLE_DATA);
 
 
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 9f5b8a5380..2e65105d30 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -2111,10 +2111,10 @@ enum {
 						     * pcu_txsm.
 						     */
 
-#define AR9300_SM_BASE				0xa200
+#define AR9300_SM_BASE(_ah)			0xa200
 #define AR9002_PHY_AGC_CONTROL			0x9860
-#define AR9003_PHY_AGC_CONTROL			AR9300_SM_BASE + 0xc4
-#define AR_PHY_AGC_CONTROL(_ah)			(AR_SREV_9300_20_OR_LATER(_ah) ? AR9003_PHY_AGC_CONTROL : AR9002_PHY_AGC_CONTROL)
+#define AR9003_PHY_AGC_CONTROL(_ah)		(AR9300_SM_BASE(_ah) + 0xc4)
+#define AR_PHY_AGC_CONTROL(_ah)			(AR_SREV_9300_20_OR_LATER(_ah) ? AR9003_PHY_AGC_CONTROL(_ah) : AR9002_PHY_AGC_CONTROL)
 #define AR_PHY_AGC_CONTROL_CAL			0x00000001  /* do internal calibration */
 #define AR_PHY_AGC_CONTROL_NF			0x00000002  /* do noise-floor calibration */
 #define AR_PHY_AGC_CONTROL_OFFSET_CAL		0x00000800  /* allow offset calibration */
diff --git a/drivers/net/wireless/ath/ath9k/reg_aic.h b/drivers/net/wireless/ath/ath9k/reg_aic.h
index f50994910e..ab69460314 100644
--- a/drivers/net/wireless/ath/ath9k/reg_aic.h
+++ b/drivers/net/wireless/ath/ath9k/reg_aic.h
@@ -17,32 +17,32 @@
 #ifndef REG_AIC_H
 #define REG_AIC_H
 
-#define AR_PHY_AIC_CTRL_0_B0                    (AR_SM_BASE + 0x4b0)
-#define AR_PHY_AIC_CTRL_1_B0                    (AR_SM_BASE + 0x4b4)
-#define AR_PHY_AIC_CTRL_2_B0                    (AR_SM_BASE + 0x4b8)
-#define AR_PHY_AIC_CTRL_3_B0                    (AR_SM_BASE + 0x4bc)
-#define AR_PHY_AIC_CTRL_4_B0                    (AR_SM_BASE + 0x4c0)
+#define AR_PHY_AIC_CTRL_0_B0(_ah)               (AR_SM_BASE(_ah) + 0x4b0)
+#define AR_PHY_AIC_CTRL_1_B0(_ah)               (AR_SM_BASE(_ah) + 0x4b4)
+#define AR_PHY_AIC_CTRL_2_B0(_ah)               (AR_SM_BASE(_ah) + 0x4b8)
+#define AR_PHY_AIC_CTRL_3_B0(_ah)               (AR_SM_BASE(_ah) + 0x4bc)
+#define AR_PHY_AIC_CTRL_4_B0(_ah)               (AR_SM_BASE(_ah) + 0x4c0)
 
-#define AR_PHY_AIC_STAT_0_B0                    (AR_SM_BASE + 0x4c4)
-#define AR_PHY_AIC_STAT_1_B0                    (AR_SM_BASE + 0x4c8)
-#define AR_PHY_AIC_STAT_2_B0                    (AR_SM_BASE + 0x4cc)
+#define AR_PHY_AIC_STAT_0_B0(_ah)               (AR_SM_BASE(_ah) + 0x4c4)
+#define AR_PHY_AIC_STAT_1_B0(_ah)               (AR_SM_BASE(_ah) + 0x4c8)
+#define AR_PHY_AIC_STAT_2_B0(_ah)               (AR_SM_BASE(_ah) + 0x4cc)
 
-#define AR_PHY_AIC_CTRL_0_B1                    (AR_SM1_BASE + 0x4b0)
-#define AR_PHY_AIC_CTRL_1_B1                    (AR_SM1_BASE + 0x4b4)
-#define AR_PHY_AIC_CTRL_4_B1                    (AR_SM1_BASE + 0x4c0)
+#define AR_PHY_AIC_CTRL_0_B1(_ah)               (AR_SM1_BASE(_ah) + 0x4b0)
+#define AR_PHY_AIC_CTRL_1_B1(_ah)               (AR_SM1_BASE(_ah) + 0x4b4)
+#define AR_PHY_AIC_CTRL_4_B1(_ah)               (AR_SM1_BASE(_ah) + 0x4c0)
 
-#define AR_PHY_AIC_STAT_0_B1                    (AR_SM1_BASE + 0x4c4)
-#define AR_PHY_AIC_STAT_1_B1                    (AR_SM1_BASE + 0x4c8)
-#define AR_PHY_AIC_STAT_2_B1                    (AR_SM1_BASE + 0x4cc)
+#define AR_PHY_AIC_STAT_0_B1(_ah)               (AR_SM1_BASE(_ah) + 0x4c4)
+#define AR_PHY_AIC_STAT_1_B1(_ah)               (AR_SM1_BASE(_ah) + 0x4c8)
+#define AR_PHY_AIC_STAT_2_B1(_ah)               (AR_SM1_BASE(_ah) + 0x4cc)
 
-#define AR_PHY_AIC_SRAM_ADDR_B0                 (AR_SM_BASE + 0x5f0)
-#define AR_PHY_AIC_SRAM_DATA_B0                 (AR_SM_BASE + 0x5f4)
+#define AR_PHY_AIC_SRAM_ADDR_B0(_ah)            (AR_SM_BASE(_ah) + 0x5f0)
+#define AR_PHY_AIC_SRAM_DATA_B0(_ah)            (AR_SM_BASE(_ah) + 0x5f4)
 
-#define AR_PHY_AIC_SRAM_ADDR_B1                 (AR_SM1_BASE + 0x5f0)
-#define AR_PHY_AIC_SRAM_DATA_B1                 (AR_SM1_BASE + 0x5f4)
+#define AR_PHY_AIC_SRAM_ADDR_B1(_ah)            (AR_SM1_BASE(_ah) + 0x5f0)
+#define AR_PHY_AIC_SRAM_DATA_B1(_ah)            (AR_SM1_BASE(_ah) + 0x5f4)
 
-#define AR_PHY_BT_COEX_4                        (AR_AGC_BASE + 0x60)
-#define AR_PHY_BT_COEX_5                        (AR_AGC_BASE + 0x64)
+#define AR_PHY_BT_COEX_4(_ah)                   (AR_AGC_BASE(_ah) + 0x60)
+#define AR_PHY_BT_COEX_5(_ah)                   (AR_AGC_BASE(_ah) + 0x64)
 
 /* AIC fields */
 #define AR_PHY_AIC_MON_ENABLE                   0x80000000
diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index e1def77591..42b313c230 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -34,8 +34,8 @@ static int ath9k_rng_data_read(struct ath_softc *sc, u32 *buf, u32 buf_size)
 	REG_RMW_FIELD(ah, AR_PHY_TEST_CTL_STATUS(ah), AR_PHY_TEST_CTL_RX_OBS_SEL, 0);
 
 	for (i = 0, j = 0; i < buf_size; i++) {
-		v1 = REG_READ(ah, AR_PHY_TST_ADC) & 0xffff;
-		v2 = REG_READ(ah, AR_PHY_TST_ADC) & 0xffff;
+		v1 = REG_READ(ah, AR_PHY_TST_ADC(ah)) & 0xffff;
+		v2 = REG_READ(ah, AR_PHY_TST_ADC(ah)) & 0xffff;
 
 		/* wait for data ready */
 		if (v1 && v2 && rng_last != v1 && v1 != v2 && v1 != 0xffff &&
-- 
2.34.1

