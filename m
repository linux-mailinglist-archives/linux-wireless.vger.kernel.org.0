Return-Path: <linux-wireless+bounces-21392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC6A84857
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03744E1328
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9915855C;
	Thu, 10 Apr 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="qYAllXbg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B1156C6F;
	Thu, 10 Apr 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299948; cv=fail; b=p4vXkGgiiA/PyZJn6UgSWIyf+v3NHvx7v+VWLmWOAW4BPiTZ9ttYu1VhzSl7ZsVgQtNfPWxcTdfWa4RH099EC9fFypB00/ZGO1kM1GLFUmR/sS9o2RD5kUlSWZJ+0CJHXZrFMj/sWkJK9deafazZio1UZt23oxozE5vNcNRTcEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299948; c=relaxed/simple;
	bh=48xecTfaxS6t2FFUXR225FbblBcWD+DLkI3Ysec31ag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rPnFWFDMmiE7fX6Mcz7+WpD9qWfdQRYUzQjsBbH1IgyE+z8bh1xWKY8QQfiPxqdLsWO6rdAFkbQPwxwEx9RD8Z9CH/WwiWz0RdjaHLphDpYxvdUEFEABhQy1WMM2ZklQgAFg2/SY/mhzhVuBZxM1EdNyZrBiKZvKqUHN1kQbpIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=qYAllXbg; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8PEhG4u8WY93ONLwdhu8d2D9kkqkQ2KzzDv+Vx/237WkgeVgZGUmhzz+SD3nnJC3sU71dq8sJDLIRFHFpMV25W//McisBpzUHfnvrXze6IveXh0DKj4+2SO41Hnn01uaZbSLLCCK9+AVbWZrCQgJxhmvugnKVn4eeESfYcb/4hjAnW/eRVtuIaaw0g+A/R4v38uYq8xhwh4SnnktiGWH+ArTnqQObfzn82FEMoTkcM1Oy7FxHDgUewWBLBj+M5yJUMD7eEg0ymEwf7HBbsWxZm5Y0XHG+LwDjtOpKdg1a/QvFJncUoRkKqUR5ANNpxl+wwRFYHdXcFGgvBdSSOduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9/XeGDiZf+tgtRmLcTsEl/d0x6cnGFCSBkoyQiW3wM=;
 b=amZE4zdExr7sjR1TnmWa6Zw39FV+zCDIoYo8uteq32/jC3w0ZKW310fqmR5+G5gDOv6y/HTrbq/uAqaIrozbjr02cpK8DUXXFOq7S4pCDh6WjqpA2r+GYmaOA/npoJdVjh4O8+wPyDQUtL9HpqkYdrttMG2O284mY3DQWsUGOkqOrn51H0y2sH7OSA4sM+R/+hYOOgNoSPxFks9w9kRx88p7l3JKr8usk3SggfcBWxkbSsmIzG/KxmWJoGM/rUAv9g6MYIlONfj8dvfKjEZw2B1Q2S/C8oMfJ+gaskhQIE9E9l4zktlVAqSzWEn1jg1PdDkVJhfOxlhlTQsZ05BgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9/XeGDiZf+tgtRmLcTsEl/d0x6cnGFCSBkoyQiW3wM=;
 b=qYAllXbghg8VeMLNcJHDSKXm2JMnyRgckKgjR8mr/U1W1xZky41h8FBcoEglPkyWCN94XRc5jNgsgBwL3CZTSqw6esn5ZWagA+D2lMbp1HpjoPQbxfs2LaWIFfuWAKugGEgiKW5LAPpyMkDT9o71+oxH1TIBNmgI1sgb7MFYHPx95RdmbyJLpuT/qMaydPgZHelyS57gmZeXdAo92GrKWv+07KARKG1+WJ/C9ZNtfr+3EcvitWUn8bY+iR+vvPd7NfyiAxPiMGRa0JtBzDRQvDAwI50JSEnu+cdPMVZZAa5DWnDdTlb75k2PxUx0yNULng8/mzZ8v1FThaFfO79TKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com (2603:10a6:10:1f0::11)
 by PA1PR07MB10210.eurprd07.prod.outlook.com (2603:10a6:102:491::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 15:45:39 +0000
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5]) by DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:45:38 +0000
From: Zhen XIN <zhen.xin@nokia-sbell.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-kernel@vger.kernel.org,
	martin.blumenstingl@googlemail.com,
	Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: [PATCH -v2 0/2] wifi: rtw88: sdio: Enable tx status for management frames
