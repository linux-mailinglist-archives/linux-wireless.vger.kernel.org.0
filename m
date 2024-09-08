Return-Path: <linux-wireless+bounces-12633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5229706C4
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BBFB21553
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04614C59B;
	Sun,  8 Sep 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajsS+ueW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC441531C2
	for <linux-wireless@vger.kernel.org>; Sun,  8 Sep 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792856; cv=fail; b=d0c5Qyh/zLYTFaEC1ibf12ltm9U0TNDk4+yL4vQVWGIq9A0AvLvxPqznfq7fMIZMSMV8+wnUMfYLa1i0bEVGDJWBeeVJcFt+ZsYh/fB1to2UuNjIZ5QYZxtuN8FDOSp1z57XsFbI0Godw9VgaIlDKpJrworzHnP93D5H/xoBTQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792856; c=relaxed/simple;
	bh=9hQeNKQ2zAwuiPB5WLTH2g9XMTIORv7P6Tjxjhq8A0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofEP0QgJLb6x3sHiefdDYybF3lk1/ovZpX0X6tbWBflt6HFoTnwrgA3/GhWqb+7zwQeo4PfC8WuHtIN63J+BPf8n7nGw6LPgEVU/G9ygWNfjVVEUKq/6snwvYBYC4NPaN6we5WATVuuaAgYrRrM6ikW2EDh3YLfTwvu5BUcoTVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajsS+ueW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725792853; x=1757328853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=9hQeNKQ2zAwuiPB5WLTH2g9XMTIORv7P6Tjxjhq8A0A=;
  b=ajsS+ueWAZWNbSBLXQeseSMoFp+Y8pls8b7QsG5jFszQZj60HXivb9H9
   M+KHJRKNfbgZHaVVfzuiUZSQ4+4QsDn40kvDNyBbK57IDhhZACyQ8Qnqo
   08WqxMD1f4FFiebV/4NiRZ1iOkTmsP929kqFRwYsaw+XKMQCTp0fpzt/Z
   FtaXZoBFHE3n18QQ81hqueJ7OIHw4YKsBywvvpJS5ZmA7Ua0vFn1QJT8i
   GZyX+4r8cBb2Rsz1WMXvz4DB26UQTC2sHsqbD9A31nZzVPPjQFkEh7AuF
   Zm9Bex7vl6boyjmy0XolGPS7vhCayUj2zyGoQFNGzfX/oKROhISXpCRbU
   g==;
X-CSE-ConnectionGUID: Hc9CWF6KQ/SzKrTmS93f8Q==
X-CSE-MsgGUID: 7ZDM9ljoRmi1/mK+e6ofxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="28234939"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="28234939"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 03:54:13 -0700
X-CSE-ConnectionGUID: sDsAmqbSQs+x4c0YgB2NDw==
X-CSE-MsgGUID: Y06xqhAORLmEW9YlD35s0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="71174740"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2024 03:54:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 03:54:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 03:54:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 03:54:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Sep 2024 03:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUBPGMVEb/MwMdxF436oXVGj+Wwhfj2mQINqxgEeIFZhEx20pDCUibwGWtYi70JiE1GssXG8wNj0AwDr3eWTLfV6mLqaxKK3J/CSiKSQLUsfoyT/dwVVpWQQuVnwOwhXfdLd616puPjxUhvZ2pFKtaPhnOsdyg1jT1aLuRuovNUnof330mOoVgq5u7e1gm3H0mn/H17Yrs9rxqJ1ns8Y7GPPdBNr7/K/yLMDixP7h0tGwdbbYn1tXz0Voc0wXKZ1GQOV0oicmDXcvqrECqel2iaLTZLC5m0fW2vEzK0qRqKzjwWXwoxYuH/TJaCjQBDuVAVDUb+9I7UYFAm+3x7pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUzqQPaz3AXN9DqYU/tVw1ijHgNLz4Lw3T4kz0GOHSU=;
 b=iuymfJsGrd2L3izmKzq6a3BYCoIFw/vFr20LGLG0nmzIkcpgMi1aWM5UUWn+gedx758dk9QeLJSkikbiIxfxJdFT/kiMryEnhn/E4fxAY3UboUlDdGHGQqRCErJ/yM4+cZ6gktLFMpPHsQ3bVgpsx0hzM/LlfUMp9lAE1V4RI1LNTBEVyq07bpd4fWu5t9bYmrgWEUsMA1iKkIxd2TfKoIRg65ESJsFVYlbFEK3c8yQ/uB7UtkQTqaKweySL73ByqyLcc/oYElpAVtTsYFXISOIUjKpBRZI6wtPzy09uTuGOGbTCVUl2RqrAjx7mV9Cvs16CUn+x1pNSdYvx5nNsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sun, 8 Sep
 2024 10:54:09 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%4]) with mapi id 15.20.7918.024; Sun, 8 Sep 2024
 10:54:09 +0000
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
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAAMEcgIAAIYgA
Date: Sun, 8 Sep 2024 10:54:09 +0000
Message-ID: <d3a83162570aaede579ecde64e00350ce1e6b452.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
	 <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
