Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C936C324A47
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 06:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBYF5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 00:57:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18745 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBYF5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 00:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614232657; x=1645768657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cEpTDZ/6rtwILkmTWfxX4g5aUOb/pTNNQxPQFS9bgyQ=;
  b=qy7ojJdd4qKMM5bu7c6lQft+Bkm0W9saCcPRAtTBmf/rtv6IpN4ZruB+
   t8frTHfYJ68T/gGcvm1yM/EHwx8fiPllMAByYB0gJjXFNftHX47AZepob
   vi+9XV29wh18Xf3bDDt+GnbabfU8n6+x6G5X/0k9H0H0uyJscNVAXDzea
   FxAUUSaLcRLTy67OB5OXDqVZKXyCKgFRilfZ/F4dGs3Gr9FUbCjxp1797
   NqSbpNobaUnMyEKEgtPREWYx7IEF02n3O/9ZoUsbEQ7IKLn+eC9pDHzSV
   CS7TUkDml7OW2LtRkrazKRIGoqEgKK25MZ5Cpg6n1zmn9bfFFR0TfWdCN
   Q==;
IronPort-SDR: Zln1ffFrFM8Dkg7fqm4dx6KZltukkYePef68jL8ZY4XXQ17wl/ryUxYskhei2JCI5Rx1tByley
 OZ4/+SjPM70ssTM80e1MdaGedVSwPOuEkBaxl3+A2PhTtT91gk3iPEiYFOCJ88CHd0Z0gk1t+W
 OnkyHGo7dYLV4hkSArhEb7PNnl41JVTAtiTOh2AT8Bf68TxzNOilFE+QAqO5EcdNNJoF9m/egt
 gGUd0Q7B+1mjPIg/7Ercu2X/eMjf7zdbd9aH6xw4juJWBBhCQUIWCciqiRqC/jcojR60g33kkE
 8KA=
