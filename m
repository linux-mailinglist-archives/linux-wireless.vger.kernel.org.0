Return-Path: <linux-wireless+bounces-22291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E56AA5AB2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 07:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C41B4A49DD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 05:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9129225A2C;
	Thu,  1 May 2025 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUDBT6sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B21EEA27
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746079081; cv=fail; b=EgTKa1b3levKRWyhaiVq646ba9dW5dbW6z63+QTRwjdAH/muaLBkI/c+kvXym/W88JLXwU6QI3dQRggep7FkmYI82pRNxg3+bvijit2yc40JMT00yW0iweM23z6PC1ehi8qecJKLw3piq6tk0ty7UqJYqIPLne3If4Qb3Mepg0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746079081; c=relaxed/simple;
	bh=OEhooco7aCFwi0taao3mKML/exDwWaLR9G18rytUR2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hW61xrC0cUplzPVzoN1ciyNldV+3ArSdITceh1cYibKMeG/S6B21DGT8PyEtjNUKLE05D8PYW54saP4risk3Ox9gzw4LQtPuhsAODZ8dJXRvP6ioyWesBG2nC5qbYtCdvuTStN4mdqPTgtTSKDLqQ22zKcf6v6w0GnyrSw0lLwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUDBT6sa; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746079079; x=1777615079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OEhooco7aCFwi0taao3mKML/exDwWaLR9G18rytUR2s=;
  b=BUDBT6safwXH11Kh9hcspsS8q0E+N6z/W4GRTfuBS9XVV28AAAqUIevc
   RKXegRapQpgEVLd8Heo48QxJlvWiwmKoXRUp3M1TuF0HFGR6tG5+Z/TGi
   JHZC1siAuK8bmbQcdPOrTV0S1U39pZH+sxhTXtu2XQt8Rxa/SbF8t8gLL
   FdnJf8zlxDQnFIJA6vqRm91YE8SoD9jrONjKDhNTJ4G0sH/VAV/SEsydr
   LZMR2TwPyA43b4sU6PktV+OEVe9ZV2zbdCXqs0xFZIByG1OPy3+jPlS0v
   4cIVOPEQQZfyiShL9+YDMQc2wkjfc/dcaSfb/GGcFz28Ja+YQ3rKhyTzn
   g==;
X-CSE-ConnectionGUID: tthDtD+zQpGUN+sjwTPGew==
X-CSE-MsgGUID: /mkEOq5YTJWEVulpJFpmNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47469330"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="47469330"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 22:57:58 -0700
X-CSE-ConnectionGUID: PlCQYL6KR0+J22OC27VNuA==
X-CSE-MsgGUID: elu4xh0DRlmw5ctjb2SWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="134207239"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 22:57:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 22:57:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 22:57:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 22:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3MA16y1Ivcy1XA1sbceULDXYmv7kFLrXs7NxxZmwbkHNxhEFkwqsGybe2BnLIhueCfjWbCpdqbmCWC7cl03/vVEwvHTo3Cp2nErTBtNAqVfEVzn4HqNoYaeNv3ovdI8mHJ81arO0JM/hKr7dzTPwMoQpfKf7hkXMDdFjBSN4EuYYoDdD5ktf0gZDfJ6oQHwmhPqvhDC2LLfv+UnIukzm8OXz0biGJJlQ6dNMEmROpQzyBjgEJREz+Z/JvzFdIiDNbFDHjTlbyAQWPDdMGN7r7k2tSdt+CZJbUkFtWq6A650K2J8bx+xKqMdgaBdQfnL4bGFWTp9HVkqK2q9Fw5GrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEhooco7aCFwi0taao3mKML/exDwWaLR9G18rytUR2s=;
 b=B77lKfSkobQ9XNhgkmiLawVaeVjNBXHlPulzt+oONNHIVtHT2FdUWDbfZj6LC5vUXXVmG5M2zBDqkCgKoukRO+5phaOcbXrYQ3h+Die24wp2NJc0Txybmd+d81CxhXJVODVSVifzyWKAhNU3hbbEsU6aE0Rd4+kgeeZJdNKdHDQLgKvRdCy9gB1k8Jk4K2qaPdgYxauUrKqPCRAoR3Fr5gggz0A5U4nz1algg25JqPbf2I5DPwVBQcv2SfZaSSApBElqjqt6Jqwt3pXQVf3wFoIOFltykOIOUdF3vRYAFBm8lQDtA1uA3G+gA1YE55tpXlgaysusfKi9awmxiJ2Fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 05:57:49 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 05:57:49 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Rory Little <rory@candelatech.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH iwlwifi-next] wifi: iwlwifi: mld: Fix iteration of
 uninitialized async handler list.
