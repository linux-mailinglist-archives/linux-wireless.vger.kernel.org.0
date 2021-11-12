Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED544E2A5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 08:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhKLHzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 02:55:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44902 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233016AbhKLHzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 02:55:09 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC7APFQ016011;
        Fri, 12 Nov 2021 07:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=t7x51wGlxyDBvglSozqXHIPtrQaIW/R7mfF++Kl++FM=;
 b=SU66wcEUOzkJuYu/BfCEFnB5nrMdHXcmTOTpNWXu3U1osj8mZAbn0+5nGXH7W/QIRAkp
 aLlzk/sOMUbXwCLEMmKpKd6+w1BOfogf4Hw8c1Ag/rhhuNpY/xHLE50cR8Bjev00Wd7D
 TFJ6UUNut4l1p+um4GLf8Sw92xoOKUW5onfv56CLqwia9oKqa1ntkSkKlfbDeZnIrbd9
 1ZYsjBageUVueqKrnw1KiBhOVv7cTZGV6co369zswJzmqTI7dD1VXcUu2VE3RtM8Y9RR
 GYD1k3sotZ9T3v2mU054Qv430bFNclRNbR9yhfG5JIbk7xeZDTU2pSLN+UjJIf86fraj dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c9kn5040q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 07:52:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AC7oQbR112661;
        Fri, 12 Nov 2021 07:52:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3c5hh7s01f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 07:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h87IZ4/7tBfRBYFAkTqb12OwIifEradWbDiu6juAFyxLXuxJBFveZtXyfOhWc8wMBkJx7I1/A+2Azw4pquCjCVYMi0amNScGKNS8iHSY9MTi0Zkc6uIbattBBevLTjur/W+Dm47BsqyXSX+GaGM7fuIy+8XH5st4XYuAcrqn1rDk/1uXj5bqQfI5RZae/i4IufqT8UDxYDwol9U3OSg7nM5ykKmMt2dK6V9sTsks3j5nffLiJSS1F6lPBYOly+hS3qPIr6v0ct7Tqd5u/xDAHgyMz3WDYoGHkAvwZYXYisgOQ98Ucvi9NXIJcVbamoZd4cemx/OAZ6IzTrXBhLEnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7x51wGlxyDBvglSozqXHIPtrQaIW/R7mfF++Kl++FM=;
 b=eP4N3qE1nUKVgCtLCoezkuTedxvzi1aEB3asMUu1D8wvhx/UQ4UtBj7NJ9j3MviuTEx6Sxn+FPhEPsYwzOZcw1N2qqeXJscdxD8bW8MyWSvhpYI6K5uT/6gEHK8VOOLkGqepG4SJOW4PGN9X/D/F7zJfqo+9A2mwS4fO1VEEn8wpuvQaY+jp4yiLb+MSBpACprKmb1Bq7jWjui5Be1rUYXTzi9juVyNeC1GhyaUxD/kk85PyavIz+wefyyRRznOaryibRMVjFyPtEvhc8H8ijCTP1Vzxy9RVD1Hpo/1xX8r9VmjuSt449sMhp6PLp5U9Ol7bQXX3Xl7T43b/5yURkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7x51wGlxyDBvglSozqXHIPtrQaIW/R7mfF++Kl++FM=;
 b=Bf4f/xsECt+csQZRZZTjSGTN68GdcFPJAm1RdXUBkJxgyHtcz/35Qc21ovuNIug1m0y19NvLYPc4QOtTfriYQM/IPVeed/JquSL5uNwok9wgoMPGYh6ZFwm0/ENutLVgDF0LmSkkdUECeyWQGuF1fad3BouOtXKoGQQG/9vgPDg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 07:52:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Fri, 12 Nov 2021
 07:52:11 +0000
