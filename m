Return-Path: <linux-wireless+bounces-26752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C28B39C13
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 13:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36157C56D0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DB30F527;
	Thu, 28 Aug 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnmC/cGr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0413C9C4
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382323; cv=fail; b=aHaDn+YIMZUUGsd+6+sXr6jN1Y1s307Naa/Uv4GDCMigiJX8810BWXAwxMuqe5UPRbHXRLV1pUB7LKVjEnb6MuEUIe7q03KZ2NzG2H/8X4ocE5w61yknkxdAfx1oUs/BPiWYp4NDDtGVrAHxOuTSVmaYSR8vVHoNYnJZrf5F30U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382323; c=relaxed/simple;
	bh=ReI+FIYDBdq2yPZI/LU3pxYU0GhKNWWE+6F33T5VzMQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nlAQlMfaorRmlvuyn5xNEn55kXtnWJgMXDQmqJ4fVz25w8U4MN7XlymYKIXEbt+d8dnmW6INLpJ6sA4IN64wB8lnio4CoeDkk0VaEXDhyBY8xfH4zmMFrwRKlTiaYS+6WlMvUvpnKPEk7yHOC+eU51DX0c0mrk2xyTU2hQW3j6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnmC/cGr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756382321; x=1787918321;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ReI+FIYDBdq2yPZI/LU3pxYU0GhKNWWE+6F33T5VzMQ=;
  b=SnmC/cGr8XYI5j78AHtrGUpqAA4Luu6k4tJF+TQeTeWNi60e3ugoAfNh
   uS8WbRBVOddaz8a7N3t2Z6FpWGmneSzm5d8GaM+Gch3gGxOKZTqKKqaW3
   CH8XUYhbYtWJrjIrLFw6WIURyrcickXxLbg4t8S4yDAOWSE0jyxZQwoI7
   LGDUWLywA6zKnESwG/fCs4/jAAc99U5+O5KuzYiyF8nUUOHpLvFIPYwcO
   KdrjD3vF2lKKL3cXFKKVCgiEsVUN9GOR1NbspMtDC5wvuoM2yC4mNtdwy
   4om+yEXS4tVP0x1/83yFU+7NWekXAEArMkv8wEwvLEf2ylZQAIe6At4h2
   w==;
