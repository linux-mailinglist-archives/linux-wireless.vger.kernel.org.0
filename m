Return-Path: <linux-wireless+bounces-33341-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JwdK5I0uWnpugEAu9opvQ
	(envelope-from <linux-wireless+bounces-33341-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:01:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAF2A8679
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED493069AC6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F63A5E78;
	Tue, 17 Mar 2026 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="DSs9ctEe";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Xt8VgNKT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546903A545A;
	Tue, 17 Mar 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745191; cv=fail; b=Q2VH0USlZcSLVgdcZn+aSMMq3Te8J07LP7witLjpyppMhD0kZhZ8PhHT/NCIQToHGKMKEc2kEHAy2O/IhZYCMW6ZANOUCHjT7acCcEkG8VQLV3EAmYckfgi60c9Ug53pxlIh9Ozg5w1thZjc7gKBgqeBiOXB2c1qZUeNj36XPQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745191; c=relaxed/simple;
	bh=XHblRpdouo/UFtxXx4g8Q9fWbYXIDcp09rwtyaXB+YY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=neUedoSJbnoXbN1Mhjmp9shJmYr4aecmNQzUd6t/0G/1RiwLNR8v9RDDwZUL8s0oNyu14jjBX585bUX0ZHQ4nHEkJxchDcREnN+qyV2HlMmnV3Nw6nd9hLtzBpjzHXI5xIEw164ffOKvSPSBU65/UuvseGobVyabrBrVpnv3ELg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=DSs9ctEe; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Xt8VgNKT; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H5O38n2952140;
	Tue, 17 Mar 2026 11:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=AclzN+Ye/LJqX6rwWfifT6
	+XJuHle4TKXCII0FS67m4=; b=DSs9ctEe4qDX6ddriL6Jp/KMdl8zQRHEGo2v3P
	01z2+07dtdPfxe8TkQIWnCqMXhavvLoKPA0KtHhVqjIvlSU6+VEP8muVWm8Mk3Wh
	BEoAbxaZzlB2zmmd3qsCxelyjAo5BhgY0YInKCc4azfky1S8tjncVNYfgniGqsoC
	eZpKIrll8OzbdvWxsVxXORfCWah1lRU9I3Mx9K3t1ase2ut1fxVjDUf37L6k3fnM
	e/RaSez2hRyZnZAQO1udiIKi4dlEicOzhh8d6qmDl5Q6FNM6hn/RmxcR1GVnZGco
	wMwGW4Q5Uht6gUMhOSTuKAWYdDF4W9SQSo7/kFZ/BYHm0Hyg==
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11021089.outbound.protection.outlook.com [52.101.65.89])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cxnkj0uax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 11:59:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGHbvv8kGwdoDGJgjUOU20lWnzPFoe9kpXrGdVbUq0MqSQcZkNDOdrk1sFCifyEF5KQFyCBkcBJrFQ3nLcSlYKuTloDJ7bu/s4VftoTaHh4rUPxQ9GilPzYvg5yLWR+GowEsZI5MO5CuQrIaBx/8DHyMSwFX7QL0tEpJTi5r1aUZA6jFmS1uPdR2VenwtkqIimepXVLnKSg3aFzVpqOo+vGKDb5gL0QUMFckaGZWfHeJNKm2oYF+FiGjm+Yg6wwhtKRnSomOuAjXX4g9i5siwSsi4n/APUILTHRVHUJ3QoC/2cC3uWQlosjQbrPW8vfWQ4cuOvukURFQK2wBjS9/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AclzN+Ye/LJqX6rwWfifT6+XJuHle4TKXCII0FS67m4=;
 b=XckmyAHyZzcUbSYWqH/dPFSQ3/rXSNgzVI6JOVRolShnGsPwFfUIo9UoEc4IzIdXscZHUna2MEAKdIa6sij9KckCv6eOLNkmQsowt+l4imlCGNYFYb7CWFbqbO6iu4d05oAAWt9A9SGzNEldhSAy8wH101IRyMpFwINUtD/ZXcJY2ss57Dez3JfSV1D3/5X3FkZV7fum5EwVZ40SfncTg/xMkbx6yIibYDkVXgnW9NPXqB+9564ZS/9qWnqiLcm5yRsoC/JYzS05zpzYGoD1ocpS9ryf6gQZOjjicb2sRF5T2mKmpeLJFWmEFUDqLTESqqczPDbTS6r//6ppzkJZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AclzN+Ye/LJqX6rwWfifT6+XJuHle4TKXCII0FS67m4=;
 b=Xt8VgNKTR0jm9B1GEPFcnRR2nMnmCZfwiQNJiOhCFcI2WqAWqQy8JNGs3WZzHqpSdWnW1QdHKswz3O4D+Uk1cjRwztzFEc1V9Aj6PBOjGAXPgc/Y5l27tq2gISV/wDpSqYNARYF749aQC2dEr21CUChYkJhDoMZoHJnoDEzaw+U=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AS2P192MB2268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:62d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 10:59:27 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 10:59:27 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Tue, 17 Mar 2026 11:59:09 +0100
