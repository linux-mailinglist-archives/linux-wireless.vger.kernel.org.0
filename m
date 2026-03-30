Return-Path: <linux-wireless+bounces-34159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHvdCWUdymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:51:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A440435615E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2A133003995
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD050391E49;
	Mon, 30 Mar 2026 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj4t3sLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F32377EBC;
	Mon, 30 Mar 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853474; cv=fail; b=P5LJnAxzvZOpRkEyLzts/w1V1hX7MeT9Ttt3Ph7U4Mr4H2SyS8JdEFXSjDE6rOtPxWy/KOg66U9xXU9h44EFsWD/72Pj8Yja3u0cmU2N4RZfX86qji2hfemjScrJ5Cr8dBOPlYpNxRNV+i49lKmlw/z+rkXwmRIa3DWuA6ZurFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853474; c=relaxed/simple;
	bh=/EeZPPvlVdXjqEV8OY1BeZwJd2XNxXg90TndiOD4yLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRhzCyrw+Sow2SdjSeBbC4mIAJz0d6XcMZ0V95CTaXPnqHBoKvxMQsMM9fLWkZmwoA3bl0CMQidI/KwlXntnkvixv9hDs8W9y9ERB7gcxAgx2u1Wj7/zTLjAoVONKmbAzYcS9mRA+gEH3g73oI8KoRkqNOZE8TmneaUVUML3jQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj4t3sLD; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774853473; x=1806389473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/EeZPPvlVdXjqEV8OY1BeZwJd2XNxXg90TndiOD4yLw=;
  b=Pj4t3sLDZtWwZa2mpnLaDIv/xldY+Xa/+F5QEeJOIkfcb2nnD6+K7/5y
   804jmxuwQbvsmk2UfsdWi/5eVq0ySYXYl0yfIYx3PUMhr2r4FxSIJm1qN
   LEukugg8lreDc1ha2g8agxFtrmGPzsp+opEOJPp20JLDe5X7d7ax6wB0O
   LzX+KwJs/bagpirGXCt1p9Ix3zd8NUfu6QFxVsRZRUgPFhWunyHcySml1
   qY+K747hGXlZ1da0DUeoiUMwkxo+CwV3MNgqcxgLclxAJLphtDnoPiPoE
   6vdmTN5+kvOz/Ar99slWjBY550H3fwfWZtWFFbJ5N/AoiNAvCbNB0lUec
   g==;
