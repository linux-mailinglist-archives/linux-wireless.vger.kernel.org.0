Return-Path: <linux-wireless+bounces-33337-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBuuMrQbuWm+qwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33337-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:15:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D32A652B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD8730649EA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95A35836F;
	Tue, 17 Mar 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="nnn9UdjC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011025.outbound.protection.outlook.com [52.103.33.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF603563C2
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738676; cv=fail; b=SAnIpQG2MQ9pSaiVYZBkruOu/pF5365gdd4raY7yFHu/G5q52aZS/tTBsyF7+3sgfaKTBwI9kxdBfMm7NF3MLcFv1cXpA4uBVtLWrs9nO5ZC8+r9pg/eX4VfzBpKcbxQxohePY0TE2b2Z7+bO4hzGb1V8r+RGT/i28XSNeym1nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738676; c=relaxed/simple;
	bh=/vCg0CPyXJgCR+CatD9V+e3663raYc/8cAlSZozDrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2gvXZsIeAwng3H+UMu674dqTsQb4o5jsblTQKvjfGcwYM3aZKAlh+paX2I78xYjXCCgEE6tpYHci22IlgQ6rmjjsAify96viqXR7P5NWLyTNOPYvXbBfs8kLzcFpCeo61vcKyIVcbzJbobQp+033MCuyhNc/D+/CtdsMSDX90Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=nnn9UdjC; arc=fail smtp.client-ip=52.103.33.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgsVJgi0eMsH7AekzL4NgBDej7kuocSZql727K8spDeEuV2SgbjvbrJgI9Yplphxqy2N8Qy5q4no+oyh1tGM+RuuU1h5QsYPAK2WqvnbqLkKC/t0kIrKDXN5VIe5gVEkePqPa0mw5ed6FvMVNsox/lIWFZg5+B7NeMkJF4B4sYrGIvYrer9CwCkITMS6DL5wDpD9idbqnVMCUeuQe3iSENVW20Oo0oAE3KRBThuNuqhaGexZlBZsJxWyU9i6xKtTOqUCF9aIm3yVqrejPUFh5UrZhbHckujlYtDTEOgYTNgF1K7h5gxyZOKKxl+rE6i8kM99TXOUmgyK0EGVZbCpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2t51eYGJi9DOiP7AHfETl8ErVLUuybRap0DwPrqeRA=;
 b=sggMqGCb1ifrjjXyRJ/tr6XwxkqUKgGHntucU9WkN2PWEgigXD/1AtUqi8JYiOw5tVkObavwHHEP+fxRFIILP8p7xN9uhZcEBndVoRB/hT3U2vxuKFZ4pL1xa6UtHBAeWLc5C/qGH25HC3YgVAlTmSWCP7M3xuDNLBwBo3IYZMaF4VXdf1etTPo63T86SxDjng5avC7RSqEUmrXVnv+JMgLvRqhwNfk20Sjn9bRuHeiXxTNszXFt2W/CQiX21VmWqS2jXiayg6zEkV3dP8F9SWQ6RLcXE9gKILUngCY4Fbhtgeihf6MoV7RCA7sAZReeim9BgGV2Wf9wtUUZUGLYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2t51eYGJi9DOiP7AHfETl8ErVLUuybRap0DwPrqeRA=;
 b=nnn9UdjCg6OwESZncEF8WewzZtnAa5xXqhuYraATuIVnf07h9pwM6/FzXkCvMikH9/lbGLqTJB5cpgZBx3Q8mFg+i1yy2nfjdj1yGCshPkEzw+YcEBTuFdUKLS/nMO9WqsxZAfLjRDbFHUC5T6wXyM+AKGT7O8oDuL/54CicTkav1A/mM5fJE26FSi+k9S2BumjXBHQlG8GVaHamSzn3JdF8s5V+ywL/Rvw8mCwcWiGBe/Z5259CKz0dCe3d1CAEWPW/xbpsrcFl1/ABSMQfgd+CGzWtctKucaznmhjtslCpw5YqU16ska0gZXAQsXBqwGQAn9sjgryXUut1JrG/nA==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PAXP251MB0579.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:284::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Tue, 17 Mar
 2026 09:11:12 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 09:11:12 +0000
From: iamdevnull <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 3/3] carlfw: disable buggy PSM to prevent USB command timeouts
Date: Tue, 17 Mar 2026 10:11:02 +0100
Message-ID:
 <AM7PPF5613FA0B6CAD9AE8898D13A62F8CF9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317091102.23894-1-mas-i@hotmail.de>
