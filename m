Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623561B0781
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDTLhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 07:37:07 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:28960 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLhF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 07:37:05 -0400
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBU0Ik030902;
        Mon, 20 Apr 2020 05:35:21 -0600
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-00183b01.pphosted.com with ESMTP id 30fxf83wn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 05:35:20 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSzIoKfDTVA+cL9VQ2KlgnmIWkI3NKZBXYq64qDTy6ymASRV3182QINGAkoDagg6I9O8wNkl1rzbaNjm+8s41aOon8JD/5X21+t0zR1c6LI1kEkW3vTf6UJpAiXPK2Ce7lfLfJYGqwn8Ptlcj6Qx6l4Z4ZlAe4lWZMGmOxRQEuAVYKDTO84Bqe/cy+GOPCURey10T7v79gRNfA8nPJMWtkO7dwaq9EW9NS7PvZsySPsTH2/xiW1ycYE1e21tsSgG97UIWkiDw9NNZ6ZqHgEXQKkzgv3xvygbc+9aWpD0mwcDfGwwgxdyzEATVefUjyS5ZfWX3yWX532L6KskUiwnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEdRHo8zZxO7czuwwPqq7sWTht7J5hnH1WJX9TkZ1h8=;
 b=eLFexX6sl6pL6w11kpseSf/gqlPemBp866dqi21YMF6Cv50QTWaPm6Os36JzoSaMVZFWSNxMGW+k20effmij16v7zrt2B0CqeZ8BkoQVTU04AbQdYa9fu23c2Z9k7OT4Bn0Ra9fE/SEXRB6E3wYvQ8ROuP2yLPSimlrBTDocDFlqmyzMV8p+pRKKAIqxU11+0YYzjQbwZq8Km2CAw+aC1NH/GM3sAez3nhySoIPTZobtMfBVgrQNPMNaybGRomB6D+KV5HyzMbgTrOZSDJ1ew+7FwbnJim5656INzPRR0sie4BAMaoGTBLTBlVyEei1LpcdCrqgK+/R/T+DJInw3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEdRHo8zZxO7czuwwPqq7sWTht7J5hnH1WJX9TkZ1h8=;
 b=DMI8SW7Mo8+9c3GYctkfGjMMgF43ynAJSgslO1qHtWTz4jkE89UF1Bobac3DDDCKe9qddAjbERwRnwfopzY01ALITbNFBmRsmtCiNssHfNJHwsyYKMXweKwMOrNFTggw7Sl3E183jyW/Y3FnNz5sVNvJPiPk+0Lf1p+4POpBrcM=