In-Reply-To: <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|MW5PR11MB5811:EE_
x-ms-office365-filtering-correlation-id: e2f427e4-c322-4559-4f7e-08dccff490f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VXovSEIyVzNHaXNrZmVqSVlzWDA5OFlVbDd2UC95d2dQNVlUd2NjUFEwSEh4?=
 =?utf-8?B?dHQ0dVB3RUZORzUzZ2p2eEdXWWNUcDgrSFJCcUdTRlJ3ZUdXV2hqK0JiNW9O?=
 =?utf-8?B?MmlVRjN1OFBTcERZdjNGdHFyK01GUlhUVm5EQ2lHTXlFYmxjRHlrNFdJYjlx?=
 =?utf-8?B?RlNhVGFaajl2U0w2N2hZMHFVd0tPUkFkU3lQTVk4UFA5T0NkWUdhT0dTZk1F?=
 =?utf-8?B?V1BTL0hzeHlxS3g3NitTaVhROGpnc1crT1Eva0NaemdDOXdiUHlBODhpTGho?=
 =?utf-8?B?Zk5HYXR3dUFCS2pkVVBtUW42UXR4RzFWcVJDM0FCOThZRnpzMDZ6bHBSUTh2?=
 =?utf-8?B?UTMwUW1yZXB3SkpCbCtKQ0NHNlI0VkE5QmtkaXpPNjN2Z2RuYkRNOFd1TzZy?=
 =?utf-8?B?VDBYbFlESGFFTHJidXVzc1ZHNll3M3FmUGFSWVA5RjhiUm9HWGJqUzR2L2hZ?=
 =?utf-8?B?YlBZNnV3TEd6MGRqbFc5ZHJ5RXNWczdna05RQkh6RzVmY2dWT24zR25kNTBp?=
 =?utf-8?B?dUFPc0ZwZ253Q1BnU2hhUnZRUEFpYVRsaUhBSDV5cUJqbDhaZmQ2SmlLdzlG?=
 =?utf-8?B?aCs2UWJwcUQ5cHZEOUNYSmR5cVdPaVNYZDl0Q2s2c1pWMkdRck5uUWI0dEpq?=
 =?utf-8?B?eURpSzQwS1psK2h3SFJ1WGp0MEd1MzcvdFlqMUZZazRTTkNCRnB4L1U0bjVD?=
 =?utf-8?B?ZmZ4VEdBWmdZZDB3aytTejE4UXYyRWNJYjRmelkzbS9jd2krMEJnTFdoU0Rk?=
 =?utf-8?B?dU1xb0lqNkxVWGx6UU4xTUU1SDE4cG5PWGl1WWkrcEFUcVlSN0QzMUZKVmRy?=
 =?utf-8?B?Mmw0T29YWUxLOFhiN3BQWmZqVjZDcFJYNEVkZWxXOEU1KzQ0OHZWU0trR1ZG?=
 =?utf-8?B?U0UwUVUydnJid09DUGF0eXdGaEIrd0NXdWJWS1JQY3ZXU3JmOWlEU28wS29n?=
 =?utf-8?B?WUUvdW4wWFEzVzM1d3lWSDVianY5MGN2QlljYkpnYWJMRzhLakVVam56VGZq?=
 =?utf-8?B?SmY1Y2JpZEZnM3NVaTRZVU0xY2F4RmJiK1dtMThCSFhJSFdTNllEbml2eG9z?=
 =?utf-8?B?ZXBYd1JUV0tuRTFaU000NktpM0Q1WWpNL294VHd6SHBrc0pGTDFBdkFRWStm?=
 =?utf-8?B?eThrN0l0M2FxRStpbWFyVEV6aHlWMXJXRHo0UTVuK1p0UjNlUjY5NDFRUktv?=
 =?utf-8?B?WUZTQksrWjdLWEFPUENEZ25PUG9keWNST3pjRDdudXdCWTJubC9zNWhGUWNi?=
 =?utf-8?B?VkRaTFkvVkIwWUVEVUtFK3ZvY01Wd2FiSkFzei9FSnZnMkU3ZmYvb01WbCtR?=
 =?utf-8?B?K21NcGN2aEtCU2U1N25JTVh4RzZZdFRlWWdaTjdCS0o2eG1ObTlYUlY3TDdI?=
 =?utf-8?B?bXlKanB6OUVwU1FPbmZkcjJCcEtOdjlYcUJNWGN5M0tLKzVFS3ZyNWwvS3VV?=
 =?utf-8?B?T3l3dHZlT2NJVXJSNmRJd0xUNUx5a1lBOVFFd1p1bXBONnRadFcwalZzem8w?=
 =?utf-8?B?Si9jdmhZWktJd0tSbitCcWVjZ3dtWnJJZFprUGcycjRpaHRSV2Yvc2laM0J1?=
 =?utf-8?B?T1QxZVRHN3d3MHphSXdrN2YzVmpXU0R0dlllSlYwVUhPbEhTTjBNeWVhSzdX?=
 =?utf-8?B?ZG5PRnAwak5kMVVzQ2lDbnlLQlpRMExhN2hOdmEvRHhvVG9ZU2Q1T09FYzBD?=
 =?utf-8?B?WUExNTJ5bkJIUTltNnU2S1ZCQ2dqUk84dGtNSm9wWnJTWnFxZlZMa2VidVpw?=
 =?utf-8?B?VVpDVUdJNGE4NDhiZkI2MFYwRkJSN053d3FQZzc0Y0E0dWp2UkhVeG96RFlM?=
 =?utf-8?B?REZvUldkM3RrYk9OQmVJdVFHZlRPa1dvejRZSWwrL2k5dHhGc1ljTjdhR0JW?=
 =?utf-8?B?ZnhyUXo3akYyRDVuaDBwSUltczE0RmVyRGZDNTM0SDFUTkdlT3NVdzM3eGpO?=
 =?utf-8?Q?A4YQbIUvK1Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjdZZ0hKSFBJVXEzeFlHbVUyTkF0bnJaZ3ErODhEZVdWNkN6d1YyNjQ1TGcr?=
 =?utf-8?B?OXd6Slk2VGRFWXRKdkszR0pEVkN2TzRobzlzTGhyU2dLZzF1c0pJVm1HSCtX?=
 =?utf-8?B?bUNhM1pYbGwrcEZSQnp2NGhPNC9DNWlYcUhHU2NwUTkxUHl1QUs4QmZodmtS?=
 =?utf-8?B?NTRHbkNVTzlQSVcxQ2RMdHlISEtkMlIrNXNNWkFpZEo2Y014NkRRanNkQVNG?=
 =?utf-8?B?aGFyL3liTUVxWFBBZVVmSVlMY2dLQnc0QURZeVB0aDNLdlhSK0M3WUxXMVM3?=
 =?utf-8?B?UzNUUGNuOVRNcm44dFdsZGd3YngrU1VGbm1tQitaZklQYjNjU0NKK3BVZkR6?=
 =?utf-8?B?bEsySTJ0UnhnZGlJSXJxd3NkajVlOUtMZ2hidHc2RUplL3VoeXhiT21Ha1Yr?=
 =?utf-8?B?cExSb0JYOXF1bkNPKy9Uckl4NklWR0xySWZwQ29HaHA2MFhsU0lLamtsS2h1?=
 =?utf-8?B?TkkzcW1SKzJmRFNXbm8vMXdvWUNURXNVZndPNjZ1Tkp2MG1rN3JsUGNkTWtv?=
 =?utf-8?B?MXR6YjJrU003TU5oUU50RTlFa3BJTTZTVjZ1bEpZV0tMR0MwR3YzZW02MXNl?=
 =?utf-8?B?RzFyNC9nZTg4MEpabzVBU2x2L1UrazJvakdZU09ncHYvSU1GSi9SK3hqRFRo?=
 =?utf-8?B?Qmx5QkVCYXBEekRiWjQvNEtwMXdqcEczck9pZ3BtemlFTFI5NHJiT0Q0YUlV?=
 =?utf-8?B?R3h5MkNlSHdDbmU3cFlxS2k2SHhhQkJueFpYR2pyLzM0N3phWWZBVEY4OFVv?=
 =?utf-8?B?OFVMK2J5NTJVVFpuNFZBMjFnalp3Q2k4WFdzaDF5cmtYajIwVmtQbllLWnlW?=
 =?utf-8?B?T3FIUmF6ZFo5RHRkZXkyQkdYeU9kOEZyTytaUndEcU13MEVCYnc5cVpITGlw?=
 =?utf-8?B?MG5NZjdxZmdkUTlOdXlMTTI4NTlKcCtDWjVxYzlZdGZkbXlYZysxb3VGTFUx?=
 =?utf-8?B?bER5SjZyMlY2SmQrWE02TS92dUNSYUY0b0lieWVvN21KNVNNZzIxcGhEdVVK?=
 =?utf-8?B?NzJTL044b2s2RGFtc1dqOUdpVFlSVFFnRlBFRDQyL1VvL0NET2VGb3c1MWpB?=
 =?utf-8?B?d1RENEgwbG1OelZOeEdoT0c1cURHeVo0bVpCcE53aTZ1TGorYTFlQXBPVmIw?=
 =?utf-8?B?VlZIRC8wVG1nMWRBQlhBWDV5c1FsZUVsdi9JMFlpK2NpdWZyeVkydU1PNlhO?=
 =?utf-8?B?bGxVZXdVRGIzQmpEVnA2Z1FRWFIwbkMzZmRtdzY2SG1PSk5MeVI4dnhCb1cx?=
 =?utf-8?B?UFQvS0VsZmowb0ZSMXUyV2VzQzF0MGZ0V09NUlRrZFkrSDAvZWoyREwxcHpW?=
 =?utf-8?B?ZFlIRFhUZnRLNjBMQUFjVjE5ZUJFQjNOaWZ1QTdHblh1THRIZHNtL1FCbERw?=
 =?utf-8?B?bWZDUUJET3lmL1hwU1lWK0orNit3dG0wQkdwU2c3N1VmMkFvZFdzUjg0VUJw?=
 =?utf-8?B?RXRqZTBGcy9rVHBKTUJOcnl1RlpURzJWVnhLLyttYURWWHcxVEt2V1o2UFZa?=
 =?utf-8?B?enRPemNrTmhnZVNBQlFTZ0h3SHNWcTFaUjBIRzVXcFVBSWUvOWc5enk1OFFn?=
 =?utf-8?B?eHNFK25oN2FRU3VxdU9zRDAreldQVm1WK3JmMFJYU09OOGErcUNaUW9aeUYy?=
 =?utf-8?B?aWxYdGcwNjJISm5yQ1BaYnpTZWhHZ21LeE4vTC9Hbk5xWUJPdTc2WVBSNGpO?=
 =?utf-8?B?M0dBbUVFYXMwUHZ4TEYwVW9FMnJBei83YTFKSE9PdktGMjQrUFFFUEMrcFJy?=
 =?utf-8?B?b08wb0pkNVVQUFFaSGFxcC9xdDhDelR2VHc1YWRGZlJCSnBNT0sxT0hscUNQ?=
 =?utf-8?B?WnhrSHVFck8yTFpYdjVUQjVEYmVHQzhUUWRYdWhsN3QzWkFVR0YrR0UyUUh2?=
 =?utf-8?B?VFBHRkptS0t6UWlINUxxQW1pUlNKVnNweGh5YXhJK01GZkt3MGV1L3RkNlV0?=
 =?utf-8?B?Z0x0RjR0R2tmWnJvWDQyU0ZZVTI4OFVFN0FTTXhiOUEveFpIU0tnWWh5Rmha?=
 =?utf-8?B?WnF4alEzbVVxNVNPcDB0YUwya1dqK2dxdTJNVXBJWHptbStSZVZwOG9veDhq?=
 =?utf-8?B?Ylc1WnpUS0NIOGhIS1dHdTZnSFRTcTB4ckdONDVkS0tmNTFJTjNuTTJZYzBx?=
 =?utf-8?B?R1RIckFPQjh2MUExWFVKam9YKzExMVlvb3V1bnZJZWVBc0lHNC8zMG85ZTBX?=
 =?utf-8?Q?us7DjOv6shZocaS19fNpT3w=3D?=
