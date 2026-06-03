Return-Path: <linux-wireless+bounces-37321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJm/JZfNH2prqAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 08:45:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F940634C79
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 08:45:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=i1LVimqL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37321-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37321-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E20304EB92
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2C34751B;
	Wed,  3 Jun 2026 06:39:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD7274FE3;
	Wed,  3 Jun 2026 06:39:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468765; cv=fail; b=jNHtn/IjWj5udabtGqirDSeiC7OMhxBqHC6KhDKTmBUlLE6Gd+obZvLsyHM6M9Ej4fTEqvHUh9QrXkDA7Tv/yptk93OGm0DSEeh/Ig72/XVG8saYdXfFBaO4q3Red2FzbyJ8NJ/Hs0maPCoFnW/YllWNGywIA/RQ+3TnzZtD5Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468765; c=relaxed/simple;
	bh=6Vv/IZbid30hB+m6xdgq2mnhxGmLx6PCG82rZn24DLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=St4wTYOfIobWfqYJ3eRWTYRtwh3prFII7AH8Mr4mvqbKR/9K3TeiLlet7hyzWl4i5AZyiHHdNuPeBVSsljYX8HNEi6zDcSAT4TDSYF9Dh+4ikEUttmsaJow+7dEUmzRddpqWjMp3+8RITVJ2UvHJPoeYmf+S7cZveCfI5XHVfsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1LVimqL; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468764; x=1812004764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Vv/IZbid30hB+m6xdgq2mnhxGmLx6PCG82rZn24DLA=;
  b=i1LVimqLcLN0ugm40ZgvNR0MaKWJRgcwKu6dpv8RY2B/bVRQ/jF4OZ3T
   HQvzwWr+wiwnkGB27iSKmIU/XjUxb2eyjLewSz3Bz+RJRoucoFWDDCo5j
   IOiLHo1EyZobrPcpwlbcJF201BINbw1oV+Ps86y56w6h9c0C+do3AoCyc
   p/iXU7lY0ztyKFIA6Vo8pL4V4kQgMQ5U1ZVOCrqrw+J+BIW7yG3WKt5TY
   bAMkDg+7hmBKVUlg3u/WRlyvxlez5chxA7gFmYoP7US+7isWtLIELgPh/
   yUfgXjduZKOEXuMauoW/0VFqcm2u0zFNQKWNPc8QMym+vUttP9spVSt+Y
   g==;
X-CSE-ConnectionGUID: 1L6ueVXXSYWkj5XCmbZQbw==
X-CSE-MsgGUID: nhnKA64lRvqK3E1T9PUJVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81169032"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81169032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:39:23 -0700
X-CSE-ConnectionGUID: VIPvenbTQMSDk4u0d50Hdw==
X-CSE-MsgGUID: HxnW57gwTACleu9fl61O9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="282242248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:39:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:39:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:39:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXNW48kwPaZ3w8hRajhCa9ARk0voCzcPltnJU13ptfB5mLP+qtVy1amc74QLgqbYBgllZRXHzG78OEoY4q5ypiAtaPWVz6NnEh65VEOM/So/FNTgwB+1yBonM+1rchx+5HQk0+JGW9eEXaJZB7H/8nXTRf1L7g32P1enJOEHGpnDymN8YGgwvqJaVuprDeM/HFzVNWOKlDF2+Xqk9g1qEqzbylNVg5ZgBpD02z5YOQJknr0kNBlVuG8Tqb7F65cMAUYk4HHisPKijjNX5Uxzn6BytmvaEnwNyCeU5tWAmBRJea9wCPRCkVtz6f7oI4HIPB5i8TnhDFeg5fxbtrk1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vv/IZbid30hB+m6xdgq2mnhxGmLx6PCG82rZn24DLA=;
 b=TDZnOF9JvKJxJlYdJzrjaSjaChhlmXD5AD7jDDEBR8W42rHyY1BMJHibnEFf1/pjMMCpoJ15dTWOrWbHSEWoIvp86Ng6RR9k9t/PMV8Y4qjSN7rIJiZyYjpg9ePjH4tkLv3SPZkgudu9ld3wR5DDMW1AUxGxGaltNSgamNz9gS+KVvWIRDpBVPbbTStibGeUcqAnaxxLH0bllmLTjlpCZEe+ePPclSrZUeQn7KzvqiDZDuUGMH5W8YVOuGnmBlOsoUlnTqmzjitAJycBMuW48Ij+B5XCgH4TvjbAo1DwanE9pACMK+H2yvKFPsXJwbMuaI2zZTjc75tJcp0OaaQYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:39:19 +0000
