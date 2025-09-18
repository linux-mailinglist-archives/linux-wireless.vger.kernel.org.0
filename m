Return-Path: <linux-wireless+bounces-27477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA3B839C2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 10:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D7A721856
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF42FF650;
	Thu, 18 Sep 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="COe4B4VJ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="IqJzTDhi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119962F8BD3;
	Thu, 18 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185680; cv=fail; b=dXL+o+os/aoWX2qIt/s7Grezzzd4K6ewMmYdLjAZduawQ50bRfaSr+7ANDT+Ta3+JkZuCedg8+KJbIp6qNBnEoSc7EjkF1ldhgP+G/hF12Sx8l4YYdZrWEi3K2OPIlQ1eHPShdUKo4z+fuqK0ClElDRnyfERiLa6IKCNCV1eyvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185680; c=relaxed/simple;
	bh=htHAMMindNlX2x8eXbjYmgLRexhBNs7uO3GD8vEDVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xe11H3bfPaK3izUeAhHvhMWai4a8JG0TZ7OftEnzbHLBKkhCRrtX8Lq/08gpDZ1CJbXxnWLywsxRMdBFeehSXWYnEAXX4NhB6BP5NSCR/8akoZf5Grzi3fsZvWmDc/d6S2i91iYLyE+5QrJtWo1xjt+GnXoxmt2jl/G81PQ1JNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=COe4B4VJ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=IqJzTDhi; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I4xSjv1586581;
	Thu, 18 Sep 2025 10:54:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	u+3wuJlWW4WfI9uAsDl+aDULFZzpAr+PG8OoUz7ArNI=; b=COe4B4VJa3Zm6mj0
	aR9uXKHcOxcHdR7T7L9YTMfnYsZqj6f5w1inhFz6oeyXed8DYIHaVzToAJTMvy64
	fXpMLoJ4xjXXpR492ogC+HTmskamnE0Sjrqzp0YG9KyueP7uoA0YFiwTr5UfUu6V
	Q6o4bocbE57lMglH0Buph0K2mkCJ2blq8fAO4ZRZV948DejE8oSnCtikGkjRyGVC
	WUk4H09hYt07BrXHvZtocHxgaJ63CNFKmuG/xLx/L/pSk6cPqZGT8ZGI4RpYzs0h
	yusp/DNBGcY+ebfEPZUZ6lG/aCOGBHpOU1HHigAQ+yVtH8ygjPlCFg+Zp0gBRSo2
	oR5SCw==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd2t95-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 10:54:20 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieBt5Lp9yJyPsVEd5jmSwf2LQOGvzfKnRJ5Au9JaSVHfn6u4RbTQU1HL48A7LYwJt71UuAICJrZq5Yu7htR02wD9rAcUTmP6D23NMvxfocfVeVik3v/AZK0/Vo4v//rQTLmooWsK1AYnnbFDu2DZg9BIE3QrhNNeUi8VP2X/4xCc7UZNRqTGHjK3B38aXronT7ON7SZDpdCys/lO5zo/MiikRyWxQ++HR33yc9H6qb/dwd+Xl055u+vbOgMHvz62wRTBOCOrqSZj63BzRWl68puXnG069BHAsIIizWXxGtmmD6wqfHvFODJpBy+32kyQnXkqiUt3teu4Fo/iCgI4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+3wuJlWW4WfI9uAsDl+aDULFZzpAr+PG8OoUz7ArNI=;
 b=jIYt5owW1upFGkmYDxzrRVVu4TuH0B5tW7rzkQXAApqAbxtp3M4eu0BbifBrloJv8PrUf/lubax7+E+Th4mJ5Xv2lTv2TZ85tiMsbcLPMjBs+6+tVLFDHt+dVO3YgY//qnWi5BcHbFFO4UxLP0SaWvGNs9WzizPO+8n6Q7PLKhNVkYB8hppC1YLngd+cV/FTFvqrtQ7qSd+dfeAwMk02WrHkmWa/LYK8FMole2mXfopmEKs8LhvJRiiIqyxXYC/Hat6NqX4FOhcnt3MY8sssQvowCecBPDhzHoEpqBLLivRd2XbtkeA8lwPkczY2s2LPGlXqiQiI8LjucW6sU4fOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+3wuJlWW4WfI9uAsDl+aDULFZzpAr+PG8OoUz7ArNI=;
 b=IqJzTDhiAgb4wrqvRgQ7GWdtQRhU8vyLbp3raRxg3tkuRiOrTNLUFhskgaZ8lXA0MaFJrzYKWIk2wZiXpIMpRSMFKYoSEGpfmNXLcpUaWdImx7WJE4KooK3Ht1QAV9LTj41a4R5+KzJRECQZfDq1nHL9+tYsE5AFl9s2AcbQ05E=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI2P192MB3195.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:54:18 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:54:18 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 4/4] wifi: ath12k: enforce CPU-endian format for all QMI
