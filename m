Return-Path: <linux-wireless+bounces-16602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58C9F7AB4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8AF16283B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393A223710;
	Thu, 19 Dec 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQECEI2e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B122236F4;
	Thu, 19 Dec 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609094; cv=fail; b=dHueUy4kdAEAZOHFsl+petFekX0oleTLkuVUW1cYS46dIEqfjzpJcbDt74e3P/f4EPp3++ax3rx36ma7Skb26KVTVk/LFd9ZEOmyPn4MsLx3JMW4o7855z5IEqaEbzD6ZemTKTix8HD7OnmlwL5y15qMIC81EDq0bTceyqZ1TYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609094; c=relaxed/simple;
	bh=6m92MB2Wk0GbQ7RCDDMpYYoLYAlyb9HKbxjLgvtwmVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxr/6y6O8YcEd/cSbrHFEht6VtbEJbs1DenGz3SlPFh0EZZy0ScckyxnZX9Rv8Y2Ap0XDWfDJyunBdzmOZAMiYGTMNYwSe2XZ9/bmuQhOPMCJg98vBGEw5xYiSJABXT2/J0PaBm6tpC7iR6vlcAanmfhI+m0/26wl8hNxDy6NcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQECEI2e; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734609092; x=1766145092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6m92MB2Wk0GbQ7RCDDMpYYoLYAlyb9HKbxjLgvtwmVI=;
  b=ZQECEI2eGUqXj5pyEv/jWxuLw5aARbV1Hqy+5rQU09Ia/Ht4cG4PXjrE
   nmp4rH/iRWW2cbZWou2AJ9eFqNrkbXdeVuRWmT6GLsTMbbtu+3CHbU9He
   Midh58XHCCQthKRUGgudjrrtAfllelD0eUacJlqmS5D9Rr3E021Zm6czD
   iUpHkTWmnhgDHAvjJrE5pDGdSPZgN6Ix/e9jbDM4zJCsDqRizYSJEntAh
   j3hFd+bc+xn8IGLXdsJe+tGIQ0UJPihOzzKNm9fHf/MAscC4AEsIysmLu
   BL3/X3RkFhBrA2mzqp+T5H58XCaAAiTta1d/telMse0Uhjii9ewdpRfMd
   Q==;
X-CSE-ConnectionGUID: 0w4a8S4XQ6qwn6SQ65yOsQ==
X-CSE-MsgGUID: CsUISq4eRFqsQ6WxUq32/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52641313"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="52641313"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 03:51:28 -0800
X-CSE-ConnectionGUID: nofRSrLYSkSzJAGBpVQ7ZA==
X-CSE-MsgGUID: 7RAzL6pTTTSZwHUGSfIrIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98989563"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 03:51:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 03:51:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 03:51:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 03:51:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFrsLunU9CgRkZGSVOOujUnAGkjux6xjiAFBrjUJbcwWJoOVzf3/WV9FJcvCRjkIBUfkwwQVZ/PtMlP1SkPuGdimDjZ19H2/8b86Wy3vECH+eqFfa4nAdhIO7bGX8GSLhp3cul6abvOr58+p9FXJSs5sRCvERoG4hWwFnP3CxQBvltkmTL2y3MEME3XA2z+HqDZkcasHN81zRKwQaTfcry73uY4/wKXtJekuRoJMl6yGLvIWPIXFGemVmhINFMWSNG0XafEdJ89aoC2LeqZB9RDKEZVzpzJYAukla5cv8ko78FPNpKxNHiV3pps1ke7tB0ift8XnHGDtIS9GJb7ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m92MB2Wk0GbQ7RCDDMpYYoLYAlyb9HKbxjLgvtwmVI=;
 b=WhWQ5hSCBeZkTMWaHtxZNkU+jMHAaJ+lnaKHWYIDHqv3eIgBLJsyWf3+OKI9+Cz9lrIXgT94OC4DJXO35df0sMijfnHhM7FXPEudut6XKfdsdZhd5kXtNTnUnIQ0JC+xuAsj6RsVnRTAAZYFZDN75jclO89wERLeM9IpUuQGWbaGZh8+6Pcs3dP0iLECqAjwQinDs64JYl7Q4wrrYBynraORDj1I+02JpC6cggxJB1wlX0XmC2CYvDn6XcZMEOHpUuB148fpG53DUS/ItY8ugRCJbYtChDRUexCVaCJUM5QeNmKC5iTbNDD15yUj6hRR4RPsoHcLdeDSsdEfigjXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 11:51:09 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 11:51:08 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Rolf Eike Beer <eb@emlix.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>
