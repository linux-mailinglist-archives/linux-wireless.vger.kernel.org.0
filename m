Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA324E9063
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiC1Iqw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 04:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiC1Iqv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 04:46:51 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6D252E02
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648457110; x=1649061910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rss/s55FHNZzKDlC/yLXvMnEw1I3gzXt1DjaAarq/RQ=;
  b=02QzsaTwKAuMh+LszDPYTM5nTrI69SGyir5h0bIlPGQHsCmkoT0Uwc/l
   ljh7SHkX67+BRtZ35Aa+3GQEU5h1EpLokEv6ofl+xBA80ezdFOJ1qVLIZ
   Ox8WdykiWgRgqKiHmou3ZC/V8fgU5UdiMwpO+TuqcvJOPat/sjLP+SicV
   A=;
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXQW8zZhS+V6ltIBSx0zKkqpNnmVt8Mr2ZcAoxOnbw2DfibYX99iZdLMOXqKsGZOXoSlwD8jQ+IaHmsuuF/CRywX67bI4seCs095CDEo0r30uzRRok6ryc5wWgBovv0HDCLmfgQzxFWd4esW/xiSoX5XMy6MBeDb3qu6VWgJI97SE+F2Vd6pxiEC8g8WUDcjmq5aA4aWoEa5+YNqyZ0jbrFox4gB1Q3BRRAJ41AJ3hEiLyL+YZV7JVSprbcuueaRfWZz+soXFZ7aNhUAt3nG6t3ZfJeFTJRGP4DSApI6jxg2i7UBYs11XGBlFlZywxCgDYtAnzBIQjzCLroROBWJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rss/s55FHNZzKDlC/yLXvMnEw1I3gzXt1DjaAarq/RQ=;
 b=KS1BcRyn4jq7qmhl5zc7L9S/VBObRc6G32muD1yM4xH1bUPGcBzb1VDWGLaTnfmTH4FJF3R9UmbbPf3MgMlkjGdW3cHGFsEmY8Im9Mn04Z6VKAexxW8DNMDbj/dqHe0sH3AFGoolCSJsTLjc1tTlAKxpMQ6fAVu8NjGETblNjbCXd0OpQFbcCCY1o/lcJXPyR4Vz8zxPiDys3JAd78hkbhuHgqIJOldx8s2X2o8PsOsTp7nPBgxPePRCvPg94dTe97nyboTO2efTGE19IuilOSrAcPqfeEqmotWo/YnEw4/tS+R+OPWc5hNIKvvO03HDwYMouenqAE7xTEI/5gYuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by DM6PR02MB5866.namprd02.prod.outlook.com (2603:10b6:5:152::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 08:45:08 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::c551:a9b0:28f3:4d42]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::c551:a9b0:28f3:4d42%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:45:08 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "vkthiagu@gmail.com" <vkthiagu@gmail.com>,
        Aaron Komisar <akomisar@maxlinear.com>,
        "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Jouni Malinen <j@w1.fi>
Subject: RE: [RFC] mac80211: prepare sta handling for MLO support
Thread-Topic: [RFC] mac80211: prepare sta handling for MLO support
Thread-Index: AQHYQBzWRZGhnyINVUu+1ETsLsPQQ6zQD2EAgARn0AA=
Date:   Mon, 28 Mar 2022 08:45:07 +0000
Message-ID: <SN6PR02MB433497C4F6E9BD97294488C5F71D9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1648194497-15848-1-git-send-email-quic_srirrama@quicinc.com>
 <20abb029438166d02b5fb47093ea857671fa86e8.camel@sipsolutions.net>
