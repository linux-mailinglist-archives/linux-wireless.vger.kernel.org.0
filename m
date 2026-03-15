Return-Path: <linux-wireless+bounces-33235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHP1ND5stmnsBQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 09:22:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064652903B6
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 09:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438EE3023346
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF10288AD;
	Sun, 15 Mar 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFp4AU3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B36EEB3
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562939; cv=fail; b=Tmz07vwNDQMkWfJz6yegFRov8EoC/HuVlsE7Uo/xNxY/l73zegLz0kngQsNoAjm4F0AFpu1i0VK9ywIeKY+WSvp3EG8+MP0EUQhgo93/7BYqu/31luAUQ+IQnhOh2BeG/LzMugDCojTRXzKvlQju61S7l1cMzVgFGXwBPRjzNmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562939; c=relaxed/simple;
	bh=gKYuOybcJowbEidRA4tAKMh3Pm8bpbvxtdKVte/yH54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Be94soMeko4dldMBdzPQHj5dwYWUQdJKxsvY6JKUhCp8jDWfW5jEam7iguFs+TVd6kDuBNt6qQsqh9fra3p5+b+tmWFjYwVicpC89CP3PIKXpuAI+ko/aFOOKiUsujTUYZ78N6oo1CJVFDXSEsyIGV5YkDqK11XHHkdxvyASnws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFp4AU3K; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773562937; x=1805098937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=gKYuOybcJowbEidRA4tAKMh3Pm8bpbvxtdKVte/yH54=;
  b=QFp4AU3KBnbFNVVjhLIAQmp5pEFHrhjBKFAStZhQKe8SNf72ZZBqtdsG
   h89kLAz2TO8ZbM8pXzbWeUpcgssTNfsAxq+mTWSiHK9J9MoczaRAsV5i0
   AufdiZMtu6/Xrl8WivKlJNiK0WjjiyRGVaQyc+DNMwn72A56pK3GKzRy9
   t5k3XBpR9o/OS26+Th8ss92MlCaJkYIiQDNjygHg7/KbzC5mRSlrwglGS
   XR8DSTfaXF6T5qvGJmT+pOSo8I56zoeRUH0Z3uYfhMkSJ8PaZYssExzRR
   Rh8bVOZME1CEjm2F74HFlqMqlndhs04mYp7HN3FrUzy4/DlZsDQXqQRGF
   w==;
X-CSE-ConnectionGUID: 7tg8sDUrT1uKZpyThaYrfg==
X-CSE-MsgGUID: LiJsXWdpRF6QF31krLvTOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="77216172"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="77216172"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 01:22:16 -0700
X-CSE-ConnectionGUID: t90lJPq8R+WFYosexsU5JA==
X-CSE-MsgGUID: v66jXYMiS8GB2Gg2Li2EGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="221808475"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 01:22:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 01:22:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 01:22:15 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 01:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9hwQdDORA4TdzobhGEnlhvrIGnogYFEWe9WqV12iUDn5dCtlmbxJhNahSkBMHZPMncL8IYwUusY4Kw3OgpkVk1yZsuc0aGY4ZY+tSswPQ4ZTbkKPxN3cxi8dhlU4A1WCk7J/bsv/suC7n5QBIgDoHmOonbDHI20TeHb/0AcCgMQqWU2pq8dCapQkgFhI6hpI3Mf1RCMtVIBbhXULy7ErX1XuvptPgTE8a37sWv6GFKh/zmtWSI/WsJEGKEi0483l3yxPMp3yckjfBeuvTmpz1GXwYHcOuClQPuOdWkAQC5UuG3+u2nL4nIFHKwejF5BJ55hKoitag/WKoVtG9euDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYd3pdWytRsh2qdaj634DZoZ2InwSa5jvdmUSlfdOBI=;
 b=g5TPzot2/Oo2TXVFgsPzncod8Q9oz7W1xYdbXlZhTSNcGKeUrq5ZHPV45hCb4dip4IaKbHlBV9PZL8JNFwDhG7KaIIXfB3ExgZwiqKBrs3mD901pWdx820orLRek0IgIQA7JigdbWtL6prjXkkn6EfrY8WWiJigoqEhJIYcLCmwWzrD3ZQ/8mTL5RmKE6pqUYA2NcggOUQn5GgoTawoY40fqAdyB6utaZohh0K2UhFZx9jLoIkw6bggwznablRrgB4J8hgFlnCeoZNzUZFvgWQkgWcO4N5pw3VX4QUubHrIsoWxt7TDn39ztwi7KHiVnJeRB1/vB5zSLQoWt85BUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Sun, 15 Mar
 2026 08:22:13 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9723.004; Sun, 15 Mar 2026
 08:22:12 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 14/15] wifi: cfg80211: add LTF keyseed
 support for secure ranging
