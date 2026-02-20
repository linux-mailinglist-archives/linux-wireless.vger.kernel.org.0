Return-Path: <linux-wireless+bounces-32054-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LXHFvdDmGm0EgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32054-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 12:22:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E016741B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 12:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 948ED3023046
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828332F74F;
	Fri, 20 Feb 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHn9MzZz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DD32F745
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586548; cv=fail; b=XmSLEHiQG+5zFB7dlu86Aib6r4WQn9CYmbAy/RelY6LuZQzvt57ciym6xwPgrtyWOj3XjDjq7N2WM0ESZ0r+SAbzmvN1nnSsl5GES388GUNBkDxmKDPQqS1oOuuk0Tlo17ixgI0qhWqNEY6bx0VVWsgAu3pu5uL2awTgwYmpoLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586548; c=relaxed/simple;
	bh=BPZzX9GU25pqnjd1zrnCapF0AvcmPvg2ZRvoGh9aioo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gf3fz4m3DPJTxoCoR+C9d1fXUBXK9cg0xLu3Iib71dO382xTJPy/ts8sYwlMOVo6EpkUDb7EVNYJJL5BR0mYR8uhpW96ptW0/n4X1BgloymwcLWQ14Qmf/WS/yloWIJMv2IJ/EKpby+CwiBIgG73kZhcl2rxIaqUqT42k6QaM38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHn9MzZz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771586547; x=1803122547;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BPZzX9GU25pqnjd1zrnCapF0AvcmPvg2ZRvoGh9aioo=;
  b=ZHn9MzZzE3jL+ihyh4K5Yhhm5Ij12/FbanXh0QEc6o1mBThxbxtnD6EF
   32eAqNkZktBc+MqR9P4FdMqzVY1QJlWU6Ghicuo+v4Qjq5NhyHlCUU8XB
   HK/s7RZHgIXCUZu3hnFLg3dEDazGysxwIEJ8j/DoEZATmPk9/DIxvF0bu
   pzm7gf/ia1BTZxhUtRroxe78J2Xm5i7hvuFyn2qJeP+32O7Z7rWK7A+vz
   LZPdJQuQ9zY1S/RXGMV1cR3COyCrYq8ZM5b0b57cg/Yr8o6YcfiUOmHNb
   IOQ4vcjWbZx/YG5v86oarZO14y6A8c2MOKXc8xxUujWInQujgMz+NT7Hn
   Q==;
X-CSE-ConnectionGUID: FouHKrJcT9i7Zp7pQCUIbQ==
X-CSE-MsgGUID: QoEC/tGJSKWU/jaRJowD8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="84039239"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="84039239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:22:26 -0800
X-CSE-ConnectionGUID: Jj8RTkB1SRqx7K+gmONLEQ==
X-CSE-MsgGUID: oSq1hQRWRqyhfgUa52OexA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219373523"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:22:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 03:22:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 03:22:25 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 03:22:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhx5IsAckbmgqoJe66ZgEQaIe30BGdd28mev3uGZ1SGw+xGAZN/c3OVjC7rHU4PrG8CrBsv6JQ7kK5kOSBV3xkm4uScXpOA8bLNHZ4E6DzPaLepysZwUkL4HQrLCdtUOQDXWE9COCYLROxS7oX4WIONEJ2SaaE5iZgK5B3Dd+IQhkZZGI3j80Zucs3jx390IijGyXHUKWyjo2NxSwH1y7jZEFhZG2jGbhTHVy8PIZHENP+4ZfHM4sZHY0k9XwkStYByjtPq4SA9pUvYa8B9gaID82W34ylctpnf5hpEUVyG+ilu3K/8B0pMxpaZgrbv7jJ5I4cWLES4Vk1xCqZyPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPZzX9GU25pqnjd1zrnCapF0AvcmPvg2ZRvoGh9aioo=;
 b=tjAQKqVCtEuljBQ3+iUKRD27/jU53U2iOPOgGhCBsVm2pvoX7uCbFD4lmWhg5Ut5nS8euMLYb+PWAkhWluHCn6L1GqqPMo0dbStHHhaaic2wO4bTwy6q+/2b4ldAkkBTV16RFhL6DPFvHgvzHUiyuQLaetR6xxnWGVqYEObT7sVCL1h8fBoDvbTcLV3o72hSDihu1qsZ0QvB1ZnTkzpEUz5x9/CzmiqXoTwY83+NqLgLRQC0csvAl5fN3PxjMvcUmrrGJIeZhOd/a+sTNhwvNIbYITsRoBCQJNbjjD92CP3MsvDQ6r3l6YWbh0StewVKNZTCPMr3Wsj3vFZU5HnFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MW4PR11MB7104.namprd11.prod.outlook.com
 (2603:10b6:303:22e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 11:22:16 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 11:22:16 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v4 wireless-next 03/15] wifi: nl80211/cfg80211: support
 stations of non-netdev interfaces
