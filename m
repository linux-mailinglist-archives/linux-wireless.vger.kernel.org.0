Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829E3FC3EA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbhHaHom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 03:44:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37644 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239801AbhHaHok (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 03:44:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V56ONw013862;
        Tue, 31 Aug 2021 07:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=WGGOHTT2EJeIvfDuVsq4I2EG4DqGXRZ08tjl2FocRHs=;
 b=qLc6zRX4QomuQObWMeIpOeO5Nb9Ecx/IXWSdmCPwTPGqDOkvkhET+ufKS26ryU9olJGm
 hCTeuGBciJt3LwI9sOXRNLeGn7epMwd18+XKi0vF8e1PlxeIWZydIcsWALTAuHiK1xVd
 Eg82rhLoTvap9nJJbzp1nwmEjs/DqhfUKvYSjNn7Nz4oFBMN6bF439Aplz+YXIul3z0b
 RpCJZCuD+MIprLEWLTnJTtKMFCYoCs5d/iRPmPQgifOh0qulMmDcLzFSJvkRez1n7jvG
 T4WC5vQzActzxDco1HynLqjEHtTQp+fNl7orZwjZHJYlsZhRUjJILy3hMbFehTToArCR AA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=WGGOHTT2EJeIvfDuVsq4I2EG4DqGXRZ08tjl2FocRHs=;
 b=fkfkVA+Xt0T8bWhlQpOBFRbi7FQAsyOBUgt/jyBjNE1VdDlkSvpH3c7+3QxWpf7oX/v9
 hsb0evaUbCIFK4Q6AnbGxYibj/r4k4NVvtB2z1BUvlVXhxg/c4Qo21DYXou/REUpNMFB
 M2ZDTUzGBsbts7/XTaP7M6kjL/9nwL2JxLN5Rm6mnFS63+CYVSOD9dpkBst9LGBlx4O5
 O9FhhDxMgrLGwbLr0fXLNTNqJ/TdwwTjy5P90qhBhrcxv2nnQzCBdvk9lKcB5wSOy5TC
 0xaBIdz8G+liYqxlN/lYkM8eSfQNfxeG6B4QF+eJIRVx+uJsnZqn/uch9+FWQO0JqXhe 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase0289ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 07:43:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V7UE73125500;
        Tue, 31 Aug 2021 07:43:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3arpf3u6f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 07:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkUvVQ0NVxe0vXw/Q68KWJlvPLt9wTBkaabQke/KSlCuLRhKnv/sncmjgCX1o6Xke+M6vD+Mmd73Dd2Tj8/735Yu+ZU/hS4O83F4ln+awpzr7K0XGpHMfjV2SEu3gbLj5iYNvjLAkka2uA20RNw0PdGYKjt2f9xUlGwGymoUF9lYnqfxIwJ6Tlo+tpid8MTB9Owqmc36l8J9wKiQd+wiHwfP8lGnGHuwAxODY2VQy1nh4pAvx9si1/UWrZNfITvnKFV+zgU/RKkcWECaKUeO3r4NRxvr2K20dWL8C/fncmHe/kwrAIJv3Ano9mgr2uo0mLL5G8tr/iBagyjLYfzAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGGOHTT2EJeIvfDuVsq4I2EG4DqGXRZ08tjl2FocRHs=;
 b=L/CRSByyRb7YFRUPtY+HV03l2YWF+HKFJ2KdanhYDu0SpdrQ+6SY0iM8uyajcmUDe9bXuoAVXmh/xEXQsIOn3v7PlCPqXKGLssyXYO+9YESdBJEluGkj1jaVgH99BtU8/Wnr9P+S2M9+wLuGQm03m4FWZWKkMKum30C1zX+akLM6VBVxJmiAEwRqvxobABumsSN5x2Z8YROgXql/sVTAIsGgUmbkWF4EOs2e5zxC2VgAkLFuze1mDsLp1bLbz24zBVqReGceLUnJ7r93F3yFOnwfTVPlOuZTefpag2C8bma2IipAzUJy25PZlgV6QKYqMbQZH/G91W23SXyP2HHUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGGOHTT2EJeIvfDuVsq4I2EG4DqGXRZ08tjl2FocRHs=;
 b=fB5+1itTNYwdBVeStwhT0beyH+2JEXp/W5Roqa6Jm0hPN7cgliV32REPrFeQgOtLis2W7ecL+nc/maPg9hhisHpmjJ+X1ztaXDrIWoGzVru3bXvmeiO/iWd4wERAY8lvOfBHBA7iBdq43d3HBCgzn7SLBp5I/m5tVX5yJqHqLcc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 07:43:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 07:43:40 +0000
Date:   Tue, 31 Aug 2021 10:43:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ilan.peer@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: mvm: Explicitly stop session protection before
 unbinding
Message-ID: <20210831074305.GA11178@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0286.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0286.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:195::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 07:43:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd7971a5-64e1-433e-3753-08d96c530c80
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB450087B3FF5C5F1FDB4A2C548ECC9@CO1PR10MB4500.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NeMNA7tvaFVxoVOVArvtE9sYp23mtDnfRZlYNRKUgwuV8QwDaldzQHJXVnp0zlKcQeSFn8Y8NrNIsfZx1OeLExuTHwLSD+t2iYZ+oFAh5wnpeC8xbw3u9MfUeXE8frcrVVwRCzcrc10ONV1FDq//RFlADHS2BK61ya03yhlOCToEt4ScSYgDSvM4Fo3A1r7nlaxLKfzM92borPzE7D6g/R1QfaHcbNaMANQ88NiUK1Y44DkGULgi43u1tVg35erw6ev0GJNzUAAUgQsaiE73bH93DZPxFP68M3dDhQI3wFrDAzQ9pffa7GgUYmGZb4zpzg+wh7qV3eE5VpRqjSwXvy4+1Ic2Xjk/Xy9BrPipQNV3zw5aGfrC7u/ng6bL+zErJhOEKw3UARKvbtnLFf9fuY9knuNVdtVFSZ1lnq9d+T9AEYFlWbJ5EbVGJoxph9TbxR0HsdtD25qaCVNqJO7E26sx+F/Ud4QmhUyBzLhX086p9XcAo5ZRsHJPuhhlshwkrph4EhLHufobQn7yCs9as1qdabS4Tx/HzLersROjQ2NuHkNUfZ4k4Kmymu8pK2bvenjxA2cBQh2xVdcijIWF9Yq41J4iFECEGk/vDHZJI8Vko11E7YTWBHyClNz/kJRc9qERBScGarBECzW6t2jbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(8936002)(1076003)(9576002)(478600001)(186003)(316002)(38100700002)(86362001)(83380400001)(33716001)(66476007)(66946007)(44832011)(52116002)(33656002)(4326008)(9686003)(8676002)(6916009)(2906002)(55016002)(66556008)(6666004)(5660300002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ff5vjkTG+tW65TsVMsB86rfLD85ZiEZPZVsRYHR6yjK0VjA3ciTqO0Qu5thW?=
 =?us-ascii?Q?7vIC0mBgIJlzFwYW4gyl/VOFyfrFRHzhImo8GIFXKonR422Slb1CCg3l01vM?=
 =?us-ascii?Q?L9f99wlSC+BHowUkTqQWBHLbN8NAX5V3HQNBMRqAJ48icuezn5Sn1DgzM5mo?=
 =?us-ascii?Q?ksWoxi7enywtn7uGCe+1xQYCKNmXaxRyMgZUoNd4Xe0kpNCuTv/i07ENPyup?=
 =?us-ascii?Q?jhPTUe99X5IGU20hOarnWr/JsqQ/xuXBO7Hc0Ih7X7Q8Sj/1TETRE0XWMMRg?=
 =?us-ascii?Q?vw3xqUxbJMOZmOhbBiChMdxeo6Ik71mBAoKzfNttiF7ENIhIUdFHfLuiRKfx?=
 =?us-ascii?Q?keZ+HOGcUqOCOjq6i3PYnVYU7ciocGblHiIQhXBnN5plerC+u923zHb6YeLt?=
 =?us-ascii?Q?xOG5pt+yRCj2af3RH2wbMe1cQiYErdvKJSdxY1HESOixcfX9suIgmCqffqjG?=
 =?us-ascii?Q?IQLCFcHTZ/Ezsz9kFZ1ESWQQVveaMlswPMpjBHfxJ2MLVEchO9vOThSuJOAB?=
 =?us-ascii?Q?6fIml+gc8F9fDipiA1zq62FfBuoGuFysANkzD9tsJcDOC7FqJYlPLREMjWKC?=
 =?us-ascii?Q?vMdxPS6gYsDqja1LBMCVRGfhcHmGRtC5PE1ZIZjNr18T/JW3dUiFGkqhyOcD?=
 =?us-ascii?Q?BlQDYPmNGhBk9KdVkb1m2ICKtHDMXLIoLQhyOf6vtAMsdLGbelaeLeEfy04N?=
 =?us-ascii?Q?p1vhSKPpTTTl2erws1Glx73wYBRXjILQA6eCp/Ls/1btCyxFUHLtqUrpOmki?=
 =?us-ascii?Q?+nDuC9thZYo9AC1lwoTmRG8JOqzfYryA4FJ0q6CKL0zwoxxRJXhGVOKaU8Xq?=
 =?us-ascii?Q?YJGc3Znazi0CCTNMRK+tEeh4wkZgAEbVVdOicDl+T9i+zjCSNuBmUMFPVD0C?=
 =?us-ascii?Q?QHIRA2AVgD2YIivOk7mbyov/+TErWsN6iYcgSciVtVzC3GduVWDukF1ZtL1r?=
 =?us-ascii?Q?QwVxJTYIn+YpVGSGP4Ji35FVYSrqnqSujmiOz0bAms3eRQbDPvA38h0c36w4?=
 =?us-ascii?Q?DbbPI6THjFj4qT7UjOa2QLJXyWy8quMUxSKA4uPaRBISq3MmIwNTAHueKvz4?=
 =?us-ascii?Q?O9pbo9fzQBRqLB8e2js0NXyapqxZ1amOUOHnY6cU+uBEJb5coksxbyGSMx05?=
 =?us-ascii?Q?J9bsOwvVy1PI8lvl1CC2F3easqALXqHKE6ZS7jqHt6XWHRg3QgIZJWT7ctVH?=
 =?us-ascii?Q?cPOOWVh6ghX3Fpqx1nT8vM1gSRWf/WEnGF12aYLewRVAUqDeCwR1fsYIZMjn?=
 =?us-ascii?Q?pLxReAzt8g2cfVhOarfUn2VuRCGj3lPlx7VACMrvxc0S71HygXjvI7SZO2Fr?=
 =?us-ascii?Q?lmGePk5n+5cMiJbqeib99wozbjKU53Rle6qsyI2+sCyI3fBeif2PJLUcXoec?=
 =?us-ascii?Q?AbxTg7Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7971a5-64e1-433e-3753-08d96c530c80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 07:43:39.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoX+p4ZyRhvEkm+dCrUaHCyRXQ76LjT1tGjNqmhaCILowHUCc9jeHalY+6wfrMu2obLTalICkH2lUCbKfbd6mxRqZdguQ7YMIX/q8c3QFsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=812 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310043
X-Proofpoint-GUID: qkdZTmJRBoWxflgQugjg_bR5WVNHwFpC
X-Proofpoint-ORIG-GUID: qkdZTmJRBoWxflgQugjg_bR5WVNHwFpC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ilan Peer,

This is a semi-automatic email about new static checker warnings.

The patch 7b3954a1d69a: "iwlwifi: mvm: Explicitly stop session 
protection before unbinding" from Jun 18, 2021, leads to the 
following Smatch complaint:

    drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:668 __iwl_mvm_remove_time_event()
    warn: variable dereferenced before check 'te_data->vif' (see line 665)

drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
   664		u32 id;
   665		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
                                                                       ^^^^^^^^^^^^
This is dereferenced inside the function.

   666		enum nl80211_iftype iftype;
   667	
   668		if (!te_data->vif)
                    ^^^^^^^^^^^^^
The new patch adds a check for NULL, but I don't think it is required.
The kernel would have already crashed at this point at any rate so the
dereference needs to be moved.

   669			return false;
   670	
   671          iftype = te_data->vif->type;
   672  
   673          /*
   674           * It is possible that by the time we got to this point the time
   675           * event was already removed.


regards,
dan carpenter