Date:   Fri, 12 Nov 2021 10:51:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw89: add Realtek 802.11ax driver
Message-ID: <20211112075159.GA15433@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Fri, 12 Nov 2021 07:52:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d75674-12ac-4929-07fb-08d9a5b1555b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-Microsoft-Antispam-PRVS: <CO1PR10MB451312137D70122BD12FA1B48E959@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UglohBCDGYhylsBZwfBV/XMwZQzOkhcYeNmr+sTJG9hc6tHxn362g+J/fuPBkBM5yjkBsJXWIFwk5YhNU73hgR2q3iBH+FIADRFjfGk4fyJW5PltJl5/GYeR0JI47t7SDfwtIBQCVvggQXtDM/+uUFKnFce0jAmvu2DV+V/7z9cfwqRC4p+7Y1HbWUnI+gvwNi8t2yXdgqO5xnSgE4YlYa+w6uoV9voRKGVudc8kwbbrkPnJCXudANxsOE+bOz/B+mqApiii4C5mRbBHpx2a8ChoDV5Oidw9BBcZW8NexOE+Ge0/Mdyu2rtJxI0chRFF7tcbv7jCW8GCa7K8h0V3fYfHd3SSBo/dh3urbruwT/btiIFRlbHcbILKjA1Yam5E42XNJ9Lo/TUtaJMzwOuQbb+VlWa4SWzrFAg49nPuLhe71hY/vCPM/aZJegdv5WS8qsWzGbJrISDe2nJyVOMTSmS8UQSY7FfiVFubYTmpx7DXWTch6lnTtAoSdrIe9RPg5qTgvDJj8jOA0vu7IS2ehvbFHS/NeRfosJSfg8cir8+m5df1WKUPfFJyZNGer8xz3lfjtpWtpfmmQNc17JLBpoRKPk+nCkoDhe1zue9+MJi+R/EiMnPDt+bDmsgxi2qgulsPClleJlz74+jUUYjnybLVT4nNR1taMp3En0pyerK/yGAC1G3cnTR2Qe7OlTqrFdXvh8udpWAy7q+55GM3NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(55016002)(52116002)(4326008)(86362001)(6496006)(8676002)(83380400001)(9686003)(38350700002)(38100700002)(6666004)(8936002)(33656002)(44832011)(316002)(33716001)(5660300002)(956004)(66946007)(66556008)(66476007)(508600001)(186003)(1076003)(2906002)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpYL58aUesh/92eutQ+AsKd9pbEb9SCYfW7E6Tt+EUb98GgC3rUGYq9hvS9t?=
 =?us-ascii?Q?EHENZLD1GIK6pSeutVk7O8cvv64K3UZMFT0JB2OUvqamEHEX9Kq5btyQeteB?=
 =?us-ascii?Q?Jc4BCJZibOI1fMbN4aOOwYVKWljJjoDUen37LArSnqgc/rkOsamvfJfuQ7cP?=
 =?us-ascii?Q?PDLsRIpgg7cxLIv9yftY9Z3TlcE3yCjdul1ts2jt5kcflNPrk1EpWablfaq+?=
 =?us-ascii?Q?HAlgVcjDa8MtJ5VJk8Au/mPD3vKlEex2LWk3wIy97RV1CWLKvafENHwNWGkK?=
 =?us-ascii?Q?BA2J6owqVxnlOiTQsW4cmI6iic6bYDhEH0NJxF8B/jhiJigAcWbFUO5xdeKt?=
 =?us-ascii?Q?EbS/ogbOsjmoHje8SnaOvrgCW2zSt28pggq5Ew10EGVGTdf+zyHB+xaHCdpa?=
 =?us-ascii?Q?gPTVwIF3RC2a7IdkOpw/ZRx4CP6T0RVyWEvfQHZaOUG5Im8uDMwVYiMqsyMO?=
 =?us-ascii?Q?3sTT/LS2/muqjrxixiL5uPmFwqAkGzCNbESkUTuXGPAHixCrHRqVU9FQpbPK?=
 =?us-ascii?Q?e/ZPeGR9YFRkpMDhHDytYtw1nQpb6KGFOx7ZYuplNjt5N4c/22UE6TNb7oSE?=
 =?us-ascii?Q?GVGnPqKO62g9nScZCiMGoaWRc156VIsQq80AwyLwmnzVFJ1DWlHUIfy58ApA?=
 =?us-ascii?Q?UHGkHFkv7TjRKDGPjObHHwwh+lWSi8P3iaZ1P2lBeS69n9bwBWFBukuCtzhY?=
 =?us-ascii?Q?EcYjQffYkn9VgHxvLuQXP6F3DORzBPUyh84J9RsQFkRr20reQKzsiLU2mxwb?=
 =?us-ascii?Q?OGQ1jII4GUCpwto/j6JuwBaKlqQUOCrDAmBa4u3Sp5gzSmm3qigazNdLAG7H?=
 =?us-ascii?Q?s4Oi/ipxFmC3EHmrtb8xZzyVZJ/l2AQUXDwdy66PvXKmO/llogBtD2yhw5sk?=
 =?us-ascii?Q?UImIgDKMzb0lZSl7y/PFwX3GBLdDy0yhoO+4bi/tpaidRvrvaLfUTJ12AiPP?=
 =?us-ascii?Q?YdOCdel7C+fzaAd9arECvzn8zXCQT15nGSBdN3wRx5hGT+jwBztlFlOROlj5?=
 =?us-ascii?Q?UaGzo0RQvwvIstMZr7Mt3Yg7DBXuXb/kaC5ExTlH5M4e77SMxNP1HqGzTt6e?=
 =?us-ascii?Q?vPyPLiv8OZFWQP+wUzIfpwBfJPzbuUFwn255/ogKkj2PRyRW1hNWWbkoAzS5?=
 =?us-ascii?Q?vqe4Kjmx0tVRVGny/qQFQK6ZAJDAZYjtqrWACVOJQFKBrcp/ALLQdRM2vNml?=
 =?us-ascii?Q?aLq30hVsLK6RqUP9p8t/tXMyL/Wji2wJJNAV5wXfS4h/x5fT17ALZRLWKuWI?=
 =?us-ascii?Q?gVd+Duv6xApAV2yAngjBjeUEvpmYD29Z0AqgJadvTApSfj1vDGCPQUWWdSJ7?=
 =?us-ascii?Q?jirtl5+wIavRD84m5cn3tV9mHbMPwzkTTJXNmY0hy8J7wKdKgX02mEC1LIVj?=
 =?us-ascii?Q?skpqVoVSc7i0QnzarGUhp9VwO6bp6d4b5Fi+zueQhtUZ+PqGc5nKCMH4KKz3?=
 =?us-ascii?Q?iNMPOf+gr4NPCcEFiC4Eb3e+O0vLz44EnZ5ydORXbmWEWg83CwtJ17O0CQQL?=
 =?us-ascii?Q?cxi5c0kKw3zKjKJa8HQFHLjw0pct+fT73RbfY6d2Znw4w8UoQPBweWQ44qgk?=
 =?us-ascii?Q?dbLdGIcL1qL/rnzq7hcvAg/dyhB2GOR76UN3F7M1JUGD4Zo/TUhipJPfAdwd?=
 =?us-ascii?Q?ZXEe7cs/tKVb2hba4HJoCwhtU6kJ6UW6KS/e/33N0tJ2IllK4zXF7a2yiTq2?=
 =?us-ascii?Q?AU9e10AMOaCCHLezOGEQGbdNTl0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d75674-12ac-4929-07fb-08d9a5b1555b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 07:52:11.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lkd19K7UuxGgTt5y4YTCxzCLur769AqWPlUWcMIJbJEPXt3xqnQuCVJqrVSzJMy4yw80g+AjTSlgx1SBSPDZurmO9/p0VXDqSxVi6T4iFJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=697
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120042
X-Proofpoint-ORIG-GUID: _rxCMi2hs9JAlb85aSxxb3dsGBZ0U3nD
X-Proofpoint-GUID: _rxCMi2hs9JAlb85aSxxb3dsGBZ0U3nD
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ping-Ke Shih,

