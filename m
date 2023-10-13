Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF97C9149
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjJMXWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 19:22:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2072.outbound.protection.outlook.com [40.92.99.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CBDC2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTd/z6+6kvpuaKuPIbQ8+3nqJAclu9/3SBrtasod3oFg3aFBQGUVmy3oURrWpOHLfyZBM/4VtQAMnZj4duoQNAkonCrXJjyRvtQ4qv2A3La+2MqhPvhfCNoMhceW9VN8xwlTc8CkhNZnDOifk4ZAWc9YyniMGvlUPAS9ii/ytxpqTfdzQJFmXf7YTDu/EZv7nhSBHpfBiKySkHcyQApgvb5JxnArfd136iYY7Mb2+GCfXf8AH7eHtYU2dqYn5eOOpztgo7P7EwqIm+yblTkkGxiOfFWvCN0SXpft3vrjyPjtdSqOB5NHs3361hD17E8aT0JlNeIvWDuOl/GYdls49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuvhDXTzmz+Vo/gPbZrGJ7ctHGvo111yRB9o6GTiNCg=;
 b=eWxNu9jmiJkCFbDHSHUV7z9A1CGslRda5NQtk5D3mqqKe/GZzM/6lz4GwgzqUEJ6sLJ3pyb+cmDzUdtNHTqkQnT2DRS5LwgW+PNmm2ucAg4eK7aQXVUg+kHoH1RdvWbLF7ylFiVNQecyYPQ7fo7/Cx2ELtP1MZO06UouYQxQuAc1TCGuyODxguuZkkTWd7E6/ecvCY+SmYe/KL0x+YxnkzOLrqW2NFVNHsZmTgorV/sscVIdOO2lZHnzy1M6iAjvmGLwcX2dwvE+WFHn/kPowlHXvVs5CyqrYx7D2KdaXoyKhO8pp6C73CPiqcFzyPM9YLKaAZrOQ4c5VLtKHgD2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuvhDXTzmz+Vo/gPbZrGJ7ctHGvo111yRB9o6GTiNCg=;
 b=c1xDmidz585Q+3GUaqGkkCUac6fMojrN5c4006lrmMITCzYkMyjzVy04Csl4SqaQ/Mad6USf+08UAEWDjPVtHlZ0I4ssEQN9z9DY/q+PwaWbQtmiIdkBQw5lZriwydZN6BSQFlZqnnbOq1T7LOp/3bOppn/vJSD/VBF9QQWG9L4Wr1ZOmu22ZLdWHAuyPQqvr9qnSDRFtGb8QHXAYgTm4/VHJooJrRTWUVINsBdmGiK5zcAPFFkDMNZtT9vfA7XTup+VWQ8AGpNx34+qgDZXQskYK4Out2R6ydWpPx3we+9tWirLbh7hA50dMzfkEIciE9MfXjoCa1i6KK8devs8ZQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1691.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31; Fri, 13 Oct
 2023 23:22:20 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 23:22:20 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 0/3] wifi: rt2x00: various improvements for MT7620 initialization
