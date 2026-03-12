Return-Path: <linux-wireless+bounces-33161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNhQMnIrs2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:09:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C919279C9B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C73033015B66
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD243B19C2;
	Thu, 12 Mar 2026 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9gGJHJL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D153B19D3
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349742; cv=fail; b=o+Vl9dJ1/SxZTU12tcIB30RM1XfKlSc1efrRPo6K2fFaYfF3OrkyZzwXsAr0jqmLlp4yKupEp8iI16XH9JwdDqB4YQGj9WBjYdHjVyN8SyHurCUNGG5hvgF5BC6+VCEI4awsW5oJd46m5klq8b1wVVeK3gkrOA2hmVhDpQBY+3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349742; c=relaxed/simple;
	bh=E+puOvW5z0vPWvbQy6YoXrutby10nTkoUEtcea7sdrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U8tAcLrsQs+hprdSW/K0mA8R8qHtF+1Dtez7zFxxAafxHomF3wD7yG12M3YEMPSaZeS9UcNt9NZcfTozgqx07mbDZcqfqLoIM+rQUg3XuGdj1Je3fuMuNrc0otiCyWn09crP17LYPrMeiIg4wnCe5mTf93g4OrAnzXqpPgJwaE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9gGJHJL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349739; x=1804885739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=E+puOvW5z0vPWvbQy6YoXrutby10nTkoUEtcea7sdrY=;
  b=E9gGJHJLZxCDfGZqdGbk2NmmPdnevJmX/WEOcTXFwcA0hI2kzK1Kx3pw
   TsAWBL1sfURwm7LBbngP27L7Kq4G4bnw4Vlek+cFFD2gS8BQ5rcaznXMZ
   qnW1waLaqwQC7DW8Pdnl64UsCIkMUD3JlMm3JnfvMPg9MWF+RZ3QbTplx
   5GBhTVzo1JzXoiEvW2jUV069iUpzPqdUTikCMLOgt2KXufA1jbuFGt4GT
   NP9ShqqPg4IDoLOQADF7EB2FBRIQY6X8DBk2dds7Yyc93j56ERSeCK0D6
   GRxFRhDBN1sGhjp9WHfa8IAb1ZXlETFjPlZrcOURvERqQOZb2/EHISVfg
   g==;
X-CSE-ConnectionGUID: AiqP++6tTxqXTS/RSXzonQ==
X-CSE-MsgGUID: Ux6yN+q+R8ukXHk6nblFxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78060740"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78060740"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:08:58 -0700
X-CSE-ConnectionGUID: Dm7E9oRGSsiSir1d+jbhqw==
X-CSE-MsgGUID: c3WyM/2PQH+WWFMr7Lwe+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="243991021"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:08:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:08:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:08:57 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIVuddEq6xxNB7BhRr7l8aOE5jz1gPZ6LcH9Vz0ZhKkmjpQQckcik6SjonT2AhkKxyxcfzfAvv33rXWdiH/uZCrZbGfkY1ORcBoiZIzLjg70q+fn9pCdhJElF1lel0QrJMqBRgVw8FIGJTFm4mu3bc1vdtdYqKB5CwrE1XKEKpKfNSi+qjtA6uAbeUaLd72c+jKUSHrWe5ZLv4xcPyMw/kdgAWWrYx1YQhKs/SAvXacH8X7fEtU9Bb8dAfI5KGnjyQgmPS3FtdqVtLQCMwuFDDAzTN/LyaNS+5RyeVuUavyYMWKuqlVfHmjMo2k/ETFZOgqHpJu5AjuWYggMIQLrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN8Q9LqoVUDme+s7wqAIUEzmBp4zsM9xEXr9GwwOmPI=;
 b=PNvxguUxjpZXhJPwU8W24hknhRgp2WoSSfShbkGgC+nkzNsMICyK0w8Rez3x0oHqi2hvcJmMkQ61P/eHiVoMB66nk5XGiQ6RqmBlVKVStgvigE3dowen8tEh0FdxYoYpg0UqL2FGrgEA1pJ7q7zq1J0deQEz9eEYpsE0meEjfNJ4vujMKBEEGoQVS1oD1GlC3Hq8VDOMTfKXI2s8ZMuqTc5L9EuIRZmil479mAOcRpi9O1qDjNWSA2CnUsO+khaPiYKy1ZF/c12w38Qh2Qllqpt55mat2OXeX8OSIG+UoQcp1yY5w128I72nI7pyvuBVHtiOEJvZVlqKBegosEnv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:08:54 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:08:52 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 06/15] wifi: cfg80211: add proximity
 detection capabilities to PMSR
