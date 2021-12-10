Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1C46FD99
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhLJJYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:24:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61571 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbhLJJYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639128043; x=1670664043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g/M/lIKT1AqdYCYbnsA7b0hnqaM+pLhJrlfw6snmDdI=;
  b=iefkzW0NgrtO+9LoXWe3kSMIzlHO/PB3Qy7cSDmg9+ejXXM08KLu9rGg
   bXm0uV2XXL850PucYfAcCQ56hID6VCqKOE9RWrEVgN3r1Jk4uV5Ic0Ub1
   rH4dCO6jzK+WJT3/jf0Lshn68NjtKi9NJ1jXHQSt8LCdWgxWtBKm6+jFC
   ijMTw6zCt8+op3J8EUUucQEyMm8XP7hFKBASUXbTdgTUSmzxH53h+qrxl
   ostUTGiOg9C4nnV/mBFzRXuhRFftox6Rc2Rrbpqx0bPHzJOLSwyg29X1Y
   6RREz3HSVVj+sdsltWpzWGYkNuRnvF7u/A9naNZSk+Rm37gqjA/qp6qA2
   w==;
IronPort-SDR: if9qyOQKEFonkUoP5Uo5/OkMo8XzufR5cf5sVlY5LlGb4AV01Ag5VIdcUDJH45AkS+Ls9Ypegp
 hg8GCNLvvMhkiGiRJsb/STzF3wOhtNg3fcSUM4uB9aHQe1jtT/HhHjRMSHrMQIuxR1s1KkzqNG
 Jx0C5HMLAH3rdrz/MgTGK9NoSYzXGJIgxNXZHzNCMwqnzVsXKz+cBMIzmQZLaWJ2mA/V6ByYl8
 3Fs4XvGbqBu27d9knPh6lDGauTtz3xUJ+KHoRnxX0aEgQacwfbpoZvIpEg+fo6Kq6nK3RJUO2k
 Zx+sPraTWzREnnQxguiVbpLm
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="79128829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2021 02:20:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Dec 2021 02:20:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 02:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAL6fCuL1jPxJBwrW6c86hlt23KmhFwOxs5OIod0ARfkVD6lGUZLPZ8ogec9onoYsUkK1ZkPijmIP4wnK24077JzoNdD1bHWBQFnX8NfKUCbkQmKWRW4Liv4SlxJqLHt5OEP08MnsAJOkHdWs0sB4TUtlKLIiKaMuWCwzOcqV87YIa0IigKcBjk57QIBtIoY5se3BjD6RS5E6+IzZsDZLh8ocYGTV/JOI1Ft8H9/GtKCK7OBdnV6d0FYokTZBuOfQOXjbd9eDtb9Ygs2hFdxugcpb2jYTFDW7FXDwyQwCvQufMZeOyb9hUJBz+I66FBjGdCqGTyQxIYMb6rSrematA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/M/lIKT1AqdYCYbnsA7b0hnqaM+pLhJrlfw6snmDdI=;
 b=FCCXtHD0Qcz2dgbbVAKGhJoO7/spN1JNuA6umPV0YScH/3UAv1i/4yvRqKie8006pDZk7S0FnRVqFxhIgvW9dFiftyBs2PRd83LlyluosoeWQPouHTxiCjhd3khuChMSe3AgZhPISKWV8MSQ5xOyldR0ejjKs/WsuEZGxLzvJ/+XetQAb9ng6tJQg2QmTKBCB7bV+0EzI0ACblBnHEti5kyvm7URWmUsTi5PAvbzfbgqYDLQWb8ItQUCjh5w24JFYdeiOVA44QTU5QA2F+7H2X7VP23lbfQD0uW/OiMwRTJDsujvPR4xBbwBCZdFUHsfHDKCqtG4ycN84ojxmTq7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/M/lIKT1AqdYCYbnsA7b0hnqaM+pLhJrlfw6snmDdI=;
 b=GkACHTHbASuDFCZFomojvtuDNYXe8K7B2WjQo+emMWHJZS+Rdy+OlsvR8h8WG6Rh+ohLYPNv0a3myZmNXQJ4NtTxSO5Mbuku1emLKAQMpu14/3Kr0fuJuR6z+4QZHtQV2mWW1RsN8TygTPTkazkbEeX/f6uvkn6xkOccDK7Z1JE=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB4040.namprd11.prod.outlook.com (2603:10b6:a03:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 09:20:41 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0%5]) with mapi id 15.20.4755.023; Fri, 10 Dec 2021
 09:20:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>