Thread-Topic: [PATCH v4 wireless-next 03/15] wifi: nl80211/cfg80211: support
 stations of non-netdev interfaces
Thread-Index: AQHcoYUDEWzOxs7aq0m44VxZ2KHKRrWKzEKAgACJ/8A=
Date: Fri, 20 Feb 2026 11:22:16 +0000
Message-ID: <DM3PPF63A6024A9100EE445B1FB91552F70A368A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
 <20260219114327.65c9cc96f814.Ic02066b88bb8ad6b21e15cbea8d720280008c83b@changeid>
 <68db44c5-0a81-4451-bbb4-1e211d6b7cde@oss.qualcomm.com>
In-Reply-To: <68db44c5-0a81-4451-bbb4-1e211d6b7cde@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MW4PR11MB7104:EE_
x-ms-office365-filtering-correlation-id: 10895db7-f9ee-46e1-e709-08de70724dd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SzlnM1M4WjlIdE5QVGNvRi9iQThwM1pvQ1hnY2VQQjdraGQ1cEZvUWJNUUdM?=
 =?utf-8?B?UlJlNjNSeWpmYWU0TGd6RnhUUU5XZmFrd1JCb1lkSDVzdzR2VEdweVY3eGJv?=
 =?utf-8?B?WUcxMXVxU0M0SzBBWVZEcGJjeFA0Y1c5OXZpbkw5VDJEdVFWenQwQkMwZTJo?=
 =?utf-8?B?OWhEWGZSdDF2eEttK094WTlUQllkeGZwaDU1ZlJydmZON1pFRGVqZkJaWlds?=
 =?utf-8?B?YjZUaHQvbUdEWlBNUnNDbDcwMkg5d1JvUjQzaGFOUW0rN3JRRlc2am1NeTFG?=
 =?utf-8?B?RGVMeHdBMUVXR1UwdTFuQmtka3JlL1NiTjFUYk8vTUtuQ2E4N3REdHN0Rkg1?=
 =?utf-8?B?bXluRHJxc3Z4S3BuTjR3eFN3K2tzVmJwTlFmUzgybjZjM2MwVTcvRFFPRHAx?=
 =?utf-8?B?alpMTHV6VEs4d2k5N2lZUDJXcER6OXVnNnNWQWpNa0kzcUhCd1lDNU9rVU8w?=
 =?utf-8?B?bEF1eWtpeGFzUXdGYWFmM2xQZzQ2S1ZmazAweG5ySkJUeVgwNk9aRzZoK3Jo?=
 =?utf-8?B?NUNkeG56amIzUWV6aEkycGtpN0Z4Z2pINWpTd3RHdEpGR0N0Z25zNGt5bHVQ?=
 =?utf-8?B?QW5ycjY5R3A5cTVTRGY5bHhmY2FzZVFWWEUyTTh6MFdrdzdEbFZhQXRoWE5T?=
 =?utf-8?B?Z1FYYzVVOU1IZzVEK3o0MnlMUU9EWW1xYXgxZ0ttd25BVXE3bTlpaEhnWGNG?=
 =?utf-8?B?ajhuZ3Z6elNwdHZkSFlKcjN5dGVjQXYrcnBLeUJOQU5TNThOU2tHQ1RBSmdS?=
 =?utf-8?B?SHNaTGRKTUlUMzlLdUZUdE1jNHlrQWY4bkRrRkZqSm9qYVVtcm5vUmM2L0M2?=
 =?utf-8?B?dld4VUhrNzhSSGFKdVo4bm1La0dua0RmQk1JaEpTYVpzTWRMT1crSDZ6MXgy?=
 =?utf-8?B?Q2tIbWNEUDJCRk1lWDBuZlpTZkZYUmhOd0x3WDBNWDMrbmIvREcwb2V4OGRr?=
 =?utf-8?B?alIzczdsU1VTNUhOMlFHN082VjVSMHhLM0xpZjdPeFhGeHppcmwwTjVnVFBi?=
 =?utf-8?B?aEdIdytrSUIxaTl0T3BYdkh4VjBsVnhWNGpGMTVpMVVwREhCYmcwdWNnS1FK?=
 =?utf-8?B?RzVDOGpYbmsxRGIvRVB5bmYrN25TZWJUQmtieDY1U1ArT0N4SFNkTGdGNnR0?=
 =?utf-8?B?SXRJM00raFJHUktxT0xGNE1YYTZERGdtSmxwN3NCNWpmbms4ZVRrYmlBSXMw?=
 =?utf-8?B?eTNaN2tCYjNFei9EU0tmK1hiZmR6YS9TVHBSbzZGS3UxQlVSV2VqWm9iRTFS?=
 =?utf-8?B?OVg1Zm16WVhON0svak12cXJnbE16QURyQjQ1WmVzaVhyMzFKcXZvRmxkd2NS?=
 =?utf-8?B?eFpMcnNNZi96VnR3WlQwbGNTUkVpbGFsSStZSkdHbU5UNGJFWVVUK1V6TkRK?=
 =?utf-8?B?K3hPbzRTKzZuVTFEZmVBN0ZKZk55b0p1VVJERlZrdUpFLzFEenFzUmtIMU9n?=
 =?utf-8?B?T2hybmFqMmtlaEV2T3FGVGpJck5OREt0RXl2MVBOeEdUUnFyTWQ3YU9aZ1lB?=
 =?utf-8?B?T2VHMXFxdnlZYzh5Y1BubnltVkU3bXlQTkdqTlJVR0JDRWRGU1FVR213R1pI?=
 =?utf-8?B?cUFOd3I2clVyV2tjR2p1bjBWUHEyb2RyWmJrcFpBZmsyVXZsYTlOeHRldk5O?=
 =?utf-8?B?YW1sVWF1bVhmMHZYSVptNWhsakhiM2lBVTh2NE9WNHBhOTVOVDNnZGFjTUpV?=
 =?utf-8?B?K2lxRlA0c1l6ajZpMHRjamtyZkpMbFNzYXl2MFVOazNxZDVQUDhWYXV1Y2hr?=
 =?utf-8?B?ajRmaUkrWVNKTzV4VmJldEVYdUNuaHU1RHp6VGRrQ0RudnV6bW5RZmI4K3du?=
 =?utf-8?B?NkhtT1Z3a3ZxaklIU1B6bVAram9lMTU1OTdTT0kwSTVxZmwrSHdOTHhWb1Ex?=
 =?utf-8?B?STN5MkxrTy9VRWRpSjk0SE5QN211Q0hkUC9HYS9vR1Vzc1l3blZnWnY5c0NU?=
 =?utf-8?B?SytJWno1bGh5dml6eGNMUDg2eHR1QTRaY2tGL1kzTDU0UHFNYm4zYytDT1U3?=
 =?utf-8?B?MTZhalZPSEtlOWcvMGRVZ2hvaWF0UjJZeWJCcjU5aXZPam9TK1l5NTZ6RHZj?=
 =?utf-8?B?akVEWVhzMWhDVzVUaFVEa2F1RnhURkcwVnQyU3B3S2s2YTRzUjM0bHZ3cEQw?=
 =?utf-8?B?WmFDK0thS2lLTlFqTGdicXBDSFhKVDFRdlN1bUppWnVZOVhTT1MySVI4eUpa?=
 =?utf-8?Q?YFl15et9oZXIkw5YkcLJ7K8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0d2bnhyY05TWWJvUmNwZWQxUXZiNDVHaHk3ektHc3RuWjhZMjJ5Z1Yxd05V?=
 =?utf-8?B?bHRlNGx2VTRYN0dkM3ZhSkh3M255STcwdXg1VzRiWHdqZnpqaENLd0FRWUo3?=
 =?utf-8?B?YUFMdm14QTFqLytoUFE1bHQySWlrSVFkV3BEam1qR3lxOHE1aW1mL1RXMCsw?=
 =?utf-8?B?M0xGaWlPUjU0anFXZVhBOGZObml2K2g2SDdzellVajU3TDNxdUJaWm1GajRx?=
 =?utf-8?B?eG5JYzRSM2hzQ3p6Rm5aQThjY3AyaHZSRjNxZ3pOblZJd0RMVXF5alJ1bGV3?=
 =?utf-8?B?OGpZYWl1Z0VBZ1BGMmhVUndpRTJkeEkzRGZiQ2s3Yk9DSXJPVERSZ1VNcnZ0?=
 =?utf-8?B?Q2FKMDhKcCtDVGsvcE5LQ2wzVjNGQzBlcTVOYnU4dDJ5aWdpQnhZL0Zja1lO?=
 =?utf-8?B?alpZamY0WUIzVzFyM2R0UUhOTHY4VFRBV1k4cDBiQnBCSXJpa3RkVVVIZ25W?=
 =?utf-8?B?a3pHTWl6V3EzMFhNaUhaNlkzc0UwMnZxWmt3VHdpVVFiS0VXQmg1SE9vTGpN?=
 =?utf-8?B?Nkp5RDRMSlJoYmFOZlFqMDI2bWQ4ZVBjRTBuVzZsNk9JMEVqWWJSek4zTk5H?=
 =?utf-8?B?ZWpWenFtUlFicnhSOUJkQ2lmL3NZcnFSSHZiOEVOVFhCY0F4VUZQNitFR3RI?=
 =?utf-8?B?WEhiUXJhMEZreVRHcEgzY0NCWXByaTZoN1ZNTTRWdXA1S2FUWnRrQUlXUmhP?=
 =?utf-8?B?SXJUcjMwdjBCY3BxTFdPQzNYTmxORmVqOFpNS3RxT0pQQW01MG42ZkN2MmJ4?=
 =?utf-8?B?YkpEcTBmdjVkM1pXTXgrN2ZTVXJGK01PTUZzYWhiY3A2R1JadGVVQUtlQ0ta?=
 =?utf-8?B?cmlUR0ZkU3NQeXdzakZDODFMN0FTT3JHUDFYUTl4TmJQV1R3eUZHaGVJdVJY?=
 =?utf-8?B?OEJETjA2MjNldlF2eGlPYVNSUm0rWFp1cHk3MmE3MGZWc2lSQWh2QW5oRlkw?=
 =?utf-8?B?WTRtbzUvRnl0N1pvbEwyZHVyU01YVmdBNVpTaGRyRVdKazJUUTRQTVFOdFFF?=
 =?utf-8?B?Ry82MzI1cTZ3YUk2N2FYTlZVdGR5cXA5Y1VBaTJqRGZvdzhHQm5sV3F5Sy9P?=
 =?utf-8?B?cFZhNWxZQ0xIMUF5SUFXN1ROcDkzbmJLUzNzODBhc3IrSzVwdUhZRHd1YTFy?=
 =?utf-8?B?TklCUWdmODhWalVqc2MvVnVGeUZ5RTNKNlpnVnU0bjFXbVhpemloZmZDR2RZ?=
 =?utf-8?B?ZCtUMnpBSmwwNDFvZHdUUDVnd1M5Ym5tc0VaYnFQMHF0c09oc04rOFBZQlhK?=
 =?utf-8?B?a3liV09IR3NvUklsaFd3a3JHNTk3WFU1VlVDNFMxNGxjSmdSTnhkMVpQWGlr?=
 =?utf-8?B?Y3VqVHRnckJRNzJvd0lxSVV2Y3pBaS9keXJxNnFzUjUyd2lRWlBRaEx2clJH?=
 =?utf-8?B?ajlRc29oUkk2MDNpcDNtai9Ea1FYNU9zalRSQTJ6WlBCYUZDeGJacUdPb0J2?=
 =?utf-8?B?d3dKa0pJL25VUUlrMmJYUEhYMEFUWlRzWjNqRnpydWNMMkJVVDFkSW5iOXkz?=
 =?utf-8?B?RHloNHh3UnZsSTh1NThLeXI2OG5CWS9nZUxuVFVlaEZZaitJNE9odUhrbVp2?=
 =?utf-8?B?WHRsUUVoUFpYS3ZZS0FmWkEyUDRPZDNFQVNZdWIzYkl1dFZIRXdBOGVwcW5S?=
 =?utf-8?B?SUlvdnEyWmsrZmFna05IVjRzT3Y3dWtRSE9ZV2xFdDNZS0s5a0R2bEVuemdY?=
 =?utf-8?B?L3ZRWDRURkxWVzlnMFpzYUFnMlRxMEtyQVVpc1lHK3R1YmFFQ1kyUm1ZSVNt?=
 =?utf-8?B?VHVzMHpMT0J3WlBBTDVMQmVLRnY4Z05GK0VLT0ZES25rbDNyUE8vVzR6bWlO?=
 =?utf-8?B?enZXcnluS3NPaFNpaGlCc2tYaFVuZUVRQThkK0VMS05LcWU1T0twYzVBdEdx?=
 =?utf-8?B?b0xuZk1lbVBwZW1MMDBOL3FKbVFSZlhRRUR6MTBOV3orWWgyWHo5YVVTcmIy?=
 =?utf-8?B?ZmloeVdiTnNncFU4WWRlR0JPK2lITllYT0xzTEM5VHFWUlB1TnNQYmFLSXB4?=
 =?utf-8?B?WXpGZjZLWE85djNRYjlBZVdqQ3Q2WEE2Tm54RnJCMDl4N3FMZzF1VmpOd3lZ?=
 =?utf-8?B?UHBwQ0VGOGNvUjdtQnd0NzlGcnU1cTc4eERRT1ZnWTZlMGxVTGN1elBrbkxP?=
 =?utf-8?B?cHNpd2xDb0VhRmk5VDVRNmNsbXg0bHlSOTMvYUpFV3gzNmZiRUxPSVo5Zklp?=
 =?utf-8?B?OENEK3RmNTdFWitibW1qRDU0cFdUQUtndjMyY2ZDUDRxUWVHdlpWdmR0NTMy?=
 =?utf-8?B?UXZ5eTYzUm0ySDFVWE5TUTk5WURNQ0NaUndlbnZLRGNmV3VvcWtIVlN3b0dM?=
 =?utf-8?B?VnQ1SG9BS3NmU3F1Y09wRnArcktLb0lIZUE5VkxkdE1iTm5aOGNaZW8zQkoz?=
 =?utf-8?Q?D4bMELodI1Zmj6vY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10895db7-f9ee-46e1-e709-08de70724dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 11:22:16.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LciVUsHHuVZM0HvIeOyZS0kumjtM43dwfdYPjI0GLLGVkyYvnJk4tHpxSQYEq6VG6w3fCNyEnk+dQ+xcCaqpuyV9Cs2e9lUbOpAjHVvvz0R553NImQ0uuia/JROGiMi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32054-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CA4E016741B
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBKb2huc29uIDxq
ZWZmLmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAy
MCwgMjAyNiAzOjI0IEFNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5y
YWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCB3aXJlbGVzcy1uZXh0IDAzLzE1XSB3aWZp
OiBubDgwMjExL2NmZzgwMjExOiBzdXBwb3J0DQo+IHN0YXRpb25zIG9mIG5vbi1uZXRkZXYgaW50
ZXJmYWNlcw0KPiANCj4gT24gMi8xOS8yMDI2IDE6NDcgQU0sIE1pcmkgS29yZW5ibGl0IHdyb3Rl
Og0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoNmtsL2NmZzgw
MjExLmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg2a2wvY2ZnODAyMTEuYw0K
PiA+IGluZGV4IDg4ZjAxOTdmYzA0MS4uZWVjYmEyMjAxYjEwIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg2a2wvY2ZnODAyMTEuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg2a2wvY2ZnODAyMTEuYw0KPiA+IEBAIC0xNzc1LDkgKzE3
NzUsMTAgQEAgc3RhdGljIGJvb2wgaXNfcmF0ZV9odDQwKHMzMiByYXRlLCB1OCAqbWNzLCBib29s
DQo+ICpzZ2kpDQo+ID4gIAlyZXR1cm4gZmFsc2U7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMg
aW50IGF0aDZrbF9nZXRfc3RhdGlvbihzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1Y3QgbmV0X2Rl
dmljZQ0KPiA+ICpkZXYsDQo+ID4gK3N0YXRpYyBpbnQgYXRoNmtsX2dldF9zdGF0aW9uKHN0cnVj
dCB3aXBoeSAqd2lwaHksIHN0cnVjdA0KPiA+ICt3aXJlbGVzc19kZXYgKndkZXYsDQo+ID4gIAkJ
CSAgICAgIGNvbnN0IHU4ICptYWMsIHN0cnVjdCBzdGF0aW9uX2luZm8gKnNpbmZvKSAgew0KPiA+
ICsJc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IHdkZXYtPm5ldGRldjsNCj4gDQo+IHdpdGggdGhl
IHVwY29taW5nIGxvZ2ljIHdpbGwgaXQgZXZlciBiZSBwb3NzaWJsZSB0aGF0IHdkZXYtPm5ldGRl
diBpcyBOVUxMPw0KPiBqdXN0IHdhbnQgdG8gbWFrZSBzdXJlIGV2ZXJ5dGhpbmcgaXMgc3RpbGwg
c2FmZQ0KDQpObywgaXQgaXMgZXhwbGljaXRseSBjaGVja2VkIGluIG5sODAyMTFfZ2V0X3N0YXRp
b24uDQoNCkluIGNmZzgwMjExX2NxbV9yc3NpX3VwZGF0ZSBhbmQgbmw4MDIxMV9wcm9iZV9tZXNo
X2xpbmsgLSB0aGUgd2RldiBpcyBmZXRjaGVkIGZyb20gYSBkZXYgaW5zdGFuY2UgaXRzZWxmLg0K
PiANCj4gPiAgCXN0cnVjdCBhdGg2a2wgKmFyID0gYXRoNmtsX3ByaXYoZGV2KTsNCj4gPiAgCXN0
cnVjdCBhdGg2a2xfdmlmICp2aWYgPSBuZXRkZXZfcHJpdihkZXYpOw0KPiA+ICAJbG9uZyBsZWZ0
Ow0K