Content-Type: multipart/mixed;
	boundary="_002_d3a83162570aaede579ecde64e00350ce1e6b452camelintelcom_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f427e4-c322-4559-4f7e-08dccff490f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 10:54:09.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xuv+r4N8D6QofPD0PiaxDZ0Cnfv2CF8c8teqhRQ/grDNkNQusPuAf5avR7Y2QjXhEIaLzZ6kzwQnqBD3wzPcFVlLvtEFinPwPm5VmB3rrrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com

--_002_d3a83162570aaede579ecde64e00350ce1e6b452camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB05A44A047C041B756E467F4B322FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gU3VuLCAyMDI0LTA5LTA4IGF0IDExOjUzICswMzAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6DQo+IE9uIFNhdCwgMjAyNC0wOS0wNyBhdCAyMjoyMSArMDEwMCwgQ2hyaXMgQmFpbmJyaWRn
ZSB3cm90ZToNCj4gPiBPbiBTYXQsIDcgU2VwdCAyMDI0IGF0IDE5OjM1LCBHcnVtYmFjaCwgRW1t
YW51ZWwNCj4gPiA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRvIGFkZDoNCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3dpcmVsZXNzL3dpcmVsZXNzLmdpdC9jb21t
aXQvP2lkPTA5NDUxM2Y4YTJmYmRkZWU1MWIwNTVkODAzNWY5OTU1NTFmOThmY2UNCj4gPiA+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3dpcmVsZXNzL3dp
cmVsZXNzLmdpdC9jb21taXQvP2lkPWNiMzQ3YmQyOWQwZDEwNjIxM2EwY2Y0Zjg2YjcyZGZmZDA4
ZDM0NTQNCj4gPiA+IA0KPiA+ID4gYW5kIGxldCBtZSBrbm93IGlmIHRoaW5ncyB3b3JrIGFnYWlu
IGZvciB5b3U/DQo+ID4gDQo+ID4gQm90aCBvZiB0aG9zZSBwYXRjaGVzIGFyZSBhbHJlYWR5IGlu
IHY2LjExLXJjNiAod2hpY2ggaGFzIHRoZSBlcnJvcikuDQo+IA0KPiBDYW4geW91IHBsZWFzZSB0
cnkgdG8gYXBwbHkgdGhpczoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL3BjaWUvdHJhbnMuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvcGNpZS90cmFucy5jDQo+IGluZGV4IDE4MjJlMjJiN2MwYS4uNDU0ZWIxMTU1
ODgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3Bj
aWUvdHJhbnMuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3Bj
aWUvdHJhbnMuYw0KPiBAQCAtMTY5Nyw2ICsxNjk3LDggQEAgaW50IGl3bF90cmFuc19wY2llX2Qz
X3Jlc3VtZShzdHJ1Y3QgaXdsX3RyYW5zICp0cmFucywNCj4gwqBvdXQ6DQo+IMKgwqDCoMKgwqDC
oMKgIGlmICgqc3RhdHVzID09IElXTF9EM19TVEFUVVNfQUxJVkUpDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpd2xfcGNpZV9kM19oYW5kc2hha2UodHJhbnMsIGZhbHNl
KTsNCj4gK8KgwqDCoMKgwqDCoCBlbHNlDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRyYW5zLT5zdGF0ZSA9IElXTF9UUkFOU19OT19GVzsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJldDsNCj4gwqB9DQoNClN0cmlrZSB0aGF0Lg0KDQpDYW4geW91IHBsZWFzZSB0YWtl
IHRoZSBwYXRjaCBpbiBhdHRhY2hlZCBpbnN0ZWFkPw0KDQo+IA0KPiBJdCBzaG91bGQgZml4IHRo
ZSBsYXN0IHBhcnQgb2YgdGhlIGVycm9yIHlvdSBwYXN0ZWQ6DQo+IA0KPiBbwqAgMTAzLjUxMjEy
Ml0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IEhhcmR3YXJlIGVycm9yIGRldGVjdGVkLiBSZXN0YXJ0
aW5nLg0KPiBbwqAgMTAzLjUxMjMzMF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFN0YXJ0IElXTCBF
cnJvciBMb2cgRHVtcDoNCj4gW8KgIDEwMy41MTIzMzFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBU
cmFuc3BvcnQgc3RhdHVzOiAweDAwMDAwMDRCDQo+IA0KPiBZb3UnbGwgc3RpbGwgaGF2ZSB0aGUg
Zmlyc3QgcGFydCBidXQgSSBleHBlY3QgV2lGaSB0byB3b3JrLg0KDQpUaGlzIGlzIHN0aWxsIHRy
dWUuIEkgc2ltdWxhdGVkIHlvdXIgZmFpbHVyZSBieSBpbmplY3RpbmcgZmFpbHVyZSBpbiB0aGUg
Y29kZSB0aGF0IGFjY2Vzc2VzIHRoZQ0KZGV2aWNlIGFuZCBzZWUgdGhhdCBXaUZpIGlzIHN0aWxs
IGZ1bmN0aW9uYWwgYWZ0ZXIgcmVzdW1lLg0KDQo+IEknbSBzdGlsbCBjaGVja2luZyBpbnRlcm5h
bGx5IHdoYXQgd2UgbmVlZCB0byBkbyBoZXJlLg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJlcG9y
dCBhbmQgYmlzZWN0aW9uIQ0KPiANCj4gPiANCj4gPiA+IEJUVyAtIEkgYXNzdW1lIHRoYXQgeW91
ciBzeXN0ZW0gaXMgY29uZmlndXJlZCBub3QgdG8gcG93ZXIgdGhlIFdMQU4gZGV2aWNlIGlmIHRo
ZSBwb3dlciBjb3JkDQo+ID4gPiBpcw0KPiA+ID4gbm90DQo+ID4gPiBjb25uZWN0ZWQgYW5kIHRo
ZSBzeXN0ZW0gaXMgc3VzcGVuZGVkPw0KPiA+IA0KPiA+IFRoaXMgaXMgYSBIUCBsYXB0b3Agd2l0
aCBkZWZhdWx0IEJJT1Mgc2V0dGluZ3MuIEl0J3MgcG9zc2libGUgdGhhdCB0aGUNCj4gPiBIUCBC
SU9TIHR1cm5zIG9mZiB0aGUgd2lmaSB3aGVuIHN1c3BlbmRlZCBvbiBiYXR0ZXJ5IHBvd2VyLCBi
dXQgSQ0KPiA+IGhhdmVuJ3QgZXhwbGljaXRseSBjb25maWd1cmVkIGFueXRoaW5nIHJlbGF0ZWQg
dG8gV0xBTiBwb3dlciAoSSBkb24ndA0KPiA+IHNlZSBhbnkgQklPUyBzZXR0aW5ncyBmb3IgdGhh
dCksIGFuZCB0aGUga2VybmVsIGlzIHJ1bm5pbmcgd2l0aA0KPiA+IGRlZmF1bHQgcGFyYW1ldGVy
cy4NCj4gDQo+IEkgc2VlLiBUaGFua3MuDQo+IA0KDQo=