Subject: [PATCH] wifi: ath12k: fix HE/EHT capability handling on big endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-fix-he-eht-capabilities-on-big-endian-v1-1-e7b937b32768@westermo.com>
X-B4-Tracking: v=1; b=H4sIAPwzuWkC/x2NzQqDMBAGX0X23A9M6g/tq5QeYrKaBVklkVIQ3
 71Lj3OYmZMqF+FKz+akwh+psqmBuzUUc9CFIcmYfOuH9u5GzPJFZnA+EMMeJlnlsAA2xSQLWJM
 ERXp0LnZ+HnruyVp7YRP/n9f7un407no+dwAAAA==
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GVX0EPF0004F08D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::625) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AS2P192MB2268:EE_
X-MS-Office365-Filtering-Correlation-Id: a44b35f7-80ed-46bb-c720-08de841441e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18092099006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QNk8y5DOisc6iSIuD4pz9Pti14E92Me5BP8Z3LCmQYOOFKjZkuhKnwEiKiyZXvSGDf/cOraDPhHYop0e81XaD0qyZYklx/Eh1a2rBUV3piHSCjLEhBlj25n4xtiTv7Aph4ha09blAHsLBjdHnVy6jUCtMtm0OLaD+pAgCyP6gB0dGaGcGQcbWqmX0TDKJE3YQO27IsSWebckfCUrTvgATiGNH9M7fnqj1MJaV6NxlcRJx/r8lrs1I7LtDfOT9UA9tGLvceNosHlk7UBefner7+xM8h2R3pmBgskYAV2N3VznDXKMqtuzmzvGSVCkCUeK4IJDd76ZgXM4qHIzfwQMkJ8Zf+G4F0lVW0uWW/vnmvaZ2xVr3XaJgozYvG43/OSykfe7Rvc4tJp5U7KsV8r/qcBcCHYpXlWNTjeRxkBfwimQQ3mIdKQyBPm8+f8LUcRfuehU4LmhmAInPf8pWnZ4c/KLd82YNmlGkvp9FJ9rPV39madviiWsTRjcd4Z/M9rTggHCaDxwaG5JsWTTKOoSl+lE4pYn5bLbc7OfOl0LCAX0rUH7U7a0q1blrSeErSAhWnvLh05hhO3GDfCr2f8+rMNXDQlmted1S6VDBY+iTQumYhzQUo8uh6poFxGKk9MIBVim9bSIEyZoVeti6Ak8E8PysP4IYmqjc/hdqM7RTcYIgRAHCUPD0L+2bM4wyEBBG2JV92zmB2Jez42jFw5PH3YlM43rW9Vn6uhDpoDipzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18092099006)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkU2a2VJNUUvTHdaMHBYNUsvZDliNGdJaC9CdDJyTzRpSmtoS1FQNVJUS1RC?=
 =?utf-8?B?bG5tVmZWcVB3TVBXbFpHa3VMbW9JZHFaSGRxZlVGSDhEaEpZTUtkanYzTjk2?=
 =?utf-8?B?Mktlck5tbHpiNERhNFFUeUhxS2RDTXllWktOSEhzRWNIZFhZSjhaTlA4d2pF?=
 =?utf-8?B?TUo2ejdOeWlaUkJqMGRSek0ySGprMXNRK2pVOG40eTBtUWtlelJHOUYvdXpU?=
 =?utf-8?B?NUY3VHdTaEtYQUh2RUlhZzYwTmRNUi9RODFlOHpVaVp6QzIrUlNicDJpTnV6?=
 =?utf-8?B?NjlrVFg4TzBDc1k5N0t0V0tYaWlhV05pakE3Uyttak9ZUVpNbjNqMkIyYnYx?=
 =?utf-8?B?QkZaMHRPSDNhNGFqQjFMR1VFTFZGVkVWUlMreSt5b21QVi94azdTY1NEd3N2?=
 =?utf-8?B?ODNId0FjTUExNU1UVXJ6bEdmem9uSXRSMmFKY05oWlZzRWVVWmt0Y2FWU01G?=
 =?utf-8?B?MXphUTgwOFNTWmtlVWJ4MUFBNDNhV3pORWxUeG5uUElWb0ZEbnEzM1llQTNw?=
 =?utf-8?B?bEFyY3p2NEdKM1ZSZnVwbnJ2Tm1LY3hwUzl2UlkvanNncE1XKzVZYXE3ckgx?=
 =?utf-8?B?VEFTVlMwU3JWWHNlOTZkS3hPa2hLOVNxUm14TVJDQzlPL2M3T2M1QUdVMUFh?=
 =?utf-8?B?UVZiRXVKdmxYRzU3UjlhN3dlN2V1QVNYSHZpUWhEblZzU29obitPK1dWcFNu?=
 =?utf-8?B?OFE0bVB2U0tBU2FGRG5hZmFpMW1BdFFNNmY1WThUNUMzbTNhRERFSjhsTW1V?=
 =?utf-8?B?d0EwS0dlaUJjZUpPNllQZUpWVWhsZlBraGZCUXZjelVxelI4ZGpFclZsVmVI?=
 =?utf-8?B?Zm8xNTdBRXFNK2RPaUQvYUl2WTl6UHY4K09wODgyTlJ2WVRxS2lZcHVVU3M4?=
 =?utf-8?B?OVlmeFZUZWZ5Y254VWV5QWYyVXVYT2s0bzZnUkduNlcwWW1QZW5lQmZiTnpu?=
 =?utf-8?B?ZjJJOEh6MWkwMjdLMHFkUk1jTEFEa1FmZHdFSGZtY2VYYXhnK2VFN3FVd1Bj?=
 =?utf-8?B?cVJxMjJha3BEUjhVclBINy9oTFVDN2ExdHJTWTBiWWxPYzQ5N0xzVWJhQTY3?=
 =?utf-8?B?TzFvTkd0b2hlbk03eklEdlBOSDI4Nit5QjJlNHFEMyswTFArcDh2ZkVpeGVG?=
 =?utf-8?B?bHVyRE1ZMXR2TjVKME4reGJwcFJUazBnbGJrdVJMQUxlNjMyY29XWU9VZWll?=
 =?utf-8?B?VC84UUNkS09rYVB6OHFBQnJpMHRWZkluNHZyNllMeFBTZ1VURXZiUnpERUtF?=
 =?utf-8?B?djAvdnByQ2FiQ2tTUys0SCt3NDZXQkVrQklnZmY3MEkzWDEvcnRKMkk4cWZr?=
 =?utf-8?B?NlJtazkxQ0VWSlFsMUZGYkFWTEVsb0hoQzJXL25ENHhadzl4aXlzalV2T2RI?=
 =?utf-8?B?NEJxQlpjb3Q0aDVOSWc4UHh3VkhmVndVR3dEeDB6N2lnaldyb21HNEJsdHBo?=
 =?utf-8?B?Q2xYZk1UQ25xUXZML2JJNlpTYUV5NENsMEFPZ1NrcWxPc0xXb0o1WERvUitY?=
 =?utf-8?B?L05mcEJ2ZVpneGpPOU9ZRUVpM1EvN3RMRDRaR1RrT0JscjVCQ0ZONEpRZklF?=
 =?utf-8?B?WDVvT21qdk5wcGZJUXBmdUUzVnJkNk9CaHZjMHJIUDMzemlVM3cvTGRFeEw3?=
 =?utf-8?B?RjVzYWlpeEhnQldVSWN4YzMreTZXN1YvTzlzK1lXanM4QkFhT284bEZEVzdl?=
 =?utf-8?B?NnB3ZEtEZmpsaUZlajNRVVRLV08wY2xDVnZtMzgvckVMTndseTVmL0hJWmhi?=
 =?utf-8?B?bWY3ekhCTnI5dGFKT2M0dHdGZ2RqRVNNKzAzOFZmejJ1blhYcEFOQXdYenB3?=
 =?utf-8?B?OENvZm9mK0RzY0ZqMFFrTThFN3IweW5FSU1kazZ3ZlZiSU5NdHNDZTVoNzBy?=
 =?utf-8?B?a1I0VnBnclJOTFlTb3B5NzVIN3lsZ25VZFpQc1EwMjVQQ2l4bkd5WEdkRmw1?=
 =?utf-8?B?aXZobWlQMXhDV053WkJJSWV0eUU3VEdDVXJscjJVbkZ5dkEwYzYrQ3dXV0ZE?=
 =?utf-8?B?TVo2OXhLYlU4MHdsVDFTc0FDQ3JvQVZGcUxNVWI3KzZtZVFuZlRIU2puN3E0?=
 =?utf-8?B?RGJqd3JzYWc3Rkk2WHRKdjNvM0NZM084QWR3WFNTN2ZkYlhobW5DWm5hSm1T?=
 =?utf-8?B?d1BGb0RhUXJSNkp5TWNqaXVzU0dXYVhQNlprRU9XYllrSHViaFZ6WjJBUEJu?=
 =?utf-8?B?eFBCWUdDOTcvcUZIS1pvbWpabWRBMWt6a0x5SlFZTjlmZ3pLWk41K3k2WWlT?=
 =?utf-8?B?aitya3hMMnNSakhmR3BhVDQ4bXAwa1VRT0hzOXFTR0pibURJVVMrRWxJRmZq?=
 =?utf-8?B?RHRMeExTWmdnR0laS2VRUnhTYTQ0QVFDc0FMUWVsVEZtcGhPOVVFUT09?=
