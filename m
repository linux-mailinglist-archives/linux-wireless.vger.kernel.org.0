Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3454EB522
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiC2VXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiC2VXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 17:23:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C7D1CCE
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 14:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7LhTuy4x4N7d86hNqTUS+p0Hwfc5sfNpDaASZBq1N6PScLFLfUgmKr93DUGYJFPyF/YAnZU+wVBOsH8b2tgjNRgWXZV3hdjW+mJ49/fPrd0VNQtr+NjBH91sQ2VW1Qozpbgwps/XGDzN9DYZzOCh1nJTYu/Fgd39Z3Jg3P1IF3SYnJXiAgDG0b6ki4wgOgM3ypau7I6OYWrtBI+PP+JtCazICfZHptfCRZyzvJZGBSYbFf/37dNBGSeQ6Npg4QuYqbqi7ZDJmITttZDJ9noApZVmghYFXT1FcLOoxSRxPjnhmfKDSO0M6B+2PBTAjyyfMvVchvjuTst9uLG85wS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq8m6hoCTUHgV5GZThcoLXFET6qTx6LZVZYSng09eMc=;
 b=OliHe7DJw54t/Zxlt1w39ZqOCH6W0YSBSmaNjAIJjRX608k9wnS9TFGz+TDdzNm3f13PF9r7G3J2qETQ8MOlyqEf5fZgYrWk9fQiXCnuZZFNHBGze02UeT70rfswQTkkzkYJJJYZ0K4ilyOB6PqZMB+3Yb/hoNq3Q2fVh3E5ouo2LqCmcBNoRErVv/HpRTBGD4l3CwyHNrwxLyqUqahtKiVI0n+dfaeL0jfhcm+up7fmYmp0/mCz4oYRUF/YlPG7RArezzbwWWtg6yTNAwENm8RNwh3WhPzs9BDSZSz/jrxtSeHyznQX5WZ9WPnZxniRvK3jf6fY4eyGi0SSUlJxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq8m6hoCTUHgV5GZThcoLXFET6qTx6LZVZYSng09eMc=;
 b=q/axK6zONltlzcEToDKeOwS+6qc9EGqyCsqDLE4oMGB9dndIbx+Mao2p1b0njTJ2CuODWAQAIpSMgvv7r+qIA4ad9Ler1nQjgIp2G+JFiKRSbnk5/ZvqN3l+lDZvYOlZJEdx+aNwKbXFmEJ8UpQTjkvGEUS/wmEvBY/+SNgCjEQ=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by VI1PR03MB4525.eurprd03.prod.outlook.com (2603:10a6:803:61::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 21:21:19 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::3ce4:64bf:3ed:64c2]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::3ce4:64bf:3ed:64c2%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 21:21:19 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Brian Norris <briannorris@chromium.org>
CC:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        "felix+debian@gueux.org" <felix+debian@gueux.org>,
        Massimo Maggi <me@massimo-maggi.eu>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
Thread-Topic: Revert: ath: add support for special 0x0 regulatory domain
Thread-Index: AQHXl3XA7B6urwS4+0SNCV8LjkYaTauBWEmAgAAxNoCAAA0dgIAAtssAgVXlcgCAAAQXAA==
Date:   Tue, 29 Mar 2022 21:21:18 +0000
Message-ID: <20220329212118.mjkwqpeoe53vgtzc@bang-olufsen.dk>
References: <YSJ//ki/A1EgfLga@skv.local>
 <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
 <YSQC32TygIq2SHJR@skv.local>
 <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
 <4c44fdc2-8dde-8a98-8dd4-4b7e6b57a090@bang-olufsen.dk>
 <CA+ASDXOeC+S2d7g0b=aS_q9XxNtdayF1S5XE9T85NZrxXnK5KA@mail.gmail.com>
