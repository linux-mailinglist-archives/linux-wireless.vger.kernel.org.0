Return-Path: <linux-wireless+bounces-25470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F4B059D3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A153A38CB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF432E2F15;
	Tue, 15 Jul 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KhgtgpEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6C2D9EF3;
	Tue, 15 Jul 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581885; cv=fail; b=bj2ZV6T+RBGVBQnNzcQLhjxyeaW+l5IGp8VA7IhVGIPGsGQGZ+ht5C1Na/JaLrv8WWzOqkQ4CXEMHkSvm+eVsTa1Q7Vn/DHJXKv4hfhfvcIFY5PpLAVaYUD1vq11UawJMeEwYOjjh8bu/QKyzSoxRe2iJ0UOVQTvDbLki81/fJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581885; c=relaxed/simple;
	bh=raIwNgbYEIdhq82OXR5I/F/yVKI5nVOPz/tfU3w0v9w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbJMiqmV1PsYcYZU7XajkliknP/k57s/gCrnYjA0ZeXfeGwVhE7S3fVCyggZRJi+6tRzVFTKs1fThaJ6FyyDa+Lh4952IvtEBmGYEtAA7+fPdKUsstVka+afhROegyH5CvE5RdWbksAwJBqpmhsXtx3BCkh8SgfZcVPWO4bM20k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KhgtgpEg; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GReKcZgFgKhWCNYp6WsDyae7dahCKIaOWl+uemgUQHeR+neyK6JZwGbKFVqNlkdmSksOmV4WOte7JRSaDZf446gukS70UvOgFKjTL15g+u3jwsFAOelUo9npdSEtqzm6cHfJ1uVhffwcFWnWSNHOo07hKMH9do62/rA8nNsCXPKpRgze28x3HNW4730znj/H/y9nGTuI4IgBu9SBHJwzj2GTCTUQZxTqDXnh7qFv2SZE2ldF8ML4MBqqUN5M4cM7RXXaNpHe4yOPfT7K1Aq4bgnpPrar1S8g8nsDGGG/RmWNzS0I36xqnSIKwqLSrQhIhhLW34fHl0Kt6OnRiepKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WRXHYcRkvycrUedPwI1vhNvo8mk/8agYS8G3Do9Wko=;
 b=vDkW1yubs0LiexkydzjCe1OR1nLxEDCOD/qlRVbKSs5xaDluqK56yTBUCEwdwfIiIlmIT5/LXxeqzDIcGT+N/IcUaBBpzcJPVCbm8ZE/YnYqOEwuK2NVTr611Uo8FUqbSGaaVkWbwx8BEB7tTwN9LMSMxMqrxC228pZSzAteH/IGPQLOiKVSYCmCW9ZdmRMEJdr5o3254V9W2od5RN2a23YJHgwLy8agf+/tni1kbwOG1EKoK2oTlnblM3qdU+ARUnj6/O0Xegixtp7yC/5rY1F9dGat7afhZFHMavd6Horuvt4i2I+J+gvtJFMV/fpNZ7P8FETHIMsebI8IRNkTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WRXHYcRkvycrUedPwI1vhNvo8mk/8agYS8G3Do9Wko=;
 b=KhgtgpEgv4xygtMfFo2x/HiCvZPO7163xU872sNlJ9JRVxlzvf3oP4wMlH1WSWTjn6wPV3k86ubODcmHRDfO+RwPdAHij2yN9G/1OGOkGrEW+cYfmKk5YHbLqUU/rKTp5iX4tCOe8EmD8guXWXOhvW0fEpIhepAnNmmZ4IqywJmjfwvNEa7nPPvw/1AxT2MjLYalv9oQae2+KsEJ1zfb5FnenFQnh2r9e1yT9WGAho2wY504kjSMooNWrg4ST5YPVZhsZw2ZuwYJ8iKKkXl4ccSppVVDf1EmiOSYdLSW4JUSDio6egdRSfLA7kNlJtYdmeDZn0KptnM6pUOKvuRIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:18:00 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:18:00 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Ondrej Jirman <megi@xff.cz>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/7] wifi: brcm80211: Use min() to improve code