Thread-Topic: [PATCH iwlwifi-next] wifi: iwlwifi: mld: Fix iteration of
 uninitialized async handler list.
Thread-Index: AQHbuhPwrheJvrZ7MUywBwaz3zsXDLO9R3HA
Date: Thu, 1 May 2025 05:57:49 +0000
Message-ID: <MW5PR11MB5810692DB99CAFA6AC57ED26A3822@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250430210627.3674314-1-rory@candelatech.com>
In-Reply-To: <20250430210627.3674314-1-rory@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SN7PR11MB8109:EE_
x-ms-office365-filtering-correlation-id: fe2918af-9257-4f44-f838-08dd88751a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXpFOXJzQnhMVFBpOElPOWk1WXNidUJlaGhDSGtxNThJUFBmbTZ2UW1UMTF2?=
 =?utf-8?B?bWt0WGhKMExGQjBjN0c3a3pyckd3T0plQ0dXSlZDL21nbDg3eTNHeEhWZzFF?=
 =?utf-8?B?T1AyMFdhYk8xRUxGeFlNblc5L0FaQndJWS8yL1I5d3YxTXIvYjI2NkU0bnFF?=
 =?utf-8?B?QnlYTGNMdFNzSy9ja3NKeFhkRkFGK2Y0V3ptaEZON2Q2NEtnbHg2alZZcXMv?=
 =?utf-8?B?TjU0aC9UWGtTcWJ2RVRYVkpJeDQ2cXlUY2kwVnRBajd5Wm5YTGlQbGxvQjdi?=
 =?utf-8?B?TTdWR2JYcG9lYW5oa2JLWnpjYnN1bzBYNlM1dGh0WDJpak1WV3RDZ3U5VHhp?=
 =?utf-8?B?NW1nSkZwMTlIc2hLSFhDN2VpZ0dqR2YrU0lwbGJNamdFUFNwaEM1QkVrODR5?=
 =?utf-8?B?Y1BIejRJU21MNVhXT0ZPbXpucEFpL0t0aElRZDl4dThBU1FhL1N1T1AyL2lQ?=
 =?utf-8?B?WTJmanI4NXpkMnNYdUpneVVROWJkNE9Ta2VMbFozZVJreHB1TGFHVEZZazR0?=
 =?utf-8?B?a0FNRUt6alJ2ZkVlTmRLcHV0RmQydW9EcmljZnJQTlpoM2M4VUd6eVBucHh3?=
 =?utf-8?B?NGMvV3JYZjEyejEvZllZWllIamJMN2Y0YW80VUZlb3BtKzV2T3duWlhaSnE4?=
 =?utf-8?B?OXZ3eVpzMWxaUkVSNXlLSGx3bXlOR1NmSk82SmNiM0hEazI2dDFQTWhhN3Nu?=
 =?utf-8?B?RXRnK1hxeDkzK1JNektUT0NzNW5hTzl4ckFXYW5KNnpUVjM2UHIyWFQ3aG1v?=
 =?utf-8?B?bEhEbEw3RDRELzVwRDVLUCtacXZWY1czanE2V0Fac1RudEZPcThDVnBrSms2?=
 =?utf-8?B?UnQ3ZHBMUExOSGh3amRtNFRIUEVvUUVSMWVYOVpLZldqdGM0OWtGelgwK0hN?=
 =?utf-8?B?aERhSUZmL2JsVG5UQkl6S0VrdlErQzRSNnhoVFc3Tld3OHB5NlV6RnIrZWFr?=
 =?utf-8?B?aGEyWTYrWnNnMHBMK2xES3FySDFuRnk0M3BqTGZYc0Zsb21QSFEwVmtXUVRx?=
 =?utf-8?B?MUdKblg4K0FjMVhkWGZnSkxoVVlxNjhCMlkyVVpkUEI1aE5oY3phUDMxWE45?=
 =?utf-8?B?YnB0L2xFMjNRZFVQenBJanRITjlOaXNVL1huUDIrbmhVb1BsS1QrM21RWmF1?=
 =?utf-8?B?cm1zcGluNmx4VjFlR0NnVTM5VmJRUUZKMktiLzhJYkJ4a1dBa2JucVFlbW1P?=
 =?utf-8?B?L0xuL2VZQlhJMlhmSkkxaWFHVW93MUVqS2pZb1Jzd2lGVjEwcnBidjRJZUJP?=
 =?utf-8?B?RkJsSCtKeXdZTW8xZFIwS0F6RVdIZ0JWYU9OcnJrZUF4eDE3TjVDc25oQis5?=
 =?utf-8?B?aEt0VGxabXBuZEZSaUo3ZndNdzQ4cER6dkMzR2dwY0tUN2dkNmxzTEV2Z0ln?=
 =?utf-8?B?S25NaHFMZHRuemhPM2oyYnQ1eS9peEp4MEpycXJTWTF5S2MwTkdJWkpnbWVB?=
 =?utf-8?B?cFBOV3k4NS9acFJtR21ObE5lZlJYT2FjTFJHVzdEbUNJK3RJZEJaVytVcHl4?=
 =?utf-8?B?MkRYeTVOUkhoenhsaWhCMFlOdDY1dytYc0MzL2wwNWR3UkszT2E3V0xJQzVz?=
 =?utf-8?B?cVU0TUlwQVdnNWJ4YnlWaE5FYWN2TEE3MWJLbVpjU2FSVWo5QllTNlB4Yk1N?=
 =?utf-8?B?aS94cUprd0tpM0twRkJ6VDRIbE12U0MxMUIrMUdmckJWYUtLSHRUZ1ZIVkZG?=
 =?utf-8?B?RTY1QjU4L1FZRzZ4RktFUmxORi8waDBuT092c2xURzVzc1U0RHdNaEFxSUll?=
 =?utf-8?B?MXBmZUhUTGVHYStmT2lwWGt4cXhUdlNmdFp6M0xSbFhaWkU4QVFBclhTM0E0?=
 =?utf-8?B?dldlVTdvalh6aUhxTGJuN3g0aHJRTk83enRnVTJFekFUVTBGaHd1OW5tYmY0?=
 =?utf-8?B?K1BQWmhwSlVuY2VFOFVPMHdQVXA1YUswMUV4amt1RGNqYUNxT3EycTNtODND?=
 =?utf-8?B?VHhrUEx2M1VuUWhpNXJIU09HL0M0Sit0a2xkS2hVeUdPM3MzWGZEbERCUEtN?=
 =?utf-8?B?ZlAxdTczU1lBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmJ3eHlnSkxKWWdEUjhQR01zR3FseDZtb09yb2FpbGJLRDlnc0RTZjQ3NVZF?=
 =?utf-8?B?YUd1bmtWQzJkU29BVG9MZzhIZTFTSi9tcXp4QnhGNUpDWUF1ZlRYQk9EbmZR?=
 =?utf-8?B?NTBWZEJXdU83V2l5SlM5NnE2bDkzTCtlaUI5MGFGbStHSnpPWGZvcVF4eXVk?=
 =?utf-8?B?ZUpvSWRuQVI1Y3VXblFtVU55UG5WVVhJQjhVZjloU0h5dWxTMjBZaU5ib01J?=
 =?utf-8?B?YnZkVDJrUmtwMS81R1B3QnFGL1NSU1lCYTJWSDFLU1FaNjlrVjVZcWRPeWVU?=
 =?utf-8?B?UTEwTEdEWnlwcnJxSXlmUlhGcjNrUCszUU1JV3pTNUNiUmZ1WnFLL1RHUUZm?=
 =?utf-8?B?RVBCZXdZcVNhVlNuNjhiTHlUcUl4ZE8zZFl4WDZUOTN6YzVGYXBaS1F6WDdS?=
 =?utf-8?B?SStISm1mUk1OZWFtMThpM09RVUppcUo5VzZEZVNRc2NkTG1xc1RoRk05R3NT?=
 =?utf-8?B?TlYrVmVJdXc1dFRDUjd1VFdySzA1QmpTbUc5V0I4SEVBL3JaZWdSZTN3eFVG?=
 =?utf-8?B?TURIdUNnNU12dkh6TlcwK3h6OFVjMTA4bUk1UFhrY0d1YUVoVy9ZWGYrdE93?=
 =?utf-8?B?ay8yK2hFNkIvNFdWMVpyenIxdjRDU3FyRTdqYnQ2Vnp4SCtOeUtWdy90ZTRK?=
 =?utf-8?B?RVhCL3oyM1hzV25kRUJRVEUxTHZqWTk1Wlc1dVBnWlVuWVZuVkV6VEJsQzNX?=
 =?utf-8?B?L1Fla3dGdWhveXFaSUtXV1k0eThJbjBHNkpORGJyT2l1N001TmxrYmduVWgx?=
 =?utf-8?B?OVN4dFNjRlkxN3VjWFc3UDl4MnpNQ005RDIxYUlpdXF6Zy9JNEpNb0lLYVhS?=
 =?utf-8?B?d0RVWDJxU2M0aHRhTWJ2RUZkam9kdHhXU1lRdVZhem5ETFloN0t6eHJsWit6?=
 =?utf-8?B?d28zWStFQ0R3OFRlWG1GcGdWR2x3UFBYaWgzWGhaRldhcGVxYjJYK2Z2MTFP?=
 =?utf-8?B?cjgvU3JzVjR0NlVrdTNRTnl6clFjd0ViRjdEU1NRcjZZOXBJc2hWa2k1ZW5E?=
 =?utf-8?B?OGp3dUZQTEd1RXFSaGlsUUYrZUlyQ0ZTWHlmdVFqRmpob0JOMjZVWEZCTnlR?=
 =?utf-8?B?NTVTeXVwZjlLZmNJMVJTUmFhTit6TjM3enUwS0dEdlBqVFZCaGFuQ3lIREY2?=
 =?utf-8?B?YTVIdTNXdENOK3N5QjdtemVtLzFLdlMwVEZ3VkgxNDhpaXZ0cEFwbXBWVll0?=
 =?utf-8?B?SVNCV25oN280R2ZWaTFrZ0FaTVNITzJJVThRZmJOdmttUFdyMlRoeENJYkw1?=
 =?utf-8?B?N0NtL2RmTURtT0JXTUdEY2M3ZVBPU05EWGRaK0pWL3JxUTNGMDd1bUx2QWV1?=
 =?utf-8?B?K1F6MnFWdzRvelQ0SjZzKzdXQ00ydGM1NDdpQlR1M0dMckVwamhRS2pyNGI4?=
 =?utf-8?B?NDVaZ2xuRFZ3ZFp1c1pyemtoc3NYREthSVFmQ2FpLzFUeU5UWVBZT3R2SEg0?=
 =?utf-8?B?OXNIZXV5amIzNGNEOEJySDIvSEJrREZocGZWNUVHeWpSMEVBdHZPV2NZYWJI?=
 =?utf-8?B?RXlTK3dYT2U1MklnL1ZPVHFVTUlFNzljcThUYlB3a2NKL1ZVQ21jWmF3WXlV?=
 =?utf-8?B?aFBDeEFVUXBhUUZ3NnEzTHVOelJpWnAzUHlsOTZTSEdGUmRoKzNDU2FyZzdr?=
 =?utf-8?B?aTdJT3M5VE9SRE1US3hMWFBmVHJDZ29DSVEwcTF6eDZoV3l0L1NCUnljbjNm?=
 =?utf-8?B?bmIzbVNFT0FUb3NtbjlxSk5lNXdhbG50QlgxTndiTlBmZHNRL1AwdHFUQU9M?=
 =?utf-8?B?ZGZRang0aWFxaUxtZDUrV1o5a3lIZ2Q4aFNhdUJLN055eXNHd1h2S1hZRGFm?=
 =?utf-8?B?a0h5VkViVTFWNm5iQkI0OFVmSldwTkhhNExKMk9RSlg0ejdBM2c3eDQvcWpy?=
 =?utf-8?B?Z1p0NDM4WnBqME04d3c0UWdCUmpMZXZJMStVKzF6cFg0aDBWR3RVMS9yMkE1?=
 =?utf-8?B?MlRtV2pHMFRkR3l4dHJybDB2NG83V3l0NUZEL1hVMlBVM05ZZGdrNEl0bStD?=
 =?utf-8?B?NGg3SWpwYVNOOXE3U0g0YUhwa052QUVFZll3WkNHZUhxTExBYmlkWVdHeXNn?=
 =?utf-8?B?Z291QW1FQlRGTk91NEIyYlo5UkttZWMrcUgrbmNOL2VvRlRGc05UV1BXU004?=
 =?utf-8?B?a3FTNXUwM2dzRlhXOHhWRlFXK0FaUDB5L0puR1RyNHNYWG1QM0lkWmltYjdh?=
 =?utf-8?Q?1KMQMBWXum6m9JO4D8pLUSg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2918af-9257-4f44-f838-08dd88751a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:57:49.2397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7C1FjwNeHnEi8oET2DYuM8Z+E2Xm8pThGe5PSwBmT/C9p17FsRonpBGlqRSUSEZ1UbPtr2CO5I+EgNdqKnbYIhhXv78uMAm+sAOaQ4qvG28kmlaAy9QNigqgk6dC8g8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9yeSBMaXR0bGUgPHJv
