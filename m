Return-Path: <linux-wireless+bounces-2524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D551B83D49A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664AEB246BE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33017585;
	Fri, 26 Jan 2024 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qi0l2O05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2A849C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706251996; cv=fail; b=rIHn/4xo6B8xZoYhYIYIqm0HsyO4S+UAarOM97Fvqfp6E0WjaBCc3O4Jwk39d06Z97/w15LPzt0VSKhQpc9ZSjjp2/P24WGwjZZfIFmSyOHa7i959VhgNvICJKc7GlBI1rDF/BVrqPhnP9L1t3PQfEiWhdKKYmtSao62V6geCJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706251996; c=relaxed/simple;
	bh=jgXs9UhNW055ASdEu8AX+NuGmMLU3EbErNbC3ITrSuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q57YhlXH0asJrMCV66omWSITugEr1bQMEB361QelHTmVJeh3GEeX1QwrqAa1ZgF3eioJn0WlOoVMtmbJD1UfrBLJgIZ9mDwXYgUZzHhH8IgftHkRlsgaomBDwSQ0w3DLQ3K2OMRyPGpyHogzn9S5ccSPXf1H8zjBd4Td63ckAu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qi0l2O05; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706251995; x=1737787995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jgXs9UhNW055ASdEu8AX+NuGmMLU3EbErNbC3ITrSuQ=;
  b=Qi0l2O05JKuhFGSDHQAsvqJ0hir8ZglZGMbmNe8MzNR5ybTGF0BuVz47
   hcjL1Ty0/24PGO6wCqN7H56ISKaaT0BBCY6cJoXejNp5J6GVAjNVLr6Ly
   WzwB/nc8FjhV8gfWpwjx2/tSS2/CiBrvs+bBbUXxC465+GWoCiW0mJjlX
   l803TzZ6oDi+yqOrDh6a6YZxUsZFMTzxBwqX8osSZmb1WvXhWvdQz1o2V
   6yEyHCoydhqc/p+v1vEXcHkJftBOx5y8w9zz8rbKCbDRCnbEaKKa/ocz5
   3KS/sxgo/ZpbdWuU94s8LqS59r6REBFZeeD1cU5NaxZxpGHUOotYS+C/Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15930120"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15930120"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 22:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787023832"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="787023832"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 22:53:13 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 22:53:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 22:53:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 22:53:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akO+PPLPYp95Sg25vYLVutqFcPnDzQNbAN+V8RnPmdUEmQtTMw8Kli2QyRUygeosaAnOkHDLWfF2xwXWfPNYHQrUcBUpvqjsDSJ4NyK5SMjOFMguRjWRq9RCyDrtn5hOrFEtrTRJJdpemWONtYhZB+VSnIb2S9VXhkhaXhcsm2Z1RH2dOeaD7pUn7X9DSZAGqZU5WcMulMd5QX4yItnOZJVn77tleK8KdDkGIfVW1AJbV6Dvv310T7WORE9eKMMyN1AgyF6gJPatY+kwFfs+PuRGFfTEDvNWHr4FCo0n/w2kxgn+mv9VBnuYIES82Hpryirnz0/Lld2BKizUU7uWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgXs9UhNW055ASdEu8AX+NuGmMLU3EbErNbC3ITrSuQ=;
 b=YGYQqXoPv0p1urZ8H5T5C8+BmbganznnnRhBerPCN0NbKXUBCQb1cybcv9kjrlwuFM1LiGFJw6RDSniiXx9C8y2wD7WmNSVdzVVnCKAV+sbLl2mDX1Ts4ZsNiYesdeWSott/00FUIMd1T6LNjSuG91VotxiB/eb82KrCPar9gr67GapopLOHArFqRd+QN1Rk9KBqKtA7aIisfRgMHz/+IG0iarCpkMyth7TBI7bEfxsZiRS6yD4nnKMii0CxK7aQ/+l7U5R1yoicfCbL1oJFvrHsSdXKk23vhghYL2eKwOmuFF6gB9xixSP2dq6CwMCVVxtQiv2L7maM0tVB2U4NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 06:53:10 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 06:53:04 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi: warning: Excess struct member 'trans_len' description in
 'iwl_fw_dump_ptrs'