Thread-Topic: [PATCH wireless-next v3 14/15] wifi: cfg80211: add LTF keyseed
 support for secure ranging
Thread-Index: AQHcr8tf+wuUF43rmECIm42lJIH5abWvSdfQ
Date: Sun, 15 Mar 2026 08:22:12 +0000
Message-ID: <CH3PR11MB8383484D69A62802D1CC6898FF43A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-15-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-15-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA3PR11MB7611:EE_
x-ms-office365-filtering-correlation-id: d818daf3-8b3a-4e89-67c0-08de826bf5af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: SZ1EChC946jVPKVnH5tIn7XT2vi40v9lCqI0Xz5qI7ufBTk3O05NDv4VKq31oOTibL5W0uh2T/8gBdxm/m82YOy4VDXHM3du5Y96fJ0E38TjksGkDqdJAeU2i1bNoSTSTlLK6H+UC6zaZMGEx2/meSYR8SGhyAfs+F/86B92QNIohrF5CMcUFIr3S5IE8rhwWA1b3cObOmDwfZTo/iQjiFM/WDT2W4lyN3cd93D7WKpi45wd0quLM5WS/pJmd6Vbe0chr/v9Cq83yVHmb4lwNPMmfiJ6MnIFIvUiQlB/E9W/8vEa3flOj+4Sh468JSG/lu/NKPYMOFli08xQgOyHoi+FEcLkQ/LPnl0/jH9ZZBTLCwJDy2B+tEi+4yrUgH7Y7Rk+PX2e4kOtryU+xBO7K+SG43WLrzPUSgZ9Fg3g2J+lHmW9wkE0Pg932Oj0IUIdQCdbBF+9eu3FwslrqTbeTSz009Zci/jt+q74dWUOVIeUmY4ojhVhdVIqSH+DiH0NP96HdXNidYssBIRtwc8VxplGIdKpXoQBS0lCCGWGzh4Ku2wpBQbqk+A1XrOhe1XWfLFVol1L67QmwINPUJCboXJAaJt0kXDjMvI/MM1DBzcsruAIx7EeFKYY8zGn7bedg6G2x2HdI0P5RM5/7hGj0IBUp0fC/6YH1aj13zDU47e3Y5UB1wUQEsWyEpzDrhxNmLXgOP/r8fgpPib5Dstfz/Nnb8pBPwtggALy/Bsrog9EpK69U/K3uYuAguqkw5coELEpOgZ5exDL6cvW95Fn9dkTjuzujgGzaFGbafKIvQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e7j9SXxdiAoR3p4NClkbv+Hj/pmYdbW5JUa7Tbpol6z8rYKolwg8HKXdtAUf?=
 =?us-ascii?Q?HGW622EIDlXlPdoiFGuL9mYsXmhH0Z5TJRU+vBgAg6N8SA8Vczz6QpYGd8ek?=
 =?us-ascii?Q?83+9TLCtZP/Rj7Geyimmg/O3JF6baV7gMB87bxve7a6k4WQLh2WTJK9+LUGZ?=
 =?us-ascii?Q?ODQb9yV3Uh71fHEE9HBfk8mRFSQj08u1jLy3LHQnqrO2z2sV2nZtggm0ggWs?=
 =?us-ascii?Q?V+P68hD2q9r9HxppQcAGvOTxpWAQ65VgVrTZpFJTpAoGdS4X47oKZrhxx0Qx?=
 =?us-ascii?Q?iibL3qun6S9FPPPo9Y+Q49qFSiXK3TDY8P314b/ya1/fL5mMT5pSKIykdu5w?=
 =?us-ascii?Q?I+K8cSFMRpOsPZ2xz0NVB7bli7JTBEOPjEBeOpn9Za67jsO0vSJt8hDO64ql?=
 =?us-ascii?Q?2hLqYLa/svrYL44TEFZ1XDAZaBoQW5F9F29PxZVGiXiUIPE15aAQFBmxM6Rf?=
 =?us-ascii?Q?hNdt0OI0+7Z4R98bv1br19VsRVPL6g35u9yTpQdtTcI0WkPM+SL0uvxQbVZE?=
 =?us-ascii?Q?+Y1SZEQGCgJm+tOReq5/rBwrUoDLleWhYVovibgp6mNbcTlvYe2mvUUa13YA?=
 =?us-ascii?Q?ZMPzKefp1z/WPbTCll8O863t4WP2y/RpR/2a0jgvKqb1Ko8xGMOgYwsZOWJ/?=
 =?us-ascii?Q?eu0T/IOOZtyy5SE3BcKIQe0IDokn0KqWIMfeAuAAZ7oShksyMoNruca1hSg0?=
 =?us-ascii?Q?2gH1epWn1tt6ksmHyTTeg7NhjWbsDpSwWeTtBHdB+irXCzc+c+LRmEELlWwV?=
 =?us-ascii?Q?u/aR4pytUSkLhnE8KBRZzELOje1cQiX1J4VM5Idq+yyZnDo5V/S0EiS7kD7u?=
 =?us-ascii?Q?RIwkHo4MQpjbYGV5zHguvrZ9y4c816tBsT/dW1mCKFHauhSsoCsYtwYpWGWg?=
 =?us-ascii?Q?v39O77BdYpIKuzvSw6czEh5PGF7SWHM2qbd0y0MiHfkik+DJmIT3cqvM87lF?=
 =?us-ascii?Q?IDFHTo3orsiS9nTBuJIH02nGG1can4/KTea3GlRrEuv3hZDBiVcXa5cmv9Ok?=
 =?us-ascii?Q?pADOCfbdDTHsDY7PGVboDd6k8j5S6swabZdxQW8SuD/kW8badox/XLynht80?=
 =?us-ascii?Q?Z3X8TlgijINBY7UP8cpBphUxXiJwCiv7x9rOTBRP/405Qcn8gH6Y0HeC/frF?=
 =?us-ascii?Q?H2sPzXPWAmOJQkcpbo3X+ktOSoJcX7UCB/rQE4cz+hrxqPGwj2t///xAT3rf?=
 =?us-ascii?Q?R8l83ydshw8enE0xsibHV1S/QOFK06OzaFZX6P91xjCAUXFKE7OvB0+UTc3u?=
 =?us-ascii?Q?rqzaf+QpCWy3/wxauRWHkChdQOumV7TzT5bYtGBGVB8uVftKMgxlta5ac+mu?=
 =?us-ascii?Q?FofzHQ647+Xm8zsvy29Yd4COAueEsHFqoyOyKOxuiScPslM3KT3/oq2tzsWR?=
 =?us-ascii?Q?B2kggh+Uo6f/imL+z1dGhB/oJ3yQGf/ZBtvsVxxaGZAGgKhyh0+5oo/WZN+x?=
 =?us-ascii?Q?zac4Jc+IT/BQPy/yn9e91WrsbIxSAyNuvuEyLome7/LY1k9RbSO/ssq+2D1Z?=
 =?us-ascii?Q?w0kurf8yF0MrIdx1nVtcBkFpPOWTmTIrB1Lapk1mEasTmkxTvBDA5thZqyIi?=
 =?us-ascii?Q?LcFNBlBc9vZ+7Z3INDkAT+KovZN6WHvNACDd4E3LStvT8G7r/TGf6oWpP1OR?=
 =?us-ascii?Q?bxFtQ0q7jBfZMYkkFQa9tVn1f9ONQjFUQG9AEHM5Lllf8Kz3TljINB4YSJ05?=
 =?us-ascii?Q?Yw7z714T6b8dOgVzSrB+zFkNY3JL/NjNmrGxONk3cq5yGmNinDmKXkpQEHkm?=
 =?us-ascii?Q?cWi08HT0JT6ddU4x8dvTO/mZmn/eiq0WzGWcgteYadHcCgoRnN7W7Gc3FLBw?=
