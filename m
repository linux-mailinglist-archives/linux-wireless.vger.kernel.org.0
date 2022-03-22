Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9914E38BA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 07:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiCVGQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiCVGQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 02:16:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7A4A3EB
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 23:15:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M1EA5l011585;
        Tue, 22 Mar 2022 06:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=giN/09EjAfWskXR6+KALnOgtaRQApcFZE8ugpJYDkMs=;
 b=lw4Rf2FH0LNQUjoaPm9hFv3H62Fm6uEPDagdRbJh6YKGyKR9YTlDsiaiyJNznGoHnViX
 XpEPoM8qGAvKFE580FNegSWOJFVrfjGJeYCv+KBFd++V9NPw2E7bjbXDNuwJkGE7wZm6
 /N3bh1klKlbfoexs+erIUfxUpMAB6GEZPgrgLWLcAh4HEbcziPvAJzGRb7Pxe0+VSVTZ
 HUgxBsQLgiKshUDLGDNQG0Mmm+qpOO6QgP3ZtAB4kSdoEB/kfmrvYMnN/tsBUWQfg1YM
 QU+vfCqJaFvwuSWuIItIU4fgBxLnKiKFBbdgi6z7BoWxKJyuIgbAw4lkngAlbDXhWkVC Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcn7db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 06:14:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22M6CMN3120667;
        Tue, 22 Mar 2022 06:14:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 3ew700vecm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 06:14:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+o2TDY4FYfHkJrxfbnGcLkLQq1Rt0udhwbQqC90pKqkXRnGekjGu/mnlgIOJSsAA0EOxG/LJQmZvD4hI8vOyMNptdVr16Dc1B+4sfmE0sNW4tHW5EjLp8YXAF8v2csn7AD5GgrQHXib5/ZGbbQYjDQqe8l050luyuQsrRVO+i7AApH9KjgRXBpOeVTTC+q8r0WGOkddedDof4YD0Nwyq4F1vjZmgOZLvgIPfYaD1ppVnu7zk+oOS2ZWMQ8Cws25A3ovI4+XeYqA5dpopLnUpjOBu8Wwu7jwTbayU52Tm0cggzmtPCqtZxB3N9Ne9WWT0m7b2s7/XWCr+BIAHpTTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giN/09EjAfWskXR6+KALnOgtaRQApcFZE8ugpJYDkMs=;
 b=j62LhnwhEk1UnPN/oVIQso8pbNBRhtx3JeT5q7XhkHZORrYgNlA4als7TBoZtpqtUc9z4QpxfVs7535+SFDGVd94aiC1obeBIOicCzsMTCakaA5Oj+jEfhUUQcXdja3ciMdspIh7r2rgilX1RgVCt3VccDMTnET9gD+r2jgNIUM2AdszmU9tH8c3dYlfJ69Sqwe7aahbRNLzKF4dfA+X/uyuZsvpl9KrzH571o3m77us235TWyabd4Rb0c51NFnajpIB3TpVVBCkr3EQwgnBQXiWvPI3cacUxBLMt5FUjXeYb4pzvv6nMzBB21scX+v+AEukoNyNw4srrV3cldUyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giN/09EjAfWskXR6+KALnOgtaRQApcFZE8ugpJYDkMs=;
 b=jza8iyObQj5o0v2OgiT8t9jXj7VorKRXk3IBqa6a2uUIEGhv/Xu9t+ph6d4wWPHdcS8ubRzFFlVAVFYW3SuvrdOjBhlBV2pCVVrUMZ7K/7DdgG2qVeyHp3AFOLemnRYdallvM0MUqVYJ7Jb7FxHsV8/IMLEoFu0JWJGIDbpSh0M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3156.namprd10.prod.outlook.com
 (2603:10b6:408:c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 06:14:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 06:14:36 +0000
Date:   Tue, 22 Mar 2022 09:14:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        johannes@sipsolutions.net
Cc:     lkp@intel.com, kbuild-all@lists.01.org, nbd@nbd.name,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        chui-hao.chiu@mediatek.com, j@w1.fi
Subject: [kbuild] Re: [PATCH wireless-next] mac80211: introduce BSS color
 collision detection
Message-ID: <202203220555.BHvsEAhe-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6226a016389e034fd9c208b3a7a75edd01aba6f4.1647858505.git.lorenzo@kernel.org>
Message-ID-Hash: LN2PATJJB2GVA3QDIDNUFK4AIC4UQCWP
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3abbec6a-fdfc-43f5-9aaf-08da0bcb3ca2
X-MS-TrafficTypeDiagnostic: BN8PR10MB3156:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3156B851B94887B5D5105DE38E179@BN8PR10MB3156.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXKLRA66udYhHRyxiiJPK3RSHr805ArAAg+QQmnQWQOkLNVoz2NN2JqmIi6JIUh3egY180oOqDPKjlWqPJfKwawPXYC/FTZ8ImVKJTHV4KQtbrIJ2H/ArSFIMaIFwoznQ2d/eSNbRq02Wqs+T8cf9uLIn/eroGsd5lTpui2HO4EIM3is8RJVe89YhDM+ZVaTC7PbKdM0dMqf5chTxr05kQ9ouNR5Ek8hJyD7TrcFBdB6uRLUxOAPbF/bm7kiAUGmnsFLZdvPNQsuZAyIR1NaiGsXp0YZnOv7rEII1vT/wEohmnKOGHRX1zxR2/19lMrEDRidtFYGQMI3moxeLXxOxnbnW77ba5wtEdSdbS1+X0XQu+XU96dYORj7I0h5AvpmqGY+uu1LWx554E53O6NUlJh5/VXqaTPR/oZu55BvNrmxZtGMJye6+Qswl2F5IGtQZMJc9NPBb73wDjGmoOYJd/OJAW6IjQSlhxbjFhybMBcd+2EHKoWdYafN+bykNP8D7PsfbORKzs7tKhgCcnQF3E46Oon4IO4R6dfccqcmRGrwDeHk4vZ+6ERfzCAkGjHQxTYQ59frUfeXCHyER2t0PFzwD3hBoALxhC22mH3Cc1gqL2xSuH5HTzdgLoBOazxKMYyLlLs+ncOMDlrGPSD16/lp3ZYUXlVhafJbOVpnIuzOGj+tECy0SHXrgZ8oi0QEcKx4nJq0T2dYTCkmYb7r7ZLEZuXDmyzTj/YESfOnXA/flyki5xGgJX0OsNvStV+Q+Crru+MPTp1vbe9/wdJ3umG6yeit/k+twfNzqXldKDhOONbabMABElA9LY8bYgppEc6CHCgn3/8f/lVhM+GRcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6666004)(26005)(1076003)(52116002)(6512007)(2906002)(9686003)(7416002)(44832011)(6506007)(186003)(966005)(38100700002)(38350700002)(83380400001)(86362001)(66946007)(66476007)(66556008)(4326008)(8676002)(36756003)(316002)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+FHDIpyEa9SxBaCBktla/41ZAybm1KH6RIH2Rus+aAedA3RDniv4Mpi8lJW?=
 =?us-ascii?Q?Ny3aTa9beiSTDlP7wr6zXl7MguTv/L27nXNzPhrIYEWqwACBjtXbZzOTjWlF?=
 =?us-ascii?Q?z0QpTbGbsC/xfpKUUtIQit8LZbabMpCo3xaLr1NwQSvbn6QCgVDjABJFeYhz?=
 =?us-ascii?Q?HvR+g9gDeg3PELx+FHCR3i8w+HeiI4hZKenMLO0RHL9gbuKlD3MdY53IOJxz?=
 =?us-ascii?Q?+vqE48sare+J3aWrRKd1rftXEjtooVBl+x73iXq85L5UvYv2LuExPUKkS5DD?=
 =?us-ascii?Q?sVfo8P6728VN9InFPDxdjU4svs6KYn6Ya3Pwh/lmDca0ug8m5Oevo/vsdbpe?=
 =?us-ascii?Q?SmSZw7WF3j0AY09rQKiKqb8Cb0KinRIKz2BvfluBml4Hu8M2e0rUPz2b8mMp?=
 =?us-ascii?Q?bK3oMLIdfjJTgVUJj0EnwOKsHSeb/FiVoi3LHsivuUSWCxTBZWmWtdi9fkRo?=
 =?us-ascii?Q?djS5f3i27NM9Qi0LOy5t/aDyfEFCqQZ6BW/hCIYDId0dPhASUVIReyGgIlY6?=
 =?us-ascii?Q?8v0y2NT3OYQ0SC1kHJIETN0s+n2P1HCnFvox1++xyXghnZpA53+XkWUp+nj+?=
 =?us-ascii?Q?BqZwtuiEphnKQqp6zFvIFoG5gKwrLIwEZz8blKErjVdPWGgYKM3FwEttOqtv?=
 =?us-ascii?Q?xvhIUzE+sI9oPPjZlhX0IRjkf4CSM0w+3DqBTgJyukBH8NgWpmBOQ0lVqBii?=
 =?us-ascii?Q?vhMmRvCskzV0oq6OE8FrTBY2lMv7ngsvY9nOBR7flDDCHhh2zd5/ke9+9QYW?=
 =?us-ascii?Q?eUXH0KtOn2Y/de0Ce4r3SYRQIuj4ouwC+0sfIHFVkT08HGM0WLxttLV6JBUD?=
 =?us-ascii?Q?rJHhmWs29OshA07v6Z22KiwigTGRMmGZKjT6ThTtNQqFZ7Sv3ALNVVX4JdLh?=
 =?us-ascii?Q?AtA/oL+5vCZsCscZZIhciuhb0VNjW28dPRYLscVPkD/quWOn9yn/zdG13AZp?=
 =?us-ascii?Q?WTUiofXD4I4uMWuXqY9XR6/iwetuGuULIQxgT/Tbkfre+PWXy3ArsvaA2AKD?=
 =?us-ascii?Q?hU4/vCbgy2xJ0jeBH+ZYgShmPjhLcUP05R+gnGaJxX1U1dCL0033neBmxfwQ?=
 =?us-ascii?Q?HskE0D7SvFaUQ7OQyPVq2R5AxKfYKelsBdTEcFeeXJRIcoeAm7OF9/3b46cN?=
 =?us-ascii?Q?ByZy/J6FfMCw/PIDfNbsAByo2EXojMJqFYpVR36DZIpdiJPsImIdS4Pif0vm?=
 =?us-ascii?Q?oyc0UwPvoDSg+ZGosgrDl27SLf47SJvufWxyZuULj4vzKK+0RB8tyieF2f8Y?=
 =?us-ascii?Q?47k4TQ4FzC8ue0nIFcfdjIWaiap2xVtLeBObv8iDvD2ahIGEfKLN9wIWQqVu?=
 =?us-ascii?Q?z+kHhZ23lluvI4qXEXYpvC6VyHM6Nn6S0WV3WO+66xf3L7NrmeNsWjQeQanV?=
 =?us-ascii?Q?6tHr2GHBxYP599OBXuwiwfU3tfTlbQznhTxdXvIYZTtpjw476OTtnRJa3QtZ?=
 =?us-ascii?Q?yJrUOgwZj2n5aNFbTove3G4glfU+uKBCzwyHvFm3ap2sU25Fu4IzGA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbec6a-fdfc-43f5-9aaf-08da0bcb3ca2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 06:14:35.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OI8TzkNKe/5zUualmd+9+kIZqsWE3IQToZ3aGJjcSyOoqNzXYHk/9C4vsTnIgMwIgC4kLpTpiNp0QPsMAsOuijkJbri3fbsygUq5Kxqa/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220037