cnlAY2FuZGVsYXRlY2guY29tPg0KPiBTZW50OiBUaHVyc2RheSwgMSBNYXkgMjAyNSAwOjA2DQo+
IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgUm9yeSBMaXR0
bGUgPHJvcnlAY2FuZGVsYXRlY2guY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsd2lmaS1uZXh0
XSB3aWZpOiBpd2x3aWZpOiBtbGQ6IEZpeCBpdGVyYXRpb24gb2YgdW5pbml0aWFsaXplZCBhc3lu
Yw0KPiBoYW5kbGVyIGxpc3QuDQo+IA0KPiBUaGVyZSB3ZXJlIGEgZmV3IGNhc2VzIHdoZXJlIGl0
ZXJhdGlvbiBvZiB0aGUgYXN5bmNfaGFuZGxlcnNfbGlzdCB3b3VsZCBiZQ0KPiBhdHRlbXB0ZWQg
YmVmb3JlIHRoZSBsaXN0IHdhcyBpbml0aWFsaXplZCBieSBhc3luY19oYW5kbGVyc193ay4gVGhp
cyBwYXRjaA0KPiBpbml0aWFsaXplcyB0aGF0IGxpc3QgZHVyaW5nIG1sZCBjb25zdHJ1Y3Rpb24g
dG8gZ3VhcmQgYWdhaW5zdCB0aGF0IGNhc2UuDQo+IA0KPiBUaGlzIGZpeGVzIGEgcGFuaWMgc2Vl
biBvbiBib290Og0KPiANCj4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBh
ZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwIFBHRCAwIFA0RA0KPiAwDQo+IE9vcHM6IE9vcHM6IDAw
MDAgWyMxXSBTTVANCj4gQ1BVOiAxIFVJRDogMCBQSUQ6IDkxMCBDb21tOiBtb2Rwcm9iZSBOb3Qg
dGFpbnRlZCA2LjE1LjAtcmMyKyAjMw0KPiBQUkVFTVBUKGZ1bGwpIEhhcmR3YXJlIG5hbWU6IERl
ZmF1bHQgc3RyaW5nIERlZmF1bHQgc3RyaW5nL1NLWUJBWSwgQklPUyA1LjEyDQo+IDAyLzIxLzIw
MjMNCj4gUklQOiAwMDEwOml3bF9tbGRfY2FuY2VsX2FzeW5jX25vdGlmaWNhdGlvbnMrMHg0YS8w
eGQwIFtpd2xtbGRdDQo+IENvZGU6IC4uLg0KPiBSU1A6IDAwMTg6ZmZmZmM5MDAwMDk3ZmJmMCBF
RkxBR1M6IDAwMDEwMjQ2DQo+IFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAw
MDAwMDAgUkNYOiAwMDAwMDAwMDA0MDAwMDAwDQo+IFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6
IDAwMDAwMDAwMDAwMDAyOTIgUkRJOiBmZmZmODg4MTI3ZDczZDcwDQo+IFJCUDogZmZmZjg4ODEy
N2Q3MjAyOCBSMDg6IGZmZmZmZmZmYTBmYzk0ODUgUjA5OiBmZmZmZmZmZmEwZmM4YjhhDQo+IFIx
MDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmODg4MTI3
ZDczZDYwDQo+IFIxMzogMDAwMDAwMDAwMDAwMDAwMyBSMTQ6IGZmZmY4ODgxMjdkNzMxNTAgUjE1
OiBmZmZmODg4MTI3ZDcyMDIwDQo+IEZTOiAgMDAwMDdmOTQyZWNlMzc0MCgwMDAwKSBHUzpmZmZm
ODg4NGRhNzhlMDAwKDAwMDApDQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gQ1M6ICAwMDEw
IERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBDUjI6IDAwMDAwMDAw
MDAwMDAwMDAgQ1IzOiAwMDAwMDAwMTM1YmQ2MDA0IENSNDogMDAwMDAwMDAwMDM3MjZmMA0KPiBE
UjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAw
MDAwMDAwMA0KPiBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERS
NzogMDAwMDAwMDAwMDAwMDQwMCBDYWxsDQo+IFRyYWNlOg0KPiAgPFRBU0s+DQo+ICBpd2xfbWxk
X3N0b3BfZncrMHgzNS8weDQwIFtpd2xtbGRdDQo+ICBpd2xfb3BfbW9kZV9tbGRfc3RhcnQrMHgz
YjYvMHg0YzAgW2l3bG1sZF0gID8NCj4gaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQrMHgxODUvMHgy
MjANCj4gIF9pd2xfb3BfbW9kZV9zdGFydCsweDU4LzB4ZDAgW2l3bHdpZmldDQo+ICBpd2xfb3Bt
b2RlX3JlZ2lzdGVyKzB4NjkvMHhjMCBbaXdsd2lmaV0gID8gbXQ3OTk2X2luaXQrMHgxMDAwLzB4
MTAwMA0KPiBbbXQ3OTk2ZV0NCj4gIGl3bF9tbGRfaW5pdCsweDE5LzB4MTAwMCBbaXdsbWxkXQ0K
PiAgPyBtdDc5OTZfaW5pdCsweDEwMDAvMHgxMDAwIFttdDc5OTZlXQ0KPiAgZG9fb25lX2luaXRj
YWxsKzB4M2UvMHgyZTANCj4gID8gZG9faW5pdF9tb2R1bGUrMHgyMi8weDIxMA0KPiAgZG9faW5p
dF9tb2R1bGUrMHg2MC8weDIxMA0KPiAgaW5pdF9tb2R1bGVfZnJvbV9maWxlKzB4ODUvMHhjMA0K
PiAgaWRlbXBvdGVudF9pbml0X21vZHVsZSsweGZlLzB4MmYwDQo+ICBfX3g2NF9zeXNfZmluaXRf
bW9kdWxlKzB4NjEvMHhjMA0KPiAgZG9fc3lzY2FsbF82NCsweDRiLzB4ZjUwDQo+ICBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Yi8weDUzDQo+IA0KPiBGaXhlczogZDFlODc5ZWM2
MDBmICgid2lmaTogaXdsd2lmaTogYWRkIGl3bG1sZCBzdWItZHJpdmVyIikNCj4gU2lnbmVkLW9m
Zi1ieTogUm9yeSBMaXR0bGUgPHJvcnlAY2FuZGVsYXRlY2guY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sZC5jIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbWxkL21sZC5jDQo+IGluZGV4IDg3NjI0NzMwZmI1MC4uZDc4ZDFiNDMz
NGRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21s
ZC9tbGQuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9t
bGQuYw0KPiBAQCAtNzcsNiArNzcsNyBAQCB2b2lkIGl3bF9jb25zdHJ1Y3RfbWxkKHN0cnVjdCBp
d2xfbWxkICptbGQsIHN0cnVjdA0KPiBpd2xfdHJhbnMgKnRyYW5zLA0KPiANCj4gIAkvKiBTZXR1
cCBhc3luYyBSWCBoYW5kbGluZyAqLw0KPiAgCXNwaW5fbG9ja19pbml0KCZtbGQtPmFzeW5jX2hh
bmRsZXJzX2xvY2spOw0KPiArCUlOSVRfTElTVF9IRUFEKCZtbGQtPmFzeW5jX2hhbmRsZXJzX2xp
c3QpOw0KPiAgCXdpcGh5X3dvcmtfaW5pdCgmbWxkLT5hc3luY19oYW5kbGVyc193aywNCj4gIAkJ
CWl3bF9tbGRfYXN5bmNfaGFuZGxlcnNfd2spOw0KPiANCj4gLS0NCj4gMi40NS4yDQoNClRoaXMg
d2FzIGFscmVhZHkgZml4ZWQgaW4gd2lyZWxlc3MNCg0KTWlyaQ0KDQo=

