Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7321F6337DE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiKVJEq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 04:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiKVJEo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 04:04:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455BBC75B
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 01:04:43 -0800 (PST)
X-UUID: 6f1bbeb58d1843219f1d0e61ddd4b3b4-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6J88REFcnXMTdZmvT7o9/iqy9a5lOe9g27Ub5mC+bt8=;
        b=TsLy8RwcLgJYH/Q50CvQAMkKVHUuXQrafV5GzNReMXR35SbFyjaOtEvcUykLruiWS9VZGNuOCRGxXgU65q2VyxBKAUvp/Js6E4s0lNrUwYmE9tAgTV+zJm0MkhiMrHFYOn24hV9YukDrYBGaiYAPsN5pFq4pzf7Rp008CX9BhYQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:182845bb-060c-4d96-ae51-073faf58c12e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.13,REQID:182845bb-060c-4d96-ae51-073faf58c12e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:79b17b2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221122034521YEW6QA4F,BulkQuantity:6,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 6f1bbeb58d1843219f1d0e61ddd4b3b4-20221122
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 716398592; Tue, 22 Nov 2022 17:04:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 22 Nov 2022 17:04:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 17:04:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkq3TujTjPXi24o/o1bSno40OHcKN1FKxgA11u4RNNKB3MKCPkLeh92LXdzEeG8FqO+tYza8q+6z9FR6/CbEFjxAo9Aza1cA0x4MFsnWPFO+Z/bm+yQn5gxAi2oOnfmU7pA/dOeFrtWYEa+YQojwmL+jnJpPr60oonZBZJITlw4ursxHSrBjkZq4eyjk6FhsBCwHHTkmMezlG957pqTBYRqNksTroPE+JH2R3BttHvcK3+M33yzrCMt3bgGo79yRAWAWtAmG4jGlcjk0VqPbwVd6+Kgs0khFJn/DSNweyTAGpDWF/62Mxz1/xT0G7qEuBtuitpGJPKLad0ZdcStmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J88REFcnXMTdZmvT7o9/iqy9a5lOe9g27Ub5mC+bt8=;
 b=Zcary6cQsikG8kCq3sZzG2RWgkaBxD+DveerEk0zn1fh1ryfYYmlZkutmNl+ESJ3cpoxBk0q8bfGh8ThHWmFUfDHOv060jSf7e88Alx5Lkn9KFHCqMVWo8603and8Lk4k9mRwukzz01wtKuwphumjdFijNAUpFh2qPgAef+Yxp8PBr863g2YAVVxrmUphLDK4FNhIL0WHSAMZa/5s6AC6k6aF0ITU1diwEkLQP0gGirpbor9BNeuBCXHCqd6zGiOZNkxAhwUT/gpTk/+4DiKW/gl/uNyycO9GFDUBxCV3S1P9bJLo35bOZC3shNBuNk+8rJOfiz8ZsAiwSdtjxBO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J88REFcnXMTdZmvT7o9/iqy9a5lOe9g27Ub5mC+bt8=;
 b=kl4lZ+NvoqlzByS0m/aBRq5ZFu4g964DjKiwpS+KTZm3aRrYdSCOo5M5WhmboS491UdxmQ2UwUsTEBPBjATH9AGiGRr1S1ANo+7t0J+fquMQtBfLJ8hhRhd5e2qxNHBvsUOrBFquRoN9n1xA0BA3z7b78WyGv4R+FvgFe0YI9do=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by KL1PR0302MB5441.apcprd03.prod.outlook.com (2603:1096:820:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 09:04:30 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::658c:288d:5ce9:29f5]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::658c:288d:5ce9:29f5%7]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 09:04:30 +0000
