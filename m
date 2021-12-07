Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2831246BBF7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 13:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhLGNB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 08:01:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53948 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhLGNB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 08:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638881877; x=1670417877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+YCcjEU0iDWk55jnq8/ZQxzVS21yb9RwW3+NZzeJWTA=;
  b=B7ohYhh1I/aSaK4caw0OgK7kgCtebfnfGotGl41cXCoAP7oScBLYpUkE
   zzUyYpjUTXuJuvwTdSEyhYzT23UcDUViu/IvHnhNbb5UAC9cakz5j+B6A
   0ePDT1+d2A+EuRyoFuuQKItaqSo0Z+odL5B45BimitIcz8xOtuhhW5yIQ
   gJY/c1Ik+gpXOAXjGOnaZC9k/ZP1bKE+AttJ3K20ahkyJMM8XRpJQt07i
   Vr7OvyzHyDrTW2hFcm1L4LdLvWypDUubE4t0Xv5olDx+nPAAr92xSlAbl
   7fFVi8odcNAC1kyfVVf5vrrC+Buyf2CRYQQSlBv7KSZmBBbzkeQmcqbCd
   g==;
IronPort-SDR: LRw910uUYMZqm59D6+yaRNNGJWKpnWR12Mq3fkiHVuvUwirkKNL92KbSAx2TCPM28sZCHCQ91b
 A6DN7Ij8DvgmYWpPOrDhENvgmoNcuODBHvraKTu2iFX8/+RZXGqUJQK+dX5RJU/GAVe8QOMG/3
 D2kGOIO0X6j/QX1/7v6qVcwnWjzq7Fsi/xJEd0OxD745nBgQGqMZ6mD9v8km6y9BRW4CwXDwxN
 cIGqcuoHVwB3GIOfYBoJucLdpuifJ7xx0ExAWdY/UaF4SqI6bpCvM8iBc14ylumQs3gzaOpeBj
 4l+Gzu7k5CSZsq4GIiu3adNI
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="145796005"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 05:57:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 05:57:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 7 Dec 2021 05:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3ZU0tE6FOLzu+PKsP26VeHOwfzGYm/hfwHWVIKsN13dTj4pkMvELKhT+k/CLypZfIMV2AND0YRuhRP4Mwvikn3DuTeAj4VGnDh0smG4p0MWWVhBQ4uQ2fY9f+wv85+rn7aBm9+8DLFi/aBQEqIgOo5P6CKJGn0vCyuB/dP3Fabp9GJ990o6II0Ex6qxIblbYWBohZDgjHti2R9sR7Jr6JSaTS539/AwSaOy9+fU1aRvrrQSZlNE0wHEPGzTICdNvl0pzZHeM4S+Jpg5gW2FhA8t02CReH5W1wPfUtvhQ+YfQ9fc+zG1TxzMjj/e4FMgoqS+kcKWIr0v2djOdQwosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YCcjEU0iDWk55jnq8/ZQxzVS21yb9RwW3+NZzeJWTA=;
 b=DAeahOescYrEpjLCdjOWPg/bK0RZpHO0tDdkotHsCTpIKUIgyhGLQNgV+F1b401VWxY2ztwxJ7oARkN1FG1+GdY48vzQQKVuzK5pZIkeTfyrlhMOGPsr5Sh03QX5JcrhfQ9bZNhAvccdyZabXePeNNoGVXUUw8Bq7YPzgt2mn0uD6ZCI2ef7AWrF3fkzZRxektg89nfWIx3xsd0b5KboDXnkz7I9eFdO1//7NjWVY9FuArNZAP2EuywA/JiWyO7QKgy3KOtxMPnFzkWxe2Eim/LP/DAfwank031cXXpEfZ9W73qrmzo1AhZXpDwn7m4iiuwlfaj5vxsOJEXwNQGeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YCcjEU0iDWk55jnq8/ZQxzVS21yb9RwW3+NZzeJWTA=;
 b=ZziMtFM2OKz5s8pVap54xE7S/QlkqM2quZ3Ef0a7Fb+iBUPZ90SLxC9wKqeinBDwSrPMtyij3lvsZZbnOKGcj+YIeQqeiBnA0U4EB3DbEDp2ayQYFpIC97d0gNeDy8ERd4zqZWGmmkEg4K4ddzXEzjbs4D3mOM+Cwy7J8neebw4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3414.namprd11.prod.outlook.com (2603:10b6:a03:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 12:57:53 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0%5]) with mapi id 15.20.4755.023; Tue, 7 Dec 2021
 12:57:53 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <davidm@egauge.net>,
        <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <robh+dt@kernel.org>,
        <adham.abozaeid@microchip.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wilc1000: Add reset/enable GPIO support to SPI driver
