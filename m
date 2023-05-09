Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A306FCDC8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjEIS0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEIS0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 14:26:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA355A3
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 11:26:03 -0700 (PDT)
X-UUID: d1fcf99cee9411ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gQVOIbmiByfApi5JUzM9If9IJ6vpNPByZbMs3mnJ4AQ=;
        b=T3vow54hxi4o6muGpQw2pNfgxnAZ5P/K2FS7QgzC7KYgwvOXrsnv/59C/XPWej5NQ7nU3aa6SQI1NzR5Nt3yad6Wsscs+09yvM2Kc5bNEJ1EOMTidD2N6fecXJnm+aIyN8eOgTJruvTm2Uk3GSawlJMFTmTYNih5dTOT6qGXgw4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:70e429a7-7631-4673-891f-b73da58b3c2d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:9a20a03a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d1fcf99cee9411ed9cb5633481061a41-20230510
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 884664136; Wed, 10 May 2023 02:10:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 02:10:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 02:10:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScRWSqnMEEz6wehMRlhUJjt+a40OBpwXzlRjDE3oWCU/KJHalbKTV8+ZCwsil6dJPJGhQpN4PyINnPaC8CNS8UtfnVfaL4rorz5r9FwRhybFEkLsNWv9Wfqn2uIjcnAQgeEKL08xH+Fs/wa32g2Lq+4D72O9mg9nAjJoDBzyy4TbntU0xYp4grzAv3sgaUsuoSjysO30iZG7/OWx035qfcIc5T0FpjZigtSqyOteAg3wD6YE+oMW9W+Oz/IQBmIR0QFPS+HUtWpLnuaEWE56nnAi+V5LzwdGVjNdqUpasP/a4bQ/jyXi7FO3XhPFdhMuVb2Y/cr/7xO4SADXmx3QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQVOIbmiByfApi5JUzM9If9IJ6vpNPByZbMs3mnJ4AQ=;
 b=SRNqQxuFMF/82ntu8ARn4MEnTNOewxLLA9r3oYXlcPXVjnS5CkSni1fDYHjs0Y8q7m7/PA9O0zr2z4eJPCcs/8MpMjUJ4d3h5nh0nSXP2VWPEXSORhWXEqMfCILcckeVryFBNTyIT6kjA0mMWmydXP9OtvAQXClEpXG78F3focwyx/C79MyGFnyQc837BDs/Hv3VKI87K67A7WmXLyY+H/HrF070pjGvoFlU8lgi00atR5aORexpqkHi+q5nFvWO3+Xhg6iPOiW1RX8EEAOmvXxp4w0CjIP20DYyQ9RVvUuljWvwpklNm/C3H6G4xxZfKpxwNJbyIY/tlIFa+bka0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQVOIbmiByfApi5JUzM9If9IJ6vpNPByZbMs3mnJ4AQ=;
 b=AQVV+ZPKPwR/R3NmbQL74CpJ8zKiw7id58BgiwhZZQF+uPsajRyUDKZHrbBn0MQXRJFuaUcADZcAD9X5rtiNDTXT8uZrcJgUEP/V0VEQD0fIOzv/ab7m6Oz9z+c4f3v9s3iCsS46f8H0ZvtiEjhNs4fxBDL1tHfavKo+IVjxCoU=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEYPR03MB7586.apcprd03.prod.outlook.com (2603:1096:101:144::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 18:10:40 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 18:10:40 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH v5] wifi: mt76: mt7915: report tx retries/failed counts
 for non-WED path
Thread-Topic: [PATCH v5] wifi: mt76: mt7915: report tx retries/failed counts
 for non-WED path