Date: Thu, 18 Sep 2025 10:53:59 +0200
Message-ID: <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::10) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI2P192MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca31b66-3145-4e14-589c-08ddf690f40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KFwA6ZO6N3yQVgFFhnJVTwJYZ014WC8L0XLaYXwo+T/L8ZcK6mV3qDlyJrn?=
 =?us-ascii?Q?xU/D3/iHnjiPiYPkzJ0rB7ZHMTQCQAVCFR6w6cSlca0RZG1unH46t2ghpJfW?=
 =?us-ascii?Q?mHsFLAGrHoHJj0tjbFJJNseDlGWQIvSyGId5ckifzVdV6O2HhhU9DJN1h53D?=
 =?us-ascii?Q?s/ou+BX8I6x+c8Fl7aaqVjxi0m+Upk4Q/C62f6i6maPycQdOVZeZ2TMIE7KO?=
 =?us-ascii?Q?9QRI/uER2LdmtO3E+bxn3xomdmEFDrqM2Nz7zLGDsBustxo41uJC7tj4FAkY?=
 =?us-ascii?Q?2xXHpd3p7/hJZ06BuzUReQZKKbv0uG+KO0qUIlwJFShIsmJv7Rgxr5V6NJEO?=
 =?us-ascii?Q?LdwbFmz2J1CUSij09qdke6gEnYVbbgw+9biYKhngvPUoNZLxFdMRvjmRsEOq?=
 =?us-ascii?Q?ncUvdDcay31YjN/usAjIqSMb72PTcf8SK0hmyq8eOGCZpP+d4LJl0Olnm6xr?=
 =?us-ascii?Q?DN/y4GBriDiIISyIFTn+EZVfoQfvtV6XF24HnZ3i9NhNkKyhrV6uxBIjvPU8?=
 =?us-ascii?Q?/4ck9FP713xJaO7T7+zF1rNrN9juVB4PnfTHd0kFaXIaE6newp29nr8tJyJI?=
 =?us-ascii?Q?Lr2C7/Ocft5rzamNt3raD3U9Nj1YTD7BXqszm5dxiHXB4unp6cvdGETmUpOq?=
 =?us-ascii?Q?e2Uj60t1oQH83elDbYHrEv8cyEY7sCy+F0ISwdbWJ3VnlgeabtLW59X1IBc8?=
 =?us-ascii?Q?DIfEsKXiPRl63nTolGBITAKpY/PP6jMlV9C+yDsr8/5yh0G+UoZ0vdIlK222?=
 =?us-ascii?Q?JlRwLif+b8UZSOLTA2zDRaXwSDXHK2VcpL+NzMx37Ce0Ww+iyFH/lGvQbQRp?=
 =?us-ascii?Q?CZSCTRAywvveKWJ6VUhQ6/WsATL8vVdi5MrGfXaDuOwqA/mjvxnvCppKorYY?=
 =?us-ascii?Q?pzrjFLj5djI7/FDciPkOr1zdMPhcmvTcOWnpG88jBZn05lC/LP4MPqkY0kEF?=
 =?us-ascii?Q?F72E/+Fs+DIkymGr4aUjmvmaviHjqqRY4Z/IIeO1Wh8H1H+XlUhG4k+obaxC?=
 =?us-ascii?Q?gA/Y6mohAb/RvKtpi6M8ScwmV/jT5cLCsG9+SMKPg7vHk60+LA7lX5rwtQ2m?=
 =?us-ascii?Q?ZNXqQVNGWCwQX9cMUFze61Nm/quxn2WOfWAsrvGyPuo2IjIEnK+EITo6xzHK?=
 =?us-ascii?Q?4ByT4m5XYERL353GtBIo72+Bvno2P5Fw2qmcdjBgBNQhK4/LEE3ruqBauKzd?=
 =?us-ascii?Q?5ZE0xRjWnS8LKDkOCFP2PAVEVVVmFMMC7sK8LtvV1LhC5UtVDzjppX6Q9CLD?=
 =?us-ascii?Q?ZYbiWDyx6nMK5zvInB+uQVB+XsJkjrhW+207+A32o+GAgmVMo2C2rBI3PDxg?=
 =?us-ascii?Q?SF8CqVfHAkp9xDQMpsC1t8JJvFP0knFPuQbY+24cFQgim+fRdrDsIpMBpBiQ?=
 =?us-ascii?Q?avxfn0vSlce4XYZEsibZTr4JHllx8RQQic4KYjvFxGvdEgFwv6p+Db8JsLsV?=
 =?us-ascii?Q?UcybofirUAg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PAPshi4gQWi1gcgkGXQH6dQuowquI5KimyyeCrIHBAYWTpmVFm4RmGTVdkFR?=
 =?us-ascii?Q?JosePzZKuedefQ8YgDQ6ciGA2QH/MEC1YksuDyL3z/lOsm/mmOuZ8ieQd2+4?=
 =?us-ascii?Q?QE5jwfiiSarVpzKyVhd4tdvcudkqDqQxPvLQ94oSyB+oiaDHHhNRJ/jvRncS?=
 =?us-ascii?Q?h81TtaZsGFACP6+oa3BnBKQC4sicHihl37ir8VJPMHtFm7/cy2zCaBL8x5qu?=
 =?us-ascii?Q?fZxTiV3OpXQZy/Z4qGqLnNTE0d9qEdGH1B0dC2PhEk5nZJKlDOTInrXAzhmU?=
 =?us-ascii?Q?P08LUfA7lfPKvC3H0U+P/x81+0CU8wRi/5V3pNBE04dKGlHCYpEKuAONjmC3?=
 =?us-ascii?Q?IxFRjBPsqt5O1MtVExptW8AyFVSxGI3e8Q74ZSJiOFAWxLtNPnvQGFLibSrb?=
 =?us-ascii?Q?aCuM5zspJ4t+6u/oXnengIAmr7V9AfwT0D3SNFWktWq/0FkURfZlIGa1YMne?=
 =?us-ascii?Q?Mge1BwgT8ZSLpwkZTLVrQ0BOQhNRoERiE82A7FS+cB3En7HyatL4tFBrj452?=
 =?us-ascii?Q?rBvZZyG6RJUTKuFcbYLkMHyMKy4rt0QiesSAHIlLyUQosjHHv2SgOkHq/ONi?=
 =?us-ascii?Q?Y4O1/BaEPy3hyyWqQIp6q+XPiVSggKXMiPCB1cL8HP1d+3zcnVY5n71NB7u/?=
 =?us-ascii?Q?s6qvhbJ4ykwj9cr60BHPKzq0lDqKvZmB9qkw2tzYcnlhy1Fa7+qktvmpD44l?=
 =?us-ascii?Q?zCSXpPQvcy91WvN/PCxbJPK3ty3Qf0Ya7C7DyhEFqMMXOnheD5S1H7fREY0Y?=
 =?us-ascii?Q?/GCtiOZmwawHWJK0y7YmC0kAVUBVvatlJPcZozQnhYnUbDczax+TGb3TRX6r?=
 =?us-ascii?Q?GpFYRf8Z0vVrLaPq3WGIlsWSsHtPp6kNB5Zv6LZJ5mIzrsH732aAmtXMrqOi?=
 =?us-ascii?Q?jgBFusAqKzA61Y4buZv5EygMyHKCC555k6g/N75CCXgDwlaab0nXtRI4Wnqj?=
 =?us-ascii?Q?pKJwEnr/5+bHT+jNQypDWHaX80KOF2De5YkFy3iYbCfRBnAEXonU0YX9HQCg?=
 =?us-ascii?Q?k+g4Ii3dIYxjuvps2AceAkj2BcUFArarfDnrDDVoH6LUqsJ7URPP8dZSvth0?=
 =?us-ascii?Q?A0ne3tyBxJ+JNWebHDKHAcB1/wtCwgkogpP1BwzbhL5FpnraViYShLUcjJmd?=
 =?us-ascii?Q?Yaaqwq+gBCh/WGxWXRr+GlaYcYlXG5o76krm432YQoibSjtRD5k5OjvQoUa5?=
 =?us-ascii?Q?4Wqqet3WFGUd9EllirCbFwtJpmVZkCyHnEGz7o5FSKeVf70VXsofAI5t3EVq?=
 =?us-ascii?Q?eCZCk4HUNTzI4vfHy/CzcGSw3+YuG9CfN6la4smN98XPm3njlI44q0heUlf/?=
 =?us-ascii?Q?dhGGtunSRQpvIkS9HKfbuyn/TWfvtfPvXAZCF31yUoxkNuWdbF0lh0hOCoGT?=
 =?us-ascii?Q?3ogWtancHAaoveMEbvYLv0+lsSGNvJviXECrSeQ62hI6WZqa3YJzTTLlUtvx?=
 =?us-ascii?Q?IJfvcUbkTCmdCJScVv5LqK/xeDKXPaogEwemHfL9956xKMQXP/FtWbhRI5xa?=
 =?us-ascii?Q?mtrCfpYGIa+RKNpcpHiZv6WmZRT+cigZlMgVQ6/PQ+syJZb3r0+mHPR8/ev/?=
 =?us-ascii?Q?6m/DTpJv2Jza6q/CNcvoHHj4LtGmv9CE/QC7W6XH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k7kaqX0Kb+Jz5J+CuznyF0cL/ixAXTLlWIYufEZ5ng6648r3CN6iB6Q9jmPsUtH9njEewVYA5rVp2HPsPlVnUOYF9c4Z2VL/r0BHR/qnGpiRS1dkBugVIi7OJFymTDqBBncFRzlHeYVclruWNNm/5zb6Z6QFbRAaVV/+4qzDDTr9QVGhFo5uube5aEbSa0FsNsth4ne16/avR4OnN395rfu7KEMfBAEfcUBWcj9tX4FELEdrO3O1JNIhbv5ZwFb/Tm36u+pRSpX2NOAJsFpcPgHmpJmxO5asSuLJZpOliPx+Up3ugWBTfBsDMgPngIfSCAsFiaycpAN4M9NEQ07WXxFcWANyEjY2z9dkszYzt2L+vhIwMKi9GFAZ6T1aY+kIiTC9PHY22dQhLKhDvby+xp0WgV9ave57JyY5YH72VqeDW8ADGDb7mEsZMa3gW5RPOTbU2xGR7GfsAKpk5pUACT8JaWjKQktTQSJ5V7ZyAZpe+x0plwJVRaoxhQlQ2H5n4X0Gc1fwzib7dNd+OGiIELCkz3RLMNDqt2j9acgMKN4EQbh3/cr4KqelQpR5h/VBmEjIJqVqGZR1YqgApobK4Xy3Ou5CEfEE7kle+1XxqYxk3tREBnhuitpIOGcCiaJR
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca31b66-3145-4e14-589c-08ddf690f40d
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:54:18.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY5cbuvUVtFgtjoCFqMpgdhfktpma2+p44twErOCjY+Jems90ugRhzEmmOzPX5kl110woEZGU/iJ7ApJSq0RGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P192MB3195
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: VI2P192MB3195.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68cbc8bd cx=c_pps
 a=8VE09XiYDOmzg4tWGOS4Pg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=-n57fyUix78Y44btv20A:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: NiddrjhgUHVefSnkRlifXRel423DFWIm
