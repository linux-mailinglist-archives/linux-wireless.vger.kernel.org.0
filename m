Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B233A504D1C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiDRHWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiDRHWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:22:48 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2072.outbound.protection.outlook.com [40.107.115.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E9639A
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koAJn2L2w1rYm7oEALEGy+EMXsuO/jJYHKY8L8PTIsV2a+C5FQcFvLEt3VAF1XvAhtOyQ5LR/R2RBB7vuVEaXcUVHRTzkb6l9VLZJ/yzAmpfsCVujrw9gjkMd1uENQk+jNSYaM/QbyYUf9T9XE6APUpV9hI+4lOe8NKD2eKkjBMIFNdpuiNhylat4AQvfA2UR1/Mh/L4U8oTBTg9HrkZY0rdRBHcBmyXiwTOFdN4RIEaH56lJQF5VknSfhWHM3gdeN4n0sqiTSfdaZcEKttdDR74A2FY0mdP0B8iXobBNQQCQ4LwLRSqyq1DpvncP4jYXQhfoCbEVu39bft2/pO9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnhaax4XCk2kztjwCp4e5DaoxBY8BGm0nvk3Vkh1FZQ=;
 b=YYyDhaW3GoSSQ4W5an4tcn6duUZxgNpeCo5o31tB4W7t2OjOi5Gc2RwlnHutm3FPFG2Y+ePZ7mo4t0DfJbhMJhsoXXx+FeWctTROnTmMQQClY0dfWIwJ8cbewQaC1wbUVfHX+vz4d+plEPfyEgOuwprWs9nh6Xu+X5tpX84RqtERx6NMVKKod8sUiRZcTByy96Y9g1pZxU0zyOtdWmCtVVHOlgf3iZLHrZZ1RB4yh8fmS/lEU1FlqIHjywwixLZ8VdsVdM9TJnwu/LUjqUJYDWTbNZlV/O8Mzj/Ea0gtCA0+3iL2xHODsCQA9oHEicLL2VCNfOtiy/M6xUyLmV2oXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:08 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:07 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 0/9] ath9k: add support for QCN550x
