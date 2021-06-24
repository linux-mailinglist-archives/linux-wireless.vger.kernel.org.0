Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA113B2D26
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhFXLC7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 07:02:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49304 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhFXLCt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 07:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624532431; x=1656068431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qwENc/VOfavS3Yoe3OOGAntUQx1Hj5xtnaia2AtCu+Q=;
  b=Gd5Nn1ADX2d6zZzKaOd2x97sffSh5h/l4MNHtnyz8PbVyiYE61L/lw3J
   o0IJE/t/8ZrQ9qBm1mZiyZFS1nLHXZxf0kyaHrgRESjJfShfq8T9RFThI
   RXF+EC4KL9xaaQWIHWjxO46I7BcaKITUXwwNEXl+qWaTUmtOACQZA7S0A
   sNlTG7qGZ411fI9zNShpi/f6CCKZTQ/7md7JRG/WSP/Vh9c9x4jOhD72g
   9NBzlw9OjitWSUMSs3cJ/8yJba4JlDkHNVPjQ4lw33bLS6NZjJJvxWufM
   VZiY57AOuZmd39+NsNbKk+bv6aE4x1pCI+l0vGJyqNIUyrJCmJKSXoegA
   Q==;
IronPort-SDR: 9qWboJNc28QcNrwKod381Js6Lm9tYTnbo5/KPB/xF8oaazoS+IUNQKcp/FqH+/Nx4igC3g9tfe
 a9/qumNH0El0q7/2n7XmDZwVzU9W2ief72DiTIR61NDkwH1XsF3N4p3XlASorAnZDOaIHipms6
 yy3/X9IcKDRbe7tDzzIMWehsHAbRN/HdrgaHtMjKdOFqqKH1SFieCp6+5D5XjYb8/kjLiDWZfd
 1GZ+7ZEWxRCDFZmmF+CkcO76C45YKAlPv5N7gFTSm47ZwiJRCLG3kaBe8IbmYHBlqeivCBClNn
 zSU=
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="125914774"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jun 2021 04:00:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 04:00:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 24 Jun 2021 04:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzDxf5YcVyTZ8WZQHMkkc38zwlUKMUoO7Yk6C7sTHLS6GyNyBkT2+mOLT59u7BzPip90BDzmehlxAUIgdWDZHwG43j8+I8g86Ouvmoy8KNxw47Zt22V78VapbtG1fAZD7p76dblwbnp4ORW/Cmjx1Y07r9Tq/P9TOPC6hNEhI8tp4oa0gIYMBf3nG5vuQOILFlVI766kLer3JCYnZfkO+MKTHmO1fE1hw4YWi/18yYxemXpU/7643CsayIrMLaqGOYnxt0s2BuSV//353Q+IlfxDoWUOBaDbUwzzqHjxQbTiZaYzl+1KZShGgZlkaaOHwaIuHiIQ9UkzGBQYM+cWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwENc/VOfavS3Yoe3OOGAntUQx1Hj5xtnaia2AtCu+Q=;
 b=MrytXJQY+7MWNu0TR2d7CVDdY0Qev0P+jGjsY/uL8u3n8waOZKceD+SbIqXC6s2oGaokoS6omKhbZ/NgJLaKQ3vJsvY1MyKLL3rkJAjtD3j0qrPrRjNLsgx914NgCzmabmB/8Pqdhtr54AN0q9gEiacZYwrrB8kmrTz14uTENQSqVCBDGU0nq7LQF7bMxBuXqhS6xE6bV65RI7goUajAYLQte/VmZimXUL8B4SdylfuENPvJ1oVevM8iXRLBAg89veBI857JEMAaHe8YYZt5Gz2ORykBFiKEZGFLDhwZpMScRAVSNfBYkoOvKDjrEbJkIqnJ0zrMyVhfwjuLJNUKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwENc/VOfavS3Yoe3OOGAntUQx1Hj5xtnaia2AtCu+Q=;
 b=beHQO3a7MRuqYBwNj5mbh5vCpqDk3dnnym3X+I2v4+BoRam69gR9SjjNAo3xyfSTBaJIgeaPn1i8UWOsM15safyD8cHopYT2meDS2rCtvVzlong8JyH0ASwzGibY5sTl46J0wKQlJMXCZxLgAAlKrHwlZZ8/hStG+AQ/3iqgHKs=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 24 Jun
 2021 11:00:26 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::cfb:6c2e:60dd:91dc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::cfb:6c2e:60dd:91dc%4]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 11:00:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 03/12] wilc1000: added new WID to pass WOW info to
 firmware
