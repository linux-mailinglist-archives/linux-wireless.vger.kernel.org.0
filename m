Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806EB4C8578
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Mar 2022 08:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiCAHuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Mar 2022 02:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCAHuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Mar 2022 02:50:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83E43482
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 23:49:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2217Z8Oi018802;
        Tue, 1 Mar 2022 07:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rUuGIbYka93WUD72AAvGSxkWvRp5sv13Ks0mo+/WRWY=;
 b=bTwM6RNAXzYvmH+j+MlvH43qspAgbeybIcF9FY4k29xMp73ebbIp3uZG+GqZ05EvRP7J
 ib5mdtJB36LJKutntxN6vGobw0VZgHIiFc1zSxwHC3p8E5iesAYnP7sVh9isHiI0Fuc/
 b4P5Gk54TIuOYjjI78LaOJ/w/s5wuyhMi+lSlDfHs9X0RG6CGddOR+q9ROS/fPWTUF0F
 VVqORjVFZVUiydG+fHy31MmuvlunT61r1CdWOwmbE0IiEDMtnvytoBQKHYSdrDUPCXqS
 HuH30zuXQXWlNeTiQp2piPyC/fxXhSagcAxTjOzZj1Y6VT9+zMg3Ox0qQbBBgll1m2e9 tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttejdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 07:49:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2217lk9H157340;
        Tue, 1 Mar 2022 07:49:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by userp3020.oracle.com with ESMTP id 3efdnm00jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 07:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZMsKJ6k+NJZbcpNVahwzqBe93dKlKGbckjWHDOeoP1XmMXEIrS/AFgDQBY+YLc3zUP9ZX46rMWS0V2gkRO0IMbcYW4gD7rRPTnxGBM5iopx6TQWxrMfj8Wt36J9KEsrY8Oc4PWjEDZ/wMUrYcLehRfcvGjw51GIDzuTuYZ3n82kz29+UrmMMPrUwZnjHRHAe3xFG93+3PkY50LfrdYj/KqXDwYg2lhxW1ilKMrMmUX5Ab6IsJkO8q/Wty0yu+LsjlaZO5HF2jeUCx/yWtxjc3YOJD7bUXd6rP6MCNSQtfStOSmnedxXoVMWzmslBm8t6lMlkEKnpzE5SUW2/IJgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUuGIbYka93WUD72AAvGSxkWvRp5sv13Ks0mo+/WRWY=;
 b=Loa2r6i0rIWZ9bUwhmXTx5N5pTaw54kiwKkFWGUxz5g4qQ4q27X9IX4XE58s6jLvx6DUM9WYPPD1nPVRfcetew+DyBjFHZXI0RU6HnlEFx27CAnqFVZO8eVw5tXKGbk/lqn8aZAZGJuw+K8feuVBRioES/7CERWdEJeQq4C7AxA9RnRAvRihxr9Kx+lKyUfmwOenXoRsIjTaB8TVWXDSGW+tGETTmF1Yq36ig6jPz2wvJaK16JChqmOMlYDSn+8574ecMcEU9jFU+1bEdlMs42XbXJ5iiBq188ifATiIwj7Mz2Kf5Z4p09EkxdVckSiXdQKQYYB3B5JaYNtWo6pFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUuGIbYka93WUD72AAvGSxkWvRp5sv13Ks0mo+/WRWY=;
 b=RgPl/7HNBkOXu5R/WkikJAcJVMWPHVDPqpPzQ1VTDKtqsN0DJZuPfxoaxoZFA4u2l3nYVCw1760Fa+AnLuka2mt51WElYOpDWNWdyklWO+AnmhJEwrQVY0WqqF56IgiMLMTD6x9OtfPb15s7OKPxn8rGGh3/F3oEeynxE4UJQPI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3779.namprd10.prod.outlook.com
 (2603:10b6:a03:1b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 07:49:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:49:16 +0000
Date:   Tue, 1 Mar 2022 10:49:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     john@phrozen.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] ath11k: add debugfs for TWT debug calls
Message-ID: <20220301074905.GA13071@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f7fb852-b756-488b-7947-08d9fb57fc81
X-MS-TrafficTypeDiagnostic: BY5PR10MB3779:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB377924778EB26A9D18C14E548E029@BY5PR10MB3779.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQu5tvp6tfJN9xKiHoaaupWiwPyvcMqzN+jCbBLydy2T+0VamSbQFnfqEXRBddEV5y9xP65lApB1aqssfBzlqhEBwc01nH9XLhgB67C0TWfCwi2zw4szOG11Zu5SDKhrh2gflLdhZP0wwzE6FdlEtn6yD50io4vWB8SY3rCdexJbdLyVj7ibLsy/wRdVYEbMTdB6hYZECVq5nTEsnoDrx7mMFGGDJ8f1vKLD7oAEYop+3p3OsIX2bZg1H7u7NAdwXW0+MysVtkFQDY4RmXGw8mazdHcJsf7vqi7V0fA60MjynqgNAGJVfECgDhVD6RsFCoex6AtxNoPcFJmhb4uuoZ1q+83lEol3d7J7q2/5C4VGoCaCHc9hw6SxcQiU5bOrMp9c0u3UYwYv4mcMVKblDXrEH8KotfNX47V41w3QOqHFEG/qkV9faFweEjEv/5CbjL7rrqIDtNXg4gAJ/MprEm+gkk4SEL2eWv33X7oq9va0hnQjkCT6ljFUs0rn9+zGTsT/8TpJlsvYtVzksm4LrDOE/DO3rUtAeoNYKqJT64r4ni/uyPZW6o1oIDEGOlkTS+B1R9z/pVNE6VnwLIq92Oc1MrwgYm61M8nwXJVFwf2BJwqBQZqkjmfJvKCYHywFtW9uO+lj782Ee1uoa7wpeG2Gax4c7Bggh/qCqyQmVcb9BppYTDWP67NSjAEExHS3WH+8R1VA9KEZZUUM9YLWSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(38100700002)(6666004)(38350700002)(6486002)(4326008)(8676002)(66556008)(66476007)(66946007)(5660300002)(8936002)(33716001)(6916009)(44832011)(86362001)(316002)(2906002)(83380400001)(186003)(33656002)(9686003)(6512007)(1076003)(26005)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVNHp+zl+0JFVrD45saCAlkDQpsn1OtNSiAjppBiBPM+BjvMB+AD6+ycZ8pC?=
 =?us-ascii?Q?f7oPyKlMd/jYkomHPCWYXyVSQHgH0roKDTGMBErRenu6oVDDIX7n5LiTkL7v?=
 =?us-ascii?Q?ejh+D9EVqSubbup4NiFkbZZ6JU3iB5Z2UsK8vpPk/gBz8oXfWnsBPjf2NseZ?=
 =?us-ascii?Q?BpzY47ZCOOsf6cSHAXtgHUoS/o5YwTg3ioqyDhhRLHa0a07FHmr/nqvry5Gw?=
 =?us-ascii?Q?HKyCgt8ogMFKpcsnC+wGbhvlFtFHjweC6xcGAkkaK5QhR2dPB8MoVJRQDZT/?=
 =?us-ascii?Q?vT0O5eAZs8tvEUWRWfHTOqVf142gtVPbHnqp3hqrEm1MzLLIM1goxW4rl0SY?=
 =?us-ascii?Q?CmOT6EZJK4RT7WI/JwSjiVjdMtQoDqxDC7/bjhfZY2K0suxUeEqKWUtUgBHF?=
 =?us-ascii?Q?1jPT+jz0I1rQVZ5DqBe0U/i8i5PT9/nVhsa7BsBjsFr8dn9Ig8PwfUzrrAvT?=
 =?us-ascii?Q?LSkLWgx66h5+HmvvLVVoX25ij2MgbJXMczhJn+qOYJyC4jxOaAYZa3IhJRlc?=
 =?us-ascii?Q?TDnxOKRnUWcSBG6Ot0bAZvSc5xFnZDwLJpZSsrvp+b9kcjQ+v85fJIf0cPtj?=
 =?us-ascii?Q?rJduls+hNGmc1+v0rSvgXDniJSbz//lNpk+Qg0ScKVYjx2+6Xy6g6tRQbA2z?=
 =?us-ascii?Q?27G2lPMlfzXGT6c6R/hx6h2MphhodaSesKBWRp4gAXlib1YT4CB+jNh9VBl6?=
 =?us-ascii?Q?wrTrtJWWiDANJzj19pnfUhl0OY9SunssRJ5JoUxcfHmv2erSpwvIQhRcwi9S?=
 =?us-ascii?Q?s/4Vb9nH5v+p1MnOtD4+HtQ4iVLITPLjjzuzEwHN6LMCA4cu+fKl10ceYle4?=
 =?us-ascii?Q?KDlSF2wTbgEG2oTTSTZBPBHS7MmuJWjoWRQcUS04WuapdZ3mQSWUApf7U3b1?=
 =?us-ascii?Q?ULFB6xYPYrlk+OK7yjFNzTqjBfIQbgi5J6F+bttQdMnOlf1X25XmbxNcJ+Dq?=
 =?us-ascii?Q?wCPJCFztU7bBdhAhneYF4IagawWwauJ7VJ/i9eTEngpUphesgVbJeHXgSTvK?=
 =?us-ascii?Q?kpdqxjeFRDnoahL1n58Nx05oMjtFJVwDRb8rcT4Nstf1MBfVC06g6sKQZVMt?=
 =?us-ascii?Q?vCI5shlyp6hLCQ/5e3GxtynX+6HI5R7UNIF9l9FKz2N5Gk90QHwLKMyt3exM?=
 =?us-ascii?Q?bLN5uMgjH7WXv9vjXALOfQPMEMbNkRVszLv+x6HDIeq3CzkFC34OYwnGpaC7?=
 =?us-ascii?Q?z9CjhFsw3Dm9VeDkteq4+5Ro19IA8tD8Hlx+MxuZFgFExiWHyrr383cJZeUY?=
 =?us-ascii?Q?SoaTA8Ce6leXM6mDjY4qLlmRnr+qusRffbZjMMT8Ro2cgFlbFZ0yuEL6Z70X?=
 =?us-ascii?Q?yobIMU8LHNzT/LmFr+a29syP29V33RN/q17nqpyl4diAE9+NYdb0Scg5NZ2v?=
 =?us-ascii?Q?jshcUCeJEeD+xQzYwbh8v7t+NKrrJHUrEBmMfHW6/5uAGIzusr7N8Jvm+xR9?=
 =?us-ascii?Q?LOvmhBgx0bPydOcxxOxDsDLxxvbnEffNhoDQh88fysCeCkDbNOjZDhj3OafJ?=
 =?us-ascii?Q?vqU4utNMpDdbZndWXbGD6Z4XQOCDFH2D0Q+CDjs0LgowekWMvfONfcxG8iVM?=
 =?us-ascii?Q?0IYRKXB+C71QCLf70qHnToBT77niWVGQNeIl5vo9HZ1TmDYTRAmkOU65Ie4g?=
 =?us-ascii?Q?G/s+dN+bha+6V5skp3udqiR9vj6LAUnwBCG3S7df1x4+v5DGkHCNMuvONmJk?=
 =?us-ascii?Q?NjrOIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7fb852-b756-488b-7947-08d9fb57fc81
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 07:49:16.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHCOhSNe3RxJjGTZyf8eQHQyFFAA/5Tz+tWcI/cDEjXnF7zQwUjiVxmJ7hQ2Ax4boMY/KWPHJsbvR2preth73nytVxlTkHeDkxuCAwU9Or4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3779
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=780 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010036
X-Proofpoint-GUID: ubSsuQN-g8M1ou5zInrg0TE3wZ9P8Mtr
X-Proofpoint-ORIG-GUID: ubSsuQN-g8M1ou5zInrg0TE3wZ9P8Mtr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello John Crispin,