X-CSE-ConnectionGUID: VTzWiC2EQ2Ksbetit++alQ==
X-CSE-MsgGUID: paXJ09k/Tz+mrfRPhKdaIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75732951"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75732951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:50:04 -0700
X-CSE-ConnectionGUID: yrNXSK2KQo+a22+4InX/rQ==
X-CSE-MsgGUID: IALDihrgSM602US0DjKbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="249008922"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:50:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:50:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:50:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnN5RUJk9M3yBp2v0KL3CX0/8Dw7IMbu5inmrEbiSkNg6wJ4hnF4umd0/lJG8V2J4yL07ODeJ4I6xOfRX66LMA5Q74UjxPd6tWDDcKx38Ox258HYz0qvR5HB7WJ2gOFEjOBw9l9TwLKIHsGHe0RP72Aq8BoBDGY4oRFINGvy7Lf9etkJd62auPLOWPQWLX9xDH5gejAUitTqs4FN/rJxTRS4Zd30DGQTA5zJTVPa1Sd1PRRi6oXIn0gJZJpEsO8+1aV3H1FN6oJIzG3rAcWaKgmhWm0nOF0J5KAwDMF54PuasrUJJDHpsJ0e7jHSw97DK7jKKSZF0gl0UtFYdp+S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EeZPPvlVdXjqEV8OY1BeZwJd2XNxXg90TndiOD4yLw=;
 b=cvz10bXzoq9C09zMxB/c+ndM82YBmX0ymAgtlbw1XhU0XwzE+cm1ICcrtv+t5xIwlUKnJOfxFP2sJdAETq7TKwUnniOV4auB9hDRUZLu9HZIVvAJ3jHElgA9HawSmYnJFQUb0q7LFByPv7VzM4OgvJKLsKGto3e1/GyEz91Ky2QMe6UE8GWkrsOWjkU3h+imJn1RwQFlB+MMf3ZsVMMzD2tyuiNGN7ToxBCLHi/EEsUdJu/EPAEq1OyPsewjqwr77HFU9LRrehfhygV1CafJsYAJ+B34G05Y4qc23A15Jf3JQGFFduQ+FxVNqppR42N1dBrqlRGLT4aK21onB4dzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CO1PR11MB4963.namprd11.prod.outlook.com
 (2603:10b6:303:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 06:50:00 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Mon, 30 Mar 2026
 06:49:59 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Cao, Junjie" <junjie.cao@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
CC: "horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yedidya.ben.shimol@intel.com"
	<yedidya.ben.shimol@intel.com>, "Stern, Avraham" <avraham.stern@intel.com>,
	"Gabay, Daniel" <daniel.gabay@intel.com>, "Prabhu, Krishnanand"
	<krishnanand.prabhu@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>,
	"gregory.greenman@intel.com" <gregory.greenman@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
Subject: RE: [PATCH v2 1/2] wifi: iwlwifi: mvm: fix race condition in PTP
 removal
Thread-Topic: [PATCH v2 1/2] wifi: iwlwifi: mvm: fix race condition in PTP
 removal
Thread-Index: AQHcnB5c4HUu1dhMikmnTZ9iPu2XvrXG6LLQgAAAvMA=
Date: Mon, 30 Mar 2026 06:49:59 +0000
Message-ID: <DM3PPF63A6024A9B209A2D68273E9773833A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <DM3PPF63A6024A9E1EF4081E342AF4BED81A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <20260212125035.1345718-1-junjie.cao@intel.com>
 <DM3PPF63A6024A9E6728A0315DC6653D109A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A9E6728A0315DC6653D109A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CO1PR11MB4963:EE_
x-ms-office365-filtering-correlation-id: 72095ba1-9c54-44e8-0258-08de8e289000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Jo1Q8lZJQp2H+ZnCgeHGNYHerGhI8E258JMsi/UwTZ/p1/WZQpGhcM3F1HWCNZ+QprBT4H31DNVcwH0ZWfjvF2RyQnqyV4lm6Tgb4qEl8DVscHBXZV8ZpFdFfEm46Ap82AeBvkVUjhD1ERHxhpzZR+KBPTfVn8asORcOftIWpqUObJXQGk3IGJMDtvxjbiaIZlP2+pxUAdJ9Vz3+jkZZYcKOUbOucInu4ji7G8UPxagmNefxtFNtvK2oRh+dAakjNXZenSjn2OlsAAGCOInTXiR4jJLa45MkTUtmU+6cjnzk9oNAGj/Q6Z4CMfLwOdIS7oiJTZtFK9o5pMdg0XyIVgpqk7i0Yw9ACvSV8eYJladoYWv/nwrxn/2KC5q/FsjbEpRswRQGb+qwhqJOI/0/LK/rXaUso4SJyqx6YhBStGyHDA8zOSqsNgvF06eSre1r1cmxy/XVUAxvxWjwFBUoPygyeERYFQrwXpsM4ggDoTh+Js7QIJmQXnadR2SAKCv2vCOAafINtHseNVrb8llEXkzCJdeDMY2Qh+rTvbLcTJEVDp0laQnhNTD/Z3aRP+Qn3M8w30mKsgT9rLYAnI3wXCiLGPs7cYG4X1TkWRn4hJbULGnzgvnXoLX/tFJ0IBnBWQTFuR0Kochk5TxOjYGCxKwvrzOLBjBMVWgl6Yz1GOTJawZ9FihfRLaER0PssTV/94iZybcU30sWkrURcLS/IdyuHQ8H1J0ySkM1mgj8UOyFgmPA5XQ7HPKsDxH0WyRvy2EKgXDAb2ACvn44GMbYMhIITTTUdfWZ3NfTsoM0qC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFFLYXpCUzFJTU5uZ1JGK2dRVFFkNmFnTk9NWUFqNG5tZlBvOXdUSTdaOGdG?=
 =?utf-8?B?dVcwN21zRHRnVDN4eUE0b24yODRONzJ4bGh1TVZqQTRNV0xnVWRFc0Q1eE0r?=
 =?utf-8?B?SG1BTVdQbUJLOUZZRkczT1lWWXBudlQ4b2pLSDdLc0JMTytZWXpRdEZFQ2o2?=
 =?utf-8?B?b0FvejU1QnVsMDFGeXljT1Fud3NxRXN0N2piUEdxSWxyanJOR3Fqb1NlelRt?=
 =?utf-8?B?Mno2WUF1U1E1d3F0bnlWaUVDOGllOGE0UFJXL0ZoaXpLc2NRV2dpVVArcFIr?=
 =?utf-8?B?SXA0eTVhZ3ozRCtabFNCSnFyRTNzcGVld0tra24zSHJNdWc5QXBBUzJ0OWhL?=
 =?utf-8?B?K1hrWkpOWkhlT25JclJiQkx2S1hWYS91RDl3eWZOa25VZHYxVlI5ek45QWMz?=
 =?utf-8?B?MWVaMDVWYVpnQkMrSm1kSXlBdGlMOXRXcEErLzBNbStzSWZiVjNXcE15Ky9J?=
 =?utf-8?B?ME1VbG5qR2p1RWNXSXNESkVyK2xjQllHd1ZPem9jcXNsL1NKRzBMODFwQVp6?=
 =?utf-8?B?TkxPV2wrSDEwM0ZQOVVtTi9UZDcyWGc0YmhmaWZNckVKWVkzalZOUm5TbHFK?=
 =?utf-8?B?YmpQeWlkQWZiZ2RKT2FhWHVIYVh2dE1rWkp6azB3ZFZIU0NpZTNrMEptQ2I2?=
 =?utf-8?B?MWNQT1RwUTVpWERGeExxUUowaEtzSFYwTkZER2NYUDVRMVhuT0hpbDhUTGQx?=
 =?utf-8?B?Y21xeGFHb1lKREpIYjJHcitLdmo3Wm1NTGdzWGgwRlkrYmFlc2FLZE5JMWxs?=
 =?utf-8?B?R1dhdWJIRXZzQTE5S2tSdHk5b3F3RXdFUmdFNW13MUpVUHNHbFBFM3RtWjh6?=
 =?utf-8?B?bzFVbGNiQmE4VW4vSUhoZW1ObDhXTm5kempzQWlDcGNncHBleWlwMVcwV2lo?=
 =?utf-8?B?M09lVHZBOWU0NzVDRXEzeGNLWmxYZFBIWHlTSURGa2FOenpEZ3BlUXk4amNQ?=
 =?utf-8?B?VGlYaVdrbkR6eWtEcmlGMDRTcjBVVHF0dlJvc1pVMzdpUmpTMXFMNHZacStz?=
 =?utf-8?B?c24yYnF2M1dXTm5QTlBCUXBNclFKTjNIMlgwNm5SVmNzVzJwWUZOYnc1UzRD?=
 =?utf-8?B?Vk14dW5USG8ycDZMbjJpT1d3c1ArN2V3dUNvZFR4S0w5dkFycWwvVmV0MzRr?=
 =?utf-8?B?OFM5SWVOQzdjUDZDK25RdHh3T1BJeURMcUdSWFQ2Q0h1Q0tFNjc5bFhuYnYw?=
 =?utf-8?B?TC9waTkxZmJSZ1JlNjc4Q3o2ZDVBZjFsY1lYb05uYzZQeU9LNXp2NDBTK1ls?=
 =?utf-8?B?Zi9tVW9CRkxyMnRTWkNwQitQMWJxNVhRbDYwWEZPWnFvS3JkeWw5RHh2bG1m?=
 =?utf-8?B?NjREWlZHUDc2d0h3R01IZVBldDM0NERvV3FVZDVCKy9UL0Vpc1JOenpyYW5B?=
 =?utf-8?B?WXQ1dVA1TkpRMGN0QVkwODg5dTdiTmxqWnc5LytyUEU0OWtpOUNqSTg0a3lI?=
 =?utf-8?B?UWpQQmxhOVBPczRlOHVUOExPem9FbUlXY1hwdTE4V3RlR2hTVEpSYnlnUVJB?=
 =?utf-8?B?VURZOS9XQk4xOURmMENuem5tTkFVNnpiZ1d5ZGYzNlF5SjJTZmY0VFcwaXRQ?=
 =?utf-8?B?TVdWd3cvT1JOKzltSi91ZXNmbitMNHU0RlZ6OTBsTW5nZWNCR0xWeHF5V3hw?=
 =?utf-8?B?Ry9qbTZ4S0NlaWROcngvNEg5ZjM5VENaVlBQM09jcEVUME9CSkluK2JhNWFC?=
 =?utf-8?B?UzM2NjJjTFNFNDRyS1hlc2UxUFVuUWNTSFoxUEtmOTdibkdDNHNLV3Rza0ds?=
 =?utf-8?B?NXJYYnRxVC8xYStoM2UwVktNUWdOaitOOWdGdkFSRS95dzJEZFBBMXcyYlUr?=
 =?utf-8?B?NHNsbEZ4clErZ1VKSlNMb1NZYTNCUTZBWTR1VEQ3RVlXY001cURDMlUzMnF4?=
 =?utf-8?B?S2hFYXc3TCtjQVBnSzI3YlZ4eFJhVkZsZUNzcHlNeFJ0TjZWcFFTbTZSZWFa?=
 =?utf-8?B?Q0EwN0xaZVkxQzlodEd2azZwVzViNURxamhBVHVrZ3EvdEhiWHNaaGRVSGdG?=
 =?utf-8?B?aC8zdlJmZW4xU3BJM01Rc0VmcjduRmpjUlFmOEZNOTZNdU9nRGtuNUw2V1JC?=
 =?utf-8?B?L2EzMmxUMWZ5dUlxVGFyVDdObms2dUV2MW56MjlWeXgyOFJXYTJwTVgwa0xy?=
 =?utf-8?B?dkxud2grdkh4R1pOTVM3MlFqUkNhUE9uS05YNXAzLzI0Sm1BUU12TmRyNHo0?=
 =?utf-8?B?TXd0STFPczFYVUJ5MVp3akpHSmRqODlNdytmRmF6U2F0blhlRmtkMFQ5MndN?=
 =?utf-8?B?dmFLMVc4NTNpcldKa0o0Qi9Ld3prZVg2VURicDZ2WmFLc1J2N3lGSXh2ekVz?=
 =?utf-8?B?cWs1bG5sKzcyZGpORnJNOEc2NnZpclNpbzZZS2gvUzQ3U0R2Q25BTGlRd1Nv?=
 =?utf-8?Q?Exc/ACbe6bCb3t1g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V9BHrcHpZaLzv+lu3Vnfw5oUFki7yQXt1MARr1cKGs0rePoMrm6ZqoFII3GMSanRt0C5FXSCJzZaKsTVF1GQdwCVs5Y9o9nxKYZ47cEqRfPuWZr1Tiuun6YiSEEvEKb2MFuKtBKwrxFNgKNj/BE2LZupFfU+a8LYhsxqma2qvTf/3BwHYi9FApm2ZTaTttYRSYWIPyyhMVi5uDsQgJMmm6tdIPqIvFnBBfGYXZo3kzEmXa3rOH2Ise5S+TgMLzwCskctNKlDQpU3QLfN3sAzcD9GrzG+uHO5tAFWLYyTNJgsKsoQmrzKEMS24b5SDMNskiCEy7yz7u45ZCnng7HOuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72095ba1-9c54-44e8-0258-08de8e289000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 06:49:59.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7jtYicODyBvvQvosQecQOCjzzXNjVeEacJmWNVoN4C5A022bFjJxKCMV6QCeGAgTcB5UbTeo2fh2+OvekR9nEpENdXFqbiJIywJdxhYBatVaNRfEQhMqwfWrnGwFKI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34159-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,vger.kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A440435615E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29yZW5ibGl0LCBNaXJp
YW0gUmFjaGVsDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMzAsIDIwMjYgOTo0NCBBTQ0KPiBUbzog
Q2FvLCBKdW5qaWUgPGp1bmppZS5jYW9AaW50ZWwuY29tPjsgQmVyZywgSm9oYW5uZXMNCj4gPGpv
aGFubmVzLmJlcmdAaW50ZWwuY29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0K
PiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb20NCj4gQ2M6IGhvcm1zQGtlcm5lbC5vcmc7IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHllZGlk
eWEuYmVuLnNoaW1vbEBpbnRlbC5jb207IFN0ZXJuLCBBdnJhaGFtIDxhdnJhaGFtLnN0ZXJuQGlu
dGVsLmNvbT47DQo+IEdhYmF5LCBEYW5pZWwgPERhbmllbC5HYWJheUBpbnRlbC5jb20+OyBQcmFi
aHUsIEtyaXNobmFuYW5kDQo+IDxrcmlzaG5hbmFuZC5wcmFiaHVAaW50ZWwuY29tPjsgQ29lbGhv
LCBMdWNpYW5vIDxsdWNpYW5vLmNvZWxob0BpbnRlbC5jb20+Ow0KPiBncmVnb3J5LmdyZWVubWFu
QGludGVsLmNvbTsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgVmFkaW0gRmVkb3JlbmtvDQo+IDx2
YWRpbS5mZWRvcmVua29AbGludXguZGV2Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDEvMl0g
d2lmaTogaXdsd2lmaTogbXZtOiBmaXggcmFjZSBjb25kaXRpb24gaW4gUFRQIHJlbW92YWwNCj4g
DQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IENhbywg
SnVuamllIDxqdW5qaWUuY2FvQGludGVsLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwgRmVicnVh
cnkgMTIsIDIwMjYgMjo1MSBQTQ0KPiA+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1p
cmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47DQo+ID4gQmVyZywgSm9oYW5uZXMgPGpv
aGFubmVzLmJlcmdAaW50ZWwuY29tPjsNCj4gPiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmc7IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbQ0KPiA+IENjOiBob3Jtc0BrZXJuZWwub3JnOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IHllZGlkeWEuYmVuLnNoaW1vbEBpbnRlbC5jb207IFN0ZXJuLA0KPiA+IEF2cmFoYW0gPGF2cmFo
YW0uc3Rlcm5AaW50ZWwuY29tPjsgR2FiYXksIERhbmllbA0KPiA+IDxkYW5pZWwuZ2FiYXlAaW50
ZWwuY29tPjsgUHJhYmh1LCBLcmlzaG5hbmFuZA0KPiA+IDxrcmlzaG5hbmFuZC5wcmFiaHVAaW50
ZWwuY29tPjsgQ29lbGhvLCBMdWNpYW5vDQo+ID4gPGx1Y2lhbm8uY29lbGhvQGludGVsLmNvbT47
IGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tOw0KPiA+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7
IENhbywgSnVuamllIDxqdW5qaWUuY2FvQGludGVsLmNvbT47IFZhZGltDQo+ID4gRmVkb3Jlbmtv
IDx2YWRpbS5mZWRvcmVua29AbGludXguZGV2Pg0KPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAxLzJd
IHdpZmk6IGl3bHdpZmk6IG12bTogZml4IHJhY2UgY29uZGl0aW9uIGluIFBUUA0KPiA+IHJlbW92
YWwNCj4gPg0KPiA+IGl3bF9tdm1fcHRwX3JlbW92ZSgpIGNhbGxzIGNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygpIG9ubHkgYWZ0ZXINCj4gPiBwdHBfY2xvY2tfdW5yZWdpc3RlcigpIGFuZCBjbGVh
cmluZyBwdHBfZGF0YSBzdGF0ZSAocHRwX2Nsb2NrLA0KPiA+IHB0cF9jbG9ja19pbmZvLCBsYXN0
X2dwMikuDQo+ID4NCj4gPiBUaGlzIGNyZWF0ZXMgYSByYWNlIHdoZXJlIHRoZSBkZWxheWVkIHdv
cmsgaXdsX212bV9wdHBfd29yaygpIGNhbg0KPiA+IGV4ZWN1dGUgYmV0d2VlbiBwdHBfY2xvY2tf
dW5yZWdpc3RlcigpIGFuZCBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSwNCj4gPiBvYnNlcnZp
bmcgcGFydGlhbGx5IGNsZWFyZWQgUFRQIHN0YXRlLg0KPiANCj4gQnV0IHRoZSB3b3JrIHJ1bnMg
dW5kZXIgdGhlIG12bSBtdXRleCwgYW5kIHNvIGRvZXMgaXdsX212bV9wdHBfcmVtb3ZlLCBzbw0K
PiBub3Qgc3VyZSBob3cgc3VjaCBhIHJhY2UgY2FuIGhhcHBlbj8NCk9vcHMsIGVyci4gSXQgZG9l
cyBub3QgcnVuIHVuZGVyIHRoZSBtdXRleC4gU29ycnkuDQpTdGlsbCBub3RlIHRoYXQgZXZlbiB3
aXRoIHRoZSB6ZXJvZWQgZGF0YSBubyBoYXJtIHdpbGwgYmUgZG9uZSBieSB0aGUgd29ya2VyLg0K
DQpXaWxsIGFwcGx5IHRoZSBwYXRjaC4NCj4gPg0KPiA+IE1vdmUgY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCkgYmVmb3JlIHB0cF9jbG9ja191bnJlZ2lzdGVyKCkgdG8NCj4gPiBlbnN1cmUgdGhl
IGRlbGF5ZWQgd29yayBpcyBmdWxseSBzdG9wcGVkIGJlZm9yZSBhbnkgUFRQIGNsZWFudXAgYmVn
aW5zLg0KPiA+DQo+ID4gRml4ZXM6IDE1OTVlY2NlMWNmMyAoIndpZmk6IGl3bHdpZmk6IG12bTog
YWRkIHN1cHBvcnQgZm9yIFBUUCBIVyBjbG9jaw0KPiA+IChQSEMpIikNCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtl
cm5lbC5vcmc+DQo+ID4gUmV2aWV3ZWQtYnk6IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3Jl
bmtvQGxpbnV4LmRldj4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKdW5qaWUgQ2FvIDxqdW5qaWUuY2Fv
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vcHRwLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0cC5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL212bS9wdHAuYw0KPiA+IGluZGV4IGFkMTU2YjgyZWFhOS4uZWZiMjkxY2Vi
MGU1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL3B0cC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vcHRwLmMNCj4gPiBAQCAtMzIzLDExICszMjMsMTEgQEAgdm9pZCBpd2xfbXZtX3B0cF9yZW1v
dmUoc3RydWN0IGl3bF9tdm0gKm12bSkNCj4gPiAgCQkJICAgICAgIG12bS0+cHRwX2RhdGEucHRw
X2Nsb2NrX2luZm8ubmFtZSwNCj4gPiAgCQkJICAgICAgIHB0cF9jbG9ja19pbmRleChtdm0tPnB0
cF9kYXRhLnB0cF9jbG9jaykpOw0KPiA+DQo+ID4gKwkJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
KCZtdm0tPnB0cF9kYXRhLmR3b3JrKTsNCj4gPiAgCQlwdHBfY2xvY2tfdW5yZWdpc3Rlcihtdm0t
PnB0cF9kYXRhLnB0cF9jbG9jayk7DQo+ID4gIAkJbXZtLT5wdHBfZGF0YS5wdHBfY2xvY2sgPSBO
VUxMOw0KPiA+ICAJCW1lbXNldCgmbXZtLT5wdHBfZGF0YS5wdHBfY2xvY2tfaW5mbywgMCwNCj4g
PiAgCQkgICAgICAgc2l6ZW9mKG12bS0+cHRwX2RhdGEucHRwX2Nsb2NrX2luZm8pKTsNCj4gPiAg
CQltdm0tPnB0cF9kYXRhLmxhc3RfZ3AyID0gMDsNCj4gPiAtCQljYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMoJm12bS0+cHRwX2RhdGEuZHdvcmspOw0KPiA+ICAJfQ0KPiA+ICB9DQo+ID4gLS0NCj4g
PiAyLjQ4LjENCg0K

