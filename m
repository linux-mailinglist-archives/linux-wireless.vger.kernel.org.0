Return-Path: <linux-wireless+bounces-2924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAE2844F3F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 03:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F86C28EA47
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 02:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7E31773E;
	Thu,  1 Feb 2024 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rK70kKtk";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2997lF+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB4EAE8
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756153; cv=fail; b=A+oPz73KwYwIZZPF7lQ380q1FSJEnPbtCsLVlAH5p3tgVVaN0qI56lKwfCYDCZKv/+jwB1fklIPH9Sta6xN/zWgvXpRhngGIvizjczCX298lQOCYPGjxy1IbBh8gXTPlhEbvH5QXYLBeMIOJsTFxG7ocEM9mUel690M4WQYxtEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756153; c=relaxed/simple;
	bh=VDH3vcv/ihzAlJG3rHJPskfeUb29FbJodjNHKn3ZYAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0CH4OcgDmFgEFMGrk64mvpplLNVnGUswJOHy4QLAGctioYY5k9QrocGzNRKtr2EDvOMP+zqbX+Bb6+AoRWbCfWLt8Cv9yt3W/UU8FdnOylovcLyaUUbOnxn5OtcyiCsji/7+y7pkWn6PJgto4o92U2lf1pXl2yao6yk/qcT1SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rK70kKtk; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2997lF+z; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706756150; x=1738292150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VDH3vcv/ihzAlJG3rHJPskfeUb29FbJodjNHKn3ZYAo=;
  b=rK70kKtkhiRw4Sh9E9YQNVadzNRw+3Tl99V6qeDohsraCHMiHrqeEMjp
   n69t85Zo1yHPIkEcLYJ8FX+QnvQ4gLOamvz68gB+Ny0IEzACBvY6sExup
   +KUwreyLYOLjJH2Sqvb/QQtXHWo0UU4GaRFwlaSLao+HH5mZZrYiZj1xP
   pj0pry7T59Hi77UyFDkT3TpaD8HVaMeRhySHWzrpBotBNTwiGn2OL0M2q
   2kMmoYlAJLvOPi5EKMBtXBmmYDp3Xip9gXwoLM6ZF/Bkj7uyTfQtdIP4y
   aQfoiYRf46u53xS0iGgQ0TgDCT+fihPhkrwIMwP9/Hxm4LPPuXmV/cFzY
   w==;
X-CSE-ConnectionGUID: 1hwRwE83T/yxulu9T+4rCw==
X-CSE-MsgGUID: 0YYHGTqRQ+a9ncdilV7L7Q==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="scan'208";a="182852981"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2024 19:55:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 19:55:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 19:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgocKybf6WxKx5xCDAWmlsJADeVLLXoR99AM8dfuD1+XM+MSFdgC/GOt4KSIeKtr17jB41TrbqNjmNU6SsCEKocxtrjqgiqsWBvqBfZTB9bDzfWa3f9cD5tRNc/YdR+jpx6IV/raz6cQQQUMJCu3LQScqtClMLu/v++9wYqMsfEQmIhyE1Uq9fiKnEJ/h7ZdOzi5/mH8JFhyRfq+vEnTpmNZDMPw9NwZ3l5Q3AtmDL/Nkn/LbL2ss0Ejw9WtYvJP4tdnu2tIhXbzPSlEgPiSZLAQRWYEhB0IdaiATV6SbJKN3s81WcoIWY4DvzzR7p8RO8in0tPFqFeTnV1qSB32jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDH3vcv/ihzAlJG3rHJPskfeUb29FbJodjNHKn3ZYAo=;
 b=Eb2KYCQ5oOmshNpIDRyIhzy9i+OoWDZUdx/LHPThjK+izTE/5SSo7mDbZ+cuRDyAWlKfrc2pM+1I84c1ETwwpvLITWa6BqHHrDQJVqZkxlkhIRg6z4BecbpczHEv84Ga77wZwQN5gQYvCRVPcktwqg1GwMaKEHzkyfziZgBHSyALJhezsAHZ3arvy2GXF4dI4i9p+bN26AFBlktDzneHEtUpTmHQ0ap1R11sFUJVMV9J2EuYuEYQ2TMTqjtrPX1YIBNAdIVUtY8zCTxjLTahN/iLAIRPJNebA8kXvFEnYTrdBoKZ5Ll5gzyogyFBHjYDwal5bJ4qgSuSpfd4qokTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDH3vcv/ihzAlJG3rHJPskfeUb29FbJodjNHKn3ZYAo=;
 b=2997lF+zXZFmVnip7Tpu+fS0+gHhaytyf9QGkclq4xtw+U+q9DOKFf2TZAfKny9amrwEZMH+Orl7BauZIIgPY38KvTu4Ns9z7kiSXuKvs8b0zIOnJr1XJOmOUdfzDJgSl5k0i0i5Be70OPtBDClQ+k30iaZ40Q0+ehNpvFhuaEps1dZEV705qYBZklS9cUlvGb6g1c89lWTH1Iu9nrUC6IqNT0eSVA8jERWJKadB5RDOrGQYy+sU9MR8rxIO+isMng4dD6czhfI8jTRe0vhEQN0KA0wZtbh9NqIybq/Cb/VQvCk9Pl5n1VebBLsbja/x8+Eo3s3OyZqXIZ75WxVyPQ==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 02:55:17 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 02:55:17 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <davidm@egauge.net>,
	<linux-wireless@vger.kernel.org>
