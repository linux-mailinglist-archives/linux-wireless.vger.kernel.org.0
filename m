Return-Path: <linux-wireless+bounces-9341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E37911733
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 02:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A4D1F228E3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 00:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D14A0C;
	Fri, 21 Jun 2024 00:18:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6D4A02;
	Fri, 21 Jun 2024 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929114; cv=fail; b=JY86yf3M9Zb2drzsk1EH90DxRoGlK7AyqH6dckPXF2/nO74eIsFH6mwbI5Kci/H2Cu8oCQJ/xm12SgDXtPFXdTR0b7PSFu45sCznB7BXactYwBp/BBth7kPGbDd1LEB5KKO6S+npCeX3IJJsrtJrxqQThRltpXAKQ3mQaz9KBmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929114; c=relaxed/simple;
	bh=NZU+re/DcuA+YydxxSfhJMgpu3a9MjAa9Wfph7eNBPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ua/yuCxJFQpC/kPkqbtyROipkYJYIySEAdPfa3fbgNydpN9R59EAwp1awnMCxYajw4zis876N7W2IsQUlELjznTI0bXSPn5TIybQpmfjKSXYqBi1NI7KxFeyOu0t0nECw7PWDBJINbZ/TufQDCgCI1+0eyEvt4cm2Bm7djYBs3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiTlHUvhNc7SKOTdJnofVsoF5gXek4kY7jUpHsT8rze+snPo26XX0GfiEJMzbPaGkizZZJE+BNl3FiQ4XCpnQXis0tFSQ262Xbdnq4nCrf3r3Hm2j69HfE5ux2ZZN1zuMMZlMldW5/yLoM0YYWTUsONiF3IpKuss1lAQiGJHiEM2B5kXjYrpx/x1KptZ9iEfXj2o7sZEPozSemaO/CP1m2OTzurhR108Pkrc1rGQQ4lSc7lHUipiWELrg4HjDx8/zFlsfd85xStBFCdvQ46t1zfLioMRT4ruU9ii/T3zCscT/3MJR2CxbjR+4Bcqxc/efxg2NyyW/Ke0M5b+Jl/HBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZU+re/DcuA+YydxxSfhJMgpu3a9MjAa9Wfph7eNBPU=;
 b=SF1n00oao6V6SpINmM0/walXrVZWYlIbrl/3r4jSLZCUtF+HjPe3LLhakMWJUk5w9dGmXofN9fr7+H9QnnWW5S1h+BYtn6xChvI++21tsRq9tLBIWw9wkDuXKuRnoZ7/j/vfPn/obudG45DXC2E5jPGTFNFidPfbkwLn9x6RlTtKv+VvGIySCSdKm2irTRfh4hyEH9rwwjo3sp9WRZIYuCU9u0/oYow8DtxLKg/vXnqcdgPDH2x9dnFJcERmVhWYS8r/GaHLroZFNKBKdrHTqqd9Q/fEmj3jvFE2IWrlZLjiT79r78/QAGHeJShScFVAB4W4TZCJM5NScFkKpZgNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB8133.apcprd03.prod.outlook.com (2603:1096:400:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 00:18:29 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Fri, 21 Jun 2024
 00:18:29 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "duoming@zju.edu.cn"
	<duoming@zju.edu.cn>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"megi@xff.cz" <megi@xff.cz>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie
	<nick@khadas.com>, "efectn@protonmail.com" <efectn@protonmail.com>,
	"jagan@edgeble.ai" <jagan@edgeble.ai>, "dsimic@manjaro.org"
	<dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add AP6275P wireless support
Thread-Topic: [PATCH v1 0/3] Add AP6275P wireless support
Thread-Index: AQHawrWe8szxUUEiVU6ofxAnEJGD6bHQ6nUAgABxMlo=
Date: Fri, 21 Jun 2024 00:18:29 +0000
Message-ID:
 <TYZPR03MB700158175919906A22D06AB180C92@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <19036b5bb30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19036b5bb30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|TYZPR03MB8133:EE_
x-ms-office365-filtering-correlation-id: 5934fcf0-0674-4e3e-7731-08dc9187ad23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/voxlk1O2stQkdSK5P6530VN41sigQmunxYaOes4nATrtSNd5Pc03lPkU8?=
 =?iso-8859-1?Q?dmknNDABoD5jC1+RwoOV3h1uWPib8BZaQx6EiGs7DB2wUea3sn33C8bDMH?=
 =?iso-8859-1?Q?49F+o8FUIJokzY9gjwOPSlUBNhHj/ykLTXvc83TyjN+gIXDnbbku7yClyO?=
 =?iso-8859-1?Q?bRp4d35LcE7FAkNjkIGHfTohktoa7MkOzMeNAnOgBXV+U6nFhXSHh6s2Pg?=
 =?iso-8859-1?Q?u+tf+pXifUminUDHYggiqdP8ewjK+XKkTeRwz+k3Zes7S4atnx2hJIcjyl?=
 =?iso-8859-1?Q?B5Cj8ByPdzjRII8VkF/LIzoCbuZpNcf9HajyRHpp8uPJy8AuwxRTAnKAvI?=
 =?iso-8859-1?Q?+sDj5/t/AenOBnfzIEgRbf2abc8hjrLOZMonno4WEo5IHBnEK9d9ddNtMd?=
 =?iso-8859-1?Q?bzzv0muMbyLKxm03StPgPchxGjdGHLVNIsib9RLiLjUwNHhmn9rM4E0vzP?=
 =?iso-8859-1?Q?NKvtMjk94TmA/pCxt5CJerm/x43r7QWtj1TvNJroFYHoHnZKYsqxQKoqN1?=
 =?iso-8859-1?Q?T4RdLNsN524T5RxCK6iqsplOJohtDNjwI9gAu5FihtMwv8Q61VJPwmxf+I?=
 =?iso-8859-1?Q?FEviHRaVyJ6IJDDnT6TrXnyRBLoqzrEwaMpTO/Kgh90w3Ai9O0kufIWYvW?=
 =?iso-8859-1?Q?WpGPCTGVfMudsPwg2BqZu49vNtAk0aoGl5ZrkzGYDRumSkW458XUX02KZK?=
 =?iso-8859-1?Q?oL1gZ2DOWpQ6qqv0DtTIHEiO51iKoyh7FF9iEesFcAlCYWn/t6YjPspdsb?=
 =?iso-8859-1?Q?Ot+EDSuNCelotZK5FEcYXr1AHOmRFuuQAlNuWikhVqWlEFl7w8G7KfDsa0?=
 =?iso-8859-1?Q?XzGe/46zEDN+YuS49IFIaGqCSsZcsd9sgc8TpwbYtoEWcEchcqU5RtkPkF?=
 =?iso-8859-1?Q?R+OeQO7+4co6dOVrDaih7eaom640oicC43jntNBh8szKxNYNBNjuER16VV?=
 =?iso-8859-1?Q?3ISKMrwywhgbuonYatYGfyE1cGGyAgBwC5t72eqTMfuDgTP6G/PeGrfwMy?=
 =?iso-8859-1?Q?pzjuDFcxI2THRyjt1x8OT0lGO110+3qAUrdGc7cx+ktxpYxhP2DtUyUljA?=
 =?iso-8859-1?Q?Y0HYEbH/7qSyLOLj8heJanJ/wI5tyB22w9DdegNqekPF93G+fno/lduY1I?=
 =?iso-8859-1?Q?s6zWLEQjHXKn/QrbuuxdjJX7Mw3MaLmPqXc0a039RwjKF/yALZ7tkuK2gO?=
 =?iso-8859-1?Q?TqX5guVuBcTDP+sUytBD3PnhaVeg7uBzBzNN4WciZDMyu17mOnaoUULOQk?=
 =?iso-8859-1?Q?ZRossRx/UrUD9PHQieLQtMQo1ysh0OTUPqKg9+KLVRtyg907TlGAUnxgDv?=
 =?iso-8859-1?Q?VlvuzvnK8DdSkDWW9FKHr9ncWqaRB+VCq9CGAEm7nI1r1yuO7wEOH86KMJ?=
 =?iso-8859-1?Q?xuhwFgimXJkiDe68KMRKtMnWh81nYL5bgB7cPLHYTui0ZDywC2fzs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nyjGFCoCjUBLZCK0Og4j21ho81eZP/0cwR5l2chOwFwctjOk59bORdI6Cx?=
 =?iso-8859-1?Q?AO07wS7uYC4uvpKrJHx9qMCtnVQGyVqRGQWoOJjiGcFtvkqMtIhhv0KZZJ?=
 =?iso-8859-1?Q?Uubms1MhDZ4/HTyULgO2obePHks15rakszoJmhT2Hn6P2l1ZbUH1v77Fah?=
 =?iso-8859-1?Q?wrVuWvxG7zlFJirWg0tvH/Zy2XxbrbABt1D5MNhHnYsAulkTrTeLEmz6oP?=
 =?iso-8859-1?Q?3cong6pCjcSLIEtC7g5eDjkS7NNPEU6kIVQDg3V44B/njHK9zzaRs1AnY8?=
 =?iso-8859-1?Q?iZFgugAplecaVLK5sfLmVhyELMVkU5JJwRKnButLpu75w44FqAPGPDwVjc?=
 =?iso-8859-1?Q?JAf+eqUjEwTrtNJbEx3te08KT538pC5gB8wz/xlwqoKnTImbA8Q9vSqHBR?=
 =?iso-8859-1?Q?KvsqxSWliwOCA421gUGQlJM66ebna1ByaQ7LcXQrMIUn96c7063+QyeoIw?=
 =?iso-8859-1?Q?yiCvRhgevl3ycv4ICHCD/fE00bpTjWJ5PuFEVIpeNgbVxww9+uXf6R1E8J?=
 =?iso-8859-1?Q?VNCsf4n0xzgAediimwD1VRZ6/voHgRkE+sTxRpjUsgVKhBk9ehgRj7m+BJ?=
 =?iso-8859-1?Q?4qwcK9uQNuDlwQNdXh4aUgJ2+n2n4JGxqhbft0t2g04ebyX5ePMzeRVdlz?=
 =?iso-8859-1?Q?dD9nuc8v+5IIWHAKaUxU2DVWJBfevuurhgzJKNr+KVkyo5O557HWIvwT3P?=
 =?iso-8859-1?Q?DeE3BT97E/sZGnP+30eBc4J77Dbo3N0omZU80iZXD2hp27f3sayj9YrJmy?=
 =?iso-8859-1?Q?0NktLkIImL4vaqHfEkbae2I0o9lvo4Dgc4pzrekZf48bZnYKcScPeHjo/j?=
 =?iso-8859-1?Q?FMANohf4WmcSNANshw9P+h65BCrUM2BwrNI00wAzgTfcajQ0IOa8CIRWhV?=
 =?iso-8859-1?Q?gCeYWqh99LoUk3ULJAi4tzA+UrCTznwhsNbpdaaBNnFcAP85vEdbdDTred?=
 =?iso-8859-1?Q?Pt7tSQHe4fg6Gw8lDx1aEH6d94GVVN4hA3++c66ixiD9ZeHNoVmpazVvhB?=
 =?iso-8859-1?Q?y8xSr39+V0ALjGNcHfXZVJaGj/gWTiFBEI0RfbhmJEUk23ly1mwmnzRtEg?=
 =?iso-8859-1?Q?H5t8ni3+zMpHDWWGuZHG3fA2Hn6NXrpnNkrdhi3V3uXqDL3HnMeRPbQQpy?=
 =?iso-8859-1?Q?Ntp1CYGhBe+8uxXl5Xc3eXzsSGSUhsGtuyNm+C6z+W13CYvXtbuWkBKqAy?=
 =?iso-8859-1?Q?n+SxFGmMzBOMbSDaK8c4ZPxLjJAmoYgBb+fTFgOtKqeIFW3AhOMupJLQG1?=
 =?iso-8859-1?Q?D5w4Y3a2SmWmewxa3wTliHZNiGj/FxoLpI5TenqESIABxUUrsTxlDSNhcN?=
 =?iso-8859-1?Q?48mGKJcqc6ezYU9LomtepTXexT+P1zrTHORL6gvMMzLI8PENOST/QK+V3d?=
 =?iso-8859-1?Q?3+YEOUmq2tz6VYq83PJqNoaeGyxwHc3tWf2Mcg2UG3m6yHy5Ux9FRFyqIc?=
 =?iso-8859-1?Q?Vo5VcsPsbCfXJzqQyOot/94l0bcmFELqMOMyXBR+3aKUNR6vnJDI7SkNOC?=
 =?iso-8859-1?Q?/kQYNSYoQ1lDHmon4neKdgzZ1rHPpmH+TtbNMWCExSRYIhk3FSrj4kTfzb?=
 =?iso-8859-1?Q?Z6xNQ4td6qHu+LeFQ6Aa4rplx0TMOzTmhLpjEjQMtR9SkDLsDkxGbEoyk1?=
 =?iso-8859-1?Q?+Kmk1qgsLBL4TYtVIuCrxL0kighMQ50Go3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5934fcf0-0674-4e3e-7731-08dc9187ad23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 00:18:29.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i7M3iuPzKyRp3HmAI8patz7Vlc5TX5Ir+Bq+aB7Rsh1MTnzJmrOxtTxeObSR70X7euGL1kGICejxGCjXfRTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8133

> Focus on getting agreement on that before=0A=
> throwing in DTS and driver details.=0A=
=0A=
Got it. I will focus on pushing the patch of defination first.=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

