Return-Path: <linux-wireless+bounces-38285-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FBNrFqA6QmpC2QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38285-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:28:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E677B6D8320
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:27:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Q+/kBTEz";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38285-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38285-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87631302D53B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954533783CC;
	Mon, 29 Jun 2026 09:23:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7C306498;
	Mon, 29 Jun 2026 09:23:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725009; cv=fail; b=H33ZtFAz8z43hRmqq3q/AqaulOR8TidjqKx6az3dwPRBDjoTDHbkEvdvTTXOdNzTh9iOWt2G1z3uj1hp7Bi1rKbw4/AIL3fDiUjkiTe38cNRs80KJmTTFm5u29QT75cnEPfVjCn+YoIj7enZTAMIQ4nwEzEfY0PY0dSto4cmq3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725009; c=relaxed/simple;
	bh=i+hqb+vfXZRmf64u/rPVXlpjHIRQcQZQ5arrMuGH6MU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4BqF147E1/GuVZydShSLX1DEBAEeEZfRm6368dZNTwHfMkJYcV5kto/9wzSKkxoAbT3x9iMc4zHYaKba9DpvoFIeStZUXa+nUlhzkGrE5GDzzUw3WLCrH9SJ00qFGHErjacxzXaRU9MH4K8GISNtcX+fjFZkCANTXqwgX2iXDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+/kBTEz; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782725007; x=1814261007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i+hqb+vfXZRmf64u/rPVXlpjHIRQcQZQ5arrMuGH6MU=;
  b=Q+/kBTEziDKfV+qBGsFYK+cla1YzTfe9nltlSzGTUglwPlnkAnsFPVc0
   Y5L5pE88aasUk6srw1amfPRQeRS4nC3/6fjIPqP/0MYFKIoUcN6XVefGh
   VsS/Ei/iKI0aQ2rgLlErN1IqFgt8CiktqYinULFD/HLZFFobXQwVsEf5s
   CAQ8n7a7JBSvved4UBLZIo49VMqbDNDbycToFjES1F74xQT60HHMpALev
   0jfLTJV8m+9ssc81gAQmCQycqFEY0lbv8uyGuu44zeo0+yJipfjeK7Z1R
   C+rNWebmIX9YxHGcWfac+m2ovbTe6sSmNTN3Hi6QCHsTYh3+Ul3/c+Rgt
   A==;
X-CSE-ConnectionGUID: OG1LMxNyRkea22qCTohzOA==
X-CSE-MsgGUID: FEJr99FBRfyWPqNKlW/hXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="94557808"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="94557808"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 02:23:16 -0700
X-CSE-ConnectionGUID: bTB+AW2HTlqtg0BEyquvNw==
X-CSE-MsgGUID: y8FGlKREQBavulbesyyxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="248544677"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 02:23:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 02:23:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 02:23:15 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 02:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhGviPgQdkxn6eTlBs23znBuj+eJ+yNUqg61ql7cemEEDanlx5MOPro2ztVtwga66ilw7hHQ7GejsRtRJ9BYq6sM04cPkmVWHrMCWyYtzvhdv0NEbhrHxNkPV339HY5JWrELFFajfE+LHwkH8LqEIZf9nsYP6/0naRZcHP0+/x35FtWiUYDUIPAlIHiLuwLUFx2UsarqhFp3vwiI7sc+uqX64HsTVYGeQWsML/9bnl8fmk4WbDBq2NyeZKDjUPzVK1O/obO91+K8crCcwRLGCVnNuJ4wpx0lbiaWqR+CaCd/5MDL8mvvcoZDRxUxQxu1CjvRL2TqCSfDDlFX4oYjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+hqb+vfXZRmf64u/rPVXlpjHIRQcQZQ5arrMuGH6MU=;
 b=W2nC4XkFbQDRl+dRSfOQ+S1qui57odXl2FZWyBm2jAGSJePOj7iFahE8HwROogQozM8d3wQygO9KpYqgPwkxe5bcm/+LQ6kAZ0OXgl4jrGj/DESLI0IufiFjbSOJAALhzsVVH3tCnPtjafZcQOKeNbz1YQznFjxcHacfHXw4NfItKB+lV6kkPRYjeHa86eXKtUSBGXXAoDF8DzQVvZIak6Oy8eLkfLBLQZufjd1YS2ObuElqBHVAoo4u9k5ztq8aVYJw+kEfKj5izCmQubMZeTj329rUUg+FEcchQun4Jv1w/TZpJad9Ks01cbc57hbzarHS5J8bcc562QydM1zPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:23:07 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:23:07 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Ulf Hansson
	<ulfh@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
	<jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao
	<quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Srinivas Kandagatla
	<srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Saravana Kannan
	<saravanak@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, Bartosz Golaszewski
	<bartosz.golaszewski@oss.qualcomm.com>
