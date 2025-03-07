Return-Path: <linux-wireless+bounces-20000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D9A56A58
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 15:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BD63B1CF4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19A70838;
	Fri,  7 Mar 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQBt7evP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56921ABDC
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357727; cv=fail; b=Fm51Pw6aH30Eeq+xkBGuT5J1foa8ki2syTV6E7NjDs1G2VN2Df112ei0YrPnIrAoexLwbDkwFO1yvAr3FAx1s2E8jntMaDaU0zn8s6ubIiae7fhIRIVLnuyL8vx1+BYAipGb34K/6nW/ofK0V6gfPC/j0HwPaKfnKkeIIY5iYvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357727; c=relaxed/simple;
	bh=N20DWUljO2FHVWJzWTf6B2xynYangbql+GvrqRbLB3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OpSJAxcsDC9L4kP0aCzBXIAXL4TPqCeta4Sgc8QVqYK3Y9PNCiCAt/qnLgPHTWg4J2nuNV94PgZMIErsvuVvuCgqhee4uOIA3tiHTs8OtPZ8ATDLmLgIiMq6OGJ04CMTxyQWd38z8dU6vGlbhhSZ9lhrwpzdCC/KGPLnCQouK/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQBt7evP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741357726; x=1772893726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N20DWUljO2FHVWJzWTf6B2xynYangbql+GvrqRbLB3I=;
  b=GQBt7evPXbZ1arDRXzyKVdSjoESe7Rk05QIObUhghaVC6hYQS/1MY7FY
   63VCy1H75vJlacHIaylPInWF45cs9nxv/+E5//rW/0+FpCNGsqYS6YAzK
   q7M+LLsDWMhlUspUtRmnF0TEdJ+JDyF79hn0/tVBWsld8YRA24Rcze4cV
   e8IQ9EvSap7uoETfGa42qJ2aGzZv+il7CQNDQVDBRIPAYsuAnLluOvNaT
   d4UU5GMXE/byBgyWAHjrfdmK9bVjXskXrdovWiBTn7AG0BC/aAn56BI0a
   /4/Wr2TTmqNfvJnmznGYkfzF1uTtj6VLhW5FmPkaxoLKyPzjFPDzuVup3
   g==;
X-CSE-ConnectionGUID: 2CEYFCwETamkAipImXwmRg==
X-CSE-MsgGUID: Wo5BHncOQ7+pZNJn60ma3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41659593"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="41659593"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:28:45 -0800
X-CSE-ConnectionGUID: YERln4vIQh+vviqOFACIzw==
X-CSE-MsgGUID: /O8JXk+vR5Gbx0P1eT1+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119836289"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:28:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 06:28:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 06:28:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 06:28:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjIXtMMYeKOjsLoYvxhiLNwTL8AmDFEZDlyP/CpglNEFM5mnvxOD4RWIUgeh+txDpS0PLwT5/yvHhuXbLppzVfz+nYNy3CugRAn87kqjX6PsBTvK4zt3eF2/gI1kXubiUqzedTe5INtQpzF8J4FwSdyi6z0uyIZzD1ULSlz6KV2/S6zh/GJOVRJL5CVbhbaWJ77QNClIzz8dbVTb/c5LNx7MwKaR4LNuBDcoqWv3oHkhy2GR7lE3qj97DRunm/l9j+Z3DPCwLkpvRDmbzgXfW4PjcLQx/VRzwYSBihREqORrmrgeUbQUsGUO1y1RsNgBdd6T5WTCYGPQyGQWbLMSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N20DWUljO2FHVWJzWTf6B2xynYangbql+GvrqRbLB3I=;
 b=PCaWS93lcnhuA6ghHKFJiLALCrkm39DxpOSC0It+hjYw7lIm9+vCb/7kxG5zGYxj9HEWmRJFPg0qCpgYhdrrU3qLZIgDHhocALJxKR1p83Yg86wdo3IXX+aOtcIiYOX1TvIDHKJr82uiVanH6V/0JWDU39kWeUIj0a1k2xfUja0uB0aLthc4faY19UltA2SyxQ9Rj9TTfoYD+gNdt+O9iYqU0Xnkm7SJ8MZWcXGFgaJwu6qPrz0hI0BGKKeo8dLjpRvKGMSPcA0jhP3zhAzptkyktyqMuLFVpHLhK/HFz/tJDPfbP1cmYk4LpgqC5C/NnM1k6pjebgoP5Glpw39gPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 14:28:42 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 14:28:42 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless-next 01/15] wifi: iwlwifi: bump FW API to 97 for
 BZ/SC/DC devices
