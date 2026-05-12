Return-Path: <linux-wireless+bounces-36319-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JLkHIAT8AmqHzQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36319-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 12:08:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C651E46B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86313088D8B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292D4C6F06;
	Tue, 12 May 2026 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuWDLbIr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201B3AE187;
	Tue, 12 May 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580244; cv=fail; b=ke3+PkmNIzsmJ0d2QM4uHDlER+vL+c2SZCHsnY+lrYoPLdFLdHzGLg4lLnBpReinrQtZJnVq5+psA30Bwf8x7T0LWO8x0iKuQYtH8x2Xz+sC7Beji2xrQzkb779TdpMt8K+dasIQlb9wjMDrUgpUKWYNMrycDBCrqFpnoPhtBXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580244; c=relaxed/simple;
	bh=1kDzzhUb4mVfe16gGeGbwl0cItpbfaL+OnQGzQXiTiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xv76+PLQG6M1ADBvfRoy74FtEGeYrNbx7Y1qzwDT1x863EPLf3qrKSiCSN6h7WtQnSkDjNqjjWzmZG4QRYTdQu1I8WdwT95QSzAIczgg4Ngtdj0vaLmXuNGeJ9hk928oxVLP08jspVMuGeCNjyR249n/xDObBtPBpQGKe5m/z1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuWDLbIr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778580244; x=1810116244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1kDzzhUb4mVfe16gGeGbwl0cItpbfaL+OnQGzQXiTiE=;
  b=OuWDLbIrNPwsT0rCtN4aJBp62fsJQIGwvPmBROAr+U1iRxXYeWBRe2lf
   1KjespVZ483bwVB65aVY/EhaxgJX2p9vyzmUgfug4iQM6QSpyhg4JlFWk
   1909cpECj58p1fyYjmn5pH6nq7dm8iOgMLA53QbEgeCKM2S4OH6Jdt8+p
   82F9qe5W/UAwLklS1SHPxipdq6RI5nKWSx1J3nEp7gu32pTzZ3NICaB7A
   2reCGIvcV6diqV4cWGxThqOnuLl5nR7Ws28Ex0HUIfvGt74yqzmJxkxed
   SjFUHQeNa+5Yqmy4EetnWfZRbVBjucWsQNd//O7dBk0a7KX57tNc+addH
   Q==;
X-CSE-ConnectionGUID: 5g4oN9ykSjyft+2kRAw5kg==
X-CSE-MsgGUID: ZcY8pJ8eS7SMjiISsvitaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79506359"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79506359"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:04:03 -0700
X-CSE-ConnectionGUID: CayWFbdqTSiW99I1NmsISQ==
X-CSE-MsgGUID: /NqbVcFEScqRAo7KixrlLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="261478913"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:04:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 03:04:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 03:04:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 03:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3Q6G5PdMFVWO3gwG5BBBzDisy2J6eEDRPrqUxwQ1GUqeXCUe6EBjmDEpvpTeBzsbml93kh21V1pRNSuEDnP+HKRgLv67X1aqQi6y1f99jthsMBMMnoE+0lDeJiMRbzdHpmSmmb5azVsIb7hvu8DcuZ/yYDlwbXm6AnLVREoom1+yB8dSoZwY0IWC2/vFn7JCoBfv7xVFIzjMp9vOYpTm6oeJmDhTI60tHmjt7vQxzC4lKjbrh7ybCxLQZFxsOrfUL/Dv9Q7FwfXYFpJmKJYZopAjQMmD4fCufi3kykI6B1HkK4q7FXJGuHRaqNZMRf0TpWPwIA7FTTsFZZMUnGmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kDzzhUb4mVfe16gGeGbwl0cItpbfaL+OnQGzQXiTiE=;
 b=J4seM5psrWZ6q2oJpdRw5fa4v9uuByWuOy4cCDJ0bUIPKYXHDWai0xSDSOkf799Gk+aZFA1bPUtIQ10T84WsxnzuU64pHBRBubL9Bc1Jvvy5DBjc9qh1XkeZrBJ/cx3Eh34rNruGTTaVoodF2ZbFpw1zij8Tbuzgo3JiQbIi3X9L+quUT287CLa9/6XMJB6FYcNNR/dJ260rwe3FDLR6q5dhgKDiK0yy+76geijRybK7V6KbQuxCrZoV01chfDXeXp2XAnNpEFCwRMlG+IF0DECMhrGJb3vA2beet01rKLBH8J0A80yT5IvzdsuwqFbZqhHU30J4s9OFgQWtu26FSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16)
 by PH3PPFF1A08ABF9.namprd11.prod.outlook.com (2603:10b6:518:1::d5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:03:57 +0000
Received: from BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12]) by BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 10:03:57 +0000
From: "Bhatt, Avinash" <avinash.bhatt@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Guetta, Kobi" <kobi.guetta@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: RE: [PATCH v2 2/3] wifi: iwlwifi: dt: add Device Tree BIOS
 configuration infrastructure
