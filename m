Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC807F0BF1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjKTGm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 01:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTGmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 01:42:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB51DB
        for <linux-wireless@vger.kernel.org>; Sun, 19 Nov 2023 22:42:14 -0800 (PST)
X-UUID: ee847396876f11eea33bb35ae8d461a2-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M5+BexLIri3lvHij8iVtfwnkV8l5FjGq4CCZh2X9bJc=;
        b=lVA8rrjmeWCQCA6b+b0KukiJm3gMxSXmtnn0YfynkAMmdZkKMs9L4+9bOp2IPnvMGF3eQF8wow22MENMnwGPN1lLsUu+qQ2GDg6jICuVrcUWyxWvLOEpYGisFAhyaQEgdNwoILr1Ucihky/RaWCZd60Y0HJx8a99sVesI+nxvdo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c9afd5c9-7be7-4df4-9d80-f3e568757356,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:8beb4060-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ee847396876f11eea33bb35ae8d461a2-20231120
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1912830161; Mon, 20 Nov 2023 14:42:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 14:42:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 14:42:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U34jCJg3No9JL4uIXfzPYNddqTg4T3PPctYNZYM4AZMBcyi0T7ohOMt4g1yNjCO8eSaXUx6xklfyf2xjpGQMN5h2XizR0vOjEE6lSSowmgOki7A5yeQ50bpncoES6SU6Nk5TQhproU5AB50eabV5Bv/su8IHcoJIy9RgG6Qa/U3k8qDcGC1NnH+Xi7ayzaRIVqxWdyb9zBkBGklt7mo6K2funl3CdGycX7lAhAHDdHc+TIWhnVhptFwYaJjN8orEs/nAM88+nYRwpYMQNiXFngXhPWdFojB9TWipxLU9lLZkgnweEstXsVji5JR8Sg+4+ZaMZM/pCxq2bX29S/jTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5+BexLIri3lvHij8iVtfwnkV8l5FjGq4CCZh2X9bJc=;
 b=NRXDndZMcLYuYv29i8WaVFKceLDfOQbwVD60PBCP89ip3erZDa4qudREGI7rytEvjEtGIMmM2Fuj7RnosegS/E+YT6VVJyI71BSSDuqLR1nskbYBC1HKGFfuFwPsi/LnD91Gm2H5/E2VUIqF0WUWehsFW+isjhXLuQqes9ehE4JjRXfz5u8HiK0ryJ+i6/fPKVfe++hexgDBXveYWKL9Jf9PrSTwrZ/q0ANYCom7dqtqop2EXVbanpUzKcFXpKaPYXNavH9kDK0Pyt/7xK6LSj3DmONrg2H68KTYkOV90Gm53F9rjxJqmJAYY3isqiFEGD5+d/U+c3ttLjZzRc+AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5+BexLIri3lvHij8iVtfwnkV8l5FjGq4CCZh2X9bJc=;
 b=wX70Nece8b9WKBU+OBj6SEh1grIIvQk7sHuDcpIjXOBs6b/WvloDFPY0eq/dlQVVHhBjtkltJDteuAkiCi3ijhcK8GUBebAxrK8e1sGe/IffQOCBeRtjUrP4TDZaKS3Xb+XfF08htoQ3H0xBzvCd9V+zG31DTPl/fu/nUL8eSi4=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by TYSPR03MB7763.apcprd03.prod.outlook.com (2603:1096:400:410::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 06:42:05 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::30b1:4c15:efa0:b4b5]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::30b1:4c15:efa0:b4b5%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 06:42:04 +0000
From:   =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>
Subject: Re: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
Thread-Topic: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
Thread-Index: AQHaFda3G7NT7MxiRkyvQdmOTr3mLLB4CnyAgArDLYA=
Date:   Mon, 20 Nov 2023 06:42:04 +0000
Message-ID: <e56d4b60d6b0e7305cc9db4f4b1e33fc44317ce5.camel@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
         <20231113021107.13110-2-michael-cy.lee@mediatek.com>
         <2eaa04080702230b8dbe3b3541d6d831484c4f1f.camel@sipsolutions.net>