Thread-Index: AQHZgiYdqqHas/p3rEWBZNfz0nlAma9SPtKA
Date:   Tue, 9 May 2023 18:10:40 +0000
Message-ID: <46117c51d736be7ab8e5cf280d779f45751b73ae.camel@mediatek.com>
References: <13d9169b5709efad969d7d167a1ff19828395fed.1683602740.git.ryder.lee@mediatek.com>
In-Reply-To: <13d9169b5709efad969d7d167a1ff19828395fed.1683602740.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEYPR03MB7586:EE_
x-ms-office365-filtering-correlation-id: abf26686-3e77-4643-ac15-08db50b8b29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SP+j79oKv+oRW+uD3qYpg2DTTyNE0UGDOoejdN1v1cWep2YZ/MpXjbhSGRdqzXCyFJcU/XvHZc1VJ1DwvTBGz1WavxtfoX9A3l+e4QsoJa4CmxCc9GcveDk7d2sOx0bm+a4XhjgLQzgE5mejmTsMgoo8UVxTANTZCxUNSLPLbEOQ8RvmKDOJnyzD2FZl6uGkFT1kCPhp1zLV86XVVzeZD+R+S3M54OScGSVcA9bbCZKGtP2w7CLmOlNIjgZQ8zCWnsV4sD730weDOIC4IOJK3nCTFLEoRXRZ1OKpN86KHgBBH77wKrprqh09Zdc4FAbXD4xkJksbsalAxr6ZEHY5lBYw3B8Pcw1a1OmzOGqpMxhmt8mNEqG2BFtw39N95Sd9zP3sZywHrO1M63+SV+IsDXfDZ8HcbIDIm0hAEFumV/jvSQIVyZqXYR5tnonrSyfB4zOeV8AHn7lXVK38t5R2HeWBUYM9dmu0DjmOPFT+9RofkW1tk4MTn0+uZblxmxOy7aUu7KsRBrvQN89/osoNQ1BwG5OlxO6sbOxxmeG4C76KhISNAF2/DTAKb+iHFhpn0zMuezG++3w0eK0jqRAVxBfNkbkNQEw7DGUYXm+wOcZMTS8TGwyvzQAo6RcAs5q5Zmj3dha2eNSJgCZMdzToAitzcxnkyFIyfUYokajzH8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(84040400005)(451199021)(83380400001)(76116006)(6636002)(6486002)(4326008)(71200400001)(2616005)(478600001)(110136005)(6512007)(6506007)(186003)(26005)(54906003)(107886003)(2906002)(5660300002)(36756003)(66556008)(64756008)(66946007)(122000001)(8676002)(66476007)(8936002)(41300700001)(66446008)(316002)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkhPKzJneWJYV1BvUVQrL3lIcW1mb2d6ZHZNS0M5MnljYVpkU2dPUUZGWUpM?=
 =?utf-8?B?QUFybE9aUERERkVpS3NrZURRWjJYTlE3YU1wSENxU1EycS9iNDdMQjdnZnpQ?=
 =?utf-8?B?dmlyak96eGQ4eTJZakpHcUZxUC9yaTVuVjJERCtEVHhqaG92TjdacnNCS1Er?=
 =?utf-8?B?c3pKVjVyV21jMXJZL0U4SThSdzBsMmh1dkM3ai9LeDFEcFFlVTliZjFjNEpL?=
 =?utf-8?B?dVFSWDZnOWxrSWxCZEhRYksrZXUxZittNTRwdnNqdjBsT2JTVkJoN1dkTlEw?=
 =?utf-8?B?QjJNVnJldFlwTUdEOEpPY1Ryd0JCckc3eDFSc0FwejFZZTFXTHo2bzVmYzY5?=
 =?utf-8?B?SUlIY3YybjBRWHgxeWdZT1JRMWJTcCtqYWt2Vk0zdVlJK0tweDlWN3V0Tlc2?=
 =?utf-8?B?azdBd3djd3hFcDJ5dngvRHZ6OHpnTSs1YkI0WGV3ZWFzTzEraDJQODJURGtT?=
 =?utf-8?B?U2ZXak95eGQweTdXOThWS2FETlRoSVpYS3JTNGZ5WDE3Nm9Cc25HeEV4cG5T?=
 =?utf-8?B?V1d4UFU4RWhqWnR1Ykl2eExJTWhjYUovOGc0Uk43RkZ0Y1lLdTQxL3BsZTh2?=
 =?utf-8?B?NVV3NnpWelBDVVk0WnJBMmlrbGY5bVpNWkZjSjZ3a1lGM2o5bUx0ak5oR1lE?=
 =?utf-8?B?VXloc3ZZQjRWQXpSWUxBa1dTRXBlaGdyVU9ENUF3OWFTc1gvMzVJaFUzdG1D?=
 =?utf-8?B?MktjM3hwZDBGcmN3RkRuVmRjbEtrS1dtekdweVB6Zmp0N0lVK1ZZdEhURGhJ?=
 =?utf-8?B?QUUzNTlVR1FSWEFmcStiak16QjVPRGxTOWtoY2hZbDlHTS9qclpXRTFMWnRQ?=
 =?utf-8?B?MXU2Ky9DYzh5dHE4WkNydW9IeG8zWUR0VlRaRkk4b3ZFMDRFa1ZsVUx4YU1N?=
 =?utf-8?B?TmZGL1VQOXovRmMwcDFlejhwWTFTQUlZK1ROTGc2bmJnZjR1YzVHUGdoOTRN?=
 =?utf-8?B?Rm1INDVBdEoyckZoak1sTnZKU1JFUFZ0akpGZHljWFk2dnlaREFOcUYwTDJ4?=
 =?utf-8?B?bU9YY21MQ1VWd01Sa2JVdTJyZ2o3R05saXJ6OVBCVmptWnh6bXd0N0l0WEQ1?=
 =?utf-8?B?bHcwZ0t3SnI5TWxwSFd2WEcvZjBGb200WEVzTWwybjdINkVsbktLRnd2elB1?=
 =?utf-8?B?WVZIZVI3dEk1NVdrN1NmUy9sR2VhZHhLRmIwdUtnVFdDOTRsbFcyY0FyNStO?=
 =?utf-8?B?K2xBMFEwMG1qems1SVZ1VWNzNkFrdHdrTlRNRzR0eFRxWGtINStmQnljdHhD?=
 =?utf-8?B?MDZKb3lRTWU2UVJHR1k0MFBYVlNGSGFxcVg4NTByM1c5eERoRVRveWpMWUs4?=
 =?utf-8?B?QmpyTXRTVloxbGNYQjVVeGpNM09iaEtKU3poc05TUHByK1UrZmdGVkc4aE5r?=
 =?utf-8?B?K1diODdhbVU3ZDkrZitFY3VjQXlHNUU5ZFpWaHptSHVKYWxlWFZabFBzMkVx?=
 =?utf-8?B?ekk3c2FpOURocHBUbDZlN0lnRzZNMnk4MDh4WFo4NTkyc0hzY0syME95Y2Zt?=
 =?utf-8?B?VDZCTVpYQ3ZEbDEzdzY5cGt6cFhtZVQxUTdyZGtROXhPUU5ncDNsQ28xYS85?=
 =?utf-8?B?NE1JNnFPWHQrS2tHc1dTZ0FJTDNtZ0x4VERXbENldXNpOGlqSTZqT1JPTjhw?=
 =?utf-8?B?TDdGcHpyVXEwdXdOVDhISDlncVY5V2Q2WjFKN3RpTGFzRmxZMDNETEhRY3Bo?=
 =?utf-8?B?aXlnRTdEM21QVVp5aGUvaFhVbDVCTDRYQTJ1cnBBSzRRTzZndjh5dExFMlNN?=
 =?utf-8?B?TVl3emVKRkVLVWh4dXRTQXNzTGNGdVJpTlRKVC9PRUZMUk55SytrNVkxN0pv?=
 =?utf-8?B?eGJMVHpuUXVuTXZwMXBmTk5xVGlCTE8yM0p0ODg4RnhvcnFzdE4rM1BNOXgy?=
 =?utf-8?B?NmpXSkc3dDJEcmRvUFE3WXMwVW81RmlRWmx1UGlEYWRWK0wzLzlObE12a1Ft?=
 =?utf-8?B?WXFuMmZjUjVwWGJuRXhLdDJUU3VwdFpZNFEweDZ1YjRWclA2dklHSDQwZUtq?=
 =?utf-8?B?eWFnUXVOclg0NnpWSkIyeUlsNGQwaHRhMitjM1dmakcxVjNyb3Y2VStUSFBJ?=
 =?utf-8?B?ODl5UnZXZkdDTDVkZVQyem5JY25PWGxKYkd2dkxPUzArZmpQN2ovMVNrMElx?=
 =?utf-8?B?Nk1LaGcrMjM5ZDBIOVNhdFVmMWhKZnZFOXVNRDcra1FmN1NBcGhIcGxKNm96?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <269F575615D9CF4A9DD64CC52C9DF82C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf26686-3e77-4643-ac15-08db50b8b29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 18:10:40.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I71u/XgFtqI4TkDtrqUwNJc0NEPvBOiuQAXIz3frJwvO8H69uUfuHLkWUcCQTh+10P6+8KRa5CYavQrd/I9mlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTA5IGF0IDExOjI2ICswODAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IEdl
