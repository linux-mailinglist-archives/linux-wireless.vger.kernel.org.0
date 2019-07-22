Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66F70D4D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfGVXYe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 19:24:34 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:20289
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727200AbfGVXYe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 19:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmf5ugVadUvzsGwYemJvcr9mrQ9LpIYku0wDni2ohyasYTaKX/gdO26yZiRFR91B5KFpUjoJcuiLVwnN5t3shuMzNtfeyqzxGpaDN375VygfDQh4M0yykuoNE/Cjr/RMOGBzmSXxaBTqlG1Ydd0dHQhoSi2yd4/sWFFeC8DNlbM6aSVWSrQO5aaru7kPc8My6lAocweebLUzKuLP2iYN5IRt4Zt3mMHjUTR7DDeSAeHnKHUMqtueiVbmYutyzuZ+xEzqnZebh97VA8LWqSDhkwQgXBdb+1V5d4KPAtgc4iDfRM6D8dWnhC+kDQDjT4FwAPy+9Vjf3y9o+7jyu80yQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7J4LkdGzJQQju767NL4PQJypnOWJ1P9GrW6dlDGgq0=;
 b=kQnSpw/Yykguox23ixKVoUtJMqg+oPD7GZlTZd6wsi0P5TIvAV0V5peGcQO1KnUoObitZJZks+quNmN2wd81yv+8OJpIwaN1B4ZeUGfo910d/gCf035jZsfWgXMVlmU00d5ibhKWxhWVgaj6ns4znmXFIeH4g0Qr0jNLPrrauptNCy+Xx8GyQ8pk/NpiFbCoU/cuGA0BTRyZK4ZmwnxzUpbWk6ujWMVcc4OLAp3IjSF0AvwqnKxaYTwAKmOTfDCGos1cmtU6tS3LibYIkcHNdxDsjVAUf23Jn5/HMFWZoXCg6voguTO/zl/2hGtLwZGPGVou1rgQXpzj/5A4KSxWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=xevo.com;dmarc=pass action=none header.from=xevo.com;dkim=pass
 header.d=xevo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-uievolution-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7J4LkdGzJQQju767NL4PQJypnOWJ1P9GrW6dlDGgq0=;
 b=LHUvzzCblumC5aIqXMbgMKO2P0iP87Vl9mvzGzF7NFboCf/P7teGtTzDc39qdkl/1B3i0tywPOrDUEy4Ru1AvavJ6LiSdLkdnXRdLi0uZ53kfIALGEc2F5E16pA/l1w4zCCevIDAW06irtswsx/3doIgyWct94Jv5gh55pcL1ts=
Received: from DM5PR18MB2293.namprd18.prod.outlook.com (52.132.208.10) by
 DM5PR18MB1290.namprd18.prod.outlook.com (10.173.209.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 23:24:30 +0000
Received: from DM5PR18MB2293.namprd18.prod.outlook.com
 ([fe80::9402:86d2:af64:7938]) by DM5PR18MB2293.namprd18.prod.outlook.com
 ([fe80::9402:86d2:af64:7938%7]) with mapi id 15.20.2094.011; Mon, 22 Jul 2019
 23:24:30 +0000
From:   Brandon Darbro <bdarbro@xevo.com>
To:     "tiwai@suse.de" <tiwai@suse.de>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "dor.shaish@intel.com" <dor.shaish@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression with the latest iwlwifi-9260-*-46.ucode
Thread-Topic: Regression with the latest iwlwifi-9260-*-46.ucode
Thread-Index: AQHVQOSbihGS2kcqiUKQc4exrvn+2g==
Date:   Mon, 22 Jul 2019 23:24:29 +0000
Message-ID: <adc640f5dc37e63283f48a9ce3c082cc8219638e.camel@xevo.com>
In-Reply-To: <s5hmuh7xrqy.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.2-1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bdarbro@xevo.com; 
x-originating-ip: [2604:3d08:7781:6100:1d1c:4723:c04d:c569]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35e411dd-23fb-4251-8268-08d70efbbf08
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR18MB1290;
x-ms-traffictypediagnostic: DM5PR18MB1290:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR18MB1290DD223F72B812AE6E837DDBC40@DM5PR18MB1290.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(186003)(486006)(5660300002)(91956017)(6916009)(305945005)(36756003)(229853002)(966005)(7736002)(99286004)(102836004)(76116006)(2501003)(14454004)(54906003)(6506007)(558084003)(64756008)(66946007)(66556008)(66476007)(66446008)(6116002)(2616005)(476003)(11346002)(25786009)(4326008)(46003)(8676002)(478600001)(71190400001)(71200400001)(81156014)(8936002)(6306002)(1730700003)(5640700003)(6246003)(81166006)(2351001)(58126008)(68736007)(256004)(316002)(118296001)(86362001)(53936002)(6436002)(6486002)(2906002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1290;H:DM5PR18MB2293.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gICG4NKeaQwgK5b3hg907y6ury4NBAD86MkBjvICw56H5kNyA2OBuPT6D3fpS0dADbk2Qr/ASdZvipLeNgfrRdL71ja9/xBtIB1hnD35abvRPJDyn2X5dnCJO/eIwDHgMgo2WhexLhUWPw981XDaYTxCfinS/gM9zBDZdZqzHAxrUxWBesC6ClKlX8YczNCoyNqxEkm/ZUDHegBKRUkxxbMHs6vnmqz/FSlMJKMeA+1/sRP0QNHuACBeEot8ROOZk2vIGwTCpnzWT53itE3I6gbEQd3zne+kWsppIHVgJOI4K9CO8tffUPzSokNvjQsXGa18GwW06CV1X5HEL5954rOWaQ5U3XLCKbo2Uss5Q4SrqfleNAUVpnfV2ZnCaMpS6ahcFyUvoVpzsxECVGksPIrR2V+0BODBeKjDfl/Wu3g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EFEE013751F6E4B904CE28D7484631A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e411dd-23fb-4251-8268-08d70efbbf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 23:24:29.8711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdarbro@xevo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1290
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VWJ1bnR1IGJ1ZyB0cmFja2luZyB0aGUgc2FtZSBpc3N1ZS4NCg0KaHR0cHM6Ly9idWdzLmxhdW5j
aHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgtZmlybXdhcmUvK2J1Zy8xODM2OTg2DQoNCg==
