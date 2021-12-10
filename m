Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF046FD4E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhLJJHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:07:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:58857 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhLJJG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639127005; x=1670663005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jly4F6ugOTvh+UjL7nhUSQBCsdNB32c8RfcHZpWIlTs=;
  b=LsQG+BpYFLqpZ6VrMD2z74FXbBnhzLrrVGMpjSdhtCPvp88ITYRxoH+I
   /QRYDwaNv7OfZwgY/IWUqjQT+EnLi3sbYZU/szMsGyBVEYZ8wuEpZ2+jP
   FzmIhxMgQWuFcZSWSugYzm+eRrR1PGdP+EjWIhWyFFibijKSrMccdhJFL
   7194BTyPYBEgj1/SEf3i4wKMAYkzWSGpSHQwf+VyPg2/X2i3HM9C0lBjD
   rPh0kfiWwItIQKLHRPCOWBDMhbncSjw2TeX5u+tgT7p3Tu8oPY5t5cAEp
   ewSiPiveWYJeI+kT+WtNiGJXz3N2ewNpRhrbvig6w4oKZyMcQOmWj0mkq
   g==;
IronPort-SDR: wAPgPLBpIBn/W3CFPp3ttrqWhrojiWQEjGggLedKNvuvcPWj54EEIEdmyEXYpPyjHjqT9iSdv/
 NQbKMvh8aDhgN79N7+/WBqd9hAnCsWUWi7KXvzOZ5RcA0Bi1xGwpoKrT4dXxjlC6GOgDJji/6k
 DEYiYnORkgyF5sprp6JgjPDgenGiQJaq/rbILgN/ol8EVVWyZ/+hjW9bUhdkjhUaS9Bvg3zdsJ
 x0wp6nkof5ciL5d96I6fjI8bRvXLNaGI4U/fBH8NU6W21hCHTI65fOpwI1DMU45NEKM8hJ3nOw
 FkZlbTcXOQwrxdvgXgUrhCnv
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="146787352"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2021 02:03:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 02:03:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 10 Dec 2021 02:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZQD++gNUykHxsbRpsNNX+sIqxauMYTnw3SZKy9a967UqiDGqzrtVMmxiorrtZ58HMWHL0k9XFVVD8zhg3xoXWEz7LWBDtYxyzWEwiPFowcI+ywkE2U+Jt51FTfy9UqAw3nGLgYWUc429QRUawO6+UxV5YKUsQIVN9Gz3chtorJDg59A952MLdcYXQniJN8RW0ereUlIWOxRbOer4c7toI3g8pci1y6GkBJ0AEXB9fkHJWebEXJqJEd5KSH0Av4s0fPDRTDgjw4LEvqJpxZp/ADy5sRFP12YokZpDUV8NUKWXjMydPyMa2nkmLIZGzFZYoNM3wzEEr0KM5/6qlnOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jly4F6ugOTvh+UjL7nhUSQBCsdNB32c8RfcHZpWIlTs=;
 b=iJZENXePhSFX/6d1qxKGFgCxOJECYk1tMhHKR+HNTwOUbBOE3s84oactHb2mH7oyHdpPBxMx5fN0qug/g6TdLnp7f5KyNJ0X6ccV3pcPfMIKAGEkpYX0XpoZzYJgL8Ait+zT6gkB9msAjrfqyDk+oz6GhUdB3p7J1Cqck8DbNNWGi9ZdBAvya5i6kX8WKCTtV15RX23KfZdJ1F7R8yR6p4iJcuHKbd6qJKm+ojKGOQnSyzsadd7pdyFbB4bONSThJR/tRDbvczIgramccMtok/xJUa4hswkvn+xxjaY6hHu/fgmW2bLrN+Iv6UeVPvuHn9mBbIm/VlgysO6o6vQ6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jly4F6ugOTvh+UjL7nhUSQBCsdNB32c8RfcHZpWIlTs=;
 b=XENog2C72fYJo04tl+0ibM1o2+to05CMUBRNgk4BlK7Z1RZqpnTAixHE9WwJ/AWIaKoJgAXUrzbQv9PRiPqoYY6melEelPBJ+1D5soEoWGss2a81PsNcNUKSA401Q1+OxkJ0bOLJBUwenSj3s7ESdEwBOHBqM9dEQaYn8wlRJzk=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3685.namprd11.prod.outlook.com (2603:10b6:a03:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 09:03:21 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0%5]) with mapi id 15.20.4755.023; Fri, 10 Dec 2021
 09:03:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>
