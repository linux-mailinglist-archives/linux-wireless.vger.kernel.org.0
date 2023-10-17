Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B27CC471
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbjJQNSo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjJQNSd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 09:18:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D8D5E
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 06:18:02 -0700 (PDT)
X-UUID: 95a967f86cef11ee8051498923ad61e6-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=x87tOSKeemTVElDLBZH2CxKQStg55Py8d4CukaUIZ1M=;
        b=Xjdo0pbzV89jhoc/RYhzZIf+ApztK+Z9NowbFC+/arzETeKVzoTpO5BRMNc9L1L7GeR9vEi8E0eLKsYxwSliuAsHJHSzzDG/gEN4ecdLipL6Z1H7KHLl4JRbwxX1u9yiRThVkZWTq6+6ngScVyskWkvReijStRvlF6LU/LhNx0c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2fbe5fe1-d282-4cdd-be0a-9131bcd6ab08,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:75db2315-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 95a967f86cef11ee8051498923ad61e6-20231017
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 572552779; Tue, 17 Oct 2023 21:17:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 21:17:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 21:17:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoGc1Ll3AmgBtySRTaEALXe1gMXc2cRerLaGJq5NL7aAzVo+GwRjeoLob8px21YTlVd6yo/xNDSQMEjc/0UqwqC1vXvrf3QhAAiABatwDLw5pylVWUCExaL1NWB61zsoePLb1RtpcR0nDM+AfhECW25Fpe0LqPHI2M1RkZVHNnqxV8x2lodVz39MdUUgL2CAYOhb1sDGA0IkSPruX/pg5A6YQCJTf9JtDeb3T7jVekdFSjvgXor3uUi5d9f0eRz25bl6JjnGmogfvL41iJsY3OIHskz8NvKyxK5ZIIc1jerBkR70Y31aYxfAicQOoPMYRi8a7Hsvu8JI+fr85J5y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x87tOSKeemTVElDLBZH2CxKQStg55Py8d4CukaUIZ1M=;
 b=Ov39G5GlCHIGM5SlJPf7uz/t0aGacQ7Y7jCBm20nNx4XyvEkMRFbiQtf4QIYimreImUJXH3ySBDDjBi0EgdUtVa7w5fFr242H2jCoQpzbjg91HMvNkODzLnFMyvxxP6WmaRDz1N+f4VGLpZI2SHrzuxQLxs7htGiFeYR9nZm4SIBUWICHBLvVUEOaYJAzLDzRqLsB7924n4tSFS2LMUVMBxxrhDUl4prFzCvqiHHiGo0EOV+DMqxtIAp8eA2nM5rKk4tkwJUblafkOC4ltN3qNowoYohNuoGhfCLsJd2kh0hWz0ycES75u8+DB65+jhE5pr+4zruA78t8KdPvaGZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x87tOSKeemTVElDLBZH2CxKQStg55Py8d4CukaUIZ1M=;
 b=Ij4O+GwV4tEliZ8l2rMHGMIba1/Q+nCtWGQfRmKCUFsoD7HAzUolo9Ynqk2ZCgLpkDKFMmQQshBnGmvkhy22zY2uYdo9NO3MEgZU9k4hd1DJFfetCBRCAG3dvwkHflyaas18cJBrHYpqVu0iCx7wtnxM/VX8dpRxySzAg9h8iOQ=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 SEYPR03MB7892.apcprd03.prod.outlook.com (2603:1096:101:166::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Tue, 17 Oct 2023 13:17:50 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::3d1b:4de0:a1e9:eafc]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::3d1b:4de0:a1e9:eafc%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:17:50 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= 
        <Mingyen.Hsieh@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>,
        =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] wifi: mt76: mt7921: update the channel usage when
 the regd domain changed
Thread-Topic: [PATCH v2 5/6] wifi: mt76: mt7921: update the channel usage when
 the regd domain changed
Thread-Index: AQHZ80VnNJV4lxDSNkeXBDntDfPTArBN4/4AgAAuHYA=
Date:   Tue, 17 Oct 2023 13:17:50 +0000
Message-ID: <c3dd6ea9dbc5cb33915cf30538b33f1b8ccc1083.camel@mediatek.com>
References: <cover.1696039301.git.deren.wu@mediatek.com>
         <14b7b24fbe0029cac43d2c0c9e471b118419ad8e.1696039301.git.deren.wu@mediatek.com>
         <927e7d50-826d-4c92-9931-3c59b18c6945@collabora.com>
