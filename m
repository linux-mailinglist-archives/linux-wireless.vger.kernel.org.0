Return-Path: <linux-wireless+bounces-23718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC78ACE217
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5363A2FF9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E7B339A1;
	Wed,  4 Jun 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmgAjqva"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D7150997
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054008; cv=fail; b=jmiYaR9L0q+/wAyoHacZq2hr6rZBEsalonzdM7OsQMpZauOq5MYAqwOsRD+8valGJRE0zZjagIYCzTOjgEfty1kCiaJNUD/isdil/fHaPgLYasFCgq1ljuNxigoLi0cpqOuvegVdECXlf4sFbZTWAGFmGEljH3rTjTa0P8sL/fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054008; c=relaxed/simple;
	bh=1+tDBb7UrW/R+c6KwI4ja3u7DJQ8ZQrYHjeCOKU4hxw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hkz7UNsfemLtkndDDpIeYtOhe9KhEf/llfivH6ty7asnRNeHxQfo8SJJASwJ5jub4icp27ksVgQix/aKu7O+B5KScvN/qwXwfyzWY9Vc6oxrxDAjjSUc/asVXOyQsb1JexcBTduVYIQv3iJPtPycVYGn7jT9qGsmjEIV3SSPQco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmgAjqva; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749054007; x=1780590007;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=1+tDBb7UrW/R+c6KwI4ja3u7DJQ8ZQrYHjeCOKU4hxw=;
  b=ZmgAjqva5aLe+ik8I4RrvJqpvYA8e/6MKeIEkSJ59iZBtdQKDx7+TTGt
   a0NAL+Y7kCgbrf5TM8zagxASn4eN0G9LEKd8SZV8S2v09goQctY0iPC5W
   zUbdkOVoUKze03MdMH+/xz3ttoTnyWyvH1E3XNiR2M0C1Z4Jm8UOF6d3G
   yjorDaR+X7SPlSdM5cy7WPuUHnTp/d4E78wmCSwBK1nVjOeu3zje24g2F
   NpI18vQh1os6dIJTT7BA60za5VCv3Sc+0KFMm0yg0lU36lfVPzyiuCgHF
   ikA3hwOpr3s8N6rAUwadS9FghP06r+JMpSgDTB/SHNx2S4jzt+Z+gewZW
   w==;
X-CSE-ConnectionGUID: F2/MUIVqRU+6Byd6knBBYg==
X-CSE-MsgGUID: D27EuCpZRa+VUMLtg+vAuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51294615"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51294615"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 09:20:06 -0700
X-CSE-ConnectionGUID: PX4Eh09GQ+OTzu+7qmgWBg==
X-CSE-MsgGUID: WiPparOBQcSn+frE5YpAYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145195430"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 09:20:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 09:20:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 09:20:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.89) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 09:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZz0cBrSmTK+6/YHirlUMgLcUv4ehgqfeZAmW9fk0n6Gqwkb0//HI3d336oZ0Ts2VueNnEqNM1pU5JkuPpkTeBiA0kBRg2jB9Iy3TNY286JduaisIqJT5/ocbCXTmxI/IAHmkB+TRMcaM43tbWJFaONOwrjK8YQ1XKmKaVDVUeqgzilblDsBPZQQrpW+mrpWWNrenE/1FrDhSK2gNaNIycC4y/LVMHI5/fuy+Ke8cvnqpEmH48iTYop3rgSf3yyZM7lJDHhp6ZvBPhehCWkCAfiVmTxojrJtlf4BtY3a7Ggr7m27nCuEDsuMcDVo8/PewNdz2njxOji3D/y08azabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+tDBb7UrW/R+c6KwI4ja3u7DJQ8ZQrYHjeCOKU4hxw=;
 b=n445uiA36ufoaZfOq9H4ZCguoGTHT0xYw7JpU9SS0gc2ldVGmh59hsOVPMEbrwe5hjCBWjyV2opcGjFK7/xaMkZw/a+H6u+uIAYkNnZFxm1VKawyZjRs4TYTR5a4t1dUKdglH9AaOoi601yz0OSKnvdnJnwj330mzkQUwq6bmreLk68mEKwnPJRO9PfC6jCRYj/+fVfaWNyyO7a+BHxUkmvHu3Mo9pomrpP68L7Gk3G7YNByuRDwzIrXd7NfPamyi9k1CrrxqJJeq0WkYq8sAl9K91MZf0yshnnFHn4SH3ija21G4tTlu7LTrqXXP7YM7eXxOa5ILv1fsGn8t7SiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA3PR11MB7463.namprd11.prod.outlook.com
 (2603:10b6:806:304::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 16:19:21 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%4]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 16:19:21 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2025-06-04