Received: from BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12]) by BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:39:13 +0000
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
Subject: RE: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware
 integration information
Thread-Topic: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware
 integration information
Thread-Index: AQHc26vi/B+Vuw6kLESUO2/QFJubJrX/KUIAgAsNsJCAAhuaAIAgPRAg
Date: Wed, 3 Jun 2026 06:39:12 +0000
Message-ID: <BL1PR11MB5954C1EA6076FE1B0EEDD320E0132@BL1PR11MB5954.namprd11.prod.outlook.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260505-crouching-albatross-of-beauty-a5ac6b@quoll>
 <BL1PR11MB5954BCE96853D1F299E4DEACE0392@BL1PR11MB5954.namprd11.prod.outlook.com>
 <a51ba34d-92db-46a5-a87d-15cea72af833@kernel.org>
In-Reply-To: <a51ba34d-92db-46a5-a87d-15cea72af833@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5954:EE_|SJ2PR11MB7645:EE_
x-ms-office365-filtering-correlation-id: 16784341-7320-46b2-ef00-08dec13ad342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|3023799007|5023799004|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: YXlSAfhT8nuNHmlm0VEB13WVX2K+yXYtr55kd6au56LGRsVYID3oJrq2Akib7wGZSZpkMXzuDfJipxXTk84zrsurN18orF2461/9TOm2IuVz12WVblYSeO9YFUqF+XYbjNXP+QFGVtZvBmAE5BSsUdTclOnAMmfVOCMwwzDthWzQVEM8B4TW/tT7US+R5xJx+dzjmLI96sHj5U9UMxKT/zGeabsrLSIk29MAisgGTtA5zw2TImhuwJG2YkjH5Qdv7fWVDHXunSh0U4bH6TmEMLqlKCpohULTNkdDgcZYmqj2/RzHq9nGtywGIjOQJfQrVCt8TSyN001/BW4s2Yb+yk47nH/YqyfRGu5pLMJJGDobULi2yij2ZLh0aasbcTs6fuU3PhYiglFbwqAWoHrupOEz+Wo7eR4eqv76/zyosbUDh+0q/+0QdkRyZN5Ip+AyJwntxCdj9F1Kxt293S/s3nFDg8M8BP8x1sB79DpcCvo5iihSbOmLPv64r4CYCSjnXuDj/Xjf9jg8lkO019nUwL6VAR1/cG1j32+wFLbzrv7lgMjP1TdOoUhmdk1i+ER7R1qxh3ag3hadTgnI/eMpjjeC3kliJw3YyFp/QEtseM/bOowTODcH/mZx1NeEKnG4VhHeTA6sNSnuhbZFq5v38aG0goWBC+dMqBulCImpb+qxkrdcXuGTVV7oFlS/REQi2Nyl39XvzmSdLt6Z4zawOnH9OYdr3lO9d6bMrpCQVJZCWxvgsAUZqjLt82fOm05r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzFSRE44ZVBSTTUrZXkwNlBtcEpVVEtWV1l1b2dGMzFlcGEyZUVsanRrT2hi?=
 =?utf-8?B?QUJSbEg5SUNvajNLd3YrLzhDVTlXMmQ0ZXBEWFBjT2FubDF5eEE1bU5iYkt4?=
 =?utf-8?B?OHpLdFNaVmhIUkF5OGZvZ1p5Z2p5aDRCUWpJUEVOU2k2T0NoVE1pY0t1UHdN?=
 =?utf-8?B?L2JoTlNTbEUzT3J3Y1M2UUZscHp4M1pQQ09kSGRock9NR2xBdnhrSWIxL2xr?=
 =?utf-8?B?R0hONStSbk9WREJaOTBjVTFmeGQrVGtpbWpURXd5b3NLb05wM0E5MWJpUmVP?=
 =?utf-8?B?UmRlaVliUjBpeWYyWUMwZkdrcTBqYjhtSlg5aVA5MUthTGs1aUdBMWt3Um9l?=
 =?utf-8?B?Q0VHbU41RlVlNDR1VlVCQUpjRHFJcTlmSERGT3B1WGFqWWxJd2o2RnQ3cUdD?=
 =?utf-8?B?UytFSjJabEFxbTFpRHFHcjBSWFRtVklnSmc3ZVY2enNrUUxsME8wdG9lSTRG?=
 =?utf-8?B?RThZL0ZrR29sbU9yUzRUeVR5b01KUEkvSzJQUjVlSlVIS0RxbThwcGQ2dXZa?=
 =?utf-8?B?eU1tdDF4cXFxNHEwNHdKZlNvSGZHOE9HRGZKTWJ6dXBWMDFhdXBEenpjNXo3?=
 =?utf-8?B?bEFSNDZOSjlzWGp0TEZMa0RSQXNLczJ5SWlRd0pWNGkzQ2RQeHR4WElva0tQ?=
 =?utf-8?B?UU1BQk1xYlJwRjVnR3lQS2Z6dExhdDBIcE9KR3RpSU12K1FRMXZrWHdmVUVx?=
 =?utf-8?B?eFcyOS9xSEFLVzYyTnEzRUtyWGFUOGYxUEpRaFpFRnFWZ09kZTU2aytRWDQ0?=
 =?utf-8?B?RkExak9GMVlmQWZsSVFFa3dGNDJQRXVkdnhGL1RpRklDRTZ0bGRuUmxqRCtj?=
 =?utf-8?B?dXEyMUxCcHZUUU9ad0ppU1FUVjNxOUtpUlVQTVlnakN4MWphaW96S2xLUW9K?=
 =?utf-8?B?Y3FuRW43bTFkYm5HVGJLQ2lJZDlSQVNuMzNGQVplMktHK1p0Q2JSZnh2QUsr?=
 =?utf-8?B?bzQwdjcvL0ZKRHJIWndrOS9NM1BPYmdjNHlxYWR5N3kxUjRMVVd6TnEzOElM?=
 =?utf-8?B?M0pOaHVkN1hBaGovM05NT0hMTDNJaHNpUmpydHhlVCtYcW1XME02elhDbXhR?=
 =?utf-8?B?aU1NL1pKYlc4WkVjQWVIZTBLa0hVbzBpQ25kMXo4eEgwQWhXM3ZnMk5yMlJz?=
 =?utf-8?B?OFF4SHNSK3A4dXZSdUtkVjVzdlQwdkFRK1VCNEdVbmpJWjdDNm5xOTk5V3E1?=
 =?utf-8?B?UER0a3VPa0x5ckpKOE4xL1FKRjJSN3haM01LMVlKc3p3UGdlV1Iza3hRRFI1?=
 =?utf-8?B?TUVnUWh4QVYvUkMzdG1iZ3hSbEhsU1duVUxlOXBMT2M5SFBHUmw5OGlNd2tv?=
 =?utf-8?B?cHVPTHRNdHUxQSt5N0dtV1FpUlhacFhlcXIzdFhPZXZxbmhIZ2NYcDNjSWZ4?=
 =?utf-8?B?U0JzSWlJVjU3dXFRMFJFdVkxcmhDU1FTY2JDRnMxSmNOb0RrTUVSL25uelIw?=
 =?utf-8?B?RzU0U1k1aXI1WjcwVTJoYVV1d2xxY09sMFUwcTFDb0ZBVWtDakUxeFF0d0tM?=
 =?utf-8?B?ZlVIaUJtL0VuMDFqeXF2UXRFekhpcmNtMmt6amhxUUNqc1B1RE1Lb2VoZkxs?=
 =?utf-8?B?U0Q4SnAzb0R3R2l0T0VlSWhQdGZGdVByNi9BQStMdzZwVGd4c3dkOGhwWHQx?=
 =?utf-8?B?ZVRMNktRa2pIcWNRTHpGU1E1UjhwZWhFV3ZtUS9reTk5Nm11YU5sMTUwMmdT?=
 =?utf-8?B?QjZuRTVVc1ZsYmE0YzVNc0RWNE1udCtUbWtLbmRKQ1hwcVdYRVBqeEt1dU84?=
 =?utf-8?B?bk92OHg4NmM3bSttbmxhUStheHpOMnVEYjRpSXZXcWg2d2wwT0p0R0MzWTgx?=
 =?utf-8?B?eEp0cURrQTdxaDhML2YzSFFBM21hSG0rWjVWNnl4Unp2a1k2RS9Ib3k3c20x?=
 =?utf-8?B?N21zTGdKcnpnaUl2NjhmdS90UWt4SmRrMXF3cTdXZXYvcXVxdmRqODY3a3c0?=
 =?utf-8?B?WXZueWhPYmZ1cDRxY1pScjI1VC9JWm1pOUZuQ244YVUvUEhCbTlIZHNhWlZ1?=
 =?utf-8?B?eGNrQnkvRjJ6cDA2N1E1alVRcEd1QkJWSW9oUjc2YU5BbHpVNkpGbnR6UE9M?=
 =?utf-8?B?bUtkQUk5MEhBV0Q0TlRSbE0yWDZrYjFKODZHQTUrRlJGRDJRSFZBTGtlMVpU?=
 =?utf-8?B?VjdBOVZHaGJRYVpsdmpHYzdaNWM4QmtlWnNLZUNSYmRiM3ZrcmZUSHZIRXRi?=
 =?utf-8?B?aWh4ekxRN24zLzEyeFRHc2lJWk9oRXdBeTRhK2wxQndacU1UZG1hWDNzTUpE?=
 =?utf-8?B?RW9BNGJQbmxaREEzd1ZLY1hZUHRtY2VYZnNRQU1LQXhzYnRKaWI4a0QzVHRh?=
 =?utf-8?B?VXJlVUNMOHBCNUI2eTc2a3FBc2xjbkx6OXo2YnpBNUdwM2VCNVRFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aPLH60BN0tBnj1vlKWw6xKn9Ivj4aTfKtZXMR+VN6vdONyZtrX1UnS9nN4OjfIGElmuS4gns9hDr4sYPIT0UWDfAgGONACVGvbuUZe08xUEpt2DFL2XdUr5o/sFsol4ZMtvmZ1o4caqjfU9Y6JeecAZIFU+HVGAgTNbUtYohYMOvCu3EEXk4WnraZRhKjTiqT+VaOjl5xGg2FjLTYTgiP4EQGyp5CoaUyHriORVD+IJ+PKVPsQeuqdy4kdKB0+t1Uu+GpAgs1j0cVnRgq5tVdBI9PUQWcroRnjox2f/RWX/gLrXJCWQv5acFwbPymIZSKK2W2i1DnZ/r4oiXSQ8O9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5954.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16784341-7320-46b2-ef00-08dec13ad342
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:39:12.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUEXWwUWvq0qswhGvLXVR26F2fZIhlnRsZiMiltU8ew0/bMLY2kLPVOUnCr0jVS37xGkEmU3UY4dcY/pZ/xQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37321-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:miriam.rachel.korenblit@intel.com,m:linux-kernel@vger.kernel.org,m:kobi.guetta@intel.com,m:emmanuel.grumbach@intel.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BL1PR11MB5954.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sipsolutions.net:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F940634C79