CC:     <Claudiu.Beznea@microchip.com>, <linux-wireless@vger.kernel.org>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
Thread-Topic: RFC: wilc1000 module parameter to disable chip sleep
Thread-Index: AQHX7GR0iVpWqOmSgEO6XUQarQMP+qwp4z4AgACVlwCAAPfwAA==
Date:   Fri, 10 Dec 2021 09:03:21 +0000
Message-ID: <c3c50590-1346-ca8b-dddf-e04dda9e5759@microchip.com>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
 <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
 <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
In-Reply-To: <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97f8627e-d9ef-486e-1a63-08d9bbbbea50
x-ms-traffictypediagnostic: BYAPR11MB3685:EE_
x-microsoft-antispam-prvs: <BYAPR11MB36857C85A1EF7765EB5A56E5E3719@BYAPR11MB3685.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2g7eFvLfeQ9MrnaBKYK2yfXyc0SgKqYSAb1yBz61BEeVWwwNSWHp7M1w4gZB8o590u8n1m8agL7FxB/Oj+bVqZSSjDSs1lO4SlSe4IbEfkZXUoP09YLNlnOfEWJrM+s7LZUb8EKHBTj8rKzuparcb3OMz/x2yg1PDtox5tHgUUnGZHZ9yZ9YS6NBbZpGtEcjds0HVnHfiWhZAZbN4iKf7QaR7hLDnDRx1BeMWwkrg697TvjbOxaDyiOQNdLvyEzSpwU6khva6Vfl02dKQp0U0/1VdLGsx7z7nMI6kOpA9SryV2NsP4qi7UiDS8DgwU3X4xdOferCyutaJ15K+haoT/tG0Xs7ZfbPytvciNFRyK4WIOreH7kN6u9RysZeGV+hl8mxlU0p6a7IgVIkDUXRa8LB8ZHCHPEPp9Hkq7Oq+PJBv+UaWfAVVYqfSFtZEYgBPQAgugWtEGWwXTKu+jYGmh/JdyszKLhAb1L1K7ocxJrDqnUHe2glb/oY2tC4lEFzOEyB3sdOCrBSWWtkL4XzFtV3S9ZPshgwlFF4kpWv3OnLXSVL67j6I9qaRg7Nt+eDI5Fw9A0zIhS6wYzi4fTSjl/QQrb7SKgEh4bU/sZDbBG6MLEzm43VYiDSh64++EnnGViP+r87JvWoa0qdfGOQAReNOck71r6DevquEhcWsfMMhv8KRxDNK+qYE56LQ9QiKb3e4j2XhadEvpwGuo/aI0TM+APma0gxhXjzCvnx5MQBhXF3+If4nl2QOSPNgQwzxI1jLl7OXcpkiMhwoZzsPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(2906002)(316002)(6916009)(186003)(8676002)(4326008)(71200400001)(508600001)(26005)(122000001)(55236004)(38100700002)(6506007)(53546011)(36756003)(8936002)(31686004)(6512007)(2616005)(83380400001)(86362001)(38070700005)(6486002)(76116006)(31696002)(64756008)(5660300002)(66476007)(91956017)(66556008)(66446008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dqN3hUZXI3SGc5VjYrWG14RWdWRjErSnlEMUJBTUN3dHVkbkpaY29yYWZD?=
 =?utf-8?B?ZWcxSGhVcXNxNE13ZkZwcDRsdHA0YkpUWVdHTER4VzVvM0RTQzRvZFBzQzFG?=
 =?utf-8?B?Tk5QZDNydGJuMUNmOEV1M2xqU2xveEJ3ZXdETVpVTHU0Qkl0TUFrT1V4bEd0?=
 =?utf-8?B?MWh2dnlxNHNkSnVwRlZCVkEybG5PM002ZUp3M2F2aXNOdm4wU2lWenJwcHp2?=
 =?utf-8?B?ZWE2TUlBKzNHYms0ZlBXM1ZxYlErTHZxa1FSUzNPWndxeFAyT2FqdUVvemsy?=
 =?utf-8?B?OHRMNjFsQmwyZVpGYk45YWVLaDZldTNiN0FKNDdGU25za2JKN2d0SFpqYitG?=
 =?utf-8?B?QjgyaElEK2tiRUd1Kzc5TWRDNXhOeE42SXg4VmxqUk50MWZSL01WQ1pHS0M4?=
 =?utf-8?B?UElSMEVyN2dFcjJtUjBtK3NsaDdUVlI5NFNzK0FtRU95L0pmRXI2ZG5HeXNh?=
 =?utf-8?B?cGczRkN0TVNWWWY1N28xMkN2S1NORlVNRjcrbk45c2xxZlhkdVZSdXN6TFZQ?=
 =?utf-8?B?N2F6QWhoaXRKN0w2ZUNQTnpJS0tOeThSanJHaE1OUUdFbVJBZzZEYUJGM3FN?=
 =?utf-8?B?ejR4V2JPdlR5OGRGd0ZqYlcxT3FLNWtraEF0REV0YVpLamRVYUlPZ0JESUxt?=
 =?utf-8?B?anlqVGNseEtJcTNGME1xN3YxelcxY0ZJZnVHZDZlNW93K3V3SjN4anVzc3FZ?=
 =?utf-8?B?d0QvaENnR1dUT3Rid2RKTnQxWmY2Mm8wcURVUFg1RmtuNnVubWNnSTJDRmRB?=
 =?utf-8?B?dU5xZ242R011N0ZrVm5JOUZyc0o5cmxGSiszS2JOZVVlcEl3N1B0blg2RkhW?=
 =?utf-8?B?Zmdrc3FVdm9DMHAycGxmV203KytqTUZsZHNxdG1DYnFxY0lGUXZ1ZkVQallq?=
 =?utf-8?B?WXR3Vit4S1B2Wm8vMmVub0ViRDVkK095VWg1OFZQSldUaHoxSnN2a2xUVFRi?=
 =?utf-8?B?OGtyREVHSkR5S3NhWUVGYkJocVVjZkVISXpBSUdxRTA4NEVEaEh5Slg1M3k1?=
 =?utf-8?B?VmFrTHZDRno4WjllR3ptbE9qbWplckFlbEp6U3YvaThGeEx0WnVIdkw4eWRa?=
 =?utf-8?B?OHIrYjhUc0tQMzh6QW9XL25MbGtPaXloMTZxVWNTcVNIUmNhZkpDajlDeW9G?=
 =?utf-8?B?ckJuYlp4OCt2VmFZWDdEZzdIYTJKUVhRQzh5bmxOdTFLQVVUeEU0cWZ2NEtF?=
 =?utf-8?B?RnU3Ym8xVjFpbVhGVW5hTUc4Tkoza3htM3huQThmT0p1TmF1ZGxESHNxdjNk?=
 =?utf-8?B?UWNUREJVRG9pWlI0ZVl1QWJPNFJueDRvWjRuL3d1UEoxR29zLzVvZlN6U1dE?=
 =?utf-8?B?QWxZQ1FQWi85U2dqczJGYTlpVU1weHFMNTFDSytURWlqQ09XcFVwVHdrSXBr?=
 =?utf-8?B?QS9OZlBEL0hWQ0hiZm1WVU51emsybVFiNDdsR3dYbitmWFlaNE55aGllRG95?=
 =?utf-8?B?NDlvdlRVMDN3LzdXYldZOFZ5TFhaQXpHdHpYNk41WWpiZUNVSjlvRHBNVm9u?=
 =?utf-8?B?M2tPdE15OENqcjl1NVIvellzQXpmRlB3bjIwSnBMb1puNVFFNGNmMGcxazFP?=
 =?utf-8?B?R3JhVHoxUDdLNmE1V1hidXRpakxTTEl3MDB5bFdFa3FPdlNoRC9WMUNuZk1w?=
 =?utf-8?B?M1lObnBwSmpQVmFzTVY1anI5V3c5cFhJbEJZQXNwWXlSSGNUQm54MDkzUUFi?=
 =?utf-8?B?aEpBcDVLT0hUdmpIRSt3TUcxS0ZKanRxNU9DcHhMUTBrdGg2aS9oMlRVQlFJ?=
 =?utf-8?B?bjRid3hpVXhiSlFwU0Y0RUpNYVZoNjFPZlRyaUdvUno1SERlYThUM2pmdzN0?=
 =?utf-8?B?bHpYQmZwdndTTDNHQk1pWVpBZXF3YVllUjFHS1VPSDR2WjY1aFl5aDZlM2tw?=
 =?utf-8?B?OG9rcjhhTm9makRaQXJ3U20xbjBZOW0zakM2STJhMjliN2JwNVkzaVFHZkV5?=
 =?utf-8?B?M1pkZ2xOaCtta1ZBT3RucDFGWXRTRzh0UVRzcXlmNE1MNGhMNXVwUTZBSzQ2?=
 =?utf-8?B?Z0VXV0YrWk5MWnJUQzEwZ1lyQndpZWM5U1F1S0VyU01FUTg4UjlmRnBzcmha?=
 =?utf-8?B?eVJEdHMwRjlEQjZKMnJ5S0VlajdNTnV6RW9JbG1mRmJHNjFaM3ZNaTJNdDEw?=
 =?utf-8?B?ZElNQnFtK21veHlwb04rK1djOUFrZ1FGMXUvOUFtUUdLZEVwMFQ3TGxnaC9y?=
 =?utf-8?B?Q1hiT1NZWWpwU2RuQjJEd0s5RHlhK1orT2Z5QVBpRXAzYUJ4U2NEeGY1YzA5?=
 =?utf-8?B?K0xaL0NibVlhcVVXcUFtM3JJOWxnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FF8C80CDE68C6489B541931094CF7F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f8627e-d9ef-486e-1a63-08d9bbbbea50
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:03:21.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKuLLk8QD6yiJxFHJBqHywhqz/CmhmP9MkJJHgl44ki3ZMOcsSkZlb1gL0YC3cfLBcA+Ny+6ciJjrpXs/d50ZZ1hCUDIqfvVT4jcukpHnsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3685
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMDkvMTIvMjEgMjM6NDUsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gW1NvcnJ5LCBteSBmaXJzdCBlbWFpbCB3
YXMgYWNjaWRlbnRhbGx5IGhhZCB0aGUgcGF0Y2ggYXBwZW5kZWQgYXMgYSBNSU1FDQo+ICAgYXR0
YWNobWVudC5dDQo+DQo+IE9uIFRodSwgMjAyMS0xMi0wOSBhdCAwOToyMCArMDAwMCwgQWpheS5L
YXRoYXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDA5LzEyLzIxIDAwOjIwLCBEYXZpZCBN
b3NiZXJnZXItVGFuZyB3cm90ZToNCj4+IFRoZSAiY2hpcF93YWtldXAiICYgImNoaXBfYWxsb3df
c2xlZXAiIEFQSSdzIGFyZSByZXF1aXJlZCB0byBjb25maWd1cmUNCj4+IHRoZSB3YWtlLXVwIHJl
Z2lzdGVycyBpbiB3aWxjLiBUaGVzZSByZWdpc3RlcnMgbXVzdCBiZSBjb25maWd1cmVkDQo+PiBj
b3JyZWN0bHkgd2hlbiB0aGUgcG93ZXIgc2F2ZSBtb2RlIGlzIGVuYWJsZWQuDQo+IEkgc2VlLg0K
Pg0KPj4+IEhlcmUgaXMgd2hhdCBJIHNlZTogb24gYSBzeXN0ZW0gY29uZmlndXJlZCBmb3IgbWlu
aW11bSBwb3dlciBjb25zdW1wdGlvbg0KPj4+IChhbGwgdW5uZWNlc3NhcnkgZGFlbW9ucyBkaXNh
YmxlZCwgRXRoZXJuZXQgdW5wbHVnZ2VkKSBJIG1lYXN1cmVkIDEsMTgwIG1XDQo+Pj4gd2hlbiB0
aGUgV0lMQyBjaGlwIGlzIGluIFJFU0VUICh0aGUgRU5BQkxFIHBpbiBpcyBhbHdheXMgaGlnaCBv
biBvdXINCj4+PiBwbGF0Zm9ybSkuDQo+Pj4NCj4+PiBXaXRoIHRoZSB3aWxjMTAwMC1zcGkvd2ls
YzEwMDAgbW9kdWxlcyBsb2FkZWQgYW5kIHRoZSBXSUxDIGNoaXANCj4+PiBydW5uaW5nIGJ1dCB3
aXRob3V0IGJlaW5nIGFzc29jaWF0ZWQgd2l0aCBhIFdMQU4gbmV0d29yaywgbWVhc3VyZWQNCj4+
PiBwb3dlciBjb25zdW1wdGlvbiB3YXMgMSw0NjAgbVcsIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBj
aGlwIHNsZWVwIHdhcw0KPj4+IGVuYWJsZWQgb3IgZGlzYWJsZWQuDQo+PiBEaWQgeW91IHRlc3Qg
YnkgZW5hYmxpbmcgdGhlIHBvd2VyLXNhdmUgbW9kZSB3aXRoICJ3cGFfc3VwcGxpY2FudCIgb3IN
Cj4+IHVzaW5nICJpdyIgY29tbWFuZC4gRm9yIHBvd2VyIGNvbnN1bXB0aW9uIG1lYXN1cmVtZW50
LCBwbGVhc2UgdHJ5IGJ5DQo+PiBkaXNhYmxpbmcgdGhlIFBTTSBtb2RlLg0KPiBObywgSSBoYXZl
IG5vdCBwbGF5ZWQgd2l0aCBwb3dlci1zYXZpbmcgbW9kZS4gIFRoZXJlIGFyZSBzb21lIGRpc2Nv
bmNlcnRpbmcNCj4gbWVzc2FnZXMgd2hlbiB0dXJuaW5nIFBTTSBvbjoNCj4NCj4gWyAxNzY0LjA3
MDM3NV0gd2lsYzEwMDBfc3BpIHNwaTEuMDogRmFpbGVkIGNtZCwgY21kIChjYSksIHJlc3AgKDAw
KQ0KPiBbIDE3NjQuMDc2NDAzXSB3aWxjMTAwMF9zcGkgc3BpMS4wOiBGYWlsZWQgY21kLCByZWFk
IHJlZyAoMDAwMDEzZjQpLi4uDQo+DQo+IFRoZSBkcml2ZXIgZG9lcyBzdGlsbCB3b3JrLCBidXQg
b2NjYXNpb25hbGx5LCBJIGdldCBsb25nIHN0cmVhbXMgb2YgdGhlc2UNCj4gbWVzc2FnZXMsIHNv
bWV0aW1lcyBpdCBnZXRzIHRvIHRoZSBwb2ludCB3aGVyZSB0aGVyZSBhcmUgc28gbWFueSB0aGF0
IHRoZQ0KPiB3YXRjaGRvZyB0aW1lciBlbmRzIHVwIHJlYm9vdGluZyB0aGUgc3lzdGVtLg0KPg0K
Pj4gVGhlIGNoaXAtc2xlZXAgY29kZSBpcyBuZWVkZWQgdG8gY29uZmlndXJlIHRoZSByZWdpc3Rl
cnMgcHJvcGVybHkgZm9yDQo+PiB3aWxjIGFuZCBub3QgdXNpbmcgdGhlc2Ugc2VxdWVuY2Ugd291
bGQgaGF2ZSBpbXBhY3Qgb24gc2VuZGluZyB0aGUgZGF0YQ0KPj4gdG8gd2lsYywgZXNwZWNpYWxs
eSB3aGVuIHRoZSBQUyBtb2RlIGlzIGVuYWJsZWQuDQo+IEhvdyBhYm91dCBzb21ldGhpbmcgYWxv
bmcgdGhlIHBhdGNoIGJlbG93IHRoZW4/DQoNCg0KVGhhbmtzLg0KDQoNClRoZSBjaGFuZ2VzIGxv
b2tzIG9rYXkgdG8gbWUuDQoNCg0KPiBXaXRoIHRoaXMgcGF0Y2gsIEkgc2VlIHRoZSBmb2xsb3dp
bmcgaXBlcmYzIHBlcmZvcm1hbmNlICgxMjAgc2Vjb25kIGF2ZXJhZ2UpOg0KPg0KPiBQU00gb246
DQo+IFsgIDRdICAgMC4wMC0xMjAuMDAgc2VjICA0Ny42IE1CeXRlcyAgMy4zMyBNYml0cy9zZWMg
ICAgMCAgICAgICAgICAgICBzZW5kZXINCj4NCj4gUFNNIG9mZjoNCj4gWyAgNF0gICAwLjAwLTEy
MC4wMCBzZWMgICAyMDEgTUJ5dGVzICAxNC4wIE1iaXRzL3NlYyAgIDEyICAgICAgICAgICAgIHNl
bmRlcg0KPg0KPiBJbiB0ZXJtcyBvZiBwb3dlciBjb25zdW1wdGlvbjoNCj4NCj4gICAgIGJhc2Vs
aW5lICAgICAgICAgICAgICAgIDogMS4yIFcNCj4gICAgIFBTTSBvbiwgaWRsZSAgICAgICAgICAg
IDogMS4yIFcNCj4gICAgIFBTTSBvbiwgVFggQCAzLjMzIE1icHMgIDogMS43IFcNCj4gICAgIFBT
TSBvZmYsIGlkbGUgICAgICAgICAgIDogMS41IFcNCj4gICAgIFBTTSBvZmYsIFRYIEAgMTQuMCBN
YnBzIDogMi40IFcNCj4NCj4gICAgLS1kYXZpZA0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jDQo+IGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jDQo+IGluZGV4IDQ0ZTkzY2Q1ZTNkZi4uMDlh
YTVjZWQxOWQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAv
d2lsYzEwMDAvaGlmLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL2hpZi5jDQo+IEBAIC0xOTEyLDYgKzE5MTIsNyBAQCBpbnQgd2lsY19lZGl0X3N0YXRp
b24oc3RydWN0IHdpbGNfdmlmICp2aWYsIGNvbnN0IHU4ICptYWMsDQo+DQo+ICAgaW50IHdpbGNf
c2V0X3Bvd2VyX21nbXQoc3RydWN0IHdpbGNfdmlmICp2aWYsIGJvb2wgZW5hYmxlZCwgdTMyIHRp
bWVvdXQpDQo+ICAgew0KPiArICAgICAgIHN0cnVjdCB3aWxjICp3aWxjID0gdmlmLT53aWxjOw0K
PiAgICAgICAgICBzdHJ1Y3Qgd2lkIHdpZDsNCj4gICAgICAgICAgaW50IHJlc3VsdDsNCj4gICAg
ICAgICAgczggcG93ZXJfbW9kZTsNCj4gQEAgLTE5MjcsNiArMTkyOCw4IEBAIGludCB3aWxjX3Nl
dF9wb3dlcl9tZ210KHN0cnVjdCB3aWxjX3ZpZiAqdmlmLCBib29sDQo+IGVuYWJsZWQsIHUzMiB0
aW1lb3V0KQ0KPiAgICAgICAgICByZXN1bHQgPSB3aWxjX3NlbmRfY29uZmlnX3BrdCh2aWYsIFdJ
TENfU0VUX0NGRywgJndpZCwgMSk7DQo+ICAgICAgICAgIGlmIChyZXN1bHQpDQo+ICAgICAgICAg
ICAgICAgICAgbmV0ZGV2X2Vycih2aWYtPm5kZXYsICJGYWlsZWQgdG8gc2VuZCBwb3dlciBtYW5h
Z2VtZW50XG4iKTsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICB3aWxjLT5wb3dl
cl9zYXZlX21vZGUgPSBlbmFibGVkOw0KPg0KPiAgICAgICAgICByZXR1cm4gcmVzdWx0Ow0KPiAg
IH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAw
MC9uZXRkZXYuaA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9u
ZXRkZXYuaA0KPiBpbmRleCAxNTI0MDgyMzJkNTEuLmRiMTQ5YWJjNWQwZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuaA0KPiBA
QCAtMjY3LDYgKzI2Nyw3IEBAIHN0cnVjdCB3aWxjIHsNCj4NCj4gICAgICAgICAgaW50IGNsaWVu
dHNfY291bnQ7DQo+ICAgICAgICAgIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpoaWZfd29ya3F1
ZXVlOw0KPiArICAgICAgIGJvb2wgcG93ZXJfc2F2ZV9tb2RlOw0KPiAgICAgICAgICBlbnVtIGNo
aXBfcHNfc3RhdGVzIGNoaXBfcHNfc3RhdGU7DQo+ICAgICAgICAgIHN0cnVjdCB3aWxjX2NmZyBj
Zmc7DQo+ICAgICAgICAgIHZvaWQgKmJ1c19kYXRhOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uYw0KPiBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMNCj4gaW5kZXggZGRkMzgyOTk2Mjc1Li4w
ZTBlMzI1ZDM5NmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC93bGFuLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlw
L3dpbGMxMDAwL3dsYW4uYw0KPiBAQCAtMTgsMTMgKzE4LDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCBpc193aWxjMTAwMCh1MzIgaWQpDQo+ICAgc3RhdGljIGlubGluZSB2b2lkIGFjcXVpcmVfYnVz
KHN0cnVjdCB3aWxjICp3aWxjLCBlbnVtIGJ1c19hY3F1aXJlIGFjcXVpcmUpDQo+ICAgew0KPiAg
ICAgICAgICBtdXRleF9sb2NrKCZ3aWxjLT5oaWZfY3MpOw0KPiAtICAgICAgIGlmIChhY3F1aXJl
ID09IFdJTENfQlVTX0FDUVVJUkVfQU5EX1dBS0VVUCkNCj4gKyAgICAgICBpZiAoYWNxdWlyZSA9
PSBXSUxDX0JVU19BQ1FVSVJFX0FORF9XQUtFVVAgJiYgd2lsYy0+cG93ZXJfc2F2ZV9tb2RlKQ0K
PiAgICAgICAgICAgICAgICAgIGNoaXBfd2FrZXVwKHdpbGMpOw0KPiAgIH0NCj4NCj4gICBzdGF0
aWMgaW5saW5lIHZvaWQgcmVsZWFzZV9idXMoc3RydWN0IHdpbGMgKndpbGMsIGVudW0gYnVzX3Jl
bGVhc2UgcmVsZWFzZSkNCj4gICB7DQo+IC0gICAgICAgaWYgKHJlbGVhc2UgPT0gV0lMQ19CVVNf
UkVMRUFTRV9BTExPV19TTEVFUCkNCj4gKyAgICAgICBpZiAocmVsZWFzZSA9PSBXSUxDX0JVU19S
RUxFQVNFX0FMTE9XX1NMRUVQICYmIHdpbGMtPnBvd2VyX3NhdmVfbW9kZSkNCj4gICAgICAgICAg
ICAgICAgICBjaGlwX2FsbG93X3NsZWVwKHdpbGMpOw0KPiAgICAgICAgICBtdXRleF91bmxvY2so
JndpbGMtPmhpZl9jcyk7DQo+ICAgfQ0KPg0KDQo=