Thread-Topic: [PATCH 03/12] wilc1000: added new WID to pass WOW info to
 firmware
Thread-Index: AQHXOG6gPjibZyJzLUi012SKzLZdnqsjRONJgAAahIA=
Date:   Thu, 24 Jun 2021 11:00:26 +0000
Message-ID: <81ca23c7-da24-5396-fb8d-1156d09357b5@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
 <20210423182925.5865-4-ajay.kathat@microchip.com>
 <87mtrfiphd.fsf@tynnyri.adurom.net>
In-Reply-To: <87mtrfiphd.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 087feb52-6cc7-4cb1-f1c5-08d936ff45a3
x-ms-traffictypediagnostic: SJ0PR11MB5022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5022AD847B890C211A8BF9DCE3079@SJ0PR11MB5022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TE+C0CUUEyiJKej59CI2hXWGgyqDqozSBA2FXnoBZzlxYMaPVX86NQe8K8LNPWnrwJRk0KlxOTHde1rC0Ceffd5pEIUaK4Q7YZKPbqxi9xvU8k5iUmmvioWnrwThyUKjwBiSGHHRqTuya8gVipPaMcrrd9voJW54lbEeVfk+Ex1LlDfdT+vNlYmnDMiTmgL0SHb0R3Fs5NuwK72VsNsZ4B4KWFQBvV69nfd7dzcsreA6SwtrcheWxpM/nGdlHvi2LicYLmdXxEL5cTgx2uh6xR6THvYZYH6IRGzzOwltTjEelT38F/HR8tbTuCRUWg8asX3wrBqOz2MPUc4E66QycAxZFK3XXPMic5dGe7EC58Zk/cTiAoI8japM9676nx4IZvHfueabD7k//9v1Q3CERSY3T27dF4TZlixj+vmez95LSTYvB9WlkODtIlhZwr2XpV7ZX+zijtG1B6Xo4sJqE9BkwzIqMtUVRLGbfuonvuGv5qmG4iLwm8RIDWeChLhFPPewmXEHPmUzpEgm/FELs1U4MhjK6OXsztA7dV73t9eLy0KOt0ZrB/D8c/VABJXtwQZHhWhB8bobdN9SllTGe94Bkf+8o/vYwtNVg/XN7bBD4dmA9FqINall3zBCuHsp88mEgm/woCMhWauks7buVQLTvNL9slHWQ7EBT78VlzrPbkG8a2/n38Gs8dbTj9lggIe530RgmWd0DPzGX8qkoRlTJuKe6UBWIqH7CS4m+8IiVqcZHOm/2RRMv2QvUnAN2KrWZ1yuNxdzqG/uhz6ftVrSPwKC/WVnbGuTTc20xCXbg1XtklWmYXwI66boJ+5BTCiRQ7jTPBM7OsoBaOnt8UMgSFgheOtFeRpKFHfrNU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(376002)(39860400002)(4744005)(5660300002)(6512007)(71200400001)(4326008)(55236004)(6916009)(6486002)(53546011)(83380400001)(2906002)(66446008)(66556008)(31696002)(316002)(31686004)(478600001)(122000001)(86362001)(38100700002)(6506007)(8936002)(64756008)(966005)(36756003)(26005)(8676002)(186003)(107886003)(54906003)(66476007)(91956017)(66946007)(2616005)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXpXQmROR0ZoQ1AyazQ3QUplUW1Xc2ZqS2RmdmJveVlwaDBSMkErZC9hUVl0?=
 =?utf-8?B?U0w1amtSdnZ5NnEyUmV3WUhaUGtESmsxOGp4VWozVGRQSTZLRm9WZG5SbFEz?=
 =?utf-8?B?blgxdzRiMXNYZXBmZGVGcitIb0oydTRPdUExRnMydjA0cWMycW9sRVZ4MGlH?=
 =?utf-8?B?eFhWdzhLcjlwbDVmQUhoS0ZZNFVUKzVsU3JwcHVnVEV0Y0d5NFRNcWl6VzJS?=
 =?utf-8?B?aUVveTFBUDNOWG8yREpsdzhwaGxtVnZhUUpwWWtNVUZXV1QxdTcwS0U1dkQ5?=
 =?utf-8?B?akg3WnBERDlkTGg5V1cyY1lQTHZmOC8wYmljM2FRK3MvZU5kalcweFpiV0RS?=
 =?utf-8?B?VzZhdkh3RmdPZXBEVXg1cW1mV3pzUnIxVXR0OHBIZ1A3OVV4WU5YTEF2OHF3?=
 =?utf-8?B?cGlZVlRpRGplaDZYSVU4a3l1L1hZN05ZbVdpeitBazU3OWt3WUNJbjc3OGtM?=
 =?utf-8?B?OFNiZXllMWpqTWdqQ2V2cnZaZFJUekgrTjROZ1R0VXZWNUJTeU5UUmxIWmVp?=
 =?utf-8?B?RG9oT0VtdjNTZENTSmxCS0JNREVvSzhqbTdXYnhXVzdnbHJiT21UVDlTY0NE?=
 =?utf-8?B?WEt1NzNmWE9aN0JsaGdkRHVKV1Fpdk5jdGRvbCttcHNuNlhLZU1OSCtPMWtT?=
 =?utf-8?B?VXpSdnhvS3JWdmF4YWEzaEQvSFlhN3JwQzg5MVNraVc0elNuaElPczVMZlVs?=
 =?utf-8?B?ekRzZ2dzcUw1Mk5pcWF3WkVUbjVPRVdiV201VVNjUUtSZFJQcEMxL0MrWlVV?=
 =?utf-8?B?b25CT0JIRmx0NWs4NlpwbUNGSTRvL0JDdUpQa0lwKzFSZCtmdW80eXgybllp?=
 =?utf-8?B?VEdIRVBQZW5DWE80TDNLWFNuUExHVndXWGtuenM0L2NlZndvMzhhVzV4VFZH?=
 =?utf-8?B?LzdKVi9kenRETEtmZUlvc0lDVXk2MHhsL0FrZ3Voc3NoQzhCVXh5M3dPSFF1?=
 =?utf-8?B?ZWpNa2lqa1lpNUZyTWZENzVrOCtBMy9LRVlaK2lqRVRwN3dTVklrd0owalZo?=
 =?utf-8?B?YmJ2YUlGeWRSMkpzRHZEblFicER0alFrV04wQmxMSGRwaE1iQlFmdGF4Vmc2?=
 =?utf-8?B?QjQ4MEZUcVdZTWFJVmVyM0Y1a0JPMzBvVXBSSGkvVCtCWmF3OEx0NmNwWHpS?=
 =?utf-8?B?ZVlxdTRxUUNxNTZ2OVQ4YnVEM1o3OUVlMFYwSmIzUHg1eFVucW4vZ3BuRkp3?=
 =?utf-8?B?cXFUUHdQYUJXWGZjdU1ucHFyYW9laWt4RGluZHdNRUY5OHpoWFNjWUpNTlNC?=
 =?utf-8?B?Q3NFWlF1bklQaGJUWHoxcWdiVXhTTE1BYXZGTmNpOGRCa0FoR3FiKzIwTlcy?=
 =?utf-8?B?b2Q0bHhkanhDNzVmS1FEc0hRTXFaUUpaTlBMSElNdUZxQXN6bkhIR2svMVhq?=
 =?utf-8?B?R0EwcVRDWmthNG5LS2pVUi9DcG5TNk5mdXVlUUp2MWp3WUNSN3h5UysxQTdB?=
 =?utf-8?B?Kzdia1QvRkhGcnVrMUtTMTVaY1JEUG8wUnZjZzlWSVJjdmdPZVZjNzJRYmxo?=
 =?utf-8?B?a2lqMjg2QTdrcm8yd2JjYk9ZYVAyU2lzMktudVZxV3ZSNnJETnFNQklYeG9x?=
 =?utf-8?B?VVlwNlVUL281SlRzMTRVa2NWUDVrcmJzUU5DcHVBN1A3NzVXSWpWSFhhL3BB?=
 =?utf-8?B?dHc5R1FKNFdkUXBMQUd5U2NwUWtKb1htdDNVQnVXc0puVDhHUXcwd3kyZmpp?=
 =?utf-8?B?TTUrR3VHVUdpSXdBQVQ0aGlVa3YydFNTU3VuK1VTRFErZThpVkUzYnBmRThm?=
 =?utf-8?Q?l9OLzSb5hpDGOERofI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D31A586A184F14190469C99E4359474@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087feb52-6cc7-4cb1-f1c5-08d936ff45a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 11:00:26.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDjv3VcxRg6rsASivRU7MNI3FqwRUDv2Fbh/Sk+GSDaJcBMnduZx+MikD4WfegWR8Z+dWUnT4v95iatvVB1hXtIkymolLKzm9EIOqtZZuQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDI0LzA2LzIxIDI6NTUgcG0sIEthbGxlIFZhbG8gd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiA8QWpheS5LYXRoYXRAbWljcm9j
