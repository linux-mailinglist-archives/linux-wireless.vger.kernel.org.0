Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8713978B6F8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjH1SDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjH1SDh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 14:03:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D338711B
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 11:03:27 -0700 (PDT)
X-UUID: 2a310f5645cd11eeb20a276fd37b9834-20230829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9ZkgGtoRDSZzszWeDL3qMPjBlDZFmTk65wTfRLz/p4A=;
        b=fqNvYgo33NhTIMUaGKfeU5TcunDY1ZjqXIapDH3h3gd67/c4+olRkJysCSTDNa3yXA/GbExBcZ2wMwpOYY4KMYUFXsGYQieXIObVgJv8NdgYqhbZW1aF0eVjoEHQ7KTrWPg0kx4r8bh+fpjqSjn/GG+PcyaQvq2d4L5OXwRW5dE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:dd5450f4-80d7-415b-9d21-29e90bf6e118,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:c9220aef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2a310f5645cd11eeb20a276fd37b9834-20230829
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1234414667; Tue, 29 Aug 2023 02:03:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Aug 2023 02:03:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Aug 2023 02:03:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T36agd5cPE9hLUgtqrqm7zdLK7Tnw5vMaTZ4MUonkSCbQJNU+USXj662srsD9M98ElLk15n4B06gmMHz9n9k9oOnkUi1cP0FusNEL0zbu3fq/TLeoErpgexrE6SRBc4BHkoxgT4a9k7V8V078ms6vzP4xakF06uZZWFwL+qv8/uN8N15Z8u+aU5yX0ocM8cJBsoFuzjjZukqBni/mj6Zm0OVA+o6IXUXAF1Hn3TiLO0mvLVvqXS5EX81Vp/vdsohhzQQjzHl3NmN6e7k1buugZVQWJcTV9yGfsAwlIAe+zrI+tAoBN+zgFbN8Ni8MVMHeiom6/BiPRwFqewyF+KuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZkgGtoRDSZzszWeDL3qMPjBlDZFmTk65wTfRLz/p4A=;
 b=V/ntvHkxMP8X1PR/vq9kqZ30psLJl75DThZz1I9H7kvOw8XxKXUQRN4h4zuG00DvheScEfuUfpCMkSmYH07wU9X55lTMULWCNL+cyEwtE+6ovnpuKfpD6nd0zbjG2R5wqRO1OiNWgCVGplv8f4TZOPUs2bkVTFgUcZ6dRIwwwnCz1zNz0dZccHeOUF/SMJAYjGA27/5CYuXYUd3CmJyUnfu0u/YWP7Jjt+1zwvoHvI9qPrb2PUsr4r7inDwvb+8OK5aj6ISEfYRtc+SrgAYbc25UIwA5nZckVy+6ElRgXlmvVbxmJw+qq4IHqtqQ6KglWcKF6GOLiyorJARA5n+G2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZkgGtoRDSZzszWeDL3qMPjBlDZFmTk65wTfRLz/p4A=;
 b=pksgk3iJBJyWa120Wsc4kqCDpkAG6caz8deA0APrUul4Bqg6xzliSx/VXIB8vx+jSuJqqlnSusS78qS8PLuOsNqx6K6eNyEkovtePf0WirQvO+p9FoyzEejmu0DWlQj5IJYG0zhmRxLvSKAhCIqxi4C39G3zBof7vLUxetmeiN0=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SI2PR03MB5580.apcprd03.prod.outlook.com (2603:1096:4:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 18:03:13 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::df4:6476:1016:ee94]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::df4:6476:1016:ee94%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:03:12 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     Yi-Chia Hsieh <Yi-Chia.Hsieh@mediatek.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>,
        =?utf-8?B?QmVuamFtaW4tancgTGluICjmnpfmtKXnt68p?= 
        <Benjamin-jw.Lin@mediatek.com>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/6] wifi: mac80211: export ieee80211_tpt_led_trig_tx/rx
 for driver
Thread-Topic: [PATCH 5/6] wifi: mac80211: export ieee80211_tpt_led_trig_tx/rx
 for driver
