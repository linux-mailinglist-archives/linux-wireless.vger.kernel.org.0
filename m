Return-Path: <linux-wireless+bounces-31703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA4xE/9Ci2mfRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:38:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194011BF87
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2ACA3018BD2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C737FF71;
	Tue, 10 Feb 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0A29LCD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42531B110;
	Tue, 10 Feb 2026 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734309; cv=fail; b=DDJBrXzQbUVLjxYD1ro60WqBF6fK8igIvW3Q4oDh2XqgKhftdy30Wd1e850TtsbwLh7AXuP96sYKm5bpziMtvR4JpyyBKUHiKTZ6Q+aGdtujxxY1E2zNLVdRjI4ab/weWeSvKtRgwLGT74l1IlUJJPE7uVfDHN5u0pNBBkpjZxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734309; c=relaxed/simple;
	bh=FOrFAhKoW1WRVIwyhlF866ZPF88zOG7CjrbOpfuiXxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFLOI+Tfk6WAzU9t+8KphAqmPktLwwLv7pjf8xhlYGLmTsypDmAx6Ll7iwr83hZw7Lvzcz+G0g/WTDaEwiQxdzAr4d0Brs960q07tSnM1+xdUAr4p+VW7D62nf5KU4bYf09KO0gHdhdIhW4aZxHGjBtg536RplP54c0oCmP++fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0A29LCD; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770734307; x=1802270307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FOrFAhKoW1WRVIwyhlF866ZPF88zOG7CjrbOpfuiXxI=;
  b=W0A29LCDPwDW5V8PVFvNl6Rx75DcTmfqcpzY0y51XVj2yTF6MJi1ys41
   D5OJG1ERNmcLM3MUaIC9GgWfSkBC2iJWPmsmrH9VD24w0shHh+zyYIGxV
   opXlmZwlNZ75u9EJBXSPsRlP4T+mBhF/5cr+SSmY8G9hif3rfJ8HJv8dt
   jBamaN8wVQ5sJk8DzBXwT2z1vS484vkk6+z3WNTV0czxWqOxqw9fucGGF
   FYO/O1F+raljmicdmiztukgLyDtAjDiGBGxNZgqxePNhxwOxni6lVKl0D
   PuP08QgnxYNQsy8mb9Pcmc49asERsLAgN88dpqjOZ4Xnpsgq7gJ/LFRMr
   A==;
