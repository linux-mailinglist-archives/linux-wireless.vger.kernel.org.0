Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162C1525612
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358202AbiELTyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356894AbiELTyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:14 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2046.outbound.protection.outlook.com [40.107.115.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127F2701B2
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyasGEKSTGf2PbhgWKK0eEX81LDj5ApfyxyAfl1TYQeQypZZ1SN49kZQsC399ds2Fbci25NrYzkLyZVe7U+RRCNwguE9ON527zFHf3k0DovboVcOXh/ESgGZma+EuLNi1lpNI7rJ7wMwfm2dipgWxx66yECeinByYXJb8qeumSHzRe64v/yxP38JONxGm424K84IT48OeVF/Ke5ZGVJlskLM637kDC8Nn8aBnMZzYUIb3B2E8d+SieQ/usU3J8jHK3Myz9HLVXFJ6SX7l+JDEpO6b5BrI8soG0EayefPpI4cNnKiH8Vg9V5QiGyOUCErkHWDFkbO9eT/8Abm+gePCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weXMQialYC9CjNTEvCY8m/R+esXx/hUDTywDNc+vekk=;
 b=TDdklQQgCy5BhRxaT6lHg6MQSao8E/6swpQpB/FeqGs1K4Sb4AKG0gzTqwVpXLN+6wVgFT4ZtWJdd/rtFHv/H5LMC3yySK6874qPKVBmWEd6mERE0jyqJIPs5ZbwkSee63ANXewEQtMBi0UtGglkGUVDZJJQSCxKznj0So2/ZO2O8YWbU88WQ3No7+XjrNJeetcZnwCauCtWUdkaKAFRf5vWAfruYKK76pedxkX5uc8cGuqBHOgANbqKFf0Steilog07SlPwiJ++Y+GARgbyNhP/Ca/HLqf+uPi+VtHzK3jjhXNTnO+6/wH2rlMk24YVlFskJ0RBPpvKRGbePOybcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:10 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:10 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 0/9] ath9k: add support for QCN550x