CC: <kvalo@kernel.org>
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
Thread-Topic: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
Thread-Index: AQHaULnuKL3TjM2+rEmNfh48y4JbNbDyFdYAgAK84AA=
Date: Thu, 1 Feb 2024 02:55:17 +0000
Message-ID: <e33b2e57-729e-45ac-b14b-bde58313bfb0@microchip.com>
References: <20240127004331.1334804-1-davidm@egauge.net>
 <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
In-Reply-To: <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CH3PR11MB8239:EE_
x-ms-office365-filtering-correlation-id: d73ec5bd-113a-4ee4-d8e3-08dc22d138b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbSTFt4/z3xrbFt++fAfV10Ss5e/XI33cj7r//BV7ZFNZ7SIG0EZvU4azgzi3gWmlQJG+vUwYoYgp7UGYyOlDbioyoHlUdFripgqiNfQQyft1NkaZDdzNkL93vcZFWVgWxGaSpINF13XCGBSed17teVTdJ4RNVEEX2C2xOqNvdv0ZJH1/KSGlpfjB/ZsKVRmQ4akXdUoYD4/vEg1JqnnJZa4Tzv9xLtskETi3Tt9LmpDc/tDnQuBcRn9UpuVWUGu7qVoysO6XZ30Gr8B50++Rii6iNME/tn5WsAljpKPOc937siyvnzj79L3yVDMfuiu+qLyDONI7z/S1naACQ1N9mOhTtwTAk2SqxqJ2bSgFEASU+j5ItYug6HbqF94w7Wih0dFl+CtwvwiaBvM962Q0eMFeQG1othejoRgw/OnHC0gF4Wj93/i40Z6cv8FPhha0FG7e+PW2eWDAODJqF1htL3hQ+7390+ifwM1lrED5WSeNM1iOotqVyOqN0hbJ0W1fyY5IHZoEz/B2nsnHJ153MbADNrtmRjhQ1RpZbE7sG2KZST5Cas71x23tvpYYbFXsG/LBfYZi/GwUVTpmNPA/3mTQdUzYBeDvwFO8I1UiOxqhS77Lt9ZeoZ990UkPsk8fqjYpmFEz69XgfY5VUxzSiEvSBlQKkY/t2f6tLkf4t/JEt8k55J4UwtFtiP/9kmyJWDZCpBNVePT9EnRPkcMqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(2616005)(26005)(31686004)(36756003)(966005)(6486002)(38070700009)(83380400001)(6506007)(71200400001)(53546011)(478600001)(6512007)(38100700002)(122000001)(316002)(76116006)(31696002)(5660300002)(86362001)(15650500001)(66476007)(8936002)(66556008)(66946007)(110136005)(66446008)(64756008)(4326008)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjlhU1ptbTFJbWxpZm43dDNmMTlEWDRZaTZoTWJtd3VXYzlZWXE2R3FuSk43?=
 =?utf-8?B?VmlTcGJidW9OMkp2SXBVNkZYUHlvM0VSQ3pSMlZ4YXk1ZEE5ejQwb3NLT2ll?=
 =?utf-8?B?M0Nxd3NIamZxbFJtRkYyWHFIcStEUWRwVXlCc25qWFZQNGZUS1NjN3owQ1g1?=
 =?utf-8?B?ajNkMVFaV09JcGtuR1NDYkFwdCtaTTVLUWpRU09pblpNcVhIdmRuSnd2Sk5D?=
 =?utf-8?B?dkhCbkpNbm12bU5ubTJXUUExaitFR0c0dUU0UURXTWk2RUg2Sm84eFRtRW1l?=
 =?utf-8?B?VUcybnR1NURKTmNnRFZ0REsxaFExK1R3cmE2VldwR3FGUVIvVWljRWU2YnRr?=
 =?utf-8?B?VTJKV29zSXlLSUVzZ1FaWHVFN0E2RHJ4blBybVhNTDE1cjgvM3c5NjhSTmR4?=
 =?utf-8?B?Z0duRXlGN2FGRlMvRHdIdFoxQUpzV3Z2MloxbFlDVkRjQzVlOC9Pc0ptWmdP?=
 =?utf-8?B?YlQ0aU5wODlHdm14a2VQRm45NXpvVk5MVlJmV1RVbXVydnZ0a2hhY2QxVUtU?=
 =?utf-8?B?VlVtZkh0RDBZanVZL3ZrWjhvNVRwNkxDK3F4YzZnS251dVY5blpZNmlwSFJR?=
 =?utf-8?B?OHdoR3lOdkRsRjhEZXFtSG1LNm5Ic3poNjRIdVVlcmZsSHhmSjVzbFowN3ZT?=
 =?utf-8?B?TFNsTVlxeFNEZWhGeUE2a0MyVWpJSHRERGdWN0EzYk1SbFZ5THR3TlBSUlV1?=
 =?utf-8?B?UE9YUTkyaVhCdG1WSStYM2Q2NlpVRUVxT1hJbnh2ZExZc3YxK09CaXl6Wjdt?=
 =?utf-8?B?MEtSeEtteVZvc09MQXpFREdRbmRCUnVadk15anJ2b2hHMjVISmlYRUh0MCtp?=
 =?utf-8?B?VkNTY2M1dWZkaUpUOHFXbjNxK3kyQVFnS2IyZks5UlVsai9EM3BvR2NyU1Vj?=
 =?utf-8?B?ajNQREM5V2RhdGtYcEhNT2FRbGhoWDIydjVicXRJQU0zQnIvWm02RWNIdmtL?=
 =?utf-8?B?dFRRb2ErMkZGTzR3VHV0SGlGb1JtOWhQZEpvdmhDNSswZG05M0g0UE1lQnR3?=
 =?utf-8?B?SStFNjNNSjhWUFpHRzFLM3JheXVQdDJkdmV6V1NiYjJZYWVlc2w3a0FLN2ZB?=
 =?utf-8?B?SFFpV3hMS2hrU0R3VFFvQ0ovMlM3R3JMU1N4VFNMbXdadENMcVUxcm1xbEQ3?=
 =?utf-8?B?L0xiaUhIaTlKc0Q3THZqdWg1dFNSdEx1MUtOZWdoS2YyYW5kTG1mZy8yQ2RK?=
 =?utf-8?B?TDFIU09aNWo1Y3dNT1VUZHFCTWlPM2JkZ2tVYUV0ZnJ4YUxhZ1NFY2tkcmtR?=
 =?utf-8?B?bXhHMTdYbWZMWi90ZkUxRXZmaHNZaGZVOXg5KzBVL3B3RFpYSXNDdUxVUytG?=
 =?utf-8?B?SFJOdWsrSHJmem1qTW83THF6ajVaaUxaTXNodnJEcCtBa28vNDc2dkNET2Zu?=
 =?utf-8?B?aHJYNndzdjBXMGdZcUFMWmVWWk9ydDEyTFJWdDMwbGJGamtLRkFDSTZVTld2?=
 =?utf-8?B?STFNUkdKRlRjYU5DY3R5VDE1UXNGcTA5bVlHM0QzVmZzNkhvMVNDa1Vxc0hQ?=
 =?utf-8?B?K1U2cUNFb2wxd01IWUZqQWZ0bmVBVVFaWVc2R0dxYVlGQ1lZc0ZnamsyY0Nl?=
 =?utf-8?B?UVZBV2RyT0RZS3NhT1Q0Yk5lVCs3Ty9DQmRBM2owMC8xdndoRXNaRzVibTMy?=
 =?utf-8?B?eGtIL080c25JTERLam5neXVnWVV6dHpyKzRQUDdKZ1NXdGRWVlhTaUt2VS8z?=
 =?utf-8?B?c29iVC9nSFpXeFducVRBQkxzVGpaYjVRVGhwRTlrWmVVQkhKWjUxU1hEWGhM?=
 =?utf-8?B?NnRMbGZaTG02dzh6VXFJWG1BemY5dWFRVmMrS2MycFEvb05iQ3kwRkJwY2lG?=
 =?utf-8?B?elJrSmRyRDBkenJmVWVDS0laK0lkZVE5ZVh5eEo3ZlZMM0xIaFNUVmhTYTll?=
 =?utf-8?B?bEsrVkUzMmlYLzUzSzNjeFdLWVp2TmpUR0h1UEpOaFFrMVBuSUlGZEtBQU9i?=
 =?utf-8?B?RE5nSjUweEh1RVdMSVVUQm45VkNPckFYVm52bGdscWpYa0R2aUo5MmM4TFBD?=
 =?utf-8?B?Ym5nUmpHcGh5NUhodjhJYURiL0FXZ0xzMEoyYncyeUg5V0E0aUpjbTNDZkNv?=
 =?utf-8?B?c3V0TUdoSndBUzlQdGhuaHcybWhDYnY1VzFPd3NWeGxLeUZWSHFNVEpGY0pZ?=
 =?utf-8?Q?3P9sISRP+o7w8GU92EF61jOmp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0CA18F34A39F24DABE6FF213B68E3F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ec5bd-113a-4ee4-d8e3-08dc22d138b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 02:55:17.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8nzUojsOLlOqEFAeAA6KDBpHnenPXwH10K1sKOUfoAKUEpXuoXuL8v4Sy90ieBIV08J3c5mMs2Vp8ntNkAWs8ZCGrSSjeCJgOLdIx2Zd60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239

