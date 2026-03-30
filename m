Return-Path: <linux-wireless+bounces-34158-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPYsOfQcymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34158-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:49:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9F356123
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B257301C888
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B98395260;
	Mon, 30 Mar 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITT1kUTf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3F1E633C;
	Mon, 30 Mar 2026 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853045; cv=fail; b=shDr8HQCuWK7YSFo2/YZ3r+Qq21PML3TeTlAuxEGp4tZBY6uUmM20giiwImIt+Jj2kiB1jYMRVzkokg0j9bAincEf5OspoOXp2wpVew4dakW6mREmKgFTeZeoPkK+I89mGKOP/LyMc6yjOb+a0Gib+tToO2nCbpUHTZwNXQjMc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853045; c=relaxed/simple;
	bh=eiOtQK1OzFhUbhQdijzxFRhtUlTqqAFzeqUhgY5ayB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nbKB9nDjXsdtT4d8pqSiIbzjPa5+isIVqqrODvjPb0rJ6EP9nireYa/PyVO6RRygWxIqD5k8XMoS3DrmL5sso5Mb+dzaR61zoQ0Lh5SCBLrxGblk+78b6/t6MpYUkdwqBnYiSzQk4Q5lm4b4+WhA0rgYRII3ktebfjXP0MAjzYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITT1kUTf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774853044; x=1806389044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eiOtQK1OzFhUbhQdijzxFRhtUlTqqAFzeqUhgY5ayB0=;
  b=ITT1kUTfIFPdYE82m24N5c4K+/xbidJQ+wVvp5+RNrVMTfbraEyyR3MB
   vFKDKSTmKsvL673izWJnJnEfFStw3HBsnc1sP4G8H/MxodEz0IjueBUtw
   6Ntyq/L6MULCS1rQcWGmcFItgTgGE9OvwNd36jNzDWmUEikEAVv/Bn/yI
   fRMFlNcaj58h9wHEMjT9GXAdn6TjK7pvtFCbu5lfkc24KpbZ0py4+1eUv
   r8Va3iZtTu24TW+2TSeYSktKdY8AlGasJ+MS+Qsi8duQ/9KxewJm730Kb
   OXd4oMG43K263lRBpBUtRqnpz1S+W/yA4H55if351bWOjxSWqQkb6geof
   w==;
