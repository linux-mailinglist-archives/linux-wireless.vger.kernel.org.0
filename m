Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8352D41B893
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhI1Uql (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 16:46:41 -0400
Received: from mail-oln040093003012.outbound.protection.outlook.com ([40.93.3.12]:36606
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242572AbhI1Uqk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 16:46:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2459pinM94iaalWaulWUXa92DBxwIu689q5rGtb1pclXcaExIUCtBIYsazXDi7EB2SNI3BOcHwP/a3Do7LEYi0UFK157hMgAv2eHyuWWZbiF8LTTgtKDXkvxa2hzEGJ3slm37Dgu3N1UB2ccD3QatqqCuwTWCI14Pbaci+mEVuSWc/tTDwmdxZ9zbaPOU4U5Z6oPgTRxEtXx++UUSs8UoN1KDwjU7MpPi/WuqXjIhMMTCTsCrwCN65oRdCw0G80ksBhxG/N+yJQ6sHd0wX6NDbDwIwmNqtlYqJYsrqgRN83dnebRm6UwD9xaW04LQYgqJV+/wKLLkERGTXtOVy/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaghJwLnkQqSBQ22Nmm4C9hj1+t3xdMn3wBsfqEs6vY=;
 b=WMXThLw2Iusa4Lms/ejKKUJa78mDcg/1Pub9/KdlKXIT360SjrP2nLa8wgZ6FlFWST+LAXhYanzIGiTGlQI4++3aYGu7WNcN//lJHOFQGkuDcoC17iQgbf/ygf727fcoeMSkxM0TW5m44+idSPY2r51Bvuic1d4EOmUaEEJGYFJjpYjSt06C3FNHsehxd/o6VlzPAjkxfpAZ5EHN8e6TlrzSi1Rvf7UHrPiUTTJ9JMvbwaFTLzZevooRRwxKI187TCK7Y7rPN5tm8aRO1FVF9PImB1aYefZstmkhxZs0Q/Al8vPEqfiXAisN6njoZdDVRlBlvaHtF+egrco8LhVm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaghJwLnkQqSBQ22Nmm4C9hj1+t3xdMn3wBsfqEs6vY=;
 b=ZY60k/EQpML+8RXDdmuGWQwZ7YhgdMEC+4+dj9Id0dRhxxcBOMRyB1f9kfSnfGcYUYc9aYEqQfTZXyWU2sVKBJ+UFZrZm6fHear8T43VqUj1TePKZVbHadXYyh7o6AxBVVywmHgkJA0rdyVJE4ZHNwHh0qpHgesjfPCpptiMx4k=
Received: from MWHPR21MB1547.namprd21.prod.outlook.com (2603:10b6:301:80::21)
 by MWHPR21MB0703.namprd21.prod.outlook.com (2603:10b6:300:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.1; Tue, 28 Sep
 2021 20:44:57 +0000
Received: from MWHPR21MB1547.namprd21.prod.outlook.com
 ([fe80::3d6b:9865:80ae:e8c7]) by MWHPR21MB1547.namprd21.prod.outlook.com
 ([fe80::3d6b:9865:80ae:e8c7%5]) with mapi id 15.20.4587.003; Tue, 28 Sep 2021
 20:44:57 +0000
From:   Guillaume Hetier <Guillaume.Hetier@microsoft.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "schuffelen@google.com" <schuffelen@google.com>,
        Shwetha Bhat <shwbhat@microsoft.com>,
        Andrew Beltrano <anbeltra@microsoft.com>,
        Brian Perkins <Brian.Perkins@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: [RFC PATCH 1/1] Add control path virtualization in virt_wifi
Thread-Topic: [RFC PATCH 1/1] Add control path virtualization in virt_wifi
Thread-Index: Ade0qbG/LOgSrzEDQiaphMV+OQhaVg==
Date:   Tue, 28 Sep 2021 20:44:56 +0000
Message-ID: <MWHPR21MB1547EB364EFA35799C3B69A38FA89@MWHPR21MB1547.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1dbee91c-9cc5-4f5f-8777-654ceed5c8c5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-28T15:35:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a60139e6-34b6-4e25-5540-08d982c0d51e
x-ms-traffictypediagnostic: MWHPR21MB0703:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB070310A173F523AA93DAB7028FA89@MWHPR21MB0703.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tbpetyVEQrLjVYCxVYHD7NyvvOdogUPEWKH/7l6wv8xO5nT1t6wEcSDEYFHcib2iZrJrwUVsoK/6oN8lRbRd6TpEkzxQdyODyB2aoNYzgj3oWTujDLj++khuH0yn1bEqPxaniU7tXKureebCB0ScCoCMo64zZlu0CkE9GGJjF/MUrcQ5S28xoeg12LbJ8ceYHAfFRxlmEkbZKkf8AaWD7ZUJRmru6D1qoQj1QZz06dgfBfTdVAodHOkI+nhkjI2lUewGPz6k/8spSaQ1dDd7dAt3ckHhnJ2NBH1P3k5ABw7MrrgLEtzwDlanG2iTEfTC2ulebW2kA0j3oZ9o4LWzEm9kVrBJf7aYYRluY9YZqKpmbZus4IBYJBnAuA7Tgal19EOqC4zfqhnjwr8f/8B8it0DIHrKjKkee0urI/IYa8aSpjZxXa63s2l+j2hBnfSyNwB+uBCUJquxnvyZteRqyVNLOsFoeB9krH62XImU3cHpvqxSD2ezge6X9QuCXKAH69V9THOax2mnwhLHR0KQ3a5KpbB4Lpk3xzwX8eKHRgfcjW7aoGTFl+auKiNA6/7KbsfduOdEke7HczXFiEdkoQkSMlnkRkjeZHYLx57vPf9v2Im+OioH0a58tjO2J0S9SPDyGT5kTfR5Hp8Mv3tBlydTqAgDyi3tJfha4WkCVmbDMLFcOwZ5HQpjA5Up0oJR+Nl+qDO6pOpVe4K5Xk8D9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1547.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66446008)(8990500004)(55016002)(8676002)(186003)(66476007)(122000001)(66946007)(2906002)(9686003)(76116006)(107886003)(10290500003)(86362001)(8936002)(6506007)(38100700002)(66556008)(71200400001)(54906003)(110136005)(508600001)(4326008)(52536014)(82960400001)(33656002)(82950400001)(5660300002)(38070700005)(316002)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTdWQ2MrQUpsbjQ0RXdCaHI0VlF1Vm4rWndNRGtXdnFtV0NwNEV3U1hta3hC?=
 =?utf-8?B?eVNTWVlGUk9GVU1YWml3NkJoRlU4WDc2ZEtxTkk3LzVQWlZrbVg1eG5zWG9R?=
 =?utf-8?B?YlRaU1B4cXBGOGZja2twcXRGVTZwaW5lVmhWK2c2amZsbC92dW9rWlRJQmw2?=
 =?utf-8?B?MitWMzJZck9SbGJhSmo5RExSSzh4NzBHZW41TGtPUW5HclN5Y1dIQzA5ZVFu?=
 =?utf-8?B?WGUzaTdDSGJQeGhSVnhUVTVkTElKM3NDbWJqK3BqYkV6Y1VkaE5CQ1N5SVJ5?=
 =?utf-8?B?T0pzRDkyTlZvZXl0M2NUd0piZUduMVFaUDFod3VHblJNK0F1eGJoZTZQQkRP?=
 =?utf-8?B?aXZydW1DWTFobXQ2RHV4ZklkL0xQYVREVmVwS2lPbjNMUkhEdW1vWkg5aGZI?=
 =?utf-8?B?U1daQjBKRXJKT29KSGgxWUFOZmxQbXRSNHZZSlRGc0Y5b1FRNmpJSG5lWTgw?=
 =?utf-8?B?K0Q0YStXTVQwZVZDQlVUM0lWR2pTZk5vUlhnM3RvTzg1aVRlekZJTkdDUWlj?=
 =?utf-8?B?UFF6dWo3cUszS2xSNDFWeHRGU1hMdmVKWlZMcm8rNVRxRUMrbUZPVENTekhX?=
 =?utf-8?B?dmtoeXd3SGhIalNjOFpyQy9jMitXL25mRlpCeW1jZCt2K2JHS0RFampVRTVZ?=
 =?utf-8?B?eEJPTTV4ektmMEh4RHhTQkV5VnIwM1U1WU9DNTJ5a29tMEVGcVY0QjBWa2tY?=
 =?utf-8?B?b3FiYytuSStkQmp2ME1MMy9IVjNrYWdHREdhUE5Ja1I2ZE5IWTJieU9ZQnZZ?=
 =?utf-8?B?cXcvb1p6YjlWSXQyR2Fzd2dwU3BVMFhYaGd1Y0NSVmZLZFB2MS9VOWNFMURx?=
 =?utf-8?B?K1IyOU1aSzVFNnJlcDJRSVB1c0hoUUVMTm1jMzIwdWIyUjhIWUhOakVVVWZz?=
 =?utf-8?B?bkFqL1JJbjBuQ3lzYk0ya1Vhd242NERST3VYeWZsSmhSWWhpdFpvRTJTakg0?=
 =?utf-8?B?YUdqV0hQaFFZc1B5UEV4MVQ3SG5PeHpkdGJuaityaGtEbFp2V3JEc0ZzSDQz?=
 =?utf-8?B?eFVwT2JnK0g2bTdSYzdIZ3pZNFQvN1VQejQ5WFJiTVFOUlZaN2xrM0Z2aWs1?=
 =?utf-8?B?ajBMNFVGNnRhTjVHOXoxcFNnY0g4VGhNZjlsdFFlNFR4eGJSQUtpbDRpZUx5?=
 =?utf-8?B?Qzl6RUZ3cEJyTEJEanVzdFRLOXlyRDJraEl2dExMS3V3SDdObURTNWZrczBu?=
 =?utf-8?B?ckk0V2NBdERUZ1JaMkhQSGlUS1BiSm1oSmo0UHk0MnNjMU9GM2MwTFl2MTZk?=
 =?utf-8?B?dnN4YUI1Q0hVTWV3RHBtY24zYWE1blUrem9BWm1ZZlkycUQ3QnVEVEJvLzJP?=
 =?utf-8?B?Yi9kOFcxcFlET0dLbnoycXgxNzdIb3BNOHhTY1g4QTBoRWlYWE5KekJoK1or?=
 =?utf-8?B?UDVmSTdQaGJFWlZxQTZDOWVGakxaYmxVQ2ZSUlVwdjJvYW1FczlKK1YxM3I2?=
 =?utf-8?B?eXBpVWlyT2JReTBpVUVqQUJFbjZkRElxNS9id1pPOE91QWZwOUdxS2tsVUpz?=
 =?utf-8?B?VENBQVJ3b21DLzN1L2FBVXpGL1BINWxFZlMzQUhlcENaR1puelNxUXJqVW5H?=
 =?utf-8?B?aTR6cElZK3NhTUplalpRTG5HRy9lSEJrNnVWdStRNm8wTGtsbGNsREU3QW5H?=
 =?utf-8?B?YVVnaXVMZDFSUkV5Q2U0dk4va3oxZGJsd1JGRVJyRkUrZG5KNnF4ZURHa1dU?=
 =?utf-8?B?Y0d1S0lDZTU2K0tIMzlaQXMrR1QzKzN6b0pxeXUrWGE0VVZwbUtmQ1lPRnlk?=
 =?utf-8?B?TzVvZ09lZ1JGeWN1R2VkMWdmTDRpTHFsN2lHcllUV2ZtZE1QNFRSZTNKcHp6?=
 =?utf-8?Q?Rxr8WvXxySWU5fTnf0lbsLmuIviwg5mEEEBF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1547.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60139e6-34b6-4e25-5540-08d982c0d51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 20:44:56.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6zbf+WiGSGUWfn+zG5AlLz+whQ3DL9WUhWw9eG1ki9OirgWYNnEBmj4lQ/nOshAo3IuCwV8SMsTDZoYPU2HAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0703
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCj4gQXJlIHRoZXJlIGFueSBzcGVjaWZpYyBhcHBsaWNhdGlvbnMgeW91J3JlIHRoaW5r
aW5nIG9mPw0KDQpPdXIgbWFpbiB0YXJnZXRzIGFyZSBwcm9ncmFtcyBzZXR0aW5nIHVwIElPVCBk
ZXZpY2VzOiB3ZSB3YW50IHRvIGdpdmUgdGhlIGd1ZXN0IHRoZSBjYXBhY2l0eSB0byBjb25uZWN0
IHRvIHNwZWNpZmljIG5ldHdvcmtzIGNyZWF0ZWQgYnkgdGhlIElPVCBkZXZpY2UgZm9yIHRoZSBk
dXJhdGlvbiBvZiB0aGVpciBzZXR1cC4NCkZvciB0aGF0LCB3ZSB3YW50IHRvIGJlIGFibGUgdG8g
c2NhbiwgY29ubmVjdCBhbmQgcmVmbGVjdCBuZXR3b3JrIHByb3BlcnRpZXMgcHJlY2lzZWx5IGVu
b3VnaCB0byBsZXQgdGhlIGd1ZXN0IHByb2dyYW1zIGdvIGZvcndhcmQgd2l0aCB0aGUgc2V0dXAu
DQoNCldlIHdvdWxkIGxpa2UgdG8gbWFrZSBvdXIgc29sdXRpb24gYXMgZ2VuZXJpYyBhcyBwb3Nz
aWJsZSB0byBiZSBleHRlbmRhYmxlIGFuZCBwb3RlbnRpYWxseSBzdXBwb3J0IGZvciBjb21wbGV4
IHVzZSBjYXNlcyBpZiBwb3NzaWJsZSwgYnV0IHdlIGFyZSBub3QgYWltaW5nIGZvciBnZW5lcmlj
IG5ldHdvcmsgbWFuYWdlbWVudCBmcm9tIHRoZSBndWVzdC4NCg0KPHNuaXA+DQoNCj4+IEJhc2Vk
IG9uIHRoZSBkaXNjdXNzaW9uLCB5b3VyIHJlY29tbWVuZGF0aW9ucyBjb25jZXJuaW5nIG91ciBp
bml0aWFsIHF1ZXN0aW9ucyBzZWVtIHRvIGJlOg0KPj4gLSB3ZSBzaG91bGQgY3JlYXRlIGEgbmV3
IGRyaXZlciwgcmF0aGVyIHRoYW4gbW9kaWZ5aW5nIHZpcnRfd2lmaQ0KPg0KPiBZZXMsIGZvciBz
dXJlLCBJIGRvbid0IHRoaW5rIHZpcnRfd2lmaSBtYWtlcyBzZW5zZS4NCj4NCj4+IC0gbmV0bGlu
ayBjb3VsZCBiZSB1c2VkIGFzIGEgcHJvdG9jb2wgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgaG9z
dA0KPg0KPiBUaGF0IHdhcyBqdXN0IGEgdGhvdWdodCByZWFsbHkuIEkndmUgZG9uZSBpdCBiZWZv
cmUgZm9yIGh3c2ltJ3Mgd21lZGl1bWQgdmlydGlvIGFic3RyYWN0aW9uLCBhbmQgaXQncyBub3Qg
YWxsIHRoYXQgYmFkLCBidXQgeW91IGNvdWxkIGp1c3QgYXMgd2VsbCBkZWNsYXJlIHN0cnVjdHMg
Zm9yIGNvbW11bmljYXRpb24gYW5kIGdvIHRoYXQgc2ltcGxlIHdheS4gTWlnaHQgb3ZlciB0aW1l
IGVuZCB1cCB3aXRoIG1vcmUgY29tcGF0aWJpbGl0eSBjb2RlIG9uIHRoZSBkZXZpY2Ugc2lkZSB0
aG91Z2ggKGFzc3VtaW5nIHlvdSB3YW50IHRvIGtlZXAgb2xkIExpbnV4IGtlcm5lbHMgcnVubmlu
ZykgVWx0aW1hdGVseSwgaXQgZG9lc24ndCByZWFsbHkgbWF0dGVyIHRvIHVzIC0gSSdkIHRoaW5r
IG9mIGl0IGFzIGEgZGV2aWNlLCBhbmQgcGVvcGxlIGNvbWUgdXAgd2l0aCBhbGwga2luZHMgb2Yg
c3RyYW5nZSBoYXJkd2FyZSBhbGwgdGhlIHRpbWUgOy0pDQoNClRoYW5rcyBmb3IgdGhlIGNvbmZp
cm1hdGlvbiENCkZvciBuZXRsaW5rLCB3ZSB0aGluayBpdCBjb3VsZCBiZSBhIG5pY2UgbWlkZGxl
IGdyb3VuZCBiZXR3ZWVuIHRoZSBsYWNrIG9mIGNvbXBhdGliaWxpdHkgb2YgcmF3IHN0cnVjdHVy
ZXMgYW5kIHRoZSBvdmVyaGVhZCBvZiBpbXBsZW1lbnRpbmcgeWV0IGFub3RoZXIgVExWIHBhcnNl
ci4gV2Ugd2lsbCBleHBlcmltZW50IHdpdGggaXQgYW5kIHVzZSBpdCBpZiBpdCBnb2VzIHdlbGwu
DQoNCkd1aWxsYXVtZQ0K
