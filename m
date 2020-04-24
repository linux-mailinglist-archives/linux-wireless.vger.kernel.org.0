Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53AF1B71CF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDXKPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:15:23 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:21604 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgDXKPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:15:21 -0400
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OAAflj028453;
        Fri, 24 Apr 2020 04:15:15 -0600
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00183b01.pphosted.com with ESMTP id 30fxuf1mtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 04:15:15 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSjGieQnDs02OvfmdxeJBWg4nOBBiYqLSNn/TXExBcxnaMPzeWAtrHNmI5wlb1APw6p04EyIcaBJYdnLZIpbRSPzrQF+vpdQ3RI7cAk6Zl19z40+2EZFMZoN0uzZv0vYLw7vFIBOozEmHqpk/n+/iOo/cs3KnZi3t5nodVW/Q64hciKkHwGwgbYq187GSkvUXU1a7JBpuhvGc2xKNmNWiOBH5QmPtsbRWmn6I2k+OI/wPZM7PQJJgj29pj0nwrDFSR8S1Ja1JcKuLshUGAYbOzdWi7CxyjtiZOY5zoKMDplyml22vPUkzb6Wfkjvr/0sEDEk3QRn4S/B8DYS8tZ8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faZIEVXAahT69Pwyo+ZQqpobLItrE8yHBdMftcmw/Og=;
 b=GqvjEOrDWQ9J9R8JGqXAgLEA3u+Vy1nRUYz7A0TQoCBx4bQ7dbDA1ke9Ju8yRyySAUq2Po86+xMBCgaiOuSmuIBShk77ibwJHMiXM7sLGfVfkimdrxNLBHnYIwlcBmMVCxlcWRtfVGe5SP9e+Wy++q5vNHjQ9DUKd/8vxpltfJwVnGVlXWXCU6C7lMQc6LfxmJ9KyFEeHFqsqRYREOx7CIg6K8C4IFquNtKp/D5nidH8AYTvQe4yMO999awnfuYGrwba4v0+RX3JMrCFEHnxFMMD8whfUALK69DL2nl1S7fONN3e5HGs/mui6/H3rR/BQM3dm4dPP4zxdkX8ZOEkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faZIEVXAahT69Pwyo+ZQqpobLItrE8yHBdMftcmw/Og=;
 b=FvuU/+yawagolcqOQPL2OvUMaVA5PavB5N5enhc68ViEcXnS9l+YehcupFF4LVlKdae2ptlvpGkLpzBQj2A67T9i6O2FTmhtDgyKyLEC4Cheb6dMhbMkw9u250322ieMHMvEeLgd+JdEIhMqbaRiBWT/141Ekr9k4GpuX5IoMzM=
Received: from DM6PR05MB5801.namprd05.prod.outlook.com (2603:10b6:5:106::30)
 by DM6PR05MB5498.namprd05.prod.outlook.com (2603:10b6:5:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.9; Fri, 24 Apr 2020 10:15:13 +0000
Received: from DM6PR05MB5801.namprd05.prod.outlook.com
 ([fe80::bd8d:8575:c72a:8191]) by DM6PR05MB5801.namprd05.prod.outlook.com
 ([fe80::bd8d:8575:c72a:8191%7]) with mapi id 15.20.2958.010; Fri, 24 Apr 2020
 10:15:13 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3094.namprd05.prod.outlook.com (2603:10b6:903:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7; Fri, 24 Apr
 2020 10:04:08 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 10:04:08 +0000
Date:   Fri, 24 Apr 2020 13:04:02 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH 3/4] cfg80211: add support for TID specific AMSDU
 configuration
Message-ID: <20200424100402.ty3i5lfqldhrivva@bars>
Mail-Followup-To: linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
 <20200420113437.16998-4-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420113437.16998-4-sergey.matyukevich.os@quantenna.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM3PR07CA0125.eurprd07.prod.outlook.com
 (2603:10a6:207:8::11) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by AM3PR07CA0125.eurprd07.prod.outlook.com (2603:10a6:207:8::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.10 via Frontend Transport; Fri, 24 Apr 2020 10:04:07 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc55c0a-7bd1-46aa-8165-08d7e836d466
X-MS-TrafficTypeDiagnostic: CY4PR05MB3094:|DM6PR05MB5498:
X-Microsoft-Antispam-PRVS: <CY4PR05MB3094D0370ADD65783121E8B9A3D00@CY4PR05MB3094.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 10:04:43 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5801.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(346002)(366004)(39850400004)(4326008)(2906002)(54906003)(6666004)(9686003)(33716001)(316002)(55016002)(16526019)(186003)(956004)(26005)(5660300002)(52116002)(6496006)(81156014)(8676002)(8936002)(9576002)(86362001)(6916009)(478600001)(4744005)(66556008)(66476007)(66946007)(1076003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQni68lOrkSxxbmZkSR6JaqUOuCh849ca96UH8dbj5T6llUV36uiz6RPSGCT6cKj40zPL+XvI0zkPlmAD6yd2iSSlzNnFXZEWEettXkdYrg3W8CJmfT/izTx6A5DbCmmZWJ/prMSjlIKCYkwtCwDBuSXFMGc8ZhyWvMdpLyMW3VSioXDroyy94a23PBaYTgsR9Vc8iE0lYhPTWn68kGWvwaZwXX/rIwf0sDtV5WcYsdwQDB8is24t9kV7JYC2AjDz/etJXPvtF+CoDLl7mD1PtFW5JOUhU1kaKR73tMIPbcdlm5cpOPhNfuMYxzHlne1OQKx/pU1I2rS0OJzGrdrLEgp+3OwflASyqTtwzb0Wyla5dHF8xWUrmHv3fWSi7eia5z/bTcb8/av8Qu46FKL0Vd4yYWVFw0QzTYehSFDd7SESa158c5iW36OIjCu0Pan
X-MS-Exchange-AntiSpam-MessageData: UnwsoyqAB67Sl7n250Pa8ysPRY4n3yk0XwG5Hvkeypj2HxYc1+oQEIJywb79OeBpbaSnM6ggu4uj9K8snNYn+nT3Ke7EMwqA802IsgwTk6NONJs+7kBW0Why8na8n6u0suKEE8yuDPC687T/GeDp5A==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc55c0a-7bd1-46aa-8165-08d7e836d466
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2zYwQwbdypxz0xGCkiQ/cJsf3JpKwZI4toGAKqqgeraZUi9lRBLWGi8t9Rtq0EYRHNzpiCfmTEitSlAHUlcrU6VNr9kI/OCjx5I2Zx9N2XmrcLxx30PLMw8dgdBtCdjX8Cn6KSZ+z4dGnhlLonZjewarqKfs7stDnBx/gxXXt9zvoAnoZV2Jc0sUCreVumM5LddLPJGhe6gA2gicNad6T0pWD8nNJEFw//ukj6XhZg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 10:15:13.0323
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5498
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=515
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240079
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> This patch adds support to control per TID MSDU aggregation
> using the NL80211_TID_CONFIG_ATTR_AMSDU_CTRL attribute.
> 
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> ---
>  include/net/cfg80211.h       |  4 +++-
>  include/uapi/linux/nl80211.h | 10 +++++++---
>  net/wireless/nl80211.c       |  6 ++++++
>  3 files changed, 16 insertions(+), 4 deletions(-)

This patch misses adding new policy for AMSDU NL80211 attribute.
To be fixed in v2.

Regards,
Sergey