X-Proofpoint-GUID: TELOnoIe1dzhXZF7q1fCwAhVJVWqkqUg
X-Proofpoint-ORIG-GUID: TELOnoIe1dzhXZF7q1fCwAhVJVWqkqUg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Bianconi/mac80211-introduce-BSS-color-collision-detection/20220321-183456 
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git  main
config: nios2-randconfig-m031-20220321 (https://download.01.org/0day-ci/archive/20220322/202203220555.BHvsEAhe-lkp@intel.com/config )
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/mac80211/rx.c:3218 ieee80211_rx_check_bss_color_collision() warn: should '(((1))) << color' be a 64 bit type?

vim +3218 net/mac80211/rx.c

964596b43c17b4 Lorenzo Bianconi 2022-03-21  3181  static void
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3182  ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3183  {
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3184  	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3185  	const struct element *ie;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3186  	size_t baselen;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3187  
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3188  	if (!wiphy_ext_feature_isset(rx->local->hw.wiphy,
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3189  				     NL80211_EXT_FEATURE_BSS_COLOR))
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3190  		return;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3191  
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3192  	if (wiphy_ext_feature_isset(rx->local->hw.wiphy,
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3193  				    NL80211_EXT_FEATURE_HW_COLOR_COLLISION))
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3194  		return;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3195  
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3196  	baselen = mgmt->u.beacon.variable - rx->skb->data;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3197  	if (baselen > rx->skb->len)
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3198  		return;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3199  
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3200  	ie = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3201  				    mgmt->u.beacon.variable,
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3202  				    rx->skb->len - baselen);
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3203  	if (ie && ie->datalen >= sizeof(struct ieee80211_he_operation) &&
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3204  	    ie->datalen >= ieee80211_he_oper_size(ie->data + 1)) {
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3205  		struct ieee80211_bss_conf *bss_conf = &rx->sdata->vif.bss_conf;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3206  		const struct ieee80211_he_operation *he_oper;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3207  		u8 color;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3208  
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3209  		he_oper = (void *)(ie->data + 1);
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3210  		if (le32_get_bits(he_oper->he_oper_params,
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3211  				  IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED))
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3212  			return;
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3213  
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3214  		color = le32_get_bits(he_oper->he_oper_params,
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3215  				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);

IEEE80211_HE_OPERATION_BSS_COLOR_MASK gives us 63

964596b43c17b4 Lorenzo Bianconi 2022-03-21  3216  		if (color == bss_conf->he_bss_color.color)
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3217  			ieeee80211_obss_color_collision_notify(&rx->sdata->vif,
964596b43c17b4 Lorenzo Bianconi 2022-03-21 @3218  							       BIT(color));

So this should be BIT_ULL()

964596b43c17b4 Lorenzo Bianconi 2022-03-21  3219  	}
964596b43c17b4 Lorenzo Bianconi 2022-03-21  3220  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