Thread-Topic: iwlwifi: warning: Excess struct member 'trans_len' description
 in 'iwl_fw_dump_ptrs'
Thread-Index: AQHaUCEW7AsecEvjRUqHi4oPExRSf7DrqBLg
Date: Fri, 26 Jan 2024 06:53:04 +0000
Message-ID: <MW5PR11MB581030AB1D5E5B9F6C0AE04CA3792@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <87il3gzjxj.fsf@kernel.org>
In-Reply-To: <87il3gzjxj.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH7PR11MB8550:EE_
x-ms-office365-filtering-correlation-id: b9ed40b2-a444-4658-5eef-08dc1e3b724a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kjFqkKsAujT6OYfGms1NIdvyFVUc3VGspIcxFASgdUlVXDUG+qnB5Mf6jFyrxYxa2oVUIGrcsMjM1MVjxNd+3dLZCpgo/gBxweybhumsbTn4hkDwKl9/tmpdWT1YBDDSr9OPDvlKaid4t2EDL6jp799mlLPcwvz/gjYkxYU+L/SQQGRg2i07lpPafn/YPUrf4WSNzlmwUjgS9IcqVjv35cceQYqcVOqEGgNtl3qnqkbwhmzWju/1LV4VyC5kQfKo60qWG20VpgOGw1Sw+WaAfJXYS2ythZeQH4033auQkmqenhLJaNYHXJm7nmfNtnllAmaYSBZbS3Sp18jDOL9WG6ECHN7l2DSUn8cIbzbFamSmJqltKkTXxX463n5RiPRdgboZ9H7dnsWlw8y/EQye0D68n+axiWVcDkwTPAB8HMi0CkZPp6eMLFBH/jPCU6p2NvkCiaJLgaRhG+hLy4lAjk7OcjukCnA4WLMICclLLpl9CmNigWHsrbEXn/dZeUj37iBFFeIE7XpzRaVm7X3SS1H5rrwLbpM23+Sfssq+fN80kLqnfTH1ur3gRFR5uILd/SqloSJU9ABqcs/nl5vxjIhW+bZA4PApHmX86T7bATWgtENQjP2wXn0YNku9wksBk2w1k5mhm/2UUq5SKkbkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(33656002)(41300700001)(4744005)(86362001)(478600001)(966005)(2906002)(52536014)(4326008)(8936002)(8676002)(66556008)(5660300002)(54906003)(66446008)(64756008)(76116006)(66946007)(66476007)(6916009)(316002)(122000001)(26005)(83380400001)(82960400001)(38070700009)(9686003)(71200400001)(6506007)(53546011)(7696005)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qj17iPlML9BDpsWcjKav001ZejmafzjV4Nk7jDEwtkI7cur1UimuMEoENUP4?=
 =?us-ascii?Q?JK8Tpv478Cn4MhywZXVSkTqaJabzaFDj0mDNWgVYijBc1wl0El7PS7apzT9J?=
 =?us-ascii?Q?qi17wdHiv0mXgBS2L7bpIuQq12SD2sS99kIAb2fGJRitUXKGhkvr1B9pZB5H?=
 =?us-ascii?Q?fA3jid8BHkHzO+fi0U8rt4Qc1DuvlMgQOIboZ8pQy1JaLheSyND3KDvD9kP7?=
 =?us-ascii?Q?R/8xeJOjHDP1C+pKG6xL/vsc2e6ri2PCDPb8OwDQtqFlxtiPorLMide1BpxZ?=
 =?us-ascii?Q?Hs3Oird2QI5SC2NFvbl711jU97oC+WPAqo+odhHFXrCiULJssHGFB4imnhQt?=
 =?us-ascii?Q?qsHonzyLVkcOf8Kds7i2wt4Usgf+lx2fsPrsMST2oS7gfyyG/RgIeu+sSxJP?=
 =?us-ascii?Q?mQ4m/zjEATs/DZbLhCSsqL9iode/Q9mtEv9tbsCC8vcuXnaOUyYv+M05Ka1o?=
 =?us-ascii?Q?ALJegQDceVBCpN4Sp41c+js0ngwn+LPxDxKU3mipLGYfgCYk4MX7jHrvufhM?=
 =?us-ascii?Q?UzVfR9RJHTgq+tOASXDMN3VBavIPSTSMAXIDNpuxlejYZlVrdqeoZdDpWhC6?=
 =?us-ascii?Q?S7rfGhoXzfQySFrbWgZoy9+myqc4QnDviAqSviHw4IOi4REOXv9JBQjlGHSH?=
 =?us-ascii?Q?npj9VjJ7iLZtQqXq8OlibO9fGH+bZB9keZer742vVycd7cd4dmx1lLA08UbH?=
 =?us-ascii?Q?bL8L3yJa/yZmqDpnGBh+W/+UlARa9vIuHUwBSU6J1kKdLQFP6uodaW6awYjX?=
 =?us-ascii?Q?6ncyXDos+EIKUraPovYxkRgbDmQNPE0I8/RkMqloDYFxI0h0z9BUj4WMcY3O?=
 =?us-ascii?Q?aLIa/nT067JhLNIhH2pawcg7JKd/ZUV9sfYd2RqZkPDnjjrKrjP/re1jvgTD?=
 =?us-ascii?Q?e2AQsKWYnKFVUm1ec3sGi5n0TuQaGLHaUmGm/wrTNCmTT9+QPRe5kr040tyg?=
 =?us-ascii?Q?QxBSda2BLYH7rQ5MG/4xVVA4fwIC6lyklX/W0ijH0Vs4K67gCitSdC8cf7IA?=
 =?us-ascii?Q?UZHTeYd931jcX3emLMx9Vbg5pH25uJ7+HzWHKXDghcGH+40EgHoBBexNbTW3?=
 =?us-ascii?Q?xVuOC44AH8h+XCfnv8GYpdmK0ji3Q8yCnkcdBJfFB/Roaj+s/meCVt2K9usJ?=
 =?us-ascii?Q?a4Z0kl5xNl0rrdbKuIXBxegC8K0dqHwi/hxk4YKTQxmqAJjwnEL0HdRjkQom?=
 =?us-ascii?Q?uB/cYf6BXlaHu9SJ1n+IXWY6PALZuZ9X2B0vTvY3NTQV48OP4nzOWlPHbd7R?=
 =?us-ascii?Q?K1VYlrZ4ntNlha4JiPpBLF6yxCyyIaNOEBO9TveHHVWUpODYa8o9Cl/ooOZ1?=
 =?us-ascii?Q?KR+s3Vknb6wMF4dBBIPzMKWH+fq3lqohbUlHuySJoDNCw/20hYuKxSIo6BLY?=
 =?us-ascii?Q?ol5lxnbmKbOMrqucV8HD3xMEs1wVW6lW3syE2X194+D4l9UvSlzJxola0jm+?=
 =?us-ascii?Q?3Np92r3b8j/wKaHw8fx509LHtrDt1Qfqt+KGNjAXnXntnjprtYxfzxjeCs15?=
 =?us-ascii?Q?7vkSW9M/YDwn820IQIVlKWPdZHNWCQUHf7k1fz6JBj0papsjAN+4oSKymtsl?=
 =?us-ascii?Q?0HnPFFvq9o1j237Q9OK5buKp/1xmaGWF571YBYVoO5UANv8lD5IZDB6qny/B?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ed40b2-a444-4658-5eef-08dc1e3b724a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 06:53:04.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9x9pP6Ug69vXCD63WMQ4PToeYTCXtjbbw1LrjqCT+2+otx4hkV7RuReiSn5sYQ4mKeu5w9mC72hs88R/+Vy7eWPt6O0ZnW+wRB0y/Q84LZPm3dT90rOwKW0aXo/mP74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, January 26, 2024 08:30
> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel=
.org
> Subject: iwlwifi: warning: Excess struct member 'trans_len' description i=
n
> 'iwl_fw_dump_ptrs'
>=20
> Hi Miri,
>=20
> I noticed a new warning in wireless tree:
>=20
> drivers/net/wireless/intel/iwlwifi/fw/dbg.c:29: warning: Excess struct me=
mber
> 'trans_len' description in 'iwl_fw_dump_ptrs'
>=20
> I don't know what commit caused it but can you fix it, please?
>=20
Of course
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es