References: <20260317091102.23894-1-mas-i@hotmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317091102.23894-3-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PAXP251MB0579:EE_
X-MS-Office365-Filtering-Correlation-Id: bba22502-21c3-4c53-742c-08de8405225a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|5072599009|461199028|41001999006|19110799012|8060799015|23021999003|15080799012|3412199025|440099028|12091999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VENGNlFGWS85ckRQRTMwQmg3UDVjakNrTDNhSVBPTElhVHFweTFLTnRrYlJ6?=
 =?utf-8?B?RXoxTllZZktMRllhVktUd21FM1pSaFlnWFdNZ0RZQ05aWCtYaGZpNGtxV3JT?=
 =?utf-8?B?VEJlUjU0RGxTcmZJREJMWFpqTzZwRlpsVmFYWjlYZTRmVU1HeitNRm5Zd3Ur?=
 =?utf-8?B?ZU9mZDc1Nmx6ckVVbUREcUdwazZYZ1JpTmhSZWlJUlBrT2FWQjNNNHB0cy9u?=
 =?utf-8?B?dGpFY0V4cmFkOHBEVWV5eFhsaUdOMGNML1QzOFpHdXBYUmVnOTNZNDFlUEpY?=
 =?utf-8?B?SnBJUTlhTkplV29FUGhRWVhSL2t6KzJZVTNQeUs0LzBML1FoK0I5cm8yeThV?=
 =?utf-8?B?ZzAyeWplWjJXNENjaW9zRnlKUHFrV2pZb3pzZmxzcUVkS256REtYTHk2M04r?=
 =?utf-8?B?dHI4UCtCUmdOcXdkYUFubzhiRVBRS0hxZ1dZSlV4bkl1UDg1eC9jYUxYN25W?=
 =?utf-8?B?VGU0Z1Z0d01MZWhjQmM1cnhZeWVOa2g3UzVRWHR0RExKV0VPUUo5RXdCOGVl?=
 =?utf-8?B?TDROMlAvYzFMamFXYjNJUGxzVDNtdllzS3NvcjJDNEl5OTF4cnhHdEZOdFFw?=
 =?utf-8?B?Z2Jpa0Z0WDJXaUZPeTJWcGNURDRqYmc2bDNaOTFoM2hHVndUZm4yVi9EMUdR?=
 =?utf-8?B?TWhtMGlJUk9wOU4xa282eUdvNUg1UkNjRE9vVlgyNzBPNENuZTFLbTlZZGtD?=
 =?utf-8?B?Y016ZTdYbGlsdTlSelFoRW9Qc0FvdmVJTnJLaDRjTmhyR25Xbkt0emFaNE9z?=
 =?utf-8?B?bUhYMThYK2ZzaGZhL2hPT0R2ZUhhcEJkN0pBbktydmFDblJHR0ZuYzROa2E2?=
 =?utf-8?B?eER1Yk5YTXlZbHFNdkNaUVNOamxUTmcybmhOT3JTWm5DUkQrdkd2MElFUjNW?=
 =?utf-8?B?TG9QRVNDQmJYeHpxM21PM0wrVlRMc3J2MkpmRnVYbWJZR2hCM1NqUmJYTi9n?=
 =?utf-8?B?aHA2TlZQK0dQNVNQWXR3Y3NZNkFtWUxUN2hQZ2pZK3o0V21LbDdYTnFXb0ZF?=
 =?utf-8?B?MVBndlFJRnJOcXo3azB1eEZtZ2RxejM3cHl2Q2piMmI2bzhrSDRKK013bEhG?=
 =?utf-8?B?Z2NGalB0SHJQVzRNMzBRd1lQUnFGbnNIbUhmZ2pTZXNaOHJSUzNocXIzWlN0?=
 =?utf-8?B?QUhmS1V5TDhnL21LOU1OdXNQWlkrN0REbnJzaGFucllVaEtHR2taQlFEeXFI?=
 =?utf-8?B?SnJ3eGNCcDE4UERPYlQ3VlREMnNPVXE2cHpYRkcvTnQ1eStqM2RabVZuM3J6?=
 =?utf-8?B?bWVFVjFDa2pVSHpldjhUYzBsL0NTODBVazNkNmkvVjRFOTMyZ0hzNU5FQTVS?=
 =?utf-8?B?ZWVNU2c3YUdVeGQwYlBTNkFFVTdZQW9odFBqT1l6Q3RRSk9PRXVhNkhCOGJp?=
 =?utf-8?B?VjdqOG54bXJ5R0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUlXZEh2anNBMlVnaGxFSHJIU256MkNoZ1lFWThycGdUQ3g5ZndmcVNtYnpP?=
 =?utf-8?B?b3paT2ZPUWJoWURjRVRsS21hRG1pamVwUGdEcmlGbW4xUkVrMnV5QkJpQjBL?=
 =?utf-8?B?L2YzSk1vWjZNNFJJVUFDK2d3eE5ha1BKTjNJd0tEeU50YXk5WHZ6b1laRlFL?=
 =?utf-8?B?aHdaYUNacnJaY0tFN2JPR1BaYU9MZGY5Z0lxTThiMytpVmlSc1FLcXlScDEr?=
 =?utf-8?B?MXgzT1AxQ2tWQ3RHUWdHRDFaQVB0UzMvbG9xenA0UEpoWk5ubmc3ejJDUWlz?=
 =?utf-8?B?NVFpTTJKb0pPejNpWVUza2NuYUV1SDlzK0NmampwbU80U09hR3YyUnJSc1R2?=
 =?utf-8?B?aFR2Kyt4YXNVUzM3S0lteityZFlMMmRrano4VmcxNnFKU0lFZFJsN3Zhenpq?=
 =?utf-8?B?TWZkcW5FQTRtSFkyaVpkbDRtblNHd2ZqUzJtV211YWFvN3B3bFMzcFNrTm52?=
 =?utf-8?B?dzVHelJZN0tGS2ljeU9uVS9nLzF2ZVU3RWpBM25uNmdqT3dvSmZ4NHovdjBW?=
 =?utf-8?B?bVJiV3B6d1V5bThHV2hJTFpIcW9haS9qMXQrYVZrOU1tRDRWelg4NnNBdmwz?=
 =?utf-8?B?Mlgrc3ZsTC9MblJlMWxNMzZFNk8vQzh2d0RGY2lSSk1KVmxjT0s3aHhvQS9h?=
 =?utf-8?B?clBOSUlGT1M5ZERRcTE2QklSRW1CdStsMGtPSmk4QUZtVmFrU2pMTkwyK1pD?=
 =?utf-8?B?aVBveHp0emJSenhzYXpiZmwvUGtJZU9hMDVFYVMwQWMrcHl1VmZiT2czN0do?=
 =?utf-8?B?UzRBalhGWVJYK0NDYzFiWk9jNGhnSGFkTU9zNHVsTHRaNmQ1T3YzODJJUU85?=
 =?utf-8?B?OHl2NnZsMUdQWXdVeDB0RkRVL3hsODJmL1BzQmdtRnUrbEJ3ZGZjUjVpUzQx?=
 =?utf-8?B?bVVmU0RxSUFUNlVuUW9aQ3REVmpxbG0xODA5bkwwYTNBaDJzbTZjYXFHbVBp?=
 =?utf-8?B?NTJnci9qakZUTlZHeXBFZTBLeU0zQWR6QTA4MHcvQUsyUXkvdGViMGtJSU5W?=
 =?utf-8?B?R1JRNUdhTUw2Ujk4MlBJbFh6Z2FlVHhTVzQxb0tKUTVBeFZ6d2FEL1JvYnA1?=
 =?utf-8?B?RklPSHZhWHhKRkdFL1F0aFJuYkR6QWNralpheUliME4zeEZuZ29VMjcyeFhC?=
 =?utf-8?B?Y2dCckxhZTl5Wk5sSWZ1Wlpwbm92aDlmSGV4d1lhNklJdHZPNHhybkdRWUFP?=
 =?utf-8?B?ZGlIYVdGNi9XUUJYdExzdW5Yenl4REdVY1Bra2x6TGFmcVZ2K2piaHJWVTFi?=
 =?utf-8?B?ZjJDcFozTlhjb2o3QTRlblBrS0FrTCtIUStEby9oRXBKa05DL3BsNGR1UzJH?=
 =?utf-8?B?ejFsUVhTaVIxZGRNS1JkYVFQaUdiZkNldXlsTDNKS0t6NXZoNjdBSmpTSFNr?=
 =?utf-8?B?OTZ0NUl0dGtiRFBDOHRVNk5sc3NjUjZpSlB5dndCUVVrbTZtSUI0ZnVWTFVx?=
 =?utf-8?B?NkR2YmNPUjQzVU1oUXNyOVpuWHhkWFNlaDJnSVRIWVd4eVA1cGovM0FWZnFt?=
 =?utf-8?B?M096SGhnRmxPME1zRjNlQVdPLzlKZ2tzTm9BRlJ4Rlp4S2JaK1BCVTVtSTJ1?=
 =?utf-8?B?OE11N1M4RFhPYXMxQVRvUThGeU93VFJBbFhjeDdUbjhUZTFUWXdtS3JadS9X?=
 =?utf-8?B?U2ZlK0tCR1lzc3B0T2thUGFoRHorYlAxclkxUmNyRHlIeG1STmxIc2RvbHlo?=
 =?utf-8?B?VDViY1hOb1NZL1JHMzcvejV6NjZaTDFJcWhqTGFmUjNBcTdzb0liZ0VmcVZy?=
 =?utf-8?B?bXd4blVQZ1lGc3BEQi9QMVhuVFRuTGFkckd2UzROakZZbGhHTGdEdFNGRTFT?=
 =?utf-8?B?ZkFOL2l3ZmNzRWpCZTRKZk5ZZTBWTzBsTHpJbVhRK2tLdldRWThzWlVTZnla?=
 =?utf-8?Q?1DmfOCK3UrwMc?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bba22502-21c3-4c53-742c-08de8405225a
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:11:12.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0579
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33337-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,hotmail.de:email]
X-Rspamd-Queue-Id: 375D32A652B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Masi Osmani <mas-i@hotmail.de>