Date: Tue, 15 Jul 2025 20:16:50 +0800
Message-Id: <20250715121721.266713-5-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 570e6c2c-20be-4f30-63b1-08ddc399a3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U91t8lyAE11+9ZlGqBWWEUydsGVmxqRoCOIC1RNsjI48VuTp2Odl3ChS6vcV?=
 =?us-ascii?Q?0ZBgBVJDJmLcDP9V+/reNxgYf1tfdU4HUsT0II4e6UvXt1S6CG9TQ4b0VQyV?=
 =?us-ascii?Q?CEI6sRXbA7XHbxGrjQlwPbq0cpNIGmRtsotnU4pmoPc6thKPY6pxYpHnVD8L?=
 =?us-ascii?Q?3FuSaARM8kG1+VmUENsBFnkpDJ6C43LnGmbCzBjyqxR5aiPuABhcw3GEW1c3?=
 =?us-ascii?Q?9CLonW29Lb0YqOJZ/ksTNq7+0NUU+uC1vqs5dtAT+E699mcx9HdTqcXZ8TUc?=
 =?us-ascii?Q?HFDe6o6m7YwILfvsIOUaHDnQY+NwM25nrU8g9TZGeX9BrHIPOpIl5rzUideF?=
 =?us-ascii?Q?LXgoQZOlupnX9ZaF7JPFcbNKBcrJcgI9Xes2oouOI5nCIig5SdAuZxOxv4+R?=
 =?us-ascii?Q?CfnhZZwPbQXLIn8bwq6vuZnK6s1MTv5WZQznKt5oOeJA/Hzw+YwuNem7wQFC?=
 =?us-ascii?Q?3bdocQEdQ8WBEshEg3NopUpSI5XeqFgHUcIyf608mMOD98khuOAyP7wkN5+Y?=
 =?us-ascii?Q?K6hqe3cI6aQ5jchB8wLzUo/y5iXjAlEBc+MtUXtk4SQt1k+R9bApaxIcwKqZ?=
 =?us-ascii?Q?oBO8nCEndIqphkIebYaFjRs+ZU/SnMhcjkeBiLBF8w0eWHG4wZa94f0NbeAA?=
 =?us-ascii?Q?AYuWUu6VKGnstN5U0gRulsbXR7sFWH+MOUVambXjoY6fhi+UIZMrM+hPQZBb?=
 =?us-ascii?Q?SCddV+qzb4XVl7jcIzPhwcl/f6gvDT3kdBZvJIdmvjMWbTWEVwDpOLwYPrpo?=
 =?us-ascii?Q?iHZ+LXF+R9aab8kVKpqe9si1155urpy+IhtoJnXCWKvxemwd5fQIgwf7qxn0?=
 =?us-ascii?Q?sWk7wLDgTtR3JYEsQAzazk3ZxOCehy7XRiNeKeUs7kAs4Q3ErL4AHDsLMrpK?=
 =?us-ascii?Q?ZwBYlFdTD96N3i0I/ynyg+QJCSD7zmUdGkv1hhc73iot+xJA2U2htbGv3ccM?=
 =?us-ascii?Q?rMa3nAnFiqVonBdn1BDSEZwdmnJ6/Yd2cePDCGUgS+gltZZnbRk3QtE5QZKy?=
 =?us-ascii?Q?zRMghhflpIDo+juqYU10ZL2mmG+RRl/oBnj1SpeL8hZ7ZGzVyyb0sMkD2gqD?=
 =?us-ascii?Q?6vGkbSt7J+iLh/NJx2xD5z0ql+XLX9IWzySCR/6XjE95rUEq8pkBM1/GinfG?=
 =?us-ascii?Q?rTFckKX5JpfC5w+zvkWSTrmdDl0h5riAEBEwX4m99wDXGJFQoY8G9gAQaDG3?=
 =?us-ascii?Q?y9YmT+EQ8P7T7OljoR/0efRUbTIfUkc2vBksaUSipp/Y6qAaKl7n+ndVRpsd?=
 =?us-ascii?Q?VqdYM05KrXQLldI9XnhQL/3UbRHAqiiOUGEeUzALf4cEfZtnRzahOF7h5o/q?=
 =?us-ascii?Q?SFrTNXfNZE9EDIr5z5T57tlf6VWDX0XCV5y3prWhITsQnX/eVQbI3n9hCaOg?=
 =?us-ascii?Q?TGQPmDJBe03cevyo1SFKajWHKN02C7qwPBOmpMKsqaLwq0Ff1OP2uwHI9XXu?=
 =?us-ascii?Q?l2VlhXwAImdE6J3EnfPin0tUMDGCh/+RdSByFOS3I3keV486naPIp72Q6gM1?=
 =?us-ascii?Q?alyqkL+Mq+qCl/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtijZ4DklDkX4/v/DcysBzi6UDtIv3WbvCejIWLZ6wr2oLuR987e5mOoggJs?=
 =?us-ascii?Q?YKlchXloQo3jW8c1bztAp/UR0FONamdEUCYAyVV0Qs0NwOEP1myp0MDkWHP2?=
 =?us-ascii?Q?ZAVYGIYaFSYcGvLqtkOAwceLVetnIKOwiBjKO+J6kg+sNOEdrYYNK5ktDWfI?=
 =?us-ascii?Q?tQm0gpHiKpQGiEDZmznS96h1zSKjet4hIhlLhBB2u2VrKG2mQl0ks8k54GP3?=
 =?us-ascii?Q?Y9ZeXCTYRHKr7RErnXxnA5pbyMJCs1NM5RWRN/4vOq2o7mDtMn4QgAHRTrbi?=
 =?us-ascii?Q?2TqbhraNSoM1yPLKuhJU5DcjD8c0QmtuY5Jh0czW5XDt+DQMTWvFWkYvagS6?=
 =?us-ascii?Q?KRraFefEVcvpu6zCQAFPYtENySLDwSynam7hOQ51o8prbvrWT6Yxoc7tHPWY?=
 =?us-ascii?Q?uxhcmxnqi5lklDwb0GEBbckfMqcZU094m/yH3XOWSL6OUnSxs06gYsX63eIE?=
 =?us-ascii?Q?KRVbOFcX95k7fP5ZVpKnNrWKwDaG5gjvIr5J9T5l/mv38QReW5lRjMt7yuPW?=
 =?us-ascii?Q?Mjx65JgAKDPRgSfuVKMZtIaC2XCqKF12dF6a1s7sU57ro6250fkukiPIBGff?=
 =?us-ascii?Q?tdAEV7p+/VZ8hxeGUJDHnHNIRZewK6SvghIjaD6gSk8vTIoYC78W+RkkJ7O9?=
 =?us-ascii?Q?v1zuYYmVRyCqsxHoYN7ga9qZMcZi8Td52p2LpUYhzbBcFFTpW9Ig7SyIr+Gt?=
 =?us-ascii?Q?RO7SxTEiCGpaegnrSbnJsrSN/7zAmftnW8kIbaIVWhKOBF/f+pOCFEKk0DoO?=
 =?us-ascii?Q?Mflllfpsfx7vf7prhIA1dcLuUpejfevE+YgyvmjOx9dDSuaHVYFw+Pg6QASC?=
 =?us-ascii?Q?nnggpAxtd1ODrl7Ni8gSzk59xflfEwGw1V/MIx6qSFFen0GIhGt7au53iya0?=
 =?us-ascii?Q?RwZm2/G5ug7AvJD+EgzipkkEfATaNNGge+Hv6blM61qYcWmiPNDDA68+GTEN?=
 =?us-ascii?Q?+r5X1udMEEE6McSTO3RpjPfBWPBwqig9Bqv7zUc+J0VrKAptjYtGAN1aCCRb?=
 =?us-ascii?Q?cA9yPG8tMDHc4LsrxTFdUxIqsCDD7eMkh33t3+g33z7m58/RTmk0QTk15oBv?=
 =?us-ascii?Q?ufYM0KvC0zF/PT0MPzSVAo4nYFBzi1zM4tg3NyNLXN0+KjVB040eqXiMtgkj?=
 =?us-ascii?Q?TXmmbxfMpyIi2Ys6wb9WvsvENA4ac2+TbKWhT9hygvYKM+kEa6H0gbMsTIVY?=
 =?us-ascii?Q?kMnn6S3gVKQg8X5FtI/FXJSbRS7XQDaTnXQtM+gH9IIaCQWdU3/Z1HNFS+o2?=
 =?us-ascii?Q?oHdHAw3GLOanJk5y+OetQ/6zlXRsdA6ySo2yiVVOwoiADBkpCnJ5GNtet0Cn?=
 =?us-ascii?Q?Uaibobv5E/9Sm1jo2lq+EXFfEJYDjhOgsjcZtwJhjCbkdYum0KWMFfmIVRt1?=
 =?us-ascii?Q?NEyjsFMkjyjY8GXq/kURCjtL5er1/IQYT1wlBh4hnJ08IWSUPuk7HvUHV2Id?=
 =?us-ascii?Q?DOiBa0ngybhebmfR0/0rGLQ7jmQ0MsC1g5BlkcbuZ7HYMg5E8IYdiPB/SmgA?=
 =?us-ascii?Q?L6pQYNDYksrhDfZDLv31sLHtYhqLxrdYYbAnh6jaA2iwXtZsTzUqhZ6AymrM?=
 =?us-ascii?Q?uy3E3LkPVz/C/CfYasYVgLEUhwTSmcaacxPW1WB2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570e6c2c-20be-4f30-63b1-08ddc399a3ec
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:18:00.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9lnDMJurnmKE3OLNUMspNXzkyyWjGiGmw8d90XvXewNljJhvyB3onNMbucnvvqO8dVTYCmBP5a6BIKjQiv73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c      | 5 +----
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c    | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index b056336d5da6..f0129d10d2b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -927,10 +927,7 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info *devinfo, u8 *fw, int fwlen)
 		/* Wait until the usb device reports it received all
 		 * the bytes we sent */
 		if ((rdlbytes == sent) && (rdlbytes != dllen)) {
-			if ((dllen-sent) < TRX_RDL_CHUNK)
-				sendlen = dllen-sent;
-			else
-				sendlen = TRX_RDL_CHUNK;
+			sendlen = min(dllen - sent, TRX_RDL_CHUNK);
 
 			/* simply avoid having to send a ZLP by ensuring we
 			 * never have an even
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index d362c4337616..b679821c7f99 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -25825,10 +25825,8 @@ wlc_phy_cal_txiqlo_nphy(struct brcms_phy *pi, struct nphy_txgains target_gain,
 
 		if (mphase) {
 			cal_cnt = pi->mphase_txcal_cmdidx;
-			if ((cal_cnt + pi->mphase_txcal_numcmds) < max_cal_cmds)
-				num_cals = cal_cnt + pi->mphase_txcal_numcmds;
-			else
-				num_cals = max_cal_cmds;
+			num_cals = min(cal_cnt + pi->mphase_txcal_numcmds,
+				       max_cal_cmds);
 		} else {
 			cal_cnt = 0;
 			num_cals = max_cal_cmds;
-- 
2.34.1


