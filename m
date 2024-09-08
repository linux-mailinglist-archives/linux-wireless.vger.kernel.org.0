Return-Path: <linux-wireless+bounces-12632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3669705E3
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E3A1F21B28
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060434204E;
	Sun,  8 Sep 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMtyN63A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC85FBB1
	for <linux-wireless@vger.kernel.org>; Sun,  8 Sep 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725785587; cv=fail; b=R60F+f4SWR0zM0lHuSwj786yHxWSoE/T48XlNNqbRFFIpNsZMuM9s72v+2bD46Bagnd7sOeQCMUrWkEFCuriwtqqr8u9SmYAuxQN0GqjGEvS5HpKc0SgEwNQVH960BX09KlFw9Q7jevYRLt3WgzipiLYUc4H8UpGsj4DZBUgqRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725785587; c=relaxed/simple;
	bh=2ujnO40VvIdmqtqibgDkoLg/PJxV9QYXgoKkcVJytBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TagTskKWNEbZVCwt/+1SrdIjW4PNi5lvjdMxUy87zXjUg7QQ1sS7HveFG2/mk7CUhjJ3iWXJYkvDUJakj1dJmoDNdPMnZh19dnz+/xYmdKOEF+E7jy4pLZkMvxXCUk5kBTmaGWaVL5sGgGzUT12zAUkJ/CJBWudx8z5ORAgWYmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMtyN63A; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725785585; x=1757321585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2ujnO40VvIdmqtqibgDkoLg/PJxV9QYXgoKkcVJytBo=;
  b=fMtyN63AnAgt/5PlI6Q4pdSfV81mmYJLsblFQaImZLpDbV18KBxoMdZu
   hj060Qk4IdrJQkuwS6Ke0QsFebJbAYQHMxI6t0qBaI5cQ2O1h0gDQA2TS
   M1Q9vPYZ6TAEo5y40e+W9f0MmzQtQTLiZiY26XaumV9Ti4BctRi887BOg
   SHjeO538EpFXtbhM8QH+hA3aY4WUraXqhgtPG75UMWi5S3U4V/AbIRuCi
   dUys6Wt/wPn7PA4V7NiH6WcSWPQnKSmkzg2tkad5cMTiP0isrpTM/N6Fz
   gACrbZHv2Az19reHP461+9QjfkxvGkRzzIr+qLmGg/79QbUjMEQVeDBgD
   A==;