Thread-Index: AQHZ13xipkDFnDvUKUqjQF/GnL8vC6/7TzyAgAS1m4A=
Date:   Mon, 28 Aug 2023 18:03:12 +0000
Message-ID: <edb44d720c30898357940f4a906cb108706fbcb4.camel@mediatek.com>
References: <09f0cb7f314a08eddb77298411d965ad30a847bb.1692983967.git.yi-chia.hsieh@mediatek.com>
         <8d18b7ac7fc394c310c0f2730da9ee7e955a9860.1692983967.git.yi-chia.hsieh@mediatek.com>
         <e94f5d18-ced0-458d-8e2c-b94a4196c442@quicinc.com>
In-Reply-To: <e94f5d18-ced0-458d-8e2c-b94a4196c442@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SI2PR03MB5580:EE_
x-ms-office365-filtering-correlation-id: 5a055f6a-ec74-49c5-9175-08dba7f10bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWI2OkQlMJDGrmN2pGY0dnvp9Y5rFk0MT7H9ZSixZ3FBKBOAGnyo4tbzKyRiytpnimtG55h49RtmTn8MenmjomDRz0KFIziD7dFL5SUfw38lS8WTJBu8OFZPmicn1iImkLHwfPiD+gARBAwTeqtM1bID1ZqVcQUjfbJRTsvZGlnm+A4D34X4xA8dIqi0mWdmK8J/5fC/UlPK+IyI4THO53YKPshLNk7UVEsKLunVRc94LVFZzLTPfwwtjcLN0F3gS62S8wRfF9lA6mpeCXNcUhqY/N1hZOX8Mt29C12ggvK/jZq+gayPgS+iuiczNxF1vhp3oOt1+QfWNt2Qf/DLU5HdpslPHjHlyJCfuONPEePmCvqVFPkws99LYJ5GkBtJUBw83eLxVIBNf/tw6y6WTgkGmdpAWqLQTRnu3fcoNHpm9QmQbzLr3ciiJFHNckvdZaYgy1OPRg6hdyP65gG/Ff+XCsJJU60ZnElb1bbCiuRwG+jnaaDCzgM3/1JVmdTOayASpraKfs76F/CfMxqasF/CCXUlBW47uxndPiRmpX1HQcy+Nx5mFoP5SbWJ++UkfaCu4jBOgPUP7WpahkH5pcK1pLCT6BcIx6Po3eRGZpTW8ceIWbPn3hKxsqHogUstlJii4uTI1YlVzfbhu+AgHHa+M9KRJvryueTXSHk6BTweGYfuXPtL+4hJOHKIG2UDJU4dc3UKNowqNFqIhtYywQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(1800799009)(451199024)(186009)(6512007)(6486002)(6506007)(71200400001)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(316002)(54906003)(66446008)(64756008)(66476007)(66556008)(66946007)(41300700001)(76116006)(110136005)(8936002)(5660300002)(4326008)(8676002)(36756003)(38070700005)(38100700002)(86362001)(122000001)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3dPdmhNR0JhQkgrbUczQ1puS1pNR0JzdnBjQjBMMWpIbWNVQXNhWXJ2Syt4?=
 =?utf-8?B?Y3ZmZmR6R1FkcEwrU0ZRVG14b0tXdkNSSE05dzlSWEJnU3IwOVVteTV6TTZB?=
 =?utf-8?B?bXVyVHJkSVNZV0o2NmRrekRQNUQyVzM4ZEkvY2piV3VCb1hROWtjb0gyRTg1?=
 =?utf-8?B?N0dacHI3UFlSUlJUaGpQZGx2czRGR04wVVpjZ0tiaHh5N3dZTXh2ZzlGN2NK?=
 =?utf-8?B?dWpwM2ZySnQ0bGV4Y0FmYmZQNjdDK0doenhKaTBtanZIUmZoNGRTSE41REZs?=
 =?utf-8?B?V3FFOHpEQ29nT3Q0TVMwOFNmNkhzcVM5MHFtNTBveWt1UDRtWEl1aVR0UE91?=
 =?utf-8?B?dndtSlEvWG45Ui80b2Mxa2VOQ1VhRTZnaGlzTFYvYWNqLy91Q21lYzlybWxF?=
 =?utf-8?B?L1RuWFh3Qk1RdisxRUYvaDZxY1M0cG0rTGsyOXlHcEhHWUFoKzlTV1M4Ykp2?=
 =?utf-8?B?WDRVWVJoSGY1bmRkWWZtenVjbEhDeWdia0ZRc3VJMkl2dFpxRUFSbERjYTgv?=
 =?utf-8?B?SnpLcTNJeHphU3MwOXVFTHhad09WS1VPMnFScHl2OXZ3bEdIS2ttbG9UNFRx?=
 =?utf-8?B?TkFEZDlaRWJUNzIybTBmNXcrcmZaTnpMRlV2ZkUwS0ZhUUVHWm0waHY0bm1a?=
 =?utf-8?B?WHU0V285VmUrdDl3SHVSNnZ3Z1BZOVQ1eUt5TE5EMXZ0YWtQL0Y4RHZqenlW?=
 =?utf-8?B?TytqTndJcHh2b0VLc3pqcUNLWWtiZkh1UHMzd2RqSTB0aHBHeTRSOThzVDBM?=
 =?utf-8?B?cVVmZEF2TmNTVW40R0dpNnBjRHlpTTd4STllcSs5Z28xT0Y5RGVROU4yaUdC?=
 =?utf-8?B?aHp5TXpPUkxJUXo5NUhuYXNwVHhYVGpMTythWjZoZTY3WG4yakxEWkhIWThj?=
 =?utf-8?B?N0IrQll4YkhmS0RVd2t0ZjcyQzJHRVh4b1NiVTBhNDZRNzNhcld3MVhJM2RE?=
 =?utf-8?B?NmRKR1c5ckFjVUhJcVNFQ05rR1dhd0tQV2tKWUdCOWlhalpPRU9LYjVEcXJM?=
 =?utf-8?B?NnkrMDE4K09XblpoRTF2eExmSnZzQkVoVU81dzMvSk1oTjRObHZET2p1Mkds?=
 =?utf-8?B?T2I2Wjh2R2VKMEVqdEVEeWRJSFQyMldDREE3SVFRc3JlY3NJRlRJNXBOUis3?=
 =?utf-8?B?Yk5MeHE5VjdrRHZucW5TQjFMbWpwQVlaZVU0N3JNNVRNWmQwSEhUdS9zVHhi?=
 =?utf-8?B?NmIrY0J3djRSdGQvMTJ4aEgybmxWdlZ2WkpGcWdnaS8rckQ3eDlCUERienlp?=
 =?utf-8?B?UTQ4eURhTUhxOG9EV1VkNzk0c3dhRDhsSlRVSHRWeitvQTJUYUpYZUI1eitu?=
 =?utf-8?B?TmxVejVRUU02K09WQStWRHNwUTU0TTZxUUU4OXVLQnJrNEZCYmcyM21pL2lH?=
 =?utf-8?B?YnExUm8ydCszSjlqSlUra0JON2NnY2FSR1VBRzFOZ0N3NEVzdTBNSnRUREIw?=
 =?utf-8?B?ams0WFU0elRCdmJMUWVESXRpRktjbjJFUEhHcERqUThRN2tEcitNcUZwL1F6?=
 =?utf-8?B?U0xJNm1kMXFEUWpRaUx1UTh5cnVhWStMZDZqRWU5TTUwRkdZYzk4WXlkQzVU?=
 =?utf-8?B?ZUJxSjU1SGVsVTRYQjJtM3RNMEliQTUrRG1KTGVJbURqRFNVVmFna1puU2t3?=
 =?utf-8?B?VjV4UHEyMUR6YnR0cjFndkxKWnZpTDBOaDJmTHRmWXF1Q3ZOVzl2dG8xNzN1?=
 =?utf-8?B?Z2lVdzM2TWRsUXFHUytseDVGcVlzaEFZSWdzK2pORkZna29hWUQ4ekZUcnFh?=
 =?utf-8?B?cEw1L1E1MkFnTzJ1U2RERnNESVIvSDNsLzc1VFpUdDNWcVEwZ3JXdE4rUTdn?=
 =?utf-8?B?N3hUTXpmaEpWSE1OQXhPTGNlZWNyTWR5THUrdHNzYU4wUk9ERzZpNFVnbGZU?=
 =?utf-8?B?RlBTWVl5TC9qZHc0NmsxMzdQOXovMHlXYXNBS3BXN21sVnFUNk1JQlIwOWl5?=
 =?utf-8?B?endiUEhMUzMzQnRyM3FQdERHMUM0T296SEpNMnluc1RTWnpiM01USG5oU2FK?=
 =?utf-8?B?KzQ2QXVLNEJsQXNOZVFud21GNzZ3a0c4anM5Y0RtK0c0M2VKZENySDMxT3dZ?=
 =?utf-8?B?dVA0elhuTXkyNktUNG1PK1FOdkRLY1c0bUtpblkwOVJKSmhKNi9WS2w1UzBv?=
 =?utf-8?B?TnNicy96bStEQ3ZRQVo4WFlsVmc2VU5KM1o0WXNKRCtDbG1oMGJWeFo5MHRy?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <690166668E890F4EA77AE6A6A131997E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a055f6a-ec74-49c5-9175-08dba7f10bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 18:03:12.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN6sGUtC10cT6Qlg4uHNmQj5rC6c97jtwyz8yo0trYcvNZ3qj0V8ALVKytWGmGCt+j0yHFU1ObrXa4+oLCdHuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDExOjA4IC0wNzAwLCBKZWZmIEpvaG5zb24gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gOC8yNS8yMDIzIDEwOjQ3IEFNLCBZaS1DaGlhIEhzaWVoIHdyb3Rl
