Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B967D1B7316
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDXLaI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:30:08 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:47048 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgDXLaI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:30:08 -0400
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03OBRLjU017911;
        Fri, 24 Apr 2020 05:30:04 -0600
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by m0059812.ppops.net with ESMTP id 30k9gr4hw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 05:30:04 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNDzaqbxNwUjHFtTmG/p2270dse+WrQMMLcfbc6XyUTjnNYoW+dVp7w0JLEtn1bNBC4ZLBXhhXuseWZHH9tj3jLJk6IFpgdlN4ObfxygTwnHWKHFBGcjKrkrZ9wvQPb7bT1fL3rOy1eHi1+byVeoWs0K/RMlCPbEuzP4LatZG4w8kwN3kRAUCMkS6jQsB4ZHQRUnongllU/ofbZFg+YkW0ZPgYHg+eLqTb2uFlZ0G4bTH0WBbsaYxnOca7MAsr7O9i8h1kLjsnzu/fxBTJsde4T4iVckBG8Q0wk718gV5A6lDtUZb6obxNvgnQl7+iCFx+BTHoPqn+dPWfJiVTVWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhG2WRt8//V5L0JLkLIlHpj90f+VnnFA2oHdz3pFybs=;
 b=Jxl6iZPP3ZIotEC2gsRdo8TwP9kDEzd4O3PsPU/SbcrbeD3+a+ZT5MZecIde2r0/WxwRZgCBjpOmrfhnZxCo6uRcRwTH2I0Q7ULxp6wljwRIa8wmme11AEBaE6rprsZR1xZKu9S+StE8fWbNyo/VoB8/VWzJDfvQGGEbeyV1WGBR8/iehF2Sw36r715c/Q5+rKRq720+4BmAc9I+BRl90QuWU8E//nOHb7CCDpyU9VHcQyRbEEnDwhFad58PtX+jJnnpK+V3xunbN1Raqtkh2rmeaVrNRPG3Ipy+5wlKMrdZkwaZxT4UnutFOuqSuDxBJMAwseBmNP1z5ZR84ZHHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhG2WRt8//V5L0JLkLIlHpj90f+VnnFA2oHdz3pFybs=;
 b=agITfB6hR/+SNmiGL1niOKUOQzGg2sqU0SPNI219Phnb671ot1s1V28DFzi8tEatZK0QLncok3440P9aC/BfX0czEVx33WdhI2zhQ93Hh9jpmnRWmjHj/97whoNMuUp3u3Wsp2Eyo4DBpBzt9nvTx1Q7eGLvhWYW6OjPX4f3Rzk=
Received: from MWHPR05MB3405.namprd05.prod.outlook.com (2603:10b6:301:3f::26)
 by MWHPR05MB2864.namprd05.prod.outlook.com (2603:10b6:300:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Fri, 24 Apr
 2020 11:30:02 +0000
Received: from MWHPR05MB3405.namprd05.prod.outlook.com
 ([fe80::acea:57b7:a007:4318]) by MWHPR05MB3405.namprd05.prod.outlook.com
 ([fe80::acea:57b7:a007:4318%7]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 11:30:02 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3160.namprd05.prod.outlook.com (2603:10b6:903:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:29:14 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:29:14 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2 0/5] cfg80211: updates and fixes for TID specific configuration
Date:   Fri, 24 Apr 2020 14:29:00 +0300
Message-ID: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0087.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 11:29:12 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21ad47c9-dce4-4578-811a-08d7e842b765
X-MS-TrafficTypeDiagnostic: CY4PR05MB3160:|MWHPR05MB2864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB31604B613CF7B5FB8EA63669A3D00@CY4PR05MB3160.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 11:30:00 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR05MB3405.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39850400004)(396003)(366004)(2616005)(5660300002)(15650500001)(7696005)(36756003)(52116002)(54906003)(26005)(316002)(16526019)(86362001)(6666004)(186003)(956004)(2906002)(6916009)(4326008)(478600001)(66946007)(1076003)(66556008)(8936002)(6486002)(107886003)(8676002)(103116003)(81156014)(66476007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuYcqTtvimfCwVoI8fO3lu9GKqeB6BSWmTzYKsqGK/bbFCMluFf7F7txivlrWlnbWA1BujJNU443iwwr7a79P5z//eopVZcoCP0uzcXhD6BCI+9K/5dywcoBKlhWeh44TuUUOhC7KiRMWS59yeHB2ea+P6Lv1TQnAsBCmL10t3b20GV4mDgCYGPb6ndR11dwR6x2GLtZuMccUtxkpcdLU0T1eEAILbQxDjxmmL8gkVwzFN7CDebiyS4X88bu0y7nvmY3Q5ZarWqNhvchyZ9txlgT69QmEp7dmHBoRml4MiA/faAsFrdL1j8DKw8DNn9FPMQ8QV2Evhs7dk3XOVlyeKZPCsGisVIi+VqGsx5c46qkIKM7KZ9WLQo0ODBqy0ev+3eI68Vl17sLZy1bedj+rLg0fuMsaWObmp1yAY4SVaRI7iAgix8JBhXHCfP18WRj
X-MS-Exchange-AntiSpam-MessageData: sI6kpsxOV9mCFc/gzYILw1vank1lYKYdIoBrrWzeF/2ib/CDYI5Dw2IXKkR5hHW8M9tnXyS4vmqf4F5Z7cy6TyOfZFY2oQRBsfmrsWhrhawVvg/eYrt+cNCc3M4ZUYSi10hHiaZM6nIRuWZLUyT7MA==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ad47c9-dce4-4578-811a-08d7e842b765
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5ffqcMOla9Bgr05Oei4iwZRuJ0N40ZvEpvLW1ANreuXeKsgFomIBvI1xp/OTo+E3aHtDHbUUGARgb4h5s1P5KNTnYbdMHXYWRAqxA7RlGDFYv5hGnku6kRWWfqkF+Lvm+34K76KVUBZF5+jVlq2rZUstTPv8XAQamKdTlHAAffTcaWpStcDMOAsz4YYZr7pZ2OJpJf50KuB5dj+A6Fxlx5Nl3KDX1Vjci4tiiuguOg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:30:02.8680
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2864
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes, Tamizh, and all

This patch series contains several minor fixes and enhancements for TID
specific configuration functionality. The first three patches include
minor fixes and TID specific AMSDU configuration.

The 4th patch is somewhat controversial, so the series is marked as RFC.
This patch simplifies current override logic. It suggests to make no
difference between 'specific peer' and 'all peers' cases and to apply
new TID configuration immediately after resetting the previous one.

The 5th patch enables access to new kernel functionality from iw tool.
Note that nl80211.h changes are not included into iw. So to make this
change work in iw , header should be updated upfront, including new
AMSDU attribute from this patch series.

Regards,
Sergey

v1 -> v2

- add policy for new AMSDU attribute
- add patch for iw with support for per-tid per-node configuration


Sergey Matyukevich (5):
  cfg80211: fix mask type in cfg80211_tid_cfg structure
  mac80211: fix variable names in TID config methods
  cfg80211: add support for TID specific AMSDU configuration
  nl80211: simplify peer specific TID configuration
  iw: add TID specific configuration command

 include/net/cfg80211.h       |  6 ++++--
 include/uapi/linux/nl80211.h | 20 +++++++++++---------
 net/mac80211/cfg.c           |  6 +++---
 net/mac80211/driver-ops.h    |  4 ++--
 net/wireless/nl80211.c       | 13 +++++++++----
 5 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.11.0

