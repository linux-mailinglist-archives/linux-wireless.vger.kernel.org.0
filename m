Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF1581694
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jul 2022 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiGZPjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jul 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiGZPjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jul 2022 11:39:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ABA2BB16
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 08:39:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFXrMf015574;
        Tue, 26 Jul 2022 15:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OXFKyybQgQBrHo8eakkfTxgr4EAMY9WzEpF+UVjc2xs=;
 b=1CFEL2EnNQrEbjzSOxUjhu8ZTt5ofzs3qz9TaoGvOtxkDrRZMGJ5lQZtai7zDSlL+Fvi
 j8Vf3IyJq/xILpvijOuDGd+FA3EBjQQWbj74vgm31IizQdKwd6+/x3f0Nk+AlmN/YT+z
 m/gDLA3QvJ/ni3jLTnDF4efqgTlmlLfmG+cmFnndcqN6nKV8aRbiPkHLhzzL/Yvp9bXa
 AGNyabgJAHvdBfDIHzscievyjqYUp0oX3Aj2a94ICBZQMuhyu3IVaALN+ccobUmQbxG1
 CMh+ZkaR9wAdt/O5jeX+inEhm6aX+P+Y5+2yGD4/CwhEmvTVAtPyaTHZ0CVTf1Nros8k yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940pr5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:39:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QE5gsH019766;
        Tue, 26 Jul 2022 15:39:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh637xxmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc3RkYWzxz2tRwnR+CIzc/lIYMweGOflJkHseGnW4r93NgKq7yc3Ene28U+8Vf8HhbVmWGUHWFN9NW633WL6EIDxZPLJxadjHpY/K16e/C3Fk7hLGrpI/pVRFumO4j4gTBVJ5RcDoLaofZnO9LGuqHvQEaVLrA3BnCQCPbeXZcHMbYW+Fv1SI0E0b4yY6/ru00f7ua2UWgx0+CFgyVt9pyvXoDFMbxcuwjfQuiNx3kWaSJ09wm7zzz5g+K3b05WS2dobNJUdUd54ien/C0UAzxfGhX94jN/ragzZ20g7Pv7cpG7agkInFivhUT4wZltyPbKyQJyFOceIMUBSuxxFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXFKyybQgQBrHo8eakkfTxgr4EAMY9WzEpF+UVjc2xs=;
 b=ULl1qeqP1Wf6uj3rZqi3L+P4h9Ni0uX8UXIU/ccvHWRjH9q5LkOJ34+y9MGp2e9OtU0ZZJeWvULCVcgqaYFfFqCzzUVl5jeRteOdk/oT/kqjQTfUgPzE3N0CfzbpwjurQUWbQNeyMo1khJzFEfPNqO4P7bAqShP1pDXIjxrQb1E5q0DEM2wqAjSWsrVRma3Nq51KWIAGWBDjRJeS9Y6Wk4orqLn0++mQCNAH3+rUOjWtCf+mDt3Bk/0VSSjT40FgQRiHoMDeO3R8fMSYSoaP5hSH0YkzBF0e+QZEu2fPohZ2bN8W+zjnXgcd8ph3TxBcENCBigPc8QeJOehW8fyNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXFKyybQgQBrHo8eakkfTxgr4EAMY9WzEpF+UVjc2xs=;
 b=wwkBQs1Pmn+7ruzBftbrLSL5w2JklK9V9I/lPfyKPRAv6QeoKGIfdFGVUft3g0QEMLBcH4EfnG2Pbqu81abDMRQkfyp54jf10Grm1zii49siZGoHMX/DK12ngK/M+7nyHwqASwh9/4KimGMGFoQMKVvXdccN4NAKvQu02tro8lc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2755.namprd10.prod.outlook.com
 (2603:10b6:406:cb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 15:39:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:39:31 +0000
Date:   Tue, 26 Jul 2022 18:39:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] wifi: nl80211/mac80211: clarify link ID in control
 port TX
Message-ID: <20220726153915.GP2316@kadam>
References: <Yt/16E0ufa0D0Ziq@kili>
 <5cdc7a91910a803ef531ae04ba330541476c0f18.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cdc7a91910a803ef531ae04ba330541476c0f18.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b99dde-ba0f-4bbb-4765-08da6f1d0880
