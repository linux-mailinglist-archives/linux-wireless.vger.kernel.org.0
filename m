Return-Path: <linux-wireless+bounces-34116-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mai7DOGhyGmRoAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34116-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 05:52:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1814B350966
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 05:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A2B301C88B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 03:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0F13AA2F;
	Sun, 29 Mar 2026 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sq+mGblz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FF7E0E8;
	Sun, 29 Mar 2026 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774756316; cv=fail; b=hPerBcCIXcLacg+xVxYwwSZfyC2H6qbzhqxDthmXsCHYbXttPRqZqjztt5NB3NczON592xtpC3a40cYTGFBEk81aWyyFkJ3mOnCQA1IxSJ9KIEtdepsfe+lI4RSPpVzETXFgErehkBFNXwpmH3qF6qGs9rE+yiU/15z9i3rdYlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774756316; c=relaxed/simple;
	bh=L3GKjnOgLI6bJFTxqYAQf4OgYD/NsLZjOKQHsJDDnWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMW+URl0UjKG4JZft0LuxyXtq4nseN3Xvh544QN44P5hwuXJd9zz7XJjr8mBEMIErS1MUNGsFbFu4oPT7RITF3Od9KFumJx3Wr6aaoJr3+mjSNFRxxT0Q4LxNLILnnrUTf5Ltr0OrWn9IZJHuACgpMun4+MEUtO/j1xt4frV9TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sq+mGblz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774756314; x=1806292314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L3GKjnOgLI6bJFTxqYAQf4OgYD/NsLZjOKQHsJDDnWU=;
  b=Sq+mGblzUcEFndUloZcq39sgO0oeA+jL9nUADGQNnlGZZ60bQBe29KGo
   n3CHAnCg6g1ikjBbQ8ayFLrGaL/vJLQvKSRcqDsnY2JycdqIaLWbWfttG
   VROwhJxCG4pooh5Fdxgz6+/VYAx8oRzqQ4UFFDGmIThyyLw5PqBDfbi17
   4V3R7nKk89MBvdVrSCd4nn+UTCF3u79pGJkTD55QpPCQikwb/w263GLxk
   oS7nrg9CznbNqYcss+GRnr6TWePBCUsPm+KI3KTXSvvVXE9/nsitHTnYt
   +5u2VKnOoe9Kt8MdERBP+R56CyxIk7pSdkXerx83b+r4mJQYnuJQBxj/U
   A==;
