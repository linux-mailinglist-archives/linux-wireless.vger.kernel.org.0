Return-Path: <linux-wireless+bounces-37212-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI/zISBEHGrQLwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37212-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 16:22:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E71616A94
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71305300F10C
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D63346B4;
	Sun, 31 May 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7I0MLGH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135C331202
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780237340; cv=fail; b=s721V1N+fTYfD1KXFlsKN2mKRkmlcIEox5l9fVCi6w+u87W4leYd3pSWSz8k1XMbwhmqJ0xBMarT1Cy8z7/yO2UFfJiXWEpx4jMdB8w3s1vqqxV3NcdpRVOpZI+ab/xxheAz8Nv0JPgpT8Q801TxKXy3Loou0/s7zhIihT/6NvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780237340; c=relaxed/simple;
	bh=JTntXAeYp+aSslAnhDyZexAbhj0fJHVYqGEAWAxFeao=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i/TOKqoeCQOhiLCtrGUkoZPdZsStAZB3oggQY+fLuQmwaCxnUjT1jTG4wy4JPV2d2n/XgL7ADV2iH1EYyvZORS0Kz/2zyHbY0BL+iYR37cuRnHaXOMBffXSXGpqzqZEuX4vwOGjHBYiIHoiz2NqxjzYAqzKUSccMZjlSdCZWVT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7I0MLGH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780237339; x=1811773339;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JTntXAeYp+aSslAnhDyZexAbhj0fJHVYqGEAWAxFeao=;
  b=l7I0MLGHshrSFcixT7UgDOvVc7Veo+pS5gt8an+7D04didqHqqntDPMp
   FwomAYRAxp6zbq2ilRjlEYVWsBWQe7fUd0Vi9MJVvI928d+WdGzwDz9HH
   rM1wbNMvqQH+Lgkx9Ph8YRHxTOo3pQUT9Kxc0ufjpsaD0jObZgMIofYRu
   YWvveVSDwClJUKpGU1T07VLN19Iq2TRQqebK+TPViY4836I/pAhJLxxFz
   Sr6+o1z9bWMPZzGpnDvCZt8XR4AdyB6nOSp3hDEmgCWDYeO3PXqCJbyc3
   MDwDgktQcbqoeUVBRP9FZwQ3g+mMKBNJUsZ3fXAmQZNaCvyA6B6rQZtVQ
   Q==;
X-CSE-ConnectionGUID: rkCvqCLmTy2NHqAX3ZX5XQ==
X-CSE-MsgGUID: +VOW2oCPTFq79beDuJqkyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81125007"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="81125007"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 07:22:19 -0700
X-CSE-ConnectionGUID: 10bLYL+MTDeYPnbPgMOi9w==
X-CSE-MsgGUID: Lmj0bEFiRT2ECGZUhDBbkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="242269251"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 07:22:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 07:22:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 07:22:18 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 07:22:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLZ2RyXr2iGyUWuYNQINaUrMv1dEN0nG6P92qghRstk6P9MaHZwrNWOA4IS3VFhUmF3C2BEEjcAW85yU1LeKWNjKNMLSn18+aLnNJmQuR5N6gwM4ivTVYjUJNMVhrP1MfrcuZY/X+212P34u1u8aAyUlF3/YAdTQaK3ULaPAPq7iDGXXxsiVEgd/uno2EipKTtIs3BYfpYnS+SfRdj/SC87JwcrICMHRkwAh8Vk3N8HUktxasVdO2SwajDluoly1ueZOk5WNe7n7iWpnbDlMoEyzb4LQnQkM8mntOlHWp7VELqHhyqP7UGMhP8Ji4yqF2nHD0UdOXXlDnwbY/v+IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTntXAeYp+aSslAnhDyZexAbhj0fJHVYqGEAWAxFeao=;
 b=eXL/z2OYiPRvAyT718sCcSJU2F4IrnI6SRbgISxbBbFkInodO3+dKmz5qhcH05nJVR4YNis13KhmpOlnlxsZFFYqFR6EpD5FpZzZrXGOMSAvtlCnPHHV5hyu5oEEOqWNr08MxI8PRUQ4aMt4bQKENuWEFHtBsLq1IbX3M6rIMOw7c8i8zd3eD8xzPEEpSml5WkdYtjj/qZG2gWrLehAT+tnI+43K1/ID1DroDJFp07E6gXe48ONFP4XDidjSIYmrY/PdKhXun6pGxJDoSvv6Ed3XfZGN1rqHiOQTnF++E04vX38l58TBbNCBEN0GyUrjfICGXLVMufc1G+iY5EJ+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 14:22:10 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 14:22:10 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes - 2026-05-31
