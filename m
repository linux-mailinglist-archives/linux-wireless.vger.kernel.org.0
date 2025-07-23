Return-Path: <linux-wireless+bounces-25939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153BB0F113
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A9116D12C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086F28137C;
	Wed, 23 Jul 2025 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNI3c/JN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF99277CBC
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269803; cv=fail; b=I1R+5QyDtoDUvN45e0zDGi/akg8wtrpG0eEZ9CiGZ9vPwAeYr5V3Bo1O3+oRk04iRc2w8EOIVtuUTlTN5lJjm9iIWfpVqAA1/UuDc+9kbdTEQtyXvzn1DlQ1T8HpSHiyR7SLFt8MrnL/yIrjx4nN5sOyEYPvCZYfza44/O+E+E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269803; c=relaxed/simple;
	bh=cYUjdqFFknxeb+IweUa/Z4QhB/bXe65lyBrypSawk/M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D6fmseBbmzb+4H/GGtqEz8D8V2cCXl7aQ7kXNDJtk50zcIKYYLyRby/UoqEsoH65Y8+pjrN8SNudySss0CfqGfcM5SKA5Zb29jroa+KBoKjnBr6P0SmRmfO3XFT6DiNvL32q0VSGjvSedCLeHCyXzP7t7yuvjsQUvLD+4QGnF00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNI3c/JN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753269802; x=1784805802;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=cYUjdqFFknxeb+IweUa/Z4QhB/bXe65lyBrypSawk/M=;
  b=hNI3c/JNV1TTQ5GtsFv8XTJoyB+W+Mn/bBfoVfdmZ70QjTd+908J4kKB
   ClTyIn0kkZ64m5fjo3UBw9hslhBRnIC2BOVoJbBD1kgT62vjD/DP9b5Sj
   NBBR8rv7efS4mqZUp5AMBGo9QbT+1LoLCxPtzdgWW0gIh5CMYq54PmNkZ
   n4EJ8q+3yZGpCNLYdE1PPKDNRbTwPhMnLc9X/B3Yq5NjYG1CkEo4wFo2b
   is9ME86JXXK53phYYraXf2S462aICzfMj/WDnUxlewiBeTYRI59AR+7ta
   /emvpYRtr5gLrgTMLdNwGWPwtznbiKiaEXlIYOYnwfjy9WneJTOcujxCP
   g==;