X-CSE-ConnectionGUID: K3UAbhbGQxe7/23ozJ09Rw==
X-CSE-MsgGUID: rN/IozTVRVSVeq2MyeK0FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="79645781"
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="79645781"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 20:51:54 -0700
X-CSE-ConnectionGUID: w7TzSppKSQq8GQppyIFQtg==
X-CSE-MsgGUID: JwbYaT12ToWuiwX4NFE9vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="225601897"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 20:51:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 28 Mar 2026 20:51:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 28 Mar 2026 20:51:52 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 28 Mar 2026 20:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag22ltObSrWbs1XfIh3+JG0dyxVNXnzuLQjlwZSnhst96nz6DJOrDyiQnlGjQpffZY+8dAVPZJ91UrTNl9aE8f9Nsbb4T1NXC4gLzZY53mHfWHxxXx7d0x3LGcbYh8UHu/SbIOIfLpyWgSLb4f0DIPk8+KYsAYYZ3C+HbctkqfycjPNfMLR8GpRsrtJ7AsLQEfOp9DlQuvngkkY4G9+TXtOuMISLR44mL5oAED3fk7KYVgWk5Ha3u3CkXCGBaFq3rlwSH4njm4Pe9S6RIw992ofQFuq082yNVDmD/OKY/c6JaU40O8cAhrU598EXtANVzLxD+ZkmuaoQpwYCA36P3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3GKjnOgLI6bJFTxqYAQf4OgYD/NsLZjOKQHsJDDnWU=;
 b=Gla+2I8CcjDaU6itTDIx3I4ay3lcs4usGfRqtHFYMgx+igwMv1JUM6UOvC8EQXAugprdl/yzhkiEJ+Xvc2mfbIYQ8q/ryhLoH+fhseBpdiPsNgCsYrhXqtLI8KkafwPof0z4aL6OUW5DuVz9n80eTfIvu7pll69J6FF8BlTYxKvAt+Y1LZ6bl0Q9FbQzim8xNdVPu5app4ICFh6J3G4FDQ2HPVto2NGSJy77avdSqV30lwjNWeVwAX+gQrYFwzEkeuzuxVEt9rawwnajE/xHiSrE7FlLg0H2TyCHaB50p9UUTVwu6+PYgOA4iWdROjs9RbdBpZ704v3gHTjT4uAOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM4PR11MB5230.namprd11.prod.outlook.com
 (2603:10b6:5:39a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 29 Mar
 2026 03:51:49 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Sun, 29 Mar 2026
 03:51:49 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: RE: [PATCH v3 0/3] Replace uses of system_wq and system_unbound_wq
Thread-Topic: [PATCH v3 0/3] Replace uses of system_wq and system_unbound_wq
Thread-Index: AQHcmppQ+jjv5hnIh02sv1jL2k6An7XC0vUAgAJWV0A=
Date: Sun, 29 Mar 2026 03:51:48 +0000
Message-ID: <DM3PPF63A6024A99B45503AD27C88685EAFA355A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260210143332.206146-1-marco.crivellari@suse.com>
 <CAAofZF7o5vvnJ=_s2Bi2Onn4tuXOq6uqHCrJ=wp44FfTkqRegQ@mail.gmail.com>
In-Reply-To: <CAAofZF7o5vvnJ=_s2Bi2Onn4tuXOq6uqHCrJ=wp44FfTkqRegQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM4PR11MB5230:EE_
x-ms-office365-filtering-correlation-id: 17903bc1-7d85-4666-49a3-08de8d468157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 1nd7v3ECoLhrp/otlQl3DzDFsZXyVWsJWvKoMUStGT/bV5zjjStj+mJoKzbW+GNVnPIyOcN91MpXEG0eqhwLGMYDi/Irzais3S2YOQdTz3lZ8g+/o09VhJ//Zrpe2ZKNjndPdOQPONluEgcKxEQCyIFyugxDqfRjrMWD2jK+M4a9H/LREYqNTMgwh86UVOWNGIazqIOW8Ulbq1/vABePXwOzOSgetiXkINScjPpfW9lvLJuhSlh5Le5NhI0+z85FHkCGuFxoWwnlP4KTKIkHM1kSNfJWrFHq94OYvTZiX+mr2HA43v/X78njsKCoX0DlbLcMFngpftq7rAamK/Na3J8lE/Gw2aCmphrHoKVmVGdkBP0yn83L03KPTKh9O/Zqfr+YY2oWmMs2WQZ6jZbwCId0fqyv1Pa4CVufeEOliQURhbqEkPMUoK8hezEamemHeDoereW57L2ebrQxBy2Ic0SkkuYTlxWLt1A7LUw3sp9e9zR3915jNjKfALEkM8NCDljfoYpuB0TBFikhpoOC8s67jMmBo2zvSfNlWLqq00oZg630+wjK+U/nmKuKfv0J+CSzQfRQD7LE1UpyNHJNvs4ygPSLULgmVz2U0zI2Q3xhwoZkVFShvKhEENRDv+efvxne0mKWh6S4M20kd3gZEJ5Q9F9LYnoXeYpjD0PuWcHCV1mEifzScwUxz1/tQkWEqisHFy1ZV7yEGoQoDnKdSkjrGrm0BVhHZWT81JznDgTFEey5ruHm07+Ds3qUwmraiPaidOwM9nmz3cQIh4SIX20jnmvOvP3C7K0jUzM6kMw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW9ScVNKRUxzMkc0cWh3aERkQ3RBVlVTcmZxYUhnUVFqSUNCL05rcHYxZFp0?=
 =?utf-8?B?dWc1NVlhQ0tpOUdZWDlacVFsZFpRbWV0dGh2R0FsUHZBVkQ3NlkxTUlDVzJv?=
 =?utf-8?B?ak5XUkxVWDVNdzJFbm9XVW42Yy9HdmpCamJvUDl1Yk1EMVdTL2RhQmYxVWVR?=
 =?utf-8?B?UHdLTmNRV2w2ZTlLKzVyL0hvaElqSlF3bnBUQWtvSlk3MVY2OWFMaVBPbFg0?=
 =?utf-8?B?eXBVT3NXeEo5R0M4Z1Qwc3ZiVjExYjNzemhLVDZwQW1hQVRmRkdZTnBSalZ6?=
 =?utf-8?B?V1BHRnNIWHRacXVLQnlEckhXd1Irc2lUOFU5WnJWcEI2cVNNbi8wNW13MHJM?=
 =?utf-8?B?bDdieUFkY1JSVGU5WktNWVFDeG9SU2IvRlQ3OVFrWGdhbnJZZDZtM1JZK2Nv?=
 =?utf-8?B?ajQ3RklJcDFzeit2OUlybm95ZXpiL1RLVkxrQnVIbDJOS3NhV0I2V2dabHFJ?=
 =?utf-8?B?UnpCeFhLT1ZvVHdBQTgyZVkzTk5CbmZmeTFZSWFSSHFmQ1FKaFgwZSs4ZnlS?=
 =?utf-8?B?TWpqK2RvV3NRb0hBOFF6dnE4U0ROYS8wTGFNd2I1NGEvc09hWW91MjNmNXZX?=
 =?utf-8?B?UnhkRHI5TTVNM2Y5V2hmYk9yWXB6SzJCQ2hYVGhvM0FIRkxqMlV0OU5xR1gw?=
 =?utf-8?B?eXp5Q3RnWHoxQ0MvcFJZcFhxNXduN3IxTDk1UUplRm50dElpYTJHZkNiSTRu?=
 =?utf-8?B?bExNdmQ0dmtnRzNtOFRpU0hOakxCQTJzaEx6d3NhTFpxSVU0WmNMOEtHb2pC?=
 =?utf-8?B?ZG1ncmNnQVh3cHc0WWExbzVjOGtRQ0pUZUQ4Qk16R0tpdVZQeFJxNFhXcWw1?=
 =?utf-8?B?UE9lTmxIYUhkNE1ZM2VBeTF6QmpvbGJnTlFkdUt5eGpwYWZKMmlMUTF6c0VZ?=
 =?utf-8?B?WWpzeUs2VGt1VU1ybGdHdXZaazJoTGdTMWhFWUVsNU1oL1VZa1VhRlYwRjF0?=
 =?utf-8?B?ZW9XVk1NVzg2RFEyUVhPRzBCVmM1MFpJVDJMVnpVYmVXR0VMbk9wd2JYNzBx?=
 =?utf-8?B?bTN2MGhMcmVBV1ZGU3hPSlNSMmtlU1dTcWNaeEpPcCtleXdTSm1OZEtBeTBV?=
 =?utf-8?B?cG5xNnpPbGNnUHY0Uzl1ZVIyb25QT1RZRWp0NEpwVjlSc29JSEYyaXl5a3dl?=
 =?utf-8?B?azVXbnFiUSsxOUJnaUpmekdEQVNlNGJ5SEZwNThiZGZuMTFxRzg0TGFOSzBH?=
 =?utf-8?B?L083aFZCdTcvak1QcmxXMWN3b0J3SlRiM2lSYlh6NkhrcG8zUkdRNzlDUHRL?=
 =?utf-8?B?RnhiNGp6WWl3Y2wwUi83dUhrOE8wVllsQzFsV3hQUG1lZGFUeFcxNG5TRTVl?=
 =?utf-8?B?cHhoaXVsV0ZaZEFJbXZCSHFWcE5IaGpkRVpvclFvYlYyejk1ZHJwcHRuVy9r?=
 =?utf-8?B?ckRtWEpnRmhVMDBCSnFIRVVodW52OUg1MWpSVVNWbDRRUlVtTkNxd3NKZ3NI?=
 =?utf-8?B?aFUrb21MNStsZEFtbit5K1NNSkQ2bmFMOTJESUVvaG9YaElKWUlyT0xVQnpl?=
 =?utf-8?B?aUV6eC96TnptdDhTZG1iMVIwZnAwSjdlUjhBUnJFaEcvNDJXZS91MTM0T09k?=
 =?utf-8?B?VmcxVjNBZjkyZzFjeW1nVzEwZC9zZnlNWi9wQ2R0THhlY3p5Qm1wUnQ4ekJF?=
 =?utf-8?B?ZlZWUEc4WkhibHk4TiswNDVGajhjVXB2VFB3blc5UUxTTXpITHRWNXZIUW54?=
 =?utf-8?B?a2s3VDB3ci9PeVdBNHRKKzhqWGJ5dGtSS0k3c2J1OE9hRllNLzZTS2JzdFY3?=
 =?utf-8?B?QmtSWmphNzBhSzhNdWpnUkNXY21MblVvaXJpekZaeDdBTWdZeTVINGJYc0NY?=
 =?utf-8?B?R3VacVorSGZMWitrT3ltdTRzbE5HM2dyUC81U1hDRTdwTTBzdlNKN0NZRzEz?=
 =?utf-8?B?aFRDZDVVZ0tWRnRESm1sN21CL1M1eWdRSklrSmpJajdzQ3g2UGdrQ3VRR2xW?=
 =?utf-8?B?aUY1M0pYVCtzMHFQbjBlaS9IbTM2SlJJS2prT2ZUVnllSHJ4MVNXeHJmSENh?=
 =?utf-8?B?RmdpdXQrOU54WE9zRWdFOWtiSTJaRFAya1lPMVpJd3FzbEU0cEdqUXl4bkd2?=
 =?utf-8?B?K2lsOWdOTE5FTFhKL0dFSllMU29xeitaL1pzNXB4aTBTbmsyV1hxSXRnNnVT?=
 =?utf-8?B?ZVpZN2R4NHIveDZEa3lrYnFNVCtiMktHOUJmUk9PbjFDQ2d5RDNyeXRrdHVL?=
 =?utf-8?B?akd1UjFMa1B4SFMyQW16K2hxQStWNUtKWVV3VWdQSzNjWWFvYURUdTBTbzJ6?=
 =?utf-8?B?aUYwTnRIYjhldE5YWmFkeXZWUnhZS0x6MnIvVUhpd0NobUdoUmtkUkZKM3Qz?=
 =?utf-8?B?eDV4UkRCeW5lanpFaXVJTFJ3WTh3cnZWdDcwb2d5cng1U2lwbERVOElVb01U?=
 =?utf-8?Q?LhkFc9gmbSOqNHS8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ve9EMWHFZ2oUqtzFIwiazBkHrAjkBJVPo9LcFQuCZOV8nkwFC217FpoL+Mwu5syJhEpFL5LpjNVckhGzNVWr4kMYLqeAY/zRSpXGTC9iOjBt/NRdvEymbA9FepYKSJVRDfXKhGspb7+g0QxSpFZ3NkDg+0MTS0SwnaI+warMls3G4/dgoqTZBr0pNG8J2ZFH5QiQo55o2NyAECtx0mVdeq0PWlxr1oB8whvQb3Okjwyd2j1/SiwrbUrCGLutCJtco3m6yDj/O5PDQQcy1i0dQd4TYygX81/CnbTP+2N/lTkRrrvO250/ISlTaqxw4/iiECXrTeUMT4zH0amgW2h6qA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17903bc1-7d85-4666-49a3-08de8d468157
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2026 03:51:49.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iDvSL2iR3QwIdRXJ9rDG8EO14ZT1vOoZEopaMDWaRndFgluv5bI7WxcbtdBC+33eZOp9DkM+T3FRYyBZifBxPYCsIaSJ5D3WTBI/rpb6hoJ+ANruYbtLy8HwiA3ciVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34116-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1814B350966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gQ3JpdmVsbGFy
aSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyNywg
MjAyNiA3OjA5IFBNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz47
IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+OyBGcmVkZXJpYw0KPiBXZWlz
YmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0K
PiA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+
OyBLb3JlbmJsaXQsIE1pcmlhbQ0KPiBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGlu
dGVsLmNvbT47IEpvaGFubmVzIEJlcmcNCj4gPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8zXSBSZXBsYWNlIHVzZXMgb2Ygc3lzdGVtX3dxIGFu
ZCBzeXN0ZW1fdW5ib3VuZF93cQ0KPiANCj4gT24gVHVlLCBGZWIgMTAsIDIwMjYgYXQgMzozM+KA
r1BNIE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNyaXZlbGxhcmlAc3VzZS5jb20+DQo+IHdyb3Rl
Og0KPiA+IE1hcmNvIENyaXZlbGxhcmkgKDMpOg0KPiA+ICAgd2lmaTogaXdsd2lmaTogcmVwbGFj
ZSB1c2Ugb2Ygc3lzdGVtX3VuYm91bmRfd3Egd2l0aCBzeXN0ZW1fZGZsX3dxDQo+ID4gICB3aWZp
OiBpd2x3aWZpOiBmdzogcmVwbGFjZSB1c2Ugb2Ygc3lzdGVtX3VuYm91bmRfd3Egd2l0aCBzeXN0
ZW1fZGZsX3dxDQo+ID4gICB3aWZpOiBpd2x3aWZpOiBtdm06IHJlcGxhY2UgdXNlIG9mIHN5c3Rl
bV93cSB3aXRoIHN5c3RlbV9wZXJjcHVfd3ENCj4gPg0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2Z3L2RiZy5jICAgIHwgNCArKy0tDQo+ID4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmggfCAyICstDQo+ID4gZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGRscy5jICB8IDYgKysrLS0tDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gSGksDQo+
IA0KPiBHZW50bGUgcGluZy4NCllvdXIgcGF0Y2hlcyB3YXMgYWNjZXB0ZWQsIHNlbnQgYW5kIGFw
cGxpZWQgdG8gd2lyZWxlc3MtbmV4dC4NCg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gLS0NCj4gDQo+
IE1hcmNvIENyaXZlbGxhcmkNCj4gDQo+IEwzIFN1cHBvcnQgRW5naW5lZXINCg==