Thread-Topic: [PATCH wireless-next 01/15] wifi: iwlwifi: bump FW API to 97 for
 BZ/SC/DC devices
Thread-Index: AQHbjuPqyw7acw7p6Ea5TkuDqd0E/LNnZc4AgABUkoA=
Date: Fri, 7 Mar 2025 14:28:42 +0000
Message-ID: <MW5PR11MB581034BE05FD2F104700384BA3D52@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
	 <20250307000213.1678abe8c9b6.Iee3bbd245e7bc750b92624f7085afef02e7dbdc6@changeid>
 <39059b0c01f42028bd17b54cc74f7d0aeaadf9b6.camel@sipsolutions.net>
In-Reply-To: <39059b0c01f42028bd17b54cc74f7d0aeaadf9b6.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH0PR11MB4887:EE_
x-ms-office365-filtering-correlation-id: 4a964128-a2ec-4234-baa9-08dd5d845c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2hDWkVUeS9OYzRYSFhCaHY0a0hxMFpvVzZxWldiZ0NnYlBpdC83V1MvME96?=
 =?utf-8?B?YzVPVlFCb2tibCt6QmNGZTNDWDE2b05QQW1TZ0lTTzduK1RIY0NiQ0JERXVv?=
 =?utf-8?B?YXlCK0I2a0J6UVQzV0g4RTI2anM1OGJDSFAxWmNINWU1TmtHYjlOeE9SY0xR?=
 =?utf-8?B?QWYySDZicTZ2N1pvRko2R0JYbXUwVGdSOTQvdytZRStnejdETEpTVHlqVmtX?=
 =?utf-8?B?TXovRzVVcEpMRDFwTkNWdzZDWnVHSjhXbytXOHNOSWxCYWt6U2xrUFNqc1NM?=
 =?utf-8?B?cjd0L0ptMWpZSDEyZlMrM1A3Qnlpam1KNGdHUUlMRnlzZjBGS0wvTzNJUWpn?=
 =?utf-8?B?eGw0eEZGN0QyMHoxZVVrb2VFdFRjbVA1cXdvV29IYU9lelZLU0NkcEJubHB1?=
 =?utf-8?B?QjI5bDNUcnYwZ1BZVm14UHZ4S241ZDlzWXNwdWQzQVFwNHpVTm5FZm82Z1dw?=
 =?utf-8?B?c1F5MVhvUFdwaVlkcnBmSjNxMi9POFBhZFp1dXA5NnQrN1lQcms4ckgzajJ3?=
 =?utf-8?B?K2ZxWTdKVHFKUENHYjQ4Z2ZPRWRDTkcwNFM4UDZzSU1JcnVBaTFPTzJkK1Rl?=
 =?utf-8?B?QjF5VjgwSTE4ZHd5N1VmZ3FsZDR4ZEtOTE11L2h4WXRaTmRxMzVXbEJSZkpG?=
 =?utf-8?B?MDk3dDBRMHY3aHFZY095WmdiSjI1YlJzT1VOM2p1bHpTcU85cWhiOEJiZHhH?=
 =?utf-8?B?ZkUwcW53RUhNOEN5UXNvUVlIVGxDZUNMQkU2ZERvZy9UYmoyZW5abmNlVTMz?=
 =?utf-8?B?WTRuQmVhalQ0Nk4zTm1QNlBjNEFTaW9NaEQ1TWxaTkI5UTMvbmFHcE9pb2tq?=
 =?utf-8?B?M084VTFBN2cxRFRITWZCQVRoUFM4RDErd2crd2x1clh6aVRSOFdFMzEwTm1V?=
 =?utf-8?B?QUNhazQzTFZ3cndHbGtLSWxrRm1LNFpQc0NtLy9DeDZ4dm1XdEJxY3hWRm9t?=
 =?utf-8?B?U2RQOTNObkFBNlJZaHNHNjFpZytwMlo1VVRMTlpCbFpLMXpNZmFWQnBaWVRs?=
 =?utf-8?B?bFdNZlJpcjd6Si9ZbFMyVDk0L1V4S1haSXJZRDVlY1RnbTZTUHliYkpTUlpH?=
 =?utf-8?B?bVZPWFh0T1p5MVJDemlnRjJPODZZSHVZMlhOK0R0WkMzZUt0K1ZHN3B2bnh5?=
 =?utf-8?B?T2pVWDU3dGNmYzNucGNhbHp3WkJFb1RCUTRuam4xdlY3cHVIWlVWaU91VEY0?=
 =?utf-8?B?a2xVOU85bXdHV1hhMDJsblUxR1hnb2QwelNIc0t2eWQ2WDBRZjFhbGU2UHhx?=
 =?utf-8?B?Vnl3ZnFMWHlUMy9KVUxWRjRhV0wzU3NLTklaYXYyT0tCb2NqMGdOV2dJZW9n?=
 =?utf-8?B?dXhQSWRRL1dRdk0wOERhL3hMNEZVRDA5UDJQUjZoTHBmTUQwYmVkVnN0L0JT?=
 =?utf-8?B?NndQemYya0lyc0RodTdGRDFDWTloYkNocDdNZG9NS0NScVg1TWllMnRlaDJH?=
 =?utf-8?B?bTNPOGZablVzN3JhSE93cjRIWDBsTkp0TE02d0s3Vys0YVdyd0pZUW9ORTAw?=
 =?utf-8?B?WTNiWE1CUzBDdGNrVk4zRnhoSzIvWlkzT2V6NHVNdjdWelQ0VmZjTE1PTDJp?=
 =?utf-8?B?cGw3RWM0MEZDWlhkdnhOVVJUN3ljREdEcURSakVsYXIyeWNnT05BMkVSUVNB?=
 =?utf-8?B?Y0NhS3d0aFJoa054R09iT2lUSk10M3FIbTZvS2ttRTA1czcySll2RXNVRGw0?=
 =?utf-8?B?NWZHTkszSHJ6ZVk0NHhTM0VBYWlOQ3VOSVBIcEZXZnVKSWN2S0FUWTFBRVJ2?=
 =?utf-8?B?anFsajJiQVVCNFJzM0dDVE5iK3NiM255WGZkaFNmSXZuOWVxbGtVSUlUV1JH?=
 =?utf-8?B?dGdMa2IzUG1YdWcxS3VQSHBNWmtHUlZnWjI4VU83S0o5c2RvWjQrRFNxL3dl?=
 =?utf-8?B?dkhodG5zVnlMcHFmeXIzTWJIOHdoUHJSVDRyU2hhaWZmUmd2UU9pU1BOSHZV?=
 =?utf-8?Q?ZPcCRzuaGD0F3T2ju4/b0i+ip0HEtlOX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2hGSVNWMzB4OFhBWGJWbHgwTGFGZTg2VzlFYWZaaHY0dlg3Z21SZEtVZmsr?=
 =?utf-8?B?S2xpYmdmKzBiMXFiVVQ2OTdmcGs5UE9KTURXWDdUam1GdmZ2eWRUd04yZlJ4?=
 =?utf-8?B?Nm1wT3ZGK0lmdytnMjI3QnltaDhKQXVUUlR0cDlRKzRaNkRhbXRaN1dST2dx?=
 =?utf-8?B?aXMvbkdLby8vYWNkVkkxOVkySmQzbkdmUVdXYlZkL29YcWZJdTdHWnNQTUU3?=
 =?utf-8?B?elJYYUNuKzhVL3V4bWRPaWlpUkFNd0Q2K2Zxdlc1aTlKYjdSeXJzS0JEVHNq?=
 =?utf-8?B?cmpiQnBnMVdnWXkyRlFNUXFyZm9KeEpoYU5mMjZvMFFNRWpBMmdsQ2l2RUpj?=
 =?utf-8?B?aXBvYXV5QVZvN3lKQkFQR3RUTWQwNkpsaVluVEhweWpBTVZ2Ky9kL21jdGNU?=
 =?utf-8?B?ZEFSTGlvSXYvcFFHKzBzOHlxMFhmT3U1OFdyanA5MVgzakVBc2VVSlRmT1d1?=
 =?utf-8?B?NUtGalR4QnNFVjJ1Z0ZUTG82SXVRdzJWdlBsSjdNU3pGanZ2WlBmZlRaclFv?=
 =?utf-8?B?VmxNaWJxSytMOVRyRnZWam9yUUVzSlJFNVBmVEhQZkVqUFBZSFl1Ky9yV2ZP?=
 =?utf-8?B?NVl4L1U4czg0WHlDL0tCWmNDK1VCQnZxK2cxMWk5ZUZETVV6Ujh5ckVGUlov?=
 =?utf-8?B?anRtTTFRWEh6eDkzR1lLWGt0bG1FaTZBOGU2N1lCSEpTdEtDeEo0SklXQU5O?=
 =?utf-8?B?bTEzb0FwaDRzS1ZVVFJMSk9kRC9ERmh5SlUva0N1eW1vV3dETlAvWTBmaGpP?=
 =?utf-8?B?Ymh4c1R0SkkrVGdJd213eXl2blMvVVI4K1JIT0JlckpLc0tYYXp2M2JrU2hE?=
 =?utf-8?B?elZaU1p2YkJ4MndyTTViR3BOS2dKZHpabVN2dzNSYVhtbHczVmtxNWVOMTQ0?=
 =?utf-8?B?aDBFV1V1QzdsMlBUNUZiNmVVSzR3SWhBZmM4WkpQNVpJWkNLT1NNWmZpand1?=
 =?utf-8?B?b3NNWG1LUUR1eHMwVVBWV1VtWXN0S1V4VG9GMXkxM2Q4ODA5SHVZblJxS3hZ?=
 =?utf-8?B?QkwxN3lSYWg4MkJ3dllPWWxXSEYyMDJaYzZ4WlRHQ0RwZEdDZHdpWklHZm1W?=
 =?utf-8?B?c1pOT1ZlNUV3anNVSXZ2T0VyYXNjTy9YT2pzV1YxRHB1Ym9jVVZjV1JBSStn?=
 =?utf-8?B?SU1aenA3NG9Gakk1MW52TkVpcUJ5Y2ZKczZzcC9MWFRlQlhOVTI3djE3Qk9o?=
 =?utf-8?B?dGcxOWxpWWlzQWRIN3N0bG5JT1lRcllIUjdaUFBOMWdONnhsZzEweEt3NWpE?=
 =?utf-8?B?cGp6aVN5QnhiWUQzVXRQSnBxWTdrUkU4cndPTWovdDZSQ3lxUzBncHN4bnJv?=
 =?utf-8?B?bzhYR3ZONitEU2VFczcya2M1K0MrV2JFdHJ3Q3dmd1pOdDhRcFpNWnpRcC94?=
 =?utf-8?B?VWxnWWl4cVlCRW9GRHMwQ0NiOU1CY1RVYzIyS1g2eVNBQ3RjR29mNVhLL3ZS?=
 =?utf-8?B?SkFBRXcyOXFBUCtLcEg2NFNZVnB0M0tteE4xdEFaRm9sdys3UDBjeDBBMlcv?=
 =?utf-8?B?ZlU0aG05ZXVqM3JmdlRRdklsZ3BVOUFMT2pBeU1qSjhwVE5DZll5a2cyOFJY?=
 =?utf-8?B?QldKN1FkTXRyVWxtRkNIMGdPVVpvdVpSM0p3QkI3SXJoTnR2ZUp6NXRuT1Fp?=
 =?utf-8?B?NGZJNllRaGFiOEszTHl5S2E1dCt5NXFMRTFWR2hCWUkrQlRWNlBWc05BRE1h?=
 =?utf-8?B?aCtEdEZ2d1I5T3R6dE9aS0thNmwyQWJib3h5c3ZnS2VCaHVYSS81RjFNYVdU?=
 =?utf-8?B?cTdtdG9qZjlMSTNUVk9ybUtUeTRXcytETW9sdTV2SUpvdy9uNkZ1eGF5Zmxm?=
 =?utf-8?B?cW13ZktTS1FuNjd1OTNXeXJlVHkrUlZPYVZzUTIzelZOY1hQVW1xbWxEZkNx?=
 =?utf-8?B?eXNSM2RIQ0pxVmtDMHlSM1JYZXcvZDZ5a29JM2cwSTJTb2k4MmJIZzI5dlRF?=
 =?utf-8?B?UFZISzExb2x0QTZ1QU9YVHMwZS9BMENQYnpGWEpUb3NQdHEwdHEvRHgvb2RP?=
 =?utf-8?B?K1VmclJ3YTJudjBOYW9OUGlHL3ZpT2xDT2k3MWtma3NCUnNia1c3L3RvQXlL?=
 =?utf-8?B?Z29oRi9UU1VHWUttajZKcWJ4YzVSN1lia3JBMEZNT1VDY2Q1ZVg1QXN0VHY0?=
 =?utf-8?B?NnhScS9lb1RBNUdrWUZHNWxCalkvdHkrSEZlV0krSkZpd0NxdkRuODZCZ3N2?=
 =?utf-8?B?UWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a964128-a2ec-4234-baa9-08dd5d845c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 14:28:42.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFRYKRgjoqDYCQlAuz+49TQ7AScg8/1we9AfvACbm3wroOa9Mixt75wjygIORSKMpoDedE7FMmtRr/vd1Udq4Vz+w7IKa4sAkW2Ms1KX7L49uUW646ZSkmKVTXZJGhPd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogRnJpZGF5LCA3IE1hcmNoIDIwMjUg
