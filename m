Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CD1B71D4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDXKR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:17:58 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:13820 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726717AbgDXKR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:17:58 -0400
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03OABO1J013990;
        Fri, 24 Apr 2020 04:17:56 -0600
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by m0059812.ppops.net with ESMTP id 30k9gr4cu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 04:17:56 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIjfxZ3IKP0yfMvH7PNzQiXRfIURpDuGexoq+QZ+28Hi19nfl8KhcSPuccJ76f6Crsp0lW4bRj0wrQmKP5o+5H2R+eze8L+V6RyS+lCX1iV4OPzbQfoGsvfvEv8mdz7i/VHUmciRHOmCygluRSL9sV0SWWbw40XI81Is1C8NqTRFFqhVkRNoSpQYC3rdopZuMOLk0Vzh9S/foGjJBXylGx79RXasrCMdxakT2PCVDizOY+7Vv/NDjIX/YY6GHVQc+rWBF1uv3WekLpWdVjWYimaxNwE8KMMpuje9qQX3mPamqF8BY1SZ146yYFm6NTAT2JUZs0lSVt5imlJO9rZmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEfLKwI6esgbomEyVHdj2qfGZ9cMnUxDYSdCZ3Hs8pw=;
 b=TOgUphmr0Hhh/h9DDGfl6wo3KN8Z8uX+lDd6Rv11QJIpi9I4uUP/I9Lr/rRoDKMZA6oSpJHXYoPJjjTl3sYA8awgtktMGhuyFqP5Ljgs5tiB+ZY6obwpYCw4OF7zuE8XAHB8tUwninL2KMvT1Iz7kRuB/clkJjOMHtK/UD4ivm0TnuUaYKBlv4mVqzeurbIb9D8JiAVWAlUHMZWs/4AdfLBwJrh0uMzHOwCUGCrA7pD8zDfFufpFvI0hu/b43fseacqGIN//OF30kfzzIqih0AnJJ46owrjKUsEObdzuq+Rbpm7uu2SpaCzTx5HTmOhLiZ/JTFH+FRY4/XFrM2ZSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEfLKwI6esgbomEyVHdj2qfGZ9cMnUxDYSdCZ3Hs8pw=;
 b=jE+OSJ1wWz/K9ZpNP6NewiZU/O3hPPGWZJNvo+e6lp52m5B6ozyHvHE8pDCE0NEbCgAv/Vp/GjJwPtl2M3KUekvnWc1d3ChmbU17Hv6cuu41skHcWlsbNIXne20QX4PUooBOQmztm0Y21IlvS+x8AKcE8qSiSenFq9V/oDUbWQI=
