Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B44A8047
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349480AbiBCIZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:25:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4882 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbiBCIZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:25:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2136IRWm024807;
        Thu, 3 Feb 2022 08:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mEjzA1R/8gFsM/0NWiMygvHL4A3XcMosvBMmHkQDuGA=;
 b=DTWTsWoHY0jltBRFPtBipVxDEFRIx1U4XhCLygFS0+IkNPijSH+JbfmFSk/cBwKReX81
 Iym2JOQ4wjKKUW24hjj90uYz9XzBl16zQSEbSNkvpycZ+BPYFK+Nkt5Bs3oU7aHaAEvR
 y1CkQUjDg8oSUeCyyVn7imOIRBg/sAR8EEFBViX6ruLab9GB3wN+wX7NVCSTpuj/yud4
 sNrOARxhBrXp/Ym1ucqsckKLt1+bMz93FSVbB9Efk9kHtk0as8NYpeeJkS7jyhPxUloK
 V/jqwdunb+JZ1sunUZ+e/DQpL1a3XGKRSgA2ExBkUXPzF16NFZ+rW7yVXdtB/B7X0QOv Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjau0r29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 08:25:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2138KFb9008509;
        Thu, 3 Feb 2022 08:25:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3020.oracle.com with ESMTP id 3dvy1u9p2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 08:25:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPUgBqSKWgK2yTIkwOWeiDAzWhhEE5h1hkqUfTgJfK+ijjTZ2MBudb5tknOaLGgxXFltpfdchHomcTY2wEFnjPYZf5H9IFwskeG1AyW93SuadZgj9oRVxCoygagvOBE/8KLJUXkceZ6tfG+s7ozwpWQjDs6cCIECL7QWKP7sS/98yDskZ7/2bJxo8kIXjwilJ8nb9fi/qZvUxuT2b8iS285O6+P7gv9tXLExALp/G+6bNbPTMEb8ksOQTVLLAcX0dAX3Gjai/DfVsIKMYkeVrQ6x1bfWKoBWvM/q7gsUZI1TAoHF7O9vN2eg+CUumIzCMUBo15Frf4F+Ebb+a4LcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEjzA1R/8gFsM/0NWiMygvHL4A3XcMosvBMmHkQDuGA=;
 b=hdk6s7HUBu4qh/ekDc1jVx34amG8yqcrTn2AoHBlbkNmoPfW0e41QfmEqpiYemzpM3X/Nu9qBafyGnZw9PpsJ4ktOIcYxuZreEZGLOQstmAiUNTQleMFHOzSSlP+otEisC9hqX0KU5a5MgV7+ZP3/gm3wG7q8GUub4KWXDV5wjnxl49OOCO70zMFA67yIUh4mL7xFmxJKeaQSlSLcwotFvrQkIDQ04jEEeId1+yh0IrIJsYGsnZ5ilj8ZrufWHLHi6NzECSL80+aJPCItdrjmxl8X+YZkgFWDTSzdwjqsyGLKWOPdblXc0gvciGcMoBauL46Oe/P/JXDJ4T0B0tWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEjzA1R/8gFsM/0NWiMygvHL4A3XcMosvBMmHkQDuGA=;
 b=KXu83RPvnEKtWBUsHXxH53aNyI/H5YBSYczQ5b+4W0cbojOg9fFFIJfcEBN1KiW2+EDeRskD54I9BK6cY35iZ5mUu8pRJN7W5yh9LBruLKHL4yJ+dU5Ivw6CPph6Yv9vZCy+zyeKovcx2vz9R0XldZbbGffYdhJwwArmtJdTUAI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1844.namprd10.prod.outlook.com
 (2603:10b6:404:fe::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 08:25:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Thu, 3 Feb 2022
 08:25:42 +0000
Date:   Thu, 3 Feb 2022 11:25:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Po-Hao Huang <phhuang@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] rtw88: fix use after free in
 rtw_hw_scan_update_probe_req()