MTE6MTgNCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3Jl
bmJsaXRAaW50ZWwuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggd2lyZWxlc3MtbmV4dCAwMS8xNV0gd2lmaTogaXdsd2lmaTog
YnVtcCBGVyBBUEkgdG8gOTcgZm9yDQo+IEJaL1NDL0RDIGRldmljZXMNCj4gDQo+IFdoeSBkb2Vz
IHRoZSBzdWJqZWN0IHNheSAiREMiPw0KSSBndWVzcyBpdCBzaG91bGQgaGF2ZSBiZWVuIERSLi4u
DQpvb29wcw0KPiANCj4gQW5kIHdoeSBzaG91bGQgdGhlcmUgYmUgdHdvIHBhdGNoZXMgYnVtcGlu
ZyBpdCBpbiB0aGUgc2FtZSBzZXQsIHJhdGhlciB0aGFuIGp1c3QNCj4gb25lPyA6KQ0KPiANCkkg
anVzdCBzZW50IHRob3NlIDIgZnJvbSB0aGUgdG9kbyBsaXN0Lg0KQnV0IHllYWggSSBjYW4gc3F1
YXNoIHRob3NlLg0KU2hvdWxkIEkgYWxzbyBzcXVhc2ggdGhlICdidW1wIE1JTicgcGF0Y2ggbWF5
YmU/DQo+IGpvaGFubmVzDQo=

