Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFD496A8C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 08:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiAVHPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jan 2022 02:15:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42796 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbiAVHO7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jan 2022 02:14:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20M1uW8S023878;
        Sat, 22 Jan 2022 07:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nljygTROzlk59SLLkN9mTXGsvmscqOD0yJt6ONgZ0QU=;
 b=AA8wNlQtO7BwudmW5FR1Cm2TYLzpFI7pNK3jpg5DEvon7VEcopFVRURnTbBHXsXByglQ
 fRD8p5TveGIZaLgGih3w3b1uQeCRjAMC6noNPb/iytOnbN2K3DnN9v0JMcbN1WZRYlV8
 f/wAKT6L7e9UgFWZiJCkm8eRqyCubhVAVWIXxQdKQlT2iUM6RASgSWkElP2Kbz3VVKfq
 2WAcU2Nq7wcT8+uOv5PJ2cQ6CvxB+S2FJydZrV4BIMvs7xaFEJm5LE155l6v7R8jVKS9
 K1yLW6pqwT6WH4UDVD2MWdjNUo9oguXW1bRmjYLx78hCK4QGvUiJJBsvktco9nLvELn6 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8q38a7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 07:14:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20M76aBT032915;
        Sat, 22 Jan 2022 07:14:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3dr9r1nk7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 07:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQgPt8jUk2sYu6v5LjEXQ8q1bcE5CjQXPC/AceERG1ji9UuMN+DX8SRB54gP2PoVwid3gVZ6McyowZKppwFnSKtMV8Lh/z/AoUTJ43IOXQRVTe5kFtXsg7qjpgxZWTBY4i14C2Irau4xiXwoK/DIdPw92ktyqPiv4g//yMsWcfNMcMhhYAcQLqYTEImcTnj3IY6VOr1LbP6TkUg5bq1eONheUcKYbqf5XRD/h6aL2F6WrEFpY1JJbSP/if1MTIcnsKmc37vcnEy2IszCaiNQrB2FQSttLh9DNOidPOSZno+41au81cRFJw7xbQm4ntF9x28VhEnoMo3pFql9R1FwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nljygTROzlk59SLLkN9mTXGsvmscqOD0yJt6ONgZ0QU=;
 b=QXNrKRqwt9SmiYIcitqYGCQRFRyelI4sJABcW463cSmdNBZDRUdRDN5Qn+MSQHVIYdsP+jzStP5EjcSWp7g6TRVvZ8rfZs2XHWuQGMBZqkK7H+FY0vKdWsUhRYm0y/40r46agiucseIbbPgPT1DjXakVb0gtQZ2+H2Yrs8Nb15aSC/y8xH1/9RMx9cGC2IW8x/xjEoIzc+Y28ukJ7bZXHi0cPQ/JDSsene+h8OWBR/aQxw7teuBHLNFArZ/7vKzqJtnbU3QnJxHZX3gxb2p7wjARazIn5ulyIAlX9cpDsz0B0salZn7Mol/mtEw56/g0yjmDecxlJXcU1DYPbLdmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nljygTROzlk59SLLkN9mTXGsvmscqOD0yJt6ONgZ0QU=;
 b=WrMxIst2JJeAItSTKcVhwD8x94bj3bH2EBeOz/hyzuW9Vk+e//evoMa2HeQQ6YaoMVUHOfhnVSDYP0o70eQcuRQ6oZYaUPIjfQjiDc6eGoWfW9gHL/Qo0Wji/zzluuitQm6AoWora+2OS1S8dG0RXHrTuZiFa4quIJwcPI8bcQ8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2780.namprd10.prod.outlook.com
 (2603:10b6:5:72::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Sat, 22 Jan
 2022 07:14:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 07:14:30 +0000
Date:   Sat, 22 Jan 2022 10:14:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mac80211: prevent out of bounds access in
 ieee80211_rx_h_action()
Message-ID: <20220122071412.GQ1951@kadam>
References: <20220119125923.GB9509@kili>
 <ea8638fcd820e5b777bc6d5befc5eab9369edbbf.camel@sipsolutions.net>
 <20220119150733.GB1978@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119150733.GB1978@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e3d213-6f47-4841-b2e0-08d9dd76d4d8
X-MS-TrafficTypeDiagnostic: DM6PR10MB2780:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB278022C8B8D622296C9866B68E5C9@DM6PR10MB2780.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZMGh1F7w0z0IDYqpIWyGVR68r9GvaHvX5gBZ+BRtjEM6ZgMA8lv3drEnsw1I8OTVm9fDt6ubqyjVUqr4YwHOCtJMRryegnmSfrWZEx4d/d2WThnGtxDbNnSTa5e1UQ6sR4hQ34FadhZNWNiVcZcZiFsQqSVj7i95f3Lk/khc6tpTZdfTR9JxIe9/MI0HQC0B5dAAdTMo+3Nu/CEebaRNgsDUH7YD07OHfI/cr0xzF5o0hgg2ukxMqBB/nXzTGUsBUFlSOZxYIDFbY2rBIvVMNchCaEaDjHSATeprDbduQpV2Tqr0sgRH4RZGvZyLArMbsglvPabZLOSw/RPVceOi6EJfpoGAbvRYxwZ4BPtnze5UK1bNc93vkVNuq0bAB2LUelo7yZ/OQyEoyd7cjbZ2UtV7Ffo24+z/yJrah1vCTxcuG1zhKXUm/ZCspQiiuC3wrV4UgK8U8mNLDn+O0M4DQCqoHb70HPPkcTQTyV5QmnnsTOqDTbf5+GjDFKGYQdBZlxgzjdGMbEKNDK8bUgN5pUztCrkxNqoQbzv/GG7rh988kPJ+M8SqDAfO474gP3oXAWUAZlLAaDaO30lhX0sumg1KQ91nNO9WnNW++Gd27YghDbrJlIAV+9YayBYbXzidAzS87Y/qitR9QVv4d2482hFTvr0xp5ciAOjK4/6OE+9JZHncMEXgk68MvpBb7W02f08Q273/Qba+NfAOwjbAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(2906002)(1076003)(6512007)(558084003)(5660300002)(66946007)(508600001)(52116002)(6486002)(8936002)(33716001)(44832011)(66556008)(8676002)(66476007)(26005)(38100700002)(6916009)(86362001)(6666004)(316002)(33656002)(4326008)(38350700002)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zfm4J0OG2ieuIa+kUR/gCXFQLB74J+iWm3PltxDzqh1L1IJ4hfKVVHk4V4Vn?=
 =?us-ascii?Q?IAEJaqJaVrxc1zoLOQT/hCeWfudJSC370W2fKF8o11zF0aBYoWZnq4lBpGjm?=
 =?us-ascii?Q?HjCyI3OCoO1xeubFNzT1OIv3tf44hONZ+wtvKY196mrhYnnhdNOsGYYgvcsu?=
 =?us-ascii?Q?1GqLlJBvjwPZ1gAsGkrBIz9+qyEZHFEubFL+ajayA9dMowzeX5SfP1SA1bow?=
 =?us-ascii?Q?VUATTNBdOG4f6EJAZDlQ5UWPT6aA2AV5ixzIDpZC20h3+PY7av2c+2cjBaHq?=
 =?us-ascii?Q?RFkUSF1fa9ECujAv4PDAcfhieXdv+fZi5WDpMh+94x3FAUPyo0pKCrhI9Pa+?=
 =?us-ascii?Q?TD4Sgi8tj0PZUF7JSpZ+Vl3XU9gSVOHiOi8G/sHTEr5/0Tg+6tVDr0WveX4k?=
 =?us-ascii?Q?e8d8tn5kiUfsNxukcStf0KN+ieNl4U01QU/JHqoK/+u09JkwtsmHCPyHKfIS?=
 =?us-ascii?Q?MNYEdLr5FioDhYrRRzrmfZk7iNVAfI9wv6JYEDjgG7CPhppYJX6n6TXIFNFP?=
 =?us-ascii?Q?LBOBslkd3pnnsFg66PvTg5Xl4MxqCjJl9QpH34/QRLlhe2LAv+zRIETk+dtx?=
 =?us-ascii?Q?LMRG072bOGedMMNuCdA8hXO1nsvStLKr/3AYJrBkMvELit8JE9kCS5l1ChJ7?=
 =?us-ascii?Q?Z60Q+NfyQ72NCuFHHEVh9a1+p4lgK3tod8HIzzYFMaxtoOfRLQFPjVMVjeJm?=
 =?us-ascii?Q?HMRG5V7n0pMEZm1SLBWl/xLnY17feQglgC/gr3I7FiD81xBCn2a0W89Sg6jr?=
 =?us-ascii?Q?7Tj/DzRgBdsc/BRztuYeMZMTTpOBv3Jv5rZ8WyQP161dB3bChG4FgajH5TAt?=
 =?us-ascii?Q?V2qhNJ1N1tYk0KVpA3m/T17aCVBjmZg8Ls47GHIOGB/Eq3SQ2wCOM5UygsYa?=
 =?us-ascii?Q?Z78YjwHoiKR3byObCnfbJg13QXhBCfv/VCmfqTU5WJ8f/nQ3rh7JkyPgKFSE?=
 =?us-ascii?Q?VDpwxqVhawQPSU5xn3Uesey2WbkA7tlSWUCPBiDuI/C/25k3BxPgsGx7RHXk?=
 =?us-ascii?Q?iAqYv9/BASZDTzR95TBhTlnUASxoP0GYwoqRxr6xcwHNRxaSoaA3hlkfqYsU?=
 =?us-ascii?Q?Rhk6E/Ajak25EcG0bkbyHtdPhHj8c2H7oZ1REJdSQ+ArSflW+5WHR/gcDxKE?=
 =?us-ascii?Q?vaW1WCLROK9LzSH9wiO6ailB9xk7azxt48DpDK0XD9hJqYu3aFxYZvLrVXT3?=
 =?us-ascii?Q?OR6sNQpQPCSqhoHACBfdMviJc33JvlELZhBhFwwh0IoQ6eRH+F0I+ShYxLUd?=
 =?us-ascii?Q?qeWtW5+vhMkhnH5qVBgXz00r87U/W77eLCkSkO3Pz0wNdCDsTW6F3su3kgK4?=
 =?us-ascii?Q?l07joMGn+OWTMZUXLo/3gSoS6KkC9BWpnR9xm235YlP51boJa2G+LjYCbH4S?=
 =?us-ascii?Q?neeqUvPl8uaX3Fvx90liu0fL6+a1TwQhRi3r6U9x+zQ8p47Q6O8w/0s/YuEH?=
 =?us-ascii?Q?OTrcXORWGIUftLwCVno22Oi+/R/WY0N8FUohDZBIf15ApBTEHtsoaO1uuKvQ?=
 =?us-ascii?Q?Yd800cpieOZDMx3e4HKZ9x3JJatXuMJgnbLBUdrtuZVUudxmI4/XpPS/TstE?=
 =?us-ascii?Q?g/qkXF3uVpzdI9pOs9Mob1wZY1aqcCPBUc8WGKa1TIdZKRAxuRG2aIp/BpXD?=
 =?us-ascii?Q?Zj+d5xAIuu2UrtwZW6og3bgQH4q7uBNMUyu2n0vhwK94pj1lvM2X6oFZ8aoL?=
 =?us-ascii?Q?ho7QO2xMsex9fS2XDNSsITzw6Z8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e3d213-6f47-4841-b2e0-08d9dd76d4d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 07:14:30.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQb48Pra+eWVHsPTfSoOTxmg3U25n1O/j+QXU+HmBjEVa7NGmAopzPesEhyD58EjOSFc6H9EhrLnlMyZo0iUUcXEnVXXW40DHACX+5sLLoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2780
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201220045
X-Proofpoint-ORIG-GUID: aSU3mgwmX28xNm7AUKCC2T6tAW5jG2FZ
X-Proofpoint-GUID: aSU3mgwmX28xNm7AUKCC2T6tAW5jG2FZ
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 19, 2022 at 06:07:33PM +0300, Dan Carpenter wrote:
> So, yeah.  It's skb->cb and Smatch for some reason thinks skb->cb holds
> user data...  I will look into this.

I fixed this bug.  I'll test the fix for a while before pushing it.

regards,
dan carpenter

