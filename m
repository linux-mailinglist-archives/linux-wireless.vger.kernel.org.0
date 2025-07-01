Return-Path: <linux-wireless+bounces-24708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46960AEF164
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EE83BC1C6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6BB26AAA3;
	Tue,  1 Jul 2025 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E6SR4wu0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012056.outbound.protection.outlook.com [52.103.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50751E515
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359181; cv=fail; b=cZwJoTBMPRzrHv13UgAADqIJPLPdewk1kjmYlYyKiwqYZ7L98adGbTMCPVi/MbeEvLZzCLqR8529Ijd7nLw6AozalBvckmMjQrTJYmnXRJ7apTECTutOrzB8kd8dms3Qn6lNX1iIBD/xeyY0u3PsKH/KCRidvCz+hp9KzaH+CQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359181; c=relaxed/simple;
	bh=WMO4LrLXjpqT5iT1sxzILnQ5/vKcFvSnX3xobRVWP6Y=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=oWvIRjsiV6Oigpw4JR9i2IMyfygOxizxsFVg++2gUcia6RKxlsxuYdzRrdI4KORWCOW9sp/mG6GGSgXl4N1G2MU51/m1jJZ86VczQYfypPIBF9o0MMaTHi+8qHItuYk4tcCFIQ55N7HveVvQo3kpaPLii60hbNSZCSJfKBG+uSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E6SR4wu0; arc=fail smtp.client-ip=52.103.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxal633IJmpvIE2zgOofBPKhphF/Mz83dDXN5FnDs+jZBKXOd9uTKqFu8w43xVrRWo2isw44yYLx6ZSUuyobQpdU7MJ3tFwzLfikmrbHY9BcR2IygYcNNhwy2iCgW0kQVn6Zs0k589nfLlNdZT2FGJ4QD9b8k82UPw2glzN85dTOIm12il8hif7zWQq8/RLuyDoKheNlgrigpyMCqRx5UF25ybOqSZl11EZpw0SxTVPGJd2Sf5IAoGhSHNr7FfkKISBkEhDZObSgRsgQR/iW7LRUBZWMKSab8gLsPM3+t4T3GHl9RY0ViB59/SPrLYSFvWqHAYonpUOzJNnku24gnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TbSnK7UK54EK7sE/UsUlELmf9PB10TPr2dCGhamTgM=;
 b=P1vT6YktdSf5/Kfu6dC2z1L1FpKAdf4r63Yot6Atc7O3FmTdDYtcz0iCqPxZA0Wpmt6jB2Dzguie5b2oxE7jiyrOtKMLNiVMe77jMnm5ddeQeVfffzorP1nvMYNvRwOPWa+YqBaCdjCmOiIlPgHa34wO88WYTJTtwIUhDKPQqikwF+IFxexPBzph3zYegDNghzXkfFiSPpUItKYERUIBGYu42ApvFJ6rh6Y7HR5g182jwGOVFpGEN8L/MiTr+XkXCk20SADt9It4mvebDLHGMjVTZWpHWF/fIUlt5qS3a46Sng1ynpllp2ace9h8C7QQwBMYfUMzvN0EOpX6ngDWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TbSnK7UK54EK7sE/UsUlELmf9PB10TPr2dCGhamTgM=;
 b=E6SR4wu0KLDGUNuDmjn6X0Dg3S8ach43frWVOb6caq2DijxdgWdRsiM5pctSFr5YkxtZ/P4NMprPO4N9LRQQpB6paD8ko3+TfgXWaydmRMOD2DXHsjhfclyhExbjmCwr2iuANrSqZw0ulPpnnw4p5B/N0aRG3Yi4v36rtJpCqCxXvEe/SG8TOb7u7z/3egzQ7APAT6pvtYBu5JRah2qpkU+1YnBc6ziRQ9Bz21bl8quNRZchRGS7qnYIMAKLVBv0UW2nxGdKRc4DvezqCbe6kq5ckvq2U5fuFecdCuJnja736fEQPkPsb7KskVOTA0DzYnQIhm9LgBeAFpqbbNATYw==
Received: from KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::7) by KL1PR01MB6014.apcprd01.prod.exchangelabs.com
 (2603:1096:820:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 08:39:37 +0000
Received: from KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 ([fe80::179c:9f8f:aa5c:d0d6]) by KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 ([fe80::179c:9f8f:aa5c:d0d6%4]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 08:39:37 +0000
Message-ID:
 <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
Date: Tue, 1 Jul 2025 14:09:34 +0530
User-Agent: Mozilla Thunderbird
From: Ansh Gupta <anshgupta1941@outlook.com>
Subject: rtw89: RTL8852BE Frequent Bluetooth disconnections and occasional
 Wi-Fi dropouts
To: linux-wireless@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::21) To KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::7)
X-Microsoft-Original-Message-ID:
 <edcf8079-2bba-481e-a217-15fd26eddba3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5322:EE_|KL1PR01MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef677ca-65ed-4f7a-8f93-08ddb87acfcc
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBujf37DYznKa5+FVAZR6NKDtSjbVZOxoi1Nw+nK6KKkGBrNkJTzc2T+LST4tNEAzx997OR/FvKRYDDxNaqIzurUAK6fKxdT+6KlE1Y3fwN7RH1P8I7LC3pluZRIpBdxYVc4JyqqW94ZBvfAsUURlA0oXho8MF5l+LyPCLzOAI33LuV91a3winCNdanail03Lz6PQjw0R6826jIUHFEuzZM4xNTAHwhRuO6QNN7vEt2GuJFa749I5cRsqK0iFedicVH+BKbTfiuN2KAk266bfww+KFJ2PAQAwHf5J/tm/Sb6a2BmqrHJsOjsHP0uW1dz4RLJYV9niSh4kJSQSahbt5dnj+fpmnKTFOwywnDdG5TJ4QdAwb6VU2S9B4PX+10bPv1G8VLkIHNBut6qteHzMF+/X5iN8lIEkJaMWZ77Giwd1Kp2s3e2oVTjoQg4J24N9T4BVAmbGXmd5VJlWycgAfKpccleCNjP0u/W9l7T/Z5I3ZTkLcWHsRDuDx8iTFMFIOB4k3f9smuv2hyWu6OzK31Yw4v+5TP2gZc215STvRrAKNz0CBPtPT3ig1/oUcVGvlNawXzc7oHMUmhq3P+fTF5F1ZNVMRs+t+/kt+C2SNleT8k8DmhUMgxJ6MGdeOT4LNOkx6buQQbdYK5VsLrM/5wjAcVRQ2I5iIL2utPmCM0SKD+1orr/vsboQ3/pUp2O0OkUNRJkUmIYtXfHzN7DcJEL7yiKQyEd1bsXG8TAbSJUItk3Vf5OA5sxeJWfazj8KmD9gV4Nh36/K5By1Na8HKpn
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799006|15080799009|6090799003|8060799009|5072599009|39105399003|3412199025|440099028|40105399003|51005399003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVhWMGdlRW9aR3BNZEtmVVZYZDlHc0hwSlE1NHl2QXA2ZGc3SlRJSzhsY2xR?=
 =?utf-8?B?eUlEdithUU5mZmdua0h5SS9uZWVGWjBOQk9sRHN5ZjcwNjI0ZHFadUZtME1G?=
 =?utf-8?B?UXovMklEelhMVnptOWxVemlVRDZsODVUSi9HbGNsZ0hETUluWUdEQlg5T3p6?=
 =?utf-8?B?cmZscjNLK3VGV1M4eTdCYTdIQXRrRHU1ak14UlJsQzMxaU9XQU5Xa0ttRVlj?=
 =?utf-8?B?T1VOdkhkQlRxL1d2TnpMOGZyYXpzSHBGQ0FMNlBvR1RMQ0lBcVorNUtQNDlr?=
 =?utf-8?B?UThCaTRmRFRWc0ZraVFxN284QzFkd1ZsRWFEYzlFcC90VnRMZHZzY0lqNjFC?=
 =?utf-8?B?elZmNXRyWlhCcFhnTFFGb1AxWW9oTU03TWdSN2VoVlNxcVpCY1ExaFcxQTFQ?=
 =?utf-8?B?QVFVY0FDZ05WelFtOWxDZzVxdk1KNmUyblFGcmQvem1kWjhobWFUUTFKUDNj?=
 =?utf-8?B?eVN5OHJLUW9TUzFQSzU5NU85bmF6ZTNzclVCcDMrV0psWkQyT21HVkx2eDhI?=
 =?utf-8?B?RkJnVUNsWU50VERIdWJ2ckdZb0JUYmNOS1NWcnhDc2JBWVhDdmtqbUJLQ1lt?=
 =?utf-8?B?QXBRdW14UlZyN0ZhQlQ1ck5ua1V6a3l0MjFIL2MzZThMbkRUem84MDgwY0wr?=
 =?utf-8?B?MWxUTXJKTEZNNm5wKzRXRHRWN2h0N1pRbStwNVRUNEhXWURPcmMwRGhDMWFu?=
 =?utf-8?B?MDVablZYSGJFN0ZuTTBEd1hCL1VqOVBRZENsNXJRQnBkdm5BVVcrU3ZRQjZs?=
 =?utf-8?B?NDBBRzBDcTdiZm8vVk8zSjFwQTJoTFBsckNJM2JpT3R3TE9EVXhCSzFxR3BZ?=
 =?utf-8?B?bm5aV09KdjBoWG5ZLzgrTHJ1Y0ltYi8xS09OWlVQa2J6ZjdTNitFMllwdFNR?=
 =?utf-8?B?a0YzYjU3dVk3ZlVEZDV0YndjL3U1RGRaL2lyWERpWGVMSmZKSGM3VHRWeE9p?=
 =?utf-8?B?TXlUM2lsbzhTcTJvekN4YmR5bUNzbkQ2L05XS3I2RnhxNjdPQjJ5b1lXRXlo?=
 =?utf-8?B?a2s1R0RqMVo0Znk0bkk5T05ySXpNVlZPK0k2bkV5Y3ZJOGRKMFdMSThvMWxl?=
 =?utf-8?B?dzY0Q05MSmJ4Tk9RdzQxMVIwMUw5U1hBd3ZyMlR3bkpMNmFKVVZCN0hmZ0ZQ?=
 =?utf-8?B?YnhSZk92ZEFuMytiS3JobDRhTkNaTElSSUI1OGptbzhQcjJSNkRtM0sxbDZ5?=
 =?utf-8?B?bko4elZMSHRGVkpwUDZMOTFqaGtQS3FpTDRHQmRuUkNRYzdsbkpCakVwd251?=
 =?utf-8?B?enY3L3QraWZBTFArcExhTDZCcVd5Nm5Od3VlTFNDSU8xZWFZeDBmL3ZOWDVP?=
 =?utf-8?B?N2JuTWFpTWZpTGlMVGJZQnVRL3hkQlhhNThYSzcvdHRUeDFzWUpQSDR1Nk04?=
 =?utf-8?B?QXJyLzM4dk5TUStHdVdxTDJpTW5hYWdtdko5NUF4SW53Y0NUMFNNVVZia1dM?=
 =?utf-8?B?Qi9meDdKTFA1b0sweGRTZjhOQVJJQnJWd2JSK01NRnM0SWhocnY1MUNFVlht?=
 =?utf-8?B?enBtSFlyZGF6MkdhWmxIYjJZRkt3RlBWdWZXOFFHcnMwaEh3YmNNRnJRYjRn?=
 =?utf-8?B?dEV3VUtGRWJPZDBOUGdoQVpnYlZPQTNpWThyOHFoWUF3dVl5VGxiMmRmeGJo?=
 =?utf-8?Q?Qt6PDJuMmceEey5qcwDqr0YiqWz+abuT33/p8wL4wFg4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtTTVNKYnkxRW8zNlN5YXdoelJ3STRJQVI2bHJKVU82dUxFTk9zb0c2Z1Bt?=
 =?utf-8?B?NUdkQndCeE9ETUsxaTJhMVErUS9TZG1zWlNGQXgxMkgvQVc2cE1zdE9VaTUv?=
 =?utf-8?B?WFdTMytIL0V6QWNkTXFLMGdreGpWb0R5KzV1ODBWL291OFJJbzZIcXUrcnBj?=
 =?utf-8?B?UWw4c0JLd3ZPajJDRys5a3VSSy9tWFZqNFNJNnRhOW1zYkxzakpiZmp1SUhV?=
 =?utf-8?B?U3orajFNdDhsU2xDU1hvQTNWcEtJeWFFWVoyRndXVEZzR0h5MW5xRk04OGRk?=
 =?utf-8?B?bGJRTmtTbUlldldJUUhoZzBUV2NVdFFjeHBpUnJsZ214MnNNS1VhYmw3ZGlh?=
 =?utf-8?B?Ti9rSExtTlpxMDk1MWZQOGNFY0ZRc2tiL25aa3NrTDBYRE43aFgrK2NHN1li?=
 =?utf-8?B?bklpRDhFR0R4SjlRWnZZNEcxSEp4UWlrZkpZbXZzdkJQUU5XdTJueDZMaGQw?=
 =?utf-8?B?NjRrN2JoWlVLazFwOFRGZmk5dTg2M2IvQ1laNUVnMzlJRGdNUmZRcHg2ZzA2?=
 =?utf-8?B?RzFhOG16UFczdTJibDNBcU1MVEQvOWZ2a0g5N0x0bzF3anM2VlZwOTVlbUdV?=
 =?utf-8?B?RWdnNk91N1FsU1pVTmNWdEd2TlBVTEY1MHhuTk1zZHlBVWhxME9uK3UzMmQ3?=
 =?utf-8?B?cGdIb3NzSlVnQllpMjJIRWRuMjhGbmdSMjNOVnU0UnJLRWhzbGk5cXNUemVV?=
 =?utf-8?B?WHVPM2NCRWF6UUZkYUtTSUhNTUJWNmprbzdicDJkY1R4ajhaT1NBYllaTWs1?=
 =?utf-8?B?SXlFeWwrOE9sUFpNYThDbUlHazJvMkpWbWY0UkVueTJ5aHloTWN3OU9pOWdy?=
 =?utf-8?B?RGI1Q2phWkRNNnYwUVlSNW9wajlFektDenRtNnBKNG9CeElQSmltTVNUajdo?=
 =?utf-8?B?N3JzemxlTHZvcDMzOXowVjE0L3E2OFA0NlBNd3V4ZndheFhtQVdiMmUyR2lu?=
 =?utf-8?B?WjVnRHNpd1N3bk8wanFRdnNuVnVSSGVPRzFWdWN4ZDZUVFcxOTdIN1h1cmJn?=
 =?utf-8?B?eHpQR2RXRzNlOFZXdGduTXppb0xFNWNSVlNNb0U0M2oxcWxqSkVSRnJDVytB?=
 =?utf-8?B?OUdaODBZQm1FQy9mUnNDOS9zNnoveGd1WGE5cSthV3ZrUVBrenBQdnlVYTZD?=
 =?utf-8?B?VDF6YStJeG84ekJadStUbCsyTjFNY2NYL2pvRHdjZVg3MC9JTkZmNEVDMnBW?=
 =?utf-8?B?NFlxSklveDlCK3Q4MVI4VjBYRWZOZGlEZFhFTThYVUhCQjVMK0N1dDhzYzVJ?=
 =?utf-8?B?d2dKWlRaV2RCMXc5L1pDbjhnZFpFNisrMDlLY2NwTnUvUmt4U1NwKzBRc25u?=
 =?utf-8?B?Zk1Qb3pMamtQaCswaUpxTHRjVXlDclNJbGV0ZjVYWXVSWlRPUW92ZERka1c5?=
 =?utf-8?B?MGUwbW9hMEsvdlhUSjBMc2d0ZUNuRFVzMWIzUXIzWWNIZjR4a3VBZmJRNlQ5?=
 =?utf-8?B?RzM5Qm9MMlVsV0NzOGNvS2o5N1F3TFNPRmJWeHd4RExHbVJnSmZPMzRFcmRX?=
 =?utf-8?B?U2xzYjFwbTl4QWhuWTIyaGtBdWxzNjJzb2svRzFwZ1NBUVZVK2doM2VMZkts?=
 =?utf-8?B?ZUpXeXRYeU15R0JHYVdzcHBOR2lOS1MybnBnVmhxaHRYcFVpZTdzRXhzamJo?=
 =?utf-8?B?MFJONzR0K0ZsQUpsY09hNk45NTUvWEkvbmtLN3VicVNPV3BqVit5TkljNDRY?=
 =?utf-8?B?NThFQWNaL1YxSTBKVFAyQjRmNXdLNURsSCt4czZRQ2lZMGs2U3JzTkNzckgz?=
 =?utf-8?Q?hEKg5mc/NXy0sVJQ+ngNRYAugpIqQ3dvBbUXyDp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef677ca-65ed-4f7a-8f93-08ddb87acfcc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5322.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:39:37.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB6014

