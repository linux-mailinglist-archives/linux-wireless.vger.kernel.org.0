Return-Path: <linux-wireless+bounces-33166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPIBEFMts2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:17:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC9279DDB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45FD9300B19C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AD3B7B78;
	Thu, 12 Mar 2026 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0mBmZ7D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D107336895
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350223; cv=fail; b=CiByJTFor+db5E/SbaBYv8CwjBX5pp3skq1d8UGtoynQYrXA6llQWJiLXWTbuF6bJ9UCLZBSHMgwlhEQ7u5Xfy39pqoVNAM+AWj1LLXj8Bls+XFjn/zv3YqIqA41D6ZpXVaWhF813IULy1ykf3wfLUyHHS08Kn/RLvBuZAorXsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350223; c=relaxed/simple;
	bh=x6v/4jfm77fURYxfhk945SLtzSoDaGmvBIpEWVH80Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ez7k8y3lU1Xxd9Rpisg9ZTk1+YaOid0H6m0ulzYDmW477ooCBO1dP32K5aLc+xnyIbJ8P9Y0Mkl0DjfvpRhQoMQ6GTvi7U63/TSPxY52Ou7OLn2qAzeNdjc96i8jWFq448K2lGkxU9xiSni7IFgHWQo9ehzEiCG30JLuvzd1BEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0mBmZ7D; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773350222; x=1804886222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=x6v/4jfm77fURYxfhk945SLtzSoDaGmvBIpEWVH80Rw=;
  b=A0mBmZ7DYtH9AMHGXITcuGalBuugo5hT9TUdYRHH7LYDCY6ZxShj43MV
   FIaJAG86ybXudYjj162LKz7kjXi29AyfDM7nJQeHBFFnrikMwR2EqSeLu
   /qt0dsAfuBJyDxGo/zQzZp19aPpu3CyXcSIpCaZJzqwi+Tp5/pQYxVjQ4
   Its7NBhKe/Ruib+Wd+vx3W6Z5yWOdo8XiTLhw5+0ADWUd8CgjzaGwoAzr
   60sw8VG9LMojPmq4R+3wSI3nGauQbDLu6342YccmirPNgAeOgKrRZDKfi
   +4L9eUFOs8xk2JL3ra5hJtyqJvN88xvkS8UmoMBH0jjbgOKC4Vp1MzjfX
   w==;
X-CSE-ConnectionGUID: ucB+mReYQSqyTkrxPNuzjw==
X-CSE-MsgGUID: PXU2JUD+SXm+mN3fqL2ekQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="99917580"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="99917580"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:17:01 -0700
X-CSE-ConnectionGUID: qBhuLjqnTkmwSlHWkOoBOw==
X-CSE-MsgGUID: oRtfZqO1SmiPcTUUylEiAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225649995"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:17:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:16:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:16:59 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvJWO0xWf+jraVT5SubosxZZXPWjCZEKc5aV9XdzY3dwPGF198js4/uyIwVfZnN6cX4jqUhg5LJrl3RpjMGrizui41b7SYuuIkLFi6sbSLSuAHJN4aXhzXZky9JvibBbrsm+q+PtnNDt+KlmO4PVnTJqCFgkGln4Sa4zZAv+aMO6r7XHSFhs3q8igTBO12Hi/qw5CKB+fKCE4GcD2ibywyYFbxYnQXL7aWwq/JxLXhDPGLrfhtH8vgXnezWfg36mwRmSHD8WLZytNxbhf2acveIzknCA5Ps8xzU3HO8IiXh+qxFcTAzrIIhcrknDMFinjPRRaU+w5urILIGoPAl9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o05pxWjUfxxOMF3oLa2GwoJoBZOZ9QS9TDuxQrJEpw=;
 b=uuQcEAFXDKBY5xhKNBbI2DDrCJve4/iah5rwkwD+j9O50gf5kjNM4Jwu2vHdHr0CaUJkw0Nw2WlfddIWaYXtOK9zqv4lnJExjau0L0iRlQzERBPQnN+r66ECVFEuEo0XGEj8a/mEFsLsa1Nzi8tFI3UTr/gZujh4K4sR0ch2O+zOcPPYkUu/zH3uef2FQQI/Wp7nmlxzUS8yAho8y5zV73tSH0Tfk5Qq3l2JLgi8122aPLiuDYK+cVWNW1yJ5/N2enNASTuuqs3zNwtk6X128GuKV8Eej+QmUvKxyuqfJSyClGpED1vZDJ/SHA1GhK2WcnzYtQw/wclyCVam6d223w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA3PR11MB9325.namprd11.prod.outlook.com (2603:10b6:208:571::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Thu, 12 Mar
 2026 21:16:54 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:16:54 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 13/15] wifi: cfg80211: add result
 reporting control for PD requests
Thread-Topic: [PATCH wireless-next v3 13/15] wifi: cfg80211: add result
 reporting control for PD requests