Thread-Topic: [PATCH wireless-next v3 06/15] wifi: cfg80211: add proximity
 detection capabilities to PMSR
Thread-Index: AQHcr8tfs07oN86fQE6a4C7XVqTA7bWraSRg
Date: Thu, 12 Mar 2026 21:08:52 +0000
Message-ID: <CH3PR11MB8383D7E5CA78D822A9FD8A1EFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-7-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-7-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM4PR11MB6239:EE_
x-ms-office365-filtering-correlation-id: 36506261-e3df-42a5-6018-08de807b9071
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ZzD4jVFgATfKUpeEhR6U3UyS1MFw2fctPjYCMVtnaxLVMN9pVva5jmx3RCnitm4gO1RM7K5VvcuwJJMR0Vs/WUT8A24Kgkrf9DiH0lPTSWBJgC9ZzSGfWb8KF3/MGf1Jn41NKtMRiSTOPSryUXAU1zpff0TP7P1+DkRwVBj6eOATo/gnD9v9OkF6hrJsOlRpRcs8FgUPkRP6cU/y/2a663E58B+oTFOWA3MlgK0RJIgXGEpdOgLn88mD9KZ4l++zTfbP+diDBlhopCU42b0T/MBXjdUG0/Y5lR7CGmXIstmbpIqVEiyTbagyCzLqrCuC/6Vh50Nminzt5r2k+vbLTAL3dtjrKbyIcKM3ajrAtOHUjHO05BdzixNOnGdyJImqFbSdKb+OFMdDIEdwaggMvveDhOJofr8l+yIoVYBWvnq2JhznUHnOLaVthkP+H9YD3kiY08pODx5PQjCTblk69NXQdSnt0MNAZjA4Jkt70YvZFM/qN9DhDlX2pwL/AtKa8aM7FS9DohzhZL/yzQeLZ1BK9avXGLXegR9F/O/sG+8uKeqIN9hQQYAMsedPD57Lrk543hQJdCYN0fzfbq1aDwBbyjX9hEX8ot6ZZdlT+uzHzTT9u7bMjVg+AmFSWC02eCIstXkthP4jjjZUuhfg1zHmlbgSJb+YFYfqZr3um53mZ18AAru6WwiI2W5OlbCS9bfwnWte1FRpujFqNrLaBRF9eOnTTh8aFEeEdRazVuBPAzhVtC62Fo/1+OwJvwgMIc9JMWraMWSoeQkMrEJIKaZNn6dgQgjdtUqSO6SY03A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S8tHEtEfcVIgxOfDvBhT1ncXdVLgMrCrXIXyRDczUTN1bMLg8lrlyWuWsHao?=
 =?us-ascii?Q?zCsgPf8eOLirjkWy5Rd3/KlwdX1vZFrHb0MTLzMXamuSRn51lAjjG4geL/Pm?=
 =?us-ascii?Q?Qr06Uf30HT75lLamzecNyuMuWlcZ8XcvDUIFlgNw4e7BvBytWDhJaWf8cMkh?=
 =?us-ascii?Q?inMaWQpgV4qGvpg7MSrXO57MPXRvz3JFK8Bd0oTEPx7yCFfInKRBaotB5QX5?=
 =?us-ascii?Q?FJlIyfaou77zkvAlmPX4BFXZYLMUKQ3svmz+plsLbbcLcnNbT5laXCsPOAuJ?=
 =?us-ascii?Q?nh2E5c5q5PFsQLDvMuU1zaZoO+8rutJvSS79HhtKzB2cCroZTkPh24CCFRvK?=
 =?us-ascii?Q?k7uIOppGGI0oJ1hNbYnj0crIZEzKI68y0B5i1bPR9axZoMXMLqA6Or6IRn8Z?=
 =?us-ascii?Q?LAk6qfLbgJdV96ek4UietpM93UChYchYIdRI1pDwsgkCjkBHGdf8XSIkouYN?=
 =?us-ascii?Q?uT559Ldoi92POPZBtFfZ32w0m8Pg8DcUveDlR3jP3eaCBlBbU1h8DFnVbOQ5?=
 =?us-ascii?Q?nB2lWkCgAglOrxKhlxbCDEquJQJf9U937C3JdrI9btdoq/rkx8X1R5K/F/o5?=
 =?us-ascii?Q?qQljjNmQAxeQPw6C1B124XbasnfVhXl+1gUcHpUziWwCz82+sFBIGJ0rviek?=
 =?us-ascii?Q?tpSlXmYTCz9yBjNK+BVm5k2RbEGK0GGYTeEgW6Cr4Sh7g2/BE1gy09NiYhZk?=
 =?us-ascii?Q?H4E73QyLdZrJn4SJEbOQc/XrmcjF9W6ItjvQonsaugg33EXsNNjwkanOz1hm?=
 =?us-ascii?Q?hUjUEacPmLRsYq0k7sPQLo07LK98zzTvY+2eufbh0tkRW+2YNgfMWa5or8Os?=
 =?us-ascii?Q?GMsUGyyeCskfsKiWpy9AYF8TCGiacRcWoOht0GQUulU9NjqZ2wz3laCVFUsl?=
 =?us-ascii?Q?2h5uToMSFHXM1oar+F85bGV1ihqiywbLwxOP4mOR4DoBAc7TBSxLblYQGcYm?=
 =?us-ascii?Q?VilCb3wV2EbZAbbfo9i+BeX8Z1Z76DL+91/NkI5Gx8m5MMjLO7EJhlIBM+16?=
 =?us-ascii?Q?kvZDAT1Fff9gvjKVufm9GzYm1ENctk+xCjx+zA+TwJ3Ht5hnqNFvvyTqfQNu?=
 =?us-ascii?Q?eufygfWj5nyT7oRhefTh7JNOF79TB/F+6Jore7XoCIbY81uDbQOwRHdsq373?=
 =?us-ascii?Q?BcTJEG+RV7jSzdzKWlxYjmNDmPPpO5QvZDq+Evc5Cg6P+8rpFE+jL/qM+ZLE?=
 =?us-ascii?Q?0x2/Yz835zDV7WL19pgptmJ3dFgw8p7PJwGYlDK44OMfqHkz02WYT45io50c?=
 =?us-ascii?Q?+Oc3U08csVIwwObFvwlHMoVcpf7sA3LxLPFCnPhKLidQkL6BjA+qNYXHdkX+?=
 =?us-ascii?Q?wTx/cqIurU0iwizz+SXZlXX1ibEY/bTmFnnMJBWoU7ceuzr4X4MwVRV2oYLM?=
 =?us-ascii?Q?LuQ2ol0c4siunTKpSmDGbBspWUREGr5HDoBcn/LkXNClfZmrituWgZUgfVdn?=
 =?us-ascii?Q?AlS5sPZyWQ4eXTBzzxu1NFYJR2lWNiOd2sVBG2/DGw/QzozNmk87bxDX6pVh?=
 =?us-ascii?Q?WcgskzxI5pqqyQ8GnGTpcSYh0za+k5pEXxUM7XDhdBgSFgPKBpCADcK5mH4r?=
 =?us-ascii?Q?Tyro98P2llU4ecUQ3ZmG+yzohZIFEY2oBh0Xm6lB+4Auw8lTdYlNCKCK1Cfv?=
 =?us-ascii?Q?D70CVxD6UUMwzuXpLQknhpddqi7LvPsyk90k7zi/HlT+bJa7OzcKQG/R2rUD?=
 =?us-ascii?Q?ea+wfctJ3Y7HQ3EdnG0rcM5EPUSlyF10awc51NwrIF0ECXJ4WTf8E1MgCmAX?=
 =?us-ascii?Q?Vd7cCPQMeq0KfdtEbOG/j90oeUtQaiBkb+nJJY8VFZn/QamnVB5+JOrriuPg?=
