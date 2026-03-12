Return-Path: <linux-wireless+bounces-33160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCHgAukrs2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:11:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B6279CD9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543FB30C3995
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C58386C0E;
	Thu, 12 Mar 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrS3++QS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8D387593
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349605; cv=fail; b=owqD5K3TchdbhnluwNOwoDa/S0xq8opEzj0fhFeph4maKzKYIRrx6woFWYbUOtGHR7/zF/sjrTqfm+8KJlpg198AJtA6AT//NjkX78WUmYPDC4VJV3RASEX3Waqlf0eVpNikCf57Xaa8Asz7aBHjh0/4myG7N7Lv6/jk+Qza2Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349605; c=relaxed/simple;
	bh=RoPGhZr4LJ+tWy15H2c8tzIEELw6Q5l334j77z3/65Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lkDB9rhBNXlvhU5JQhRP1WQnzAzk0lH4pMt3lIQ4UEGq/Wx2AV7DINQLdVyarcbCgbuEyK2kbsdz/uc5tXNfJQ4h+qqZlIXa/OIPK44es1aUaLoVfrlhrvrvMjtQjYLN+Mx9STfXlQgdT9OZMTpob6AI0+fhv+WIA6cxf1SjaMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrS3++QS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349603; x=1804885603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=RoPGhZr4LJ+tWy15H2c8tzIEELw6Q5l334j77z3/65Q=;
  b=OrS3++QSL46gMJvAdo6Efr66SMg8aeqKyxzRe4hQfiOzrNr9HyOueT+5
   LBwigLYzHkv8nMsmk2ou84pj/eDS4KRJXIcR9Tz+HYiP012oma20zUwTL
   b5hiJ/WnJ0M/rWiaELL5MI4HRZQxURHfbtjK/WwLZn1xK2bWptiO5ax2/
   uBM3ZO+RpyPg186ZxFX+55qb0r/nHgZSK+pwXAZVPapMDX/hW0uWsryRd
   biMwcqAXcpVLbpxSo18WrjTfDkJD1rXHq++vTg3mqEPNTgeU3ZD+eaF7y
   jXdrVwGkdoIrXvF0V/Rdpt0p2XbgW7LGwGYZAfTM0gxW0ecyCiqtfFAKe
   A==;
X-CSE-ConnectionGUID: Z3c+8vcVRPal7FxQQfAk/w==
X-CSE-MsgGUID: ArEMYVZnQJW9iB/TNbpa6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74349588"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74349588"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:06:42 -0700
X-CSE-ConnectionGUID: aJTWpdudSju9B97sXGn20g==
X-CSE-MsgGUID: apyOaxvsR3+W/hWH9Zsd6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="217021510"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:06:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:06:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:06:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UclqegiCdEfWk5utEF7V8yNuhd4XFWtCyj6Tog2FZGH/0frbMIsrDbnYKxOvZoUkxSZS9i2QDvann5TmSB46jvk4y3F7XCJO0oAMDKUtawuNt2MaSnEkdN2f7pYHGJZ/Hog5e9flrn81v/JeXT1vcXoGYbs1DUSrSVSf5RmO22VEQFpj9jI5y/irOBB8YARz+CirEjOe+zYUYhvH0bts6idQAycG8L7BNqF7admhjzZv+rhSEYW6A6fdreOSalqblxWYcJQPwyqzjNoZM0m4YLZVHHRaeuQcP0Hm+yKLjxHy6udE/rgkT5be5CNhXz7WYQbE4KONxIAPsrCELgK3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh29HpxxNk731lxPZcX14BOsgQhj7VmDnWyY96u328w=;
 b=XH/eZpBmZGLOI4yVj9pAynXYyXGCdzTyWpt78+A+lovw9o0VNx0HaPbGJnaQcsS5Fj5+SRug4pB0/3KwyXCDjsz9iyETM33b2QtTxefd3gFrnU/Re3QeHSD5UmN+MdsD1HhIgJBoRqQuCI8ynRCqgl2tt8s3FaQO74b4EIAESp2x7fuM/JMmrb/9/fXoUaBkupEvOb3/lELf88K9fBchhP1AtCLfgwGVzQALD6/fcijn1XicPudEnlbAPOf20+b3tSSj/bIcO3rOZ+jctFynzVNHyJ2a1lDHJ8B0ld8D2uT8JQnVu79mY1fJYUKU3xSvk/1hn1D++F7vB1JyTgsKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SJ5PPFC295640A5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:06:38 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:06:38 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 04/15] wifi: cfg80211/mac80211: Add
 NL80211_IFTYPE_PD for PD PASN and PMSR operations
