Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2863CFBE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 08:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiK3HfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 02:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiK3HfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 02:35:12 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF75ADCC
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 23:35:04 -0800 (PST)
X-UUID: dc2d846590964be3a04c7e9f6c9745a6-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DN3otkJmfP0wqg0YM1OGgbogCKEYSWBVfE5k/FYLSoc=;
        b=E/OQXsgboBkSiITk12CIrEz1IaQDcjxXzSfW4gIuyw5orBubGBy/qJKluHsHN66CgTkoSH/wFdatsD4urMc19UC4aKkXLO3MpSPqPquYwQsIs8ZSbI02w5ZLofUWwKizShT5jEDzpBk+Vbv3rF93VyJurVkFh+KbkxuFzPiOYOE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e4855bec-8a27-4382-b796-3411311cc6cc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:6d7e3c30-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: dc2d846590964be3a04c7e9f6c9745a6-20221130
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 336563933; Wed, 30 Nov 2022 15:35:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 30 Nov 2022 15:35:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 30 Nov 2022 15:34:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8QV0EHdLpdHxbzhmap32qpk3OWNg+iBrSyI9RZZORvjaTLM0vtQurUyuvRU1wfYFwsXFvQ6hr8aC9CFx0s6vMDHuK3ShFlU2aoZXY7p0qvWNbLY4ZOVYJkl4GzjPJ7BJpXulFN1ysnbQv8gVtXwzgDwil7uhG3zLflC5itvV7gTToeoUGHGTsJwlCxNdWE6Rt2ILiL157QXd7yjBIXF0kZ8+P6ZzY0817I7fXh4f2j+TuAI7keRWH1tpRUmaQM6h+dqOBWjb19E2Q/xfEtNEliJCjR6fzjS54J3a4fIY2EhHA8dO2aFo0iLM9X9ZDJGIhzPfTRn9AtcnGEIpvwjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN3otkJmfP0wqg0YM1OGgbogCKEYSWBVfE5k/FYLSoc=;
 b=PR7xnAkRqUciGKbKDkwaZQHr+EH0xWJRHQbj3aZGLj9vvFvLvxyk6qoXq6dXv2zkrwycaksngqPfA7eWdhETUNYh2ABLhNnBxRt1F0dkpuP9UrigOXbykqW6YWc8/ilFVVhPHgh4YF0FV+qgyHHuMmnMxDB4jfIXEayvREFEsqKno1LRomeU8GEski9GRgswbFr4scmJhe4DZyM4uD+TUofziycljX5WGp65aVLS8mDP3+yIx1YehDoPLbH3PYonM3iEF5mwhO3x3woED8Oh2YK6sbY/tn3lDCU7mhSyUHogmRd6xJ94RHHuHqWbNknkYv1mCYjgPZsouipdYAEwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN3otkJmfP0wqg0YM1OGgbogCKEYSWBVfE5k/FYLSoc=;
 b=q7GiUwp5nE62dENvpIptVQthjGGUJOrsdvXrHOiowwWK54SsxlBDrZDvzgMXd5acdfgo+9C25KQ7q6kfspG3kI4vFDB/u+9tQ9z078TxyFLjeCZc9/H0ebx7JfFtnXr4nn2rEusllg9xIbTCRnLZr1qI8Ppaig/I2zybBFFlRqE=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 KL1PR0302MB5426.apcprd03.prod.outlook.com (2603:1096:820:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 07:34:56 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 07:34:56 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?WU4gQ2hlbiAo6Zmz5b2l5a+nKQ==?= <YN.Chen@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] wifi: mt76: introduce reboot notifier support
Thread-Topic: [PATCH v2 1/2] wifi: mt76: introduce reboot notifier support
Thread-Index: AQHZA9NZmLWodvcYnkywZyrryrzTKa5V/x6AgAEVsgA=
Date:   Wed, 30 Nov 2022 07:34:56 +0000
Message-ID: <a2554c8753fc45649e121ab85a78e4004dc2602c.camel@mediatek.com>
References: <d44631bcc74cce3f32a72f616a99d1bd2837690f.1669711916.git.deren.wu@mediatek.com>
         <1e8185a3-0a40-a637-7e49-79b00d95e576@collabora.com>
