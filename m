Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335DE68F2EB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjBHQNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 11:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBHQNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 11:13:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECEF4A1CA
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 08:13:39 -0800 (PST)
X-UUID: 87c331d0a7cb11ed945fc101203acc17-20230209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uqG49vwh6RWyDrLLolG2AvV4nmwW4+qe1K4ARVZNyeM=;
        b=I8+u7er4umFQVcLlfptjAjG+uZcfTAsQS0h9ujuc5MnW5xt8jd/slO3s/1RZxqFGkDZyakYxz7D/mdjqr6uEg2Hqt04Cisy0Nj9z9c1oAgF9BGiQ86ECqNKe3RWbX+KdPo2B4pAKDb1z5x6JT8a66w4VwnpqffUR5sYF8RPUcpE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:63725f60-006d-40ae-9fa9-b50f28d96f7e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:39cb4c8e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 87c331d0a7cb11ed945fc101203acc17-20230209
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 697734128; Thu, 09 Feb 2023 00:13:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 9 Feb 2023 00:13:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 9 Feb 2023 00:13:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8MU1PVQPmG+YKWLgcD7nL4UjY5jnYmn0bnRLGPesjAOBMMozHt1xNY4r+b8W7eYhuS0JKS/7qB5WuSFN8irMXGPoj1tIkvm6mwwiag5IF15E2CjBe9z7PsMv/u8JApXzITSA094mLq8pNkEHyOJ5IS4AmiKENvUO1i9dhPugXW7eMmGPouXax8CUopkUthyJSr+rKNyFWnKSa4m57gv3t9TyF3BASTPOk9Gl7wxI+GhiKrYEQuWbUvl1Q3RU1+G5p8SDC+4huS01dCQJEgse5dDbwi5U+3h24bk3+2H8HHQPjFoxIBOQ9taJjI1V8a3Yy0zktiK42SDSZNbyMySdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqG49vwh6RWyDrLLolG2AvV4nmwW4+qe1K4ARVZNyeM=;
 b=T1qiuSe8oGFIgjhM9Qu+mMCFjc4AKBydjPjdWvWoRVphEHAO8+dRUL8dPRVHTDtwdDHbT1AvkmVoTuU8nJSaEpz477Aw7zZfnt/mYNJL8k/3hrzG974bOvzzBCwnBOd6DKFADqgF09JYGNuaczOxIYnlr1c+QsBCiWTCRffLT8pQe+Ud49w8RTjyZT7SZWkEmwpD+r3ePvXjgE/4Dfg0JNkczU2fsUG74KThPuCh1ZvI9O8eQpkLAe9/VyNgvtRnAzRIwrcLDp1/WHCxo9axn0H7DDA8D7m6Nzay/7izsKjXgpB7bPvH1kjIAoVceRsvSYsQXP0fC3bBfhXQ21oJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqG49vwh6RWyDrLLolG2AvV4nmwW4+qe1K4ARVZNyeM=;
 b=qalL6RHQNnANnyjV+35S6tlW5OjD08C8I73DxZIrWea38rp2xFqyww13/abvAPfQohW2G9P8dxL0nhyNBgZdXRJGN2o+IOITEEgjRYzCqCofcZGCMAfmNcp51tybyU17AJRA6/rhZDTD865P3MTsWPUsYQhCNH/5SE5IUn0lfzw=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by TYZPR03MB5437.apcprd03.prod.outlook.com (2603:1096:400:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 16:13:29 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::56e7:bf25:29f9:18c0]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::56e7:bf25:29f9:18c0%7]) with mapi id 15.20.6064.031; Wed, 8 Feb 2023
 16:13:29 +0000
From:   shayne.chen@mediatek.com
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 2/2] linux-firmware: update firmware for MT7916
Thread-Topic: [PATCH 2/2] linux-firmware: update firmware for MT7916
Thread-Index: AQHZNlmxCIC7teDGwUCQvxxXPvlzpq7FQ9qA
Date:   Wed, 8 Feb 2023 16:13:28 +0000
Message-ID: <c82307e02e6d2c29d2e30209c76fe8bb7c86616f.camel@mediatek.com>
References: <20221123110743.22005-1-shayne.chen@mediatek.com>
         <20221123110743.22005-2-shayne.chen@mediatek.com>
         <d6244fd6-62bd-ba07-fe18-dee559594ece@nbd.name>
