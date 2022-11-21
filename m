Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF4632D2B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 20:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiKUTpo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 14:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKUTpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 14:45:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD0D22B3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 11:45:25 -0800 (PST)
X-UUID: 68dc943958f044c08087741301fb4ba4-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FpfWGw2SgnSFruw7Qy7db4+sZ4JITQWO00wpr4hWk8Y=;
        b=G4Bp+i7DPv7HsDF2Ipn2hSOnpWn5RB5cGqVRdCn2uzMOs+PEldDMxwc2RI54DFa9humfRbdB1MeG6tA33s/h0iW0IF+abGEjQEC3n3Xiq0s9Nr2/xpRqMEXCaABUEpCQV0gFIEGXCe0me4Kjsfm7P67YJgBoUwiX5snKJsb+zYo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:3453a4d8-0e77-43a4-8202-75ae2b6be6e2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.13,REQID:3453a4d8-0e77-43a4-8202-75ae2b6be6e2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:2bd6672f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221122034521YEW6QA4F,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 68dc943958f044c08087741301fb4ba4-20221122
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1927995823; Tue, 22 Nov 2022 03:45:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 03:45:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 22 Nov 2022 03:45:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTHsWtp43640zSCaakgwV3Y/qhWtJuqqgzzn9sA6cw1/i1f+OEOk+GhWoui74/QX7zYQd1F7jOW3Jm2FwldwN3Na4WvKD4vORH0zoDRHr3A9u2N4yRfV+HEZ23qjjowH+kny6jYporld46/Vu2WqQYsDEWPUYsYuAKdRZlekW6iRS2HUxqjZz3cQeVtdDCnSfBMyjjze2wsJXDGayJov3znWTDYzvQjnm4BbbskPrI+ym1D4Iq1tTuwllIw0eIU3wy5rPwRRo8QLzuDu4MCKdOo8NXVRg4TZJ59o9noc1GA/6B4nC+QE1RQMWZzGlrez+n5JsBWWkBGvnbJntWOIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpfWGw2SgnSFruw7Qy7db4+sZ4JITQWO00wpr4hWk8Y=;
 b=QQp8qhxNhx+VKgLk+45RZntX7NfCdOtfI2Ig3bvuwokljMAi12DTylkRVO8zxWyPJkS22cLSm4tDmUHKRTDZXsc3HmzrgvcnzbEFyoS5jpLkOEW4oTTb1+jCcT3rMTk9HKqoCsA+YmsQJTNSXybb+a7nYF8dzA2VIQeTFDVeiwyaDfdwdaRjGYAJf/HwynR2sleg6z3fSulUok1aA1sTkwSsdbamjl5dzcRNaRz+ZsfwF52SLHOxSWzXSYAmFiwcP/aUFl2yK1kSt8JVuE30Mcg8jW0Okk8k1Es7EXGIpnZRJ1ejU5KiME3V45CrGRBMJq/n57dJWEzRxMmr4LtRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpfWGw2SgnSFruw7Qy7db4+sZ4JITQWO00wpr4hWk8Y=;
 b=EEC48WnDruFc3qQ/QmJC0xoYMWMVFVsxu5PgdzJpqKsNR2zyBqAP4KRjAmr18kImx/IIQh7UC+8IE9Zdmt4AuYMupIUVVYAMoT44pS3Fgh8pEQ0Tvm/SLrJgFM02bi3ISuBR+VIJPOxFHe1hMsrwlgX6gAUJcAoj8psbHDLfetc=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by PSAPR03MB5783.apcprd03.prod.outlook.com (2603:1096:301:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 19:45:14 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::3c4f:5697:636e:56e6]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::3c4f:5697:636e:56e6%4]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 19:45:14 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>
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
        <Chui-hao.Chiu@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi
 7 (802.11be) devices
Thread-Topic: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi
 7 (802.11be) devices