Thread-Topic: [PATCH wireless-next v3 04/15] wifi: cfg80211/mac80211: Add
 NL80211_IFTYPE_PD for PD PASN and PMSR operations
Thread-Index: AQHcr8tfJlFROaZiR0KmHmvvESOuQLWraEtQ
Date: Thu, 12 Mar 2026 21:06:38 +0000
Message-ID: <CH3PR11MB8383B129375415AB3B50C4DCFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-5-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-5-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SJ5PPFC295640A5:EE_
x-ms-office365-filtering-correlation-id: 49e8fade-d8d0-4865-1bca-08de807b4084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: GsQyMczfzwZmTUmOSXYp3m/69FHIsAGBjnmt7LtvKB2GZtQsRkFII5ALLevKOr0SfUImkT0WUdKa7Ps8nWDW8PliGaOuStqDWfeNn5+bVs+5klhK+lTZvu083/92yLyLXhcEq0I7ee1adYTB+JFShQi3uQXSMxpY1JVEhuAUaFVaCl2QIhyHjYVbLj6DXTO0RMrIUF6LNFm1uOFd2HBXke5ee274eyNX12jTpdeN334qGwyZ674u5+WzZbSujtkDZIsksBQkHJV1ZYJyZwHX/uAcjJVizkXDcHPa7Etcy5kPyI69XwdIPnhem0e6FJZf64tbTtLUI+rPh2O3YR12nsYPgwwOS7xEhOsncxTsppUZNww9YLT53TiXjYfVPPOWvpI+aHPPGFG14L5b4ardUbKLcZg3SRfAe1LEvaeTkckb+xDclX7dE9vmU9tLL1yI5y0up8gJvDk5tq6W69wuxgtY+zvMw2LwB46aadnkH9NqgJ3whmcmwTvvRDNXnQ50yoXcxit28WzChpG2gh0VDQMcVBW+tOWysgtN3sK+Q1EilgKook4O9kDUak3v0qdLZwpC1EO/mm3DooO25er/QcP/pX2bWunuGgp/7NGjHyqGxJxeTZF8iccQeZas3j+7egstrP4uuFX4yEnUzjr4gC1b2PVEu/KCh+5hnXdw+3a/+84JEUuxynOlZJLLnRcQnCF34akYrn+o+v+hVcSBDU6Ww9rihUDM3ycKK24e9WeQe6lXThYDY3JE1XLJ7A8rDEa9VhFGpB+sgJEcloPVBzaN9OF5D0tUABFS+5YJNrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?caBSERXhWOMdS0UKOp88VlgiKE/jtxdWAjjbvuOXequNEtqPszBWU3WtUP7Z?=
 =?us-ascii?Q?/+XO1U6hD+xOmPo0ebjbVPlaN6f2io5d2eJxh7SDAr7PfmTPIR8Wq/JLKm+W?=
 =?us-ascii?Q?HM2v/nMQ4SRQc0IEGShwVbLpobmXhafhlplsV8aDyIIcibKQL6IKhyN9zFE7?=
 =?us-ascii?Q?+Lyiw53Vf3Wb5cyL/hTc18Io2kVQVyz8APsgRh7ck8TDkf/s5olU8VPA06Ie?=
 =?us-ascii?Q?/5xnpBWsxuc/zH2XaSn+3bgkPoyO8t2BgpimSTLlkAIi1NlTghUghhbrzK3J?=
 =?us-ascii?Q?ReViXbVJzfJwMGl5BYEwXczisuJ1jRcNIWCVTr31Brx+AVX+fzKzOA52G/La?=
 =?us-ascii?Q?lWuEbEvHeJ45wdpr1cyR1sa0ajAVZQKQajiyPIxmy2eDvheyzsPF2efciCjl?=
 =?us-ascii?Q?K8l9zKbM5HKwKEDf0kCQgdvOp2ueDOckPGMT8GA6kpLJSItYf5S3fbi9w8bO?=
 =?us-ascii?Q?ZEr7MDzqcgyEUbNG6Bv0cfvrqLWX2eP5yP1JNqWOOWLPkHF0h7Mjd4GTKnQn?=
 =?us-ascii?Q?wqLpKgbsX3/hI0UfpwFU4Z6KgYD6D3XE4UH8c2QPUfbOgdo0NBLi/sr8Nxyj?=
 =?us-ascii?Q?flVFNJXggNin3e1uERZ9y8h2DiQ9hUn2Q/IkwssIdlDq4P6060apSSnqq9bl?=
 =?us-ascii?Q?EoY8TBAq0K/pcRfyorFAs71lt5wViO0CP3F4FV8XR3lIW8GjgzhHTtjZ4Mcn?=
 =?us-ascii?Q?IvbHKJC7p61NjvwvcGzxwe2NZ9+CaxG+eSizeoiSqYaSJsTnpKpwPEdQOZ6P?=
 =?us-ascii?Q?43QeXbIC5+pt4jx+4p0F8DswBlWpX1OQ9nvjHHAQaSg9bwYbTIGfqTca9K6A?=
 =?us-ascii?Q?s0gQtgfP7vRGhhLcPYOBvuRuq/Q8iudAlKziWjNfGCLyxiZsmQBgqBNBHjQc?=
 =?us-ascii?Q?koi1FTHz4MQne8cqsGEAHFqeUvbSrWSKp/KfvKgSgBrHoclvjUnwuFRaEK7c?=
 =?us-ascii?Q?2TyUu5KJLBlRh+AQt5hXGTFqRSZ7vadI0kpIDkjeiIusCBl80lAfX3pmCwgg?=
 =?us-ascii?Q?4IVtLr3M70mIRbcmaWvJI1FCjNJilAO48M9/85g47nWJGiRalN5xjWqcZtx1?=
 =?us-ascii?Q?X8gc+dsO9R1qMQyY3yqy9Pxq7ySdMlbwPNRIOqucGtGC4M27erJ6NVIb6+0r?=
 =?us-ascii?Q?1/67A3A592A2ir5uNUBDtdkojogJiSBNhQ1kRPm9vU4bTjMRWpqpXllB8xqu?=
 =?us-ascii?Q?8geQbd0lHmepooYWP38RTacCdr1qcEUuNhs8uueHETk8v6HLBsqT2NB0I4vJ?=
 =?us-ascii?Q?E+0uo7YSyRGVQkZTh3MHmMf5UNx8NPe2GqPnsJql2zj0CtPTJcNGpzFJOtP3?=
 =?us-ascii?Q?0j9Hnp+NO6pviW3+1khJdWVDo1Iv9hrXIZihzzTk00N5K7I9ovKve86DId2d?=
 =?us-ascii?Q?ZlxWM5B27Pyu7HLr0tCCdHa4Ptl4pBj+NWX0k3tpLrbFqBLIhKhSQ0Sz6unm?=
 =?us-ascii?Q?YVUTV8FyxJR6Hk6eE7YDlEtODdikMeorSc2CCx1OF4MBLQyF0g5jxT15UMBn?=
 =?us-ascii?Q?Np+yYZZsqEz8l3eGTyIcdomOl7kxWGAHNgwuFEfaEMzZdPFJ7IzVg2EncA/q?=
 =?us-ascii?Q?tomuJ1myREuX/1RDGP8p89ZB19V5UUf4KFZCU+Ltx/plc7403M+aJHIBKweL?=
 =?us-ascii?Q?VL7NrC3FbbeTf7sje4orFIc8Pz16P5YhV0JMiedomCGYgujBIPgMVmUDgmS4?=
 =?us-ascii?Q?jM+2JowGuxl8kOV5ghtWiH0x8OYt3PhOv4Z7WghFZJJIJe1KfduC6cFuz9vx?=
 =?us-ascii?Q?qHgtz1QBlseGTkDFEn6p7hv6JZ/6jtCPQBLgYkheX+7ITbrjij9LxF8oYVzS?=
