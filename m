Return-Path: <linux-wireless+bounces-24319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD8AE3216
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC37188DE73
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103371E9B0B;
	Sun, 22 Jun 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrQDuYL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE87263C;
	Sun, 22 Jun 2025 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625590; cv=fail; b=emqcEp7inO4ADxXxoM9DT2Crl7aSXgAeO05ZaveJZMKZdLosap2fzl05zIriHgEgoS0EseE6Pu+w0gT4e5a4ISYZg/cDnoQYZliKJ/ZcH/KU2Y7bo/UcetHlsfJz1Oq3or5pL6/uWvjoaaTBxslbZ/81LRszy05ixPOrxs8JNF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625590; c=relaxed/simple;
	bh=E+zb4sUbu1hC01SgCBZ5S53eIqdhyKKdm/gOUOTtzYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MPuHctw8sWjhU5DSMIXUB3bKEOMxxirtpT2WZ5XkAwrRzWCflGL/omUFjmsuCaYzx2Rpru2tn0sXdEMs1O/iWE9ty0H1vnUnZw/0Q1LOQXZzaFfpP3vt7hLtz7SqkcD2GgyS4wJN09UpsBM/53dCL6XU0ZHjgA1e0P5hZvkiyFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrQDuYL4; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750625589; x=1782161589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=E+zb4sUbu1hC01SgCBZ5S53eIqdhyKKdm/gOUOTtzYo=;
  b=CrQDuYL43HRy35tDUxK6ptoTqV70ctMaK7AZr1so55tJ/2NJyaLSqVpK
   jNnJ488kwWNpoWkUxQE4nsHnA7GQoifX6ynijEI8uvGQd/UllDia2sFcD
   tRNR6ADAv855grJkFwxZ+49xz4vflsmAEAZHi3tT50I3i41AVxXdAheOz
   xen2CzdYCPW8sB5CS5Xr0qR5RloDJv+IUGnLbHWnUYbFLiTw2LBujIlSn
   tNNmYb0WIGQPuPXvtS0X7fpyb8Qp/FlqZjC48DLevdZYH44Npjtk1XktP
   oQ/SZch9dXnzovxhxKfI+lhBvvkxmsvuboiNpQFWxQ3r7Qbe5NyFIraPQ
   Q==;
