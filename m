Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1F44D741
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 14:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhKKNeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 08:34:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42296 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhKKNeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 08:34:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABCMDwl008244;
        Thu, 11 Nov 2021 13:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=itCZBsBAiW8YlK4VuoYBmo6gnzUbnMqsAtgErctfQmE=;
 b=A2vE0bqYJQWKHgSbjgLLuaMh8oZdesWXYSaNmrL8kKaFm3FTRPc/srUhaAttbZG7MDt8
 QHVAaRNlnMn5oQ0oflPwK5RZAqGHubkeEGszo1T9Jk+U6+poB8iqLEVJmJ9yZ+grUYjU
 OHbHhc0y0NDbsP5nw7lMiSvb1tsXKBAaD1Xzr4CQsb7Gtj574gi92q2lHOlE3os9igjn
 Eef4PUy+IzaJGA67fKKEzCnjyY4jNjd1TZvf5fY5wFk7CffvfI+6p+yoM0L4JwJF/Amh
 Rq32B/BXuTmSIi9aUHvY/JRp8xkTFljzlhkMw96OKpj/VFBOGSiqlGa1Zh35+s3B2X+3 tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c880s1uyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 13:31:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ABDU8D4144217;
        Thu, 11 Nov 2021 13:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3c5frh6cfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 13:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI1r19+1PfaStHufzDgnBcwpXtBt61zFxhjyDwQN0kQJDQd47+Mx5C8nrMj2ReRr6JBjqN2fnHa4LJzTgeAAPVk40ghWqNe+kUhofHMvKlGZqVdfpjmSxHQaWO2uzy7SAceoCrbKtXvfLXsAcU9qEVvAuMTJQrUTSNz4ugFDZ39B6XosMwFBi+Lqvu75QYel6p1HyFheqPVd/zw7KRoYIiHSU9sFmDQWoVgO+yc0o1r4PQtjbBvmF/LqoYC9+lzsFpFGV0OJI1q5o0h+k4YJKjAng29k2n6IbiPjM0tAbofL9rxgU2fgandiHPPlryD1271jLlhK1uf6IvkZsGDF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itCZBsBAiW8YlK4VuoYBmo6gnzUbnMqsAtgErctfQmE=;
 b=XfbiOi0TK4MfDqTS/mDB2Qp5zIqtlsAskCDlPJInTuf6nwvOERFPHd47m4Nx3Qt7lojjOnzTZh/KLkT/3OTEhpwMz9R9GRqCJOzeOa/cvhfQAVMVmZFxlBZsCushLu+4Z8Aack8CyrscrMNarUoxHeRTXw640J8ooPSHNWL9p5k/oSBX0pENrDXfRP7M3W+BNybfKEzXY2zwciGVnnkWJZ9nZF/6zqdMvbCznzPWXwLnRtHCbcxoUDbzYih72JIZEEzd4bVwyArjBNHCdDKRzcUDR8DV3jXWevN0yrZhCrxByc/IPc43vXjU4ibfZDpEYn/xMUu+VJsqbEmoxb8ZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itCZBsBAiW8YlK4VuoYBmo6gnzUbnMqsAtgErctfQmE=;
 b=GPugos4nezRAEpH06DI8Puayus17Hodoy7dkTxYWsg0Qe7+5sUpuLMwXBJKoaHouUZl3T1N36Ek5d8JrZflBLzQwQgUyFgkrqJwb2jtGW/u5XN9mKx2i3o8jm2qL5lTZHJcvInoJaBS8bm7C0MDPXgl8OX5NktsxzacD+pWPX5Y=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1421.namprd10.prod.outlook.com
 (2603:10b6:300:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Thu, 11 Nov
 2021 13:31:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 13:31:26 +0000
Date:   Thu, 11 Nov 2021 16:31:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ayala.barazani@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: ACPI: support revision 3 WGDS tables
Message-ID: <20211111133116.GA21433@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Thu, 11 Nov 2021 13:31:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1717af42-2aaf-4848-2da1-08d9a5178fc3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1421F37134E748A48F2958D08E949@MWHPR10MB1421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V36zHbmMiamTXQp+8Il2UCxh9L4HgtbwkmoiczksRPJuL7mM4za4t1BQFRUTPtJnz/2uu0XthRzWGZwYP0EAryh+vqAT0OznQPaya6Pe4ahdtz627PGuZo+t3Da7w/r/pO64YxClY32RhIuh/ZN50c3HzMLRiRA4q3tZk1tSeY1C+kWNbUAnMeXTrdxhv8gCz1mgotNT0bJW+dA14YCrvitbJkKjYo0UXcqoX7FirPjmqKgKt/p2vdzubM+n8sKRxa9S/gg+FYHkHMP+5Jj3PLk9+OM3rWaQUwAZPg8mJjOi8jDnTd4NE2W0qLGM82QKtMRu/R6rtiC5PKO1COlpbO118GuSvijzix1HGNqf7cKB+nQIUnt03GR5LC4Qph2H/+YxmRMu3xDQ9Uua0LcvxGlQa6C02XeZl0e0Mqyr5FOMsBjOIQM88QflF1H3VGDR2dqTnuvweegd7Peumn7OmfGCzWHHIEc6FVF28Rjh1J3z7D0TLqD8XnWQx/fVC5ZDoSScrNywvq6xzCBPPiZ37gac9U+NEUTQtuOLMfgSruARTJAhwJoyCa0k7GEdqR0Bv58fT9nnbnqLgaBMW4sBucCnr0Pglrsn2BXPhciCoJOb1oxMrBSm5WANbMdmzMbPReVMVOcATK0wFWoSMcmMSeMMecHyjpNx/awO8Q1vQZoOZXEQMyOeUfur3A5bKGoSWeAMZItsDERkdFrnX/auSY6epB5bYL/v2eaUIb4sGvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(44832011)(83380400001)(8676002)(6496006)(86362001)(2906002)(9576002)(508600001)(52116002)(6666004)(26005)(316002)(33656002)(186003)(8936002)(5660300002)(66556008)(38350700002)(66476007)(6916009)(9686003)(66946007)(38100700002)(33716001)(1076003)(55016002)(956004)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MvePyq6TlA7wm1T6pheRbRYCPHhZb4+YZBWOACcWi1ynbwv3GlQlYvVQfhjQ?=
 =?us-ascii?Q?pJrDV9M/5zYJqQ8yrtJz1lmrSqx/Cj2dTYjsE56Lv3EhvKfOltKZM4pCVwKk?=
 =?us-ascii?Q?d515Cj55HLf26GAQRrg5IqHPvG7xSa6+Jpabj35pKFzjb/+hZqTFVBnEF9Bv?=
 =?us-ascii?Q?fCAxrOuNyWM4iow+DgWciM708LHNT06Zt15gkRx6Psad7xCil0pfpRl415AH?=
 =?us-ascii?Q?OlygoEKYvoGcx5rpR+ArnR75qc0FOP9yXeBhOb0A2utSim0d9m3dN/9C08t/?=
 =?us-ascii?Q?bIP8fnTXkvsrMvCAhMvxDoArkVoGrw5U9BdCPNxVr0ObXI6OkdZGTU48vTqr?=
 =?us-ascii?Q?2eIxY9jDuEgTaZHbKA9SWW3i5579HcB4Xm9DfgcNxKeniPufscqlH2XqxIA4?=
 =?us-ascii?Q?eTZU70B13/XlqxNC+xvJjEUACUJcVuVZimItAaTCU+hNXCJzLHgbQS52RTb8?=
 =?us-ascii?Q?2tiqwRz/978wfiG5PQV2Qo9GTu2PKWn+T97dl5rIbHjqIPPEriBaW/yGMvlo?=
 =?us-ascii?Q?1oYxs6bpaPsTqcAX5QR8qEfs1gtm48O7urpiRy1Sofx8aKwTjgq9Yb7U09LX?=
 =?us-ascii?Q?OiHrcP1pOkQoGnmqg5Hx8BfzBGERl0NHpQDFz8y4zUn5Pl0Um8W7AjooCXDN?=
 =?us-ascii?Q?sXngTKAnErDl09WiMBRzFt0YLhicw/mbyXG1ZPwVq2fkkRcgVJ72piBcuwmK?=
 =?us-ascii?Q?e+7fnbiUFzLcDPp86hVhoasP2oiAB9FQcyZ/1k0Hc/w2TcEvuSuiqjznWqXb?=
 =?us-ascii?Q?ct7e286h9ZDuN0aVHIJELRADsttOEbrvJsMFGRWp+bEJ3mli9e0ZuR8X+D5V?=
 =?us-ascii?Q?tzEZwGy6wSGrBzWc7Y7ChMK4JEBpGn4teG3a/KnBArv0MulyKDs/1TlTLLSG?=
 =?us-ascii?Q?HeB0txF/dSm84cN0qOjwiGKlIsHNTN6OUFIm22m4ZGn+JuSKFoT5hBRt/aYH?=
 =?us-ascii?Q?5oFDXy523yIh8p6k7W14cGJ+XLgCkOxPmIauDnUsbN4dKoOhZAqB9VywaaCC?=
 =?us-ascii?Q?VJEwItTVEFiOXid155B8HOjPckH7GHNJU87sjTBJTucUJLD/LkYHTYbeRbtm?=
 =?us-ascii?Q?XpHeX4pibjm+3DMKWzKtIwzjMVJ6xACYv7cYWPaIfVJVs9v5Ohhowj4/OzEp?=
 =?us-ascii?Q?7v+UvYsUm0UN3QKErvVguZj1GQn0/zuL0thE7JO2TaDot8h+9FEfzJ2VIwPh?=
 =?us-ascii?Q?SYu0z1pQdssZGcfjA1yxbthnCOMn81z9I4gx2k42urTK6H65EE0HV/4VWKul?=
 =?us-ascii?Q?uIenFazzXujPIy+3UwT2/+36bQvgpwiGjCYO1/irCbPN12O/j6UbN7DXwfEk?=
 =?us-ascii?Q?u7ObJUS34Jn6F1yfbsoH+I8rOaR00wfW4liD4k0+mXsUKbBzMVYqwzfsPz0s?=
 =?us-ascii?Q?UTToO3vmcfkD4Xro95XTdsLmHyLARGcWdVwzvHA0ihgQIr5KYnuGP1ps5u8H?=
 =?us-ascii?Q?iZt4ECZdiRhRmmwKSqvnuVBHMIOemOIdAZ7VDwpcsIEdrMvatw70FI/zF8pr?=
 =?us-ascii?Q?hZ/2OLO4hofaoVdbdc6vv0VMtgWuIKTA9UDd79KIgnKvG2EqcyJ+/agwj6eo?=
 =?us-ascii?Q?aU44xrufVcXnujmAY/KXc1AgbC3Nwc1fLIHDSuyvSuUlEI+3hFk+5xGkWzjf?=
 =?us-ascii?Q?8aCPY0vcLl0og0ovIujNApXFY5xZNt2WXTRqx7PuP5pT3aCDUF9XO7G1eHyR?=
 =?us-ascii?Q?b6uK4Hk3TqEbnokw3dZimAkDDMY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1717af42-2aaf-4848-2da1-08d9a5178fc3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 13:31:26.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zAfnrk3PETQU1YVKqM9KS+HUcGU0M+r3EHogwt7hd4I5jfPHRYda6pCMLzYRCFz7Eg/mfntegQ1oDJFjLl8GBsLXE1i6JnmiDSNKauKpi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=649 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110080
X-Proofpoint-GUID: Xe8Xtj7bQOXm-DEznfserCJWIgHfF6Ym
X-Proofpoint-ORIG-GUID: Xe8Xtj7bQOXm-DEznfserCJWIgHfF6Ym
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ayala Barazani,

The patch 97f8a3d1610b: "iwlwifi: ACPI: support revision 3 WGDS
tables" from Oct 24, 2021, leads to the following Smatch static
checker warning:

	drivers/net/wireless/intel/iwlwifi/fw/acpi.c:801 iwl_sar_get_wgds_table()
	warn: duplicate check 'idx < (12 / 4 + (0))' (previous on line 749)

drivers/net/wireless/intel/iwlwifi/fw/acpi.c
   743  
   744          data = iwl_acpi_get_object(fwrt->dev, ACPI_WGDS_METHOD);
   745          if (IS_ERR(data))
   746                  return PTR_ERR(data);
   747  
   748          /* read the highest revision we understand first */
   749          for (idx = 0; idx < ARRAY_SIZE(rev_data); idx++) {
   750                  /* min_profiles != 0 requires num_profiles header */
   751                  u32 hdr_size = 1 + !!rev_data[idx].min_profiles;
   752                  u32 profile_size = ACPI_GEO_PER_CHAIN_SIZE *
   753                                     rev_data[idx].bands;
   754                  u32 max_size = hdr_size + profile_size * rev_data[idx].profiles;
   755                  u32 min_size;
   756  
   757                  if (!rev_data[idx].min_profiles)
   758                          min_size = max_size;
   759                  else
   760                          min_size = hdr_size +
   761                                     profile_size * rev_data[idx].min_profiles;
   762  
   763                  wifi_pkg = iwl_acpi_get_wifi_pkg_range(fwrt->dev, data,
   764                                                         min_size, max_size,
   765                                                         &tbl_rev);
   766                  if (!IS_ERR(wifi_pkg)) {

Should this break on error instead of a continue?

   767                          if (!(BIT(tbl_rev) & rev_data[idx].revisions))
   768                                  continue;
   769  
   770                          num_bands = rev_data[idx].bands;
   771                          num_profiles = rev_data[idx].profiles;
   772  
   773                          if (rev_data[idx].min_profiles) {
   774                                  /* read header that says # of profiles */
   775                                  union acpi_object *entry;
   776  
   777                                  entry = &wifi_pkg->package.elements[entry_idx];
   778                                  entry_idx++;
   779                                  if (entry->type != ACPI_TYPE_INTEGER ||
   780                                      entry->integer.value > num_profiles) {
   781                                          ret = -EINVAL;
   782                                          goto out_free;
   783                                  }
   784                                  num_profiles = entry->integer.value;
   785  
   786                                  /*
   787                                   * this also validates >= min_profiles since we
   788                                   * otherwise wouldn't have gotten the data when
   789                                   * looking up in ACPI
   790                                   */
   791                                  if (wifi_pkg->package.count !=
   792                                      min_size + profile_size * num_profiles) {
   793                                          ret = -EINVAL;
   794                                          goto out_free;
   795                                  }
   796                          }
   797                          goto read_table;
   798                  }
   799          }
   800  
   801          if (idx < ARRAY_SIZE(rev_data))
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
idx is always == ARRAY_SIZE() at this point.


   802                  ret = PTR_ERR(wifi_pkg);
   803          else
   804                  ret = -ENOENT;
   805          goto out_free;
   806  
   807  read_table:
   808          fwrt->geo_rev = tbl_rev;
   809          for (i = 0; i < num_profiles; i++) {
   810                  for (j = 0; j < ACPI_GEO_NUM_BANDS_REV2; j++) {

regards,
dan carpenter
