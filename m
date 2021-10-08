Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D157426CD1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJHOiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 10:38:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4284 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229756AbhJHOiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 10:38:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198DgnYL029276;
        Fri, 8 Oct 2021 14:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=n5VWGoj5evWOL4Kj9ZFOOCjSCHchVPh80l9c+qrCvxs=;
 b=AHZl+O12h+lxVqbQBNmUTJJXIfwx7vIDqGArwxkiCcRffetAwAu4DNu6+oxIy5ESzff4
 D9cz8bs6mCUgV+SM46dGRNsBEkpjOtaTmoP5ljfrmdoHrG0CW2u3PdEW+CbV2SgqvwC3
 19GFzqkOlH51pgN1jB5yyMfGR9YiQLcTzUGQr9AP/w0lQ8pbsqDLVgKCesD2/ZDfmsi1
 D9DatV5mXuJLYuYszPNJVhWGw96Q49+qFRY5YDnr8W+3wZNHoqFpbCpRAnSHktqeOIdq
 x3qy9AKrBwDKrb/d8VeUSDhiY/NV3pQhifYkqDnSdCfJZsAjhwJqRe5YUPPJQtHesJro +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhwfdsadw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 14:36:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 198EUpiv025961;
        Fri, 8 Oct 2021 14:36:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3bf0sbvxfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 14:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7kTtZOoTVxVTTlKN3sBrdd6XIONNmfNpx7B8b5q5aY0LaxbfPXSRKyE96o5gpcLQLzvjIMNLsQt+J1xDa/Z+GUKevZc9Sd94aFQ6dEt4DBncqFz3dVcUnn16FxEaX0GFYnhDW6wyBwSR98CU17ofgSanUCfq4zBn+JqJb9zPGpoQ9lqygbI+JvL9AlHFjLzeR7/eBBqga3z5bKr4x6vgSSvEom11wKpto8IO7+SDgF6ARknvPmxAbrYyJLPe/TXe7f2KLxnwtKITO31RVkyVBuHjHQW73FrHQ3q24o/iXwUCk+5C5FtAkN1rfYSaZ0bCzim8iSrQF4hYzAGxesUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32fbqCmbNrz+LvG0HLJ2k8yNKfRy/MwGQjh8cyMZjfQ=;
 b=SYXQqeAlXrO6cViFbHvkCILpFxB1yQPnULDTN8V2C7tgmay/PSODoYZ407o3+iDJBYsSndYD0VjTYk/kfWW6E5qLITJBwpLgAdiWzS/51WQ7JqzP2CjjpxOiyU9qCdNUNAHj+V81blAhNaMzgM4zDkVL4BIB2elo4KUgGwryLGT5Ymr9OWIHLcEpB4NhOM0gi023PqpAX/W+P6qr1q7Q5aKlhPBrqQMmgqe0DHS29JSlqE/pKaOt5cfgylQZvCEt01/qnjsD1MmjnSQSg/XY5aSu3ib8NCJOjJsBkHoSzQdwDS0NTCUP3YEIZFVT/rSz0D9Vp/8g7q5KqRMqHDx5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32fbqCmbNrz+LvG0HLJ2k8yNKfRy/MwGQjh8cyMZjfQ=;
 b=VWFTT7PH5br1L1ICMs1gBhxwYhkiytEQWk74ldcoGL/pUQW7yDW0gG1eFNNpaDNKbBqwVZX/b3RtnSCF54sXIBqmxya00iun5SnigT2ZKlQWeChe+dqOdngTgwGxwDjKQL0J9U68ov/bY9HsuHkYhsyEvI2nBiqBX3kYlXsDXIA=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1615.namprd10.prod.outlook.com
 (2603:10b6:301:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 14:36:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.025; Fri, 8 Oct 2021
 14:36:01 +0000
Date:   Fri, 8 Oct 2021 17:35:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [bug report] mt76: implement functions to get the response skb
 for MCU calls
Message-ID: <20211008143545.GJ2083@kadam>
References: <20211008130007.GA23161@kili>
 <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
 <20211008142734.GI2083@kadam>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008142734.GI2083@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 14:35:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebcdd04e-5c1c-411a-13a8-08d98a68f330
X-MS-TrafficTypeDiagnostic: MWHPR10MB1615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB16159319C52627B5B8495DF78EB29@MWHPR10MB1615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7dJ39yCBEeXX4VIuEw7NQHK8OxheRxr2yskFV6ejUuuQcBOENtbZxpo7srj42b0pHHRVq9vgSjZT6MGVPVeeu/Gv4pXtlulx+lcH+QITEjJvMYQ+6Cid5SyyL9KvXaZZdtT3NFcCKEA9Zb8imsUhtCVgEB6zuJq1LDtiAMN3smj60K+w7cKJdN2aFmKD5nLJDK/Zs6z2K6I+M22qRQQgnN0y+t9NBKPUdSrUqDw9FvYUVyafi4h4WFs0kkttx5maFRJmEH+qnSrK/NZgX1s1KoWMY3tox7SOzgZj2zcawdfpTtKH8gcLZXHCWVi9o7h4wgwKda1orDCks4k41Bi65Dq1wChSF8QeKBAB9AUq3lJz3WpRHTeZq+DToabG4NH6BXgbQYzJtibEiu3dHO/7Xa8VKGCCz9UH69CEDCqQtWBSsfSIpCP2NMRMZDI2R3EQb66X44fId6HlYNWSawxySxz+cXgYMZgg6fFjkM3+JHuWcHoOIC077Nzpx/PDHHkYyxml1wkbIXben+ALDtx9fnJMS3ONOn/35h5ianwlHouEluJoilqEwV1GOjScZ6C9SP9qYC7gp08ZAPD1kFPIsZkCqyiMOjFKMenwQdQhowSeHhht5W0Y7IlX8IewFRiZq3wcN7TLR5myVDwifp10gilViuNiBdAWVP+PkTBLZOXZTnTSt2xQfYl2Oweherc1XYSF8cz2lE0uq3u6QRUvqUfNP6OD46c0UW3J4OwKT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(26005)(956004)(2906002)(66556008)(66476007)(9686003)(6916009)(4326008)(1076003)(38100700002)(38350700002)(508600001)(52116002)(6496006)(55016002)(33656002)(33716001)(86362001)(8936002)(66946007)(6666004)(186003)(8676002)(5660300002)(9576002)(316002)(83380400001)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?k6j00bps6o8qccvX16/178Au3//c5XEciE6B1r1AlX8HedgldlFOhwxp55?=
 =?iso-8859-1?Q?fzD76ak519SqXmw/SHBXjSUy70Vh19mQl07EE07UUZ8lSpmWzcKX268BZe?=
 =?iso-8859-1?Q?oNecvI76OCqvrzGEYCi057iwmyn8EC4fKUUb9vve5/Dq9pn9zl2jO1NMcI?=
 =?iso-8859-1?Q?AGblTRioeKUpbEibDF/E2lueLirYtWDuG6PkiR54+0nkG8vJlz8Y/QZrUI?=
 =?iso-8859-1?Q?m4FoPDLHREU+rfmVMS4U3Lug6D8F0VirbjkmQu6v6faRoBvZec7C71htMd?=
 =?iso-8859-1?Q?xeUyXkXPxSYL2QXqT8/wTaZ6EvCa9BBL7g2/C0bsF4ectB9G3EhU0Zuhtj?=
 =?iso-8859-1?Q?Z+fb6Esp7hKlsvE2TYu1i6uWJFfFb/A1hIX7VdMrNxBkAWA/7X8Xz/pgkE?=
 =?iso-8859-1?Q?Ro3dWoZLcgzLBUK2+3S2JtwjDw7ZgSLS46yfvXvO6lNJn5aEqea9pjIqzL?=
 =?iso-8859-1?Q?oMhwUe2oEJiqRZPBkrDbxGvIXfqrvm6qQ11o8HnsOtgxpfY21uzHPP98TL?=
 =?iso-8859-1?Q?fwXKkJuDXkp3t1ZIw0evABfJUj8sk0xSa8yi/UGVxv3QQcjm8avecbXatf?=
 =?iso-8859-1?Q?igpoGvdSKALgj2HPuUv/0F/tQshL76mCspqK+928UU7koH0GBuKRVUx4FK?=
 =?iso-8859-1?Q?I6Us7iX5xeUT8ZRiLtE0BDwgZvtvvw17thNeuyxUYJBOVbaPAGxiqVU1e0?=
 =?iso-8859-1?Q?Kuo2tjbTQr1rOx3l4H424nqdPnw4ri2z7kBPy1fhIhmbIblaJzJC6OFLZW?=
 =?iso-8859-1?Q?AN2Z9pxiazTcZrz6X0JbWZNbZQnLicXpGpCC8uVoUSVJl08OOygIz67yua?=
 =?iso-8859-1?Q?yaPkwz+uEGQ7sGZ1/WWvS+V4I6l1QeaDzr4RP4RSDKbnZIETsyRIRcN9Sk?=
 =?iso-8859-1?Q?1gdzpS+V6Z9SXLyDWBl4sORW0jQqbxMRKDWvawp+bAGd5LXH7tCK3J5qiz?=
 =?iso-8859-1?Q?58MDKkzUD7/H0f3HoYIeyhjOrfak7a00lZhhc/Wi6PamoHSqpzTWSDd4dz?=
 =?iso-8859-1?Q?Cc68P7vI3M/lJn/V4bvvZQH3BuPnZ+OHa8I1INrtlz6C5phH2EEH5d4Rbf?=
 =?iso-8859-1?Q?RvW+a9M8p9yosMyRSlkUZ47ajPrZ8oueH+c865obVjl4uOFVykuo46TieC?=
 =?iso-8859-1?Q?F1qVIJseVkmOrvG+ksSYbiC0mIyyw6XuQTtq1sDIMQQh5foLKHRfcfwH/T?=
 =?iso-8859-1?Q?zeUkOboQgeXJbKNnHbFDjdarI5WMuYtI9rM607YcGQC5z9uvNNxJiTGA7h?=
 =?iso-8859-1?Q?iKGpVmHWmog8HczMv63fwcAJ0FVVHrgfre/EudIWlGGobjVVkAb3jKqKIU?=
 =?iso-8859-1?Q?S7jLnRPE9QO4w4sTFPg8XAyLl5sHS/GBCHec8sNinqglDuIOPE4gb4GKxg?=
 =?iso-8859-1?Q?dlXtrWU3F/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcdd04e-5c1c-411a-13a8-08d98a68f330
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 14:36:01.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/kwfqwASfY1SQM+dNVpqKnxA/Zu+BovqHu9ONHPpaHW3IvNYgaEhhbOFotwno6JiCJRKF6ThwVp2AoWEUkJly3yE04UoZXqfv2v0sVOca0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080087
X-Proofpoint-ORIG-GUID: X95H5RB9UvBRIOgCvrQ4GN9jR_7APb45
X-Proofpoint-GUID: X95H5RB9UvBRIOgCvrQ4GN9jR_7APb45
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 08, 2021 at 05:27:35PM +0300, Dan Carpenter wrote:
> On Fri, Oct 08, 2021 at 04:03:10PM +0200, Johannes Berg wrote:
> > On Fri, 2021-10-08 at 16:00 +0300, Dan Carpenter wrote:
> > > 
> > >     1146         ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
> > >     1147                                         sizeof(req), true, &skb);
> > > 
> > > If mt76_mcu_send_and_get_msg() calls the dev->mcu_ops->mcu_send_msg()
> > > then "skb" is not initialized.
> > > 
> > >     1148         if (ret)
> > >     1149                 return ret;
> > >     1150 
> > > --> 1151         res = (struct mt7921_mcu_eeprom_info *)skb->data;
> > 
> > Looks like possibly 'skb' is always initialized if
> > mt76_mcu_send_and_get_msg() returns 0 (success)?
> > 
> 
> This build is with cross function analysis enabled so Smatch looks for
> that.

Btw, it turns out I basically completely disabled the Smatch check for
uninitialized variables a while back.

I've fixed it now so it's warning again, but I'm going through and
manually fixing stuff and adding hack arounds to silence false
positives.  So hopefully, I'll be able to enable it in the published
code soonish.

regards,
dan carpenter

