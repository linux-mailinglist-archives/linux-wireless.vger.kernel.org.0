Return-Path: <linux-wireless+bounces-36208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKZ5EMWCAWpObwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:18:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E6D508FC2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 470883014753
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554AB3783C8;
	Mon, 11 May 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKRZdPve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB437106A
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483857; cv=fail; b=TNz5DD+gXpUEERrJdwlIhSz+o33AAXhezjvLDCs9jFqDN7f/ni3zxXHnG77XNfz4d1yT8zL3ykIB+Y+Cqe9R4Py9RNKwoutNtyKdtWT98OJWcHtjghtW+6hi4mgnEcc+CS5E7S4sMhTIJhbmbtrs1QwDEhQRvWuCCK2c08QkkmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483857; c=relaxed/simple;
	bh=/9bhqa40qnJo4W2UHx3SMA1RVBNau9z4F43W5m1E58M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EQr9ZCKae5IrXcCO0JIKCVRYvVXzx8YMbrTGLWH3yVenN/ZaDHkjRDCLTr16VwcrxSS+eySy8wZm7n74kJVSgZ9txyReq20KKajbeB3niji+5apHELaDCs1sZXN7hGUAhQCbbBMuUth2w65zoEGvTR6P+vjASesMTFv0vKI6qVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKRZdPve; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778483855; x=1810019855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/9bhqa40qnJo4W2UHx3SMA1RVBNau9z4F43W5m1E58M=;
  b=NKRZdPveIdoOIYAUGdbLdJOn6MRVWnTRwSCnY1J0XiwF0dB7LVfsp7gZ
   JEqs8MD9g6eTx56iB2KDS+ylz+GoiQt5NYwVSiVJ5gmE+LNF10r/o9EQd
   wQ2IT8mfkEWi26P6oeOqt1WZU8qxO8UYpBtrhM+JxlHAL1xOAUP09bAmZ
   b5vH+yTph8i5hMdYZD/YWZ93HF7lv38V5gdxDhKQw9ZEpLyu2mgnZbPTF
   0yUMoNPSSVghcG8VN8L7nkoAE0V1LGhg1VQujaSMs9SgQviOhY9W/D4Yp
   sbBVhiExIxhCiPG5K9llBIfFR1285ttuCiRPZ0HBIIO3DmMz+717KnpcG
   A==;