x-ms-exchange-antispam-messagedata-1: Rf1L3PvQGuw0xg==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bDeSiINqhf11m/9yHwxL0UW3uKy4V3G4if37uevQvkEs58GLicmUwZZWZvz+IWruf2pZKzbJji1XbcqLKRC0PoOB3E6VQn+Dkeu+bVHyIR2t9o+yAAjgBH9hLAxk6Lt/7Yuh3HWcakRdEN/Hjek/jdxe2WWCjZCu8JxC5cZwlyytVzOZjUGfy7mtkwrtuTOzpziAGeSOSY6rS0srGQj2iREz7bidyNxeVCxGi15zhSTSdHuB91u5hLm78FT2VS3oTXqFvMBHkC1dj9ES50YjBPi+EXCjZ1ejWEVAyAoEAbfHzHM8h4iaTzjkfYiQQbxOv0dkRixU4pTrh8231bobwg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e8fade-d8d0-4865-1bca-08de807b4084
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:06:38.4645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdUS2vaucIgK+tYPLyxqOGBgpcSudRKbsR5LoVcv07JaAlUfY6612Tm3Ji/hOfKuernrBpXHv7f5lY4xA5eICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33160-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 609B6279CD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> > Se=
nt: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 04/15] wifi: cfg80211/mac80211: Add NL80=
211_IFTYPE_PD for PD PASN and PMSR operations