X-Exchange-RoutingPolicyChecked:
	LTErAJwfKF5CRzaOIZTktxaQDr34UqNU8PNxJXixzVLJyFMZXWjLy3l1Kr8Xz5g7JFtDaUZJdXcWkFnAWISQOn4QbJ9jER2gUqYcaIl/Rwk6cFOhDwQjKanO7U2LtGk1nmO1iykjBvZ8dZeEmGVgYxiVjSuztrFlAl6IL9e/3Q+TXd9DDEBdWNlk8eyTjDFZJXgdv7/drSS6ctuV3KxFzA9pZlkQUZV7a5FHRdJe0l0fmMB5lOWfIQdx2oITJViTGsIZHTfxMSq5lIlpBQYIJrBAGFDdN9MqnCIxCDkZUt7smu668Ys/tj8Pv+KG36ZeCbdJ4AwpwzdXasQJCzg1rA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K/vEiFlWuZ9Vu0oMhqazyM6BfeJFKvSbH5seC/D48VYVzw3Z7HqBJIs4PdUwaW6cE/B7YyTG015cKSf95rdMMaj7tIbzb75yazWZ+bfuxGKAT0kCUBvZKgg1IzgwFTsP134tL6R+Ntw0MhRoijQsWKC51CbuC6k9sHWf4w6+xR90AAFo3Y3dsa0MbvnK4JDyxZrolOGEMVCK2Sb9sXQsSyRue2PL4tFrzUNMY4M/bxZjH8GnOJ+bVstsuZ0EeirKg2TcPbU2ZNIM4Y1y6qEA0GejhMkVX3ge8Pcamme+CPKPRohG9lndh8fbdI8YAYkEGYv8X+Al+fAeBJ+ivJf7l0xayWtj/JNmr31tYPMwiZtl/7Mwwi1B++Kp3NiioAvgCY7nqiFdB2amby5lF6iPIaCdQiw26rjM46kBUIRgGZbINSVFRzaX5CCiSTB0e1QjPIMmEXu98h9pJzCewNZAKBy7SPf5PGUNsxZgIAgohOt/ZA6jcC1/h43sUDrSjPxg3YgXBuwKUYMzSxKYbQSF5K0YBpuiASBKcYYSorWDaMkiDvG/9xBVrIZQGp19vzmr5RveGLvxBMCNc4ZEw0xHfh2GYUEjbzQwsKl1Rx5K2+YAjBNf+IcjsmeTStlbhH9j
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44b35f7-80ed-46bb-c720-08de841441e7
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:59:27.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXJZaulIipBbq5kXAggH3rdQaysMQil45iVYxv0589DNhOTIchzfI+dGXe/GXiqNBdQU1d/MqL6d+T09w7k6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2268
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AS2P192MB2268.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PO8COPqC c=1 sm=1 tr=0 ts=69b93411 cx=c_pps
 a=lakOHStLBeaDgIzsH3dHVg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=H8Orwd-V1rlTU6yqn9EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: UQD6UqmV3xd9XibyRg4pnlB4TaF0Pnpl