X-CSE-ConnectionGUID: NB8HzVwBRc+4FX/L4fZaaw==
X-CSE-MsgGUID: 9LoNt8HURXWt+dThXdpZaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="66894566"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="66894566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:17:35 -0700
X-CSE-ConnectionGUID: UMf3odWTSDmv8z9D0i2RLQ==
X-CSE-MsgGUID: 8TUlSMu6T02NZbilW/N4kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="239198779"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:17:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 00:17:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 00:17:34 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 00:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+Ye/YePQ2Rd9oVGcSDgqTR2yyVBNkDMI6E/tbBsYu+WCtErnymQpf3e5GYLILzG8v/3/FokroY0R1oKWtY86jyRUWqQpu4VuZFtC03FtBBTf9BUfmNC+UOAzXSURkFoKMYCtQLEmykSYWiGeYeAaTPqTCAzFqgwZU5NMJVzyO7QqlygBcaxE5u4BOU9L56EIbuFVgk59AYsaw3isAWKdUHVZk3l+aXtIZ0xuTdsDJEoIwp3km1//y7YdXZTEeV2oJp1LnuOabf0N7AESiXlKuhRWSUwj306QZL4TKxfsUY8sOUNQuytci8stMiyVLoqUedhuXrdd19+pNYMEhRnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9bhqa40qnJo4W2UHx3SMA1RVBNau9z4F43W5m1E58M=;
 b=A59Q/5VfMZcinV7H/1M5ECFu47hOWJKU0mWpmK7Au/XtmcX52BS1GVALy0HWiSQi1MZG23kFeVcO/Tt5XyyeZXV54m9kRdi3TQn+1GFYGv1vqmsqSILKE4rJIfLdNuVsza91rK6Yj25pnbQydAW5WcI1v5NLowI2Scn3IB9CDlc1V3DzDrxNbSHkHALOQ6L6pSxkOpvaqZ4WLfbDGMURw5v3GbXurEXOAnK45XX1Dbd0ek6eyH2KejYiE7hWzwqEESt6sL8Vby2kqyloONYY1JBfcYVpEkUCnUfVuxbhUTD5S694RlYLOFS0k5TR2xyJTTNv2cBrCJdfXKeBuaoE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by LVUPR11MB9786.namprd11.prod.outlook.com (2603:10b6:408:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:17:32 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.20.9891.016; Mon, 11 May 2026
 07:17:32 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "coiby.xu@gmail.com" <coiby.xu@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Subject: Re: iwlwifi: network not back after resuming from suspend since
 v6.15-rc2
Thread-Topic: iwlwifi: network not back after resuming from suspend since
 v6.15-rc2
Thread-Index: AQHc4RJrBxX3eOxaikqb529hz0g0a7YIalGA
Date: Mon, 11 May 2026 07:17:31 +0000
Message-ID: <5d143832c8fdb8c39ee7daa5002cda9e5a26921e.camel@intel.com>
References: <agFzc-Ngf_ZFXJ3o@Rk>
In-Reply-To: <agFzc-Ngf_ZFXJ3o@Rk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.1 (3.60.1-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|LVUPR11MB9786:EE_
x-ms-office365-filtering-correlation-id: 07a88ead-2028-4f74-6ebd-08deaf2d5e15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 6DJRl9GiBXY1PtNs4ehhEUwskeGyXKObWc/KqefKlDsAQZdk+PCDl1+Qnyn11TqzZK11Yt4G5nhL8hk2mCILhLmhxm2ROvb5JT8KmSABrZg0CH/7bwKYGwamayE21PDfrtSPV+grjCxDLuS2T4D6ujz4VARM9HXl2RlEcQPLHe/IB2G79ogwrarE7cWyTwzYZuhsyqTs7MIS4zlsVZZAyrF75bRjBeumoPXwWR2+fOXXkyQ/qotyJZ0iyJJB/bZCYD0p7SP/3TiswqwF9to/aBBlExsMuxw3N/QVTWYWWdqnbWwJQiZK0tTDz5SAEsy/KJLSPHtwwumEvsYan841BE1BbvvteVzXvYqrJYFItepetDqqrFTqyIn5UWY7hZYp8fg2qlL7QJHWHEo7hcH0UFogj+QPFjAWYG+GdNK9aUwPRAbLcSiXEQnMAvn5yme6WKXX9AFbs8qjbtXCclm3vfiL0tLbZlG3wjKmBETDNZUIChz08AGYqxoE1lyzvDnNnvLGJXzEzxv4eK6Tu13Tk5xPvuBxfYQJ2j4178kJMHhqx3HgrYl9Uelxiy1b4vsS234XWEV0WsT2MulGOODjW0rKtgb69VHEBbaOMoeFl+H5Zg8yb+p4fIa92zyQP1PkUQhvZ8or1o28HOqGA4lSl/xlTmIT+rD5+yNruVJyyryVXkTmGU7zdGM/iYbPZ6ORCSifrF2Z4JDMMmlILws8tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzBDa0RtS3RpUDVsSHpUS0dLbnk0ZTUyalpSUUhxUzFEa1c4N08ydTZId2pk?=
 =?utf-8?B?ZWU1SU5pTnM3VzVLdGtYQ091RHdIbjNyR2ZNM2xUeGcxODBkSlVsRmtMeVIy?=
 =?utf-8?B?UncwSWhIVDZ1VllsRGJWd1VxMG9iUGVBdDFMMUp3ME45cUlhZG5qZHNTVjNy?=
 =?utf-8?B?bmRkaXhFZ0RKNVNaUlVWejlVMzRyczZieXY0SGVIeWpKdUo1SDA0L1R6NHNX?=
 =?utf-8?B?QVBtS21XY0VXaWNNOVhQUkpWMDVmSmRlaHd2RzZKd3FPTHM2VzdQY0JrL1VY?=
 =?utf-8?B?YVA3V0RtV29nQzFCRjBaR0VrZDBYcHY2UHJ2RHlCUzk5WmtLTzVua2NHbGI2?=
 =?utf-8?B?MitMTklTR2Q3c3dOSG1JSk1penhpdXB6VFRDNEdPTVVVLzdtVUEyQ09KYk43?=
 =?utf-8?B?YjFMQVB0aHNKUHMrWkpPWVc5UFU2eWNZNkl1NG45bnFjanpQZG02R2VxL2Q0?=
 =?utf-8?B?cmg5bGVGSksvTnlPMVJhUmlQcStaRDZNTGlWK1EySWhOYUx0Kzg4aS9aWmZt?=
 =?utf-8?B?TDdKRXZETDBVdFdmaW1YR1hrSE9GS3lMbXp4TWJ5cWNDVy9YRDcxTWZ1UEt4?=
 =?utf-8?B?M1FkaGtUZnVmZlloamhlakF5WmJwOXpXcEhKRTljVmFlQzJsN0tRRGVaKzFB?=
 =?utf-8?B?aFNWM2NXUUwvWFF0azUrTXZBOC9uTlhheHJIemFXOEZFUm5FaEVNQlFOSU1l?=
 =?utf-8?B?K3Fna2FBMzNPU0xEWk1SeEg0bXBESWpxMlh4dDROU3p0T2JEekdiWFU1RG5r?=
 =?utf-8?B?eGRTK1ZJcmFmQ2crVVN4WTFSdWtBNWRwTGdaVEoxaWk2ZitDVlNVT3RUcTJY?=
 =?utf-8?B?eHZCVW9nOTJTL0NVdEZtUU5ROG5WT3JOb1ZBd3FBS1BrZGI3WDlpOHR0WlQ3?=
 =?utf-8?B?UE9JbnE1bXk1dy9nc2JxN3VVY2FtREVVa2NMNU53SjZjb0J5MmZNUkJ4dkQw?=
 =?utf-8?B?SHI5TjgrNXROSTY5ZDgzd1FrUHJDTjV6TW1OeTdiZ2NBSjFiNzRQRFA4dlNo?=
 =?utf-8?B?TFhWdC93MG5GTm0rN2p2eUs5L3lER09YeGxKa1pmaW9zWVdleUlsMGd1Zm1U?=
 =?utf-8?B?K0JBL1Y1c1Yvc0tEN0JOUjhKZ1BqdExHZllIclNkaGttcjJxVzVNV2EwZDBu?=
 =?utf-8?B?b1ZVMWlnaHg2bU81WExRUGwxRlNLbTduak5KUUtzR1EvUkY2Yys3V1lEZDRM?=
 =?utf-8?B?VXZrRGdXcDNCNGxUQzlVYWF6U3dBSm9TUWZqczd5WWNuQkNLWlZXTm1tMHZN?=
 =?utf-8?B?WUJ2SE0zSUNkSkNxN3NZN0VCcjBLNEpiK2F3OEJTRGZrNFBrUEZyWGJpVDZ1?=
 =?utf-8?B?RHRmL3cwTmYzZVJsdVQ5V0RmaHdpdWVmSHpid1JKTHpsNTRZV3VqY1JvazZL?=
 =?utf-8?B?L2JqVktNMFI3Y1NhbGVoV3o0NUpKNFFBelFZcVZia3NFcFFjbXd4d2VvYVha?=
 =?utf-8?B?dk5GNjJYbmw5RE9yNXlrdVNwZjVvdm9kSjJIR2FRSUpiY045Z0FtdW5FdlJo?=
 =?utf-8?B?ajQ1VzAvZkdlQjNkMUxDMkVhblJiZGhkWU5jQ3VYd294UzNrZHpyZ1V1Wlgw?=
 =?utf-8?B?Nm4wSUV2MkZ0MjNyb0pDVFp6THV1dTVqdnpzdklYeWdQeVhuT3dTdG5uSWwy?=
 =?utf-8?B?QkRXTnRZU0RHaEZJRE9vdzVOL3FqQWVJem1lL0dqYjIwSkRJZGV4Q3p1eWdT?=
 =?utf-8?B?aEhNYmRNeHozUzZjYUk1Tk5nMTZUdVJuWG9sMjhhaTlndWl2cjhCT1QzOVVy?=
 =?utf-8?B?LzYrR0JGa1BRRU1zUDBpSVhNTDUxd01jdHRoaWk3MmYvQUpib0krYno2YmJP?=
 =?utf-8?B?TFkwZDdnOHNXRzJKZmxTUm9JZDZZNXEweUpod0lYSlRhMFBLZ2hMV2dTS3Rq?=
 =?utf-8?B?VTBpckdCMTM4bGE1Z2hpRnBTbVVrZmJJWi9OT0ZQTEdFSjBzMXhpUEhmcFRl?=
 =?utf-8?B?L1VFNzBiZFpiV0JxTVNnQTV0V2pFdjlKOGlnYTZMWHRSeXlEUHV5MCtxTXdF?=
 =?utf-8?B?dnFtdk0yMDRVdHZqL3A2NFg1Q0ptTytPWlgxMGk0UHk1V25aQVdyTUJhK0N4?=
 =?utf-8?B?NHZvRWR5U3FVN2M4T2w5cUE1QnliMHB6WDFVN2dLQWNMQlQ5ZlVtNzBhVWM2?=
 =?utf-8?B?NVkzZHhDUUVPTnJKZGdBRERzRytEV2FGejk3VWVxWUR5YTFTWUt2NGlHeVVD?=
 =?utf-8?B?c003RWl3ZC9KckNreHNrWTlIRDNrbGR2VkV2MVVWbUVXZDNXeEZLSVR6enFl?=
 =?utf-8?B?Z3JnKzZnWVIvMDdoSFl5T0xNMFFCL1Z1QjdoVmx2SzM3T3YwS2lXQXFqTTE0?=
 =?utf-8?B?dG1aMHAxTFEvRTgweFV3YVlIbDhOeEdSMUtLK1c0RTY3Q1hhamdJSm1HZHE4?=
 =?utf-8?Q?qsU6yOIujNC0/IFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1935FF29AA105140B45F0D9C7EFA1AA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lrQnfcG1W9GoxdWSJa7Bv11nVJqm2aXG2f1Gru8vKHyXKYyO8h+cLIL3qsyaHDp58cVETq+TaxhcWOD1aRZMCTcdO7epIzytFsiCxuCp9JISgzwhH7+gRySIfFVdlUjerea8VVzEVYopJs6+p65mtcMwoyiE6i82Dmv+or8oXnLNSm0DM/sD/WaCS+sQJui+wMEgUD24fNNtAGoRtlaCtHh7bnWZu2w6yp7SUYbXO0heRaWGAn+C1oNkyXTR+NvHR6+I5oYS3BP3pSbC9EUh0H375PJVeEF0n2AEi3HlouCcr/7EJoCs5wXRlCmkMQBku6jlSL3kxqTN89sgvWbp4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a88ead-2028-4f74-6ebd-08deaf2d5e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 07:17:31.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItEGt1HYFkaPqMvz+UL1vBfJeK/AdEdreqk0pG1VjDYKS5PBH3sV2DhUlbGTfo5wyAR0eWCo9UVTA+22kf+snW4JC5/1JoN06voiQW4m5Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9786
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E1E6D508FC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36208-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,opensuse.org:url,gitlab.com:url];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emmanuel.grumbach@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

SGksDQoNCg0KT24gTW9uLCAyMDI2LTA1LTExIGF0IDE0OjQ5ICswODAwLCBDb2lieSBYdSB3cm90
ZToNCj4gSGkgRW1tYW51ZWwsDQo+IA0KPiBJIG5vdGljZSBzaW5jZSB2Ni4xNS1yYzIsIG1vc3Qg
b2YgdGhlIHRpbWVzIHRoZSBuZXR3b3JrIHdvbid0IGJlIGJhY2sNCj4gYWdhaW4gYWZ0ZXIgcmVz
dW1pbmcgZnJvbSBzdXNwZW5kLiBBbmQgc29tZXRpbWVzIEkgbmVlZCB0byBydW4NCj4gInN5c3Rl
bWN0bCBzdXNwZW5kIiBmb3IgOCBvciA5IGNvbnNlY3V0aXZlIHRpbWVzIHRvIG1ha2UgV0lGSQ0K
PiBhdmFpbGFibGUNCj4gYWdhaW4uIGJpc2VjdCBhbmQgbWFudWFsIHJldmVydGluZyBzaG93IDE1
MjIwYTI1NzMxOSAoIndpZmk6IGl3bHdpZmk6DQo+IGRvbid0IHdhcm4gaWYgdGhlIE5JQyBpcyBn
b25lIGluIHJlc3VtZSIpIGlzIHRoZSAxc3QgYmFkIGNvbW1pdC4gDQo+IA0KDQpUaGlzIGlzIC4u
LiBzdHJhbmdlLg0KQ2FuIHlvdSB0cnkgdG8gdXNlIG91ciBiYWNrcG9ydCB0cmVlPw0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9iYWNrcG9y
dC1pd2x3aWZpLmdpdC9sb2cvDQoNCkkgYW0gcHJldHR5IHN1cmUgaXQgd29uJ3Qgc29sdmUgYW55
dGhpbmcsIGJ1dCBhdCBsZWFzdCwgaXQnbGwgbWFrZSBpdA0KZWFzaWVyIGZvciB1cyB0byB3b3Jr
IHRvZ2V0aGVyIG9uIHRoaXMgaXNzdWUuDQoNCkFsc28sIG1heSBJIHN1Z2dlc3QgeW91IG9wZW4g
YSBidWd6aWxsYSB0aWNrZXQgb24gdGhlIGRyaXZlcnMgLw0Kd2lyZWxlc3MtaW50ZWwgY29tcG9u
ZW50Pw0KQXMgYSBzdGFydGluZyBwb2ludCwgSSdsbCBhYnNvbHV0ZWx5IG5lZWQgdGhlIGtlcm5l
bCBsb2cuDQoNCg0KPiBIZXJlIGFyZSBzb21lIG90aGVyIGNsdWVzIHRoYXQgbWF5IGhlbHAgcmVz
b2x2ZSB0aGlzIGlzc3VlLA0KPiANCj4gwqDCoMKgwqAgMS4gQW4gaXdsd2lmaSBzZXR0aW5nIFsx
XSBjYW4gbWFrZSB0aGlzIGlzc3VlIGRpc2FwcGVhciwNCj4gwqDCoMKgwqDCoMKgwqAgb3B0aW9u
cyBpd2x3aWZpIHN3Y3J5cHRvPTANCj4gwqDCoMKgwqDCoMKgwqAgb3B0aW9ucyBpd2x3aWZpIGJ0
X2NvZXhfYWN0aXZlPTANCj4gwqDCoMKgwqDCoMKgwqAgb3B0aW9ucyBpd2x3aWZpIHBvd2VyX3Nh
dmU9MA0KPiDCoMKgwqDCoMKgwqDCoCBvcHRpb25zIGl3bHdpZmkgdWFwc2RfZGlzYWJsZT0xDQo+
IMKgwqDCoMKgwqDCoMKgIG9wdGlvbnMgaXdsbXZtIHBvd2VyX3NjaGVtZT0xDQoNClRoaXMgaXMg
ZXZlbiBtb3JlIHN0cmFuZ2UuDQoNCj4gDQo+IMKgwqDCoMKgIDIuIEJlZm9yZSB2Ni4xNS1yYzIs
IHRoZSBpc3N1ZSByYXJlbHkgaGFwcGVucy4gQW5kIGlmIGl0DQo+IGhhcHBlbnMsDQo+IMKgwqDC
oMKgwqDCoMKgIHNpbXBseSBzdXNwZW5kaW5nIG9uY2UgY2FuIGJyaW5nIHRoZSBuZXR3b3JrIG9u
bGluZSBhZ2Fpbi4NCj4gT3RoZXINCj4gwqDCoMKgwqDCoMKgwqAgdXNlcnMgc2VlbSB0byBoYXZl
IGV4cGVyaWVuY2VkIHRoZSBzYW1lIGlzc3VlIGUuZy4gWzJdWzNdWzRdLg0KPiANCj4gwqDCoMKg
wqAgMy4gU3VzcGVuZGluZyBieSAicnRjd2FrZSAtbSBtZW0gLXMgNSIgaW5zdGVhZCBvZiBieSAi
c3lzdGVtY2wNCj4gc3VzcGVuZCINCj4gwqDCoMKgwqDCoMKgwqAgY2FuIG1ha2UgaXQgbXVjaCBl
YXNpZXIgdG8gcmVwcm9kdWNlIHRoaXMgaXNzdWUgZm9yIGtlcm5lbHMNCj4gb2xkZXINCj4gwqDC
oMKgwqDCoMKgwqAgdGhhbiB2Ni4xNS1yYzIuDQo+IA0KPiBJZiB5b3UgbmVlZCBtb3JlIGRldGFp
bHMgZnJvbSBtZSwgZmVlbCBmcmVlIHRvIGxldCBtZSBrbm93ISBBbmQgSSdsbA0KPiB2ZXJ5IGhh
cHB5IHRvIHRlc3QgYW55IHBvc3NpYmxlIHNvbHV0aW9ucy4gVGhhbmtzIQ0KDQpNeSBwcm9ibGVt
IGhlcmUgaXMgdGhhdCB3ZSBzZWVtIHRvIGJlIHRhbGtpbmcgYWJvdXQgInRoZSBpc3N1ZSIgYnV0
IHdlDQpkb24ndCBrbm93IGV4YWN0bHkgd2hpY2ggb25lLi4uIExldCdzIHN0YXJ0IHdpdGggYSBi
dWd6aWxsYSB0aWNrZXQgd2l0aA0KbG9ncy4NCg0KDQo8c25pcD4NCg0KPiBJIGNhbid0IGJpc2Vj
dCBhZ2FpbnN0IHVwc3RyZWFtIGtlcm5lbCBkaXJlY3RseSBiZWNhdXNlIHY2LjE1LXJjMg0KPiB3
b24ndA0KPiBiZSBhYmxlIHRvIG1vdW50IG15IHJvb3QgcGFydGl0aW9uLiBTbyBJIG1hbnVhbGx5
IHJldmVydGVkIHVwc3RyZWFtDQo+IDE1MjIwYTI1NzMxOSAoIndpZmk6IGl3bHdpZmk6IGRvbid0
IHdhcm4gaWYgdGhlIE5JQyBpcyBnb25lIGluDQo+IHJlc3VtZSIpDQo+IGluIHY2LjE1IHRvIGNv
bmZpcm0gaXQncyBpbmRlZWQgdGhlIGJhZCBjb21taXQuDQo+IA0KPiBbMV0gaHR0cHM6Ly9iYnMu
YXJjaGxpbnV4Lm9yZy92aWV3dG9waWMucGhwP3BpZD0yMjI3MjAyI3AyMjI3MjAyDQo+IFsyXSBo
dHRwczovL2Jicy5hcmNobGludXgub3JnL3ZpZXd0b3BpYy5waHA/aWQ9MzAxOTcxDQo+IFszXQ0K
PiBodHRwczovL2Rpc2N1c3Npb24uZmVkb3JhcHJvamVjdC5vcmcvdC9yYW5kb20td2ktZmktYWRh
cHRlci1sb3NzLW9uLWZlZG9yYS00Mi1pbnRlbC1hbGRlci1sYWtlLXAtY252aS8xNTI4NzgNCj4g
WzRdDQo+IGh0dHBzOi8vZm9ydW1zLm9wZW5zdXNlLm9yZy90L3dpZmktc3VkZGVubHktbm8tbW9y
ZS1hdmFpbGFibGUvMTg0Mzk5DQo+IFs1XQ0KPiBodHRwczovL2dpdGh1Yi5jb20vY29pYnkva2Vy
bmVsLWF1dG8tYmlzZWN0L3RyZWUvcmFuZG9tX2lzc3VlX2Jpc2VjdA0KPiBbNl0gaHR0cHM6Ly9n
aXRodWIuY29tL3Joa2R1bXAva2VybmVsLWF1dG8tYmlzZWN0DQo+IFs3XQ0KPiBodHRwczovL2dp
dGxhYi5jb20vY2tpLXByb2plY3Qva2VybmVsLWFyay8tL2NvbW1pdC82NDUzZTg5MmNmODZjOTAw
ZDUxZjU4ODRlOTAxM2UwZGJlZWVhNGFkDQo+IA0KDQpUaG9zZSB0aWNrZXRzIGFyZSBhbGwgb3Zl
ciB0aGUgcGxhY2UgYW5kIHVuZm9ydHVuYXRlbHksIG5vdGhpbmcgdmVyeQ0KY29uY2x1c2l2ZSBj
b21lcyB1cCBmcm9tIHRob3NlIGxpbmtzLg0K

