Return-Path: <linux-wireless+bounces-17248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A916A07C93
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 16:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AA83A92DA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2821E088;
	Thu,  9 Jan 2025 15:53:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816821A42C;
	Thu,  9 Jan 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438005; cv=fail; b=kZWFab4gkYxsrq20NbhuaiFbgtAeaTY+BmBR7dZ6H2BoKYVod05OC4Y6DxNq9Xt2k1qdtIX8xAgesO2EXFXXLspmW8DNaIuKdrYvlolfFTW0nDQ87FgVHSyys/Jp1ipFp/8SHzLOfT/VsKA34wjIRaV5vhqHyiZo5BHUaju8j8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438005; c=relaxed/simple;
	bh=ozaq0T3tMisXLZQ4yg1pKZgc/Le1r1dchC0a9xHF2LA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hy+Lq6kMAiHKGMQsQsH6ESlp88120eqmVOQpjTTdDL/EgF50spyf+6tm3taP7bCvBg4kA8wOnIItyL+eJaDKeSr+UP5ibNowvYnBOZxOOi+1mdBrl1CSB0pq5c+QJE5Xb3dp/AjOwQQtYgTtYaV7OL+s8FvimUNLQhIUeO4mJCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509BPxK4001632;
	Thu, 9 Jan 2025 15:53:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 441fnkhw59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 15:53:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5JDUgHnzj1hTLhs+N/llSFaQXpIhLbHgkH29AYvxtvZ0a7N5Pi8I6QsZiT76r3EA9P7RtLtlHmN/q15vs4CaY4nAklrZDRh6ovNaCMSkOL8Ro26M/BsjJLhTGWT20Redi82PcSdmGBWWU2IW9bJ6b64z2eA+D7iIt0KIGq93O5Ijgn/ZyTojxThDeKxXMF0cDICt+Q2gUvrjPttrPqIoLlW/SlyKLctGxD60V4jAVxxorUJSE+LYPanPAJWHS4vLqxabngE7AXMxWeKt+5f7rnemRLi3vqfu0c4qRZzrI7kjy9VQiLAJCAr1ThiIZVdupg9dyUQrK6yV+bbl3YImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szyKh/IqqxKDjMmGArD1xxjKLUjpTtx2gKjs1luvbM0=;
 b=EUvyjP4hViLz1sQkN/5H9nPKxS0pzuP6ZYk73/3YCtpv0Fs7dBw4kGKWlxjSnhyhv9RqbqX3wBRthJO4gi5DLxtCYu0AqvLlHca6oLDqvIa13eRbwHEY0BPa8Y3qs6SjvWEAWoPwh9cSbwKowyyRW3aoONT0tWGmpUneMQA9q0bVsM4YBURCvSHEyC5MMbe6LlF859Losim4/HAEk8KkkYgz9MYgXYPcaGqJS11T++2OZRLanUmVuu3H8nCVAEfO6XgDxjxLRmPGqSS2Uit1Ambvf1JEV0IOAKLP9n6raRdkET1da769036/vOdzjmOzZsdYMrNF5pV0jsEOQlOfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 15:53:08 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 15:53:07 +0000