aGlwLmNvbT4gd3JpdGVzOg0KPg0KPj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWlj
cm9jaGlwLmNvbT4NCj4+DQo+PiBBZGRlZCBuZXcgV0lEIHRvIGhhbmRsZSBXT1cgYW5kIHBhc3Mg
dGhlIGluZm9ybWF0aW9uIHRvIEZXIGluDQo+PiB3aWxjX3NldF93YWtldXAoKS4NCj4gVGhlIGNv
bW1pdCBsb2cgZG9lcyBub3QgYW5zd2VyIHRvICJXaHk/Ii4gSWYgeW91IGFyZSBmaXhpbmcgYSBi
dWcsDQo+IHBsZWFzZSBkZXNjcmliZSB0aGUgaXNzdWUuDQoNCg0KU3VyZSwgSSB3aWxsIHJld29y
ayBvbiB0aGUgcmV2aWV3IGNvbW1lbnRzIGFuZCByZXN1Ym1pdCB2MiBzZXJpZXMgYnkgDQppbmNs
dWRpbmcgbW9yZSBjb21taXQgZGV0YWlscy4NCg0KDQpSZWdhcmRzLA0KDQpBamF5DQoNCj4gQW5k
IHVzZSBpbXBlcmF0aXZlIHZvaWNlOiAiYWRkZWQiIC0+ICJhZGQiDQo+DQo+IFBsZWFzZSByZWFk
IHRoZSB3aWtpIHdoaWNoIGNvbnRhaW5zIG1vcmUgaW5mb3JtYXRpb246DQo+DQo+IGh0dHBzOi8v
d2lyZWxlc3Mud2lraS5rZXJuZWwub3JnL2VuL2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJt
aXR0aW5ncGF0Y2hlcyNjb21taXRfbWVzc2FnZXMNCj4NCj4gLS0NCj4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL2xpc3QvDQo+DQo+IGh0dHBzOi8v
d2lyZWxlc3Mud2lraS5rZXJuZWwub3JnL2VuL2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJt
aXR0aW5ncGF0Y2hlcw0KDQoNCg==