x-ms-exchange-antispam-messagedata-1: Z0e1vEdU1H+AMA==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ty1UT/YHBPdXtaNbDu3wRcQrBVAKWFJCun74rwQ7NRb0L6DUs0q7d1zcGNMBDiFxXhN9SwLVGmIPVCP3oHs3m3fWt5IpmtZL5MCt/7csU4zab2JxQnziPOuNqLBKWhOB1bAZbpfEcwwQxV9vZp3DCx/oEAfLLyGbwE1tHmYGOiejkn9XETV5B/WIJFYPi7pVBzpBLgoLoIY95gL8rO8YBigSnllQ9U2QNivVQisCt7gZsOy8vpGPypJ+KWrTNa4WeQ7jbrt5UiAzKJnZPZJ4c+3mW6qNQ7WjluJ5HVyzoDLZITsKsgK9KqUrjwTs/zZwznliMZFdAb9gbUAeY0sF8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d818daf3-8b3a-4e89-67c0-08de826bf5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2026 08:22:12.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vg3JITgxKj9HPNQZP3/sKNSNcjd7fbh4F8pbdtle28zywY72WZQWmAxPttzcxmpWlvJX2tst24isxyeii97w3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33235-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,sipsolutions.net:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 064652903B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 14/15] wifi: cfg80211: add LTF keyseed s=
upport for secure ranging

