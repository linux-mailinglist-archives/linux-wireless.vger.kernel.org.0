Return-Path: <linux-wireless+bounces-33773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHAEIeKBwmlneQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 13:21:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244730819C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 13:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B10AC30008BB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A8A3D75AC;
	Tue, 24 Mar 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kShYhRZm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470B37107C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354241; cv=fail; b=lx4Q6st6izu2nx0+aWns6we0yqzE4dMhjzodCMA8zGFO1trRwHYSXOhnrzqDSiQBHMW8r7N7DOb0t28RZ5r5opPEy0MLTOnCaX36uZBpGyfxpUnH3EQyQzWKtvHPeMqt56ffniSsdlXWBID3f0RsTic8AN9WV42lZlf2Ut448Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354241; c=relaxed/simple;
	bh=5jQCYLeefrqb/L+aGpnwKQf0wSfJtpeOqWOmtarw/Bo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LfSZAxraH8jB8RyL86/zIl2AecUDkJYek8g3kc1hQXc9Had0W77Ec/EnUEdpnHgvjH0qhHzVgGiRLf4qSpKETXub3PQN+KHOoNKArjqT2hk74aw8GbIaLHsyYKdBol6ZcLwhzVNlZVb9uunSnhwIFwKjTBwW3AT5xtF0QWwl7mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kShYhRZm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774354239; x=1805890239;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5jQCYLeefrqb/L+aGpnwKQf0wSfJtpeOqWOmtarw/Bo=;
  b=kShYhRZmXYZRLXU0X1JY+ApY3uCSvBGV95MKbRV8Gt4A0l3MtVgP7Xdh
   ZESNHeko/zic73u5uog5AOaumL9uh5pST2ntqclDjSFgUgNE+EdwztKLP
   LitBVIaspDihXqzrARNg7gz0EU/uvO3Z/GnIt/+w2aVQDwQlvhsgMF5mf
   fDJEbuMZHHFn4cLubsH+c4at0p8C0FvqTac77ju2pALsz6gK2vaEESdy6
   WtbzcyXENqyQCmZzYqzRgfEX0WhsUlNr/lfpyQi+37vbgrq9jkvpXcivf
   9Talg1IBe1H6gzkJC6ruWqzTtpIZIUvhgyxGWJjTkuLxb1ZA4VzKIZtbb
   w==;
