Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013A4DD31C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiCRCew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiCRCen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183E19ABC4
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XCp54017643, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XCp54017643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 10:33:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 04/11] rtw89: regd: update mapping table to R59-R32
Date:   Fri, 18 Mar 2022 10:32:07 +0800
Message-ID: <20220318023214.32411-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318023214.32411-1-pkshih@realtek.com>
References: <20220318023214.32411-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Update notes:
Configure rtw89_regulatory for 6G band according to country.
Adjust country GB to use RTW89_UK entry on all bands.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 476 +++++++++++-----------
 1 file changed, 238 insertions(+), 238 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 4d4bc201485b4..20c7afd3e70fe 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -14,244 +14,244 @@ static const struct rtw89_regulatory rtw89_ww_regd =
 	COUNTRY_REGD("00", RTW89_WW, RTW89_WW);
 
 static const struct rtw89_regulatory rtw89_regd_map[] = {
-	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO),
-	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("CL", RTW89_CHILE, RTW89_CHILE),
-	COUNTRY_REGD("CO", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("CR", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("EC", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("SV", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("GT", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("HN", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("MX", RTW89_MEXICO, RTW89_MEXICO),
-	COUNTRY_REGD("NI", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("PA", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("PY", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("PE", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("US", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("UY", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("VE", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("PR", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("DO", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("AT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CY", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("DK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("EE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("FI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("FR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("DE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("HU", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IS", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LV", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LU", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MC", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NL", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PL", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ES", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GB", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AL", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("HR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("EG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IQ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IL", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("JO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KW", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LB", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LS", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("OM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("QA", RTW89_QATAR, RTW89_QATAR),
-	COUNTRY_REGD("RO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("RU", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("RS", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ME", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ZA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("UA", RTW89_UKRAINE, RTW89_UKRAINE),
-	COUNTRY_REGD("AE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("YE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ZW", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BD", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CN", RTW89_CN, RTW89_CN),
-	COUNTRY_REGD("HK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ID", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KR", RTW89_KCC, RTW89_KCC),
-	COUNTRY_REGD("MY", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("NZ", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("PG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CA", RTW89_IC, RTW89_IC),
-	COUNTRY_REGD("JP", RTW89_MKK, RTW89_MKK),
-	COUNTRY_REGD("JM", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("AN", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("TT", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("TN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("DZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AS", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("AD", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AQ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AG", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("AM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("AW", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BS", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BB", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BY", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BZ", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BJ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BM", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BW", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BV", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("VG", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("BN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("BI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CV", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KY", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("CF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TD", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CX", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("CC", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CD", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("DJ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("DM", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("GQ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ER", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ET", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("FK", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("FO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("FJ", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("GF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("GG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GW", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GY", RTW89_NCC, RTW89_NCC),
-	COUNTRY_REGD("HT", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("HM", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("VA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("JE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KI", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LA", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LY", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MW", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MV", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ML", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MH", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("MQ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MU", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("YT", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("MD", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MN", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MS", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NP", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NC", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("NU", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("NF", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("MP", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("PW", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("RE", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("RW", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("KN", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("LC", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("MF", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("SX", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("PM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("VC", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("WS", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("SM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ST", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("SC", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("SL", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SB", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GS", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SR", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("SJ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("SZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TJ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TK", RTW89_ACMA, RTW89_ACMA),
-	COUNTRY_REGD("TO", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TC", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TV", RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("UG", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("VI", RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("UZ", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("VU", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("WF", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("EH", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("ZM", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("IR", RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PS", RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO, RTW89_NA),
+	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("CL", RTW89_CHILE, RTW89_CHILE, RTW89_CHILE),
+	COUNTRY_REGD("CO", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("CR", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("EC", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("SV", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GT", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("HN", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("MX", RTW89_MEXICO, RTW89_MEXICO, RTW89_NA),
+	COUNTRY_REGD("NI", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("PA", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("PY", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("PE", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("US", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("UY", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("VE", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("PR", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("DO", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("AT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("BE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("CY", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("CZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("DK", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("EE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("FI", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("FR", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("DE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("GR", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("HU", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("IS", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("IE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("IT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("LV", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("LI", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("LT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("LU", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("MT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("MC", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("NL", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("NO", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("PL", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("PT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("SK", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("SI", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("ES", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("SE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("CH", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("GB", RTW89_UK, RTW89_UK, RTW89_UK),
+	COUNTRY_REGD("AL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("HR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("EG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("IQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("IL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("JO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LB", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("OM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("QA", RTW89_QATAR, RTW89_QATAR, RTW89_QATAR),
+	COUNTRY_REGD("RO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("RU", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("RS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ME", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ZA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("UA", RTW89_UKRAINE, RTW89_UKRAINE, RTW89_UKRAINE),
+	COUNTRY_REGD("AE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("YE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ZW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CN", RTW89_CN, RTW89_CN, RTW89_CN),
+	COUNTRY_REGD("HK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("IN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ID", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KR", RTW89_KCC, RTW89_KCC, RTW89_KCC),
+	COUNTRY_REGD("MY", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("PK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("PH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("NZ", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("PG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CA", RTW89_IC, RTW89_IC, RTW89_IC),
+	COUNTRY_REGD("JP", RTW89_MKK, RTW89_MKK, RTW89_NA),
+	COUNTRY_REGD("JM", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("AN", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("TT", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("TN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("DZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AS", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("AD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AG", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("AM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("AW", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BS", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BB", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BY", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BZ", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BJ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BM", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BT", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BV", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("IO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("VG", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("BN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CV", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KY", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("CF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CX", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("CC", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("DJ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("DM", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ER", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ET", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("FK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("FO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("FJ", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("PF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GY", RTW89_NCC, RTW89_NCC, RTW89_NA),
+	COUNTRY_REGD("HT", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("HM", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("VA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("IM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("JE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LY", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MV", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ML", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MH", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("MQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MU", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("YT", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("MD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NP", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NC", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NU", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("NF", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("MP", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("PW", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("RE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("RW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KN", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("LC", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("MF", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("SX", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("PM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("VC", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("WS", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("SM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ST", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("SC", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("SL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SB", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SR", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("SJ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TJ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TK", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
+	COUNTRY_REGD("TO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TC", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TV", RTW89_ETSI, RTW89_NA, RTW89_NA),
+	COUNTRY_REGD("UG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("VI", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("UZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("VU", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("WF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("EH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ZM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("IR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("PS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 };
 
 static const struct rtw89_regulatory *rtw89_regd_find_reg_by_name(char *alpha2)
-- 
2.25.1