--_002_d3a83162570aaede579ecde64e00350ce1e6b452camelintelcom_
Content-Type: text/x-patch; name="fix.patch"
Content-Description: fix.patch
Content-Disposition: attachment; filename="fix.patch"; size=3063;
	creation-date="Sun, 08 Sep 2024 10:54:08 GMT";
	modification-date="Sun, 08 Sep 2024 10:54:08 GMT"
Content-ID: <73CF03F150CD4C409908C35C26E51616@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5z
LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oCmluZGV4
IDBlZjQ4ZWZmZWVmYi4uMmQ0MWQxMDgxMTJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmgKQEAgLTEwNzYsMTIgKzEwNzYsMTUgQEAgaW50IGl3
bF90cmFuc19yZWFkX2NvbmZpZzMyKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCB1MzIgb2ZzLAog
dm9pZCBpd2xfdHJhbnNfZGVidWdmc19jbGVhbnVwKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zKTsK
ICNlbmRpZgogCi0jZGVmaW5lIGl3bF90cmFuc19yZWFkX21lbV9ieXRlcyh0cmFucywgYWRkciwg
YnVmLCBidWZzaXplKQkJICAgICAgXAotCWRvIHsJCQkJCQkJCSAgICAgIFwKLQkJaWYgKF9fYnVp
bHRpbl9jb25zdGFudF9wKGJ1ZnNpemUpKQkJCSAgICAgIFwKLQkJCUJVSUxEX0JVR19PTigoYnVm
c2l6ZSkgJSBzaXplb2YodTMyKSk7CQkgICAgICBcCi0JCWl3bF90cmFuc19yZWFkX21lbSh0cmFu
cywgYWRkciwgYnVmLCAoYnVmc2l6ZSkgLyBzaXplb2YodTMyKSk7XAotCX0gd2hpbGUgKDApCisj
ZGVmaW5lIGl3bF90cmFuc19yZWFkX21lbV9ieXRlcyh0cmFucywgYWRkciwgYnVmLCBidWZzaXpl
KQkJXAorCSh7CQkJCQkJCQlcCisJCWludCBfX3JldDsJCQkJCQlcCisJCWlmIChfX2J1aWx0aW5f
Y29uc3RhbnRfcChidWZzaXplKSkJCQlcCisJCQlCVUlMRF9CVUdfT04oKGJ1ZnNpemUpICUgc2l6
ZW9mKHUzMikpOwkJXAorCQlfX3JldCA9IGl3bF90cmFuc19yZWFkX21lbSh0cmFucywgYWRkciwg
YnVmLAkJXAorCQkJCQkgICAoYnVmc2l6ZSkgLyBzaXplb2YodTMyKSk7CVwKKwkJX19yZXQ7CQkJ
CQkJCVwKKwl9KQogCiBpbnQgaXdsX3RyYW5zX3dyaXRlX2ltcl9tZW0oc3RydWN0IGl3bF90cmFu
cyAqdHJhbnMsIHUzMiBkc3RfYWRkciwKIAkJCSAgICB1NjQgc3JjX2FkZHIsIHUzMiBieXRlX2Nu
dCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9k
My5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYwppbmRleCA5
OWE1NDFkNDQyYmIuLjhmOWMwNGJlNGQwMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS9kMy5jCkBAIC0zMDMwLDEzICszMDMwLDE4IEBAIHN0YXRpYyBib29sIGl3
bF9tdm1fcnRfc3RhdHVzKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCB1MzIgYmFzZSwgdTMyICpl
cnJfaWQpCiAJCS8qIGNmLiBzdHJ1Y3QgaXdsX2Vycm9yX2V2ZW50X3RhYmxlICovCiAJCXUzMiB2
YWxpZDsKIAkJX19sZTMyIGVycl9pZDsKLQl9IGVycl9pbmZvOworCX0gZXJyX2luZm8gPSB7fTsK
KwlpbnQgcmV0OwogCiAJaWYgKCFiYXNlKQogCQlyZXR1cm4gZmFsc2U7CiAKLQlpd2xfdHJhbnNf
cmVhZF9tZW1fYnl0ZXModHJhbnMsIGJhc2UsCi0JCQkJICZlcnJfaW5mbywgc2l6ZW9mKGVycl9p
bmZvKSk7CisJcmV0ID0gaXdsX3RyYW5zX3JlYWRfbWVtX2J5dGVzKHRyYW5zLCBiYXNlLCAmZXJy
X2luZm8sCisJCQkJICAgICAgIHNpemVvZihlcnJfaW5mbykpOworCisJaWYgKHJldCkKKwkJcmV0
dXJuIHRydWU7CisKIAlpZiAoZXJyX2luZm8udmFsaWQgJiYgZXJyX2lkKQogCQkqZXJyX2lkID0g
bGUzMl90b19jcHUoZXJyX2luZm8uZXJyX2lkKTsKIApAQCAtMzYzMywxMiArMzYzOCwxNyBAQCBp
bnQgaXdsX212bV9mYXN0X3Jlc3VtZShzdHJ1Y3QgaXdsX212bSAqbXZtKQogCWl3bF9md19kYmdf
cmVhZF9kM19kZWJ1Z19kYXRhKCZtdm0tPmZ3cnQpOwogCiAJaWYgKGl3bF9tdm1fY2hlY2tfcnRf
c3RhdHVzKG12bSwgTlVMTCkpIHsKKwkJSVdMX0VSUihtdm0sCisJCQkiaXdsX212bV9jaGVja19y
dF9zdGF0dXMgZmFpbGVkLCBkZXZpY2UgaXMgZ29uZSBkdXJpbmcgc3VzcGVuZFxuIik7CiAJCXNl
dF9iaXQoU1RBVFVTX0ZXX0VSUk9SLCAmbXZtLT50cmFucy0+c3RhdHVzKTsKIAkJaXdsX212bV9k
dW1wX25pY19lcnJvcl9sb2cobXZtKTsKIAkJaXdsX2RiZ190bHZfdGltZV9wb2ludCgmbXZtLT5m
d3J0LAogCQkJCSAgICAgICBJV0xfRldfSU5JX1RJTUVfUE9JTlRfRldfQVNTRVJULCBOVUxMKTsK
IAkJaXdsX2Z3X2RiZ19jb2xsZWN0X2Rlc2MoJm12bS0+ZndydCwgJml3bF9kdW1wX2Rlc2NfYXNz
ZXJ0LAogCQkJCQlmYWxzZSwgMCk7CisJCWNsZWFyX2JpdChJV0xfTVZNX1NUQVRVU19JTl9EMywg
Jm12bS0+c3RhdHVzKTsKKwkJbXZtLT50cmFucy0+c3lzdGVtX3BtX21vZGUgPSBJV0xfUExBVF9Q
TV9NT0RFX0RJU0FCTEVEOworCQltdm0tPnRyYW5zLT5zdGF0ZSA9IElXTF9UUkFOU19OT19GVzsK
IAkJcmV0dXJuIC1FTk9ERVY7CiAJfQogCXJldCA9IGl3bF9tdm1fZDNfbm90aWZfd2FpdChtdm0s
ICZkM19kYXRhKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvcGNpZS90cmFucy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2ll
L3RyYW5zLmMKaW5kZXggNzE5ZGRjNGI3MmM1Li43Mjk4OWE5OWM3NzcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS90cmFucy5jCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS90cmFucy5jCkBAIC0xNjQzLDYgKzE2
NDMsOCBAQCBpbnQgaXdsX3RyYW5zX3BjaWVfZDNfcmVzdW1lKHN0cnVjdCBpd2xfdHJhbnMgKnRy
YW5zLAogb3V0OgogCWlmICgqc3RhdHVzID09IElXTF9EM19TVEFUVVNfQUxJVkUpCiAJCXJldCA9
IGl3bF9wY2llX2QzX2hhbmRzaGFrZSh0cmFucywgZmFsc2UpOworCWVsc2UKKwkJdHJhbnMtPnN0
YXRlID0gSVdMX1RSQU5TX05PX0ZXOwogCiAJcmV0dXJuIHJldDsKIH0K

--_002_d3a83162570aaede579ecde64e00350ce1e6b452camelintelcom_--