x-ms-exchange-antispam-messagedata-1: 7MxBUbmiBXedxA==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jiiCCQtvPbQKiNP/KHdnKAFBNh1Vh0ArXNkNQPkB/orB+76MQgfo6EhsmZrxDQasBsyzYzxmKRXhlNJ4hqEUmtofPl+U3+NG9Og+0Eins7fI8hwh0Te9qnLMHBto/x6f7s4OIKZ4gtbB+KrPgMP1MAA20D+gYzdedWJNERqjw1Sk+9gJdW8Fx5uRCEIxgUAl0SFLVTdpch4fNx8AezuAimGxu7Bxjsh+5h07V8UZS+PDm94ujKGXX8WLPhTTl1++lgoqjCiQCZ7pcGkC8uFcl88X+6SJWUVwc6XERDHpJ3pe8esw1tbmiOPwWWt7kudKqFB/2hEllk0WR6x5fHBVTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36506261-e3df-42a5-6018-08de807b9071
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:08:52.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i1h+lqFX3ZJUiI0pq24RHRiSHRLRGrtglRk5akmEj6JOngpxP/Db4PN06qFO3VITQglAHBE/TSlwIcRQraAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6239
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33161-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:email,CH3PR11MB8383.namprd11.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6C919279C9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> =

> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 06/15] wifi: cfg80211: add proximity det=
ection capabilities to PMSR

