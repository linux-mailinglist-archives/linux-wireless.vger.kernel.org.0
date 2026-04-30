Return-Path: <linux-wireless+bounces-35710-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKFqIMpT82mLzgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35710-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:06:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C75834A3282
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C128305C635
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7B40B6ED;
	Thu, 30 Apr 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAHzW5lP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A540B6DE;
	Thu, 30 Apr 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553937; cv=fail; b=NmCoByuFQGH9JGcbpMYVrz+DF6JWd7ltrBVZT1dZPgXCdcdkrzs7hWke/CimflUUlKJiKzqD+oV7jMG0aqDJGkzcEvNkBYIOyCpz9X/vCGkpUupRB7+TeJuvSwD4ZshoHHxwYvSbrRFFLxleGtEj2svE8nYma0LYdyETMNpOtWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553937; c=relaxed/simple;
	bh=krDDmc2zQgcI/7Da2saqs9Mg+901gG41JsblwUCAUFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SubBueCIxBVKmHjLNMieBRPRv0OHmU2fCETnoS+7kuzB80pQf7D1dCPHZXfSP9+afxmW700uPzNLry8ytyA25AR3SfFBTc0RAtKMHTsCoemFpI1Caa46JOK+1etVOPgEvwisUShLcTQ0TQ5QO1vdXo+s+rtVkyn6nNKU5zwZZS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAHzW5lP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777553936; x=1809089936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=krDDmc2zQgcI/7Da2saqs9Mg+901gG41JsblwUCAUFk=;
  b=LAHzW5lPYmBlNL2fgjohpEksQjOHtw2HyVraZEahI/V4q6a6fZM4cxVS
   PAVEf/AXJUipGmTXldgweDQfszyqJG0jOmab827qamMbmNz26GwFrFBh4
   7YtS0EaORFXZy9I/VyXXDwrvWmlTcM0lQBU45Z0h0H8leyPQIL1g0LQcX
   xTtpXm81KQfhhRwwCEICOH5CNIbMHoA+Wf6VWB4IFGGHUfLedC7o55l1q
   NgRLSZYKCPnfaAJxQeW0LyfiaD7pDTUUOyPgOX0nwj8Gqi21gDAwhqy/9
   wKSAynvJhI6u1QTmpZ2WCwIAguJLdkhDSKlIKFBY/+1tJ6S0a2Gm9zLxK
   A==;
X-CSE-ConnectionGUID: NJVt+IU4S5+vWRyywrHrsw==
X-CSE-MsgGUID: X4D8NUrqQdiaBKt7fpvqUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89595440"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="89595440"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:58:55 -0700
X-CSE-ConnectionGUID: rBWk2QFTQS6uH/Cn2htttQ==
X-CSE-MsgGUID: /1mCb8P3SQmLpdmP3aEm2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="258154951"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:58:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 05:58:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 05:58:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 05:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXcDj2wZa9BGgKBq3BPHUDQxfcU3CK2tqKukxMIqQqfO9OgK5k+zhVPwNsfgcvomd6CnPnUpEt50uuYjgdT9A5lkfxm4z+umZIRWMeqjgJkASnahwuY1wW77fD936LUggmuQjdI38DlRPKVoc4fh6Jm81jK/csWOpS3r3f9zx8xIlBkdj0vbgHUX6MlE243wYZp/MfDQoctFZ90wLB4/zsnuYCjUR9D15hJ3i2moWt2qV+blkvHO/6TztNlXJl+QnnQGImJ9vSxkVDpkhU1uyg9iX3Akomh6EjRo1RPb5L630wYv1YP/5oVuxvLnM8H9xLTmEgyHxzaasbpYoLmmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krDDmc2zQgcI/7Da2saqs9Mg+901gG41JsblwUCAUFk=;
 b=IbWtJH06thtDsjVw3DFXMxqyo8mFSwUHy11x0MQQ/8LT//nvUTcOQyKdpnDtS0JlyRyhrh3Gbuq0F8+wrJoCaTLFaxIBwB/IR2KNplK/t91fFPEw7CAaGeeDDAJXPT0Iu8E66IhoeW4cFq5cV/VPhPczg/WMe5H6vHXy2YgvpdB/cEHjJbIUIYpwaK8lXteM9ds5RWHg3Mgd/fd62diHSBt8ucF/3HlMJDqW3GAKyafjmcN0DUn6r8U77J+uH7qx7wOM+GQfBbmXfNZilFBJPPBq9cpcPQIhilZ5dhnePmZyIqT3TSec0znIIX1c2OP87FugBgliPoai9VsEcs1A8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 12:58:46 +0000