The carl9170 firmware power save implementation causes the SH-2
processor to stop responding to USB commands after entering PS mode.
Powering down the ADDAC and synthesizer via rf_psm() makes the
device miss host command responses, triggering -ETIMEDOUT (-110)
on the host every 45-135 seconds during normal operation.

The kernel.org driver documentation confirms:
"Power Save Mode, It's implemented but buggy"

Three changes:
- fw.c: remove CARL9170FW_PSM and CARL9170FW_FIXED_5GHZ_PSM from
  firmware capability bitmask so the driver never enables PS
- rf.c: rf_psm() early return — never power down ADDAC/synthesizer
- hostif.c: accept but ignore CARL9170_CMD_PSM commands gracefully

With PSM disabled, the adapter stays fully responsive on USB.
Tested: 0 crashes in 180s (previously every 45-135s). The host
cannot force PS on even via iw set power_save on since the
firmware no longer advertises the capability.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 carlfw/src/fw.c     | 6 ++++--
 carlfw/src/hostif.c | 4 ++--
 carlfw/src/rf.c     | 7 +++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

--- a/carlfw/src/fw.c	2026-03-16 23:38:46.184137155 +0100
+++ b/carlfw/src/fw.c	2026-03-16 23:38:59.714232929 +0100
@@ -48,8 +48,10 @@ const struct carl9170_firmware_descripto
 #endif /* CONFIG_CARL9170FW_USB_DOWN_STREAM */
 #ifdef CONFIG_CARL9170FW_RADIO_FUNCTIONS
 					BIT(CARL9170FW_COMMAND_PHY) |