In-Reply-To: <d6244fd6-62bd-ba07-fe18-dee559594ece@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|TYZPR03MB5437:EE_
x-ms-office365-filtering-correlation-id: 27bc5347-4b4c-4d8e-f64a-08db09ef6a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIDF+FqpBmfK3EaWHDNguVElc7cZ/sLGramASfkSRWTjH+ubXPl82rtDENThtXb4vh2PY+WrIY4wxrIIVvRaoR2+jigVEIrq6jGRccWoavN+YNobixdnhhHJ2rTPNNTBZQGouFe8p4908/D5lf90sTiG9JTvpfDFizfreRjSGaXlzRJUEMJ+MGPd9ixZWGM9CSOzolFqwK3r594EqB6o2a7iL3ya5xyMn+StXl2sPcUaN131Io1m0nIUSK/SPHzdzCxaz5ZzZV95uno+tcAm8NCyri0i1m97uNealGXoWv0ZsW9GSPbuq4tvJMxGM+hGsoX4l8vCziOoralGP1jewSgCvBugC0uMGBHBeC8SLxM5Pc0gmonyB1uVaLIPBvGT6bbvTxcBsjpzlm4vUbw2nBVvYqpnYe6H8yxwbLupunjhPCnbkbVdS4zqkR6pWdjj1Vwdl23Eg11Gx2StAByqLzeD9si/B0ZjjNnXHdAuYLWmY0SmdAjS90NEJ3n7o0DlnNoXhj8iqeQ1D3ntDO+AGIZjb/QNwIgAeGthahanYFpqZ5x8alZcymioeC4CE0qCqgOCVKKZk5JlBSb/XcJP9Lp3/AMtjbq3LQwTtjIPNkTVtiW942UU7WbE0pBF1Khb9JtPCqhMl+0VVfk4eiVTCnRmAg377u/GgcBXFpNlsTMC9yBQg0jhhqjkWY8schy2ssJTOKah0Ms7Tz2CpW8rADEhqQcrTT0ae6hjZPG5UAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(36756003)(85182001)(41300700001)(2906002)(71200400001)(122000001)(38070700005)(38100700002)(6486002)(478600001)(26005)(2616005)(6506007)(4326008)(53546011)(8676002)(186003)(66476007)(66446008)(6512007)(66556008)(66946007)(64756008)(76116006)(86362001)(316002)(91956017)(54906003)(110136005)(83380400001)(107886003)(15650500001)(5660300002)(4744005)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGYzTFVyZmpMSS9XZEFZUVBsMXc3M1pvemdoTnY5a3U4NmYzS0UzallRRDFk?=
 =?utf-8?B?bTJ2U1JZTXltVndZMDdUOEI0QzdzK1B6ZTJJOU5wVVJpVWFjbm1ZMzJIMHFj?=
 =?utf-8?B?UVBrNEh3V0dlYjFEaGtZcUJCSUFySmtHakwwMTdRTThIRE5XaUtFbjFkU1VI?=
 =?utf-8?B?OTBHYUNzOU1GVzhqSmZudlNsYVFiK1lZMGNBem1McFdnQTJ1VGtmYnZGNGdR?=
 =?utf-8?B?V0diUGVlT3N4NHUwMytTTHlQRThJVUo5eHpzR0tUa3gwcU1lTG5FRXhhdFky?=
 =?utf-8?B?VFNZZ1NEWjBmV2xvYjMzV1lOK0xhUUlTNUdLZ01WNnJ1Yllac0RkcE1FdzU4?=
 =?utf-8?B?NW44N1laR3dKcVJxSTh4ajBldDAvSXlRd1BiUktzbUQxUHlZN0l3UkZldHNB?=
 =?utf-8?B?eGhDT3ZsMlpSNzFnWHQrSHVpR1dOUVh4cnFmUWVVRXlFWlFJQWNSOHNQY3Qv?=
 =?utf-8?B?V2ZJOERVWENmU3JNS1h5NGJYWnkreXBldDV3Skh3dmhPbXVBbERlanZTaUtJ?=
 =?utf-8?B?WE45ZENNMTBMTHB2bytFU243eTM2bUJ3QytQL2RTRnN2czdWU0RwTks2bjBh?=
 =?utf-8?B?aUUxSFdJdjdWc1gxNVozWlU3aWErODc0ZVpXQ00xYVdRYmcrVk9YNmF6ajVj?=
 =?utf-8?B?QTBTa1VKSmk1OEdoSUc2TC9GOVYrS2dtWkg0VjJ3aTBPVXkwMUt1VjRpaVR3?=
 =?utf-8?B?a3Jvbm5hWnozQ1lsL0o2RXdPOHFhbzFmWnF6bkNoaDdQMzdJNE1lUVlSRnFR?=
 =?utf-8?B?OFJNNlVMN0lZck1zT0JGU204REExcU5nWWhrNlhJdVFKVlZYQmNodVRFdEpN?=
 =?utf-8?B?UXI3RFJZREVudmhuWWxHV0NRWm81TVlhWmNKMkNBbjU2V2lkaDRTU0VHb2Ir?=
 =?utf-8?B?N0dsMFRDdlZFYnFFcGVNbm1rTGhnSFE1cUpSWXJ4OUMyUGk3QmJSeUpDQTBC?=
 =?utf-8?B?ZkVDKy9kb2xOVWV5RkhvUEM5SURqMFIzaVVHZlVJYk9OcEZEang0Z1loZ1p0?=
 =?utf-8?B?YVVQbDNJbEluRDlHU3VFN1daallQL1R5STVuTXB4aUpUeHpoYjlneHIwZTF6?=
 =?utf-8?B?M0wyYVh6TWFtSTJEek9WYjZxZE5ZVHB4b3ZVYnl6WFB6VGFpc2xOQUM1SHhL?=
 =?utf-8?B?SjlOcW1lcHdVZTMyNXBwd28zcW5ibjk1d1lzakV0bngyLzN6K2IvOXRNSlR4?=
 =?utf-8?B?WjZ3aGh3S2hZdVFyTUtMZzlXNUdoSndoRGo5SlJxZFg5U2J2cnc2cTNYeFlP?=
 =?utf-8?B?dUkzaEtrWGc0OSs2clZ4cWMyc0VDbGpqMzFKTk9hd1V3NFhNbnYrVnd2SkVH?=
 =?utf-8?B?L1R2WUYwOFFHcUZYd2NtcmlJdmg4djlqcXkzYW1xME9kZThTRWlPa1hSdzlU?=
 =?utf-8?B?RWJhajVJSmx5dlkvMnBLSktOcmJoeEV3aVRac0RWa2JrcFVOa0ZrdHBRRE9v?=
 =?utf-8?B?alduMll1dlRsVHdUZml4Z2NVL0U5NVJmajRCL0Y3dnYycE9TenBYeHpCWHBx?=
 =?utf-8?B?ZXl4dXVmUG9ybGpsWm9DTmdvenlUamF1dC9MZGhEejRlclZPM1VlK0IzeGdP?=
 =?utf-8?B?ekUya0N1elJCRUVWY2JMelM5dXRBL1pEYSs0cEpkcXJnTWRSZ05yWFpwb3No?=
 =?utf-8?B?cUxGZUk3UXA4ZzhkdnlyeFVwejNwYm84ZUp5RFlodXdGcmw1V1JwaEFyQkpQ?=
 =?utf-8?B?dmZYc3lRTlBJMnhjM2ZGdGt3UE0xMmpLQ1JwaXQ3NlhJS3JjRnMxZ0swTkVD?=
 =?utf-8?B?OEpRMGc1eDFBeHc4aDRjZ1pWZ1BxWFpaWTBIdm5pQkt5NWdNYnNIWVFrRDIw?=
 =?utf-8?B?enVERG9ZLzNoaE8zeVRaMlk0aU1JVUNXSGR2ZFUySXQ0VXVwVCtyU3ZHS21j?=
 =?utf-8?B?c3NDRTFPOVJGWDJwamdVanRvcVFhamRKNmNWK09nQkhzaktzMFRlcGZWN2hK?=
 =?utf-8?B?OWJlM0ZySnplMHg3MnZudCs4ZlV0T0JpNHVhUTRZdEptRTV6WXNXd2JzTEF6?=
 =?utf-8?B?em0wazd3VUJNUFZyTkFyNTZVMGZ3RS90NTdMcG1TbFhVVjJ5RWpPTzhOTzda?=
 =?utf-8?B?aTNQeUtWYzBISWhqK3E5U1ZLWUJnMkNjWGZUQ3FCY1IvZXFvVkNWRlpDNTQ1?=
 =?utf-8?B?RVZTa3BSKzREU2k2NDk3L09hVEc1R3VJeWEvU2p3dlBGd1plQXFtR29lanNL?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52AF8EF6DB8E3A47BB0990330C32FB33@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc5347-4b4c-4d8e-f64a-08db09ef6a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 16:13:28.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EW/12aZ6XLBOSIS1wKE3UPXek+iDZXnAIpxzD8urWq6v01aC/NXYtJZAIVXzyKF7NwoeGKqlu30WSmyTbYiiasGGenQyR2U2VbPmmxFCiTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5437
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTAxIGF0IDE3OjA3ICswMTAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAyMy4xMS4yMiAxMjowNywgU2hheW5lIENoZW4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCB1
cGRhdGVzIGZpcm13YXJlIGZpbGVzIHYyMTExMjAyMjEwMzEgZm9yIE1UNzkxNiBXaUZpDQo+ID4g
TklDLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYXluZSBDaGVuPHNoYXluZS5jaGVuQG1l
ZGlhdGVrLmNvbT4NCj4gDQo+IE1vcmUgYW5kIG1vcmUgdXNlcnMgYXJlIGNvbXBsYWluaW5nIHRo
YXQgdGhpcyBmaXJtd2FyZSB1cGRhdGUNCj4gaW50cm9kdWNlcyANCj4gYSByZWdyZXNzaW9uIG9m
IG5vdCBiZWluZyBhYmxlIHRvIHN1cHBvcnQgNSBHSHogYW5kIDYgR0h6IHRvZ2V0aGVyIA0KPiBh
bnltb3JlLiBBcHBhcmVudGx5IHRoZSBFRVBST00gZGF0YSBuZWVkcyB0byBiZSBwYXRjaGVkIHRv
IGxpbWl0DQo+IHN1cHBvcnQgDQo+IHRvIG9uZSBvZiB0aGUgdHdvIGJhbmRzLCBvdGhlcndpc2Ug
Ym90aCBkb24ndCB3b3JrLg0KPiBTd2l0Y2hpbmcgYXQgcnVudGltZSBhcHBhcmVudGx5IGRvZXNu
J3Qgd29yayB3aXRob3V0IGEgZmlybXdhcmUNCj4gcmVzdGFydC4NCj4gDQo+IElzIHRoZXJlIGFu
eSBjaGFuY2Ugd2UgY291bGQgZ2V0IGEgZmlybXdhcmUgdGhhdCBmaXhlcyB0aGlzIGJ1Zz8NCj4g
DQpIaSBGZWxpeCwNCg0KV2UndmUgcmVsZWFzZWQgbmV3IGZpcm13YXJlIHdoaWNoIGVuYWJsZXMg
NSs2IEdIeiBvbiBtdDc5MTYgYmFuZDEgdG8NCm10NzYgY29tbXVuaXR5LCBhbmQgYXJlIGNvbGxl
Y3RpbmcgZmVlZGJhY2tzIGZyb20gdXNlcnMuDQpJJ2xsIHNlbmQgdGhlIHVwZGF0ZWQgZmlybXdh
cmUgYWZ0ZXIgZ2V0dGluZyBwb3NpdGl2ZSBmZWVkYmFja3MuDQoNClRoYW5rcywNClNoYXluZQ0K
DQo+IFRoYW5rcywNCj4gDQo+IC0gRmVsaXgNCg==