Subject: RE: wifi: iwlwifi: fix documentation about initial values in station
 table
Thread-Topic: wifi: iwlwifi: fix documentation about initial values in station
 table
Thread-Index: AQHbUf/w29vMxAJLuEaBx8iLVDKE9rLtdAMA
Date: Thu, 19 Dec 2024 11:51:08 +0000
Message-ID: <MW5PR11MB5810609CEE8C0830676215A7A3062@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <2008554.usQuhbGJ8B@devpool47.emlix.com>
In-Reply-To: <2008554.usQuhbGJ8B@devpool47.emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DM4PR11MB5229:EE_
x-ms-office365-filtering-correlation-id: 437854f8-ceca-49f2-7158-08dd20236d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXVzaUo5RHlwWlFrMkNkNDFRN2JxSWQwKzIxeE9ZM2tscDY4SVZCRmFZd3Y4?=
 =?utf-8?B?YmZJTmhOeXNTcjhtWHgxZ0dsT1pDV01HMEo4R1RFbWxHS01ZMEVKZ0daaFRx?=
 =?utf-8?B?UzBLZjdndFJrREY1bVdxNVJuY2MxWWMvTTYzZmJ0bDlyMXVhTFNLclQ2SjJO?=
 =?utf-8?B?QU5sUloxTWlobkZxZDhqR0VMYWZxaHk5emZvdEFvRURyS2JLaVVhOElNa1ha?=
 =?utf-8?B?bVNTT2lOVHBXLzlJdlpmUVNDU2pLUWZSRHZRTzRYQjRyNVZnaFdpYVoyVi9B?=
 =?utf-8?B?eEJ3a0xMbmxTNnl5aGhyZ3pIOVJQaGcxOVBTREVPTUlQY3QzdU51L0tNNFFt?=
 =?utf-8?B?ZlA0TVJLY2E2aThVeG1DcUh5RU5GaGg0bzN4L3VwOFp4WjJ1dmUrT2htN0pk?=
 =?utf-8?B?bHl3T0gzUHZ6YmF6L1Z5bmJOZS9FdXZxeDROYnFBVmZvcHRnUnBJdUdjOUgw?=
 =?utf-8?B?cjhlazRLT0RwTnpiM0d1ZUEreWU3VU5uZzFweGFqN0tVUUNHZFIyQTJ2WFFE?=
 =?utf-8?B?ZC8zUGZGNXJIdDdmMjlZeDFkVVNrSzZMTXRBRHFTanZqcXJXa0U4aElTdFpj?=
 =?utf-8?B?WUk4T1FacGM3MTNzMVNvSzgwNGluanZwcWNLUTdEQThXSmxlNXNwSHEraEow?=
 =?utf-8?B?QlNiNFhUSnlMa2g1VmNRY0xzck9yS2h5cVQyVEdxSFVuZ1Fsb0FqK0J5S2xv?=
 =?utf-8?B?S05OT2J1ZnZPamFQdGtWc2F1UWhVWk8wSUFJbFVzSTQ2RlJHM1czdGVSTERv?=
 =?utf-8?B?MUp6My9sNmhOYlZ4aTJVeXdiVjhjM0EvcUtPYjRJa2pBeXl3NGhWRVdSQmtC?=
 =?utf-8?B?R0lINkhqSnl5MCtVRnV4WjM3Zzg1Z1A1cm5qLzJvRlpWbVZxUUVCb2ErNGhQ?=
 =?utf-8?B?TGFZdHFiTEkrK2t3ak1WOXhDMXR0QTJVTHhYc3RpMFpydjBwNm1HSlVJb3hQ?=
 =?utf-8?B?VUY5Uk8yK2RJMVBXR2RydThscERoL1Q2S2lCUkVYOW1TZWg5NzA1UkJmMjU3?=
 =?utf-8?B?M0tSQTdZZDRpVVhjRjBrNEVmb0J2WEdGZUx1dE5OWElDN3J3Y1g3WTE0MTN6?=
 =?utf-8?B?eXlKRVhoc1pGcWVaUExZa1N4SGFFNFh5cDA2Mkp1UjdrTWkwd0tudkVPTnp3?=
 =?utf-8?B?M2E5MWdlcFQya1h5d0U2U2dHbVdpSDV4Z3NwRmtCd2xhdXhmcmpidnJudmVH?=
 =?utf-8?B?YVBNOUNCakRmV0FFWlJ6Q0tsVlRWOW9aSWM0aTl4Z2F0WXVSNWhHRXg1ajNI?=
 =?utf-8?B?VHhyZzRVNDBucG9UUFVReStoVlVPYUsrZUQvZFFjYTNaMGtaUGtYQThwY0kr?=
 =?utf-8?B?UUx4WW51YkVyRDNYdnl6NWx0Y2ZPY29nR2tlNVBtWmw0WkQvbHBDSHN5ZGdB?=
 =?utf-8?B?VDdCTGlqSnlILzRWTjkwb2hWd2xTaG9ZY1RjUVo2dGs0WThSeUROYkxYVFMz?=
 =?utf-8?B?OUVsRWg3QzBxeVRveStISENTV1NmSkdpcW12dUt4WlhNc2E3VlBVcG9IWlRm?=
 =?utf-8?B?UWNQanBsOXVVUjFLVzducGJwcThrdVE4VFlMOWZSVTJIMTU4ZDdLUDdRRURx?=
 =?utf-8?B?TEo0cUZldmZSVEJNaU1UbWV0d2FHUWp2T1dHaFZleWpCbldKeEF2d3o5aHUv?=
 =?utf-8?B?SkNsZmxkTnFIekFNRE1lSkF0bnRiTjNoYjhsT2VJYW5vbTRldXhyMnF1azhj?=
 =?utf-8?B?NmFkQWV4bnUvclFKbDEwdzhUbjBGSUNEOHNrR1JmU1ZMUVlXc1hIb0tqVnNo?=
 =?utf-8?B?VHpaRm9aSDh3dUFCZUdNZG91Tlhpd3BBZjA5dXNFV0RPcm1Sb1pWUFlKVy92?=
 =?utf-8?B?UlpTeEV4VE1sSjNPa0ZaQjRsOXJIWFFmNldoWTFJN2NLaG5NRkVQRGxBaHBy?=
 =?utf-8?Q?OaAgTLVxYb+wz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnNET2czQzdEWDJ1bFgyb0R3a05sWmVGcmJmUHF6bGpFUGVWZ2tBRFpLNWhN?=
 =?utf-8?B?YWpUOGl2WmR3Vm55d20rV3J3ZTJsdHVrTUVzZjlCaytnVHd2NGlwTVUvZ1lB?=
 =?utf-8?B?ck0wNjhneVd4NWNMUCtwcURSb240NUUyc1M3cXBOOHNOZUJmUzBlbUloQ0F1?=
 =?utf-8?B?N2poQUdmR1RLMUtlMjM5RW1maEhkWnFnOVg5TFh5T3VvRGJhSTFGK3dBdml5?=
 =?utf-8?B?Q2hXYUhISGJPZmQ1QitIL3kwMEJOaWNlZTRXTkFNUCt6QVlXOEpQeWJDVVpp?=
 =?utf-8?B?cWErQ29sQlV4cFhleWdoRWN6MHJ5TEhDMFdXTFJHdHV4L3VNNzRwSnZCSUV4?=
 =?utf-8?B?VktpcTZNQnc4M1ZTVTBWMXNqcGhMNVZObFlsQlNDY2IweFRmV1lDRklvV2ov?=
 =?utf-8?B?OVlwN3BpUlhCVklPZTM1TE9TQlk0ZE5wSjhHZE5VdWtycDNQajFOLytKbHFK?=
 =?utf-8?B?aWpsVWdPa0ZzYkduQ28wN3Z5SFEreG5SZ2hBcm1TUGJiQ2NNYXZQUEFLYmVi?=
 =?utf-8?B?WU5mV3M3YjJ3ajZhQjVXN1A3bE10YzlOWHhSNVRXNkdqRS93NXFyVW5RSGFv?=
 =?utf-8?B?SFBZeFJXZ0xlc0p3am5tYm5zeUo0VklZMWNia1ZPVVZrcGdLWEhKaE1wY25v?=
 =?utf-8?B?Z1VPeEE3K3ZHTDl6WVpWUUwrRnovRWZLanY0ZFJrOWxYOXpHdlBlWmNDZEQ4?=
 =?utf-8?B?WnRTRFkrSU54OWF3UjY4TVNocXdUWWNtSFRBcEVNUHp4QUE1cEhSQTRiZGVG?=
 =?utf-8?B?TUQxYnh1NlZsMlFpd2dqMW8rN1dWWjk1TFA1eWZ0ZDZRQThhellIQzlFUG12?=
 =?utf-8?B?NHkzMWVnT3pDN3ZVczR6RGRJL3dtbGpnLzIyV0x0QlBUSWQwWVhhQnozb1Y1?=
 =?utf-8?B?MHFPM1NIcmtpUzNidGdrNEk3dVRGWU1TVHZoV0Z5OERNWVZ3ZUdkb1lPaGR3?=
 =?utf-8?B?bkpOdExJU3ZqcW40VmN0L1FwK3JvaW9IR3labG1CSFkvcmQ3Y0lzVytUcU9y?=
 =?utf-8?B?ek1BUFFhNXZidXkvOWFrOWVQeUhybWNWdW1ZL1c5bEw2VEhPdW1Td0pPV3c2?=
 =?utf-8?B?OE9YV1lyb2IvL2xEL1J1cllkZDFIMDY5WDNVUkhWbWF2bXp4TVBsQTFSVEpx?=
 =?utf-8?B?Z2RjV3UyekgwM1dGZjRDallJMlhDQUFQUkVQeXVCcEgxYWxScmlCNmtkZnRC?=
 =?utf-8?B?VDdTN29Qc3d5V2pmbDZEeEo3Q2RPK25wbEE2bTM4Q3NIN3FKaHN5N3BPOFRi?=
 =?utf-8?B?QWRmbklSR2VTTGJTd1hLSU1velYvMVBjT0daOXdjNWRqM005dzZxc1N6WE1z?=
 =?utf-8?B?RXoyZjdueThPbjBwYW1pREhEU1NXZzc0QldpaVhOYTRwY3hHdDAwR0VKbURs?=
 =?utf-8?B?WlFtYW8yTUJjYnRzRzBUQlZaSWd6UmhJZGZLUEduNHE4Yy9SU0pmbkZZcmM3?=
 =?utf-8?B?dXJQM0tlTFNyVnFpbTZhSkgxeGlBTzVEV2RpVDN5ajk3czB0L1JsTEdYV25w?=
 =?utf-8?B?NUYvY3dxMytxNkczMngrVGtIM3FJSmkyVEtBdXNkU1Y2TUt2c0VHMDh4UWc1?=
 =?utf-8?B?V0dwcDc1VFRuSC9SQ0ZYWGJNWTcwTlZ1R2RQTTZyd00yUmhhdlloREpEWStR?=
 =?utf-8?B?MEJlRUs1VStzbHp2b3BFUUtpQlNTMlVQaEVrOHMzMEt4ZXJZYnhvZGpNbzFn?=
 =?utf-8?B?YndPSTczUUE0WUM0bTNpWmZ1SEphWFZlR2V4TGJvVVhxZjhTYm1Wd1lVVzVM?=
 =?utf-8?B?TXlzZUtOb3V1cU13ajZLQWZEeDV6TzhGOStHbXhuTlBhTVJsV2grYjNWaEJO?=
 =?utf-8?B?TnViMXJNSlliakpDUkFsS1ExU1VCUWJnakx3SHBKM3JrM0Z1YUx4dDRPbWtq?=
 =?utf-8?B?a3dvWitOcnRmSWdROG1OM3lISitqYTFVUnZaZTd1SjBLVmNGSnVnVjIxdGNU?=
 =?utf-8?B?NTJQY2V2VGpMYW1WdzdIUzJDdXhwRC9XbFBob3djWEs5Ukt1YkdTTTErRFVk?=
 =?utf-8?B?ZjRidkRyUU9VTElVUjhWSkVMYytnTG1EMEZFMkFWNFhVRm5tQXFIOXpFZWJu?=
 =?utf-8?B?NzJHak5rV29YODM0T2taeUN2bzVxdDZuTEdVR1lhWnpycmpwMzlNVVRlQkN3?=
 =?utf-8?B?akV1Yi9LY0t4ZFpYQnVpalVwS3ZRZzdIMm5ON1ZndmdwUDMrK1pBQXNidTVh?=
 =?utf-8?B?dWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 437854f8-ceca-49f2-7158-08dd20236d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 11:51:08.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMxb8Grssc5fPIKSirgdyLxLtImi4BT4qBl+XeZG1AxZdrY5g3GD76HdoOl0I55k6CA26DxclC2Mml3Ob6RZEv/Q30kWDgYKN8KnCHq6xCZfhK9XPeRhbl+BmrvejDXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9sZiBFaWtlIEJlZXIg
