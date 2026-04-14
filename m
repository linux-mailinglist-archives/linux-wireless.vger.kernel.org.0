Return-Path: <linux-wireless+bounces-34721-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBmwJgW63WnciAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34721-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 05:52:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102993F55DB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 05:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B62143027D91
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8718872A;
	Tue, 14 Apr 2026 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSqmU6Qt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E6336885
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776138730; cv=fail; b=Z2VaPUTiOiwGHctNTQT9sRlvJ6yQO1ryGwxAJOOrepPIoQWnX3iupfMuKrG3wVDx9J/fs+qcW/rzzktq+5eSWAQBXE3JNmBS1CiaeemtKLEn48g7A7Tz3TMsb78FgaMZA8iav8L3Dc6KH3QbEBzCDfCn6ChOCqYM2eMp5htH3A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776138730; c=relaxed/simple;
	bh=WegZ/DGh+ogTWxDtxsRpXvMmuanbshrO+jzTsrF2mlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEX2Yl9EpQX7eOBh8EVaIhVXT8Ddk6icDA7lCgKKuaB+0HTN4TJVnXIHIyBo6Ibj+Xs6/OqGm0mEIXhycMC4Ahet9hTdl7kcMQi9szXU2IZDUkh+F0FasN5Gba2JLii1ufpR/nGsfpJ1VU9Y+vvLLD+4iLsRjO1FN68LORXA2sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSqmU6Qt; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776138725; x=1807674725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WegZ/DGh+ogTWxDtxsRpXvMmuanbshrO+jzTsrF2mlc=;
  b=hSqmU6QtW1Im646HJs4ubqm1aT8mOEXlIsef9OOBAQOZWZb6+W4nnB2l
   LtTJC+eePGeGJTYoK8Ti797kzSto7is8OeB88/dHqwbGqZEOo1dR8XkV2
   xZ4+6YnjonDq2ALktMGx/AQJlhdev+SG79+UAMKGhwa9RQ8enhtjD0PNG
   ZqSm11cG9MlA9kYNteljZRGiUtYhRKC+LyhJIiHed21ZrAEYNG3UYwL0q
   MF7yQzT0Qy5Wu/C0vKs+2kdIBGB04Uew+Ez8+VLwMg1+O4jeQ9B+NbgQN
   8YWL6Il5Z6BSieLdG1/qBX7ZoKx6+SDxSg0LSZbT/e0wnnNFHsN/NyU64
   A==;
X-CSE-ConnectionGUID: hyIwp4WWTyWh2jxIgruQ8A==
X-CSE-MsgGUID: kYWqmaNlTBie/+tAYmYj7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87385541"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="87385541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 20:52:04 -0700
X-CSE-ConnectionGUID: NP6FtmkkTeSR4/72Btyk/Q==
X-CSE-MsgGUID: U5zh6OXVStGtz09KY2gptQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="267955850"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 20:52:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 20:52:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 20:52:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 20:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFhneG0QAMfQx05f8NZFy2d8DKsCFfsBWcVl5ZEtvZPlk8I6CwlSy6zmm7cPsEGFSTlk8HVl/90Ks4masSlSbZE5DpoR6JvspfcS165D8L9pax34u5gDJ22Mb56qc6S5UPTe4bQpsKfa7DPJwPQ2EXSuxBmGyqLWgo7AvZjjPqWrL0MjMupxVoRiaciF1j4yjC7e/OBlz5vbOAh/9wXSPh65WJBGvlXHPM/NGtXvjVKpn9K6pTB6qISeG2Gl3dn2steZ1IXu/oQLY/HBDF430l0T2vdNeB3fyDsSx4KNwf9/KjluSYjlDIv8TgjMlkyjoPf3czgadQAcWjn0dyMdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WegZ/DGh+ogTWxDtxsRpXvMmuanbshrO+jzTsrF2mlc=;
 b=JIVRwLBn4RmlhTRCXQ30ZA/AMl73N0XtPdt6ZVil//G0SfEbWeksD2Zarv6ietutqTOT7IDvwH2bA/rxDb7haVhKyBygHSZUwDrk4LZNo8VbIUz0uwegbFH7lfEpun4ATeru4mEAH1XLyfzly1wkjv3ZwUMXdQA2uJVVSZMg3/tNoSog4FStk9yTK9rPhn3l1I+epaJYzaHvIz4Dft6MEMhyDt83XKjD2NdRtyHAXYzaDfjUY3wVvM40GrSTbkLSH4GQm5oUNphAG3tBredWphJPim21GSajvrUcqbSQRfrOCbuIkT4cmw07rIbc6HTfEb//K4OND9atTtbPCQ7UEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Tue, 14 Apr 2026 03:51:52 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 03:51:52 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Cole Leavitt <cole@unwrap.rs>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "greearb@candelatech.com" <greearb@candelatech.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: RE: [PATCH v2 0/3] wifi: iwlwifi: mld: fix UAF and soft lockup on
 firmware error
