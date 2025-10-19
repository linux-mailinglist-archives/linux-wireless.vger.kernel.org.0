Return-Path: <linux-wireless+bounces-28083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA5BEE4B2
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014AB40424C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805172580F9;
	Sun, 19 Oct 2025 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBrLQhBS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D7366
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760876369; cv=fail; b=By2bjWfjeqbtFsmfuFl0Lha2HSNojadgMspAvkY3YowhXsWAYV0vtiM2FC4uzmVrCCYSZ51/TTRiRU+rxUFIPbZ8/ujWLhlkhPTum/x5q53tohIhQjNsAsXT3MvFXD9IvRhnj0LCYaWMpr+ZzOtyv9gm5AEAA87UmsDQN3Wv4ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760876369; c=relaxed/simple;
	bh=hdzWmsjgmaJtwoYcKOPmTN7mCskmBwiVBknynFIkfew=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BV/0AvF1/WBq0KT86e4IIs1EvMPrDh3eF+Fs+QMt6wVaxfU19qFcKlrIXNdMM/NCrBmUi5YOscNpwofh8buSvff33OXe0DpZuBQSmqy1LBe49bA25i65AAtOLp+W6UjmFV0PfXxWFOE8pARGKubhMGTeWAhTSS22WLK2YHrllJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBrLQhBS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760876367; x=1792412367;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hdzWmsjgmaJtwoYcKOPmTN7mCskmBwiVBknynFIkfew=;
  b=UBrLQhBS2lJUGlI/l8dIJBTU80FW4wpBckeAbqt2RIbuwYQRX2gZKhmR
   OmV9u5l3A1qm+FDrcgAY41uGAPk/9K7XjaQZecrp1vg/584xa6IDnN9yu
   8LnndBaNrUtsX0myxZJM2L5Lndviyt7jO7UknNs7RyKpky3Qy3atj1WiP
   Ppov5FVAMCJlQ+xT5/0Xd07pnlXUD/eYX7yLAUA+Rwz8wiL1M8dEaFYEk
   2UcdG+UP8wTclgA5kc7VcPK1v/MfLr74ynpOTsYhL+SFgXuUtkFZlT8Ae
   HWhK/PuOtLIgiuv103zTfbFhhnKE7xxz6UclScg/jRzg9aIK39HckHpmo
   w==;
X-CSE-ConnectionGUID: sM3Xq2KJR7ucy7xd/+ZreQ==
X-CSE-MsgGUID: QaHnp+YUQL2AYxNt9YJvYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63169649"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="63169649"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 05:19:27 -0700
X-CSE-ConnectionGUID: fXs0zlQ3R4GNlA52drwbAQ==
X-CSE-MsgGUID: Aepm6gc0ScO87vJMZlSBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="188419940"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 05:19:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 05:19:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 05:19:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 05:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7M8QZa3AL8A6FOUWe3f/efpMDX88GTWerW70L1hgVXeAmjVBjedvBgA2jSHF9BZ5DYv9nJyh3t4y0SW6ZhGJ0Pc2rB5MRltjky+S4Rsi4q2Z1WlaFvb+hNCO96SAnf7mZVqGW1OzN8fyg0Rwi6I0gKOxnsDqC46cgrkrQ8/uoYyUZDLhSUPjAECNiFA7GzdmC7AlBTB37HC2cTh3J4O+87CoMDOreXtWrEZcGMHcEcrEenh789T+ssmJkCIEXlC8vuqZeXhu1cmiMafw0GBYBDABJkXNfodiUF/fI+lBgafxL7t18i8znc12+YeUP2hfEOMAlZOCWdB9rDShpP7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdzWmsjgmaJtwoYcKOPmTN7mCskmBwiVBknynFIkfew=;
 b=Uw21n5iVO4eo3u0tPvjRi7vAjczl+PrkvtF597+sIcjwKdH8prLFozNby/FXuZJxYA0C+wxZptDafrxtM5DStiNXc7XH9rK9Z5ny3BmfnUmPgA2kUIBe2yc3LeLdfOTUtD30CXuejHuwh8JqwrKi7C99j/+bkpUemahep1okHOXhWsJn9aPNV0mzx5DqLSY2CbbqbqFfQIJhJzvQ1QWEwZX98QCkgIVWNYkKxxKs1QR5ImJ/ynNaR70+lX7hGdr59NsfNq4jI1rUFscojhfAi8C9w2r6rQGWXMdQ1Ut1tAxvOIfdukc/tUMNId7aHm2PS20UQVmvkQkgUQwJkXEtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH7PR11MB7571.namprd11.prod.outlook.com
 (2603:10b6:510:27e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 12:19:18 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%7]) with mapi id 15.20.9228.015; Sun, 19 Oct 2025
 12:19:18 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Linux Wireless <linux-wireless@vger.kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: pull-request: iwlwifi-fixes-2025-10-19
