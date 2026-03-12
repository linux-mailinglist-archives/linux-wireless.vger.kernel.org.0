Return-Path: <linux-wireless+bounces-33157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OzAJ5oqs2l9SwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:05:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B5279BFD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301B6304C4AC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E3383C66;
	Thu, 12 Mar 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cthNF50L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE07376BF8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349395; cv=fail; b=lE5eKshGZ8NO3c9WpYfAvGuf7Fw5JNHqRhmFzlnM8ZEGrGyxyvmfC6y3i3Ev6WYaG1KPlcpiUUEoLfWb3KSc7VSwTFQ/6NOCuKGtq4IdjUnzL4N6VGOGfJLM/NZC5pnFI62j7oOgso+4c+Q6J+6YxEXj6GlsmLV9hNHsbVZYem4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349395; c=relaxed/simple;
	bh=6bdciNJX49gnSSUPhY45STixQgR6e1HeQBqdPOs2Nzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGSQh7ksjUTWQmE8fZ+OgR+uE4B5/F33aIEa/IdI/+Tedg+qOKS0I2j+06HFJE7IdZMZHa8PYbgz9hJq2rq1MrgFjbgVLpKqneFg5mBdLwCIunM6wPsRiuFX4Xo9CqH93yESmhLZadjrSfgKEBTcFs+ofBuy42hhGiNJBjSni0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cthNF50L; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349392; x=1804885392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=6bdciNJX49gnSSUPhY45STixQgR6e1HeQBqdPOs2Nzs=;
  b=cthNF50Lnnv8UduAZu3Wznl/9gga9wgI7mMzptMJrYiROV/sEngA07oH
   HGppDAVd5XQIKRQHiZlUIrmUoFxgV0Pjog4HZHZWrhWedV2uDJpcneWKa
   zUv9uTG7S7oDvPYboKcrI4hgH9NlvvjuXCjVJNFGPpdlakXiv9v+Cbhy9
   LKa9aXeeZXZ001qCZ9mGc3s0A97NCAS0CEkNRaCuvpYfB3T6RRB0j0bbY
   PH5mCdXNtrqP3ky9mnPPZEmKI68HWDJJmsf3ALxJzmZ4mKjQBJ2M2Okj/
   P8ZLlG1i0sT79EORGVTvGzRHXVg1L8PovIZ+xvSfFv9PwwgxqyXUsWrO7
   A==;
X-CSE-ConnectionGUID: LgygMBuuSv2DSKjpClmJng==
X-CSE-MsgGUID: SRSFw6K4ShiQ3HtCIdl7Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74642829"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74642829"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:03:11 -0700
X-CSE-ConnectionGUID: nA9fK+aAQHe3nl+1CBl2wg==
X-CSE-MsgGUID: Pbb1GWP7Tc6xHlJWv6bprg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="218335705"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:03:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:03:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:03:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLl1YGTyBu/kE2R9RWoTpxfDDu2jkI6P5n/6Tiuw85MixVE9SWmMLxqyrPBObYP925sUG+47D/qLifAFdWCmX6vMBku1Snc2k0N822ufRicnzmVEc4gSPLxvVrH+rH2Ro0ywWB3pecc1obxjl6xAQVoCE3F6nn/2RE16cKxTJvAbST72Tvi69bxGfykD7HdW6pECVIJSoc/7DNPAf0fKuIYEBJqfKU9WBfy7+DiZv1XG5t7WMI3MT2MSxKJznQ3LqO2lc0Tx7j3udFQuOt24U/5gUcgYb+t+PKnbP9es6jG6DC3/nqLRpZTa2CH4Q4U6dCIaWnu3WD3G3oG+DjRl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+bvh9BA3eFIu6fO6UAV3m+I0uGrYv1ikQoaVX0FasY=;
 b=nGAluKKKDx4gIq3jUwQCmrnpGBkww7bBKimgjANZ9bryPuBiulY9iv2KVLA2VQOogtDi6jdL41ddIEoIb+YtyaZjPsnFawjRMi9it+tlEZn6IdxEq1BhTvrQFuDdCISG6IEWyQmCU1aRdG92Ebp84gOKJXg3v6IjPLfMBS6SSaK3+rbJI9Mz2/NkiH1krycAM+za4JfFJUVkrzqC6HvMRu8HIKGb6LXoSpmB6UYBcojmcbMhHcMTgAvuJGNMIAuj4TDyOH+zUY9CIl5tXDbjJs+e8HkdNJQinX2CmwHKp0XV5WIB/As2Q3NuimR0AxloGfP0Gt41ST7NJOPE/0ioZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Thu, 12 Mar 2026 21:03:05 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:03:04 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 01/15] wifi: cfg80211: Allow RSTA role
 without LMR request
Thread-Topic: [PATCH wireless-next v3 01/15] wifi: cfg80211: Allow RSTA role
 without LMR request