X-Proofpoint-ORIG-GUID: UQD6UqmV3xd9XibyRg4pnlB4TaF0Pnpl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA5NyBTYWx0ZWRfX75wEfNK1I1AG
 IT9aPb4T7f9ErzF9qG1z8Mc5EI8fMhNxre6SzXzKIybdVUYFWOtumd9rZ0FSC8KWOXvOhYuFrr7
 nRAA9yP8HPri4sBNkp6HyJSn0MSKGPTDRaYPerYn5l1kfFQ5czjVynolh9uKlnml+pXNPw3QLXw
 +BZIAQtHYFgjpenZPStra0Xn3MBO5pqBNoiAetvPqDjwmwd2Kj2iXaRAdS4ETbqiGCLLu0MpaV6
 X4C40XhWx/n/FjvmqCfO0+iqfNQ35os3z9psijnLv2H28hiKtdL5n8yCevcuro6MWpmhWOeD1x1
 4kHQYa/y23MOpc0VouSwqm1vkqx2pgAZsSBCG6wLFtsskDbkNutwePUdY6Ak1ep9q8uAI9Msdjo
 55HcETdU+BjmS3VI/XEqUY1f2qO08mxa5HM9LdvkpR1r0BG5PONtPQXe/5ln+akGyPRCSoJaQkn
 IfdQrlU4MxPQaJjGz+Q==
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-33341-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,westermo.com:dkim,westermo.com:email,westermo.com:mid,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5CFAF2A8679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver uses u32 data types for the HE/EHT capabilities in
CPU‑native order. However, the ieee80211.h header defines these fields as
u8 arrays. This causes the ieee80211 registration failure on big‑endian
platforms, as shown in the following log:

    ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath12k_pci 0001:01:00.0: MSI vectors: 1
    ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
    ath12k_pci 0001:01:00.0: qmi dma allocation failed (29360128 B type 1), will try later with small size
    ath12k_pci 0001:01:00.0: memory type 10 not supported
    ath12k_pci 0001:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x1005 soc_id 0x401a2200
    ath12k_pci 0001:01:00.0: fw_version 0x111300d6 fw_build_timestamp 2024-08-06 08:43 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
    ath12k_pci 0001:01:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
    ath12k_pci 0001:01:00.0: Invalid module id 2
    ath12k_pci 0001:01:00.0: failed to parse tlv -22
    ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
    ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22
    ath12k_pci 0001:01:00.0: failed to create pdev core: -22
    ath12k_pci 0001:01:00.0: qmi failed set mode request, mode: 4, err = -110
    ath12k_pci 0001:01:00.0: qmi failed to send wlan mode off