Received: from MWHPR05MB3215.namprd05.prod.outlook.com (2603:10b6:300:b1::15)
 by MWHPR05MB3088.namprd05.prod.outlook.com (2603:10b6:300:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Mon, 20 Apr
 2020 11:35:19 +0000
Received: from MWHPR05MB3215.namprd05.prod.outlook.com
 ([fe80::1ce4:73e0:7a6e:9823]) by MWHPR05MB3215.namprd05.prod.outlook.com
 ([fe80::1ce4:73e0:7a6e:9823%8]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:35:19 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB2982.namprd05.prod.outlook.com (2603:10b6:903:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:34:47 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:34:47 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 0/4] cfg80211: updates and fixes for TID specific configuration
Date:   Mon, 20 Apr 2020 14:34:33 +0300
Message-ID: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0101CA0012.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:34:46 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17400555-0c54-43fe-ee3c-08d7e51ed45b
X-MS-TrafficTypeDiagnostic: CY4PR05MB2982:|MWHPR05MB3088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB2982B3ED9F9FBD89E582B23DA3D40@CY4PR05MB2982.namprd05.prod.outlook.com>
X-Moderation-Data: 4/20/2020 11:35:17 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR05MB3215.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(6666004)(6916009)(36756003)(81156014)(478600001)(8936002)(52116002)(7696005)(1076003)(86362001)(66556008)(66476007)(66946007)(54906003)(16526019)(316002)(2616005)(5660300002)(103116003)(186003)(26005)(2906002)(4326008)(107886003)(956004)(8676002)(6486002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp4Atx5bd+9bFKyaS8BcVvwan6JorfQYoGJyQZQRQXIl3LjAaLIxkog4OTdGZ42dlZcD0pLCxWJds5auojbGAvegkNoZbrLp/sGmYY93eIYyoOJcPWHMyVbKW2Co1un4xmbd8iW+5VvPt9M6lnHOecWqNifrfAoN4he7Tqr5XmRY4KdNN95FcA9N++YWmrSpImX26qwPNW6CWMz8brkmx2aabCtEs65ldF7ts8XqHigNwtMgMVmOvKAFLJIJekqAoxeDXYy6ee+EzyqdUn6eG8wasxG/5ssP7cV9a4XD1EVX4y7fMaO0gldHrBgdcwqr+bPkZAnXPpV/1myaepB7pH1eXnUgNGiI6y7cB4ZC6QJQf+yPbIIOVQ3P36YfoLvSOBNM+22JF1seiliXRfWnn9/gSdE/ue5Tcq4HktVN9LT0yIqk4DOaEgNG3TnYzoKW
X-MS-Exchange-AntiSpam-MessageData: ZcUDGpaS/PU7n1WsuSKQ1I/7J3sCkfMG/3UBRDHyPcJqJvaMX2p9MuLFPgtfw3kCwv6KWVQ4PSIXtWXutmSP4ziGTfUlhKRejV8BYXOFDhH53/6uVEqppFwYCW27X3ES743l18ADh9Ln8/QgQur2x5dtQ//QvfqCGlLK4Xt9QjnBjbzucW3gcsRVQs4Pe5UKFVjKiu6ayEu1elclGEx67w8Yh8g4OTDCd0DFM3rdu1uPyTcEc6nS6QhaASBTevBicybjGRlRSZsqoovO1HbfJ3k5Ep0Dn8MfIFVSo3ed91dOPGO/fJxtXQIGp9tz+uAzPnq0e5HlsVUUkyh3DALSatGE/fUo4/3Hg71wBx7gKCFfX0saPZXIqQtHsIawZ/ameQZMGcMKzC76mOHD2I0HUna9nbpJHK/IWsA+O7fk1vf4eWacvZKlmPNB+PeSggJ1Aw/kZXYXSk3+69+iJKcP4J/WbG6MbnMCjvW1BU62LZKTj6X2X0zQxF4n/MySS2LwjKsbv1W/mmjyMB7a44rGhPHfKpPkXusIsvx0/dcqCIOPtzFuiLUbsvOLmrrJ+ZrNlKvEWcTt4eQBffg9v35bu6p/kZoyGP/FKX22OwXPjCu/TZZhC4nvJ3x8Zcb+YjAHyIqGb1e44YvIjXirDvPoElkgGtGpw8RzjGyvDcuj1JWIdjLyTLNXXc4WSh6+h3Jn8MGbcDQORZpQfh3FMlbIUY1YunJ7b/vhgc66FwCDTEAg+363F0I5wbXtiVt+PQAwg/bLnClx7nzvdd5kYhw6qu4PAFJsjV2CJRJbbwtG1hQ=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17400555-0c54-43fe-ee3c-08d7e51ed45b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcGmUssh0doN2DhYCdLzGhHD7lX2YV3zjxLBwh+FIOPfItziXcaZL8fX5RpfG7BR/jbTgzJA7kn8qzIdbQj1PExLnfVKM+wvdSGAlPEuMU5U7ZOMokIQ4nVNaKK38QuGSKp5Cd92M23N3j8BzlVktd1eGCqvYWhbYGY7khrZ4OByvsH2uD+7vxpo03nAeR307bfbsr4dQ0rEekFZN0RRJQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:35:19.2671
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3088
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=859 adultscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200104
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes, Tamizh, and all

This patch series contains several minor fixes and enhancements for TID
specific configuration functionality. The first three patches include
minor fixes and TID specific AMSDU configuration.

The last patch is somewhat controversial, so the series is marked as RFC.
The last patch simplifies current override logic. It suggests to make no
difference between 'specific peer' and 'all peers' cases and to apply
new TID configuration immediately after resetting the previous one.

Regards,
Sergey

Sergey Matyukevich (4):
  cfg80211: fix mask type in cfg80211_tid_cfg structure
  mac80211: fix variable names in TID config methods
  cfg80211: add support for TID specific AMSDU configuration
  nl80211: simplify peer specific TID configuration

 include/net/cfg80211.h       |  6 ++++--
 include/uapi/linux/nl80211.h | 20 +++++++++++---------
 net/mac80211/cfg.c           |  6 +++---
 net/mac80211/driver-ops.h    |  4 ++--
 net/wireless/nl80211.c       | 11 +++++++----
 5 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.11.0