Thread-Topic: pull-request: iwlwifi-fixes - 2026-05-31
Thread-Index: AdzxCMZv6eq2HOVhSyaoSs3uoTactQ==
Date: Sun, 31 May 2026 14:22:10 +0000
Message-ID: <DS0PR11MB7880599A289BFAA037378B00A3142@DS0PR11MB7880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|SA2PR11MB4796:EE_
x-ms-office365-filtering-correlation-id: 67947843-e06a-4938-d882-08debf2000d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info: 5IaIZlKWPYSWUq13WdjoBnYLkIUfEa5SembkeKIZUCP2pjbUc41MbSYw78mRH+kQdVAuTv4P5rgzygA0k1UzmSODq8W7K6asliMxHkl2iftIaRXBzj7Y/xPVdLyD0QSPzLyioyUzGaM66PalfDCEbXdgkK3uJ6KQPnWj6g2KvlSGuN1ykgptZxossyIz/5sJMmFH15vjcf5/g9VRH+A6ZPJN7KrODsudcEihae/bc6AMxLeC/eSIffykgiG7zKgvQNOe314BCfByjLXt26+fMGVZhciXWomx6mYtMMiTySkrz/vU4TDf9RDbUFwiONoMosTNppf3+ke6l6ytYx0H3vAwCGTSmgycvg5AY7OFhoSqWvtiun/ALcCQTMRYJIca1VyQ3el8qzKEnpqmBXwK5SkMfU/GZfEA+XyGeKjVqT82lInLxv/Xg4WhcNcza/t7NRKmtMZn8u9Z/dWYCA7LO5+PutWW7j4eSVWtQJrmjovFPJQDOt48feGLdrGmxpxzrUx7JLklFAurM32R8Cp+lBsu1abJtti3G2hObAp/WX6iqcrCChiVbxhf1KspInAIDNv4zJY+/IKyN+8cALcX0zibuA1QvtWEPfw8c1StyQkoLKM+e6ADOv1psuNzub2OEMSQ/l7pkEaUAb9P6a2ihZ2o7Niwam1KylDt9GdTYQElh1Amfg71E7dLmwhJWDo2mWDqUPkz9f0C7oDaO/7ULuxzWlQRe/oS7ZceEBVxj6JnYLvT4Hsurb121X2FWAEM0uh00p1f7BRknYvaJLisGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmovdlBtZnRSSHRaUURZMzF1WTZzVXNITVJwU004M2twcFNlL3l0RFVFVitT?=
 =?utf-8?B?VUE2dTBheS8yMnNZSDFmMjBybVVwcFJzRU9KUmJWY0lVMGxaTzhmMzBwQjBK?=
 =?utf-8?B?WlJLSkpDVCtxd2FQY21TcTlKSHNscy9sY1BnVDJuYjZYZGRIL25xaHBoN2ly?=
 =?utf-8?B?cWUyNU1PS0VaQmxUNjhlWGRaRWx1QUtuK1NZcFIycCtHcjBUQUhDdWxGdzZ1?=
 =?utf-8?B?d2FOdldFSXMxT2xieEw3V1J3aElsMjBySzlacE1URXJUbGhlakJTRXIrMW15?=
 =?utf-8?B?WjdtZFMvbm9YZ2t0NWRHYzl6c1hBQTcxSGYwRjJOL0dQSmNUNVNMeTBzcFJE?=
 =?utf-8?B?UTBpSU9oc3d2cklmLzh5M2ppc2dCL1JSamlhY21yMGgzdmlkamI1cW9BaVBU?=
 =?utf-8?B?U0dreVVMZjRlQlZOQXN3Q3hRUnNudUFGN3BWNXl1SGUxVS9DdytGS3IvY0RP?=
 =?utf-8?B?bUdGaUo5MlZoOFZTUUp0aU9mUEJneVZQTTV6MGRCRlRGdzNtS2g0Q0tDbkFy?=
 =?utf-8?B?L21jUDdacFJSRDk4ZUhEenZBbExUMTVKY1NmQi82QXVZUlFlN215WTd6ZDZx?=
 =?utf-8?B?bkVlY3U2VkxDVGJoNnhsNzF0OHBnd3g5TUd6d2JFdGpweVlmU0dVY0FadFBO?=
 =?utf-8?B?Z1lKNURQbFU0QXQ2UmFtMUI2QlpWUWlSRjZPSUdNdUtlT0VyRytaVUJHaHA5?=
 =?utf-8?B?VTJMb3J6b08vRUt2WlY5aVN4R3JDU1JqOExNd1plYllxZUdKbUNlRy9mbVR4?=
 =?utf-8?B?Zkx4eWt3NDlaZ25zUDhkZk9TZjU1Mzd3eS9xaWpVWVhLa2Fib3ZRcGRjZDAw?=
 =?utf-8?B?VnA4QWEyQTJKVkhRNmo5WEdGYXlzT09zbkdsRG1zZWdvZC9DOElsNFFUd0hl?=
 =?utf-8?B?ZGhWekFmQ253aW1KdHRCK0lRRVdPZ0FidFNMVWlobHdnZkJVLzhtTzFhYng0?=
 =?utf-8?B?dFd6Ujl3eHNNSFZQRnBQZW1wVmVKTTF0RW9OUFhXbE8ra1dCd2tjdWRkSVpk?=
 =?utf-8?B?Rko2WU8xK0FZdU5yK2lpQnRLdUt5NG0rNDdJY1hhOUFmTFprT3ZvTkRsUnRK?=
 =?utf-8?B?MXd5aXZpTHlURnJNV3hzYWhhNVlrNFVsRmR6YmpYV0RDVWFjdXQza3VRRzBF?=
 =?utf-8?B?NytYakdLN0hVVURDOGdVYndBZnMvTHJ2aVMxbTVuM3V6VnF2MkNnZDZ5eFdK?=
 =?utf-8?B?b3NaWHBTaFh6WjJ6blJWNWU4NVU1OTNOcEpMNFlRMWorRVl3OFArQzdtQWIv?=
 =?utf-8?B?elFwYjFBK0ZaRFNkdVFNWUpwcG9PTi9WSEU5T2Q2WDVLRTlna2tadlMxQWZw?=
 =?utf-8?B?VjdmT3lwdEh2YXh6SkpnOG9YYk1uVkx5RHM0aXZ6TzRBZWZzWFRTOVI4a25R?=
 =?utf-8?B?QnFrMDkvL0h5MFM1ZmlVTUtiUzNKYWlKQ20zR1BqZi9LY2JKR0hIczRWSER3?=
 =?utf-8?B?R3dLWU9IOWxKeDljUXNUN3E1WlM2Y2lOZEgyRnA1Yk9XQTI1NGxqRUhkWDhq?=
 =?utf-8?B?cTlQT2k2UE13elNXU285SHJqa3V0OG52dUUrNUdCekpka05CbGVGWTNpeDVE?=
 =?utf-8?B?QlAxaTJVTkpSMDUxZlYvdFZ6STVPMVVVOWg1bmpqK25PL29JZ00vdGppcDNU?=
 =?utf-8?B?NlZTV1l3TFlaajdNZHVDNGVBeERxUS93Q002ajJ4ZXY1VTlsVnAxekNwbzA1?=
 =?utf-8?B?amtKNVk2cG1QaHZ1cTdHR1BXM28ybVFKTXg5am1ERGc5cDE5Q0ZFR1JvNlVL?=
 =?utf-8?B?a1FxK2JYa044Nk13RGQrRlRxTFJHdVRRTHdHOTRLalpFYnh3UkNTQi9Mc0hp?=
 =?utf-8?B?cXVoTHREbDcrUDFPVGNyd3NzZzNTZitGSVJkS0ZLUXE4UkJzVEd4SFNSZjA3?=
 =?utf-8?B?OUNBcmdqQkdoVXNFbXlMMkpUd1h2OGJwS05EMTkyd09HMTNlckk4TW84eUpl?=
 =?utf-8?B?TU9hWjVNdERMcWZrVFgvYk1uSStNaExYN3RtWGZZdUlkWkJjYnpMRU82NU9W?=
 =?utf-8?B?eGRadFZkaGQrM05CTlRTYUM2M1U3UFhOMy80Nk9wK29udEpocVJFWVlSR0R0?=
 =?utf-8?B?V0QyWEdTaGF1NUxZVjB6UDhEWElwUmlpZ1c3ZVo1SFo0MUlHMWdPL01SSDZN?=
 =?utf-8?B?dlVMZU51WEtCNU9zL1p6Y054RThDN21lYmlhaU00WjMvTmxpSUtRQXBFTi92?=
 =?utf-8?B?K1lkMTdRK0JoSXptVU14VVNYK3haRHlSSVhyY2FIOEFVQzZXblZTemxEdkpq?=
 =?utf-8?B?VUxpY0dURGhSbmdNRlBmTDFaYzlrTlpxdFBtaGlUd0tibE1MZjVVaGgvK2ZX?=
 =?utf-8?B?dXJYWEVkRy9idDBxZHRqU0VJT1pONnI2OEtHL2dLcGJIcWZPTmxaVi9nZVBy?=
 =?utf-8?Q?pckRit1Ug4PAZx+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jzm8ZVWGmUnIMFtyhJ/AP4m51B5sfXAQZFWg7rXqNAM+w5DuDSPs7LCi3d9wXoPOaG0vpcxFSJTRxJIq3XckAThPdctvmDGSWCP57+LupnZyxcOv7H+a0aNObUJ6hAj8O0CTKAd6zwn2TIL09RMwtIFcbjrbbTt0UGAZTp6erWdYZ8BrgYZxhN45EbdTSeF9A5SL+CMBfN4kQe7hpWUkHWLPesOUOWjCg59mb/HhuGHVJYrYib/rELgruMUP+GnS8fmw5A6SjnouWzwMh1nYyL68CjCCjmGwPj65n4mYg6PIOuusqsWUOk8aDfFzn4E2d65N7mysI4ZRtB9O9dhfNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67947843-e06a-4938-d882-08debf2000d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 14:22:10.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boi9XOJRrFRAG6X+eWj+Tv0WbpvB3YttkdtNW7ZZBDX+fWaYwA6VgMBeCbwV29Rdj66NXYWz/vXi5VFiUCBTGxou22banVw4j1eZU/TewfbeKNoaRY/u/EGMVvtjqH/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-37212-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.869];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 61E71616A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2ODk5M2NlZDBmNjE4ZTM2Y2YzMzM4