Received: from BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12]) by BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12%5]) with mapi id 15.20.9870.022; Thu, 30 Apr 2026
 12:58:46 +0000
From: "Bhatt, Avinash" <avinash.bhatt@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "Guetta, Kobi"
	<kobi.guetta@intel.com>, "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: RE: [PATCH 0/1] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Thread-Topic: [PATCH 0/1] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Thread-Index: AQHc17AuCyG5kLWp+UCDYdnVBEO9crX3PLSAgABVn4A=
Date: Thu, 30 Apr 2026 12:58:45 +0000
Message-ID: <BL1PR11MB5954722BD1F1EED6C1F5AEF8E0352@BL1PR11MB5954.namprd11.prod.outlook.com>
References: <20260429081403.46087-1-avinash.bhatt@intel.com>
 <f8351134-c421-49ce-a314-8731c9d1cf02@kernel.org>
In-Reply-To: <f8351134-c421-49ce-a314-8731c9d1cf02@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5954:EE_|SJ0PR11MB5215:EE_
x-ms-office365-filtering-correlation-id: ec5b1bec-90da-43db-68c5-08dea6b83704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|13003099007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: c5u4bUaNvYrEZ6fI9SWhh6CpXavsNVaecCwXOjRkyMMRVigQi8pfOx3gQzmYIMcBT89XZGTkuS2GT8DqAnhwsDZCjUnOzeh+0Xlmj2HDiWL/5nUA0ERihoQs6EgqUVPLGe17DXAwTNHAAbYK6P5zKPc/kY5rEse/O21HuMlSQnrIzV4YTilPfkN7+8dS/G4IyIQ5LwIuks1wl7M8YNfebFCYD3vdf/Up3ExjI8sy6b4RhUJ/ODT1TrMeY3ueIAxSrOVpbgm08y2StTWQsADo27/PktllhsN8osG74tXEVh5UiGS6/b539+7DrPMoIgxkNrgv2AV6JFSGEN/YjwaLVenYSRqUscPAIEOYhXXIhfkcP6JSRstp4mYUi5xv4xl0gmFRMxlgBUrySDOrwIbyy9RUS+X4lW4HLG4fpnsIZZeTk+eyTOfVpQmHkHe/OPgqP+OTsXgRgdLlO9O5AsKq0qkCUEPiLuW6RDjpFyLqIPwB/1LXWOfZplt5x2sYPEKEChlwoM/htONmp0Nj4Xaa0aviHzhynBT/dF8t7JrNnQtiNpX8oiJuD/ihmmaKvbA7zAnmEPUB5+0lPbmxjRxkYTyO/oFVS5wzRy6wwcrDffgwB8byj9rugd5Ug6KbpSQtqasZzNxWGErkyA3D5ViO7UvAYSxRG2BQY/KHRDUXg+AQxzB4m1xUNd1T0YQRF4I5XJWjdd53RVb3hbu36moFk1wPL9mrLYGFn6MWTx3cxfU9U8VirHUGrfZzeJFzIuorpXMWLQ395MsPLvo3qVdG9NkF/BDE/HrOtKA0dpuhvto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVVhdStNYkFwSW4yNkZMY2xrbWZKOGRUOFRwd2IvVUR6SEJEclEvS3U4RElJ?=
 =?utf-8?B?UE5CZU5WWDlPdFRta3oybkZzeU4zeFYwK2tDNlRLWUZtcmUzMGFZT1ByNnJx?=
 =?utf-8?B?bzhlcGZnaGFwSmw3ZEVqaWhGY1ZKREZxTkM5eGdQR1JpTjQ2dEM0Yk1QOXh2?=
 =?utf-8?B?MmgzMlp3cWEyMEkxZnJBZSszdC8yK3pyM3NnMHdsMFM5RTEwRnU3U1lsSi9t?=
 =?utf-8?B?RHZsTG05ZzA1SmZjdEE2TWpXSVVyRDJidE1uZWRScDh0T2FvNW81Rmx6VGtk?=
 =?utf-8?B?OGRuZGlROWpTM3BpNFl1em4wcTBSSXZFdmY3RUprMTlmbS9VS1gyRWljL0Vh?=
 =?utf-8?B?Z3VGbG00V3VtcnYwZzRGU0hKaDJMMURPbjlPdWVSTjhBUHhqVGNIb3JOdkYr?=
 =?utf-8?B?b1lRT1ZOd2pzKzdVSm9QNndnYkdPbnpzWmhCKzJRQnJqN0VjOEZ5QlQ3NEVz?=
 =?utf-8?B?bS96VlE2MkovMmUwM1JaQnQwVGVZcnpNYWZYOUlTbFlMdldWOUExWGZDMVpH?=
 =?utf-8?B?OWJUSW9EeGx4c0lLNlpFWUk1bHNhQndrMTdhYU1NR1hiUTlidmk4OWdmZzlx?=
 =?utf-8?B?UlpKM2ZDTnl5Q1Q0QzV6a1F4M280cUpiWXVwRytJU2NjKzBidXdyUzQ3RDBj?=
 =?utf-8?B?NUN2SlFxQnpzbU16Q25mRlJ1WFJjbVVMM0w5bUZoRTZrZXhmcWtrekJWVU5E?=
 =?utf-8?B?T003Qm82RjJPM1l0blFKK3RlOXdGN2c2K0RiblRWTno3bFpZcXZtRGtOa0xo?=
 =?utf-8?B?S3FocldoSGh1UEI3SWJJeHRjb29Rd3dZZHFNOEozcUNwVXV3SzJZaWRuU1Jj?=
 =?utf-8?B?SHlSeUJ2ZlZabGl0QzdxR1E0bXpsZjRXSWZBS1M4QklxS2Y4SmxnZklOVzJl?=
 =?utf-8?B?K0xDKzR2ZDBrZXZSRUJ5ZCtpK2w1ZVU5TkpRL1JBZk1zVWgxSGFzN3FHclEw?=
 =?utf-8?B?UEFRSklYY2ZNUWw0dVhvd3JsNHF1Wkc2TmdUclQ2bGRLczMwNENiQWhJb1Fl?=
 =?utf-8?B?Z0FjUFVFbU0zQjhqeVcwbDlFeHNGOEl3SzExdktNUWxSdFZLcXJtKzIzQ1NL?=
 =?utf-8?B?OHYvYlVLNkNNY0xrc2FmLzRnOTNBcm1aSkU4SnZJT01XME5FQ3N1ejFlSnoy?=
 =?utf-8?B?UW4vTW85Tm9LQzlSN2JPb3ZQbHo1UnpMZ3hyNGttWkRPS0szdlZnaUhRdi9p?=
 =?utf-8?B?V1o5NWhERC92b2N6OHgzOGp5eTkxbWVSRjhWU1ZSMFdTQURFR2ZNaDZnRmVw?=
 =?utf-8?B?dUc5azRzWnZya3ZFR1lUdVlHdE1QNThKclgwVmpvYVVSbzJQeCtXcXRZaGsz?=
 =?utf-8?B?MHg5ZnFrTGZxYjNBcHNJWmJCbzFUVU5Ncys1WldQQlIxdkxtc21rVkFidDFL?=
 =?utf-8?B?SDFxckVKMnpWM1AzM2RudnF4MXA3b21FMlhoeU1ocjVIWm9EUVJscFRqSXlT?=
 =?utf-8?B?dFhYcWtyalFKcGhJMitsSFh5Mnd1dzk1RDVxTGgyL1FKa3JXK0VXZ2xOYUI2?=
 =?utf-8?B?MWFsdm0xNEVXeHpOZ1VLMUgvZy9rRnpESWd6T0tiZk91bTNwTTZwa2lNVW0z?=
 =?utf-8?B?c2VyNk53azd4bjBpU2tuN1dhNFFQdFFsSXhLRjJodDYwYTRlNkZzNERmTHJW?=
 =?utf-8?B?bjhCSFNFRzN1SUtOWk9KMzNwamVzZUlUWHZsOUJnZjQ2bWJLMFpOUWtSMVZV?=
 =?utf-8?B?TWRzVlpCc2FIeEhwNlNxZUl2MGIrUjFkR1VZelBjN3N6eGJsMkxPclUxcy9R?=
 =?utf-8?B?b2VTdG91WjdoREh1TDdEc1IrbmhlamFRdXRFdlVsTDJkOEJ0TnVncXVJWmc4?=
 =?utf-8?B?SjdhS3pCUDlGVTZ6VGNSZ3ZFNWt6ZnBIUzBZRXNDelR2WE9uZlY0MXBkKzU0?=
 =?utf-8?B?cmc3M2JLU29nR1lsN3hlTW5JK3JjN3ZBdEkyeHlnYjlrZnc5aG93VjdZWlkz?=
 =?utf-8?B?cmtIem0xUitxVGptK0RDQkw4TWQ5Ni9objJIZ0JwZHVGM1NtQkF3ZkpWNkZw?=
 =?utf-8?B?WkpqT0ZRUVkvL1AzY0tOb1BOdERTMk1XMzVXSERBdmZCL1BUempPMFJ1V29s?=
 =?utf-8?B?ZWJwS2d5UC9KRmY4RlQvTU5Kd0FTRjBLYVN5QXAxMlFaakd5VU9oM0ptODNp?=
 =?utf-8?B?bTk3SW55NDl3VXFCVkhWWklzNXZrdTVmcmp3Z3hUTm1QT2l2L0dvVnhMM0pW?=
 =?utf-8?B?QzNDZ28rYmx5YklhT3Q3R2pTUGdjaHppVHVqNlEzT2YrbWVsZER0WTE2bXFH?=
 =?utf-8?B?M3ZWbHprRDBLdEZqYktUc3ZnMW5sam9qaFZsQWdzcHJLRjk1T01YVXp6NVRm?=
 =?utf-8?B?dUllTndxT2RMZ3pCVnNQdGdNQzBXbk04SHVYSCsrUlZCWmtERXRyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LSwiA5UOr/U7YBlip60NkTpSIS3iET+tdQa0Bm88eZcd5NhFS3mzhnS7eoz+Y1a/gonjJ+7xE8Us+IC9XKbYRN+qthJCXfzNdRMEhOAMkMlppuQp2VivJX/FXwdW6Jw18MZnVtoKkJowCr2SXFba1Q6VimJKYEJCJi7tFT4PzTZ3zHfwmWh0XKqawF5UntXl+JwWZ+UgqK6k/FHLbdbLllYUBd2VEZEmcYLNXqF3pAzzKm9bVEeruDD1NRueM/cd6727Z/MY4pbbzUhQ0gS0ZcLeSVbPa1W3Hw6Dn+7yhkv72yTp+N3icLhPBusVlKZ3sTpTtgSAwx51UqCFbxq58g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5954.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5b1bec-90da-43db-68c5-08dea6b83704
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 12:58:45.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwrwYy1UCvj3p/sAm5fST3gYbJ9xRpzS0Sm0QpfE0/ftt9GK1TOy/Puzbcou+MaSfhkzs+p0SDFcPj6iNUH9pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C75834A3282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35710-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