Use the __le32 data type for the HE/EHT capabilities instead and avoid
swapping, so that both platform endiannesses are supported.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  8 ++---
 drivers/net/wireless/ath/ath12k/wmi.c  | 58 ++++++++++++++++------------------
 drivers/net/wireless/ath/ath12k/wmi.h  |  4 +--
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..8481015dcda6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -788,13 +788,13 @@ struct ath12k_band_cap {
 	u32 phy_id;
 	u32 max_bw_supported;
 	u32 ht_cap_info;
-	u32 he_cap_info[2];
+	__le32 he_cap_info[2];
 	u32 he_mcs;
-	u32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
+	__le32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
 	struct ath12k_wmi_ppe_threshold_arg he_ppet;
 	u16 he_6ghz_capa;
-	u32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
-	u32 eht_cap_phy_info[WMI_MAX_EHTCAP_PHY_SIZE];
+	__le32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
+	__le32 eht_cap_phy_info[WMI_MAX_EHTCAP_PHY_SIZE];
 	u32 eht_mcs_20_only;
 	u32 eht_mcs_80;
 	u32 eht_mcs_160;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..f5cd1eb27685 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -487,12 +487,11 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
 		cap_band->max_bw_supported = le32_to_cpu(mac_caps->max_bw_supported_2g);
 		cap_band->ht_cap_info = le32_to_cpu(mac_caps->ht_cap_info_2g);
-		cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_2g);
-		cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_2g_ext);
+		cap_band->he_cap_info[0] = mac_caps->he_cap_info_2g;
+		cap_band->he_cap_info[1] = mac_caps->he_cap_info_2g_ext;
 		cap_band->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_2g);
