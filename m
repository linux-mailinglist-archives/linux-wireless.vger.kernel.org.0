Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE1599485
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbiHSFYC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 01:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiHSFYB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 01:24:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6FD4BCC;
        Thu, 18 Aug 2022 22:24:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J4A8pY023251;
        Fri, 19 Aug 2022 05:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=zZuv37HYpWxUeHu42MQezREokTPYuFFZvque3+g5eFE=;
 b=snBgoS/TY2v76VODa+3HVBfNXizypnP5s4KCCB7eELTOZUkA0nRc179vYGHE0qi26bA+
 uEyYU8oP8vn3PmEtlSDjbCqkKP58JeNfcJXENdjfRfGG0/Ssg7tG4WHmOnF04EK3B4zW
 BimEXEZsix/EKCWVb99Oqtaz5eQJUHlg7Dx6hWyMLRDJWT/fYaK0+zpdiGcvPhv2RxJb
 OidUmwTRV65oywWzWYpJYk+FIZR3xH8t6qyWDwEbwnDyFkXM4t/VSbPXVVCccqnhPWRZ
 Oy6z5drjuQanw0wKSOfaHUwu2pjBhzck8mAxS6y5m4zCJvckYt6Kh7RXWXJ1+I6YN/8r Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j238e02p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 05:23:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27J4lXA8031901;
        Fri, 19 Aug 2022 05:23:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d55ywf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 05:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+ZTMCwCXtytrWYTSsnBAGYEbNaSZJ7g0k3GKS4N758h6W7jMSwl97YwCkLtX/hP6IrWTMNTind/aApZqRt9LLk22LC4/g+SmrX8uYwVSQ1H2eIBeSskSdHGGqDgZ8J+e264p0GRpgKXexzyjSFXkrqspaLwv/+Q/qVYTHXOHSZ2H+0JoxUZjDAIjMH9T3T0n7JYcfOofxEYpi9pm8wa2C0nPem7o8+jZnk+/2NHbjs/gETdjAab9ucsOQQm2Y1h5iYEqS5H1WY1Vm+qmAXJXVJ/fmKUTfu5l7nM2IM+2fZ4S3IWpqQ2PrMdNC/UoNyX37T+UEmTL3HinVbL04MK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZuv37HYpWxUeHu42MQezREokTPYuFFZvque3+g5eFE=;
 b=hXk7/ySr+EI8SJz/PeVzAzdCl90j+QZau0bRLp6tRiHxEm267ARne90+Vf251q5Hs66uaS7T8BwosB6XwsyDAgfpimLcZ8fGskZqZ+WDJMAqQNONy2GY3A9og7R87MjQXjhgltIiQd2TI3lUv7nQPaOD7Nl1kK+cI41FVvgqMrD/lzt6ohNgFxQG5elZbAwYvwgziXa7vroNMASoeYr93hkyZVNzA7G7lFKPsqbEzUcdhWmJVHWXHq6H9DnQCuyNBg9AiEW+ln1wb88Uj81eNgHDXEsEk3abHuQGDxVONTFqYZH8Epw013Qpsg4TN8ndPK0PedzIPrFqA/H+U/TeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZuv37HYpWxUeHu42MQezREokTPYuFFZvque3+g5eFE=;
 b=PZgMbKx3WD8TkT05khehMa+xkKCU0nci1RJBCKp9t44jelroKUUm1xOaSUDTme+5aN3QbinVgdSxjbfg80x93YMMw4BOJaFxGTRxG8H+Pgkb7u1ESI2mdxAyhnmxXYV/AdAQnKxMVTcA6+/U77RIEdrsHwScCyraKBiOePqfAGs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4124.namprd10.prod.outlook.com
 (2603:10b6:5:218::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 05:23:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Fri, 19 Aug 2022
 05:23:53 +0000
Date:   Fri, 19 Aug 2022 08:23:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wfx: prevent underflow in wfx_send_pds()
Message-ID: <Yv8eX7Xv2ubUOvW7@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0119.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22d2590f-bb87-425f-033b-08da81a301b1
X-MS-TrafficTypeDiagnostic: DM6PR10MB4124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePYsSZADkVLcKFqx7O7hc8vtjxlHErZ9dtDfMa/43Ml3XEr9IetpwswI80iYUJ8tj2QhjM7RxMkjSN23wqt4IX9lv/A8ydPtT+IkjaKlU8DlxSybiDBSBcnoDf4y6ZFsKrJ8LEKk7I6uAqYOuIg0W0fegCD7Sxm8krA/6nAWd6a+dzzujmg5vvUVJ07rJD9AEOakHhIQwZjdkIntY+AWlWx3xqOdTUyoNhnF0hEiC7h0csUIowjgcfRzFo0v9BzyBWZW6SmKwXSN86pexCKv8425DXDBZLwz9VdvMEtJjes7jZqPeVVXoEaAvxMzVukZsE6PIbIkzNYm5NmPuTRxhRTPoa9LdeIJQdxLdcqyWqjyEKY6mu2Bm7dSR6TAKfBzs2pJ7jLqli7TzoXlC6qgQrd47HQ4nzxJ+bdUP/oQKVcsYoL1uOr0eWg/PMkzVvl1hZUkkVEjkluU0WsLQVj3iaq8I1ymI1/GRmz3mkvUjjz14q6ryPSLKhl+ZAEKP/fZrMILd1v8+4mnx3yFk+TUkiBfoPTxFV/PaCC6lFYumKJl/V7pBReuK3Oanre2mKdxeiQoPYMLIIF3l5iVHNrHbFDYQhisxxCmNcz6gi0VX7U9FNp3LwNjSPwIf1DAv+Wb2EF2cxH/Ze4VnoqtK4KahOc72oys/nZJC8jhAlQWYHVIXehPQJwwm5g4uVJnBGnoe1PY9mkmw4BHfLUeoBi1UFk1pZzw4xzE4d6ot+HW1woLc2uCMRA5kAcrM0yvKwrNd+tri1vMpTb8wFenHp2Cxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(6916009)(41300700001)(52116002)(186003)(478600001)(6512007)(26005)(9686003)(33716001)(83380400001)(44832011)(316002)(6666004)(6506007)(2906002)(8936002)(4744005)(6486002)(5660300002)(8676002)(66556008)(4326008)(66476007)(66946007)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?exWqtT0aBikgH6D4T6klGmCO+S4nynq09mAoUU7JuqSdNenfj4IQbh2OSNCQ?=
 =?us-ascii?Q?O48lNtRk7z7LTTUDNqkvN/J3FjuMKk1dTBd7+IpuCbE5KhYr4lGVjthv3vqv?=
 =?us-ascii?Q?287uFssChbfy6/FS7iEQ1rpSYBgI/KzuDfTV8iMZZYMMVNdZo4IHbvcWNN1B?=
 =?us-ascii?Q?ewBMqiMOCyREbl4bD49MQw6Ik7lnmZT+v29EpYUg+ACx+0tdrhbocTJLuc7e?=
 =?us-ascii?Q?s+6PUouplngIEI8C2X6nDhWxWO6hM/QKOk5kqGdNe3MrtINrhcYtnPkV+/VO?=
 =?us-ascii?Q?4l4cIX9dcAzOJKUckhjeduG2zc0WpC5jnFXHTRF9jGSCR47Wd/IM+g7njfUt?=
 =?us-ascii?Q?HeqwS9LTTh/V73Ktv7pbhmE7UqBwAgNht5aVUagOEr9iw9huMRr1R5NHAacw?=
 =?us-ascii?Q?9Nu58GXWTUuVaGmWAqgoKI4YbieRgc2jTt1/6BIr+PJ1kNv9mnAmK5pfA7Zp?=
 =?us-ascii?Q?8jgqOs6VlH8pvMUdtx0H9p0n/Cexm3Q1XeXlKCmhf4yTsHIKPeXfWOnd2gQG?=
 =?us-ascii?Q?XbWsoswhYNtyMjciD+qexlpDV4Gznk115VEvfEEBVsHHY0yXdo5bqTdqTjjd?=
 =?us-ascii?Q?/P7mFQprwvhcRzwn6oR7dAs1bJa5S4JwYbLfqku+Lb/yxBoo+bd4L0eXmRqS?=
 =?us-ascii?Q?Xws/N20KNiI2YSh4/OPglVw8E9Jh64d5crOd/9nf7LVP3GzGO54wP9U4USX+?=
 =?us-ascii?Q?FgyqhGMshvHPT1IXVhb2zQLUJmdlbskhmWxLp0mwb9gPulHz+4IAddnG2ulu?=
 =?us-ascii?Q?gzM9wkLC1BKWUZfFre5TqdQI0DNF4CaJu7NF2jU1KlT9dOoN6UT5x7mmW6cx?=
 =?us-ascii?Q?8Ab+NFc175hOTpyRhQN9wd2fw4EAUHhW4Etc30OJEeRgPImS0c011FSfZzoS?=
 =?us-ascii?Q?SeyfQ28uKDFi236QhHSxea9n5b3OGGqN6bbqd4BicBBLOX2dMGQvbOYLVaIg?=
 =?us-ascii?Q?dnyOeS3tGu4VXXNYsUbLrt3usFs4p1YGMrzl7MhU4V10p4wkjrRJIsZGjD1P?=
 =?us-ascii?Q?dz29blq0N3IBZVJzTNWAcHTsVNjwLqX+iDS/wTFVABo645/955Yzd4ch3nXF?=
 =?us-ascii?Q?ti8qkqRjurO3ME61IyuMHpMsNHcTCyf9v+Nwf1JZQV4jceHqF2Kwzjpldlep?=
 =?us-ascii?Q?a+lTgvDkGSSD+/6VLj4RKyf0G2az9WFekEIHFwqUz19qjNKvaWXMauLHOhyL?=
 =?us-ascii?Q?moTvhHK5YVrrSnBLfAQNjj8IDPHURJXJh5yT5yk17yQ3BEVsHBcTnFAMK51s?=
 =?us-ascii?Q?oePEslnGHc+uPHwUw/cX4vZ7g4EsVb4hPtEV0U4ziwBbpERThZRL/0MRFN/q?=
 =?us-ascii?Q?90smTf/DPU9NtbOgkqF1Zs/51w2ccLOuHLKSP2Ih9dRv9GCeuJkr2F7KcRV0?=
 =?us-ascii?Q?CjspI/wuixpp/04BUTjCD5WqtBweejI0chrWuPa0AH03ynduO99rk2I6SytA?=
 =?us-ascii?Q?k1Izzc4ZqNNaqZqPDozQnzsInYhV3KKmyfNq7eSrPmsc9kbsj3AXQ2degI+T?=
 =?us-ascii?Q?en26XwjN3WEzxIZ9eg0/OAv/qDk+JxN5buFlEZzJ/c5LcSIESfQenpGvO8r8?=
 =?us-ascii?Q?+IdawZJUB0SMYL8LBBNZNKjvmoehgVMfK4+tGUZL7h6KD+dMMHxfJSvJwTxp?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?p5t+ds0eO/TSSicpyObFqlZ43s1hRzVuBL1lupbbwS1kZ/CB4Fl434rJV3+e?=
 =?us-ascii?Q?m1LL6ZRbs5iIWOTUAL74rs5MyN1LqDJ1/89kpYLm56JYYijTT5pBUx04zdq8?=
 =?us-ascii?Q?oNsyVz+tOmTtMo4qoWgHD5ckdudezU36lDuM/9KSA3vChDlRsE7YgKPSNTwQ?=
 =?us-ascii?Q?s/bKn+y9022ehI5Ah6itMWi6ScsGEVrGUmsDFlDXS0d3+X8nqoeBN5zmoJjm?=
 =?us-ascii?Q?hNnbKRUyhLD3+Om3Lrul8HRW+d2tHcBBZvq5ediu5H25Y21B4dda0E8VequB?=
 =?us-ascii?Q?ezL5hcZ7QyoluMztUUvv/0nL8sfnu/Z8+acq0OBUntGzQry0NKJ+15nSk+3Y?=
 =?us-ascii?Q?ZEepZSy1LmRXEtizNeAQ43h7YHr9cSQ4l4F2m+2O5eraXDa3NEC/kFC9951r?=
 =?us-ascii?Q?0lHLuDKisSb78+OOO6I6ypA+PndNrXE5/h/gYaspgeqpxvhu7eIlbWgGTrvU?=
 =?us-ascii?Q?GHCSQzBxs0uxvAWSYnA5KGCWc49XGwuKTUwHbeNvP81cbxdePNr8y653h69b?=
 =?us-ascii?Q?/WP64R0zSeC3xJGojE2ZJ+NpOSdShDrpDfoH99rQgp4CwoY4b7UDaxyPOI6b?=
 =?us-ascii?Q?xKILSQkawnXByf2bm6+wH19ZDd88V0jWO9ppgivbEnDi7enI+IekFLI4vxEa?=
 =?us-ascii?Q?GO4DDoRratl3ZRuEosxwFCikMnD/2NpmXcx8gx9nuj2n2SMvXYC3x2d58x+U?=
 =?us-ascii?Q?MthUp59BXO+fR36ufdOSpKzW2+CVFo2dvIu5Ym6V0yze68FXQwWQevAeHDpc?=
 =?us-ascii?Q?Nbs62nYAyXWnilonlh1Jq5PbYivrInfE3ms+5CXUJPR/HvbF9HEnEjss44DL?=
 =?us-ascii?Q?7CfWskUV9/aJAVbQKpayzOqfb+OUyvRuWjgvqyg4+tbXBPTjaHju5zBoRpRo?=
 =?us-ascii?Q?aZlZEVzsLFiApww4tI2cD6ybOFTdW1BPZUGlXLsV7Wwtx7WIO94MuPktY/W/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d2590f-bb87-425f-033b-08da81a301b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 05:23:53.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUUCqSDw2f+sPn1zsjLxa+zvd2GcBfozOyilNkGtb7UZYu5vFaUfTSnfyECm01JH7NXWC8mnzx3HlAik9P38p8RXUAOgl+fsdNeH+XCkQ0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190022
X-Proofpoint-ORIG-GUID: lXXswH-1tpl4bK5S7ATF0AQq0O_7tXTA
X-Proofpoint-GUID: lXXswH-1tpl4bK5S7ATF0AQq0O_7tXTA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This does a "chunk_len - 4" subtraction later when it calls:

	ret = wfx_hif_configuration(wdev, buf + 4, chunk_len - 4);

so check for "chunk_len" is less than 4.

Fixes: dcbecb497908 ("staging: wfx: allow new PDS format")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/silabs/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index e015bfb8d221..84d82ddded56 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -181,7 +181,7 @@ int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
 	while (len > 0) {
 		chunk_type = get_unaligned_le16(buf + 0);
 		chunk_len = get_unaligned_le16(buf + 2);
-		if (chunk_len > len) {
+		if (chunk_len < 4 || chunk_len > len) {
 			dev_err(wdev->dev, "PDS:%d: corrupted file\n", chunk_num);
 			return -EINVAL;
 		}
-- 
2.35.1

