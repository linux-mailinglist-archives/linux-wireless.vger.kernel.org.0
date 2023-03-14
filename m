Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3F6B8BED
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 08:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCNH1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNH1k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 03:27:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7775A42
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 00:27:35 -0700 (PDT)
X-UUID: aebaf826c23911eda06fc9ecc4dadd91-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gw8NeNK/Zms/se1t5T8dqEiStFEmrb6cymvtBP4zfYA=;
        b=oCO6INC0R9npStcKQn8OEUqN3aAxKCo6zGnrDcK1ItT+wKwTXgWB5XuBgpKprTcpWN7lRepxiiKOgH6HvapsRPWKC06T+TScDe+FuMqeS55abujOg7+6Y6VbZGAvb/suLzivvEmr6XOO8t79jNao8AggDnBLhIGii4ZtZiChJx4=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:36b77a31-9caf-4439-91ec-d6517fe636df,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.20,REQID:36b77a31-9caf-4439-91ec-d6517fe636df,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:25b5999,CLOUDID:5dafbcf5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230314152733PJ3IOAOV,BulkQuantity:0,Recheck:0,SF:38|16|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: aebaf826c23911eda06fc9ecc4dadd91-20230314
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1212899746; Tue, 14 Mar 2023 15:27:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 15:27:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 15:27:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBUe7wzNYCVfMN7ZGILPiK5TyiY0r/NOC30M8kMQaCdXlNPC8rwf+abqNXwo/E7ih9G7r3LMk0SX7l3OTN9RMKi9+guaMtG+IqisV5fOEKWjomo8B6V8WWcbT0Xv3nzkd5j/C73JtTC3DqP77yWJUYTYYEnWdQXtkJ1J8hcDabXy6oxyxamBtpf26d0mgqjqCfVyavZxEw939i+n2Gk4LMbx3J90X70aRWz08BNtgPVARYg/dj1r58wjvn2dMAVQJrqt2HkeJHpM5OWnvq+RWDsWzBvws8ZJrkW7POkSndiqNhT1vBJm27juz3pzjr4YEBPJ5vcArkIOHX9myEvOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw8NeNK/Zms/se1t5T8dqEiStFEmrb6cymvtBP4zfYA=;
 b=cs8Pec169sYR6A9L0kcPv/BgAzvbI6Rbpwbriix5OL/jFtDVcdXh5j5C3AT5WqrLZS1KQo+YeTrUqp/ot9Kt+7sl0CBjRsCk6FhSDriM6a68HS4APPa6g6g7VA/Idd8YHRKVexf8AxtpfpjzDUCydpcq6xoS51AieecozcyR4H8z66iVfDetiZQJLE2LKH7mIf5Q4NtHISzu8g+5NONvagic0MSbzWFC0TaPw00Sqa0Bu+2e3Fb4Y1nT8bLemoRDZ489xHAh4cynPwQ8XjAVwfp2BWdIJ1YXedY1UPtIoThQbdeMlhFaITOTRHrxWi6cRRK4yYtHMioLG3WGxidkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw8NeNK/Zms/se1t5T8dqEiStFEmrb6cymvtBP4zfYA=;
 b=mGo86X8DN9cPaWxgS/7LhPL8mvjA8d7xBHKzZFZ7zb2CmMuaVjnFrH3VhXs1gYxxNpgbjn3n35NejX1sCCsULvbcDW7Nzrk3A7DEDbCbhfnIQQfCLNpmlxSTmkt5FdOHlIKR4gfMROJUACkg4Adw5kSCF4HXrGc4TUzSmSSbts4=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by TYUPR03MB7177.apcprd03.prod.outlook.com (2603:1096:400:347::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Tue, 14 Mar
 2023 07:27:28 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::a826:a86e:abc3:e552]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::a826:a86e:abc3:e552%6]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 07:27:28 +0000
From:   =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
Thread-Topic: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
Thread-Index: AQHZFeW7Ufe4GFzX60OkXD2JlsAcjK6kFeeAgFZLJwA=
Date:   Tue, 14 Mar 2023 07:27:27 +0000
Message-ID: <70f19f86043750c8f164c316496a8690709fc062.camel@mediatek.com>
References: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
         <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