X-MS-TrafficTypeDiagnostic: BN7PR10MB2755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nc57Ux75f08AQlEDloaOVMDL4gINk+4U7j0f/i4ypOLN6mfAUmZMXHEP5TMlz8xqdEP0NrdrpNKceMnFBn0yePXahVadlpVxeFLSyvW8oUpan1+COtraXnnL3OBibAa1pZkqL9lmDfKB8mlvJfmL9eD+bvaVzNSTP+DlXhE/3Blx1MnOIpxJvwZITcKezZeK7W4VJ6TU6LXJPCgmnt219W9ZhSqFSm4VoW06Pzt8j1Jfesgyzwg4tpXbRdGe4Tj2fZF4Xe/bk4ZkCxHPodjoMUJ8wJSfh7tUOfVxuwlcQaW4RS8+e9Z+BXPM2BzZ0AbX4wRgPfLjVntpgTwxb3sfIhOW9tItQxyYk4h7SvgdFkjuvUVYEqoOXuiHlVsHWDEcoIJtU4GHfaZOsYWeK94f0by8qhKpe7xtxY0r0NKrlYWvzzSCimMgBk73xWohyq+zlBP51Z3YXvWv52boL0U2iy/YwctKeaJv0edNx11RXl+QG6rdSsPTx5MnkE4PgF6z9BDXCpJT1eMUanmdPHJdHokVQqJxi/4ot9sDN2h0/r0s8XYBofBLF7XdTMyxz5O/gySiP8MU2201KrNE38adILQXfxMR6cVMtSKm4pxo0hRGQeWbDlsNmp/74Wfs9pqiNvSz4oGdK33G5I8yzxsk0rLoEWKE3uDYF2frUL2tKBfbGUiOA/aEsNwx9CEAREgdDohroJGd77GdehtRNzBJga3Ia37vOShXXiL9CnxjMeyoKNRPBSRjfRuofG+vJjvdUEw5j4RUH2csv2k6Sfg3SwPzBr1uSKKvfl7DHUqI7k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(44832011)(6916009)(86362001)(52116002)(6506007)(2906002)(8676002)(66556008)(66476007)(38100700002)(66946007)(41300700001)(33656002)(4326008)(38350700002)(316002)(6666004)(9686003)(26005)(83380400001)(6486002)(186003)(478600001)(6512007)(1076003)(8936002)(5660300002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVtRiKqQnVCk9v82ISm+r+xLu4eCiB/BM0EeRhpEu1DqegrXx72+tYpnjNi+?=
 =?us-ascii?Q?enPIez8Wwi6V8stI4vi0SB0KtzqC6jgR43VDcyULkDdLVphoU/f8n3KulNge?=
 =?us-ascii?Q?o79FgdlAEwl1Ygv30gpkv19hdli7jMzb6/R+2HvQfXgRzLqrwZ81+ciEm3sZ?=
 =?us-ascii?Q?znk+XIXWAwDZpgrsu1qAYZ1CJLmwRE9NwEOojG9myAs5/Hxrad6wScFEo2k9?=
 =?us-ascii?Q?GETXdQ5wz3BB1U0Fjcpcxn2xfD4lwh8P7oC8azg3Q82LaT4YwhG0PRJ8Amo/?=
 =?us-ascii?Q?NJXg6Ooqdhu22WGARB6J91YNQ0lSDcjiUVmE+VlCpmux0+5N0fmYcbDWHRvA?=
 =?us-ascii?Q?b9iMiFIhpThYLYHvM3ongCOQScY7LaQtVSg6bed2EUTAz8a5d8r0bqBjWvJ9?=
 =?us-ascii?Q?vKfJaHoXQJdT8e/fFGXT9gVfjr6OQu0/lincuhd97pSRLtXqWUrP38isPOP7?=
 =?us-ascii?Q?gQ2Hjv5dKI07zc1ks/3XmgtObGCKtVHzQNL/IdvmAEiLKC56Wtam8L9Sh25P?=
 =?us-ascii?Q?jVRk7qmp+e1W/bXXYsZpWzVJajsC9wrWdDMNNrf30qYO6waN8KV27tLr8kgJ?=
 =?us-ascii?Q?2f7xQJn/gO7Zu/dz6New3cPWrynOk7Cqe3IzyUrlqh1URdhDd87HsEiaRoKm?=
 =?us-ascii?Q?yOKtT19cdTHajgkemVETvrH/1aKAMAvgp0FnB/VQJw5W4RAx+OQywnVu3cM6?=
 =?us-ascii?Q?pD9NEOXxlPTlMBhKK3g45ToKfwV73UIrK7vQUmZXyas12lGJQpmWujvKRbRX?=
 =?us-ascii?Q?XHDV96LXn3RjEspnxNc0MK/JLNTZeI0eRvAnuPShDOQAeLtzLo3VF1dhT01W?=
 =?us-ascii?Q?r0/Q8Cxk+UV9xpPIxMfUa8zDSGIPdqFQWOQI+3cfvJXaiAbL+NhiUAYroYIm?=
 =?us-ascii?Q?N0m+4Hx6HMmM+4R9oWMU73HwmBX8Jd3sdLiAn/DtHmlgGc9dx6A+cLFsZpr4?=
 =?us-ascii?Q?Trc7CqiG9d4gCkNgVm1GpsabUzlbzpRmtyGm30tOfGjHhlGmX+FwkKSzsnRF?=
 =?us-ascii?Q?Lv12h80qOkKjA+adk2yGLl9jl4mtVa37TyRG50CTuBvZhLXXEDI2+iKCV8D7?=
 =?us-ascii?Q?5uv3Wr09HTMGMqcWxoxr7wjMcyAmnYetkPmkyofpMKIPfwcDr2U2p6oco+/r?=
 =?us-ascii?Q?FvDPW4clkO4rHasz3shHQnUE1mcanirQgrUe2ntN9iurDzcmYUJzCH7RMgby?=
 =?us-ascii?Q?rZ904OajsMQJKe35g3sYOGlYK2ELUYc7/viWx7zi63j2P6zyaCuCICmfRojR?=
 =?us-ascii?Q?SW7DEbId4VxRVXd5yKLeP2mxU3/APQYjt3eX5K0b25zdjlL2A7LdF57poWp+?=
 =?us-ascii?Q?IVP0OciiYU80bM3IhW7PzjNFye7PNU9jVHSGcWQjnQi6Ux097e6/nQYkJDZT?=
 =?us-ascii?Q?f3aOV0ct5WuRQ07s1K8LBZ3QgITNdEiWuro8PNpOJ1c846a72zMjUBXjh4Ce?=
 =?us-ascii?Q?Hl8N+Qb0Gvy5abMf6eqqrxIHJ47yUSn7fE1a7fwYl2OChRJI7hD4/iX3Mfti?=
 =?us-ascii?Q?GCJWse1xD6lc+SKU9IqUg2d0JTlvuKry4QfljpzDmXFNxv6WSiJhUtJghk3Y?=
 =?us-ascii?Q?RHZw4wW1pKmfAIcCz6ZbRGjnp19xxGUoO/NP7aal0ikuWsnVBtFUoBexXYmj?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b99dde-ba0f-4bbb-4765-08da6f1d0880
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:39:31.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypv+6xy+aU8ETVWk7L0EFBRv6CmCPfe6eCvWJcwAKWFst5dFrcq/5tCY+6vpV2cKnKlCZZi4N2e0Vn5eAGJbKF7L796NLvQyiPXSo3zno04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=686 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260060
X-Proofpoint-GUID: U03s4NKnmVmNAmVTYVGF08UCAfdHntJX
X-Proofpoint-ORIG-GUID: U03s4NKnmVmNAmVTYVGF08UCAfdHntJX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 26, 2022 at 04:42:41PM +0200, Johannes Berg wrote:
> Hi Dan,
> 
> 
> On Tue, 2022-07-26 at 17:10 +0300, Dan Carpenter wrote:
> >     5885         rcu_read_lock();
> >     5886         err = ieee80211_lookup_ra_sta(sdata, skb, &sta);
> > 
> > For sdata->vif.type == NL80211_IFTYPE_MESH_POINT then "sta" can be NULL.
> > Smatch doesn't know the value of sdata->vif.type at this point, and even
> > if it did, then it doesn't split the return states up with enough
> > granularity for that to make a difference.
> 
> Right, but that wouldn't matter anyway?
> 
> >     5887         if (err) {
> >     5888                 rcu_read_unlock();
> >     5889                 return err;
> >     5890         }
> >     5891 
> >     5892         if (!IS_ERR(sta)) {
> 
> Since this is all independent of the interface type.
> 
> >     5893                 u16 queue = __ieee80211_select_queue(sdata, sta, skb);
> >     5894 
> >     5895                 skb_set_queue_mapping(skb, queue);
> >     5896                 skb_get_hash(skb);
> >     5897 
> >     5898                 /*
> >     5899                  * for MLO STA, the SA should be the AP MLD address, but
> >     5900                  * the link ID has been selected already
> >     5901                  */
> > --> 5902                 if (sta->sta.mlo)
> > 
> > Which Smatch complains about here.
> 
> Makes sense, should be "if (sta && sta->sta.mlo)" then I suppose. I'm on
> vacation now, so if you want to send a patch as a reminder that'd be
> nice.

Sure.  I can do that.  Enjoy your vacation!

regards,
dan carpenter