T24gMS8zMC8yNCAwMjowNiwgQWxleGlzIExvdGhvcsOpIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEvMjcvMjQgMDE6NDMsIERhdmlkIE1vc2Jl
cmdlci1UYW5nIHdyb3RlOg0KPj4gUHJldmlvdXNseSwgdGhlIGRyaXZlciBjcmVhdGVkIGEgbmV0
IGRldmljZSAodHlwaWNhbGx5IHdsYW4wKSBhcyBzb29uDQo+PiBhcyB0aGUgbW9kdWxlIHdhcyBs
b2FkZWQuICBUaGlzIGNvbW1pdCBjaGFuZ2VzIHRoZSBkcml2ZXIgdG8gZm9sbG93DQo+PiBub3Jt
YWwgTGludXggY29udmVudGlvbiBvZiBjcmVhdGluZyB0aGUgbmV0IGRldmljZSBvbmx5IHdoZW4g
YnVzDQo+PiBwcm9iaW5nIGRldGVjdHMgYSBzdXBwb3J0ZWQgY2hpcC4NCj4gDQo+IEFzIGFscmVh
ZHkgbWVudGlvbmVkIG11bHRpcGxlIHRpbWVzLCBJIGFtIHNrZXB0aWNhbCBhYm91dCB0aGUgdmFs
aWRpdHkgb2YNCj4ga2VlcGluZyBuZXRkZXYgcmVnaXN0cmF0aW9uIGJlZm9yZSBjaGlwIHByZXNl
bmNlIGNoZWNrLCBidXQgSSBhbSBub3QgdGhlDQo+IG1haW50YWluZXIsIHNvIEkgbGV0IEFqYXkg
YW5kIEthbGxlIGRlY2lkZSBmb3IgdGhpcy4gQXNpZGUgZnJvbSB0aGF0LCBhbmQgZnJvbQ0KPiB0
aGUga2FzYW4gd2FybmluZyB3aGljaCBpcyBub3QgZXNwZWNpYWxseSByZWxhdGVkIHRvIHRoZSBz
ZXJpZXMgKGFuZCBub3QNCj4gb2JzZXJ2ZWQgaW4gbm9taW5hbCBjYXNlKSwgSSBzdGlsbCBoYXZl
IGEgZmV3IG1pbm9yIGNvbW1lbnRzIGJlbG93DQo+IA0KDQpJTU8gdGhlIG9yZGVyIG9mIG5ldGRl
diByZWdpc3RyYXRpb24gYmVmb3JlIGNoaXAgdmFsaWRpdHkgc2hvdWxkIGJlDQpmaW5lLiBTaW5j
ZSB3aWxjX2J1c19wcm9iZSgpIGlzIGFscmVhZHkgZG9pbmcgbmV0ZGV2X2NsZWFudXAgdGhhdCB0
YWtlcw0KY2FyZSBvZiBlcnJvcnMgcGF0aCBhZnRlciBuZXRkZXYgcmVnaXN0cmF0aW9uLiBGb3Ig
dGhpcyBwYXRjaCwgaXQgaXMNCm9rYXkgdG8gZm9sbG93IHRoZSBzYW1lIGFwcHJvYWNoIGxpa2Ug
dGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uLg0KDQpIb3dldmVyLCBpbiB0aGUgcGF0Y2gsIHBs
ZWFzZSB0YWtlIGNhcmUgb2YgZGlzYWJsaW5nICd3aWxjLT5ydGNfY2xrJyBpbg0Kd2lsY19idXNf
cHJvYmUoKSBmb3IgdGhlIGZhaWx1cmUgY29uZGl0aW9uLg0KDQpzdGF0aWMgaW50IHdpbGNfYnVz
X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpIHsNCi4uLg0KK3Bvd2VyX2Rvd246DQorICAg
ICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZSh3aWxjLT5ydGNfY2xrKTsNCisgICAgICAgd2lsY193
bGFuX3Bvd2VyKHdpbGMsIGZhbHNlKTsNCiBuZXRkZXZfY2xlYW51cDoNCiAgICAgICAgd2lsY19u
ZXRkZXZfY2xlYW51cCh3aWxjKTsNCg0KDQpJIGhvcGUgdGhpcyBwYXRjaCBpcyB0ZXN0ZWQgZm9y
IGZhaWx1cmUgc2NlbmFyaW8od2hlbiBXSUxDMTAwMCBTUEkNCmRldmljZSBpcyBub3QgY29ubmVj
dGVkKSBhcyB3ZWxsLg0KDQoNCj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIE1vc2Jlcmdlci1UYW5n
IDxkYXZpZG1AZWdhdWdlLm5ldD4NCj4+IC0tLQ0KPj4gY2hhbmdlbG9nOg0KPj4gVjE6IG9yaWdp
bmFsIHZlcnNpb24NCj4+IFYyOiBBZGQgbWlzc2luZyBmb3J3YXJkIGRlY2xhcmF0aW9ucw0KPj4g
VjM6IEFkZCBtaXNzaW5nIGZvcndhcmQgZGVjbGFyYXRpb25zLCBhY3R1YWxseSA6LSgNCj4+IFY0
OiAtIHJlYXJyYW5nZWQgZnVuY3Rpb24gb3JkZXIgdG8gaW1wcm92ZSByZWFkYWJpbGl0eQ0KPj4g
ICAgIC0gbm93IHJlbGF0aXZlIHRvIHdpcmVsZXNzLW5leHQgcmVwb3NpdG9yeQ0KPj4gICAgIC0g
YXZvaWQgY2hhbmdlIGVycm9yIHJldHVybiB2YWx1ZSBhbmQgaGF2ZSBsb3dlci1sZXZlbCBmdW5j
dGlvbnMNCj4+ICAgICAgIGRpcmVjdGx5IHJldHVybiAtRU5PREVWIGluc3RlYWQNCj4+ICAgICAt
IHJlbW92ZWQgYW55IG1lbnRpb24gb2YgV0lMQzMwMDANCj4+ICAgICAtIGV4cG9ydCBhbmQgdXNl
IGV4aXN0aW5nIGlzX3dpbGMxMDAwKCkgZm9yIGNoaXBpZCB2YWxpZGF0aW9uDQo+PiAgICAgLSBy
ZXBsYWNlZCBzdHJib29sKCkgZnVuY3Rpb24gd2l0aCBvcGVuIGNvZGUNCj4+DQo+PiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jIHwgNzQgKysrKysrKysrKysr
KystLS0tLQ0KPj4gIC4uLi9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uYyAg
ICB8ICAzICstDQo+PiAgLi4uL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5o
ICAgIHwgIDEgKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMTkgZGVs
ZXRpb25zKC0pDQo+IA0KPiBbLi4uXQ0KPiANCj4+IEBAIC0xMTQyLDcgKzExNzAsNyBAQCBzdGF0
aWMgaW50IHdpbGNfc3BpX2luaXQoc3RydWN0IHdpbGMgKndpbGMsIGJvb2wgcmVzdW1lKQ0KPj4g
ICAgICAgfQ0KPj4gICAgICAgaWYgKHJldCkgew0KPj4gICAgICAgICAgICAgICBkZXZfZXJyKCZz
cGktPmRldiwgIkZhaWxlZCB3aXRoIENSQzcgb24gYW5kIG9mZi5cbiIpOw0KPj4gLSAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gDQo+
IFlvdSBhcmUgc3RpbGwgcmV3cml0aW5nIGVycm9yIGNvZGVzIGhlcmUuIEF0IGEgbG93ZXIgbGV2
ZWwsIHN1cmUsIGJ1dCBzdGlsbC4uLg0KPiBXaGVuIEkgc3VnZ2VzdGVkIHNldHRpbmcgLUVOT0RF
ViBhdCBsb3dlciBsZXZlbCwgSSB3YXMgdGhpbmtpbmcgYWJvdXQgcGxhY2VzDQo+IHdoZXJlIG5v
IGV4cGxpY2l0IGVycm9yIGNvZGUgd2FzIGFscmVhZHkgaW4gdXNlLCBidXQNCj4gc3BpX2ludGVy
bmFsX3JlYWQvc3BpX2ludGVybmFsX3dyaXRlIGFscmVhZHkgZ2VuZXJhdGUgcHJvcGVyIGVycm9y
IGNvZGVzLiBPciBhbQ0KPiBJIG1pc3NpbmcgYSBjb25zdHJhaW50LCBsaWtlIHRoZSBwcm9iZSBj
aGFpbiByZWFsbHkgbmVlZGluZyAtRU5PREVWID8NCj4gDQo+PiAgICAgICB9DQo+Pg0KPj4gICAg
ICAgLyogc2V0IHVwIHRoZSBkZXNpcmVkIENSQyBjb25maWd1cmF0aW9uOiAqLw0KPj4gQEAgLTEx
NjUsNyArMTE5Myw3IEBAIHN0YXRpYyBpbnQgd2lsY19zcGlfaW5pdChzdHJ1Y3Qgd2lsYyAqd2ls
YywgYm9vbCByZXN1bWUpDQo+PiAgICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICJbd2lsYyBzcGkgJWRdOiBGYWlsZWQgaW50ZXJuYWwgd3Jp
dGUgcmVnXG4iLA0KPj4gICAgICAgICAgICAgICAgICAgICAgIF9fTElORV9fKTsNCj4+IC0gICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+
PiAgICAgICB9DQo+PiAgICAgICAvKiB1cGRhdGUgb3VyIHN0YXRlIHRvIG1hdGNoIG5ldyBwcm90
b2NvbCBzZXR0aW5nczogKi8NCj4+ICAgICAgIHNwaV9wcml2LT5jcmM3X2VuYWJsZWQgPSBlbmFi
bGVfY3JjNzsNCj4+IEBAIC0xMTc2LDE3ICsxMjA0LDI3IEBAIHN0YXRpYyBpbnQgd2lsY19zcGlf
aW5pdChzdHJ1Y3Qgd2lsYyAqd2lsYywgYm9vbCByZXN1bWUpDQo+Pg0KPj4gICAgICAgc3BpX3By
aXYtPnByb2JpbmdfY3JjID0gZmFsc2U7DQo+Pg0KPj4gKyAgICAgcmV0dXJuIDA7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyBpbnQgd2lsY192YWxpZGF0ZV9jaGlwaWQoc3RydWN0IHdpbGMgKndp
bGMpDQo+PiArew0KPj4gKyAgICAgc3RydWN0IHNwaV9kZXZpY2UgKnNwaSA9IHRvX3NwaV9kZXZp
Y2Uod2lsYy0+ZGV2KTsNCj4+ICsgICAgIHUzMiBjaGlwaWQ7DQo+PiArICAgICBpbnQgcmV0Ow0K
Pj4gKw0KPj4gICAgICAgLyoNCj4+ICAgICAgICAqIG1ha2Ugc3VyZSBjYW4gcmVhZCBjaGlwIGlk
IHdpdGhvdXQgcHJvdG9jb2wgZXJyb3INCj4+ICAgICAgICAqLw0KPj4gICAgICAgcmV0ID0gd2ls
Y19zcGlfcmVhZF9yZWcod2lsYywgV0lMQ19DSElQSUQsICZjaGlwaWQpOw0KPj4gICAgICAgaWYg
KHJldCkgew0KPj4gICAgICAgICAgICAgICBkZXZfZXJyKCZzcGktPmRldiwgIkZhaWwgY21kIHJl
YWQgY2hpcCBpZC4uLlxuIik7DQo+PiAtICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4gKyAgICAgfQ0KPj4gKyAgICAgaWYgKCFpc193
aWxjMTAwMChjaGlwaWQpKSB7DQo+PiArICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LCAi
VW5rbm93biBjaGlwIGlkIDB4JXhcbiIsIGNoaXBpZCk7DQo+PiArICAgICAgICAgICAgIHJldHVy
biAtRU5PREVWOw0KPj4gICAgICAgfQ0KPj4gLQ0KPj4gLSAgICAgc3BpX3ByaXYtPmlzaW5pdCA9
IHRydWU7DQo+PiAtDQo+PiAgICAgICByZXR1cm4gMDsNCj4+ICB9DQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5jDQo+PiBpbmRleCA2YjJm
MjI2OWRkZjguLjMxMzBhM2VhOGQ3MSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMNCj4+IEBAIC0xMiwxMCArMTIsMTEgQEANCj4+
DQo+PiAgI2RlZmluZSBXQUtFX1VQX1RSSUFMX1JFVFJZICAgICAgICAgIDEwMDAwDQo+Pg0KPj4g
LXN0YXRpYyBpbmxpbmUgYm9vbCBpc193aWxjMTAwMCh1MzIgaWQpDQo+PiArYm9vbCBpc193aWxj
MTAwMCh1MzIgaWQpDQo+PiAgew0KPj4gICAgICAgcmV0dXJuIChpZCAmICh+V0lMQ19DSElQX1JF
Vl9GSUVMRCkpID09IFdJTENfMTAwMF9CQVNFX0lEOw0KPj4gIH0NCj4+ICtFWFBPUlRfU1lNQk9M
X0dQTChpc193aWxjMTAwMCk7DQo+IA0KPiBuaXQ6IFNpbmNlIHRoZSBmdW5jdGlvbiBpcyBub3Qg
c3RhdGljIGFueW1vcmUsIGl0IHdvdWxkIGhhdmUgYmVlbiBuaWNlIHRvIG1vdmUNCj4gaXQgd2l0
aCB0aGUgb3RoZXIgZXhwb3J0ZWQgZnVuY3Rpb25zIHRvIG1haW50YWluIHRoZSBleGlzdGluZyBm
dW5jdGlvbnMgb3JkZXJpbmcNCj4gDQo+PiAgc3RhdGljIGlubGluZSB2b2lkIGFjcXVpcmVfYnVz
KHN0cnVjdCB3aWxjICp3aWxjLCBlbnVtIGJ1c19hY3F1aXJlIGFjcXVpcmUpDQo+PiAgew0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFu
LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5oDQo+PiBp
bmRleCBmMDI3NzVmN2U0MWYuLmViZGZiMGFmYWY3MSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmgNCj4+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmgNCj4+IEBAIC00MDksNiArNDA5
LDcgQEAgc3RydWN0IHdpbGNfY2ZnX3JzcCB7DQo+Pg0KPj4gIHN0cnVjdCB3aWxjX3ZpZjsNCj4+
DQo+PiArYm9vbCBpc193aWxjMTAwMCh1MzIgaWQpOw0KPj4gIGludCB3aWxjX3dsYW5fZmlybXdh
cmVfZG93bmxvYWQoc3RydWN0IHdpbGMgKndpbGMsIGNvbnN0IHU4ICpidWZmZXIsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgYnVmZmVyX3NpemUpOw0KPj4gIGludCB3aWxj
X3dsYW5fc3RhcnQoc3RydWN0IHdpbGMgKndpbGMpOw0KPiANCj4gLS0NCj4gQWxleGlzIExvdGhv
csOpLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4g
aHR0cHM6Ly9ib290bGluLmNvbQ0KPiANCg0K

