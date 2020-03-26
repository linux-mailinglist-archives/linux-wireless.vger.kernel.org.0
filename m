Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F84193A82
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 09:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCZIMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 04:12:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14773 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgCZIMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 04:12:41 -0400
IronPort-SDR: 2GNsSfZBakrU/jJJAHxDTjy1EKcKdASf5UlHLtZr+2UDnssQScmZq0FtIhFfSycqJ4WXpdOBU8
 J6PwcpKWSDti4kEUfvKtY6ayLYRrOCHb46HNXqDVPPD0E+1kQ/XLvon1I/sGf4IWfPCaQP8Uka
 D8HTUJcRqhMQ4YBuvIrgwjayIESw0Mcy+Yn2oPUcz1MeUAxcen0lI32VNENqeEa7ozc9YXfFgY
 FDCoA+7UhsPl5I1j4dFBNOLMj7w4MpnIvlDqeGJwugzBU++c4YApApU2YDgAKTKEaIzDtw+si1
 ZhE=
X-IronPort-AV: E=Sophos;i="5.72,307,1580799600"; 
   d="scan'208";a="70249287"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 01:12:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 01:12:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 01:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNBuvQcKOvs6IPk2kXsHl10Vir4kpYIg1N65pdj8n8uKYsJsKR1LiilSX4G+zDGvsl3FH+tSfUOy7KHLSJ0evOfClnRbwTsfGZfJKiyAyM8xElmV6gryh48SxJJ/05S8fJ0OBbxtCXhkryQZppiFmn8MBGRg3tCDNO4Iu9nXjSEv+s9ItBGkv9EQ4Vd+XeldRDJ/iyNNuoPi7O/7wBPM75v0NEVYmwCBAv2sMAT+uLwbAk5X8KOlqh6Vfj2mEn7tuNNeJp3xApQ7pL+S/yecurwR2t6GQvXDizyALFSHUwMpHyqN7eCQtH2S0JvCDKLoo4jRStg8AfdGSwPrNZBfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynhFTjkfOZvG0Wxe4Lxm7iNU1ie+XzpI5ylFp1p/TNU=;
 b=WA5iE4Rap/aBTRU0bjSqM9Iwy3QXlQZsWzzqXDZ3/ZZWnlB1FgPa9Dz8HJQDwAVM2EgexTfp7e0e5lUeE7G/iIIDhZbL7SVA4LbVUtcltnB7tai+GVZODn5sGVZSG5Hhc2Sfboml9Uax/0nf8ZTs4yy8BGcVJBvNZoerjAhVCmGnXgckqbBBHbv04ywuBUgAxrD49+aYSRm/6NtjUc9Ef20av5ou8n7bNXE3ZqxrHm2VD6hkOF7VevWPhv3iDdzNCGm4oy+29UubJtGVaK9ZcFplPzSr+xPQC1Ls4E2e8vnWlTksqZ3c1BuLLSTtjylBO50hht4cfxRdQ25aGH7DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynhFTjkfOZvG0Wxe4Lxm7iNU1ie+XzpI5ylFp1p/TNU=;
 b=R/pLoZKiT3zRQDVaIfCuSHs/eHs8vyLYO3KsXBiNFVilxXIRQpbXdjs01L8L36obPC+EnOkUh8zQkkzOvNHz0cU504DkV2f6DjEqbW4YGINkJpE89p8173uqhbGm5BaGFwE4DDsiAee05bw5pwmhi2b0CFdfZQmRNAy7/1CrmEs=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2950.namprd11.prod.outlook.com (2603:10b6:a03:8f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 08:12:38 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Thu, 26 Mar 2020
 08:12:38 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <robh@kernel.org>
Subject: Re: [PATCH] staging: wilc1000: remove label from examples in DT
 binding documentation
Thread-Topic: [PATCH] staging: wilc1000: remove label from examples in DT
 binding documentation
Thread-Index: AQHWAsRltX69oPURgUSNLfUw6CPRa6haf6o5gAAHagA=
Date:   Thu, 26 Mar 2020 08:12:38 +0000
Message-ID: <25ec81ba-e060-3c0f-2a57-1248a5fd21a7@microchip.com>
References: <20200325164234.14146-1-ajay.kathat@microchip.com>
 <87v9mrpnjh.fsf@tynnyri.adurom.net>
In-Reply-To: <87v9mrpnjh.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a997e20a-a975-469a-1383-08d7d15d72eb
x-ms-traffictypediagnostic: BYAPR11MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB29508F6EAD21A682C77EADC7E3CF0@BYAPR11MB2950.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(6512007)(71200400001)(53546011)(86362001)(54906003)(81166006)(316002)(26005)(8936002)(31696002)(186003)(2906002)(966005)(478600001)(91956017)(4744005)(6916009)(66446008)(5660300002)(6506007)(6486002)(4326008)(81156014)(66476007)(2616005)(31686004)(66946007)(64756008)(8676002)(66556008)(76116006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2950;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJ9pGH0jTGpHQNYkfGeFddjdMvrWMl5AfkF5yq1P3WG/YEubZnr0XQHWEoJMd3Yv/UmnA56aBpLJWbVxNBPI3xF4Q0ZsJXLMov6neARJPs1v9ZEqf7irK4CybfSEDSIos9FoLhbsFXLDFluv/9iTGrAM67UxDuqMwGdv1SdxZb+UfjxXw3Tha7k2bOnO2rAyRNUN36d+FykRi6Z0nFM6IMpP4l+b5Vx79Zov38hf3f8vMKWVUUd/pfIhXNY29S266ZWgOmoWhX/pErfrin+1zwx8eS0Ju77xWkl0EOQ9QdlWoC0esQ3ylKhT0RaluNAbfa1Oh8zKApnBF803nZ0tF15RaB457VA1sX5PYgbheRuXNYAUpbysnvaphfjvcogQE7BuZJllt9cz2tZsde0dEkzBOrczBl0thMkmck+6z9SuZ84zY2yPeHQCS2+SL0zOgYbWkx7JBzVawICaUzWO56S7lBISQQMgCeE4w0SOLFmeRrWzTv3RTpioYC/Sy5mp//qIKk6B7nMYFj2ritEoqQ==
x-ms-exchange-antispam-messagedata: wLTgFa6RTBf6ZZdYjEvDKTQvsGSIj+3sUo64aNYVMULa0Os3QhUlQItnL72Cc1to+iil5p/JYJua1Tu+4SHs8T+2N16I23Sx1lyTLXGhXtZs9TKZdUQ4Aj542L0xje4XjlXjd/CuvXEZml2Fh5K4Ww==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFFCF2F9A3854F48AEEDE2085579C895@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a997e20a-a975-469a-1383-08d7d15d72eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 08:12:38.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPyaSprehrbcgsaSI3wOmD4vYLOAAjSYMWt0bLW2OoqTFikS5sf9hxbk9Ywu0XRIu7Zx7ZMi4SjlUc3CQi8zH1TzuARDcWT6yIMRMnOZiBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2950
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDI2LzAzLzIwIDE6MTUgcG0sIEthbGxlIFZhbG8gd3JvdGU6DQo+IA0K
PiA8QWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbT4gd3JpdGVzOg0KPiANCj4+IEZyb206IEFqYXkg
U2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gUmVtb3ZlIGxhYmVscyBh
bmQgbm90IHJlbGV2YW50IHByb3BlcnR5IGZyb20gRFQgYmluZGluZyBkb2N1bWVudGF0aW9uDQo+
PiBleGFtcGxlcyBhcyBzdWdnZXN0ZWQgaW4gWzFdLg0KPj4NCj4+IDEuIGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcGF0Y2gvMTI1MjgzNw0KPiANCj4gSnVzdCBhIG5pdHBpY2sgYnV0IHBh
dGNod29yayBsaW5rcyBhcmUgbm90IHRoYXQgcmVsaWFibGUgaW4gdGhlIGxvbmcNCj4gcnVuLiBJ
bnN0ZWFkIHVzaW5nIGEgbG9yZSBsaW5rIGlzIGJldHRlciBhcyB0aGUgbWVzc2FnZSBpZCBpcyB2
aXNpYmxlDQo+IGRpcmVjdGx5IGZyb20gdGhlIFVSTC4NCj4gDQoNClN1cmUuIEkgd2lsbCBtYWtl
IHVzZSBvZiBsb3JlIGxpbmsgZm9yIGZ1dHVyZSBwYXRjaGVzIGFzIHRoaXMgcGF0Y2ggaXMNCmFs
cmVhZHkgYXBwbGllZC4NCg0KDQpSZWdhcmRzLA0KQWpheQ==
