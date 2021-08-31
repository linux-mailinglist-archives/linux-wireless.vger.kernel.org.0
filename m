Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9163B3FC42E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhHaITd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 04:19:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35530 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240229AbhHaITc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 04:19:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V5x0jQ010878;
        Tue, 31 Aug 2021 08:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZJKFd+bh8Rjsev2V8+aWW7wB126LzSMf71Cj/s4AMug=;
 b=XgHNn16w+h7FpX051n0N8+Re4RhjhEEYz2TaGwvDAG6I6TQw37JttiAYFEbUaAxzN5ri
 4qg9tDqY5pe7DPSrk7UhjBWI7aTzte6Xtf22hcyQKXWFey9l6YdekeczjBpVYEHe4K/U
 qdseWE/iDwHBMRu/iY00StBAyCCUlj3HKevRFIOofgevnw2sVHt0fDFED0CLdPgQFnOF
 0Efxx8uZVjxx2qhb6PvdMYi1eD3/qP0M8TwAaBOmsNpNpWumA/htNj6pCGYdzmBISU9H
 Z1sflvaN8mxTUdW/ttduSkh1G/iPl9hcI5pqd8+0I+cu+TeCQRK2eRjHgh+VnURZWMJD eQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ZJKFd+bh8Rjsev2V8+aWW7wB126LzSMf71Cj/s4AMug=;
 b=QGYBajLUdLficsohHBzrzn+5kwKtuS2BgzjtxZzsdbI1GhuFAl/QTFACKr+cJDbgLkOi
 1++KwOboNF8QvWXEsywLmPYET9vyQw2/t5MrM3AdvzqoVK7q97+HPItavFfqDuAwGcmI
 e86VDFoDugQoEDP8aAV4/ePKZ+irTg78Jkt7cPL98eyP9/GGjciFyoxqsKqKh00LdF1A
 0hHOivhXGyJ75yLe4A/ZHMJ+5F9PsurOEJzxvZGaZDlkN3ePNF+pI3GxvW1QbnjoQ/6W
 p4PJOYZw9R0CTxR+a3Z7o5qdMzh6OPeUmW9Fyd81Ou8w/upZ8rFadTH/gx8Hfxsbfbd+ IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aserr09bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 08:18:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V8GENo081128;
        Tue, 31 Aug 2021 08:18:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3030.oracle.com with ESMTP id 3arpf3vxn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 08:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/GgKH75VKDYLifkGShwIzXdJ1kfJQ+3Vhhon1ybAIo375qlDaGCaGHk4F2SclGR/TX28XF20OHV3dA1WuArO63Z5fLOZ4OFmCoGkQ8OKRb+Q6Cf0EB2p9+cZYsGvQx8bQ3OpR+TOL2iD4WVrbfIZJCVwXPVLVrz3UvnsyZedZaoUNtgtSZec244Lu25dGHVH6gAD+qf3Gqwg8hhCJLPsCQIl4E3q4UIq2LnYlnCexO/PviBQgqJZS+RvB2MaMwTVNLmHW8SFcpbe2kurR+GlqbnLTCDkaOJWXcQ5bO7FV9HoRm4163cvETEcnrwLkg7/k2hcjnOFluxpGbrD9QS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJKFd+bh8Rjsev2V8+aWW7wB126LzSMf71Cj/s4AMug=;
 b=JveFGv4sO1ziwBE+UeWgzhX48M7LWjJY/e8Eo0xm87Rj73inJh1Q2+8rGYHG7HlM/za7waLW0Ofkn+ADkX6rcYIj3HhYtwi4gMtHqBn7jSH+0EprM4hFOJn+vJnkxswBvFeGoILQai61uQY0vUxds3vvTWNEMWPEvGFhwYdebL7kkOSK7IPsb6njDwgKvblax2Kihc+YUR1TTw09tm9fPgHPo3SOATqRsj15APdXt0GpM1J6v0qxrVMeOrg8RzwVKCWSeN8CX8gb+uyd49I+8WKW0ahBIwpMPl78IUs4Ze2//+l0VHHmHtei0qas59t5+7P1ql87rRWIAtjj66M9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJKFd+bh8Rjsev2V8+aWW7wB126LzSMf71Cj/s4AMug=;
 b=OoN3l6mqXzSWaw4R85g3ozVoYbPBv4tS3MiYvll9Nx2lJqz3cCpMrOPLzmKBxvtd7jg7C4bTR763aJZB/kNJiYhv1lx4sGLeT9O1sRviC/EYKzj6nB9woAHeYAYt19uKEAAHAyo6m/S1a2qQ7KeQ5MeyKqk45/DyV7Wp/FiW66Q=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Tue, 31 Aug
 2021 08:18:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 08:18:31 +0000
