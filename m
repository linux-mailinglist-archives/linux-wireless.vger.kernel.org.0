Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE67430F0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjF2XQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:16:52 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbjF2XQt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZFubpImMFMFXZomDUfg1D9Ml9vTS27zf/ybcr+y3Nmc/zDesOisOdgEci4r3wO/8emyAiEEPzFVbZuU46z9czCs1Bcjiv1jaDEMSrTV5LcjBactwX1AoGtm2/IBx+354tE+9inP/qUWRGtLj3clNKNcwqnGFNgjQ3fGM0fn43cwg0Gq3z3xH8lg/3/uFK42hm3MroocDUOGVDiqwrsKn4Kv/+cHtx8UBIkgth7qnmTZ0ngsaWUXwCVrshMzD1VSvSs6KMovY2z0HDCLWN3TXCudQueJJ0IJkdWiznP32IOF9kwWSJQOO0tPHw98Jb4Id9B362iP1fLfFWBWhZL+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDE4i3zQGbuPwygdBlxL2AmsbAK0oMlKO525LfqXhzg=;
 b=Nu9pZqdJcnG3bKIugddPr0wYyXuZ9cExdPxqhAJivilTRgTRkQxknaL0HrwrwnsVx4O6V3ygkkGVv4qcAutfWK0k3bkYAEvg2tYCU8rlziyYuetU55ISRo4+ZyioHBDg/MJVF1cP5Uq+39E6nSyLPUm+mjFeRKwcpGjMVzkfyRpmnyh7ZefmZrC2yzBA5ms0ADoDZ658EEdXChTlxFEpVGVIfeZ+mj3OS53/b1iSedIMWDMWLMQy6cMPp/oMPTyx6+gPexxKkZHEmc9/x+t/hpyn9O5B+q9mJtQ3dOPYXxrK3wDYqzR2ME6TIcQcwdOgOOQilfPoQGX7cA8NhiLOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:47 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:46 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 00/11] wifi: ath9k: add support for QCN550x