Thread-Topic: pull-request: iwlwifi-fixes-2025-06-04
Thread-Index: AdvVbE2qKhwQ7PzDSmSPseJRRPhVqQ==
Date: Wed, 4 Jun 2025 16:19:21 +0000
Message-ID: <DM3PPF63A6024A95B509E4493EA8B8C74B9A36CA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA3PR11MB7463:EE_
x-ms-office365-filtering-correlation-id: 1b352db8-410f-4878-ea41-08dda383904c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0xWRjhVV1BXUE11V1FkQ2ROTkVodXc4N09hRnMrRit6MWIxTjAwLzd6dGF3?=
 =?utf-8?B?eHJJUUNmY0t0RGlJWEtacWhpZ0R3Q0dyNWhYQ1V3emQ2eGcrZG1LeG9jZEU2?=
 =?utf-8?B?akd4SWFwb1A1ZW90TUlRVzl2ZERqZ1BNQ2wzK0t6QzlrWUFsbkdaUDdDMG5z?=
 =?utf-8?B?cmNqM1doVkQ0M2FXSGJ5ZGhWTlNGRkk4RTMzTVhBOTJNS1hPWkVNbG0yckwx?=
 =?utf-8?B?ZVV1NnkyTWl6cFd4Z0ZEMVBQRzFId3hUcnlXZktJM1pGVXc5Zno1Y3dMbUlE?=
 =?utf-8?B?dXZSRGg0Zk93YkMxMGpSTUY3Ymk5VWRUdHdBNzJoQTg0MW5hRzVLSHpzWDNa?=
 =?utf-8?B?dUdXaWc2NlJ3alovRnAyeGhObFRudlYzeWdxUzdmOElXQk9yQjVDRmhyeEt3?=
 =?utf-8?B?UkM2aFpHYXFDc3dlcExxdjZLREI1dUNaZXQ1UXFGa1hUU2taZU5IamJmSjBN?=
 =?utf-8?B?d095YVQyQVpjblpVR3Q3cFlxeG1sS3VRdVZMc25YVFRHV09WTXVKaFVPdjZN?=
 =?utf-8?B?WXR1clNUUjduTkdJbmlPeGN0Y3h3Q2U3NVNuckRtV1F5Q21VclRiRHE1TTBp?=
 =?utf-8?B?M3NNTkxLb0hxaHZTQUlGcHZPTVBEMEg0OW1tWC9Kdzh2UTIzelRpdngwTlR4?=
 =?utf-8?B?c085T0ZNR2RSOU5JdjJvN3RoTHB1Ny9XOEFLK0JqZWhicDRmRkk2ZnB0RjA1?=
 =?utf-8?B?RFh4NzR3a3hxZnphVWRzelhIY0tQeHNlQW85bXBBNWl2SkkyM0N0VnJIbkhB?=
 =?utf-8?B?WFlQNHdXbWEvVWkvMG5mdFJpdmkvSWNnRkw3TFlRaXlBK1pxQU16SUhLRUpF?=
 =?utf-8?B?WWlhMWIvTFM3ZjdoaHRDRWtDMmEyUWNMK3VxVTUwMGhRQ3U0UnF0aVBxcjYz?=
 =?utf-8?B?WE9vNXVkM29LeE5EMkRFNUZub0RjUjdnM1FXQVUra25mOXJhdlZ3Uk5HN2xl?=
 =?utf-8?B?Y2M0NEdSOHdSUGZheTBTdDdRMkVVKzQ2Y1IrVDc0NUxqR2FhVzJoVGxZMGNv?=
 =?utf-8?B?UmQ1S0JYYnA5VXZ4UTdtNW9MSW5FSSt0dTg4TlY0ajVaOW90cHl6UkcwRjlG?=
 =?utf-8?B?K0VXbjFUdy9aTnIxK25oK3ErRlZDMk5JRk96QW0wSEx2T0lzZVBSQ3BCQ2FO?=
 =?utf-8?B?N1JuUFpPMU52ZENiZGdDRFFLQkJERkZsaUhDK2ZOTlN4QTcwNjZncVdhR0R4?=
 =?utf-8?B?WnozWmYyUzZ6S1Y3SlpITHA1R0V5Z3N1UkxHS3ZsYjlESnJGeHlCSWxGVVNu?=
 =?utf-8?B?SHpReXJva3RjaEdNUTRVSlFyRGJ5Q0F0SHJ6dVFodEphZDQ5UlZaVFZTNnJZ?=
 =?utf-8?B?SWVDdHVSdk9uZHJEOVNoRUZSS0hwMkNFVFh2Vzg1U1RBQ3labXU4eUIyNXVO?=
 =?utf-8?B?N1k4bEY4K1pKSTNESUdmNnI4akdNd2pOUzgvSmk2bnZVOWVTMHR2K0NJNzBQ?=
 =?utf-8?B?RmNDTTJOdlZOV3NZWTdRSWh2VnVJdnB4Y3BDOVNqZ0hUd0Z6N1hhQ1kzT252?=
 =?utf-8?B?V2NRVEtpN1Y5OXNQVk9uTXVINkhIQ216WDZKV3Naem81WnY0cTVzUUxwNDVu?=
 =?utf-8?B?czZza1dtUTZPZnRKZit1ZnB3c3JDbGE2QXlVeHBpTERUd2pvR09oN2NsUGFB?=
 =?utf-8?B?dDh0R2Z5eGRoMkVKYlVtaTU5VUtDMEdpRjRQb1ZiVTlEVDhyNXVSdFNuK1NH?=
 =?utf-8?B?OFZvSmNzZHNkZUhZQjFOaHJwYVlIYzc3MDNYSm1hMDNVaktkZGwxemsrMmhm?=
 =?utf-8?B?Q3g1RFRyMmJQb1RjYzlnbHlNOTFGTXVDd3VHTDJuYWUweWpoTUJ3Q0NoM3Yz?=
 =?utf-8?B?TTZpQTU1UmZ2MlhBaHdiVHJMZkNQb3ZSSlBEdGQwZlRCbzhhMzdWSVJZQWZh?=
 =?utf-8?B?UWxKd1QxV1dvRm9WRzhocXNmT01IMVJiR2NIMnlSQjJYTzBCbUpWY2IrM3hv?=
 =?utf-8?B?bUhCdmFrVXhaNVBKdzhOOVk3bm5aK2xSYW1sU3lpNUFDQW9vc0xVdTFCSGNa?=
 =?utf-8?Q?WaqiWbmVjBHMyiuff4AnchD1Da+fhY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzUwK29QSlpmU1lXaXdtUDRiVldRbG5xR2liWjdCaUkrSzEzUkYrY3BXWkla?=
 =?utf-8?B?M3FvOFdQemVKRndHc2VLdDZ1TW5IVndqUnpXdWpzSUxIN2JDcldKV0VTRmNL?=
 =?utf-8?B?dW1LcGJHeG1aOUh3bG5JUXFFd3diYzJjNWhnL1UxMzJRSmRxWmEzZnd2eVB3?=
 =?utf-8?B?VkZqNU1DZ2NhMmxmTlpZdXNoV04rRFVaVHQ0L1lxajRwcmNHSDR2MG80OUJu?=
 =?utf-8?B?SUJaNnlWQWNUN3psNElJOXZleW9MN2ZoZEpqTWljMUVicEh3TjNJeDJaVytj?=
 =?utf-8?B?RjZwckg4VUhueU9oY1JPdlBMak1hNUxoeVd1WjMxQXFzR1JnRWRTWFRWQjM1?=
 =?utf-8?B?RmFBamN6SFV5NlVWZTBEaDE4dVFMQjJPeE1LWU1uZkVlUGxwQzZPWjc2QVAw?=
 =?utf-8?B?OXlxT3h1RzkvdzVVcjNDbjd4S1FIL2tYeDQ3MHBGQ2FPcTNqcmFpUFkxTy9N?=
 =?utf-8?B?QVhBalcwOGZobHN5YUU4d3N0YVFyUDJKOUZrZmFCbkRHZEpkUXQ1K2xGbDdQ?=
 =?utf-8?B?VDJFTTUrdjNnMzNDb05LOVNsZWNrUy90WThCWWZRYXFra25wNTRrZys2Z0lu?=
 =?utf-8?B?UzBsMmc4NTdCMnFpSSswNWtQTmVnOE5pTE5keWFnMEVWeUpRN3p3RGlBRGV2?=
 =?utf-8?B?Sk9tUkYwcHZXNXdBZzhPYzhGem5zZHNlQkZwYXFpQWhoWCtUNFRKTE1MMWZH?=
 =?utf-8?B?TGNobUFGanhrTHE1QnZwc285enBNUTlTaWVqRUptcEd0YWhFeGt5b0xGOUNk?=
 =?utf-8?B?NlRVOCthMHgxWVFyK2pqcDZKNHAzUVpHY0FraExDUmVjUkhaTklUdFNHS2V3?=
 =?utf-8?B?K1EwbzJIUkI5eE83ZzVqRndvZjZQN2tRWDgvYXlJZTl2VXV1QUNXY0xmazIz?=
 =?utf-8?B?RmNjZHBwc00vYWpDZDhmRFlvWTlMZkZSbkhGeHYrb3RkVGpRdTN4SkpwVVFC?=
 =?utf-8?B?OWlNSkZYWWp4TGVGUHhxbHNHWC9PS3ljTHl3VzNXNXIzZHd2akFKWkpnLzJ0?=
 =?utf-8?B?R3F3UVp5SzBmWGJwRUtPL0RGMU1rNGpCZUdSMVYxcFNqSjFpMVcwaS9nNS9R?=
 =?utf-8?B?SXVPZExNWFVHN2FoQmtIZ1pnWVpqS3UwZk9YblFpdFVaK1l3Ky8zbURFc00z?=
 =?utf-8?B?WlprMFFYeVNpbmV2SVFKaHpUZkNiaVZLd0tFZE5rZ1lQNVNqYlhKbkVFS0Zx?=
 =?utf-8?B?UUM2NzhlRitoSDNQSkhrYkNHdnRoZ0UwZU1EZi9hV05YL01FU1hvcUFZQWx3?=
 =?utf-8?B?Q2o2aHprTWtSaHRwSnoyWFQ1VWhGYzRsdFpYUmJLR0hBUUhKZmpSM0FQdFdH?=
 =?utf-8?B?SU9pWE9lT0ZpN3JQckFTc0NIRlBJSDNuSzVNYUZ2NHVpa3hzeC8yakdHYVdq?=
 =?utf-8?B?Um1sQVlXREszbDBYaHR2ZnFzRE5qSGZmQ0tOblNWbmtyRi9lSmJNWjVWZ3R1?=
 =?utf-8?B?VlFMM2pjRXN3WGJtRzVQQ3lMUkoxdTdGc1IzOHJ0S0JUeXV1Q1NqYkpDVEtl?=
 =?utf-8?B?V1E5VVAzekdqTEltd2ZicW5OZHNtSUl4MUlrR3puOWlVbHg3TEdKUTNmZWtv?=
 =?utf-8?B?L2lzWlVhUzBJczFvdlhVeTlrTk5oYXZtMzI1SUVFQ05SVHl2NDVjNWlmblkw?=
 =?utf-8?B?bERJcEZvMVFNNkZva3VaeVkxMVdacE84cjVCVkhRNHo3ZnFrVzNaU1ZCYTUx?=
 =?utf-8?B?TkRFN1cyMzR4akt2OVp1UG8wOUs3MVVmQVFZOHRRdytwM2UyVS9UcE42NHF6?=
 =?utf-8?B?ZEpxb1NTd1kyL3V3dnVkTmdTR0xPRWI0dFFjTXhYemRoV1ZFTFZjZEN0ODJw?=
 =?utf-8?B?NzRtS0tVWjVCVjRQY3QycFlFSFZKcHFIWnEzOXIrRnR6ZWhVbXk3bFFSVkVt?=
 =?utf-8?B?YnNEQ3Zqa3I3eEtpSHJzdTFKSWtsU0hkVHhISnFBa0dGZGREWmU2aDVQbUo0?=
 =?utf-8?B?Mk91d0NkdWd2dURObndNaHZPRWR5OWVlRCt0UkhOUkpGY3JEQTlMQ3UxalRX?=
 =?utf-8?B?TCtDYTM2anFIaXNDamVWSFo2Wk5lVE95eFp4Y1RLcHZIa2pOUTRXYzZCSUt3?=
 =?utf-8?B?NWE4KzQxS0xnbUtZNFZjcHRlaHVsS3BrQUVLRHBVNmNTTGdDMmNqRFpaOWVG?=
 =?utf-8?B?ekdkTjcxN2hiZmVvLzgzZ1dwYUNwSklLZEY0TEYrb3pOMGljd3hEaHByM1RJ?=
 =?utf-8?B?T0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b352db8-410f-4878-ea41-08dda383904c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 16:19:21.3363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMDvTM7/UqJaD8eATFgE6z+nd81AZlo+MtJB5uumXb7QEM2iUgPvhwvr5thhfSf8uEohNf72ifYfjOyJu3cEGKJ4tnjgGofrx6SwKnuZre/BFWF8RceGiZNV4DBih55u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAxYjk4ZjM1N2RhZGQ2ZWE2MTNhNDM1