X-CSE-ConnectionGUID: INf4sXGJQGah8U3WH6xzYg==
X-CSE-MsgGUID: Uv+20X5BQEGhCYfBi5dLIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83302490"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83302490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 06:38:27 -0800
X-CSE-ConnectionGUID: Uf86dTnCSi22LEOTfV3LRg==
X-CSE-MsgGUID: EqYtoETXTouSC2Urtc5V1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211039797"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 06:38:27 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:38:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:38:26 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:38:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvEYw+A7zNSrb9v/eSoQC/Dt1tuC6ceYvrHpSEBW/FOLkiZuzJcEf3jg2fqgONeaJD8vP3SJ3tpeZMUofKudz5biPlIRjHletcxUwEIOg1HRp4LdN6SkJh4+tEWUHjeNSo4GkRDzsj6OIR42bK5mC59XCBmioQmpjkoh9Lk+vsoyEKPZPbCClhK83Kq1TjUqU5eepl7Tg9KiIPFOqEQkZ90LbKT/pmtWmMBXmf3s6e98sFXzRvpHzR0Oym7291JWmPRYrA/xiu2YzgteCHIUksrtdZuFHr11PYf3+zscSqd0x6I6sOTkV3/Czx11GQIG312Zv+CbGh05YMWMYggKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOrFAhKoW1WRVIwyhlF866ZPF88zOG7CjrbOpfuiXxI=;
 b=ROAAHlj34aToFmaQrcoaJm8/W0jIyJe7PhqnGzH/0PZcrrdMRWJjLi7bcs0KyG3uJHMuLjiuZKiDNMnGEsLuVhpiXmOZU/D146vBAArAwrmkUVg1Pdh7f8L3Hi99HDlmMLQ3r2MwLDBV42Pf9EPxcrsLWMKlTrQYF4+iUI+EyZ0An6e5G1esDzSYQevolr/LJuZLsXieWdBW+TjiV2BgrRa9iQz7Kw4mmxmM1sRqHPfTkhtY0pfm4hVDOn1v+MZHOk/aZe3PKiQ3rBSCrLmuvjvKruswMDZCqdNRb6iNJdqdsoAemeeWnCxfuRk/pVLoUt3D6Po68O1CCDncy6OB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MN2PR11MB4519.namprd11.prod.outlook.com
 (2603:10b6:208:26c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 14:38:22 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:38:22 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: RE: [PATCH v3 1/3] wifi: iwlwifi: replace use of system_unbound_wq
 with system_dfl_wq
Thread-Topic: [PATCH v3 1/3] wifi: iwlwifi: replace use of system_unbound_wq
 with system_dfl_wq
Thread-Index: AQHcmppysYD8ss9/6Emp9qUxjeSMl7V8AEDQ
Date: Tue, 10 Feb 2026 14:38:22 +0000
Message-ID: <DM3PPF63A6024A9C19580265F85C5200610A362A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260210143332.206146-1-marco.crivellari@suse.com>
 <20260210143332.206146-2-marco.crivellari@suse.com>
In-Reply-To: <20260210143332.206146-2-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MN2PR11MB4519:EE_
x-ms-office365-filtering-correlation-id: 236f1cd1-aec0-4331-62a7-08de68b20aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YStnUDNydTVyaDE2WTd3SHpWcWU5eVdZRGR4eFlDYjdqSTBTZENOMG43OVQr?=
 =?utf-8?B?cTJSRjlzOG1hT0FhRFNtUjd6Si9zVzZ2djQ5WEJBUlFDVFlWRzFjOTVxcUgx?=
 =?utf-8?B?VnFwM3JNUmRQc0pNK3dLUkwxSHBkQWdvcEpicWNJb1Z5TE51eHQweHdRTDgr?=
 =?utf-8?B?UGluSmhxL3k2R21OeU1TOUJOR3dYV2s4Z3ZCZ25QT2JmZkNzZTlHYjVDQnE4?=
 =?utf-8?B?cVhXNmZjbGVpQXd0VllWeTBrSnNEQ1NkSkRBeVlEcWsyVnRlSDU5ck55azIx?=
 =?utf-8?B?WjhuSEI0bzFOa0hHK1l3dHM3Z0tqN3VIdmZLUDZJcENSK0kxWWw3cENXSU5s?=
 =?utf-8?B?WmxEbEtGQlE3R3VJbUI3Z0ZTMFFteGxqV01RaVg2QVk5STJsak5NbmFBRVNR?=
 =?utf-8?B?QnVrZ0hJU1Y1NlJ3Nm8rUU1GNEp1OTVwY1hiV2lRZ3BnZTZNTmwxVDJUZXF6?=
 =?utf-8?B?cEJmT0tOVlMwemVYSlVaclZScG1Wa1U4Um9uSHRkSnhYaS9wMnJUQi9HNW5p?=
 =?utf-8?B?MUR4enQvN1M4OVRZcXREOGRvRmk5SkIxVjNJWmcraDV2Qy9jRkRwSUI0WXBp?=
 =?utf-8?B?TUhPZWxSaEwwU1BSYlpkNGpnMVZaNW1zeWtCNWwrVDFLanhXMTcrcUo3QkJl?=
 =?utf-8?B?Rm5qT2Fab3QzMGdiZmRGVHJmaTJIcXlzeExnRCtCU2FQMGdmZzgvRm5ZK0FD?=
 =?utf-8?B?OW90N1lqRW9rck9rS0xoMXpzUzNUVE03NG5oRk9zcmJIZzlYc2JSWDYvZzd5?=
 =?utf-8?B?UHFmRjN0K0c1aHlza3JobGl5bE9vNXR6TlFQMmJ1bFlqeFdpc1VFd1k4TnRr?=
 =?utf-8?B?blFpRUJJZzZ4RTFZSGJmdVBqa3ZmRk1CUjZWdThZZ3lqeXhqNml6UkQwNFox?=
 =?utf-8?B?UjR4SGFqUWVYSm9YLytMSmFwcnp1cTRkeUxmZUxvM1NXVVhrL0d2MlQxT1RR?=
 =?utf-8?B?dktkY3V0TE1uNk9maE9BaDRBZDNnRjlwd3JONzdSL2JkbGJVbXpLU3hBQXFQ?=
 =?utf-8?B?RFBkRkxJL0x6VjFXTEM1VCtiVHoyOFN2OG5Sb09iRGwxUWI1S3Z1RG5MSU5z?=
 =?utf-8?B?bmxTZitvTGxudzIyVTBwOE1YeUJWamZQcEVHNGVaMXZpVkg5ZjJoNFdGQXRT?=
 =?utf-8?B?dzNoUW9IcVpGM1d1TVI0Z0MxRzV3dnBTZDJGNUFnL0dldkQrMXRsYTd3eHgr?=
 =?utf-8?B?RndiVVhBallteTIzMXluWUs4d3lPNUNQbkcwZzNocjF5RVR6UHBCL0YrbXQz?=
 =?utf-8?B?K2d2MXh2TzE1Q1R1cVpnYjJnZi9rZlFlakU5aEpYUWJhZTNTYjNzeTF5aUdx?=
 =?utf-8?B?bHhMSTk5ak1Cb1pHaWltRzRHNWJXRmJkZnpkNUdEeGJSMFhtUU1iWVJQMlVI?=
 =?utf-8?B?dk90OHZ3S3RRRHlXWFFyZHluUWoyYzl1V0xoaWhPRlh2dGRWdjc5MXFuS1FW?=
 =?utf-8?B?R0VoNittWDBtc1V0c0tOS3g5RDc3RDJ2ZWRJZUhvNTlmSGtQRUhVL21KNXRh?=
 =?utf-8?B?UW1PeW9PWEdzV0tiOEV2VTMrTnBjS2FjTTJhdTJUa0srREUzWHdUd1lKMU5p?=
 =?utf-8?B?TzlyZE9XYnZjbnljVWxaOXRsL3lnWEM1U3dDT3podk9nSFJXK0tSZ3BMZEJj?=
 =?utf-8?B?bk1qTDRRdkJKOHl4czFaY1RLOUZ0c0JIOHdRWVUrVlNUa2ZLVEVOZWE4ekt5?=
 =?utf-8?B?K2h5Vk5vTSs5blhFTUZkNzdxeStkanBSSEtlYlFRTjdSZjVYWCtpeks0MUJa?=
 =?utf-8?B?endLRkY1MDZ5d0t3RmtDOG0vNURKOVA2bk1uY3B0bjhPMzMzTEdCWG1Rc2ZG?=
 =?utf-8?B?TFdvbjZ3dzM1QSs0b3BMRHk4NUV0dTNKd2d4ekQybFB3eW9QREZBU1BoQmh2?=
 =?utf-8?B?QWo1cmhHbHFzS3pycytrck1UV0NqcTZ0Y1N0NzJjVnU0eDdQczRBVG1Ickxw?=
 =?utf-8?B?M0gzMm53K1lHaVBYSjRSZnl3Z3Q2SDlKa2VoamRZRm9OeWZPOGJrSS9jTnRL?=
 =?utf-8?B?NFJaZ2VYeENHaXdjbm0zOE1VejFxSE5qYkUvbzFNc2N6WGNQZHBtT0Zwc3I2?=
 =?utf-8?B?dXl6ZE4yUTlqbVhiRGdOTnRNN0JRUHdXNGQxRzZaRzZLZnd0QWpiUGJGV0NN?=
 =?utf-8?B?UDJyczl1c2w4YjZjZHB6ZVlXTThRd2pPOSs0OVRpQ0prbUNoL3NmMThEdHhq?=
 =?utf-8?Q?my6qOuD29dYaQEuqBbiG2z4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE81SVlpTzBXMGIvMUdObCs0OWlibHhEZW1Ca3pnTGQ2STFLbnZEK3FCK0lF?=
 =?utf-8?B?ODE0RXM1WGthOVFZSXdjNUw2Z1dzTWpNcmlUR2Z2NndOa2xNbVEzanliaU5B?=
 =?utf-8?B?WXNVRHF5blMxMnpMYTFmRFdFWnV0eHhHblJBWG9XblZiaktMbmE5S24yL3VS?=
 =?utf-8?B?SXlwbktqRzJ3OEh0aFhDU1Vyclc5TnVIRkc3NUdhNVVaTDJuT3ZFUG5temls?=
 =?utf-8?B?K1czRzFPTWJ0VWZxaEZXSkduMWs2dzJDK1ora09yR05oWjZQV2MvWklqNDdy?=
 =?utf-8?B?ODZDZUU3bGlIQlRXdlkxVHRrQXg2SzdQRUtINWlVVG5CQzNjR1A5dTVLZyt6?=
 =?utf-8?B?bjVTRVFsakFGOFFWb09HamlUTjVhVEdkS3Y1YWYzT3lCVlYzdndUV1hyekVM?=
 =?utf-8?B?WnV2UzdIUmhCaXIzaHpOaXYzV3RLYy9HeUxhakJCMVMxK1kvWVZWaTkzcjVI?=
 =?utf-8?B?Tm8rMEdXd0FPTnRjaDVJWnBTSW11aENNdzN2dll1c1ZsdmRySlBhTVMzSXF2?=
 =?utf-8?B?RStlSndNZk9kcldJRzRXTnRjTXl6UXRSSkhoNzFuVUF3d0h4dkVXOUNpejBT?=
 =?utf-8?B?QStXZkU4WlpCQTJwd1Fid0JJcm9yaW1EckdxdTJhb0ZuRUw5KzJrVUpqVkhB?=
 =?utf-8?B?UjlFYzRwRFl0b0pIN0ZDdUVySVJRK1VlZDlPWkNURmczYkdBRzFoYll3MTB5?=
 =?utf-8?B?TFVnRVlIaG5Lbk43SnFNdWxIMXI4RVNKRGNyc1lzZWFDUmE0bStNc1Zldlg1?=
 =?utf-8?B?MGt5UFdjZlFhbU5PUHJJQ1AwSndzcUI2Zm9kQ0FteDNRMXp2WTRpcEIzYjZM?=
 =?utf-8?B?cmtEczcxRmxCMi83RjQ0VXpsa1ZVdjkvVVRkc3NOc0VqclFwUUhQcEhSN05V?=
 =?utf-8?B?empDQS8zamMvY0w1UEI0TmtXSnVVclJWWmt2OUV1R3JadGpxcXJZcTBwSHVG?=
 =?utf-8?B?K2lwdzRpcmFXalhqMy94L1lwUFRLRGoydGdYMFVRQ21KVlZZOHRNMFVMOW4v?=
 =?utf-8?B?VGd4K2dBdExPeVNwVHdxM3Rab1dPQmkzQTV0R2d5NlNXcDJOMGE1WXRhM3J0?=
 =?utf-8?B?N3BoNnQrQ3Nvajl6VUFvcXR0OG0ya01yV1NQanNWekpmM0FlcjVKb3lFV1NU?=
 =?utf-8?B?QXBwZWg1ZGoveFRwdGJ2VEVjVWduU2lQb2hORDF5WlJ3WmpxTk91am5QVDlG?=
 =?utf-8?B?emxUdXV1c2xHYnVuYTJyaFNvREN1emxabjVlQWJsTGNpbEkrTzV1Vm9MUWlm?=
 =?utf-8?B?ZHVnYzFWTTc5U2RPTlpKREFOWWRvN0FIaGF5QkRxZ2Vsb2ExVG5LcGZFakdE?=
 =?utf-8?B?Z3lvekx2d0l6dWVmbENXdTZiTmxvRFo3UWQzUm9haVBqOGY0c1E4N3FscUkr?=
 =?utf-8?B?cUNQTWdCMHhzZDF2OEFnNGFLVlQ5WEYzeGttMnk3cHNqUjNxdG5VMTdCWmE2?=
 =?utf-8?B?YWlEOUdmbFhCdWZKNGdiK3IyMy9GeTFSOC9RdzgwcXlyNnlDQ0dNVE8ySk9n?=
 =?utf-8?B?Y2tBZ0wzR3hMYk4ybmxWZ2U4OU8rYlVkanRQTjVVSDdPUHVnY3N2Mzg2eVBG?=
 =?utf-8?B?TWQ0T0JOVmwzVmxEV2hMMm9yUlhjZXBCdnVRNktaeVg1MCt6YWx6a012TDlO?=
 =?utf-8?B?YkJWOVpNZGRsUWEwTlBGVUV4U3RNcFJVUnR5NWZ4U05lK0RvQ0tTMGhSYkVk?=
 =?utf-8?B?bnVJTVF1Zmk0eUNKcWlnKzZRVlBrQ0tFWDY1L25MbWVGNHRaVlg0Njg5enZ1?=
 =?utf-8?B?Ry93OUZ2bGVod3kxTkFDOFpBTndHVUZERGRCU1BPT1V0RGFQM2pQMVhzNEsw?=
 =?utf-8?B?WnBPemJVVm1lM2tZdnJpN1VSVFRhV2tFaTQ1VmhHVVB3UGV5dDR1NDBOSVBj?=
 =?utf-8?B?TEdhbWlNcDlRa2lCcDJPWTV3L0dOR2ZmODRxQmo2Y1FmVE9xSmQ1ZlRTcWRu?=
 =?utf-8?B?MytrMlNNeTZNSFppYlo0VDRyVG9TNnN2ekNkVUZlVEFwNkowWkZYdzBraE5C?=
 =?utf-8?B?YXlPdG13Vk9PeDZDYWc5ZUd4c3cvaDJDd1dnVFlERUZNWlFjbktUYjFwdUhS?=
 =?utf-8?B?WTRpU1NEemQ2OVk0SVI5TnNjTTZIQVdndWdrcVVFTVJtSnlMOW9xTStqSGVR?=
 =?utf-8?B?M0U4ZTRkdkd0ZHNveXRGNW1yQ2o4bHRGYUowODRaK0tNU2FyOExRQSsySmdS?=
 =?utf-8?B?N0lsNThyblNpV1VLalB6K1J6UlRXQVIrSDJWNHNGOU9UYTZyNFd2eGZlRDdm?=
 =?utf-8?B?WHd6bUp4QUNEQS9CR3IvSXQ3OUd0Y3pGNUxDSzJ3blpDNTVrcy9FV1IxS25x?=
 =?utf-8?B?V0F4bHRZanFIVFQ3bThLVzVKelRKS3pMc1Z0WnR4WWtWcFcxbFYzSUVTSzdW?=
 =?utf-8?Q?LVCOAPTFJv22bR8M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 236f1cd1-aec0-4331-62a7-08de68b20aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:38:22.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGZWJSXm6DCdDfSBOmaagYqPoPORFQTKFyVadFHK15Fnv7Ib1TKQeLp5c50tOQ7M9APuqYj0wjo+4mkTVYgyYkv9ICuwRXJg7GeEEOx7vco3wDxTUIUlb9BlvzEDskG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4519
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31703-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7194011BF87
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gQ3JpdmVsbGFy
aSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkg
MTAsIDIwMjYgNDozNCBQTQ0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5v
cmc+OyBMYWkgSmlhbmdzaGFuIDxqaWFuZ3NoYW5sYWlAZ21haWwuY29tPjsgRnJlZGVyaWMNCj4g
V2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz47IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdp
b3INCj4gPGJpZ2Vhc3lAbGludXRyb25peC5kZT47IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNy
aXZlbGxhcmlAc3VzZS5jb20+OyBNaWNoYWwNCj4gSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT47IEtv
cmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwu
Y29tPjsgSm9oYW5uZXMgQmVyZw0KPiA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU3Vi
amVjdDogW1BBVENIIHYzIDEvM10gd2lmaTogaXdsd2lmaTogcmVwbGFjZSB1c2Ugb2Ygc3lzdGVt
X3VuYm91bmRfd3Egd2l0aA0KPiBzeXN0ZW1fZGZsX3dxDQo+IA0KPiBUaGlzIHBhdGNoIGNvbnRp
bnVlcyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9yIHdvcmtxdWV1ZSBBUElzLCB3aGljaCBoYXMgYmVn
dW4gd2l0aA0KPiB0aGUgY2hhbmdlcyBpbnRyb2R1Y2luZyBuZXcgd29ya3F1ZXVlcyBhbmQgYSBu
ZXcgYWxsb2Nfd29ya3F1ZXVlIGZsYWc6DQo+IA0KPiAgICBjb21taXQgMTI4ZWE5ZjZjY2ZiICgi
d29ya3F1ZXVlOiBBZGQgc3lzdGVtX3BlcmNwdV93cSBhbmQNCj4gc3lzdGVtX2RmbF93cSIpDQo+
ICAgIGNvbW1pdCA5MzBjMmVhNTY2YWYgKCJ3b3JrcXVldWU6IEFkZCBuZXcgV1FfUEVSQ1BVIGZs
YWciKQ0KPiANCj4gVGhlIHBvaW50IG9mIHRoZSByZWZhY3RvcmluZyBpcyB0byBldmVudHVhbGx5
IGFsdGVyIHRoZSBkZWZhdWx0IGJlaGF2aW9yIG9mDQo+IHdvcmtxdWV1ZXMgdG8gYmVjb21lIHVu
Ym91bmQgYnkgZGVmYXVsdCBzbyB0aGF0IHRoZWlyIHdvcmtsb2FkIHBsYWNlbWVudCBpcw0KPiBv
cHRpbWl6ZWQgYnkgdGhlIHNjaGVkdWxlci4NCj4gDQo+IEJlZm9yZSB0aGF0IHRvIGhhcHBlbiBh
ZnRlciBhIGNhcmVmdWwgcmV2aWV3IGFuZCBjb252ZXJzaW9uIG9mIGVhY2ggaW5kaXZpZHVhbA0K
PiBjYXNlLCB3b3JrcXVldWUgdXNlcnMgbXVzdCBiZSBjb252ZXJ0ZWQgdG8gdGhlIGJldHRlciBu
YW1lZCBuZXcgd29ya3F1ZXVlcw0KPiB3aXRoIG5vIGludGVuZGVkIGJlaGF2aW91ciBjaGFuZ2Vz
Og0KPiANCj4gICAgc3lzdGVtX3dxIC0+IHN5c3RlbV9wZXJjcHVfd3ENCj4gICAgc3lzdGVtX3Vu
Ym91bmRfd3EgLT4gc3lzdGVtX2RmbF93cQ0KPiANCj4gVGhpcyB3YXkgdGhlIG9sZCBvYnNvbGV0
ZSB3b3JrcXVldWVzIChzeXN0ZW1fd3EsIHN5c3RlbV91bmJvdW5kX3dxKSBjYW4gYmUNCj4gcmVt
b3ZlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRqQGtl
cm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNyaXZl
bGxhcmlAc3VzZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9pd2wtdHJhbnMuaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2l3bC10cmFucy5oDQo+IGluZGV4IGE1NTI2NjlkYjZlMi4uMmYyNGI2MzljMTMz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10
cmFucy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRy
YW5zLmgNCj4gQEAgLTEwOTIsNyArMTA5Miw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpd2xfdHJh
bnNfc2NoZWR1bGVfcmVzZXQoc3RydWN0DQo+IGl3bF90cmFucyAqdHJhbnMsDQo+ICAJICovDQo+
ICAJdHJhbnMtPnJlc3RhcnQuZHVyaW5nX3Jlc2V0ID0gdGVzdF9iaXQoU1RBVFVTX0lOX1NXX1JF
U0VULA0KPiAgCQkJCQkgICAgICAgJnRyYW5zLT5zdGF0dXMpOw0KPiAtCXF1ZXVlX2RlbGF5ZWRf
d29yayhzeXN0ZW1fdW5ib3VuZF93cSwgJnRyYW5zLT5yZXN0YXJ0LndrLCAwKTsNCj4gKwlxdWV1
ZV9kZWxheWVkX3dvcmsoc3lzdGVtX2RmbF93cSwgJnRyYW5zLT5yZXN0YXJ0LndrLCAwKTsNCj4g
IH0NCj4gDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgaXdsX3RyYW5zX2Z3X2Vycm9yKHN0cnVjdCBp
d2xfdHJhbnMgKnRyYW5zLA0KPiAtLQ0KPiAyLjUyLjANCj4gDQpBbHJlYWR5IHRvb2sgdGhpcyBp
biBpdHMgcHJldmlvdXMgdmVyc2lvbiwgSSBzZW50IGFuIGVtYWlsIHdpdGggIkFja2VkLWJ5IiDw
n5iKDQpTYW1lIGZvciB0aGUgb3RoZXIgb25lLiBPbmx5IHRoZSBtdm0gb25lIG5lZWRlZCB0byBi
ZSBmaXhlZA0KDQo=