Thread-Topic: [PATCH] wilc1000: Add reset/enable GPIO support to SPI driver
Thread-Index: AQHX5zB3Q+6UfrvgnkmXj6/HIhoj8qwm1zSAgAAugQA=
Date:   Tue, 7 Dec 2021 12:57:52 +0000
Message-ID: <f313c9b4-a70c-1b63-a7dd-9b807cfb8e76@microchip.com>
References: <20211202034348.2901092-1-davidm@egauge.net>
 <e2a7e005-e133-ec15-df78-2302aa538a26@microchip.com>
In-Reply-To: <e2a7e005-e133-ec15-df78-2302aa538a26@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16bc4a00-5245-4b4a-1cbf-08d9b9812e86
x-ms-traffictypediagnostic: BYAPR11MB3414:EE_
x-microsoft-antispam-prvs: <BYAPR11MB341491DAA207CAD6E070EA97E36E9@BYAPR11MB3414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQPINvKbwLTZN9WZuEN+KVGyT1SFDBbEIOpIoRw2BK+8xZH9V664Qdm6pmoG+zxCqxkvwFx4XVE85vJTTwWEBBDmG+7oCBaSK79b4+jkNGf+3uL5Uq8tCxwtXmJuxycQOHluy3aHvosaQPUMxXdE3R1hwmE/wXMxvZfEoOUBW2lrBwa3sGq8CjsKu9gBLWTjr2OrvmhO26/JS86pLBzfj2aRmnXjLYA3BwWR3E4/JscjNKzdzct2n9EUntHa/ugNO4TC+5LkDcq2spw1bTVKcF382kb5Z81GPmpwY/swpY0nOJrDP5NKOG88SvdhnRgGL4zh6LqtqIFulr44ORb9uME5HApAXtEu1+vg/PjhxptR1VV2Rj0r3Wr2hMdu/O9upIJwLWfC3EEy5j8aNu82zzzmQ54eRfC+S7jFA9GsgmZeBpnU1bD86O6rW+cWNU8TNTohpux34c8zrPo2gPxNedplPIZHBryWyMTozZ38mqj/kLQi12r25DqIGDQ0tsRy5dTWkG7Wbbj7GJEE/f1+DO1MfboekKXNRBifehiQK8NPvt5eUncS97m1vVaJkJ+dKwBfL3T8/10h9Le/uSp9enCJ6R5g7H65tQxABV2bG7yy7evsdLVuMc7FLviu75KzWopJnG0Hwth3NEKsQTfaBaWe6TT2XzplZdZGVuuyJF3rSI570hR/A0/x6bD3elYcLIiZ8H+bKnOCz3HXFLbBYeU1FkAhv09FWE/E7gWaUoHgYNvdaonrFG0dt5c6OSNWu0OGXuL9EaxlOj5XV7kjQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(31696002)(8676002)(38070700005)(38100700002)(2906002)(508600001)(55236004)(8936002)(26005)(91956017)(66556008)(66946007)(76116006)(66446008)(64756008)(122000001)(66476007)(4326008)(2616005)(71200400001)(54906003)(6512007)(186003)(5660300002)(36756003)(316002)(53546011)(6506007)(110136005)(31686004)(83380400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0FrbzBDT1IwaU9uZDdOLzN3ZE90clIwem40Zk5FeEdlblljcjNsNjZTemxL?=
 =?utf-8?B?SGNkMGwvNFZXMHJTR1B0WVVrTWFPMlp2SHN1bG0ySkFCVmsvaTNRby9saU5L?=
 =?utf-8?B?VmFJV1hnQTlra3JHU3hkSjlYN2NQQ2FPaktmMTFKb0wzMkVmTXZ1ekJwOVB5?=
 =?utf-8?B?Yk55TlFhby9MTEI1ODhGb0JGOUlrVWV3MUhHOFRBQjB2cnpOUG1ETVU4a0gw?=
 =?utf-8?B?SmkwdUtwSFVxRXdKMHpMT3hXUVNOYi83TTczaW85Z2Rrc2JOK1NwR21XYkN3?=
 =?utf-8?B?eXpNSmxxT21qdlJGSEhiNFdnQnZnVWFHdjkwL0lKckp0YzRtZXRLY1pEdVIz?=
 =?utf-8?B?UHR0RDd4Qjl6VElKMzJzNjFRMzVjL2RUOXA0SmdTNzYyd2RCV0p6dVpCVm9Q?=
 =?utf-8?B?ak1PaGFvaml4QTdUbStSajUxZmlZYml4TXNaSW5xRGpPb1lqUi9oeXAvOUcr?=
 =?utf-8?B?OCtaeUtSNkxMaHBOVm80cWRGaHAzSzFBaXV2M25weEVuVnN3WXJWOUJESUsw?=
 =?utf-8?B?dzIya0UvV0FDNmVPOC95TGYxMUR5OTE1aWxiVWlwL0NIeVNtblhvRlQxNm5q?=
 =?utf-8?B?d09zOHBaY0N3YjMxL3lPZ2g5QnJqbjRqNk1aOEhMVStOaVNsMHRZUXVFL1FG?=
 =?utf-8?B?ajlvdkZNZVBYRTRPZ0pjeFM0T3JVWUtWZFpuK2dGcldVQUdHT0VOcGRWOVlI?=
 =?utf-8?B?VWVsbnI3N3RsRkgzeTd2SnFxUDMxcVAwSDJIMTRrOXkyR2ZCbDFYQVgzam9n?=
 =?utf-8?B?QXBOWXpzRUtXc0N3ODJOY2k1VlQ1OW14WWZCZ3g3b0pEN3MvOHJ6cDlXU0ZO?=
 =?utf-8?B?NzQwV0hSNXZjQkhrQ0RZWXJQZGRoeld2UFdJcW1hZTdseDhoYWJ4aGVlMDZr?=
 =?utf-8?B?cytyZTZxWDE3bkdjU2txYWtGNUJaTGdHNHZZa1pwN1h3MzNRMFVLdlpnSWN6?=
 =?utf-8?B?VnJXWGsvVWtUbHJBUFlUQ1N0U1RnVmUybmVockxVZzZqN3VUc1ZBMEt4WTBG?=
 =?utf-8?B?a1RpcVh4ZUl2WjFHWkdEanYyZkRyMWxxTFpsNDRqdzJad2owaGo3amdZQUZk?=
 =?utf-8?B?RmR0MHlQcjJhT3d0a1lTLzF3akJtTC9sdFhmTm5Qam5SYXE4bjhsMk5oR0o4?=
 =?utf-8?B?N3ZJSDJSRURDbkFrc29MZnVtRkM2bjlhTWxJL1FsVkVPaGZTcWREdm5mK21k?=
 =?utf-8?B?aVZTcG5rRnpXNVRSN0ZkRmJlN0pKMzNQTkY4TzJ6a1BMSG9qdG45dmdKTURE?=
 =?utf-8?B?M1paUVJYTE5RSXhWczdtelllWS9SR0hkUUxaWi9XQkxtUWlBU1QreFVkb1Fa?=
 =?utf-8?B?MFVDZmVPeUZJSWJ2dUFJc0tCOWRCVmhoeXBYekZwVVRGaC9aTUpHQkdkK3Jk?=
 =?utf-8?B?b0hFU05mQjJTNDlPdnpwV2lFQXJUN2Zrbm9iYWpyQis2Z2JnQnYrS3VlbFdw?=
 =?utf-8?B?bjRBMVNSdU9FT0I2R2xwUStPM2JXZ1lxTzZLWDRpSmZ0OURzRCtZbHFEVU1j?=
 =?utf-8?B?TStnMVBzSWZQb1orL2wwTFkzNGlmbUpmdHBxL3VsSll6d1ZGRnBNTVdvelBW?=
 =?utf-8?B?ajQ1elFDRWNJTFMrdWJHMjgvTlZsYkd5VE1BYjA4VEhET2dNYmFiSGVka0tD?=
 =?utf-8?B?VUVlaWRuQkR6YzRiNS92NnhxazV0bmEzQ0djc3JSWTV4UkVvbDhpZEVRU1Zh?=
 =?utf-8?B?dGNadGh2RHhiVVVxNDQraDRrL2lULzgyZURCZi9BWDJVTkJMdzY1VVFwaVRX?=
 =?utf-8?B?SmFJSFNWcVFkQllwNWpBeit0K2MxNjJXMlVpdFUyM001NUNhbi94WFpibkF2?=
 =?utf-8?B?TDZnSTBMRW5ER0VCcGVpa3VjRnZUN05OeXREV2MxTHo3bXhFSUdYWW04dUlO?=
 =?utf-8?B?MEx3VXh0WjRoOEdHYTNPRjgrd083dUpnc3BJeUp5d3RrNy9oaitUMEJsK0lY?=
 =?utf-8?B?NFovNEx2UEZ2dTl2YkQrSS93ZTIvT0M0SzFnb1JpUldGeXpDcFFrOVU1WXJJ?=
 =?utf-8?B?Z0MwNE5nMFVnZGZGdGJHNWx3TXNuOFAzd3U3eG8xOWRGVTZEYlc0bFlQR3pF?=
 =?utf-8?B?aDVRN0N0cHkyTGtZN2duRXAvK2xtditQQktMS0kyQUdoNlVqeWFzL2U5eWdr?=
 =?utf-8?B?akZBc1N5ZHd5em0vNjAxQU1VQkNZV1hIVFI1UmdFWDU2UzVXWFdLTGtoT1Jn?=
 =?utf-8?B?Q1NBZE5zcTNVeUUyVm0wSm15ZGN0SEdVUnBpQWNrcEVKRHBSb0dmUngrTnRW?=
 =?utf-8?B?TTM0WTlsSjdBNmZobENRc00xZ1F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C40A7044E124954B9CC9AF9E32B9FD54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bc4a00-5245-4b4a-1cbf-08d9b9812e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 12:57:53.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJQPfzRTcbAlgt2tNlABr2SpMF8EaFrl7nSVR/MW1XZIW1bCWrp2144xcl6i1e1UQ69kXXS8dwtzWI8o36lDkuTSkcHwXOa3wKvcLHagBH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3414
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiAwNy8xMi8yMSAxNTo0MSwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDAyLjEyLjIwMjEgMDU6NTUsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pg0KPj4gVGhpcyBwYXRjaCBpcyBiYXNlZCBv
biBzaW1pbGFyIGNvZGUgZnJvbSB0aGUgbGludXg0c2FtL2xpbnV4LWF0OTEgR0lUDQo+PiByZXBv
c2l0b3J5Lg0KPj4NCj4+IEZvciB0aGUgU0RJTyBkcml2ZXIsIHRoZSBSRVNFVC9FTkFCTEUgcGlu
cyBvZiBXSUxDMTAwMCBtYXkgYmUNCj4+IGNvbnRyb2xsZWQgdGhyb3VnaCB0aGUgU0RJTyBwb3dl
ciBzZXF1ZW5jZSBkcml2ZXIuICBUaGlzIGNvbW1pdCBhZGRzDQo+PiBhbmFsb2dvdXMgc3VwcG9y
dCBmb3IgdGhlIFNQSSBkcml2ZXIuICBTcGVjaWZpY2FsbHksIGR1cmluZyBidXMNCj4+IHByb2Jp
bmcsIHRoZSBjaGlwIHdpbGwgYmUgcmVzZXQtY3ljbGVkIGFuZCBkdXJpbmcgdW5sb2FkaW5nLCB0
aGUgY2hpcA0KPj4gd2lsbCBiZSBwbGFjZWQgaW50byByZXNldCBhbmQgZGlzYWJsZWQgKGJvdGgg
dG8gcmVkdWNlIHBvd2VyDQo+PiBjb25zdW1wdGlvbiBhbmQgdG8gZW5zdXJlIHRoZSBXaUZpIHJh
ZGlvIGlzIG9mZikuDQo+Pg0KPj4gQm90aCBSRVNFVCBhbmQgRU5BQkxFIEdQSU9zIGFyZSBvcHRp
b25hbC4gIEhvd2V2ZXIsIGlmIHRoZSBFTkFCTEUgR1BJTw0KPj4gaXMgc3BlY2lmaWVkLCB0aGVu
IHRoZSBSRVNFVCBHUElPIGFsc28gbXVzdCBiZSBzcGVjaWZpZWQgYXMgb3RoZXJ3aXNlDQo+PiB0
aGVyZSBpcyBubyB3YXkgdG8gZW5zdXJlIHByb3BlciB0aW1pbmcgb2YgdGhlIEVOQUJMRS9SRVNF
VCBzZXF1ZW5jZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNb3NiZXJnZXItVGFuZyA8
ZGF2aWRtQGVnYXVnZS5uZXQ+DQo+PiAtLS0NCj4+ICAgLi4uL25ldC93aXJlbGVzcy9taWNyb2No
aXAsd2lsYzEwMDAueWFtbCAgICAgIHwgMTEgKysrDQo+PiAgIC4uLi9uZXQvd2lyZWxlc3MvbWlj
cm9jaGlwL3dpbGMxMDAwL01ha2VmaWxlICB8ICAyICstDQo+PiAgIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuaCB8ICAyICsNCj4+ICAgLi4uL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmggIHwgMTAgKysrDQo+PiAgIC4uLi9uZXQvd2ly
ZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3Bvd2VyLmMgICB8IDczICsrKysrKysrKysrKysrKysr
KysNCj4+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jIHwg
MTUgKysrLQ0KPj4gICAuLi4vbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMg
ICAgfCAgMiArLQ0KPj4gICA3IGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL3Bvd2VyLmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWlj
cm9jaGlwLHdpbGMxMDAwLnlhbWwNCj4+IGluZGV4IDZjMzU2ODIzNzdlNi4uMmNlMzE2ZjVlMzUz
IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93
aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAueWFtbA0K
Pj4gQEAgLTMyLDYgKzMyLDE1IEBAIHByb3BlcnRpZXM6DQo+PiAgICAgY2xvY2stbmFtZXM6DQo+
PiAgICAgICBjb25zdDogcnRjDQo+Pg0KPj4gKyAgZW5hYmxlLWdwaW9zOg0KPj4gKyAgICBtYXhJ
dGVtczogMQ0KPj4gKyAgICBkZXNjcmlwdGlvbjogQSBHUElPIGxpbmUgY29ubmVjdGVkIHRvIHRo
ZSBFTkFCTEUgbGluZS4gIElmIHRoaXMNCj4+ICsgICAgICBpcyBzcGVjaWZpZWQsIHRoZW4gcmVz
ZXQtZ3Bpb3MgYWxzbyBtdXN0IGJlIHNwZWNpZmllZC4NCj4+ICsNCj4+ICsgIHJlc2V0LWdwaW9z
Og0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKyAgICBkZXNjcmlwdGlvbjogQSBHUElPIGxpbmUg
Y29ubmVjdGVkIHRvIHRoZSBSRVNFVCBsaW5lLg0KPj4gKw0KPiBCaW5kaW5ncyBzaG91bGQgZ28g
dGhyb3VnaCBhIGRpZmZlcmVudCBwYXRjaC4NCj4NCj4+ICAgcmVxdWlyZWQ6DQo+PiAgICAgLSBj
b21wYXRpYmxlDQo+PiAgICAgLSBpbnRlcnJ1cHRzDQo+PiBAQCAtNTEsNiArNjAsOCBAQCBleGFt
cGxlczoNCj4+ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDI3IDA+Ow0KPj4gICAgICAgICAgIGNs
b2NrcyA9IDwmcGNrMT47DQo+PiAgICAgICAgICAgY2xvY2stbmFtZXMgPSAicnRjIjsNCj4+ICsg
ICAgICAgIGVuYWJsZS1ncGlvcyA9IDwmcGlvQSA1IDA+Ow0KPj4gKyAgICAgICAgcmVzZXQtZ3Bp
b3MgPSA8JnBpb0EgNiAwPjsNCj4+ICAgICAgICAgfTsNCj4+ICAgICAgIH07DQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9NYWtlZmls
ZSBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9NYWtlZmlsZQ0KPj4g
aW5kZXggYzNjOWUzNGMxZWFhLi5iYWY5ZjAyMWExZDYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvTWFrZWZpbGUNCj4+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9NYWtlZmlsZQ0KPj4gQEAgLTIsNyAr
Miw3IEBADQo+PiAgIG9iai0kKENPTkZJR19XSUxDMTAwMCkgKz0gd2lsYzEwMDAubw0KPj4NCj4+
ICAgd2lsYzEwMDAtb2JqcyA6PSBjZmc4MDIxMS5vIG5ldGRldi5vIG1vbi5vIFwNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGhpZi5vIHdsYW5fY2ZnLm8gd2xhbi5vDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICBoaWYubyB3bGFuX2NmZy5vIHdsYW4ubyBwb3dlci5vDQo+Pg0KPj4gICBv
YmotJChDT05GSUdfV0lMQzEwMDBfU0RJTykgKz0gd2lsYzEwMDAtc2Rpby5vDQo+PiAgIHdpbGMx
MDAwLXNkaW8tb2JqcyArPSBzZGlvLm8NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvaGlmLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNy
b2NoaXAvd2lsYzEwMDAvaGlmLmgNCj4+IGluZGV4IGNjY2Q1NGVkMDUxOC4uYTU3MDk1ZDgwODhl
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L2hpZi5oDQo+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAv
aGlmLmgNCj4+IEBAIC0yMTMsNCArMjEzLDYgQEAgdm9pZCB3aWxjX25ldHdvcmtfaW5mb19yZWNl
aXZlZChzdHJ1Y3Qgd2lsYyAqd2lsYywgdTggKmJ1ZmZlciwgdTMyIGxlbmd0aCk7DQo+PiAgIHZv
aWQgd2lsY19nbnJsX2FzeW5jX2luZm9fcmVjZWl2ZWQoc3RydWN0IHdpbGMgKndpbGMsIHU4ICpi
dWZmZXIsIHUzMiBsZW5ndGgpOw0KPj4gICB2b2lkICp3aWxjX3BhcnNlX2pvaW5fYnNzX3BhcmFt
KHN0cnVjdCBjZmc4MDIxMV9ic3MgKmJzcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBjZmc4MDIxMV9jcnlwdG9fc2V0dGluZ3MgKmNyeXB0byk7DQo+PiAraW50
IHdpbGNfb2ZfcGFyc2VfcG93ZXJfcGlucyhzdHJ1Y3Qgd2lsYyAqd2lsYyk7DQo+PiArdm9pZCB3
aWxjX3dsYW5fcG93ZXIoc3RydWN0IHdpbGMgKndpbGMsIGJvb2wgb24pOw0KPj4gICAjZW5kaWYN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAv
bmV0ZGV2LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2
LmgNCj4+IGluZGV4IGI5YTg4YjNlMzIyZi4uYjk1YTI0NzMyMmE2IDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oDQo+PiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmgNCj4+IEBA
IC0xOTcsNiArMTk3LDE1IEBAIHN0cnVjdCB3aWxjX3ZpZiB7DQo+PiAgICAgICAgICBzdHJ1Y3Qg
Y2ZnODAyMTFfYnNzICpic3M7DQo+PiAgIH07DQo+Pg0KPj4gK3N0cnVjdCB3aWxjX3Bvd2VyX2dw
aW9zIHsNCj4+ICsgICAgICAgaW50IHJlc2V0Ow0KPj4gKyAgICAgICBpbnQgY2hpcF9lbjsNCj4+
ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCB3aWxjX3Bvd2VyIHsNCj4+ICsgICAgICAgc3RydWN0IHdp
bGNfcG93ZXJfZ3Bpb3MgZ3Bpb3M7DQo+PiArfTsNCj4+ICsNCj4+ICAgc3RydWN0IHdpbGNfdHhf
cXVldWVfc3RhdHVzIHsNCj4+ICAgICAgICAgIHU4IGJ1ZmZlcltBQ19CVUZGRVJfU0laRV07DQo+
PiAgICAgICAgICB1MTYgZW5kX2luZGV4Ow0KPj4gQEAgLTI2NSw2ICsyNzQsNyBAQCBzdHJ1Y3Qg
d2lsYyB7DQo+PiAgICAgICAgICBib29sIHN1c3BlbmRfZXZlbnQ7DQo+Pg0KPj4gICAgICAgICAg
c3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmhpZl93b3JrcXVldWU7DQo+PiArICAgICAgIHN0cnVj
dCB3aWxjX3Bvd2VyIHBvd2VyOw0KPiBGb3IgU0RJTyBwb3dlciBzaG91bGQgYmUgY29udHJvbGxl
ZCB0aG91Z2ggTU1DIHB3cnNlcSBkcml2ZXIuIFRodXMgSSB3b3VsZA0KPiBrZWVwIHRoaXMgY29k
ZSBmb3IgU1BJIG9ubHkgYW5kIG1vdmUgdGhpcyBtZW1iZXIgdG8gc3RydWN0IHdpbGNfc3BpLg0K
Pg0KPj4gICAgICAgICAgc3RydWN0IHdpbGNfY2ZnIGNmZzsNCj4+ICAgICAgICAgIHZvaWQgKmJ1
c19kYXRhOw0KPj4gICAgICAgICAgc3RydWN0IG5ldF9kZXZpY2UgKm1vbml0b3JfZGV2Ow0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9wb3dl
ci5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3Bvd2VyLmMNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmQyNmEzOWI3Njk4
ZA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9j
aGlwL3dpbGMxMDAwL3Bvd2VyLmMNCj4+IEBAIC0wLDAgKzEsNzMgQEANCj4+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKy8qDQo+PiArICogQ29weXJpZ2h0IChjKSAy
MDEyIC0gMjAxOCBNaWNyb2NoaXAgVGVjaG5vbG9neSBJbmMuLCBhbmQgaXRzIHN1YnNpZGlhcmll
cy4NCj4+ICsgKiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiBUaGlzIGlzIG5vdCBpbiB0aGUgR0lU
IHJlcG8uIEl0IHNob3VsZCBoYXZlIGJlZW46DQo+ICJDb3B5cmlnaHQgKGMpIDIwMjEgTWljcm9j
aGlwIFRlY2hub2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcyINCj4gCQleDQo+IAkJY3Vy
cmVudCB5ZWFyDQo+DQo+PiArICovDQo+PiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+PiAr
I2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICsj
aW5jbHVkZSA8bGludXgvb2ZfZ3Bpby5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC92ZXJzaW9uLmg+
DQo+PiArDQo+PiArI2luY2x1ZGUgIm5ldGRldi5oIg0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHdp
bGNfb2ZfcGFyc2VfcG93ZXJfcGlucygpIC0gcGFyc2UgcG93ZXIgc2VxdWVuY2UgcGlucw0KPj4g
KyAqDQo+PiArICogQHdpbGM6ICAgICAgd2lsYyBkYXRhIHN0cnVjdHVyZQ0KPj4gKyAqDQo+PiAr
ICogUmV0dXJuczogICAgIDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgbnVtYmVyIG9uIGZh
aWx1cmVzLg0KPj4gKyAqLw0KPj4gK2ludCB3aWxjX29mX3BhcnNlX3Bvd2VyX3BpbnMoc3RydWN0
IHdpbGMgKndpbGMpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm9mID0g
d2lsYy0+ZGV2LT5vZl9ub2RlOw0KPj4gKyAgICAgICBzdHJ1Y3Qgd2lsY19wb3dlciAqcG93ZXIg
PSAmd2lsYy0+cG93ZXI7DQo+PiArICAgICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICAgIHBv
d2VyLT5ncGlvcy5yZXNldCA9IG9mX2dldF9uYW1lZF9ncGlvX2ZsYWdzKG9mLCAicmVzZXQtZ3Bp
b3MiLCAwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOVUxMKTsNCj4+ICsgICAgICAgcG93ZXItPmdwaW9zLmNoaXBfZW4gPSBvZl9nZXRf
bmFtZWRfZ3Bpb19mbGFncyhvZiwgImNoaXBfZW4tZ3Bpb3MiLCAwLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KPiBDb25z
aWRlciB1c2luZyBncGlvIGRlc2NyaXB0b3JzIGFuZCBkZXZtX2dwaW9kX2dldCgpLg0KPg0KPj4g
KyAgICAgICBpZiAoIWdwaW9faXNfdmFsaWQocG93ZXItPmdwaW9zLnJlc2V0KSkNCj4+ICsgICAg
ICAgICAgICAgICByZXR1cm4gMDsgICAgICAgLyogYXNzdW1lIFNESU8gcG93ZXIgc2VxdWVuY2Ug
ZHJpdmVyIGlzIHVzZWQgKi8NCj4gSW4gY2FzZSBvZiBTRElPIHdlIHNob3VsZCByZWx5IG9uIG1t
YyBwd3JzZXEgYWxsIHRoZSB0aW1lLiBJdCBrZWVwcyB0aGluZ3MNCj4gY2xlYW5lci4gSSB3b3Vs
ZCBrZWVwIHRoZSBjb2RlIGluIHRoaXMgZmlsZSBvbmx5IGZvciBTUEkuDQo+DQo+PiArDQo+PiAr
ICAgICAgIGlmIChncGlvX2lzX3ZhbGlkKHBvd2VyLT5ncGlvcy5jaGlwX2VuKSkgew0KPj4gKyAg
ICAgICAgICAgICAgIHJldCA9IGRldm1fZ3Bpb19yZXF1ZXN0KHdpbGMtPmRldiwgcG93ZXItPmdw
aW9zLmNoaXBfZW4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IkNISVBfRU4iKTsNCj4+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgfQ0KPj4gKyAgICAgICByZXR1cm4g
ZGV2bV9ncGlvX3JlcXVlc3Qod2lsYy0+ZGV2LCBwb3dlci0+Z3Bpb3MucmVzZXQsICJSRVNFVCIp
Ow0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTCh3aWxjX29mX3BhcnNlX3Bvd2VyX3BpbnMp
Ow0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHdpbGNfd2xhbl9wb3dlcigpIC0gaGFuZGxlIHBvd2Vy
IG9uL29mZiBjb21tYW5kcw0KPj4gKyAqDQo+PiArICogQHdpbGM6ICAgICAgd2lsYyBkYXRhIHN0
cnVjdHVyZQ0KPj4gKyAqIEBvbjogICAgICAgICAgICAgICAgcmVxdWVzdGVkIHBvd2VyIHN0YXR1
cw0KPj4gKyAqDQo+PiArICogUmV0dXJuczogICAgbm9uZQ0KPj4gKyAqLw0KPj4gK3ZvaWQgd2ls
Y193bGFuX3Bvd2VyKHN0cnVjdCB3aWxjICp3aWxjLCBib29sIG9uKQ0KPj4gK3sNCj4+ICsgICAg
ICAgaWYgKCFncGlvX2lzX3ZhbGlkKHdpbGMtPnBvd2VyLmdwaW9zLnJlc2V0KSkgew0KPj4gKyAg
ICAgICAgICAgICAgIC8qIEluIGNhc2UgU0RJTyBwb3dlciBzZXF1ZW5jZSBkcml2ZXIgaXMgdXNl
ZCB0byBwb3dlciB0aGlzDQo+PiArICAgICAgICAgICAgICAgICogZGV2aWNlIHRoZW4gdGhlIHBv
d2VyaW5nIHNlcXVlbmNlIGlzIGhhbmRsZWQgYnkgdGhlIGJ1cw0KPj4gKyAgICAgICAgICAgICAg
ICAqIHZpYSBwbV9ydW50aW1lXyogZnVuY3Rpb25zLiAqLw0KPiBJIHNlZSB0aGlzIGZ1bmN0aW9u
IGlzIGNhbGxlZCBhbnl3YXkgb25seSBpbiBTUEkgY29udGV4dCwgc28sIGRvbid0IHRoaW5rDQo+
IHRoaXMgaGFuZGxpbmcgZm9yIFNESU8gaXMgbmVjZXNzYXJ5LiBNYXliZSB0aGVzZSBpcyBzb21l
dGhpbmcgSSBtaXNzIHdpdGgNCj4gcmVnYXJkcyB0byBpdC4gQWpheSwgcGxlYXNlIGNvcnJlY3Qg
bWUgaWYgSSdtIHdyb25nLg0KDQoNClllcywgJ3dpbGNfd2xhbl9wb3dlcicgZnVuY3Rpb24gaXMg
Y2FsbGVkIGZvciBTUEkgYnVzLiBUaGUgY29tbWVudHMgDQooLyoqLykgc3BlY2lmaWMgdG8gU0RJ
TyBjYW4gYmUgcmVtb3ZlZCwgdGhvdWdoIHRoZSBHUElPJ3MgdmFsaWRpdHkgY2hlY2sgDQppcyBy
ZXF1aXJlZCB0byB2ZXJpZnkgR1BJTyBlbnRyaWVzLg0KDQoNClJlZ2FyZHMsDQoNCkFqYXkNCg0K