ZmJhZWYxYTVkZDdiMzVmZDIxOg0KDQogIE1lcmdlIHRhZyAnbmV0LW5leHQtNi4xNicgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQtbmV4
dCAoMjAyNS0wNS0yOCAxNToyNDozNiAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMt
MjAyNS0wNi0wNA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZjgxYWE4MzRiZmE5
MWM4MjdmMjkwYjYyYTI0NWUyM2M1YWQyODEzYzoNCg0KICB3aWZpOiBpd2x3aWZpOiBtbGQ6IE1v
dmUgcmVndWxhdG9yeSBkb21haW4gaW5pdGlhbGl6YXRpb24gKDIwMjUtMDYtMDQgMTk6MDc6MjEg
KzAzMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCml3bHdpZmkgZml4ZXMNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSWxhbiBQZWVyICgx
KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogTW92ZSByZWd1bGF0b3J5IGRvbWFpbiBpbml0
aWFsaXphdGlvbg0KDQpKb2hhbm5lcyBCZXJnICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHBj
aWU6IGZpeCBub24tTVNJWCBoYW5kc2hha2UgcmVnaXN0ZXINCg0KTWlyaSBLb3JlbmJsaXQgKDIp
Og0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBmaXggYXNzZXJ0IG9uIHN1c3BlbmQNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1sZDogYXZvaWQgcGFuaWMgb24gaW5pdCBmYWlsdXJlDQoNCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9mdy5jICAgICAgICAgIHwgOCArKysr
LS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sZC5jICAgICAg
ICAgfCAzICsrLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgw
MjExLmMgICAgfCA0ICsrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3Bj
aWUvdHJhbnMtZ2VuMi5jIHwgMiArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0K