Og0KPiA+IFdoZW5ldmVyIHRoZSBIL1cgcGF0aCBpcyBlbmFibGVkIGFuZCB0cmFmZmljIGlzIGlu
IHRoZSBiaW5kaW5nDQo+IHN0YXRlLA0KPiA+IG1hYzgwMjExIGlzIG5vdCBhd2FyZSBvZiB0aGUg
dHJhZmZpYy4gQ29uc2VxdWVudGx5LCB0aGUgTEVEIGRvZXMNCj4gbm90DQo+ID4gYmxpbmsgZm9y
IHRoYXQgcmVhc29uLg0KPiA+IA0KPiA+IFRoZSBpZWVlODAyMTFfdHB0X2xlZF90cmlnX3R4L3J4
IGZ1bmN0aW9ucyBhcmUgZXhwb3J0ZWQgZm9yIHRoZQ0KPiBkcml2ZXINCj4gPiBzbyB0aGF0IHdl
IGNhbiByZXBvcnQgdGhlIHR4IGFuZCByeCBieXRlcyBmcm9tIHRoZSBkcml2ZXIgd2hlbg0KPiA+
IHRoZSBIL1cgcGF0aCBpcyBiZWluZyB1c2VkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlp
LUNoaWEgSHNpZWggPHlpLWNoaWEuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
aW5jbHVkZS9uZXQvbWFjODAyMTEuaCB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ID4gICBuZXQv
bWFjODAyMTEvbGVkLmMgICAgIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4gICBuZXQvbWFj
ODAyMTEvbGVkLmggICAgIHwgMTggLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICBuZXQvbWFjODAy
MTEvcnguYyAgICAgIHwgIDIgKy0NCj4gPiAgIG5ldC9tYWM4MDIxMS90eC5jICAgICAgfCAgNCAr
Ky0tDQo+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9tYWM4MDIxMS5oIGIvaW5j
bHVkZS9uZXQvbWFjODAyMTEuaA0KPiA+IGluZGV4IDNhOGEyZDJjNThjMy4uNTM4MDQ4MjJkYzhk
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L21hYzgwMjExLmgNCj4gPiArKysgYi9pbmNs
dWRlL25ldC9tYWM4MDIxMS5oDQo+ID4gQEAgLTQ3MjksNiArNDcyOSw4IEBAIF9faWVlZTgwMjEx
X2NyZWF0ZV90cHRfbGVkX3RyaWdnZXIoc3RydWN0DQo+IGllZWU4MDIxMV9odyAqaHcsDQo+ID4g
ICAgICB1bnNpZ25lZCBpbnQgZmxhZ3MsDQo+ID4gICAgICBjb25zdCBzdHJ1Y3QgaWVlZTgwMjEx
X3RwdF9ibGluayAqYmxpbmtfdGFibGUsDQo+ID4gICAgICB1bnNpZ25lZCBpbnQgYmxpbmtfdGFi
bGVfbGVuKTsNCj4gPiArdm9pZCBfX2llZWU4MDIxMV90cHRfbGVkX3RyaWdfdHgoc3RydWN0IGll
ZWU4MDIxMV9odyAqaHcsIGludA0KPiBieXRlcyk7DQo+ID4gK3ZvaWQgX19pZWVlODAyMTFfdHB0
X2xlZF90cmlnX3J4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBpbnQNCj4gYnl0ZXMpOw0KPiAN
Cj4gc3VnZ2VzdCB0aGVzZSBzaG91bGQgYmUgaW4gbGVkLmggc2luY2UgdGhleSBhcmUgbG9jYWwg
dG8gbWFjODAyMTENCj4gYW5kIA0KPiBzaG91bGQgbm90IGJlIGRpcmVjdGx5IGludm9rZWQgYnkg
Y2xpZW50cyBvZiBtYWM4MDIxMQ0KPiANCj4gPiAgICNlbmRpZg0KPiA+ICAgLyoqDQo+ID4gICAg
KiBpZWVlODAyMTFfZ2V0X3R4X2xlZF9uYW1lIC0gZ2V0IG5hbWUgb2YgVFggTEVEDQo+ID4gQEAg
LTQ4MzksNiArNDg0MSwyMSBAQCBpZWVlODAyMTFfY3JlYXRlX3RwdF9sZWRfdHJpZ2dlcihzdHJ1
Y3QNCj4gaWVlZTgwMjExX2h3ICpodywgdW5zaWduZWQgaW50IGZsYWdzLA0KPiA+ICAgI2VuZGlm
DQo+ID4gICB9DQo+ID4gICANCj4gPiArc3RhdGljIGlubGluZSB2b2lkDQo+ID4gK2llZWU4MDIx
MV90cHRfbGVkX3RyaWdfdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIGludCBieXRlcykNCj4g
PiArew0KPiA+ICsjaWZkZWYgQ1BUQ0ZHX01BQzgwMjExX0xFRFMNCj4gDQo+IHdoeSBpc24ndCB0
aGlzIHVzaW5nIENPTkZJR19NQUM4MDIxMV9MRURTPz8NCj4gDQoNCldpbGwgZml4Lg0KPiA+ICtf
X2llZWU4MDIxMV90cHRfbGVkX3RyaWdfdHgoaHcsIGJ5dGVzKTsNCj4gPiArI2VuZGlmDQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZA0KPiA+ICtpZWVlODAyMTFfdHB0X2xl
ZF90cmlnX3J4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBpbnQgYnl0ZXMpDQo+ID4gK3sNCj4g
PiArI2lmZGVmIENQVENGR19NQUM4MDIxMV9MRURTDQo+ID4gK19faWVlZTgwMjExX3RwdF9sZWRf
dHJpZ19yeChodywgYnl0ZXMpOw0KPiA+ICsjZW5kaWYNCj4gPiArfQ0KPiA+ICAgLyoqDQo+ID4g
ICAgKiBpZWVlODAyMTFfdW5yZWdpc3Rlcl9odyAtIFVucmVnaXN0ZXIgYSBoYXJkd2FyZSBkZXZp
Y2UNCj4gPiAgICAqDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9sZWQuYyBiL25ldC9t
YWM4MDIxMS9sZWQuYw0KPiA+IGluZGV4IDJkYzczMjE0N2U4NS4uYWYwM2EyZWY1YzZhIDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9tYWM4MDIxMS9sZWQuYw0KPiA+ICsrKyBiL25ldC9tYWM4MDIxMS9s
ZWQuYw0KPiA+IEBAIC0zMTksNiArMzE5LDI0IEBAIF9faWVlZTgwMjExX2NyZWF0ZV90cHRfbGVk
X3RyaWdnZXIoc3RydWN0DQo+IGllZWU4MDIxMV9odyAqaHcsDQo+ID4gICB9DQo+ID4gICBFWFBP
UlRfU1lNQk9MKF9faWVlZTgwMjExX2NyZWF0ZV90cHRfbGVkX3RyaWdnZXIpOw0KPiA+ICAgDQo+
ID4gK3ZvaWQgX19pZWVlODAyMTFfdHB0X2xlZF90cmlnX3R4KHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3LCBpbnQNCj4gYnl0ZXMpDQo+ID4gK3sNCj4gPiArc3RydWN0IGllZWU4MDIxMV9sb2NhbCAq
bG9jYWwgPSBod190b19sb2NhbChodyk7DQo+ID4gKw0KPiA+ICtpZiAoYXRvbWljX3JlYWQoJmxv
Y2FsLT50cHRfbGVkX2FjdGl2ZSkpDQo+ID4gK2xvY2FsLT50cHRfbGVkX3RyaWdnZXItPnR4X2J5
dGVzICs9IGJ5dGVzOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woX19pZWVlODAyMTFfdHB0
X2xlZF90cmlnX3R4KTsNCj4gPiArDQo+ID4gK3ZvaWQgX19pZWVlODAyMTFfdHB0X2xlZF90cmln
X3J4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBpbnQNCj4gYnl0ZXMpDQo+ID4gK3sNCj4gPiAr
c3RydWN0IGllZWU4MDIxMV9sb2NhbCAqbG9jYWwgPSBod190b19sb2NhbChodyk7DQo+ID4gKw0K
PiA+ICtpZiAoYXRvbWljX3JlYWQoJmxvY2FsLT50cHRfbGVkX2FjdGl2ZSkpDQo+ID4gK2xvY2Fs
LT50cHRfbGVkX3RyaWdnZXItPnJ4X2J5dGVzICs9IGJ5dGVzOw0KPiA+ICt9DQo+ID4gK0VYUE9S
VF9TWU1CT0woX19pZWVlODAyMTFfdHB0X2xlZF90cmlnX3J4KTsNCj4gPiArDQo+IA0KPiB3aHkg
YXJlIHlvdSBtYWtpbmcgdGhlc2UgZXhwb3J0ZWQgaW1wbGVtZW50YXRpb25zIGluc3RlYWQgb2Yg
a2VlcGluZyANCj4gdGhlbSBhcyBpbmxpbmUgaW4gbGVkLmg/DQo+IA0KDQpXZSB0aG91Z2h0IHNv
LiBIb3dldmVyLCBsZWQuYyBoYXMgbWFueSBzYW1lIGV4cG9ydGVkIGltcGxlbWVudGF0aW9ucywN
CmluY2x1ZGluZyB0aGUgbG9jYWwgZnVuY3Rpb25zIHlvdSBzdWdnZXN0ZWQgYWJvdmUuIGkuZS4N
Cl9faWVlZTgwMjExX2dldF9hc3NvY19sZWRfbmFtZSgpIEZvciB0aGUgc2FrZSBvZiBjb25zaXN0
ZW5jeSwgd2UganVzdA0KY29weS1wYXN0ZWQgb25lIG9mIHRob3NlIGZ1bmN0aW9ucy4gRG8geW91
IHdhbnQgdXMgdG8gY2hhbmdlIHRoaXM/DQoNCj4gPiAgIHN0YXRpYyB2b2lkIGllZWU4MDIxMV9z
dGFydF90cHRfbGVkX3RyaWcoc3RydWN0IGllZWU4MDIxMV9sb2NhbA0KPiAqbG9jYWwpDQo+ID4g
ICB7DQo+ID4gICBzdHJ1Y3QgdHB0X2xlZF90cmlnZ2VyICp0cHRfdHJpZyA9IGxvY2FsLT50cHRf
bGVkX3RyaWdnZXI7DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9sZWQuaCBiL25ldC9t
YWM4MDIxMS9sZWQuaA0KPiA+IGluZGV4IGQyNWYxMzM0NmI4Mi4uOThkYjQzNTZkMGRlIDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9tYWM4MDIxMS9sZWQuaA0KPiA+ICsrKyBiL25ldC9tYWM4MDIxMS9s
ZWQuaA0KPiA+IEBAIC02NiwyMSArNjYsMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gaWVlZTgw
MjExX21vZF90cHRfbGVkX3RyaWcoc3RydWN0IGllZWU4MDIxMV9sb2NhbCAqbG9jYWwsDQo+ID4g
ICB7DQo+ID4gICB9DQo+ID4gICAjZW5kaWYNCj4gPiAtDQo+ID4gLXN0YXRpYyBpbmxpbmUgdm9p
ZA0KPiA+IC1pZWVlODAyMTFfdHB0X2xlZF90cmlnX3R4KHN0cnVjdCBpZWVlODAyMTFfbG9jYWwg
KmxvY2FsLCBpbnQNCj4gYnl0ZXMpDQo+ID4gLXsNCj4gPiAtI2lmZGVmIENPTkZJR19NQUM4MDIx
MV9MRURTDQo+ID4gLWlmIChhdG9taWNfcmVhZCgmbG9jYWwtPnRwdF9sZWRfYWN0aXZlKSkNCj4g
PiAtbG9jYWwtPnRwdF9sZWRfdHJpZ2dlci0+dHhfYnl0ZXMgKz0gYnl0ZXM7DQo+ID4gLSNlbmRp
Zg0KPiA+IC19DQo+ID4gLQ0KPiA+IC1zdGF0aWMgaW5saW5lIHZvaWQNCj4gPiAtaWVlZTgwMjEx
X3RwdF9sZWRfdHJpZ19yeChzdHJ1Y3QgaWVlZTgwMjExX2xvY2FsICpsb2NhbCwgaW50DQo+IGJ5
dGVzKQ0KPiA+IC17DQo+ID4gLSNpZmRlZiBDT05GSUdfTUFDODAyMTFfTEVEUw0KPiA+IC1pZiAo
YXRvbWljX3JlYWQoJmxvY2FsLT50cHRfbGVkX2FjdGl2ZSkpDQo+ID4gLWxvY2FsLT50cHRfbGVk
X3RyaWdnZXItPnJ4X2J5dGVzICs9IGJ5dGVzOw0KPiA+IC0jZW5kaWYNCj4gPiAtfQ0KPiA+IGRp
ZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvcnguYyBiL25ldC9tYWM4MDIxMS9yeC5jDQo+ID4gaW5k
ZXggNGY3MDdkMmExNjBmLi41NzQ3ZDdkYWM0ZDcgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L21hYzgw
MjExL3J4LmMNCj4gPiArKysgYi9uZXQvbWFjODAyMTEvcnguYw0KPiA+IEBAIC01Mzc1LDcgKzUz
NzUsNyBAQCB2b2lkIGllZWU4MDIxMV9yeF9saXN0KHN0cnVjdCBpZWVlODAyMTFfaHcNCj4gKmh3
LCBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqcHVic3RhLA0KPiA+ICAgaWYgKHNrYikgew0KPiA+ICAg
aWYgKChzdGF0dXMtPmZsYWcgJiBSWF9GTEFHXzgwMjMpIHx8DQo+ID4gICBpZWVlODAyMTFfaXNf
ZGF0YV9wcmVzZW50KGhkci0+ZnJhbWVfY29udHJvbCkpDQo+ID4gLWllZWU4MDIxMV90cHRfbGVk
X3RyaWdfcngobG9jYWwsIHNrYi0+bGVuKTsNCj4gPiAraWVlZTgwMjExX3RwdF9sZWRfdHJpZ19y
eCgmbG9jYWwtPmh3LCBza2ItPmxlbik7DQo+IA0KPiB3aGF0IGlzIHRoZSByYXRpb25hbGUgZm9y
IGNoYW5naW5nIHRoZSBzaWduYXR1cmUsIGVzcGVjaWFsbHkgZ2l2ZW4NCj4gdGhhdCANCj4gdGhl
IGZpcnN0IHRoaW5nIHRoZSBpbXBsZW1lbnRhdGlvbnMgZG8gaXMgbG9jYWwgPSBod190b19sb2Nh
bChodykNCj4gDQoNCldlIHdhbnQgdG8gbWFrZSBpZWVlODAyMTFfdHB0X2xlZF90cmlnX3J4KCkg
bW9yZSBnZW5lcmljIHNvIHRoYXQgaXQgY2FuDQpiZSBjYWxsZWQgYnkgZHJpdmVyIGFzIHdoYXQg
aGUgZGlkIGluIHBhdGNoIDYvNi4gQnV0IHRoZQ0KaWVlZTgwMjExX2xvY2FsIGNhbid0IGJlIGFj
Y2Vzc2VkIG90aGVyIHRoYW4gbWFjODAyMTEgc28gaGUgbWFkZSB0aGlzDQpjaGFuZ2UgdG8gdXNl
IGllZWU4MDIxMV9odyBpbnN0ZWFkLiBEb2VzIHRoYXQgbWFrZSBzZW5zZT8NCg0KUnlkZXINCg==
