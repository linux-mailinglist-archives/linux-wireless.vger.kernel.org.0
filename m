Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845531EDDE1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgFDHSs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:18:48 -0400
Received: from mail-mw2nam12on2118.outbound.protection.outlook.com ([40.107.244.118]:20832
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgFDHSs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:18:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ6jbJm6XlWqsc1wDFRFi9lP9PoC/Coxf04NTROReE8ewUpR6XHLBNtmc/1mucSGoFD8HkjY2hsHGkkbX2xfaNuhAxCp0jEHl66ZDsYvKCUzKHzvgG0W4xm/E2CN1y5J9HwciLRgbqw1BF1ZYe6YwRPQgkxUgbGfpJiPEyT09Ah3p8NgW3I/T4j3agXTiETVPTv95oC9RSaJ0MswL8mPHnDWAJtNxR45sbwgjGL99y5IWPleI8OzgjbZLjO7hU+Y72SowOLCrpJIrxG3zm4YxnervofsBLLNNZW0vBA2beO20YmhGrkuZvCA5HSUrL4kqavwig9JAiKbd/6rmQH1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7U3UczknmHsTsjTNSz0Zz1QSQpuXT1eqadg+PodIj0=;
 b=hBiXTvm+CC0rA7RrKbbTk2gviNiFoqWU7I3ApengboBfxjpdc3MAu35q5FtLD3MTDmDU9ux74sCsM9HNcJOhsst/O5Bh0G9RsY3fvso+dcyB9BkenTZv68Ke0TF2JoYGmiX/oHTS5HuUfjuakk7t64MIUWKDOT72eVRsP36PHqW2MEOYA+N4xg8C2GQf9vy35i3KHFlIgaEUJQx/0zZjtG3j1MaFWsc4fECKbvB9QTrMaI/5TULhuvXohN+CITGf9126/NhUPWOQVPndiCOZQIL2hwlZ0uPAkwNysp5D26sIGhKewk5zhiNLbgmgEIltz9O/kBGsAgsBQzbPPZwQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7U3UczknmHsTsjTNSz0Zz1QSQpuXT1eqadg+PodIj0=;
 b=CljFElOL0d7zJViesk+jKizBusmweZ5/s2El0LuHNrj5pvoe3Eu7vrSSOzziuZNMjJyp8HhRddaq12PKeCJ/QJoXVLfUe7idKfO2vTsBOWehgZtzVS/B20T6PqbMHPIRp8Ri/OfNOkFXv+v784gHYAnrMG/wtBbpYm11S11p4yI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5324.namprd06.prod.outlook.com (2603:10b6:5:102::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 07:18:46 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:18:46 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 0/5] brcmfmac: Stability change series
Date:   Thu,  4 Jun 2020 02:18:30 -0500
Message-Id: <20200604071835.3842-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 07:18:44 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f927f235-6d3c-4c27-0ec9-08d8085784c9
X-MS-TrafficTypeDiagnostic: DM6PR06MB5324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB53242472164AF5A163A761D1FB890@DM6PR06MB5324.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwf2YqYCXjqEQdcCwyfma6lkOkf26s6W8cYdHr7vFUMGbiamOJd+TMVK7w1EbcR9SZ0irU3qEzRrB3Ve/k7Adlxhsehdlza0QBMVruzaqU7hEi5o+bpdzfwhb3mC40zEwHFWgIOJN01eAnFps41OHShs4+qXrhqMe6tOoll3MWpQvLNnBnVnVDHlgfmjJY8KqtJ97W0bgnog/p4wkwTN8dt0ScRJlZgGjvFzVdZ9h8QiZv5FtDUH948nFuRTYIunWiICJeX2yOtniB710wTJtri+SzIL059cnpfI+wb4yxMDz7iaFyNZsR4capQou5WnT//7/N+tsC+1MSF20BKtCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(136003)(39860400002)(376002)(26005)(8676002)(186003)(16526019)(66946007)(6916009)(4744005)(6486002)(52116002)(5660300002)(66476007)(2906002)(66556008)(54906003)(316002)(7696005)(1076003)(107886003)(6666004)(4326008)(2616005)(36756003)(8936002)(956004)(83380400001)(86362001)(478600001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UTzLKNoqquaHBv94TquX/Cnx0YsOSzsP0IgNCq7kbelyjXiL9oQMMbfABNSgikGXQ1k3DZ5H7bgXgfIzvJaghuWS1c2TzGMddqXgBwTvUNqD3x3lYc4xM5VwBm7e28flIOmkN6uDzZrdAh5SA2BjsNoEaBoUsLF9eF8UkOFKjgyygb6YtSWzpXu1JgNbjodhv17l3zgolHbw1yY7kZMLJYvj/11He6Otna93lCDElH6XoNBgMbJstbrvPWjMhIEaFg+KCR3/smgq2/2MJcLvE/gywGG1YtP9tp5PniDAi93GT+dvvZHAFoRdjDXpjEkIgEVmn3XUj7MkpdbTnB+P6lbZcIXfYnXtnMAfRyxSyixPQ37TPhTg9INrmKZ8ZYSk1XDyrOC3Oyu+5/Y7cnBo+XMT5kTLJUaf+q51V76S3DSz7SKu5bdJEVtnd1r4+J6nLOR+kTerAoLMAM//3TBFHx8apPNr3n/zbcOsETboWm6TwHUQPO/4Ty5p54RMxLEU
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f927f235-6d3c-4c27-0ec9-08d8085784c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:18:45.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFDcRyKd9uvPQEhargnXl9UVoaluVhtvYQg6oeeeNAO3+1+ixBQ+VSsOd+KTDk1B6ne6isy+7rzrTc7h0IKzCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5324
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes stability and connection related failures.

Changes in v2:
 - Correct all typos in commit message

Prasanna Kerekoppa (1):
  brcmfmac: To fix Bss Info flag definition Bug

Raveendran Somu (1):
  brcmfmac: To fix kernel crash on out of boundary access

Wright Feng (3):
  brcmfmac: fix invalid permanent MAC address in wiphy
  brcmfmac: keep SDIO watchdog running when console_interval is non-zero
  brcmfmac: reduce maximum station interface from 2 to 1 in RSDB mode

 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c   | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 6 +++++-
 5 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.25.0