X-CSE-ConnectionGUID: im9cb/QnQIC30fVs+bnpIw==
X-CSE-MsgGUID: kSotcox8Tg62fZFb0TZN2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35842354"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="35842354"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 01:53:04 -0700
X-CSE-ConnectionGUID: Jnh/unWYRdiRAShe/maBcw==
X-CSE-MsgGUID: NPCJ5kclRm+VnOr6DRwcmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="71178584"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2024 01:53:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 01:53:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 01:53:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Sep 2024 01:53:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc0cfCCjFKDsyXoIZCx+BeNg6qQQs+sxusQzYZozNuTMapqzvD/VVXu4S4FbKqJpNl7aipiypBmUYKTMtEJGSNt6NEb1r5ERakz5WuaWyk5Vw1q74W0MJoxaOnuieA6ZcjHTsh8C5TSgNQ+kPsZWi3EpUS4X5H7WdqCBLrvc0ffQb9Vr28YthJk9Kt7HtB7QdZAfC618VuxVO6K7jalfg5QaKW+dNRhdxcBKIZwBjYMe4Iyvhxk2YS5qTbTrLSABMlhEpS+OMqtswaHZnLe7Elfs/+byeOnZ1v1djVcCPogr0RwKl9g4RknvlkzxJ+5qjOHncQ3pyjuo5McRE/TXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ujnO40VvIdmqtqibgDkoLg/PJxV9QYXgoKkcVJytBo=;
 b=DKYRvcMOlSC4URJ+ENi351LxeiixKZo7IfDfaeoYSE30hXZmV2o6bqK31L75oJA/4Ddff7Yabr//YtJNrJDrQPS/g0eSZjUT3Mz4Fo1u2Eqen0i3qXN3bpsJVNGqY3VMkrR874lI3J+cVqVviCoMck3nKT6KemULdkRRVgdMkLsneDMB5oqREPlu3TsVzPAd7X3lfIm0hIAzaligIruYamJfhTmkZjWJed5apfRIaUrLVBrdUU+uSevqScnurXaCBNLVY1qq2DGScbp1Dj/PLd2t3QFirruKOUsSgUepltgchrPapicnixkytc51RsGvW5NBOT8g5uAOEDTKWjUHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sun, 8 Sep
 2024 08:53:01 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%4]) with mapi id 15.20.7918.024; Sun, 8 Sep 2024
 08:53:01 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Thread-Topic: [REGRESSION] iwlwifi resume error, bisected
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAAMEcgA==
Date: Sun, 8 Sep 2024 08:53:01 +0000
Message-ID: <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
In-Reply-To: <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: 3d9f6aa4-f19c-408a-0caa-08dccfe3a551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ukx2WG9qRHFOdnlLWWxPaFRYTm1NYThIUGxPZkF1anJyMU5WUGRXNVlaTFND?=
 =?utf-8?B?WGpyNXY4Rmg3THJvUHRxRzd0UTdzdnFFUWR1Kyt2WVIwNU16aVBhbHgvZ3M0?=
 =?utf-8?B?V0xlK1M3N3c2dFhENmthTkpWdG5zUk1HcnNYTnBsOFZ6by83RGdDN29jcjZB?=
 =?utf-8?B?NVphV3dMVjN4RGs2UVhTdWM3dnQ1cW5UQUZ4REZocHc5elRyakVUeXpWZHZn?=
 =?utf-8?B?YTZxbFdteXYrbmc3Y0VNUmNmSkFQNWZIeW5nTWUxZjQxcHJYd0xYN0RwOEJ2?=
 =?utf-8?B?M2lJdXliOXczbjd1QS9BbFcrbzY0RkhITEh0WWpJMTVRbngzSi9kVlovRXZU?=
 =?utf-8?B?Sk9zaEI1KzFYbkJrN05BVjV1TEYraGxMamRqdUo4K3NmYWJwWTJzREhzTmRs?=
 =?utf-8?B?YXQreDJCbDRSQ1FLUzMycVdwZ3d0bXljY0R0YnZJaWw5Tm9aRlFzQWg3cEdB?=
 =?utf-8?B?YWp0SWJ0KzA3T0ZNcWVZL2JKbjUraHBPbjZmTmVtT2lnQTlJbmZSemJEQmtZ?=
 =?utf-8?B?TllZblRGSUJJNXZtWFdVWlJVZ2FLTDBPRU9QWjlPaTlqZVNGR1lpSGkxd2xx?=
 =?utf-8?B?aEFmYWhicGZDSCtLZUhvZDBabFFESERmc000Q2NnbHBTd0ZlV0lGa3IwdVlx?=
 =?utf-8?B?bCtrdG5TQXN0SldOREF5c2hsRTFGVGhKOUl3eGFJTDFHRks3eGY0WUFmRWx1?=
 =?utf-8?B?TnVJZ0JpOE1QV0NQbGtwcUhCeFdmVEh0QUd2d2xMTUloeGwvK2w5Y1lXYzUv?=
 =?utf-8?B?YmhJNG5xM2NyWkFEaDA4TGgxbkoxZWl5cnVoWFFBY0luK3JVZmFSVEdLcURp?=
 =?utf-8?B?SjRZTVh2bE5zcFc1N1F1NDRTWjF6dXlab09JdlBPNnpCZHBqVE5rZm9jMVJs?=
 =?utf-8?B?ZjlLbUhDdTViMmlSMmFJNFdlOXpXQ3hjdHFEMkFQL3YyOFZyUkFuNlRXQlVQ?=
 =?utf-8?B?MlB6R3ByaXhwd1BaYjFHVjEvQVp1UjZCTkRkRXdiY2VJQUFNRVlHSEpuZHZV?=
 =?utf-8?B?TldnTm1kb0VPUUF2aTBjNHdBUzVtMnd0SEF0QkZ3QjREUVc0TVd3VVdmRkZq?=
 =?utf-8?B?RGtUNVJrN2NjLzBIUTI2OVlyc1cvNUM2QzNGVEdlWElONjdLQlRyTXE3eXZV?=
 =?utf-8?B?L1V1aTI0SVFEb0MrZWl0d08zR1NaVzRBa2xxLzhoMXZBM2VCbC9yOVZXT1dW?=
 =?utf-8?B?QVdnZVcrVnNLQ2lPT3lvVUZjVzE0OWJUL3BpNEdVYXJ4N2d5ZEdVNnFSSHB4?=
 =?utf-8?B?VFZaeUhhS1FsK1pqMWphRi9PTmV5ZHlMU3U0eGcvY3JhUFhKTXI0eGVPMFp4?=
 =?utf-8?B?WHFwM203NEtob1NLQWUwcno3cEZVOVYzMUxpTC96blQ3S1RaZGQxdW5MdkNz?=
 =?utf-8?B?eFVmbHNaMFM3S0lEMEc4N0p4V0xSYVo1cW1PbjhxVnkvNno3MlE4UFl0U1FQ?=
 =?utf-8?B?M2NBS2lrckR0RXhLMjhQUnh3WEV6YVZhdC8xWm5EV3JEZ25ScTFzb2RGSk5R?=
 =?utf-8?B?MmlDdkpPVkRXcWdSc0lBY0R6UnlNdkoxeWc1MWUwQ0tDVm9oR3RjdzNScFNr?=
 =?utf-8?B?YVEyRTJuVTV4SER5RStONlQrNVZOM3RaTjNGcVJNNUlhR3haZFBScnp5b1dO?=
 =?utf-8?B?WXFaenVyTjY3OG9PVTliVVY3eldhak9BY0FqYkM3SlRTZ0Fvbm11UmwyNXho?=
 =?utf-8?B?YkFreE91Skg2UWp4Zy9UcG5SemoxWGdTNXlyV3RKenBMMHM3QUxZcHZubWZz?=
 =?utf-8?B?bXRLWDh5TDJ4LzhDUXBEM0h0NjBoT055bCs0ZkkyLzB0bUQvSWp6b3dQNFFs?=
 =?utf-8?B?Tk1zUWhJaGhucUtRRWJNZEFEVXN0cEhtd0p1NlhnSFlzT0ZUcDVJVFVvTWhI?=
 =?utf-8?B?dy84UVk1bnJaV3hKL1JPUEdXUGd5Tzc3Vjk2c1pwN04wc0hTM29OazE3Sld4?=
 =?utf-8?Q?2X+rufAJWuk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWRzYkRtMStCS0pSSlpBbktFcmsyT01EL3NTZ3RNY202VUx2TlFlUzc5VVVr?=
 =?utf-8?B?WlZpODlyeXhJcVVaMlZvRmdQcGxCZUpWOTJCV3BGVU9wWXZ0Q0wwWXMzYUQ4?=
 =?utf-8?B?Z1RRWnF5MTJrREZ0MmQ0a2hiYWw3NnRycWJFS1prUEs1M3F0eUFRNUIzWEFT?=
 =?utf-8?B?dHdRKzAvOTN1ZzBpak1wVjRmbVExalFiNDczZStWb3N5S1dpYmhSOCt2cXN3?=
 =?utf-8?B?dC9mYXRUWld4ZkFPS3RNdEh2T1pSRTExQWtMQUREU0IvK2hZZDhsMWNoN0R5?=
 =?utf-8?B?T1lZbjhGOGlsZmRRbnk1L3NTSHFZV0pXMDBOL0JjZVoxN2Y5MDI3QVk5amlG?=
 =?utf-8?B?VHAzYnFxZ3N2NXZEV3NlQWhxWnNnZDdtSmozb1ZRTHQwOTJidzFkS0RhUmwy?=
 =?utf-8?B?RFYrQ29STmtnbzBXbmZqb3JjdzZLS0t4SW1uTXpOdThjZzNWZU9wcXJSblI2?=
 =?utf-8?B?ZWhBc0NPam9HcEhBNG0vSDl2eXRheC9rVXpoK2h4QmFkUTkwTCtqYmRPWjB2?=
 =?utf-8?B?cVk4SFVOKzJEZVZaWHAwRHI1NU52WDU4MUtITG9mQ1pyUXVIMk9ma0lycXFU?=
 =?utf-8?B?OWdPcUE4NDBoWWYwZjRVeXlpWWg3VVg2QzQ3QnFOeWFrZWh4SFhwNE1PMC9w?=
 =?utf-8?B?Q1pta1k4NjhTcFdndVdrUWNSVzFNTjBFMG1QSFk5N0FBcU4wNk9kUE9aMmRr?=
 =?utf-8?B?dG9pZ1NqTmZRdHNUZzhOZ2gza2tSYjVGRmVTRjFOOGwwWXB5QW1SekVoNUdm?=
 =?utf-8?B?QWtsR2lVcFdoUWZvQWNvOGdXQVFmY3FXM2UzdmhBdDhVWjM4VWhnQmtuRzFP?=
 =?utf-8?B?dTgxUnFiOUN4anQvTmM0eHVMWDlaTmJnb2UrODNGUTljV2ZiR3VNN3JTU1VY?=
 =?utf-8?B?c24yMUFYb1B5RldCOUFKcmF5cWxqQVlLM3BjMjdkQi9rdTB1VFZOZ3MveW9y?=
 =?utf-8?B?VzhQaE94Y0hkVTVFWDdZdVN5WG1hSStzckwrL3krbmUzWkdrSW5LeXZQNXIy?=
 =?utf-8?B?M1cwTE1QVlZpbTNtM2hBVDI0ckVGZTR0VUNsVUk5SC9vdG1MdFlEbk9MYlkv?=
 =?utf-8?B?ckRjUjgyb2d6OW56d3V5RTd1MkpWcUZaUlQzelVVQUFmaDRJM0RhQzlEL1NB?=
 =?utf-8?B?bjliVzF4VHFXNWFIdWhSNTl4SUpVTnUvYXJaUXd6cXpoNU1mVTdhY2x3aEpx?=
 =?utf-8?B?eC8yWG9nV2YzMnhQK1B6bTIvTHdLT1grMGhmaEJjelBBN2wzWjNNWDE0UU40?=
 =?utf-8?B?ZWtwczE3Y3lML3Z1WEwwb1BGdTVQZTlOWHoxTWk2b3E0VUR0bldiTGRubFJB?=
 =?utf-8?B?UlQvbmxLNEhqcWxRWU1FdGxIRmRCNjY0eUpNbXB4c09QNGhSc1FxbFRPQTRM?=
 =?utf-8?B?SGwrSGlkMThUdTRIeXZoOUswSXlISWc4NE1HVmw1STZ2VTJqWHdrcU9kQXBV?=
 =?utf-8?B?b0ZJNTJnaG5UeUU4akoxaWJuNEhLS2ppL2dEQ3NYUE5OSENOelhZUk1UWEtX?=
 =?utf-8?B?Q05xamVPOWRBZktzTEZteW8xUE5mV0sxeHpPc3VjZ2xTcDBwcnpDYnV5TThN?=
 =?utf-8?B?RDRFUzNuOHZJRjMweEx4c0szTXpnb21yNk9tdlpJZzU5TURVNnNEbnZnVlBl?=
 =?utf-8?B?N3lkSVdzcEh4S1ZuNWVXN0toTWVSemQzV1lvZzcxTnR0NFp1dW9IMjZsRlVM?=
 =?utf-8?B?UDZYRUhScWtseDhVTnhYWEpWalBicjJZdGVXZVNQbHJGd0p1Z3R1N0VhN1Mx?=
 =?utf-8?B?elpJZVZyVU9kSjhhbThxTmZhelFmb1I1bWdSSVUzeEVtNXlBZzU4dHMwN3Fa?=
 =?utf-8?B?T2E0TnZXdWtXbHBLL1Ixa3gxYVVFUEd5RXBLN3g3em9xTmk2Nk5MLzhFOXpT?=
 =?utf-8?B?QVM0R3BPTW15b1dnRGF0blVCQWE2dHphR3JZMVNLVUd6YlRMSXdQY2xBZzBZ?=
 =?utf-8?B?NDBZNG1NZEdEdlZBSnBBcTg0OWZxNWYvdjBDUW5rVys4QTNOVk1jbEZzMEFG?=
 =?utf-8?B?UzNwclBiMjhBc3UwZUNHVFE2OEdSZ01LdExJWEpQbElXVUVhUVVPeEhhanRL?=
 =?utf-8?B?UG1lenpleXMxM05Id2ZhUFhFK3Joc1c4bkRtWE1IamhJQ1oyQmhFWUZ5Vk1H?=
 =?utf-8?B?OWlzNHd2M01iY3JFYXdNUUVCN0VDRGtrZVdLNCt0dm9BdWNYdE5kWnZ2Wkc2?=
 =?utf-8?Q?GioglQVXE9BXLdcQdxqNiuc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C177ADF2F9C6F43B081736671E3EB8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9f6aa4-f19c-408a-0caa-08dccfe3a551
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 08:53:01.7580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8EQRys/LjA5TdKyjgWL0sXYlpDHgpPNcMvkJwLz5jrJJ90vt7rWXytcbx6Xx3VyXxgV32lPF2Wi69CuvPMckCjjdBwvnDFw7uEU7hi2AzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTA5LTA3IGF0IDIyOjIxICswMTAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3Rl
Og0KPiBPbiBTYXQsIDcgU2VwdCAyMDI0IGF0IDE5OjM1LCBHcnVtYmFjaCwgRW1tYW51ZWwNCj4g
PGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQ2FuIHlvdSBw
bGVhc2UgdHJ5IHRvIGFkZDoNCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC93aXJlbGVzcy93aXJlbGVzcy5naXQvY29tbWl0Lz9pZD0wOTQ1MTNmOGEy
ZmJkZGVlNTFiMDU1ZDgwMzVmOTk1NTUxZjk4ZmNlDQo+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvd2lyZWxlc3Mvd2lyZWxlc3MuZ2l0L2NvbW1pdC8/
aWQ9Y2IzNDdiZDI5ZDBkMTA2MjEzYTBjZjRmODZiNzJkZmZkMDhkMzQ1NA0KPiA+IA0KPiA+IGFu
ZCBsZXQgbWUga25vdyBpZiB0aGluZ3Mgd29yayBhZ2FpbiBmb3IgeW91Pw0KPiANCj4gQm90aCBv
ZiB0aG9zZSBwYXRjaGVzIGFyZSBhbHJlYWR5IGluIHY2LjExLXJjNiAod2hpY2ggaGFzIHRoZSBl
cnJvcikuDQoNCkNhbiB5b3UgcGxlYXNlIHRyeSB0byBhcHBseSB0aGlzOg0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL3RyYW5zLmMNCmIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL3RyYW5zLmMNCmluZGV4IDE4MjJl
MjJiN2MwYS4uNDU0ZWIxMTU1ODgxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9wY2llL3RyYW5zLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvcGNpZS90cmFucy5jDQpAQCAtMTY5Nyw2ICsxNjk3LDggQEAgaW50IGl3bF90
cmFuc19wY2llX2QzX3Jlc3VtZShzdHJ1Y3QgaXdsX3RyYW5zICp0cmFucywNCiBvdXQ6DQogICAg
ICAgIGlmICgqc3RhdHVzID09IElXTF9EM19TVEFUVVNfQUxJVkUpDQogICAgICAgICAgICAgICAg
cmV0ID0gaXdsX3BjaWVfZDNfaGFuZHNoYWtlKHRyYW5zLCBmYWxzZSk7DQorICAgICAgIGVsc2UN
CisgICAgICAgICAgICAgICB0cmFucy0+c3RhdGUgPSBJV0xfVFJBTlNfTk9fRlc7DQogDQogICAg
ICAgIHJldHVybiByZXQ7DQogfQ0KDQpJdCBzaG91bGQgZml4IHRoZSBsYXN0IHBhcnQgb2YgdGhl
IGVycm9yIHlvdSBwYXN0ZWQ6DQoNClsgIDEwMy41MTIxMjJdIGl3bHdpZmkgMDAwMDowMTowMC4w
OiBIYXJkd2FyZSBlcnJvciBkZXRlY3RlZC4gUmVzdGFydGluZy4NClsgIDEwMy41MTIzMzBdIGl3
bHdpZmkgMDAwMDowMTowMC4wOiBTdGFydCBJV0wgRXJyb3IgTG9nIER1bXA6DQpbICAxMDMuNTEy
MzMxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogVHJhbnNwb3J0IHN0YXR1czogMHgwMDAwMDA0Qg0K
DQpZb3UnbGwgc3RpbGwgaGF2ZSB0aGUgZmlyc3QgcGFydCBidXQgSSBleHBlY3QgV2lGaSB0byB3
b3JrLg0KSSdtIHN0aWxsIGNoZWNraW5nIGludGVybmFsbHkgd2hhdCB3ZSBuZWVkIHRvIGRvIGhl
cmUuDQoNClRoYW5rcyBmb3IgeW91ciByZXBvcnQgYW5kIGJpc2VjdGlvbiENCg0KPiANCj4gPiBC
VFcgLSBJIGFzc3VtZSB0aGF0IHlvdXIgc3lzdGVtIGlzIGNvbmZpZ3VyZWQgbm90IHRvIHBvd2Vy
IHRoZSBXTEFOIGRldmljZSBpZiB0aGUgcG93ZXIgY29yZCBpcw0KPiA+IG5vdA0KPiA+IGNvbm5l
Y3RlZCBhbmQgdGhlIHN5c3RlbSBpcyBzdXNwZW5kZWQ/DQo+IA0KPiBUaGlzIGlzIGEgSFAgbGFw
dG9wIHdpdGggZGVmYXVsdCBCSU9TIHNldHRpbmdzLiBJdCdzIHBvc3NpYmxlIHRoYXQgdGhlDQo+
IEhQIEJJT1MgdHVybnMgb2ZmIHRoZSB3aWZpIHdoZW4gc3VzcGVuZGVkIG9uIGJhdHRlcnkgcG93
ZXIsIGJ1dCBJDQo+IGhhdmVuJ3QgZXhwbGljaXRseSBjb25maWd1cmVkIGFueXRoaW5nIHJlbGF0
ZWQgdG8gV0xBTiBwb3dlciAoSSBkb24ndA0KPiBzZWUgYW55IEJJT1Mgc2V0dGluZ3MgZm9yIHRo
YXQpLCBhbmQgdGhlIGtlcm5lbCBpcyBydW5uaW5nIHdpdGgNCj4gZGVmYXVsdCBwYXJhbWV0ZXJz
Lg0KDQpJIHNlZS4gVGhhbmtzLg0KDQo=