In-Reply-To: <20abb029438166d02b5fb47093ea857671fa86e8.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a72f312-dc14-4fee-5faa-08da10974335
x-ms-traffictypediagnostic: DM6PR02MB5866:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB58669391304FED90B3E27DD38B1D9@DM6PR02MB5866.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tTaHwNZosYDfIFNK0LMH5YlLtwxjswsxGkJowVqpaEShHDhx8BzS2VdfoxvPbeSmTJC8qUqZiFDdrIWd3SqAIB2UPZ0qPiIBOwRYjS0EN++vzfmp9FMuh1s+kVplsxklndnWq4WiHIl5Ftbr4hxWK/Oa4MW83J5Aqo72O0i4AF9bef3uVycDjzA1gneIImkcpR+ArcjpB7mgJUmKz9EEyWwJIf3UQPlUHNbxZoxdIFrccMjZz7SHLgrf4foeJzklNK0n5etJ2MSpVnBMpDmloA7gCaJZjT5F3rC1rr7bO1ahUCa/cbUjyG1EN2DvHMah0OeCOPcPQDkLLpNcpjS+9FDYvMjprTvLyTGGVejmECEUb3wvnssYbirdz8vKKklyST1j0LBMwC8imBuKZGGObyKbISXPuEjizvv+Wp1+xCfNhpD9qyNJppmAoGyd5e7C39YHZSTwf1EdgNDd0dbLENpF2FsPb5XuyUqWyG0nx+WKTMsSrvqoCeCSjoOGrSpzGMJMZYK4o+yOhE1WIwXGxgZ9hZ5C1xVDHBZA93hwBCbDqXbKtkUFQFnj1lDukxgQlpNMSWa4jIm7zIzKzmFj786uJ0enN8O8A5LXw0FX36j44EjHZuxYSuv3w8mSAo/OHx2S2Xb5eqHyMWNEQqhR2INnQSL3ncM+3g/cNE06C99qBftuzo3VKWqlpG9+aPBcRCxMo8FX+DZKUcl/E/2XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(33656002)(122000001)(2906002)(66446008)(66556008)(4326008)(66476007)(66946007)(5660300002)(38100700002)(316002)(8676002)(38070700005)(54906003)(64756008)(8936002)(76116006)(7696005)(26005)(86362001)(52536014)(55016003)(9686003)(508600001)(110136005)(53546011)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzh1ZVd3SHAwTDJhSjJlemlCTFRTcVRaUy9FMGhrekZTVEtmdkxhL3p4b05E?=
 =?utf-8?B?YmRCR0FoYWh3WE1qcUsxVEZvZElZTEt5M3lCQlZ5VVdZNU11TE9jYjBsMnhY?=
 =?utf-8?B?cVlBTXg1UXpTVy9EdE10UjJZS0ZuQjF2UjZMcFlqTFNjMjRXTWF3STM3OHAv?=
 =?utf-8?B?RWJaY3c5VEtZSzZodm83ZkxxR250aFhEcVM5b3pUNFdHUnVWMlhEQ2VVbXRY?=
 =?utf-8?B?bFh3a2ZsMUhxVE56ZmltcmlYTlFhb0dlNEE2YU1pdStJM2VaK3JCRDVXYWdW?=
 =?utf-8?B?YXVxcW9VVHVaZGRrTW5BU2VhZDB3cFRKS090MWNIUG9KZkl2M3pCNkIxa2dq?=
 =?utf-8?B?U3lLMEtxcCtMU0wwMDVhb1BueW9FODdZdUxwR1Zua3hURDhvSHlkZExCOEg5?=
 =?utf-8?B?OEw0T0JFMWR6UE9VZzNJNW0rbzBqaG5CYlFhWXJFd0puQmk0YXdwZ0gzbXZ6?=
 =?utf-8?B?elduZ0EyZlQwQ1pOUys5c1FjRjhZM01hTzM3R2tmbEtBdUExZnhJSDhsT0ds?=
 =?utf-8?B?b1E3UXRZWTdFQ1NPRVZTVng2Ukk2YUR1YVByN3VOMVkzNHN0MnBSUGxiVXZB?=
 =?utf-8?B?VzBqSmNkY0Vib25rT1QwV2xvaXplbXlYeU1mK0p1cXpTdUE1U3I0d3cxMmhW?=
 =?utf-8?B?N05DWktkcjBBY1BRL2hXTWRiZWgwY1BEeG1sQTVvdmhBYmlQK1BYSytVZjhn?=
 =?utf-8?B?MkVTRjZ6SUEvUFBqUW1zcjNWR1R3SUhLZGtQdFAveVBpYlI5dm0zRUp6UGNO?=
 =?utf-8?B?Umd3TUVOSGR6bU5xMFVnTGNaeGh3QnpqYVljUlcvMFI3b1ppTHZCT2MzTDl2?=
 =?utf-8?B?R1pwQnRaY3o3MUdNblBCNVZzWTJhNHBvT3RuTHdyTXh1T2pjSDZ5RDBCS1Az?=
 =?utf-8?B?dDd5a2c4ZG5DR2UzVEtVTG90RTZjbUlXTEJ2UzJKajl6NXNDd3BUVkh0bjFx?=
 =?utf-8?B?Rkk4a3ZleWM5aHNPeEdZK3dMQVA2SFJDM3JBNnFpWW14UytIL3d6cktseW1h?=
 =?utf-8?B?dm1mWEN1VzIvNFZSN2NyQkRCWEwyMG1zem1ibmp6T3ZJdGsvKzRodEcwMmt2?=
 =?utf-8?B?aHlJOGZKK2VTL0RlMWIvcUlsRE56Z3djZ2tUbHdlL0NOTnEyT1pjcWZuZHVr?=
 =?utf-8?B?d1Y4Ly9xNEV3ZHhsa1lUUnhUN29TZ0ViNFE5L2ZoQUtocmxTZmcvT3h6ay9H?=
 =?utf-8?B?WU0weGsxWU5SQlNBNFByL1ZOSzQ4U3d3eXdoSXdvZTdjem53VjB5RmVmZGNP?=
 =?utf-8?B?M0o2WSthNGNvUHJnMjJjRnhqSWhIN1EyNXNIWkZtWjRYb2NzWmNhSlVWNWdK?=
 =?utf-8?B?ZS8rTkVHNXdvUDZoTTFXREFyRHRURm1VNVVjaG53eWE3SE1QSm1Rd0E3TUc1?=
 =?utf-8?B?OFI2MHhrQys0bDE5U21qVmduNHdMcE10LzBXUlN2QTFBQURlMVhPald6Zm1r?=
 =?utf-8?B?bVp6RFVlT25TdjJvVkJQb1RlcHhEQ2drZGttWUFISXJiUkNjbVRiSERKNzFQ?=
 =?utf-8?B?TkcrL2NaWE1zSStIemtreUNYZ2pwQXBrRU1RbC9lUnhFTEF0SjNRRjdpV29Z?=
 =?utf-8?B?NjhMS1hjK2xQTUtGZ1BFNGQrTlZnU2hqSUlsa0MxdWxYOWl0ejR6RWlpanhJ?=
 =?utf-8?B?Ymc2cE41VVgySGhYVTlCb242QkFMRmhBZ3dKek5xU2txaStVM3E1TjkxTEpt?=
 =?utf-8?B?NXBoRnRPQS80WmhBZ0thWlNhdERvT3RsVHhjMEsrNE1ZWTJNdEQ0RUJ0N0No?=
 =?utf-8?B?VURYTllCZlM0K0dCUnBVYlVBai9KQ29pUnM2TkhZK1BRTGRwMW5kbWVJbmtl?=
 =?utf-8?B?ZWI5S2FXMGd4Y1Y3OWVxOERzSUkwczlHVmxKZ1hqNGwrNGJSV25rbjFRaWxy?=
 =?utf-8?B?cHhNWkRrVnJPd1hzVmluMFQ4Y3pyU0VxSllMWjJLcUc2QlMyb3ZXeW40dzAw?=
 =?utf-8?B?K2R2Qmhsc0l0WEY1N0J2djBZRGJ5M0xqa1J1Rng2eElWS1p1ZkZWb1Y2WVZl?=
 =?utf-8?B?S0NsUUZ5MWRFN3dCZGlUZE0zdmUrUFNPWndaUHM5dGRJZDZGdDJwcDk4b01G?=
 =?utf-8?B?ZjJkVGdBRCtGQS9qZzdJNVhlWStVNDFROGRhek1wbzYyZFl2YW83c25tKzIr?=
 =?utf-8?B?bjl4YVErUmZ6T3c5STVFdmlhOGgxVHFiUlU2Q3VPTGduRll4amZkMEF2S2xN?=
 =?utf-8?B?SXl6emVGTE1JbnMyR3l3SDFoeHFvamZMdUNSWS9RU2x4Ym1kR0x2Q3ZtNXlv?=
 =?utf-8?B?MWRkUUtrbXJWNXZMS2RhbW5admNCOTJoQ0I2UUpqdmRZa0VKNXNSZ213TG1H?=
 =?utf-8?B?TFBRak9ZVlJaL05oVEZYYzdESkVIUzQ1bE00ZG9UUkxyaUkzQUdOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a72f312-dc14-4fee-5faa-08da10974335
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:45:07.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQw+Vxct7goPllwIEoopfwlBWGTMRL1wN5HqDkKw64ATr5NqiGqDtlXtPgpKBcj+5k6VQcFzKBgwTWXB160Qu+auUjwj8LrqTyNyLX+osWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5866
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDI1LCAyMDIyIDY6
MjcgUE0NCj4gVG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT47
IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHZrdGhpYWd1QGdtYWls
LmNvbTsgQWFyb24gS29taXNhciA8YWtvbWlzYXJAbWF4bGluZWFyLmNvbT47IEplZmYNCj4gSm9o
bnNvbiAoUVVJQykgPHF1aWNfampvaG5zb25AcXVpY2luYy5jb20+OyBKb3VuaSBNYWxpbmVuIDxq
QHcxLmZpPg0KPiBTdWJqZWN0OiBSZTogW1JGQ10gbWFjODAyMTE6IHByZXBhcmUgc3RhIGhhbmRs
aW5nIGZvciBNTE8gc3VwcG9ydA0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KSGkgSm9oYW5u
ZXMsDQo8c25pcD4NCj4gDQo+ID4NCj4gPiArI2RlZmluZSBNQVhfU1RBX0xJTktTICAgICAgICAg
ICAgICAgICAgICAgICAgMTYNCj4gDQo+IElzbid0IHRoYXQgMTU/IDE1IGlzIHJlc2VydmVkLCBJ
IGJlbGlldmU/DQpZZWFoIHJpZ2h0LCBJJ2xsIGNvcnJlY3QgaW4gbmV4dCByZXZpc2lvbi4NCj4g
DQo+ID4gK3N0cnVjdCBpZWVlODAyMTFfbGlua19zdGEgew0KPiA+ICsgICAgIHU4IGFkZHJbRVRI
X0FMRU5dOw0KPiA+ICsNCj4gPiArICAgICBzdHJ1Y3QgaWVlZTgwMjExX3N0YV9odF9jYXAgaHRf
Y2FwOw0KPiA+ICsgICAgIHN0cnVjdCBpZWVlODAyMTFfc3RhX3ZodF9jYXAgdmh0X2NhcDsNCj4g
PiArICAgICBzdHJ1Y3QgaWVlZTgwMjExX3N0YV9oZV9jYXAgaGVfY2FwOw0KPiA+ICsgICAgIHN0
cnVjdCBpZWVlODAyMTFfaGVfNmdoel9jYXBhIGhlXzZnaHpfY2FwYTsNCj4gPiArDQo+ID4gKyAg
ICAgdTggcnhfbnNzOw0KPiA+ICsgICAgIGVudW0gaWVlZTgwMjExX3N0YV9yeF9iYW5kd2lkdGgg
YmFuZHdpZHRoOw0KPiA+ICsgICAgIHN0cnVjdCBpZWVlODAyMTFfc3RhX3R4cHdyIHR4cHdyOw0K
PiANCj4gVGhhdCBsb29rcyBtb3N0bHkgZmluZS4NCj4gDQo+IEkgdGhpbmsgeW91IG1pc3NlZCBh
dCBsZWFzdA0KPiAgLSBzdXBwX3JhdGVzIChjbGVhcmx5LCB0aGUgbGlzdCBvZiBsZWdhY3kgcmF0
ZXMpDQo+ICAtIHJhdGVzIChyYXRlIGNvbnRyb2wgbXVzdCBiZSBkb25lIHNlcGFyYXRlbHkgcGVy
IGJhbmQpDQo+IA0KPiBhbmQgSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBBLU1TRFUgcmVsYXRlZCBv
bmVzPw0KPiANClN1cmUsIHRoZSBjb250ZW50cyBvZiB0aGUgbGluayBzdGEgKGxpbmtfc3RhX2lu
Zm8gb3IgaWVlZTgwMjExX2xpbmtfc3RhKSBuZWVkcyB0byBiZSBkZWZpbml0ZWx5IHJldmlzaXRl
ZC4NClRoaXMgUkZDIHdhcyB0byBtYWlubHkgY29uY2x1ZGUgb24gdGhlIGFwcHJvYWNoIG9mIHNw
bGl0dGluZyB0aGUgc3RhX2luZm8sIGllZWU4MDIxMV9zdGEgc3RydWN0cw0KYW5kIGhvdyB3ZSBh
Y2Nlc3MgdGhlIGxpbmsgc3RhIHJlbGF0ZWQgaW5mbyB3aXRoaW4gdGhlbS4gSSdsbCByZWxvb2sg
aW50byB0aGUgY29udGVudHMgYW5kIGFkZCBhbnkNCmxpbmsgcmVsYXRlZCBpbmZvIHRvIGxpbmsg
c3RydWN0cyBpbiBuZXh0IHZlcnNpb24gYW5kIHdlIGNhbiByZXZpZXcgdGhhdCBwYXJ0IGFnYWlu
IGlmIGFueSBtb3JlIGluZm8NCnJlcXVpcmVzIHRvIGJlIG1vdmVkLg0KDQo+ID4gKyAgICAgYm9v
bCBtdWx0aV9saW5rX3N0YTsNCj4gPiArICAgICB1OCBudW1fc3RhX2xpbmtzOw0KPiANCj4gV2h5
IGRvIHdlIG5lZWQgdGhlIG51bV9zdGFfbGlua3M/IFdlIGNhbiBhbHdheXMgY291bnQgd2hpY2gg
bGlua1tdIGVudHJpZXMNCj4gYXJlIG5vbi1OVUxMPw0KQ29ycmVjdCBJIGRvbuKAmXQgc2VlIGFu
eSB1c2UgaGF2aW5nIHRoaXMgY291bnRlciwgSSdsbCByZW1vdmUgbnVtX3N0YV9saW5rcy4NCj4g
DQo+ID4gKyAgICAgc3RydWN0IGllZWU4MDIxMV9saW5rX3N0YSAqbGlua1tNQVhfU1RBX0xJTktT
XTsNCj4gDQo+IEkgZ3Vlc3Mgd2UgaW5kZXggdGhpcyBieSBsaW5rLUlELCB3aGljaCBtYXkgYmUg
YXNzaWduZWQgYnkgdGhlIEFQIGFuZCB3ZSBtaWdodA0KPiBlbmQgdXAgdXNpbmcgZS5nLiAxIGFu
ZCAxNCwgYW5kIHRoZW4gdGhpbmdzIGFyZSBzaW1wbGVyIGJ1dCB3ZSBtaWdodCBoYXZlIGEgbG90
DQo+IG9mIE5VTEwgcG9pbnRlcnM/IEknbSBmaW5lIHdpdGggdGhhdCwganVzdCBhc2tpbmcgaWYg
SSdtIGludGVycHJldGluZyBpdCBjb3JyZWN0bHkuDQpZZXMgdGhhdOKAmXMgY29ycmVjdC4NCj4g
DQo+ID4gK3N0YXRpYyBpbnQgc3RhX2xpbmtfYWxsb2Moc3RydWN0IGllZWU4MDIxMV9zdWJfaWZf
ZGF0YSAqc2RhdGEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHN0YV9pbmZv
ICpzdGEsIGNvbnN0IHU4ICphZGRyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
dXBkYXRlLCBnZnBfdCBnZnApDQo+IA0KPiBubyBwb2ludCBwYXNzaW5nIGdmcA0KU3VyZSwgSSds
bCByZW1vdmUgaXQuDQo8c25pcD4NCj4gPiArICAgICBsc2luZm8gPSBremFsbG9jKHNpemVvZigq
bHNpbmZvKSwgZ2ZwKTsNCj4gPiArICAgICBpZiAoIWxzaW5mbykNCj4gPiArICAgICAgICAgICAg
IGdvdG8gZnJlZTsNCj4gPiArDQo+ID4gKyAgICAgbHN0YSA9IGt6YWxsb2Moc2l6ZW9mKCpsc3Rh
KSwgZ2ZwKTsNCj4gPiArICAgICBpZiAoIWxzdGEpDQo+ID4gKyAgICAgICAgICAgICBnb3RvIGZy
ZWU7DQo+IA0KPiBJIGRpZCBzdGFydCB3b25kZXJpbmcgaWYgd2Ugd291bGRuJ3Qgd2FudCB0byBt
b3ZlIHN0cnVjdCBsaW5rX3N0YV9pbmZvIHRvDQo+IG1hYzgwMjExLmggYXMgd2VsbCwgdGhvdWdo
IEknbSBub3Qgc3VyZSB3aGF0IGVsc2Ugd2UnZCBoYXZlIHRvIG1vdmUsIGFuZCBub3QNCj4gaGF2
ZSB0byBhbGxvY2F0ZSBhbGwgb2YgdGhlc2Ugc2VwYXJhdGVseT8NCkkgZGlkbuKAmXQgZ2V0IHRo
aXMgcG9pbnQgY29ycmVjdGx5LCBEbyB5b3UgbWVhbiB0byBtZXJnZSBsaW5rX3N0YV9pbmZvIGFu
ZCBpZWVlODAyMTFfbGlua19zdGEgc3RydWN0cw0Kc28gYXMgdG8gYXZvaWQgdGhlc2UgdHdvIGFs
bG9jcz8NCj4gDQo+IFRob3VnaCBpZiB3ZSBmb2xsb3cgdGhlbSB0aHJvdWdoIHBvaW50ZXJzLCB3
ZSBjYW4gc3RpbGwgYWxsb2NhdGUgdGhlbSBpbiB0aGUNCj4gc2FtZSBtZW1vcnkgY2h1bmsgKGp1
c3QgYWRkIHRoZSBzaXplcykuDQpEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZSwNCmxzaW5mbyA9
IGt6YWxsb2Moc2l6ZW9mKCpsc2luZm8pICsgc2l6ZW9mKCpsc3RhKSwgZ2ZwKTsNCmxzdGEgPSAo
dTggKilsc2luZm8gKyBzaXplb2YoKmxzaW5mbyk7DQoNClRoaXMgc2VlbXMgZmluZSBJIGd1ZXNz
IGFuZCBoZWxwcyB0byBkbyBhd2F5IHdpdGggdGhlIHNlY29uZCBremFsbG9jKCkuIENhbiB3ZSBn
byB3aXRoIHRoaXM/DQo+IA0KPiBOb3Qgc3VyZSB3ZSBuZWVkIHRvIG9wdGltaXNlIGFueXRoaW5n
IGhlcmUgdGhvdWdoLg0KPiANCj4gT3IgbWF5YmUgaW4gYWRkaXRpb24gb3IgaW5zdGVhZCB3ZSBz
aG91bGQgYWxsb2NhdGUgYW4gKmFycmF5KiBvZiBsaW5rcz8NCj4gQnV0IG9mIGNvdXJzZSBvbmx5
IGhvd2V2ZXIgbWFueSB3ZSBhY3R1YWxseSBuZWVkLCByZWdhcmRsZXNzIG9mIHdoaWNoIG9uZXMN
Cj4gYXJlIGFjdHVhbGx5IGFjdGl2ZS4NClRoZSBhcnJheSBvZiBsaW5rIHBvaW50ZXJzIGFyZSBh
bHJlYWR5IGFsbG9jYXRlZCBhcyBwYXJ0IG9mIHN0cnVjdCBpZWVlODAyMTFfc3RhIGFuZCBzdHJ1
Y3Qgc3RhX2luZm8sIHJpZ2h0Pw0KRGlkIEkgbWlzdW5kZXJzdG9vZD8NCj4gDQo+IE9UT0gsIG1h
eWJlIHdlIHNob3VsZCBrZWVwIGl0IHRoaXMgd2F5LCBhbmQgdGhlbiB3ZSBjb3VsZCBlbWJlZCB0
aGUgMHRoIGxpbmsNCj4gaW5zdGVhZD8gVGhlbiB3ZSB3b3VsZG4ndCBoYXZlDQo+IA0KPiAgICAg
ICAgIHN0YS0+bGlua1swXS0+cnhfbnNzDQo+IA0KPiAocGlja2luZyB1cCB5b3VyIGV4YW1wbGUp
LCBidXQNCj4gDQo+ICAgICAgICAgc3RhLT5kZWZsaW5rLnJ4X25zcw0KPiANCj4gd2hpY2ggc2F2
ZXMgYSBwb2ludGVyIGRlcmVmZXJlbmNlLiBXZSdkIGFsc28gZG8NCj4gDQo+ICAgICAgICAgc3Rh
LT5saW5rWzBdID0gJnN0YS0+ZGVmbGluazsNCj4gDQo+IG9mIGNvdXJzZS4gVGhpcyByZW1vdmVz
IHRoZSBNTE8gb3ZlcmhlYWQgaW4gdGhlICpkcml2ZXJzKiBhdCBsZWFzdCwgZm9yIHRob3NlDQo+
IGRyaXZlcnMgbm90IHN1cHBvcnRpbmcgTUxPIGF0IGFsbC4NCj4gDQo+IFdlIGNvdWxkbid0IGRv
IHRoaXMgaW4gbWFjODAyMTEgdGhvdWdoLCBvbmx5IGluIHRoZSBtYWM4MDIxMS5oIGxldmVsLCBi
dXQgc3RpbGwsDQo+IG1pZ2h0IGJlIHdvcnRod2hpbGU/DQoNClRoaXMgJ2RlZmxpbmsnIGFwcHJv
YWNoIGxvb2tzIHZlcnkgbmVhdCwgVGhhbmtzLiBJJ2xsIHVwZGF0ZSBpbiBuZXh0IHZlcnNpb24u
DQo+IA0KPiBZb3Ugc2F5IGluIHRoZSBjb21taXQgbWVzc2FnZToNCj4gDQo+ID4gU3RhdHMgYXJl
IGFjY3VtdWxhdGVkIHBlciBsaW5rIHN0YSBhbmQgZmluYWxseSBhZ2dyZWdhdGVkIGlmIG1sZCBz
dGENCj4gPiBzdGF0cyBpcyByZXF1aXJlZC4NCj4gDQo+IGJ1dCB0aGUgY2hhbmdlcyBoZXJlDQo+
IA0KPiA+ICBzdGF0aWMgc3RydWN0IGllZWU4MDIxMV9zdGFfcnhfc3RhdHMgKiAgc3RhX2dldF9s
YXN0X3J4X3N0YXRzKHN0cnVjdA0KPiA+IHN0YV9pbmZvICpzdGEpICB7DQo+ID4gLSAgICAgc3Ry
dWN0IGllZWU4MDIxMV9zdGFfcnhfc3RhdHMgKnN0YXRzID0gJnN0YS0+cnhfc3RhdHM7DQo+ID4g
KyAgICAgc3RydWN0IGllZWU4MDIxMV9zdGFfcnhfc3RhdHMgKnN0YXRzID0gJnN0YS0+bGlua1sw
XS0+cnhfc3RhdHM7DQo+IA0KPiBkb24ndCBzZWVtIGxpa2UgeW91IGRpZCB0aGF0IHlldD8gV2hp
Y2ggYWdhaW4sIGlzIGZpbmUsIGp1c3Qgd29uZGVyaW5nDQo+IGlmIEknbSBtaXNzaW5nIHNvbWV0
aGluZy4NClllcywgdGhpcyBjaGFuZ2Ugd291bGQgYmUgcGFydCBvZiBNTE8gc3VwcG9ydCBjaGFu
Z2VzLg0KPiANCj4gDQo+IFdoaWNoLCBidHcsIG1ha2VzIHRoaXMgcGF0Y2ggZmFpcmx5IG11Y2gg
bWVjaGFuaWNhbCwgc28gbWF5YmUgcHV0IHRoZQ0KPiBzcGF0Y2ggaW4gdGhlIGNvbW1pdCBtZXNz
YWdlPyBUaGF0IHdheSBjYW4gcmUtYXBwbHkgaXQgaWYgdGhlcmUgYXJlDQo+IGNvbmZsaWN0cywg
b3Igc3VjaC4NCj4gDQo+ID4gKyAqIFRPRE8gTW92ZSBvdGhlciBsaW5rIHBhcmFtcyBmcm9tIHN0
YV9pbmZvIGFzIHJlcXVpcmVkIGZvciBNTEQNCj4gb3BlcmF0aW9uDQo+IA0KPiA6KQ0KPiANCj4g
U28gbG9va3MgZ29vZCBJIHRoaW5rISBMZXQncyBnZXQgYW4gc3BhdGNoIHRvIGRvIGl0IGluIGJv
dGggbWFjODAyMTEgYW5kDQo+IHRoZSBkcml2ZXJzLCBhbmQgc3RhcnQgc3BsaXR0aW5nIHRoaW5n
cy4NClN1cmUsIGxldCBtZSBwcmVwYXJlIGl0IGZvciB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0K
PiBVbmxlc3MgeW91IHNlZSBhbnkgbWFqb3IgcHJvYmxlbSB3aXRoIGl0LCBJIHRoaW5rIEknZCBy
ZWFsbHkgcHJlZmVyIHRvDQo+IGhhdmUgYSAiZGVmbGluayIgZW1iZWRkZWQgYW5kIGluc3RlYWQg
b2YgY2hhbmdpbmcNCj4gDQo+ICAgICAgICAgc3RhLT5zb21ldGhpbmcNCj4gdG8NCj4gICAgICAg
ICBzdGEtPmxpbmtzWzBdLT5zb21ldGhpbmcNCj4gDQo+IG1ha2UgYWxsIHRoZSBjaGFuZ2VzIGJl
IGxpa2UNCj4gDQo+ICAgICAgICAgc3RhLT5zb21ldGhpbmcNCj4gdG8NCj4gICAgICAgICBzdGEt
PmRlZmxpbmsuc29tZXRoaW5nDQo+IA0KPiB3aGljaCBvZiBjb3Vyc2UgZG9lcyBub3RoaW5nIGZv
ciBNTE8geWV0LCBidXQgaXQncyBlYXNpZXIgdG8gZ3JlcCBmb3IsDQo+IGFuZCB3ZSdsbCBzdXJl
bHkgYWx3YXlzIGhhdmUgYSBzaW5nbGUgbGluaywgc28gaW4gdGhlIG5vbi1NTE8gY2FzZXMgd2UN
Cj4gbmVlZCBub3QgaGF2ZSBhbGwgdGhlIGV4dHJhIGFsbG9jYXRpb25zIGFyb3VuZCBldGMuLCBl
dmVuIGlmIGluIG1hYzgwMjExDQo+IHdlIGVuZCB1cCBhY2Nlc3NpbmcgdGhyb3VnaCBhIHBvaW50
ZXIuDQpTdXJlLCBJJ2xsIHVwZGF0ZS4gIFRoYW5rcyBmb3IgdGhlIHF1aWNrIHJldmlldy4NClJl
Z2FyZHMsDQpTcmlyYW0uUg0K