Thread-Topic: [PATCH v2 0/3] wifi: iwlwifi: mld: fix UAF and soft lockup on
 firmware error
Thread-Index: AQHcxL7sJ48JlY4NP0q4XdyMu9zOU7Xd+hjA
Date: Tue, 14 Apr 2026 03:51:52 +0000
Message-ID: <DS0PR11MB7880E9A54C78A39307F793C3A3252@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <20260405054145.1064152-1-cole@unwrap.rs>
In-Reply-To: <20260405054145.1064152-1-cole@unwrap.rs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|SJ2PR11MB8565:EE_
x-ms-office365-filtering-correlation-id: 1617be09-dcdd-4c0b-a8d2-08de99d929ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 6h0n30VUKOg6mWgTyiVz53HfITaz8VG976fhHacZvgIvN6BlLLwcYwQG1cuaZPYRxzsB2ZYyulY0UbKElE5/kr3k/tjmWIKx8RXFpYdQpgX7FLF7pkpR6q0so7kzG3XoEkwilD3SmXRkxSbPd1ZMs45fMPqzYJQzmqPbfT/54ON3E3sz/j5VaAqieC5n7z/IMVEgZXDH0sBKsvKjhJLCe1OAzHePbhJpCdi0ByndnpkV6xZp86jAgrUulM4KHMRUlE0kL9zkYRHMiseP/pLRqxv14tJWt0cu6rcJxFRcIQgGj3Ru1PYCKcMQGgFoI8kdW5JW13mD8jrhs8YUIPya/xfy/pUkBAKxrgr7VXd7XGnzb0UOBqEdaMLgnEHycvF5mXIuQkQJ+vPs9nxfyymHG2+ASPKla+I6DDsnNfkS7i5/LGYhnHUFI9nS5v/RlKZ6HBDAmnCgAtlwYA38rI0tgFvT+d6rpKJ+5wLLt31e5hIhH15zxR9tLiVR5K44lmzmozqYndhQNulmcAdzw3y1A6H4CO8a+3ONslcsOuSkH9ZjRux8rcZwRKYMCKupTdijTmnlKkZa/AdQVQp19ZGKpa+JLO5lbjCdCzw+fS//q8uP+uw+C0JMh2weMjT860X9GdutYKQ4x+ib/zxXzeqtiQP0hb0Vy6G+lJwki7B+4VVwitUO5lQIMTt0nI8xuF3naG+SzjWH0XzyqoN4Dno49r9vZJ5SDMMmswvjzEFKk+s+/snM2FLVNvX1Uk3oquXwg7ZPEOzPneJ0Av3cAhT3JJKC12HI3CKqmaIYtHnT6w8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZGZkpoQlJ0OXRqWmZxUEhyMlF6VittMVFxbERiQjNvMFdkSTJiQnJpOFZE?=
 =?utf-8?B?SDFUMTBRTU5QL2ZsNGVSTkdmeXQxc2pLRG1kUFFCWXNTV3N0cnBuN0Npem5i?=
 =?utf-8?B?aWFFcVN1cnNaZUVaZytTNlpKK3YxMWZ5ZjdTczQxOEVvbVBEM3pWQ0hmNERL?=
 =?utf-8?B?SjRvRXhOQlR3Z2JMMExETUZvYzZxNGpsbStpczdaNnlDSUpLd3RFWXkzcUJo?=
 =?utf-8?B?cGhSa0doMXpiOUd2S3N1QkhRUlZXL092VU8xVUxkUjIvZGIxMUx3cFdicnZx?=
 =?utf-8?B?NTNrTk5PSlpWRUdqM05VSDJwbW5aaTI3djByTy80WElkbDM5Q1RrT2ZQSTJE?=
 =?utf-8?B?eVoyR1lLT2FmNXFJVXJEeWpZcFRRNE9BeU9BNXhScWxmTEJzRjFRb3hjdy9U?=
 =?utf-8?B?SHZQSjluZG8wcEVpRkMxb1NoZVAzQ2RGTitBUjRRWjZPZ2xOSVN6ajhaRlpl?=
 =?utf-8?B?eC9CS3BHaWhWVG9qd0NaT1BnTC9YOEk1NVQyWUVOY1hzOTIyVTNZQXpabE9G?=
 =?utf-8?B?SGNaenk3eURmYmNhNW5YRVZDUkdNMmpmeVBBVGZEUHFWMjlBSkpkS2VFYTk2?=
 =?utf-8?B?cXNpZjBBNXkzTFlrT0FyTEc2NUtWZnY4cWFBLzlrbGNBekpqWU9ZQVpQNUZ0?=
 =?utf-8?B?cE05ZVJFVjBlbGMyS0ptbm1NeTZySzlubEcvR1ZuOHczMnFkN1hyTkhFSDJI?=
 =?utf-8?B?N3ErYmdhRW81MnNPOVQwVWJ0L1c1WjJoZHRnRmVCSXBKU01JYW0vQ1dWNnlW?=
 =?utf-8?B?d1U0dE5JMkJQckhzZVZsMmdJZEliMlpldjdMWXo3MkhUOVlVUmtnckxKWFRQ?=
 =?utf-8?B?NDRva2tBM1JOaXFMRWtVSjRkNUV4MEEvMktkRDlyYWdkMDYyeHI3UXNZVmRG?=
 =?utf-8?B?RWFGRVdBODlRV2FPelJ4c2IwUTNHdFZaaGFPUHlTU05KM0d4ZlJRQkhHOXZ4?=
 =?utf-8?B?U2MraUtUaHZvVkgyM3ArZ3kvWlN5SFJ6TE5IVEdnUzBMSG1MUm83TGNpYVM1?=
 =?utf-8?B?R1pxd1YrcittRGVITFlHN1BDRHh1RjVjK2NBVEdqWkpORGk3Nit0MmNKTjBu?=
 =?utf-8?B?S0VvdzQxSkQyQmdiNFFDVnA3NXREV0JqWE94NmoyWGpRMUZueUFoS3Q0SHZs?=
 =?utf-8?B?U1BGejFqRjlYamlabDlaWEhpMGRNb2ZuMkl5akJuMVhJcFJpcWJwUktSWGZV?=
 =?utf-8?B?ZHRCeE90emVxTnE0L2krcTBQU3FVWkY0L1JxN1ZRVTZVU3B5NG9aL2R1YnFC?=
 =?utf-8?B?cFI0K1lmWVpvditIYzMvODVWdXZrR0R6akNiOFJ5SHdlK2lGNVdNaVI0bUJr?=
 =?utf-8?B?S1ZoeHo2NnhReUVkQkIyU3RHQWpoRm5EU2tFYXlDRVFOYlVzNE9rakxzR0JC?=
 =?utf-8?B?S1ZTTXVzY01zZWN6M2hHYzA1ZEk3RGhwNGF0Q1RlenRXTURsVWFGa3JkclNM?=
 =?utf-8?B?STh2NWtIbks1cjhBZW5YUTBnY2xUbVJOWld2dTZ5L1pHWDBuVWZDdmJPcXli?=
 =?utf-8?B?dE55Y2NUcnJRNk5yOUV2T2xUY1BJYllNWmxnd3NqMlY5ekNqUDZuVDZXd0x3?=
 =?utf-8?B?REFvSXRkUldna09TUitiQmc4dTRUazRzR01TTlozaDUwVHh5dnFuM29xeEd6?=
 =?utf-8?B?TXlTSEJlZzg5di9Rd0NLNzBEQUdYQUU2R1BVRGhlRWVGQ2dZRGZmR2NUTXdr?=
 =?utf-8?B?cHR2ZnVHY25NTStiWVVsMGJjazcvRG9qU25OL2VuSUpLc2Q3M1pQMFRZQ2ds?=
 =?utf-8?B?OFV1VUtOaDQyOWQzSDVsL216NHk1aWNtd0dTRTJJQXZsdEVaZjRyYTIwN1V6?=
 =?utf-8?B?UlZXQ3JxZ1dOOS9qTy84Q283U2hyVWpNbFQ1WlYwVWtvOVJtQW1qa1IvdDdF?=
 =?utf-8?B?L2JCWGt1UDFWdHRieEpWcEkyQnQ0c2FhUzA1dlNERjEyejVhZVRjanh5WUFz?=
 =?utf-8?B?Z1d1c0cxQk1mZTUzRno2TnhhNEVmWVNlYU1ibUtkN2NxZFRmL3MrV3JjeTVV?=
 =?utf-8?B?N0tjdnNpaWwxajVCOE9hQ2lWTWUvWW9wbWt4eUc1WHdUQUJDL0d0VGNvbWpJ?=
 =?utf-8?B?MDBZeGR3b0JKa1NlcEU3OEI4c0JlbHRIZzFHc3ZlSStIY1J3NytlR1haUDFD?=
 =?utf-8?B?OHZuZlpoZ2lPN29UWmRDN3A5c0p0NG9CczJDOFVwOTdtQkdUb0tsVVFSQmNw?=
 =?utf-8?B?Q0JaUWFvaWczN1NIZHBDYXNBdmVaQWpJMHZVWUFkaTlSYUhRNjIrQ0VUMzl3?=
 =?utf-8?B?WDZFaCsrQjlwTTZTbUY0eFFNZEgyeXJ4R1dzRHRFZ09zZW1Hd3BlZUdUZTdh?=
 =?utf-8?B?ZVREV2h6d25VZDlXRlJENTE3enZPeFFRV0g2ZHVsMDNJY0R0Y3JUVmZlSTcy?=
 =?utf-8?Q?NyVmEEwXXDMa0OVY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MnvMv8Em10wObNieuJxVdG+JF6gMLm8kvdN16Q/yg211SvTDPcebgJNCFhAzCbA9hjcNhvFkl8xxoZJAtSy6B4LnHtvfMCykIDWpEsrJLyZWPOaXpxjWF6SIKVMi9aGVL/JeM2BtAvRDmAWN0n6YFjkP2srfAzaVcyqg6whiSaJRtuPV6ywxXRIba5X2CHbU+Esd6fUKz3D7BxukAa613bjC1jN2hTIEWJ5eJmXdJZBZvdOE+K04VvxruyOC6PcHZTLQWBS1K8v5e7deR59le4epsBq6xmDiT+46HkQBxzAOf06iOb9wrRlhGTxSLlJnzMR0TzojTlzIfGjxi9G3EQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1617be09-dcdd-4c0b-a8d2-08de99d929ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 03:51:52.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0m0UH8HMsGT4ZlvlK3jT67kEqe9LNCceIFQVeROYFBaRdLIo5nFqRcw5aAav7ZJ/WZhViesJgI52SlF/gSPOBJESPKlHYy8owbtqzWYOyScbvDeV3OrVN3pdTLiBCu5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34721-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,candelatech.com:email,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 102993F55DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29sZSBMZWF2aXR0IDxj
