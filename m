Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E72B8DE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjFLHlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjFLHlj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 03:41:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14671981;
        Mon, 12 Jun 2023 00:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjZqO1rjZRxxj6W5ayA0ejf9sqpoVaSlIb07ucf4uJqofisAzeKY/E0ulQIrzAJahSfaajNQ+Z9UxtmNCtlfl8JMu7n5DcxIbFIbz+eyY6qPR2/nH25hZr9jLtdBU4VQgjvvLJmQYDLEGxy/R0I9vEwNwnK/+n97rjuITsm1uKhvwBIOfxKaLa+eO+c4Rzlp417sLNXD7/ZlpRozx2t3D7E+DPRaW+yN/AB3xvgMDsknDbgM1hmoEJAePy9obFX9K30whfNi6mBvxgLEHmlIydap/PtAKTSskWfGvcJb2Nsl/I0qIFWd/63AdyJ2kEwk2UcOZLrDwjSXwkKJaqBxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsYf9VfYyzG53ozM7vsAYfMHOjtcUbJsPOpHqltMuTE=;
 b=LibiBhsm/VtWJhnY581ZoQHziZ6Tl2y9zj8+Ri0Mln+PrR6drOVeLxuIa2euzgbw2c3Vmvxa5RyUzKuVeH7bzxo8u3iKBnRd3/MfLtrHoZPGiZtHy4mQaAs1xoUStj8Ctz5iwIcrkNp26etkG6nHVEOYV60z1CgHa2oWJWEvLFblY8t6JiecsSJ8oJPizYLChyDb+6MYFt996PTvpQBnDoFGFjjzl6bo+t2PBS8eWAY1BqZpGkGVMp5Zx+5c36kHx62PkcJKYa4fBEizZl6Cs9esEaTAb6s8dczBVnFgFQU5WUrSWVZz2+Y42uVj8W/G3EKDSfKooaD8wFGCmzQBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsYf9VfYyzG53ozM7vsAYfMHOjtcUbJsPOpHqltMuTE=;
 b=hm69rapoqVvcoGFQLfebAylSsDax5jEPkGpQX92n28B/X5lpEevz1J2rS7Z/RBcZDN6tui+hTpR0/JanhClZCdnuYUTT60IbWIYpugGxJugV3rGtJlS/yg6VlzVDYkhv+2rUaloQpBBJRgTk5GnYDaBGRQlQAH3nEO+ygxFtZCI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Mon, 12 Jun 2023 07:39:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 07:39:16 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH V2 2/7] wifi: mac80211: Add support for ACPI WBRF
Thread-Topic: [PATCH V2 2/7] wifi: mac80211: Add support for ACPI WBRF
Thread-Index: AQHZmqQgcvaNXbLPmkaCrNwW18v2Z6+CIWsAgASavhA=
Date:   Mon, 12 Jun 2023 07:39:15 +0000
Message-ID: <DM6PR12MB26197BB35984260FAF2BAFD0E454A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230609072846.1552238-1-evan.quan@amd.com>
         <20230609072846.1552238-3-evan.quan@amd.com>
 <ccbaf80adb305ea59eb1a457460b99dc920bb65d.camel@sipsolutions.net>