In-Reply-To: <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|TYUPR03MB7177:EE_
x-ms-office365-filtering-correlation-id: c6413d53-540d-4a39-e6fc-08db245d9098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22mOzQ9mvcdMZqVVvXmSk8Z2RlqctbviMHvsYPBrbYob/iQ3Cb3lfAks8QIhbB5VwI5sRGiZghkVUG+xsPjd089BVX2TN7+HZdCQhHWEIQbo+LJheCttUtyV8KM3kM7sDGENkY62jIFU+SS+rZVLa71EcEmOnIaudyhMTz9hwFhXPOA/78jQxjQX0GlZ6JXlMA4Xz9uE+oFPSAdur5ftG9cFNVaNHeQSJ7bzKnnu8XCOJddKsupBLKsdHETdfc62gOJclHU2471ZgAo/RN0l0mxtcHaqPWfsNWIj6Kzi109kRcu8VSimasv4ZS43wmG9nXcnBbU4+GKf4VCcq7NB/HEMefG9UTYF9v6GVykAdWOhilFKJNIggy1Uohr0Tlzw6icOm0+VWytnuEAjLyo070cB3KiA1Kzl2snZTN4GieUjtAoKCrnRXhutwHUo18QItb+SBWMdMgh3rSO4YeMCtaWcYXqiCrQ8kmMiAoUFrO4vLmYelsVAN1mtWR03E33XFO0g9SCRVyLAfiDTgPgtOO7ylXWZaJruAxquLJaYFhdXVCkWZs/cJRjwZWB447mYrlLavhrZskExSEoPM2eqBF+pNbEGXYjs1ty4a/W/hsx6fXhIJmE8wAdALKCfcgKt+XGu8M0rdMpDwsXG2w1gMyx8uuGoclBh2IZXfJUWo8kRo44+OvvWiPbaF1Gmj4C3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(66899018)(86362001)(38100700002)(110136005)(6512007)(316002)(85182001)(36756003)(54906003)(38070700005)(41300700001)(6506007)(122000001)(107886003)(83380400001)(186003)(26005)(2616005)(8936002)(5660300002)(966005)(478600001)(6486002)(66476007)(71200400001)(91956017)(4001150100001)(66556008)(4326008)(76116006)(2906002)(66446008)(66946007)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGdvbXRTTlVyblE1Y0JmMC80UTZmeThXVDdoSjJUUjl3Z1BiZ1VDclJLaUxJ?=
 =?utf-8?B?WDNLb0p0RWpodXdvVncrYnBFRWRwVHpFNmdhNkxybW1pVXJpUW9YKzE1N0pO?=
 =?utf-8?B?T2EzYlkrWDBsRmVpMlloZ2loNzdBYVlJcjVSMGljUSt6Q1QvWHNVZkVmbU1K?=
 =?utf-8?B?c2ZyS04rMTMwRUdYZ1A0VHlROUl3d2ZKTG5GREU4TERHZ3daK2JzdTdFZzdM?=
 =?utf-8?B?bE4ydGhsWEZCZEpRSTdyUGRwTTNqb0Qwdm5zV0s2ZlF4TkhqK0RBOFd2clNI?=
 =?utf-8?B?UGZZaExhdHBIVUJZWk92M0VGbCtUZWFIYUthUkIrNkxkd2pzcUlKcXVhL0xi?=
 =?utf-8?B?UWJ3L2xzc1VhbGtvM0UrWUZZSUJSMlQzeE5RaVdzbkhrYUhHSXFxMXgvOEFJ?=
 =?utf-8?B?VnNzdjVsTlhPNTBSUEl1cFpQVFpSdC9vRyt4bXlVVVNRd0Ivek1ZRlJnWHFa?=
 =?utf-8?B?c3pycDhTS2NBcWd4Z1AzRkRuV1hVR1hDbGg5TDJjWit0ZzBrN2g2WnJzbFhF?=
 =?utf-8?B?eGdkOWhldHpHUnBTaTVkTXl3NU0rQmsvSDNlbWU5cytCT1JXT1AvcVo0Tnp5?=
 =?utf-8?B?WGs4NlhpWlpIWlpBTUtOZ2hheHpNcTBLeVNvR0J1MERiOTBkSWxjeloyNlor?=
 =?utf-8?B?WVJJQkR0SnYyL05TUWhjdGU4L1haOEozdUlPak5TNDByMmZkTVJLTGVySGhF?=
 =?utf-8?B?YjYyYmE4NTdYUlROYTZFZ3diZXplRVp3ejBwMnQrSjZxR0hGY3pmUG52WUdX?=
 =?utf-8?B?NUxxa0xRdTlvOGJhaXI3Q1RnQ0pqc0ZTUlYvSE5HOVhTc2xkNXRDS3V0LzhV?=
 =?utf-8?B?V1ZTUFJrVi9oWGtpMHF6aEZaSGlYTDFMR1pZMkRBR0FiTjY3WHFMR0VyVlRp?=
 =?utf-8?B?S0FSOTF2bytMZjRJcWlNTDFaTkt0SG9QOGJTMVovQ1JrNzA4SXhtUWhUQUxm?=
 =?utf-8?B?Z1FNZDlRUklqbXlXYkdMb1RWN0RnYUZSSkQ4N1ZkVm5xSDh3UmhCelFTNm9i?=
 =?utf-8?B?b0NCV1dFclNmRmprZStsbGJpUE9wVDFGU2hNTkVxZmNJTVF2bGsraUROTDV1?=
 =?utf-8?B?N2diTFFvV2VBZVV6WjRSQWhHWWJjaXN1UVd2Z09SQ0R3YVZYeHIrb0VORGlt?=
 =?utf-8?B?KzVHTnBUYWY2bnNmTjNyZEJ4c29xVXJSSkxwU0VURlcvK0lCb2pteE1ZU0ky?=
 =?utf-8?B?MG5JcnZJYmhlaEpnM2JEMzVpOXpwcGtJK1hDak95TlB6UktTdWJZQnI3bGZr?=
 =?utf-8?B?SWcxbUNQUWpOSmk5ZEU4UWJ6dFFVQk5yNjY3SFRaVklCbzlta1V0STV6WTlF?=
 =?utf-8?B?TUZSeG5UQmVUL2ozMlJHU0V3YU5GYWxpb0dydEZxSkNNSy9OZEVRWld1Mngw?=
 =?utf-8?B?QzV3Z2dxK0NVV1VXREZVQjZiWnhXak82bmR6c1RMNjJLUWJUektiM3ZxR25Z?=
 =?utf-8?B?U3E3NHc1dFg3QVNSOSs1ZTk1Y0hXMTJ6RURDTTArTVFsclZZMlhsOGMwa1lX?=
 =?utf-8?B?OU1GR24wSCsxNFo3QW80VnVROXpFYkdxWkE2NTlBMzZCcnQ5UlJ1WXpod1Ar?=
 =?utf-8?B?VmorUHlHaUJqZVFLNkVMRVlkK2dtLzArL1pEdWdIcHRkaUs0Y0RWMzJZUG9B?=
 =?utf-8?B?cnIxTjlhbVYzbjRqT0VreFpsOXlQMlJhb1loeDdXSmdRemhNV1FURUVKbFAy?=
 =?utf-8?B?ZTE0WGVoUmdCZlBsSE1hYmo0ZDFtMnZqQllsVE9NUHE0N1lRYU9GSWRWcWVm?=
 =?utf-8?B?K1NVMmc5Skt6R0lUVDNPVld3UFgrWlVYWFdHWEdOTkhBVzBTaUIvVXF3SGlv?=
 =?utf-8?B?TlB0K2hTTDRLNmUwWi9telMySkpWalJNN0ZLbTlxV1dhcEorV2NUeFBVMk1t?=
 =?utf-8?B?U2FTUm9LN3hEZ3U1RVVLRGRjcVZ0WFhxaGgxYlNvOU8vTmQxRnU2UDBKdTND?=
 =?utf-8?B?b0l0VkI4cnZ3OUhlSHBMR2wweGx6T1pCc0tObCszQ2J2SjA3Z2x4UmowdUJG?=
 =?utf-8?B?Q1ExeUJ1SDg2cjU2SE5OWGdsM0FBVEFhT3QxS24xN3QxNEwvWG9TaEdWT3Jy?=
 =?utf-8?B?MGlkQkMxaENEMjlQc3AyRFdrSEpqb3BNcnczM01Tc1VtamtkWDZUeklydEVR?=
 =?utf-8?B?Q2l4MTlXV1hqRitVNWRjdnBHclc5MUkyTUl5aFdRbnhCcWloZFpyeTJVUTd5?=
 =?utf-8?Q?ISptnJytetFkFfHIOvdN3iE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D38B23C4559BD845BCB177DF273CB0FB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6413d53-540d-4a39-e6fc-08db245d9098
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 07:27:27.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vjRlBKmJN/vZ9YJKGBDk4PNzgS0Sl4dVoDG9Uu0f6ZDPZlqOKuxxv/9Hjsi1MdyptErAwHrDiPNR0WuvfP1GSVg41zmG0oKep2HqXAbTs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksIA0KDQpJbiB0aGUgc2NlbmFyaW8gbWVudGlvbmVkIGluIHRoZSBwcmV2aW91cyBtYWlsLCB3
ZSBleHBlY3QgdGhlDQphc3NvY2lhdGlvbiBhdHRlbXB0IGZyb20gRXh0ZW5kZXLigJlzIFNUQSBp
bnRlcmZhY2Ugd291bGQgZmFpbCB3aXRoIHRoZQ0KZm9sbG93aW5nIGNvbmRpdGlvbnM6DQoxLiBF
eHRlbmRlcidzIFNUQSBhbmQgQVAgaW50ZXJmYWNlcyBsb2NhdGUgb24gdGhlIHNhbWUgaWVlZTgw
MjExX2xvY2FsDQp3aGljaCB1c2VzIGNoYW5uZWwgNDQgYW5kIGJhbmR3aWR0aCA4ME1Iei4NCjIu
IFRoZSBjaGFubmVsIGNvbmZpZ3VyYXRpb25zIGJldHdlZW4gUm9vdEFQ4oCZcyBhbmQgRXh0ZW5k
ZXIncyBhcmUNCmRpZmZlcmVudC4gKFJvb3RBUDogQ2gzNi84ME1IejsgRXh0ZW5kZXI6IENoNDQv
ODBNSHopDQozLiBPdXIgZGV2aWNlIGFsbG93cyBvbmx5IG9uZSBjaGFubmVsIGNvbnRleHQgdG8g
ZXhpc3Qgb24gZWFjaA0KaWVlZTgwMjExX2xvY2FsLiAobnVtX2RpZmZlcmVudF9jaGFubmVscyA9
IDEgaW4gbXQ3NiBkcml2ZXIsIHJlZjogDQpodHRwczovL2dpdGh1Yi5jb20vb3BlbndydC9tdDc2
L2Jsb2IvbWFzdGVyL210NzkxNS9pbml0LmMjTDMwKQ0KDQpXaGVuIEV4dGVuZGVyJ3MgU1RBIGlu
dGVyZmFjZSB0cmllcyB0byBhc3NvY2lhdGUgd2l0aCBSb290QVAsIHRoZQ0KcmV0dXJuIHZhbHVl
IG9mIGllZWU4MDIxMV9saW5rX3VzZV9jaGFubmVsIGlzIG5vdCAwIGJlY2F1c2UgdGhlIGN1cnJl
bnQNCmNoYW5uZWwgY29udGV4dCAoY2g0NC84ME0pIGlzIG5vdCBjb21wYXRpYmxlIHdpdGggUm9v
dEFQ4oCZcyBjaGFubmVsDQpjb250ZXh0IChjaDM2LzgwTSkgYW5kIGl0IGNhbm5vdCBjcmVhdGUg
YSBuZXcgY2hhbm5lbCBjb250ZXh0IG9uDQpFeHRlbmRlcuKAmXMgaWVlZTgwMjExX2xvY2FsIGJl
Y2F1c2Ugb2YgdGhlIGRldmljZSBsaW1pdGF0aW9uDQoobnVtX2RpZmZlcmVudF9jaGFubmVscyA9
IDEpLg0KVG8gZGVhbCB3aXRoIHN1Y2ggYW4gZXJyb3IgY2FzZSwgRXh0ZW5kZXLigJlzIFNUQSBp
bnRlcmZhY2Ugd291bGQNCmRvd25ncmFkZSB0aGUgY2hhbm5lbCBiYW5kd2lkdGggKGZyb20gODBN
SHopIGFuZCBydW4NCmllZWU4MDIxMV9saW5rX3VzZV9jaGFubmVsIHRvIGNoZWNrIGFnYWluIHVu
dGlsIHRoZSBiYW5kd2lkdGggYmVjb21lcw0KdGhlIG1pbmltdW0gMjBNSHouIA0KU2luY2UgdGhl
IGNvbnRyb2wgY2hhbm5lbHMgYXJlIGRpZmZlcmVudCwgZG93bmdyYWRpbmcgdGhlIGJhbmR3aWR0
aA0KY2Fubm90IG1ha2UgaWVlZTgwMjExX2xpbmtfdXNlX2NoYW5uZWwgdG8gcmV0dXJuIDAuIEZp
bmFsbHksIEV4dGVuZGVy4oCZcw0KU1RBIGludGVyZmFjZSBiYW5kd2lkdGggKGlmbWdkLT5mbGFn
cykgd291bGQgdXNlIDIwTUh6IGFmdGVyd2FyZC4gKEluDQp0aGUgY3VycmVudCBrZXJuZWwgdmVy
c2lvbiwgdGhlIGZsYWcgaXMgbGluay0+dS5tZ2QuY29ubl9mbGFncykNCg0KQXQgdGhpcyBtb21l
bnQsIGEgaG9zdGFwZF9jbGkgY2hhbm5lbCBzd2l0Y2ggY29tbWFuZCBtaWdodCBiZSBpc3N1ZWQs
DQptYWtpbmcgRXh0ZW5kZXIncyBBUCBpbnRlcmZhY2Ugc3dpdGNoIHRvIFJvb3RBUCdzIGNoYW5u
ZWwgKGNoMzYpLg0KQmVjYXVzZSB0aGUgY29udHJvbCBjaGFubmVsIG5vdyBzeW5jaHJvbml6ZXMs
IEV4dGVuZGVyJ3MgU1RBDQphc3NvY2lhdGlvbiBhdHRlbXB0IHN1Y2NlZWRzLiBIb3dldmVyLCBF
eHRlbmRlcuKAmXMgU1RBIGlmbWdkLT5mbGFncw0KcmVtYWlucyBpbiB0aGUgZmFsbGJhY2sgc3Rh
dGUgYW5kIHRodXMgdGhlIG9wZXJhdGluZyBiYW5kd2lkdGggaXMgMjBNSHoNCmluc3RlYWQgb2Yg
ODBNSHogd2UgZXhwZWN0Lg0KDQpUbyBhdm9pZCBhbnkgdW5kZXNpcmFibGUgYmFuZHdpZHRoIGRv
d25ncmFkaW5nLCB3aGVuDQppZWVlODAyMTFfbGlua191c2VfY2hhbm5lbCByZXR1cm5zIG5vbi16
ZXJvLCB3ZSBjaGVjayB0aGUgY29udHJvbA0KY2hhbm5lbCBiZWZvcmUgZW50ZXJpbmcgdGhlIGxv
b3Agb2YgZG93bmdyYWRpbmcgYmFuZHdpZHRoLiANCg0KRm9yIG90aGVyIHJlcGxpZXMsIHBsZWFz
ZSBzZWUgdGhlIGlubGluZS4NCg0KT24gV2VkLCAyMDIzLTAxLTE4IGF0IDEwOjQwICswMTAwLCBK
b2hhbm5lcyBCZXJnIHdyb3RlOg0KPiBIaSwNCj4gDQo+IFNvIEkndmUgbG9va2VkIGF0IHRoaXMg
cGF0Y2ggYSBmZXcgdGltZXMsIGJ1dCBpdCBqdXN0IGNvbmZ1c2VzIG1lIC4uLg0KPiANCj4gT24g
VGh1LCAyMDIyLTEyLTIyIGF0IDE3OjEzICswODAwLCBNaWNoYWVsIExlZSB3cm90ZToNCj4gPiBX
aGVuIHRoZSBsaW5rIGZhaWxzIHRvIHVzZSB0aGUgY2hhbm5lbCwgY2hhbmRlZidzIGJhbmR3aWR0
aCB3aWxsDQo+ID4gYmUgDQo+ID4gZG93bmdyYWRlZCB3aXRob3V0IGNoZWNraW5nIHRoZSBjb250
cm9sIGNoYW5uZWwuDQo+ID4gVGhlIGlzc3VlIGhhcHBlbnMgd2hlbiB0aGUgU1RBIG9mIGFuIGV4
dGVuZGVyIHdpdGggbGltaXRlZCBjaGFubmVsIA0KPiA+IGNvbnRleHQgYXNzb2NpYXRlcyB3aXRo
IGEgcm9vdCBBUCBvcGVyYXRpbmcgb24gYSBkaWZmZXJlbnQgY2hhbm5lbC4NCj4gPiANCj4gPiBC
ZWxvdyBpcyBhbiBleGFtcGxlOg0KPiA+IA0KPiA+ICAgICBfX19fX19fX19fX19fXyAgICAgICAg
ICAgX19fX19fX19fX19fX19fXw0KPiA+ICAgIHwgUm9vdEFQKGNoMzYpIHwgICAgICAgICB8IEV4
dGVuZGVyKGNoNDQpIHwNCj4gPiAgICB8ICAgICAgICAgICAgICB8IChBU1NPQykgfCAgICAgICBB
UCAgICAgICB8DQo+ID4gICAgfCAgICAgIEFQIDwtLS0tLS0tLS0tLS0tLS0tLS0tLSBTVEEgICAg
ICAgfA0KPiA+ICAgIHxfX19fX19fX19fX19fX3wgICAgICAgICB8X19fX19fX19fX19fX19fX3wN
Cj4gPiANCj4gPiAtIFJvb3RBUCBpcyBvcGVyYXRpbmcgb24gY2hhbm5lbCAzNiwgd2hpbGUgRXh0
ZW5kZXIgaXMgb3BlcmF0aW5nDQo+ID4gICBvbiBjaGFubmVsIDQ0DQo+IA0KPiBXaGF0IGRvZXMg
dGhpcyBtYXR0ZXI/IFRoZSBleHRlbmRlZCBpcyBqdXN0IGEgU1RBLCBubz8gT3IgYXJlIHlvdQ0K
PiBzYXlpbmcNCj4gaXQncyBpbXBvcnRhbnQgdGhhdCB0aGUgZXh0ZW5kZXIgaGFzIGEgY29uY3Vy
cmVudCBBUCBpbnRlcmZhY2UgdGhhdCdzDQo+IG9uDQo+IGNoYW5uZWwgNDQ/DQo+IA0KPiBBbmQg
aWYgeW91IHNheSAiY2gzNiIgb3IgImNoNDQiIHRoYXQncyBqdXN0IHRoZSBjb250cm9sIGNoYW5u
ZWwgKEkNCj4gZ3Vlc3MpLCBidXQgd2hhdCdzIHRoZSBhY3R1YWwgY29tcGxldGUgY2hhbm5lbCBj
b25maWd1cmF0aW9uPw0KDQpPdXIgRXh0ZW5kZXIgY29udGFpbnMgb25lIEFQIGludGVyZmFjZSBh
bmQgb25lIFNUQSBpbnRlcmZhY2Ugb24gdGhlDQpzYW1lIGllZWU4MDIxMV9sb2NhbCwgYW5kIHNp
bmNlIG91ciBkZXZpY2UgYWxsb3dzIG9ubHkgb25lIGNoYW5uZWwNCmNvbnRleHQgb24gZWFjaCBp
ZWVlODAyMTFfbG9jYWwsIHRoZSBBUCBhbmQgU1RBIGludGVyZmFjZSBtdXN0IG9wZXJhdGUNCm9u
IHRoZSBzYW1lIGNvbnRyb2wgY2hhbm5lbC4NClJvb3RBUCBhbmQgRXh0ZW5kZXLigJlzIEFQIGlu
dGVyZmFjZSBvcGVyYXRlIG9uIGRpZmZlcmVudCBjb250cm9sDQpjaGFubmVscyAoY2gzNiBhbmQg
Y2g0NCksIHdpdGggb3RoZXIgY2hhbm5lbCBjb25maWd1cmF0aW9ucyBiZWluZyB0aGUNCnNhbWUg
KGJhbmR3aWR0aCA4ME1IeiBhbmQgY2VudGVyIGZyZXF1ZW5jeSA1MjEwTUh6KQ0KDQo+IA0KPiA+
IC0gV2hlbiBhc3NvY2lhdGluZyB3aXRoIFJvb3RBUCwgRXh0ZW5kZXItU1RBIGRvd25ncmFkZXMg
dGhlDQo+ID4gICBjaGFuZGVmJ3MgYmFuZHdpZHRoIHRvIGJlIGNvbXBhdGlibGUgd2l0aCBhbnkg
Y2hhbm5lbHMgb24gdGhlIHBoeQ0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiBieSAib24gdGhlIHBo
eSIgaGVyZT8gVGhhdCdzIG5vdCBtYWM4MDIxMQ0KPiB0ZXJtaW5vbG9neSwNCj4gc28gbm90IHN1
cmUuDQoNClNvcnJ5IGZvciB0aGUgYW1iaWd1b3VzIHdvcmQsIHdlIG1lYW4gdGhlIGllZWU4MDIx
MV9sb2NhbCBzdHJ1Y3R1cmUuDQoNCj4gDQo+ID4gLSBGaW5hbGx5LCBjaGFuZGVmJ3MgYmFuZHdp
ZHRoIGlzIGRvd25ncmFkZWQgdG8gMjBNSHogYW5kIA0KPiA+ICAgdGhlIGFzc29jaWF0aW9uIGZh
aWxzDQo+ID4gDQo+ID4gSW4gdGhpcyBwYXRjaCwgYSBjb250cm9sIGNoYW5uZWwgY2hlY2tpbmcg
aXMgYWRkZWQgdG8gYXZvaWQNCj4gPiB1bm5lY2Vzc2FyeQ0KPiA+IGJhbmR3aWR0aCBkb3duZ3Jh
ZGluZw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgTGVlIDxtaWNoYWVsLWN5Lmxl
ZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9tYWM4MDIxMS9tbG1lLmMgfCAyNCAr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL21sbWUuYyBiL25ldC9t
YWM4MDIxMS9tbG1lLmMNCj4gPiBpbmRleCAwYWVlMjM5MmRkMjkuLmJjNDM1ZTg1MDhlMiAxMDA2
NDQNCj4gPiAtLS0gYS9uZXQvbWFjODAyMTEvbWxtZS5jDQo+ID4gKysrIGIvbmV0L21hYzgwMjEx
L21sbWUuYw0KPiA+IEBAIC00NjE2LDYgKzQ2MTYsMjcgQEAgaWVlZTgwMjExX3ZlcmlmeV9zdGFf
aGVfbWNzX3N1cHBvcnQoc3RydWN0DQo+ID4gaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpzZGF0YSwN
Cj4gPiAgCXJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGJvb2wNCj4g
PiAraWVlZTgwMjExX2NoZWNrX3NhbWVfY3RybF9jaGFubmVsKHN0cnVjdCBpZWVlODAyMTFfc3Vi
X2lmX2RhdGENCj4gPiAqc2RhdGEsDQo+ID4gKwkJCQkgIGNvbnN0IHN0cnVjdCBjZmc4MDIxMV9j
aGFuX2RlZg0KPiA+ICpjaGFuZGVmKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaWVlZTgwMjExX2xv
Y2FsICpsb2NhbCA9IHNkYXRhLT5sb2NhbDsNCj4gPiArCXN0cnVjdCBpZWVlODAyMTFfY2hhbmN0
eCAqY3R4Ow0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJmxvY2FsLT5jaGFuY3R4X210eCk7DQo+
ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGN0eCwgJmxvY2FsLT5jaGFuY3R4X2xpc3QsIGxpc3Qp
IHsNCj4gPiArCQlpZiAoY3R4LT5yZXBsYWNlX3N0YXRlID09DQo+ID4gSUVFRTgwMjExX0NIQU5D
VFhfV0lMTF9CRV9SRVBMQUNFRCkNCj4gPiArCQkJY29udGludWU7DQo+ID4gKwkJaWYgKGN0eC0+
bW9kZSA9PSBJRUVFODAyMTFfQ0hBTkNUWF9FWENMVVNJVkUpDQo+ID4gKwkJCWNvbnRpbnVlOw0K
PiA+ICsJCWlmIChjaGFuZGVmLT5jaGFuID09IGN0eC0+Y29uZi5kZWYuY2hhbikNCj4gPiArCQkJ
cmV0dXJuIHRydWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZsb2NhbC0+
Y2hhbmN0eF9tdHgpOw0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBz
dGF0aWMgaW50IGllZWU4MDIxMV9wcmVwX2NoYW5uZWwoc3RydWN0IGllZWU4MDIxMV9zdWJfaWZf
ZGF0YQ0KPiA+ICpzZGF0YSwNCj4gPiAgCQkJCSAgc3RydWN0IGllZWU4MDIxMV9saW5rX2RhdGEg
KmxpbmssDQo+ID4gIAkJCQkgIHN0cnVjdCBjZmc4MDIxMV9ic3MgKmNic3MsDQo+ID4gQEAgLTQ4
NDIsNiArNDg2Myw5IEBAIHN0YXRpYyBpbnQgaWVlZTgwMjExX3ByZXBfY2hhbm5lbChzdHJ1Y3QN
Cj4gPiBpZWVlODAyMTFfc3ViX2lmX2RhdGEgKnNkYXRhLA0KPiA+ICAJICAgIGNoYW5kZWYud2lk
dGggPT0gTkw4MDIxMV9DSEFOX1dJRFRIXzEwKQ0KPiA+ICAJCWdvdG8gb3V0Ow0KPiA+ICANCj4g
PiArCWlmICghcmV0IHx8ICFpZWVlODAyMTFfY2hlY2tfc2FtZV9jdHJsX2NoYW5uZWwoc2RhdGEs
DQo+ID4gJmNoYW5kZWYpKQ0KPiA+ICsJCWdvdG8gb3V0Ow0KPiANCj4gTm90IHN1cmUgSSBnZXQg
aG93IHRoaXMgaXMgYW55IGRpZmZlcmVudCAtIHlvdSdyZSBkZXNjcmliaW5nIGEgY2FzZQ0KPiB3
aGVyZSAicmV0ICE9IDAiIChiZWNhdXNlIGlmIHJldCA9PSAwIG5vdGhpbmcgaGFwcGVucyBpbiB0
aGUgd2hpbGUNCj4gbG9vcCksIHNvIHRoZW4geW91IGZhaWwgX2FueXdheV8/IFNvIHdoYXQncyB0
aGUgcG9pbnQ/DQoNCkFzIGRlc2NyaWJlZCBhYm92ZSwgdGhlIGZpcnN0IGFzc29jaWF0aW9uIGZh
aWxzIGFzIGV4cGVjdGVkLiBIb3dldmVyLA0KYWZ0ZXIgRXh0ZW5kZXIncyBBUCBpbnRlcmZhY2Ug
c3dpdGNoIHRvIHRoZSBzYW1lIGNvbnRyb2wgY2hhbm5lbCBhcw0KUm9vdEFQLCB0aGUgRXh0ZW5k
ZXIncyBTVEEgYXNzb2NpYXRlcyB3aXRoIFJvb3RBUCBieSBvbmx5IDIwTUh6IGluc3RlYWQNCm9m
IDgwTWh6IHdlIGV4cGVjdC4NCg0KPiANCj4gam9oYW5uZXMNCj4gDQoNCkJlc3QsIA0KTWljaGFl
bA0K