In-Reply-To: <1e8185a3-0a40-a637-7e49-79b00d95e576@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|KL1PR0302MB5426:EE_
x-ms-office365-filtering-correlation-id: 633d624b-8691-48dc-19cd-08dad2a560c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2Q2QQsB75SE29dVFENqHVQfnovG6XRMYn5LbUDndqGZGubF1XFYxRAdXYjFRyGvdT/OmMOJ5IJKH6Ejk+lHAXgHbfDKhku43uULyz9+sNdjoy4ItWilKdkj4+POefZmLJ8BdlCVrkTxvOGfQWTmuaTlzPj/IK+BD0/FlrVfS9eJJHuGgGmWtlvx1GoYKWdaNhHCEQFTTqgvFgryZOg3aOV2sph+I2XwFqE8npZu6ToHuCd5XIs9ejFM127PRMPPWcchljQrfUCuNY/UP4v5ZJ4sbe+UdlkcSvhEKWmMufpIovr1jyaIUSM6GgCIquQxajjN/uVS4mYsr+yuh1fczCLU2cLwcu1BtUFqbMwVcEs0FlqQNSDzX0MI/7h1JYQuVwS0FX8s7kBBiBRzf1nmlDFWOgXKhhTFmEJNR0vF4KdfRBNKL9/qgLadOXpoVJ1Eal/GXx2dj0ryMd4DJa/o2euaEH+MRIqmIGyMdlBfElcmbIoDcWSQ8aJp1VLMbC3y6Ox2hRHp/GQh/DUD5tf6Ay52vBP3oLgezDv9A69BS1dd+FvtDKWwzPmG+TRHXtcUOTPx6PoK8DviX8ZYj7dYDp+l/Ra5LxLZjnIQVpTRwZndCkxiKjQSvXS5ouYiNpvRsmdpb9PS/QvErvL2GFZ08RB1AR3VYEZiBlUf+zz9bY1ueY8pHCKuzYtbRXwygiItruTzwwKLC7PneExmgD4jMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(41300700001)(8676002)(66946007)(4001150100001)(66556008)(66446008)(64756008)(76116006)(36756003)(66476007)(4326008)(86362001)(186003)(38100700002)(2906002)(2616005)(110136005)(83380400001)(478600001)(71200400001)(6486002)(6506007)(316002)(8936002)(26005)(6512007)(85182001)(38070700005)(54906003)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anNvdU1ZNEt5Y2huUG05Q2lHTmlEb3NnTjl4bUZXRE4rT0VqUEh3cHZpbnRV?=
 =?utf-8?B?VGVxaGpFVXR1WDZpUndZVERhclc0cjI4dlphaTlqYXlSVHhOSVlZeDluVm1o?=
 =?utf-8?B?RG5VbzNjOWVwZ3FGZFlsNHRHc0ZmWXBrajZjNUFtSHZySXBqdmFUMUdiMzFD?=
 =?utf-8?B?SUloZmhpZGs0bTUvaFpEYXY0YmVCY3U5SjdaTk5oNFZ4ZERjOGpDTTVvZ2Qr?=
 =?utf-8?B?ZmZmbCtBdXltOUcxRCtQa2RoSlk5OFlMZ1VEaFJ1aWxDbHlzQzRGczRHS1R4?=
 =?utf-8?B?aTUwcGxiakZxditHWFRvczNlc3kybUh5KzRWTjNXN0VRbEQ1N1VQRWhyNGlt?=
 =?utf-8?B?WXRxcHlwYXJWZjUrRkp3ZEVpQkIwUVZsdDVxQWRHYXducHlvbU1BcXVORHJn?=
 =?utf-8?B?bEFxQmo5MStWbUxSdHRRdjBoRG1CdWtSVEhFTWlONXRRMW5FaHpTcjcwb0l3?=
 =?utf-8?B?Tnk1dXMwTEpIRE5BTytoMGYrMjhmbWMyYjRKWjd4Sy9iQkY0cmo2K041NW9H?=
 =?utf-8?B?OHNYL2VKQmI4R0N3K01PbUgzZy94ZXY5NzlQQ0Q3VUtsZWR6RXh5TEJZTUdE?=
 =?utf-8?B?cmk3NEc3N2dvNkpJSFBZSXBsYlRFT2FOV3JXV0ROUEFCYS9vU1VFUnJYaXY5?=
 =?utf-8?B?ek5POE1FUExvUzYxNE5DOUUzS1d4SG9HTEQ5RUkzK0tmSnBOSUZWQmhYK0NG?=
 =?utf-8?B?T2NodUtwcUpmbjJUNys3Z0ZIblgvSm0rb1VobmJzNnAwbjFLTEZaL0dWdE1l?=
 =?utf-8?B?c1QxQWFUYnA1b3ROcFdFejViL2NxeFVmUjlIOFRmZUpId1BuRXE5OFB6V3Iw?=
 =?utf-8?B?Wi9NMnMwMWdoK1dpTmhJOXdPb21kbStmRGYzWGZhT00wcXg0TlBNZzlmaTJK?=
 =?utf-8?B?V25aRllwenNiNjc2eEJ2K1AweG81bnR1YXhOa2p2aVR0cW55dnNXekxONnp5?=
 =?utf-8?B?OTJ5L2o4d1dKWlZqaUltajhzYXEydjRuVnhkSzRkUDJWNk9MVlhxbG1LT2Fp?=
 =?utf-8?B?UjNBMTRsNGlpcnhnS1FjVmk0OXFoc3crcHQxMlY4Y3ZBWk15bUFnUjNBMVFq?=
 =?utf-8?B?TW1GZ2xvVTBBYUVtVXAyRFRNOFg5bzZIQVRRaVYxOVlDMzlFNDc2WGtnclFX?=
 =?utf-8?B?N21PcmhxR0dpV29ma0Y4SlN4ZlFXakxuQXB3dEk3VkR1UnBqNGFtMndrcEFG?=
 =?utf-8?B?TEQ5a3BGTUF0eHNnVHpwYkNGRTBSWkxRS2ttZVBIUmVjdjAyaldyZ25rU1Vi?=
 =?utf-8?B?S1BWZGNNK3NsZWxaVHFnd2JuQ0lOVk1GZm9pekRUSDhDN3RhSlVPcWYvSGRO?=
 =?utf-8?B?R1U5amdIYVJmWkJwNjVLWlVsRnFDMkQrM3FYNXhKQjArdW5Pb0NZakhOdW41?=
 =?utf-8?B?WUx3bjRlS3ZrbEEweU5QeEx3aHE5eTMraFMxRHVYejZ2YjR4bjRjWjQxQVNj?=
 =?utf-8?B?QUlKUTBJT2lMaHZsNkkxbDJNMjNNa3dkanZUY3JrVTVTWDdKL2I5QkswR2NP?=
 =?utf-8?B?bXNBVVBldy9CVE1PMGRrZll1QzhuNkthTU9ISmFTZ2haUS9lK1ZORFRRY0R1?=
 =?utf-8?B?S2piYmdJT2NOejlWM3g5QWFkekJXV2J2aGlSRGR5dkNCU0xVQStMOVlaMXZ5?=
 =?utf-8?B?b3F5N0NyeEs4ZzNpWlJuTDFGSEc1MXd0bi92SS9mcVpLWlZMZnpsODBBVG9l?=
 =?utf-8?B?VW5ucXZZNUl3c3U3UWdjMzlBaHVvOWo4ZjJ0OWdvWFY5Q0NSdzNoZjFBdkJ4?=
 =?utf-8?B?WWtidmdzcU5Vb2d0dkpuM3BGcEs2T085ajFtbVhiM21FRXVOOEpkSExSZXpn?=
 =?utf-8?B?RGRUSGErb29TWDArQjIzMWVSK0VkRzJVaG9kTWlzUVBUU0huc1ZQRklFa2wr?=
 =?utf-8?B?MGZrVnVXbUdIZ1MwWTJIRXowN3hEZkNEYkJpeXlmNCt1S0liUHlGekxkaCtW?=
 =?utf-8?B?Q3pWeEpYVEVXSFZiY1hZQjRacjVVeitvSmNtV3dKOEc5K2l3Zlo3dnZmc2Zw?=
 =?utf-8?B?SXllc2lDSzMyV0J0RVFPZTdEWlNPdXpnSFJJakoxb3dlZXZnckRTNWpFYjZr?=
 =?utf-8?B?SlJ2QU9WQmNRbEExNjFQSS9NMlNTa1lMc1lxdGV2Q2FTT0IwcDBLbkV6c3BQ?=
 =?utf-8?B?R25zVHk3YjQ3eklZMUlRUFNNQXNLcXZKYm5MV2FpMnB3QTA4eWU5RkJpTTJU?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED6BF3A2C587084AA0531C0D14D8148B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d624b-8691-48dc-19cd-08dad2a560c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 07:34:56.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLCP+WRCMG1Bo56RTg/lLdebT7VBLimiUq3bpnIR4DXa+jJUBIuQi5varNmi0riQODTeBV0sdC6WCRhDP6mzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjItMTEtMjkgYXQgMTY6MDAgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyOS8xMS8yMiAxMDoxNiwgRGVyZW4gV3Ug
