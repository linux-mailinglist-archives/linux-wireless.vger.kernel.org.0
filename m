Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E532777035
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 08:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjHJGUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjHJGUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 02:20:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664A9C
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 23:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTx+WOLQUYUBNyzVwzLglR/q07QCXeGqEokvN2VtsWhzbQ2SCAtucOwWv6FO0fc9qdatClY7wkmjnEUDuFe+XbBiMPIkEE/ropNy2uLB6oymv7EiCM7IsrbhxqzaFeMifhsufv4Aiqg2GX4e5t3TFd2JUWUZ4GUxoJTAAi6ueBeV342KKyjRzbHWZHg4LQ4hTGRVhnVwXH3o/6giZXO/KZPm0r/kIZry71C9+oI6Y2mLztnG+WcQHCVafSIm+1O0+JFKa/FRcmoGZaXbaxPG+ckkWkdjxGkwWaKWj6MV1HdP5Au4w6mgpeBN+RxX+NQB22D8HNTkFzeIyMO1JpB55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubYH3BahL5BOsjbTCzHkmjoIDIclFBvANdEN58ww2yI=;
 b=ZzPlTY24TC0KrloHf2dugSeP/VitwIiozX5MSAPp72PN2TNhJvERVzi2JIeO1BWDds6yFUVIW9MN9Iv/G1tANXQ3baT+1iP9EztdUgmVKvImTwu23JWBowchxrwruVJW6mKUQDkBzjaIpAO7TysyVWc657qv+jG+FMdoyWgWswE9QhqTYaVfeWCKXHSsNkzdUqnuffjE/i0e3HzFhSrcJNh0En5ZcxBSyd37PR5oep/2xV3/vJpFnkCEKbPKnHfSlVYlUtID9InSTjIhogtT+TauBxot4ZQl/jlEjDcUuVUA4Hx+8aUpiw4B/x++bKT3Me7PczZKZxdqUuera2bpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubYH3BahL5BOsjbTCzHkmjoIDIclFBvANdEN58ww2yI=;
 b=rdvC2L8lwtGDZqtS335tU2d+MevrGj2EBJTHVTnT4jSQLdnTknfyzNFnsw69QN5b26ARb6NZLxY48+I2kvQPxCD8cHw3XCvlADIA6ighgZU0MXC1X6wLXUh+CNDYNp2/IGpzdSaGlK2g9BeqLV0Xg+GpQ8VJtigcJJ9DZX6xuhY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB10074.eurprd04.prod.outlook.com (2603:10a6:800:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 06:20:35 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:20:35 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhgABqs2AAAW//+A=
Date:   Thu, 10 Aug 2023 06:20:35 +0000
Message-ID: <PA4PR04MB96384714731A9A78B85D62F8D113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <2a069aea-7b5d-ed12-c5ec-9c1de3b6a9ac@quicinc.com>
In-Reply-To: <2a069aea-7b5d-ed12-c5ec-9c1de3b6a9ac@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB10074:EE_
x-ms-office365-filtering-correlation-id: 36b20096-eac3-473a-a0a8-08db9969e8a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGpVy8yAUFtKCaDRBDq4F79LXGKkghoCDijV31rp9d8l/1qNiYT3KbBjEqjxXc08giyyPOF9sjozmu3V9pdgPhXB8rjV1zPZgkiL1Dwbl9j4cAcxi2hHFB9AVETxwrFttE0o45hLjUzZ8Crb+Py+41EQnBa3VpuWB8MeVRmXIaVIl98qKQhrXXeZSPm3yCWLo1WICNvSZwc5HALozlal8SH8s/4aCQczWgO1cNFbb7EC6PbACVmRtd2G4QICIAhbruD1FB0NT13i7IIwyQjzwrwxaucJkmQGRlSN/zb0d9Te+5XzqY00ohRo4J23oAJCWFAJXX8Il9Apj63I6rmveTZtzKIiuCF5RmpojlpzOt0h+t1zD2olYfl4OSfrf8zC1t10sHiX7DoN7ZEv4lJ+qnnL5wBaV8ho9+CG7NDyNrnOIS2AV/kVKaCmqYrVOXIPfkSErG13oLa0wMl8EWOS2qFt/eVcyDyrmp3GODJQgphxzBGEewfI95XWx4UDsO1urSaygM5RR8J3ubxhYn95TNOuB0lYUEMCuvsxR5qyL4/RUqJF0brJITEfOiQEIuLnhuqZcNi1xQ+GuCZpTwVy/iijKsP9v5OLtz1HaB2E9FT9teNdL+DW0GQcSQh7FXVx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(1800799006)(451199021)(186006)(54906003)(38100700002)(110136005)(4326008)(76116006)(8676002)(8936002)(66946007)(66476007)(66446008)(66556008)(64756008)(2906002)(86362001)(478600001)(41300700001)(38070700005)(5660300002)(83380400001)(316002)(52536014)(71200400001)(122000001)(7696005)(33656002)(9686003)(55016003)(53546011)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUExR1FnbmVQeklCMEF6T0c5UDJtWENOK2ZkR3RCZkhPRzN6NWQzRHZieGdj?=
 =?utf-8?B?NGlXUDB6SDhmTnNPazVNQXFpY0FMcmFINERKZG5PTC81cnpHam1mWlJTTW1t?=
 =?utf-8?B?S3ROOW16K3p0MXN5L2hEMk50cUEwMFJURjlHY0NiSEY1WVI1TlIxVGM1UEYw?=
 =?utf-8?B?emREZ0NVcVhjRzZxeTVNNWZaRk5QbWpGdTFtUTB5WlhHR1I1b1Q5R0tERXll?=
 =?utf-8?B?UTBZZU5WSGgrQ2k2RGdKR00xNVY0ZC92YjdhRGJkcmtER2ZkdUhCM0lCQ1pa?=
 =?utf-8?B?NnVxTCtDRElQUERqSzdtell1THJoMWpSd2JpYUVRTGdEVkowMDlWUEEwczRI?=
 =?utf-8?B?UE1kV21QdG1JZ3A1TTkzb3Z5QmVBRXpXNUg1OUUwVm5VUVpUUllIYkNYdXFl?=
 =?utf-8?B?UDdMcmVEZGEwa3RxY1N1bEFVWTFUaUV3ZWJNNUlpUk1mYlQ3NXdwWS84eG05?=
 =?utf-8?B?STArT0l2L2YrVmk3c1VKQUtFcVFqMnJvUi9GaWJTQ3l2WitkaHFhSy8yUWI2?=
 =?utf-8?B?RXFLb1R6L3BpbGpyOXhHZHQyWjJFM0NvVEhDSjhJc2UrVDZMU0l1Q2d6TFky?=
 =?utf-8?B?dCtGMDFQR0I0SFRGWUpRNVNGNFl3WDN6bEt6VVdRVG9aeW5PSDB3WmlHM3d0?=
 =?utf-8?B?TFlzME5paTJzbmRIbjFIVUsyaWNRMHRBR1VWU0I3VXlmblo1ZWMyek5tcDc0?=
 =?utf-8?B?a255RDlmYjhGRnRoYjJQU1g3anpISzZ4TXJib2RaZlB6eWU1YnB0bjhsQkFE?=
 =?utf-8?B?RW8wWEJONHNRWCtyMnZvdzhlTXZER2ZaN2Z1djlid1dOMUtuRjVoZlIxclUy?=
 =?utf-8?B?U1l6Wkg0ZUdwcFlheCtDT2lka1FSS1BleTF2Z2xjWER6bGQ3eEExQzBSSlRY?=
 =?utf-8?B?bE5mZmpuZElrV1VOcE9tOWR1OG8yOGVQblRrWG5KcUVkZ2o0TFhLdXZLRDJ6?=
 =?utf-8?B?UjdrU2w4NjBuajQva0dzMmw0Q0ovZ1FFTXJ5SmJ1bml6c1k4cDZkb1pSY09F?=
 =?utf-8?B?ei9lalk1ZEtwb3pvZHViUVRMcHpLYWc5TEdlc25PdG8vV1VWdHBUMDRiKzh6?=
 =?utf-8?B?KzM3WW5hSkZ2eXN5UGw1TVNqdmZxSXUyc3QyOVdqNEVnM3c4Z21Gblo5d2lO?=
 =?utf-8?B?WVBIUzZyVFJqNWcybTRiekMzaHBwZFQ2eG5PUGVZRnlNcWxac2RscXhjbG9T?=
 =?utf-8?B?cTdySDJmMzU3SEVSdkpDVkV6clBQWkViMS9waC9HSkhzMGZHekU5N1YyNnRM?=
 =?utf-8?B?MmM5V3IvcVFxWlFvQU1qR2c4SVlPNXlVZm1xV2hXTG1iOE1pd3AwMXhRT1lT?=
 =?utf-8?B?bGhmVnVXOWZpMWhXZ3hMQ214ZVQ2ckNCd3BSWHJjZHI1VVppMXRtRmRsak5m?=
 =?utf-8?B?WEprSTNqRktrR1M4eDJ4c05JSzcyZ1d1YkRDSU1uUldmMHF6cmR3Rm9aTlQ0?=
 =?utf-8?B?SkI3RmxIeGRyWW4wSkVTSWkzRGY3WVIwelJ2M0JoYTJNbjhnWUNlMjV5bWZK?=
 =?utf-8?B?ZGYvOFkxWHM3Tm1nZ01XRzlvYjhhVGNQOG1BWHJDbnAzeWRkL1EvcU5NUUpl?=
 =?utf-8?B?cERScWZvc2xFdzk3ZHhMQ3hJVmU2RUlnKzQzUzRpS2d6YkU1dGZ6SDlvb04r?=
 =?utf-8?B?eUhiNkU2YVBJNFd5dEtGV3pjemlhbGc0R3QrQVFQUVNZQko0YmxFVzR5U0Fz?=
 =?utf-8?B?TkJHNUVQUEdmbmk5TXA5aHJIcWNrTkQxZFB5MGROeFZTVzUwOHQvNExsZ1Bs?=
 =?utf-8?B?Q3kvck1zdjR6T3R0aTFmaldYSGVhUDBFOHVxMnFQbjd4N2JBUFZrNzEzZjRi?=
 =?utf-8?B?cWdiSWlRdHh6eldlQk10Z01JYTc2TzQxY21YNFFTTUorVGd6WitZNVFENzAv?=
 =?utf-8?B?SlZ3SkNtODlGWitza004WC9JYlBlbUZYVXd1YllianhPcGNuUU5BUDZiV0Z6?=
 =?utf-8?B?endxWnUwYUVKOUQxK1UyeEZ4K1d3bCtPbGRmYlRQWmtGQS9vMzVxSDV4MXJ2?=
 =?utf-8?B?YUJIWmoyQXdtcWMwcVRyNXcwZkV0SDZJdW5mRTNTNUEyZmpDSkVYZUpWU2sr?=
 =?utf-8?B?S3ZsbVZaT0dxWERiMWFaMUllUkt6dW1Va25aWXc0eHZ4WXozK0xKUVJNWWVV?=
 =?utf-8?Q?pRg5yZ+05McW1dONtBKpxCuVQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b20096-eac3-473a-a0a8-08db9969e8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 06:20:35.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QECfF6xPRwRxyJS2tEbTiOKHuxVFFXivWq53/ma95lMsdH1HX2JZJrBTH6zDpvD9keZheGJVWtsGqDhc9b9l2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IEZyb206IEplZmYgSm9obnNvbiA8cXVpY19qam9obnNvbkBxdWljaW5jLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIEF1Z3VzdCAxMCwgMjAyMyAxMToyNyBBTQ0KPiBUbzogRGF2aWQgTGluIDx5
dS1oYW8ubGluQG54cC5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IFNoYXJ2YXJpIEhhcmlzYW5nYW0gPHNoYXJ2YXJpLmhhcmlzYW5nYW1AbnhwLmNvbT47IFBldGUg
SHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjNdIHdpZmk6IG13aWZpZXg6IGFkZGVkIGNvZGUgdG8gc3VwcG9ydCBob3N0IG1s
bWUuDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFr
ZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDgvOS8yMDIzIDc6MzkgUE0sIERhdmlkIExpbiB3
cm90ZToNCj4gc25pcA0KPiANCj4gPiBAQCAtNDkxLDYgKzUxMSwxNyBAQCBpbnQgbXdpZmlleF9j
bWRfODAyXzExX2Fzc29jaWF0ZShzdHJ1Y3QNCj4gbXdpZmlleF9wcml2YXRlICpwcml2LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IG13aWZpZXhfY2hhbl9zY2Fu
X3BhcmFtX3NldCk7DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBpZiAocHJpdi0+
YWRhcHRlci0+aG9zdF9tbG1lKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGhvc3RfbWxtZV90bHYg
PSAoc3RydWN0IG13aWZpZXhfaWVfdHlwZXNfaG9zdF9tbG1lDQo+ICopcG9zOw0KPiA+ICsgICAg
ICAgICAgICAgICBob3N0X21sbWVfdGx2LT5oZWFkZXIudHlwZSA9DQo+IGNwdV90b19sZTE2KFRM
Vl9UWVBFX0hPU1RfTUxNRSk7DQo+ID4gKyAgICAgICAgICAgICAgIGhvc3RfbWxtZV90bHYtPmhl
YWRlci5sZW4gPQ0KPiA+ICsgc2l6ZW9mKGhvc3RfbWxtZV90bHYtPmhvc3RfbWxtZSk7DQo+IA0K
PiBjcHVfdG9fbGUxNihzaXplb2YoaG9zdF9tbG1lX3Rsdi0+aG9zdF9tbG1lKSkgPz8NCj4gDQo+
ID4gKyAgICAgICAgICAgICAgIGhvc3RfbWxtZV90bHYtPmhvc3RfbWxtZSA9IDE7DQo+ID4gKyAg
ICAgICAgICAgICAgIHBvcyArPSBzaXplb2YoaG9zdF9tbG1lX3Rsdi0+aGVhZGVyKSArDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgaG9zdF9tbG1lX3Rsdi0+aGVhZGVyLmxlbjsNCj4gDQo+
IGxlMTZfdG9fY3B1KGhvc3RfbWxtZV90bHYtPmhlYWRlci5sZW4pID8/IG9yIGp1c3QgdXNlDQo+
IHNpemVvZihob3N0X21sbWVfdGx2LT5ob3N0X21sbWUpDQo+IA0KPiA+ICsgICAgICAgICAgICAg
ICBob3N0X21sbWVfdGx2LT5oZWFkZXIubGVuID0NCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBjcHVfdG9fbGUxNihob3N0X21sbWVfdGx2LT5oZWFkZXIubGVuKTsNCj4gDQo+IFRoZSBhcHBy
b2FjaCBjdXJyZW50bHkgYmVpbmcgdGFrZW4gZG9lc24ndCBsb29rIHNwYXJzZS1jb21wbGlhbnQu
IFlvdSBzaG91bGQNCj4gd3JpdGUgYW4gbGUxNiBpbnRvIGEgX19sZTE2IG1lbWJlcjsgd3JpdGlu
ZyBhIGNwdTE2IGludG8gYSBfX2xlMTYgbWVtYmVyDQo+IGFuZCB0aGVuIGNvbnZlcnRpbmcgaW4g
cGxhY2UgdXNpbmcgY3B1X3RvX2xlMTYoKSBpcyBicm9rZW4uDQo+IA0KPiA+ICsgICAgICAgfQ0K
PiA+ICsNCj4gDQo+IFRoZSBhYm92ZSBqdW1wZWQgb3V0IGF0IG1lIHdoaWxlIHNjYW5uaW5nIHlv
dXIgcGF0Y2ggLS0gaXQgZmFpbGVkIG15IG1lbnRhbA0KPiBwYXR0ZXJuIG1hdGNoaW5nLg0KPiAN
Cg0KU29ycnkuIEl0IGlzIG15IGZhdWx0LiBJIGRpZCBub3QgY2hlY2sgdGhlIHBvcnRlZCBjb2Rl
IGNhcmVmdWxseS4gSSB0aGluayBmb2xsb3dpbmcgY29kZSBzaG91bGQgYmUgY29ycmVjdDoNCg0K
aWYgKHByaXYtPmFkYXB0ZXItPmhvc3RfbWxtZSkgew0KCQlob3N0X21sbWVfdGx2ID0gKHN0cnVj
dCBtd2lmaWV4X2llX3R5cGVzX2hvc3RfbWxtZSAqKXBvczsNCgkJaG9zdF9tbG1lX3Rsdi0+aGVh
ZGVyLnR5cGUgPSBjcHVfdG9fbGUxNihUTFZfVFlQRV9IT1NUX01MTUUpOw0KCQlob3N0X21sbWVf
dGx2LT5oZWFkZXIubGVuID0NCgkJCWNwdV90b19sZTE2KHNpemVvZihob3N0X21sbWVfdGx2LT5o
b3N0X21sbWUpKTsNCgkJaG9zdF9tbG1lX3Rsdi0+aG9zdF9tbG1lID0gMTsNCgkJcG9zICs9IHNp
emVvZihob3N0X21sbWVfdGx2LT5oZWFkZXIpICsNCgkJCXNpemVvZihob3N0X21sbWVfdGx2LT5o
b3N0X21sbWUpOw0KfQ0KDQpJIHdpbGwgZml4IGl0IGluIFBBVENIIHY0LiBUaGFua3MuDQoNCj4g
L2plZmYNCg0K
