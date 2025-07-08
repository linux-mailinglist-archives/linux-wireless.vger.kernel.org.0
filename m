Return-Path: <linux-wireless+bounces-24943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD0BAFCB2B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D9F17CF40
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC52DCBE0;
	Tue,  8 Jul 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgCgBe+y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B5221D87
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979595; cv=fail; b=rK4Fvtqul4DYeKk9YCVlik1FQHLB8BLZx93XR1PQYE9lcpF3ttKSyrrUSG4q6tXPAkHZtKUyVIv2DqMAoT6J/tZW6BGk9D8IY1WFHRs4NocJ3UXt6p4jgSiEGU1bNRWh5DO4srnw7VlgLZJ8nQxpiTNBiZfGrwB/XRHhLmP1Ufs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979595; c=relaxed/simple;
	bh=H+kqVI/LLNLMt8E2TVUXd3J3LMpsmogQjPhKcg7S/GY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uA8S9W4pIclaVk5w7kd2LIwaVW2qtWKTGqjcij5OpxqwbjZSHZlwXGeuQEhyRO6Ow/9F6VUZnbDNLyhboi4MqUc2d3uuxu19529oAxGV0Vmzmc2XxISGROgzrVoF3h4g7K+L733BLkiFtkt7/mxoNDdQveKdpJxsVg5Cp31DXto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgCgBe+y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751979594; x=1783515594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+kqVI/LLNLMt8E2TVUXd3J3LMpsmogQjPhKcg7S/GY=;
  b=HgCgBe+ydWsBuxTnnduYPRd2vQefU8YtmuK4QN/UMQKgmNA4aShfZg+d
   7TnkrazFn6JHecYdl/7LiR4CgQhI7gNdJxNgCzus5ubQj5MJTQlyvZq5r
   Vv/z8Srkoh8JVqNEaFbK7hKTmOTGy6g68kPLGgrdyRB+j2y4WEdrtNTTD
   bGct6UQHY6WaUsQsufH+sNS0NjM/12nKyPhL7I2IY6cwnOHyMQlt8UCIE
   f0gaW0hpwRAZ6x1ovumkOLpoRSfi3fhJUttWnZURD4a3Nyz/bMYyk4Uoj
   aEpSFoD3gA6aVBdxdyd6v9SCoCrzmizBD+rJRU0m7CLAcHFN15vYJYg3l
   g==;
X-CSE-ConnectionGUID: qttS/fzAQ4qwZirMDWVZMQ==
X-CSE-MsgGUID: IdyF7+bET+W72TgMLE/0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="41839234"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="41839234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:59:50 -0700
X-CSE-ConnectionGUID: pcAgjQl2S3ik7frvtxm8aw==
X-CSE-MsgGUID: UM6Uou9kQkK/BAJfNIWz1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="192670369"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:59:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:59:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:59:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuhsOLDXnEqvwwBzSH/m+XBxUjWaEACA85CaOT9PmEBMPOibtZg6jBVS42YNZP6zvBxM3tdb9I9IqaLRYLQuEZIRMB3CW8EUyvApA4vd9Feq3KKCtanBSBIz3gU1hGMqViWeb0QuKDDRpmnPggY6KZuQwz1ONUEvlM8QMrd6kcq2x/xWl52sZ0bFuBmVLsnVNIofP+1UDJNUBZU2+HuN2psOGe7jo1uZtoENW5l+jYvLc8YevggxHoUwYa7nXEjkf9Sb7/np6zeobwASjTGgzCiLrGaiphi9gh84xXelxlkOYfMAxjt4hTfo0Ravs5Blho8Rb7EH7RJTdY2GCglwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+kqVI/LLNLMt8E2TVUXd3J3LMpsmogQjPhKcg7S/GY=;
 b=s8CodZkbaZn7ZomY3LfpmidXrWCuEa+q6224ENhuXpFsRgQN2YgMki307KlQvOLawRoD1pxNXD1unPTQxzH3jWHA2s5Dr77oYNjFz7akM7B/CIeE1n4c1/M8dqKntbg6hx5Wpz8QSt0gMzdF10SBDrcf1ZhpdhB7qTQeVUKC8Ohpjzfr2TS2qAPEptfFurD6swyD4yVmObjhN5Frhi7QH2rlC1Onrbd3rq7QmHTcthd0SwGhy+zxuxHCkXTtVkxH52gOUKWyct4xlUSI7N4JZhklz5v/v9N7qj+v582QS5mQyr3MBzKaXUMp+xHPAqa49G+sBtUqrZ3vB9yvM5K+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21)
 by DS0PR11MB7505.namprd11.prod.outlook.com (2603:10b6:8:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 12:59:31 +0000
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95]) by SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:59:31 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Vinay Gannevaram <quic_vganneva@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"maheshkkv@google.com" <maheshkkv@google.com>
Subject: RE: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
Thread-Topic: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
Thread-Index: AQHb48SdjpmBjSQ3gUKiLcOKc//j87QoN9EAgAABqlA=
Date: Tue, 8 Jul 2025 12:59:31 +0000
Message-ID: <SJ1PR11MB6252B3B53AE9473FF2B8F529F54EA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
 <20250622222444.356435-2-andrei.otcheretianski@intel.com>
 <d3526485-9f53-4202-8a88-489f3cf424d5@quicinc.com>