-					BIT(CARL9170FW_PSM) |
-					BIT(CARL9170FW_FIXED_5GHZ_PSM) |
+					/*
+					 * PSM capability removed — firmware
+					 * PS causes USB command timeouts.
+					 */
 #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
 #ifdef CONFIG_CARL9170FW_SECURITY_ENGINE
 					BIT(CARL9170FW_COMMAND_CAM) |
--- a/carlfw/src/rf.c	2026-03-16 23:38:46.188101929 +0100
+++ b/carlfw/src/rf.c	2026-03-16 23:39:12.970421845 +0100
@@ -237,6 +237,13 @@ void rf_psm(void)
 {
 	u32 bank3;
 
+	/*
+	 * PSM disabled — powering down ADDAC/synthesizer causes the
+	 * SH-2 to miss USB command responses, triggering host-side
+	 * -ETIMEDOUT and device crash. Always stay awake.
+	 */
+	return;
+
 	if (fw.phy.psm.state == CARL9170_PSM_SOFTWARE) {
 		/* not enabled by the driver */
 		return;
--- a/carlfw/src/hostif.c	2026-03-16 23:38:46.192102245 +0100
+++ b/carlfw/src/hostif.c	2026-03-16 23:39:27.262628301 +0100
@@ -285,9 +285,9 @@ void handle_cmd(struct carl9170_rsp *res
 		break;
 
 	case CARL9170_CMD_PSM:
+		/* PSM commands accepted but ignored — PS is disabled
+		 * to prevent USB command timeout crashes. */
 		resp->hdr.len = 0;
-		fw.phy.psm.state = le32_to_cpu(cmd->psm.state);
-		rf_psm();
 		break;
 #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
 