X-CSE-ConnectionGUID: x2etw1j1QuKYKeKTQChZGQ==
X-CSE-MsgGUID: 8uudqiH1Rdyps0QabAcX4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62472101"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62472101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:58:40 -0700
X-CSE-ConnectionGUID: gByJn1q7QQmzyBiZbRHAJQ==
X-CSE-MsgGUID: psAy1UENRCeUEm0KUWad6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170266355"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:58:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:58:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 04:58:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.67)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQzlOh2qD0u0STqGgCz/fLZdOj4lghj0QeqgxcYDb9St535/1+GHcC1Edg1yD88j+Ply90w0qPwPmdGdjfxWnrk7v6z2nSMs5eGkV/+1zRTToPhKjfYKxRwMfS9Unf5eUdlMIb/uXABNBEl5iuH+vZ6dei2QKdzdyV1cF25Nf2iQNklfW2npFWtt1ErSaauzlxupW33kXxGIDyV3OyRrH3AtQv+GiP/TK9Frk9vunNjYvewQcHSMBZdAZ6xhcwU4eDsIeyCf9Qp21/FmtsnrqxlcU8usr67YFc2hl/PXOWFk03cVvcEPb+1R4V3ITBtMCYMN+YJPi1mDkB5uvRIGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReI+FIYDBdq2yPZI/LU3pxYU0GhKNWWE+6F33T5VzMQ=;
 b=SQfTD2PCmAAyu6GFSoNj6GKQkOKoiAGHpcrlZBC8gO0xXoyCog5nLOuLKUtpVGUhqFfdLZjUoUD34wjPfK5ylnX4gEg6fafMtCzFzpImCfuM34O9mzV2RU9GXtayEeH5pofGLZCY1ZAvKU40bQQcOZ1VTTLhTd2HmO5sfQXOl8aZSL16IZnhV+7saKNJU3p4DNSxcdRAym0T5hEgdU6ow+ehQipNfqCdNh8g6UCJNWNNphCGaZmSibmjFg6GVgFJl9Aq5VUCzUY3Hpc49k1OACxdeZXMS0lNBllmbF9Vc3tPCMRmB4IVsrab6lp6CZ1VcpxDGMif0mwqUh+FlqGvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA2PR11MB4825.namprd11.prod.outlook.com
 (2603:10b6:806:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 11:58:33 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:58:33 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>
Subject: pull-request: iwlwifi-fixes-2025-08-28
Thread-Topic: pull-request: iwlwifi-fixes-2025-08-28
Thread-Index: AdwYEw03owimfUcoQZSmgY1HkfDZ/A==
Date: Thu, 28 Aug 2025 11:58:33 +0000
Message-ID: <DM3PPF63A6024A98B15E78FF64041B248D3A33BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA2PR11MB4825:EE_
x-ms-office365-filtering-correlation-id: 9470c89c-ca51-4af2-cfaa-08dde62a3675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QkhmNVBkY1JPYS9SVHhMNnJWTkxsaGZBbnNFQnZoR2x0ODJScEgzZk4waUR6?=
 =?utf-8?B?bzBMWnhlNXM5NEFuYUlqYVJqdFhEQTdwa0NiT09qSlpLRXBReThrNkZzeDBW?=
 =?utf-8?B?T3F6RHppYVk1eVFpNFV5WEdsOGhEN2g0SWlMMFFFTUcwOHgzbmFQanhXWGhZ?=
 =?utf-8?B?MjZUZm82VWZBaTk2R1NHUUxhdERuUGNINnBHSUJDc1V6UUoreWFyWFB0Mlh6?=
 =?utf-8?B?QWRNd09LeEN5WlFFdnFRaGU3V3hRc25Fbk5OVkw1dHpBQnpvSmtjMWV3Sy84?=
 =?utf-8?B?dEZsU0F2QnZVdnlxNlhRTjdsTDNUVnRsTHN0MWM0SUg5Q1dDSTJoRitBTUFr?=
 =?utf-8?B?UTFmNmhsR3RjTjNsZXp6b1hVRm5WZFVwUzVDRzRHTUtBazIzQUZoYkJKNVlV?=
 =?utf-8?B?ZFJ5RHEyK09vczBqZEZod09LTmpHWFVJWUxCVTNXNENOK2V3dDhZUngyOENm?=
 =?utf-8?B?MERZblprNXlHQUNKMVVuODk0TjR1WWhvOFc4ODV5R092bC9ZZkJlRlpiTW5y?=
 =?utf-8?B?dWoyclk0eVlQaXBOQTRtc2hFTzZCamJpZ2t3eitpSHkwYWJXaEVRMlF2VGNp?=
 =?utf-8?B?dm92bTQxaGNqb2tQQ1RDQkI0SlA1Si9sbW4zYnBFNVA5bnZFS0NzQlpPSVJp?=
 =?utf-8?B?VUFJYXEzczF2VnFidnFKd1lMb3FkQ3BTY1F1Yi8yTkpuR1hSUThKMDgzOFVn?=
 =?utf-8?B?ZCttaFVRWlFkbktYSHNWSVorTHMxMit6bXFDMVhzNytLWDJ0V1RCRUhocEQz?=
 =?utf-8?B?d1BTL2g1TW1hYXBqK25KU1Y2UTcyNXBsQjNRZm02VlplSDJlMTVTeGxzejZJ?=
 =?utf-8?B?WjVOa0ZpZVNYNlo3SUdlOWZ4eW5Cbkd3UDU2bkhzb2I3K2xodzVta2VOUkRu?=
 =?utf-8?B?aFhIYWdiOWF0Zld3N0FWYlBBem1sVDhkSXFVZHdySVE2akZCRE9jTi9ZbTBF?=
 =?utf-8?B?cFRPc1NJbUg1TTQ3cURmSTBCRExwRmVFTnNoSDVhUWUxU2dQa0xBcllaYW5N?=
 =?utf-8?B?THZUVFU5KzgrdnJWdzVzV3NRWW9TQjhiOFNuTDlzZWVnUWE2U1ZFTjZMTUd1?=
 =?utf-8?B?ZE80VEE3UDdhWms3SzZ2ZzBtcW9CK3ZrN20remVUQWNneFlwZGlHZWFkbngw?=
 =?utf-8?B?UTE2dkg3b3JXcU15aXRkNzRzazh2WHdvLzdYU0hmWjNObFdHUE5JU2lCdWZ3?=
 =?utf-8?B?dTZ3VnNjTGFzNjRDYWs5R1JlWElkcUdrWDBEcmUvbnM5RXlvbUErS3poWDZm?=
 =?utf-8?B?cGtpbGhtUWxyN1UxNHpqWHh4bnAvUmt0Q0ZqaXZCUmxBV2J1SkFPQkpOU3pX?=
 =?utf-8?B?MW9qcjlYd3RlMkNuS3ZtaTVpcDlwMFUzWkVPY255QmlxYlZuaVo3SjlBTE92?=
 =?utf-8?B?SThzbmFtRE5mUDNIQ053eU85cmN5KzdQTkFNZ0hHVlRKU1ZxUmlwM0RSS1Qr?=
 =?utf-8?B?eU5oQ3hGRTlJMjhiYjJhdWlsMVNWOG9hSzNucUdKMFlVOXZOcjdNWVpTcjQ5?=
 =?utf-8?B?UVh5WEU2YXpldEhRcWN2K1MyT0dEZE1zQmt5YVNjRE1tWnExbmlmT1pra0l6?=
 =?utf-8?B?bGE5bUFpU256aFpabzZrdTV5T2ZrTWJFVktndDhBTTYrdWlIdUd5c1I0OUh1?=
 =?utf-8?B?Yk9INDJvd2lXOWdjOWVFZXNlb2toM29INmxrbndtQ0MzeUhaaUZmcDB1d1BW?=
 =?utf-8?B?Y2hoczk4TU9meXA4UFBWdHJZbG5GcVZzUEc2ZFdNS0tlRHd3azU2OGxSYjRW?=
 =?utf-8?B?dWZaTmtRcUZLSGlCQ0JGTmZSTUtvV3B2T0ZBWlh0WUI2RndYaVFpcTJNcjht?=
 =?utf-8?B?TVE3c1lSTmczWlF4c2RBMDBaOXd6UHN2VTBJelRwRWVIQ0pGNWZGMWxpWnNm?=
 =?utf-8?B?enRWekp4WlVscGk5NCtjcnpES2thUnowaExETjJ6a2RoSUUwOWZOWkxxdzJH?=
 =?utf-8?B?RTBVR1k0NkxHazg4NWlCSDNrczJQcENFeVdtTCtlbWNLRnorcmVqK0x4SmVi?=
 =?utf-8?Q?TkF4HLiZMF7LqbSGoRYoGX/ZT2Xmh4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3VwekxlMHNFRmhhazZJYzI5SDhvWXFySm1sMlB0RXVESWY2TzBrWWRjOUp4?=
 =?utf-8?B?a0p5djJwZnZjelB1UjA4d0krS0MrWFV4bTRXS3FlRXBZRzdMUWlybStqdUxY?=
 =?utf-8?B?NmkwM3ZBY3pvajdRWnVZLzUzbkZMWHBmV0dEMGNScUF0ZHh5WVB6TXNlSnI2?=
 =?utf-8?B?dGI4N3hpSzVxZ3hDUWtzakJ3TUhqUUhYSG9xV29hc0JxYzhwaGZYSkQ2dU1h?=
 =?utf-8?B?aEpWbnlOdTR0MnBiZFFRQ2p3cnpmUm5vSjEwc21nUXA0aWJTTkx1N0pQTjdJ?=
 =?utf-8?B?bjhvY0RITHM0NUZVZVR5UUdFTGJLUVRKUGNnSXBIaVVSZFlGRE9WS1FQbXd2?=
 =?utf-8?B?RDdDMkYwbkJpNlJzTFkxU25SY2NKUHhVMTRtWUROSGZKalB5M2VYbUxhYm5S?=
 =?utf-8?B?WEg1ZG4rZmJCRUt1Q2dTWG9BNGEvVkpqUUMwOEdKQ1Q2WXNwOEFVczNLVU54?=
 =?utf-8?B?ZDdDQXNaeVJOeGpvbVVxT1JaTHFJRDFpOFFMU3AraVptNWltczNSZDluNnlM?=
 =?utf-8?B?dllaVXY4MXM0VXA0bit0eHhhQVErdTlvbTdDTlZyRUdweTNlRm0wZzlCTDJJ?=
 =?utf-8?B?Nkw4WjBMQk9XeHI2elkyMDRGZWw1dFA3MWUxZUhueFBhdXl6d0NDaUgyT2NC?=
 =?utf-8?B?eHA0dG02ZlRCUGFMSDlwb3dCTzlBNXJBelI5V0JtejlZZGZBZlA2TEQwRkNq?=
 =?utf-8?B?ZXMxL1ZuNjdwdHFqcXl0MHgwWGdYa1BhZ2grcC9YYUZ5ekpDZ1FFbjQ5R0tL?=
 =?utf-8?B?UG1QZURaQk9jUGpXYkY3dEdQZ2lUNW1lYmNRRnlrY3BXVnlPZDFwSXJldWRW?=
 =?utf-8?B?Uk84bmlwTTR0VmdBZkVZYWpHa3pWcStGdVcyR0pRajNVZzMyREdIOHUrSUxk?=
 =?utf-8?B?TmxRR0g4YnI3VjAvOG94L0lZQkZMTDc2TjdxaXNKeW9pNThhc0pGZzZEdmZK?=
 =?utf-8?B?RXlyNnU3QUx3VVNJYXRFdW9qdmJtWHpwQitLaW5BY3RTTE9mVjQyRUdhenJD?=
 =?utf-8?B?NVRtcklkSTVzZUM5K3ovWW1JbDBoVC9ja0ZXblNicWRTZG5Ub0o5R2pXRUt6?=
 =?utf-8?B?VW5pMXBOVUM4aEo3d2VPd04zZkRkdTl5WjN5cThDSnZRN3dTaVhnSkZqVFRQ?=
 =?utf-8?B?TTJoaCtFTGRRUUIwNWdLMWNONytiMGxTdmtSZy9HT0FaSnJpQ1FlQmgzSjBs?=
 =?utf-8?B?SElVdnR6K1VXaHU0ZXlvcDV3cklNSmFnSlhkS25PQjUvaVhxbGl5M08vUUVa?=
 =?utf-8?B?Uy9MeS9NYWNoWnAyU0phN2ZHWk1hNi92amZUU001VHUvOG9uSllXa2wyQmg3?=
 =?utf-8?B?em5aU3BZSlc5TGVBNGlBZnhtc3JLUDBsSmdsb2NpMnAxMzJDZzlYajR1SDZ1?=
 =?utf-8?B?aHRhVTl3UThQNyttWEZTSVU0c2wyb2U4UDh1TWY3V0tuQldYNWRzK3VhQWhX?=
 =?utf-8?B?RnVOY2NlYkp5SzcyTzdHR0E1L3NlY2tscVAwMmgwUzNickdaOTdXMUc2dDZX?=
 =?utf-8?B?d0RkQ2ZyZ1FYUVVaeFlxT3kxSlRpQkJRSTVQbjZHM29RWi9pcFFFYkFNS2tT?=
 =?utf-8?B?dWFmZXgra3NobE5NdFdZTTZ5VmlPcUJTdjRsbVd0TllqVVZXZ2NteWdOSmkx?=
 =?utf-8?B?S3VaSkRrSERPcE1IWGZCNnA0UmNXRG9hZGxXMXBZZkU1MjhPTW94WGFYTlNJ?=
 =?utf-8?B?VFdRcm45QUJ6aHRDRXlORm1odHBKTUh1Q2dpNHpkQlVmcER4YytHNStnZy9i?=
 =?utf-8?B?SFRiSEYzcThIQU1Za2dZNlZZNzVBeUFSNUtaeHNUOFk4ekZxUE9zQU82aVJm?=
 =?utf-8?B?MmcvcHlwVS9STnB4SlpIUXdKaHF4U1FzdFlwanJnQmQvNFhKMW9YYi9FdGNP?=
 =?utf-8?B?VDRQM2thMGtqalV2djE3Y3psTXZtcDIrNWtPZ3JZK3d2OTJUSDB5a3lOUkw0?=
 =?utf-8?B?R1VsM3g2dnFKQ3N0d0lIWVVMSC9pZjNoN2w4dDZiZTNqNHBqTzBxV0YzMFd5?=
 =?utf-8?B?MHRmRVFLQVlvdk5iZ2ZZc3VoTUNkeUZjaERYMnpJWUdIOVhjVHhUODFjZSt0?=
 =?utf-8?B?NUovK1kyR09vVlBDZXVsYnRPbDVHa1ZnNnp6cmcwdUI5WTAxSkMyMTFDZzNL?=
 =?utf-8?B?aWpMci9vb3lRRFRMVE43WGZWRldpYkdveUdma3dCNXdrR0xSZUtWazFSdlZX?=
 =?utf-8?B?b3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9470c89c-ca51-4af2-cfaa-08dde62a3675
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 11:58:33.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGtxn+O7GGFoXtEYPxL6UU+yP1c17PAvjdQK5TV/z5u8SQSV4AGFqYlLAcL2C4b0NAW51WmwViiNy3hKExAOI1T37esIgIgSgI6+/4GQ2Z/98fUq2AGsH8pDT6DsIZ5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

SGksDQoNClJlc2VuZGluZyB0aGUgcHVsbCByZXF1ZXN0IHNpbmNlIG9uZSBvZiB0aGUgY29tbWl0
cyB3YXMgbWlzc2luZyBzLW8tYg0KDQpUaGFua3MsDQpNaXJpDQotLS0NCg0KVGhlIGZvbGxvd2lu
ZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkOTEwNGNlYzNlOGZlNGI0NThiNzQ3MDk4NTMyMzEzODU3
NzkwMDFmOg0KDQogIE1lcmdlIHRhZyAnYnBmLW5leHQtNi4xNycgb2YgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JwZi9icGYtbmV4dCAoMjAyNS0wNy0zMCAw
OTo1ODo1MCAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6
DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXds
d2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAyNS0wOC0yOA0KDQpm
b3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMDE5ZjcxYTY3NjBhNmY4OWQzODhjM2NkNDU2
MjJkMWFhZTdkMzY0MToNCg0KICB3aWZpOiBpd2x3aWZpOiBjZmc6IGFkZCBiYWNrIG1vcmUgbG9z
dCBQQ0kgSURzICgyMDI1LTA4LTI4IDE0OjUyOjExICswMzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQphIGZldyBm
aXhlcywgbWFpbmx5IG9mIHRoZSBjZmcgcmV3b3JrLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpFbW1hbnVlbCBHcnVt
YmFjaCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBpZiBzY3JhdGNoIGlzIH4wVSwgY29uc2lk
ZXIgaXQgYSBmYWlsdXJlDQoNCkpvaGFubmVzIEJlcmcgKDUpOg0KICAgICAgd2lmaTogaXdsd2lm
aTogYWNwaTogY2hlY2sgRFNNIGZ1bmMgdmFsaWRpdHkNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHVl
Zmk6IGNoZWNrIERTTSBpdGVtIHZhbGlkaXR5DQogICAgICB3aWZpOiBpd2x3aWZpOiBjZmc6IHJl
c3RvcmUgc29tZSAxMDAwIHNlcmllcyBjb25maWdzDQogICAgICB3aWZpOiBpd2x3aWZpOiBmaXgg
Ynl0ZSBjb3VudCB0YWJsZSBmb3Igb2xkIGRldmljZXMNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGNm
ZzogYWRkIGJhY2sgbW9yZSBsb3N0IFBDSSBJRHMNCg0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvZncvYWNwaS5jICAgICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysrLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcnVudGltZS5oICAgIHwgIDgg
KysrKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvdWVmaS5jICAg
ICAgIHwgIDYgKysrKysrDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2ll
L2Rydi5jICAgICAgfCAyMiArKysrKysrKysrKysrKy0tLS0tDQogLi4uL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL3R4LmMgICAgfCAgMyArKy0NCiA1IGZpbGVzIGNoYW5n
ZWQsIDU3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo=