In-Reply-To: <927e7d50-826d-4c92-9931-3c59b18c6945@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|SEYPR03MB7892:EE_
x-ms-office365-filtering-correlation-id: 748b634f-7895-41fd-bcf9-08dbcf13765f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1jcLiENaRdwrLnT37no+GzZWnK79DG9jD/RXKFpZVNHpv5xNhY9MEjFaAm+MPMm6YYc8MkZNZ80MRw4wHM7hc+qEWnaTqKSEObTnvHykstssZqc0wLSsRLrIjF7FddiKFktFmOD4xUGeF4NiZBkFNy0IgN+4VTy9L6xlcQzS8s6xybiYiZQlIbUGp1jRem4UbXlK/gu8owGO+AOZAHM8zeL91rw8bxN5aMxg+eUhhxjKZGQfzO9jp03xc1tEmqVhiIxRY9b7QJvSe88OKvCWflumVMlWP5URw4+/VYalxaWFJmcHZFYq5SCX8eNSxcXmIgt61BVfrbgsHtStTWNipp9iEdNmLbFiNLQp8xsfQYrc0QsQ/0F/1sAfQLEV4Ykq+P9opJ9RLVU2nMO+BFL6eXUgDSKx9awXlrOmOnlgzLC0+tY3R9vmN4tw8lchrVpk5wzdoBTe2AkdjPDT9ax+nM+sNjn9Da1wBd35KStq7vNn4dzP6B0YpmfDC0PWLmendk+pW6WYhL4i48LJqmcQxvXuThLy6GYHcW/DrJunzp8UFQhitrlwtuxL5YSciiu3RfJ7zcBaiYz6jNyK0fV/3X4JKXxSF8u1mRQDzIBBO1/8PQRv4Ifn0uTA+SSTT8PnCuBreMwty9YNy7BvkJa8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(122000001)(15650500001)(38070700005)(4326008)(8936002)(8676002)(38100700002)(4001150100001)(41300700001)(5660300002)(86362001)(2906002)(6512007)(6506007)(478600001)(45080400002)(6486002)(966005)(71200400001)(2616005)(36756003)(85182001)(26005)(83380400001)(54906003)(66556008)(316002)(91956017)(110136005)(66946007)(76116006)(64756008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW0xYWRBdnFUZjg4L3ptTWtvMkNaRThjOHRzbGVUeUJ0Z0N4eUs4SWxKbjBJ?=
 =?utf-8?B?RFpwL2ZDSU1ONGRUUmF5cWdneUZ3bWx3QS9rSFdIMENJRS9aeVhIMVpXa3hz?=
 =?utf-8?B?U25zYVYxMkM3eWhET05QbGt2dlRZSk1qdHFrSE9zOWJxbXVuL3pUNkt0TzFs?=
 =?utf-8?B?aTVKK2N0NGNGZ3haNUlqZmEzSzVsOE5WQ3BuajVDeVRwSzY4dGMyejVQVzQ0?=
 =?utf-8?B?T3E4NVVGU2NZL0sybW1MbldVWGtDNkNqQ25NN3RnWUJybG5CV0QvWUdCVWth?=
 =?utf-8?B?Y0QrUXFIMW1sV2s5eFV1L2xjUHBINVNBYkdmWEtQVm9JaER4dzVCc1dQSHVI?=
 =?utf-8?B?ZENjQkNLbnNZc082cWIydTJRKzJqYnhWeVJ5Q2FqWE5PUUpqckd1SkJJV2pZ?=
 =?utf-8?B?TDJoYlpmNnFMeGdPeW1NeGdka2JCQ0ZSWWZUMkJMZXFFNTJGVEpxcDJvYjl6?=
 =?utf-8?B?c0R3MzIvT0UzR2ZzRU0xMUJzVXZhbTFTK3Q1R3ZZeFJKL3B1SUVwaTVjdTE3?=
 =?utf-8?B?MDF1WXgvSVhmUEZmaU9PUlFqUUZSOXFNQktmSGgxV2xoSlk5ZWpIYkMvcVVT?=
 =?utf-8?B?VzhwakJMKzhwY3k4MFRldUhBTWJ0cWdmL3hoeXpHR1Y0NVJ3ZHpFbHFnQ0RO?=
 =?utf-8?B?c1NadWR2Z3BNNXk5eUlsNmZYSXpQYndMandQM3hzRzR2MS9ZSFJ4cklpZ2J4?=
 =?utf-8?B?OUV0MGhwSmhhOFVHbEhONDFjbHRDRnA0YXNhTEw3cUFmaWl5M1pHd2J5cUNP?=
 =?utf-8?B?MmY3TGtnbk5IamF6NElpem9sOU53RnJSU2F1d00zeHAyYkZkbWF0Q0FNb3Nl?=
 =?utf-8?B?aVN5UVZaaGd2VjEzbzVYM2RVa21BdjhkR1BiNjl4MllDOFRmR1ZxRnl2OEto?=
 =?utf-8?B?V2JUZzNWeVZrWjZ6alNqL2N0WldRRnB4U1YwSmtjaWYwOTlhYzJoT2lBWkN1?=
 =?utf-8?B?QmwxVlhSYm91M2UxVEk4Y3YxRVpZT3BFZDBXRW42VmdTZkNsTDQ2NWxnQ3h5?=
 =?utf-8?B?T0hzai9FRktQaS9wZTEzcTZ6NnRYbk12eGlsMVlEd1FuRUJGeldyWTN0dGxG?=
 =?utf-8?B?eE41ZjVKY3RuRGJsUFRxcXcvRGh1ZzdhL0h1NXhDejRKbHhiTC9zZkNKTjIr?=
 =?utf-8?B?T2VpUCs4eEEybFZ5M2dXVDFVRkc4Vi9WTms3UHFVbXRoWklrNXdvakwrbjBS?=
 =?utf-8?B?UkFVQnAzSUxPK0JrcVY2cm1GV2c2WGVjZGg3MUM3aDlBY1A5UW1zREdNNVBF?=
 =?utf-8?B?RXA2elFZdThITTE1OEQ4Rm1QTE1NR0lrVk9ZRmZ3QXdyRXE5QVNXbS9NMGpq?=
 =?utf-8?B?bjY5RkJiK2gySzlPRzZmWERFckhCVENyZWxJOFVOWEJ4dUlsTXU0ZE1vdFJH?=
 =?utf-8?B?Z09WOFZjZGFQS2xVVWc0WTZxazdpamNmVURNR2JOOGZYcDUyRlo1bDNIdGN6?=
 =?utf-8?B?eURnK2RlSndiSzBnRFFnSXRnL1VuL29WV0FhZjRjTjJnL1d4RzQzK1NSNldR?=
 =?utf-8?B?aldROTUrR2VIaWFBZlluN0E4dVpWdGkwMnVyYzJZcnZlTkhHZHdjcTNJVzJV?=
 =?utf-8?B?MkF6Ymc1KzhJb2drdTVqcENBT01iMm9rWmxOZHhQNytja0hBZEFxcklPWUVY?=
 =?utf-8?B?clFFMTZncXdPb1JURzdJbmI4KzlXVGROdjlJUzV3MUVHdkZnWUhQME1GT0NO?=
 =?utf-8?B?RGZKazlWaXNCYTVxMTN0QnZ5NXUyQnRaQ0pvWnR4SENTNG4zRnlTeFVYZVlS?=
 =?utf-8?B?TndXenRIQzlRQ2FhdHNHM0hydXU0VkZGNFJnRTI1eHZsY04wYWFDNzY4azIv?=
 =?utf-8?B?eTNYZExFam5Kd1laM0tCdlBlcHptSHRtWUFVQ2VpdWIvVkRadkI4c1Rkbkxa?=
 =?utf-8?B?T1d6L2J0cXlpMzFEQWZPaW5tTjVoc3cvZ3RBZnpYNkNrZ2xmeHVZZUt2OWRS?=
 =?utf-8?B?VXlvNXpPcENsRVh0UUdISEppMUpmYUtjN1NpcHdvSXIxQVdvNE1LZTZZUFg5?=
 =?utf-8?B?UVFUeTBaRjdpU2l4MUlFRVhjaWtFc2ZZMFJwY2RKSHRzUlZ5eXJOdVdwYTdQ?=
 =?utf-8?B?eHBobG5kam5CL24zNi9mRXNSK2JiUGZZemcxb1lRK1hqcVZRNUFhTThPSVlu?=
 =?utf-8?B?T0t5ZWozWGN5L005UG1CSjNzbHgzNGlZZ1k3RDVRelM3aHdYcldDMmhWTDNw?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD5A43112590534489A437D6957523BD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b634f-7895-41fd-bcf9-08dbcf13765f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:17:50.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWNMnL0zyOE8o9ORh82aG6uCKP1GRUcEf6q2rtnv0h10IuAPRWydo9V/9h8dJo5YUmP4pBJdwXankbkDeKGeXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7892
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.179200-8.000000
X-TMASE-MatchedRID: HrJsCrYHOqPUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXYlJxMC94GqDUuug82vqq5sxNmUW1dq3NxkRs1fAcYNHEpWss5kPUFdIKwF4K/wIz9z5z
        AIum8OcR3DRBv+8enf4N2Be8ZZHZbcC92X+BT6RbQyiEb4hDaxxLXa2P1m93zOcqlsYvgKFVDvG
        NAF0fneFcFRoO05Tn4tpqoU9tNJ/5UHnl2REyzzImV1zb45ieG5Y0kb0hqatxnerzbhugqsvLTF
        m7Vc1pINQtn/DQ9imDL0O7A1t3q4ekNTvyxUG5Pj2FGM19l45cMJ78s6JmULXI35yp6FmTPmlbd
        RhCTBtSQmXwS7ElYLsx49cTke9GQkBulMq39DyjJ1E/nrJFEDw2aa5XTqpYWaVRQ51WzrJqjxYy
        RBa/qJRVHsNBZf9aRAYt5KiTiutlt1O49r1VEa8RB0bsfrpPIXzYxeQR1Dvvh/g4wA5B55PDp7i
        fhWhyl+5ruZ/MbfgZ7ax2PdCYi0oVxIm5v/HGf
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.179200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0E12A4B92D20A35A4870AA37CE1906169783D1E61F7A17D7CDB1568EBFFBAD3B2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjMtMTAtMTcgYXQgMTI6MzIgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAzMC8wOS8yMyAwNDoyNSwgRGVyZW4gV3Ug
aGEgc2NyaXR0bzoNCj4gPiBGcm9tOiBNaW5nIFllbiBIc2llaCA8bWluZ3llbi5oc2llaEBtZWRp
YXRlay5jb20+DQo+ID4gDQo+ID4gVGhlIDUuOS82R0h6IGNoYW5uZWwgbGljZW5zZSBvZiBhIGNl
cnRhaW4gcGxhdGZvcm0gZGV2aWNlIGhhcyBiZWVuDQo+ID4gcmVndWxhdGVkIGluIHZhcmlvdXMg
Y291bnRyaWVzLiBUaGF0IG1heSBiZSBkaWZmZXJlbmNlIHdpdGgNCj4gPiBzdGFuZGFyZA0KPiA+
IExpdW54IHJlZ3VsYXRvcnkgZG9tYWluIHNldHRpbmdzLiBJbiB0aGlzIGNhc2UsIHdoZW4NCj4g
PiAucmVnX25vdGlmaWVyKCkNCj4gPiBjYWxsZWQgZm9yIHJlZ3VsYXRvcnkgY2hhbmdlLCBtdDc5
MnggY2hpcHNldCBzaG91bGQgdXBkYXRlIHRoZQ0KPiA+IGNoYW5uZWwNCj4gPiB1c2FnZSBiYXNl
ZCBvbiBjbGMgb3IgZHRzIGNvbmZpZ3VyYXRpb25zLg0KPiA+IA0KPiA+IENoYW5uZWwgd291bGQg
YmUgZGlzYWJsZWQgYnkgZm9sbG93aW5nIGNhc2VzLg0KPiA+ICogY2xjIHJlcG9ydCB0aGUgcGFy
dGljdWxhciBVTklJLXggaXMgZGlzYWJsZWQuDQo+ID4gKiBkdHMgZW5hYmxlZCBhbmQgdGhlIGNo
YW5uZWwgaXMgbm90IGNvbmZpZ3VyZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZyBZ
ZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IENvLWRldmVsb3BlZC1i
eTogRGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBE
ZXJlbiBXdSA8ZGVyZW4ud3VAbWVkaWF0ZWsuY29tPg0KPiANCj4gSGVsbG8sDQo+IHRoaXMgcGF0
Y2ggaXMgZ2l2aW5nIGEga2VybmVsIHBhbmljIG9uIHRoZSBNVDgxOTUgQWNlciBUb21hdG8NCj4g
Q2hyb21lYm9vay4NCj4gDQpUaGFua3MgZm9yIHRoZSByZXBvcnQuIFdlIHByb3ZpZGUgYSBwYXRj
aCBmb3IgdGhpcyBjYXNlIGFuZCBjb21wbGV0ZQ0KdGhlIHRlc3Qgd2l0aCBtdDc5MjEvbXQ3OTIy
LiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gY2hlY2sgdGhlIG5ldw0KcGF0Y2g/DQoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9iM2M0NTk4MGEyMzBmMTdhZjE4NmQ0MDA0MTA3ZWQyN2Vl
OTUyY2M5LjE2OTc1NDc0NjEuZ2l0LmRlcmVuLnd1QG1lZGlhdGVrLmNvbS8NCg0KVGhhbmtzLA0K
RGVyZW4NCg0KPiANCj4gUGxlYXNlIHJlZmVyIHRvIHRoaXMgc3RhY2t0cmFjZToNCj4gDQo+IDwx
PlsgICAxOS40NDIwNzhdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSBhdA0KPiB2aXJ0dWFsIA0KPiBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMTQNCj4gPDE+
WyAgIDE5LjQ1NzUzNV0gTWVtIGFib3J0IGluZm86DQo+IDwxPlsgICAxOS40NjUzMjldICAgRVNS
ID0gMHgwMDAwMDAwMDk2MDAwMDA0DQo+IDwxPlsgICAxOS40NzMyOTVdICAgRUMgPSAweDI1OiBE
QUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+IDwxPlsgICAxOS40ODIzNTRdICAgU0VU
ID0gMCwgRm5WID0gMA0KPiA8MT5bICAgMTkuNDg5MTQzXSAgIEVBID0gMCwgUzFQVFcgPSAwDQo+
IDwxPlsgICAxOS40OTU5OTFdICAgRlNDID0gMHgwNDogbGV2ZWwgMCB0cmFuc2xhdGlvbiBmYXVs
dA0KPiA8MT5bICAgMTkuNTA0NTU0XSBEYXRhIGFib3J0IGluZm86DQo+IDwxPlsgICAxOS41MTEx
MTFdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNCwgSVNTMiA9IDB4MDAwMDAwMDANCj4gPDE+
WyAgIDE5LjUyMDI2OV0gICBDTSA9IDAsIFduUiA9IDAsIFRuRCA9IDAsIFRhZ0FjY2VzcyA9IDAN
Cj4gPDE+WyAgIDE5LjUyODk4OF0gICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGlydHlCaXQgPSAw
LCBYcyA9IDANCj4gPDE+WyAgIDE5LjUzNzk2MF0gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgt
Yml0IFZBcywNCj4gcGdkcD0wMDAwMDAwMTAyN2E5MDAwDQo+IDwxPlsgICAxOS41NDgwMTRdIFsw
MDAwMDAwMDAwMDAwMDE0XSBwZ2Q9MDAwMDAwMDAwMDAwMDAwMCwNCj4gcDRkPTAwMDAwMDAwMDAw
MDAwMDANCj4gPDA+WyAgIDE5LjU1ODQyOV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAw
OTYwMDAwMDQgWyMxXSBQUkVFTVBUDQo+IFNNUA0KPiA8ND5bICAgMTkuNTY4MjcwXSBNb2R1bGVz
IGxpbmtlZCBpbjogbXQ3OTIxZSBtdDc5MjFfY29tbW9uDQo+IG10NzkyeF9saWIgDQo+IG10NzZf
Y29ubmFjX2xpYiBtdDc2IG1hYzgwMjExIGJ0dXNiIGJ0aW50ZWwgY2ZnODAyMTEgYnRtdGsNCj4g
c25kX3NvZl9pcGNfbXNnX2luamVjdG9yIA0KPiBidHJ0bCBzbmRfc29mX2lwY19mbG9vZF90ZXN0
IGJ0YmNtIGJsdWV0b290aCBzbmRfc29mX210ODE5NSB1dmN2aWRlbyANCj4gbXRrX2Fkc3BfY29t
bW9uIHNuZF9zb2ZfeHRlbnNhX2RzcCB1dmMgc25kX3NvZl9vZiBzbmRfc29mDQo+IHZpZGVvYnVm
Ml92bWFsbG9jIA0KPiBlY2RoX2dlbmVyaWMgZWNjIHNuZF9zb2ZfdXRpbHMgY3Jvc19lY19saWRf
YW5nbGUgY3Jvc19lY19zZW5zb3JzDQo+IGNyY3QxMGRpZl9jZSANCj4gY3Jvc19lY19zZW5zb3Jz
X2NvcmUgY3Jvc191c2JwZF9sb2dnZXIgY3J5cHRvX3VzZXIgZnVzZSBpcF90YWJsZXMNCj4gaXB2
Ng0KPiA8ND5bICAgMTkuNjE0MjM3XSBDUFU6IDEgUElEOiAxMDUgQ29tbToga3dvcmtlci8xOjEg
Tm90IHRhaW50ZWQgDQo+IDYuNi4wLXJjNi1uZXh0LTIwMjMxMDE3KyAjMzI0DQo+IDw0PlsgICAx
OS42MjU5NTddIEhhcmR3YXJlIG5hbWU6IEFjZXIgVG9tYXRvIChyZXYyKSBib2FyZCAoRFQpDQo+
IDw0PlsgICAxOS42MzQ5NzBdIFdvcmtxdWV1ZTogZXZlbnRzIG10NzkyMV9pbml0X3dvcmsgW210
NzkyMV9jb21tb25dDQo+IDw0PlsgICAxOS42NDQ1MjJdIHBzdGF0ZTogNjA0MDAwMDkgKG5aQ3Yg
ZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUDQo+IC1TU0JTIEJUWVBFPS0tKQ0KPiA8ND5bICAgMTku
NjU1MTgyXSBwYyA6IG10NzkyMV9yZWdkX25vdGlmaWVyKzB4MTgwLzB4MjkwDQo+IFttdDc5MjFf
Y29tbW9uXQ0KPiA8ND5bICAgMTkuNjY0OTgzXSBsciA6IG10NzkyMV9yZWdkX25vdGlmaWVyKzB4
ZDQvMHgyOTANCj4gW210NzkyMV9jb21tb25dDQo+IDw0PlsgICAxOS42NzQ2NzldIHNwIDogZmZm
ZjgwMDA4MGFjYmE4MA0KPiA8ND5bICAgMTkuNjgxNjQ5XSB4Mjk6IGZmZmY4MDAwODBhY2JhODAg
eDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzoNCj4gZmZmZjRmYWYxNjAzMjE0OA0KPiA8ND5bICAg
MTkuNjkyNDgzXSB4MjY6IDAwMDAwMDAwMDAwMDAwMDAgeDI1OiAwMDAwMDAwMDAwMDAwMDAwIHgy
NDoNCj4gZmZmZjRmYWYxNjAzYWZhMA0KPiA8ND5bICAgMTkuNzAzMjk0XSB4MjM6IDAwMDAwMDAw
ZmZmZmU5MjYgeDIyOiBmZmZmNGZhZjE2MDMxZmEwIHgyMToNCj4gMDAwMDAwMDAwMDAwMDAyMw0K
PiA8ND5bICAgMTkuNzE0MTA4XSB4MjA6IDAwMDAwMDAwMDAwMDAwMWMgeDE5OiBmZmZmNGZhZjE2
YmE2ZjQwIHgxODoNCj4gMDAwMDAwMDBmZjFkNjAwMA0KPiA8ND5bICAgMTkuNzI0OTI4XSB4MTc6
IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiBmZmZmYWM2Yjg5MWMyNzUwIHgxNToNCj4gZmZmZjgwMDA4
MTA1MTAwMA0KPiA8ND5bICAgMTkuNzM1NzIyXSB4MTQ6IDAwMDAwMDAwMDAwMDAxODAgeDEzOiAw
MDAwMDAwMDAwMDAwMDAwIHgxMjoNCj4gMDAwMDAwMDAwMDAwMDAwMg0KPiA8ND5bICAgMTkuNzQ2
NDc4XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDIgeDEwOiBmZmZmNGZhZjAxYzIxNzgwIHg5IDoNCj4g
ZmZmZmFjNmI4OTFjMjgyYw0KPiA8ND5bICAgMTkuNzU3MjE0XSB4OCA6IDAwMDAwMDAwMDA2YzAw
MDAgeDcgOiBmZmZmYWM2YjZiMDIwY2YwIHg2IDoNCj4gZmZmZmFjNmI2YjAyMGNlOA0KPiA8ND5b
ICAgMTkuNzY3OTQ1XSB4NSA6IGZmZmZhYzZiNmIwMjBkMDAgeDQgOiBmZmZmYWM2YjZiMDIwY2Y4
IHgzIDoNCj4gZmZmZjRmYWYxNjAzNWZhMA0KPiA8ND5bICAgMTkuNzc4NjQ4XSB4MiA6IDAwMDAw
MDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDFjIHgwIDoNCj4gMDAwMDAwMDAwMDAwMDAz
MQ0KPiA8ND5bICAgMTkuNzg5MzY2XSBDYWxsIHRyYWNlOg0KPiA8ND5bICAgMTkuNzk1MzgxXSAg
bXQ3OTIxX3JlZ2Rfbm90aWZpZXIrMHgxODAvMHgyOTAgW210NzkyMV9jb21tb25dDQo+IDw0Plsg
ICAxOS44MDQ2NzVdICB3aXBoeV91cGRhdGVfcmVndWxhdG9yeSsweDJiYy8weGEwOCBbY2ZnODAy
MTFdDQo+IDw0PlsgICAxOS44MTM4NjRdICB3aXBoeV9yZWd1bGF0b3J5X3JlZ2lzdGVyKzB4NGMv
MHg4OCBbY2ZnODAyMTFdDQo+IDw0PlsgICAxOS44MjMwMjldICB3aXBoeV9yZWdpc3RlcisweDc1
Yy8weDhkMCBbY2ZnODAyMTFdDQo+IDw0PlsgICAxOS44MzE0NDZdICBpZWVlODAyMTFfcmVnaXN0
ZXJfaHcrMHg3MGMvMHhjMTAgW21hYzgwMjExXQ0KPiA8ND5bICAgMTkuODQwNDc5XSAgbXQ3Nl9y
ZWdpc3Rlcl9kZXZpY2UrMHgxNjgvMHgyZTggW210NzZdDQo+IDw0PlsgICAxOS44NDkwMDhdICBt
dDc5MjFfaW5pdF93b3JrKzB4ZGMvMHgyNTAgW210NzkyMV9jb21tb25dDQo+IDw0PlsgICAxOS44
NTc4MTddICBwcm9jZXNzX29uZV93b3JrKzB4MTQ4LzB4M2MwDQo+IDw0PlsgICAxOS44NjUyOTJd
ICB3b3JrZXJfdGhyZWFkKzB4MzJjLzB4NDUwDQo+IDw0PlsgICAxOS44NzI0ODldICBrdGhyZWFk
KzB4MTFjLzB4MTI4DQo+IDw0PlsgICAxOS44NzkxNzNdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgy
MA0KPiA8MD5bICAgMTkuODg2MTUzXSBDb2RlOiBmMDAwMDA0MSA5MTAwYTAyMSA5NDAwMGFlZiBh
YTAwMDNmOQ0KPiAoYjk0MDE3ODApDQo+IDw0PlsgICAxOS44OTU2MzRdIC0tLVsgZW5kIHRyYWNl
IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0K
