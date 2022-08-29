Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA65A4581
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiH2Ixn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2Ixm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 04:53:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251059279;
        Mon, 29 Aug 2022 01:53:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T72ZhB003801;
        Mon, 29 Aug 2022 08:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3Uv5IpNNrtRsSLlZRkDfBzmFeTpDMq5gvTEsp+NTEQc=;
 b=nNJmFbLqadU9U4q43QpaYTFC1l6jRdXNHZ0xLXfnO0CLIKuk+NRIL2jOGkBsSXZRCtPT
 jWilys/seugbW3X1X1+2LfF3V41K4l0ruJx0Lcwlz6L36tOFbw2FPF8r1CzLSmosOq/c
 50rT5/NCfI5n2GdwV3aN46yxdsp786342qgEMU22eejsHYZA45lrPU8HQHW2YirF6iKM
 4EoodCONy5PegggbIcd0PJjzEE03vMI+oeC314/iPFf0qulMrBGtMZi4tk89FBUUJLBq
 VCj5zxK4DggSX01jHXDnwBN11AU/4BWqCBENompVaWLmKXoVCKJ1bskjpQJlfl/D+PlB 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt2rsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:53:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27T8aJCL034651;
        Mon, 29 Aug 2022 08:53:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q20drh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/lOUF96sCHyLKPVCOfyZ+nEFDq/NnGAjez/6KfKYjd5s97JVIM/pmwgDA8Y9s5GXnbjhPOl9udL9DgeNA53HI9cXNG+bx2qrVdeisWtRxi/1gl2WRiM5jK64k558YOXU5U1JI1QLEnrTgMZsRvPZwq8XNqfBG1deRoYYfsm43kY4vH5Xl2GAW/OzKt9JbP5gGcBrHX0+CSLmRKbsJ9PId06Gbpb8oylQCs5GV0HAkzSOLFOvoTWXwK7mOEd4nJVXWgCygu5js/uNduAHqxduw2MJhBe4NLbcmHoS4M/bj4/p+CmxnYlcAMopG4r/4JqF4hzQIM//PZq4lOGwWPSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Uv5IpNNrtRsSLlZRkDfBzmFeTpDMq5gvTEsp+NTEQc=;
 b=OWou9i+C5MYNIiK4BKWsSwD/R+h8ip2u1VRKh8K5ucxr6f/kFt/HuOKc9cLfdPxBT7k3V1ZotKKkhCp8JmlMMIjV+3aK5lERPKl41R7H/+60rNp4NRDgH8gglcmIVq7s00UYZH3qYw6ITPln8uaVsLzgabn6MadV4hlGztxwGT4Lbtli4SJAuGGNkwJUXFnZ09y3DJUEyMW/Y70Z8bmRp6o5IKUOMYeUOwTILu22nSSGj85PXiBDuI+yahpHfDtcE1XZ5TeU8tYfyG3l2fX16PCHF2BIJVCcCXlG8H7reaeiOmaGQcAjxLO78+WMc+Z4U7+6jolsyLqyHcKHBhVEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Uv5IpNNrtRsSLlZRkDfBzmFeTpDMq5gvTEsp+NTEQc=;
 b=YRs1+6mrpsxCi2kw4TunWMzyW4gCr4HloX6JSamXRanDv98ES+ojL0zeYy36Ikl6ryesZMNm7AdPAT3tZS4u3jnu5AwXZJlvCbTl8fnxxFuPK++7Fzkv2OYb2vePMUcHScmqfPxtgnR9TO1EXu/arbUIjmn7iRgJId+KUk+3BOI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5946.namprd10.prod.outlook.com
 (2603:10b6:208:3d6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 08:53:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 08:53:34 +0000
Date:   Mon, 29 Aug 2022 11:53:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ilan Peer <ilan.peer@intel.com>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Unlock on error path in
 ieee80211_key_link()
Message-ID: <20220829085324.GN2030@kadam>
References: <Ywx7xR590F6lUA4l@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywx7xR590F6lUA4l@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0199.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a199bfc-26f3-430c-32c1-08da899bf4be
X-MS-TrafficTypeDiagnostic: IA1PR10MB5946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FMSazc00iCPxl8JSiygT7e8mm2KIvlhG0luKPqQXSaLFWIFmX8v3+srjIbIMz8hBSBIU8S6P+PBoFfh7auxKM+bYuRxHMoNVyOBqEIYM49+bO7cbTDpvzz/w1tLbQ53iJq+J/11WnPBPijwbla14d37SVHII9oaAHrTvSJvzhNdkywTjOaf6jaJSqlmG8h2LbH3Uiok7hPO57YSvAXMg+o5t6omLmWUt1xF0pu/cxwikCRSCZ28FKum20y8D69gXBYfNSRb1DTwN+p3H3SXyjPmZqoNPIurshePwdV0VpRysDsuNxkS0IaheI4lFnWiuhRlGcO4MavTzrzCLB/YBAuKu4/FkGnMuBYkkvvaJlrd9MWwxEq5Lg0n7mQ36UOItsBiwWqgFTBSUOGg7/d4PB+gPCcnJ8lY3KQAYkhE4glg5O8dXcQUrzAOA08Wun/GQ2pdirligxjgVWemVFcEfGIPwGZQymTligeK4WGSPKRc3Eh4vzVWDQe9/LexjqDs2lukYjzTYuuDxx/ktckNaDf6xUqf/8vHZW/Z3gLcU7d+ijJycwM0akvH+s18ANy1W0Gfv2nc1XGpXxarGftXNXp9omeOo321mY6VEpmyix2K/lRuu+Rs5GZuWWAi0VqwxqtOeOJF7ux21+oM+RXSUORa1P8H3eUIOwpZ64kzrkZ6+fP1dH1vfWHfXf3U31n8GhyVkWXwJb3zU9snQKIyAlLh1OzUE0lHLO2p3FfKQjIvmjaDM5Uv1ZiSJ9kFm4M1XzzJZhW2ye6N/Mrj+7PMcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(4326008)(5660300002)(44832011)(6916009)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(33656002)(558084003)(2906002)(33716001)(8936002)(83380400001)(38100700002)(478600001)(38350700002)(6486002)(41300700001)(186003)(26005)(52116002)(1076003)(9686003)(6506007)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1gBs6XS+o06edyyCzh5M/IPOkgfoONwmOIebjjDu+rWX1h6LbNSS7mZy+Zh?=
 =?us-ascii?Q?hWs0HpylAPyP5mGAhUjQGWd3myq8iMgv6fSJaF4Yk4yO2EPloU7Z0UYyr49I?=
 =?us-ascii?Q?n4TE76cR/aidGO31Tu0ehlV+8gH+dY5kHkoLAS+GXf714lxPjuEk4KPUK18g?=
 =?us-ascii?Q?fID6MRmOmlxqZaXlxOgwhp1R5qqG2Kx2BTlZvPuUy3NhbCuTMA8eD1Ot0B1A?=
 =?us-ascii?Q?CBk357xfEPik3YCJ4cVZFVo+VHy61BcQpjL6m4FT/iQO6aC3HSMOElzkU+KF?=
 =?us-ascii?Q?zbXIb1gRuqho1FLOjgYSiH4XSNi/KkjytR/0UC9kPY/co4rV/PWcbU3k8v0U?=
 =?us-ascii?Q?Rl3oCvggF5BXnIUBaaQ+spAISE6sIACqHjbuxcCN/ImcKdX4o3utSp+m+8kt?=
 =?us-ascii?Q?oSnHX8esQRNa1El8HwAFLdw1VMfoDGXR1DBYg3MZX7Mj3zVKnVT3exPiOjNQ?=
 =?us-ascii?Q?emJVVds/SE7+4bkSY5c33BvT/YD93X4maTZVrlqPb0nYzyv9vKlM8fb2JkzJ?=
 =?us-ascii?Q?I0xVRmrT5dln0cG1w9DhEu7C2SNGTuSTq/p2JU2l54tqPqt/mhLFJpWYz1Ju?=
 =?us-ascii?Q?dTxRng+NAAzax/G/ixeVy5OAuPbkxJEOphXNYtRmU4BtzHjallzANGt4tArg?=
 =?us-ascii?Q?GvplRm5Orj70ja3j2TU/jXF/KGSEs84X5KC+1fj4YOkoB7/oIaANpHGhyGae?=
 =?us-ascii?Q?E8HYHM9z8w2rD6GdTo3m7WgJeVq57gE7n7BjPxFZnFjK/qMBhCSfKJ+Fi1Vv?=
 =?us-ascii?Q?eC9vm26aChpsIwi1cyO0+UXezRdsHJAzXqiTV015rwXjrkvEX/kLpkoY0C+x?=
 =?us-ascii?Q?hFMO2LJ2gSNlPopQJra+Jg09Kxq6nwclsLGx2sojzGw1CzSEXVoAq099AvSA?=
 =?us-ascii?Q?+Zp5q+c+/a+weto8eI7d3Os+qswEzRHtM7wK0WKoYsdrDUk3AVRrGRSR2VIm?=
 =?us-ascii?Q?wQAUxNW14Fok1SwTTiwFQawJG60cc7dXRPxwBQIIsF3BKsUKS4ZRc/BHPyhl?=
 =?us-ascii?Q?39WasNc+8geLgX5J/3w4FQwhhPyPvJSLBkwMb9icVylV99POxkiotfd8IMkS?=
 =?us-ascii?Q?2GGiWEDQTeMBaaT8LVg4N3ubHmm0yWchDCLa8EFaSHiocZ5h8sVyezHlnxFj?=
 =?us-ascii?Q?TZ9kcE15cb8MPCCSyp65YVy5EVbR2qw/X0AlQAhygPwL3ducd+Y+D//VEvjm?=
 =?us-ascii?Q?setcWHSwQZ5Q0f8djshg+xBxmGp/8Vzqm1pNFWaRdmEM2lz+oGPX5862kRYZ?=
 =?us-ascii?Q?0TjZdukdmvA2NfhiONH62fjCVcfxzso+L2uVRbz12NcPPDEFA5Q91OGcDxbH?=
 =?us-ascii?Q?ubyMaH36uCk2F2fkiDNnB2nUNn3jef+6rWzCohNys3rNPHiRciJF/y/F2mOX?=
 =?us-ascii?Q?6/hR9fkzo5z6HIeQcXaEFGrqIBhqQe/CWXuIbqRNu99QlmJ6d9ZwirwWz9+p?=
 =?us-ascii?Q?P4cvkbEB9sBMMNwsAYfenqc7+mgSBFGAiv+BJ2sz5hFkcio/xif29hX5lkeB?=
 =?us-ascii?Q?4FlRj7i7DIKWJzHMC3RiNmscXu7/euXC6JKC7mIkXJhkrm0iTkYCapQ8Ttel?=
 =?us-ascii?Q?YiwwRa9izpNGLYtHTP4CyIQ6yyNOjAgfPxlIoFpzqYv919dTtpPmxbJBjhXl?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a199bfc-26f3-430c-32c1-08da899bf4be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 08:53:34.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uzfp2ckZx9Wb8PKK29JUyN0+3uu4AnAqnpCPgmScQbpkrzM7XFSZWDxWO7bfGXsXOwbwHdyt1EsbitnO8N9B20eIEXWSGq3lxqgjH6E4XUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=821 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290044
X-Proofpoint-ORIG-GUID: hJm3IbTHngEQXUzPqHSzkQ6uzdOrMxWh
X-Proofpoint-GUID: hJm3IbTHngEQXUzPqHSzkQ6uzdOrMxWh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 29, 2022 at 11:41:41AM +0300, Dan Carpenter wrote:
> Unlock before returning on this error path.
> 

Never mind.  I see that Sun Ke already sent this.  I need to make
checking lore a standard part of my QC process instead of only for
uninitialized variable bugs...

regards,
dan carpenter