X-IronPort-AV: E=Sophos;i="5.81,203,1610434800"; 
   d="scan'208";a="116558784"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 22:56:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 22:56:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 24 Feb 2021 22:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msTYzYgopC9dlllXK5ONWRKExF80+7FnjPXY/eOYYRzzgdpfzRr3/hPtFQd0CMTCxaoAtEtnqZuDlf48p2BA0+6Y5sn1Qm81TD3aWDqfnqg/zSpviBsK7svfU9x3b51yifbUFHC4hi96KvF+tO9tlLvL9t7Dhny70i9C+8BCbzVBHv8P4wF2dRGaWnRG2tLJExBJ6AFdr54g8lMQr3NT5pKO9I6/uMZA22JmB894u63HP6fI647UtVG7hQ41tR9bRce5yhq/YbDdp8eKgsqIt4Ljxweoc8C9evtXlOHhn1Bmgbo72fyEMa+BWswJ8uPTmoTYEITPiFB1dZs13YmO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEpTDZ/6rtwILkmTWfxX4g5aUOb/pTNNQxPQFS9bgyQ=;
 b=VlrfYtrqaSuyOi4Zg2ODH3gl62jpjgpZFtHPAkYDLPQUgTP7PEcUqbQlCgxMWj9AzND7dG5jwgJCWv8dVqpZdv3dnJ+i4FXp52qoMLpHNNV5X8BTDAzoKW0WpJ824DNfY4kQPy2L9zUPBE0igPwb3jgikEB6q2PLxAQweWNhuakOivcN33IYIO5d54BICumcfWNgUCp3taNBkiBgB3QCf/OpOfjNWtlUYVLxNPPjncYPkPnhYZ1IvzQhHWr+W7zVGqnkluAKVbke+qDIt4ypnYRmxSmUus1SrW5Y1ZOJ51kkcwZEoBC4fQvZLOiMcO83O5xCOmWg6TKGIZpMNqeYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEpTDZ/6rtwILkmTWfxX4g5aUOb/pTNNQxPQFS9bgyQ=;
 b=fl9BjE8qAux/Y9lsSPHDGVpy2XO4YX7bcVFSMbvlyROMTnr48bMtrr7YqzbjcwZDVRrEIVWxjQSxrceqMkG1XW9mSGSIBJpsCBXUKYcIMu0pw5Wz9/AHEK0TfJ7l6yZgZPk0Uho1J6UnHFAjoiUDWCGHoNgS2H2c167nixVNWEk=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5198.namprd11.prod.outlook.com (2603:10b6:a03:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 05:56:20 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 05:56:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <julian.calaby@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Topic: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Index: AQHXCnEwZSbR0AsbwkSoOjOCksEYjKpn0IyAgAAmboCAAGoDgA==
Date:   Thu, 25 Feb 2021 05:56:20 +0000
Message-ID: <74fcdef6-124e-3fc2-6467-f71badc01d0c@microchip.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
 <20210224055135.1509200-4-davidm@egauge.net>
 <CAGRGNgUR7wHgprWcqz5orJNuhcxeLMSE1C3WCi1_UH_MCwJ6Cg@mail.gmail.com>
 <70567db1d625086e051b305320c9d4be7deb1b82.camel@egauge.net>
In-Reply-To: <70567db1d625086e051b305320c9d4be7deb1b82.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: egauge.net; dkim=none (message not signed)
 header.d=none;egauge.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [106.51.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 789cbb74-7c16-41da-6430-08d8d9521329
x-ms-traffictypediagnostic: SJ0PR11MB5198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB51988424A1FDB87CADBCAF34E39E9@SJ0PR11MB5198.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QI6aCEPXplqmRUhffzd7+xRl7Zc6NY5mX76Gk9mUK7BxF8Xp8cev+LbU7j1q0+E8gr9KEiuTCEvgupxrBABYpBMgaL8xjlyw1SQCfAtAFoEBTZIxk+ctMIqmFpavq/7xN3ZNOM0YznTziLfNf2w5jejq5xL8j/ZC4eOVSd6MAq36Zyp6HdSxFQSGPqtRNDoMvr8qjpzFvu3yBxv3p+7x8qDkVWVNpogERUiwZXqV3MPEgkboI+hhZzjbBu3Zs/bq02CMsAaJ8bcWh3IHvQafSvf68GU9GCs/k+1G0mXDqt5SIMvwXDeTJrRzz4R1P+34AC1hwPIZWcnJ1XTjmanLaZtibCFFt1NvjBhqOoVMxkXGyWlA3mv+R1usmVLytucAvho0+CxXiw1srnNJxt2NEo08E+d+sSOQw2jSXhcT8Jrr6XcHu9wAq0YdrYg3ivPFN61JqaJMCfxbCis4nyGYyGplDRqurcqRQjoF+VqqEv6A4bRadyAzrkIjHbSUwFkDsUGBV1YMBbX7jP/w013MF+2I6VZX8hjo7Pnif5so76EJ5Pm1PIf7qrHPXfSJ0NVTT0SBDKa96YzH0yEglLMh57BruFsNLpAPbEn+aHDj0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(376002)(136003)(6512007)(186003)(478600001)(26005)(316002)(110136005)(36756003)(54906003)(4744005)(8676002)(55236004)(8936002)(31696002)(5660300002)(2616005)(86362001)(107886003)(53546011)(2906002)(6506007)(31686004)(4326008)(66946007)(66556008)(71200400001)(66476007)(91956017)(66446008)(64756008)(6486002)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K0tSUGZDazJoY1A0VUhIVTVPaGpEZU5ENFJ3aktwNktkWW1vTG01QnJJY1Ax?=
 =?utf-8?B?aTVja1lRNkZtMzZZWmxsT2tzdGcwSlNZV21UWWZobyt2RUs4TzZ1Ym1ZYy8x?=
 =?utf-8?B?NzlicHJGd3BGT3crV3dCWnVFUUxJcWJYRW9zdnBLekd6MGdpN0wyQ2t1MFk2?=
 =?utf-8?B?V2xaQ3VSZFJhZDJxOG1PaUcvTmRZVWVSQkxkYzJqNmpGSy9YSHNiK0IxVWpG?=
 =?utf-8?B?bUZLUUpFKzFmb2UwdjlFOWZXc3FhUEdqV2RrUFRxbFA4cHkvUWZWb2NUT0s3?=
 =?utf-8?B?bU1EUkE4T3R4RDdQenJUeG5yYThIV25rT0ZWQzF6VXJBTks2NXlUUU9tUGl5?=
 =?utf-8?B?ZWpFdHkwVG9qNjFCVlVTTnRrZEVsOFY3MzhQNlRJWlFSMGRuUCtlSVFnY0tk?=
 =?utf-8?B?M00xbncxWXJZeW42MVdxOVFQNktWamhvS1VMUEhwOGFMNjFyMTNaWXk3K3Bo?=
 =?utf-8?B?amtHdVVRTlBFNGpCWUpIRXZsckZrcEpDeWlEeG1COG9Ebno0ZVVKdHdqOGx5?=
 =?utf-8?B?eU9QQ3k4clU3REUyMEtWNEhaMTVWNWRydXFwVk9TYXErNld3bnYvRm9QNVdK?=
 =?utf-8?B?bnlvZStIVzgwUzhIazdjU0NKQ3JVcFNkcmRjMlR0dVJad3Fic3oycHAvRysx?=
 =?utf-8?B?RU82WEF5VmY1bTVyZG81RW5CenBHT3R5RHNTcjNEdHhJRVA1NzR5TnZZWnQ5?=
 =?utf-8?B?L29zOHEwazZXT3ZCZFR0em5oYU9DZFdIRHg0aVh0ZFRIcFZpWEhwTUErZ0pX?=
 =?utf-8?B?Tm5hU0ozTXBGd0M3RE1yK3VQc2dhZkZhMG0ra2ZIV3RuZ2c1Yk1tVmRLWTM2?=
 =?utf-8?B?OGErRm15V3RBT0M0clJJbXhCN21WcWdSTFpPOGVabS8rcldOcmYrY21iSWdC?=
 =?utf-8?B?eU5KanZjWjBZbmprMGpxRGN1UDJGcFY3UkN1TUE4SjZGd1RlVVBHNXk4VzlI?=
 =?utf-8?B?dER0OElvTmNhd1piMWo4TkdHYk9tK2dlZVIyZHVURzY2TTlEWEthVlQ4dkh4?=
 =?utf-8?B?OHB2WWlpbFhzWnNISFNIbURQd2FWYTRXdHg3TFl0RWpjOWJXVHFTSVcxS3By?=
 =?utf-8?B?OGpsV1FaWERHS1ZhcmxVODhUUmJ5TUJQTFN2dHh1RFNucXhPV2I1cGk0U1du?=
 =?utf-8?B?Q2F5UGd4ZkRlQXdlcUF6M2F4WXBmcGFNUlZ4SCtvT2gzb1FoNmVraUJaN3Rm?=
 =?utf-8?B?M1FyMjJ6MEUxNWtlSVNoWmJjZE9FVENLbnhVVEhGbytwN0NCWGtHeW5FNkNU?=
 =?utf-8?B?bVd6T0RTKzhhZTF6M1ZJbXpNOG1UeHFNK0MwMll6VGJnZEFxSmhVSWZvRkRa?=
 =?utf-8?B?S3AzcmpBS2RsTUNGRkNON3lqUDRrT2Z5RnQxZ3NxZ09rRXJuMlpWK2lrR2JX?=
 =?utf-8?B?MWYzbkNxdTgrMURidm5rUkRLaGMyK3IvWHJZQThyWHRCck5uVnkyZ1ZlSXhp?=
 =?utf-8?B?aTRVajlHUmt6U1lQR0ovWXEwaHJPQjJIWlRBSkZvMzNqOU1hVEtjcWRvaTZY?=
 =?utf-8?B?SHBpaVhaekYwRUkvdS9uSnltVnhqTkZGUFMrVXhEVTNBbW15T05yN2dMaTZG?=
 =?utf-8?B?SUNidDZmWE5OZHlnVmVXUU1xSS9jNDVmWHBXR1hVdWpFL3pocHJxOTFHOVMx?=
 =?utf-8?B?NDF2ejhRclIzeXdPaVhuMmhQTEE0RDMzT0hCTXZyZ3JEZTVMa1JCbUR1cWx3?=
 =?utf-8?B?Yy9GV0xuMnZRNTlnZ2lEU2xENjMwbnJjRHdvejNxU0pwWkJrcEIzMnBRYVN1?=
 =?utf-8?Q?bIeZenvvCdTavflshIt5aN0RF1umgVI4XQHJQ51?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C870B7FB09E6B4B8A8235D8305C17CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789cbb74-7c16-41da-6430-08d8d9521329
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 05:56:20.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvLirCkGJzJa/UfjiTRwFKcf9J1E4Gg6Rp3TDCpzvPorOw0dZvXRbpSv8ZZfbw3qGUBlGf+JbYnLxEJfAWsJCUtPIGZTeExG1CDPLEZwC+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5198
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDI1LzAyLzIxIDU6MDYgYW0sIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEp1bGlhbiwNCj4gDQo+IE9u
IFRodSwgMjAyMS0wMi0yNSBhdCAwODoxOSArMTEwMCwgSnVsaWFuIENhbGFieSB3cm90ZToNCj4+
IEhpIERhdmlkLA0KPj4NCj4+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDY6NTYgUE0gRGF2aWQg
TW9zYmVyZ2VyLVRhbmcgPA0KPj4gZGF2aWRtQGVnYXVnZS5uZXQ+IHdyb3RlOg0KPj4+DQo+Pj4g
KyNkZWZpbmUgRU5BQkxFX0NSQzcgICAgMCAgICAgICAvKiBzZXQgdG8gMSB0byBwcm90ZWN0IFNQ
SSBjb21tYW5kcw0KPj4+IHdpdGggQ1JDNyAqLw0KPj4+ICsjZGVmaW5lIEVOQUJMRV9DUkMxNiAg
IDAgICAgICAgLyogc2V0IHRvIDEgdG8gcHJvdGVjdCBTUEkgZGF0YQ0KPj4+IHdpdGggQ1JDMTYg
Ki8NCj4+DQo+PiBTaG91bGQgdGhlc2UgYmUgS2NvbmZpZyB2YXJpYWJsZXMgaW5zdGVhZD8NCj4g
DQo+IEknZCBjZXJ0YWlubHkgbGlrZSB0aGF0LiAgQWpheSwgd291bGQgeW91IGJlIE9LIHdpdGgg
dGhhdD8NCj4gDQoNClllcywgSSBhbSBmaW5lIHdpdGggdGhlIGNoYW5nZXMgdG8gbW92ZSBhcyBL
Y29uZmlnIHZhcmlhYmxlLg0KDQpSZWdhcmRzDQpBamF5DQo=
