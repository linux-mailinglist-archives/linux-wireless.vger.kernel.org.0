Return-Path: <linux-wireless+bounces-29263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FAC7E138
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 14:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 410D4341510
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55E224245;
	Sun, 23 Nov 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJoY5S4P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61920ADF8
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763903513; cv=fail; b=cyeD8/i7TfzmCH0bzWaY3QRMjZh4YeINe0YA/4i37dxI21LaNPb8jVfrQYLRS/r3BaLeBoXS9/NFpoyWqpOeiiClUHjK7IW8Ho94Q0202ZEkW0UpD9Hy5UvYmtwO8IZlE46PiFAerpW9lzzNGgdzjJsRXbTotS6Keu64TywQ0Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763903513; c=relaxed/simple;
	bh=RysYhz02HwRiUpArxemOau+LaN3kcbRpw6jft2+1ws0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pjs8IMfARyOHvsKtUCz3+fbopqImgERPTMtBxPaIzejlccv/IPAzvkKxdZv125wfOqOGaFzC4oK4rIHqvSk7l6/r71OsxkLhWPP4Fz7uL6xfZofhUr/64aP8Go2sIDScpJZ/z1bLLzYp119oPeq/N2Oschks+YDnmjqmqfa4rBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJoY5S4P; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763903512; x=1795439512;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=RysYhz02HwRiUpArxemOau+LaN3kcbRpw6jft2+1ws0=;
  b=VJoY5S4PjmgKKGr/13tjSeH6woxUNVXgcwivsbSlIvJdbaLrtokceihf
   L3PFqlTwlrShesfJmD2gDkDtrhaGRxUOImEJw9Umaf8LY8ka5nn3D/dIe
   zlOW6i3ZZrFa1VLA51DsMjhHKxN+ti4Xgp0J2Pn3o0veykfqf/Cn6NeKv
   9K2q0D290Ukda1j2Ce9V3BW4AV0mraK4wbnW0SIfCmuYwuE+DlEsfuBEH
   hgXIDCDVYoVEMRUUyq8CseJiLYF/kS0ZpY9+9N2WgUpyS5e+R432M0dRD
   VlX/rmhsLJkHAFreJ460oaeTZozYcB/FdUZ90aeAAnk6pmYQ4wMg3bkAO
   w==;
X-CSE-ConnectionGUID: MGzpxdsnTTWNEDJ0C0IWWA==
X-CSE-MsgGUID: qwE8g7kcR1qj/u1q4SjbNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="76535177"
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="76535177"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 05:11:50 -0800
X-CSE-ConnectionGUID: cMJBl7/jTNqG5ueMQZXPlA==
X-CSE-MsgGUID: Ol8rnnYJSlmOCZTiAuRhJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="191886655"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 05:11:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 23 Nov 2025 05:11:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 23 Nov 2025 05:11:49 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 23 Nov 2025 05:11:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLfCMutHq2m4MmJAMX8ttE2tlTgrQb7mKB4FC7h2A0GKbgKVtMwtgKs5ePde9Zxv+k2PyOeXt+gPZYDMqsuSNGjrA0hwwqwnHYwEu8EBPHKBGURFBnxtJXX1N2I3a4HczLfQdjcuqzlCzrkRcSsao43JF75/5WekUjgNvNkqMhJb5yodAmdycT6RooJycEL4tOylEv6o3UlkHsHBwaiEnKKyUXJG0eF/vLg0sZxvrfhOz8p2RsAHYW3KuuLHRo+w6YwaXFFY6aFPdSIXR01tPEkgUv12ImBO0SoTanx1bEb6JC8Sv1bmIF5E0QwcfF9dFKMudiX4jx6/XyyzFJPeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RysYhz02HwRiUpArxemOau+LaN3kcbRpw6jft2+1ws0=;
 b=EQ+b2jFgAzqhUKT1WTDoLgZ3miQQ9SboMuLNQj4fwkIiwq233DIjbn5MXKcGBX5mz74G9ffsV5u4+YC+Lumds2g7IKW7hyccjcKPloGn9214EidshHWM/qRhVA8fB/5gpbY2HNQj/nA+eI8NG4xuYCnEe7u+l/YUXi0VQwXf1PMKefgoW6bxQYe9HzvHmaWpwDZPU0qHFdQnEMlZ+uAdn5tGbjn1NzclagrcJujJ3nEc2AL/zFkzF9qk7MXPzGwHLC1GTWHT6get8UxEg7KXgCUmqkijq5v/BEONfYf7b1mxlGKRYMRNGyN21lPs8TrjTLr/cT0gvEtlmd4ZijHGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 13:11:46 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%2]) with mapi id 15.20.9343.016; Sun, 23 Nov 2025
 13:11:46 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Josh Boyer <jwboyer@kernel.org>, "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>, Linux Wireless <linux-wireless@vger.kernel.org>,
	"Yang, You-Sheng" <vicamo.yang@canonical.com>, "Hutchings, Ben"
	<ben@decadent.org.uk>, "kyle@infradead.org" <kyle@infradead.org>