Thread-Index: AQHcr8tfmQUpD4bCqUC3A2G0q9zNl7WrZzaQ
Date: Thu, 12 Mar 2026 21:03:04 +0000
Message-ID: <CH3PR11MB8383C2D2AFE618B66A92B698FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-2-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-2-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS7PR11MB6152:EE_
x-ms-office365-filtering-correlation-id: d20e5e32-3065-45b4-2e1a-08de807ac137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: SVS7AY3rXxtd1NLNNw+MJs0QvNpIRzpUpU1Z9cqZZ+3XO6wR70SqR+jNgHRrA3XzqJiPjqVrsdVENp6sMvJ4BnGsT+9Wy2J8jnGpmsrm+BDHO16fjDvm0I4R70wAQlTtKeE9iOTp4n8h2hd1HaA2JpgSz9gPjluUhTfsJlY8U4F7nz3sYLrRbk3WEX7Q8nA9ovhFteAjIC6y9b87VNQrFskzUSRkaap3H/A6sMbjLnidM79QZ4/uHUWDH0RNE5JgN+hBSN9/4QugP0kFJhN/L1Ma1sz0zLgEsuLdWCFOzo5vBuYoGpUbY7Whcm2yWiik9r0A95cUWY8zEgDmSsmWZgmFwWlKWviiYHBprDRn+kDU2Zqu8wkOccyfcXkZms1t/+geB8iWbZIVF4+3OZAcAn/80Rew27D7xmbMs3DOQZJFmFZyJRAzxZMl0g8LPahxR8xlWPOW5vImNwKfYzARekV+YYxgYY9MYyJm+QIjpAFlKlzlshNv20Xv56vq78zn2xn+n1C15Zc2U0tULCctazjkXcdtalVnhpKAlefX2w5YvBBXCAuE8h6v67i0gcAa3Dy5Qz6uUiYuOUGxdmsDzzeRQ5V40s3srno0yc81wC0LTiiYzaYLyo8jFPhh/E95w3eCJDhSKO2gFh0xTPEQXwV8fGSWXqlwBT0gSYu4x1dOuAre9aBfhbbWf+wOod44waq/oDUJsiv9+ftcCDkc/9ieNR4xpCbPwq0k/jYzVdipm95XCAaphxdSHOVuQtuCyPMx6AfYPw1Zh1AKFv463D+arYA9c606pDgpAtpXio8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Cz/VmQ7QUXH7WagwFouJ8kxEs7fwRuXgjsIWOcViOrUflRukfnM/bAxWRQP?=
 =?us-ascii?Q?xBaYLTcw4vk9OiaDb3d16l9T3TXFbxr5hKe1JkiFTbqKwnc1nKD8rrw/jiKY?=
 =?us-ascii?Q?tJT8n7mpBgG4U7PKW7F980szCM/mDpQLuPvcl/Oevz+rsAnTj/Io6rZDYY2+?=
 =?us-ascii?Q?R4WR67yO5EUTHdd6YS3yEUcnqa0Jtb19TXhIHq7XydtVFuIXtCqkZ/d1JOyh?=
 =?us-ascii?Q?VCpTwJSC7/hm7rabXCvk8pQEQ1xeuIm5+eADxubhVt7PXzlP5c6i/+/9FLJX?=
 =?us-ascii?Q?9kpEi8PRHRhrwr69ODD1dXypbEwfLNBwoVgHlt8r02JASwvuYYLVx4NSZNKJ?=
 =?us-ascii?Q?U8pN5nOGlymIrt2S3ATfpWSgGy5YlOuT+zEwL/fRjv9nfumO0iSzfyHHgo1/?=
 =?us-ascii?Q?vdnBaHMmGk/dMFSnioKcFic7IPs3h4StEL4kjdF3vJyoCuaMJ0mdRUHqufH/?=
 =?us-ascii?Q?TWqVyApnboVUvAuFFjIDZeDNQnqpQv0LWtTn/fhZjEg61XPTkXqyk9a+Mdna?=
 =?us-ascii?Q?2IJ6wnkHFQmvEydopjXcepgtW22WEp/94mE+pcAP13nD1+M6aqMTsPo0Am7O?=
 =?us-ascii?Q?MuNT3igS5jjJRIGsi/sdLrZep3SBB2JtfMxbhTkrn0Grf11SkjTAX3WiLOIn?=
 =?us-ascii?Q?EHJ5iJIbufbdEtJkMcZ23bVIgPjxFOpfgLNyUl17B1paTsTIdOxQiI0iM55E?=
 =?us-ascii?Q?nkXygGZCuLmEDin4EMSYHbav2tgfqRS+GAFewKMlwYkdgqSnUw3F4naAnGci?=
 =?us-ascii?Q?PnayWkPXoiMUOq8Ei7CplZd6VLAj2Fw5oWFimzCqK+EPnmfPsoLBpMdHCO9g?=
 =?us-ascii?Q?lsiplDLBU8h/1/4s5lt+Bohdw3l8AusdV4iVOluuUMPM0j/viCFObtfhoaaQ?=
 =?us-ascii?Q?9H5A9MobuZdS1nCe+X74sBWrse6J3H7bnKSDDZmM5ON2wlGOxlqjGOfr6q9a?=
 =?us-ascii?Q?ASFdn5wf3ZDSiFA/gcGDFOOewF0qVbDqGxNVhgR5gBUUAN5h3jh3aGNbwlxb?=
 =?us-ascii?Q?D/l7zRak57DGjI9m1OAfzyDPwwMsnsVf/sFTNVARHpGVqHPSFmtr342ivNmj?=
 =?us-ascii?Q?oB/on7ejlVehP9234TbGgds4htH5ZDIbTCDypBWRq0lOVMWC4MzwSVf4XChu?=
 =?us-ascii?Q?P8nq42S0AtVkzY4gVjSQKuWwiYQkNfuAUI8v3R3DO9aoYGWKHYBZ89F8RSFi?=
 =?us-ascii?Q?tBupPW6uj59VHq8f6SLUTgLQs5EbokQfcrboj/BODz1a43TUN2HkLU45hrGw?=
 =?us-ascii?Q?oAjiEBKr+SzoHvAbjIGx/+zpMhlYcHnAYB4l3PJM4YLhxcdRlO/Cf8WpqPGL?=
 =?us-ascii?Q?dnXQ1RWKsrPR/7k93B4zevBKSAEhSiQgjiyvrziBYpszXmoGM2QsfJpQk+wr?=
 =?us-ascii?Q?CresXlLG4mT1jzE3RtXnY98ZXH3xSP/1ultQ2/Pw3teDkAL8kcNykpzULjVq?=
 =?us-ascii?Q?W3lSd9fZSi/Fr+O7Zxsc4g9PZMXJgq+BWLjYDEmGGnwXRA7JWFWFOf8rrgVP?=
 =?us-ascii?Q?ZkcTEGTR6R21MntK48hQEeK0FQv39snmovKzO8KW4BCvAejn3Te+faxu535D?=
 =?us-ascii?Q?6sOA5P4kAd8Ziys4oC2FFd1zm/M8ALK6WVs0BnF3JAZlrJP6w+Mq+IUsGpy6?=
 =?us-ascii?Q?vJ6D7NvMv1j7A8XQeaCZBCgOxB3yn1X6+D89KMdkMO6SyCVukP11b5Tfz1ZT?=
 =?us-ascii?Q?AYXqyP4qz6AEPdMobp6dz2kc6pgQOj456ImXGSgfp3usmKeEIJXjdCfIZUDa?=
 =?us-ascii?Q?CcudViHv6eQ0fzwe2QZra53buSQr/Ae8V4mwL/Yge6kYW7eqqEyn23tFeYLU?=