X-CSE-ConnectionGUID: uKbhcedjQImTGjVHv4+5tg==
X-CSE-MsgGUID: d5SrhcYPS2eE0rwPbnTW5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52542534"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208,223";a="52542534"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 13:53:08 -0700
X-CSE-ConnectionGUID: 4orxn0aVTzu2jC8dqLpcKA==
X-CSE-MsgGUID: e13fi5HGSC6LVopaJaECGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208,223";a="151551926"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 13:53:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 13:53:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 13:53:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 13:53:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZeQvIUa1lXDx9Ocs/LVnZjUqs/Pd3ACimLPBG30RPSsnz1p5HA8Dz5P9TshyTHZY74lWToCeydiZST7F8lpGKxXKa4iZodx4UHnhCyCWRw458vbLz2BltY18DlIbfmRx5w1wOAoD51dNu2VjFs1tW0R3dlWou/GUIJuLVdFh6OYvlJg3VFN65ZK23vkHer0mt7TKtby34bOKrknqmMDODIlUbo1lkplgtk0nuJajk24ISx0KWlOvhJ5CQKjf1OXy5gVtuXDwSE6c72R42gUjka2EaOXZ4wi5F9cNejJD9yr6A6fqHsMfvVYgydKCBF45glzjTo8+sqQpBSW93YgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nmi92ACQ61ScegL5LxDsyWNQdgCSWd/pAWArfZ3CHaw=;
 b=WC3zvahSjHsEZbKbsuQmRY3WfxTOmADGX8vP1KGVgwfel+TTzbt7BOebl1g5OK1pD8hb1k16wCJtgaOz3vqfXeH1ab8opdWblxBWH+Rm4W0tQ3y+7XYyoB48znoSXMoff3IG8tj1993UnY04F0mNXz+oebdv64UfHQ6oCJh5bELyczgQxo+EVt1HGFQ+zrc7tc8CUSDgflpHavV8m5AOaSx+e8IjVUeDlkOqO8Tusi4/sUhGUt+N6SetKeq4AcZrNd1VXjJIeczpRoxUFb6gMqbun2/ZthSqftzPl7H8tMzoTuHz8L/H3W1EJ5Wv7qoRlHu9gyVFy/z7mFurkUdJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA1PR11MB7175.namprd11.prod.outlook.com
 (2603:10b6:208:419::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Sun, 22 Jun
 2025 20:52:37 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8835.027; Sun, 22 Jun 2025
 20:52:37 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Damian Tometzki <damian@riscv-rocks.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: wlwifi AX201: WARN_ON in iwl_mvm_mld_mac_ctxt_cmd_common repeated
 UMAC FW crashes on 6.16-rc2
Thread-Topic: wlwifi AX201: WARN_ON in iwl_mvm_mld_mac_ctxt_cmd_common
 repeated UMAC FW crashes on 6.16-rc2
Thread-Index: AQHb464+XlvO2cQaC0asQs5rNKi6/rQPpyww
Date: Sun, 22 Jun 2025 20:52:37 +0000
Message-ID: <DM3PPF63A6024A9D829CDC0DFA239FE0885A37EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <aFgvmhSbup2BnUHu@fedora>
 <CAL=B37mqrHOzEQzPX3=6S5XaUZexYRUXNBgUuGsiX6+4iHWO8g@mail.gmail.com>
In-Reply-To: <CAL=B37mqrHOzEQzPX3=6S5XaUZexYRUXNBgUuGsiX6+4iHWO8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA1PR11MB7175:EE_
x-ms-office365-filtering-correlation-id: c4101a9f-5ed2-4538-7a31-08ddb1ceb875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEtUSWR0R3lHRElHOWhmL0FWVkxFRVc0aGd6NGNINE5JQ3ZGSm5NRW42NGZ2?=
 =?utf-8?B?QWxINFB5Rk9LSUZnSzVIVjlRMUxNdm1EYUxOTjhva0pYUmVFTjNmcVZCZzNP?=
 =?utf-8?B?M29kS0R4ZkQ5VExTeWUrN21qNytaOTlHR0ozRzNYc2h0Q2ZFMC8yMlJtOHZm?=
 =?utf-8?B?a1VzU1ZwTGJrYlFVeDg4QmZ5cmo2OVVhMnEwYmdCRFVwcWpSL3N5dXhzQjJi?=
 =?utf-8?B?bzZONSsxMzVFMWdwckJ4Mjk4dXpkL2ZQWlNZdXRJNU53TGdJdkc3dzNUSHFJ?=
 =?utf-8?B?MGJYWmpvZlE3a0xsenJydlVqL1dyOWM4YXZjbmhLbEVhS3ZlTDBhZlRpM3Vm?=
 =?utf-8?B?WHh0eXJaMGlUTFdRaTNxS3pOZ2xXRThLM0lkMWMranFnelRVbWloSEswOXZ1?=
 =?utf-8?B?Q3FITEYzc3dpNVVyK1BuR2hnM3l2RmxUK3RyUTFJQ2l4NjZ0OHZOZFhtdkh3?=
 =?utf-8?B?SnlhRmQvalk2ZUlyd0pDOEF0V2xxQWJaWm5YYmlhbDNVaGg3Q1RjWURYM1Rm?=
 =?utf-8?B?MUxwbWJ6VWVDUmxmbkpWQ0hvZjQrcWRRcTJWTjlyTTJDSlp0MHp6WnlGSnY0?=
 =?utf-8?B?djViOWpEaEdhQ3Rrd3EzY21zeWp5VUdBQzl2VjhvMFVaVnNvKzQxUC9zRWVS?=
 =?utf-8?B?OGVKSUdmakcwdUpTNkhTVVdJTWZ2YU9FYlNYZ1hrV2lndzNtTjFIdlBrK0VO?=
 =?utf-8?B?M1pBd1IyUUNaMElhNUtLelBJa2dJQlZQYkVaQ3BkZVJ3WTczR1FlYzBUdUNs?=
 =?utf-8?B?aGpBM0J1SnNxMXhoQVRHMnJGWUdRd0czbStEeEc0N3hycS9MYmNhNFBnbk1S?=
 =?utf-8?B?eVkvVUh4VDUvbjFSUmtBNHFCdmhwN3NtczU0cFJnK1hsR0x3Q3FRc0lJdVRF?=
 =?utf-8?B?cThBOFVBeVZNZTRZOTJXNWtwbFZjWXBzSWVnVWtFNXpYdWRtMjdRR0htODNY?=
 =?utf-8?B?U2drUER0dGU0cXpVbHpyNTB6bmVMSDR6YmRRQXRtaDNmUDlTMmtQMzI5T2gz?=
 =?utf-8?B?UFNxVFpGN2kyZXIwNm1USXVqeVFDdmpJSUVjRWc3QVFEcWIxeWNlem9IUTFW?=
 =?utf-8?B?bmNqNVY5L2ttckR3bVhvalpBcVh5YXE5b2Y2b2xIaU1BVkkxejNhTlVKb1BF?=
 =?utf-8?B?L25uRVNTMkMyZGNkR21DbE54Q2Q3T3lFTnFrYUlYaDdFSmpneHhnTzNCbmVm?=
 =?utf-8?B?eFVNTGNUZ2czSVlEeDU3Mm56MlhIYUkwZDV0R01BSVAxWU5pMmVPOXhwV0lr?=
 =?utf-8?B?SmppZU9ualh5VzBzMEd2ZXB2VTFudElWVVo0bUdQUzVWVEk4VStaSWpKcEFx?=
 =?utf-8?B?TnNqUjBmb2sxdG40MzVLUlNzME1iUlUvSFZzYk1yMTcvWHQzY0VIdXFTVERl?=
 =?utf-8?B?MzRQTTBnVjN0RlZyYjA3RGFRNlNxaS9PeHZucTZrL2tPMk1IaUtNWFhWY1BN?=
 =?utf-8?B?OEozZkRyb1JDYkZlR0N1SG10MUV1Y3g4TFU4WEJyeEhtaTZjZkVFSlpEQ0RM?=
 =?utf-8?B?WkRyZXBaSE95VXkzWFFLdkhsRkZMalUrVk43TG1uV1FXNktDODI3WERpU2x2?=
 =?utf-8?B?OHF1VHZEenVvOEdrbldEdzBBbnFSWFhRU0hud0xOY3VOd25QdXdqVVF2V2hx?=
 =?utf-8?B?SjBJRUR2aXU3QVl1Ym1UNVoxcEVGaS9nSk1pTUtGUGFlN0xNTjFJTEV5YWhm?=
 =?utf-8?B?K3BZUHYzbnlJM1BSSTJaS3VRSU5KUmxwM1JCZnBJaDZkb3VvL2JqbnpzWjhU?=
 =?utf-8?B?b1Z6Q0lJR091WUhDS0F1R0t5T2hEQWtMcm0zcFBDSm1MbGpSaWoySXQ1d1Vv?=
 =?utf-8?B?T0Z5V3R0RHlrNHhrWmtydjFKQTlNTmQvWXNzYU1oT1paaWkvNnFRTVZMOW11?=
 =?utf-8?B?K00xelBESkZ1QklrcmtISEpudUR2ekZtTUIwQlNtQ2w2OWpjRUdrc0Y3ZkpX?=
 =?utf-8?B?RlNzMDlFTG9JZm96bE5Oem1xR1lUTEhKY29oZlpad3dBbXlzRlJFOTdJYjlw?=
 =?utf-8?Q?0/ddcwQ1EWdvtZkXBP8yIEFnJ9oq9Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmdhUjdwb1Z0ZmlpbVNTQUVkRXN3ZXdMVmRUdzhmWEE3biszUmxZeHFRNlVn?=
 =?utf-8?B?T0RIODBvN2NTZlc0bk5vaXBPZ1VXRkp6ZnM4cC9maThzdWdYaS82U0lFT2p6?=
 =?utf-8?B?WWpUUTI3NHFhbTFndHkzRGJTY21raGRDNTV5VWlneHBLKzBSOFBaTk1mWEhl?=
 =?utf-8?B?djFXeVJzWjRaSitHeERROStXZkZyeUpIYmo1OHRpbTI2NUp1RzNoQ2lCRWc3?=
 =?utf-8?B?dk5ySVk2MjQ2dmVTRUJNTGlOQUZFUmtQWXRzUEtRQ24weXdMbE9MSDVBR3lT?=
 =?utf-8?B?MVczZHcyV0QvUWJnbVlTRWdSL0hZQnpJZnQxV1M4QkVId0tTWm9oMTU0T3NY?=
 =?utf-8?B?S3JxMGJJTHhSbEYyQWxEbEkzVGViYkpHbzRsNzVjRVExemZzRUVNRC9xTDlQ?=
 =?utf-8?B?Y2wrYmQwdVkzU1QwSmJEOE10Qy9EZVczMnpMNldyWFdrUXRuRXVjL3lCbDh5?=
 =?utf-8?B?MHlLZDY5Qnl2azhNVitwMWdiU21la2dsb3MydzZzSHVrakF2Q0I2VTk1elBB?=
 =?utf-8?B?YUdZeXdpV2p1NFllUzhGbGFsMWF4cjdieXFRaU1tdG1IblJkL1RSMmNXTzdE?=
 =?utf-8?B?bTlXWXM4U3hza21rOERwYXBwSFpvdnpDSDViR2pQSFNEUzEySjRYdVpLVDJz?=
 =?utf-8?B?OXFlWkFLeWF1L0RlRktSNjdMNTMwdUJGc1dla01aS0J5MEczUkhWQi91UnJR?=
 =?utf-8?B?NktHN2tzSnhVMVVNa3Q3VWVjaElMMzNVMlZmRmpQUDlkRENEaWFWODNrZEF2?=
 =?utf-8?B?b3FSUlpMcDhhUFpqeUlEWHl5aGk0c1pYT2c3TE9SOWU2TTFDWWFzdTBadHBl?=
 =?utf-8?B?VEljNjIvS1pvT3dveWViaFlMNEw4QjhrS3VuWU1UUy93SVdBaGNZQ0pjMDBq?=
 =?utf-8?B?U1N1RG5VWThBdnYvYk5Fb2V4eUpXdm5qeXFBZVRtbEFUK2xBYWd1UUJ0T1Va?=
 =?utf-8?B?TXR1WXpjaU8yM21xa3puOXFJNjVmTVNvMlNkdjYyZXZIRTdTbmpKQWo2c0dq?=
 =?utf-8?B?dUFrZlRMaFloZFNGbjZMMWZJeEFSb2NxeVFKNnBDMFROQStlQUhzdEdnM0NC?=
 =?utf-8?B?ZUlZd3RQUERXMFNRaThkdVRHSGpEeEVYQTRmUHZmUTRMVVdZbndMRU9JajhR?=
 =?utf-8?B?U0w5bzk1Tkl0VzlpbDJydklmamNKTndCSk9LVUo0b25BbEhNTk9uazJMbEJX?=
 =?utf-8?B?cm9TSFlWcGNwTkdvRWRVM3VnVGlBZzBkY3dCeXBpMitnc1g2NnV6dlYxSnBE?=
 =?utf-8?B?Y1hSZTJ2N3BnM3Exdzd1TnUzaHRvMnVDeThRdkRzN3RvTkhBcHZxb1Zabnoz?=
 =?utf-8?B?WTlNL01RQ2gwOSt4eEQwM1pCSmhKc0l1dVNzdmxPd1R4UTFheHlQNlNyNS81?=
 =?utf-8?B?ekhBS3R3TGpoeFFZcWlmMnB5Y0FnNmJWV3NDdm9oUE9sWTgrRDdTNjk0V0xz?=
 =?utf-8?B?dllWbEFJWHJGU2NXc0ZiMzhGM0xETkZ5UE5HMVVmNzl0bXJkNm1ROUkvUm9B?=
 =?utf-8?B?TFMvb3F0aFBJbW5YbXR1bzYzallxSkZMYUdaeDVvNzdtRGJvQ1VmZ1hEV2Ex?=
 =?utf-8?B?cExvUlZZZEhIVjNGZjZTdFJJdFI4dGVTdWcxamhMWkQ5cXZEam91NDF2VCs3?=
 =?utf-8?B?WjF1TlVxczBuWHNCclAxNXlneUNmTlpLZUQyY3l4TUZUbHl6d3gzOVluT2Zj?=
 =?utf-8?B?RVliRWFXbWttTmxKNG9NZGZvMi92K0g3N0p6emxEY1VmaEJyTVB0cmpzY1V2?=
 =?utf-8?B?c0VwRU1QN1Nsd09NSXp6cjQ1UWNRNHh3Z3pCdUR2K1VmbHhreG5wWmg3VkJW?=
 =?utf-8?B?VkxvTlVrNFdGSVEwVUszWmpITEJXd2hxMzJXRDNBZ2g1V2JnQVVOZVYvRmEw?=
 =?utf-8?B?MHZUUDFsa0VaODVIOWl4UDQ0YUd2cDVFQnd3YUhPNVNQamdyZ1lzYmFYMmZx?=
 =?utf-8?B?TUNrMEhiTi9TMUlMOSt4NVlMbmJJcE13SmlDTXBQUTVDUDgrK1VWQVo3eWNX?=
 =?utf-8?B?U0lpaXlTNnBscENYNXYrTFRXcnBLQXE1VEpPbC8zOFo3VnZsN3RiV3ExUW4w?=
 =?utf-8?B?R3hDLzhpU3JJaDFjUy94RnEzZjVOVVd0WmprcHowd2FtNGlpbDEyR1dWVUoy?=
 =?utf-8?B?UVB4bGVPc094SHhDWHAxRndMM1R0cFUxcTBlVU9HSG10UFBHWXN2ZE9YcTdm?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_DM3PPF63A6024A9D829CDC0DFA239FE0885A37EADM3PPF63A6024A9_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4101a9f-5ed2-4538-7a31-08ddb1ceb875
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2025 20:52:37.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DucLZ+qYDDD0u6exhkFetvwdyqlHhG3HdPEKKNBzmRKOrM7GcqSu+lmsh6by5uDtM3rEPuMlcJtiHULJZ8dMaRps4AeYBmk+lk6F0IiEbY51DRMx5lnSH/unq3pkbTZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
X-OriginatorOrg: intel.com

--_002_DM3PPF63A6024A9D829CDC0DFA239FE0885A37EADM3PPF63A6024A9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IFZHDQo+ID4gRGVtaWFuIFRvbWV0emtpDQo+IA0KPiBIaSB0b2dldGhlciwNCj4gDQo+IEkg
aWRlbnRpZmllZCBjb21taXQgODNmM2FjMjg0OGI0NmUzZTVhZjVkMDZiNWYxNzZjIGFzIHRoZSBj
YXVzZSBvZiB0aGUgaXNzdWUuDQo+IEFmdGVyIHJldmVydGluZyBpdCwgdGhlIHN5c3RlbSBpcyB3
b3JraW5nIGFnYWluLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IERhbWlhbg0KDQpIaSBEYW1pYW4s
DQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydCENCg0KQ2FuIHlvdSB0ZXN0IHRoZSBhdHRhY2hlZCBm
aXg/DQoNCk1pcmkNCg==

--_002_DM3PPF63A6024A9D829CDC0DFA239FE0885A37EADM3PPF63A6024A9_
Content-Type: application/octet-stream;
	name="0001-wifi-iwlwifi-mvm-assume-1-as-the-default-mac_config_.patch"
Content-Description: 0001-wifi-iwlwifi-mvm-assume-1-as-the-default-mac_config_.patch
Content-Disposition: attachment;
	filename="0001-wifi-iwlwifi-mvm-assume-1-as-the-default-mac_config_.patch";
	size=1421; creation-date="Sun, 22 Jun 2025 20:50:10 GMT";
	modification-date="Sun, 22 Jun 2025 20:52:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YzM5MzMxZDAxZGIwZjEwNDdmMzg5ZDg5Zjg4NTE2ZGIxZWY5MGUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJs
aXRAaW50ZWwuY29tPgpEYXRlOiBTdW4sIDIyIEp1biAyMDI1IDIzOjQyOjA0ICswMzAwClN1Ympl
Y3Q6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogbXZtOiBhc3N1bWUgJzEnIGFzIHRoZSBkZWZhdWx0
IG1hY19jb25maWdfY21kCiB2ZXJzaW9uCk9yZ2FuaXphdGlvbjogSW50ZWwgSXNyYWVsICg3NCkg
TGltaXRlZAoKVW5mb3J0dW5hdGVseSwgRldzIG9mIHNvbWUgZGV2aWNlcyBkb24ndCBoYXZlIHRo
ZSB2ZXJzaW9uIG9mIHRoZQppd2xfbWFjX2NvbmZpZ19jbWQgZGVmaW5lZCBpbiB0aGUgVExWcy4g
V2Ugc2VuZCAwIGFzIHRoZSAnZGVmIGFyZ3VtZW50CnRvICBpd2xfZndfbG9va3VwX2NtZF92ZXIs
IHNvIGZvciBzdWNoIEZXcywgdGhlIHJldHVybiB2YWx1ZSB3aWxsIGJlIDAsCmxlYWRpbmcgdG8g
YSB3YXJuaW5nLCBhbmQgdG8gbm90IHNlbmRpbmcgdGhlIGNvbW1hbmQuCgpGaXggdGhpcyBieSBh
c3N1bWluZyB0aGF0IHRoZSBkZWZhdWx0IHZlcnNpb24gaXMgMS4KClNpZ25lZC1vZmYtYnk6IE1p
cmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+CkNoYW5nZS1J
ZDogSWJhNDg3YjNhZGRmYWQ5NWU1MWM3ZDVhZDc5Yzk2MmJlM2VhYjA0NmYKLS0tCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjLmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjLmMKaW5kZXggM2MyNTVhZTkxNmM4
Li40OGFiNmEyYTk4Y2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL21sZC1tYWMuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9tbGQtbWFjLmMKQEAgLTMyLDcgKzMyLDcgQEAgc3RhdGljIHZvaWQgaXdsX212bV9t
bGRfbWFjX2N0eHRfY21kX2NvbW1vbihzdHJ1Y3QgaXdsX212bSAqbXZtLAogCXVuc2lnbmVkIGlu
dCBsaW5rX2lkOwogCWludCBjbWRfdmVyID0gaXdsX2Z3X2xvb2t1cF9jbWRfdmVyKG12bS0+Zncs
CiAJCQkJCSAgICBXSURFX0lEKE1BQ19DT05GX0dST1VQLAotCQkJCQkJICAgIE1BQ19DT05GSUdf
Q01EKSwgMCk7CisJCQkJCQkgICAgTUFDX0NPTkZJR19DTUQpLCAxKTsKIAogCWlmIChXQVJOX09O
KGNtZF92ZXIgPCAxIHx8IGNtZF92ZXIgPiAzKSkKIAkJcmV0dXJuOwotLSAKMi4zNC4xCgo=

--_002_DM3PPF63A6024A9D829CDC0DFA239FE0885A37EADM3PPF63A6024A9_--

