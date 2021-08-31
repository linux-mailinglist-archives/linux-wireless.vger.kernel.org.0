Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140BF3FC42F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhHaIUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 04:20:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22164 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233064AbhHaIUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 04:20:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V56Lvc013840;
        Tue, 31 Aug 2021 08:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=Yd+EhFqRYN+2zCp/uKMVCxlgTVsR2M1NYROiyI9Tp0Y=;
 b=Pl+VtRViSwbTKvf8dvKskOpfHVvILExNT2HCoP4qC813lB9fCKWwfxxqWQBGdU5K8EGK
 KV+Flh0+k9/pvYQRZ9F31YeRZnlcPTxdtCM7qoH1+EU3IMZdbm2nVpn0S0zEy6ZBw4AB
 YifqSvrVhnJco47ItE+brvg3DKfuPY8ZL+gZStcWdp8c5FXd7nv0Mh0xEAj0QU5EPM9A
 JmNCKJ/IPmytNzCf5mxb+626jwbW/5TWsuAdhOJ6eYbU14viaJ4CL43KQtQP2gC0XiqW
 jzHdsVz3OXmt7a6QtusVM/7A7jf6YofaNaREsQuhKrvnNzezKD3KJG9SNbvGhCfxRRH1 zQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=Yd+EhFqRYN+2zCp/uKMVCxlgTVsR2M1NYROiyI9Tp0Y=;
 b=i5MlggFnCKdO8xmveO07wDtN+xBVhrm1fEiLE8K6XGo1uLxXguQpE6jeK1rmjf0b/dsN
 QEFqWKvFULJpp+Bs5FwsYUsbSmfVZUlnIshXrbAAxd8INazRLHIyVJIL5mZYeRkMIdIG
 4dkirdWpAwXLo6qPd1YirfbWPOW2C0O7CF/tVZGXWeItznY1jfs/cZp+QI8K3ETA+Xyv
 M+Va402KfSxk3/kTkrB9UORSd76OXOGDgXrXd5ae9KBPcHDNFRKUs3hp9qp9Jl6vTOek
 Sdj/K4JXjCOmIT8NfoLJn46nH229fDVnhSBj9mkX+rxJZPSEvhFPBfaeVToGWz0WXCD9 nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase028bqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 08:19:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V8Fj8f099183;
        Tue, 31 Aug 2021 08:19:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by aserp3030.oracle.com with ESMTP id 3aqb6dec06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 08:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1QtBD2JskpzRtoW+FKgeGmTQIeYcLYuI67bTn2qjezA3GkGICRmb8XGLWdic/XdG0/6a2mKOPHAeYilEe6ugwJwQN5MGxu19oN9kquoOiKP2+1C2cGl0fuuW43B+1Li+MFD+CPXUMrtaPNS3eGDbTzTGTSsmoXc445TLRL82xDM4Eqcu/kHAujMMeTfbJ9/cKtRcx3CkGsS8F9Q8EtF/aD/qkS7rCSSeadbT4gFtMf3kFz1SWCuDT83fe35Hj8luRrnu8eMeQczzm64/odqJEjphvVWry/TFivlAjZ4omq/Bnx4S91MlmH3nR3t8EOh/6ZrKmyK1jcHfwfd6yJNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd+EhFqRYN+2zCp/uKMVCxlgTVsR2M1NYROiyI9Tp0Y=;
 b=mVHCWjQgys6ewJvee4kbagMchdy7LCI3j+bmfG92isAflei8ZTj6BKrzUGgPFzQdIDNtkotqBwb8VKW0PhwmgtBCw7EnTJZp1B0HgdbPuBgRB/Zw7Fo34/DgB2U8bPYufvvkvtwS6qa02bib4yAad3Ebhc4PI7mszN80FB0EZLkHL7JmJNLMOJ3eI/WlwS1cdlzwAwfPas01vJ/74Tw9PaUEm+1iUeGwhGPwbatNus6Dlh1SS58SqRoD8oJMb9PhoUxGU5mIZIedaIh0ac74ySMMokItYf+s23aI5lIvEORpBVtKxz6OslJBlPtVF7ao3c8CjMLIpufFEsfeOsrJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd+EhFqRYN+2zCp/uKMVCxlgTVsR2M1NYROiyI9Tp0Y=;
 b=eXg8hpCorOCn3yd1xwiKGAM/ZB3VDDAYPUgVTE4x/JsP5adpx7EKsoKRKQFRLYjcN75NCruQH9TWUQuDopwjwEa1isbV/8OfubyQOHieRHcS+LaUW/1J6B8iym0wld3WSxG2+qhWr0qqWOaXxH1xvQBRuzGs/lklI3KNajmzP6Q=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Tue, 31 Aug
 2021 08:19:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 08:19:17 +0000
