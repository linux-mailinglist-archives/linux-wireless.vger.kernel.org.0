Return-Path: <linux-wireless+bounces-18089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F33A211F3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 20:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84E63A3D54
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58A13BADF;
	Tue, 28 Jan 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKz39sCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76768748D;
	Tue, 28 Jan 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091060; cv=fail; b=AxsFNxvJjTh21yAp30zi1dHw8KrpGnTyU0knRIF069fzIYOpUHui1XAkYYfuKPoY1VWS10IRjtAE9BvhxG63PU05x7cVPfRdCPmODEXmr0zEafLwCj6Im6TbWAxh4Epzc7dNjaEBOyTc2FwfnJPzBs04AQnyawsTT0n/LQqFZ9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091060; c=relaxed/simple;
	bh=RbYkMClGhcgzKbkymV6ONplsGCyxVCmGuYUFtrYB5c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=coJI6BI7ZJ2F569eoo9i3pa7WE8lg4uQ5VSlOw9McPInq6lGA76JGtkLWuiLzmFkz+lpEGi/Ba7PpwSwSEnUjvtPHmkJg7irPFfNSVJLZMAdhG0kRXezXflYkKof9NStXsmaeUqQasYN9KAydRhT1Va2OMKlUjlRjFfnH/xhxTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKz39sCQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738091058; x=1769627058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RbYkMClGhcgzKbkymV6ONplsGCyxVCmGuYUFtrYB5c0=;
  b=OKz39sCQ/Uw7TGPCUTZpiUtFTvaRKwCx9l2BR2wc0INmbU8+0Wbs8v4s
   cCJktapSXtS9KZVlQW3l9Fa555DP5ENTNA3tIQQ6iYWVtHcqOfSXpU791
   YxVANcG9VQDrizLah9Upnp9ZjAUf8vSVlJ+mt+GDabmJhXLFwNyQfru3T
   /IgR/5N62m3ULM2Kg3AgRbNUQ/THVt0+X+2UlQ13SCGY0qa8+IDBNhsAi
   6kP7jeMv/Je7Ebbqvb5Uxk1UgRv4mc/8Ys1Xs0MC7xeYNb1MleaTCp06d
   n1UuLI8z6C74fBRUrihDXuSi0oD8GyLKnFzIDQrCUkaLjmTgg7R8E7FHj
   Q==;
X-CSE-ConnectionGUID: vAHaXPJGRZanhwWGSy/H8Q==
X-CSE-MsgGUID: bS+/hFaST6ORMS+0p2dTxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50007547"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50007547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 11:04:17 -0800
X-CSE-ConnectionGUID: iBohXrI7S3C/OKd1RQLOwQ==
X-CSE-MsgGUID: m5BM+UxkSUq+4zYCoQoE/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109738111"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 11:04:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 11:04:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 11:04:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 11:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQLaWYdp6ExSd0sp5k/Z2aofHyaMhIU71R+ymWBQc2FlBIDq1u7HRPuF+ZenIH0yFNOKpcymFOQI2c/Au01iwpqJSCuWIFVFTz7fUZcmL4YLAA8T7Yce5fjgTc4zlxMG4VogKI6lLDJHg3rv02IKcjpbN15+NKiuusO/sGVhqe14gW9296+Ca3zqc9SMeth0DHqxXEv8oMiy9hZHniFICluQ0pfGqvx19MHNdVf1NqyKoLLzy8RpTTNln8e1umWYgfabnNZuXp8IX4X+csu/zRA7WMijCrRaxeGpD4INCNHSOJ2v7qZDngxjaDVoBM9OOZi+FXLF10lZw4pdANkohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbYkMClGhcgzKbkymV6ONplsGCyxVCmGuYUFtrYB5c0=;
 b=TY04RwQnqqT8KAJZdTWvM53o1V8FRuYH9CP6E7s4I9HcgvD8GjLY+T1WDYly4ZevEcp+9zJzeOvJrBKM1Q+MjV363kbgV0CtLQq4tMN4R6s7WdSXhX80B6h+PFA4AHok7KWM3D9wwj+Rd4aIBlobo8hirmwiMOX7pRL9djfPi6BhMKli7QUNinrwdxiR8edGLPp8IFnII1PVBh2XHj6G2b5QPuVFn19qcfyPhmz0AreHdwDeVlIkZLUU1BOgPzFZnoTlzyMZLM5HdCUsSfFxQ5/roLSzfeIGMWVgmrMrM8Y8HL12ZXnvHH0CJO/okVUwBEF+GFfZ/JE6jBeO4AADjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Tue, 28 Jan
 2025 19:04:14 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 19:04:14 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] iwlwifi: Cleaning up deadcode