Hello,


My Bluetooth earphones frequently disconnect when no media is playing. 
Here is the scenario to make it clearer:

1. I connect to my Bluetooth earphones.

2. I start streaming a video.

3. When the video ends, I choose another one to stream.

4. As soon as the new video starts playing, Bluetooth disconnects.


A few related things also happen, such as:

1. Delay in providing audio output from earphones when a video loads,

2. Slow network (with bluetooth on), due to which I could not stream 
videos without buffering every 10-20 seconds,

3. Occasional Wi-Fi and bluetooth dropouts at the same time.

The available network connection point(s) uses 2.4GHz band. I have 
concluded that the earphones are not problematic after testing them on a 
Windows installation on the same device and on my phone.


I disabled power saving features as mentioned with the driver options in 
/etc/modprobe.d/rtw89.conf, which did not fix the issue. I went ahead to 
toggle disable_clkreq as well to see if it does something, it did not 
fix the problem either. I toggled disable_clkreq to N right after checking.

$ cat /etc/modprobe.d/rtw89.conf
options rtw89_pci disable_clkreq=n disable_aspm_l1=y disable_aspm_l1ss=y
options rtw89_core disable_ps_mode=y


Additional information:

Using EndeavourOS


$ uname -a
Linux ansh-hplaptop15fc0xxx 6.15.4-arch2-1 #1 SMP PREEMPT_DYNAMIC Fri, 
27 Jun 2025 16:35:07 +0000 x86_64 GNU/Linux