> + * @pd_support: supports peer-to-peer ranging as mentioned in the specif=
ication
> + *	"PR Implementation Consideration Draft 1.9 rev 1" where PD stands for
> + *	proximity detection
> + * @pd_concurrent_ista_rsta_support: As the peer measurement request can=
 be a
> + *	multi-peer request this will indicate if the device can act
> + *	simultaneously as initiator and a responder. Only valid if @pd_support
> + *	is set.
> * @ftm: FTM measurement data

These should be part of the FTM data.
pd_concurrent_ista_rsta_support is only valid if ftm.support_rsta is set.

> + * @ftm.max_no_of_tx_antennas: maximum number of transmit antennas suppo=
rted for
> + *	ranging
> + * @ftm.max_no_of_rx_antennas: maximum number of receive antennas suppor=
ted for
> + *	ranging

Supported for EDCA based ranging

> + * @ftm.min_allowed_ranging_interval_edca: Minimum EDCA ranging
> + *	interval supported by the device in milli seconds. (0 means unknown)
> + * @ftm.min_allowed_ranging_interval_ntb: Minimum NTB ranging
> + *	interval supported by the device in milli seconds. (0 means unknown)

These are not advertised anywhere, and time between measurements is not par=
t of the measurement request from the user.
So why this capability is needed?

>  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
> + * @ftm.support_edca_responder: supports operating as FTM responder in P=
MSR FTM
> + *	request for EDCA-based ranging

So support rsta means supports RSTA for NTB only now? Do we also need suppo=
rt TB RSTA?
 =

	struct {
 		u32 preambles;
> +		u32 max_no_of_tx_antennas;
> +		u32 max_no_of_rx_antennas;

u8 should be enough

  * @NUM_NL80211_PMSR_ATTR: internal
>   * @NL80211_PMSR_ATTR_MAX: highest attribute number @@ -7841,6 +7850,8 @=
@ enum nl80211_peer_measurement_attrs {
> 	NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR,
>  	NL80211_PMSR_ATTR_TYPE_CAPA,
>  	NL80211_PMSR_ATTR_PEERS,
> +	NL80211_PMSR_ATTR_PD_SUPPORT,
> +	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
 =

These should be under nl80211_peer_measurement_ftm_capa

> -	if (out->ftm.rsta && !capa->ftm.support_rsta) {
> +	if (out->ftm.rsta && !capa->ftm.support_rsta &&
> +	    !capa->ftm.support_edca_responder) {
>  		NL_SET_ERR_MSG_ATTR(info->extack,
>  				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
> 				    "FTM: RSTA not supported by device");

capa->ftm.support_edca_responder is only needed if out->ftm.non_trigger_bas=
ed is not set

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


