Return-Path: <linux-wireless+bounces-27311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CAFB572D5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521A53AC56B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531F2D839A;
	Mon, 15 Sep 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCm9PXZk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8441E7C2E
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924725; cv=fail; b=syrZk2Xe0b5fFgO6ASIQSWa4fmDJLLrrfl41Rfhaiz778acarjzRcku5XDJs739SHZj9v9fZgC5jUzJ8nV7REHS82KreJgr80bNoICbVaJQ4NjlaKPuoMxR0YlJa1aNgYav0QDsoJ7WwYKBg5SuL0C5eRdMq8zSYDO+i31o7a2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924725; c=relaxed/simple;
	bh=l9rTpy5bE7mX7JeSLvpSOVphiL6uMFAL84ea81I7AHE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kdEKbbuyNpTFS5R7/e+RvY8+QSLzpJAXx4q4OOUXSbymMBX7m0tw3I3Y/4cHcuembRLiPFHg0CLxsexW7vbRpMwrT3hHB/7sRBM9NCWM+8lfR7Mh+tgiZirwPIXWmiA7OJCR1mZEFeuPZbYubmxNA0ubleCR/bWYbz6u+cDbc7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCm9PXZk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757924723; x=1789460723;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=l9rTpy5bE7mX7JeSLvpSOVphiL6uMFAL84ea81I7AHE=;
  b=dCm9PXZkG9DiETtA9e3HCLa2yyL5GhMp9bi6/w8/0heixMZ8IN6ODOuW
   ppSTNS034MNPxUD+xATjle4cB12rtmpykTUlZ/ksuj18kEAxRacD91n0Z
   Ja9bRVxwHcxppOISAxcIQr4qnzadlymGcuEawABU3/a1g1LsOQWlgOoVR
   XcItzP4oEoTNwFpQ4AtAt9I3TC44PsvOZPpi+On81HYihOONvX0ovpIOf
   uDy0sGX7B6vxrwMr9hk9yOpRydcVLkEFjG4vNDRzRSS53Go3zzMtnF/63
   MK7d5lf/P1n8U9wmGwu40PakKRctKMz/s92c+ZIQ8yBjnmt/ynYZNZM83
   Q==;