$ lspci -knn -s 02:00.0
02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. 
RTL8852BE PCIe 802.11ax Wireless Network Controller [1T1R] [10ec:b85b]
         DeviceName: Realtek Wi-Fi 6 RTL8852BE-VS + BT 5.3
         Subsystem: Hewlett-Packard Company Device [103c:88e6]
         Kernel driver in use: rtw89_8852be
         Kernel modules: rtw89_8852be


$ lspci -vvv
02:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE 
PCIe 802.11ax Wireless Network Controller [1T1R]
         DeviceName: Realtek Wi-Fi 6 RTL8852BE-VS + BT 5.3
         Subsystem: Hewlett-Packard Company Device 88e6
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 82
         IOMMU group: 11
         Region 0: I/O ports at f000 [size=256]
         Region 2: Memory at fce00000 (64-bit, non-prefetchable) [size=1M]
         Capabilities: <access denied>
         Kernel driver in use: rtw89_8852be
         Kernel modules: rtw89_8852be


$ sudo dmesg | grep rtw
[    4.354259] rtw89_8852be 0000:02:00.0: loaded firmware 
rtw89/rtw8852b_fw-1.bin
[    4.354439] rtw89_8852be 0000:02:00.0: enabling device (0000 -> 0003)
[    4.364330] rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.8 
(39dbf50f), cmd version 0, type 5
[    4.364341] rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.8 
(39dbf50f), cmd version 0, type 3
[    4.642760] rtw89_8852be 0000:02:00.0: chip rfe_type is 41
[    4.672201] rtw89_8852be 0000:02:00.0: rfkill hardware state changed 
to enable


