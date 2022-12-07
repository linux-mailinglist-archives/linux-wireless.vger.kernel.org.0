Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D225B645DAF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 16:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLGPb7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiLGPbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 10:31:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2B262E88
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 07:31:44 -0800 (PST)
X-UUID: 8dcfcbd53af04e379aa729077a657bb1-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m2bF2HPemxwOViAXqy2kHk8a41p0Hh6soMbAsaJ2O6Q=;
        b=rdeoQPcVm+U+B8hcLT2aASs4SyKjseXksWxkjyU2IUsp+mVUGjqprUh15DJVXPfPqSLX0YnuQ2bho0dlvo8cZe9DGhLudxf9fpRE9YMfGQaBGgMILdLnZz5T0jIsgvP+bHmPdu5CEQq5XHLiwbGiGwXmYr+ALmiecxcJU/Ij/MI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:608b9136-ea63-4540-a70a-dc90d4dea216,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:608b9136-ea63-4540-a70a-dc90d4dea216,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:7fd0edd1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:221207211736W0MW3MDV,BulkQuantity:7,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 8dcfcbd53af04e379aa729077a657bb1-20221207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1230330310; Wed, 07 Dec 2022 23:31:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 23:31:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 23:31:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3rONNchNKzZ1oeBcxnnhi2lddrK/Fd1qvtvVQ/pR6wp94UJuRY0rqOYb/7pMF1cEiKHdu9DBN5Yb8jWTWQWsfwAUYmLffM1dQDsnmpO8jBw6qUXMUKQgT64ePgWhNyELngWOrfanjVxFTGsfQBP5cfZP90YT4T3EBYUOYtvH3ZPNLfuiwmBEtTWlmKwYd/I3KaIPrpjNi98ocYiSDBN2B9IO3Rmw2e1BCCzjwDC1wg0Dq4qru+YhqV/nB3GWuN3oCbg8mqxTQivrbPSvB6Wna051IGZXTWZttnw4oQ2ON2Ugq0C/bd+edu52TiEDeitKkjDGd1GD79z1R7vHCYpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2bF2HPemxwOViAXqy2kHk8a41p0Hh6soMbAsaJ2O6Q=;
 b=eNCmfqqFqJ/XMlitcsnMfuY6MFS7KLX8tb9DUibmuH9c4nj3khnV3j8t1ZNM2/es50zpcG3DD3hA1fzN+W/Ls1Fxlm52JYxte0qzXeqV+SkLfXaZlDavH6F82QqH8jhk75c2FjZBTrZVzN2RgreJzjLl+UDek7nIElephLi8A78zO1Zif6Hgym2ra5zMtkTKJKn+kIJtEhK4HyAVfTT7JnEjA2JetlrrqmxchNHmdyqg/1QQSPH3SxmmdewcsOpblu6ZXHxPeNvyREqI7s8izfWxveG0VrjTaXwHSo5g4bNdSXZC4bxaVax2eKjKzYg8DCQ9d2NmnhCgP7MXzAZFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2bF2HPemxwOViAXqy2kHk8a41p0Hh6soMbAsaJ2O6Q=;
 b=p/2eZ8ZPWcYtagTxAe4pgb6mIcKBThY/bMKz/ac3RQjDLQR+aEN6QZyMwb/u3CwrJnVEMYDzmHGiVUGUD61ruQVk+x1URvwsjI4VEapq7bi0rMAbSSuutJpbCMbDtcsce2jVn49TjLPpGKDiCPPYQNRe8TTjD2Fek0b12RiObWU=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 SEYPR03MB6505.apcprd03.prod.outlook.com (2603:1096:101:52::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Wed, 7 Dec 2022 15:31:33 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:31:32 +0000
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
Subject: Re: [PATCH] wifi: mt76: fix coverity uninit_use_in_call in
 mt76_connac2_reverse_frag0_hdr_trans()
Thread-Topic: [PATCH] wifi: mt76: fix coverity uninit_use_in_call in
 mt76_connac2_reverse_frag0_hdr_trans()
Thread-Index: AQHZCh1tfMuCIANteUykkGyRjp7UGa5iaEGAgAAld4A=
Date:   Wed, 7 Dec 2022 15:31:32 +0000
Message-ID: <b88d62e351689bb3b9223f214dc7ce4eaf4c8cfe.camel@mediatek.com>
References: <200ea97407b6f121da7ccd4567fde4b0426c5d9c.1670404791.git.deren.wu@mediatek.com>
         <65220c33-dc2d-9f3d-578b-dc973b9c043a@collabora.com>
In-Reply-To: <65220c33-dc2d-9f3d-578b-dc973b9c043a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|SEYPR03MB6505:EE_
x-ms-office365-filtering-correlation-id: 19b777bf-9e37-448d-28ce-08dad8681e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7kH0F0CX9CuRrbpCG5ISKJWfzhKXt1iDyu6ss23Gl/FwY8CfDTibfidqkpHsRFxG04UofO0MsWNun5XGEb/nmRVG0uAUA2C6Mk/TYsijY4Vr+43XIQxsexEVuhRKcEV0OsXJLoJzKyY8Y22oK+DShxLpK8I2G7S3F9hTW6ai2Wm0/oCdhiS19ZWuE4tX0xrzf4Sx8YUwK+am9XYD8yGfK4Yu2sYE0J7nRBBOpe1ELpb2HwInFKVc1CMFLAeb9mJI2VJ8Xitzlp+ywnWcYUh1r8WDs4G+7ckfUOBoWOBRjJzogorFzuWZ/zx7BKTH+wdvhJZvj1cDtQoHNWcokD84jljkT8I6hQkEVvwjjFWjbbuVpxJva2Q7EGLBemnmiWcLLcE/5GUJ6o2Rj0N+vB6ZsJ+EZBTPD9pM3SC2xvTS5zXUcNH4C3TLXSJjU5Qkeh+qvfXpJvcRXFmjfVrOOUIvmkV3b1QSRNWOWCMkhIjT8dnGU2IPOg9TcFLESRsXM/7DiwF7QtmqwRHr+nmA4l5NvE7tFg7NtxDp5Yg3QpYPgNsXnGFvnE7tzrNximkqWNrgLu2adcTOjZc2OrFNgbgrKRBnSERuNwQElyNq65/iRqE2/i2LDYCcFQrVGnoXjYviniwMQ6Ol/nesqFp5y8pJArZXAYY6fy++es6ret4jnBdkiJ+rt+7hz+TGEHp1iirMUzrVTCgeBbLg2jlhWVx2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(478600001)(86362001)(85182001)(6486002)(6506007)(38070700005)(36756003)(66476007)(83380400001)(122000001)(38100700002)(186003)(2616005)(8676002)(41300700001)(66946007)(8936002)(4326008)(91956017)(64756008)(5660300002)(71200400001)(76116006)(4744005)(110136005)(6512007)(26005)(2906002)(54906003)(66556008)(316002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkRUYlI0dmFUajdadlR2dDBNZFVxNHE2bEpzTEdoMXRiSTZBbzhYcG1oNUt0?=
 =?utf-8?B?bEJLWWw0TlFOK05HZVJoYUUxbGtKNEtBelFsOVdHaDZmTHhFS01zY1BBaktY?=
 =?utf-8?B?SVBYTDl5VWVQdDI3TEEzaFRwV1hXa2FqQjYwb05nVXRhVS9NSzZOVlJlbzF0?=
 =?utf-8?B?UmZGbExML1c2RTBja2VOWkRyZVZNL1V2bktVd2sxK1Bka0E0Zk5rOGd5NDRM?=
 =?utf-8?B?ckRsWHgwRjltTUNjRnJaTkNjMGljOXY4Z1dUNi9EcWF5SWFiczJXK3lqVlM5?=
 =?utf-8?B?Lys1UXA0K1NYOEZnSzF2eWVFZGh5SzZRUU9Wb1plTU9yUTkyQ0VQTkdCQnZ5?=
 =?utf-8?B?dlJ6UjZlbEVhUHNrNDZwSHF0bTM1aDVOckc5RVMxSWxlY2tmZWE3RE9zT1Jz?=
 =?utf-8?B?UFhLallicGo5bnhoVWZNNXE1SG04ZHdTNHEzcGdRYTMvVnlQOVRrcXF3dTN6?=
 =?utf-8?B?NUFYbERKN1UrVlM4TEZOOEQ0TTVuUVA1bXYrTFZ5REdmN2ZZcngycE5FeFNh?=
 =?utf-8?B?ZXlxa2dMTDVVY0dOK0dMZ2JublN3ckluY1JIRlVOT05XQitZZ2J5VTE4WXY5?=
 =?utf-8?B?cUhPNzBIazBvS1RMbk43djNKVE5RTi9Yc20vWjFnYmx3djI1SWxpSU5kYmRo?=
 =?utf-8?B?UkZrYzluYVZyNWRQYWlFZWxSYVN3VHh6S3JPM0lleVVaMmI0OTNqSDZsT3pW?=
 =?utf-8?B?U1k3Q3E4LzlFeGlQZGI0QXdUTmdjL0JoMTRrYUh4WElQdDhKMnh3ZzMwNUJY?=
 =?utf-8?B?dktDRklwc0xubUtLWktUR1dNUG01Q0xvMjF2bW8yZzR2TUw4R3NFTFlPL2lY?=
 =?utf-8?B?WlFEYzA4L0JzVVdNcGVuTnJ6ckhHcjA2a1ZVZ1czczBVSW1UVFU3SGs1THNy?=
 =?utf-8?B?b0xHZCtwRE5aRDFFemRDVjR6V0thUGZ3TWhUL3k3Z3dsYm5paFRsdTF6Tldz?=
 =?utf-8?B?VmJZdkkzejlaK0p3bTVOZk5taTlVek52Vi9xRVBOejFJaEhmZEVkekpma3FP?=
 =?utf-8?B?VVhlTW1DMk9nb1JmVmwrKzR0anliVXZ4SjA2TEs4QVg5S2NLaUg0cWJxZy83?=
 =?utf-8?B?ZGlodVljRGw1OWxKdFptNWFxdE9QVVBad3hLbVp1cUZHcUFMWFhXQWpUdlR6?=
 =?utf-8?B?NFFpMlh0UC9SSHZLczhXQ1BaaitxM0U2TVlyUi9PZ3oya0lSVG45VzRxeXFt?=
 =?utf-8?B?RkNSeHlHVmJaWExPTVZRbDg3aTlGNS9aUzY3S3M0bHdqbWNvSnRHNlpyS3cr?=
 =?utf-8?B?UlV2L2c5bEdwc2xjV0h3N3kvRDFNdENocHE5Vm53cENPMVVGbEIxRm1jamtK?=
 =?utf-8?B?WUpYRkpCbjI5TVVaMmpySTdYa0dLSXd3KzBSM0ZvWjI0Wlk5c1RWRzNSb1ZQ?=
 =?utf-8?B?M0E4SWh0RVcxTXhReGZPVlVnYlkvT09CSW9ZdWQ1VjBKMk9Dblh1L3B5S0NH?=
 =?utf-8?B?ZC9IRUR4TDRUSGRlbTl5OVMwOURhWjZTOEg0eWdJbXZMeTZiV1phclpGSTJH?=
 =?utf-8?B?SEc2bWo4RCtVOUg3YkJWcTUvRVhWN25JWFRmcVZtVEk4OGJjazVSZkRjU0dP?=
 =?utf-8?B?NzNVUEM2ZUpBV0xhVjkreEFmMVNiRFozUXlhd0wrS054TGdKaXB6cnRLekhK?=
 =?utf-8?B?RmszWVI0MXY1QWxVQzVnUnhlNHEzUGtVd2ZRM2tFTkFmQTJoUHdFSXJWQkMy?=
 =?utf-8?B?by95UHVJekdXaGdyZXQ2d2pTTnRGTHVWY0RjZkhsWWhFUktseVpvSVI5ZjZz?=
 =?utf-8?B?eXgwNTRidjBEQUFiaGVCbGJtZHNGejJkTzYva3NRdEJ1UmdXTnNCNFRkZkVI?=
 =?utf-8?B?dXZ5Y2NWakdXZVZlSE9rUmdNQjQ0RlZlUTN2QUpqN244S1lrVnB2Z2JIR3Bt?=
 =?utf-8?B?dUpVQUpMVGQ1Q0hWRFFORjdSbkRjd2dvZEl3YUlBeS9uVDhudE51MzlvT1BE?=
 =?utf-8?B?Y0E4bXJUKy9hUFVVaVVUZklxemY0dW9tTHAzTlhKUGRrTG1ieEFQM01vUDUv?=
 =?utf-8?B?L2pSM1NnTkpDMkhDVHpwaGw1V0lyTDhwZjhqQjc2Q3c3Rm9tNXN1N1hxVG1P?=
 =?utf-8?B?b01MM1Q4SEZiZGtwdS9Za1ZGVi9TSk1Tc2dPVVRsanBuY2xhYmxHai9FbG5S?=
 =?utf-8?B?U2EwR1E1QXFNcVhLclVLMzgvSXFmNXJreGFLVFFtckFBajNuQlJJQXFrMStv?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A14B6AB8E6FB0841B4ACA0D26ADFE4B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b777bf-9e37-448d-28ce-08dad8681e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:31:32.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0eCeHAf2J3DfgJXS0sL1LXTrnVGi7AtUVpvamveLT6KWsGF+s0GWgkG0gf4NaYjfpbx0wiryb/Z9xIk8fDBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTA3IGF0IDE0OjE3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDcvMTIvMjIgMTA6MjIsIERlcmVuIFd1IGhhIHNjcml0dG86DQo+
ID4gVGhlIGRlZmF1bHQgY2FzZSBmb3IgZnJhbWVfY29udG9ybCBpcyBpbnZhbGlkLiBXZSBzaG91
bGQgYWx3YXlzDQo+ID4gYXNzaWduIGFkZHIzIG9mIHRoaXMgZnJhbWUgcHJvcGVybHkuDQo+ID4g
DQo+ID4gQ292ZXJpdHkgZXJyb3IgbWVzc2FnZToNCj4gPiBpZiAoaWVlZTgwMjExX2hhc19hNCho
ZHIuZnJhbWVfY29udHJvbCkpDQo+ID4gKDE5KSBFdmVudCB1bmluaXRfdXNlX2luX2NhbGw6CVVz
aW5nIHVuaW5pdGlhbGl6ZWQgdmFsdWUNCj4gPiAiaGRyIi4NCj4gPiBGaWVsZCAiaGRyLmFkZHIz
IiBpcyB1bmluaXRpYWxpemVkIHdoZW4gY2FsbGluZyAibWVtY3B5Ii4NCj4gPiAJbWVtY3B5KHNr
Yl9wdXNoKHNrYiwgc2l6ZW9mKGhkcikpLCAmaGRyLCBzaXplb2YoaGRyKSk7DQo+ID4gZWxzZQ0K
PiA+IAltZW1jcHkoc2tiX3B1c2goc2tiLCBzaXplb2YoaGRyKSAtIDYpLCAmaGRyLCBzaXplb2Yo
aGRyKSAtIDYpOw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlcmVuIFd1IDxkZXJlbi53dUBt
ZWRpYXRlay5jb20+DQo+IA0KPiBQbGVhc2UgYWRkIHRoZSBhcHByb3ByaWF0ZSBGaXhlcyB0YWcg
dG8gdGhpcyBjb21taXQuDQo+IA0KPiBUaGFua3MsDQo+IEFuZ2Vsbw0KPiANClRoYW5rcywgQW5n
ZWxvLiBJIHdpbGwgcG9zdCBhIG5ldyB2ZXJzaW9uIHdpdGggRml4ZXMgdGFnLg0KDQoNCg0KDQo=