CC: "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, "Damary, Guy"
	<guy.damary@intel.com>
Subject: pull request: iwlwifi firmware updates 2025-11-23
Thread-Topic: pull request: iwlwifi firmware updates 2025-11-23
Thread-Index: AdxcepMpCamE3Z0yS+O/g41mqfPpAw==
Date: Sun, 23 Nov 2025 13:11:46 +0000
Message-ID: <DM3PPF63A6024A9CC529E3991D0F473DA69A3D3A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS4PPF93A1BBECD:EE_
x-ms-office365-filtering-correlation-id: 66dbd261-1ccf-43c9-330c-08de2a91daef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K1daakVHOGRGQlNSQW05dlpDQTVqcEtQVzR1Mlp2Uy9kaU1NT0RSQUcyNXIx?=
 =?utf-8?B?V2N1K3RHaCtQdU85UHExNjdWR2ZidXdDMkdKY0FkaVNKaUVGN05IV01JOUV0?=
 =?utf-8?B?RlFTRlR5NmNONHRPYXBMalZONVBmWXFNKzFiUTZHeWFNSVpBUktpOHV6Mnpj?=
 =?utf-8?B?OEVoUmRjNWd0NEhHQlFYbkE4M1dBVlMydUtPTkVUaXRGdHhNTmpFaUhGbVVz?=
 =?utf-8?B?czd4d0VoWGJBZndYU0JDU1ZuZHczWGh3bUJTb0hWcWNiNnJtNmxaWlJwazIw?=
 =?utf-8?B?VDcxSlJoYVNIMzJTeGxpQjE4Z2QwL011eTJDdnR0VjJSWHJuNklFamc1NTFY?=
 =?utf-8?B?MWl4bUNicldRSCtnL3F0blIyS2tYakNjMHdhWm1Gdkd1YUsxNzVXaFd1WnlQ?=
 =?utf-8?B?ditHbWtkUTZWVmNNdy9Wd2tEZ0Rpa3NkWGVKSmo4VVNCdFRSeHE1T2w1MVJw?=
 =?utf-8?B?U2lBYzdQaXkvVjlpV043NXhPbkU0aFE0aWkvTXRWQmM5UHY3bE40OFNXK1dp?=
 =?utf-8?B?bGp1WDJLeHFDbVZhQ1VkVW5MMVNQck40Uk0xbXBSeWVxSVlUcUpOSmtORkRj?=
 =?utf-8?B?Wlk4RlVZSFFJOWdMZEdZYkM3Ly9FQjVJNmxBLzBlVVJwdU55MjVTR1Yrd2NS?=
 =?utf-8?B?MVlWSDNTWERkMXNUd011enFzc1FZd0FoZ21qUElHL2ZKUUdTTjJESGExNTQ2?=
 =?utf-8?B?NmVPU1Fua01Dbm4zanI2a0JFbzdHYjVEcmxGWFdvdGttS2NmNlJGRnhJeTEy?=
 =?utf-8?B?dWw1TkYxQ3RDaWtxWVpLYVE3RGFzOFJvNjV0SElsckhudGNKT2hwZzFNdlZo?=
 =?utf-8?B?QS9QZVplUnBIbU1QUmh2b0RqZ0pLSFBRTkIzNTVibUQyOGhlQk5MTkZrZXF5?=
 =?utf-8?B?MTRjK2JoMUUrQUpDVDNMMG0yYUlJL2pVeEFQMEhEaTBqUldoQlV5ZVlWU0I2?=
 =?utf-8?B?NUFWQ1FaTWRVTFg2dnhJTjVmYTlDa2xUanFDc0dGUUppR1UwU3pBejlJOE5V?=
 =?utf-8?B?UzJEZVlZTC9NR0wya1JJU3BrajBRRjdEQWl6U09NS1R6R3Q3UGxCOXMxMVNY?=
 =?utf-8?B?ODdQZms3VzVTbE5CcjRnOWZjZXcyQ05DMmVPUDhnSlhaeVR2dlRseTVqbkpT?=
 =?utf-8?B?bWNETk53ZHRwc3NIYXRLWHBzWmVzV0RLRHlGRUZZdVNIay9pWU9kRzFWMW51?=
 =?utf-8?B?NWZ6QTg5ZVd6Q3E2bFV3bU82UzNRQmhlWkhvTEIyZ0dDUUN6c3hSVEFIbEFh?=
 =?utf-8?B?VUhjZzlONzJFOWJjdUFaUzNiUFQ5Y0IxWUJEOXd4dld2czRhNGhaY2N5MWlZ?=
 =?utf-8?B?SFA3Wk5uYUxxbDVXejBEMEdRZm9NUGlRcGIrdUMvcHhhbFJvUVg3WThQbjZT?=
 =?utf-8?B?SVNKWFJGeVhJak9xUHZ3Z3RkZTlzOFRRU2VBb3E1bHh4dVh5eTUzY2RjL1Y2?=
 =?utf-8?B?UXE3NmttVEt2aElVYnVQSW9oL1l1MkNxQlJUbnhzeFRSZFdCOGZnWksySWVp?=
 =?utf-8?B?TmZuSFFsc3BVUmlJSFgrVnN3Q0RVY0tjbVVNSitBcDBybllzTXIwbWVmajFU?=
 =?utf-8?B?K0F3NHE0SWdoMGdRODhxSlVGVi9zcDlEOVk4M0VQRER0ekdxR0V4STJZRmhJ?=
 =?utf-8?B?TXlUaFFjZ2xWMmNxbkpmVWZnRmxTK2FmZDRkQ2NWdmtWUFAyaGFwZ0MzWjgw?=
 =?utf-8?B?WjlSY3NEd0w2MnlTdnZyUnBiT3U2RnpPY1F1dHdWWlVKcVFEa1RXUTJ0M05G?=
 =?utf-8?B?a1ROclNpK3FlUEUrOEtKT1JEeGdYcnR0d0UzNmxKbjEzU3NkLzJYaEtOU3JJ?=
 =?utf-8?B?UXRHY21IWFh1MFZCbWpqZld3V3ZLMXAzK1pkYUFJTHlVWmVpL3c0bC9BL2ZT?=
 =?utf-8?B?SG1XNlcwdlg1aG0yTVJHUysreWtsSURFdzRBalhsMkZpWEwxWU14ZEZkWENC?=
 =?utf-8?B?ZThyVUhMMTVwaURQdFNUU2xDb1c2M3FFRUt2aHhkZnhWL1hWVnMvV21KZ0Rh?=
 =?utf-8?B?YUtzNE1BaENNL1pualpRL280ZDNxVjY0dWEzV3Z0dXNsUVNWT2ZjdEQ3TzQ0?=
 =?utf-8?B?QTUrZkxMUzFVanQrYUY4eXRPRU9RSHk2M3hDUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21IK3JyTUZWcTBpeDlIL0doZ29rWjlmZFdnUWd3STNqWEtTU1pSZ3NlejVQ?=
 =?utf-8?B?TzhoMkhtdXMrdzR4TTBodHEvOEI3SWV0VkFTVkU1OGRZR1k0cXkra2FPNlBJ?=
 =?utf-8?B?QmczMjJ2RS9NZGp1UnNzU2lkRS9XN3o2TjJTRWNLTno1NWJrRjhSeGxBMkhN?=
 =?utf-8?B?bDNWMnBheGh5S2EycCsxUEp3L0phRTNRYUFBc1JpUVg4VUhMMEJmaDF4MkdQ?=
 =?utf-8?B?SGFHcHZBeWNWNnkrN3VKTGRlYlZ3VFRUOVRENHRNOVVQR2hHaW9uT3BmWFA2?=
 =?utf-8?B?OEd6aU5PaHFRejQ0eitYNkpjc1FsdG9NSkY2SUFFTkhIRjl2eXdZNU9ubHNs?=
 =?utf-8?B?dDhrN2Vwc2k4U0I1YnNQbW82V2ZMWGRvdlZ2N0JBRkYyLzRGYithU0FZV05S?=
 =?utf-8?B?bFY1cVZJODBpVDZkSlc4Vm40cG5TUUZyNU11V1lxMTIvSlo4TU1COFh6N0hn?=
 =?utf-8?B?Q2hUWWh0Nkp6VU1kWWg5T2thVDZhS25VUy9jckp3WFhoNytKVVV5OEtVbDJG?=
 =?utf-8?B?WkxoSlJzc09nSDhsTTVKdVFDU1kyTWxwdnNKLzJpN3A1QThsS3hOalZ1eWM3?=
 =?utf-8?B?bW9EMVhiYWJvT20yWStkMytTbXlFV0htSDBQODhBNktFbmVHT2h5QUFNMFV6?=
 =?utf-8?B?THB1NlQvMW50emJ2RXVyOUoySnpQNlhybGdSWDdOWnA0cUpnVFVteVl6YkF1?=
 =?utf-8?B?OWhkUGRQWGlkblNVWmdWdEhsQ05UYXR5SFV1YThGWkk5SmJrQTZWbktGV01J?=
 =?utf-8?B?SkR3a2w2NVNiUVp1cWFFK3J4V2J1akhObmNpdzh0OEhFdlFJVFBTek11RTdo?=
 =?utf-8?B?emF0RVJSS2RqdW9UUjRkclZhc0U4Y050MlFUc1Bwd0lSRXNQS3dIcXBXMkZ6?=
 =?utf-8?B?djh6VysxUXhMc21hWU5RdkwvTkhlVStwMkJpaThkK2preUNlelN3UzVoZnNm?=
 =?utf-8?B?QWdkY3h4bFAyNFZyZHFRT3FRbzNWcWQzc3E5UTFYaVVYZkdZVGh6bmllTElP?=
 =?utf-8?B?R1UwcytnOVdtZFhKYlFvenJWOUtlZUpUU3ZhamFjR05MS3prYlJlZ2Y0TVNO?=
 =?utf-8?B?RVBYbU5sRzZFVWJSZ0FQczlSdXk0dXJKSkJGdGlvNStnTExQRnpURkkyRkhs?=
 =?utf-8?B?QWpPYzZkWC9oRzh5dGdRYXMxeHZTdFRjem5ENTJwazlEYnlQR3F5RmJFUWJh?=
 =?utf-8?B?TkpEZGlSZVF0S3lEUmF5ekJxeFFENmxjSDhsOUxSTmlZbUxoZlBQcjczNGVH?=
 =?utf-8?B?aUdEMHNuZWJQdWEzc3ZnRjduUUlJUm1CaU1wb3k4RGdxTGZMTm9LSlFDY1lw?=
 =?utf-8?B?WlBIS2t1RnJDNTJsT1JCeDdkRGpoU2N5dHY5Zk5jVkV1dXBNcm4yWmkrczVU?=
 =?utf-8?B?aS8yQUlXNE5rQVNxbUx6Rm5mbmc4RThVTm51emZyWlpIY1ZyQkp6TGdMbHVm?=
 =?utf-8?B?MFFDTXA3TDJEUWNxSTc0MzVVUitFQlI2QmZTQkFlT1V4QXVZTXViMzE4WUtq?=
 =?utf-8?B?WmRRa0cxZkg5ZFdGZEx3Qm9SazA3NUxIeG9oRkhyQ0pSbGZoU1owRnZmeVJz?=
 =?utf-8?B?SEhaaktldXQ0czBkU3E4MVk4bjRMZFZ3TkNTQkpNcjc4Mml3QkEwTVExaEMw?=
 =?utf-8?B?L2xpbjhDeE5tS0ROMk42SkQvbHdma1NzcnpNYkZiR253MVlRb3B6cWxCZ1dr?=
 =?utf-8?B?SXRrZ055VU9tUDZsUjk1cVJ1anBqb25nY0kxUzkvZGt6VHFsUEFFZStqTFZ0?=
 =?utf-8?B?RDMvNmtMWmowcWthcU5nRHoxaXRmYTMyeDdJb3RwdVBsMlJFS1VzelNGOTN2?=
 =?utf-8?B?THpqQlZTbXlBeFNSWmtwT0RTdjlJbjJmcWlTV3RwR0VaNVFBYWlKMGcrMTRv?=
 =?utf-8?B?V0lkeThZNVJSVWw1Ym1VWXpYSW5ZQ1pFeGtVeGxqUXVOaGFjRHNYRWhVS1dJ?=
 =?utf-8?B?bkdLazhSNGMzZTlpc1drYjVHUjRCVGpnUkZIR0JLT3dlcFREMDlaZDRGSHJp?=
 =?utf-8?B?QzZmWU9yc2J1L1lkMlJzVE9QQ0tlaGQ3NzduSWRDVFowM3pVbkk4Nzd0ZDNN?=
 =?utf-8?B?N094RHVsNUVCZjdyKzBMaXdsZTV4cm8vcFgwSGlMR0M5cmx2cEtSVzZZTkdM?=
 =?utf-8?B?TlRXOEo0T3FwYmRhaGc0QytrZzhrcDhMQlVia0RGMG1QY2RZaURFWmN0UFNN?=
 =?utf-8?B?NVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dbd261-1ccf-43c9-330c-08de2a91daef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 13:11:46.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfPDbUdtr29KDUC0/h/vV1VMmFProiUHIZdjlJnmvaJfJO2PK9cYofQ3Yfc/v99fs+NgmRQ7d0phEWJOJ6bXVBQb5I1r7mCQVuGneXo4G14zHLugPiolJ4H6s5IZOTME
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF93A1BBECD
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgYSBmaXJtd2FyZSBvZiBjb3JlOTggZm9yIFNDLVdILg0KDQpQ
bGVhc2UgcHVsbCBvciBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhh
bmtzLA0KTWlyaQ0KLS0tDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZmY2
NDE4ZDE4NTUyOGJiOWIwNDBkZTEwNjZjMzRmYTQwNWVjZDRiZDoNCg0KICBNZXJnZSBicmFuY2gg
J2FtZC1zdGFnaW5nJyBpbnRvICdtYWluJyAoMjAyNS0xMS0yMSAyMDoxNzo1NiArMDAwMCkNCg0K
YXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZpcm13YXJl
LmdpdCB0YWdzL2l3bHdpZmktZnctMjAyNS0xMS0yMw0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5n
ZXMgdXAgdG8gNGIyNDU0NzlhYWNhYmEwZTNiMDczYzMxMTUxYjcxMWU3YWFlMTI2ODoNCg0KICBp
d2x3aWZpOiBhZGQgU2MvV2ggRlcgZm9yIGNvcmU5OC0xODEgcmVsZWFzZSAoMjAyNS0xMS0yMyAx
NTowMzo0NyArMDIwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBGVyBmb3IgU2MvV2guIENvcmU5OCwg
YnVpbGQgMTgxDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCk1pcmkgS29yZW5ibGl0ICgxKToNCiAgICAgIGl3bHdpZmk6
IGFkZCBTYy9XaCBGVyBmb3IgY29yZTk4LTE4MSByZWxlYXNlDQoNCiBXSEVOQ0UgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsrKysNCiBpbnRlbC9pd2x3aWZpL2l3
bHdpZmktc2MtYTAtd2gtYjAtMTAxLnVjb2RlIHwgQmluIDAgLT4gMjA5NjE3MiBieXRlcw0KIDIg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGludGVs
L2l3bHdpZmkvaXdsd2lmaS1zYy1hMC13aC1iMC0xMDEudWNvZGUNCg==