Thread-Index: AQHcr8tfr8Z878zLkUaQ7JCtGu9ryLWray/Q
Date: Thu, 12 Mar 2026 21:16:53 +0000
Message-ID: <CH3PR11MB8383F6C4E5840702AF996AB9FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-14-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-14-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA3PR11MB9325:EE_
x-ms-office365-filtering-correlation-id: 5d91ae3e-3cfb-4f9d-174c-08de807caf6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 2tWdK+f7h+w1gVYtCNnBa2i2QF3YAvq+xJZ8RJZ0BPmkWQhRYqAe/My+dwc4IYv5fm8d+oYgPxhE5PfPKjK1SKEOZCtyAYjSTUqf3+SF5qn5mP8r0k6vtbKJpRHSQJjp6MWTRtYaZS3RUlML0WzuTRQKm6AV0NVOsq64FXdhlcbyVUPtOI2o5H9HTOnkgAs7cjzp1fo7OYUs/Bkt/fvOQpQrGq6oHEN3Ph0vcanMz81tqD/sAEejSOV7TKNGilVL8wKmQuK9Zp4UrY7jd0bHF1AAtkr09qmoVqx1NKoDqsAHI3pnRYGLeBENjJ3BD1SpnT77EemF0CX1tfeQuzPpRvPe6stgX8I7qe5i1Sy9l3ROQwT2I8dXcUZ/ixOzGhuxBiatRP6bqym6Ng07dMq+cMy7rtRTP6oNVcl3B6EHHowkmHVK+O13ThQNcUsDgMZzDgOHC2r3Wp6uBUdFji0FDOCq3ZFwfVpvA5dajDsuCluZtaB7w2iGUTXHArNVbhiFryxE4YfJ8tAHcIvFsJS/9ES8SXpg2UI+3fThXGAtx/hxoa+q9qlMLnKtitTFl3xGG8OiQ1JVRfOGM6ioj08xj2jNzefWk3CC7PEDqOjQd8qcnPR8GAaluyG2vueleHby6hUZLNpXMPzZgF3ppniIuLtouPIOcqgx1IYjNtKgNY6dIIYie5FgmRGUIXmima46rEcInhKidHYzNvEbP+VBvFnj3KL70CDfqr4ZF/xJHQM+Uup/m1UAOwj1Lhqo+1/xp0d4k8YflOG1dPsZUx8MwPK49XrKj8BFIApCVl0LzgY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4YrPgsR2ZPYs19dBMsfZLtnEvN4K1kl5pFJxUcDKl0DFTKOX2xEkuHMJhIfz?=
 =?us-ascii?Q?3HBTPnLmmHWk4/3N8y+1Wxe1lYWkm0h3a+qqbn4UuFZIPiPksSSCvIMPzOCA?=
 =?us-ascii?Q?+lQFpc75HbGhjqPnDQkNDzFNBWz8TRLqpP94APnj0FHLFoU+DGKDq9ZzhGlW?=
 =?us-ascii?Q?eqjsH0NdVlZboQFDa319ptw5QCY4BJj9HaIy7OrkjzZYShcJm52VE+6Sij1d?=
 =?us-ascii?Q?gRyLCJIvXR8DrHvM/4eg3hDWTPg4p4N3r5fj+VZbrClMaMm5pLVt5zjBl2Vq?=
 =?us-ascii?Q?ianxXAbMMAsxXa/UZcPKlmpnmoRszmIpsOtaVx3aI3kNX1GzAHIfQmpXJ+Ng?=
 =?us-ascii?Q?E+34sMWUsH5S/oYQNXksrTCuyWjseShds/3Vtw+6oViXTfkogeah/0zxRUKR?=
 =?us-ascii?Q?FVdjzlJHgV9Ef/DQ/v1QqwaOfP10SzYSjdP+gzrZzwDiWmhlQ4Wryl64ZMhG?=
 =?us-ascii?Q?jHZOHNPPjaCMhzqdalPL8KQa2BQTAmQYwJLV8XfTe1FnpnI6r5r2jQaDZ0kR?=
 =?us-ascii?Q?SFvbgMy7S9wjdSDhRgpx8ImiBrdKzHmYIQ3YP+ZPPrVBkp5rOCJ2SfKWBZtK?=
 =?us-ascii?Q?JF47dWOPOaf7eNBZ0P+rbmWMoY0+anxcBpAfGkZRhfdykvaGRiepoU4sWKmY?=
 =?us-ascii?Q?jHRH3MRudnsB6VsS98alSztY0ZlC2VCMTaIsfYx2M0e9LKcY1zNhaRbLCTN7?=
 =?us-ascii?Q?XwPn1qcBKl4xFc4+XWmJtDGNNegOTvr7agrM/UyGkaGflfzOBnAobIdxKJ7n?=
 =?us-ascii?Q?Wgj2uHPRn3vEAiaOVmqiTEolDJI7QASdqIbMhRZtLDumOmcjmFgjvaVYYENt?=
 =?us-ascii?Q?ECSY77HCiQR41WdZ9mksS6WaGT48Pp7sg4cJ7dMxcqAebZP08wXD52BijOGf?=
 =?us-ascii?Q?4pF7VgWB4wZqS5y/TioXdBHJ51aEYV/P5Dew1FCx229gWZqu+Z0RiXjcMfBK?=
 =?us-ascii?Q?P9F9CZLpLT3/Rzvvd3wHBW1jQv3OaCvaNOsmBp8v5T16+3KERTB4NNzaEqD1?=
 =?us-ascii?Q?4MW/Tm4skM3PZObJILfBWkZ8afJOk3DcZTAXkjOCLDEVUlmHX+LtqPUc339p?=
 =?us-ascii?Q?7eJo62cOo3WMENxvc3jmQQ18UG/+D4fbEALiIh5cEGSlrdluk/2e5/0KmDgk?=
 =?us-ascii?Q?iQNamGZS9z8/9Q5DhhIYAcSrQhaj4IwPtw2nPghKfg3sBmcFcRmuMFV71F6N?=
 =?us-ascii?Q?RwQChrnUG/EtQygXnOHffIoIyydWiypiyuYeAzc8V12uLRC2GKp/WmpAUDm1?=
 =?us-ascii?Q?La0XWFzhbGb6hss/iD8bun+MjYwS7WN5IR42ZSR6M8Mfzvkiul6+i5CjUV8W?=
 =?us-ascii?Q?cLXQubcO9buLcGVw6LmfCfqURgNH884CdB72elgQBH9w/ZxarNuNKxMedLw/?=
 =?us-ascii?Q?3XDoBwgdp+tWkLsAsA7VHZ2jdmNav8YGvOCpNKtfHYRq+PhkidNbdEmw6ECz?=
 =?us-ascii?Q?gtG82lCQOry9GOExcDnSP7OWJTWZlAcmHXHEdJL5VESVESOipTvoNakpErxX?=
 =?us-ascii?Q?1jtY/Scg1ScLJxXqKhalzgPKDIZrej48lkrL15x4eHFJ6fHtXK+zpeGxGP0W?=
 =?us-ascii?Q?CnCDvhy35l+J3FtAc2VP7P5ysJek5sZzdihjkMFsirDOmjE5yvFhib8lHqqV?=
 =?us-ascii?Q?gQgAxplJQcO4jV2tPshpTL52Nlb/55lt0b1PZk5GFRqhATuSfC6KbmSGi2+w?=
 =?us-ascii?Q?FaWpWgmCziRWBxIUf4ttGSoOrPo9ZUYK3LlCwkb4BJWiAhmkF5vkXMjlutps?=
 =?us-ascii?Q?ojoibS1QK720Wf/4q83LTpnL+A1ke+icGni3tHcQJf+FGLjz1QcX2OTaXo2J?=
