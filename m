Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A412342636D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 05:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhJHD7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 23:59:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43569 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbhJHD7k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 23:59:40 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1983vfwjF006507, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1983vfwjF006507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Oct 2021 11:57:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 8 Oct 2021 11:57:41 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 8 Oct 2021
 11:57:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v7 12/24] rtw89: add regulatory support
Date:   Fri, 8 Oct 2021 11:56:15 +0800
Message-ID: <20211008035627.19463-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008035627.19463-1-pkshih@realtek.com>
References: <20211008035627.19463-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/08/2021 03:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzcgpFWkyCAxMToyMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/08/2021 03:43:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166592 [Oct 07 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/08/2021 03:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Interact with regulatory hints by below rules:
For a non-PGed chip, I assume that it is world-roaming, so accepts every
notifications except the following condition.
For a non-PGed chip and the current domain is set by userspace, the
country ie notification will be disabled. The reason is that the current
setting might come from the system of a distro, and I assume that they
do not expect the domain will be changed by connecting to an AP.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 353 ++++++++++++++++++++++
 1 file changed, 353 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/regd.c

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
new file mode 100644
index 000000000000..f00b94ecfff4
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "ps.h"
+
+#define COUNTRY_REGD(_alpha2, _txpwr_regd_2g, _txpwr_regd_5g) \
+	{.alpha2 = (_alpha2), \
+	 .txpwr_regd[RTW89_BAND_2G] = (_txpwr_regd_2g), \
+	 .txpwr_regd[RTW89_BAND_5G] = (_txpwr_regd_5g) \
+	}
+
+static const struct rtw89_regulatory rtw89_ww_regd =
+	COUNTRY_REGD("00", RTW89_WW, RTW89_WW);
+
+static const struct rtw89_regulatory rtw89_regd_map[] = {
+	COUNTRY_REGD("AR", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BO", RTW89_WW, RTW89_FCC),
+	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("CL", RTW89_WW, RTW89_CHILE),
+	COUNTRY_REGD("CO", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("CR", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("EC", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SV", RTW89_WW, RTW89_FCC),
+	COUNTRY_REGD("GT", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("HN", RTW89_WW, RTW89_FCC),
+	COUNTRY_REGD("MX", RTW89_FCC, RTW89_MEXICO),
+	COUNTRY_REGD("NI", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("PA", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("PY", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("PE", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("US", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("UY", RTW89_WW, RTW89_FCC),
+	COUNTRY_REGD("VE", RTW89_WW, RTW89_FCC),
+	COUNTRY_REGD("PR", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("DO", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("AT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CY", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("DK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("EE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("FI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("FR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("DE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("HU", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IS", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LV", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LU", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MC", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NL", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("PL", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("PT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ES", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GB", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AL", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("HR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("EG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IQ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IL", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("JO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KW", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LB", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LS", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("OM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("QA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("RO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("RU", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("RS", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ME", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ZA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("UA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("YE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ZW", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BD", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("HK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ID", RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("KR", RTW89_KCC, RTW89_KCC),
+	COUNTRY_REGD("MY", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("PK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("PH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("TH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("VN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AU", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("NZ", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("PG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CA", RTW89_IC, RTW89_IC),
+	COUNTRY_REGD("JP", RTW89_MKK, RTW89_MKK),
+	COUNTRY_REGD("JM", RTW89_WW, RTW89_FCC),
+	COUNTRY_REGD("AN", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("TT", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("TN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AF", RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("DZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AS", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("AD", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AQ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AG", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("AM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("AW", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BS", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BB", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BY", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BZ", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BJ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BM", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BW", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BV", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("VG", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BF", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("BI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CV", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KY", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("CF", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TD", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CX", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("CC", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CD", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("CI", RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("DJ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("DM", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("GQ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ER", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ET", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("FK", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("FO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("FJ", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("GF", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("PF", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TF", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GL", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("GP", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("GG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GW", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GY", RTW89_FCC, RTW89_NCC),
+	COUNTRY_REGD("HT", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("HM", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("VA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("JE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KI", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LA", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("LY", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MW", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MV", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ML", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MH", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("MQ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MU", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("YT", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("MD", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MN", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("MS", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NR", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NP", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NC", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("NU", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("NF", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("MP", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("PW", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("RE", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("RW", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("KN", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("LC", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("MF", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SX", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("PM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("VC", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("WS", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ST", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SC", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SL", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SB", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("GS", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SR", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SJ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("SZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TJ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TK", RTW89_WW, RTW89_ACMA),
+	COUNTRY_REGD("TO", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TC", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("TV", RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("UG", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("VI", RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("UZ", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("VU", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("WF", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("EH", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("ZM", RTW89_WW, RTW89_ETSI),
+	COUNTRY_REGD("IR", RTW89_WW, RTW89_ETSI),
+};
+
+static const struct rtw89_regulatory *rtw89_regd_find_reg_by_name(char *alpha2)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(rtw89_regd_map); i++) {
+		if (!memcmp(rtw89_regd_map[i].alpha2, alpha2, 2))
+			return &rtw89_regd_map[i];
+	}
+
+	return &rtw89_ww_regd;
+}
+
+static bool rtw89_regd_is_ww(const struct rtw89_regulatory *regd)
+{
+	return regd == &rtw89_ww_regd;
+}
+
+int rtw89_regd_init(struct rtw89_dev *rtwdev,
+		    void (*reg_notifier)(struct wiphy *wiphy,
+					 struct regulatory_request *request))
+{
+	const struct rtw89_regulatory *chip_regd;
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+	int ret;
+
+	if (!wiphy)
+		return -EINVAL;
+
+	chip_regd = rtw89_regd_find_reg_by_name(rtwdev->efuse.country_code);
+	if (!rtw89_regd_is_ww(chip_regd)) {
+		rtwdev->regd = chip_regd;
+		/* Ignore country ie if there is a country domain programmed in chip */
+		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+		wiphy->regulatory_flags |= REGULATORY_STRICT_REG;
+
+		ret = regulatory_hint(rtwdev->hw->wiphy, rtwdev->regd->alpha2);
+		if (ret)
+			rtw89_warn(rtwdev, "failed to hint regulatory:%d\n", ret);
+
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "efuse country code %c%c, mapping to 2g txregd %d, 5g txregd %d\n",
+			    rtwdev->efuse.country_code[0], rtwdev->efuse.country_code[1],
+			    rtwdev->regd->txpwr_regd[RTW89_BAND_2G],
+			    rtwdev->regd->txpwr_regd[RTW89_BAND_5G]);
+
+		return 0;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_REGD,
+		    "worldwide roaming chip, follow the setting of stack(%c%c), mapping to 2g txregd %d, 5g txregd %d\n",
+		     rtwdev->regd->alpha2[0], rtwdev->regd->alpha2[1],
+		     rtwdev->regd->txpwr_regd[RTW89_BAND_2G],
+		     rtwdev->regd->txpwr_regd[RTW89_BAND_5G]);
+
+	return 0;
+}
+
+static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
+				      struct wiphy *wiphy,
+				      struct regulatory_request *request)
+{
+	rtwdev->regd = rtw89_regd_find_reg_by_name(request->alpha2);
+	/* This notification might be set from the system of distros,
+	 * and it does not expect the regulatory will be modified by
+	 * connecting to an AP (i.e. country ie).
+	 */
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
+	    !rtw89_regd_is_ww(rtwdev->regd))
+		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	else
+		wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+}
+
+void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_leave_ps_mode(rtwdev);
+
+	if (wiphy->regd) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "There is a country domain programmed in chip, ignore notifications\n");
+		goto exit;
+	}
+	rtw89_regd_notifier_apply(rtwdev, wiphy, request);
+	rtw89_debug(rtwdev, RTW89_DBG_REGD,
+		    "get alpha2 %c%c from initiator %d, mapping to 2g txregd %d, 5g txregd %d\n",
+		    request->alpha2[0], request->alpha2[1], request->initiator,
+		    rtwdev->regd->txpwr_regd[RTW89_BAND_2G],
+		    rtwdev->regd->txpwr_regd[RTW89_BAND_5G]);
+
+	rtw89_chip_set_txpwr(rtwdev);
+
+exit:
+	mutex_unlock(&rtwdev->mutex);
+}
-- 
2.25.1