X-Proofpoint-ORIG-GUID: NiddrjhgUHVefSnkRlifXRel423DFWIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4MSBTYWx0ZWRfX9V5O1wxKOZgm
 aavPB+D6L2Y8CM3PZObOqHJefuZkgXYHKShz/rpqV7/4zKu10S5P5proZM48WWQwCxQcSqpEymc
 bXtRTJ29ZKfu60+jYFZ1l3klUlaq8/CzOcj+a3MLR7+u49mH9pKfpfrbeSUMvnInA5famapEnmD
 GXDNEOt9atvwKF+H7M1rvMfHc3N5ZNI5pvWY5SY2FsSHrOYAmHKCuqRkFFFbt4e6noqVGmjhbMF
 kZbm6a3Wl4PtHiSktpTI/SV+o1X5wK6W01pRkfqr3Pmt1r5Un0dE0t2+nVPwyRyb2Vx+JNhx6gj
 g10NFZOeAxld863iUgAJ7YRXBZYzC07nrWvm16OEzvov2ciZArlxDd+gNuI7iQ=

Due to internal endianness handling within the QMI subsystem, all QMI
requests and responses must now be provided in CPU byte order. Replace all
QMI-related data types with CPU-endian types and add the necessary
conversions to ensure correct interpretation across architectures.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/qmi.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..36325e62aa24 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3307,20 +3307,28 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	/* This is number of CE configs */
 	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
 	for (pipe_num = 0; pipe_num < req->tgt_cfg_len ; pipe_num++) {
-		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
-		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
-		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
-		req->tgt_cfg[pipe_num].nbytes_max = ce_cfg[pipe_num].nbytes_max;
-		req->tgt_cfg[pipe_num].flags = ce_cfg[pipe_num].flags;
+		req->tgt_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(ce_cfg[pipe_num].pipenum);
+		req->tgt_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(ce_cfg[pipe_num].pipedir);
+		req->tgt_cfg[pipe_num].nentries =
+			__le32_to_cpu(ce_cfg[pipe_num].nentries);
+		req->tgt_cfg[pipe_num].nbytes_max =
+			__le32_to_cpu(ce_cfg[pipe_num].nbytes_max);
+		req->tgt_cfg[pipe_num].flags =
+			__le32_to_cpu(ce_cfg[pipe_num].flags);
 	}
 
 	req->svc_cfg_valid = 1;
 	/* This is number of Service/CE configs */
 	req->svc_cfg_len = ab->qmi.ce_cfg.svc_to_ce_map_len;
 	for (pipe_num = 0; pipe_num < req->svc_cfg_len; pipe_num++) {
-		req->svc_cfg[pipe_num].service_id = svc_cfg[pipe_num].service_id;
-		req->svc_cfg[pipe_num].pipe_dir = svc_cfg[pipe_num].pipedir;
-		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
+		req->svc_cfg[pipe_num].service_id =
+			__le32_to_cpu(svc_cfg[pipe_num].service_id);
+		req->svc_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(svc_cfg[pipe_num].pipedir);
+		req->svc_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(svc_cfg[pipe_num].pipenum);
 	}
 
 	/* set shadow v3 configuration */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abdaade3b542..4767d9a2e309 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -392,17 +392,17 @@ enum qmi_wlanfw_pipedir_enum_v01 {
 };
 
 struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01 {
-	__le32 pipe_num;
-	__le32 pipe_dir;
-	__le32 nentries;
-	__le32 nbytes_max;
-	__le32 flags;
+	u32 pipe_num;
+	u32 pipe_dir;
+	u32 nentries;
+	u32 nbytes_max;
+	u32 flags;
 };
 
 struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
-	__le32 service_id;
-	__le32 pipe_dir;
-	__le32 pipe_num;
+	u32 service_id;
+	u32 pipe_dir;
+	u32 pipe_num;
 };
 
 struct qmi_wlanfw_shadow_reg_cfg_s_v01 {
-- 
2.43.0