SGkgS3J6eXN6dG9mLA0KDQpBcG9sb2dpZXMgZm9yIGJvdGggaXNzdWVzLg0KDQpPbiAyOS8wNC8y
MDI2IDEwOjE0LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAyOS8wNC8yMDI2IDEw
OjE0LCBBdmluYXNoIEJoYXR0IHdyb3RlOg0KPj4gTGluayB0byBSRkM6DQo+PiBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvZGV2aWNldHJlZS9wYXRjaC8yMDI2MDQwODA1NTcw
OS4xDQo+PiAxNTc5LTItYXZpbmFzaC5iaGF0dEBpbnRlbC5jb20vDQo+DQo+IFNvIHRoYXQncyBh
IHYyLiBQbGVhc2UgdmVyc2lvbiB5b3VyIHBhdGNoZXMgY29ycmVjdGx5Lg0KDQpBY2tub3dsZWRn
ZWQuIFJGQyBjb3VudHMgYXMgdjEgc28gdGhlIG5leHQgcmV2aXNpb24gc2hvdWxkIGhhdmUgYmVl
bg0KW1BBVENIIHYyXSDigJQgbWlzc2VkIHRoYXQgY29udmVudGlvbi4gVGhlIG5leHQgc3VibWlz
c2lvbiB3aWxsIGJlIHNlbnQNCmFzIFtQQVRDSCB2Ml0gYXMgaXQgc2hvdWxkIGJlLg0KDQo+IEFs
c28sIEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgY291bGQgeW91IGNsYWltIHRoYXQgUkZDIHBhc3Nl
cyB0ZXN0cyBidXQNCj4gdGhpcyBvYnZpb3VzbHkgd2FzIG5vdCB0ZXN0ZWQuDQoNCkkgdmFsaWRh
dGVkIGxvY2FsbHkgd2l0aCBkdHNjaGVtYSAyMDI1LjEyOyB0aGUgQ0kgYm90IHVzZXMgMjAyNi40
DQp3aGljaCBhZGRlZCBzdHJpY3RlciBlbmZvcmNlbWVudCBvZiB0aGUgaXRlbXMvbWluSXRlbXMg
cnVsZS4gV2UgaGF2ZQ0KdXBncmFkZWQgdG8gMjAyNi40LCBmaXhlZCBhbGwgZXJyb3JzLCBhbmQg
YWxsIGNoZWNrcyBub3cgcGFzcyBjbGVhbi4NCldpbGwgc2VuZCBbUEFUQ0ggdjJdIHNob3J0bHku
DQoNCg0KQmVzdCByZWdhcmRzLA0KQXZpbmFzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiANClNlbnQ6IDMw
IEFwcmlsIDIwMjYgMTM6MjENClRvOiBCaGF0dCwgQXZpbmFzaCA8YXZpbmFzaC5iaGF0dEBpbnRl
bC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGpvaGFubmVzQHNp
cHNvbHV0aW9ucy5uZXQ7IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5r
b3JlbmJsaXRAaW50ZWwuY29tPjsgR3VldHRhLCBLb2JpIDxrb2JpLmd1ZXR0YUBpbnRlbC5jb20+
OyBHcnVtYmFjaCwgRW1tYW51ZWwgPGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMC8xXSBkdC1iaW5kaW5nczogbmV0OiB3aXJlbGVzczogaW50ZWwsaXds
d2lmaTogYWRkIGJpbmRpbmcNCg0KT24gMjkvMDQvMjAyNiAxMDoxNCwgQXZpbmFzaCBCaGF0dCB3
cm90ZToNCj4gQWRkIERldmljZSBUcmVlIGJpbmRpbmcgc2NoZW1hIGZvciBJbnRlbCBkaXNjcmV0
ZSBXaS1GaSA3IEJFMjAwIFBDSWUgDQo+IGFkYXB0ZXJzLiBUaGUgYmluZGluZyBkb2N1bWVudHMg
b3B0aW9uYWwgT0VNIHBsYXRmb3JtIGNvbmZpZ3VyYXRpb24gDQo+IHByb3BlcnRpZXMgZm9yIHBs
YXRmb3JtcyB1c2luZyBEZXZpY2UgVHJlZSBpbnN0ZWFkIG9mIEFDUEkvVUVGSSANCj4gZmlybXdh
cmUgbWV0aG9kcy4NCj4gDQo+IExpbmsgdG8gUkZDOiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2RldmljZXRyZWUvcGF0Y2gvMjAyNjA0MDgwNTU3MDkuMQ0KPiAxNTc5
LTItYXZpbmFzaC5iaGF0dEBpbnRlbC5jb20vDQoNClNvIHRoYXQncyBhIHYyLiBQbGVhc2UgdmVy
c2lvbiB5b3VyIHBhdGNoZXMgY29ycmVjdGx5Lg0KDQpBbHNvLCBJIGRvbid0IHVuZGVyc3RhbmQg
aG93IGNvdWxkIHlvdSBjbGFpbSB0aGF0IFJGQyBwYXNzZXMgdGVzdHMgYnV0IHRoaXMgb2J2aW91
c2x5IHdhcyBub3QgdGVzdGVkLg0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg==