The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
11, 2021, leads to the following Smatch static checker warning:

	drivers/net/wireless/realtek/rtw89/fw.c:1383 rtw89_fw_h2c_rf_reg()
	error: buffer overflow 'info->rtw89_phy_config_rf_h2c' 3 <= 3

drivers/net/wireless/realtek/rtw89/phy.c
   662  static int rtw89_phy_config_rf_reg_fw(struct rtw89_dev *rtwdev,
   663                                        struct rtw89_fw_h2c_rf_reg_info *info)
   664  {
   665          u16 page = info->curr_idx / RTW89_H2C_RF_PAGE_SIZE;
   666          u16 len = (info->curr_idx % RTW89_H2C_RF_PAGE_SIZE) * 4;
   667          u8 i;
   668          int ret = 0;
   669  
   670          if (page > RTW89_H2C_RF_PAGE_NUM) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Lets assume "page == RTW89_H2C_RF_PAGE_NUM.

   671                  rtw89_warn(rtwdev,
   672                             "rf reg h2c total page num %d larger than %d (RTW89_H2C_RF_PAGE_NUM)\n",
   673                             page, RTW89_H2C_RF_PAGE_NUM);
   674                  return -EINVAL;
   675          }
   676  
   677          for (i = 0; i < page; i++) {
                            ^^^^^^^^^

   678                  ret = rtw89_fw_h2c_rf_reg(rtwdev, info,
   679                                            RTW89_H2C_RF_PAGE_SIZE * 4, i);
   680                  if (ret)
   681                          return ret;
   682          }
   683          ret = rtw89_fw_h2c_rf_reg(rtwdev, info, len, i);
                                                             ^
So "i" is now RTW89_H2C_RF_PAGE_NUM and it leads to off by one out of
bounds error.

   684          if (ret)
   685                  return ret;
   686          info->curr_idx = 0;
   687  
   688          return 0;
   689  }

regards,
dan carpenter