In-Reply-To: <2eaa04080702230b8dbe3b3541d6d831484c4f1f.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|TYSPR03MB7763:EE_
x-ms-office365-filtering-correlation-id: 8109cb6b-1c17-467f-fd23-08dbe993cf2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ms2TPQcsKpuoMx/f9pB/K+icqjN9bSnxj7Zjq61dyAAn4w8ROh4+07njZwxRXEh5Uqhu8wshY0fEa9ZCF5Begfg0maMqpipQiPiNDuB8eSGvH2FFinpzD6J4aWyRGC+f2XyDXCxKjtJKHp4LjfxabibBLAnRAd+0swbseeG5mUd24cVWxN5hl34X/9t1RqI/3l+0ji3uKxbHyhLUBdMZHP0+NBkB2MABXi8VkL76ohZOT6fXwa2wko9vEA4NRHO4vk0xTfmhYH0hZKSM/kg5Qp/wMAS9zN4aVxxiYCREcmtle9141m8GKEK3QJ1Nli/aatts3k9mRzUGyRhy6db+HZcWNvaZDYnyoW+1cmNNWCozp6vUcRnkBwnYmwrZduwc9TK+eCmWKmXeb1XTeZ9fw9UsDFO/KVfp/f428hY9XtOUFFjokvOXzCOUz+PjCGj9Nl3FUJVxmmYJixOL7EKa9EBr7sJhZGS/yfloXa1RH5SutNTRT49NlKpvDREcOAjN5vlldTw9bF2iG/sGh+AOgwwMkRk1CSahcGY5U4Z9vNUtSe3c7nAEJSObPm4dTiSlkMQaqToIjyOnLBBatINNomeTd4IqrfJzLIWsnrUJ/WpU982kPwhpeZ8uWHG96A8tO+YbeT8qv5hiyvj7T6Z/VbXXXwOvKwSuotyaRG+SLxWdehYxfEzmxoCGmMqjYhByoMBu6g+XG2JKB/vKKBSQFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(85182001)(36756003)(5660300002)(86362001)(4001150100001)(2906002)(38070700009)(122000001)(6506007)(6512007)(26005)(2616005)(107886003)(83380400001)(478600001)(6486002)(71200400001)(38100700002)(110136005)(91956017)(66556008)(66446008)(76116006)(66946007)(4326008)(8936002)(66476007)(64756008)(8676002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmxDMDAzS2prTXVyMUFsdDJTcDJtWDh1RXU1QzlvVlIxNTFtWWEwSVEzZDdk?=
 =?utf-8?B?TUlDVU82SFROeE93WDRQUGZ6VnFyVTR4ejE1UW0wY2s2MndjaDN1MDdLT3ZM?=
 =?utf-8?B?c3dqS0o0RGtZU0tnblRzZlFIaFNVSHdzN3p3dktBYmc3UXBsU3BpdHdFT0dZ?=
 =?utf-8?B?MTA2VWdYVWpadFNTaEpmUVl4WHlDZWh5N2ptdlFrWDhTYkRTUFJlNEV0akow?=
 =?utf-8?B?dUlZUlMyVmFWeUE4aXgzNXdtZkdqcEsyR25QTUlUMUJMMS9DenJSUGtzQm5k?=
 =?utf-8?B?TDU1TTJLSkxiczBSRDloNDByMVFhZkEzRUVIbmRjSFFVZ1ZIUGFVSHVzaEQ2?=
 =?utf-8?B?S3A0VDJBRGhjYWE2RjJ6d2grQzBTN2dnRDJQcG9LQVN0cWVQRDRLcHpDNzg1?=
 =?utf-8?B?dHNCYWpOQTFVeUtReFZXcStUdjlGREhpYXhTWHpGazkyOWJTQjBjbFlJOURR?=
 =?utf-8?B?K2VES2lXZ2xVd2VLb3h0ajBUVWtlMEQ2ZWxsanZnc1V4T3JoZ1paclQ0UHdr?=
 =?utf-8?B?V0Q5Y1NWN2xXWlNFSDJLTGxFeE1qZ0hiRWNIemF0YjR0RUtJTmdmWDBBMktS?=
 =?utf-8?B?TDhqUWczdStHY2pUUG1QVVBSWGQxQTNLUEx4NEsvTlBmTzEwUU9JdTZCVEtM?=
 =?utf-8?B?R3U2VUNxcWdSQjQwTGM0cE45Z2pBNEFFYXJyM1pYNlhzZ2pKSGpaK0JlTk9Y?=
 =?utf-8?B?M1pUZnVvM0NlSEZCVWJ3aWJpUVhoeWIwZWp0RlJNM3BUYjE1Z0ZGNHdZTWZp?=
 =?utf-8?B?R3F3ZHRTbld3KzhXTTZya1hTNzRCTFN0NVVCQXdqVFUwL2NnS2dscE43emZT?=
 =?utf-8?B?a1BoQ1djRjlmZ0JmVlZXbnRxNFIveDk1OS9Nci9wWlREUmUvdHpRa1hleE93?=
 =?utf-8?B?WHpIVUZLMGFoSUo4eUc3WkV2b2FxRFdyek04akVEdlpXVDRLNkF5UmxtMURN?=
 =?utf-8?B?WEdtamg5dmxiZjZvMStWcjg0eFEzbmpyWDUrRnYrbWU1TFFWcG0zalRkV1ZJ?=
 =?utf-8?B?Y0NlaVFTL3QwbG92VWJmVEtaeTh1ekVxWGJEb253MHFKSmZZS1ZGWml6RHlM?=
 =?utf-8?B?dm43R2o0T05GTzdzRGhVbVBQaUl6dHFZY2pzcnNoZmovUWMrK0pnMlZBb1pZ?=
 =?utf-8?B?eTRKRktKYng5T2VtQ2xreWdjS3hBODZEVXlKcUxwWnQ5dDRFUTFwK0VkZUpP?=
 =?utf-8?B?UEVMbkNpS2FudnZLSmFvT0Zma0IvVXEvRk1WbTZscENuZm4zZnZxakowVDBQ?=
 =?utf-8?B?RXcyUmZKMlV5WlhzZ1c5cUNuNGNxL1dQVGlPL09obFlkYi9za3Q2b2taTFRR?=
 =?utf-8?B?TUExMFhSQ3g3amVxVC9YUG5qVHR4eDVCQThlNSthZjVLbGdvZG5EZWlJOUFI?=
 =?utf-8?B?eHBmOXJ6RmkrYU9PbzVsTE1qeElkbWt6SWduUE83enNaTy9rQlVVZURTTG82?=
 =?utf-8?B?K1M0cmJlOXcwWjAvRTlQaTFiaXJqYjNwWlh0cm5CYnZPV3puWWRPaENNZGcw?=
 =?utf-8?B?T00vWlFsemd2WmRIREVoS2NWRS9DMXRrZFBjNDBKd1l1K3hkU2syaUNwc3cw?=
 =?utf-8?B?b093bllGeTVVY3hhN2NLV09vTFZpMU9wR3VWam5EYUlCcDRvNmlKR1MzMjdk?=
 =?utf-8?B?UFAwS1VMTmQ4SWxYTnRIbUtwVmZjcXRCc2dJdXQ1cGd6SmhUa2I5d0hTSTVE?=
 =?utf-8?B?OVJacXU4Qm9jYzhQUWZmcXZwZ0IrUFh0UTU4THpmL0kxaHpkV2hHeklNLzB3?=
 =?utf-8?B?T1NUSDloOEhCR2VpUURpUFRxR24yc0NHS2M2Q2x0aHIybXp4czlWNE5QdGx0?=
 =?utf-8?B?ZkNJaHBNTnNxd0VsQXhsdFJmd2lkeE95UytHYXpFUEIzR00vUm8xbnZSZ3ow?=
 =?utf-8?B?TjN2MHRta3g1Q3UybzdheTQ3blNFOG42eURtY0NrbWtoUE5icXo2ajdDYWVD?=
 =?utf-8?B?eFE1UmROVlFWOTIwQTRtNkxHbTdKMHNJdmxoR2NwWGcrSkR1RUtEaEpuQzNK?=
 =?utf-8?B?YW9RZVc5bWFFY2RmSi9HRUpSWElhOFViYzJRZ016eGg0VXl5VExidzBSVWk0?=
 =?utf-8?B?dHZjV1RzS3dkSEZubnZ6OWU0ZHM3eE5LazBKZGxvM3ZVb2FwVk9sb3ExODl6?=
 =?utf-8?B?dy9maXJQYWdsaDR3UnEzcFkwbXJDYlIxbE5hc3hJYlhzaGNPZkEzUlA1SmFu?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B10D21AE03FB6D42A156A470BD3E96DA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8109cb6b-1c17-467f-fd23-08dbe993cf2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 06:42:04.8064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EM7FZV84oYAYafAeu4Yj8fbqbG+urxfcvIhUXmQtOIbbRiNaKKy4Ryg1Ohk+pt4A225t38pht7HPw2Bpp7W+BhiI+IKvOGaEXiG+HQnCkE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7763
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.630100-8.000000
X-TMASE-MatchedRID: 9d2LtCNB3NJhgXuWXN7TdsAmcZEx8XHJq/9ouYhuDGQjdsSsWMwoDdAY
        WUo4HSIky/JO2VufWJV0dGAnt43KrWIkuSDGYD3DSHCU59h5KrHDHSNFHFxB87uqk4cq52pzwJL
        YAybWdAJxi0SNYWzDUfujjfdGiUklSSQ7jOqms04fBnGazfXNjiH8kDR0dp2mg79QgL6o/3jCDc
        jF5OS/iONWK7dLtU8N4MwF2WlzisXzNZjRxuo8vmlHv4vQHqYTzQQ2zkt0IfkvM0Gdq0fzqa0Ro
        mhWPJaQvMCj4jijz4wjfA7ocKKIp7taoC6wda2MkPoFsM336M6Vq+okl1rYD+od133eVWP4Swn2
        DEKt5OT09ZVL1hM9UaCVmgiPL15lYTmYMPkC1lUzw5Ejs3g1lsnlJe2gk8vIir7SL98lyQnWgKP
        NwCGUEja/4GCvu+Pec2suhjdWR4VB3qCBpmVp/p4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrIke0Gx
        /n9RcltVC7UY1n6yLKayT/BQTiGgP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.630100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D67B51E9950677B9A7BFA796E0FAA4F9752FA89C0DF86F2FCDF5C3E58E33B3472000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSm9oYW5uZXMsDQoNCkkgd2lsbCBmaXggdGhlIHR5cG9zIGFuZCBjaGFuZ2UgYWxsIHRoZSDi
gJxJRSDigJ0gdG8g4oCcRWxlbWVudOKAnS4gVGhlIFRPRE8NCmZvciAzMjAgTUh6IGJhbmR3aWR0
aCBpcyB1c2VkIGZvciBpbnRlcm5hbCB0ZXN0cywgSeKAmWxsIHJlbW92ZSBpdCwgdG9vLg0KIA0K
V2UgaGFkIGNoZWNrZWQgdGhlIEQ0LjEsIGFuZCB1bmZvcnR1bmF0ZWx5LCB0aGUgYWRkaXRpb25h
bCBkZXNjcmlwdGlvbg0KZm9yIFdCQ1MgRWxlbWVudCBpbiBEMy4yIDkuNC4yLjE1OSBpcyByZW1v
dmVkLiBJbiBvdGhlciB3b3JkcywgRDQuMQ0KZG9lcyBub3QgY2hhbmdlIHRoZSBkZWZpbml0aW9u
cyBvZiBXQkNTIEVsZW1lbnQgYW5kIFdCQ1MgRWxlbWVudCBzaG91bGQNCmJlIHBhcnNlZCBhcyBW
SFQgb3BlcmF0aW5nIGluZm9ybWF0aW9uIHJlZ2FyZGxlc3Mgb2YgdGhlIEJTUyBiZWluZyBWSFQs
DQpIRSwgb3IgRUhULg0KIA0KQWZ0ZXIgcGFyc2luZyB0aGUgV0JDUyBFbGVtZW50LCB0aGUgU1RB
IG5lZWRzIHRvIGNoZWNrIHdoZXRoZXIgdGhlIG5ldw0KY2hhbm5lbCBmaXRzIGl0cyBjYXBhYmls
aXRpZXMgYWNjb3JkaW5nIHRvIHRoZSBvcGVyYXRpbmcgbW9kZQ0KKFZIVC9IRS9FSFQpLg0KSG93
ZXZlciwgdGhlIGV4aXN0aW5nIGZsb3cgb25seSBjaGVja3MgdGhlIFZIVCBjYXBhYmlsaXR5IGFm
dGVyIHRoZQ0KV0JDUyBFbGVtZW50IHBhcnNpbmcsIHdoaWNoIGlzIGluY29ycmVjdCB3aGVuIHRo
ZSBCU1MgaXMgSEUvRUhUIG9yIHRoZQ0KYmFuZCBpcyA2IEdIei4NCiANCkluIHN1bW1hcnksIEkg
d2lsbCByZWZhY3RvciB0aGUgV0JDUyBFbGVtZW50IHBhcnNpbmcgcGFydCBvZiB0aGlzDQpwYXRj
aCwgYWxvbmcgd2l0aCBvdGhlciBmaXhlcy4NCg0KQmVzdCwNCk1pY2hhZWwNCg0KT24gTW9uLCAy
MDIzLTExLTEzIGF0IDExOjIwICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiAgCSANCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gIE9uIE1vbiwgMjAyMy0xMS0xMyBhdCAxMDoxMSArMDgwMCwgTWljaGFlbC1DWSBMZWUg
d3JvdGU6DQo+ID4gVGhlIFdpLUZpIFN0YW5kYXJkIChJRUVFIDgwMi4xMS0yMDIwIDkuNC4yLjE2
MCkgaW5pdGlhbGx5IHNwZWNpZmllZA0KPiB0aGF0DQo+ID4gdGhlIFdpZGUgQmFuZHdpZHRoIENo
YW5uZWwgU3dpdGNoIChXQkNTKSBJRSBzdWJmaWVsZHMgaGF2ZSBzYW1lDQo+IGRlZmluaXRpb25z
DQo+ID4gYXMgdGhlIFMxRyBvciBWSFQgT3BlcmF0aW9uIEluZm9ybWF0aW9uIGFjY29yZGluZyB0
byB0aGUgb3BlcmF0aW5nDQo+IGJhbmQuDQo+ID4gDQo+ID4gSG93ZXZlciwgaXQgZGlkIG5vdCBj
aGFuZ2UgdGhlIGRlZmluaXRpb25zIGluIHRoZSBhbWVuZG1lbnQgZm9yIDYNCj4gR0h6DQo+ID4g
KElFRUUgODAyLjExYXgtMjAyMSksIHNvIHRoZSBsb2dpYyByZW1haW4gdGhlIHNhbWUgZm9yIGhh
bmRsaW5nIHRoZQ0KPiBXQkNTDQo+ID4gSUUgZXZlbiBpZiB0aGVyZSBpcyBubyBWSFQgbW9kZSBp
biA2IEdIei4NCj4gPiANCj4gPiBOb3cgdGhlIFdpLUZpIFN0YW5kYXJkIGRyYWZ0IChJRUVFIFA4
MDIxMWJlIEQzLjIgOS40LjIuMTU5KQ0KPiBtb2RpZmllcyB0aGUNCj4gPiBkZWZpdGlvbnMsIG1h
a2luZyB0aGUgV0JDUyBJRSBzdWJmaWVsZHMgZm9sbG93IHRoZSBkZWZpbml0aW9ucyBvZg0KPiBT
MUcsDQo+IA0KPiB0eXBlIC0gZGVmaW5pdGlvbnMNCj4gDQo+ID4gVkhUIGFuZCBIRSBPcGVyYXRp
b24gSW5mb3JtYXRpb24gaW4gUzFHLCA1IEdIeiBhbmQgNiBHSHogYmFuZCwNCj4gcmVzcGVjdGl2
ZWx5Lg0KPiA+IA0KPiA+IEFQcyBpbiA2IEdIeiBiYW5kIG1pZ2h0IHVzZSB0aGUgVkhUIG9yIEhF
IE9wZXJhdGlvbiBJbmZvcm1hdGlvbiB0bw0KPiBidWlsZA0KPiA+IGEgV0JDUyBJRSBhY2NvcmRp
bmcgdG8gdGhlIFdpLUZpIFN0YW5kYXJkIHRoZXkgZm9sbG93LiBPcmlnaW5hbGx5LA0KPiB0aGUg
U1RBDQo+IA0KPiBQcm9iYWJseSBzaG91bGQgc2F5ICJFbGVtZW50IiBpbiBwbGFjZSBvZiBhbGwg
dGhvc2UgIklFIiAtIHRoZSBzcGVjDQo+IHN0b3BwZWQgY2FsbGluZyB0aGVtICJJbmZvcm1hdGlv
biBFbGVtZW50cyIgYSBsb25nIHRpbWUgYWdvIDopDQo+IA0KPiA+IGp1c3QgcGFyc2VkIHRoZSBX
QkNTIElFIGFzIFZIVCBPcGVyYXRpb24gSW5mb3JhbXRpb24sIHdoaWNoIHdhcw0KPiB3cm9uZyBp
Zg0KPiA+IHRoZSBBUCB3YXMgYWN0dWFsbHkgYnVpbGQgdGhlIElFIGJ5IHRoZSBIRSBPcGVyYXRp
b24gSW5mb3JtYXRpb24uDQo+ID4gDQo+ID4gVG8gYXZvaWQgdGhlIGFtYmlndWl0eSwgU1RBIHNo
b3VsZCBwcmVmZXIgdGhlIG9wX2NsYXNzIGluIHRoZQ0KPiBFeHRlbmRlZA0KPiA+IENoYW5uZWwg
U3dpdGNoIEFubm91bmNlbWVudCAoRUNTQSkgSUUgcmF0aGVuIHRoYW4gdGhlIFdCQ1MgSUUuIElm
DQo+IHRoZSBFQ1NBDQo+IA0KPiB0eXBvIC0gcmF0aGVyDQo+IA0KPiA+IElFIGlzIG5vdCBwcmVz
ZW50ZWQgaW4gYSBjaGFubmVsIHN3aXRjaCB0byA2IEdIeiwgdGhlIFNUQSBzaG91bGQgYmUNCj4g
YXdhcmUNCj4gPiBvZiB0aGUgcG9zc2libGUgYW1iaWd1aXR5IHdoZW4gcGFyc2luZyB0aGUgV0JD
UyBJRS4NCj4gPiANCj4gPiBUbyBkZXJpdmUgdGhlIGNvcnJlY3QgYmFuZHdpZHRpbiBpbiB1c2Us
IHRoZSBTVEEgc2hvdWxkIGNoZWNrIHRoZQ0KPiANCj4gdHlwbyAtIGJhbmR3aWR0aCBpbg0KPiAN
Cj4gPiArY2FzZSA0Og0KPiA+ICsvKiAzMjAgTUh6IGJhbmR3aWR0aA0KPiA+ICsgKiBUT0RPIGNo
YW5uZWwgc3dpdGNoIHRvIDMyMCBNSHogYmFuZHdpZHRoIHNob3VsZCBiZSBpbmRpYXRlZA0KPiA+
ICsgKiBieSBCYW5kd2lkdGggSW5kaWNhdGlvbiBJRSAoSUVFRSBQODAyMTFiZSBEMy4yIDkuNC4y
LjE1OSkNCj4gPiArICovDQo+ID4gK2hlXzZnaHpfb3Blci0+Y29udHJvbCA9IElFRUU4MDIxMV9F
SFRfT1BFUl9DSEFOX1dJRFRIXzMyME1IWjsNCj4gPiArYnJlYWs7DQo+IA0KPiBJJ20gbm90IHN1
cmUgd2hhdCB0aGlzIFRPRE8gd2FzIG1lYW50IHRvIHJlZmVyIHRvLCBidXQgSSBkbyBrbm93IHRo
YXQNCj4gRDQuMSBtYWRlIHNvbWUgY2hhbmdlcyBoZXJlLCBtYXliZSB3ZSBzaG91bGQgY2hlY2sg
dGhvc2U/IEkgaGF2ZW4ndA0KPiBldmVuDQo+IGNoZWNrZWQgd2hhdCB0aGUgY2hhbmdlcyBhcmUg
dGhvdWdoLg0KPiANCj4gSW4gYW55IGNhc2UsIGNoZWNraW5nIHdpdGggYSBuZXdlciBkcmFmdCBh
bmQgdXNpbmcgdGhhdCB3b3VsZCBzZWVtDQo+IHVzZWZ1bD8NCj4gDQo+IEhhdmVuJ3QgcmVhbGx5
IHJlYWQgYWxsIHRoZSBvdGhlciB0aGluZ3MgaGVyZSB5ZXQsIHRoaXMganVzdCBjYXVnaHQNCj4g
bXkNCj4gZXllIHNpbmNlIEkgYWxzbyBqdXN0IGhlYXJkIGFib3V0IEQ0LjEgY2hhbmdlcywgYnV0
IEkgZG9uJ3QgaGF2ZSB0aGF0DQo+IG9yDQo+IGV2ZW4gdGhlIG9sZCBzdHVmZiBhbGwgaW4gbXkg
aGVhZCByaWdodCBub3cuDQo+IA0KPiBqb2hhbm5lcw0KPiANCg==