-		for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-			cap_band->he_cap_phy_info[i] =
-				le32_to_cpu(mac_caps->he_cap_phy_info_2g[i]);
+		memcpy(&cap_band->he_cap_phy_info, &mac_caps->he_cap_phy_info_2g,
+		       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet2g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet2g.ru_info);
@@ -508,12 +507,11 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->max_bw_supported =
 			le32_to_cpu(mac_caps->max_bw_supported_5g);
 		cap_band->ht_cap_info = le32_to_cpu(mac_caps->ht_cap_info_5g);
-		cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_5g);
-		cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_5g_ext);
+		cap_band->he_cap_info[0] = mac_caps->he_cap_info_5g;
+		cap_band->he_cap_info[1] = mac_caps->he_cap_info_5g_ext;
 		cap_band->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
-		for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-			cap_band->he_cap_phy_info[i] =
-				le32_to_cpu(mac_caps->he_cap_phy_info_5g[i]);
+		memcpy(&cap_band->he_cap_phy_info, &mac_caps->he_cap_phy_info_5g,
+		       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet5g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet5g.ru_info);
@@ -526,12 +524,11 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->max_bw_supported =
 			le32_to_cpu(mac_caps->max_bw_supported_5g);
 		cap_band->ht_cap_info = le32_to_cpu(mac_caps->ht_cap_info_5g);
-		cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_5g);
-		cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_5g_ext);
+		cap_band->he_cap_info[0] = mac_caps->he_cap_info_5g;
+		cap_band->he_cap_info[1] = mac_caps->he_cap_info_5g_ext;
 		cap_band->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
-		for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-			cap_band->he_cap_phy_info[i] =
-				le32_to_cpu(mac_caps->he_cap_phy_info_5g[i]);
+		memcpy(&cap_band->he_cap_phy_info, &mac_caps->he_cap_phy_info_5g,
+		       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet5g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet5g.ru_info);
@@ -2226,14 +2223,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	cmd->peer_phymode = cpu_to_le32(arg->peer_phymode);
 
 	/* Update 11ax capabilities */