Thread-Topic: [PATCH v2 2/3] wifi: iwlwifi: dt: add Device Tree BIOS
 configuration infrastructure
Thread-Index: AQHc26vpGkW3JjGX6kK97BUB4yxI/rX/KN+AgAsM7YA=
Date: Tue, 12 May 2026 10:03:57 +0000
Message-ID: <BL1PR11MB595490A72F8319FBB23194F1E0392@BL1PR11MB5954.namprd11.prod.outlook.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260504095327.30892-3-avinash.bhatt@intel.com>
 <20260505-sincere-electric-lobster-2a7bc3@quoll>
In-Reply-To: <20260505-sincere-electric-lobster-2a7bc3@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5954:EE_|PH3PPFF1A08ABF9:EE_
x-ms-office365-filtering-correlation-id: a450014f-fde8-43d7-69e8-08deb00dc87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003|11063799003;
x-microsoft-antispam-message-info: 6BdXiJ9OLKsr0FykP4tA57qE8q+ecME69076iOk62q/NTdVjpqxyKs8iz94l18mg3gI5ILP8fjmupahPJD8IhNUwNPJcrnXpna5Fna6HPS9XZ9WhSA9n8TIuUnoOVdih+MXm37gjQkB/7VB3pXpYr0FfGOO5d5k1aR8C/GBuJpU4hjPUQSkXjNjCPdBIX3yaix89H7x4pGQ7bxnfCnyURpxle3zjQ5CckhupLa1Wq0ocEBkFl+mD5dloqY+sHYHRCZ6AmbLf8bx45sv7/cPIfamjXBqX93n1hyCOIkli5M9D0z1LiFfFAvF1qG6EMGeqleCdh0UELV332iMtPXNOsUhucgSwwUdCnRYPjfC8s4pbskt+pDYq/B+g6OuOGhsexo91V1tToMN3Ipgi9T89iKnQMRbTwAj3sD0pJhpfH9eKN7XhJYB8HwfvX/vuI+/bjZoznW+JCs7zhK+EiHcycZLaNlAtn9qoeiOXAFS7xBHymNOMOAVSlNXRli2dpAnxtbya61MRlZgpg4DxLC/m6SFOZK2neWZtkaTfhQRZKspj46TxYXdnrAs8Mt3//14joStL8xVQ4NiPSD6OJmAs5AGuer+2bfueXiR++BLIpXG7VbGIVY+mrxwslhW/etkK4YRu10GDAQK5rNLkD204F8K0hjzfSY2JCGeC5QvVb2zF9Zp/DAXCp87envzud9EoHTgTQEgzca49w90E6T86GT79hOBLVNeRjGjX2ZCC8R0Rv8LnGtKP7zalFEm3oMz2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWpHcHZRSFNtWlB3bjNzOGpjQ2RPamgzM01lRWU2ZUV2SkJmSS9kZThOVjF3?=
 =?utf-8?B?VXNmVUg1QVA3dGJDeThHbG96cXdjQmtaZXozY3dyV3hxbXNaaGM4U0creWpv?=
 =?utf-8?B?Y1pVVUYwa2Y4QVNpanJ6TmgyNmlYZ29tV1pXVlpCVWxIbk5ER3h3enozcFFM?=
 =?utf-8?B?K0JNa1RjRDdZbXZkNkhJVjBnUnNRUitXTjlNcFp2WDAxQTI2Q1g4Wjhzckd4?=
 =?utf-8?B?WHVqeHZWYTUwT2hsaXBkTnlRZG92cmdEOVJSRnRBVFFiMmYyV1FtZSt4YUJ4?=
 =?utf-8?B?eWpqSzlsZmZiZjZMbWM5TkNTMDkxdk9ibzdwNitxR1pPRmMwR2hGTVVMK0hy?=
 =?utf-8?B?SnNZL1Y5YTJvOTJ6akFDd3FrWnkyLzBNWTJvZWhNeHVROTJzc0puT2FTaGNP?=
 =?utf-8?B?cHlSaEJCK3ZpdlpUV242REYxV0xKbXpuaWw1NFF1UE54ZHlLRnZLYnlzYjdL?=
 =?utf-8?B?VzhVYVpIZFIrZ1B2azA5WmdBaWhsYTdScnNoZm0vQzRsMjVqQWVWVjFnRnMy?=
 =?utf-8?B?WlZhcjdSalFjZGNBSWNBNjBKUmxYZXdOV3kwdzZsMGpFM3Fad0JJblJ3VnNM?=
 =?utf-8?B?WnVPaWRnY3M0MUI1QnZNcmhTazhKdFlkMVRubDRjMXV0blZDeU9BQWx5L1Fr?=
 =?utf-8?B?KzdBWE9XcC9ZejNmc3VFdkp4WUJWM3QvNDFQc283SmwvWVZGOURtUFUwZWdB?=
 =?utf-8?B?L3lTeERJTDB6dDM1VzNYWWl6NGxqMmFWQjY0Z1M4Sk9HQ3NKbkRrdlh4MHdv?=
 =?utf-8?B?R0tFb1lXRUxnQmV3UUtLc2pXbnJLb295aXJFclZrMjR3TzIzTy8rM2YzWHlT?=
 =?utf-8?B?UEthWm9pTVdSYSsrcDVsdmErNmwxNlZhc092N1JoNjNqbGRkcmFIYjJTUTRK?=
 =?utf-8?B?em9QaHkzdWNkbzBqVGVkUXYxbWdwUWx3Lys0LzYyS2VhcjZUSmVhSFU3Y2RN?=
 =?utf-8?B?eW5nZEJiMVhtZmdvTlh3OUxaV2twOWdJTWVKdGdJSzBZWENZQzFwVldDY1lv?=
 =?utf-8?B?dC9CU1hBTUZRNlc5N0lxaVhDczFQNjdjNUJWbzcxRnFnSXdDSG9iMmdMaUZU?=
 =?utf-8?B?Wk03ODNPUWxyK0psOGVtNEFFd0UxQzYvSXY4R0M3M0hsa2JrWTdFeE5LekVT?=
 =?utf-8?B?d3U1bGxuSWdMY054VVpiSnFHSVd0RHJtZGFXTlpZQm9kVG9mTktKUTg4aGlC?=
 =?utf-8?B?NWU1SCtyOStwcDFjSE8zdGVhUjJhcjJ3RThGbUVRekJXamF4M1lQMUxqWkYv?=
 =?utf-8?B?dnJFV0ljMkZ1YzE1ZzEya1UyNStNbTV2dVcvTEFnYVFwa201Ulc4Ky9GRy9i?=
 =?utf-8?B?R2szUTNkK3FHQnhrUkxyM0xqK1hzNE9ubTY2WWJOb05JUVBCZ1d6NHZmN25N?=
 =?utf-8?B?UmhSUVZqcWpiczhqeWNyaFQwSm9YOUpPUnFVTU13ZG5FUDUyZ0hSNjZuK0VI?=
 =?utf-8?B?SG9mc2poOSszOGFtdC9JR29Ld2liM0JGYmRKQTU5VHFmL1RFSXV3Nk8yL2hN?=
 =?utf-8?B?SkhPOFJ0U3JnQ1N4R1FhM0ZFNlJnSnFVUzJIYUpuU21LU01nZlJnZkdkK2pX?=
 =?utf-8?B?aUExNW1JK0E3b295M0Mzc1QvVGRoZEU4K3BQWUNkbkZMUkFsRjhHUHU0b0dZ?=
 =?utf-8?B?UzFwckdMSU93MWVyaEt1b0F6Y3pnK1hVU05XVDBpNnp2SDZYUDdhaUFBamVM?=
 =?utf-8?B?aFJDbTZUMkNKdmNrN0YvRGdXV1dvem9oNDdJcy9zRVFuTmhBcnVUWUJVNjF0?=
 =?utf-8?B?cjhlMVMvTnppSHZMUnVrSkVzcFJLTkJtVTNTanlaOG9UZHJYTHdlWWErQ2pH?=
 =?utf-8?B?Qk5jNFE1MElIUGFUcEpFaGtQUGNpYWJRTDhaY3N3WkVSRWJ5M3VMK3VMRFVR?=
 =?utf-8?B?RGtlZXkrZXlYRTVnVUdqVjlRaTRnNURPd2NTMUV0U0gzaUM1MExwQkhSdEwx?=
 =?utf-8?B?NGtIR21SVFM4TlcxU0pJaGhhcC9vanQyeWFmcEswdldzdFZxR0QvQmZ4bGIw?=
 =?utf-8?B?SWJMbkxDZGhvVFJET3plRm1KcWxINElTMmo2NlZNeVk2RlYraG9YaHRwK0gr?=
 =?utf-8?B?ODZHWVg2K25lZ0xyY2RZMUNoU0pQZ3NoN1RuNmVZQ2l6VDBXT3pXRDlLbVha?=
 =?utf-8?B?SFVRTlBGTm9mRDdMdzZTNzN6MG40QTl2VEVWMjZ3Q3JOSGp5TTBmai9JOXdW?=
 =?utf-8?B?Z3hSbTFCbG5TL0pGbGhIZ0hkVGdzOUJlT1lPMHorMzQrZkJLdWNJdHZUOXI0?=
 =?utf-8?B?SnA4blR1OWN4Yk1NM2ZITlE2S25aSFdoNlVBMERGUGdwR0tWVGVQTXdER3VN?=
 =?utf-8?B?bHZuWlFBUGlkcFk3dXRnSzQ1OEtHQ2ZRWVg4ZkE4aHYvRXlxaENlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mPcymGEejCFCVJwIbPpH839n/qIwAPPohKRC1FfyvnaDj2k2O4w4sR1sAXT2aFUzp9bIm18QKb+rQ4bgNNZMFIK8Qymgx6WmHXhfG+qBB1kdhKyCOE7xKDrJuWtqy+HCrvbusKto4ns4/HA7IqtuFl6Md+g6bB1OgwwHdoMIHRrY7qwP8VKTJySVZdZ7nHY4HHxaGV0W6CfXhIzXI7wb6OWdgWWnoZ6kIj2R74DXH0KYs/nqh7qF5ZD9H6/BUKiJhmUW54hyaj+oR37xgAz5b0d+O+ZUolb8zIgvEWO6JSSvJGelx5K+y3w8VszNikRO7swqO/Awy13Mp2zlUVOdpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5954.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a450014f-fde8-43d7-69e8-08deb00dc87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 10:03:57.7626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1ze4A/6+3MorWeBO7CEN+h+6/ZBYk4s8nlfb32VXG9TN59cnC2AfxGeNAikME7ux/zLh0U6xNVFB9r1zflyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF1A08ABF9
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 170C651E46B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36319-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BL1PR11MB5954.namprd11.prod.outlook.com:mid,sipsolutions.net:email,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIFBsZWFzZSBmaW5kIG91
ciByZXNwb25zZSBpbmxpbmUgYmVsb3cuDQpXZSBoYXZlIG1hZGUgc2V2ZXJhbCBjaGFuZ2VzIGlu
IHRoZSBkcml2ZXIgYXMgcGFydCBvZiB2MyBhbmQgd2lsbCBiZQ0Kc2VuZGluZyBpdCBzaG9ydGx5
Lg0KDQpPbiBNb24sIE1heSAwNCwgMjAyNiBhdCAxMjo1MzoyNlBNICswMzAwLCBLcnp5c3p0b2Yg
S296bG93c2tpIHdyb3RlOg0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmRzbV9mdW5jX3RvX3Byb3Bf
bmFtZShlbnVtIGl3bF9kc21fZnVuY3MgZnVuYykgew0KPiArCXN3aXRjaCAoZnVuYykgew0KPiAr
CWNhc2UgRFNNX0ZVTkNfRElTQUJMRV9TUkQ6ICAgICAgICAgIHJldHVybiBJV0xfRFRfUFJPUF9T
UkQ7DQo+ICsJY2FzZSBEU01fRlVOQ19FTkFCTEVfNkU6ICAgICAgICAgICAgcmV0dXJuIElXTF9E
VF9QUk9QXzZFX1VIQjsNCj4gLi4uDQo+DQo+IFBvaW50bGVzcyBmdW5jdGlvbiBhbmQgb25seSBt
YWtpbmcgRFQgQUJJIGNoZWNrcyBkaWZmaWN1bHQuIERyb3AuDQo+IERvbid0IGludmVudCBBUEkg
d3JhcHBlcnMgb3Igb3RoZXIgSEFMIG92ZXIgc2ltcGxlIGNhbGxzIHRvIE9GIG9yDQo+IGRldmlj
ZSBBUEkuDQo+IERyb3AgYWxzbyBBTEwgZGVmaW5lcyBhbmQgdXNlIE9GIEFQSSBsaWtlIEVWRVJZ
IG90aGVyIGRyaXZlci4NCg0KRml4ZWQgaW4gdjMuIFJlbW92ZWQgZHNtX2Z1bmNfdG9fcHJvcF9u
YW1lKCkgYW5kIGFsbCBJV0xfRFRfUFJPUF8qDQpkZWZpbmVzLiBpd2xfZHRfZ2V0X2RzbSgpIG5v
dyBkaXNwYXRjaGVzIHZpYSBhIGRpcmVjdCBzd2l0Y2ggb24gdGhlDQpmdW5jdGlvbiBpbmRleCB0
byBpbmRpdmlkdWFsIHBlci1wcm9wZXJ0eSBmdW5jdGlvbnMgKGl3bF9kdF9nZXRfc3JkKCksDQpp
d2xfZHRfZ2V0XzZlX3VoYigpLCBldGMuKSwgZWFjaCBjYWxsaW5nIG9mX3Byb3BlcnR5X3JlYWRf
KigpIGRpcmVjdGx5DQp3aXRoIHRoZSBsaXRlcmFsIHByb3BlcnR5IHN0cmluZyDigJQgY29uc2lz
dGVudCB3aXRoIGhvdyBldmVyeSBvdGhlcg0KZHJpdmVyIHVzZXMgdGhlIE9GIEFQSS4NCg0KQmVz
dCBSZWdhcmRzLA0KQXZpbmFzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiANClNlbnQ6IDA1IE1heSAyMDI2
IDE0OjQ4DQpUbzogQmhhdHQsIEF2aW5hc2ggPGF2aW5hc2guYmhhdHRAaW50ZWwuY29tPg0KQ2M6
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwu
b3JnOyBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0OyBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwg
PG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEd1ZXR0YSwgS29iaSA8a29iaS5ndWV0dGFAaW50ZWwuY29tPjsgR3J1bWJhY2gs
IEVtbWFudWVsIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDIvM10gd2lmaTogaXdsd2lmaTogZHQ6IGFkZCBEZXZpY2UgVHJlZSBCSU9TIGNvbmZp
Z3VyYXRpb24gaW5mcmFzdHJ1Y3R1cmUNCg0KT24gTW9uLCBNYXkgMDQsIDIwMjYgYXQgMTI6NTM6
MjZQTSArMDMwMCwgQXZpbmFzaCBCaGF0dCB3cm90ZToNCj4gKw0KPiArLyoNCj4gKyAqIE1hcHBp
bmcgZnJvbSBEU00gZnVuY3Rpb24gaW5kZXggdG8gRGV2aWNlIFRyZWUgcHJvcGVydHkgbmFtZS4N
Cj4gKyAqIFJldHVybnMgdGhlIERUIHByb3BlcnR5IG5hbWUgZm9yIGEgZ2l2ZW4gRFNNIGZ1bmN0
aW9uLCBvciBOVUxMIGlmIA0KPiArdGhlDQo+ICsgKiBmdW5jdGlvbiBoYXMgbm8gRGV2aWNlIFRy
ZWUgcmVwcmVzZW50YXRpb24uDQo+ICsgKi8NCj4gK3N0YXRpYyBjb25zdCBjaGFyICpkc21fZnVu
Y190b19wcm9wX25hbWUoZW51bSBpd2xfZHNtX2Z1bmNzIGZ1bmMpIHsNCj4gKwlzd2l0Y2ggKGZ1
bmMpIHsNCj4gKwljYXNlIERTTV9GVU5DX0RJU0FCTEVfU1JEOiAgICAgICAgICByZXR1cm4gSVdM
X0RUX1BST1BfU1JEOw0KPiArCWNhc2UgRFNNX0ZVTkNfRU5BQkxFXzZFOiAgICAgICAgICAgIHJl
dHVybiBJV0xfRFRfUFJPUF82RV9VSEI7DQo+ICsJY2FzZSBEU01fRlVOQ19SRUdVTEFUT1JZX0NP
TkZJRzogICAgcmV0dXJuIElXTF9EVF9QUk9QX1JFR19TUEVDSUFMOw0KPiArCWNhc2UgRFNNX0ZV
TkNfQUNUSVZBVEVfQ0hBTk5FTDogICAgIHJldHVybiBJV0xfRFRfUFJPUF9BQ1RJVkFURV9DSDsN
Cj4gKwljYXNlIERTTV9GVU5DX0ZPUkNFX0RJU0FCTEVfQ0hBTk5FTFM6DQo+ICsJCXJldHVybiBJ
V0xfRFRfUFJPUF9GT1JDRV9ESVNBQkxFX0NIOw0KPiArCWNhc2UgRFNNX0ZVTkNfRU5BQkxFXzEx
QkU6ICAgICAgICAgIHJldHVybiBJV0xfRFRfUFJPUF8xMUJFOw0KPiArCWRlZmF1bHQ6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KDQpQb2ludGxlc3MgZnVuY3Rpb24g
YW5kIG9ubHkgbWFraW5nIERUIEFCSSBjaGVja3MgZGlmZmljdWx0LiBEcm9wLg0KDQpEb24ndCBp
bnZlbnQgQVBJIHdyYXBwZXJzIG9yIG90aGVyIEhBTCBvdmVyIHNpbXBsZSBjYWxscyB0byBPRiBv
ciBkZXZpY2UgQVBJLg0KDQpEcm9wIGFsc28gQUxMIGRlZmluZXMgYW5kIHVzZSBPRiBBUEkgbGlr
ZSBFVkVSWSBvdGhlciBkcml2ZXIuIFRoaXMgaXMgbm90IGEgc3BlY2lhbCBwbGFjZS4NCg0KQmVz
dCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==