In-Reply-To: <ccbaf80adb305ea59eb1a457460b99dc920bb65d.camel@sipsolutions.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Mario.Limonciello@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=242e5a5e-4ad3-4d4d-8d5f-32b8a23b115c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T06:40:05Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM4PR12MB5889:EE_
x-ms-office365-filtering-correlation-id: ef4cac66-1ea3-41fc-2c87-08db6b181fcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+Bfhr1ejjhjMa0+iRDZBmSOsSLdIobisLc9ApW5DQ5p86hg72cPVGipfEEJe7TwSspBaUaETjP0Rn+7yeSz0X9W79FQJbkmH1xnbfIy/Z3PUX2/zUAIHkthIUwlkeOErVRRTnfJ84Trvoh7b9YWBQn7Q5twhigX54PCbd+4QY1LZI247lUgCW3ne1gHc1z2xIZVimNnSe2+6cDudj4o6wN4PCZ1U8Ttd3o+++IQ8hxBwU4Zl46z6c/HLI/zwrT5k8FXE4Gx06Psj01bqKrhB8lz5WIzuosNylFyi9/GvtxS1GmZKCcQJPhYMYMj0751xCHSWdq+EaKHf5Ot9Fcf2LcLzKj3I4TrJttrsoj04G/5HaohZF9wI+axtM1PpxTHhSl0yDWUVsX4mfD/DvbTAHmdUuIqECW0rUvvrW9s5bJ0daI2qCmSBZiFxzEsQbGPcKcQjFaA2AJYetRPk7BD2R/5I7tfNqXSBxvSC65Ls8b2xaEloOBLBaLcnzuPlDVJxjP/TIFTQX/r5QVIqMipHKtts1kmkMIrtrkCckHOVyxPnmRzNsPTm36w9677mE9mYnsTQ5svu9FU4eRebZaatGsg27B4GuusAikXd+LdgcEnlUlTD9RCGBxYkv8+/HcwsrCvSYyJp++f3yzRr3TmFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(84040400005)(451199021)(66556008)(66946007)(76116006)(8936002)(8676002)(5660300002)(6636002)(4326008)(71200400001)(64756008)(66446008)(66476007)(54906003)(110136005)(52536014)(478600001)(7696005)(41300700001)(316002)(38100700002)(55016003)(921005)(122000001)(7416002)(53546011)(9686003)(6506007)(26005)(186003)(38070700005)(83380400001)(86362001)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZSR0VwUzZGdGFzK09aRUs5N28va1RYL2hZYUo2OU55cmdZYlJjY09Mc2Fl?=
 =?utf-8?B?MVVqRjgya1huUy9GdUJxVnJ6UGM3WDZNZFJIY09uVUxUYlZON1BGMnNKK09L?=
 =?utf-8?B?NkxqWG9LejdwSGlFblRCNUs3bzdSalFuNit3TEg4Mkx4bHBVbFhKbkh4cHdZ?=
 =?utf-8?B?dWJiUmREZnpSRHNiUFNHMnFNU3MyR1pQZlFMTjBSc3JIb0hmdERxK1dpanAz?=
 =?utf-8?B?NHd2MXRzZkpKRmNvUlpiRnRGV1UvZ3JTS3FNU2toVnE0aXoxNUdVM05KekMy?=
 =?utf-8?B?eGNzYkNjSnFFYUY3Z3pXTldkRzl1NWMvejdXbUZqL0paZU1jYXRzSzFWd3JT?=
 =?utf-8?B?SGJ4YUhYMWxNQW1qZWRYTDNoelR0d1VxSU5oZ1FMZ05lcWRvNnF3OG1KWHdN?=
 =?utf-8?B?dDFTYmM1MG5WZmV5TVduQStmU1BiR2VUNXJMS3VvcFJxMHNuaGtKSjdVazN5?=
 =?utf-8?B?SXk4dUZEanVCV3hHcmNhZGZsTlZmcUJvWXJnWUw1bytuekcrcGNzT0lTWUZU?=
 =?utf-8?B?L1NIZ1Y1UE9hMHZjYXQ5WS9Pd0tnTWlsaXJRMmMyTW1wNkVOZEQyUHNURVpU?=
 =?utf-8?B?SkhzKzh3Wm1mVFNWZjlGTWhqNEdQOTVrSU5sOUVGVXp3QnZiazhRNHYza2tq?=
 =?utf-8?B?eDJtUXpwd3dnVHpHM2cwZmxqTTRGaVlQcE9maU5tNFZIRDB1d2RLYUtkVW9p?=
 =?utf-8?B?YW9HeGJmbFdaVWl0Q2k4TjJiSmk0TWNrNjV1VmhEQ0JneW1PeU02NzhucFdP?=
 =?utf-8?B?VGo4T3BoL2p5amdtR0dILzNOY3p4U2p6WE0wWlRmbXZ4L0lncFhCOG55eFU0?=
 =?utf-8?B?NlQ3Wk1QbFVMZTZxVUtjS2d6eGF1STFraHZqc0VncFYxcmFkSkRqL2xocm5N?=
 =?utf-8?B?bUQwT3Ftb2hoYmFpSFovTWc3WnJnNm1TMVpvRm1BZk16L1Q0UnZoRVhLaEFG?=
 =?utf-8?B?b1VESmVtU1EyMWt3S0dUS3lZbEkxZWdUeStFaklrd29YQVNreVpSeVFhNGVp?=
 =?utf-8?B?T0l4ZXVISzJ1dHB6UllxQjVGcGhkR0lvQUpXVXhrbEtlUGhOK05TS2daUXp6?=
 =?utf-8?B?VXlocXhCRXZoQi9YNUZvcDZ4ei9iU0R5bFZuTEYrSzBJQmkwMU13NDcwUUpS?=
 =?utf-8?B?Tk9VK0FlSkhqVGhOUlN2UXNzOGNCWENVV0lINTNoSXlTWjBsZlM4Z014cE01?=
 =?utf-8?B?ZGVCa3JDcVQzby9wMUZKQmFxSnI4WjBHT1VraHkvbEg3QlR1VFhUY1AxSWh6?=
 =?utf-8?B?Q0VCTHlDNnl1QXlham5WRGZwS2ZwaDhhZ2pFTERyYVc3TzNrR3R4RW8zek9Q?=
 =?utf-8?B?c1VPdU0yTzl1YWw0TG83cFp2MHpXZGM3MlpmQnZvdTNRc2tUbHk4Nk5EVWZY?=
 =?utf-8?B?R085SFVmWlowTExHVUZWeDUvb3lPTXBFbnpqd2liQTVMQThsNUlUcE1mazdw?=
 =?utf-8?B?VjlDVHRGMFpvaU0xN1JBYkYvWTBhcHVGQlBtRjQ0ajVQYkVzU3BQNmRybWNT?=
 =?utf-8?B?RldqS2VvQTRub1VBa3U0TFlIQ0h5dXpZb1ZoVERjWjN3bmZCM0NHYWhsQXZT?=
 =?utf-8?B?a0lBWnlaVk8vTUJmajRwcVNUWitONWNVREJFaFpReEYzeHpLNit0a1dIZDM1?=
 =?utf-8?B?em1xWnpJTW1BNHlhQkYxS2hzUFJESzlOb2NMelFucmovR2lNRjlpeGQxaTFW?=
 =?utf-8?B?N3lzaTNkZ0hEaHk4S1IzaGxEWG5wNCtMamNTSzBsdHQ1V25ONzFOWWJvdXNz?=
 =?utf-8?B?emFIVnppSzY0SFpnRlA4TWJtQ1V0SVBPV1M5NDZWMGZqZjJQT2lYV1N1Tmw1?=
 =?utf-8?B?RUNYcUR1eUprY2ZreFZVQVZpUG9rQXFoa05hZGVDUWU0MXJlYUgxSWkwVWc4?=
 =?utf-8?B?L09nMUNGeG5WTXJwWWZkQ29RaEhsSUVuR0RHSDZQOElsZkRrTnZlQVdGMjJw?=
 =?utf-8?B?UWFwUTQ3eEoyTnpUYjRHcWZMMjlYZko3MzJSTzNLZVdyY3d2TjlULzJaWVpD?=
 =?utf-8?B?QlkyWGYwTkZidWFJbEtrb2t0Zk1LUE1LcmZkQzNBK09pYXJ6Nit1RGhyWjlF?=
 =?utf-8?B?aGlXaTBQTm1QR2RRNEdMQkdrOWJUU2htbTZGSTVVTXQ0a2tTZSthRXoyNDlE?=
 =?utf-8?Q?Gxg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4cac66-1ea3-41fc-2c87-08db6b181fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 07:39:15.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7zqWsDT69ino1qEDspCvwiOQIVZ7jAjuyfPCjFwjKlHonrWtEYmzfnDQgoSMt8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBKb2hhbm5lcy4gQ29t