From: Marcel Hamer <marcel.hamer@windriver.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Marcel Hamer <marcel.hamer@windriver.com>, stable@vger.kernel.org
Subject: [PATCH] brcmfmac: NULL pointer dereference on tx statistic update
Date: Thu,  9 Jan 2025 16:52:01 +0100
Message-Id: <20250109155201.3661298-1-marcel.hamer@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E75.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::44) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|CH3PR11MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: aabc7f4c-af13-410e-3b73-08dd30c5b5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KZk5KJKCMhvmZdb+jEUTqM4W53aOzrEAe2+LTP9K2AV/18uX5gY93JBQR8R?=
 =?us-ascii?Q?KyRpdsmk4OKn83u/Q7C2bx9KTJR0lxKsuVU5VBRHDwwu0wPAzA7K4QByuB9b?=
 =?us-ascii?Q?UiZJ9sI67SiVKL3dU3xtrclKGnURgiz8vg/s4PNBDBTBbqHQ6up1ZIiUACf4?=
 =?us-ascii?Q?IUnhfzL4gt703xDdHV/R9qJVG0YHSFPDC/7tHMQo34+tV5x2WgDbAybfTgMB?=
 =?us-ascii?Q?vmWNm9B7Of41OH9FsarfYOBFMrIiocg3i5RhuxYKrrxVqwHoNNJWsj2iwT8L?=
 =?us-ascii?Q?2toC/EHKCQCrvhuh/DSJDc0qxHCG7QYGQXXQM8mscRjBULybfx2hgTKE6UNO?=
 =?us-ascii?Q?itbuP4vYMHGUVxh68krl2/TChVLk2qguhIvOeZ9VE/robD48vACyGcw3NrPc?=
 =?us-ascii?Q?C4Eel92cn0pYFR+UX0H498+WxeduqB+bntRlBYTuAhUPe2clnqBYHZZUA9un?=
 =?us-ascii?Q?pcuezWJJpQHyCE6mf7zepJpwNYn0cTWGlokkBhnVn1PwU922mEtvmt6oDBAg?=
 =?us-ascii?Q?nOGsKavDJLlvFwnktHs9dtpAzhNpba++JawrL8OJ9vhEm3FeibbJU6ud4Hte?=
 =?us-ascii?Q?37V+B4mVOoAJkApb/MPML/MIhuAlucRy8D5JENUl7DZ6qr29IYld6qh+L9Wd?=
 =?us-ascii?Q?2Y6i/+lFEjb6VAfE8E46MPa0G46xdB2u0i6kLpf/Fb58W4NN9MQ0zL98TGkU?=
 =?us-ascii?Q?MX8T1pA42Y7e4y7aGqGDmdir5Gp/C+09BO7HJqpjx3bvYKhW5S7XP77nyprQ?=
 =?us-ascii?Q?Whhm6W8KhlR9QCQUBKA8CaUvNpZuoIgC3QmxD5t+nRPD9ek3isOfXLeKtkh5?=
 =?us-ascii?Q?P8WESjCSHjdhUozIhMiTuMuDKlJEU94JD0+FGOLql38RLVebXHKS9f4QaSCA?=
 =?us-ascii?Q?fqHSgWXEtmZraJkQeyJUOxjh1Esob8xx6vz6wK9WZ+15eIKW61GFybNd3lR/?=
 =?us-ascii?Q?nYNXm2O0J0r03I66piRx0fPehBPnE/dxh94mMavj1gq7Cr263k0QNyqpIXh2?=
 =?us-ascii?Q?hxZ3trn9bvSlXF9TfoJhh9lSyhnY8ywbFa1qS0gK8sGGuye60eVeC0fbLtaw?=
 =?us-ascii?Q?l/RwMcLXdHtlQ6yMB9plvOwiPlt/E1FF9wA4gsFt8NR4gh8/lHGRd/y1Hqva?=
 =?us-ascii?Q?qU7EfC4fV4VlBM79WgRl+H+OInT/G6hlwS9U6q6ORaP2DUTyzd292rgyfmM7?=
 =?us-ascii?Q?gnAmxHk0utJY+sVt7n0HSUIu0Zmb/+X25RaQHz9D6Mxw/lfYvJA6GGaZmFNQ?=
 =?us-ascii?Q?sYuUjqIq+EVaf6S96Rt2oaS3NPhfbesKjGNsbG/YZt+JjWqAuPZ5NasCmUpF?=
 =?us-ascii?Q?PNN6XzEAsGCqWT1/fErL18qF0t9AYQ+M1hdNSlwYqD0/J7Txo0U68B+Wz4Ar?=
 =?us-ascii?Q?TOlYnnSTwHhTdYwYTDA/FT/3qURe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZKAWgDR/73K6ZV+zkKnq2NKkKmJ9vd1ODYrouJYYyMT6871y71H+S5xjEcR?=
 =?us-ascii?Q?6qYq+2hcY3eBG8oDoT0dvI4v1M+Z6CT18URMFD6iwjEhcrAHHMxhCxNVrLYa?=
 =?us-ascii?Q?+m12O/86h0YetCzda3udiK1JKXPutzzn5Ey44CpW6YD4NScAb58esYgQEbDW?=
 =?us-ascii?Q?si3Tu1ImMeYWj9aQtvGDkN9w71O6g2EunYdOym/M6k2csw8hwlJ/yPn9YJU+?=
 =?us-ascii?Q?qs9ACZwLXYxbpZ1hHN/buE1+Z203G9s/eZPdRbkustHTyRKDFSes4fb3awlo?=
 =?us-ascii?Q?iog9dF5Ii/qvvbcbJB/78jgMCyl341Zbck70uVoeaBRiPY1ySCd5YFgecsCM?=
 =?us-ascii?Q?bQkp8XaKzDlo2FKzvpYaxeNKoelo14Ar05XYGQGoSxd7KU2HL5eXhMWrLcow?=
 =?us-ascii?Q?ijVAh2gLH+fNhatxmnVcyInFDO/2t2ez+q/udak5k6rUL3RiDFcAiGJytogN?=
 =?us-ascii?Q?DLcX82WaVXC+uvNuXH0EkAziCenRaVPQvZbRZgTQqDt0G5c/RsS+yQPeYGFE?=
 =?us-ascii?Q?6WIj3EToqr9AVuKF4FZN3Eay4gXZGzj5qLksk6AIs2ce003DG7WulCKqVFsd?=
 =?us-ascii?Q?2ptM+8Z4igOmiVpz8Xb9TxvH5b8D26uddk3Qh42wcZ0BN5FS+nDsEmcsET5Z?=
 =?us-ascii?Q?CCKZNsLUvV5qiNeppbvMuTHlCohQVH6m9oULjnMCeD6FLbGDKxhMb26uzGip?=
 =?us-ascii?Q?zH8CgwRSS8iyt+t1qcflyn/RyfZRq46PgnWZdX7DmC5E2fNT3ci4Yp/6pM9s?=
 =?us-ascii?Q?/zcvBigUF5vovZXMn8821zHjYEu3ufrqJQek10DWlakTB7VA5PAhAJ30aAXW?=
 =?us-ascii?Q?gOjiKeJGQYo0oAtTtmcqZE3dG/24iwXgV3BqETm/F5wPAEoQLIrUQHgi+6HM?=
 =?us-ascii?Q?ecE4xyx6mRPKsoYk/VNzACOGa2sPnQjYwpo1qSQiVYsBXhH4a0xxNZxW5Q9s?=
 =?us-ascii?Q?CwI6aDhggz2dra34g02yOOnSAPRsGEyhgSc76+eKXRpgujBUz2iUzhmtVz6M?=
 =?us-ascii?Q?j6h4JnfrMGhP7dKQfDXwFlpuSzhhDLJekh/jQB8nzZyqkLc4OJResNYrDwQw?=
 =?us-ascii?Q?nskfYpAzK4A3zkp9z9BR0lFclwDaK4ZcyE9J9ROt70+jN/hLMe5/y1I43tMg?=
 =?us-ascii?Q?8Iiumkvlz69iycLqEafnNg1Pl5qdOwUIQA9cDTIBLjndT8FhLTMroodKY4cr?=
 =?us-ascii?Q?oGbHq2iGbGf6e79kk2exSCJ0P2D1mdjF4eky07s0bR0+vi8DVVIQQr43fQF4?=
 =?us-ascii?Q?EAhPmfvNh6lE9wyKO4NN3Mrsee/QtplyG8c75W7BTfrpBORO27Yny4luJ5iQ?=
 =?us-ascii?Q?N7BOrUCm2GYP+XD8VK2Tski7DVshx3iQ8yfhswwLAM45bl+DhkC4c9EM5L5i?=
 =?us-ascii?Q?x7GACJ/VKShUVODQpL/csdDZ//377knSyrdCP8CP4EnWVqJh2OfKaJdqxhZH?=
 =?us-ascii?Q?hIGkRtO0ylTz2TW2o6EgwWRlYOhkW7mWtwAhoFkVqwY1RqAtKz0V/lXEzrQb?=
 =?us-ascii?Q?ALKxKDeZOyV3CaPF3GX8KaicuaDSKsIeKXCgUb17Yh1bQmrqgHYy85xOtlU8?=
 =?us-ascii?Q?WgLiPD/63AKole+HKDoobZ3xCF+RZvnjEOcGEhGqTGy58Cr24jOUi7ITpu5u?=
 =?us-ascii?Q?kNFHCwVfI69LScATRFR+eZAodzDqC4FKvg/L9IWQnzrngov3Da6x/VzMcIDt?=
 =?us-ascii?Q?JQBfIA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabc7f4c-af13-410e-3b73-08dd30c5b5e3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:53:07.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzMM12fNCIughpbDPERmKApszCe5qXoMhOgL1Y02zSOKGxDPkd8R4MoYg8Dufs/bb+WcfncBvf81k4kxQWfzZXc9v3N78q6Jd0MTVwfdf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-Proofpoint-GUID: _Iuk1h7CNxkGC4-Vp3ZjPXEW_7-WOAml