Date:   Tue, 31 Aug 2021 11:18:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Dan Halperin <Dan1.Halperin@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] iwlwifi: mvm: d3: Fix off by ones in
 iwl_mvm_wowlan_get_rsc_v5_data()
Message-ID: <20210831081802.GA9846@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 08:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92023c6c-0263-4581-f1dc-08d96c57eb20
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5412D3E5427E057A0ABF4FB18ECC9@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNelg/bc46IoF1KLIevl+gEiv75iNdtXbzf55UxIY4zEi2qCCk3HYbMfEPolyo33BR9F7rcizDFyJNcugTx/uMUJEx9W/6B8IA03JtXY+2ykeEota+cgaab98ztBytyBqCxkFuftbAeA+GliCgF7iCDAjbxGYEPSGUfnrp9ZM7dXTu5sbP1N/ped96Jj1BQ7g3rmyR9xhRFt23ATOHBsoo+wMM8y6IkPfe0qxs7Qy0ntXEOnXYv5V0aM2PXhs7W4yfEUH2i77oM4d3AMbwhUhX6T9fJrtKB0zqVyKVHQJgvy2Md0LWEPGPLWi1vpvjlXtSxgp6gqMYZ0ocTQsu5fFqOdKitZ+n1gWWyu/yIdInOg9MAYxhRK9TiqZ3QMxW9hS2Vkjay4wmAd7mx7MaO/9HrhI+VQtFuGMJSzIvluw4fPQoLmJzV4V9rsFwY5jsFC59JM0WLnaBzDz5Bq8QlCAHEv0Le95kPpE8SdGXSkipoCub2v1N6LOhuqJhj24bA4BPElvQm/8LJ0hr/ziEMw1t0P4Oz3ytZNql9OYQqwIb4POF+ifNOTXG4GbN9HxY46ObplU0CzTQWAfQ+tBudwE4ekARWhifbqwjOyMWtYcXWQI6gf+kBZ9kFuyLioDQwo4lemv/mRGtiwlYt2HNq9aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(2906002)(6666004)(86362001)(66476007)(110136005)(33656002)(9686003)(54906003)(5660300002)(7416002)(66556008)(8936002)(4326008)(38100700002)(186003)(66946007)(8676002)(44832011)(33716001)(478600001)(83380400001)(55016002)(52116002)(9576002)(1076003)(6496006)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KGIvKTxIrH1g6BJp8uRQGy/YcKZyl4RKIl1OgodnbRx4pX84pjUQhM7+lpy?=
 =?us-ascii?Q?6dHOnP4cSK33bbVyKqoKr42EKmq4/WioEWJsEdnUDDP2MQX0zDMw4OPDa2fP?=
 =?us-ascii?Q?QpDl5Edj5IpA45+WszUOPsPlf6vz3rA4Cd+J89q/tglkC/BHpBPwV4oFlXzR?=
 =?us-ascii?Q?SA9+dRsMR7OaRi0W/aDOL8ps9TZ7LlgKe0v1rVqXj77DuZK+EbOjxIFEiosR?=
 =?us-ascii?Q?yTCQEYDHycs5dZ3xggqbukkjhFysGmffQWUFW4BIiPBWmfNQddHRl2uh5Wo3?=
 =?us-ascii?Q?5wW2DBehHAc/Zqzw3VFti3zycJbPetpvWuKZmq8vTDCw+T8T2yaI3G5eg23K?=
 =?us-ascii?Q?g07GDQzwobzIlvvXgVU9sx1xZf2xr4Us15UYUgBSeD+r2igoq7QbOIrP9IGp?=
 =?us-ascii?Q?dXN5lmkXJwgKN6ldKS1W3+AQ9UgH8BE7HsMnb/0QGmF6KxfGLIj0gSJ4KHSQ?=
 =?us-ascii?Q?XWT88WapfRPJnpr6guvU6AB+0ZEzui+TV/sYMWHhZ9JAZPyND6SDQpIEQz4d?=
 =?us-ascii?Q?adTIQ0t+mOTZW57QmG/h7krvC1fpWuSoxW1YwjNT4NFl5MMTnmklhqtl2JQr?=
 =?us-ascii?Q?y1WrKiYWmtvEwsURnf0sKwdapSjFuCjbcl4DvsySPSLfw7ROCOqZO55SxX0I?=
 =?us-ascii?Q?F8It9V2i6n5WnNwQMAYXMJ268nkzvZg7LFMlFj3KUU06nsmC/0N9LX+Mx3m8?=
 =?us-ascii?Q?Q07OzmK7DjWoGl1mTm2way2FLL0gBCPTfFy6XH9Twmnnoj2HxYwbMAsavqoM?=
 =?us-ascii?Q?fT0355Ns5Gm0JYsAraNoQbcvrlQMxH0FY9Pe9E3MzX1ayj1SeNeC20HR32dV?=
 =?us-ascii?Q?GPDArE50/ACQTb3VKW9UWpgldLUZlP45c+wLkhmxoj4SPHKPiA0oEM/3X1n7?=
 =?us-ascii?Q?mo7PUUuEGVPPQlqQTr3TXFrsBE00niwnlkTMeUzQ0gzN2xNE2bD0SUzFqJeK?=
 =?us-ascii?Q?EKAFmcel1QLy4Rxegl2V3KZwXjJ5zQTy2NiaMyH2rmDElOf6oGgpNvpLebo6?=
 =?us-ascii?Q?jNb1FnJaOQlcSLYjouEZ04cym3eyyxCldw1oHsS8vPYPF7t7/L79dzi9yXBb?=
 =?us-ascii?Q?9lITLRIe/i3QK26uOe9JA8kdQDXeCqhpXNrSM60cB4IemK8QVMiHWm06mOQL?=
 =?us-ascii?Q?oh6mpWw713z3JyVBhLegsLP6Cy0nKEb/GUJ0FN/+WznUd3ewKlkmofA6UrsI?=
 =?us-ascii?Q?CWHDRFJksTABKB0SjyXuup9waQBYEWSUMsnFZKzL9YFlf75uiMFKwEmei4g4?=
 =?us-ascii?Q?z7EAT+4eUthhRerL77egt2ehZYBrmGwDRcMW6Ntvv+CcVmAVl3yGoeFu0ywa?=
 =?us-ascii?Q?Rc29ECislbpohDeHSzhcN83GS1zv07BEe3dI+MMX37RSuJijr+LWMczU3C1t?=
 =?us-ascii?Q?KdbCV2o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92023c6c-0263-4581-f1dc-08d96c57eb20
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 08:18:31.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEJkloHgM7kzo8vST70wdV5MFeDFAW9hGRlsrjRu5bueZH2lqH1WujgntbvRKGmOSiojpGbMKHcvDwwXQBfcpuTn177E7EgDcpHcFzpuySs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310047
X-Proofpoint-GUID: n80ymvik836bRaJlosx7dsGuSLZZpl2S
X-Proofpoint-ORIG-GUID: n80ymvik836bRaJlosx7dsGuSLZZpl2S
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These should be >= ARRAY_SIZE() instead of > ARRAY_SIZE() to prevent an
out of bounds write on the next line.

Fixes: 79e561f0f05a ("iwlwifi: mvm: d3: implement RSC command version 5")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 0e97d5e6c644..6e3a63a5a75c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -360,11 +360,11 @@ static void iwl_mvm_wowlan_get_rsc_v5_data(struct ieee80211_hw *hw,
 	if (sta) {
 		rsc = data->rsc->ucast_rsc;
 	} else {
-		if (WARN_ON(data->gtks > ARRAY_SIZE(data->gtk_ids)))
+		if (WARN_ON(data->gtks >= ARRAY_SIZE(data->gtk_ids)))
 			return;
 		data->gtk_ids[data->gtks] = key->keyidx;
 		rsc = data->rsc->mcast_rsc[data->gtks % 2];
-		if (WARN_ON(key->keyidx >
+		if (WARN_ON(key->keyidx >=
 				ARRAY_SIZE(data->rsc->mcast_key_id_map)))
 			return;
 		data->rsc->mcast_key_id_map[key->keyidx] = data->gtks % 2;
-- 
2.20.1

