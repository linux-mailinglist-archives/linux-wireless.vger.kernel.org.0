Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EDB4860EF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 08:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiAFHSp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 02:18:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30452 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235359AbiAFHSo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 02:18:44 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2064WFRB031983;
        Thu, 6 Jan 2022 07:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=dbFD+xBJ8+wKCWaNvEmM+/pxqb7bTvASgQHk2C87VF8=;
 b=Fp//fheroYTNxhhNlqoNwIqoin0OOFjicsOmDylv53MWwq9bBjG4hHR9Zykvn9FiJvLI
 KOhyeZLpz8q2ArJBaj8iXGOgWJyz1zRTvU/1T0zEuZ719gojf2/3kqLg0mNxCQ/3VMvS
 VAECRY8rGQsDByEpyJ3pSnCxkPvhrJzh5qi5s17HGvsUTlIUiMmAC3xEhp+VUyOOfMj1
 9qEkpW4gnJjbnf/ANqa2lO0uu9GaCUdRZK6LLRE0E6MIYTUauEe5sM2qcFYVI8vCJ7BY
 nkwpOyVytUKcpfl3frnqKaVVQArN3drNxO6Dm/DWnPmTkXvqMvH7kybhr+MpKpeFynRb Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjrtwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 07:18:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2067BKCU002968;
        Thu, 6 Jan 2022 07:18:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3ddmq68t6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 07:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udn3P9x+UKPuQiAMIVLY9OFZ4tYQbXUQfooFwqIXNcAJDgWnoM/Wc6QEBNPH0y2oH7ppkO6rgH/q+/IKMDoSlq7ei2BIPdlNzXcSex2DXZKINEnGyDiVaHkNISv550KxMprYE2RJOn1cLD4QY/a52ZwHdthUTxc3ZXJHw+gCU37jzjWhnjHNwRQROroj1x7zvOysLHiProVeLV36qq5N5WfKiRdHR3cIlc5Spm+b3yJ9Nkvnz+th1d9RC5GMGgr/54TYBdN+RRixjsdfKH/JaIQ9y2NgNMhEjx3n+ITtnwN2qTLOxqzg8+O8uRgvI8Ql5fC9P7Q/msotzyCjs9x8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbFD+xBJ8+wKCWaNvEmM+/pxqb7bTvASgQHk2C87VF8=;
 b=adK/Hpq2PBUV+JnkjGT8OcD2rn0hPZwGobT0CDDZqUc1f7Qtox3LxBU+Tih+sOeq8raKgP7lzdeohu7w+VflS495Ik5v3uY/OTipCLOz73qjHv3u4hMsNnt4gzBofhlNysnjl5+EUSKmr8d6boMbzJs391oq9eCdoMCOgW9UwLY1rG1AQpIDD6q9LbVsWYUsl1VOzmFd43DM9k1EBejSMxYKYzOseN2Gi5khKJtUcM1n6jj81Nmsy+9dnY6ZNqmVrNkcmmc6gIV7d6FoLRxHYvauRhB1rvCgfpic2yRvasJvryngfLqKK8dnDG70TQjLDjNrgFiXBzsKTp9s2cZWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbFD+xBJ8+wKCWaNvEmM+/pxqb7bTvASgQHk2C87VF8=;
 b=BcC5DhZ/WUzhQuoeH8LG+OUqQEzC8Cp1o7UZ06goa5DbNzAd5OCdur2Yymt2DTUS1ydKQ/4Lia51WvpP5g7DfEjFc+47LxYxYrCWP1ZZXUKalj6m7Vea+N+BVDGXmZ3oSLoj0gZ24yRs4jlRPsPknA+Clkdf4jUvas17HssD9ds=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5715.namprd10.prod.outlook.com
 (2603:10b6:303:19c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 6 Jan
 2022 07:18:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 07:18:36 +0000
Date:   Thu, 6 Jan 2022 10:18:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iwlwifi: mvm: fix off by one in
 iwl_mvm_stat_iterator_all_macs()
Message-ID: <20220106071825.GA5836@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e98c7e3-40ef-4d9a-14f9-08d9d0e4c10d
X-MS-TrafficTypeDiagnostic: MW5PR10MB5715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR10MB571584451B5CBA443D0CCD218E4C9@MW5PR10MB5715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wr9P4JDdP72kfhwyfAL+/EbYoeUE39aejLLpOcpUMhI01fpnY4vqvKiZgcDWa5NKkGrKxr6MB4dBfh1PNkjq+gCJedfSb18Em+8HN5At/d6ZT8vBl0D5JD6wKXozyImVGXMMhR8CLv3zy7ZxhvWIvdOknYjxmr6KlS8z/G+a8Ix49+C0lU9j0nlVohYeCBr29c50UJuYAP5YEtWSc/vQsEoUUfVMn9qM5HpCKyh9F0H/x2+uXdfWbor7UEhbalE59DdpqWnrqHxSETIBfWXiZKpemz1R3+7sWOxoQkalbhv6ztUEUqEQIz0si3tm0eDE08Zgty/obb1WwhdlBf8S52P5k+AiP9omuyPDI2RtQX+exzZ5GeMCtbHlIfLM3/P8N5KUdsnrB+tlN2xj/tHM2BtVVuvP0QVL460dDRDcptAdlRXzeVGHHhrHV/0KRwBjRIZ2szuoqdHIpUY+9JLZjpTYyllHFblodMbH4sTGXwmSxKyg3zHcCaoNKVwZYalgioFPh7OR04iHTupihOVZRgA0Kd7lZkbEhI/SHZD0jEdhr6Y0ejHrAcwU/muAu9iDqAYEk4akDFGSL0N9o5fgbtn7PIlefFMnWr/5QguujZ5xyXHqYd8x6WsXqt/oiecY8PmUIEmCKYQjcFDyQ0LzCKywwm1GhW/jyKUyYjVUkUhuM7LWxpBjCiTjUMMvEU4mCu/UJS4igC8+ho3QsXaZOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(6916009)(52116002)(316002)(508600001)(6512007)(6486002)(44832011)(86362001)(4744005)(6666004)(83380400001)(38350700002)(9686003)(1076003)(33656002)(66556008)(186003)(66946007)(66476007)(33716001)(54906003)(2906002)(6506007)(8936002)(4326008)(26005)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1IuT+4TJKY2rc/UJ8vKiajVgUyA2jABcgOGddc8bsaucnELGmxKR3tj8Ctt?=
 =?us-ascii?Q?ThbXwlK2P2PFGW+cyLl2D3rhBHxLNdQ2RTjW95OIYuRcxydqCp3cdafQM2+V?=
 =?us-ascii?Q?xouATiyUmKvuOp0Xur8Fq5OdPoQcswoR9u/kY3Gh2ClYoR4CiI0MJE3ln1ot?=
 =?us-ascii?Q?S+9XGwXATHWUtw1DlH6Z7keLBgoay59Rr7BEQ/aulyE4MZ/b+qGXaSE6JYPQ?=
 =?us-ascii?Q?Sye0j2HScUHOXOTi9dkaQLIdgGDt8zpIS0fYk2vyA3NvObdagKCdQHo1KSJH?=
 =?us-ascii?Q?uAZzVVj7IaqKWFe9qMU8x/BEZ9C2rHOQTgKuXit3nndLRnVH7JJWjoIo3zs4?=
 =?us-ascii?Q?NqT2U3bFp8Pqw0NnH8qavYndfDGTGY29CsMR84AnBY85eN59VS4eixcH3BOp?=
 =?us-ascii?Q?DlE4y7RwxLaJhvUojdouPG3NhJylx1GMNUihD1xZCTBlPwQLzmG3euFKrzyH?=
 =?us-ascii?Q?VfcCbY7DKeij3FPh7Kn2O3PUuFwkzcCNTmbQTAS2XYiCbJWVEv9nrcSDX/lY?=
 =?us-ascii?Q?yIe15er+yCUUIm+hsIMTUFOMRYrZBCHzSOhv142ZKZFheMmyMcPJQ1iWLgN9?=
 =?us-ascii?Q?+uNeiQYW4oXDXLh+vVfFanI6A2unXG+A6mICPub1FFFQLX1+0jJKi4mbd5t0?=
 =?us-ascii?Q?/VXKegA/y4PPqTEvYUN2wOKnuG70634WK728Wn8XHxLf4I2QEVspiXi9+QcH?=
 =?us-ascii?Q?nKMx4M18YNJig7qIHXfQaA7WjV80H5FT8vysyk//dIbcq7Umjb6UDcXiLym4?=
 =?us-ascii?Q?zneCNmAo3PVeS6N0bIqbrk5buGXrwW6Fpe7Zqsg8KYAPNkQz8wc1sZlZlLf3?=
 =?us-ascii?Q?u5IjeygfoFHv4vznCuWL7dQnRu87/pr2pRgk9XgMHb0VLSU7aKm2xfNWUkJv?=
 =?us-ascii?Q?48/y+7LdKrD5C2+VBKMUvoyaJNYmDJ5hGvnnr1169WeEWWWWDkYOlAKWkX3L?=
 =?us-ascii?Q?6I/gkuK6Zkb3ekREztNUdeAG7BB1ovl4TxMeMFQ99lBhsCfwlKkg1d0hvDWh?=
 =?us-ascii?Q?8jGMo/bgjD9XIDkxEbogWmPZWfZWP322zfhd+iKzBi/FQUF5XIPUmQUjBpu6?=
 =?us-ascii?Q?WFVzioFCRyyFTEiN3pAcUYXx8CKZwLmOcErrA+Xy5uWdk6mtwCucP7QNlYKL?=
 =?us-ascii?Q?zSggf0LaemC6CBg6NCCWss4c88TAMqezfr9ZkYZF8T7BMpQ/vBJqlX9nHhNh?=
 =?us-ascii?Q?YfIYSb864HqjAgwiWPe5fSWpLiNIZLsdUSBGCXiMiynJIBz9CMYOj81fOEGt?=
 =?us-ascii?Q?wwSv4xa36fsc6Lo1pt9l5ZK5fm2jXlKTpaGBHpcEW8LkXvr8+o7O5bhhAw+o?=
 =?us-ascii?Q?9Z8bhKeWnOLeB+Lvr0kiM59E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e98c7e3-40ef-4d9a-14f9-08d9d0e4c10d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:18:36.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLXnRfy8+//a5TEmgKH3rPadHWO4XtDC2gVhJBna3jGeg0aNKVBq9b8yzfFdgOArYky/wDWdN9bob4JvZnt/jLs1Uq/6pnJbNON4ijasHVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5715
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060049
X-Proofpoint-ORIG-GUID: VgCZHLq-tTUqdnts0o_Zd0ac6e7bzf_1
X-Proofpoint-GUID: VgCZHLq-tTUqdnts0o_Zd0ac6e7bzf_1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the comparison from ">" to ">=" to avoid accessing one element
beyond the end of the ->per_mac_stats[] array.

Fixes: 6324c173ff4a ("iwlwifi: mvm: add support for statistics update version 15")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 64446a11ef98..9a46468bd434 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -640,7 +640,7 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u16 vif_id = mvmvif->id;
 
-	if (WARN_ONCE(vif_id > MAC_INDEX_AUX, "invalid vif id: %d", vif_id))
+	if (WARN_ONCE(vif_id >= MAC_INDEX_AUX, "invalid vif id: %d", vif_id))
 		return;
 
 	if (vif->type != NL80211_IFTYPE_STATION)
-- 
2.20.1