x-ms-exchange-antispam-messagedata-1: TlHkvB1DtqQ9tw==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FIcc/DsP3+R2qOkJL6coUFzRmnb+Z8yiDHUtPy6PHi1Kf4joo19Sr9CEq833zum6zKSQ7CbYYfOYs6cXdXVtMwRhPItCYCDhPfkxm1IvE9fRzqRuLfW2uNbYPFy18O/9MeHAO1J4KO4oukvTxOc0v7F259msSAw3inT124tpR9oE/yvHlVBV4yl/8hnw9SmdlZMY1vrvBb66IXmAyVC4eWlZaOUJ3gR+rFFDsErWd89BCnDELE1J3FdlRjFyarLXmD+YWKGnR5vckidNJxnwMFX6xxVTPCn7XInyg6Qd29f11Jh5s1BlzaMLnyx508zmkeKU5UZhcW0VoYoIE68zhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d91ae3e-3cfb-4f9d-174c-08de807caf6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:16:54.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXwLYsWtgc4sy5AcTR9uPuu1ivoe5MqGgBl3Va+39B80SOxCDEL8pKePwO7smkufTKcNlPTyBNz4ulAR26fVZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9325
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33166-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DCBC9279DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> =

> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 13/15] wifi: cfg80211: add result report=
ing control for PD requests

> Proximity detection applications may not need detailed ranging measuremen=
ts for every request, yet currently receive all results causing unnecessary=
 data transfer, host wakeups, and processing overhead. Currently, there is =
no mechanism for applications to suppress result reporting when only proxim=
ity detection is needed.

> Introduce optional result suppression control that drivers can use to imp=
lement selective result reporting. Add a flag allowing applications to disa=
ble ranging reports when only proximity detection is needed, enabling drive=
rs to reduce unnecessary data transfer and host wakeups. This flag cannot b=
e combined > with range report or LMR feedback requests in RSTA mode as the=
se require result reporting.

As commented on previous patch, LMR feedback and range report are mandatory=
 for PD ranging. Results can be not reported regardless.

> + * @pd_suppress_range_results: flag to suppress ranging results for PD
> + *	requests. When set, ranging measurements are performed but results
> + *	are not reported to userspace, regardless of ranging role or type.
> + *	Only valid when @pd_request is set. Cannot be used with @range_report

The title said "applications may not need detailed ranging measurements for=
 every request", but here it says no results at all...
So this is intended for providing ranging services to another peer?


---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