In-Reply-To: <d3526485-9f53-4202-8a88-489f3cf424d5@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6252:EE_|DS0PR11MB7505:EE_
x-ms-office365-filtering-correlation-id: 239a4e2f-4258-47a9-7d9f-08ddbe1f4798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDM4QmNxSmdzOXN2NFcvV3NkSDE1bnRoMnE5M1JPSm16aFV1WVNySzd4KzZL?=
 =?utf-8?B?NDNpL0hiZTk0S0FrKzF3WkoxVFJBRGUyMGtwd0dOU3pzbE1ZOFk5aWdub2ta?=
 =?utf-8?B?RHI3SEZjQlNzejNxMGFDVjBlNDhGYU81V3UyQWZIVGlkaVowc2xEcjN6MVV2?=
 =?utf-8?B?L3lLVHlaNVJJOG5CZExwaFp0RElmdnFyY0xUejRkSFRiSnA5a2VWWDY1eW9N?=
 =?utf-8?B?REhFV2ZUVmp3OUVDMENTWVBLMjRKVzBpUExrK1FrOTV5V2l6aW5PanNqYUd4?=
 =?utf-8?B?a2RZNmN2cG1aUzIydmowRlpSclpPNGNQL1Q0RnVDSVJibmt3Q3hzbXVYQUVu?=
 =?utf-8?B?SUtvNlV1UjNYQ1UxMDYya3ZMVVNRdU15THNiKzkwMkt2cElMVkJtM05pVG9H?=
 =?utf-8?B?MEFwQjdkb25Zem8zTmtCd2FFcG95ZDNVQUNQTlRCNm13VjVmRkhSOFNZQWNL?=
 =?utf-8?B?UlZZRUZCS2pZVXcyN0M5WDZzMEVkUmRJREx0WE9yMEJ3ejVpdzhPVzNwMzJt?=
 =?utf-8?B?OHVYblNmUnFJM0N0aG1JOWNXbWxNbFJEY0JEbzByakQ1N1ppcW5iQVcrQjRm?=
 =?utf-8?B?ZnNBR25lSmFUZE1RT0kxeWhqTllrNDdpaXYwbk4xQ2Vxc3N5U3U2bHpKWWZt?=
 =?utf-8?B?eUdkWmYyblJnVGpCZ0FqOHdCWC9WcTlUUkJwOE9HTlIzdnBIemRzVHdqV25j?=
 =?utf-8?B?ajF3c0VJcWQ5Y1ZhNVRzRElSa1IzdjRCNDI5MW40d3Jxa0NhV3VNY0UzY1lI?=
 =?utf-8?B?RXFTYU91TlhWbkJtbXVhN1BvSzlkMkhVbGhyanFQNDM4UjExTUc2TllmZW5B?=
 =?utf-8?B?ODdBZ0dhbEIxUDBXM0w3Z0pVRFM5WnNHWldKM282NHRuRlp0eGk4NW5zdTlO?=
 =?utf-8?B?QXRBY2lyakdjRmtlV2ZhbmNjZEZ0aTlPMVZwVFNNakdJUk1VVFUwYzVPdTFQ?=
 =?utf-8?B?WEJJKzNKVmU0TUVIV1RrdGk3U2dtTVFOYmx5SFRzYnE5dmRwOU5MVHcrdndt?=
 =?utf-8?B?RzZ0R01sbHhSNlM5ZkRGWmxYNDZnMUt4MytQZEoyMk5sVFN0eUJHbm1kaGRX?=
 =?utf-8?B?QlpVTXo1cGtNTjZucGp1R25iVnM0RWFuUjE0WC93eFZtQWJCR0FhRWRmcFNB?=
 =?utf-8?B?UURCVVJNQXUyR1RUQmNDWGNiZlVzd2Q4dEdIaE9iZzl1QnJMbU5UcUxMdCto?=
 =?utf-8?B?TVY3bGkxK0FUQ3dFRHlTOVEwV05LM2QxbEFia0lCd1hRd2dIQktCaldBY3pl?=
 =?utf-8?B?dDh1WG14VmpUak1TZ1Y2NnVVeGNFZlpqNmRRUUVjQnl5cFVZc241TjFERFlS?=
 =?utf-8?B?S3IvNTB3bEVLODV5Ym9EWHN5UkJqT2xDeTBYSjAwUzV5em52a09hYnRLRjJF?=
 =?utf-8?B?NnR6M3RaZnNERXZaUis0dmh2dUZQMFptZUhjQUVIK2d5N3lhY3oxelY5ODN6?=
 =?utf-8?B?Rnd5Y0xTcXI1eUtnRnZiZkIyYThPMVpIMktoTGpzcTB4OE1uMUtqQmZERE1V?=
 =?utf-8?B?TTQ5TFFzUklLOVV4QjZMWmJodVpPRExxeDNFdzZ3bXBGNmRtQmVzemQwdHJG?=
 =?utf-8?B?bGVZTHhDV0xrOEpWd1VoTW9SU3g1cTgwUXlaV25DSHkrOHppbnZVSFdaM1dK?=
 =?utf-8?B?WmJXWldvZjgwc3pxQkJ3VyswTWt4UFNZbkVYZlhwdkJjeE56WlV2SVd6MUNP?=
 =?utf-8?B?SWh0WTd1cndteVJVSDAwc3JjakhNTEszbmJ4Z0dkUStnUXErYzRRS1V0cTVw?=
 =?utf-8?B?QWJrRHhOMjhtRWU0QWtyNW9wVUhYUFNobzg3N2RDTjJXYjhHWEhabkVQYi9Z?=
 =?utf-8?B?UXB6dXVxNWJjbCs5eUt4a095bE1tVHN5NDl0THlWRmRJdjJXRDh1VkVjR0hy?=
 =?utf-8?B?akVDM3lOT3pwRkFEeU84Uk0yaDFqUXUvZWFJYkJ1allObmozRnc0Y0VXSnBs?=
 =?utf-8?B?NHl2cnAwZFJ4cTNTbk9YdHd2UDFxeVNwekIrdUxvUytNQ0V6UCtrYVdNdlRB?=
 =?utf-8?B?SlcyWG4vNFd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDlSUVY5OElvVnhlT1BKeWx4c2VKUTNWcmVXaWVXNjFIL3hWSlQ4dGVNdjhS?=
 =?utf-8?B?NFIxSEd3L016N1JWRUxORmhUdmZTRTNvcXV0Z05Ed0ZJV0IrcEtyZi9jNWhB?=
 =?utf-8?B?ZVpmTVU2ZUNFRlpFUm1KTVoxZDZoRkx3TWMzajVRVnpyR2xUSjc2SzVJL1Fv?=
 =?utf-8?B?WGk0TnNGdHp0c2Q1TkdnYytlYmx0bUplZlhsbmttemtMTVZPT1NVaTQzL255?=
 =?utf-8?B?azRwc01TL1dvUXJSV0JaOFVZVDdVTnBaYkJMUjV5ZW9tMC91dXEyNGR2TStV?=
 =?utf-8?B?S3lQY1NUWFQ4UFdycExFUktrTllhV0w4OFdWUG1pK1lqaGFXVklPNEpjZTVI?=
 =?utf-8?B?RzZSRlpXUHFpQS9pbGhYejhEUDh4MC9QU25NMWNLdS9LRDE2czh2dzZNbDVr?=
 =?utf-8?B?dmtPZVNIVi9lZE40bU5yNTRPOXBoRFNIUlRHNE5YNXdnQy9QRjNOSDNQOUxS?=
 =?utf-8?B?elpyaTVsVytFL3k2Y0c3RjNoMHpobDF6cUU0bFJtN2VCVjhBYm85dWZKaUkr?=
 =?utf-8?B?RU84NURpZHhJVVBvcUsxTzZpNmQwNER1Vy95Njlqayt5NkdiMCtUQmZYNStv?=
 =?utf-8?B?MWtFc3VWZHIwNFFsYmprTnAxSGFzWjhtaE1xUkQ5YUkwaXFpd0MvZVNQZjh6?=
 =?utf-8?B?MkFBdWtnZFMvYkppYk8zZ1dEYXh0TzZSeDE0cEltM0IxVzdTQnNxL3owdzlS?=
 =?utf-8?B?TjBtc2kzcDJSMDlJeFVpUEJxaWV3L29weXNTT0lwZlMzeUppc2lEbVZ5M3JI?=
 =?utf-8?B?a3NMUy8zVzZUNVlKbUVYQ2V2bHB3dGhHeVBaV2szbWlKcHcyczk4VTcxYjdL?=
 =?utf-8?B?dzhDOXlHWlVtN0JBbjRCbkdrcXZsNEZxRERNRXQrckcvTlN5ZmtkVVlTZEwv?=
 =?utf-8?B?ZlEzb2hKMFQ0endXaWoxWEpzUXZzcjd5RU93dk1OemdKWGJ3S2ZqdnNnbXUr?=
 =?utf-8?B?blFqdzNCZzRHTzFOUDY1cGtjNGR1c2czeHM3YXh4cFVxWVBoaFhPcXErOUNr?=
 =?utf-8?B?eEphaHduRXR3cnRoRFZERWJ6TW85MGc2MEVrbmVYOG8xTm1PZEkyejZyN3Rs?=
 =?utf-8?B?WXR5eVBzdW9kWHAxRUl6MzZNZTNjdHowd3ZnMGpFQWNNaDNLTWMwcTY1dy80?=
 =?utf-8?B?OTM5UiticG9PMUtvSEVvdjJMWE83dlJ6RSsxdHBIdG5WU2lnUWlJMS9zdGxq?=
 =?utf-8?B?OTYzWFlRVXltZ1ZReTJyNkJtelBZSDNsL053d0RoY25aL20rWGpTNkpyQktZ?=
 =?utf-8?B?M09JMXQwekdZbk5uVkFEWDFJVXFKblZqQlBpa0s2ZmFmZXZURHo4SWRUaHJZ?=
 =?utf-8?B?aCtwTHc5a3FKTFIxNlN0aGFVZFYxSUVGQzc1YWRGNzZDcjlnMkFjb1B5L3pr?=
 =?utf-8?B?UDk0dmxDUlhadVJKVzhGc0RhTXdKU2VDajlyUUo3ZnU0NHlEQi9ndE9GU0kz?=
 =?utf-8?B?S3poT21xU0ZLTGlWRFRickU3ZUV6VjJZVzJvZ1hScFZkWHFGcFpkNUV3Sm00?=
 =?utf-8?B?QmZ5dDRvZEZUQWhpTzZudDVkcytvK3Y5RldHZXZHME9mWmVwS0ltbnZsTXJo?=
 =?utf-8?B?RXlCTGx5cEYvODE5TmZROGdkUkY3eTZqb0ZOZHFNQnFyMlVvblBSZjhiSUJB?=
 =?utf-8?B?eC82MFRiWGllZHZMOUpMa3h2d3IwaW5YbFE3Y3lKZ0hodGUwK09oeVoxL3JJ?=
 =?utf-8?B?NTAyam04SGpXdXpiWXp1N1phMlZDTXhkQjBCeSszVWgvNldZcW1rMGlSWUFk?=
 =?utf-8?B?T3hXMEttNWo3OTR1YTVYalliT1IwU3kzeXpKSnp1UHN3dzdoaFlKV2lxQ01B?=
 =?utf-8?B?dG1iZW5TMldxQ1NlNTVWc1JKYzI1YTNUcTBHa09jd1dMaDVCWkN1bFRSWXBt?=
 =?utf-8?B?K2NnOXk5elo4dDVNZjhWUlEyWklhUUdmRHlVMVREcFJkakJCd0hjNGx2cldF?=
 =?utf-8?B?cmdOUCttdndPTjJSRE1aSkJxKytNYVpzcUw1WFY1d1VMeDIyc0VHMzBpZVlz?=
 =?utf-8?B?RGdsVzAxQWN1V09ML0lENXYwcU0yalZSMVEvZUtNTStScXRtOTFObTRja282?=
 =?utf-8?B?bEVPbmhiaU1kamZYZ2k5N1MxMGhjTGFVWTlEMHAyaWtIU1JMMXI4NC9JbkhL?=
 =?utf-8?B?MHBzWGxGdWhPRTd1UFZ6eHduZXQ1K3lDbnpPblZ2U3hjL2lzL3FRQU1YTGJN?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239a4e2f-4258-47a9-7d9f-08ddbe1f4798
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 12:59:31.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUKB6JcASqpbf+eM2OwMUvXa9TmYOm0vNQ4QypJpbVrMFjXOU3Pt2cLhF9lzSt2WHkMZvP6ormXH1jLMyWs0tyjaLJdMe7ZL3ZIXuBKQJqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7505
X-OriginatorOrg: intel.com