Thread-Topic: pull-request: iwlwifi-fixes-2025-10-19
Thread-Index: AdxA8mkl3edCKrCuRg6rGRqitXB+VQ==
Date: Sun, 19 Oct 2025 12:19:18 +0000
Message-ID: <DM3PPF63A6024A9AA24A98F889248027FC4A3F4A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: 33fa94c0-538e-4750-dfd6-08de0f09ba10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dVZYOVZQek9ubTZjYVB0UUF5aVN3TktuYmNOaUkyS3N0bllrWldsWGxiRCs2?=
 =?utf-8?B?WC9BbU9DcXVCWU1lSnJxc2U4ckF2ck1UVzVLcC92cGx1bGpZcUVxOERRMHZx?=
 =?utf-8?B?NEc4UVd4VWNySXdrbVJjUC9zV0s2ZExPRGc5bjBKWGRpT2NwYzZsUXk2UnFF?=
 =?utf-8?B?TVdhU3VZck5jU1FwdnBMK0FYekQveGxaMHJpTTBzazdkdllOZk81ZjIydDl6?=
 =?utf-8?B?N2tvdXlnelY1NFVkbjcyd3VLSndaNEFmSGwveEhBTjVNUHlrWVc5VlJjWkla?=
 =?utf-8?B?VEF3MjF2VXNpd2tPWXl3TVo3NE1wbXczdFBIdHF0cU5aMmtmM0l4WFVURWc5?=
 =?utf-8?B?c1laY3NvMEtRNWxQQWUrbzQ4L3VYM2FSKzB3VTRSZWttSk8vVHdybmV4QzNi?=
 =?utf-8?B?cmdnUDdZaGZpRHFyME5KeldyVW9DcXlYYjU4dVVEbmtBVHpxK3R1MC90bUFt?=
 =?utf-8?B?T0Y1NnVFWEE1S3hiTnRmdVNOaXpwMXlQR21NUjE4eFBFemhna2JyNzlIYkF4?=
 =?utf-8?B?Y0VOcWRCQ05MMDVYQzFNdzJVUEdPU1VrWGVCL2YvbW5aUFZWTUk2d0xiMVpw?=
 =?utf-8?B?bytCRmNUamxnTXI5bjhNcjU3enhXdHRpby9OUUVNV2M5ZDVGeVNWV21HTDBN?=
 =?utf-8?B?c0ZUZ0FHd0QxYVUzUCtvYXpQUjhZUjRjVUJWSVNhek81cXBlTkMwem9vUnJN?=
 =?utf-8?B?cDEvOHVPWWI3SEZjSi8xY0E1VFIwbTE5VjVPcDVWc1FVdW96RlEzaWh5N2NR?=
 =?utf-8?B?RmFSNm1sS3FjaEJuV0lnNlM0UFQ4VEp3MytpSHloY2FqTXJaVjRoNlZLOHUw?=
 =?utf-8?B?cFp4N1RwekZnY05nblc5aFViYXV3TzROUHcwUkJTRUhkZDRzVlp6TUJYTkhu?=
 =?utf-8?B?bVpMQjI5WGFvRDZFd1hFcmRuQy9MUGV6RldPMjJuSUM2VWh0YWlQbElocEZB?=
 =?utf-8?B?MDJiR1FUOHdMaHY5M0tnMkQ4R25uTjRVaEkzRW5nbnB5OXI5ZzJUOHpYOWxr?=
 =?utf-8?B?Z1Iweisrei9KbU41RktLTU9YK3liS214Y0l0SklySkJOaUFxT3NKK3hqWnlV?=
 =?utf-8?B?OGRCU0dkd21hUG9DdmFoWm9sRnYrVmZCMGl3dm5HOUovR3pSZnRYWFRtWHVs?=
 =?utf-8?B?cWRQWXp1MjFjU3RXQlBGZms5THJqUDRnZzJuRW9XUCtWSzZwbGhZa1ZyT1Jk?=
 =?utf-8?B?M0NVL0NzYU0xZU9sRmtKOEVPTUxLMzROdjBQMGhVVDF5aXV0clNhbHFIVGM3?=
 =?utf-8?B?OHZneFJxeUVsdXdqaEFKaG5Ld2tkaUlWRE5aamhkaDhtV1l6b1lkWkJwQ2xX?=
 =?utf-8?B?SlA5cGlucVF2bzV4L0dkSzlRRzZDQU0rV3BtbE5EMTJ1UTAyYTQyR2tjbGRE?=
 =?utf-8?B?UGxUbjhEVmxsZ0VuRzAybHBkOWdKR1VPcjI2c0VlTUpKRXYzbEd5ZW5TWW4y?=
 =?utf-8?B?YnUyMlV6RjZmNHlMemdsTzVhODBSWjg5aHJBK1NwOGRxMnVBbWhramRpOXRh?=
 =?utf-8?B?T216L3ROaXVBWXlFaThPT3pwZ0V4d3JXVERnbEp2b2xRdFRvSFkzb1RnRW93?=
 =?utf-8?B?VmcvTmM2T3BjUFEyTFgyektrdFFMblh3QWdTZHVCTk9scGVRaXNFd0ZyaTBi?=
 =?utf-8?B?eEFPQ3IwQW02N3N3UnlRT2dybzZhdzg3S3VYTlRJK1psNkU3VDdBdU9kWHI3?=
 =?utf-8?B?b2RTNjFUMStpWUExbzF2UWRqaHlmYnMzT1RXbHhTSHgrV05Edmxhc2tNUkhF?=
 =?utf-8?B?NzIwSExzNWJQVlZXa1FMS0EwTkM4VkV2c0xSTnlWRzdoeFV6OEFHWkNlZXhk?=
 =?utf-8?B?OERQcngwb044SDYxQ1U2R2ZibDFLZXMzc2R2QlcvNEpKcmFwWDh0aktQcmFx?=
 =?utf-8?B?aFVWc1hDNEt4ekZjMWhudUV4bnBGNTMwR0NYTE92eDdKcW5wdDBDUC9ocTJS?=
 =?utf-8?B?YmszaFJQWExuZlVIYzJ5VUxweWJwSE1yNlN6VjJ2dmJ2SExHeVgxVGFubmxs?=
 =?utf-8?B?ZXBMdGtzSkhiN2tyOVV4ZUttOG9GdEhUZjZxYWZRbTR2MlE5aVBscno1Qk1M?=
 =?utf-8?Q?JN7Iq+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejNyUjhuM3RHSDNqV1VXSHJRMllBYjgzK255OWNhRUZ2dnc2UGw5MHV0ZUlV?=
 =?utf-8?B?ejVVcHNIM0I1WU8wMW0zSlRPSFhnRndLQUU3QXNYdU92by9mQXVLOTJjbWth?=
 =?utf-8?B?YzY0bWpsbXZxWDZ2SHJyNGZMNi9oZnBlRG9tRXJKanVRakdxN29tbEhtaU9v?=
 =?utf-8?B?ZmFCODQ1dXRlWDFXTkNJVmx0LzVxOWJsQnNLK1d0WEpraElNamhMb1F5SzRM?=
 =?utf-8?B?bktpRlVrQlJ5SUtId1g3eGpFUURna0VucTNZaGdQTmRIYk5LZnRqb05QUXVS?=
 =?utf-8?B?TEVLZlRzYjZhaXFkUmNocVVWaTJwQ052Z05DKytEajNXclZsZmpUMVBsNTRu?=
 =?utf-8?B?MjIwOHJBTkxNQUE4SHArejZzU2E2MHc5R2tLWjdsaDZEUWFEY3FoL2QzNjd0?=
 =?utf-8?B?dk92NHBhTFR6UEUzNnF4c1ZNSHhwNXU2UTlqSDRQUnhHNTBWRlVjZG01bEVE?=
 =?utf-8?B?Nk5BalJOZzgvbFkzRWRVcFNwaEQvWmkyRzk2eVNWSUFpbXR6TzIzRFM0ckJq?=
 =?utf-8?B?QndsL0xEWStXMFdaZHJEMVo1T2ErL1RKNmV5bG9aVU1SKzA4c2VhUFlTQVlW?=
 =?utf-8?B?Tml0bWRvWWQyNnZGcUJQSHc1OGpQTUhBVXJBMTEydEUyQ3E5MWxZV2JvbVlG?=
 =?utf-8?B?bzhvK1I0K3NqWjhqNEhBejB5Vng5cjJhNDBScVZLVUJzbFV1T1NCOW0yT0Yv?=
 =?utf-8?B?Rll3TEJTV2dSQmNGT1g2SG42TjdrVDZMNkNXTTlUTVlVbHFmUTV0ZUplYmht?=
 =?utf-8?B?RHM2aS9IYlplSDI3TTN3V2cwYzBXQSs1WSt5a2tOeTIzUitjcHpvMG83Mkcv?=
 =?utf-8?B?WEpOTjBFN0s5akl2Ni80VzdiOTU5TFpmMTBrRS91ZjlRL1E0bm15WmtBb2l6?=
 =?utf-8?B?SlIyamlibjhjaEZIYzMrU1RxRUtOaXMyL25lQnhkT2lZLzVRdGozYit6cDJB?=
 =?utf-8?B?SjlLSkJ6bmpGWjBRVVVNQ0EyN3hGQzh6M1FOMnQ3WG5UeCs4em96RFhueWhJ?=
 =?utf-8?B?UTNQU3lIeWdydWswTFZCdmVzMUdMblFaaHVBOWJESkFxWjFJVmJGOGRGeTdB?=
 =?utf-8?B?OTZZbE9EdlQ2a0RUZ0svbHY5K1VhWHMwK3U4bUxLYm41cUlzTlhxTlFoMUQ3?=
 =?utf-8?B?eXJ3RHErcGhEYXRSQ2lFb2huN0d3QTJIVEQrWkdVazUrRi9mVU1yWDRKbXJs?=
 =?utf-8?B?dGV2alZjWkJpdGx5V3p0bGJSU1F4aWMxaVY5dWtaTStKUmlCbVl3ZXNJcmFv?=
 =?utf-8?B?M3JHNjNDNUF4MU9SYk5zR0x2TEc4V2d4QjN6dUZySVhCMXY5ektta1IwbVNt?=
 =?utf-8?B?d01wN09CZHlZOU5ER2gyc1ltY05KQnBGQ0xUMU1ib3pUKzBEY3lMZXRjQmRh?=
 =?utf-8?B?aUR1VjBNaVV4TFI5TnFURDR2aWpKbUtIS0lxZE9nTEVNTnd4TWxlV1FEMDdP?=
 =?utf-8?B?OXJKV1dpcmk4N213SndlRjBVeUZKTmJHbDRUNlZ1bVRZYmJnVlRBM2p6M3BI?=
 =?utf-8?B?OWNjTUN2MHcwVUpjQ1A2YUs3UHV4V0pPWjBHam9ZdnFkc3VBYVM3cUIybmpx?=
 =?utf-8?B?NzkwVDhOdkw1WXp1NUtPM2kwbnljVTFtcnNHQ3RPNHVTRkpJTWJmNk1KVmtk?=
 =?utf-8?B?akhHMS9YcjIwNlhMTUZwODFETE1MZDYvZDVCbERvbGQ1NmZjNTlPR2U5UlZr?=
 =?utf-8?B?WjZuWnVMUkV5S0ZBUWVJMVRPT0Y2bkxacUhjdjlyNGd4Tk9FYWVzL05CREtY?=
 =?utf-8?B?NkMwTDZjQmp5WUZ4QUFON2FEcnNvYkxKMFJEa2lLamNQRjlMZk1rV1N6OFdx?=
 =?utf-8?B?TEJibWluYjQvanlGa3ljRFpRY3N2dVUvK3hieXViaVN5cjNtVm1VMXZ4eitN?=
 =?utf-8?B?MlFRRldCcWkvdlcveTV4NHoyckRuNExWdHdmL204V2VrY20ybDhGYm95YjRh?=
 =?utf-8?B?a2oyUllmVFlqWnFGbkJvbHpYQlB0V1FKTmU4ZU9OSE02T2E1UG9OMzAvMEZr?=
 =?utf-8?B?TWhpYXpuMzJhd2hJbXFUSEVLT0hXeit6RDR2M0piV1R1OWJoUmNmNnRaRG4x?=
 =?utf-8?B?dFE2YktoalNhUlo5R2ZCTko2UDFYbGd5R0h4VUMwVTA1QlRZbTZEdjArOTZQ?=
 =?utf-8?B?RXNieWo4MElDQWJSZ0gzSzc5eFFwSVNCOEE1WXVTQU5uWFlJYTI3TDE4OC8z?=
 =?utf-8?B?Q0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fa94c0-538e-4750-dfd6-08de0f09ba10
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2025 12:19:18.3458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Mncp0XK6fnPOA/C9gM95EA/pCefLxNiKwarTjSfU0NIo3AMLKOMaJbtn9/5TXO2BgsPebwHTrc05an4lJZcOIm9vvhlsSP6YQ51O1K9By/Lww2rscQtjF9b8GduUiF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0ZmY3MWFmMDIwYWU1OWFlMmQ4M2Ix
NzQ2NDZmYzJhZDlmY2Q0ZGM0Og0KDQogIE1lcmdlIHRhZyAnbmV0LTYuMTctcmM4JyBvZiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldCAoMjAy
NS0wOS0yNSAwODoyMzo1MiAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAyNS0x
MC0xOQ0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNzdlNjdkNWRhYWYxNTVmN2Qw
Zjk5ZjRlNzk3YzQ4NDIxNjllYzE5ZToNCg0KICB3aWZpOiBpd2x3aWZpOiBmaXggcG90ZW50aWFs
IHVzZSBhZnRlciBmcmVlIGluIGl3bF9tbGRfcmVtb3ZlX2xpbmsoKSAoMjAyNS0xMC0xOSAxNTox
MjozNiArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBmaXgNCg0KYXZvaWQgdXNlIGFmdGVyIGZy
ZWUNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KRGFuIENhcnBlbnRlciAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBm
aXggcG90ZW50aWFsIHVzZSBhZnRlciBmcmVlIGluIGl3bF9tbGRfcmVtb3ZlX2xpbmsoKQ0KDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbGluay5jIHwgNSArKystLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCg0K

