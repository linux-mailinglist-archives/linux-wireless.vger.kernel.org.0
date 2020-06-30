Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF120EBE6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 05:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgF3DRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 23:17:06 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:47926 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgF3DRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 23:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593487025; x=1625023025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eF7/2U667xS+89eN//YAmoJuD5HQu7GqPyx0qJJpXx4=;
  b=DN197/UmNYgnGmDP/vtvcNV66sPzenXriX7tHoyeP2RN4n4iZyHz3p27
   afGjTKg49H8VvqiSVoANQ+HxC6If5cQtcmF2KjyJ6QxUgnFi47Zi+n2j3
   cPlMrjSsc3Nz3oRLAjwGqSCgeNlD0WOwdvdJuGrO34CdJegt8/C5BST3A
   wan1wJaIof2XUEybNyfDRlIdUSy3FOdzic4NJnF5X0fgwLd0zNX7fPr5v
   JSV2AQL+OpvChpkX7PricCdlX0pB7HFJUkhKYV2QIB+vssXkeg6FjImxA
   SGND6L03RrPXgduFWIRAajHMDNWiDoovErsEwdDTyds5lNqNZSdORaKIW
   A==;
IronPort-SDR: /UJ6+GygTyRttc1j+/3xk1S/JZ7ArdGvhBZoLMwunRupzgTzUidWvGgzTT1MoebggArEgbrlFG
 oQeE8IpwPNg4k13LB7CeqAoNbivOTziryYsrvpzpKoS1wCjd0v2cJ6hW98QPyDFWxzxbF/xCXx
 EkgGEKrxCU4zoP+vHHfL0e4np0Bkg5K9LkXUGUM9YiRq3xy/ddy3gb7j87hxVPce7oNyS5xyKv
 23+8apj4xda4/T5SY9WMH52y800XqqtiihPAmbllSw1mbh2mlhJqlPTEPb2PdA1KnKIVWjaF/+
 va8=
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="82003439"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2020 20:17:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 20:16:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 29 Jun 2020 20:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9Ubp34BUiggKo9Ved2E4kaWn9QKlvtpR/lzBLSrhrFIFOmUFsB80czBDVJD3O1dgEmYRmgaE/vcirpaY6PHUQ1nkG786ZyyJqTZf3IuJEoVh+d79LtPkXvJuMKkGsq2Sdujmv7aXUcKyaECm/5ZAuVTRo5Ww1A1gADnwq9lMFqJI1Yb3Nbohe3hR/OOW66KBmNmyil/HAhKPtaCscpLlZ+J98nn3J0GTZw5ovbyUGHn7211qU8txzVRC1qN4hMroOpOz7becI2G4l3uKsGAvyXywZtjXxxIMqAgY96/kJi5f9/7DzyK58+KDUX40ID8ycjolO6WKniy7WbZAs5T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF7/2U667xS+89eN//YAmoJuD5HQu7GqPyx0qJJpXx4=;
 b=W2b4CjtO6C8pGa4Tsbtc9tvk92vqPLoOAMF9IOWQYvVKxnaErYEnlEw9gF5rDhXT85CAoXMTsScGMkcALrlvpsrblO5ODQfUGfIyUp0Aw/psD2/tYoymWmxceCORxIPBlvtjmCtcndqwF/lSQq8VPJ78tmpC+23ZbkOu+LH6uLJWtK3hkKXgmabT95oXlzHZM0DS2KjuVoJh38SNpeulNAT/O35GAyv6wrXXD94pa8pIZr5LsG1gCPxthmyoPqNNYaBRidKWiNgGgN6umsbpInM2Hj4NEkoQjnxdlNoM01oUEFr6wRmhWs7JonPtfPTQtop541uJXOGfrX3tRUA9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF7/2U667xS+89eN//YAmoJuD5HQu7GqPyx0qJJpXx4=;
 b=AuA+1KxAqRw0fjaaoAnear39hxZkTiFu9SbgtyVjdutSRMHgOwB/sDv9LNjhPLVUFcuAhbckwSxz/Ayy/P3zh8LMa35KLDf5eiQw5pFQU7gVnSMznmZ+SC3VXsaQ/EKbzvWE/TwAJCKX155NI3GKlBHn0OPPrp1xVRlIzn/5OL0=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3774.namprd11.prod.outlook.com (2603:10b6:208:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 03:17:01 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 03:17:01 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <pali@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
Thread-Topic: [PATCH v7 00/17] wilc1000: move out of staging
Thread-Index: AQHWSU1z8nHvJKTVrkqyNvSWLHZdH6jvnxsAgADoIAA=
Date:   Tue, 30 Jun 2020 03:17:01 +0000
Message-ID: <c23ca5da-b9db-5e98-94e4-edc84ded9611@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
 <20200629132612.nl6rfpihzlii6ilh@pali>
In-Reply-To: <20200629132612.nl6rfpihzlii6ilh@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [49.207.206.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdb4d1af-80e8-451c-34bf-08d81ca40e95
x-ms-traffictypediagnostic: MN2PR11MB3774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37743CCDAC38E621A3610E04E36F0@MN2PR11MB3774.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzK4R0Px6mxmWsLyGMHN4FeMRv5scIeO/d9mdsAUJNcgH0uI5s+JVmx6hUqpIhyD0SB2UgNCa4FJPwviSvSd1Rn3yM9t6tnfQOms/b//O9SRbtrVk3Sukyy2QxSs5Qh+qBnKRKKNttlyw9ygUwNXmQThvfqWEavkAKRsUZ4QdhTh6xk/NOWo0DGx53HwCGq5w1gfHS1MxW5WWEUO/dme3Pn1ip92FVL95s8j4hJjEYNpeXoddoXKrcbNStq4auguobW4yA08Cl+BqsIBsm4leS+/cGgCnJS3aLPRh8COOHYlJ3SiAhqpMEFYUSO8b/uoQzX9C+o8ver5vNSklufhnZZT1oioJj/pkEkqQF+54uG1onA99CdWAytsvgnfHaGLYgNJHONPdwkwGdQ07ylXwvMIF8ChQoO7X7RXePnYneOvYXKMHxcPhv3oNlONZnKic/ZHDtEFz9ShnpzqKf+Z2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(36756003)(83380400001)(8936002)(6512007)(53546011)(55236004)(316002)(54906003)(107886003)(71200400001)(6506007)(6916009)(4326008)(2616005)(86362001)(6486002)(8676002)(76116006)(66556008)(66476007)(66446008)(478600001)(64756008)(186003)(966005)(2906002)(31686004)(26005)(4744005)(66946007)(31696002)(5660300002)(91956017)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZAS/dl8cUEPXBG7uwkpUVfWGVaoFdCTb3MAfR5Lh0XSnJWea0AGkZsV40FwuAjLb+tBL3mmzkhfvq1Kj2RRRknuoNFOcgt1ZMQ/i+H8WwP0k+qyUwnLQRdZBFyAqascmTKB7kl0051TVw6OvTMus3QRCl1/qOYpsh5XXSavEqhjcnFzin0ljBYN96DemM0jipRDX5O7Q8zPRkJ63lKUC16pJlFBrJFzk4RRkeyZ90IiAvQwPZa+BReQ/xZrxxS/zVyYnJ8j6yXZke7htYRMwqaZAViO6etmCsdGdxkzgxt8mW18QFBsi+elc8dO9tcO4XiGNY8Va5heqM5+NhS7ewCgM7ff8yoxaVRyzQQnsaM85MbH6/pRWRM52kjADNzqPhMHVi9MBPSxQg3Y+N2TwI6vH47eCrjjkKemeXQNgc5exkHyCZ+1yLJ/8KtGAl0i4hPTt09JpSXB9pwQSeBZ0oU7IWA0Xu/KAeDt+qJVYxCg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65F9A0FE50CC5E499FB96DB7C34C2575@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb4d1af-80e8-451c-34bf-08d81ca40e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:17:01.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSdFTaqSTx8y3D9KgyU7LoLgP+ORKu1mjamPMD9lvlxtYSWcQ8Kyyu8yLJkz58rpJbhpWmMZ5ZVOB5ntgv2GrMN0cuD0lAUF44i8mkLBqJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3774
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDI5LzA2LzIwIDY6NTYgcG0sIFBhbGkgUm9ow6FyIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZXNkYXkgMjMgSnVuZSAyMDIwIDEx
OjAwOjA0IEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBUaGlzIHBhdGNoIHNl
cmllcyBpcyB0byByZXZpZXcgYW5kIG1vdmUgd2lsYzEwMDAgZHJpdmVyIG91dCBvZiBzdGFnaW5n
Lg0KPj4gTW9zdCBvZiB0aGUgcmV2aWV3IGNvbW1lbnRzIHJlY2VpdmVkIGluIFsxXSAmIFsyXSBh
cmUgYWRkcmVzc2VkIGluIHRoZQ0KPj4gbGF0ZXN0IGNvZGUuDQo+PiBQbGVhc2UgcmV2aWV3IGFu
ZCBwcm92aWRlIHlvdXIgaW5wdXRzLg0KPiANCj4gSGVsbG8gQWpheSEgQ291bGQgeW91IHBsZWFz
ZSBtb3ZlIFNESU8gdmVuZG9yL2RldmljZSBJRCBkZWZpbml0aW9ucyBmcm9tDQo+IGRyaXZlciBj
b2RlIHdpbGMxMDAwL3NkaW8uYyB0byBjb21tb24gZmlsZSBpbmNsdWRlL2xpbnV4L21tYy9zZGlv
X2lkcy5oPw0KPiANCg0KQ3VycmVudGx5LCB0aGUgd2lsYzEwMDAgZHJpdmVyIG1vdmVtZW50IGNo
YW5nZXMgYXJlIHByZXNlbnQgaW4gdG9waWMNCmJyYW5jaCBhbmQgeWV0IHRvIGJlIG1lcmdlZCB0
byBtYXN0ZXIgYnJhbmNoLiBXb3VsZCBpdCBiZSBva2F5IHRvIHN1Ym1pdA0KdGhlIG5ldyBwYXRj
aCBvbmNlIGRyaXZlciBpcyBtZXJnZWQgdG8gJ3dpcmVsZXNzLWRyaXZlci1uZXh0JyBtYXN0ZXIg
YW5kDQpicmFuY2ggaXMgcHVsbGVkIGludG8gR3JlZydzIHN0YWdpbmcgcmVwby4NCg0KUmVnYXJk
cywNCkFqYXkNCg0KPiBTaW1pbGFyIGNsZWFudXAgd2FzIHJlY2VudGx5IGZpbmlzaGVkIGZvciBh
bGwgZXhpc3Rpbmcgbm9uLXN0YWdpbmcgZHJpdmVyczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtbW1jLzIwMjAwNTIyMTQ0NDEyLjE5NzEyLTEtcGFsaUBrZXJuZWwub3JnLw0KPiA=