Date: Thu, 10 Apr 2025 15:42:15 +0000
Message-Id: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0153.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::12) To DBBPR07MB7481.eurprd07.prod.outlook.com
 (2603:10a6:10:1f0::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR07MB7481:EE_|PA1PR07MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fc30b8-a24d-40d3-5436-08dd7846bdea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22t0O/fs+Bq4bISviq2DIleNnm8MqjCg0/jOPektXet9ecX+6eZfE2R1hF6Y?=
 =?us-ascii?Q?SPrlx90dHVCwF/s037uYkiHjfoHaFFhwtNEz/3fRVZgHjjNzZglgfB+7cQr+?=
 =?us-ascii?Q?7tkadGajIu5FCeFj6ztI0fQofSBcEA3MEcjJC9RJAmiY8hua/ApK38K7riEa?=
 =?us-ascii?Q?wNrK9E2lrTyjFg4CWtgtaL4HfIY/DsMAD7FpeVZVMeY2S96KwL1UP715rLyO?=
 =?us-ascii?Q?zjbe912bCmBUpcWyxnipu+BLoMylFykYwNTthYa4fAfrbO9FSaLREXgKzbC6?=
 =?us-ascii?Q?7E6VYLe1m60x121rkUvFp8bUMdH0WK++9E+9muWN32tleXtOxVgI1pCNoLUd?=
 =?us-ascii?Q?tJiFWQSdZxaGM/n9Y7N7VDpA0Y9fMpoby3gHAGsk99x3PWN9JwbvPCuhzRpN?=
 =?us-ascii?Q?3ZS6JgNfJNGmrTv1wVr3yzqdCCvHD10rIW+KuIJO21XKOnTXvp0qBTkgM4GW?=
 =?us-ascii?Q?x/+zdwxe5ranCaWf+JEV197C75/OxXPvV+5J3o7zt1s+O6OeoIXLcubH531B?=
 =?us-ascii?Q?LSby5sUOB3TrWGC6j4aOj/8lRPJ1dXHxgbc+r9LEsszhw4aMXLtUZ1z9hHpb?=
 =?us-ascii?Q?X0mZtxjI8slrc7f5cm1z+6Cg+DwlVXve+cyOQ1o94wrm5bKZqS6/tsJoC2XN?=
 =?us-ascii?Q?viaJC3W21lkRk7/rMW+VtnsDen3sklWMopaOuB7OOXciprtLEON/xQbnUte0?=
 =?us-ascii?Q?GcVSpa43Yn5lcnTo0g5cHpLgj3/DIIuSodgh/+2aWQwU2oKQvCvfBPJmRnPs?=
 =?us-ascii?Q?qOJLt77xF70450228I72T1dlEW7xBs3yj8KTPd6oYi3vgoWSQLrMYxdYR8Va?=
 =?us-ascii?Q?4FzeMtRnVpaGqYEMNenWqNXeVXH9MCucEkaLbtEpVd3+veJfaGQL549VjqEu?=
 =?us-ascii?Q?BlfAmOn1V7iJyx2BIi8Wz8If9MzjPgHqxWS3WL9/4q3jBu4t3oetCOZqO8kG?=
 =?us-ascii?Q?/OFkPIEn7GU0EMoLw4wThQlVr+WTDgGDdyo5OalbFGeKoPVsOfUaan7zOoHf?=
 =?us-ascii?Q?G0scwCdHBqu9/VuecisUoLg+u95LCN06gi+SC2KHzoo6L4PDJTTCQx2lFbuu?=
 =?us-ascii?Q?14ZcT1Le47zfcT3kJucS0OmUa9ABZy4IUlmYrRmEY98Dv0vNew5gQKQW2sNp?=
 =?us-ascii?Q?pYbgHF9WToeXAU0+7IEAGoorI9pr6B41/+AVHh1OkvmTfn4F4jS6sGYp1iUd?=
 =?us-ascii?Q?fXd1bDLjqT6oUYqB0pWN3twZXB4HnY//Z0pp/3JQb6yNYfbcqU29YZs8AwmX?=
 =?us-ascii?Q?zI2isdFjClYHKoAW0xTGNutjDBqjgN1/JmrdQjs6eB5GkHLt7Xh9fohZM8s1?=
 =?us-ascii?Q?Ve1KoUoK1LD74s84NkstE7avUUOThDrja32xJ5Aas5KcCfWmHZjMibCfk9M5?=
 =?us-ascii?Q?xEwQBH74Pqdit58BWccFm7Tq2IgS5ivp5HN+P9be8an8hrWLO6P09/ZFfRET?=
 =?us-ascii?Q?EH2mCMIh9FU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR07MB7481.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpOZ4JBUhiSpJCNA4KsqEy1JxdC8EJcPf7xPklPZiiyNN+ofQgVsgtrtmz28?=
 =?us-ascii?Q?iUJILr9hAwC9IdEJo+6mVUOLwxTNsFlUAZpRVSUvVds/8cxhXuvoMNQVyTID?=
 =?us-ascii?Q?vvSm+KSbuEecaLFP62UZhlaQB2Y0AdNb1wdfMfhl5MiY/3Pu0ZNRvxRxAJ0Y?=
 =?us-ascii?Q?i0ZyR0MjpHMTthHtBJ828q8ocJswwPAxQ1AlSKnqpPGftt0codxm1Mp6xXw/?=
 =?us-ascii?Q?3Jc9zkZ8DbcmTW70RqPXX0TbRpY4mbOj/QTORcfGPlTqbrzM6lf6JaHyt4we?=
 =?us-ascii?Q?NCpdUQCNecIA14olGyPY80IEeM1b2GS0sy7BoDSs1mas4P1HYnBzIXMGbGT+?=
 =?us-ascii?Q?1V0ym2QWd2bpp6QYe2rfYFNIlBD+MQPH4YWiZFjp5x6KsZXoic9s9Q+nbwJY?=
 =?us-ascii?Q?JysLhOFzWkyY2kY8pbbdL+qGlMR50Ae9vnUpFdowxHBiLqewN4rATQ9JNVbj?=
 =?us-ascii?Q?Wse4UhbTiJEQq6aWtofKFGaS+RKx9aLJdcS1DsaDrKp0NcCWwsV6P3dGH9aS?=
 =?us-ascii?Q?ujLquUvJevXYCwm5u9sYon4HsBetbG9GMJm9M7BHP4d5lWqpUXvbBFpb+6tc?=
 =?us-ascii?Q?RyiIis2o3vi72JlANjeYn+xTIOtj4aq0Renxr6ZFC0z4KN3iprrh972Ug98J?=
 =?us-ascii?Q?UmL+iTipoNIkx5XcTvYwTEkhCAv7qyk6sMgXpeeGwWckUbTO9eqG9pg53Pez?=
 =?us-ascii?Q?HCc9ErI6zliatYDKlnKg91OFi9Qj6bG1fjLMBYCS4kfiNB8/5t6BkXClwVmR?=
 =?us-ascii?Q?e29TOKFtjO+9lmrtejoyD5JFW133oIWJg2F+X023Y3xpYp9nypfPUjxJDZoL?=
 =?us-ascii?Q?Q0h00erDqHGTA/ck6XOtZaVlbYR+zxyLoaZhZCXZoe3g3qc6aSnoP/DySYfZ?=
 =?us-ascii?Q?0hLQcK6hgdy9YBXqVMo3ozHDUDWgeZK4qFlR30F7tMGkgnjm3fk0tKGUikqC?=
 =?us-ascii?Q?3Qurgkuf0LWsSTF+M/4RRoxtJrkw2WRU9CJNrGy8quybQztksH/0gUStagsy?=
 =?us-ascii?Q?LYK5nCoGH6RjBL8F1rxmGVwAX2mW3GK4Tpp1GJGnMqfAS5CkME5Gacg/VYy1?=
 =?us-ascii?Q?grbeCMcROcK668XSa92tiOumBgf/PBybnQqORJuX2qYOWHkEva6xGMPVQT+o?=
 =?us-ascii?Q?HpLZ7A8XwHMRLFDIlF+QYOYge+5oFqu3pGyVc1/RfoB5bmh8IdiBwWSAJdwP?=
 =?us-ascii?Q?BzgEgUiKr1xbjhjT+Oaa5eiCyJjoGHssYM/25Q+9Tb77Ce2XhiZvRXcD/84V?=
 =?us-ascii?Q?B6J2ATr5/EXyXJriO6kMb9gshmNxFQGbozpy7KNjslcXIpNFH9tWwz8/kYT1?=
 =?us-ascii?Q?fW44KjQ2f89C6qCJzJqenefAfHuDf+Fnsh9tMMCdiPdf0/qYq5faJRoForPV?=
 =?us-ascii?Q?FvspsY/cYvdepMj5/ztqNGTWkNS30R3yCQ57pSVTN47V8hbleSJrfzR00ds/?=
 =?us-ascii?Q?X1jO60XA3W5sKGG6g8nc2L8JtVMMrzx09u+VMHOnuMNSrCvDDiCdm0oiYiLu?=
 =?us-ascii?Q?FU2Zqd4nXsoiO1diy++aUGdxcmS2uoVc/wUqmHpphvD5/nfrCLl/FmQCldau?=
 =?us-ascii?Q?6TvT2MVxHnt5HejsBvaQ2jBjarIaW8GQmAd5h1MiOtsCTEbtPUWGum6+DkvU?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fc30b8-a24d-40d3-5436-08dd7846bdea
X-MS-Exchange-CrossTenant-AuthSource: DBBPR07MB7481.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:45:38.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQFkCK/PU1EXkMaqhKSVVHTph6An2jYYPtOht+4HtYmePl79DrQ1ctv6UQkoRWAo0+tHcmhpm4RzFWF0HgCp79pE1u9IOK/pxS8GehDuruM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10210

Rtw88-sdio do not work in AP mode due to the lack of tx status report for
management frames.

These patches put management frames into the right queue for tx status
report and ensure the correct handling of tx reports.

changes in v2: have the right queue as pointed out by Bitterblue Smith

Zhen XIN (2):
  wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally
  wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT

 drivers/net/wireless/realtek/rtw88/sdio.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.25.1