In-Reply-To: <CA+ASDXOeC+S2d7g0b=aS_q9XxNtdayF1S5XE9T85NZrxXnK5KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eabbfd34-e9d3-4aaf-13df-08da11ca10de
x-ms-traffictypediagnostic: VI1PR03MB4525:EE_
x-microsoft-antispam-prvs: <VI1PR03MB4525500CBE7750F5705FC6E4831E9@VI1PR03MB4525.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7EVpfd/RwhIOMuqi29wRHAbaxxdkbkWEKIVKaS0y375rDrtZBr5FiHmvocPo5cd7YX6FAqiNzqg35lfrkfHxcc98Psdm3XanoQvcvo0iWCM8YcuOC6QQE0RUL4xz2X03SeI88x7HoH6D3ebPwCXQNb1srWd9Cz8NtY+/aa+/BWO9H8MNAmBwtJ0pDpEKCK1/X8QrAb6frsK4UbTHaRcA8GKEd8O6079JsesqaLsY1LNtga9WQfWsasLpjNdeGoRP/btwhYMo4WnkAHAhgiWMC6XFJ2uIt7OLoXNY7/hPANCUj5k2iVc/qK1NSQyjk53PJNXkNuw4ZqWnCne3FuG+zNa86qDaTdqLbPTtCVdM9URcHK6ImTC2gI7kMVlEjpzIvb+YtZ9r8rJDHw41BFlyN0sWjQGeXbotkMnc96q9CjTpRRx8vG9G+bhmjDb6uIN0hlLxDEQfLIJaE3NY/5OUKFOlPEjs3ZCpCoIN1lBNRnd6EAyw2ygYMYQOpujjMws2TmBJJNhBE4iUV+zI1tTk1mCOQwif5ZYGvGU4BOBEfxcSBmujPbJhTOC0Buoudn+Yg1yV4c7AUfNE1bDDtJf3oGEFt27vlBrjlUUsGT0jLdFztgZYrrWK6kbSwf8ufZHktOCYcT6W3C/fGsfIVUHHI2tcZPx33kfpxfocSthRtBmrACGQTQ0p7OhsocF9aIylNo90bGTV/Vjj1vvRG+RMSlSvL2LK2X+DOQqsrIaPbq7Fk5m3pg/L0azZjy1ZnI1W1FGH57DaJlBdryy6u5PVgY/P/qb0jRwMBIjSD9in+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(91956017)(38100700002)(966005)(6486002)(66556008)(66476007)(2906002)(508600001)(8676002)(66446008)(8936002)(38070700005)(5660300002)(4326008)(54906003)(86362001)(66946007)(8976002)(64756008)(15650500001)(316002)(6506007)(85202003)(71200400001)(53546011)(85182001)(83380400001)(36756003)(6512007)(6916009)(122000001)(2616005)(186003)(1076003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZKWXd3b01Zb014aERSSGxsN1BUc3g3UUhQTzc2dkRSM085UzZ4VEZvVXdT?=
 =?utf-8?B?SWZrYzdBdjJyTFJzUDMycFd6NC93b1dGVDgzV0dEMzcyWkdnSkJScUU5M0wr?=
 =?utf-8?B?TGxMNGY0YVg5UFNmSkFoS3F2MkNQcEFDVUpRN1RZdXdlTXdRNTg4UEJTbnN6?=
 =?utf-8?B?N2I4eFpSYXJBdkRtVzEwd2FBSTZOelE3djRndWhGQ1pvaTRGenIzWE5zVW5E?=
 =?utf-8?B?QVM1U1BTS2xXN2V6NDY0bTVGYUw0dFJHcEJVeW15d2FBYjVnY25HMGRFd1Ro?=
 =?utf-8?B?d0tYY0VpMU1USG9aQ3RkSzROdDM1V3lqeEpyQ2NtVkkvQWdVMzZPbENXTlFa?=
 =?utf-8?B?N0daMVh3dEhWYWl2MG5qcDVVZG5wYXliMXNIWUl3VHhzRXhGT2RZVVZ6SUpr?=
 =?utf-8?B?b1VGb1JCMnkwdHF3eXMybGFySGk5MThFUHBxRDVTNVRrQzJITWxvMERsblNP?=
 =?utf-8?B?UHJqNkltMkFTSzFFbXhNZGh0czkrZ3ZjY2QyNUJhdDR4UHRHTHcxY0J3V1pN?=
 =?utf-8?B?NWNERk0wOHpwb2l0Yk1VUVQzZ1RUSUxrYlpiR2hWcEMyeXcxekJaTzlVcmNY?=
 =?utf-8?B?YUNZTVhLTTdyS2dvaUsxWmVuWnE5MERRdmZkZGNmUEl1bHpRQ0FiMy9LMDZM?=
 =?utf-8?B?Um1nNzVrNWxCWjY4bFhkbjNuMkRFREVPNUV1Vm5hS3VhSm90TityM0hCRHVO?=
 =?utf-8?B?SS9oNWtsUTF1ZDE4VGJraFBwd0FnTGg3N1h4QzZVNVNWQVNHOG02c2FseTJa?=
 =?utf-8?B?REdDODQyMEdVUnI2ektXZWl0VGtxc2p2YnpNbXVsMTc4NUVYaHNNc1I0Wmpq?=
 =?utf-8?B?Ty9HYmtTVmNZQ3FmdGdOWnl3b0p5WWV6SFVQNGlscUw0cTIrSVNHcFNMbXQ4?=
 =?utf-8?B?aVNvK2RvVlI4S05UbkN0TXI1dG1jLzRLS2RNcUgzZUpHUnAyOWM5M3F3anZs?=
 =?utf-8?B?aU9sRi9Pa1dTMUJ5RGhJODZuN0FUbFRNUmxQekcvcDlKdHNtakkxUmtpMzla?=
 =?utf-8?B?Z1RJdjlTSlMwalhmajFOVzIyRXMweGc3bTVyKzc0ZFhKWDNMZEFJdVRQK3Rs?=
 =?utf-8?B?QTY5YkNQUEJnK2ZYR05ielVoNVN5RkFPalp1cmc1YlRNZGRYTW9pSFZxSlhj?=
 =?utf-8?B?Zkd3NG94VVZGRnhpdURlakFteDlmTE9CRkYvMzFjYUNjWUR1V1paN0g4YU9Y?=
 =?utf-8?B?ZDNhVHhEcDNIUVk4KzZvc1AzT3NYZlJBVlVGai9wOUNrTmxwaWsyaGFpRXEw?=
 =?utf-8?B?cXlzdlB4TXVKSzBnMXZoZ2hsY2FVUEovWnhtN2tOZGNGdVRzcktNVUpWbEtS?=
 =?utf-8?B?dDFFcDRZaFdvVS9Rd05EcnNGZXZpZXFmcVdpa3FnK1V0V1VraXptUzluQTNy?=
 =?utf-8?B?Nm54dytJcGJ0SEI3VlZhWFMzc0YwWFl2YmhPOVhvL1M4WGw0cXN3cHZwcDFQ?=
 =?utf-8?B?RGZ2aExKMmxTUEVZQTByaHlva0NFd21scmY2VnBsbnBwaERid2xDZHYwZkIr?=
 =?utf-8?B?MFhQeFJjRUVxK2hDL21sb21BaElQdkhUWG5icDgxTWphOEtsTFZIb0QzRkRj?=
 =?utf-8?B?UU9RS3F3Q3JyOVRiMERBMkJLbDdNdlVmSDRsSEJvSWNwMCtUYU0zcm1SUE94?=
 =?utf-8?B?WEpwMW1STEZZVHdXU21icG1kY1IyNndwZDdqN2UxcDBDQ2dpVTRaY01ZejNu?=
 =?utf-8?B?cDk4dDMzNjZFZmlEVVg0UThyWk9KbWdoUTYzNy9sd2YxeExjS1pHVktHbHA5?=
 =?utf-8?B?RmZvQ0ZWUzNqM2lEemgyNmlZNE5aZVhkV01ub3pGNG1CTllXb3JUcks3aFFR?=
 =?utf-8?B?RGlmLyt4b1J1aXNibDREMnlLOXNwMkdQL3VkYlV4YkxIWGdITmw3eW1abk1s?=
 =?utf-8?B?Vy9nWHNaYnNzOUgwZHcxd3RxRHRaQmxxQWVpc1YyMm5JVFVjdWc5c1hDM3hv?=
 =?utf-8?B?OUJJZWhwZWg0angyeFV6OHVNVlA1Y21Cd3BERmFxcUF5ZTVVc2ZuK2FJaXZX?=
 =?utf-8?B?T3ptalZyT3FQVEpiV281M1EwYjBEeVhkV3hBREpiSE43Qm5MWSs1MURCNllt?=
 =?utf-8?B?U1VBZ0phd0J2L1NybVp5OFVJT3lwTElCbjFEeXJYY1pFVnArYzhrSVdWUFY5?=
 =?utf-8?B?anYxaFFnYmRFOHJodzdvUUc1eDdtaG12YVQxU3ZzUkxrWmpZeGF4YlpjRW5s?=
 =?utf-8?B?aGZ4NUJYaGlMSW1zVENML2VZalFMQ0N5TWxDck5WcmJkbzZick55RklZYnFO?=
 =?utf-8?B?TFR0R1NKWUxzaFNUbXRPS1ZleTNROE5leExqeWxuOWx3bHREWTN6a1RnSHA1?=
 =?utf-8?B?MEhrb0JjeXpvMTVwUmxQbjdkK3hiNjI4bGtnMWh6a0tkQzVpZ25VUzFuWDVl?=
 =?utf-8?Q?L4cGDurtX/btFd1Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C9DDD4707C17545AF0641B6F2BEA756@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabbfd34-e9d3-4aaf-13df-08da11ca10de
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 21:21:18.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROGbEXRUkv2FlkCzg74t40AiXKq76KMuYAD8DTfehuW/0WXWGjrnutKsTQgRzDg31o1XAFMabg9wJGIBiJD+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4525
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQnJpYW4sDQoNCk9uIFR1ZSwgTWFyIDI5LCAyMDIyIGF0IDAyOjA2OjQwUE0gLTA3MDAsIEJy
aWFuIE5vcnJpcyB3cm90ZToNCj4gT24gVHVlLCBBdWcgMjQsIDIwMjEgYXQgMTowMCBBTSBBbHZp
biDilLzDoWlwcmFnYSA8QUxTSUBiYW5nLW9sdWZzZW4uZGs+IHdyb3RlOg0KPiA+IE51bWVyb3Vz
IHBlb3BsZSAtIG15c2VsZiBpbmNsdWRlZCAtIGhhdmUgY2l0ZWQgc291cmNlcyBjbGVhcmx5DQo+
ID4gaW5kaWNhdGluZyB0aGF0IDB4MCA9IFVTLCBOT1QgdW5zZXQuIFNlZSB0aGUgc2FtZSBwb3N0
WzFdIGZvciBtb3JlIGluZm8uDQo+ID4NCj4gPiBJIHN0aWxsIHRoaW5rIHRoaXMgcGF0Y2ggc2hv
dWxkIGJlIHJldmVydGVkIHVubGVzcyBzb21lYm9keSBjYW4gcHJvdmlkZQ0KPiA+IGEgc291cmNl
IHRvIHRoZSBjb250cmFyeSwgcmU6IHRoZSBtZWFuaW5nIG9mIDB4MC4NCj4gPg0KPiA+IEl0J3Mg
dW5mb3J0dW5hdGUgdGhhdCB0aGlzIGlzIHN0aWxsIGFmZmVjdGluZyB1c2VycywgcGFydGljdWxh
cmx5IHdoZW4NCj4gPiB0aGUgb3JpZ2luYWwgYXV0aG9yIG9mIHRoZSBwYXRjaCBldmVuIGFza2Vk
IGZvciBpdCB0byBiZSByZXZlcnRlZC5bMl0NCj4gDQo+IEZZSSwgbXkgcmV2ZXJ0IHdhcyByZWNl
bnRseSBtZXJnZWQgdG8gTGludXMncyB0cmVlIGFuZCBpcyBtYWtpbmcgaXRzDQo+IHdheSBpbnRv
IHZhcmlvdXMgLXN0YWJsZSB0cmVlczoNCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbGlu
dXMvMWVjN2VkNTE2M2M3MGEwZDA0MDE1MGQyMjc5ZjkzMmM3ZTdjMTQzZg0KDQpUaGF0J3MgZ3Jl
YXQgbmV3cywgdGhhbmtzIGZvciBzaGFyaW5nIHRoZSB1cGRhdGUgb3IgZWxzZSBJIHdvdWxkIGhh
dmUNCm1pc3NlZCBpdC4NCg0KPiANCj4gU2lkZSBub3RlOiBpdCdzIGEgc21hbGwgc2hhbWUgdGhh
dCBLYWxsZSdzIHNjcmlwdHMgc2VlbSB0byBoYXZlIG11bmdlZA0KPiB0aGUgYXV0aG9yc2hpcCBk
YXRlIC0tIGdpdCB0aGlua3MgaXQgd2FzIGF1dGhvcmVkIGluIDIwMjIsIHdoZW4gaW4NCj4gZmFj
dCBpdCB3YXMgaW4gMjAyMCA7KQ0KPiANCj4gUmVnYXJkcywNCj4gQnJpYW4NCg0KS2luZCByZWdh
cmRzLA0KQWx2aW4=