> Add a new wdev-only interface type NL80211_IFTYPE_PD to support Proximity=
 Detection (PD) operations such as PASN, key install and peer measurement o=
perations. This interface type operates without a netdev, similar to P2P_DE=
VICE and NAN interfaces.

What about PD discovery?

> The PD interface provides isolated functionality for PD PASN and PMSR wit=
hout affecting existing network operations.

So PMSR will be allowed on station interface (for sta to AP measurements, w=
hen possibly associated and have security context already), and on the new =
interface type for non-AP ranging?

> @@ -1935,6 +1938,7 @@ static void ieee80211_setup_sdata(struct ieee80211_=
sub_if_data *sdata,
>  		break;
>  	case NL80211_IFTYPE_AP_VLAN:
>  	case NL80211_IFTYPE_P2P_DEVICE:
> +	case NL80211_IFTYPE_PD:
>  		sdata->vif.bss_conf.bssid =3D sdata->vif.addr;
>  		break;
 =

bss_conf is irrelevant for PD interface =


> @@ -898,6 +898,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wir=
eless_dev *wdev,
>  		need_offchan =3D true;
>  		break;
>  	case NL80211_IFTYPE_NAN:
> +	case NL80211_IFTYPE_PD:
>  		break;

PD interface doesn't have a channel context, so set need_offchan =3D true?

> @@ -4621,6 +4621,7 @@ static bool ieee80211_accept_frame(struct ieee80211=
_rx_data *rx)
>  			(ieee80211_is_public_action(hdr, skb->len) ||
>  			 (ieee80211_is_auth(hdr->frame_control) &&
>  			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
> +	case NL80211_IFTYPE_PD:
> 	default:
> 		break;
 =

At least check addr1, and accept only auth frames (PASN) and if used for di=
scovery, also public action.

> @@ -13954,6 +13962,11 @@ static int nl80211_register_mgmt(struct sk_buff =
*skb, struct genl_info *info)
>  		      WIPHY_NAN_FLAGS_USERSPACE_DE))
> 			return -EOPNOTSUPP;
> 		break;
> +	case NL80211_IFTYPE_PD:
> +		if (!wiphy_ext_feature_isset(wdev->wiphy,
> +					     NL80211_EXT_FEATURE_SECURE_RTT))
> +			return -EOPNOTSUPP;
> +		break;

So not used for PD discovery, why?

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