X-CSE-ConnectionGUID: yhjHWdrcS3ahOvsk3lHvsg==
X-CSE-MsgGUID: 2DKp1ZwSSTK/3J+N6sQFug==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75014659"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75014659"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:44:03 -0700
X-CSE-ConnectionGUID: srRBUvvPQgq4IqH9VIbcvw==
X-CSE-MsgGUID: X27HO8TuRQyklYNVPnPr/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="222647819"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:44:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:44:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:44:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFTUXWNJM95WOmZEr1cDX1WI2Ospl1hbG/EVw7Wx5nB5P6KjiV50lKCzveU+fcu3NiUqFlLWICn/fyZKNzoA20a4SeymBBbPhYFEZF+IwAd+11kzxAQfnSjHMz4ouy2osp7ZnCPf2D2UNBLGyFmeppMd6iZzeyqE2XDQ/Da0axwXgkIM1aGeqPdzDFEtiscldwOVimbfkYhz5VDktk5sXgEMCg90myBEzmPtbHFYmgJDlTQ4mY41hMMm51AjpRUL3OpXS/ijiZ85jK0uqykdS1ULRftJwAnD+7E21wyV3xrL9SbBb6++bAcZ9DEm1afCO9k8ZkWL7QhUuv+TaJtuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiOtQK1OzFhUbhQdijzxFRhtUlTqqAFzeqUhgY5ayB0=;
 b=WApM34ZAwVhsWYfqrGu8IbyVnfz/ROyuRIzJyB3B+qhYTrJVDFDCnW6ExwCxEwQvrHcArS1b3ISXqWxLdd7ApI86xC1b7Q8Pz0GXBdqJXLXrQRcDfkkno2SkXhP+JEp7ysSCtJKj11r7lY52T0qARvKR+uFOoaLsBb3PLldzx//TwYE5TeJMSrHTaese5fcrVWPD8h8CY5tAXnjazUwoEWZoRRwYmeq4EeStNu7HFRhKhMSDV8eTL1rwiX/ilpbSf0WBynPJ+UxdwJwViSJvaxA59xt6Rvi1KGyWwpRDuJ5CpKPAR750agqpTYWqULr6thC+uq90h9z+ajyTDKNG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM6PR11MB4580.namprd11.prod.outlook.com
 (2603:10b6:5:2af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 06:43:57 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Mon, 30 Mar 2026
 06:43:57 +0000
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
Thread-Index: AQHcnB5c4HUu1dhMikmnTZ9iPu2XvrXG6LLQ
Date: Mon, 30 Mar 2026 06:43:56 +0000
Message-ID: <DM3PPF63A6024A9E6728A0315DC6653D109A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <DM3PPF63A6024A9E1EF4081E342AF4BED81A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <20260212125035.1345718-1-junjie.cao@intel.com>
In-Reply-To: <20260212125035.1345718-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM6PR11MB4580:EE_
x-ms-office365-filtering-correlation-id: a53fcd3c-999d-4dcc-4315-08de8e27b7c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: mlNXnWmwXWGoy1Tcz5y2s0/qy/i0RdSN8+/sq3ts3ap/91ElZm5vUhq3fCj6PA+mOEhWHmwbCTo/+x0juHbRtXRXyDslW7pKRWMGCTAToMDftN+CDUrD5Xfyz3iEqIH3HSahWLmeGDXzAysQepUCUI/Nlqxl3pWABLAgKhlMuAlEGeKOmfY8h+x9M5cI1Lh11FwAhUarpV19djTXFNWJEjocnvo+wfw51hhQ1c8g7E7tqCAn+5SzBekqary2UtSGIaNsck+NymNfYygBksJiEpSkvPdZ7Sycj2pf5Kys2TSdRSsODf/TC1p6QaFrWzP47GEC6hFS8qcVI2GgNP353mbH36pos5h+6pCHOCiB/uFFBJZDRXnuWVtBfm8jOCdx6dEP1qY0+hyS7eki0T/7WdiQEMjFmiPJhLMmczsoyz+5OQ7WvENjh78jXbQ/2Q1OZPTqQMo/m226TFjjazWG1f6LwA/7uophN0/zhqN0tuZo5lS7mYNw/f+ZsLoDOLMMjnaFFb4B6mtMtflRLbPJwK4ZdyE9G/ftAiAk5M/rhsn01uBp9En7lZx9OORxx4Ni9dGOh4QTQ6NFN+Twwrtvs/GOBdPnIHDQdtKhyxrwtkdExwFUCU66drhOy23jq484ZonboMImQ762Vzs9r9GlSBtOTeHCe66Gc1/9rAFTih2QHDK79+e4RM55tQl0o0L3/IKYnMk3s13MOnq4fml8Rb9EG55d4ONzAzVX7GMhWqzRGcJ90Z3WekiE7rYqosd+pbxSweg/NSmxz43rDOvTzCoMVtr2DtVu0p2Pwr9Y75A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWVHS0xrejkyN2huT2hvMVdzMUVUcWVUTmxRVGxmYkQzZjh6WmR3bm5VQ3RD?=
 =?utf-8?B?VjJNOWo0MnhkQnV6RGt1cGQvY0VaM1JpY3A0cm94WjJ3ZEoxK3VIb1pvc3Fo?=
 =?utf-8?B?eUdwai9CTDdXeTZ4MFFOVDE3b3RLTENKRW9LMjlyTFVFaFVlUlpvbU1NWHZl?=
 =?utf-8?B?VVgvV2I0T29ydm1sdXJoY0RrNGxRVVJDeDJobGZabXV2cUFHR3BQU3VMTHFH?=
 =?utf-8?B?Y2lUTlNFZFZ1UitBMTRtMXNSK1dJc3lzMnBzaGZnTHBaNXBYTnJLdmVHWUtJ?=
 =?utf-8?B?NWRTMHpoRExKZzJwMWdyK1FNVkxNb0tZWDd5dWJNUzBiekF3cXpNcDd6V0xn?=
 =?utf-8?B?eHZwMDBCcVc5TWczMGszWWZDbDZ5ZFNZemN0akE3S2paSjMrenpzOWcvNHE1?=
 =?utf-8?B?akY2Y1E5Nk9yQ1BMVmpNcmpRakVvS0VTQ2lWVjM3dHk2U1VOTHhkSkFoQW1V?=
 =?utf-8?B?UGFjelkvdzlCK0hPREtKL0lGclRUdHJZQlVOenpKbXdwa094VzFDRDI1RWFO?=
 =?utf-8?B?L2h4UHNoalpRNThDQXh1U1hzQ3NZdlZjYThINTRDUjVWRUxPZmxsSUQ2bXBU?=
 =?utf-8?B?R1B5WUttSlZNZzdKSE05Uyt4ZGwyL05yRm9NSUFkNFppaU53MG9yMkIwSm9O?=
 =?utf-8?B?OTV0eXFEUytoR2t2NlltaE5yakNENi82a0JvSWVDTCtlMWM1S24veXMrSWtB?=
 =?utf-8?B?RVErK0hSM3dJRkNUUE8xYjdtSmRsUkYzdGk1dU5OaEw1eStnZ2J0bm1ibFJ3?=
 =?utf-8?B?TUxiSE1QeGVjMFd2b3EyaUZQZE11dXlNMEQyRGZJV24zNkRwbWowd2RvNUpy?=
 =?utf-8?B?d0NQYjlIUkJkVm9RcjhJTjl5WDhQc2NOaCtOMzFYcWxCeWs3NUUweXdWVE1h?=
 =?utf-8?B?LzQySFdzQmp3N1FYOXdkcE15b3Ywdk1zck5IVDBqNHRnd0tTdldUdkJrNFdD?=
 =?utf-8?B?U1pxR25GdWRFSEgybG1iTmNLZFhwNTVRbHVvSWZTeldWZ2ZDVmd1aGdxU0pY?=
 =?utf-8?B?OGFVSGRPK2ZoNml6TG9aUktFU3V0S3VGWmxVRWE4OERDZCtIMVN5NGp6Mlp2?=
 =?utf-8?B?SEcvNEo3bmo2cmw5enI2bkY1TGkxUzZJWUlCcFBXdE5aNWdaZGxNYW1KenFW?=
 =?utf-8?B?b2NWei9IblFRdTRSR0pBaHBEbUtiTGF3d2F0blZCWnVFc3RvTFIwdEtIRm5S?=
 =?utf-8?B?Y1Q1azVuMWxJbHBNVlB6SVFBZHc2YnRtaEVRYnVIa1RJMmhTTk1wWEJycm9H?=
 =?utf-8?B?ekMwS0EyTW8wSzJEcjdUMkMzUnk4cy9rUVhtbG4yY05OdkpjR01rWnZkdG81?=
 =?utf-8?B?cmFqakxaN3Z3bkRMYnJ1a3h0dFhoWEJ0Rk12RHBKNW05cHFyWEVyWmxST3VS?=
 =?utf-8?B?RUZKcGU5bkRNMStsL2VZUkJFZVdoaFc1VzM2alRBTCtxNGVhVGFGQkVvZHpo?=
 =?utf-8?B?QUtvNGM1d2NwZVZha3hEN2syTVRoakN3VG9SWnlqT3E5UmhRYlpTaWhoaWZX?=
 =?utf-8?B?RWtDV3RMcGwzSVMrOE5FL0lpNjJYSFF6dFhZU3pDUzZVWU43RTlqYnVHVEdw?=
 =?utf-8?B?WFVnYVFVSmpSdG1ndFp3cVMxSlk0U1Z6VEVhTEM5WjZ6Sm1qR05aRHhodWMw?=
 =?utf-8?B?S2srN1VEenB6TzY4M1lIUkx0NnZ5WUU2NWx0ZnVYL2NFQXVuUVVES3dtOFJw?=
 =?utf-8?B?RkpUTzY0QytQVjFOd0FxN0FBbnFtY2llZmtkMHJEY28ybzdSUDV1TG9odnF3?=
 =?utf-8?B?ekVFYlJtV2xKVkt0aTJHZDdxc2xJS0lpVFpUR0NMZS94NVo0U2dvSFZZNXJv?=
 =?utf-8?B?Qmh5R3F5TUxSRFd6L2pLVHdtYTdMWkNjS0pjME5uT0NhRWVNM3VEYTBlNVQ3?=
 =?utf-8?B?akE0dkd5b0RZZnVBUHF5eTFzWUNBZFhHWDhLTnMzOGg4bzQrRUN4M2RleW5h?=
 =?utf-8?B?TlJwU1paMlpQMEVyNDZHc3p5bTlyZTNDMitWSHVHRW9heTJyR3BwZDJVREIy?=
 =?utf-8?B?Vlo3SDZhYkZxWi9LYWM5bkpUYlQrNHgxM1ZiZ1VpWUk0ZTViUU82L25wMXA0?=
 =?utf-8?B?eFJ0Znd3ZjRRKzBhbG45VytvVUJCbEMyVThYUjFERG1KN0xUVnhHV0dlQ05H?=
 =?utf-8?B?amI5Z3FXdk9Hd1FuQkhGT2M4QjR2aU1kQjFveVUvNkM4S0hIMmZMQkpodUhp?=
 =?utf-8?B?UGpWdkpwOURqY0xsS25iYkFIUS8vVWx5M0dJa0VGRnpqSUJMbDZBSWFqdjdL?=
 =?utf-8?B?Zkk3OVF1S3UvS3ZYZm0zRU1GMDlGUG5wam0zYklYYlpMNHk1eDFQN1FWeVMy?=
 =?utf-8?B?OTU1VzRkdjlobkJOSFFkNlVJK09wcWNwMDRsbEZUanlwcCtBcFN5TFZ0L2Zy?=
 =?utf-8?Q?gjM6JYFyAxpuCXYA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uKqHVDiEXyPV+esW2pV5/BkthW+KmzYoK9shcm3w5U9hpQ9kgHUNi2VxD+cXsZriDvHvTvQgaXINzqKTl3dzIsshhJaDdYHX855p9LyaQuFuuJX/heajbfbZl2/Hgbui7q+dw/Z+YDRGFB61O4Y4WqLZ7WQVZa1Nl/aK38Ww9ae5WUZrlb4Z2ONYZ9KE73oKQKWTEpkcwDh7akyJsYjOhkX9TOU+r2U2Yiyz8hMp1sYhgtIJA8M6WtFsL5oI1UH0WYPAfzH73emP1/fstvxTjKojEEJBrF8th9Pa6XHiJFGa4JfTKfiJCAXm6muoxhkkXlO4I/XA2rU+mKkmnhByXA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53fcd3c-999d-4dcc-4315-08de8e27b7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 06:43:57.0429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pIUPZIxYA17KEVDtcAttqt3ch7+ippkiNoDwJNFSUKy/SXKGqXNfV95rMXB20RbSj3eUrLQaNBeqLPfiSnBWWUml0jqbepwalYQtN91mAftU0rOo8vWPHfB0WVfph6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34158-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,vger.kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1DD9F356123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2FvLCBKdW5qaWUgPGp1
bmppZS5jYW9AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTIsIDIwMjYg
Mjo1MSBQTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtv
cmVuYmxpdEBpbnRlbC5jb20+OyBCZXJnLA0KPiBKb2hhbm5lcyA8am9oYW5uZXMuYmVyZ0BpbnRl
bC5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IHJpY2hhcmRjb2NocmFu
QGdtYWlsLmNvbQ0KPiBDYzogaG9ybXNAa2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4geWVkaWR5YS5iZW4uc2hpbW9sQGlu
dGVsLmNvbTsgU3Rlcm4sIEF2cmFoYW0gPGF2cmFoYW0uc3Rlcm5AaW50ZWwuY29tPjsNCj4gR2Fi
YXksIERhbmllbCA8ZGFuaWVsLmdhYmF5QGludGVsLmNvbT47IFByYWJodSwgS3Jpc2huYW5hbmQN
Cj4gPGtyaXNobmFuYW5kLnByYWJodUBpbnRlbC5jb20+OyBDb2VsaG8sIEx1Y2lhbm8gPGx1Y2lh
bm8uY29lbGhvQGludGVsLmNvbT47DQo+IGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tOyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnOyBDYW8sIEp1bmppZQ0KPiA8anVuamllLmNhb0BpbnRlbC5jb20+
OyBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IFN1YmplY3Q6
IFtQQVRDSCB2MiAxLzJdIHdpZmk6IGl3bHdpZmk6IG12bTogZml4IHJhY2UgY29uZGl0aW9uIGlu
IFBUUCByZW1vdmFsDQo+IA0KPiBpd2xfbXZtX3B0cF9yZW1vdmUoKSBjYWxscyBjYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoKSBvbmx5IGFmdGVyDQo+IHB0cF9jbG9ja191bnJlZ2lzdGVyKCkgYW5k
IGNsZWFyaW5nIHB0cF9kYXRhIHN0YXRlIChwdHBfY2xvY2ssIHB0cF9jbG9ja19pbmZvLA0KPiBs
YXN0X2dwMikuDQo+IA0KPiBUaGlzIGNyZWF0ZXMgYSByYWNlIHdoZXJlIHRoZSBkZWxheWVkIHdv
cmsgaXdsX212bV9wdHBfd29yaygpIGNhbiBleGVjdXRlDQo+IGJldHdlZW4gcHRwX2Nsb2NrX3Vu
cmVnaXN0ZXIoKSBhbmQgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCksIG9ic2VydmluZw0KPiBw
YXJ0aWFsbHkgY2xlYXJlZCBQVFAgc3RhdGUuDQoNCkJ1dCB0aGUgd29yayBydW5zIHVuZGVyIHRo
ZSBtdm0gbXV0ZXgsIGFuZCBzbyBkb2VzIGl3bF9tdm1fcHRwX3JlbW92ZSwgc28gbm90IHN1cmUg
aG93IHN1Y2ggYSByYWNlIGNhbiBoYXBwZW4/DQo+IA0KPiBNb3ZlIGNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygpIGJlZm9yZSBwdHBfY2xvY2tfdW5yZWdpc3RlcigpIHRvIGVuc3VyZSB0aGUNCj4g
ZGVsYXllZCB3b3JrIGlzIGZ1bGx5IHN0b3BwZWQgYmVmb3JlIGFueSBQVFAgY2xlYW51cCBiZWdp
bnMuDQo+IA0KPiBGaXhlczogMTU5NWVjY2UxY2YzICgid2lmaTogaXdsd2lmaTogbXZtOiBhZGQg
c3VwcG9ydCBmb3IgUFRQIEhXIGNsb2NrIChQSEMpIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4g
UmV2aWV3ZWQtYnk6IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4N
Cj4gU2lnbmVkLW9mZi1ieTogSnVuamllIENhbyA8anVuamllLmNhb0BpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcHRwLmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAu
Yw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0cC5jDQo+IGlu
ZGV4IGFkMTU2YjgyZWFhOS4uZWZiMjkxY2ViMGU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYw0KPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYw0KPiBAQCAtMzIzLDExICszMjMsMTEgQEAg
dm9pZCBpd2xfbXZtX3B0cF9yZW1vdmUoc3RydWN0IGl3bF9tdm0gKm12bSkNCj4gIAkJCSAgICAg
ICBtdm0tPnB0cF9kYXRhLnB0cF9jbG9ja19pbmZvLm5hbWUsDQo+ICAJCQkgICAgICAgcHRwX2Ns
b2NrX2luZGV4KG12bS0+cHRwX2RhdGEucHRwX2Nsb2NrKSk7DQo+IA0KPiArCQljYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoJm12bS0+cHRwX2RhdGEuZHdvcmspOw0KPiAgCQlwdHBfY2xvY2tfdW5y
ZWdpc3Rlcihtdm0tPnB0cF9kYXRhLnB0cF9jbG9jayk7DQo+ICAJCW12bS0+cHRwX2RhdGEucHRw
X2Nsb2NrID0gTlVMTDsNCj4gIAkJbWVtc2V0KCZtdm0tPnB0cF9kYXRhLnB0cF9jbG9ja19pbmZv
LCAwLA0KPiAgCQkgICAgICAgc2l6ZW9mKG12bS0+cHRwX2RhdGEucHRwX2Nsb2NrX2luZm8pKTsN
Cj4gIAkJbXZtLT5wdHBfZGF0YS5sYXN0X2dwMiA9IDA7DQo+IC0JCWNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygmbXZtLT5wdHBfZGF0YS5kd29yayk7DQo+ICAJfQ0KPiAgfQ0KPiAtLQ0KPiAyLjQ4
LjENCg0K