X-CSE-ConnectionGUID: dhJKRMj8QzOoARNyF24N7Q==
X-CSE-MsgGUID: 4RH4m5+YSamqb83fhRfZ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="82759275"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="82759275"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:25:22 -0700
X-CSE-ConnectionGUID: M+d/m78ISz6b95tWpuTjbg==
X-CSE-MsgGUID: 7VHyINrhQeOVqVsrZs3RLQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:25:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 01:25:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 01:25:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.85)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 01:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmDYBNVv7Z08qnnLFG4lbLsvrjXuLyygfZHR8fdweNo9+nEjYP/ZaCD7HhOkjdBtwhgsoNLuZxSIJwKmHJC5nccKj8KZ6FHeJp0Lj802YGJmXsTM8UrDsW7C2Bg/Py0+t25Z7rq6u8XsYIRo2dUFjXqYuTOtX72vAGIjPhBdw7/W55pNpjY3p+zfPCpLJYSrD71ZZcWWC+IjbR9hrjI4m15YSz531NiYKdDM2h3kajZ1TrSLgmRnuPxIB7nrb0MlgyxU8GVAvNk1sn96U4gSZZmEjL7jveJy29e2VLs2oStDNEvGY//tgCCzUnRV6RA8HLLeDKhA/iL67fTbQLMAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9rTpy5bE7mX7JeSLvpSOVphiL6uMFAL84ea81I7AHE=;
 b=NvSuj3By/vgWRhURQUgDpLS3j3tnmCW5TlfFVkTHWQdT7OkbEtY9ArXVu9EfsjrT8T7430HC/zbsKFYQocl4FLnUVT4IrpQ5SwR9mfjoX/KENBE+IwGEPqu+ZcudpXMzA075z9rAdas05IyARY2xaDfVgeve1+8PnSvhv+GOJhGjq+DbLYRlNbB6vnB0bN5d6ImgYHcFvosLZLBpFHF3MLZJSMsHrutTE2re24TpwBMg+T5Lr/3qX2cemwjMDaRhNePyolzOAdWhnvChzOhSXQfv1wAD9oU+VfflP9ZzPdlKFCDdzZSrow3tNbyCF00jBliVo3xfze9o7f1OrzWFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA0PR11MB4542.namprd11.prod.outlook.com
 (2603:10b6:806:9f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 08:25:16 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 08:25:16 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Berg, Johannes" <johannes.berg@intel.com>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2025-09-15
Thread-Topic: pull-request: iwlwifi-fixes-2025-09-15
Thread-Index: AdwmGkFHufnCjkjMTG+O53Sh/onhRg==
Date: Mon, 15 Sep 2025 08:25:16 +0000
Message-ID: <DM3PPF63A6024A96C0524C461FD41D61D23A315A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA0PR11MB4542:EE_
x-ms-office365-filtering-correlation-id: f70d3f88-d005-4600-d3f5-08ddf4316650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WTVFMVJEZkk0OW5FQkcyOGFFUUcyV3g4a3BtbVF4L2lrQ3hTK2lJcnhlSC95?=
 =?utf-8?B?M1hkbHJMeHQxaW5JazV5bE96bHlVYzEvWU55eGhReVBQNzE4bmdjNFpoUGJE?=
 =?utf-8?B?YkR6NWVHdWFNdk91VFNqaXBGZTdVMlBiMk4rYi8vQ3ZlU3VCS3g3YnpPQm92?=
 =?utf-8?B?S2IzR0hoZERGdmpCb0pyb3ErRGVEWHBhVE93ck9wYlpRVWNJTEc3NHdSR3NL?=
 =?utf-8?B?eXJBdk1jMEhCaFJWWjVZRFRrclZiMXVabm5zM2VPMTdDdDk0bGZzbDFwdEEv?=
 =?utf-8?B?bUlhNHhRWVo2S3hSY3ZWTjAyK3RFOFBQRmVoR2NwazNDYlJBMUZqcHNCdVM0?=
 =?utf-8?B?ZVB5ckxoVm1BZ2VkWFhpUENCQUMxZVIyYkszTnFxQVJlbXdxTmVoRUxUeHVi?=
 =?utf-8?B?c1dwMlp4TEp5N3VXTDhvd3pnK3BLblQ4d1FsRnRsSzdnM0daeVFIQ2NMRkJw?=
 =?utf-8?B?SEViUmJuVjZpcElBWUlTVzA4RGdqajhOZzVCR24yVWl2R1ZlYmFFRG1SUEEr?=
 =?utf-8?B?TUNiNkgzRUxNZ1RrWTExMVA5WjhwSHg5MEh5eW9DUXNSSnlRWGZlZmNVRGFE?=
 =?utf-8?B?ZmVrRithNkVVRk92TElZUExqUmJ2KzBDczk3aWhOUXNSOWlVc1B3SkRYV0wx?=
 =?utf-8?B?YTRMV3RsQU5kYXEzN3hWaC9mYTFUdlhEY0lBNXpRYSt5QXdsOU1XajBYQ2px?=
 =?utf-8?B?Z000Tm5LWVExdm5qSkNoSWVIWmg0QjVJL2VkbUlIR1pkN1M0RXIzdkpLNWpv?=
 =?utf-8?B?dW54YXpJUm9CTElxekZZWmJEZUpTdHpCTjM0U3NuN2tnWCtBdmhBdHNBYlI2?=
 =?utf-8?B?aWRlSXVYVEZDVTZUMVozdVRYd3V0c2hCSDlhM2ZFVC83bDAzOXlQRkQ2ZUxv?=
 =?utf-8?B?ajlRK0VRa3paYUwzbFd6eFF3cW9Xd0UvSlZnMGpTT3NvbHd3ZjJ1Zm5WVXAr?=
 =?utf-8?B?eTJ2UCs3MFM0K054V083SEVLZUljN0VzNkhqemxtcDZtWVNoOU1vTW55QkFT?=
 =?utf-8?B?OGN1ZXVYQ0ZhVE9vdmNaVG1iQmkwZjF0N0R3OEZUOXhHZC9VQ0FQT3owQ3hu?=
 =?utf-8?B?dlVyNDR1bEF1aFVWdUhPVzRPeGVKVm5ZWHhxVHJYS1dJYlRqR2RZUDBWbmEr?=
 =?utf-8?B?SW5EVUNNd0J5ejVGbnhnZTZIYjl0Wmk1dHpmS1JhQm1uZlVkQzRDUTFIVk8v?=
 =?utf-8?B?NWZCZzdkS3RGSElVdmxiM3JkQk04aVZZZTNhU3lMVE1CTTM4U3M4MXo3QnUy?=
 =?utf-8?B?R1o1aXdaV3o0YWVla2tmOVNrVVR3ZWxHdzcxRXFndWg4YkVvalFPREgzRC9H?=
 =?utf-8?B?ZkFSUEM5TVBCY25NbU02TnFxUlZtVUYvZWRRWHpMU3V4dzJwS3NYRzVvNWtC?=
 =?utf-8?B?NHV3ZkpDaWtWK01nMWdnSnFlakRTc0RPZFQzeUlGa1pzYXBXK0s5RUFkWEhO?=
 =?utf-8?B?K25FV3N6b0V4emVGeHFmRlR4clZWdzJWdGU1NURJSlBkdEVaMzdFeUcreHlN?=
 =?utf-8?B?YW1lQkVYSVlFTEpySkZDTkpPK1FXbC9NOUgrc2wvZHg5UjU0SWJtNkYwa1dY?=
 =?utf-8?B?V0NpakZlbWpFRXRRRnowaFBDT2pudFZwK1YxU3RKcVA1ZGkzOXYwcTFsZ0Jm?=
 =?utf-8?B?SjQ4eTcyRTF5YktxVml0UTY5SEY3aWJDNTlGMFZLdFQ3WFJDdzk4MkdoSjdw?=
 =?utf-8?B?MzRNKzJtU1VsZlJWY01MK05nWHlWREY1Y0x4aU84c3lIQTF0VjFQUGF0anI3?=
 =?utf-8?B?ME01KzJPMzkzOUhNV242eU1RRjdlOHBaSVcxbXRTc0xZK1pkbFY2aDhJZ2F3?=
 =?utf-8?B?WGJjcW03MUtjZzRsM1huTHZxZHYydDh2TGplWG5VQ2lWejBoUlVCMXNoRitO?=
 =?utf-8?B?NDlHM250N1c0eTVRbmFmeGNCUGpTa3N1OG5HMlYxMFBHUlRmcTA2MzQyUEFh?=
 =?utf-8?B?MlFPYllRU0RZRFRIRHUwd3JseDNrOUI3VXloZDg2dWt2MXI2dUpPbThZbXB5?=
 =?utf-8?Q?lwOBNPKSVGtguERkHsYyKWu0M6cauM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0Y5MDhsUSt6Vmw5WGU5YUNaOHZOMjk4Lzc1c2FzU2Z1NEMyN3JaeVlWQ0dt?=
 =?utf-8?B?UjRhYU1JbnJ4SGdLblhneEdWUHF6YkJsTEVkc1lwazJxQjFlMHNXWHo1TXlh?=
 =?utf-8?B?T29JMXhRekh0QmczbjZCLzc1RlZ2cVJ1RCsxTUFnZVVyOTczeWlTQ2xvbExF?=
 =?utf-8?B?T1VELzY1SkxDdTB3RzRETkt3TVY3dUpsUzBCd2Q5VlBCZTVvd1lwSDl0USt1?=
 =?utf-8?B?OTNzK3EwWVM5NEJIem1xL00zc1lneDJrZDdhL3k3WGszZmFKcW9RZkUvaFYr?=
 =?utf-8?B?NVJuTkNoL1hnMW83RE5HYnM2Zk81ZmhCR1Nyc3NxMUFNa1dVN2JBUkNCbGxP?=
 =?utf-8?B?d0ExdHVLRDRoV3ZhdFQ1R2d2WS8xd1g1Q01ocWVTaDA1UFk1eU15bTZiSGNJ?=
 =?utf-8?B?UWxOQXRWSGhkS2Q0TndxQ1NRUE5EMVR5SUpVbE9YOG1vcGlFOWsyWGZudlhP?=
 =?utf-8?B?SkhNbHMwMU8yZzl1ZnErZldPdDk4RzY1S0FYOFNQR2UyM3RRejk2ZFZvZkZu?=
 =?utf-8?B?ZThzQmdGT0NDaDJsQ05ib3FFbW5Kbk1FOTl6eW9zaGszNC8vajN1cXhmODZW?=
 =?utf-8?B?Z0NVTmJnR3JFbkRiNFFyMzhpZ3dXR3hOT1JERit3clVCdWZzdGJJbmxSK2pM?=
 =?utf-8?B?cFkyRjFPZ0I3emQxeHJDTEEvSWxtQjB5bU5Tb0hFYU9nc1F1UjJjTFpueVcr?=
 =?utf-8?B?eG04RGtEV0huUm9SZURKUlRqc29zZlNxNjYzcWgyMVJTWkNCOGFKVTNHYTQ2?=
 =?utf-8?B?bDAvWmhwdU15WElBejgvYzNSVzFDd3BCRnA0c05pNEhQTGdhN1VENlVEcktE?=
 =?utf-8?B?UE50WXBSeGNNRHNTa0xYdVc1RTFIVnE4aGZGVUQ1S3ZVZFg3YjliMmhNRk9x?=
 =?utf-8?B?aThZQWNXcFYvSEt0U3F4Z1RiTzlWcTlzYlpXUVF6Y1hpelFqUlZXd1RSUUJr?=
 =?utf-8?B?VDBlSzBRZFdTU01HNVJUS2cyazNjNnBJeE9wakVZWmNEc0NVUzhtSjBCTGdv?=
 =?utf-8?B?UHFJazhQN3NjZ2NCMUp1K3JrS25zTDRxK3cwdnU5Q0xzM0VMZTJVZkdSMjh5?=
 =?utf-8?B?U09lVlpONlQ0UkdGT1FlK2dsSDE5RnhUWndHTXRqM3FOYlpadTJVZW5nYTVL?=
 =?utf-8?B?MDVvUnZmUFRxdVNYNUc0R2NSeFRaaUdpYVh5dzhLaGtmSENYbFNha2s4cHFx?=
 =?utf-8?B?WkZDUVEwODBiaGpYK1d4TE4weXB0UUowWUg0NEt1QTJ5eXY1U3d5ZFNhdGJh?=
 =?utf-8?B?RDZNNC80Q3cvMDZNKytaL3NFT21Za2x4dTgvUjQ2cmtvYzZMQVJOczM3V0Mv?=
 =?utf-8?B?S285d1M1cnJVYmdNMmVzVkJBRTVkRU5NZmZxOGdWVWo0WmFYNDBleEJoNU5T?=
 =?utf-8?B?OHkvYkxxU3h4OEp0UHpIUy9ZRWJWSlhLMmdIaWUyU2tjZUozam9CelAxWVlm?=
 =?utf-8?B?SnYwU2x2UWJVeHVwdVROdHp2czByQ2NNV1JOeGp4MWFGTWcwOVlGKzdPMHJt?=
 =?utf-8?B?RExoWWFKaEY1Yldkek14UXZRNDE0clFRRWFuSk85SW1WbjZoUENRa2duMFlm?=
 =?utf-8?B?Snltck5MOURYa1NGOHNGbmdtc2tSUGhqbTlaUWFKY2Y3Z0tveGVJQVp3OCtI?=
 =?utf-8?B?TGF6UVBUN2tRNUhqcTlYYmtQMGwxMGxrTElFTFpNZzhvOTIyQ2dyMGtBR3kz?=
 =?utf-8?B?WkNvVjR2SnFBVVhtUWxVcVFZRDhqb2crWDJvdnFZUnVtb0MrVjh5TnNtNUo3?=
 =?utf-8?B?MjFVeTdSRnVXck1NYmQ5Q2UwSlVZMHd5d0NYMXNseW1NNzZzVHdYRHovK0Nv?=
 =?utf-8?B?T3ZKSEU3bi80bFdIYVQ0czQyaWpvZW10QmFGdERMT3hzSmxablMyUlBKd3Qv?=
 =?utf-8?B?UE9Vc2xIbzdGOGlBSXZBZTBoQklrYzJVNW9sZ3NZUWRYWnd1M1FkOEF4bzFB?=
 =?utf-8?B?QmsxZGVFOUJyd1RVbHBkQ0RFblNTSzhQWUNaY3NBdDgzbDFqRXZCNnhOQlE4?=
 =?utf-8?B?eTRSRi9YL0RLWWt2VnRZMmNnNVVDSGFCLzVMWUpLTEFveU12b08xanFFRWVF?=
 =?utf-8?B?VVpBcFRHcUtiWi9mYUE0dmNna1pPMmRtdFkzeTZCQWJTcTNmL2h2ZGZhM3BR?=
 =?utf-8?B?RVB6NHp5bDl0M21ZM29oa3hGWG5ZRU55eU1YNXF1enhBMnNlMEFtclp0dDBk?=
 =?utf-8?B?NUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f70d3f88-d005-4600-d3f5-08ddf4316650
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 08:25:16.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HpWCjob4HJCG81SpH6rkAX7tkt8P9vBPlHtqYNSB6/wbkaTq7p6NfL50+rTS7lfuZuGLPVdd8ZXY5cWuOEE9dfmPYgcLCnSjDbOkkQiDKknY5b2OGn7P1Y9+ixwM0+K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5YzYwMDU4OWUxNGY1ZmMwMWI4YmU5
YTVkMGFkMWYwOTRiOGIzMDRiOg0KDQogIHdpZmk6IHZpcnRfd2lmaTogRml4IHBhZ2UgZmF1bHQg
b24gY29ubmVjdCAoMjAyNS0wOS0xMCAxNTowMTowNyArMDIwMCkNCg0KYXJlIGF2YWlsYWJsZSBp
biB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdp
ZmktZml4ZXMtMjAyNS0wOS0xNQ0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYTM4
MTA4YTIzYWI1NThiODM0ZDcxZDU0MmQzMmMwNWFiMGZiNjRkNDoNCg0KICB3aWZpOiBpd2x3aWZp
OiBwY2llOiBmaXggYnl0ZSBjb3VudCB0YWJsZSBmb3Igc29tZSBkZXZpY2VzICgyMDI1LTA5LTE1
IDExOjIwOjQ3ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3aWZpIGZpeA0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpKb2hh
bm5lcyBCZXJnICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHBjaWU6IGZpeCBieXRlIGNvdW50
IHRhYmxlIGZvciBzb21lIGRldmljZXMNCg0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvcGNpZS9nZW4xXzIvdHguYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg==