-	cmd->peer_he_cap_info = cpu_to_le32(arg->peer_he_cap_macinfo[0]);
-	cmd->peer_he_cap_info_ext = cpu_to_le32(arg->peer_he_cap_macinfo[1]);
+	cmd->peer_he_cap_info = arg->peer_he_cap_macinfo[0];
+	cmd->peer_he_cap_info_ext = arg->peer_he_cap_macinfo[1];
 	cmd->peer_he_cap_info_internal = cpu_to_le32(arg->peer_he_cap_macinfo_internal);
 	cmd->peer_he_caps_6ghz = cpu_to_le32(arg->peer_he_caps_6ghz);
 	cmd->peer_he_ops = cpu_to_le32(arg->peer_he_ops);
-	for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-		cmd->peer_he_cap_phy[i] =
-			cpu_to_le32(arg->peer_he_cap_phyinfo[i]);
+	memcpy(cmd->peer_he_cap_phy, arg->peer_he_cap_phyinfo,
+	       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 	cmd->peer_ppet.numss_m1 = cpu_to_le32(arg->peer_ppet.numss_m1);
 	cmd->peer_ppet.ru_info = cpu_to_le32(arg->peer_ppet.ru_bit_mask);
 	for (i = 0; i < WMI_MAX_NUM_SS; i++)
@@ -5034,17 +5030,17 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 	u8 i;
 
 	if (band == NL80211_BAND_6GHZ)
-		support_320mhz = cap_band->eht_cap_phy_info[0] &
-					IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		support_320mhz = le32_to_cpu(cap_band->eht_cap_phy_info[0]) &
+				 IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 
-	for (i = 0; i < WMI_MAX_EHTCAP_MAC_SIZE; i++)
-		cap_band->eht_cap_mac_info[i] = le32_to_cpu(cap_mac_info[i]);
+	memcpy(cap_band->eht_cap_mac_info, cap_mac_info,
+	       sizeof(u32) * WMI_MAX_EHTCAP_MAC_SIZE);
 
-	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
-		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
+	memcpy(cap_band->eht_cap_phy_info, cap_phy_info,
+	       sizeof(u32) * WMI_MAX_EHTCAP_PHY_SIZE);
 
 	if (band == NL80211_BAND_6GHZ)
-		cap_band->eht_cap_phy_info[0] |= support_320mhz;
+		cap_band->eht_cap_phy_info[0] |= cpu_to_le32(support_320mhz);
 
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
@@ -5132,10 +5128,12 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 
 	if (ab->hw_params->single_pdev_only) {
 		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
-			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
-					 IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+			support_320mhz =
+				le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
+				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 			cap_band = &ab->pdevs[0].cap.band[NL80211_BAND_6GHZ];
-			cap_band->eht_cap_phy_info[0] |= support_320mhz;
+			cap_band->eht_cap_phy_info[0] |=
+				cpu_to_le32(support_320mhz);
 		}
 
 		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 5ba9b7d3a888..ea680a1a5464 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3911,11 +3911,11 @@ struct ath12k_wmi_peer_assoc_arg {
 	u8 peer_mac[ETH_ALEN];
 
 	bool he_flag;
-	u32 peer_he_cap_macinfo[2];
+	__le32 peer_he_cap_macinfo[2];
 	u32 peer_he_cap_macinfo_internal;
 	u32 peer_he_caps_6ghz;
 	u32 peer_he_ops;
-	u32 peer_he_cap_phyinfo[WMI_HOST_MAX_HECAP_PHY_SIZE];
+	__le32 peer_he_cap_phyinfo[WMI_HOST_MAX_HECAP_PHY_SIZE];
 	u32 peer_he_mcs_count;
 	u32 peer_he_rx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
 	u32 peer_he_tx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];

---
base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
change-id: 20260317-fix-he-eht-capabilities-on-big-endian-d941c42f65e5

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