b2xlQHVud3JhcC5ycz4NCj4gU2VudDogU3VuZGF5LCBBcHJpbCA1LCAyMDI2IDg6NDIgQU0NCj4g
VG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZ3JlZWFyYkBjYW5kZWxh
dGVjaC5jb207IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3Jl
bmJsaXRAaW50ZWwuY29tPjsgam9oYW5uZXNAc2lwc29sdXRpb25zLm5ldDsNCj4gY29sZUB1bndy
YXAucnMNCj4gU3ViamVjdDogW1BBVENIIHYyIDAvM10gd2lmaTogaXdsd2lmaTogbWxkOiBmaXgg
VUFGIGFuZCBzb2Z0IGxvY2t1cCBvbiBmaXJtd2FyZQ0KPiBlcnJvcg0KPiANCj4gVGhyZWUgZml4
ZXMgZm9yIHRoZSBpd2xtbGQgc3ViLWRyaXZlciBhZGRyZXNzaW5nIHVzZS1hZnRlci1mcmVlLCBU
U08gc2VnbWVudGF0aW9uDQo+IGV4cGxvc2lvbiwgYW5kIHNvZnQgbG9ja3VwcyBkdXJpbmcgZmly
bXdhcmUgZXJyb3IgcmVjb3Zlcnkgb24gSW50ZWwgQkUyMDAgKFdpRmk3KS4NCj4gDQo+IDEvMyBj
bG9zZXMgdGhlIE5BUEkgcmFjZSB3aW5kb3cgd2hlcmUgc3RhbGUgUlggZGF0YSBmcm9tIGR5aW5n
IGZpcm13YXJlDQo+IHJlYWNoZXMgdGhlIFRYIGNvbXBsZXRpb24gaGFuZGxlcnMsIGNhdXNpbmcg
Y29ycnVwdCBTU04gdmFsdWVzIHRvIHRyaWdnZXIgc2tiDQo+IHVzZS1hZnRlci1mcmVlIGluIGl3
bF90cmFuc19yZWNsYWltKCkuDQo+IEJlbiBHcmVlYXIgY29uZmlybWVkIHRoZSBXQVJOX09OQ0Ug
ZmlyZXMgb24gaGlzIHRlc3Qgc3lzdGVtcy4NCj4gDQo+IDIvMyBmaXhlcyB0aGUgVFNPIHNlZ21l
bnRhdGlvbiBleHBsb3Npb24gd2hlbiBBTVNEVSBpcyBkaXNhYmxlZCBmb3IgYSBUSUQuIFRoZQ0K
PiBUTEMgbm90aWZpY2F0aW9uIHNldHMgbWF4X3RpZF9hbXNkdV9sZW4gdG8gdGhlIHNlbnRpbmVs
IHZhbHVlIDEsIHdoaWNoIHNsaXBzIHBhc3QNCj4gdGhlIGV4aXN0aW5nIHplcm8gY2hlY2sgYW5k
IHByb2R1Y2VzIG51bV9zdWJmcmFtZXM9MCwgY2F1c2luZw0KPiBza2JfZ3NvX3NlZ21lbnQoKSB0
byBjcmVhdGUNCj4gMzIwMDArIHRpbnkgc2VnbWVudHMuIFJldmlzZWQgcGVyIE1pcmlhbSBLb3Jl
bmJsaXQncyBmZWVkYmFjayB0bw0KPiBjaGVjayBmb3IgdGhlIHNlbnRpbmVsIHZhbHVlIGRpcmVj
dGx5IGFuZCBhZGQgYSBXQVJOX09OX09OQ0UgZ3VhcmQgYWZ0ZXIgdGhlDQo+IGRpdmlzaW9uIGFz
IGRlZmVuc2UtaW4tZGVwdGguDQo+IA0KPiAzLzMgYWRkcyBTVEFUVVNfRldfRVJST1IgY2hlY2tz
IGluIHRoZSBUWCBwdWxsIHBhdGggdG8gc3RvcCBmZWVkaW5nIGZyYW1lcyB0bw0KPiBkZWFkIGZp
cm13YXJlLiBSZXZpc2VkIHBlciBKb2hhbm5lcyBCZXJnJ3MgZmVlZGJhY2sgdG8gdXNlIHN0YXR1
cyBiaXQgY2hlY2tzDQo+IGluc3RlYWQgb2Ygc3RvcF9xdWV1ZXMvd2FrZV9xdWV1ZXMsIHdoaWNo
IGRvZXNuJ3QgaW50ZXJhY3Qgd2VsbCB3aXRoIFRYUS0NCj4gYmFzZWQgQVBJcy4NCg0KV2FzIHRo
ZSBzb2Z0IGxvY2t1cCBoYXBwZW5pbmcgYWZ0ZXIgKGFzIGEgY29uc2VxdWVuY2U/KSBvZiB0aGUg
YnVnIHRoYXQgeW91IGZpeGVkIGluIDIvMz8NCkkgYW0gd29uZGVyaW5nIHdoeSB3ZSBkaWRuJ3Qg
c2VlIGl0IGluIG12bSBkcml2ZXIuIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBzdWNoIGEgZ3VhcmQg
dGhlcmUNCg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gICAtIDEvMzogQWRkZWQgVGVzdGVk
LWJ5IGZyb20gQmVuIEdyZWVhcg0KPiAgIC0gMi8zOiBDaGVjayBtYXhfdGlkX2Ftc2R1X2xlbiA9
PSAxIChzZW50aW5lbCkgaW5zdGVhZCBvZg0KPiAgICAgZ3VhcmRpbmcgIW51bV9zdWJmcmFtZXMg
YWZ0ZXIgZGl2aXNpb247IGFkZGVkIFdBUk5fT05fT05DRQ0KPiAgICAgZGVmZW5zZS1pbi1kZXB0
aCAoU3VnZ2VzdGVkLWJ5OiBNaXJpYW0gS29yZW5ibGl0KQ0KPiAgIC0gMy8zOiBSZXBsYWNlZCBp
ZWVlODAyMTFfc3RvcF9xdWV1ZXMoKS93YWtlX3F1ZXVlcygpIHdpdGgNCj4gICAgIFNUQVRVU19G
V19FUlJPUiBjaGVja3MgaW4gVFggcHVsbCBwYXRoIChwZXIgSm9oYW5uZXMgQmVyZykNCj4gDQo+
IENvbGUgTGVhdml0dCAoMyk6DQo+ICAgd2lmaTogaXdsd2lmaTogcHJldmVudCBOQVBJIHByb2Nl
c3NpbmcgYWZ0ZXIgZmlybXdhcmUgZXJyb3INCj4gICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGZpeCBU
U08gc2VnbWVudGF0aW9uIGV4cGxvc2lvbiB3aGVuIEFNU0RVIGlzDQo+ICAgICBkaXNhYmxlZA0K
PiAgIHdpZmk6IGl3bHdpZmk6IG1sZDogc2tpcCBUWCB3aGVuIGZpcm13YXJlIGlzIGRlYWQNCj4g
DQo+ICAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21hYzgwMjExLmMgfCAgIDQg
Kw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdHguYyAgIHwgMjEw
ICsrKysrLS0tLS0tDQo+ICAuLi4vd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi9y
eC5jICAgfCAzMzcgKysrKysrKysrLS0tLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI4NCBp
bnNlcnRpb25zKCspLCAyNjcgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDNh
YWU5MzgzZjQyZjY4NzIyMWMwMTFkN2VlODc1MjkzOThlODI2YjMNCj4gLS0NCj4gMi41Mi4wDQoN
Cg==