Date:   Thu, 29 Jun 2023 16:16:14 -0700
Message-Id: <20230629231625.951744-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT3PR01MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 71480c90-2d63-4349-4312-08db78f6e8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUmK/nxeBW0MWaMXZsVIXT+ppYK1LhKkbm2ukXMkBcbzd7yEYghqWP7Rh93RN1SHytQpoZtP3aDZD8F32FL4fu2zYvdP06KmtmUcRLnZ/4eeoA1irmjqNAhlwxa+PT00OF2/m34yZIPgRZrfQ4WAd1XeBmOdKqAncymT7pPCrcoNpLgLng70kh9/V7Eso9OxStvT8gQXAZxksSbibILuJ3qMZhbbJSKPQrw1virmsJbFC1w8dteLdrGifDXAsHnlBL/t6Mm7+IfCm/KWN63nDJ1ipKVb8cwJbWe+Tt0jWaHwxhCu7dT/werXAABxHyTK9YsHtcnDZESg/HGAqMmw/nQbPdi2rFvjg43NNXJrf/NytYdT6v43KUhsuPBCntUM2UHJN0dxkdSRkVjLVuyHqDDfkJdV8L+Oxg/WvWl7YpkU0rpew6b4C23fWfSX4wl1mWTMVmtyIAK8FaocyFGf5ARjZP5QklK8aiCrAdDwY20VlGFDkOOUKQI2kGPq49+y6IldAPRmTCNf24qMAYldy4UslYwSDLVwu4NG0sQUDpiKje76UjaiRjCY/0WrcSKQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvBObGhzFSUOiBrmLaS7GQW7kyXq8xbF+09KFjKOP778TS9VtgAtKSZ0GwTm?=
 =?us-ascii?Q?JINY6kp+nkseR2mU4PtEeu5lLs2Irww8cWoycKowVd2Ye/cH9RvW5ET4TBQp?=
 =?us-ascii?Q?P4MbeIZJPbynS+fhkHBDDfWuIC2NSyqvtCthpTiTOPtlQHF8bRPAB4qMFGpf?=
 =?us-ascii?Q?IiDATpAu/QKxTM1CFHZ3dxvImMU1SkgfiDJOpjpAwEXQPXs373wWMWe01CAV?=
 =?us-ascii?Q?04QtUc2VbEXO6kBk13+9k/k6Llil4BAD1QqtaSnt/s7j+m3wfMU+GRvrOUWN?=
 =?us-ascii?Q?+RqgCyNEvVZBztZO9sN8jvihX4J+UUroQk/72MuQn2v1vTwNT5wKwm76iSrr?=
 =?us-ascii?Q?JBSJ8jEw9UhfmtkSLYnmeaGc1FjgiN9uFHCbEU74AuxjwgHGk50Y8Jej1tF1?=
 =?us-ascii?Q?XlI5LbYAuPF57SB2xJPuawCZRmkTEQgE+rs2MEe1xVzEOwPWD1AZ3JRluR45?=
 =?us-ascii?Q?Hoy8FnWqT2BjwUfSKU6ezqITziq2l8rT/8dvR8kNnAT8OuQpq7WCFJmE5XAB?=
 =?us-ascii?Q?BrOBe9s8r7GK/wnhATnP2jP9SG34aRCT7Y3VFObh/Mq2nSw4QocwhSB1nw2f?=
 =?us-ascii?Q?RCpcxuh8iZhm5PDakweZ1EHKUdT329lSd6Jy+MpVx1UQNB4vShVCJcH+nWk/?=
 =?us-ascii?Q?D9yfDFeKIR66UHRD7Ktq/qY3lxhx6lnT49VpMqLcZeA7ux6rQpKsJqWD8qGv?=
 =?us-ascii?Q?4p16JBIS9bWdvnHS4AgJumgl0tUXGaqvZ7BlSNpNOrBcFIo3c8ZcGzFflvmw?=
 =?us-ascii?Q?uywrJWkN9pWFLa/yzQycwzHnSgybz2bsaU1gUH39UuvjecLxGM1k2oH3XGuI?=
 =?us-ascii?Q?C5d3YaVdIqWEygvE9FySsB2Eq9IthO5s6JVCvTY9vHPbxIgp50zQ1gcqrexo?=
 =?us-ascii?Q?wkG39LiMm+kfv2R/+HsV7OF3y9T4ICxhcuQ3KhmfO5Hzob0LUWvZrCgnivdb?=
 =?us-ascii?Q?MT25w3KITvF/1dWnLlmJnhVZQ/3QEgv2QkUNWY/AF1fc/+EWjdBguzDfSwDF?=
 =?us-ascii?Q?4Gtvt+tUuNMyLwwuB7HzUGiLzBqVsdQ+ANMaTDtAadht2O5mz9vBoi6xfEt4?=
 =?us-ascii?Q?jIwMe9o5bhaTTuK9FmbnhQ10wvuzt/vUDAIO6PkDuP1//O+UtydGqMbJC9SJ?=
 =?us-ascii?Q?pRk01vkDnt9MiwfHed9HKQe8K5Knj/f9sD89f6NhOCmtalTAwoqXlNSIitAS?=
 =?us-ascii?Q?cInyBHtp9vS1eWAIxruYnW+K25GCzfAgWebLt8ES4DWb+8oRn3CbllxUWq5B?=
 =?us-ascii?Q?YsUWmwZP3Gm3eUgh4GrYcJVIaXuytxCGrhxfEf4TdANNJcrJVAZxodtpdmJ/?=
 =?us-ascii?Q?hlm+4Hqm44doQkn35dZeAy/S5fL4oUpkZjr66PpukBZoAu5CgzBCfWg+Rl8Z?=
 =?us-ascii?Q?X2qggIjDvJwaNPVTM0tv5Nfe5F5mvoYEfL+UWx4Q5D1NnmBLz/7HiuvTpL6z?=
 =?us-ascii?Q?ebelGITXw6Dx8IRfRTrpl/XlknIjpPiXmfj4mZZL3W3rd5ZBg6562aGnK35w?=
 =?us-ascii?Q?lU6UkIgOQzVz5GaosIBafp60OWwPzeORgp3GISYeJM/8AMwc1Iyk18El7fD6?=
 =?us-ascii?Q?GU/MpaVTt3vmKdZ4vlat3kBn8VdqhtosO1vyaS8N?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 71480c90-2d63-4349-4312-08db78f6e8de
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:46.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqZt5GIWfsJbfxO7Y02+l1xsDuwjZC8af0xdzHufJZXTptD32ozSO75ShHZozQcarIgCmrXfpAogvo3di75/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for QCN550x. Compared to previous versions of
this patchset:

- Removed hidden dependencies on ah macro
  (see commit b3a663f0037d20e77bbafd9271a3d9dd0351059d)
- Done significantly more testing and performance improvements. In my
  informal testing, the 3x3 performance of this driver generally meets
  or exceeds the performance of stock firmwares, which was not the case
  for previous patchsets. The main source of the improvement was
  enabling the clock doubler.

Notes:

- While QCN5502 is a 4-stream device, ath9k only supports 3 streams, and
  that is unchanged.
- The QCN550x EEPROM format is different from other AR9003 devices due
  to the 4th stream. An abstraction layer has been added over the EEPROM
  to support both formats.
- This driver has been tested on the following devices:
  - Asus RT-ACRH12 (FCC ID: MSQ-RTACRH01)
    QCN5502 4x4 RX mode 1 (no XLNA) TX mode 1 (no XPA)
  - Netgear EX6400v2 (FCC ID: PY318300422)
    QCN5502 3x3 RX mode 1 (no XLNA) TX mode 1 (no XPA)
  - Netgear EX7300v2 (FCC ID: PY318300422)
    QCN5502 4x4 RX mode 1 (no XLNA) TX mode 1 (no XPA)
  - TP-Link Archer A9 v6 (FCC ID: TE7A9V6)
    QCN5502 4x4 RX mode 0 (XLNA) TX mode 1 (no XPA)
  - Netgear EX7300v1: QCA9558 (no obvious regression observed)
- No device has been tested that uses QCN5502 with XPA or 5GHz. I don't
  know if such devices exists.

Wenli Looi (11):
  wifi: ath9k: group some ar9300 eeprom functions at the top
  wifi: ath9k: delete some unused/duplicate macros
  wifi: ath9k: add _ah parameter to certain macros
  Revert "ath9k_hw: fall back to OTP ROM when platform data has no valid
    eeprom data"
  wifi: ath9k: add QCN550x device IDs
  wifi: ath9k: basic support for QCN550x
  wifi: ath9k: add QCN550x initvals
  wifi: ath9k: implement QCN550x rx
  wifi: ath9k: implement QCN550x tx
  wifi: ath9k: add abstractions over ar9300 eeprom
  wifi: ath9k: add QCN550x eeprom

 drivers/net/wireless/ath/ath9k/ahb.c          |    4 +
 drivers/net/wireless/ath/ath9k/ani.c          |    2 +-
 .../net/wireless/ath/ath9k/ar550x_initvals.h  | 1539 +++++++++++++++++
 drivers/net/wireless/ath/ath9k/ar9003_aic.c   |   52 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |   98 +-
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 1069 ++++++++----
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    |  112 ++
 drivers/net/wireless/ath/ath9k/ar9003_hw.c    |   65 +
 drivers/net/wireless/ath/ath9k/ar9003_mac.c   |   92 +-
 drivers/net/wireless/ath/ath9k/ar9003_mac.h   |   10 +
 drivers/net/wireless/ath/ath9k/ar9003_mci.c   |    4 +-
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c |  120 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   |  370 ++--
 drivers/net/wireless/ath/ath9k/ar9003_phy.h   |  598 ++++---
 drivers/net/wireless/ath/ath9k/ar9003_rtt.c   |   32 +-
 drivers/net/wireless/ath/ath9k/hw.c           |   43 +-
 drivers/net/wireless/ath/ath9k/hw.h           |    2 +
 drivers/net/wireless/ath/ath9k/mac.c          |    2 +-
 drivers/net/wireless/ath/ath9k/mac.h          |   13 +
 drivers/net/wireless/ath/ath9k/recv.c         |    2 +-
 drivers/net/wireless/ath/ath9k/reg.h          |   13 +-
 drivers/net/wireless/ath/ath9k/reg_aic.h      |   44 +-
 drivers/net/wireless/ath/ath9k/rng.c          |    4 +-
 23 files changed, 3232 insertions(+), 1058 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath9k/ar550x_initvals.h

-- 
2.34.1

