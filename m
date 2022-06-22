Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52F5543FE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbiFVHHS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiFVHHR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 03:07:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8E36B53
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 00:07:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M6M855011837;
        Wed, 22 Jun 2022 07:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=JMY8zGkQGsOIZc0zR2DabMow/tETIZ1hEcezIv3spKA=;
 b=HslJ5/XedklpAbpNZHjs6SoVYTLSFmK5GdwY6a3t3BQl2Q1ebwdOJjAPPCbJkROtoKKZ
 vrL5CbJG+yYoU0ZmbHED2zCFocd1lexTQC9ibS19GI65h4J4lDlaqcxHgdniDzPoYqdC
 2sylH+0ZTyAoUCS4+pODA15htCXbnxJBivkX3X3CMG0S3fl7Aw0NdRcp0qV0DET9DFBV
 RD3k9fnwTdCviEPGpYVfTncfgSlXWJtg7YQFn3fZQuAFO5jyaDEP+qFd0YoENjq+Xmdf
 PuufS6qRaE+3bcYIGREmSD80qPTHvO/SNMvOldCXN+Vb0fIqphjS9b62RYY7YXMj6OmX Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asymqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 07:07:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M76WYt011239;
        Wed, 22 Jun 2022 07:07:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8x70bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 07:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqGo3SLOY6sUhtVbGvwXYbuSH7/cSvxT1sqCArJuTICpsRkYGLGc21WrrcDdWGCBPDOKFo4dZkYUQ1smv2Vsg/Sbkls7nQa/2KqAeodLj2Wsvb0XODoDOYfrUkWzd4MJRE9ZwQ+VuyWMWLtf1y9fpm1mTRuI6Hxo+Yio8opcCxXmsQpYpkWwmkduUgxnZujW+Cpes33GSgGYoLnKr0f0noTy6Q78TY45OvCcPFg0k3gPPuqw1kcIUUlHFh9a88WN32SUfEwAVE7yB0eJSadIz1SuUo3rNaJej7spr/2guU+ZzCu/2duCCIcWpfO4U9OCKlAf1h8fsfF1mjJ6wakKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMY8zGkQGsOIZc0zR2DabMow/tETIZ1hEcezIv3spKA=;
 b=WD1N2ipMtm9tP2Q7HtHwWo8Oiz/rSS5ZZibo8tB8IPBSOtku9+Xecxe09RucUnX5AVbrNQdoy+hkcKZDo24THXEA9O+NWwpdM3YGxF1FyFDzx0HxgmYPE/L0SL9eLAUOjV/ofrzuF1W2FIHG3qWQE4J5aLF3hYk5Div5T2davPFssy8aVl41laMx894fuERA0+2aUnaHD7a9ljvASJZR+oZNYRXFZTIYwvL34MKPAMVfhQYROF1W996746sEtBmJznvDFmqIGRtYtSaazkqznUsOWdWNCiggGjC4BV1/9s2bRe9c8dXHUkrGLfczS8nMpVfo2QglBxdPWKrV1TZ11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMY8zGkQGsOIZc0zR2DabMow/tETIZ1hEcezIv3spKA=;
 b=tMcm9yXHMZx0c1TbhQsPGsluiPSsrJhSbweXS5cBNXa66jQGQ8QJ4zmWHXETs4/BP+DHz1lLJVMAmwBMRZYVzg1cUoBPw/BYqeIwwCoxQuMG6ZYYUDXr9xStyNhh0Y32BLe3eeCn0VM+v06Ch8PvZDMWm1upPvysh/OKZFtH+EA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5442.namprd10.prod.outlook.com
 (2603:10b6:303:138::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 07:07:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 07:07:09 +0000
Date:   Wed, 22 Jun 2022 10:06:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: cfg80211: simplify cfg80211_mlme_auth() prototype
Message-ID: <YrK/kj6QI2j/CNqO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4c285e2-4e3d-4ec8-402d-08da541dd279
X-MS-TrafficTypeDiagnostic: CO6PR10MB5442:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54421EC72825F3D5575FECC78EB29@CO6PR10MB5442.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weTbnHtzFw2VD52doW7nlvVScI3a+vlWHL87clXWpwE1pwkQWjEBwRtKAi+Gbzf4IiDYrSqR/OQ10fOVXMLArN47bWYfBB+cnD7AZ/Gs+bUhWjvoVALYoQQcLyIR4L28H4ugO3beKrItQ4qERkQjjpkQgmRkuiF8dmKse/2EqP/FeHuWeurjLxJP5T5t88YuBt6OZx2VhuzEzjNYsM+ENEtHUleWNG0hkFEW7XdrzCuvTFpzlt1DIuZgpwMPvNDFk5XrXeM+YuuY5xIeDBZPf0yd2Gt3sUEya/KEBNVVzyFANdcUK/bIQD+2E0eJn73SWKBSOqh3bGo7aevug4mmImHAtnQ/QmHMftLeWbnr4xj4GT4azSkY1565oPkvSribUT5uFi1UuU8gnAXW6oKDXf8CSc9wIb+W/93HrYwRW3+rpX4BfqBlfkmjIQ/xziwVxUsixmrRYFBs+adqbJ2YfrqZNopFhHnfSEUiZmv/pH2n6u8PcQN5BRU3dBA4fNmHmcRKO2uCz0BqZxcABfYd9Hqscvrq40/N2e786QQT5vnqYptyJ+PBw8P+GdS1zrLqKDkxv6ScVHDXgzGHzq1meMMJS27LZsH5/iOrff03E3XVkWhycV5A0dm5ngiavnFEIDW7I32dh/plGNe1riniyQkvbaItHe0itlmJMKbo60QjWT97FzM29G8rJ03fEYLvbxjau0li/2ko/N9MHZYOmNs01QQDUXYVmrsMhRgmbAQYmklE9EykK9yyxRZcZ0QTKxucWFflUBy3Pxjk0klL6pf42HN1Juw/ornqX9JvXGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(186003)(6506007)(26005)(38100700002)(9686003)(8936002)(52116002)(6666004)(41300700001)(66946007)(86362001)(6512007)(316002)(478600001)(2906002)(8676002)(4326008)(66556008)(6486002)(6916009)(33716001)(44832011)(66476007)(5660300002)(83380400001)(38350700002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EwnCmdTQCqjVRuz+M+lt5ZeYfxL6PtMQjFG82erC11vz0Xqnm8+lU+G6NFkT?=
 =?us-ascii?Q?eopNQrEnhXCJ4fWctQzt2DU0biYK146wvgjLpivSr18v1FZgywa7hYe7jv1f?=
 =?us-ascii?Q?eTcDNxTxHZ5JqdPZd3qwV8/TocKuzy05dCo3V6hSyqTw6FBJehH6KDHWoG31?=
 =?us-ascii?Q?Wp2kEceweasRbfPinH4VDOzlY7e1ShODLW140AJ/1exnUcg6qwd1vhomJJtL?=
 =?us-ascii?Q?t7rYXalot0FVSKRqfJ35sTOCp3UlukaGXXqvzBpOPqWdgbrSuP80a9mkqPsq?=
 =?us-ascii?Q?stEUNO3/Vy3bfXuhSq1gdf1bjAKD9YSlIH0zPzRBk0zvTl6mY/+sHOi6E4Pl?=
 =?us-ascii?Q?pozWnJF+0+zKMIKWbuLdDYhISM/v42A4ZJGTBZ5d2jP7EntFXnSeNifPzQCf?=
 =?us-ascii?Q?0O8fczfqU3gdWNyaeEnVD14UrpYU29ZMJ0rcF2vPyDV6v5QPhr1qv3Tyyilq?=
 =?us-ascii?Q?YwJjS9PeizQ+74x8Jrv3HZgv+2RPkN+goJ847IdJnXgGYyldaVznMVkriU9B?=
 =?us-ascii?Q?rFO48L6dyRbQaLrrwOtkXI2/IFA1Q045oIoEJgpSJPkSYegwbgFMuwbkgYZ8?=
 =?us-ascii?Q?Hrchk5vs0g3atBKiTJ+dN4eN6oXt0x623TfmmDUizsDHPY96WvpE8jAM2VGs?=
 =?us-ascii?Q?VfOXTiu7xiSR0xonkzQbZgggPPix4mgbDJzg4Th7oIgIPrxJag5Oo09aCUw9?=
 =?us-ascii?Q?8zIQSfHovBb9YAwU51Jiu0zZnFeyes3b4YVrdvx2wGjm5z/VB0jS+c0HObPn?=
 =?us-ascii?Q?ok9ECPXpwHkaxgoWAISOqdzToNARvP7GLUUJPvFYcf6FZ2R3IyfT8yqoSvm8?=
 =?us-ascii?Q?L/LXupwxxSYQK8jyDGIlYyGLB8yQDcEzuRVvcmnuYFK+oFfI8n75rnYncbxi?=
 =?us-ascii?Q?2QnUugKYSygBTzHlSO8WC7czWNwR/hM5v0A/oQjT7Caz4affyfxzl6uB9RJh?=
 =?us-ascii?Q?IC/5cH+bF5YCght/SHpzB5f7+/ZsbCUvnHkirfnlKb62E2USN1gZPoWiOG6X?=
 =?us-ascii?Q?LBgFCnMFgzRmKDgLUe4uPJS/va2O7ntUbquwyMnBPxdt+fWbhO+VjQxCsjf4?=
 =?us-ascii?Q?3GSAjdejfT7RH7NAcS1qrutlDAUZ1pQBPGmdGl9BmBh9ayiLabF8KgYufV/k?=
 =?us-ascii?Q?jzey4V3DnDAT0w49Os63hKJvsY3Tr2HJIysfj2bX57X9x72W17gijPG4EKBq?=
 =?us-ascii?Q?WKYF8BrqeBI3yyLnqFV7XpZj3rGbVp+c8ovwA485/7mQu4VOGatrfTJW04Oz?=
 =?us-ascii?Q?S5XZzqttbi1wE+Pw9UGL4HJSZ3ahfUbyPCHo0B+V4uE4EJdV5bBDJDQmhiHS?=
 =?us-ascii?Q?OfOYCuF1oB7McKT6SSYFUIwQH4S6th4ZqHi3mY/OV/1fKfRs43XAWuv2KZxP?=
 =?us-ascii?Q?Zf6ghFlTbTZAtC5nBhQ0+KKGdmZqApWQZO5tfY6DLS4KFtyctVaa97wt7Hmp?=
 =?us-ascii?Q?bmVDRdje8BgEvDbK4ZDXVhXnS8sH3nPUXJGPESorK58emjw1oCpKWni5dnpI?=
 =?us-ascii?Q?nsf9qxR6O1Eo4OviBjwk9N5CcxlkPWiXVpeLffRo5t2cX5WffMpnsLEDSRKu?=
 =?us-ascii?Q?+mGcKOrpwqgNlaLB3RYtaeyjBMPIo1jukTF0F2CjrFmjD5Cp0ixvTVB/vtAc?=
 =?us-ascii?Q?G8qZOax35vbQeGXBE+RydF7EamSN2qfgeYFNVF2PDLYteGjN77Daym9P+NKi?=
 =?us-ascii?Q?pGI8aHz6t4x7EvjaOlVYO2pTCNtdUeRV5I6Mtem497DptN1HOp4xKKLLLD5r?=
 =?us-ascii?Q?A2WtTvZyXba+TCKT/ZNr6tfQsLIFyi4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c285e2-4e3d-4ec8-402d-08da541dd279
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 07:07:09.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pTFYljhbHbwf3X7jEWr65iRT1RrXULxA+0K2X/ZQDpHoFA4GtOSn/Fqs7Q/IYM/kGEZaoHxi8yC2kK2MdE68fYYsgkmvYezu9eb4d+iH3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5442
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220035
X-Proofpoint-ORIG-GUID: KXBPSVUMqutPwoVgu4aD1hN_KtE_YLre
X-Proofpoint-GUID: KXBPSVUMqutPwoVgu4aD1hN_KtE_YLre
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes Berg,

The patch 325839da9581: "wifi: cfg80211: simplify
cfg80211_mlme_auth() prototype" from Jun 1, 2022, leads to the
following Smatch static checker warning:

	net/wireless/nl80211.c:10310 nl80211_authenticate()
	warn: assigning signed to unsigned: 'req.key_idx = key.idx' '(-1)-3'

net/wireless/nl80211.c
    10192 static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
    10193 {
    10194         struct cfg80211_registered_device *rdev = info->user_ptr[0];
    10195         struct net_device *dev = info->user_ptr[1];
    10196         struct ieee80211_channel *chan;
    10197         const u8 *bssid, *ssid;
    10198         int err, ssid_len;
    10199         enum nl80211_auth_type auth_type;
    10200         struct key_parse key;
    10201         bool local_state_change;
    10202         struct cfg80211_auth_request req = {};
    10203         u32 freq;
    10204 
    10205         if (!info->attrs[NL80211_ATTR_MAC])
    10206                 return -EINVAL;
    10207 
    10208         if (!info->attrs[NL80211_ATTR_AUTH_TYPE])
    10209                 return -EINVAL;
    10210 
    10211         if (!info->attrs[NL80211_ATTR_SSID])
    10212                 return -EINVAL;
    10213 
    10214         if (!info->attrs[NL80211_ATTR_WIPHY_FREQ])
    10215                 return -EINVAL;
    10216 
    10217         err = nl80211_parse_key(info, &key);
    10218         if (err)
    10219                 return err;
    10220 
    10221         if (key.idx >= 0) {
    10222                 if (key.type != -1 && key.type != NL80211_KEYTYPE_GROUP)
    10223                         return -EINVAL;
    10224                 if (!key.p.key || !key.p.key_len)
    10225                         return -EINVAL;
    10226                 if ((key.p.cipher != WLAN_CIPHER_SUITE_WEP40 ||
    10227                      key.p.key_len != WLAN_KEY_LEN_WEP40) &&
    10228                     (key.p.cipher != WLAN_CIPHER_SUITE_WEP104 ||
    10229                      key.p.key_len != WLAN_KEY_LEN_WEP104))
    10230                         return -EINVAL;
    10231                 if (key.idx > 3)
    10232                         return -EINVAL;
    10233         } else {
    10234                 key.p.key_len = 0;
    10235                 key.p.key = NULL;

Apparently key.idx can be -1 on this path

    10236         }
    10237 
    10238         if (key.idx >= 0) {
    10239                 int i;
    10240                 bool ok = false;
    10241 
    10242                 for (i = 0; i < rdev->wiphy.n_cipher_suites; i++) {
    10243                         if (key.p.cipher == rdev->wiphy.cipher_suites[i]) {
    10244                                 ok = true;
    10245                                 break;
    10246                         }
    10247                 }
    10248                 if (!ok)
    10249                         return -EINVAL;
    10250         }

And here

    10251 
    10252         if (!rdev->ops->auth)
    10253                 return -EOPNOTSUPP;
    10254 
    10255         if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION &&
    10256             dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT)
    10257                 return -EOPNOTSUPP;
    10258 
    10259         bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
    10260         freq = MHZ_TO_KHZ(nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ]));
    10261         if (info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
    10262                 freq +=
    10263                     nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
    10264 
    10265         chan = nl80211_get_valid_chan(&rdev->wiphy, freq);
    10266         if (!chan)
    10267                 return -EINVAL;
    10268 
    10269         ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
    10270         ssid_len = nla_len(info->attrs[NL80211_ATTR_SSID]);
    10271 
    10272         if (info->attrs[NL80211_ATTR_IE]) {
    10273                 req.ie = nla_data(info->attrs[NL80211_ATTR_IE]);
    10274                 req.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
    10275         }
    10276 
    10277         auth_type = nla_get_u32(info->attrs[NL80211_ATTR_AUTH_TYPE]);
    10278         if (!nl80211_valid_auth_type(rdev, auth_type, NL80211_CMD_AUTHENTICATE))
    10279                 return -EINVAL;
    10280 
    10281         if ((auth_type == NL80211_AUTHTYPE_SAE ||
    10282              auth_type == NL80211_AUTHTYPE_FILS_SK ||
    10283              auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
    10284              auth_type == NL80211_AUTHTYPE_FILS_PK) &&
    10285             !info->attrs[NL80211_ATTR_AUTH_DATA])
    10286                 return -EINVAL;
    10287 
    10288         if (info->attrs[NL80211_ATTR_AUTH_DATA]) {
    10289                 if (auth_type != NL80211_AUTHTYPE_SAE &&
    10290                     auth_type != NL80211_AUTHTYPE_FILS_SK &&
    10291                     auth_type != NL80211_AUTHTYPE_FILS_SK_PFS &&
    10292                     auth_type != NL80211_AUTHTYPE_FILS_PK)
    10293                         return -EINVAL;
    10294                 req.auth_data = nla_data(info->attrs[NL80211_ATTR_AUTH_DATA]);
    10295                 req.auth_data_len = nla_len(info->attrs[NL80211_ATTR_AUTH_DATA]);
    10296         }
    10297 
    10298         local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
    10299 
    10300         /*
    10301          * Since we no longer track auth state, ignore
    10302          * requests to only change local state.
    10303          */
    10304         if (local_state_change)
    10305                 return 0;
    10306 
    10307         req.auth_type = auth_type;
    10308         req.key = key.p.key;
    10309         req.key_len = key.p.key_len;
--> 10310         req.key_idx = key.idx;

So do we really want to set "req.key_idx to (u8)-1" here?


    10311         req.link_id = nl80211_link_id_or_invalid(info->attrs);
    10312         if (req.link_id >= 0) {
    10313                 if (!info->attrs[NL80211_ATTR_MLD_ADDR])
    10314                         return -EINVAL;
    10315                 req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
    10316         }
    10317 
    10318         req.bss = cfg80211_get_bss(&rdev->wiphy, chan, bssid, ssid, ssid_len,
    10319                                    IEEE80211_BSS_TYPE_ESS,
    10320                                    IEEE80211_PRIVACY_ANY);
    10321         if (!req.bss)
    10322                 return -ENOENT;
    10323 
    10324         wdev_lock(dev->ieee80211_ptr);
    10325         err = cfg80211_mlme_auth(rdev, dev, &req);
    10326         wdev_unlock(dev->ieee80211_ptr);
    10327 
    10328         cfg80211_put_bss(&rdev->wiphy, req.bss);
    10329 
    10330         return err;
    10331 }

regards,
dan carpenter