X-CSE-ConnectionGUID: Q7uoDZ3WT3eTN5dc97GPDg==
X-CSE-MsgGUID: 6bjrBidWQQilRxCyJ8pEBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59206675"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59206675"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 04:23:19 -0700
X-CSE-ConnectionGUID: JYInR0eOTAmxSVjoe4XPww==
X-CSE-MsgGUID: DxDspUf3TaOQfMTSDAflWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163709478"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 04:23:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:23:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 04:23:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJe1uS1DSwjNb9xVkVOEWi4LWlqFLZoY9ba/XQwn7l2EVO7KkUuHPbOtPWrIdDZHWOSx0NiSS+jZjpGTXN+6rvECEDNKnmEQXwX4HZHNRI8vwle+C1zz50Av0p4YyFKre05faMyK/9ceUw35fS0R6/CwkjfK5i+wWU3eBmhS6oy9GNoFvZ/2BGcm7tE9zVAyNzMmGBlZTbma6W+Oy4uveqsEzNcxVsS5egA/kpB6Ldy3GkmQFKQPJOSsBNXeNnaZl8oKkMaM+FqavYrvOTaoKFZgVz/lCwCy+s0ZFIdNCQPmRsImOvV15P80h10tIoh7NrOdcMVCUt0vfkCzIeKnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYUjdqFFknxeb+IweUa/Z4QhB/bXe65lyBrypSawk/M=;
 b=vtFVE2mqKFtPax0dZUrFA+QFKxhgDmVm4+Cvc8TEWOGkRm/RS1NVJknSP3gnt+MQRnEyHgT5s1v2lYGqTR1Zi1AtEgELz8ZOwRShcK/864BnGlG+zRUxOmrFiAPjjK8AKvx4ZtR6Mwr0gnzmNcQ7+LkUFrGA3GQUuoPd/9089IO50igtvdHg+qXXRFgV2LhO+T56Ia8oPwV4ntled05+2HwGL6wUi1D/uBEaIUqRg+Gdg5LQOuJpp69y8eeTZZo6dAIJbi2pCZCbTrygcqFFjLKmVvZoQ6IMoOcaCFh1ho5WpOqSCh5AueGDKj3EwfWQ9QcLPKaYdagpHZdZ+7G4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM4PR11MB7207.namprd11.prod.outlook.com
 (2603:10b6:8:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 11:22:57 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 11:22:57 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-2025-07-23
Thread-Topic: pull-request: iwlwifi-next-2025-07-23
Thread-Index: Adv7w6fDG4Ww61XZT5mQwF6FfpSLJg==
Date: Wed, 23 Jul 2025 11:22:57 +0000
Message-ID: <DM3PPF63A6024A9FA94AD32176B0D1F0B61A35FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM4PR11MB7207:EE_
x-ms-office365-filtering-correlation-id: 1bb7ddd0-8f21-4728-65b2-08ddc9db46a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mkc1NXRhcEdXc0F0WEx6RGc4Z2dIWm1wSkVrNVB0WWtoQ3NsZjZBV245QmtO?=
 =?utf-8?B?bUpiQTJRZzkxTTBjekZxbE12MngwQjBqenpNbFc4MHB3Ui92ekdXR2VDZm5z?=
 =?utf-8?B?ZmU1Zk9jUXhRbk44NWQ0bDc5MzNlV3hOb1o0TytGS0o4ZEt0Q2xRWU9MQlB6?=
 =?utf-8?B?TlYva0FLR1QvTjlFd1RtSnVlQUV4a0hYR2dTSE04d00vc01UQnBrSjFpWUZj?=
 =?utf-8?B?VExhWUxYa1hsWHBhQmdYSWxobkIvRXJWZmpsZ215b1pETkdrbVVqN0NSMVVP?=
 =?utf-8?B?V3htQmpaK2Y3TU1HcTYwMTUraHozRjRkQThQd2lLNlB1Y1BxdWwzU0F5MzJa?=
 =?utf-8?B?dVFYN1Y0R2t4eXZoOVhqanpNbmNhQ1JnRC9zT0hpb1FOcU9ldlExRjh5Y21l?=
 =?utf-8?B?NnpFdmpTVSsvR0pvZUpQcjc2NmE1bUxpdExPVFlZYkdBTlJrc2xtUkxSSXlH?=
 =?utf-8?B?TkphR1RDeXZ1WjZiUjlqUGFsRW1TTzdLSmRBSUF4Q3NzZ1JDRlNGeTdYckpU?=
 =?utf-8?B?THpNTXNxTGhTdE1aR0V2NG0xQWVkR05hOW02QnhJU3hiUFF1L2xYcmJ0My9M?=
 =?utf-8?B?d2UyV3JIaDhXTDhLZkVCQ0tocVJOVUlFbnk4SU9vTVhHVExjVXp2MmdaeWZ5?=
 =?utf-8?B?ekgzRmpTSzR5T1o5STJrYmV6VEV0ZGFhcERHbVllOGx3N010M1JIditkell3?=
 =?utf-8?B?VTlFOEJ5RStQTHdpWFEvN3hPMm5hd09aRjlZU1h2YVF2RVJDaUZ1ZG9DZzJ1?=
 =?utf-8?B?eWVPOXlMOTUzVWovVEdmZ3Uvak9SVDBvVjR5OWVmS1lGNm9rOTVDamd0WlRD?=
 =?utf-8?B?QVl1elpJY3ZJWlN5cmxSOGdCYThWYWJWOFI0MFhwbW5oazZHMUhBVm5FREl3?=
 =?utf-8?B?cnc0RDhJODJRN0RJbXZVUWRUbFJyZ2lzQ2wxWXBGRi9ka00yWGQvNk5qVmRQ?=
 =?utf-8?B?TThjdUpkcEU0YndvSld3cWZPc2VwR002ZG5Ea2swRVFOcWg1bDNXalUxVEJr?=
 =?utf-8?B?cHBnTW5LeXZqRXBSTFJFZGhCS05mdjlRT3Mrd2RNMXZFeGpCSUF0ZzBZUzgz?=
 =?utf-8?B?RjlzbGpaUnlRK1JzNlcxb3BkT0t2TmVkbXFJYTFrTEpnTjN4VWtFU2EvcHBm?=
 =?utf-8?B?Y1d6WmhWZHozMm4vRFNWWFc1dWZjeTdWNUQ1ZTlRYVBsNzk3QUhMb2huVEJT?=
 =?utf-8?B?M1pTN2U3WGV0VEtxVXVJTGlsZ21iZHpHVW5ZZVoxM3VSODN4aUw2cjZMRmFH?=
 =?utf-8?B?SWdQQTgrTUxJMXdwL1JGVDN4R2NqOERrdk0vcEgzLzJ1dDJKdWQwbjhvT0Vq?=
 =?utf-8?B?R0FxYzY1ZndpeTRGa0JIT01xK0VJTUxsRi9EV0JGdnB5Z2REbmFKeThDUWpl?=
 =?utf-8?B?S2p5SEFaRENlMmZXSFpsenJRck1MbUNMVUtRUFQrbU9iazMrZm0zSWJUMGdP?=
 =?utf-8?B?L0tiTWdmQjg4SXZXRXNxVjFKa25NUzgrb3dJcG5YNEk4UGVYWWNpYlIwVnVj?=
 =?utf-8?B?RGRhY0Zvc015MjNoKzlnZWZZcVFiTnN0dW5mN2lBdHVONktZZnJtaVBYNFhl?=
 =?utf-8?B?RFM5VDQ4RTU1V29HcTY4Um5ZaitQa05Ma0FLWEFDM2U3UkR1amoyRzhjS2xV?=
 =?utf-8?B?b1RMWDBZNFd1SEFTWkFkNk5qMzdWMjN1YitiaVd2NkNtUTFZemsxMTFqbU5z?=
 =?utf-8?B?UFJGWGFuZUFQcGwwblk5NXpQaE1vb2JkTVYrK0NLMUxkdWhDSUg3Y0VOR2lN?=
 =?utf-8?B?aGhpYnpxVnpFNGtZMGpEUHhxR2lSNnU0Vm1LRjJQTGdKMytlVElPNGhvbXpo?=
 =?utf-8?B?bUF0Z3R4d2R2ZFNsWVE0eXpLRGhzOUkranVnM3lKalREWVRTUFo2R1ByNWNK?=
 =?utf-8?B?U2ZPdm5ramZ2eEVGNWVFM3pqdHhHKzBTYUpLMXRxL2h4cjUyNkZMMmZIeEYv?=
 =?utf-8?B?VFcwRk9BK3puUkFTVXg3MUZVQTMyMWNFNlFjRy9FZlM2Mms2aFNzL2pIMVJV?=
 =?utf-8?Q?m6QVRY7bWjfdBWkyWfDdivnPMI0m8U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFl1ZFQ5TGtJTklCZCtLTTNJdEliWWQxajRmTi9iby9nVmVnaXlQSTN3QnVn?=
 =?utf-8?B?cnNHYWwxV2ZsdXh0QkNYUXNZL1VodkVrbWFPcFNnWTJLdHk2RFE0M2h6dEZ0?=
 =?utf-8?B?NE5GVktsMEdCTWRLeDFJdi9ONmJvOGlQYUEzMi9jOUtaYWN1Y2QwN2lTNys5?=
 =?utf-8?B?eHM0Y2tPTHNwOHo5dFozUUlzRWhuRkQ5dEw0VzlMbXFKcXliQWo3ZEliSXF0?=
 =?utf-8?B?Qm1DOXJiYVMzdzZrVVF0andjdHlUMXlSc3grak51KzhpWHVFVUZHNFhhNk5p?=
 =?utf-8?B?VHJRMndoWmRaT1Q4bG1tREtJNVNUNjdiUUtTdTJ5WFZSUEtobExnYXp6aW9h?=
 =?utf-8?B?N2FBUUt1SWZZSFR2bFFOMld3bHBMOTdEVWFZZEJIdXhpWUhIWk9FWjFnVXdV?=
 =?utf-8?B?L3VxWEI3SDFrS0lURTVheVdPeFlWQ1VGcFdQRlp1cWZtN01WN2ZUdVZMd1pU?=
 =?utf-8?B?TFJHNkNVNmIzNWQvYWdoRnp3Q1FLOGRuY0ZHOVVDaXUwVC83OTZoT2tPWVc1?=
 =?utf-8?B?RkpzUDE3SyswdTJndncyOUlxMzczYmdMeUtXSjBOL2VPN0NucGxuL0JNZHQw?=
 =?utf-8?B?UUtUQk03K1F3R3BPS3dpeXIvVDMvRXdORGUxQXRVam5ZbWxQV0RSSi9SclJn?=
 =?utf-8?B?a0lPS092NW1nNkpMQUU1bXdaSXJzRHFraHNyaGxQaDZmams4OWo2dzQvTE1z?=
 =?utf-8?B?Y3p3U3NOS2FYYlNtdTM4bGt0TjdqQ3NDN2dSQUhjaHZDNkM1SktXSWRWa3Zs?=
 =?utf-8?B?MVFFMm9LUWdlMW1sYzJKM1ZNTTVLVm5QazA2Wkd0aXBNWkdWSDVsVDVBakRT?=
 =?utf-8?B?aHpZYWNHaFdGMTVtTTI0MnZySGt6aEErZkVFTXlSRUFBbThRZllaT2c4SEtE?=
 =?utf-8?B?cmF1LzNjTk56Nm9JN1JRNlVIVnlmakd5dFRLY1JWWXJvMFVqMExUMXYzQkJU?=
 =?utf-8?B?M2xRTmhjNnB4RFJBYW9WanhkYlpTeDViRXF6eWRISzdkdVB4QWZQemtnN2Nu?=
 =?utf-8?B?bFZLUEFJQlNOU3Ftbm9DVlhqbjFmSDBsN1phY1RhOHBxQnhlVzRFZ0d5Qndu?=
 =?utf-8?B?NFZYMDVEYnhRZjRSRFBhOWNVWHRVZEJjVWdENEVGOG02K0FHZ0hlYlpqV1Nr?=
 =?utf-8?B?aTQ1N1YyOXFsSmozVXkyUFY3alhTQm9GOTQ0bjh6UTFKQ1ovTmRPV3BaQmF3?=
 =?utf-8?B?SGtRNnh0R2JMQitEY29Oc0JzVE9XRFZiU3BPWCtDUC92ZmNRODlxRE9kVkVY?=
 =?utf-8?B?Q090ZnBOdVM0eTRXalF0bkdISlhzNVFxQWhxR1dra2RqRG1aNWpuVklGTk80?=
 =?utf-8?B?YXJCTjc4WVliZ2hacUt2TS8xQ01mSitYcjFZYUMvbEp0VmRxNkpqT1RBaFEz?=
 =?utf-8?B?MXhpVVovUkR3ZjAwbGFIN2o2QW5ucXgraEQwNXQvOEpYU1VoV2RJbDE5MS9N?=
 =?utf-8?B?V0x4WHVCTEdxTWhIaDJvVUJFL3lrYXFNaDhmTGtoYjU3enViVXlJeHZWaFc1?=
 =?utf-8?B?cnBzUDlkRVQ1djNPT0hkb2NHRzVFc1ZhV3VzUUFyQWg1cTdUOXo2RlFrbXda?=
 =?utf-8?B?NjFtNWFPS3RsbTBtbGhYcldnQS9UZTdINTNxcTF2K0lPMFlwQ0Q2UlVDSW5Y?=
 =?utf-8?B?dE1XREpHYm9Mdm9mclROeTlpTWNLUDZneHBySnJmWFhhaVpONzFWREpLV09q?=
 =?utf-8?B?ZWlSa3BFdXFVS1VIM20vOGQvb3U4SHZqQ1YyWStmSEdaaHpUMHcvSk94dHRq?=
 =?utf-8?B?d2UvUVN5WGkxSlhBb3FoS2pJOTdEN0lWRXNsVzVrWkdHSHdScmVaR3RXR1dX?=
 =?utf-8?B?ZXpQa2VKT294NTFXNG1yV3lqcjluaEJLWWxSc2lVUVJqOVgySzhEOVdIdGhF?=
 =?utf-8?B?eWgxZ0xOMWhYSUJ1czRQRkhsNkt1K3ZQS2ZUdmZObkxlZytrSkwxZWNkVE9a?=
 =?utf-8?B?MmFBMXN5VkZ2VENiU2pZL3dGWGdUS0lrZWJPZG45UHlDYUlXWjZIc1Q0cC8r?=
 =?utf-8?B?MnhaUXF0VXo1eVpBVnB5NjFMYTBJZjBuL1A1cm9CZjRHVVZkcC9CLzE3NTg2?=
 =?utf-8?B?ZllTQkNTMzA1SUs5dHhjb2FPR2tPR2FiTUJZaGtqeStXWGJmNmsvNmhLenph?=
 =?utf-8?B?alE5RENXdElwdGsrU0FKVkNQem1Odnc4UzUwYTlkcEptMHRYUGkwRmttL1FB?=
 =?utf-8?Q?aIkUOjLWdOhadJTjAJw+YbQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb7ddd0-8f21-4728-65b2-08ddc9db46a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 11:22:57.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/jYDsVozZ0L51PpToHZZNMBhGMVMy880NmRZy0G8o0Ol3t7h8Q5l+l8ECCBe1SAoZHHzU0AIqh7SCO+Mpi8I1Q39MQO213KFSBoMLSlZb9UYP4wPWrAhwVlvaDPJmND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3NTRmZTg0OGIzYjI5N2ZjODVlYzI0
Y2Q5NTliYWQyMmI2ZGY4Y2I4Og0KDQogIFJlYXBwbHkgIndpZmk6IG1hYzgwMjExOiBVcGRhdGUg
c2tiJ3MgY29udHJvbCBibG9jayBrZXkgaW4gaWVlZTgwMjExX3R4X2RlcXVldWUoKSIgKDIwMjUt
MDctMTggMTQ6Mjk6MzAgKzAyMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0
b3J5IGF0Og0KDQogIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2l3bHdpZmkvaXdsd2lmaS1uZXh0LmdpdC8gdGFncy9pd2x3aWZpLW5leHQtMjAyNS0wNy0y
Mw0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZGE3NWYxODNmZWEwMWYyYzlmMTM4
MjY1NWIzNjZlZDAxNzg5MWU0ZToNCg0KICB3aWZpOiBpd2x3aWZpOiBSZXZlcnQgIndpZmk6IGl3
bHdpZmk6IHJlbW92ZSBzdXBwb3J0IG9mIHNldmVyYWwgaXdsX3BwYWdfdGFibGVfY21kIHZlcnNp
b25zIiAoMjAyNS0wNy0yMyAxNDoxMDo1NyArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBmZWF0
dXJlLCBub3RhYmx5DQoNCi0gZGlzYWJsZSBmZWF0dXJlcyBpbiBmaXBzDQotIHJlbW92ZSBSWCBP
TUkgZmVhdHVyZSBjb2RlDQotIEEgZmV3IGZpeGVzIGFuZCBjbGVhbnVwcw0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpB
bnRvbmlvIFF1YXJ0dWxsaSAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBmaXggY21kIGxlbmd0
aCB3aGVuIHNlbmRpbmcgV09XTEFOX1RTQ19SU0NfUEFSQU0NCg0KQXZyYWhhbSBTdGVybiAoMik6
DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGF2b2lkIG91dGRhdGVkIHJlb3JkZXIgYnVmZmVy
IGhlYWRfc24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogYXZvaWQgb3V0ZGF0ZWQgcmVvcmRl
ciBidWZmZXIgaGVhZF9zbg0KDQpCZW5qYW1pbiBCZXJnICgyKToNCiAgICAgIHdpZmk6IGl3bHdp
Zmk6IG1sZDogc3VwcG9ydCBjaGFubmVsIHN1cnZleSBjb2xsZWN0aW9uIGZvciBBQ1Mgc2NhbnMN
CiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogZGVjb2RlIEVPRiBiaXQgZm9yIEFNUERVcw0KDQpH
dXN0YXZvIEEuIFIuIFNpbHZhICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bS9mdzogQXZv
aWQgLVdmbGV4LWFycmF5LW1lbWJlci1ub3QtYXQtZW5kIHdhcm5pbmdzDQoNCklsYW4gUGVlciAo
MSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IFJlbW92ZSBOQU4gc3VwcG9ydA0KDQpKb2hh
bm5lcyBCZXJnICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGRpc2FibGUgY2VydGFpbiBmZWF0
dXJlcyBmb3IgZmlwc19lbmFibGVkDQoNCk1pcmkgS29yZW5ibGl0ICg4KToNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZDogZGlzYWJsZSBSWCBhZ2dyZWdhdGlvbiBpZiByZXF1ZXN0ZWQNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IHJlbW92ZSBTQzJGIGZpcm13YXJlIHN1cHBvcnQNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IHN0b3Agc3VwcG9ydGluZyBpd2xfb21pX3NlbmRfc3RhdHVzX25vdGlmIHZlciAx
DQogICAgICB3aWZpOiBpd2x3aWZpOiBSZW1vdmUgc3VwcG9ydCBmb3IgcnggT01JIGJhbmR3aWR0
aCByZWR1Y3Rpb24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogdXNlIHNwZWMgbGluayBpZCBh
bmQgbm90IEZXIGxpbmsgaWQNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGRvbid0IGV4cG9ydCBzeW1i
b2xzIHRoYXQgd2Ugc2hvdWxkbid0DQogICAgICB3aWZpOiBpd2x3aWZpOiBjaGVjayB2YWxpZGl0
eSBvZiB0aGUgRlcgQVBJIHJhbmdlDQogICAgICB3aWZpOiBpd2x3aWZpOiBSZXZlcnQgIndpZmk6
IGl3bHdpZmk6IHJlbW92ZSBzdXBwb3J0IG9mIHNldmVyYWwgaXdsX3BwYWdfdGFibGVfY21kIHZl
cnNpb25zIg0KDQpXYW5nWXVsaSAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBGaXggdHlwbyAi
cmFuc3BvcnQiDQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9zYy5j
ICAgICAgICB8ICAgNCAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0v
YWduLmggICAgICAgfCAgIDIgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
YXBpL2RhdGFwYXRoLmggICB8ICAyNiAtLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvZncvYXBpL3Bvd2VyLmggIHwgIDIwICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9mdy9hcGkvdGRscy5oICAgfCAgIDQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS90eC5oICAgICB8ICAzMyArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcmVndWxhdG9yeS5jIHwgIDIwICstDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtZHJ2LmMgICAgICAgfCAgIDUgKy0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1pby5jICAgICAgICB8ICAgNiAtDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtbnZtLXBhcnNlLmMgfCAgMjUg
Ky0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5jICAgICB8
ICAxNiAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvYWdnLmMgICAg
ICAgfCAgIDUgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2NvbnN0
YW50cy5oIHwgICA5IC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9s
aW5rLmMgICAgICB8IDM4OSArLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL21sZC9saW5rLmggICAgICB8ICAzMCAtLQ0KIC4uLi9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbG93X2xhdGVuY3kuYyAgIHwgICAzIC0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jICB8ICA3MyArLS0tDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWxkLmMgICAgICAgfCAgMTAg
Ky0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuaCAgICAgICB8
ICAgMiArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbm90aWYuYyAg
ICAgfCAgMTkgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9yeC5j
ICAgICAgICB8ICAgOSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQv
c2Nhbi5jICAgICAgfCAxNTYgKysrKysrKystDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tbGQvc2Nhbi5oICAgICAgfCAgMzcgKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL21sZC9zdGF0cy5jICAgICB8ICAgMiAtDQogZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jICB8ICAxOCArLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMgIHwgIDIyICstDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxkLW1hYy5jICAgfCAgIDkgLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oICAgICAgIHwgIDE2
ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcG93ZXIuYyAgICAg
fCAgIDEgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3J4bXEuYyAg
ICAgIHwgICA1ICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90eC5j
ICAgICAgICB8ICA5MyArKy0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2ll
L2dlbjFfMi90eC5jICAgIHwgIDIyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS90ZXN0cy9kZXZpbmZvLmMgfCAgMjggKysNCiAzNCBmaWxlcyBjaGFuZ2VkLCA0NDMgaW5z
ZXJ0aW9ucygrKSwgNjc4IGRlbGV0aW9ucygtKQ0K