PiBJZiB5b3UgYXJlIG5vdCB3aWxsaW5nIHRvIHBvc3QgRFRTLCB0aGVuIHlvdSBhcmUgbm90IGhl
bHBpbmcgdXMgdG8NCj4gdW5kZXJzdGFuZCB0aGUgY29tcGxldGVuZXNzIG9mIHRoaXMgYmluZGlu
ZyBhbmQgaGFyZHdhcmUgZGVzY3JpcHRpb24uDQo+IElPVywgdGhlIGJpZ2dlciBwaWN0dXJlIGlz
IG1pc3NpbmcsIHNvIElNTyBJIHdvdWxkIHJlbW92ZSBtb3N0IG9mIHRoZQ0KPiBwcm9wZXJ0aWVz
Lg0KDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiBnZXR0aW5nIGJhY2sgb24gdGhpcy4gVGhp
cyBpcyBub3QgYSBtYXR0ZXINCm9mIHdpbGxpbmduZXNzIOKAlCB3ZSBoYXZlIGEgZGVwZW5kZW5j
eSBvbiBvdXIgT0VNIHBhcnRuZXJzIHRvIHByb3ZpZGUgYW4NCnVwc3RyZWFtIERUUyB1c2VyLCBh
cyB0aGlzIGJpbmRpbmcgaXMgaW50ZW5kZWQgZm9yIHVzZSBvbiB0aGVpcg0KcGxhdGZvcm1zLg0K
DQpXZSByZWFjaGVkIG91dCB0byB0aGVtLCBhbmQgdGhleSBoYXZlIGNvbmZpcm1lZCB0aGF0IHRo
ZXkgYXJlIHVuYWJsZSB0bw0KdXBzdHJlYW0gdGhlaXIgRFRTIGF0IHRoaXMgdGltZS4gR2l2ZW4g
dGhpcyBjb25zdHJhaW50LCB3ZSB3aWxsIGhvbGQNCm9mZiBvbiBwdXNoaW5nIHRoaXMgYmluZGlu
ZyB1cHN0cmVhbSBmb3Igbm93LiBXZSB3aWxsIHJlYXNzZXNzIGFuZA0KcmV0dXJuIHRvIHRoaXMg
dGhyZWFkIGlmIGFuZCB3aGVuIHRoZSBzaXR1YXRpb24gY2hhbmdlcy4NCg0KQmVzdCByZWdhcmRz
LA0KQXZpbmFzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiANClNlbnQ6IDEzIE1heSAyMDI2IDIzOjQ5DQpU
bzogQmhhdHQsIEF2aW5hc2ggPGF2aW5hc2guYmhhdHRAaW50ZWwuY29tPg0KQ2M6IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IHJvYmhA
a2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0OyBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5y
YWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEd1ZXR0YSwgS29iaSA8a29iaS5ndWV0dGFAaW50ZWwuY29tPjsgR3J1bWJhY2gsIEVtbWFudWVs
IDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAv
M10gd2lmaTogaXdsd2lmaTogYWRkIERldmljZSBUcmVlIGhhcmR3YXJlIGludGVncmF0aW9uIGlu
Zm9ybWF0aW9uDQoNCk9uIDEyLzA1LzIwMjYgMTI6MDcsIEJoYXR0LCBBdmluYXNoIHdyb3RlOg0K
PiBIaSBLcnp5c3p0b2YsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIFBsZWFzZSBm
aW5kIG91ciByZXNwb25zZSBpbmxpbmUgYmVsb3cuDQo+IA0KPiBPbiBNb24sIE1heSAwNCwgMjAy
NiBhdCAxMjo1MzoyNFBNICswMzAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gUGxl
YXNlIHByb3ZpZGUgbGluayB0byBhbnkgdXBzdHJlYW0gRFRTIHVzZXIgb2YgdGhpcyBiaW5kaW5n
LCBlaXRoZXIgDQo+PiBjb21wbGV0ZSBvciB3b3JrIGluIHByb2dyZXNzLg0KPiANCj4gV2UgaGF2
ZSBPRU0gcGFydG5lcnMgd2FpdGluZyBmb3IgdGhpcyBiaW5kaW5nIGxheW91dCB0byBiZSBmaW5h
bGl6ZWQgDQo+IGJlZm9yZSB0aGV5IHByb2NlZWQgd2l0aCB0aGVpciBEVFMgd29yay4gT3VyIGlu
dGVudCBpcyB0byBoYXZlIHRoZSANCj4gc2NoZW1hIHJldmlld2VkIGFuZCBhY2NlcHRlZCBieSB0
aGUgRFQgbWFpbnRhaW5lcnMgZmlyc3Qg4oCUIHNoYXJpbmcgYSANCj4gYmluZGluZyB0aGF0IG1h
eSBzdGlsbCB1bmRlcmdvIHN0cnVjdHVyYWwgY2hhbmdlcyB3aXRoIE9FTXMgd291bGQgDQo+IGNy
ZWF0ZSB1bm5lY2Vzc2FyeSBjaHVybiBvbiB0aGVpciBzaWRlLg0KPiANCj4gT0VNIHBhcnRuZXJz
IGFyZSB0YXJnZXRpbmcgcGxhdGZvcm1zIHRoYXQgZGVwZW5kIG9uIHRoaXMgYmluZGluZy4gVGhl
eSANCj4gYXJlIHdhaXRpbmcgZm9yIHRoZSBzY2hlbWEgdG8gYmUgZmluYWxpemVkIGJlZm9yZSBw
cm9jZWVkaW5nIHdpdGggDQo+IHRoZWlyIERUUyB3b3JrLCBhbmQgd2hldGhlciB0aGV5IHVwc3Ry
ZWFtIHRoYXQgRFRTIGlzIHVsdGltYXRlbHkgdGhlaXIgDQo+IGRlY2lzaW9uLg0KPiANCj4gSWYg
YSBEVFMgdXNlciBpcyBzdHJpY3RseSByZXF1aXJlZCBmb3IgdGhlIGJpbmRpbmcgdG8gYmUgbWVy
Z2VkLCB3ZSANCj4gdW5kZXJzdGFuZCBhbmQgYWNjZXB0IHRoYXQgcmVxdWlyZW1lbnQg4oCUIGhv
d2V2ZXIsIHNpbmNlIE9FTSANCj4gdXBzdHJlYW1pbmcgaXMgb3V0c2lkZSBvdXIgY29udHJvbCwg
d2Ugd291bGQgZ3JlYXRseSBhcHByZWNpYXRlIGFuIA0KPiBlYXJseSBpbmRpY2F0aW9uIG9mIHdo
ZXRoZXIgdGhlIHNjaGVtYSBkaXJlY3Rpb24gaXMgYWNjZXB0YWJsZSBiZWZvcmUgDQo+IHdlIGRp
c3RyaWJ1dGUgaXQgZnVydGhlci4gQW55IGZlZWRiYWNrIG9yIHByb3Zpc2lvbmFsIGFjY2VwdGFu
Y2UgYXQgDQo+IHRoaXMgc3RhZ2Ugd291bGQgYmUgdmVyeSBoZWxwZnVsLg0KPiANCj4gV2UgYXJl
IGFjdGl2ZWx5IGFkZHJlc3NpbmcgYWxsIHRoZSByZXZpZXcgY29tbWVudHMgZnJvbSB2MiBhbmQg
cGxhbiB0byANCj4gc2VuZCB2MyBzaG9ydGx5Lg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBBdmlu
YXNoDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDA1IE1heSAyMDI2IDE0OjUwDQo+
IFRvOiBCaGF0dCwgQXZpbmFzaCA8YXZpbmFzaC5iaGF0dEBpbnRlbC5jb20+DQo+IENjOiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyAN
Cj4gcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5v
cmc7IA0KPiBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0OyBLb3JlbmJsaXQsIE1pcmlhbSBSYWNo
ZWwgDQo+IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyANCj4gR3VldHRhLCBLb2JpIDxrb2JpLmd1ZXR0YUBpbnRlbC5jb20+
OyBHcnVtYmFjaCwgRW1tYW51ZWwgDQo+IDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC8zXSB3aWZpOiBpd2x3aWZpOiBhZGQgRGV2aWNlIFRy
ZWUgaGFyZHdhcmUgDQo+IGludGVncmF0aW9uIGluZm9ybWF0aW9uDQo+IA0KPiBPbiBNb24sIE1h
eSAwNCwgMjAyNiBhdCAxMjo1MzoyNFBNICswMzAwLCBBdmluYXNoIEJoYXR0IHdyb3RlOg0KPj4g
QWRkIERldmljZSBUcmVlIHN1cHBvcnQgZm9yIEludGVsIFdpLUZpIGhhcmR3YXJlIGludGVncmF0
aW9uIA0KPj4gaW5mb3JtYXRpb24gb24gcGxhdGZvcm1zIHRoYXQgZG8gbm90IHByb3ZpZGUgVUVG
SSB2YXJpYWJsZXMgb3IgQUNQSSBtZXRob2RzLg0KPj4NCj4+IFBhdGNoIDEvMyBhZGRzIHRoZSBE
VCBiaW5kaW5nIHNjaGVtYSBmb3IgdGhlIEludGVsIGl3bHdpZmkgY29tcGF0aWJsZSANCj4+IG5v
ZGUuIFBhdGNoZXMgMi8zIGFuZCAzLzMgYWRkIHRoZSBkcml2ZXIgaW5mcmFzdHJ1Y3R1cmUgYW5k
IGludGVncmF0ZSANCj4+IERUIGFzIHRoZSBsb3dlc3QtcHJpb3JpdHkgZmFsbGJhY2sgYWZ0ZXIg
VUVGSSBhbmQgQUNQSS4NCj4gDQo+IFBsZWFzZSBwcm92aWRlIGxpbmsgdG8gYW55IHVwc3RyZWFt
IERUUyB1c2VyIG9mIHRoaXMgYmluZGluZywgZWl0aGVyIGNvbXBsZXRlIG9yIHdvcmsgaW4gcHJv
Z3Jlc3MuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpEbyBub3QgdG9wIHBv
c3QuDQoNCklmIHlvdSBhcmUgbm90IHdpbGxpbmcgdG8gcG9zdCBEVFMsIHRoZW4geW91IGFyZSBu
b3QgaGVscGluZyB1cyB0byB1bmRlcnN0YW5kIHRoZSBjb21wbGV0ZW5lc3Mgb2YgdGhpcyBiaW5k
aW5nIGFuZCBoYXJkd2FyZSBkZXNjcmlwdGlvbi4NCklPVywgdGhlIGJpZ2dlciBwaWN0dXJlIGlz
IG1pc3NpbmcsIHNvIElNTyBJIHdvdWxkIHJlbW92ZSBtb3N0IG9mIHRoZSBwcm9wZXJ0aWVzLg0K
DQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg==