dCBtaXNzaW5nIHR4IHJldHJpZXMvZmFpbGVkIGNvdW50cyBmcm9tIHR4ZnJlZSBkb25lIGV2ZW50
cyBhbmQNCj4gcmVwb3J0DQo+IHRoZW0gdmlhIG10NzkxNV9zdGFfc3RhdGlzdGljcygpLg0KPiAN
Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBQZXRlciBDaGl1IDxjaHVpLWhhby5jaGl1QG1lZGlhdGVrLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4N
Cj4gLS0tDQo+IHY1IC0gZml4IG5vYWNrZWQNCj4gdjQgLSBzd2l0Y2ggZnJvbSBUeCBsYXRlbmN5
IHJlcG9ydCB0byBlbmFibGUgVHggY291bnQgaW4gdHhmcmVlIHBhdGgNCj4gZm9yIG5vbi12MyBm
b3JtYXQNCj4gdjMgLSBhZGQgYSBtaXNzaW5nIGNoZWNrIGZvciBtdDc5MjENCj4gdjIgLSBhZGQg
YSBtaXNzaW5nIGNoZWNrIGZvciBub24tdjMgZm9ybWF0DQo+IC0tLQ0KPiAgLi4uL3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWFjLmMgIHwgIDcgKysrKy0tDQo+ICAuLi4vbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYyAgfCAgMiArKw0KPiAgLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYyAgIHwgMjINCj4gKysrKysrKysr
KysrKysrKystLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMu
aCAgIHwgIDcgKysrKystDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21haW4uYyAgfCAxMiArKysrKy0tLS0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L3JlZ3MuaCAgfCAgMyArKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tYWMuYw0KPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWFjLmMNCj4gaW5kZXggZWUwZmJm
Y2QwN2Q2Li42YjUxNWYzMzA5NzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWFjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tYWMuYw0KPiBAQCAtNzI4LDE2ICs3Mjgs
MTkgQEAgYm9vbCBtdDc2X2Nvbm5hYzJfbWFjX2FkZF90eHNfc2tiKHN0cnVjdA0KPiBtdDc2X2Rl
diAqZGV2LCBzdHJ1Y3QgbXQ3Nl93Y2lkICp3Y2lkLA0KPiAgCXNrYiA9IG10NzZfdHhfc3RhdHVz
X3NrYl9nZXQoZGV2LCB3Y2lkLCBwaWQsICZsaXN0KTsNCj4gIAlpZiAoc2tiKSB7DQo+ICAJCXN0
cnVjdCBpZWVlODAyMTFfdHhfaW5mbyAqaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsNCj4g
LQkJYm9vbCBub2Fja2VkID0gIShpbmZvLT5mbGFncyAmIElFRUU4MDIxMV9UWF9TVEFUX0FDSyk7
DQo+ICsJCWJvb2wgbm9hY2tlZDsNCj4gIA0KPiAgCQlpZiAoIShsZTMyX3RvX2NwdSh0eHNfZGF0
YVswXSkgJg0KPiBNVF9UWFMwX0FDS19FUlJPUl9NQVNLKSkNCj4gIAkJCWluZm8tPmZsYWdzIHw9
IElFRUU4MDIxMV9UWF9TVEFUX0FDSzsNCj4gIA0KPiArCQlub2Fja2VkID0gIShpbmZvLT5mbGFn
cyAmIElFRUU4MDIxMV9UWF9TVEFUX0FDSyk7DQo+ICAJCWluZm8tPnN0YXR1cy5hbXBkdV9sZW4g
PSAxOw0KPiAgCQlpbmZvLT5zdGF0dXMuYW1wZHVfYWNrX2xlbiA9ICFub2Fja2VkOw0KPiAgCQlp
bmZvLT5zdGF0dXMucmF0ZXNbMF0uaWR4ID0gLTE7DQo+ICANCj4gLQkJd2NpZC0+c3RhdHMudHhf
ZmFpbGVkICs9IG5vYWNrZWQ7DQo+ICsJCS8qIGF2b2lkIGRvdWJsZSBjb3VudGluZyBpZiBkZXYg
c3VwcG9ydHMgdHhmcmVlIGV2ZW50DQo+ICovDQo+ICsJCWlmIChpc19tdDc5MjEoZGV2KSkNCj4g
KwkJCXdjaWQtPnN0YXRzLnR4X2ZhaWxlZCArPSBub2Fja2VkOw0KQERlcmVuLCBjYW4geW91IGhl
bHAgdG8gY2hlY2sgaWYgbXQ3OTIxIGNhbiBkcm9wIHRoaXMgIGFuZCBjYWxjdWxhdGUNCnR4X2Zh
aWxlZCBmcm9tIHR4ZnJlZSBkaXJlY3RseT8NCg0KUnlkZXINCg==