From:   shayne.chen@mediatek.com
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SG93YXJkLVlIIEhzdSAo6Kix6IKy6LGqKQ==?= 
        <Howard-YH.Hsu@mediatek.com>,
        =?utf-8?B?TWVpQ2hpYSBDaGl1ICjpgrHnvo7lmIkp?= 
        <MeiChia.Chiu@mediatek.com>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?= 
        <StanleyYP.Wang@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi
 7 (802.11be) devices
Thread-Topic: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi
 7 (802.11be) devices
Thread-Index: AQHY9OgPR0BV1n2v106PJn0Pu5rObq5JjH/6gAEsiYA=
Date:   Tue, 22 Nov 2022 09:04:30 +0000
Message-ID: <83f60433f893331337012a6ce8ed920db67639c4.camel@mediatek.com>
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
         <20221110093525.29649-10-shayne.chen@mediatek.com>
         <87ilj8pcqr.fsf@kernel.org>
In-Reply-To: <87ilj8pcqr.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|KL1PR0302MB5441:EE_
x-ms-office365-filtering-correlation-id: b963f7a2-4f61-44a4-0be6-08dacc6890f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTRv1t7tFrzXlxKoMkPlECGSBiOZEtPEvDXx5/PKK78JgtncM4nVuMv23RSvo8kLqlXZ0Jgy8CRX+0wr1gJPLay3w++u44tduCEsZDjiQdezcVYP3ZzaU62/c/o1qQWfZa0l83lmsg0jYen4d8Rg/gZA+wG5XIMCGM8LnQ6Vs7Ka96+hy38zfQqFNmpgyQQk8LMnUfE8uQ6PzZgvkZjXD1Neqx662K0FiGPJu5ELacy7FnlytPnVeID8o6OHHFNIAgY5RGOT2YjJ2wnHudNP7AMLAnItvA1fk8yCwkp9SH9FFOeJpLO222/1bZbaw3K761Eseo/5Tvn/bCQDaR/z7oLTfSJFY+7i9dxe+44Eo8VlOxjn3Ts6c3crpUoYF4h+mVebHyG+GB9hbikFcipa+dlbUFWwMNsVCQ4hb3y/ivqDXA+EpNdvgqRFeITcs2UdIIXP5Vg/CQUjzVUZibxJ5Tz/tqumvMQ/b6LGVbDiarFwTq1H6LaPnPQgBfWcDX1N+1YdNUD3lcYYpDN1VSisUnR9QoHzy5vx8yxJaAwDs9IffyaqDRSkl+dAmTV96hkH1bEzGj3gxvxZjbgc54CiGeNIK4tEibbpniCk4gYyf95RI4t3dSSh3dzTjikzQkV5Qh03aCM00GRs1R6+OxacGofpzTv4gvGomOXL6vfRekt02pxcOky2LXiGHv8jYdTqx8hH37v3gguCBXRzeHC1SeVF1zxONPNEeW5y5g5AUyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(26005)(122000001)(38070700005)(86362001)(66556008)(71200400001)(6486002)(107886003)(6506007)(478600001)(76116006)(66946007)(4326008)(91956017)(64756008)(66446008)(8676002)(41300700001)(66476007)(316002)(83380400001)(2616005)(186003)(5660300002)(6512007)(4001150100001)(54906003)(2906002)(8936002)(6916009)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDlZUXphYkJ6WnpQcXFYUUxWdGNmaFpYYkFBYThXZTU2dVdaTjFGckpNL3Uv?=
 =?utf-8?B?bzhJVnNucmxyRGV0MktCWEx3U0ZucmxlUlpRbFNScnVWNlY4dkJtK3dPYmdY?=
 =?utf-8?B?S08xRi9PWlJOdXVtQ01sUktuVW5uVDlsdzYzaVM3UFV1ZTV0Uk9GRUJQT3Z5?=
 =?utf-8?B?SlRoWG1veHhnVSsyV0wwVW1vdmVCRS92ZVFWdjltUkF4TU5VdmhnYUgxM3VM?=
 =?utf-8?B?cE42N2NBOGFpaWpiQmR4c2V3d1NhVmRHMmY2Ni9kWEdWRGdsaXBNNm1CVkM2?=
 =?utf-8?B?bHRTM0haV2ZpcXM0YkVaV29DUStqd0VLbWs1MWZiOEJhTG9CMnl1QXdRcEpK?=
 =?utf-8?B?N29CeDRjS2d4ZDltYUdwaVR4Q3kwSUNSWHhRNjNVODdGR09IWHFLcWxlU0Na?=
 =?utf-8?B?ZGNBSFE2U2pDQ2ozV3pGRlk5WlprUjVKTnpHeFhoWXJVMHlyWm00OWZiTy9K?=
 =?utf-8?B?RFdqQzM5a3RBSWcwejFqa0lvOEppTkxiendTVDMxOTBEOWgrTW9Hcm8rSjRw?=
 =?utf-8?B?T216eVZ6YXVDVzFDWlBTZ2JSNHNVSUxLa1JFVXljVUtUaHhLVnR1SG1WbVpv?=
 =?utf-8?B?ZEQrNnI1NE9iajF0a3h0enRWdWk3Q1FIRGVEV1N6ZldhdVQ2ZmNPZUREMHZL?=
 =?utf-8?B?b2V6MTNmS2laWjU5YUp1dGo1QXFCS01YQmYxek90MGxsVUVBTWRWeHhZMXpE?=
 =?utf-8?B?TVNzYXlTWnVoeEpRMlFoODU5aFdLQTdOUEtFeldFM3VHTXJ4RG9MSld6Y1F1?=
 =?utf-8?B?UXk0Vm5FUVZ1b0NkTitDQ1RNSGtSY3BOeDI0V3puZlZ0Vm9VNGMyZUZhVmtK?=
 =?utf-8?B?Q0dRa3lqVWE1TENDWVIrQThRTEdZREkvNldDQ1VVQkl2UWR2c0dxZTFNV0lM?=
 =?utf-8?B?TkpXRmdaTnVLaEcyYWE0d3BUTkhuNjBRcTJSQ2plTUVzeHR4OU16Z0ZaUHpq?=
 =?utf-8?B?Z2pRTGhqK0hoS0VONVJXd2tHajlMSmk0N29jVXNTWHNQUlFPRkcwVHlvdDlL?=
 =?utf-8?B?RHNUOWgyeDM5dXNyMWR5SDdrTWdMTFhXSlErc0RTUU9XZzlOZVV2ZEVTQ2U3?=
 =?utf-8?B?SG1nV1RBV3dTaTFmWHRzTXJUcVFFWWJJdmpjY2M0eS9tWXBXNWMrNkM3YWFm?=
 =?utf-8?B?M2I2UHdDRTE4YVlmT0xXSDdLNTA5cW4xWXRRVEFZaWQ3Y0dPaUh5WTdxL0o0?=
 =?utf-8?B?K01tR3Zmbml6SkZ1aUZzZFVMa1JEWjVqUUdKWThLUi85eWJ0dnZMcjNTWksv?=
 =?utf-8?B?ZlhERm5uNnJXQjhnV3E2ZkhMalA0WGdkSVVIeXRJSVcxTCttOWcvRDNZekR4?=
 =?utf-8?B?TFVpUmxKQU4waTJHaFkzbTk2TDJaTmtvR3MwSzNsZEFJcGNocVROL3hMRlha?=
 =?utf-8?B?b3NXSmhoMTVEblJFSk1PMHZsbnp2SkZ0MHdPUWNpS1g3VTlGUkw5WUp6T2Y1?=
 =?utf-8?B?NnMwdGZtTjBYK2ViYXVPZ0dENmZmM0xYL0s3bjRVMDY2SU1STEJpeTFxa2Ru?=
 =?utf-8?B?V2lnZGgzNGd2Zm5kbEFiang1Q1hGTU5YcWorV3VsZXd1UHZIcGJObHJNU1E0?=
 =?utf-8?B?YytnSGMraW5nNXFwZm00dWFLT1FLQThpOGJ1b2lKeWZvOFlXNmxLS2s0VnVm?=
 =?utf-8?B?aVhRT0syWUx0Ykh6ZnRjQWMxMkF4b3VaMTQyY0R2bHRiTW91Z21oYWl0VklK?=
 =?utf-8?B?QW9Lc2dLMUQ4bXBYbXdxd09GNm1jc09IYzJZSnRwaHZBN0pKTDVyeGgwSTBo?=
 =?utf-8?B?aHlzUFBkR2IwZHRHNGRWVndoSGRHM2pndit6NTl4cmdReFNsdDFGT3M5aEhP?=
 =?utf-8?B?eHFZc1o5QWdqWUVRWXo5S3VuV1h6V254dmJRUEF1bWRaN0FheWNyRlRJeVVi?=
 =?utf-8?B?K1lNejlMdkhncnJjMUVVMUdLTUlOYm9rSlhOa015TXJCWDh6ajZqVFdIVnoz?=
 =?utf-8?B?amVRdjhNb0ppRS96NE9KN3JhdDdMR0NQT2F1UkU1SXlEOGlPbkJWWS82a0ZL?=
 =?utf-8?B?TFBjRjJQWWE1U04rRFVJVEhwdmVqRmg2ZGF6SlVCK1ZNYTE1MUxMSCs3MndU?=
 =?utf-8?B?aGZNNGwyTFIvYWhMSVNKd0EzTVpwV3BRSXNiY1A1eUo0MExYOW15a25SVU9z?=
 =?utf-8?B?azBjTTdlYkYrYVRoMHNWOTd1KzZIdHc4TlczVUpJaHc1UHhTdm94YlVYU3kr?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B09A837D308E6646B38268579890FBFE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b963f7a2-4f61-44a4-0be6-08dacc6890f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:04:30.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVs8N3CYXhPT9ox94up9GVClL6xCUy7Uv4VIgWB8A3TKZsWEoFd0KBmnEPSQqAb/DLZ3PJhVab23irAwUOQgo/k9apglZ5jttaCxX3c5tbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5441
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTIxIGF0IDE3OjA3ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBT
aGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEFk
ZCBNZWRpYVRlayBuZXcgbWFjODAyMTEgZHJpdmVyIG10Nzk5NiBmb3IgV2ktRmkgNyAoODAyLjEx
YmUpDQo+ID4gZGV2aWNlcy4NCj4gPiBUaGUgZHJpdmVyIGZpcnN0IHN1cHBvcnRzIEZpbG9naWMg
NjgwIFBDSSBkZXZpY2UsIHdoaWNoIGlzIGEgV2ktRmkNCj4gPiA3DQo+ID4gY2hpcHNldCBzdXBw
b3J0aW5nIGNvbmN1cnJlbnQgdHJpLWJhbmQgb3BlcmF0aW9uIGF0IDYgR0h6LCA1IEdIeiwNCj4g
PiBhbmQNCj4gPiAyLjQgR0h6IHdpdGggNHg0IGFudGVubmFzIG9uIGVhY2ggYmFuZC4NCj4gPiAN
Cj4gPiBDdXJyZW50bHksIG10Nzk5NiBvbmx5IHN1cHBvcnRzIHRyaS1iYW5kIEhFIG9yIG9sZGVy
IG1vZGUuDQo+ID4gRUhUIG1vZGUgYW5kIG1vcmUgdmFyaWFudHMgb2YgRmlsb2dpYyA2ODAgc3Vw
cG9ydCB3aWxsIGJlDQo+ID4gaW50cm9kdWNlZA0KPiA+IGluIGZ1cnRoZXIgcGF0Y2hlcy4NCj4g
PiANCj4gPiBSZXZpZXdlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0K
PiA+IENvLWRldmVsb3BlZC1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRl
ay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBCbyBKaWFvIDxCby5KaWFvQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCbyBKaWFvIDxCby5KaWFvQG1lZGlhdGVrLmNvbT4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IEhvd2FyZCBIc3UgPGhvd2FyZC15aC5oc3VAbWVkaWF0ZWsuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvd2FyZCBIc3UgPGhvd2FyZC15aC5oc3VAbWVkaWF0ZWsu
Y29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogTWVpQ2hpYSBDaGl1IDxtZWljaGlhLmNoaXVAbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1laUNoaWEgQ2hpdSA8bWVpY2hpYS5jaGl1
QG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFN0YW5sZXlZUCBXYW5nIDxTdGFu
bGV5WVAuV2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleVlQIFdh
bmcgPFN0YW5sZXlZUC5XYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IE1v
bmV5IFdhbmcgPE1vbmV5LldhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1v
bmV5IFdhbmcgPE1vbmV5LldhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTog
RXZlbHluIFRzYWkgPGV2ZWx5bi50c2FpQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvS2NvbmZpZyAgICB8ICAgIDEgKw0K
PiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L01ha2VmaWxlICAgfCAgICAx
ICsNCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9LY29uZmlnIHwg
ICAxMiArDQo+ID4gIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9NYWtlZmlsZSAg
ICB8ICAgIDYgKw0KPiA+ICAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvZGVidWdm
cy5jICAgfCAgODUxICsrKysNCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
Nzk5Ni9kbWEuYyAgIHwgIDM2MCArKw0KPiA+ICAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5OTYvZWVwcm9tLmMgICAgfCAgMjI5ICsrDQo+ID4gIC4uLi93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210Nzk5Ni9lZXByb20uaCAgICB8ICAgNzUgKw0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTk2L2luaXQuYyAgfCAgODE2ICsrKysNCj4gPiAgLi4uL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMuYyAgIHwgMjQ2OCArKysrKysrKysrKysNCj4g
PiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMuaCAgIHwgIDM5OCAr
Kw0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21haW4uYyAgfCAx
MzI1ICsrKysrKysNCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9t
Y3UuYyAgIHwgMzQyOA0KPiA+ICsrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmggICB8ICA2NjIgKysrKw0KPiA+ICAuLi4vbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21taW8uYyAgfCAgMzg1ICsrDQo+ID4gIC4u
Li93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaCAgICB8ICA1MTYgKysrDQo+
ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvcGNpLmMgICB8ICAyMjIg
KysNCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9yZWdzLmggIHwg
IDUzMyArKysNCj4gPiAgMTggZmlsZXMgY2hhbmdlZCwgMTIyODggaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gVGhpcyBwYXRjaCBpcyB0b28gYmlnLCBwbGVhc2Ugc3BsaXQgaXQuIE9uZSBwYXRjaCBwZXIg
ZmlsZSBpcyBhIGdvb2QNCj4gcnVsZSBvZiB0aHVtYi4NCj4gDQo+IEkgZGlkIHNlZSBzb21lIHN1
c3BpY2lvdXMgc3RhdGljIHZhcmlhYmxlcyBpbiBwY2kuYywgYnV0IG90aGVyd2lzZSBJDQo+IGJh
c2ljYWxseSBza2lwcGVkIGV2ZXJ5dGhpbmcuDQo+IA0KSGkgS2FsbGUsDQoNClRoYW5rcyBmb3Ig
eW91ciByZW1pbmRlci4NCg0KSSd2ZSBzcGxpdHRlZCB0aGUgYmlnIHBhdGNoIGludG8gc21hbGxl
ciBwYXRjaGVzIGJ5IGZ1bmN0aW9uYWxpdHkgZm9yDQplYXNpZXIgcmV2aWV3Lg0KDQpUaGFua3Ms
DQpTaGF5bmUNCg==