Thread-Topic: [PATCH 0/6] iwlwifi: Cleaning up deadcode
Thread-Index: AQHbVNqB4hb3KRG61EmqUhxEhXw9NLMsv+eAgAAE2kA=
Date: Tue, 28 Jan 2025 19:04:13 +0000
Message-ID: <MW5PR11MB5810E64A405DBCE4F472A253A3EF2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20241223013202.340180-1-linux@treblig.org>
 <Z5kly5whELp8h1k3@gallifrey>
In-Reply-To: <Z5kly5whELp8h1k3@gallifrey>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH0PR11MB4920:EE_
x-ms-office365-filtering-correlation-id: 413a6a19-eeeb-4518-4d02-08dd3fce8e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVJoaVJjTkltaVJnM3psVjF5U0FuMnM1RWgvNXlzZTV5SzlFdm92UGdBNzc4?=
 =?utf-8?B?VDQrYW03SnZhR20ycUtkWHlTdklpSk9sa1BMSk42SVI2ekcycmNjUUZEa1RZ?=
 =?utf-8?B?NzZNS2F2azNzT3BTWUY1L2xFenFVM1BUd2l1OVBwMWFYeThpWWg5dlYrZkJh?=
 =?utf-8?B?c3RDSlc4M3ZmMXAwNkJ5WDA2Q0RsUnd2a0gyTG5mWUhXclprem4yV2swOXh0?=
 =?utf-8?B?ajd1NmwwNTdoaEJyS1N0SFR2N2ZZYTdMc0p0aGpOWjhCdElwRTdvMlRET2Iz?=
 =?utf-8?B?L2hHQ3Naam51cEtTbVVQVGJ0R3krMzEzOEVCVVV1WWJ2UWxCdmRvbUpLMTg5?=
 =?utf-8?B?bEJ3a3djd1N2czZEdFdIR2NHWUY3cEFWeGdKUnQ1ZE83WGlMa0E1eHYvZGJw?=
 =?utf-8?B?NUlUZStmVCtNRHFxQ1JOdm55SS8yR3JkNXM1VE9NeXQ2WmUxNWVNVVcvNlVZ?=
 =?utf-8?B?bnNsLzlFdldBRjlFbGxxYWhRaWU5c2R1b2lKZUV0M1Vycnhmd0hRWkU4MVhh?=
 =?utf-8?B?Z0ZnSHhEMlNPU0czVXRUbTJBQ0hjNjMyeDZlK0xLa3FNS3duTmNBQmMrNVJ4?=
 =?utf-8?B?dnBMMU0xUTVjYlhEcStlMTNGV0xWTGxaNjE4Zis0NStvVjNqc2JTYmhUUDRu?=
 =?utf-8?B?Y1NrU2s1QUltR0p2WHpOaFVWNFpxQzNHU1hGbGoydVBRSmVMZkV4NkZpRVJh?=
 =?utf-8?B?UlYrSHUvQTZyVWx0SmdnZ2pFUDBjWE5IbEdLN2lEYnk1NU10QjVBcHFXK3hl?=
 =?utf-8?B?QTEzQ0xONzdlelgwcDFBaFBFaU9JTStjZkNoU1VzT3YwZFdhRiswODl1em45?=
 =?utf-8?B?Qk5tSEZ0YXlVNEo4MHVZSFZ1UzlEaExLUHQ4Nkc0dlpYVXFYenJTQ1NCazVN?=
 =?utf-8?B?RzdWVTU5bWJLMTlUMmZGT2VrWGlrazBNckhwTG9RZWthRVRaMUgwbitjVXJL?=
 =?utf-8?B?UGRIbmZFRkZVd2ZMWXJPNDhFL25tb24yV2pUSTYzSERBZkJsdDRhdUMwQzNj?=
 =?utf-8?B?VTNvV2wvMkF2TE01eXIyeWtjWUVmZFNIS0RqOHJaMC9mNTE3TkZncWdPRnV2?=
 =?utf-8?B?aUwrSkxwZXNzbEtiaDRZbi9PQTRscndnMHR1SjNDRDBXVWdHc3JIdUZZWHFu?=
 =?utf-8?B?bmtzMHVLV1lhVHUxMzc1dWVTYXg5NmkybEVqQTYwWHZsaXFrU0d0Yk1heWNx?=
 =?utf-8?B?OVUzWmt0bUg5blpJVjZ4L2loNkY2S3FZM1lNT0dEQnhPYmhoQTRFdkthWmt1?=
 =?utf-8?B?Z1dTS0I1U09uUE56Y0lkMmcxN0NWNGcwTUVGZXpUcmJwSlp3akFQeDNJM280?=
 =?utf-8?B?TS9XZElyemNsTUI0THp4d3Z4NGRpby9UelhXNGcrSGpoTDZRVXpNL0w3OHlq?=
 =?utf-8?B?dFdJUVJPb2ZucTlFa2owcFRObjJycjB0eVA3YWJRRmk0RXk3eDFUVDJYTks2?=
 =?utf-8?B?MVZpQkc4NVZwMDB5Qy9XamtRL0MzeENaQ0VKTmFkcGxiRkpkNDlNNExXTld1?=
 =?utf-8?B?c2EwMnUxQjRhRkRsbWw1eVhWRWlmNDRNaW9zTlo5bjFITXNhYmhUbmNxOHk5?=
 =?utf-8?B?aGd5a2lqQzFZMWJzYTdGNkpmU2oxaU9HK3dHbWtJalExWUd5dWl0a0VCY2RO?=
 =?utf-8?B?ekh2dDdHeVF0dmdud2V2YnZ6bjNMbWJwWVp6VlZmVjVHR0dDSll1YkdSeHZ6?=
 =?utf-8?B?U3JtTXlWbFA5ZFN4eURPeVpzVUNRNWlrUmRBZW9KeERFQmZPRW9hNGtVK0Zo?=
 =?utf-8?B?UEtjdDltV0pFK2xRN0daMVZhdThwV0FyVS9XZ1o3ckVINWdDdUJnZnRzY3Q5?=
 =?utf-8?B?ZFo5ZGlEYUFwYVpqbGNyOWJ2Y2FsWnNIZ3ZKNzUrTFFRZTV4Wm5pa1laangr?=
 =?utf-8?Q?/qtayW6iW6TmN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHN4TUNjVmozK0UwQitTZHdqZnArWjRZckx5T0pZQngyNjhtSW9oQ0IzTnVR?=
 =?utf-8?B?NjhPVmZOdCtCTTBBaHVodGVnUkpybDEzaE42Qi9rOUYyVXFtamJFZDJqZ1RK?=
 =?utf-8?B?Y0FIOWJJbzBWNk9NUnUreU1DQVVSU1RWK2FlQk9HaXJTZVJYL0x2QVRWV1BJ?=
 =?utf-8?B?WmxuU0dEaVkvbnZVY1NWL3l2RWhWTm9iU0poMkQxeFdyazlZWDlpVGZ5bFVQ?=
 =?utf-8?B?ZHV2Vzl0blRZMG5oZ2FIWW5KekQxT1FZN09yeEdENXhLZU5YcWJ3c2RCZE1Y?=
 =?utf-8?B?NVdBczU2TldwUE1teG5GYVVsR25aaTg4RlQrTzVwWDkzUU45ZWN3Z1p0enFr?=
 =?utf-8?B?bUFBYS9BVm45U2xMOWU2WW9RYUUvdWZwZGtvRWUvZlN3VHdlYmpMWU53UU9u?=
 =?utf-8?B?b21IRFhad1RqZzFDQzF0ZTN2a1crNnJtQnQvaGtTVjlscUJOK1I4TmpsalFS?=
 =?utf-8?B?ZWFOc3E1VnBsZ2lUTXZ3cllCYllvSzFQbTdBU09kaVZ0a1RhVXVZbm9jbGo3?=
 =?utf-8?B?VUR4SE0vYUgzRHRUWENQeWJ6OGFyRlEwQTNZOHNnbVdvOVZVQk13dXBWL2hT?=
 =?utf-8?B?a1ZaQnltVnZyU3lFL2I5bUlXUEdKcmZjNjNwSFJySzZnTTRuVXlxM21CZ2pK?=
 =?utf-8?B?cXUxN1o2UVQ4TWl0NUNPK1BpUHVmRjYwRlcwdUtLd1hXUkZZM0ZHWGgrSjgw?=
 =?utf-8?B?akdBNlo3dVEyd3ZFYURRN1JFMVdNMUNuSFJsUjBwM0hqSDZmb3pNVEhTTG1h?=
 =?utf-8?B?NnJpdXViNTFhc1RkMnhOSmEwUkNuTTV6SEZ0bjRuTUpFUm9GVk1YVmRkSFd4?=
 =?utf-8?B?VS83WVJWdmxzS0N5WktSL0MvaWdvLzVsc0NCM3pldjFodFFPSGZxSVhialVs?=
 =?utf-8?B?Q2Q0ZE0ybmpldFZMR2t1aDFPV05UZ2tMeVoxODNJZmJadU5pYjFicUQwa0I2?=
 =?utf-8?B?OFVub1IvMUdkNVREdFV4L1J1R1I2aURmZTJkS1V2eTVtME81RXFIVmNadlNl?=
 =?utf-8?B?ZzQwSVQ2Y25qV29uYi94SXVOMUNCSGw4eFBuQXlKY29ncFRTTUVJMWhjOTBM?=
 =?utf-8?B?YXlOK1IwYW5INlZMNVJRbW1uYWxEVXdUWk5LSENmalYrNnJvdVdsTEVWbTFS?=
 =?utf-8?B?YjFNNVFNUVd4SVhBWk5pS2JjSnFYVFl0ZnQyYWV2QmhKaHBNdmliWjZsSU9D?=
 =?utf-8?B?dkJvZjBTZXRia1c4NmRrczRQRFlXektrT3c2RmtKTmxrajRrQ3Fpc0xDMVg2?=
 =?utf-8?B?eTVnUG1TejkyMmdYUldsbWovUjFNS3lZYlV5aDJob1BFMk9xQlJwdlFVbDEy?=
 =?utf-8?B?aStxYVMzcXBnNUNNTTdHQm1MSThCY09WTThlaUc4MmFHNHQxSml4V2JzWnk4?=
 =?utf-8?B?OUp0N0RlWW9iOHlubFVFWmZsK0NwN1IwQ3NwNTJtbTh4NmNUcFlEcG5YRURl?=
 =?utf-8?B?a0o1aVRvalNQdDhBdTBkTkZSbkVYSmo4QUI1R3JIK21jZE4ydlpyS3pGakdG?=
 =?utf-8?B?eTlzeEsyb1M2eDEwNUZkVWFjL0d6WGM0MUxha1FkWkJjWktoUGIvUjZERktm?=
 =?utf-8?B?eDJ6SzNZOUdPQkdVVk1pTzVOc1E2WEpyTE14eGFBTWZxVG1iNjFYYmt2R3Zk?=
 =?utf-8?B?NHBCNlpSWWVQZkF5RlEwUkJKbXVRcUc1b0Y5OGVTd0lOSWZRd3Q0alJkc1hS?=
 =?utf-8?B?TVlVMHJBMWt3UklWS1NNcjd5bVZpOVJmQ2VUNW5teTRLUTFuRkV4bDdERzIx?=
 =?utf-8?B?TVBSU2UwOVJIRTBQeWtIdThzMFQ2RUJVMitVS0pjQ3Q4TkFUZ1Noa0UrejdB?=
 =?utf-8?B?NVhMYlJVbEczQXdBNzJ6ZWRENDNSUTdSVTJSRnN3OU1acFV6WEc1RXMxa1BY?=
 =?utf-8?B?S084SmhEY3dpRWZpZHo3c1FYNll0K0o0Qno5OTVQVUs2dEJkdXZlTDBOZ0JI?=
 =?utf-8?B?aDZ1VVlJUWIzM1dHbXZNc1dkVTNGQ0NRUWFBUUlGdkw1ZkpDaTBDaUVKK0Rv?=
 =?utf-8?B?RkNTZWJ3TkZpM1hyMVlWeUZsWXZyUzdOS1RXTDJxem0rUnpXNXh2bk5OSlUv?=
 =?utf-8?B?MktXTkRtRU1wQW9IK3pENVB6TmVYMlFkTmd0N2lpRDg1NG5RY3pPMi93b2hl?=
 =?utf-8?B?bEpiMmZlcFkzNmkxc0E5RmJNSEk4K2szMUR3SE5qK1BFVXlQZmkrY002MVZE?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413a6a19-eeeb-4518-4d02-08dd3fce8e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 19:04:14.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3WBForox4kHTNLckuJ2x1gr21HpwSv77Fa1kjKr3BII6Bgxr+4n0BuI259tvqdfhNOrgHIV2oebuAMyy38ESUaui0Q0XjJ7Rea5zDs7CBwmmBYYMtRnUfYByasvz+6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHIuIERhdmlkIEFsYW4g
R2lsYmVydCA8bGludXhAdHJlYmxpZy5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIDI4IEphbnVhcnkg
MjAyNSAyMDo0Ng0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVs
LmtvcmVuYmxpdEBpbnRlbC5jb20+Ow0KPiBrdmFsb0BrZXJuZWwub3JnOyBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAwLzZdIGl3bHdpZmk6IENsZWFuaW5nIHVwIGRlYWRjb2RlDQo+
IA0KPiAqIGxpbnV4QHRyZWJsaWcub3JnIChsaW51eEB0cmVibGlnLm9yZykgd3JvdGU6DQo+ID4g
RnJvbTogIkRyLiBEYXZpZCBBbGFuIEdpbGJlcnQiIDxsaW51eEB0cmVibGlnLm9yZz4NCj4gPg0K
PiA+IEhpLA0KPiA+ICAgVGhpcyBpcyBhIGNvbGxlY3Rpb24gb2YgcmVtb3ZhbCBvZiBmdW5jdGlv
bnMgdGhhdCBoYXZlIGJlZW4gdXNlZCBmb3INCj4gPiBtb3JlIHRoYW4gYSBmZXcgeWVhcnMuDQo+
ID4NCj4gPiAgIFRoZXJlIGFyZSBhbHNvIGEgaGFuZGZ1bCBvZiBzdHJpbmcgYW5kIG9uZSBzdHJ1
Y3R1cmUgcmVtb3ZhbCB0aGF0DQo+ID4gYXJlIGp1c3QgbGVmdCBvdmVycyBmcm9tIGEgcmVjZW50
IGNvbW1pdC4NCj4gPg0KPiA+IFRoZXkncmUgYWxsIGVudGlyZSBmdW5jdGlvbi9zdHJ1Y3R1cmUv
c3RyaW5nIHJlbW92YWwuDQo+ID4NCj4gPiBCdWlsZCB0ZXN0ZWQgb25seS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgPGxpbnV4QHRyZWJsaWcub3JnPg0K
PiANCj4gQSBnZW50bGUgcGluZyBvbiB0aGlzIGp1c3QtcHJlLWNocmlzdG1hcyBzZXQgcGxlYXNl
Lg0KPiBUaGFua3MhDQo+IA0KPiBEYXZlDQo+IA0KPiA+DQo+ID4NCj4gPiBEci4gRGF2aWQgQWxh
biBHaWxiZXJ0ICg2KToNCj4gPiAgIGl3bHdpZmk6IFJlbW92ZSB1bnVzZWQgaXdsX3J4X2FudF9y
ZXN0cmljdGlvbg0KPiA+ICAgaXdsd2lmaTogUmVtb3ZlIHVudXNlZCBpd2xfbXZtX3J4X21pc3Nl
ZF92YXBfbm90aWYNCj4gPiAgIGl3bHdpZmk6IFJlbW92ZSB1bnVzZWQgaXdsX212bV9mdG1fKl9h
ZGRfcGFzbl9zdGEgZnVuY3Rpb25zDQo+ID4gICBpd2x3aWZpOiBSZW1vdmUgdW51c2VkIGl3bF9t
dm1fZnRtX2FkZF9wYXNuX3N0YQ0KPiA+ICAgaXdsd2lmaTogUmVtb3ZlIHVudXNlZCBpd2xfYnpf
bmFtZQ0KPiA+ICAgaXdsd2lmaTogUmVtb3ZlIG9sZCBkZXZpY2UgZGF0YQ0KPiA+DQo+ID4gIC4u
Li9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAuYyAgICB8ICAgMSAtDQo+ID4g
IC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvYXgyMTAuYyAgICB8ICAgOCAtLQ0K
PiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9iei5jICAgfCAgIDEg
LQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2R2bS90dC5jICAgfCAg
MTEgLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vdHQuaCAg
IHwgICAxIC0NCj4gPiAgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1jb25maWcu
aCAgIHwgICA0IC0NCj4gPiAgLi4uL2ludGVsL2l3bHdpZmkvbXZtL2Z0bS1pbml0aWF0b3IuYyAg
ICAgICAgIHwgMTAxIC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAuLi4vaW50ZWwvaXdsd2lmaS9t
dm0vZnRtLXJlc3BvbmRlci5jICAgICAgICAgfCAgODYgLS0tLS0tLS0tLS0tLS0tDQo+ID4gIC4u
Li9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQuYyB8ICAyMyAtLS0tDQo+
ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmggIHwgIDEyIC0t
LQ0KPiA+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3N0YS5jICB8ICA2
MSAtLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9zdGEuaCAgfCAgIDQgLQ0KPiA+ICAxMiBmaWxlcyBjaGFuZ2VkLCAzMTMgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDcuMQ0KPiA+DQo+IC0tDQo+ICAtLS0tLU9wZW4gdXAgeW91
ciBleWVzLCBvcGVuIHVwIHlvdXIgbWluZCwgb3BlbiB1cCB5b3VyIGNvZGUgLS0tLS0tLQ0KPiAv
IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgICAgfCAgICAgICBSdW5uaW5nIEdOVS9MaW51eCAgICAg
ICB8IEhhcHB5ICBcDQo+IFwgICAgICAgIGRhdmUgQCB0cmVibGlnLm9yZyB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgSW4gSGV4IC8NCj4gIFwgX19fX19fX19fX19fX19fX19fX19f
X19fX3xfX19fXyBodHRwOi8vd3d3LnRyZWJsaWcub3JnICAgfF9fX19fX18vDQoNCg0KQWNrZWQt
Ynk6IE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo=