> Currently there is no way to install an LTF key seed that can be used in =
non-trigger-based (NTB) and trigger-based (TB) FTM ranging to protect NDP f=
rames. Without this, drivers cannot enable PHY-layer security for peer meas=
urement sessions, leaving ranging measurements vulnerable to eavesdropping =
and manipulation.

Installing keys when there is no station (PASN keys) is something new (not =
supported by mac80211, is it?). so currently even installing the TK from PA=
SN is not clearly defined?

  =

>  struct key_params {
>  	const u8 *key;
> @@ -839,6 +841,8 @@ struct key_params {
>  	u16 vlan_id;
>  	u32 cipher;
>  	enum nl80211_key_mode mode;
> +	const u8 *ltf_keyseed;
> +	size_t ltf_keyseed_len;
 =

Since the mode is NL80211_KEY_LTF_SEED, can use key and key_len, like any o=
ther key.
On the other hand, LTF key seed is not really a key... maybe add the KDK (f=
rom which the LTF key seed is derived) instead?
 =

> + * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
> + *	secure LTF keys used in case of peer measurement request with FTM
> + *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
> + *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds will
> + *	help enable PHY security in peer measurement session. The correspondi=
ng
> + *	keys need to be configured beforehand to ensure peer measurement
> + *	session is secure. Only valid if %NL80211_EXT_FEATURE_SET_KEY_LTF_SEED

"the corresponding keys" - refers to the TK?
"beforehand" - before installing the LTF key seed or before the measurement?
This is not clear. =



---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