Received: from BL0PR05MB5121.namprd05.prod.outlook.com (2603:10b6:208:83::11)
 by BL0PR05MB5011.namprd05.prod.outlook.com (2603:10b6:208:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Fri, 24 Apr
 2020 10:17:55 +0000
Received: from BL0PR05MB5121.namprd05.prod.outlook.com
 ([fe80::5415:8a6a:540d:39e0]) by BL0PR05MB5121.namprd05.prod.outlook.com
 ([fe80::5415:8a6a:540d:39e0%7]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 10:17:54 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB2934.namprd05.prod.outlook.com (2603:10b6:903:a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 10:17:14 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 10:17:14 +0000
Date:   Fri, 24 Apr 2020 13:17:08 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g
 chip
Message-ID: <20200424101707.nbkojo74vaucq55z@bars>
Mail-Followup-To: Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
References: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
 <20191121135324.21715-3-sergey.matyukevich.os@quantenna.com>
 <0101016e8f9afb9b-7e5241a3-3145-45dd-a178-8f4c9d5ff83e-000000@us-west-2.amazonses.com>
 <20191126075150.e2rrz3jqx627l3g2@bars>
 <20200127083404.jr6k2clfxgv7vxz7@bars>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127083404.jr6k2clfxgv7vxz7@bars>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM0P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by AM0P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 10:17:12 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 002d632b-2505-47d9-0ef7-08d7e838a87f
X-MS-TrafficTypeDiagnostic: CY4PR05MB2934:|BL0PR05MB5011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB2934746FC1A5B6853B655387A3D00@CY4PR05MB2934.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 10:17:52 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5121.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(346002)(136003)(396003)(376002)(366004)(86362001)(956004)(8936002)(66946007)(26005)(33716001)(4326008)(8676002)(5660300002)(316002)(1076003)(186003)(2906002)(478600001)(54906003)(81156014)(16526019)(6496006)(66556008)(107886003)(9686003)(6916009)(66476007)(9576002)(52116002)(55016002)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6w6TVkwZMwky2VFbTMgnMbjPeS6QtAYKOnVQDMWbhG/rYctYJpT2e7d++HerIeikadrlW9xocGamzrnIiwZgsH/ROBOMQEwpykZ7CaNV6ZJy5vkjN4q6OyvlsM6fRzzR16NCvhQpGMycjGxf2TQLKJzYAzWlrhBue8H3f6qwvFGhSQSeRa4Sb/8JJjbyaEFH7+lbqA3+gjBmInYawbhhxQ81UaylY2A6+tBMQF1O8kpEBcp2vo5SDYSKQHQwQriT22JHQSoPFVHLCyjiexDL4Jgi1JrYxU2mb11CXibvP3QDrRMVN1h4sNBBFMIssQhiVK9YFyLy+Htlp/ALRihblEsCZWLrby4pTZddMWlpiayNY3wiBRsIk+NTSFBsy2e0TyQSH2BwLMtABUL7yw+4ZtKfiZ92n/+eFqHfXOC1/PD9IboRTEOpXXG6jNEZkel
X-MS-Exchange-AntiSpam-MessageData: Xz3rV4hhCx7BLUtDS3yggwpUj7qYGf7Q3+8m5tOSho6/nBvWIGjqyTKlQbWSk7JUnAU5GM67nmRn45Cv0sMxN/PwJ/E/aOqBiDKpTNa71zoMje7p3dibZp0KPMOi2QVsks3bcv5LNyQ5cXc2bUS1XIoN6dUZFjS43BGxtMclLfepETCWi/jY+l6MPNTEBVVWijxi0D9IIit5ehwZtozBw3k+qKhz29hX5P055PjLCKmuxe/EEvh/pJebbYhDjEkJ/wkbZXW+G8FpWsiRc2wzuPyp8WcBrbt/IwQWskD7ea6Jeroq/n2DSAb5jquzJUtPOkQnRqB0rLdAWswl6fWLdlEtmnK5c6MRgQB9ufZl/JHE9vyJumSTrnfEujnkgk+KQK/NQgDMiB2mFyt1BnSga9gCnuROIBGT/EwDzcr9VTzchno9Ykd2DqiynlQykQqv8xJWjbBvIL804nFEeAvH2u3/DMRspND+dBP1nS+RTsb6fKI3zRGXiWUyQNm5WO+z4EM3gIFXpucUoTHZEVXB5Vzj2neXM+cW/afrS/aAteF1k4BdleHB7+NV5uTMSJ+nxpijXffNmkYXcCiL0dnaJ/q05fX0uJ9mLLbTS6eQ2S8dHkQsFkyVZy4UHNQ56NwRufRJy64/KAPIcaK4CSflFLOvWV1fgVVCZnnZTeNnwWBUky3ULmQP7xa2jbGTgonQRZ+0n5WkVyGS8+i6rMQFgti7RAAOer8tGh1KHcqZ1yLUGU8Zi7eqzmfXArWULIK09Lhn3lu2bmW6sULKcZx6xmgdiln2+dnyMvvAhNB1G5I=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d632b-2505-47d9-0ef7-08d7e838a87f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hViGyhEoHc4gyacjd8rOvhDtpp/O47evxYpd9PwiK3qx1BtkHOLMOOhMF2Ay5PxTxd7xqix9JpNaRzHYYFEH/CdKe1QbtJULMWSmimXw1UfAfqpnSQac7Ffoby2EArN5OyDPGeVLDvD0ArMecDh9CAsRMWWK2aN05C0Bkx/wMbjGXLJwmm+BN00FkeRVGqYyyGzspFd7nl/K1AlwyqqmPA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 10:17:54.8055
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5011
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240079
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > > > Add support for the new minor revision of QSR10g chip. Major changes from
> > > > the driver perspective include PCIe data path modifications. Setup is now
> > > > more complicated, but finally more things have been offloaded to hardware.
> > > > As a result, less driver boilerplate operations are needed after Tx/Rx
> > > > descriptors queues have been configured. Besides, restrictions on
> > > > descriptors queue lengths have been relaxed.
> > > >
> > > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> > > 
> > > What about the firmware, is that available for this new revision?
> > 
> > Hello Kalle,
> > 
> > There are two drivers: pearl_qtnfmac for QSR10G and topaz_qtnfmac for
> > QSR1000. Firmware for QSR1000 chips has a higher priority since those
> > devices have been in production for quite a while now and there are
> > multiple products available. From the engineering perspective we are
> > ready to release firmware and SDK for QSR1000/QSR2000 devices. Now we
> > are waiting for the ACK from legal team. This was delayed by the
> > acquisition of Quantenna by On Semiconductor.  
> > 
> > As for the latest QSR10G chips, we are not yet ready to release SDK.
> > The main reason is that platform is under active development.
> 
> Hello Kalle,
> 
> I noticed that you marked these two patches as deferred in patchwork.
> Is there anything else I have to do here ?
> 
> Regards,
> Sergey

Hello Kalle,

Could you please clarify your expectations regarding this functionality.
Am I correct assuming that you implicitly tie acceptance of these patches
with the promised release of firmware and SDK for QSR1000/2000 family ?

Regards,
Sergey