Date:   Thu, 12 May 2022 12:53:10 -0700
Message-Id: <20220512195319.14635-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a12ed25-9ac6-43f6-7945-08da34512e82
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9515:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB951589120C9F3E03FE82C25AB2CB9@YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uk1dSUFDyS/OWSvIv5WPdlINXIkjva9vAWIBBe2A/bq7WErJKreYmercx7eLj/knGzhrEQEf0y5yOl1hjvTWIDs/IBvPCpoMGn8OybeMk3I+gPC3A7xD45G0vv+v7svoYSpqQtuNn6Te8jPH+xv4XEpeZd76whMD6kmXwpMp65YPs6eZtbxen+O+bDpN1xVZllyMZshab07jTWYvhZLpxyQUd9xBTPVFyYizcrylVorxagClSqJ0pwfhE3X+tNkwDVlU0qYm1YNXaVqHQirPW6H57UaiEByn1AOpbzpa015usNTZ3SONF4Ws7cHSxThxx/afEfZylF0Pb/6D28QHAQxf1NVX9hJQE2KCSKDmcI1mGK1+sDCCvknb1lEIPAe9orpG59lZRbH5DpQpHtzKzmR90SKM84IM/cUIzlY8czK8uTopA5tOdyj0cCdEAuFRo7ysrr8uKny6EpG9Sq82ZaIRfQHv24gjYb/0keipahqHYgsEXwDY2oZhgV7OIIS3PHRwXbjYFg5ajWeZeql/Lh55IF4Tfjs40VcpnCbHGeSPr5NkHUkg9FYTMnRL8etEkHb1Ph8ZlSYo7V9k0bxxqUU/qkeZVjcNZD0cWIWYgDR1Q1gVYnKZDZ1n/E+vsOwfcXn+V3W9tjebV7f6JDRovHjjrZ5sd6XaY4RlJmPwOn70eKenEV3CukAcFI+Fy5Cy4s7/cSu+uzez7R2wpjQB4gWgHsvKjiBD9ezWMzJeOT1d4iFkHNhgFggMYffKMaeDTtNr62b5729L/tgaU2Mr06TUSt09OXkNnKs3CTJE7/jkXhuagVKNbzHlrxDUyk/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(6506007)(5660300002)(1076003)(107886003)(83380400001)(8676002)(4326008)(26005)(186003)(66476007)(52116002)(2906002)(6512007)(86362001)(2616005)(966005)(6486002)(8936002)(508600001)(6916009)(54906003)(36756003)(786003)(316002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UNJ54ev1VyOkvB1vqH0CVkT9kfF+bJKwtBq9+A2/c4DZTC/oNKsh8YOjarW3?=
 =?us-ascii?Q?5WGVQd30lVrnqPDhTNbmC29GmAX5TZ3+lzaoIbxUv83Ma/4Zk9TEAjh7Vqm0?=
 =?us-ascii?Q?lsWPEIt8dgCRMcULjR1ncGkJmcsk7G4HWKGfnfZDezrHUmt/NW+tSggHZmK/?=
 =?us-ascii?Q?cRciPHV+FfNbGOoP1cat8GFJJjENDrjqChyeutbSyHAGESRVP7rCLrH6GP6/?=
 =?us-ascii?Q?axtufXqVntkEFy7Nr8Gw1iZRKAAh67zJK93alL03ZjdMYpjCOA/DkAxN1q02?=
 =?us-ascii?Q?t6lECmMa2r2vgDHodXv1JGP9s3vS2dSxqORTbALufvMFi3ikl2Dvm1Hus6IP?=
 =?us-ascii?Q?8C0f9Uw+a3xjeC0r5UG4oIMClMv1TcR/BCPNxBen19hK/8m6D9dc+ZT8elKm?=
 =?us-ascii?Q?u7yd3vg2Y1JYh16/SK3Uqr3kLHXB2UAWPW08u37a59Tva2pRcruFjK7wH2Z9?=
 =?us-ascii?Q?ZVyBpH3802pKKsm0REdaN1ohi+GzCYM/gTwN4y5K/Chp0mTQZyEYiEDXeIy1?=
 =?us-ascii?Q?sfxHj9Tr6ahw0K+VDMEjvJBR5qzb7+SxMnKcFstvLwD73B7Ofcj+MMkoJQkX?=
 =?us-ascii?Q?TE03njkmQHCY61CtPIkyd0NfZ/TCgjePzRaktSbqrn9RsXAZikMY5A4F/7Bu?=
 =?us-ascii?Q?fdZM0/TuZU47vO3mUbb7syRiSS7c+f1GE9FXvnqxUdtyH4F4HDVetjvdqDk5?=
 =?us-ascii?Q?srqqal8c3Od1g+q4p7rElqqyUsVDirEhB8Rv1Hatj/1CwdNg+9VLD8tJGEwE?=
 =?us-ascii?Q?4asWVR7KnDcWYyle+o7k1osq2K1w7C/qztsNynhlNTZVDCYB4jSyzpt/6Dui?=
 =?us-ascii?Q?3BBS+YxZ/v0Lrrb6Fm/0sQLF0qhuBx1d2cjxYPzIkf+MvGtXgr6Ym9ER+mND?=
 =?us-ascii?Q?Gd5vqDRH9G7ae4I2UvbjJyvTQN4rUflCiI/+K9layZidyTn+I1cgORDvmO90?=
 =?us-ascii?Q?wKWJCzzycd81uEPFV33WmL+OZfBFV4kKDPOborJx5x/MF45XhNx3bs96a7qZ?=
 =?us-ascii?Q?xWKvMl27noQZTQ2hBeUB+4IYP+QDHE2LL3qA2SVKwvt5KAg+Ew7gfyYcr9Fc?=
 =?us-ascii?Q?TJ0StkPV52Xvi03pOikUzoWRH3Lwxjd48c+vV1Klc8w8hvy2xQAvNuDCM9Yn?=
 =?us-ascii?Q?8hKZ4Q9dJLcySO58hsEdkBBCzkd5cdlIIF2dwdkZFzMv7EFnRQAbzC54m4Fa?=
 =?us-ascii?Q?2O8n4m9xXs7odEso1fbWXNMlTV5v5opOAs/RqQGrECnIX7xg9MK0cCvQj0Ul?=
 =?us-ascii?Q?X2U0F+xvAhb70o/YI1dbjPSjtDnWKI07WdBHTjjxk58oueARhcMAGzFPSSbh?=
 =?us-ascii?Q?wAZrc1SS1y0mcfuA1Nrv/gJj+H5SLscUujbUDi8GCaaPXkXuyIjF6/IT8ANf?=
 =?us-ascii?Q?rLMAPS3zGJ833Icgceoc7bR3JoZT9+lC3Arn+0tc/PXymSpofrQk2/SHiph7?=
 =?us-ascii?Q?2l5ySkxg7OLO81uFhTZqWi2Hk8Fi0KZxjp1HayoCjn0aVrkraMMrmcES643B?=
 =?us-ascii?Q?dHUnSSSQFecqrUmtm3yp/c7f4/k5sbGXMCAJ5xIa4Vc+9O0/Zy2dhAcxOFyc?=
 =?us-ascii?Q?C7BtaXkkf7oVI0cAVXI/x8fvTbuOeNq0xX0xKpJ+6yDCu59bqsr2XiRfpjFk?=
 =?us-ascii?Q?jQ/dAxOoCt4Bh9zHdsQqX+HneUrmGvY4LxSJp+tUMlsi2hLr4/Fq9VaJHCRI?=
 =?us-ascii?Q?0NnxJtlRiiYlym6OWKcfZVOtTYRr29pBplAWs/foSrqLKzDO0AUdMQwwd2ru?=
 =?us-ascii?Q?CNi8IOldEA=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a12ed25-9ac6-43f6-7945-08da34512e82
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:10.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDOIOZdi1V2XcO45knbNMLEWV8TdCZLy2C5QlXJGH2eutcOYwq+XNuQoVIcCg653n6ksptuY7ttOUfb1Vv01dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

v2:
 1. fix empty commit logs and missing s-o-b

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