$ sudo dmesg | grep Bluetooth
[    1.226666] usb 1-2: Product: Bluetooth Radio
[    4.099843] Bluetooth: Core ver 2.22
[    4.099882] Bluetooth: HCI device and connection manager initialized
[    4.099890] Bluetooth: HCI socket layer initialized
[    4.099894] Bluetooth: L2CAP socket layer initialized
[    4.099900] Bluetooth: SCO socket layer initialized
[    4.239693] Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b 
lmp_ver=0b lmp_subver=8852
[    4.242684] Bluetooth: hci0: RTL: rom_version status=0 version=1
[    4.242702] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    4.244742] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    4.246709] Bluetooth: hci0: RTL: cfg_sz 6, total sz 57259
[    5.037633] Bluetooth: hci0: RTL: fw version 0x098b154b
[    5.212631] Bluetooth: hci0: AOSP extensions version v1.00
[    7.279137] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.279142] Bluetooth: BNEP filters: protocol multicast
[    7.279149] Bluetooth: BNEP socket layer initialized
[    7.281095] Bluetooth: MGMT ver 1.23
[    7.509649] Bluetooth: hci0: AOSP extensions version v1.00
[   17.799079] Bluetooth: RFCOMM TTY layer initialized
[   17.799096] Bluetooth: RFCOMM socket layer initialized
[   17.799102] Bluetooth: RFCOMM ver 1.11
[ 1636.264340] Bluetooth: hci0: Ignoring HCI_Connection_Complete for 
existing connection
[ 1674.313897] Bluetooth: hci0: link tx timeout
[ 1674.313911] Bluetooth: hci0: killing stalled connection xx:xx:xx:xx:xx:xx


**Multiple disconnections happened while reproducing issues and 
capturing these dmesg logs.


Regards,

Ansh