Date:   Tue, 31 Aug 2021 11:18:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Nathan Errera <nathan.errera@intel.com>,
        Dan Halperin <Dan1.Halperin@intel.com>,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] iwlwifi: mvm: d3: missing unlock in
 iwl_mvm_wowlan_program_keys()
Message-ID: <20210831081849.GB9846@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831081802.GA9846@kili>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:189::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 08:19:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60264798-69f4-435e-76cb-08d96c5806e1
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5412999064E7640A8645334A8ECC9@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXEbIzobsY8QgLvvCzfAuorbJgHcrW0r/ilU1HtFxft1GRYG9FXU8nguajHm9wep3bnxM1gxg//jNj4FransYPkiYtNpEjiaq6baCiKKlSTYIKgOm+qBf/xjMEktSZ7ljRtjzn8+0fZ4GxUxbn75TmvQJ/CzNG+1Uk42aP4sFirlzMuIAbOCqRnFTsjqrTj4e6XhA7dOcaQrdwTm7/r6hAoYf3FAudLn0Fo9XUU5e/3qce0MjCNMwEEW4O4WE1nd423Vac/Jl62YYOUfWtbnq+WmVYeyld1gbhxEwe6PQjdl5kOBL5Q/06ohK3uFNTuKU2xnwHNcmOSzwGsKUh4wYCeq4paWxGZDw0Uk3FG/3ihetOPQWcM9iGW7QM55LnYlOHs01Fk8UWSw+9PXDyQwY59YNGdiOXD/G8+GG7c4iF4qkx7a/K+I3pNUPynpV5cmkT9frAVjnG7lPZgnRCcwKXTCwjmkAwEamOdtXgMjpg8V+H/fnSeKYzuzNxD5udSub60VK75fwfuHBMYYcBvQ4UTw3cFU8wB2i82Uz70dS0qQdDpDIhxnb2oZj/nGqEQoxD3v3Gal/U2q1uUESr59thrDC6cjPGE+0DRaZYDnwuuSM34EB8lWy0idahUfyOLCH1TkK+jkZ0MD1FKyz9hF8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(2906002)(6666004)(86362001)(66476007)(110136005)(33656002)(9686003)(54906003)(5660300002)(7416002)(66556008)(8936002)(4326008)(38100700002)(4744005)(186003)(66946007)(8676002)(44832011)(33716001)(478600001)(83380400001)(55016002)(52116002)(9576002)(1076003)(6496006)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ow9nLBeWZENVni+zsilsPUaAumrTvKt1gH4RluxjaEBSZxHLszjt2yFF+Tmr?=
 =?us-ascii?Q?5HOr8SPkAyHFNbTZJQ1QCgec0ew4EIO4L0Sl8KMBmZAyHDgdziDL28xK1Azz?=
 =?us-ascii?Q?5syODXI+cLvmiy8Q+Fv4wnU6ZjMKwBmroOt72SUG1anjz8H/BnA15XqBbm5Z?=
 =?us-ascii?Q?wX/ZEDBOZriglzenvXSbXempNWhs+BWUeluoBjhFrPtt2VVP4BCLiosxmk/w?=
 =?us-ascii?Q?m1ieKCYY+0EaRd9kwmx/gZdZ8Nwtb+BHvvIQVzfXKqSjnK3vF6V6F6SVQuY4?=
 =?us-ascii?Q?hk1fBkZBpjdLiKfdV/uPGrchWJHczosuN60CENTYUgEK4OQ2a2Ivm74Al24M?=
 =?us-ascii?Q?opADKXb5G4IVpPRu57/Nqdbys9cFwoohc08ufepREj51A4OFIwwTGEr373ec?=
 =?us-ascii?Q?otny4xMmAi+W+eTxhF8megjwPBP1BBRrRpCebrPmYjRxCvXUHj5im/W8W2CG?=
 =?us-ascii?Q?6ebZ47SbZuo8rtNOHQiGPfuaUBbogPn7P5/+mdvrP71X5UdCdJpZ+m1Qflen?=
 =?us-ascii?Q?gWQPVnnxAroR6edlxwU+szU2MmJzIqJnHnU16aqjyzBrvljTJk1c7CpGwxUR?=
 =?us-ascii?Q?EZU8WG4xtcValmp3nCjCX/N9m3WNFjwzyVCzvvrBgEnpD7FBN6IlzsLj03b1?=
 =?us-ascii?Q?o/qitQMyYBiNMCchsdAkKEYTfWVCICtuFaa6AInZJKehsuPXe+qzcdtY1Jxn?=
 =?us-ascii?Q?Nl6Ic5IeH/ehC/1c3+6LWSyEanK5WKnRkQ8rHBzGi+Dr+kiB41wRfC4N8b4x?=
 =?us-ascii?Q?wg4EYfnUWt7fwZW80u6f64Cw3CJgsGKDT81C+QV2sctdpxK4+D/xUfCdJuvt?=
 =?us-ascii?Q?yEas6PsRy24/fYr2JoyeqFEr3wZ7ageOKCqXNk2k5gFSqXamDtB3tVG8fRZk?=
 =?us-ascii?Q?9EdGOKEgfyuEvwwHJjYDEnSZvjo20JMt3CilNd5l7+fSo5oSMeNkfXzDevLD?=
 =?us-ascii?Q?lsVXjlclIdJAvFqRE1syTfiw2yVm5CRqenZCuQdDG/W2eiL/Cz3G+CkvB7al?=
 =?us-ascii?Q?oBZKBwPPRBuiVYQ9lHvsMs5rNrZFaJ4BvpsQbOMTW1bwRCsgjKqwTWjfD+Hj?=
 =?us-ascii?Q?8K2cuMJ2xI4xgeWwQYyq2lisiHbiyq9IXv5n23FXfMAmq9k0MHkteJbQ5MU5?=
 =?us-ascii?Q?1cC/KdGUy0IQ78P6m02H6oPnygzsi4zbdAzzsj92ciArYSWM3PIJjH4wP1ow?=
 =?us-ascii?Q?SDnNFjdVqzQ43aJJnFxTHA+pgY1O7f5bDQR/hxBdnbqlUwzscXTRC8XzgOpX?=
 =?us-ascii?Q?fUQ+3TeT3pQodOU14grjGf0GJwj3ibE98DHjMmIFsDNs+l+U9i3pnQ5TpUIu?=
 =?us-ascii?Q?BvcxtngX+4V03yhUNC3ZZAkLHNn5a3s/tZEW73mhQ9Sj1MuE0+FXHClkwsNO?=
 =?us-ascii?Q?j3IXB2w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60264798-69f4-435e-76cb-08d96c5806e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 08:19:17.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NUkgda7MbDIZ99LInZz4bFixyJYc9GQ5mLDcvDyUEgwAuNso/FkH3nj2FfPYG4TtBZIgOBtz13p6bSWVhJkBBgwxrbotK9Q7gbM4tb5QLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310047
X-Proofpoint-GUID: VRCXGZSsloA6FlLj4eO27lLB25eMLUzd
X-Proofpoint-ORIG-GUID: VRCXGZSsloA6FlLj4eO27lLB25eMLUzd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code was refactored and the mutex_unlock(&mvm->mutex); was
accidentally deleted.

Fixes: af3aab9ce298 ("iwlwifi: mvm: d3: make key reprogramming iteration optional")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6e3a63a5a75c..9f706fffb592 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -160,6 +160,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		mvm->ptk_icvlen = key->icv_len;
 		mvm->gtk_ivlen = key->iv_len;
 		mvm->gtk_icvlen = key->icv_len;
+		mutex_unlock(&mvm->mutex);
 
 		/* don't upload key again */
 		return;
-- 
2.20.1