X-CSE-ConnectionGUID: 9Eam/bUsRo2UuWR+sDaZqQ==
X-CSE-MsgGUID: 1B6BJAOtSg6hE65sJgqnCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92746252"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="92746252"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:10:38 -0700
X-CSE-ConnectionGUID: iLNP8rp4SB2cwEoQO3zwOA==
X-CSE-MsgGUID: UAydH32kRkq2/21tKjEfXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247413061"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:10:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 05:10:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 05:10:37 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 05:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrSXzWjCRDsZRiKbyKaLGpJtrZCHlRFmQzT0TsHfvy7KyYl+jwk271OfxDFdhM1olbH9wJcv8Z529O0AN8KhnsALxKRk5UfIkpO00VVwLCxiqptIH+t13VCk+DGwmw3dqhPPbsGRTju4HscXm45Z9xU7qvByB+8AI9fCO7BMM7NNNDsSYZgkvh96ifbl7E9omReZkuAkaanxXjSXgEObhse/32H4WpyeTyfpftFGzQGxymdyaqfwDZ3GQbwSQGm4nrg0cXcXVyxxHckv+DPiCxtb375hhDf5K6gm2yjHsqNj/y2rh5//mddWkNkexhQXXOsk1aMZSJ89S6p/9KP06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jQCYLeefrqb/L+aGpnwKQf0wSfJtpeOqWOmtarw/Bo=;
 b=fiVCoCP0hkzrMSDoS5ZfDK/0U9/9/wUtPqMtlXRebuSw+snwfTQk1lIRJa95JExxtta/KLAeaF9PemL+M/FbYl/kIfWEd3sQ3m+jWvKodQbnfHkmHCzDsPDABtMlyRYrf8iB9pRSRXs0PXl232zSwPE5QKVSxX1HvqvC4PTnhbDb7IzWCbnES9IHwn9pDFv4jO+re8b49P0QZYcD/3iAKsAMBj6ecfKA/C1B4gUMK6D1H+fgx9XBCWXNGfaBBo2z02lkECZE0Dj5MZlUd2Y2kG/i1pQX0DbqZXOg541/rvvvcmUeGHUDb9QANy6ZtoWoJF3ch9lcomp44QjA+DY9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS0PR11MB7460.namprd11.prod.outlook.com
 (2603:10b6:8:142::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:10:30 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Tue, 24 Mar 2026
 12:10:29 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2026-03-24
Thread-Topic: pull-request: iwlwifi-fixes-2026-03-24
Thread-Index: Ady7hwhnE9auMyG8QDK7a2MMDyqZIw==
Date: Tue, 24 Mar 2026 12:10:29 +0000
Message-ID: <DM3PPF63A6024A95EE7442D8001AFD7B2EFA348A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS0PR11MB7460:EE_
x-ms-office365-filtering-correlation-id: 4484dcc7-3056-49c5-927b-08de899e5786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: gfTWkK+ptWE3lly82J4TRDIN99USAyvw1WawruvdtdpjmgL+jBZWfC6Zo2boRfjG85nxSkWZzUG7RWm2CedUTOPnEEDqbU/yazIPsV7xVy++AUBCBDaZTli0EKovXjt3h7d2Gw4SxJ7qCJxYpOER6HB4LJsJfg9R1Sgkgq++1p64/PGJ/2WhyYUNgxOjdYcs0uy0Y4BzdifE7zAgo6QRDj2lKh9J12cnklyGIrNbhyGf8OqItorfS/T3R5AULDakZymDJQ0cbo79IapvHm+LMd9i3SRyzPZpca7nEA/xaKl29SlAxX1A848NTU9kbu9oaGSAe9Kk1eFfEGmWjnb8NxXxJLhTrbsJCJwDhBuXER//FeA5va+YB9Hqk1ZvfFjo1hcgN60jYJJgIEW5p9H7gm8LscvrcH7UVZuYRizmjCc0b9xtfc06xzeC8WZm2q2NBcFlQLv/Upj/agVsj4M2CumlSlDKJK/MY001suj6mvdzOP2wj+tXIvmtz0RP7gYMVGuafa/D+e/b8hDrAyDiT0T6MI+KI+at9LwD9dgOFG25QhuP8fXz3mnUgcqQruCDnpneIYJdTDgGdJGJ7Xj0zk/yHMczLtWQjytbKjgKpFtCS3JbC94QuCbwl2Vbekt1UZwTjvydB6or/Xk+glOKuVJ/eUL/ELgGSzliEhvxk0K6t9RWBLen7B3msTgiLTJ6uhW+16sJOXRRoJ/Hsvrt0hhZbBU/PCFAa2NwEV8wZatUKqxpS5rwfut/Lzo3cdet1kEI+peXkyWFxl7bzSKScsQneWfZI+Rc9R01ObIx6fs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHZrUGRkMjNxWU92eENtT3ozcEFhUXRMcGV5dlFsd2IvUWxuZlBVcXZySVVF?=
 =?utf-8?B?TXIrWW9LaDRhZ3dqZGdianVwVXh3NXJiMXhWeGRJaHZaZURMSE1tRjB5L3NH?=
 =?utf-8?B?S1NVRU9vRFBPT0Y3SGc4ajV5d2ZFa2M1Qmlhcmc4aWs4SHdLb1pZR1IrY2Zr?=
 =?utf-8?B?enJtdTdVaFJOa2VRMVBrUFBudHlLek1nckh5K2ZyMm5IVFVmdE5XNkdJSmw0?=
 =?utf-8?B?UERJbklTTHNFQ1VvSk1jVXV3TENJUnducFViYWRkTk4za1EvbDcrdUVseEwv?=
 =?utf-8?B?Sy9tcWJZVUZEdjI3eUlKTWNMdFpBZDNtZG1pS1dGai9XYjVRNnJKaTJLaFpq?=
 =?utf-8?B?VkR5aXVpZlJFYUNoWlZkc3RZUmxXUVVIM0RmVElmWUZMbDlZU0lCS2JBdXJ1?=
 =?utf-8?B?ZWk1VkIyUFIvd2RkQ0RobUxGM3VGMGNZbjhIL0JPL00rd1lmN2toNUFKblVh?=
 =?utf-8?B?aTJpMWxQUUFLTkVZdUF2ZWNsUHNsTDhuYnJ5WEFVcElJNmoyTVFIOWlHN2Rx?=
 =?utf-8?B?cTFiWXJVTHB2dU53OXVWcXBFcFBSOXA0SHV3aU10ZFBldk5wcFE0Q2ltZk9H?=
 =?utf-8?B?Nkc0NlJiN3pydnJiUmV5bDA1K0Y4aW5kd254eXhBalpVeEcvL1dmYkFtQlIy?=
 =?utf-8?B?cEFuYlJyZXZveUFkMitMaXcwZXRpWU4yUk56SWxYcmxHREFMNDZ1bmhjOEtM?=
 =?utf-8?B?Zm1XVFdVN1hmV1FBdmdGWkRlUmNjZ201UUhBY1B4QXJ0b3owYXFVQnZaWm5V?=
 =?utf-8?B?MEVUMUptR25vRkxIeWRsdG9tZDV0d1lnWG1PNHhEalIrZzhJNC9sYjN4WHNV?=
 =?utf-8?B?QTVmazR0QklMaEpMVUR6NU0wcGdlWDJHQ2Z6SUI5a2lZRWJJTmN3ekhJTmZq?=
 =?utf-8?B?REp4cEYvSU9lakZuM3VaaWdQa3dWQTkxaWJJakVwTy8zVWZEaVIxdG9rdFZQ?=
 =?utf-8?B?dXJaVXkxdHJNcGc0aFZva2ZHcUw3TlhFcXdtanRDNUY0T211c0pIVXo0VGIy?=
 =?utf-8?B?K1JCbGdNc2F6eUk3c2dpU1dpZWMzQ3BuQlpkQ1JDemo5OVloV0NsTE9wZ1oy?=
 =?utf-8?B?MWFGM1JWOS8yYTZ6c2JNd3hLL21YRWVuQkIxTzZ4VkozdkYwWEd4M3hiVDZ3?=
 =?utf-8?B?NnpvME9zVVJieEp3Z3pqNXBJYXh0UkJ1ZWVlZE90M1ZJbXhEcS9aTUtLcEgy?=
 =?utf-8?B?SkZ5UFBxVHFCV1VORVdYSExWZ3Z1VlhydGM4TWZrZ1EzbWR2VTZIZEpERXZT?=
 =?utf-8?B?MUxSY1NvOVNlN1J1OTlOY1lFbWczekpwamFpOXcxSkRURU9xc0s4dDh6TmxP?=
 =?utf-8?B?QjZLNjlxTUNxc0wxQlhUblZNYjhUK0FOaDRzekpiVmQzWHRVOGVMVktIMzdB?=
 =?utf-8?B?R1dNMDVCaENJeXVRclphQ2toS1NJRFQyWElqcGczODZIdE55TkRuOTIzV3ZB?=
 =?utf-8?B?ZFQySk1EV3RCaEw4Q2xFVUpNZDY4STBRQzJFRTdQbk54VGIxSXE4SjFPeUpS?=
 =?utf-8?B?bXY5YVVPNFhsZnBaaHlFajQ3OE11djZUdkxuYW45cmZmUnRGdzlXQnB2N0Zr?=
 =?utf-8?B?YUtab0xPd2JndGg1b1VJZURXSlREVWF3eUhodUhTYmRwSy9OZElNZFhzSDBO?=
 =?utf-8?B?NkFkeGhSdDRNQ29xbE5Hdm54YXo0d1J5ZGs3VnluZS9pOUR4bUJiZCt5TExh?=
 =?utf-8?B?SVc3ZmxYSEdRNExqSkNHWmJra3lDUmJ1Ui9ac0FQNklncFhUUlZ6dmR2b3hQ?=
 =?utf-8?B?R0R0Wm84bUNiTDQwblJRbVZaRUMyRUNreEI5cmZKZVkwTEk4LzcyVExBMTA5?=
 =?utf-8?B?QktVVzFBdnFmektDYzI3SkJPT3k1YXk4T2NhU09vRkdraTVra3p6cEhYakVG?=
 =?utf-8?B?OTNaVUFOdENYN2IxYTQ2a2p2NGpReXRFRDJEaHpFSFFqWDUxVk9VUWloU05s?=
 =?utf-8?B?MjB6UXpQeXVlNFJ3ZW1lbzJtUUVMUXlLSUhqcGJlWjJuNEtwbE5ZVlMwWkRa?=
 =?utf-8?B?cWl4Ty9pVG5ONFlTNit6YWhaa2pnYUtqSmN6Z3BxN3NIMjQ2STJyOHNWYXIx?=
 =?utf-8?B?QXNVT0NWZzFSYkNrLytsaUhCQWlqU2dzVVdlUy9NYlVLTk5xOUVsUFoyRVFU?=
 =?utf-8?B?L3lSMHJOMVFaRklaMXNmbk9MYit3RW5kRmFyU0ltcDd3cVFVWlY3K3hMdEg5?=
 =?utf-8?B?clFYTzlMMkkrRHBMZThJMThRMHpvK0d4OG93VzdvOEc5ZUdRVUZYejRUSGkv?=
 =?utf-8?B?U3RoUGJzNG1NTllIbXRSRUFIUW5PaitkSHMyUEdwdXdMWkZvYzIraEhnS2c3?=
 =?utf-8?B?WkRCeXY3S0ZGYW9wWjI3a1ZoTkJNRnpSL3c0ZTN3RVdST2NEaU52WmtBTFhU?=
 =?utf-8?Q?lBf+WxwupGB8mY/Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uKU+2hP6Bx5H2e7Ka/992hrFIUkTEBOKEy5uzJOmXUHfypS/KheGNEdbHtnT1uQzjP3+78p/cAXDkd5vIGhr0v8fbTZ7XN65SABMvQKDTZkTMMbepGPL3is2UEEAwTz56RFZLhfNNHNdhrjtnrsaCJ783zT8aEu9ZZM+AtRqzqIwbTOy36SbgbYBWcjYMyfZ4B+TTSCxfwQGT3dN0XopLSjuEkcGx3MlsEoGxlIRPzXwxG+idmIlYd4AvgoGagdGqHmZGUVgXhvMCfSCp5V16pwlMiYrhkglhydQHAC0dDk/yGUd9xd9kV3EJrGpLliO5PKsiZGwDBChOy7M8qMSdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484dcc7-3056-49c5-927b-08de899e5786
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 12:10:29.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30CAVdA5GdTElNuGm11mxwXkgb7HLGM6zHSw2Cx1kBBaopuuNtns9CK1s3BI/avCVp6nZTVEqSqLxEeeeriVhysXefcgDwYxL9gDibhycFQt8oQg8JcdLe9sN4NGsxXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33773-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9244730819C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhMWQ5ZDhlODMzNzgxYzQ0YWI2ODg3
MDg4MDRjZTM1ZjIwZjNjYmJkOg0KDQogIE1lcmdlIHRhZyAnbmV0LTcuMC1yYzUnIG9mIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0ICgyMDI2
LTAzLTE5IDExOjI1OjQwIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9pd2x3aWZpL2l3bHdpZmktbmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1maXhlcy0yMDI2LTAz
LTI0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA2ODdhOTVkMjA0ZTcyZTUyZjJl
NmJjN2E5OTRjYzgyZjc2YjI2NzhmOg0KDQogIHdpZmk6IGl3bHdpZmk6IG1sZDogY29ycmVjdGx5
IHNldCB3aWZpIGdlbmVyYXRpb24gZGF0YSAoMjAyNi0wMy0yNCAxMzo1NTo1MyArMDIwMCkNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0Kd2lmaTogaXdsd2lmaTogZml4ZXMgLSAyMDI2LTAzLTI0DQoNCi0gRml4IE1MTyBz
Y2FuIHRpbWluZyAocmVjb3JkIHRoZSBzY2FuIHN0YXJ0IGluIEZXKQ0KLSBkb24ndCBzZW5kIGEg
NkUgcmVsYXRlZCBjb21tYW5kIHdoZW4gbm90IHN1cHBvcnRlZA0KLSBjb3JyZWN0bHkgc2V0IHdp
ZmkgZ2VuZXJhdGlvbiBkYXRhDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkVtbWFudWVsIEdydW1iYWNoICgxKToNCiAg
ICAgIHdpZmk6IGl3bHdpZmk6IG12bTogZG9uJ3Qgc2VuZCBhIDZFIHJlbGF0ZWQgY29tbWFuZCB3
aGVuIG5vdCBzdXBwb3J0ZWQNCg0KSm9oYW5uZXMgQmVyZyAoMSk6DQogICAgICB3aWZpOiBpd2x3
aWZpOiBtbGQ6IGNvcnJlY3RseSBzZXQgd2lmaSBnZW5lcmF0aW9uIGRhdGENCg0KUGFnYWRhbGEg
WWVzdSBBbmphbmV5dWx1ICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogRml4IE1MTyBz
Y2FuIHRpbWluZw0KDQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9jb21t
YW5kcy5oICAgfCAgIDUgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
YXBpL3NjYW4uaCAgIHwgIDEwICsrDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tbGQvaWZhY2UuYyAgICAgfCAxMDEgKysrKysrKysrKysrKystLS0tLS0tDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYyAgfCAgMTkgKysrKw0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sZC5jICAgICAgIHwgICAxICsN
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbG8uYyAgICAgICB8ICAg
NCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL25vdGlmLmMgICAg
IHwgICA1ICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9zY2FuLmMg
ICAgICB8ICAzMCArKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21s
ZC9zY2FuLmggICAgICB8ICAgOSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL2Z3LmMgICAgICAgIHwgICAzICstDQogMTAgZmlsZXMgY2hhbmdlZCwgMTQ2IGluc2Vy
dGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0K