aGEgc2NyaXR0bzoNCj4gPiBTb21lIGNvbWJpbmF0aW9ucyBvZiBob3N0cyBjYW5ubm90IGRldGVj
dCB3aWZpIGNoaXAgYWZ0ZXIgcmVib290Lg0KPiA+IFRoZQ0KPiA+IGludGVyb3BlcmFiaWxpdHkg
aXNzdWUgaXMgY2F1c2VkIGJ5IHRoZSBzdGF0dXMgbWlzbWF0Y2ggYmV0d2Vlbg0KPiA+IGhvc3QN
Cj4gPiBhbmQgY2hpcCBmdy4gSW4gc3VjaCBjYXNlcywgdGhlIGRyaXZlciBzaG91bGQgc3RvcCBj
aGlwIGFjdGl2aXRpZXMNCj4gPiBhbmQgcmVzZXQgY2hpcCB0byBkZWZhdWx0IHN0YXRlIGJlZm9y
ZSByZWJvb3QuDQo+ID4gDQo+ID4gVGhpcyBpcyBhIHByZWxpbWluYXJ5IHBhdGNoIHRvIGFkZCBt
dDc5MjFlIHJlYm9vdCBub3RpZmllciBzdXBwb3J0Lg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBT
aGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+IA0KPiBJZiB5b3Ugd2FudCB0byBw
ZXJmb3JtIHNodXRkb3duIGFjdGlvbnMgd2hlbiByZWJvb3RpbmcgdGhlIG1hY2hpbmUsDQo+IHRo
aXMNCj4gbWVhbnMgdGhhdCB5b3Ugd2FudCB0byBwZXJmb3JtIGFjdGlvbnMgd2hlbiBzaHV0dGlu
ZyBkb3duIHRoZQ0KPiBrZXJuZWwuLi4uDQo+IA0KPiAuLi5zbywgaGF2ZSB5b3UgdHJpZWQgdG8g
cGVyZm9ybSBzdWNoIGFjdGlvbnMgaW4gdGhlIC5zaHV0ZG93bigpDQo+IGNhbGxiYWNrDQo+IG9m
IHlvdXIgc3RydWN0IHBjaV9kcml2ZXI/IDotKQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+
IA0KDQpUaGlzIHBhdGNoIHdvcmtzIGZpbmUgd2l0aCBwY2kgLnNodXRkb3duKCkuIFRoYW5rcyBm
b3IgeW91ciBjb21tZW50cyA6KQ0KDQpJIHdpbGwgZHJvcCB0aGlzIHNlcmllcyBhbmQgcG9zdCBh
IG5ldyB2ZXJzaW9uLg0KDQoNClJlZ2FyZHMsDQpEZXJlbg0KDQoNCj4gPiAtLS0NCj4gPiAgIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbWFjODAyMTEuYyB8IDIxDQo+ID4gKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2LmggICAgIHwgIDIgKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiANCj4gDQo=