X-Authority-Analysis: v=2.4 cv=bJjsIO+Z c=1 sm=1 tr=0 ts=677ff0e8 cx=c_pps a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=0pxr1lnVwKlhBzQI8TcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: _Iuk1h7CNxkGC4-Vp3ZjPXEW_7-WOAml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_07,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=872
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501090127

On removal of the device or unloading of the kernel module a potential
NULL pointer dereference occurs.

The following sequence deletes the interface:

  brcmf_detach()
    brcmf_remove_interface()
      brcmf_del_if()

Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.

After brcmf_remove_interface() call the brcmf_proto_detach() function is
called providing the following sequence:

  brcmf_detach()
    brcmf_proto_detach()
      brcmf_proto_msgbuf_detach()
        brcmf_flowring_detach()
          brcmf_msgbuf_delete_flowring()
            brcmf_msgbuf_remove_flowring()
              brcmf_flowring_delete()
                brcmf_get_ifp()
                brcmf_txfinalize()

Since brcmf_get_ip() can and actually will return NULL in this case the
call to brcmf_txfinalize() will result in a NULL pointer dereference
inside brcmf_txfinalize() when trying to update
ifp->ndev->stats.tx_errors.

This will only happen if a flowring still has an skb.

Cc: stable@vger.kernel.org
Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index c3a57e30c855..cf731bc7ae24 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -549,7 +549,7 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
 			wake_up(&ifp->pend_8021x_wait);
 	}
 
-	if (!success)
+	if (!success && ifp)
 		ifp->ndev->stats.tx_errors++;
 
 	brcmu_pkt_buf_free_skb(txp);
-- 
2.34.1