The patch fe98a6137d03: "ath11k: add debugfs for TWT debug calls"
from Jan 31, 2022, leads to the following Smatch static checker
warning:

	drivers/net/wireless/ath/ath11k/debugfs.c:1642 ath11k_debugfs_add_interface()
	warn: 'arvif->debugfs_twt' is an error pointer or valid

drivers/net/wireless/ath/ath11k/debugfs.c
    1637 int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
    1638 {
    1639         if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
    1640                 arvif->debugfs_twt = debugfs_create_dir("twt",
    1641                                                         arvif->vif->debugfs_dir);
--> 1642                 if (!arvif->debugfs_twt || IS_ERR(arvif->debugfs_twt)) {
    1643                         ath11k_warn(arvif->ar->ab,
    1644                                     "failed to create directory %p\n",
    1645                                     arvif->debugfs_twt);

The debugfs_create_dir() function never returns NULL.  It's generally
not supposed to checked for errors.  This code here looks like a
layering violation because it's trying to check if debugfs is already
registered.  But the clean up code just unregisters on the first call.
Should it be ref counted or can the !arvif->debugfs_twt check be
removed?

Also if the user deliberately disabled debugfs then this prints an error
message.

    1646                         arvif->debugfs_twt = NULL;
    1647                         return -1;
    1648                 }
    1649 
    1650                 debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
    1651                                     arvif, &ath11k_fops_twt_add_dialog);
    1652 
    1653                 debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
    1654                                     arvif, &ath11k_fops_twt_del_dialog);
    1655 
    1656                 debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
    1657                                     arvif, &ath11k_fops_twt_pause_dialog);
    1658 
    1659                 debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
    1660                                     arvif, &ath11k_fops_twt_resume_dialog);
    1661         }
    1662         return 0;
    1663 }

regards,
dan carpenter