OGYxZTUwMjIzZTVlNmU3OGNjOg0KDQogIE1lcmdlIHRhZyAnbmV0LTcuMS1yYzUnIG9mIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0ICgyMDI2
LTA1LTIxIDE0OjM5OjEyIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9pd2x3aWZpL2l3bHdpZmktbmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1maXhlcy0yMDI2LTA1
LTMxDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAwOTMzMDVkODAxZmFlNmZmOWI4
YmI1MzFmZDc4YjU3OTc5NGM0ZjgwOg0KDQogIHdpZmk6IGl3bHdpZmk6IHBjaWU6IHNpbXBsaWZ5
IHRoZSByZXN1bWUgZmxvdyBpZiBmYXN0IHJlc3VtZSBpcyBub3QgdXNlZCAoMjAyNi0wNS0zMSAx
NzowNzoxMSArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0Kd2lmaTogaXdsd2lmaTogZml4ZXMgLSAyMDI2LTA1
LTMxDQoNClRoaXMgY29udGFpbnMgYSBmZXcgZml4ZXM6DQotIERvbid0IGdyYWIgbmljIGFjY2Vz
cyBpbiBub24tZmFzdC1yZXN1bWUNCi0gRG9uJ3Qgc2VuZCBhIGxhcmdlIGhjbWQgdGhhbiB0cmFu
c3BvcnQgc3VwcG9ydHMNCi0gSW4gQVAgbW9kZSwgZG9uJ3Qgc2VuZCB0eCBwb3dlciBjb25zdHJh
aW50cyBjb21tYW5kIGJlZm9yZSBhY3RpdmF0aW5nDQogIHRoZSBsaW5rDQotIERvbid0IGRvIHN3
IHJlc2V0IGhhbmRzaGFrZSBvbiBvbGRlciBmaXJtd2FyZXMuDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkVtbWFudWVs
IEdydW1iYWNoICgzKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogZG9uJ3Qgc3VwcG9ydCB0
aGUgcmVzZXQgaGFuZHNoYWtlIGZvciBvbGQgZmlybXdhcmVzDQogICAgICB3aWZpOiBpd2x3aWZp
OiBtdm06IGF2b2lkIG92ZXJzaXplZCBVQVRTIGNvbW1hbmQgY29weQ0KICAgICAgd2lmaTogaXds
d2lmaTogcGNpZTogc2ltcGxpZnkgdGhlIHJlc3VtZSBmbG93IGlmIGZhc3QgcmVzdW1lIGlzIG5v
dCB1c2VkDQoNClBhZ2FkYWxhIFllc3UgQW5qYW5leXVsdSAoMSk6DQogICAgICB3aWZpOiBpd2x3
aWZpOiBtbGQ6IHNlbmQgdHggcG93ZXIgY29uc3RyYWludHMgYmVmb3JlIGxpbmsgYWN0aXZhdGlv
bg0KDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvYXAuYyAgICAgICB8
ICA0IC0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEu
YyB8ICA3ICsrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3Bvd2Vy
LmMgICAgfCAgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3
LmMgICAgICAgfCAyNiArKysrKysrKystLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL29wcy5jICAgICAgfCAgNiArKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL3BjaWUvZHJ2LmMgICAgIHwgNTYgKysrKysrKysrKysrKy0tLS0tLS0tLS0NCiA2
IGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0K