Message-ID: <20220203082532.GA25151@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ebf438-7b6a-4876-25c7-08d9e6eec492
X-MS-TrafficTypeDiagnostic: BN6PR10MB1844:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1844513312A208F266C4F2568E289@BN6PR10MB1844.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXB/H0BazsPE4urddPA1ZFilHrgKtZiAJY+JlJZQ2XuHdpzxPxwfCJl6o51xnMgcEMAartPd2On16nkKECxGbpkSf7pMYyYeGEDRfsTkQgbOTni13AyFdz+8jJTO9A3zABG90kT6mnVMi22t1/8eKH6aSfKp103tKbkLiDyblqgxfjBLTZNyR3Jy7R3XWlpIDdXFtrfFvUvphFwn1ZEDHRelBvPtvIQ54dGMUo2HhLtJ1uPLx+KRVj14LuFxFCMUUVoHkrrSocEhZaO0IroCta5Ttbsj9tTqr4lvSucl3luQY6ctTpM/kLfQULIaBVjVUlNlfe5CCxinv+oZLy7szsL25SZY0Wdh3whtQ3E0J91AArh/98DpsfSD8e8/ymlvQiIPQtv1KXp7iw+etu/J6KrqQKtSfCRXdBjHRLTLuiO3u/10mokG1nGorP/cLysVqp+nm9FBEy8kzjpeE3tloiNmrhvH/BTSPPUoAk+UU13uMh//2Nuemzly7C9Iw/53cjOwsOJLjU+px3IVH9DeQJ3Il95p6B5UHIH1O+dDQpSukwBZiymVHY6PjODc90MncgViDh/gahpWH5LiTk7EV45TKJMm+r2l3lPtUGQ32WWj3kaMun3nM/h4J90CODs1lJbQDH7SG3UOqaoMnORUsa+DNETChA3JVHc0J9hY5BzwWiHePfkfM2Lh6o5Z5dPw8ZxSSRs0yzAR4KhQtRHKMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(8936002)(4326008)(83380400001)(38100700002)(38350700002)(66946007)(66556008)(66476007)(508600001)(6486002)(9686003)(6512007)(6506007)(6666004)(52116002)(316002)(1076003)(86362001)(26005)(186003)(110136005)(2906002)(33716001)(33656002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGXwlnOpUI343jnIIBN4cQRA9VBwbzvDoIqoOlZUILrp3bh5l07HLtPKywaM?=
 =?us-ascii?Q?zkT0RlR6taVQ/+0POoiaKJu4N9LBPn5TU+5RLmxMAkAUHoNvB6zUL0PHx0oa?=
 =?us-ascii?Q?xx42BXGvzeWZzIGAJ5+cTyQtrE3z6Z5HGrTRK87/pVgtAsYidyFQW1Ptta0V?=
 =?us-ascii?Q?7iGHmoPwz3UoaiZctYRgoC5AbHF/caTqB3s5VhRbXkvNdaM6Mz9KSR5sEkgV?=
 =?us-ascii?Q?HdVgJmsW4IYXXpseCIvxyTVESODYfakVSDh/oWbBgr1ecv0v85OdPLgQvJAD?=
 =?us-ascii?Q?yG1kjGzlZg7MTtSI9xBjiBnMM/i5Y7PAtpuJwoVcBWW9xLRrzm2zXy5boVZj?=
 =?us-ascii?Q?DGVxve2ddzKGUeKFnIVBeXCghLhLKWJrB+rGxHoEQxWJJJCZVVN6HwUnkTpV?=
 =?us-ascii?Q?Wt55s3hCtrJs1ER9pStSNEkhfdPpbSLKXRJk0rr4V97Eb5hFiNiwJSMQGFaM?=
 =?us-ascii?Q?qdDffVXdlXe4394SzrbCyr9zWvfeXDiUEjVFguGdGVys0xFCfT7+Asd02WHX?=
 =?us-ascii?Q?W9A+Cz8NyUvFxhPZO1s3i2apIYPeNaBjWHehePfzMgcZDIRTZqtvU+4m4pke?=
 =?us-ascii?Q?a9z/XimCndOH+vWGvVV3FRnft+y2XnPFlTg5LP6o4Z27sCdL8y5LDDzWsyiB?=
 =?us-ascii?Q?x1TvvUk2oU6eObLtYEbsltNQiiUj6Xeh/lM+Fr/0SFxFUhjEmWEKt6oEqY31?=
 =?us-ascii?Q?+0MXHHgrKAme5k2giWSFlnwHmxirkojTNWqbywCU7yRLTYMw2wEX09gbJDsu?=
 =?us-ascii?Q?EtqYGlN7F7L/zOtantnkYV4E/VeOJq4uyBUM9uiHoDEowRIAm+mBQfNs3ibo?=
 =?us-ascii?Q?NWVi8DkJ/5C2iN7BnqaoAooqqRHQ+Tu2l7cFxJ1jKO4r0bjSPynSuLo84s/v?=
 =?us-ascii?Q?ZRrZkblXdvMiw0n8YiYwciwhKrFW3udI554zZgwbJPanCXIgILXdND2QwiyO?=
 =?us-ascii?Q?1dhViGAdNcJ2xGfWzRk1jZr09d4IB6i14jQbdr2EFS0WbUyrWK+C+0eyMhpK?=
 =?us-ascii?Q?bATXg6s3kJhMD4bLQtLkw9fY8/vqEUWiAlyoYJlVay4qLP6obUYHRqypF0Nz?=
 =?us-ascii?Q?+i5tKAVv7BWsoeHJeotyr2tF647vqatkbXROiFQ/8ILUggBzEXUws8v7ifJs?=
 =?us-ascii?Q?EjpvcpUE+g5K49Dv7uTV3Bwef54xZnuYzO/fUY9NVO2GM/NtmKgkBOK5Q0wZ?=
 =?us-ascii?Q?WOSm3SKostk6U20ddq6JqLFMHjXpDYtTXmuaF1IlzJKDVxAeMwhExLg68Osl?=
 =?us-ascii?Q?tIB2lfoNJ9U+ECzmTmKT33gCy2UUJHiFl5xUy10aOWEh2/i0gcQSRv3vTEOT?=
 =?us-ascii?Q?IzzaLbFkPSOZ3zqPG/BLbMpO7JVNWwnMU6Mu/GlVhYfnlUTXJsVYtruvr/6Y?=
 =?us-ascii?Q?2/tmZZ7xF8awIDo2BBvs550+wGrt6nTjU/7OVLxpQ5eYDfx8s0lvhrUuvY5i?=
 =?us-ascii?Q?ZEgsEFYLl4fR0KAKDLwbo5zCAgeMKm6srMFsclY04w3T8OJszHGWT6Gr64Rn?=
 =?us-ascii?Q?fGgeXjKS3jHK45QpPsMfbOzA/dzqaEacxtTtEfH5JGDqw/gCOnjcNBLC4up4?=
 =?us-ascii?Q?gU0kIWgtW1EZDWJKon/qYanOuHI3f4NvLLPu6TntlFwVQSm2b6VrI7p5jW4l?=
 =?us-ascii?Q?iDMhZieh4pITxoE0JFy0KCVCPPxiaGsS/DqR/T56WwRX+064H3kavoByQwfD?=
 =?us-ascii?Q?zZenLRE9DYyLsXgufOSbvfTtboc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ebf438-7b6a-4876-25c7-08d9e6eec492
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 08:25:42.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idpvfzt4vub32SswxCn/3TQ/crIihSUI5sfyfdg5tKg8SZwZYz1d2J4D/+j2gChmwykXgyAxT2eekWZKZpImWeuarBwDh46jjGY+lb/X5jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1844
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030050
X-Proofpoint-GUID: kOmp36yGKupiD4kMLQhWBdSTkFxqxdTf
X-Proofpoint-ORIG-GUID: kOmp36yGKupiD4kMLQhWBdSTkFxqxdTf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code needs to use skb_queue_walk_safe() instead of skb_queue_walk()
because it frees the list iterator.

Fixes: d95984b5580d ("rtw88: fix memory overrun and memory leak during hw_scan")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Fix a similar issue in _rtw_hw_scan_update_probe_req() as pointed
out by Ping-Ke Shih.

 drivers/net/wireless/realtek/rtw88/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ce9535cce723..4c8e5ea5d069 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1853,7 +1853,7 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 	rtwdev->scan_info.probe_pg_size = page_offset;
 out:
 	kfree(buf);
-	skb_queue_walk(probe_req_list, skb)
+	skb_queue_walk_safe(probe_req_list, skb, tmp)
 		kfree_skb(skb);
 
 	return ret;
@@ -1864,7 +1864,7 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 {
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct sk_buff_head list;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *tmp;
 	u8 num = req->n_ssids, i, bands = 0;
 	int ret;
 
@@ -1889,7 +1889,7 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 	return _rtw_hw_scan_update_probe_req(rtwdev, num * bands, &list);
 
 out:
-	skb_queue_walk(&list, skb)
+	skb_queue_walk_safe(&list, skb, tmp)
 		kfree_skb(skb);
 
 	return ret;
-- 
2.20.1