DQpIaSBWaW5heSwNClRoYW5rcyBmb3IgcmV2aWV3aW5nLCBqdXN0IGEgZ2VuZXJhbCBub3RlLCBj
YW4geW91IG1ha2Ugc3VyZSB5b3UgcmVwbHkgaW5saW5lIGluIHBsYWludGV4dCwgc28gaXQgbWFr
ZXMgaXQgZWFzaWVyIHRvIHJlcGx5IPCfmIoNCg0KPiA+ICsgKiBAbG93X2JhbmRfY2ZnOiBjb25m
aWd1cmF0aW9uIGZvciB0aGUgbG93IGJhbmQuDQo+ID4gKyAqIEBoaWdoX2JhbmRfY2ZnOiBjb25m
aWd1cmF0aW9uIGZvciB0aGUgaGlnaCBiYW5kLg0KPiA+ICsgKiBAZW5hYmxlX3NjYW46IEZsYWcg
dG8gZW5hYmxlIG9yIGRpc2FibGUgc2Nhbm5pbmcgb24gNSBHSHogYmFuZC4NCg0KPiBzL2VuYWJs
ZV9zY2FuL2VuYWJsZV9oYl9zY2FuIA0KDQpXaWxsIGZpeC4gVGhhbmtzLg0KDQo+ID4gKyAqIEBl
eHRyYV9uYW5fYXR0cnM6IHBvaW50ZXIgdG8gYWRkaXRpb25hbCBOQU4gYXR0cmlidXRlcy4gPg0K
PiA+ICsgKiBAZXh0cmFfbmFuX2F0dHJzX2xlbjogbGVuZ3RoIG9mIHRoZSBhZGRpdGlvbmFsIE5B
TiBhdHRyaWJ1dGVzLg0KPiA+ICsgKiBAdmVuZG9yX2VsZW1zOiBwb2ludGVyIHRvIHZlbmRvci1z
cGVjaWZpYyBlbGVtZW50cy4NCj4gPiArICogQHZlbmRvcl9lbGVtc19sZW46IGxlbmd0aCBvZiB0
aGUgdmVuZG9yLXNwZWNpZmljIGVsZW1lbnRzLg0KDQo+IENhbiB5b3UgcGxlYXNlIHJldmlldyBp
ZiB0aGUgZm9sbG93aW5nIGFkZGl0aW9uYWwgcGFyYW1ldGVycyB3b3VsZCBiZSByZXF1aXJlZCBm
b3IgdGhlIGRyaXZlcnMgdG8gc3RhcnQgbmFuIG9yIGNoYW5nZSB0aGUgY29uZmlnLiANCj4gKiBA
bWF4X3B1Ymxpc2hfc2lkc19pbl9iZWFjb246IFRoaXMgaW5kaWNhdGVzIG1heGltdW0gbnVtYmVy
IG9mIHNlcnZpY2UgSURzIHRoYXQgY2FuIGJlIGFjY29tbW9kYXRlZCBpbiB0aGUgU2VydmljZSBJ
RCBMaXN0IGF0dHJpYnV0ZSBpbiBhIE5BTiBiZWFjb24uIA0KPiAqIEBtYXhfc3Vic2NyaWJlX3Np
ZHNfaW5fYmVhY29uOiBUaGlzIGluZGljYXRlcyBtYXhpbXVtIG51bWJlciBvZiBzZXJ2aWNlIElE
cyB0aGF0IGNhbiBiZSBhY2NvbW1vZGF0ZWQgaW4gdGhlIFN1YnNjcmliZSBTZXJ2aWNlIElEIExp
c3QgYXR0cmlidXRlIGluIGEgTkFOIGJlYWNvbi4gDQoNClRoZXNlIGxvb2sgbGlrZSBjYXBhYmls
aXRpZXMgb2YgdGhlIGRldmljZSBhbmQgbm90IGFzIGNvbmZpZ3VyYXRpb24gbm8/DQpJIHRoaW5r
IGl0IG1ha2VzIG1vcmUgc2Vuc2UgdGhhdCB0aGUgZGV2aWNlIHdpbGwgcmVwb3J0IGl0LiAoU2Vl
IG15IG5leHQgY2FwYWJpbGl0eSBwYXRjaCkuDQpIb3dldmVyLCBzcGVjaWZpY2FsbHkgZm9yIHRo
ZXNlIHBhcmFtZXRlcnMsIGFzIEkgc2VlIGl0LCB0aGUgdXNlciBzcGFjZSB3aWxsIGNvbmZpZ3Vy
ZSBzZXJ2aWNlIGlkcyBsaXN0IHVzaW5nIGV4dHJhX25hbl9hdHRycy4NClNvIGlmIG5lZWRlZCwg
SSB3b3VsZCBpbnN0ZWFkIHJlcG9ydCBtb3JlIGdlbmVyaWMgbWF4X2V4dHJhbl9uYW5fYXR0cnNf
c2l6ZSBjYXBhYmlsaXR5LiAoU2FtZSBmb3IgdmVuZG9yIGVsZW1lbnRzKS4NCg0KPiAqIEBob3Bf
bGltaXQ6IE1heGltdW0gbnVtYmVyIG9mIGhvcHMgdGhhdCBpcyBhbGxvd2VkIHRvIGpvaW4gYSBj
bHVzdGVyLiBWYWx1ZSAwIGluZGljYXRlcyBubyBzdWNoIHJlc3RyaWN0aW9uLiANCg0KQWN0dWFs
bHkgd2UgY29uc2lkZXJlZCBpdCBhbmQgZXZlbiBoYWQgc29tZSBsb25nIGRpc2N1c3Npb25zIHdp
dGggTWFoZXNoIChjYydlZCkgd2h5IGlzIHRoaXMgbmVlZGVkLg0KSW4gbXkgdW5kZXJzdGFuZGlu
ZyBsaW1pdGluZyBob3AgbWF5IHJlc3VsdCBpbiBjbHVzdGVyIHN5bmNocm9uaXphdGlvbiBiZWlu
ZyBicm9rZW4sIG9yIHNvbWUgdW5kZWZpbmVkIGJlaGF2aW9yLg0KQ2FuIHlvdSBleHBsYWluIHdo
YXQgaXMgdGhlIHNjZW5hcmlvIHRoYXQgeW91IGFyZSB0cnlpbmcgdG8gc29sdmUgYnkgbGltaXRp
bmcgdGhlIGhvcCBjb3VudD8NCg0KPiAqIEByc3NpX3dpbmRvd19zaXplOiBNb3ZpbmcgYXZlcmFn
ZSBvZiBSU1NJIHRvIGRlY2lkZSBOQU4gcm9sZSBzd2l0Y2guIA0KDQpUaGlzIHNob3VsZCBiZSBp
bXBsZW1lbnRhdGlvbiBzcGVjaWZpYy4gSW1wbGVtZW50aW5nIG1vdmluZyBhdmVyYWdlIGZvciBh
bGwgdGhlIGJlYWNvbnMgYXJvdW5kIGlzIG5vdCB0cml2aWFsLg0KVGhlIGRldmljZSBtYXkgYWxz
byBpbXBsZW1lbnQgaW5zdGVhZCBzb21lIG90aGVyIGFsZ29yaXRobXMgZm9yIGF2ZXJhZ2luZyBs
aWtlIChFV0EpIGV0Yy4uDQpEbyB5b3UgaGF2ZSBhbnkgc3BlY2lmaWMgc2NlbmFyaW8gd2hlcmUg
dXNlciBzcGFjZSBuZWVkcyB0byBjb25maWd1cmUgaXQ/DQoNCj4gKiBAbnNzOiBObyBvZiBUWCBh
bmQgUlggY2hhaW5zIHRvIGJlIHVzZWQuIFRoaXMgY2FuIGJlIHJlY29uZmlndXJlZCB1c2luZyBj
aGFuZ2UgY29uZmlncyBmb3IgYW55IGNoYW5nZSBpbiBwb3dlciBzZXR0aW5nLg0KDQpOb3Qgc3Vy
ZSB3aGF0IGl0IG1lYW5zLiBJcyBpdCBmb3IgcmFuZ2luZyBvbmx5IG1heWJlPw0KSSBkaWRuJ3Qg
Y292ZXIgYW55IHJhbmdpbmcgcmVsYXRlZCBwYXJhbWV0ZXJzIGluIHRoaXMgcGF0Y2ggc2VyaWVz
LiBJZiBuZWVkZWQsIG1heWJlIGl0IHNob3VsZCBiZSBhZGRlZCBzZXBhcmF0ZWx5Lg0KSWYgaXQn
cyBmb3IgZ2VuZXJhbCBOQU4gc3luY2hyb25pemF0aW9uLCBJJ20gbm90IHN1cmUgd2hhdCBpdCBt
ZWFucyBhcyBOQU4gZGV2aWNlIHVzZXMgb25seSA2bWJpdCByYXRlIC0gSSB0aGluayBpdCB3aWxs
IGFsd2F5cyB1c2UgYSBzaW5nbGUgYW50ZW5uYS4NCg0KPiAqIEBlbmFibGVfZHdfZWFybHlfdGVy
bWluYXRpb246IEZsYWcgdG8gZW5hYmxlL2Rpc2FibGUgZWFybHkgRFcgdGVybWluYXRpb24uIFRo
ZSBkZXZpY2UgY2FuIGRlY2lkZSB0byBtb3ZlIG91dCBvZiB0aGUgRFcgYmVmb3JlIHRoZSBkd2Vs
bCB0aW1lIGlmIHRoaXMgaXMgZW5hYmxlZC4gDQoNClRoaXMgb25lIG1ha2VzIHNlbnNlLCBidXQg
d2Ugd2lsbCBhbHNvIG5lZWQgYSBjb3JyZXNwb25kaW5nIGNhcGFiaWxpdHkgc2luY2UgaXQncyBh
biBvcHRpb25hbCBmZWF0dXJlLg0KDQo+ICAvKioNCj4gQEAgLTM3NzksMTAgKzM4MjgsMzIgQEAg
c3RydWN0IGNmZzgwMjExX25hbl9jb25mIHsNCj4gICAqDQo+ICAgKiBAQ0ZHODAyMTFfTkFOX0NP
TkZfQ0hBTkdFRF9QUkVGOiBtYXN0ZXIgcHJlZmVyZW5jZQ0KPiAgICogQENGRzgwMjExX05BTl9D
T05GX0NIQU5HRURfQkFORFM6IG9wZXJhdGluZyBiYW5kcw0KPiArICogQENGRzgwMjExX05BTl9D
T05GX0NIQU5HRURfQ0xVU1RFUl9JRDogY2x1c3RlciBJRA0KPiArICogQENGRzgwMjExX05BTl9D
T05GX0NIQU5HRURfU0NBTl9QRVJJT0Q6IHNjYW4gcGVyaW9kDQo+ICsgKiBAQ0ZHODAyMTFfTkFO
X0NPTkZfQ0hBTkdFRF9TQ0FOX0RXRUxMX1RJTUU6IHNjYW4gZHdlbGwgdGltZQ0KPiANCj4NCg0K
QW5kcmVpDQo=