Date:   Mon, 18 Apr 2022 00:13:04 -0700
Message-Id: <20220418071313.882179-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3ce53f-413e-4fbd-adc8-08da210bddbc
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB4363822EE4A77AD761DCE91FB2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1rOeF5rwLeQ1Yw8PYvZzOj20cwGvSD5C7a2FQ3/2Q5w5iYyXgvuODNR9wIg3HdBxTOri9cv6saOZVHSv2a2pm7ZIDgdS/DePj4IRZVlyK44+e1GPD1tmcTeP1bdekDU/yXA4PctV+VJ2UrePdMqPnwhWWLAFhZ1M2YFm8vEJyul5h11NoAJUr87yyDn12/9aWYXz1h1VV6KSUTYdawAf/GhhpgoTWR5agcMAeidfDFPrHbA+Y3F9+eZL3+GgUfne0oRmzsXgYYuT5YcZnZ2xZDmvYfGMCjsQG/5N7ujpzH69j3hZCGWlmW1c1zbFYq/0C/c0Hs36yz/o4gwwIoCBwErN8ktEbsAo0sXYwu0I1NPNpKqvFyzdhcfrIO+i2K18um9jlOn/xoYgLITqJTostiypxeNuublmIyUEUvwkKXVD9us/xtSh8lkaMqDWCqSAKHrsacezmF9W3AxrJMgiZFvQVvuOOEiJIlyz89j3xkU+HFALigM3mRvVuR7o5Xx7KcDUSii5pvGo9pY19SWnfpWOJextYqwArZNsBQwhFXS1PQ1nM9cwKSrN8GssoxWIQOCRays18uwDkz8DXhAMYaPeOuNHIyJwjzgaOvFqSKYJg41GC7vavcvfWl/a2YPJ752sr4WE7UjpKIBHZtfaC8d3ewjd9egaJ9oqjdcndHA5CXPGmY0e33xnPMo7ikKGA7QD8T80of3Zvhj9VLAZoE8HIPc36wg9lOFO7mS8exTwkPPFFuDsd300FZlka2gutKEcNZWIjlDdkhbIEGXJOII96RteHJ8rzRuQFATkkhSlySx9Tz6aSo3w/wV1J5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(966005)(66946007)(316002)(186003)(26005)(786003)(38350700002)(6486002)(38100700002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P36dE2WTcb1oFr4Y9m8mR+hbT54CqQ5UTR5565xCjFt5U787KZaP/KUfpDTD?=
 =?us-ascii?Q?wQpe95LDaP0GYJ8rxCPYDDCykY1YQC/nmzmyS8E34ctshgcR+e3YGzYIiUfa?=
 =?us-ascii?Q?iHWJnjqxzryk928Km1CuuCRqX6qBKZY7dgDr3mQWYZKzXvOJRGuq/BvyO1kI?=
 =?us-ascii?Q?zbfIPH83C1awW36C/rg1+cEjKVA5sBeWrqg0l++PhAFbon2Z/UEscVtmr0/E?=
 =?us-ascii?Q?jR9utWXgmjOapsmqDPAWb4EXPOXxfIPzCicJpKQGTHkY9zrcwqhM0awTmwPk?=
 =?us-ascii?Q?/JvKFnEEXG/LFxv34k1VjJfVRtWM90NhcgugncU68FQ19jZifj/k7Oum/AF1?=
 =?us-ascii?Q?VE62UaKAw4fW6FWJI3dog6rdTMpsnyOzRp72AoZ0lNEDJRXaspEoUL/cVMUJ?=
 =?us-ascii?Q?YTuLbYGRGiH1fpiWJyOMS3ARETTkT7+/1HCmkdgE6OC7USIjfux0A1yZGCta?=
 =?us-ascii?Q?O/wFPJ8dFcZZGPLm72FIVV1d4D+B6UcOtu7uxyrbctq29OLhOCwOAvMcnjvn?=
 =?us-ascii?Q?r01qCcBkx+IifA96/sAsAVQEMfI9x2Q3RGmnVTlrqaYjWocIVc6l4+vcI1a4?=
 =?us-ascii?Q?UMMqQkghmeXVUnKJ2pHrzc82zAJmOXt7tVJy2Rsj1plRLAa4zu8Qp6WRKJBv?=
 =?us-ascii?Q?CUaCFE9X9iJgYVPD24nntXk48x3Ll/i6Bd8vWXddiarWbESJhmLljbMncS8F?=
 =?us-ascii?Q?/qKDOqorGs4pRKbxCYqvUkP32KT5wWmMqn6VeW2vcktns2DsL4Yt6xpXK7Tw?=
 =?us-ascii?Q?ODD2McveayD95SsNrH/GjrvQMpIxfi85LvOLY6Evyid5V0nXX7qbzrL3sujw?=
 =?us-ascii?Q?oE6MkTyD5RxCyJgeJ2BJ+zjPluYwBoHBPtR4lDxV69EJh6lmqIan7E5rZFIL?=
 =?us-ascii?Q?aoC0YlNjLuqTuFx03QukRb/nrsBTLmcbQE9O4XwI8HfgTbLXtDbdJaUgTNPN?=
 =?us-ascii?Q?CStGxdbDEOOY1WeDNkHuudxGST58lS++JV1YwEGzTZCwSKSzcPKGkYum+LjZ?=
 =?us-ascii?Q?7YHUKRwAoi4ireCol+oRflcatWpEqYVZuZnkrHnzCw6qz3C2E+fT90KD31wL?=
 =?us-ascii?Q?+CrPMD7ITA6lcsYHI7/3aF1tJVkHstznpGly+3Jvp454013rV7apNIIdY6OD?=
 =?us-ascii?Q?exRDk6W9XTmxw4tAns03jdmWVnLwAQn9zjVOanzkfqRKcMnWiS0e8M77TBmk?=
 =?us-ascii?Q?fErFxPpAPGGHqbE9aRpCWV2070IXZpQPZq3L9KxT05ZW+xP7JPE93IeBsVfZ?=
 =?us-ascii?Q?41EYjPIb7+U45JsD5/bRMwMEIqElbUl9v/xOkuaZ9PKx1x/UwilTXKEDDaxb?=
 =?us-ascii?Q?mnK7IZkTtVkDfqlBbuItrR5kKb14I7liYmYRq9TWOzObU/tozUPxwEzdytVX?=
 =?us-ascii?Q?2iXeJ9sWPSHY4TGCJVSCT2Ja4H7brHyVdfZkHGJB+Unin9C0q+eKmbX2BJ19?=
 =?us-ascii?Q?aohjefLpx5qhHUk7bzX4Mv0noIQMvHBt4PUKXPxfhZAELfdGvMr1cSVFui1u?=
 =?us-ascii?Q?+wOzFrwjZWuvB2VrHN5mYtWdRHgBhfcdScCVZIQMhThreYmtckmal7GfPHIs?=
 =?us-ascii?Q?S52OeA79FM2UEgD3m3tFwCIH0U/Tk85ruesVXFYHZI/4YeRAtc3T8dJIk+43?=
 =?us-ascii?Q?v3GIzjHY7J8MNTPvocN2Nk14pgSC2N5O850a9I9py+X2shKYqmrVW6PMvtmM?=
 =?us-ascii?Q?xT2IXi2M6+H4YNyfc0ftRSnC+MPsCAfSvYx1hBfgG1jRQEkzxoIajgE1/OZy?=
 =?us-ascii?Q?ByvMJJEqeg=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3ce53f-413e-4fbd-adc8-08da210bddbc
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:07.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRDkwkdkl3r3j1nNeK6QoznAewdmUhWq44BEPM/XW7J+kn1z7anZYTcz0tOOSVKRY+pxlm0Tr2HIcGLufYSRRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for QCN550x. It is an attempt to write a
cleaner version of the following patch:

https://github.com/openwrt/openwrt/pull/9389

I'm definitely open to ideas on how to better implement this change.

Notes:

- While QCN5502 is a 4-stream device, ath9k only supports 3 streams, and
  that is unchanged.
- The QCN550x EEPROM format is different from other AR9003 devices due
  to the 4th stream. An abstraction layer has been added over the EEPROM
  to support both formats.
- The QCN550x initvals here are a hacked version of the QCA956x
  initvals, and have only been partially tested.
- This change has been tested on the following devices, which appear to
  work as an access point:
  - QCN5502: Netgear EX6400v2
  - QCA9558: Netgear EX7300v1

Relevant links:

- QCN550x SoC support, which appears to be identical to QCA956x:
  https://github.com/torvalds/linux/commit/a0b8cd5c223042efe764864b8dd9396ee127c763
- QSDK patch for QCN550x:
  https://source.codeaurora.org/quic/qsdk/oss/system/openwrt/tree/target/linux/ar71xx/patches-3.3/9991-MIPS-ath79-add-SoC-detection-code-for-QCN550X.patch?h=aa/banana

Wenli Looi (9):
  ath9k: add QCN550x device IDs
  ath9k: basic support for QCN550x
  ath9k: add QCN550x initvals
  ath9k: implement QCN550x rx
  ath9k: implement QCN550x tx
  ath9k: group some ar9300 eeprom functions at the top
  ath9k: add abstractions over ar9300 eeprom
  ath9k: rename ar9300_eeprom to ar9300_eeprom_v1
  ath9k: add ar9300_eeprom_v2

 drivers/net/wireless/ath/ath9k/ahb.c          |    4 +
 drivers/net/wireless/ath/ath9k/ani.c          |    2 +-
 .../net/wireless/ath/ath9k/ar550x_initvals.h  | 1296 +++++++++++++++++
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |    4 +-
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    |  949 ++++++++----
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    |  144 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c    |   59 +
 drivers/net/wireless/ath/ath9k/ar9003_mac.c   |   79 +-
 drivers/net/wireless/ath/ath9k/ar9003_mac.h   |   10 +
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c |    4 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   |   35 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h   |   83 +-
 drivers/net/wireless/ath/ath9k/hw.c           |   38 +-
 drivers/net/wireless/ath/ath9k/hw.h           |    4 +-
 drivers/net/wireless/ath/ath9k/mac.c          |    2 +-
 drivers/net/wireless/ath/ath9k/mac.h          |   12 +
 drivers/net/wireless/ath/ath9k/recv.c         |    2 +-
 drivers/net/wireless/ath/ath9k/reg.h          |   11 +-
 drivers/net/wireless/ath/ath9k/reg_aic.h      |    6 +-
 19 files changed, 2330 insertions(+), 414 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath9k/ar550x_initvals.h

-- 
2.25.1

