Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01FC1ACFDA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgDPSmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 14:42:00 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:5042 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728815AbgDPSl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 14:41:59 -0400
X-Greylist: delayed 789 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2020 14:41:58 EDT
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GISNB9012954;
        Thu, 16 Apr 2020 12:28:48 -0600
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00183b01.pphosted.com with ESMTP id 30dn8d6ayj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 12:28:48 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWKKVnxcqOmv1EMp4Gbfettxoxk23LlHw8k/XHc+DNTD/4USvak0w6qmZMbtfKRJ5hRP8shjSIh4Nm5skTn0rLqHl6C2PbF2XB+LXLcPJtHx7UYjPnaM3mGm+57Kf4zOJo+XICBpRzqwoazDkHoRH10VMNPW3TqTMSIzTTznGQ/ckocUF9+N6kl9leBL/gXeQW2B6IURFP2FVfcKcyg4bie8jEQ9PZQce1iDWBXoDFWt3QKe63PyLYYzOIYYm9dTGq65MdtBMImejiBj8YAiBnGdXO4495ziUAYYD8oZ4DKfHmCQoGEeySZlm5abtTgCSnf1qxK7hICLOi3rse9wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvUYhPSGvgNajQ3xLXSoegi7378QX5kpa4y/Mbu7P48=;
 b=f4gmfE1jYizJSX9H+X3K/wJBJgNPFGnuKkDbhHdAOLyMrEl0cIlfbDwhiMW0K7HoGVbAzNer/9mK4CYGCd3IIjIpRS9gsx2r7HZMMrRA89g8GydsNmCYr58oTaISbAPszVtn+9N5keo7CKAs9yTyR7buUTmuXUNPNrst7UtpNQG4SnHJUvM0zhz0VMtXKE+XYwLR8HMWyaDIIfbec3UZdOTFduHf4flBDcx6yAiEX5FFUK8JA2fD47sBno1MBKDkuLVLTsNrF3vpvWag+x670vIxjXL9HLbyZkXIQgGPXS7V0rdS/7Y8W1Q8W27cQ7QuCQQtOPUSVFRmC2+3t3otTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvUYhPSGvgNajQ3xLXSoegi7378QX5kpa4y/Mbu7P48=;
 b=sEDyojkW8uu2gB4dsxZupsmcQc1U/jpCkAc1i8NAb5SkwTxEO2nEizb8qHI++Nx6VCl3A3tR9n2rTlZZugcAwLb5jnx89zaw7GNs4jzBKb9H9PJgj0gsG2+CtcuATaU7SBarkE8Mrq0c95i1NfnSXAcsNS1V61hCL65p5CD+mfk=
Received: from SN6PR05MB5695.namprd05.prod.outlook.com (2603:10b6:805:101::30)
 by SN6PR05MB6302.namprd05.prod.outlook.com (2603:10b6:805:fa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.24; Thu, 16 Apr
 2020 18:28:46 +0000
Received: from SN6PR05MB5695.namprd05.prod.outlook.com
 ([fe80::1053:d922:d99e:c3f8]) by SN6PR05MB5695.namprd05.prod.outlook.com
 ([fe80::1053:d922:d99e:c3f8%7]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 18:28:45 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3062.namprd05.prod.outlook.com (2603:10b6:903:f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.24; Thu, 16 Apr
 2020 18:28:10 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 18:28:10 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>
Subject: [PATCH] MAINTAINERS: update list of qtnfmac maintainers
Date:   Thu, 16 Apr 2020 21:28:03 +0300
Message-ID: <20200416182803.31201-1-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0130.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::35) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0130.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 18:28:08 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf2bbf1-c638-410c-6515-08d7e233ea71
X-MS-TrafficTypeDiagnostic: CY4PR05MB3062:|SN6PR05MB6302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB306254913290B65575369D97A3D80@CY4PR05MB3062.namprd05.prod.outlook.com>
X-Moderation-Data: 4/16/2020 6:28:41 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR05MB5695.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39850400004)(346002)(366004)(396003)(376002)(86362001)(36756003)(103116003)(52116002)(6666004)(478600001)(66556008)(66476007)(4744005)(5660300002)(1076003)(2906002)(6486002)(4326008)(81156014)(8676002)(107886003)(316002)(54906003)(7696005)(2616005)(956004)(6916009)(8936002)(16526019)(186003)(66946007)(26005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thuB2LhmDcUJIM/bKgSmiSDn4kGFlk7+QOhk4oEW3LtmfgaTabE3NJoDp/BX3uBbe5AXviLvvKL9cYsH5IA5WAgEZy0xbTAQLSHC8uiCLRbO38+FvzcWD6t1cdOwKkG8O1Hi434lh/bnqMWHWwJmQH+7FsxmUMpIqVj4SFzJv3EUT/154dEg1wzv+qpuOdgQmJjTzU/nrNC/1Gisdz8wxBDiAcClZS8H09Xh2wjoqVmBVuXIr7HWfQmhEybTICJKV5i7rCRyfiv5OK6VEoJ2i398zrPIpVyYiOj04svjFASGBhKOQhG+ZCGq6rJJ0EC/xPCz8FH+eoOJtO20BZgtv5MD1V3UUal6KuWLPhqhNY+jBNxvvUeo0ZmSnndOhadkBCE1ecEWbl6kqIRZXVwgQLP2tMMO56LF3SXKsDxiFA6JRxsBf21hHtMPrynsoMs3
X-MS-Exchange-AntiSpam-MessageData: XCmefhRkBxvkKcA12ovBrJmIRGNeU3g7k0YnyTOhzxw+wqC+4TzoqRH79lYLeB0QqCZ6d81O0CHqjlOhpdqnmnJH9+lfKGZ8wRyedrfNx1qIWRfn9+/5tGbqLMgYfNjDkVIwc6T4Hf2vCwvYlR1SGg==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf2bbf1-c638-410c-6515-08d7e233ea71
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf7fPkIlqDdjj1qN0UoP0iC6sn7Hzv1PBpSxEu4kwhHHTBXmuE78SEu2LG626uAOJTIJRtBZeMzAMFqLyytH36hblGGegbZtiTB0ZLjjw2QtUA6TZ0LxXtAEwabJly+Yhmt7z4DkQc+Brl5vADGnqc34LnwHa9PpFgBdF2dCpdKGJiy5JYB7c4Ysmb6Q5+daavXoqQVFC598anaNSPS+LR+rwbP9CrAoL0zpdgdAyqI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 18:28:45.7920
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB6302
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_08:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=1 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=488 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160130
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Removing Avinash since tomorrow is his last day at Quantenna.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Signed-off-by: Avinash Patil <avinashp@quantenna.com>

---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dce264bc7c..190601def17a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13925,7 +13925,6 @@ F:	drivers/net/wireless/ath/wcn36xx/
 
 QUANTENNA QTNFMAC WIRELESS DRIVER
 M:	Igor Mitsyanko <imitsyanko@quantenna.com>
-M:	Avinash Patil <avinashp@quantenna.com>
 M:	Sergey Matyukevich <smatyukevich@quantenna.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-- 
2.11.0