PGViQGVtbGl4LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE5IERlY2VtYmVyIDIwMjQgMTI6MjIN
Cj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRA
aW50ZWwuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IHdpZmk6IGl3bHdpZmk6IGZpeCBkb2N1
bWVudGF0aW9uIGFib3V0IGluaXRpYWwgdmFsdWVzIGluIHN0YXRpb24gdGFibGUNCj4gDQo+IFRo
ZSBpbnZlcnNlIHZhbHVlIGlzIHN0b3JlZCBpbiB0aGUgdGFibGUsIG1ha2UgdGhlIGRvY3VtZW50
YXRpb24gbWF0Y2ggdGhlIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2xmIEVpa2UgQmVl
ciA8ZWJAZW1saXguY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL3N0YS5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vc3RhLmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS9zdGEuaA0KPiBpbmRleCA0YTM3OTlhZTdjMTguLmRiYzUzMWM2M2YwZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vc3RhLmgN
Cj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vc3RhLmgNCj4g
QEAgLTEzMyw3ICsxMzMsNyBAQCBzdHJ1Y3QgaXdsX212bV92aWY7DQo+ICAgKiBhbmQgbm8gVElE
IGRhdGEgYXMgdGhpcyBpcyBhbHNvIG5vdCBuZWVkZWQuDQo+ICAgKiBPbmUgdGhpbmcgdG8gbm90
ZSwgaXMgdGhhdCB0aGVzZSBzdGF0aW9ucyBoYXZlIGFuIElEIGluIHRoZSBmdywgYnV0IG5vdA0K
PiAgICogaW4gbWFjODAyMTEuIEluIG9yZGVyIHRvICJyZXNlcnZlIiB0aGVtIGEgc3RhX2lkIGlu
ICVmd19pZF90b19tYWNfaWQNCj4gLSAqIHdlIGZpbGwgRVJSX1BUUihFSU5WQUwpIGluIHRoaXMg
bWFwcGluZyBhbmQgYWxsIG90aGVyIGRlcmVmZXJlbmNpbmcgb2YNCj4gKyAqIHdlIGZpbGwgRVJS
X1BUUigtRUlOVkFMKSBpbiB0aGlzIG1hcHBpbmcgYW5kIGFsbCBvdGhlciBkZXJlZmVyZW5jaW5n
IG9mDQo+ICAgKiBwb2ludGVycyBmcm9tIHRoaXMgbWFwcGluZyBuZWVkIHRvIGNoZWNrIHRoYXQg
dGhlIHZhbHVlIGlzIG5vdCBlcnJvcg0KPiAgICogb3IgTlVMTC4NCj4gICAqDQo+IC0tDQo+IDIu
NDcuMQ0KPiANCj4gDQo+IC0tDQo+IFJvbGYgRWlrZSBCZWVyDQo+IA0KPiBlbWxpeCBHbWJIDQo+
IEhlYWRxdWFydGVyczogQmVybGluZXIgU3RyLiAxMiwgMzcwNzMgR8O2dHRpbmdlbiwgR2VybWFu
eQ0KPiBQaG9uZSArNDkgKDApNTUxIDMwNjY0LTAsIGUtbWFpbCBpbmZvQGVtbGl4LmNvbQ0KPiBE
aXN0cmljdCBDb3VydCBvZiBHw7Z0dGluZ2VuLCBSZWdpc3RyeSBOdW1iZXIgSFIgQiAzMTYwDQo+
IE1hbmFnaW5nIERpcmVjdG9yczogSGVpa2UgSm9yZGFuLCBEci4gVXdlIEtyYWNrZQ0KPiBWQVQg
SUQgTm8uIERFIDIwNSAxOTggMDU1DQo+IE9mZmljZSBCZXJsaW46IFBhbm9yYW1hc3RyLiAxLCAx
MDE3OCBCZXJsaW4sIEdlcm1hbnkNCj4gT2ZmaWNlIEJvbm46IEJhY2hzdHIuIDYsIDUzMTE1IEJv
bm4sIEdlcm1hbnkNCj4gaHR0cDovL3d3dy5lbWxpeC5jb20NCj4gDQo+IGVtbGl4IC0geW91ciBl
bWJlZGRlZCBMaW51eCBwYXJ0bmVyDQo+IA0KQWNrZWQtYnk6IE1pcmkgS29yZW5ibGl0IDxtaXJp
YW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo=