bWVudCBpbi1saW5lDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9o
YW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogRnJpZGF5LCBK
dW5lIDksIDIwMjMgNDoyMSBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+
OyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47
DQo+IGFpcmxpZWRAZ21haWwuY29tOyBkYW5pZWxAZmZ3bGwuY2g7IGt2YWxvQGtlcm5lbC5vcmc7
IG5iZEBuYmQubmFtZTsNCj4gbG9yZW56b0BrZXJuZWwub3JnOyByeWRlci5sZWVAbWVkaWF0ZWsu
Y29tOyBzaGF5bmUuY2hlbkBtZWRpYXRlay5jb207DQo+IHNlYW4ud2FuZ0BtZWRpYXRlay5jb207
IG1hdHRoaWFzLmJnZ0BnbWFpbC5jb207DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29s
bGFib3JhLmNvbTsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBhbWQtDQo+IGdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWMiAyLzddIHdpZmk6IG1hYzgwMjExOiBBZGQgc3VwcG9ydCBmb3IgQUNQSSBXQlJGDQo+DQo+
IE9uIEZyaSwgMjAyMy0wNi0wOSBhdCAxNToyOCArMDgwMCwgRXZhbiBRdWFuIHdyb3RlOg0KPg0K
PiA+IC0tLSBhL2luY2x1ZGUvbmV0L2NmZzgwMjExLmgNCj4gPiArKysgYi9pbmNsdWRlL25ldC9j
Zmc4MDIxMS5oDQo+ID4gQEAgLTU1NTEsNiArNTU1MSwxMCBAQCBzdHJ1Y3Qgd2lwaHkgew0KPiA+
DQo+ID4gICAgIHUxNiBod190aW1lc3RhbXBfbWF4X3BlZXJzOw0KPiA+DQo+ID4gKyNpZmRlZiBD
T05GSUdfQUNQSV9XQlJGDQo+ID4gKyAgIGJvb2wgd2JyZl9zdXBwb3J0ZWQ7DQo+ID4gKyNlbmRp
Zg0KPg0KPiBUaGlzIHNob3VsZCBiZSBpbiBzb21lIHByaXZhdGUgc3RydWN0IGluIG1hYzgwMjEx
LCBpZWVlODAyMTFfbG9jYWwgSSB0aGluay4NClRoZXJlIHdhcyBpbmRlZWQgYSBwcm9wb3NhbCBm
cm9tIE1hcmlvIHRvIHB1dCB0aGlzIGluIGllZWU4MDIxMV9sb2NhbC4NCkJ1dCBJIHRob3VnaHQg
IndicmZfc3VwcG9ydGVkIiBzdGFuZHMgZm9yIGEgZGV2aWNlIHNwZWNpZmljIGZlYXR1cmUgYW5k
ICJzdHJ1Y3Qgd2lwaHkiIHNlZW1lZCB0aGUgcmlnaHQgcGxhY2UuDQpBbnl3YXkgSSBjYW4gdXBk
YXRlIHRoaXMgYXMgc3VnZ2VzdGVkLg0KPg0KPiA+ICAgICBjaGFyIHByaXZbXSBfX2FsaWduZWQo
TkVUREVWX0FMSUdOKTsgIH07DQo+ID4NCj4gPiBAQCAtOTA2Nyw0ICs5MDcxLDE4IEBAIHN0YXRp
YyBpbmxpbmUgaW50DQo+ID4gY2ZnODAyMTFfY29sb3JfY2hhbmdlX25vdGlmeShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KSAgYm9vbA0KPiBjZmc4MDIxMV92YWxpZF9kaXNhYmxlX3N1YmNoYW5uZWxf
Yml0bWFwKHUxNiAqYml0bWFwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IHN0cnVjdCBjZmc4MDIxMV9jaGFuX2RlZg0KPiAqY2hhbmRlZik7DQo+
ID4NCj4gPiArI2lmZGVmIENPTkZJR19BQ1BJX1dCUkYNCj4gPiArdm9pZCBpZWVlODAyMTFfY2hl
Y2tfd2JyZl9zdXBwb3J0KHN0cnVjdCB3aXBoeSAqd2lwaHkpOyBpbnQNCj4gPiAraWVlZTgwMjEx
X2FkZF93YnJmKHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ID4gKyAgICAgICAgICAgICAgICAgIHN0
cnVjdCBjZmc4MDIxMV9jaGFuX2RlZiAqY2hhbmRlZik7IHZvaWQNCj4gPiAraWVlZTgwMjExX3Jl
bW92ZV93YnJmKHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgY2ZnODAyMTFfY2hhbl9kZWYgKmNoYW5kZWYpOyAjZWxzZSBzdGF0aWMNCj4gaW5s
aW5lIHZvaWQNCj4gPiAraWVlZTgwMjExX2NoZWNrX3dicmZfc3VwcG9ydChzdHJ1Y3Qgd2lwaHkg
KndpcGh5KSB7IH0gc3RhdGljIGlubGluZQ0KPiA+ICtpbnQgaWVlZTgwMjExX2FkZF93YnJmKHN0
cnVjdCB3aXBoeSAqd2lwaHksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGNmZzgwMjExX2NoYW5fZGVmICpjaGFuZGVmKQ0KPiB7IHJldHVybiAwOyB9IHN0YXRp
Yw0KPiA+ICtpbmxpbmUgdm9pZCBpZWVlODAyMTFfcmVtb3ZlX3dicmYoc3RydWN0IHdpcGh5ICp3
aXBoeSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGNm
ZzgwMjExX2NoYW5fZGVmICpjaGFuZGVmKQ0KPiB7IH0gI2VuZGlmIC8qDQo+ID4gK0NPTkZJR19B
Q1BJX1dCUkYgKi8NCj4NCj4gU2FtZSBoZXJlLCBub3QgdGhlIHJpZ2h0IHBsYWNlLiBUaGlzIHNo
b3VsZCBldmVuIGJlIGluIGFuIGludGVybmFsDQo+IG1hYzgwMjExIGhlYWRlciAoc3VjaCBhcyBu
ZXQvbWFjODAyMTEvaWVlZTgwMjExX2kuaCBvciBjcmVhdGUgYSBuZXcNCj4gbmV0L21hYzgwMjEx
L3dyYmYuaCBvciBzbyBpZiB5b3UgcHJlZmVyLikNCldpbGwgdXBkYXRlIHRoaXMgYWx0b2dldGhl
ci4NCj4NCj4NCj4gPiAtLS0gYS9uZXQvbWFjODAyMTEvY2hhbi5jDQo+ID4gKysrIGIvbmV0L21h
YzgwMjExL2NoYW4uYw0KPiA+IEBAIC02NjgsNiArNjY4LDEwIEBAIHN0YXRpYyBpbnQgaWVlZTgw
MjExX2FkZF9jaGFuY3R4KHN0cnVjdA0KPiBpZWVlODAyMTFfbG9jYWwgKmxvY2FsLA0KPiA+ICAg
ICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZsb2NhbC0+bXR4KTsNCj4gPiAgICAgbG9ja2RlcF9hc3Nl
cnRfaGVsZCgmbG9jYWwtPmNoYW5jdHhfbXR4KTsNCj4gPg0KPiA+ICsgICBlcnIgPSBpZWVlODAy
MTFfYWRkX3dicmYobG9jYWwtPmh3LndpcGh5LCAmY3R4LT5jb25mLmRlZik7DQo+ID4gKyAgIGlm
IChlcnIpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gICAgIGlmICgh
bG9jYWwtPnVzZV9jaGFuY3R4KQ0KPiA+ICAgICAgICAgICAgIGxvY2FsLT5ody5jb25mLnJhZGFy
X2VuYWJsZWQgPSBjdHgtPmNvbmYucmFkYXJfZW5hYmxlZDsNCj4gPg0KPiA+IEBAIC03NDgsNiAr
NzUyLDggQEAgc3RhdGljIHZvaWQgaWVlZTgwMjExX2RlbF9jaGFuY3R4KHN0cnVjdA0KPiBpZWVl
ODAyMTFfbG9jYWwgKmxvY2FsLA0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgaWVlZTgwMjExX3Jl
Y2FsY19pZGxlKGxvY2FsKTsNCj4gPiArDQo+ID4gKyAgIGllZWU4MDIxMV9yZW1vdmVfd2JyZihs
b2NhbC0+aHcud2lwaHksICZjdHgtPmNvbmYuZGVmKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRp
YyB2b2lkIGllZWU4MDIxMV9mcmVlX2NoYW5jdHgoc3RydWN0IGllZWU4MDIxMV9sb2NhbCAqbG9j
YWwsDQo+ID4NCj4NCj4gVGhpcyBpcyB0cmlja3ksIGFuZCBxdWl0ZSBsaWtlbHkgaW5jb3JyZWN0
Lg0KPg0KPiBGaXJzdCBvZiBhbGwsIGNoYW5kZWZzIGNhbiBhY3R1YWxseSBfY2hhbmdlXywgc2Vl
IF9pZWVlODAyMTFfY2hhbmdlX2NoYW5jdHgoKS4NCj4gWW91J2QgcHJvYmFibHkgaGF2ZSB0byBj
YWxsIHRoaXMgYWRkL3JlbW92ZSAob3IgaGF2ZSBtb2RpZnkpIHdoZW5ldmVyIHdlDQo+IGNhbGwg
ZHJ2X2NoYW5nZV9jaGFuY3R4KCkgdG8gY2hhbmdlIHRoZSB3aWR0aCAobm90IGlmIHJhZGFyL3J4
IGNoYWlucyBjaGFuZ2UpLg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4gVW5mb3J0dW5h
dGVseSBJIGhhdmUgbGltaXQga25vd2xlZGdlIGFib3V0IG5ldHdvcmsgcmVsYXRlZC4NCkNhbiB5
b3UgaGVscCBtZSB0byBsaXN0IGFsbCB0aG9zZSBBUElzPyBBbnkgb3RoZXJzIGV4Y2VwdCB0aGUg
Zm91ciBiZWxvdz8NCl9pZWVlODAyMTFfY2hhbmdlX2NoYW5jdHgNCmllZWU4MDIxMV9yZWNhbGNf
Y2hhbmN0eF9taW5fZGVmICAoSnVzdCBjdXJpb3VzIHdoeSAiIWxvY2FsLT51c2VfY2hhbmN0eCIg
aXMgbm90IGNvdmVyIGluIHRoaXMgQVBJIGxpa2Ugb3RoZXJzPykNCmllZWU4MDIxMV9yZWNhbGNf
cmFkYXJfY2hhbmN0eCAgKGRvIHlvdSBtZWFuIHRoaXMgb25lIGNhbiBiZSBpZ25vcmVkID8pDQpp
ZWVlODAyMTFfcmVjYWxjX3NtcHNfY2hhbmN0eA0KPg0KPiBTZWNvbmRseSwgeW91IGRvbid0IGtu
b3cgaWYgdGhlIGRyaXZlciB3aWxsIGFjdHVhbGx5IHVzZSBjdHgtPmNvbmYuZGVmLCBvciBjdHgt
DQo+ID5jb25mLm1pbmRlZi4gRm9yIGNsaWVudCBtb2RlIHRoYXQgZG9lc24ndCBtYXR0ZXIsIGJ1
dCBmb3IgQVAgbW9kZSBpZiB0aGUgQVAgaXMNCj4gY29uZmlndXJlZCB0byBzYXkgMTYwIE1Ieiwg
aXQgbWlnaHQgYWN0dWFsbHkgY29uZmlndXJlIGRvd24gdG8gMjAgTUh6IHdoZW4NCj4gbm8gc3Rh
dGlvbnMgYXJlIGNvbm5lY3RlZCAob3Igb25seSAyMCBNSHogc3RhdGlvbnMgYXJlKS4gSSBkb24n
dCBrbm93IGlmIHlvdQ0KPiByZWFsbHkgY2FyZSBhYm91dCB0YWtpbmcgdGhhdCBpbnRvIGFjY291
bnQsIEkgYWxzbyBkb24ndCBrbm93IGhvdyBkeW5hbWljIHRoaXMNCj4gcmVhbGx5IHNob3VsZCBi
ZS4gU3RhdGlvbnMgY2FuIGNvbm5lY3QgYW5kIGRpc2Nvbm5lY3QgcXVpY2tseSwgc28gcGVyaGFw
cyB0aGUNCj4gV0JSRiBzaG91bGQgYWN0dWFsbHkgdGFrZSB0aGUgZnVsbCBwb3RlbnRpYWwgYmFu
ZHdpZHRoIGludG8gYWNjb3VudCBhbGwgdGhlDQo+IHRpbWUsIGluIHdoaWNoIGNhc2UgdGFraW5n
DQo+IGN0eC0+Y29uZi5kZWYgd291bGQgYmUgY29ycmVjdC4NCk9LLiBJZiB3ZSBjYW5ub3QgZmln
dXJlIG91dCB3aGF0J3MgdGhlIGV4YWN0IGJhbmR3aWR0aCBpbiB1c2UgZm9yIEFQLCBJIGFzc3Vt
ZSB1c2luZyBjdHgtPmNvbmYuZGVmIHNob3VsZCBiZSBPSy4NCkBMaW1vbmNpZWxsbywgTWFyaW8g
d2hhdCdzIHlvdXIgb3Bpbmlvbj8NCj4NCj4gSSdsbCBub3RlIHRoYXQgeW91ciBwcmV2aW91cyBp
bi1kcml2ZXIgYXBwcm9hY2ggaGFkIGFsbCB0aGUgc2FtZSBwcm9ibGVtcyB0aGUNCj4gd2F5IHlv
dSBoYWQgaW1wbGVtZW50ZWQgaXQsIHRob3VnaCBJIGRvbid0IGtub3cgaWYgdGhhdCBkcml2ZXIg
ZXZlciBjYW4gdXNlDQo+IG1pbmRlZiBvciBub3QuDQo+DQo+DQo+ID4gK3ZvaWQgaWVlZTgwMjEx
X2NoZWNrX3dicmZfc3VwcG9ydChzdHJ1Y3Qgd2lwaHkgKndpcGh5KSB7DQo+ID4gKyAgIHN0cnVj
dCBkZXZpY2UgKmRldiA9IHdpcGh5LT5kZXYucGFyZW50Ow0KPiA+ICsgICBzdHJ1Y3QgYWNwaV9k
ZXZpY2UgKmFjcGlfZGV2Ow0KPiA+ICsNCj4gPiArICAgYWNwaV9kZXYgPSBBQ1BJX0NPTVBBTklP
TihkZXYpOw0KPg0KPiBDYW4gdGhpcyBjb3BlIHdpdGggJ2RldicgYmVpbmcgTlVMTD8gSnVzdCBu
b3Qgc3VyZSBub3RoaW5nIGxpa2UgaHdzaW0gb3Igc28NCj4gYWx3YXlzIGV2ZW4gaGFzIGEgcGFy
ZW50LiBJIGd1ZXNzIGl0IHNob3VsZCwgYnV0IC4uLg0KT0ssIEkgc2VlLiBJIHdpbGwgYWRkIGlu
cHV0IGNoZWNrcyBmb3IgdW5leHBlY3RlZCBOVUxMLg0KPg0KPiA+ICtzdGF0aWMgaW50IGNoYW5f
d2lkdGhfdG9fbWh6KGVudW0gbmw4MDIxMV9jaGFuX3dpZHRoIGNoYW5fd2lkdGgpIHsNCj4gPiAr
ICAgaW50IG1oejsNCj4gPiArDQo+ID4gKyAgIHN3aXRjaCAoY2hhbl93aWR0aCkgew0KPiA+ICsg
ICBjYXNlIE5MODAyMTFfQ0hBTl9XSURUSF8xOg0KPiA+ICsgICAgICAgICAgIG1oeiA9IDE7DQo+
ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIGNhc2UgTkw4MDIxMV9DSEFOX1dJRFRIXzI6
DQo+ID4gKyAgICAgICAgICAgbWh6ID0gMjsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiAr
ICAgY2FzZSBOTDgwMjExX0NIQU5fV0lEVEhfNDoNCj4gPiArICAgICAgICAgICBtaHogPSA0Ow0K
PiA+ICsgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICBjYXNlIE5MODAyMTFfQ0hBTl9XSURUSF84
Og0KPiA+ICsgICAgICAgICAgIG1oeiA9IDg7DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4g
KyAgIGNhc2UgTkw4MDIxMV9DSEFOX1dJRFRIXzE2Og0KPiA+ICsgICAgICAgICAgIG1oeiA9IDE2
Ow0KPiA+ICsgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICBjYXNlIE5MODAyMTFfQ0hBTl9XSURU
SF81Og0KPiA+ICsgICAgICAgICAgIG1oeiA9IDU7DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgIGNhc2UgTkw4MDIxMV9DSEFOX1dJRFRIXzEwOg0KPiA+ICsgICAgICAgICAgIG1oeiA9
IDEwOw0KPiA+ICsgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICBjYXNlIE5MODAyMTFfQ0hBTl9X
SURUSF8yMDoNCj4gPiArICAgY2FzZSBOTDgwMjExX0NIQU5fV0lEVEhfMjBfTk9IVDoNCj4gPiAr
ICAgICAgICAgICBtaHogPSAyMDsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArICAgY2Fz
ZSBOTDgwMjExX0NIQU5fV0lEVEhfNDA6DQo+ID4gKyAgICAgICAgICAgbWh6ID0gNDA7DQo+ID4g
KyAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIGNhc2UgTkw4MDIxMV9DSEFOX1dJRFRIXzgwUDgw
Og0KPiA+ICsgICBjYXNlIE5MODAyMTFfQ0hBTl9XSURUSF84MDoNCj4gPiArICAgICAgICAgICBt
aHogPSA4MDsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArICAgY2FzZSBOTDgwMjExX0NI
QU5fV0lEVEhfMTYwOg0KPiA+ICsgICAgICAgICAgIG1oeiA9IDE2MDsNCj4gPiArICAgICAgICAg
ICBicmVhazsNCj4gPiArICAgY2FzZSBOTDgwMjExX0NIQU5fV0lEVEhfMzIwOg0KPiA+ICsgICAg
ICAgICAgIG1oeiA9IDMyMDsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArICAgZGVmYXVs
dDoNCj4gPiArICAgICAgICAgICBXQVJOX09OX09OQ0UoMSk7DQo+ID4gKyAgICAgICAgICAgcmV0
dXJuIC0xOw0KPiA+ICsgICB9DQo+ID4gKyAgIHJldHVybiBtaHo7DQo+DQo+IFRoaXMgbWlnaHQg
YmUgbW9yZSBnZW5lcmFsbHkgdXNlZnVsIGFzIGEgZnVuY3Rpb24gaW4gY2ZnODAyMTEgdGhhdCdz
IGV4cG9ydGVkIC0NCj4gaHdzaW0gaGFzIGV4YWN0bHkgdGhlIHNhbWUgZnVuY3Rpb24gdG9kYXks
IGZvciBleGFtcGxlLg0KWWVzLCB0aGlzIHNoYXJlcyBleGFjdGx5IHRoZSBzYW1lIGltcGxlbWVu
dGF0aW9uIGFzIG5sODAyMTFfY2hhbl93aWR0aF90b19taHouDQpMZXQgbWUgZ2V0IG5sODAyMTFf
Y2hhbl93aWR0aF90b19taHogZXhwb3NlZCBzbyB0aGF0IG90aGVyIHBhcnRzIGNhbiBzaGFyZS4N
Cj4NCj4gPiArc3RhdGljIHZvaWQgZ2V0X2NoYW5fZnJlcV9ib3VuZGFyeSh1MzIgY2VudGVyX2Zy
ZXEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBiYW5kd2lkdGgsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCAqc3RhcnQsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCAqZW5kKQ0KPiA+ICt7DQo+ID4gKyAgIGJhbmR3
aWR0aCA9IE1IWl9UT19LSFooYmFuZHdpZHRoKTsNCj4gPiArICAgY2VudGVyX2ZyZXEgPSBNSFpf
VE9fS0haKGNlbnRlcl9mcmVxKTsNCj4gPiArDQo+ID4gKyAgICpzdGFydCA9IGNlbnRlcl9mcmVx
IC0gYmFuZHdpZHRoIC8gMjsNCj4gPiArICAgKmVuZCA9IGNlbnRlcl9mcmVxICsgYmFuZHdpZHRo
IC8gMjsNCj4gPiArDQo+ID4gKyAgIC8qIEZyZXF1ZW5jeSBpbiBIWiBpcyBleHBlY3RlZCAqLw0K
PiA+ICsgICAqc3RhcnQgPSBLSFpfVE9fSFooKnN0YXJ0KTsNCj4gPiArICAgKmVuZCA9IEtIWl9U
T19IWigqZW5kKTsNCj4gPiArfQ0KPg0KPiBTaW1pbGFyIHBhdHRlcm5zIGFyZSBwcm9iYWJseSBl
bHNld2hlcmUgdG9vIGZvciB0aGlzLCBidXQgSSBndWVzcyB3ZSBjYW4gYWx3YXlzDQo+IHJlZmFj
dG9yIGxhdGVyIHRvby4NCkkgZGlkIGNoZWNrIHRoaXMgYmVmb3JlIGFuZCBJIGRpZCBub3QgZmlu
ZCBzaW1pbGFyIHBhdHRlcm5zIGluIG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwuIEFsdGhvdWdo
IHNvbWUgb2YgdGhlbSBjYW4gcHJvdmlkZSB0aGUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGNlbnRl
ciBmcmVxdWVuY3kgcG9pbnQgKGUuZy4gY29udHJvbF9mcmVxLyBvcGVyX2ZyZXEpLiBOb25lIG9m
IHRoZW0gY2FuIGJlIHVzZWQgdG8gdGVsbCB0aGUgZnJlcXVlbmN5IG9mIHRoZSBzdGFydC9lbmQg
cG9pbnQgb2YgdGhlIHJhbmdlLiBBbnl3YXksIHllcywgd2UgY2FuIHJlZmFjdG9yIHRoaXMgbGF0
ZXIgaWYgd2Ugc2VlIHN1Y2ggbmVlZC4NCg0KRXZhbg0KPg0KPiBqb2hhbm5lcw0K
