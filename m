Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1714FE2C5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiDLNdJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356031AbiDLNc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:32:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF51015;
        Tue, 12 Apr 2022 06:30:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CBvjhn028018;
        Tue, 12 Apr 2022 13:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=1+kwWyxHjLRoQK40vWzS1632ExnFpY7GtqTdOGQ41Ik=;
 b=rvtnoFirO449C0g4Qc0VXhXGpFLnmz/JB+D3TxbPC7f0HPsucO15n97DBWqn2ccmbFES
 q+73xfcfaYPZyuDmzmli/2Jr/qQVVU6DqSEdU15QndWwPAbV96BlEx1nqYqXW0tZhtg+
 U1RukvLs8MMMmhlMSlG3n3UKV/Aci20r8iEEitROctdfgAYR573FbtO7LyrvPY/kU7a2
 AKFVNAWF+ipIbwOcg/aIZhgRgF2p1d20QGLxtXsNT75NcgDdv9GyBqnykgidqrQswwwV
 P825YUCSMYs0C7lfTteR/dLJenI5Z27rCparUeyHDn8mPf7zvra46OmWGrmgS+HAUqYo kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb219xh65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 13:29:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CDFiQt015256;
        Tue, 12 Apr 2022 13:29:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2y4j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 13:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyzAT/Wh/mJKHlt47YPxiUlNxPFJb+UsbYaUXNErQp6TGM+oN7Jxw6odMWYvDsCTXSzN6a+Ksop4ez1ILP8vZuIchainfSqYMaYI/Dzavs8h2v2HX0CMlJ1BEFDgb4zxxIhkI3HLRbbZmSgSZfeZmPfawnexkqlqUPRgEYvHNATjfSC7/ZCUB8VU+A9h2mg+yUvyBoThTfTOLytnhgglt7WzZ7KyFteYCblBcZZpsOtkhwiIH+GiGI6YQUnnjKPzS/e7/1gkSZo/vpxhBjHGvzqHaLJVHCL0xPABdd+Z9Bo/0FEjyBTMXviYf2fVKEYcPdvMzJXjOpjf4WFPYLrZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEQAPK46UBh+zYYVhFHiaKbVN7E94POdQmo2YKRxv20=;
 b=Qgr+rYIGVHID5Iy1oqyI9PhZ2TrD6r1EJ+3nGfEr0LOqmBVGQl5Ks5HSELd/t+0drrIb3TvCAC68u5faVZUTWsqlk080dUAjmoGhTs1xX4E2iIFDxXyNwhKpmO9p/zvTAhkn2t764sUznF3iEZCBAghut832SJpFICoz2vn99vSi+VBCxwd/urryoWVEfAz+2a5yvhiMepKGMOtXIlWFL3YS2qk0/DekylC5zyBN0w22EXHyRfKevBhgKWvgRl8LnEj9DxW+DZzxdsQu5doYPYR85ZV5IbEfc70PJ5lQYUIw87rsNclnwxX8gx/rpjeZJt93d9sCfWWpWsSYMQoS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEQAPK46UBh+zYYVhFHiaKbVN7E94POdQmo2YKRxv20=;
 b=Y22ZTxy3hWtA9l5jWEsTukNH3kuiCfKjE3GdmfeVXBYrGqiJzGlhspwYQnT4Dc3iFQ+M7DGjk2JxcKy1hSq+fCi4zk5Bi57jJ0sWK0ThgyLvfFo9RGXkYugtP+JGlbjyIbJqJJyt/DAvjp5JhUxkSlXWEhzwgL4q6VafiNS8vz0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4533.namprd10.prod.outlook.com
 (2603:10b6:510:39::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:29:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 13:29:29 +0000
Date:   Tue, 12 Apr 2022 16:29:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with
 invalid rxstatus->rs_keyix
Message-ID: <20220412132918.GQ12805@kadam>
References: <20220409061225.GA5447@kili>
 <87tub26ir2.fsf@toke.dk>
 <875yneo2jh.fsf@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yneo2jh.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2503587-0bad-449c-6498-08da1c8878c8
X-MS-TrafficTypeDiagnostic: PH0PR10MB4533:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4533C504F77077D9B42064E38EED9@PH0PR10MB4533.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzQg9cTglOdv9QQd9jLW1UFmAbochK0AuxQzesUjGcEfSf2CR/mmTegJv2snvai6AsdUyO0ggdUBmKRqP1v3jwC+M57vvKmB8IgHhqrHLs/f/qZpWIGMDnmqFraZ5ZPsPz7YhyvelcYLAwrC6iOL6g43dKSYcXqUfLDGO/8tdSrs37y6f6KonreewSWPLvpXtiRCRDVu9Op+6GHBWFEOa8WKILgzb5MEffAL13FZgo3v0neBRLVsHPtLeTKM3KqQRd746M+xN6q54hTIBrhXZywbdCYntJ+GQl2ocfKnh1zURnFuAeYsI7CxbdxZFOyEzTuMyDTQ+lk76Q7lEKtxUgXI+q/IKGuCjxseB90zGO4aERHDuIThwB1FQfg7QuxSql7xtIQCqt9Z3qd5HI4i0nJMUqUT4l11AySM9bZMuRMWr0w8JqKZiftIeHndBVwVZOpM5wi4KD44r1Y1kG8DG13Vhzcj++62vwGnr7LAvguWKIPARExvVfDPlbCZi8wkLlC5GNp2xY++uPvJvw09Px8DPn8ECeJBJia9KpQrWfciUzU4I8fCebRBylSyAHks6/Tg8OmdzkJYtHaYxFXhG1cIdYgQQGxrRIzWr65JDbnzucoeIqBIurg5dGwtrzcaNajp0CftKIbgkQVp2TCz6AIgii1MaPxlUbHDpCI0HzD0dKgi7QpF/mQ0kB4vi/zLAnB8DEJ2Xn9OwYxPgigesA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4744005)(44832011)(66946007)(8936002)(5660300002)(8676002)(6916009)(6486002)(2906002)(86362001)(38350700002)(33716001)(9686003)(6512007)(6506007)(52116002)(6666004)(26005)(4326008)(316002)(66476007)(66556008)(38100700002)(66574015)(1076003)(186003)(54906003)(508600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FNJlftX8tUPpUi4fRGsfZsKM4dSRT9yIPsL1BeIHLnEa7WHSYc5DMvbjRq?=
 =?iso-8859-1?Q?b9WPLkbtd6IOcNC1tJ0PZG5jbonmDzFGSfqVhHU4WsLKIu17Bx0di9kvQP?=
 =?iso-8859-1?Q?lQumgsmbqfhPyBx0ex0AdscvIKD5YP3oXdpYl2YLQYxPC/WD2QUO9PEilo?=
 =?iso-8859-1?Q?1QIJwMHheGhN+BCydPGmWDIMFjyhMfB3mqjjzeq57A01OnTci8w/7iH5ix?=
 =?iso-8859-1?Q?NocBP0TwhZ6MU2mODXvm/WHBiBwRFBz5D6BeqnWWXpBdOuEa9/s0Pm0t1J?=
 =?iso-8859-1?Q?+MR4H0wQGfoQ6JuKS32FYPVnKSNBmhOzGBAoShdFrjoqXDLAOFg09siSRs?=
 =?iso-8859-1?Q?P4GZzVGF4YuU78oxNDxI9d18ClLIPpnw1Y6H8RhGTDRK6TbAg6Txfpb/yf?=
 =?iso-8859-1?Q?+RAg/SN93SFr4Ge+KUHN/yg2K0FeexpUwrmnYCYi0ceAmDThFfnUZ7eiXU?=
 =?iso-8859-1?Q?Knc8hUiIUhTqFwCs4owura6RhV7YO28Yp71hjRpALZZ4hnSjBYxYPUTpAG?=
 =?iso-8859-1?Q?A/sBZPMJPlcf6k4CcTBfL/lqOtrVuzwycgv7KMADP4cZa4fOGcPnQmsyN3?=
 =?iso-8859-1?Q?W8iqRbKKxIIc7M1B4Xov5dmp9T9kp86o7TmF01F32uB9CkEisUhspDAHvb?=
 =?iso-8859-1?Q?SZMY1fqGh6GQgXymZw96sySm0meh6FF99eXv4JUyAMytkcoPHZHQPxWu//?=
 =?iso-8859-1?Q?R8a6Qn1MUfy6YKARjDhVs/2cUJzcEN8gT9Kp5MnssWmK21qnVyPRiqi/Gt?=
 =?iso-8859-1?Q?hOc1hl9dCQ+mpf/azrgUNO/fxfjllzQHfUCBZ52meSoDu3jKTKrf1Kzztg?=
 =?iso-8859-1?Q?V7U93kxfqtSkChVq4Nl5iggJhs48N8L6mZAqPODAysdws8d389np9gw34u?=
 =?iso-8859-1?Q?eZB2BHnXfxgy1uuD5aK9ZYusA7QikUBN6plm8HCFTuQ8akAF/dApUmyDsf?=
 =?iso-8859-1?Q?V74oCN5v8Fo80gVa+q+/BrKYLCY1pEU/HUFNsFQnfIA4yc3SNQCX/OJws1?=
 =?iso-8859-1?Q?KSwKfEzHIEijRJt6RsyIS4J/Zh3fq/xwswOwqCuYfmxiHVjTi49KschPUJ?=
 =?iso-8859-1?Q?AZmNVjd6vv43QUkQ88lkWbeNQzEqrKwMb+Y04bjlL2hcwakyWqKVjjcaSX?=
 =?iso-8859-1?Q?LBXe3LuiIzYB7cJB7HRHExebGvmOO1wLK2qHfEzTdXo+bxI4yU7/F4jGKp?=
 =?iso-8859-1?Q?bwOWKose/MPCVBkhSXcIh9wa0zk4K7dRSz4QCDIAhm0hSXv6h9zhY5d4lp?=
 =?iso-8859-1?Q?/pUWtya6hWA55JfmdkMBkGhYjHGCAoxlQBEsFNNeLYibst7PmD4AsFA9bE?=
 =?iso-8859-1?Q?iCPwf7850wJ5kHs1Ol9B27dH8UzhgzMq6kOrb4YY/k3VMELs1xIfo1HvDZ?=
 =?iso-8859-1?Q?QnWVndo5dS1o3f8IQJGH3SP4EoGggsrFRwJUhbDKUbn8Ag5FEPLCTCtfRM?=
 =?iso-8859-1?Q?J10dh9e3kuUI7UuM8Z+fwg5R2Lko44kaOsSXmfTVRPkvPnNncXtDS/oUq1?=
 =?iso-8859-1?Q?T70gqPPN8mYeHfVSCIgbmQnunAbNClDe4S36NmBjaht7KelyquMHaBLwbr?=
 =?iso-8859-1?Q?rGSbgBpm6YS5DZa0UYvseglwADqgLfSjiyfk1Xl4avzG9Ui4jBX5C+taKL?=
 =?iso-8859-1?Q?5dwxp2zz56EnqCGrU4vbITcCetpiPIsTYtCXc6wFw4/bjrvq7okPVAuOtS?=
 =?iso-8859-1?Q?yH2Po7ScIt0PZhv4IJ6djlwtC7jhMJTbPD+2+X6RonYvvwOrijGB4/fks0?=
 =?iso-8859-1?Q?3v4T3LqHIffoED7KDAITqdamKzCuVnA58Kbu/CGo71XMXpXlRdMKEGAYac?=
 =?iso-8859-1?Q?90pA9IPDZ3avJPidVoDaeho1MsdzCTQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2503587-0bad-449c-6498-08da1c8878c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:29:29.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L+ssECxevyA5vSlexzBdINfPbC2vs4vvksrgLVbfiR5mDLVS2WuGv5XbgRR9nImwHcwON2l8IkvVnQIBH3MbstgjhFh5gFNzllpCsz3QyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_04:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=990 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120064
X-Proofpoint-GUID: wZeHJDtm8U9JF36dR1BjIwRa9Y8GHmD_
X-Proofpoint-ORIG-GUID: wZeHJDtm8U9JF36dR1BjIwRa9Y8GHmD_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 12, 2022 at 04:26:58PM +0300, Kalle Valo wrote:
> Toke Høiland-Jørgensen <toke@toke.dk> writes:
> 
> > Dan Carpenter <dan.carpenter@oracle.com> writes:
> >
> >> The "rxstatus->rs_keyix" eventually gets passed to test_bit() so we need to
> >> ensure that it is within than bitmap.
> >
> > s/than/the/ ?
> >
> > This I think Kalle can fix up when applying :)
> 
> Yup, fixed now in the pending branch.

Thanks!

regards,
dan carpenter

