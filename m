Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CEF554347
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbiFVHDa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352035AbiFVHD3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 03:03:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBB13E3C
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 00:03:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M6UXZM017645;
        Wed, 22 Jun 2022 07:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=nRt4a3t2SGVRmGTNxbuFjD49yqQnlBjaMMmdjOkRFQE=;
 b=sqAWaaChoB9uOzyqOiSSotUj6P/tB1rcktm8G+0H7ylzL6kXvQhber5BgESm+rXNlD0i
 9Zhj3TDExsMDHpeTrdPs9ZwkRT8sBLyDelv+urjDhiPl9ezoPskfXoxvjorVc+Od+86o
 ZV/zJYvsfjbmM3cCv62qo1AoyF5Ep7VhPPrCuXS+B4VQPVh2QhJEj712d0Y8COidfG/6
 XYHpBXaFuHxPkz9ha+bUkU/H5BA0gwgwMp3WmjIt+Q2amUnyiK8UKJ8kQSKdRNxFPKiT
 OTtBbiD91sRQEK8HPKAfYhUa8Ivnt6lhWaMxnnLhp9QyqDOinKSXbc85RS7Bh+i0y/V2 cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78tykra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 07:03:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M6ugEw012852;
        Wed, 22 Jun 2022 07:03:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3w1s8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 07:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBIu3EILE1tWYG+5LQDkxU8ew9/U1KN8MzkTmL8JdT3VC/U9/BzULOjsp+osNfKMRtCtIyUjTGMbdwQPiocuG27aZVUWiiTCSLokNVOOrgWWeaYKahFtTnPxbSkED2Vhm/6tosjjhwDZjYjabbdIBHfrxc6kdGsDZN+Bk/iwExpQ+MWjuqVcikOqNKdY7ibyZuhcUq2gH5oHTB/YtyIV8nAzuQ/h64rFdrsd+dU1nEDCTU6FJfQ9qtlCxx6g11TRED0PWIT/Og2yIOEULmaaqDkyg/rSVh8wIa9dfHneJU3VrkwI1bvcN+zNENPcI6wawHdEg5snmvuQFhNGqqiM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRt4a3t2SGVRmGTNxbuFjD49yqQnlBjaMMmdjOkRFQE=;
 b=bkKscGgRbgZIuPNqvZgd5iOFNuttwHEukhG+7T8vq2/sRBQMtMWKZ8ijHbK0Loim1J0MtBPKKhK0PuzVxBGxpvLfmQsraS4Za75FQVOSCBB1tJhYyNDhl/xBJA7QripJWB9TeZ4fmdIT4Eq0dsO/nGr3ui4nLgPj6ixtGb9Oj5BV5hdsc6Bb5Qz6zle/iYA2b9Xjira06DvcjsNiRE21snoclH5B8HYuxw9WkpeZB1gGKxcRCKfkwD2tRBf1m5l8ZfL7qQTIcqHq9qoRYqX/PJM2Wz8ZppXahhHtSDrRzb9R4LEo2E0m6eZ6jw+8ZGAwUuGVR2Tbo7UI8lhh8msc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRt4a3t2SGVRmGTNxbuFjD49yqQnlBjaMMmdjOkRFQE=;
 b=x1MPxUJTWner/D/YwJ3O9Ig+0Yk6IfGkMZQE3E7tHSalMGWG9GSk+CjAFGonCaLhAnRmzTqBHT1QugeO9urpPvg13QODY6BaTjZ+wWZ+ayQWqJ+mFT0+QqqJ87B/g4+Z9qPOmUghy/dPZXCfS+Ir98JT+bGzJ9XrSuqxQWQu0Rw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS0PR10MB6053.namprd10.prod.outlook.com
 (2603:10b6:8:ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 07:03:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 07:03:25 +0000
Date:   Wed, 22 Jun 2022 10:03:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: nl80211: support MLO in auth/assoc
Message-ID: <YrK+sjPSFRxX4XAM@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0195.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82bd95bd-3259-44e6-c05f-08da541d4d01
X-MS-TrafficTypeDiagnostic: DS0PR10MB6053:EE_
X-Microsoft-Antispam-PRVS: <DS0PR10MB6053191569963C6C785997598EB29@DS0PR10MB6053.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IbRbHuYAxUHVpZCZ1OINqQVuW9869R0JX47ajXwCt0exX+8xawRAEeoRaZ0uGqxkPaEDStFDbdTuAHYU+eXJKUEcdgI4tJdYL7SmEZwLyco8Il57OeD18J82L9u8abTLCAneeyelLS4olLCYEqnwXjzYkOjzYWgWBOLdYeN3yYDt+zB8y+1Outkla/0oJvl7QU5007JzNAPhA8V8SeJvdBFRVdN/nG7vgvWFz5psa85h3SCnnGHof+WJDuSvFnx0/BxmDmA8yXF0BOEwkJdUOzs9pOCfGdDzLJvwqUPihH3u1feIn3c583FLSYDTX2sW2tOa+DJJiIGBPSTX0iG2jmtXln74c6XnRds7AasdxdI62WFGRgcUWRLzrUGngoUJeKAXyDkOohV0ZURaay3J9SH6UKBe9J5OFEtjECCOdQfa2O7gxdSih015ocOme/p4rG7eFLRzK6zidr/zjfxvAhEV3z/r0E6xMbviHVimc7XjMZZP+B5o6hW5SI4O61nGZC3WzvCQ9o/wwPbNgxdbtber+RJKbY80DXdiDDD3yNG1JvvVUXs5INADgpZdcCJ2lPSc7KdtXapKmJ8xla71iKgRemjs1mkoMCYD6/kZKY9lHW/AgHhXsapSN4STpwDZtwIwlDErGP7vGmg4ooVzYCWfLi5ZGr7IO3izlo9DLEkSLmLwwFCSXG3dinGFP8mqZGIiwA7kUJYjXo8FdXMaqOeMGC6p7OMbcehDvGvRrk8G7HfumYllwdeiAcfgUDOUGR6B8xta0UydCyIrB5l//rdmiGL5Uu57vSlbbiVMVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(186003)(86362001)(38350700002)(83380400001)(4326008)(66476007)(6666004)(66556008)(33716001)(6916009)(8676002)(38100700002)(66946007)(316002)(6512007)(5660300002)(26005)(6506007)(41300700001)(6486002)(52116002)(478600001)(8936002)(4744005)(9686003)(2906002)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSL6hCTc8ugIwh8HxrdBR0efYsJ0crWnSiVDnjw/3rZn2xJiKtQcNA6/gf1I?=
 =?us-ascii?Q?qkP1RghFS6Bp6A03fcCQ1EhqwvoYKV5n/TeTYgg0tzgN14n+sD4pFjSWLi7W?=
 =?us-ascii?Q?GrqgBnHVx1pEtasUBURkfhokk0FYxaNHNteg3+BfxUV1owca5SNcDpsp1ghJ?=
 =?us-ascii?Q?BEt3Mna3k4MWl142BKa1rFf7nPTEG08aQZ9E1BGWaVFa+rBW9et9vYm/qA2l?=
 =?us-ascii?Q?gmM4a3m/r72zqf47LmkJ3HlYdNUbO8XmuEsXkEgTHomAScYtYT3fBZi+0Vf8?=
 =?us-ascii?Q?JYd9xPEUYiQEgXdJa7fYJ/GlCBkJfYlrYyielYmvNKHItvGElIPKNiGeDB10?=
 =?us-ascii?Q?E7q47tHzpAuTcHjarR5ln86m6WMtSp21qYfN0ZBy801MWzwftsezf6GlHiCV?=
 =?us-ascii?Q?dVmtN/3BKSnnmi0Q4qxDNsIcNT5/ANXAKPTtfwRBmuw7IDLkVHAidS7IU++x?=
 =?us-ascii?Q?/FgdhrPVR8F9nnwVKC75/7VyHqRn4sALJaQNcg/F/yjgU320W8npNryCOgNx?=
 =?us-ascii?Q?aLqvrmfKcy5Ac3bavEoQEGfJrIP9wvdvFRgvC2dRlkvUdKSY9RwBAsIMoBtS?=
 =?us-ascii?Q?mC2YiScSeHRmdi3YW20xLrjJbVHoxI+Vw8/dQ1nKsjnHVey/pkLh2tK55aQM?=
 =?us-ascii?Q?LN5ITumfv2ae6rHxT+xnCTGiAkwsHo1pIeOo7uLoMNZgfI17GquVll8tejaV?=
 =?us-ascii?Q?VvcrubzvA3MHXEOf5aaSDZoSpRDzyGDJDaN4zcGcoSYGk2/+6gi2Q7Hh5e7R?=
 =?us-ascii?Q?i60QnbEFRA5ERb/PAgEFKA5MwBBwIipnoM/HcMFlninp6Kue1x8Qx2xiZtWg?=
 =?us-ascii?Q?WCOgV5HiVClxD6zgh4XZX4zI9Aia+Zg/eR04bhq2PuvvNFo5Vb8WnWWZ8K4u?=
 =?us-ascii?Q?+0T4lsKOIPR69vZfRy3t/0+39t22WwZhI17cTKYuzrmHrhMcG5/1DISYC0xD?=
 =?us-ascii?Q?a80mwA7ulmZvf4TqpzsOOv4wRdTSOz/V5v/jGw3P3LcrSULDvZukRUnnaBvV?=
 =?us-ascii?Q?5az6or9cb5rHKVD5GWXt7+XoMBnghQm9EATx+YOogzJaS+weOOfJMnh4m7s2?=
 =?us-ascii?Q?tmE4ZBf1MXiH0VYTLksxOgyeTxqS4QzHEKWfgBXKjj7U8g/Hrnfpj6vs7o+A?=
 =?us-ascii?Q?Ppw2ad4pzY3qaZWatHvkvgMyvj/31HrJ6uXsssDaNxY9LZPLWmlNCqcuhcfY?=
 =?us-ascii?Q?jMV91ceKjioXBttHs8KfYnyK/zph10Jted3OgJIcyEn0ng/oCJWxQLTWBYR1?=
 =?us-ascii?Q?NYD85vWxCFe5djeOsXm0QZEhdNmlGKuZG8IGLrGdlSZ/AaN4+AJ022qGY58r?=
 =?us-ascii?Q?i1/aeTeyOgxbzYYsg9DLKOzhacdsNV9qzG9LmY9amtrd/vzml6OXbJ6cEPq5?=
 =?us-ascii?Q?WhNV7hJkH+t1fDe3Y04t2yqdxNmmr4wjnuasQHlfNn9OB4gd/h6OF4kwwCOk?=
 =?us-ascii?Q?2O6KO6oUd0f3VfKzSsNQThTiinHAvD+xiIlB7XxDqoWfKNZoXwXv9W3IdUbU?=
 =?us-ascii?Q?LmdXaJH4QqSrNYjHrmeQtjT+XwEGv0HU0arQFxSi0IYLuqyjKdvz2sHkjvT9?=
 =?us-ascii?Q?/GiFX8VH5EgrlK0h80pUVZpwW2IKQj7S5416UMDV2wDzXKsa92PJWlMesafG?=
 =?us-ascii?Q?UqZzLoXcibT/L7RCIcKrazW1O2hKdRzsSnb3hEjL++Tf7f2CZ16GvXBMIKpo?=
 =?us-ascii?Q?Q1IQm1aQ3sJ+oh0N6dOmPsc0/Cxv/la3wiLUgXmifgkJIjmshfx72i3z/jkp?=
 =?us-ascii?Q?MjxIXz2P/RdEeBr2I1Nu6xMAobluYVg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bd95bd-3259-44e6-c05f-08da541d4d01
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 07:03:25.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TAZ4qxr1DAMpmT4JX+4cmXbSetpRvOMIrvjmzuNgHfXvX6NiWBkVDdQdS5GuApUzMLkUXQwO82ZACvhG+XlHvKTOTjIT0w9UddgjR1tZK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6053
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=888
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220034
X-Proofpoint-GUID: 9HY2lD4dADpzaZLdJe6P1sM-kshcANGn
X-Proofpoint-ORIG-GUID: 9HY2lD4dADpzaZLdJe6P1sM-kshcANGn
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

This is a semi-automatic email about new static checker warnings.

The patch d648c23024bd: "wifi: nl80211: support MLO in auth/assoc"
from May 31, 2022, leads to the following Smatch complaint:

    net/wireless/mlme.c:328 cfg80211_mlme_assoc()
    warn: variable dereferenced before check 'req->bss' (see line 324)

net/wireless/mlme.c
   323	
   324		err = rdev_assoc(rdev, dev, req);
                                            ^^^
req->bss dereferenced inside the function call

   325		if (!err) {
   326			int link_id;
   327	
   328			if (req->bss) {
                            ^^^^^^^^
Check for NULL is too late

   329				cfg80211_ref_bss(&rdev->wiphy, req->bss);
   330				cfg80211_hold_bss(bss_from_pub(req->bss));

regards,
dan carpenter