Date:   Sat, 14 Oct 2023 07:21:27 +0800
Message-ID: <TYAP286MB03159DF41F754CB4F3AA4566BCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wNzAIxtaxs26UimOF+WWMiRaHuBIViMP623NeQn8VUU=]
X-ClientProxiedBy: TYBP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231013232130.416-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1691:EE_
X-MS-Office365-Filtering-Correlation-Id: a5750a8b-569c-4ea2-d16e-08dbcc433ea6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7C0nSZcK7L+hY6MOIe7Q/NDNbqCmtsiyfeJEEaF1mq119LlW9C6WDHPCZDXmfYzl8X1goSo2RbjN+VRRlJ/QAdPjs4+/TRDKsV1VhcDDcGmBu1Ig2lFycD513QgSmOsn1D/9P8a/01uFzeZk8ehYTnDWM/sq1LgQWvOeqQTkqhKfDUFduL+FiLk7/mI8YdeLBcvuU5Qnla8zAlxtbRugz4S35iHSPYs5e4ME+mpUc9IP8W7haV2gFTqfPjAEBDDgX+dZTsHUcsV0X1NYJjXsI68+uZwtYTPn6M49+r7RbLj0cV6kcMuKVduAnYscOehYMfBfzqtUWkUZe6IgT6jN4AxItLtyjAtnSSgNmG7dxa3QxFzuAB4uR9rIFnHhK/SJ8oV6Yh0DrbCnz6zpgnizZVH1WUKVSv7oESjwiK5M6H9Ee+fF8jPwwHY75zwLBWWZPBodmBeX3rkUbnMLJ1hpuqY8MjKLJP5JjqsIhkYYhbqPzmIiPxrOSuFCXUk4YNkkgRPHC60OyianysNJmbvgZGTm6+K6Kcj455CKMsLZvuXyi4I/7OdOKmgOoYIjb8qVBM5PJ9Ky6VjJsouZulJKE+RdMCjSRKMNWPqEXdZ/k0l/7NsCIkz9yqc2Nf8JGRXv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qC+FWtuDaFGHrJl92VtXWv+3BycIbqIDST5Ax5DOT/mgNe7vgurUn6laIook?=
 =?us-ascii?Q?pQb0yUVEt5E9aKO51kjbTttIrHFLRTe2W5IUGEOO0OcEdtSgq6cFa2GTko88?=
 =?us-ascii?Q?fn9ZdHOaY0W7qVXHs+7WlBROpWPqmo1aGCzbeNtDYuuLBt49UB0zdsPH1oR/?=
 =?us-ascii?Q?PT63brb2XYxH/ERKpMg12tNwDnF7qQNF0Ac/rIFRFa1DG0jVQutTs+zRVm5u?=
 =?us-ascii?Q?DyNGDkH27yMGNVP2jZA01gYdOwchdDTVhr3YwDkLQjqnj7lwPZnX6Uki1kD9?=
 =?us-ascii?Q?PEpRPwGwaka97dDq3ulPaiursa6kSexR9/NX8mz8a30DP7tiS86YAMO7wnG4?=
 =?us-ascii?Q?6ER+oc+OxD17d1TKNmrO1ybsEBm9mWsrr2mr/jUsG5JvG24xJrMVR0kFaWnr?=
 =?us-ascii?Q?lGlQ9l4SMlUTRwsiL0LgKEr5hGoBrrJphGGxC+kSHkcD7RFS/RA88amvImEC?=
 =?us-ascii?Q?qqseH9YeU0k4iS5cOa4edttsHSBcYYz+LwCZJwx1xxyRmIhmqTMAt9+dlBk+?=
 =?us-ascii?Q?4VwLxiOMRb5uc4MKavzmpqgsXm1L6WrOCRGBAGzsPa5CSHNCyuUrnLY5rnIe?=
 =?us-ascii?Q?viDgcN0cb+a65TJ7mP9bBjMS9MJoinloyPz94F7y7iqF5gGrFBieRFAwWi4s?=
 =?us-ascii?Q?80I3lkmOdR2os4hbq28IYmzyTwoEu5nF+fDOy2yHTSF9dwOXWsftWAzHc6Fu?=
 =?us-ascii?Q?xZw+4va/GOBH48A5ibsqVp/BD2cKJxWzsK7Xtc2yJWk/GaPayKLG/nHvsoZc?=
 =?us-ascii?Q?8hIoeEtoG92ZBFARpESff/2QV/8whKh47r85DwFsL4u1pYtAVFOfdzroHJIm?=
 =?us-ascii?Q?KmyPZMjBUUwz+CpgchF4c5sjsAQb6roydd+lqz3cnOy1uZXb+rYANN5L3Ogg?=
 =?us-ascii?Q?iAUMVZNHa3qVFgdo6PNHVU/NvhFjf+J9TjdZywfkrOZCobtsTFJn0ycEXf4e?=
 =?us-ascii?Q?Fe5NV4TzDpuFy3KLdPT2Yg6lrEbFiNsyHwwYVMX63jYI7FpZ20RVgJtoBUaX?=
 =?us-ascii?Q?kjN0kuJsY6mMadIOC4ua7hAVtWIEMq1LZrzDMSSxL75z1b47Qqc5W7+pcnpC?=
 =?us-ascii?Q?AD+/Ik6KVBke/UctHFuxSmq/HZCKiuj0c0ToAtsWm/o1Lrdq2PTEBy5N2zHO?=
 =?us-ascii?Q?JAAUWJA8Jehkyb8YjbFg+QY/fL5Px1/02ASfJ/XihIW7LY45mSE7EY/bdQuY?=
 =?us-ascii?Q?2sWXXMwDtStTlsS/jKxU+49dunjpTlK3k74dRkdsGj2dyP7xlBvlJ6aj0Gg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5750a8b-569c-4ea2-d16e-08dbcc433ea6
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 23:22:20.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1691
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!
This series patches aim to improve the initialization of MT7620. All
changes and register values were ported from the Mediatek vendor
driver, and I have been testing them on OpenWrt for several weeks.
Regards,
  Shiji Yang


Shiji Yang (3):
  wifi: rt2x00: improve MT7620 register initialization
  wifi: rt2x00: rework MT7620 channel config function
  wifi: rt2x00: rework MT7620 PA/LNA RF calibration

 drivers/net/wireless/ralink/rt2x00/rt2800.h   |  18 ++
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 290 +++++++++++-------
 .../net/wireless/ralink/rt2x00/rt2800mmio.c   |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |   6 +
 4 files changed, 210 insertions(+), 107 deletions(-)

-- 
2.39.2