CC:     <Claudiu.Beznea@microchip.com>, <linux-wireless@vger.kernel.org>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
Thread-Topic: RFC: wilc1000 module parameter to disable chip sleep
Thread-Index: AQHX7GR0iVpWqOmSgEO6XUQarQMP+qwp4z4AgACVlwCAAA+vAIAABIGAgAALJACAAN1zAA==
Date:   Fri, 10 Dec 2021 09:20:41 +0000
Message-ID: <790a731e-d952-f3cf-280e-9af1d3a158cb@microchip.com>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
 <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
 <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
 <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
 <dcbbd9fce1f12393c5e2cd1271c60507a8475bc6.camel@egauge.net>
 <ea0cd2faee9ff61c2e822f4df37d6a9ce59dd3f0.camel@egauge.net>
In-Reply-To: <ea0cd2faee9ff61c2e822f4df37d6a9ce59dd3f0.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6c9ad95-3362-4a74-4fe7-08d9bbbe563e
x-ms-traffictypediagnostic: BY5PR11MB4040:EE_
x-microsoft-antispam-prvs: <BY5PR11MB404097A0FE8757601E80DBDFE3719@BY5PR11MB4040.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFSow4l6jxW3OudaSmLD09N0L5pdt1XuL6NaftGleBlx9lBvc8jt5Cp7q5bLXzNH/LHyim/Rif3XHHVooV4XDBjpiov/fYqn2L4e9kek8QTAg1XZwvgHRilSpmm3GzvsO/O0p0wQT+j+G9FMexNGgZZRtc9rf3d80MNNmUyBF5YY746zdSHb/m9GTy8bOrwZ/rfz+yKN4d2TlRt9bjyLj+hIQsGfLZKRpu7jbo2lim1oSIa5VWG35NQnoZDcUQfhyDOy60OUi47cIwUTjbMNmXifBOQFnOw+YOvScriNQeE8D73b5YNGr6tD/NCD6woxkAjRBI3SXqb5EKY2lKYnQFc+i/mI01YwG9Chu8olTAm+Ee05eI+aWhtfrxQ4wNPS0/oNRTRJ5zFOM9XSvXENY2EOgLC9RdP3sXNW4/EVVlZoAUR8CnHPvFXQRxX2i/8LPn9hgwIZ1r+N2eYSMpEiVEbADubUSlXyKe5w/O7ABYRfcYit7O1BMhtcyxPxcr1CKayWqczqUi5z6p80xG8iwj1UF8LeMQD3LP6ZyofMFhag7AGFXLzam/PgahcjPtZVzj6N3/8E0SeAUMaG29nHp+7U4Q+CB5FFGM1uuhFyt4y/xKMvgRxOJnHt9BzLeMtDW9i3QDIUSqwXkIrNHyubeROuFRBfv9K2Zv9+BQ2dujt9wrGDOwiJ4b9Ci4yo+aIFOsTr6qnOUSXN/LrPgMYT+77foQSrysNR9poN3lw8kQu0GDFIj3/a52d9cGpZ6ziy1NoRIWd1BlpZd5SobJHsvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6486002)(54906003)(8676002)(2906002)(8936002)(508600001)(66446008)(64756008)(66556008)(6916009)(66476007)(76116006)(91956017)(66946007)(38100700002)(71200400001)(36756003)(4326008)(6512007)(5660300002)(316002)(31696002)(122000001)(2616005)(55236004)(31686004)(26005)(6506007)(53546011)(38070700005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVJ3am9LN2ZISEViVDJ6S2dyclRUVExFTVlVeUN3MnVmMXVYTXNlUFJ5ckpR?=
 =?utf-8?B?K1NiR1JwR3RnQVdabFJMZE1CL1dsMldYY2Q4UUlGUDEzNVJ5YlF2Y05LaWNl?=
 =?utf-8?B?eDE5K2NoZ3VTdEZXZzBZWWtMNzJjbXFVRlJZc0Nud0pMTGFUSWlXOC9BZHc2?=
 =?utf-8?B?dTBSTSt4UWpDazZKalpyZmRRZEk1MHdoQm9rbzc1TUliVWJ4dmVOVkRVbHdE?=
 =?utf-8?B?ekwwZmc1TVZJdTMrdEZ4bUZZM0VzUDR6NHExZ21UaUFiakRRdU1XdFExT04y?=
 =?utf-8?B?NCtkVzg5Y0ZJazFjTkw3SjNYVjBJeHFpbnhXbU9UdXBWSWY2WlZjdTNjMDRO?=
 =?utf-8?B?Ris5QWh1Qmx2dnRUUnVHdXdOb3NGaUhXL3hOQko0Y25BT0ZheHdSUVYvTHR5?=
 =?utf-8?B?dXl6aDhHN0FJbU1uTFBETVlZc01DeXdKeE9BcHVSZ3F4bkhucDN3Zjl0bisy?=
 =?utf-8?B?Y1NrVTBsY0QxcHNqT0E0UjNnaktNRXVoeEhRNnpUTzBOd1FsT3Q1WW5mR0Zy?=
 =?utf-8?B?bGF3bkp0bnlQZFRPRDlJQ015WTZucWtsc2NWUGw2SGVvTmNpVXYwTCtYanFD?=
 =?utf-8?B?Nlh1b0p2c1I4S040ZjdTUXNHMDNrRVd0eVdPSjNmMi9vUjh3RHdjWGNGdlpP?=
 =?utf-8?B?WDJaRzI2NjhwWnpPRmJqSndlNWdOMnN0bFVjbmI0R2Z0VVhubi8zSlhLVVNa?=
 =?utf-8?B?R0ZVY2xZL0h5d3FidDVHQUtycGx3VHpsNjc5UWhxY2lpdEFCai81cUNDblYr?=
 =?utf-8?B?UU1pc29xUitlUnZ1L0dTYVBoSDZpYmlvU2JEaEpTUG02MCtmNHowcnI0SjEx?=
 =?utf-8?B?QVcxWjR0VXJJb3ZscDBJcTIrejZWSEduN3NlbnVyMkJncFd3WG1YMzFRa25h?=
 =?utf-8?B?TlpPZ05hN3pjcXFVelNTdnlCWHJJMGp1S2NKQzBwK2JiRDhrTDhZN1ovLzYv?=
 =?utf-8?B?ZTNDM3RIUWQwRGgxeFdFK21FZ0RSeEpmYi9rc0FZNGFsWVg3RDkrdUljZXZG?=
 =?utf-8?B?aVZoNHJPRlI0VlpDcENqVTB5Yk1UaGlyTTVGZVhkWVhxelBUZ1VWRHRSMis4?=
 =?utf-8?B?UlkxeGVHaWpkMWViV1Rhb1lkYUVneHIybkUzcUR4MVppK3REVzdUeURkWFNV?=
 =?utf-8?B?Q0MrVStRVldHSG1saGJFdEJXTzlkY2RVUTluVXZCelorZlVsZUNGbDlYN21O?=
 =?utf-8?B?dE5TdjBKOTloTGh1ZW5CWE1yQkpGcHYzWWd2d2dPQ0tzaDJzQkJMVldPeHpM?=
 =?utf-8?B?ckdVQzlNaFg2VS9BQWtNUkh3eW1zWHk4VGJvem1DcllwcGZ5Ky84QkRxdXVl?=
 =?utf-8?B?ZEpSUk9FTGhncDFzYXVLeVZacWxDbWNlZTJBQW5IZEpkanhBNjQyNmNOY1Nw?=
 =?utf-8?B?eTVHZkxQbnRreGJyeWhXTnBVOG9ZcGJiQ1FZNlNjd1dBTDBKZEpBc09MeUNr?=
 =?utf-8?B?bCtRQ29HdXhUZWxSUkRLYkFjTE9zRndqTHBHTlk5aVJwLzRLUVJ6YnR0dHBU?=
 =?utf-8?B?bytoZmFiaGpWVDVlVzllNHZ1dURiaXJKV3JtbXdmQUg3QmVQRE0vQmlEL2Jw?=
 =?utf-8?B?TWorYzJNVUN4elUzbWhjOGdlNEVteGdrbmp6UVA0a0RyVk5UVG52YnFmNFNl?=
 =?utf-8?B?YzVySUVMdjJ0d1JjbjArdHU1bnJIRVk0UUI4RG9VOU15d3JRdS9oN1dKem9k?=
 =?utf-8?B?RnMwVGNBZjFuSis0VEpFa0FqK3g5U1hKeHB0S1FKZ1BhbFRvZi9yLzczU3NS?=
 =?utf-8?B?VkZhaUxpSzFMQXZrQSswaGNGdjZoaXhjQ3RZUmlmU0lQaUEwZE9CbGxaTFVC?=
 =?utf-8?B?WmpLeHRaYmZoTWVuRkt4RXI3cnJEMGFqN1VsOElRaXF0MGdjbDRGdWVpTDhx?=
 =?utf-8?B?V2pNZFk0TVliUFlGSXV1T3UzM1MrTFNncUF1Y2doS3dMRGJoY2FzcnRveTk2?=
 =?utf-8?B?ekVDeTBoc1JpNUwxeE1ncFlmcGRBdVBVTWd6TUJSc1FId0NickFaaVlSR09E?=
 =?utf-8?B?SFVnVEhZaDlleTU3eEVFbW0wZTBDM2x6L1VVVGkwcXR3QTg2QTM3SkIzSTZW?=
 =?utf-8?B?SjJ1eVhjVE5uRXhRdlNOd0VSSUNNU3gxS1hvVmVadjdIYVo3SGVaY0dvRmhv?=
 =?utf-8?B?UUdpUHp2eVpYYVBob1Z2Q1lhY1c0QldaYkkxTVdMMDBWVWYvVWdqS1FzQk13?=
 =?utf-8?B?dWVzQzJ5TWVzem83VDYzV0ordDRRZVp1MzJwbWRJcTVnR1lUVWpFVDU4Zk5k?=
 =?utf-8?B?MTl3VHZQVUFLb2c2eUhyQU1Jc2N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A06CA7455755DB41B14E6BF9DFF244BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c9ad95-3362-4a74-4fe7-08d9bbbe563e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:20:41.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzYNW8rtwlnuaYuaemcREb38Wxdw5Q0qblztIbQtLEUcOBWB5H4H3GrUYvmZ/49Rw5BuG+Rxm3TXzDXxAfyI6YWl/rKyVAIyGAcnMBQ1SkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4040
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTAvMTIvMjEgMDE6MzgsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gSSB0b29rIGxpbnV4LXdpcmVsZXNzIG9m
ZiB0aGUgQ0MgbGlzdC4uLg0KPg0KPiBPbiBUaHUsIDIwMjEtMTItMDkgYXQgMTI6MjggLTA3MDAs
IERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPj4gT24gVGh1LCAyMDIxLTEyLTA5IGF0IDEy
OjEyIC0wNzAwLCBEYXZpZCBNb3NiZXJnZXItVGFuZyB3cm90ZToNCj4+PiBPbiBUaHUsIDIwMjEt
MTItMDkgYXQgMTE6MTUgLTA3MDAsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPj4+DQo+
Pj4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgY2hpcF93YWtldXAoKSBjYW4gdHJpZ2dlciB0aGlzIGxl
Z2l0aW1hdGVseToNCj4+Pg0KPj4+ICAgICAgICAgICAgICBkbyB7DQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgaC0+aGlmX3JlYWRfcmVnKHdpbGMsIFdJTENfU1BJX1dBS0VVUF9SRUcsICZyZWcp
Ow0KPj4+ICAgICAgICAgICAgICAgICAgICAgIGgtPmhpZl93cml0ZV9yZWcod2lsYywgV0lMQ19T
UElfV0FLRVVQX1JFRywNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZyB8IFdJTENfU1BJX1dBS0VVUF9CSVQpOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgIGgt
PmhpZl93cml0ZV9yZWcod2lsYywgV0lMQ19TUElfV0FLRVVQX1JFRywNCj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyAmIH5XSUxDX1NQSV9XQUtFVVBfQklUKTsN
Cj4+Pg0KPj4+ICAgICAgICAgICAgICAgICAgICAgIGRvIHsNCj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgyMDAwLCAyNTAwKTsNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHdpbGNfZ2V0X2NoaXBpZCh3aWxjLCB0cnVlKTsNCj4+PiAgICAgICAg
ICAgICAgICAgICAgICB9IHdoaWxlICh3aWxjX2dldF9jaGlwaWQod2lsYywgdHJ1ZSkgPT0gMCk7
DQo+Pj4gICAgICAgICAgICAgIH0gd2hpbGUgKHdpbGNfZ2V0X2NoaXBpZCh3aWxjLCB0cnVlKSA9
PSAwKTsNCj4+Pg0KPj4+IEFjdHVhbGx5LCB0aGUgYWJvdmUgbG9va3MgcmF0aGVyIGdyb3NzLiAg
d2lsY19nZXRfY2hpcCgpIHJlYWRzIGJvdGggV0lMQ19DSElQSUQNCj4+PiBhbmQgV0lMQ19SRl9S
RVZJU0lPTl9JRCBhbmQgd2UgZG8gdGhpcyBhdCBsZWFzdCB0aHJlZSB0aW1lcyBpbiBhIHJvdyBv
biBlYWNoDQo+Pj4gY2hpcF93YWtldXAoKS4gIFdvdy4gIElzIHRoaXMgcmVhbGx5IG5lY2Vzc2Fy
eT8NCj4+IExvb2tzIGxpa2UgSSdtIG9uIHRvIHNvbWV0aGluZy4gIElmIEkgcmVwbGFjZSB0aGUg
Z3Jvc3MgY29kZSB3aXRoOg0KPj4NCj4+ICAgICAgICAgICAgICAgIGgtPmhpZl9yZWFkX3JlZyh3
aWxjLCBXSUxDX1NQSV9XQUtFVVBfUkVHLCAmcmVnKTsNCj4+ICAgICAgICAgICAgICAgIGgtPmhp
Zl93cml0ZV9yZWcod2lsYywgV0lMQ19TUElfV0FLRVVQX1JFRywgcmVnIHwgV0lMQ19TUElfV0FL
RVVQX0JJVCk7DQo+PiAgICAgICAgICAgICAgICBoLT5oaWZfd3JpdGVfcmVnKHdpbGMsIFdJTENf
U1BJX1dBS0VVUF9SRUcsIHJlZyAmIH5XSUxDX1NQSV9XQUtFVVBfQklUKTsNCj4+DQo+PiAgICAg
ICAgICAgICAgICB3aGlsZSAoMSkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAod2ls
Yy0+aGlmX2Z1bmMtPmhpZl9yZWFkX3JlZyh3aWxjLCBXSUxDX0NISVBJRCwgJmNoaXBpZCkgPT0g
MCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDIwMDAsIDI1MDApOw0KPj4gICAgICAgICAgICAg
ICAgfQ0KPj4NCj4+IExvb2sgd2hhdCBoYXBwZW5zIHRvIFRYIHRocm91Z2hwdXQ6DQo+Pg0KPj4g
WyAgNF0gICAwLjAwLTEyMC4wMCBzZWMgICAxNDIgTUJ5dGVzICA5LjkyIE1iaXRzL3NlYyAgICA2
ICAgICAgICAgICAgIHNlbmRlcg0KPj4NCj4+IFRoaXMgaXMgd2l0aCBwb3dlcl9zYXZlIG1vZGUg
dHVybmVkIG9uLiAgQWxtb3N0IGV4YWN0bHkgMyB0aW1lcyBmYXN0ZXIgdGhhbiB0aGUNCj4+IDMu
MzMgTWJpdHMvc2VjIEkgd2FzIHNlZWluZyBiZWZvcmUuDQo+IE92ZXIgMTIwIHNlY29uZHMgb2Yg
aXBlcmYzLCBhIGhpc3RvZ3JhbSBvZiB0aGUgbnVtYmVyIG9mIFdJTENfQ0hJUElEIHJlYWRzDQo+
IHJlcXVpcmVkIHRvIGdldCBhIHN1Y2Nlc3NmdWwgcmVhZCBsb29rZWQgbGlrZSB0aGlzOg0KPg0K
PiBbICA0OTMuOTE4Nzg1XSBoaXN0WyAgMF09NzA0MTcNCj4gWyAgNDkzLjkyMTYwOV0gaGlzdFsg
IDFdPTANCj4gWyAgNDkzLjkyMzk5N10gaGlzdFsgIDJdPTANCj4gWyAgNDkzLjkyNjQyNF0gaGlz
dFsgIDNdPTANCj4gWyAgNDkzLjkyODk1N10gaGlzdFsgIDRdPTANCj4gWyAgNDkzLjkzMTM1OV0g
aGlzdFsgIDVdPTANCj4gWyAgNDkzLjkzMzc4MV0gaGlzdFsgIDZdPTANCj4gWyAgNDkzLjkzNjIx
MF0gaGlzdFsgIDddPTANCj4gWyAgNDkzLjkzODcwMl0gaGlzdFsgIDhdPTANCj4gWyAgNDkzLjk0
MTA5N10gaGlzdFsgIDldPTANCj4gWyAgNDkzLjk0MzUyM10gaGlzdFsgMTBdPTANCj4gWyAgNDkz
Ljk0NTk1MV0gaGlzdFsgMTFdPTANCj4gWyAgNDkzLjk0ODQxOF0gaGlzdFsgMTJdPTANCj4gWyAg
NDkzLjk1MDgxMl0gaGlzdFsgMTNdPTANCj4gWyAgNDkzLjk1MzIzOF0gaGlzdFsgMTRdPTANCj4g
WyAgNDkzLjk1NTY2N10gaGlzdFsgMTVdPTANCj4gWyAgNDkzLjk1ODEyNl0gaGlzdFsgMTZdPTAN
Cj4gWyAgNDkzLjk2MDUyN10gaGlzdFsgMTddPTANCj4gWyAgNDkzLjk2Mjk1NF0gaGlzdFsgMThd
PTENCj4gWyAgNDkzLjk2NTM4Ml0gaGlzdFsgMTldPTcNCj4gWyAgNDkzLjk2Nzg0MF0gaGlzdFsg
MjBdPTENCj4gWyAgNDkzLjk3MDI0Ml0gaGlzdFsgMjFdPTEzDQo+DQo+IEJhc2VkIG9uIHRoaXMs
IEkgY2hhbmdlZCB0aGUgYWJvdmUgY29kZSB0bzoNCj4NCj4gICAgICAgICAgICAgICAgICB3aGls
ZSAoMSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaC0+aGlmX3JlYWRfcmVnKHdpbGMs
IFdJTENfU1BJX1dBS0VVUF9SRUcsICZyZWcpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
aC0+aGlmX3dyaXRlX3JlZyh3aWxjLCBXSUxDX1NQSV9XQUtFVVBfUkVHLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgfCBXSUxDX1NQSV9XQUtFVVBfQklU
KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGgtPmhpZl93cml0ZV9yZWcod2lsYywgV0lM
Q19TUElfV0FLRVVQX1JFRywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmVnICYgfldJTENfU1BJX1dBS0VVUF9CSVQpOw0KPg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHdpbGMtPmhpZl9mdW5jLT5oaWZfcmVhZF9yZWcod2lsYywgV0lMQ19DSElQ
SUQsICZjaGlwaWQpID09IDApDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDIwMDAsIDI1MDAp
Ow0KPiAgICAgICAgICAgICAgICAgIH0NCj4NCj4gVGhpcyBnZXRzIG1lOg0KPg0KPiAgICAgVFgv
UFNNIG9mZjogWyAgNF0gICAwLjAwLTEyMC4wMCBzZWMgICAxOTggTUJ5dGVzICAxMy44IE1iaXRz
L3NlYyAgICA5ICAgICAgICAgICAgIHNlbmRlcg0KPiAgICAgVFgvUFNNIG9uIDogWyAgNF0gICAw
LjAwLTEyMC4wMCBzZWMgICAxNDAgTUJ5dGVzICA5Ljc4IE1iaXRzL3NlYyAgICA5ICAgICAgICAg
ICAgIHNlbmRlcg0KPiAgICAgUlgvUFNNIG9mZjogWyAgNV0gICAwLjAwLTEyMC4xMCBzZWMgICAz
MDQgTUJ5dGVzICAyMS4yIE1iaXRzL3NlYyAgICAgICAgICAgICAgICAgIHJlY2VpdmVyDQo+ICAg
ICBSWC9QU00gb24gOiBbICA1XSAgIDAuMDAtMTIwLjExIHNlYyAgIDI4OCBNQnl0ZXMgIDIwLjEg
TWJpdHMvc2VjICAgICAgICAgICAgICAgICAgcmVjZWl2ZQ0KPg0KPiBBamF5LCBJJ20gZ3Vlc3Np
bmcgeW91ciBrZXJuZWwgaXMgZWl0aGVyIGNvbmZpZ3VyZWQgZm9yIHRpY2tsZXNzIHRpbWVyIG9y
DQo+IEhaPTEwMDA/ICBUaGF0IHdvdWxkIGV4cGxhaW4gd2h5IHlvdSdkIHNlZSBoaWdoZXIgdGhy
b3VnaHB1dCB3aXRoIHRoZSBvcmlnaW5hbA0KPiBjb2RlLiAgTXkgc3lzdGVtIGlzIGNvbmZpZ3Vy
ZWQgZm9yIEhaPTEwMCwgc28gdGhlIHVzbGVlcF9yYW5nZSgpIHdvdWxkIHR5cGljYWxseQ0KPiB0
YWtlIDEwbXMuDQoNCkkgdGhpbmsgdGhlIGlzc3VlIG1heSBub3QgYmUgcmVsYXRlZCB0byB0aGUg
SFogY29uZmlndXJhdGlvbiBiZWNhdXNlIHRoZSANCiJ1c2xlZXBfcmFuZ2UiIEFQSSBtYXkgaGF2
ZSBhIGRlbGF5IG9mIHRoZSBzYW1lIG1hZ25pdHVkZS5CdHcgSSB0b28gaGF2ZSANCkNPTkZJR19I
Wj0xMDAgY29uZmlndXJlZCBmb3IgbXkgc2V0dXAuIEkgb3Zlcmxvb2tlZCB0aGF0IHRoZSB0aHJv
dWdocHV0IA0KbnVtYmVyIGZvciB0dGNwIHdhcyBpbiBCeXRlcy9zZWMgd2hlcmVhcyBpUGVyZiBz
cGVjaWZpZWQgaW4gKGJpdHMvc2VjKSANCnNvIGl0IGxvb2tzIGxpa2UgdGhlIG51bWJlcnMgYXJl
IGluIHNhbWUgcmFuZ2UuDQoNCg0KPg0KPiBBbnkgb2JqZWN0aW9ucyB0byB0aGUgbGF0ZXN0IGNv
ZGU/DQoNCg0KVGhlIGFib3ZlIG1vZGlmaWNhdGlvbiBhcmUgbm90IHJlcXVpcmVkIGJlY2F1c2Ug
dGhlIEFQSSBpcyBhbHJlYWR5IA0KY2hhbmdlZCBidXQgaXQgd291bGQgYmUgZ29vZCB0byBoYXZl
IHRoZSBvdGhlciBwYXRjaCB3aGljaCB1c2VzIA0KInBvd2VyX3NhdmVfbW9kZSIgZmxhZyB0byBh
dm9pZCBjYWxsaW5nIG9mIGNoaXAtc2xlZXAgY29kZS4NCg0KDQpSZWdhcmRzLA0KDQpBamF5DQoN
Cg==