x-ms-exchange-antispam-messagedata-1: e7ZLC5rqNpV/8Q==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TeJ11BRRWkjuWEoV7oSt6ZSiYiTqFjKqBjKz2QelTwJgtZqN3ngQqgs/WT8faN82mgB9dtZ/TztF/SYNtvoudRkIWzj4zDQEECEAXzIP0QyvTmeGb1pC20cFn9QJPgUaE+MFNgdUdc/Wld+QODT7fYUJIZsBlRproV3+idpXFMZgGtl7aHgqtFfIw7bdrNLMro+EtI+dsF4302bqBCXja35SSqSjjK7my4wM5NbKH47sYDKd5/GlUlb4041HMmuP5FQ5yFV9RMMVvXUCWBtsP5qkIgr6Cj5cAB/ds1DEdb+H3YlQuY61C3bbE21NuO/uuKuzvuLmUVv3DkduoN18ZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20e5e32-3065-45b4-2e1a-08de807ac137
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:03:04.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkD7ZA4lCwaReqWTtRvtxxG7byoOv47+JUhZuciOdwtbrYHo604t7R0yhbJdTCPqlRncNk8roZOYR29ZxwIvcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33157-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,sipsolutions.net:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 004B5279BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hi Peddolla

> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 01/15] wifi: cfg80211: Allow RSTA =

> role without LMR request

> Currently when enabling RSTA role in PMSR FTM requests,
> pmsr_parse_ftm() mandates LMR feedback to be requested. This

I2R LMR is mandatory when the RSTA is not continuously available on-channel:
I2R LMR is required for ISTA to request AW changes (NNW bit) and to termina=
te the session.

> prevents valid use cases where devices need to operate as RSTA without =

> waking the host for measurement reports.

Devices can decide not to wake the host although I2R LMR was used over the =
air.
But with current API, cfg80211_pmsr_report() is expected to be called in re=
sponse.
So maybe need a different flag to indicate no response?

Avi

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