Subject: RE: [PATCH v6 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Thread-Topic: [PATCH v6 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Thread-Index: AQHdB6WiH1Z4NcSkJUWT9KMiTf7/trZVQPVA
Date: Mon, 29 Jun 2026 09:23:07 +0000
Message-ID: <PH7PR11MB5983F94CEA966F037C4E768CF3E82@PH7PR11MB5983.namprd11.prod.outlook.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-7-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-7-f02513dcd46d@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|PH7PR11MB6794:EE_
x-ms-office365-filtering-correlation-id: 72291064-b5b7-49c2-c90b-08ded5c007ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: zI1/EHGgKOwqIsHcuoKNroHYiGwOsh/ZX1UWxqLAczY5VIHf4VygvqbDKV4re71RKxiAtsZtNP0Rv1AHIvKxEnQYeitqhH7/3iIMBQcNkdzj/Wnm4Atyc+PKZKBgs7Bh/Q+6fVmnkBwf1uAFWsQ9k1JYFNyIKBr2V2MAYF4gFc1srrLyqU3X5wHiFqZw5vFxPnWTJVyGT1Dg98DSsYRszlEKrN/2Zikn/HY4Qv3QMeU2GJiz2xH05rIt/212Bk8f9AVj1qigXGjmw0402W1LbO3lLm555j9kydzOGGeZRhzCWrwchqiV9V211YxCgdRhKAloEb9Yg05QOgzj5p1ONIUEu4dtmeJx0yvJVoN858RSatGX6e3aB59Ew4YPaI3cvFdoTiT5MmtRj9iNaSJjKuv8EfD6Twd9OiNaDrkFhG2pWVRVYmY8TV0wb+Y93oQYMB1PQtJIAd5wMprQ2My8jHOPfmxtQ6rjRuNLlkJCwbmgh/ScQm29ph28pTOKol2XybVbdNLtooNpsDPN0cOieb4Q42xtYO/cq5wH/faAf4GJOlEhxqNluC/cCLP1WubSfoBcV1XDTELyx1flfEUsiNpFNcvNXn9VDkv84J//s4ZLE9AXutk1m1B/VNCvFONIOpt67hCkgFHbg/JuaYHz7FzRJES7H8W8Jg/m5wamc4pPOXOFa+bxfFB50Av4zI1k+o4FMgCGlxW+IKqNNgouKlBIgCeC4CnyDEniOR49g+w4KReFwpjn+rSLr2EZa9oS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0tsalBEa2ZoWEl1dGh4UWFxeFdpZEJTU1pNTnl1a29ZQ1FBcGZOYXlkcnhm?=
 =?utf-8?B?SFlVNHUvanM0UURuUG1GVkU2eURaZmhlNEM2VE5STkU0QTNkZXQ3NC8xWE00?=
 =?utf-8?B?TCtNSWo2VFd0dzRKRDY1OE9SVE95QXZHZ2lkYXJBRllqUnVaME9sMURMZjEr?=
 =?utf-8?B?QktDbDlKZWRoOTA0QlVsNFBCREpLYWtqeHFxOHVDS25jMTNDUXhzeitSeDdk?=
 =?utf-8?B?RFJWNXRJTHltcDkzR0d1dXdPWGR6Y0ZicDNiNW8rVW0vVVE0Q3YzS1pZUm5K?=
 =?utf-8?B?enk5Ym1KcmxCOS9ONTlhT0wxcEJxRkhTcnVEMi9Rck8xVlJkQUZsY1IvZU1Z?=
 =?utf-8?B?QXp2aFhDdnZzbk8xVkxBNDg3Z0YvVHlYT3hyUE9JVGpvR3l5UnhuN0J6b2Js?=
 =?utf-8?B?QWxXaTZnby9vM1VpU3lZb215aUFVOEhoN0p2VURNMjRuaEpWaXZCbVU5eWw4?=
 =?utf-8?B?OTVyZkRXRGpyOWZaQndSMEZIMHdnbUZNWmJpK3F4c2NtZUg5ZEtKdk5nWDJG?=
 =?utf-8?B?Z2VhVGF2R2JwUmg3cFJ2aGFSRDgxZ2d0MUQwY2xrbE9zQVM4VlRjMk14STgr?=
 =?utf-8?B?RzhHRHMrOW52SFZDU0l2bEpiQVJMSnBvbXZPZ2lkcmRMbHl3N2sxRnBxdVlj?=
 =?utf-8?B?Snd2UVFIQ3p5VU04REVSdEFRRlZZUjc0RDNGTG8wbmFsMHRXd2M1eEtvVzVM?=
 =?utf-8?B?VzcyMUdjQ2JGRVB2VVpIMjZEc1ZSQmZXTktTbmRSZjFqTGFGbFI0SE5ZdlFh?=
 =?utf-8?B?VlNjMmFkWm9BM0hHdmVsU0ZvNHVMRXExNmRRTHNwWGwvQ21IbnEwK09oS2pN?=
 =?utf-8?B?d2daZGpnNFllZ0FWNW9taEcrOCtMZTBJdVJaT3dVa3pSc0NTalprNDlDb1d2?=
 =?utf-8?B?cGdBdEw1clN2UnptVUFzeXZKWVNlN1lWTHVHM0x2amFXWGJaYWUwcGhEK2Ro?=
 =?utf-8?B?VlVLbFp0ZFdKN2Y5ZGJyTDcrcWxrYWxZRjlyd1FsakNvYjBkd0MyTElBYS85?=
 =?utf-8?B?V2cxTHNFUW8xMlU3NTJWeERDcEZmNU5vNjZYR0JlaVFiT2tYb05ETllIWXRi?=
 =?utf-8?B?TE9lSjdEY1YzZFZlblh4VUIyOE9KcGpSdFFod21oUnQ0M0FkZE1qWUFJU2pB?=
 =?utf-8?B?V0ZlM0VtVXNIdkZKczBOSEo5WU5vVzRwT2pTZXV4cTl3T2U1R2pPeXR3WWZS?=
 =?utf-8?B?N0N3b1NTMHp2RjlyOFZ4bTlzdlRxOVc0OEtHdjdaZVFTSzB5UzJENm1CRCtF?=
 =?utf-8?B?UGZZRmtIb1YwYy80UjBldDhyd1JGMmZEam5YaEFSS2V5ZVVNSGtOL2VWZkhi?=
 =?utf-8?B?NlpnamY2MXZXWlhLNzlJbTJ0THJWVUhqZUNPbVVMNm8rSUJPMmhOSHJTaTc1?=
 =?utf-8?B?SEI4NE9BTFNMYm5RWmdsSjhRNFlhSll2cFhpQ0tnSDJ2Y3g5K1JNRVVOZjIw?=
 =?utf-8?B?QThqR016bDZVLzIrZWxXU2ozTWJPRnFkSlBIRVluaW9uR1FnMHpQRmJMUDl1?=
 =?utf-8?B?RnM5Y1NoSHVQN0xUU1ZEM2o3eCsxVVZNUzNKTVZqaWk4TmNDZzlSVVlMZURW?=
 =?utf-8?B?RXo3eVBOYk9iM1BMV2dMcU02UU5vRzNQcXdhcDM1dkkvNnl4dkMrUjI0ZTcw?=
 =?utf-8?B?dTJUb2lyVVh4VmlkdlZ5ZWE0eXl6SUV6SkU1cVNlTlRmVE02NFN2QkZ5SGJy?=
 =?utf-8?B?SEd3cm1TMERvQnJXTVNwbERpL08zV3hDVWJKQ084VituYksrRGVDWkljZ0pQ?=
 =?utf-8?B?YlYzWDc1SVVqRThoUzQ3V1pWcUdWemd4YmlJQ0syZE1WL2IxTzkzWEh4NGc1?=
 =?utf-8?B?M3JsdnA0RmgvOFJzcVZ1aXVyZm5oL0N4R0hORWpjTkVsZzM2WGZvaEloa1NW?=
 =?utf-8?B?Tmc3UEdIY0ZxeEFpbFBQN1RhY3FUNkxsdWxLcDZmNGJlQkErVGVpbG5LRVNv?=
 =?utf-8?B?N1JNbGFPQUFhZTlrekpRdkV5ZmlRNnNNM1ZvdTN1THgzbDJJQ3UyTjhYOUE2?=
 =?utf-8?B?WVZlM0ZOTGxqbS9UeGU0dTZ0WlVOMFpBUVhzYkROODhOQ3dQTHB6SUQxMTh5?=
 =?utf-8?B?ZmpNbnR6YmhvYzdjTVNvcXM5RDlRU21XNWtoS3JUZGk3SER0bUhlTXdnVmxi?=
 =?utf-8?B?aE9qb09pRHMyZDJZaDJwMElreHMyQmFFYzZWL0VYU2RzOXc2N0lyMFVqZDZ0?=
 =?utf-8?B?T1g0bmxobUIrYVIvNlpXc1Npa1orV3FrNmJ0T2xEZVl1dlRVOGVOYW91YjdR?=
 =?utf-8?B?anl6QzRGYVFIQ0ZXZDNWTHhoQm5NMmY2NW1xdU9IQnptc0xJSVRodGhJa2ZF?=
 =?utf-8?B?Q2lCSGRka0RMaTZsTVlCbXowMmdYdENOVm9PVWtkdXR0UHdNUlJidz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qvVrWz5XerbFDNnK6p59W7N19WZRg2ZLPLOF4dxsFEHL7CQ/K7cOfiR8d5/vDOmCeOCOa3PLy9uHN9niAzf38bQyv999XzikYh9LgVLDLblWI3lF0keEHTrKpqNq9OT3xIywfBv+ZZUCJQSZ6rkYiqt5P07Fisv0ueeqw4aUGcy08rFvRA2HMxi8fScBpfRK3woLDO/7PdeSkNKJjvHzHAfPacX0FcR48yka9e+hpTsPDqXWImwZS3DBIiZXEEzjMiy1MfAz7E6qnjDqnbwDcI2Uy7p3/qTmXz3mm9pOLrZAIP6r8CVj3Az+mg5Lv3gykyVhfFY6FU7wJGU2lX2tvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72291064-b5b7-49c2-c90b-08ded5c007ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 09:23:07.2340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3RcP8xjsUZ6LzsTw3nn7Qwfh6JgLVvUzBhZNs/RA3zIIKLTmFJQZ/slFUvHjjW5ipGf/b+Lfp/Kayc/CfeqmcRZCwGv7wYHTfKv5Z1h3yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38285-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[piotr.kwapulinski@intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E677B6D8320

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTG9pYyBQb3VsYWluIDxsb2ljLnBv
dWxhaW5Ab3NzLnF1YWxjb21tLmNvbT4gDQo+U2VudDogTW9uZGF5LCBKdW5lIDI5LCAyMDI2IDEw
OjU1IEFNDQo+VG86IFVsZiBIYW5zc29uIDx1bGZoQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgQmpvcm4gQW5kZXJzc29uIDxh
bmRlcnNzb25Aa2VybmVsLm9yZz47IEtvbnJhZCBEeWJjaW8gPGtvbnJhZHliY2lvQGtlcm5lbC5v
cmc+OyBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+OyBKb2hhbm5lcyBCZXJnIDxqb2hhbm5l
c0BzaXBzb2x1dGlvbnMubmV0PjsgSmVmZiBKb2huc29uIDxqam9obnNvbkBrZXJuZWwub3JnPjsg
QmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBrZXJuZWwub3JnPjsgTWFyY2VsIEhvbHRtYW5uIDxt
YXJjZWxAaG9sdG1hbm4ub3JnPjsgTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBn
bWFpbC5jb20+OyBCYWxha3Jpc2huYSBHb2RhdmFydGhpIDxxdWljX2Jnb2RhdmFyQHF1aWNpbmMu
Y29tPjsgUm9ja3kgTGlhbyA8cXVpY19yamxpYW9AcXVpY2luYy5jb20+OyBEYXZpZCBTLiBNaWxs
ZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5j
b20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVu
aUByZWRoYXQuY29tPjsgU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgU3Jpbml2YXMg
S2FuZGFnYXRsYSA8c3JpbmlAa2VybmVsLm9yZz47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5j
aD47IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcg
PGxpbnV4QGFybWxpbnV4Lm9yZy51az47IFNhcmF2YW5hIEthbm5hbiA8c2FyYXZhbmFrQGtlcm5l
bC5vcmc+OyBDaHJpc3RpYW4gTWFyYW5naSA8YW5zdWVsc210aEBnbWFpbC5jb20+DQo+Q2M6IGxp
bnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmc7IGF0aDEwa0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJu
ZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYW5pZWxAbWFrcm90b3BpYS5vcmc7IExv
aWMgUG91bGFpbiA8bG9pYy5wb3VsYWluQG9zcy5xdWFsY29tbS5jb20+OyBCYXJ0b3N6IEdvbGFz
emV3c2tpIDxiYXJ0b3N6LmdvbGFzemV3c2tpQG9zcy5xdWFsY29tbS5jb20+DQo+U3ViamVjdDog
W1BBVENIIHY2IDcvOV0gQmx1ZXRvb3RoOiBoY2lfc3luYzogQWRkIE5WTUVNLWJhY2tlZCBCRCBh
ZGRyZXNzIHJldHJpZXZhbA0KPg0KPlNvbWUgZGV2aWNlcyBzdG9yZSB0aGUgQmx1ZXRvb3RoIEJE
IGFkZHJlc3MgaW4gbm9uLXZvbGF0aWxlIG1lbW9yeSwgd2hpY2ggY2FuIGJlIGFjY2Vzc2VkIHRo
cm91Z2ggdGhlIE5WTUVNIGZyYW1ld29yay4NCj5TaW1pbGFyIHRvIEV0aGVybmV0IG9yIFdpRmkg
TUFDIGFkZHJlc3NlcywgYWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcgdGhlIEJEIGFkZHJlc3MgZnJv
bSBhICdsb2NhbC1iZC1hZGRyZXNzJyBOVk1FTSBjZWxsLg0KPg0KPkFzIHdpdGggdGhlIGRldmlj
ZS10cmVlIHByb3ZpZGVkIEJEIGFkZHJlc3MsIGFkZCBhIHF1aXJrIHRvIGluZGljYXRlIHdoZXRo
ZXIgYSBkZXZpY2Ugb3IgcGxhdGZvcm0gc2hvdWxkIGF0dGVtcHQgdG8gcmVhZCB0aGUgYWRkcmVz
cyBmcm9tIE5WTUVNIHdoZW4gbm8gdmFsaWQgaW4tY2hpcCBhZGRyZXNzIGlzIHByZXNlbnQuDQo+
QWxzbyBhZGQgYSBxdWlyayB0byBpbmRpY2F0ZSBpZiB0aGUgYWRkcmVzcyBpcyBzdG9yZWQgaW4g
YmlnLWVuZGlhbiBieXRlIG9yZGVyLg0KPg0KPlJldmlld2VkLWJ5OiBCYXJ0b3N6IEdvbGFzemV3
c2tpIDxiYXJ0b3N6LmdvbGFzemV3c2tpQG9zcy5xdWFsY29tbS5jb20+DQo+U2lnbmVkLW9mZi1i
eTogTG9pYyBQb3VsYWluIDxsb2ljLnBvdWxhaW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4tLS0NCj4g
aW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIHwgMTggKysrKysrKysrKysrKysrKysrDQo+IG5l
dC9ibHVldG9vdGgvaGNpX3N5bmMuYyAgICB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIGIv
aW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIGluZGV4IDU3MmIxYzYyMGM1ZDY1M2ExZmUxMGIy
NmMxYjBiYTMzZThmNDk2OGYuLjc2ODY0NjZkMTEwOTI1M2IwZDc1ZWRlYjVmNmE5OWZiOThjZTRj
YzYgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oDQo+KysrIGIvaW5j
bHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oDQo+QEAgLTE2NCw2ICsxNjQsMjQgQEAgZW51bSB7DQo+
IAkgKi8NCj4gCUhDSV9RVUlSS19CREFERFJfUFJPUEVSVFlfQlJPS0VOLA0KPiANCj4rCS8qIFdo
ZW4gdGhpcyBxdWlyayBpcyBzZXQsIHRoZSBwdWJsaWMgQmx1ZXRvb3RoIGFkZHJlc3MNCj4rCSAq
IGluaXRpYWxseSByZXBvcnRlZCBieSBIQ0kgUmVhZCBCRCBBZGRyZXNzIGNvbW1hbmQNCj4rCSAq
IGlzIGNvbnNpZGVyZWQgaW52YWxpZC4gVGhlIHB1YmxpYyBCRCBBZGRyZXNzIGNhbiBiZQ0KPisJ
ICogcmV0cmlldmVkIHZpYSBhICdsb2NhbC1iZC1hZGRyZXNzJyBOVk1FTSBjZWxsLg0KPisJICoN
Cj4rCSAqIFRoaXMgcXVpcmsgY2FuIGJlIHNldCBiZWZvcmUgaGNpX3JlZ2lzdGVyX2RldiBpcyBj
YWxsZWQgb3INCj4rCSAqIGR1cmluZyB0aGUgaGRldi0+c2V0dXAgdmVuZG9yIGNhbGxiYWNrLg0K
PisJICovDQo+KwlIQ0lfUVVJUktfVVNFX0JEQUREUl9OVk1FTSwNCj4rDQo+KwkvKiBXaGVuIHRo
aXMgcXVpcmsgaXMgc2V0LCB0aGUgQmx1ZXRvb3RoIERldmljZSBBZGRyZXNzIHByb3ZpZGVkIGJ5
DQo+KwkgKiB0aGUgJ2xvY2FsLWJkLWFkZHJlc3MnIE5WTUVNIGlzIHN0b3JlZCBpbiBiaWctZW5k
aWFuIG9yZGVyLg0KPisJICoNCj4rCSAqIFRoaXMgcXVpcmsgY2FuIGJlIHNldCBiZWZvcmUgaGNp
X3JlZ2lzdGVyX2RldiBpcyBjYWxsZWQgb3INCj4rCSAqIGR1cmluZyB0aGUgaGRldi0+c2V0dXAg
dmVuZG9yIGNhbGxiYWNrLg0KPisJICovDQo+KwlIQ0lfUVVJUktfQkRBRERSX05WTUVNX0JFLA0K
PisNCj4gCS8qIFdoZW4gdGhpcyBxdWlyayBpcyBzZXQsIHRoZSBkdXBsaWNhdGUgZmlsdGVyaW5n
IGR1cmluZw0KPiAJICogc2Nhbm5pbmcgaXMgYmFzZWQgb24gQmx1ZXRvb3RoIGRldmljZXMgYWRk
cmVzc2VzLiBUbyBhbGxvdw0KPiAJICogUlNTSSBiYXNlZCB1cGRhdGVzLCByZXN0YXJ0IHNjYW5u
aW5nIGlmIG5lZWRlZC4NCj5kaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jIGIv
bmV0L2JsdWV0b290aC9oY2lfc3luYy5jIGluZGV4IGZkM2FhY2RlYTUxMmEzN2MyMmI5YTJiZTkw
Yzg5ZGRjYTRiNGQ5OWYuLjU4OWNjZGZhMjZjMTI4MWQ2ZWI5NzkzNzA1MjNmZmYwZDc5MjAzMDIg
MTAwNjQ0DQo+LS0tIGEvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jDQo+KysrIGIvbmV0L2JsdWV0
b290aC9oY2lfc3luYy5jDQo+QEAgLTcsNiArNyw3IEBADQo+ICAqLw0KPiANCj4gI2luY2x1ZGUg
PGxpbnV4L3Byb3BlcnR5Lmg+DQo+KyNpbmNsdWRlIDxsaW51eC9vZl9uZXQuaD4NCj4gDQo+ICNp
bmNsdWRlIDxuZXQvYmx1ZXRvb3RoL2JsdWV0b290aC5oPg0KPiAjaW5jbHVkZSA8bmV0L2JsdWV0
b290aC9oY2lfY29yZS5oPg0KPkBAIC0zNTg4LDYgKzM1ODksMzcgQEAgaW50IGhjaV9wb3dlcmVk
X3VwZGF0ZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPiAJcmV0dXJuIDA7DQo+IH0NCj4g
DQo+Ky8qKg0KPisgKiBoY2lfZGV2X2dldF9iZF9hZGRyX2Zyb21fbnZtZW0gLSBHZXQgdGhlIEJs
dWV0b290aCBEZXZpY2UgQWRkcmVzcw0KPisgKgkJCQkgICAgKEJEX0FERFIpIGZvciBhIEhDSSBk
ZXZpY2UgZnJvbQ0KPisgKgkJCQkgICAgYW4gTlZNRU0gY2VsbC4NCj4rICogQGhkZXY6CVRoZSBI
Q0kgZGV2aWNlDQo+KyAqDQo+KyAqIFNlYXJjaCBmb3IgJ2xvY2FsLWJkLWFkZHJlc3MnIE5WTUVN
IGNlbGwgaW4gdGhlIGRldmljZSBmaXJtd2FyZSBub2RlLg0KPisgKg0KPisgKiBBbGwtemVybyBC
RCBhZGRyZXNzZXMgYXJlIHJlamVjdGVkICh1bnByb3Zpc2lvbmVkKS4NClBsZWFzZSBhZGQgcmV0
dXJuIHZhbHVlIGRlc2NyaXB0aW9uIGFuZA0KUmV2aWV3ZWQtYnk6IFBpb3RyIEt3YXB1bGluc2tp
IDxwaW90ci5rd2FwdWxpbnNraUBpbnRlbC5jb20+DQpUaGFuayB5b3UuDQpQaW90cg0KDQo+KyAq
Lw0KPitzdGF0aWMgaW50IGhjaV9kZXZfZ2V0X2JkX2FkZHJfZnJvbV9udm1lbShzdHJ1Y3QgaGNp
X2RldiAqaGRldikgew0KPisJc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldl9vZl9ub2RlKGhk
ZXYtPmRldi5wYXJlbnQpOw0KPisJdTggYmFbc2l6ZW9mKGJkYWRkcl90KV07DQo+KwlpbnQgZXJy
Ow0KPisNCj4rCWlmICghbnApDQo+KwkJcmV0dXJuIC1FTk9ERVY7DQo+Kw0KPisJZXJyID0gb2Zf
Z2V0X252bWVtX2V1aTQ4KG5wLCAibG9jYWwtYmQtYWRkcmVzcyIsIGJhKTsNCj4rCWlmIChlcnIp
DQo+KwkJcmV0dXJuIGVycjsNCj4rDQo+KwlpZiAoaGNpX3Rlc3RfcXVpcmsoaGRldiwgSENJX1FV
SVJLX0JEQUREUl9OVk1FTV9CRSkpDQo+KwkJYmFzd2FwKCZoZGV2LT5wdWJsaWNfYWRkciwgKGJk
YWRkcl90ICopYmEpOw0KPisJZWxzZQ0KPisJCWJhY3B5KCZoZGV2LT5wdWJsaWNfYWRkciwgKGJk
YWRkcl90ICopYmEpOw0KPisNCj4rCXJldHVybiAwOw0KPit9DQo+Kw0KPiAvKioNCj4gICogaGNp
X2Rldl9nZXRfYmRfYWRkcl9mcm9tX3Byb3BlcnR5IC0gR2V0IHRoZSBCbHVldG9vdGggRGV2aWNl
IEFkZHJlc3MNCj4gICoJCQkJICAgICAgIChCRF9BRERSKSBmb3IgYSBIQ0kgZGV2aWNlIGZyb20N
Cj5AQCAtNTA0MiwxMiArNTA3NCwxNyBAQCBzdGF0aWMgaW50IGhjaV9kZXZfc2V0dXBfc3luYyhz
dHJ1Y3QgaGNpX2RldiAqaGRldikNCj4gCSAqIGl0cyBzZXR1cCBjYWxsYmFjay4NCj4gCSAqLw0K
PiAJaW52YWxpZF9iZGFkZHIgPSBoY2lfdGVzdF9xdWlyayhoZGV2LCBIQ0lfUVVJUktfSU5WQUxJ
RF9CREFERFIpIHx8DQo+LQkJCSBoY2lfdGVzdF9xdWlyayhoZGV2LCBIQ0lfUVVJUktfVVNFX0JE
QUREUl9QUk9QRVJUWSk7DQo+KwkJCSBoY2lfdGVzdF9xdWlyayhoZGV2LCBIQ0lfUVVJUktfVVNF
X0JEQUREUl9QUk9QRVJUWSkgfHwNCj4rCQkJIGhjaV90ZXN0X3F1aXJrKGhkZXYsIEhDSV9RVUlS
S19VU0VfQkRBRERSX05WTUVNKTsNCj4gCWlmICghcmV0KSB7DQo+IAkJaWYgKGhjaV90ZXN0X3F1
aXJrKGhkZXYsIEhDSV9RVUlSS19VU0VfQkRBRERSX1BST1BFUlRZKSAmJg0KPiAJCSAgICAhYmFj
bXAoJmhkZXYtPnB1YmxpY19hZGRyLCBCREFERFJfQU5ZKSkNCj4gCQkJaGNpX2Rldl9nZXRfYmRf
YWRkcl9mcm9tX3Byb3BlcnR5KGhkZXYpOw0KPiANCj4rCQlpZiAoaGNpX3Rlc3RfcXVpcmsoaGRl
diwgSENJX1FVSVJLX1VTRV9CREFERFJfTlZNRU0pICYmDQo+KwkJICAgICFiYWNtcCgmaGRldi0+
cHVibGljX2FkZHIsIEJEQUREUl9BTlkpKQ0KPisJCQloY2lfZGV2X2dldF9iZF9hZGRyX2Zyb21f
bnZtZW0oaGRldik7DQo+Kw0KPiAJCWlmIChpbnZhbGlkX2JkYWRkciAmJiBiYWNtcCgmaGRldi0+
cHVibGljX2FkZHIsIEJEQUREUl9BTlkpICYmDQo+IAkJICAgIGhkZXYtPnNldF9iZGFkZHIpIHsN
Cj4gCQkJcmV0ID0gaGRldi0+c2V0X2JkYWRkcihoZGV2LCAmaGRldi0+cHVibGljX2FkZHIpOw0K
Pg0KPi0tDQo+Mi4zNC4xDQo+DQo=