Thread-Index: AQHY/bsiKpHNlwxwc0y52TSXv+lmxK5JyBKA
Date:   Mon, 21 Nov 2022 19:45:14 +0000
Message-ID: <0285ab6ac5d3edfdd513ff3888481f0764b2e38b.camel@mediatek.com>
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
         <20221110093525.29649-10-shayne.chen@mediatek.com>
         <87ilj8pcqr.fsf@kernel.org>
In-Reply-To: <87ilj8pcqr.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|PSAPR03MB5783:EE_
x-ms-office365-filtering-correlation-id: 6962504d-396a-4048-9125-08dacbf8e8cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSxGmga4AryK0ijHYJ3cfY5SxJz+40hEAYmCYsOf4lz/he/25nXPGTzpi5ZdXLJjBcxDm0RDZEH2tK7jC/jB4hqvkvaW/F9fcFxW/f35KOafAoGL/hgitxMAf09ynbnoblzptdBDcMxNe3O6eEmhXvam4OEl7DHVITClZLGrRm8jQhGLE5jp2tMiHTl6v31y5ltJ1QG8n9ZLnXxfRzWH/wckP6UOrUUoNBILQq0uVMMmfpuTFqn+xBSUbMdNk4dXIrtb2pbLqGTV+Z3ZLCtZnCUxym8upglD74MxPX3CpDWPeHm8anfN7zyFy/cVfbiriRoV5AsbeK24UOAxxCA0BN398+rdO6EjeGjeHZVZYcYIJKXzBxvRYZ39F8rsos7rYwHCoBUng3Q1Zyz/W41RYcAAULSE8SuopnoMviXT+OqtVO7hBWA7BJnsjttPi/bTBhTFJVOWoKNvfLu071EWiOzgiSkTwuRbLSkplr9nW5DJzb5TL0BdtJJr7zcPNpDYa0xWxIIVw87Z/BER5P2BTtVlGQzDcimfGTYBKNsWWPGZwV5XvEO7eAtuHxuX4/MOfHeGj5HSiN1qWXSQtN1Vrc1ha1OpneMhdoKSj6OuFXY2zmpma6SkLZzSPYpRqSsyPLQdC4gCs+oND6XIzZbU00cXTUnbVcqaEO6gV1C9iuNuxYQEYTvln1SwDR7V9cf6BBd1orRUDbl0TD1sX9P/1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199015)(36756003)(38070700005)(86362001)(6506007)(38100700002)(122000001)(66556008)(8936002)(2906002)(83380400001)(4001150100001)(41300700001)(8676002)(26005)(6512007)(5660300002)(66446008)(107886003)(316002)(186003)(2616005)(478600001)(54906003)(6486002)(71200400001)(66946007)(4326008)(66476007)(76116006)(64756008)(6636002)(110136005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGszQWpHVjFzK2wwL1A1V3JOZXJNSFRPZGxwVTRJeXNlSW9Wck02Rmtzam03?=
 =?utf-8?B?Sy9iNG93YTczMk1aUGd2WWVXZDU0emtLblBVMkIrbU8wR3ROS0NoWC9PMFlK?=
 =?utf-8?B?WTZia2FBdkpETVlnRHI3Q1dYYllyS3p5ZEd5dTI5WTVpMFNpMnVxK0dKL3kr?=
 =?utf-8?B?ZXBBWk0zQmVqS1JOMnBIaWFrd1VrRXhVL2lkRi90cWRJTUlvRWMyR2gvdzZr?=
 =?utf-8?B?NmEvQ1RGdU9zZjd0cDZ0RTE0RitINzhSLzh4UHZoY3prQjUzZnh2ZkhscERP?=
 =?utf-8?B?TTFmd3h2aFo2NnpPcW1wN24vYThPRVRNSytRV2d2TjVra2J0MG9INVM3aGxt?=
 =?utf-8?B?aEN4NmlnaGxXN2lybDcvMTV3WHRJTnQ1Z2dxOFdMR0U1VitlRENPakdCRnB1?=
 =?utf-8?B?Sm9aUFJpeFZqNUI2UUFGZUlxcURzWUlEdjlQbTF1WHE0cXovVGVaOW51QkQr?=
 =?utf-8?B?UWFscnZjSVErZHlwL1lvNUZwcHhSWWh6azJsMWc3TzFKY2loUHJsb0RGTDJJ?=
 =?utf-8?B?S3k5RHlxdjl0TDc1VWZUWVg0T2VTK1A4djFMQ0lUc0htYWdrSWtBUWpGcEN0?=
 =?utf-8?B?QzM4d3BJWWExZlpCdndiUnpPQzNjOFcvbWJFckNqWXdza3oxK2U0enh2SHpM?=
 =?utf-8?B?NUNQNDZiTHJmWTJ4ZWhpaENmTHlwZlN4RktoNTg1Wm5tYWFnS09lTmZmZ2Iv?=
 =?utf-8?B?TTJZRDN3clBXNWx4SnVaUitMTm55cThSSy8wN2liTzhqSTlYU1VNbGpTNHFs?=
 =?utf-8?B?ZllhRGtFU0NsREVDQ1BNc0NuU2pHYjhHY2NKZU42VENTWmoveVE5K21WdmNn?=
 =?utf-8?B?TW40KzBzNHlQSjFtK3hGRUMzYk8wT0FWM0VwL2dHY3A3QU1TcVQ3SHIxTFFw?=
 =?utf-8?B?bjhxNjNNUUljRG9RK21HVDJmODR5L256NEFML0NPemhSMW84Y3VjUzJDTTVD?=
 =?utf-8?B?bFdEQ0ZqY0k0MVdVTWJtMDRoV3c1RzF0UHNFaFo4MTlBUS9OSGppZ3EvUzUx?=
 =?utf-8?B?QUFTOUZDRVZsOVhocDlEYmFSa2FxZnJtN0FsZXRCOXVYMHp1ak0zeTZrb0pj?=
 =?utf-8?B?SUY3T2lCMFJlbGhZUTl3SGovMXVVVENzRXg0eHRFdjVFK1lKUHV0TmNlWEJi?=
 =?utf-8?B?d2hOeklQZGczYUZFdDg3UGt2T1VTblhPa1IvYjY4YTBkTDVWS1dkMnlRdk5L?=
 =?utf-8?B?TWpKMFI2Q2VwanY4WTR2WWFXc2ZOZEFLVUJYeTJ2OFQzSDJrbHowZHpZY0hU?=
 =?utf-8?B?SE9qNVUyblpTWTdVaUFPQTZCai9jdjdFRWg2Vkc1YmpZOGVEWU15dXkvM1k0?=
 =?utf-8?B?YjFsQklDTUlhUTZBYUVMTHBDSU5UT1A5R1ZTdVZRQVVpQzkyQ2F1NzFQYi9q?=
 =?utf-8?B?aUhwMDJnVmVDWktHazVKblBDVnBlcWNzSTUyYzhzT24yWnd5OTlSYkIzWDkx?=
 =?utf-8?B?S0N1OFhWS2ZIWmw1L0w5UWxUQ0ViaDNMZEJycURNZm0xWWRXVlBaanRlK2F3?=
 =?utf-8?B?d3YySC95dmxEa1dWbWlTYTNMWVJheDlJdmdueGFJSjNhRXVPTHkrZHd6eWRz?=
 =?utf-8?B?bm1rZFUrc2F0OFNhN0hzZ2NDbEhMVTlYdmFBajl3UktaRHlrcERZai9OUHZa?=
 =?utf-8?B?N1Rna3h4REZEOGtzRFBDMVN6WVJ2N0ZvVllmMTFIalBBK0h6VDlucVdZc3Jr?=
 =?utf-8?B?Z0RRRHIzd3ZDQUFhVWpLNWJLTXdYUThXWlhSM1F5aWFTa29pUFdMVkg0Sk5N?=
 =?utf-8?B?ZkZocEhtaDZ1QUFLR3pkaDF6amJGMDg2U2NTckh4bGxCWlg1dlFPKzByd0t6?=
 =?utf-8?B?bUFOaE16N1FsRXFCQjdKVVA1QXlEVUF5cXViSFBHV3MrZk91dkF6OWNMaS9B?=
 =?utf-8?B?akxwUFRsbTNkUTZMZTBhcVM1Nm10d2MyQ0pzZWZkcklUTGMzVmZBNlRqU08r?=
 =?utf-8?B?TFlnRWVzQ05pbTFxOXFLTS9scCtCMjRtU1dva3lDbFZ4T0hWeThqK1RRMzVH?=
 =?utf-8?B?SUttcUVPamorK05Hd0VPYytLTW16a2hwMWd6SCtSQjljbE4yVHFSaWF1eHZD?=
 =?utf-8?B?VS9lK0R5b3cvZjR5dVVmSVA5aWhVK2xyWHpvbkxJRGVtc1QvMFllaFhJSkhU?=
 =?utf-8?B?Y0hlbTBlVHVMZWpHNWRNRHNaTW9GZHE2TXFKZ29SWlRPeVNmS0V4MTMvQWxa?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD668143C1788148B22CA390EDCBB609@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6962504d-396a-4048-9125-08dacbf8e8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 19:45:14.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6fTYd0Xjo/VJu+B7T0mfQ+CtHO34t8whlrUfGxdBALH2TXz4A96bcpLliFTj9Dgm4xGVGqtTBE9vrA24TxOmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5783
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
ZmlsZSBpcyBhIGdvb2QNCj4gcnVsZSBvZiB0aHVtYi4NCj4gDQoNCkhpIEthbGxlLA0KDQpUaGFu
a3MgZm9yIGNvbW1lbnRzLg0KDQpJdCdzIGEgYml0IGhhcmQgdG8gYWRqdWdlbWVudCB0byB1cyBh
Y3R1YWxseS4gV2UnZCBwcmVmZXIgdG8ga2VlcGluZw0Kb25lIHRvcGljICh3aWZpNyB0aGluZyBz
dXBwb3J0IGZvciB0aGlzIGNhc2UpIG9uZSBwYXRjaC4gSSBndWVzcyBhZGQNCmNvZGUgdGhhdCBp
cyBub3IgdXNlZCBvciBkb2VzIG5vdCBjb21waWxlIGNvdWxkIGdldCBvdGhlciBjb21wbGFpbnRz
Lg0KDQpHaXZlbiB0aGF0IHRoZSBzZXJpZXMgaGFzIGJlZW4gbWVyZ2VkIHRvIEZlbGl4J3MgdHJl
ZSAoYW5kIGNvdXBsZQ0KcGF0Y2hlcyBhcmUgYmVpbmcgYXBwbGllZCBvbiB0b3Agb2YgaGlzIHRy
ZWUpLi4uIGJ1dCB3ZSB3aWxsIHRha2UgY2FyZQ0Kb2YgdGhpcyBwYXJ0IG5leHQgdGltZSBhbmQg
c3BsaXQgdGhlIHNlcmllcyBieSBmdW5jdGlvbmFsaXR5IGFzIG11Y2ggYXMNCndlIGNhbi4gV2hh
dCBkbyB5b3UgdGhpbms/DQoNCj4gSSBkaWQgc2VlIHNvbWUgc3VzcGljaW91cyBzdGF0aWMgdmFy
aWFibGVzIGluIHBjaS5jLCBidXQgb3RoZXJ3aXNlIEkNCj4gYmFzaWNhbGx5IHNraXBwZWQgZXZl
cnl0aGluZy4NCg0KSSBndWVzcyB5b3UgbWVhbnMgaGlmMl8qIHdoaWNoIGhhcyBleGlzdGVkIGlu
IG10NzkxNSBhbHJlYWR5LiBUaGVzZSBhcmUNCm5lZWRlZCBmb3Igb3VyIHNwZWNpZmljIHNlY29u
ZGFyeSBQQ0llIGJ1cyBzdXBwb3J0LiBUaGUgcmVsYXRlZCBjaGFuZ2VzDQpoYXZlIGJlZW4gcmV2
aWV3ZCBiZWZvcmUgSUlSQy4NCg0KUnlkZXINCg==
