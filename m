Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F735532A0B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiEXMFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiEXMFu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 08:05:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C1E64BCA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653393943; x=1684929943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ie4TQBCk/veRgEextKnZuC4E+bfp4iwm+yU3vMnUllo=;
  b=xcPR2HXJRDo5ZswcTtJt1p8PBSdlwMKss9mB1aG7k4pYix4HH9zrWIvN
   W8VEdMF38ed2ralh5R7qAHm3l57aCnUPv6C+qb6y3z6MzrQWYK0+e79k9
   JIW3O9xdTm/knIyxnVReQWjQb4s3UJ3Da4tVInUlteVm/qiAfkD7ITpQJ
   eMnF5eKD8Xb2xhTviLMWeBIBCRZNVI8mrTf9owWcw++3FOuZ9+Lwo6YUZ
   W5FQITxMYllY6SuB3L7u+b2UWl1VNaN3FVhA5EhNZ4Q0+Ak+6of39UnS0
   lnxMNYW5R9385qA4y7nFS1gG24w2jR2jlNEk8fhFZcvIvQ3ZKrC7+RpEo
   A==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="165080849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2022 05:05:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 24 May 2022 05:05:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 24 May 2022 05:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obfOlUonCKiyClg+muDKZ61RkxZRtRTEcVNPfC0N611zc6qcEs2hLWWIlGDlHuKpbmiEMe8+Lm66wVyg+phg3qiEta/uqD3up+wb7Cj/a3AujCby3FnnWZq1R2pLas5BuXNv5vIjN0CuUGAaJ9wbTtxcO4/RmPVoDliCFMZF1BIvV0+qauntdfZq0X+HS9MCwFaDGtcWWzQoxUCSBkZW3wXfcaMqfiIAMd0jM33LTLBLCw2FzDKl17I0fI4MCpmmvi+ikgPY71b5pMb84VmAdZ9kOuaul2/O8CWNyK4NSHRFIk3aFYKR84j/1cIrITtnn0TWujYxPktErw2zCtKu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie4TQBCk/veRgEextKnZuC4E+bfp4iwm+yU3vMnUllo=;
 b=TUwXYgh3749Um3EfGgpMP0/9NWCpAK1slojJuWFsF3NyUIAO7RWGnPFeUVWWsk6kk9UwZUq1+7T9BMYCqgcoeG3MG8Z2uV8dIA9ubs3bc+xrdMY+A/JAq4M+D3nt6h1ryTfVavYbpNaEganV2MXdZAd5PXM8yaqzZffVdv8QP0FS2D6+VI2j/B3ZJrvTy+tejGxlw+LoRr3w6gKE4Br2DkTiQak11gUO/YtYHy1EoP6eS8SWEriom4x8VlbCSlvzwua4pp5irT1L3oujRCxpNrjAF/JYTGiYbxKJYmOivJPtBwTqFJ3JWjDr7g8Wlcwh42WaFMYRUjtbY5V8XyH6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie4TQBCk/veRgEextKnZuC4E+bfp4iwm+yU3vMnUllo=;
 b=pvVoQN4cJn3AqCbfczglwhq9FMn0MooDnQd6HJUjcQbCG2mzr6G2dqmLZYFl/C0IwTnahiPPQBHONqddVaIl5CMyNIgqJX+xhMTfifjan9YqZLsaVvhNhgZ2/jHd6Y1HPrpajl+B5+/wz/eApUOsMOlOq6GbDMaRDXVyKK+tTz8=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:05:37 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:05:37 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <linux-wireless@vger.kernel.org>
CC:     <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH v2 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Topic: [PATCH v2 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Index: AQHYbq6p2rJ8Qd5opkWdRD9tXlXgEK0trb8AgABCCgA=
Date:   Tue, 24 May 2022 12:05:36 +0000
Message-ID: <8f4c9505-5a14-3fd5-8a85-c29e71ef6962@microchip.com>
References: <20220523140812.164028-1-ajay.kathat@microchip.com>
 <23630392-50ac-5588-8fdb-5e8950acb357@microchip.com>
In-Reply-To: <23630392-50ac-5588-8fdb-5e8950acb357@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27581f3d-e696-4a11-6827-08da3d7db695
x-ms-traffictypediagnostic: CH0PR11MB5412:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5412E9A0AA96322121F55165E3D79@CH0PR11MB5412.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtsrQ7Vg2u8Bs2I6hyXucZHG/MWmKuRtjlcjBofzalmGX0YAMbv95I6u25AQhpN0SusVBUT+cGsjJI2FrZ9zllQl4OY90f/nv1otne5fAjEvQKwH1T72Fx9LSmDUtcMEvX8V/I+mAu/EhMEoBTF7UQhC5DeSgzsnXwCIyZqfXz+MkCf+E9BDGGMMlhVQ7lWk5eCejI5Ds/F3WCmSGZ0udJpPNeEPnaMQxe20sQnqYCYeVkTb4r7mScAFF91QdmcazEAZSZxUlcmyWGr1x1nMyt5Tu0kubsnhXhA6HYONL3wL+p5Nowvvk1MlrGiiVeXj3AIy7Cshdb6zMzMP9UP35wZVNHg3B7x7lEbCjYURnNn8Q2YtZi5OufFsWks7wKSFPu/+BrFYA3fnbF67nMbZ9WKJKVgcP7VY64aFPBf2bLGbJOu4J+a8pJunYPPIN9g7lW2F4wA+LLD2I2NhWm+ZatZkI1oQs+enfvr35SiC7pOT7lsDhP1NbrIHd52xYWX/tIqwJJGK4+dT+EsVmDc+sTo9z0Hnfp0gD6YVCjqPqYIg+0BPgXa0C3kfO+jrl4jDsazmu8mxrq2Mz08x2P5Bnavjax+ufeTcQSsckv5GcxMCvZ+gZTPwB/WYs3GO1IPJTUR8jJczQL/F3vRDrB1OZFh+Pm92TAZl4d4qXvw14wiN3nNwUlWezl7st0lJVcjvmr0MfSuVjKWsQkEQkUp605/V8fMDBqFOW6UqVbChRV2EaQU1zmm8HW0BV27BCLpoJqBzTbz64gdz4O0pcTaEaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4744005)(8936002)(2616005)(6486002)(5660300002)(86362001)(508600001)(31696002)(26005)(107886003)(31686004)(38100700002)(110136005)(38070700005)(36756003)(316002)(122000001)(8676002)(4326008)(6512007)(66946007)(66476007)(6506007)(186003)(66446008)(76116006)(91956017)(64756008)(71200400001)(66556008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUw1TW1Ub2NHMzM4OEdDWkI5cXRia3NWekVUYjhOZVpOT3JIcHJvZ2MrOHlk?=
 =?utf-8?B?ZFZzUGlLTUpXUjd0TWhqUFdndFVmWHlaanFCb1A1dXB3WjhhNFBWRi9udTlr?=
 =?utf-8?B?MkJXS1hBMUJ1eDNNb3NOZmwva3Yxak5pb1VBNERpK01aR2VMVzZxTGdORW5W?=
 =?utf-8?B?T0NsUjd0cDFtS2xXMm1oZWVFUVNVRTdiRS9ONWRGMVZzS29LSG1uSkNzYmRF?=
 =?utf-8?B?NG1HNHdMTUNGcmdlTlFrL0R0dXd2c3pGN2NDYTVlUng3YmNydUhjdGEvNmVK?=
 =?utf-8?B?em9DbXhPSE1hNDZBYmc4WWE0OE1HaVNBbTlxR3BTTGE4cFQrczlWTnd6UjRv?=
 =?utf-8?B?VnVIOVVZUVh0N2tac3JweGorbmNQSXV3U0ZOVFkvcXUwczA5WUtTYmdXVExW?=
 =?utf-8?B?YVZtSzhPVGNZNHBRZWxtTkhVeU9QZ2kvczB2STJPNUtIZk9VeGZrWjRLa0JV?=
 =?utf-8?B?c3d6NVo2VDZXS0VWTjZueHhGN3ZLcGJNbFFmSTJVdm1vOFI2QkM0bW1WVy9w?=
 =?utf-8?B?SnB0YXVyOEhET3lsMVZTUDFSVzNQZS81dlpMN1dYS2xuQUNwbU51TjdPbmhV?=
 =?utf-8?B?bGlZaXkxWHBydkx4T3pad09jYzFoQjZVU3k3ZVFmQ2prQzVyZXBLRGhteG11?=
 =?utf-8?B?WlhsZ1Baa08xLzhZSUVramgxeE0rNjJoNGVGaUVKV1pxa3RnbTNoZGUzYlQ3?=
 =?utf-8?B?NXlxeVZBWFoxU3R4aHZPRGxpSXZUMHh5cFFVY1NNZlA3bFhFZmZkTHZEUXpw?=
 =?utf-8?B?d1NldFpGOWM2NWh0SHBVQzlXeG95R2dzWEk2YWJHT3VPYUJ5VzM2YUM4RWxn?=
 =?utf-8?B?UFVhZE1nR09oRWVwQVJBY2dKbTgwMjJEeDdkc28zRDZHM1NCcTZOMWhxM2dC?=
 =?utf-8?B?UlhuTzEzYVh1eVZQS05vL1JKSkRzcGYrZmh6MjArcEFoYllzRW5XVmk5SnNJ?=
 =?utf-8?B?NlhxMWhxRjBTaDg0ZFJXZ3IvOWRjRVZoUjQvUXlPQjJ3YnVBdW01YStmMXV2?=
 =?utf-8?B?S3p0UU1qYStTanlyYi92THlQMG1ldDVnTlEySThveS9XQTRaalphN0VZellQ?=
 =?utf-8?B?eVhPUURkTDNFa3pRaWkxY0VtUGNTbGttT1NOVkxFOEkwSkpZdkZRRkJvOUsr?=
 =?utf-8?B?dlV0QUJxa2dtbXNQcmN0K3pBb2JPMHZlUGJiUzRMdlVabjJUMTY0MmhvSHlU?=
 =?utf-8?B?SG5sSFFMTGtEcStReWxXK0FwczJOVnczbTdiVllHc3JEWVFtcGVDbHRRbGtT?=
 =?utf-8?B?UEZ6eEhxM3JxYS9vVCtQNUxRRy9VUWU1RTNHTHlhSVhocU93UHNDQWgvR2tB?=
 =?utf-8?B?YUtGc25kVythTkRyR2lZcmpHVVVlZktveE52SFgwOVdGazg5N2JxM0o1NFhW?=
 =?utf-8?B?K0ZWZElKT1h6c0cxb0lzRUgvenZuVlM4ZmtUejlLTHpFbmppbnY0MkIrRndu?=
 =?utf-8?B?cTZFNkZkUGVvZkd1M2JCRnltYTlPdzhlSHBpTW8vaEdPcEp5SGNFSEFMQ2ZE?=
 =?utf-8?B?Uk52MDhVaDdGREZSZlpQL1FiUkNZQzgzYWZXd2J0ZXZscGEvMm95Mko3U3Na?=
 =?utf-8?B?NDZ4UDNGTklhZTVwQUV3STB2VXNpakdSNkNGcHk0VDRuZEV2YVFBRUE5MmMx?=
 =?utf-8?B?Mlg5RXdLbEZudVdBcTE5aE5NOHZ1Q0lBQmEwdENlWjZuRlVmZkpKZG4rdWJF?=
 =?utf-8?B?dHJYNkZLQ2dmQ2hBOVlGQ29ZRk02YThYblJqRmhaM3ZTY3Fuazg3eEl6LzBN?=
 =?utf-8?B?RjhQaWZNZDQwNEVWVzFoZy8xZzg0YWsvaWoweGFwQnVVS05CUFM0TFZLak8x?=
 =?utf-8?B?cS84KzNlRUoyTUJEWUw5MEJBWjhkSytqeklIUHMxVjNtekt2bkJIMXBmVFcy?=
 =?utf-8?B?YWpqZ0ZKVm5hQ1RLaTNNdnhYWjdtU3N0bXAvU0kyS3E5MUorYWprU2NBQnBp?=
 =?utf-8?B?bmpYK3hTdEE3Y1VBclEzbUZxOUhUa0lGbEJqT3FicnkvSWFlODIvOXRVcExp?=
 =?utf-8?B?WXFJL2FPQzB2aVcwTkJVNmtISUJWU2xDNXpia2RTc25mVVlyNktKUUtMV2ZU?=
 =?utf-8?B?aUZ3T09uUDBQZ0ZPaEtkMUZMaFA2MkNyRnAwMnR6TEdWaTNYSGVWU1FKQW8r?=
 =?utf-8?B?ZFo0aDJQZFo1K3V2Q0xqMi9JckFPTENqcDluWTlaNVlrQ1VraTZIdytLUTNq?=
 =?utf-8?B?SzlrQWJKNkdhU3pUQ2xCdG90UHpYUFI1YnBwTERlT0hhTFIzNU5SbVZmeE14?=
 =?utf-8?B?V25vSnZWMGRWdnhFN2N4SW4vRXErZUh6SER4WitlSDdSdEM5TGI5UnNVc045?=
 =?utf-8?B?aVdqT1BVckFEcjN5SEZRRmRTb2pzaFk2clBxZE9ydjBsU1E0ZjNPVFJPZUtu?=
 =?utf-8?Q?uVPD7QNNQefmAD4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32DFF34C2304C04AB52E3866C0DA4430@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27581f3d-e696-4a11-6827-08da3d7db695
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:05:36.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XoOl90yvdnomn6lzrw4DVvw3uCI/2cQg12CR/gBPiarRzKJdpcgGcDErfL5At9t7pjvQD9wUr4ImqOZeDUnKf+tCGemSTnBSXd7f8Ec9JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5412
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMjQvMDUvMjIgMTM6MzksIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPiBIaSwg
QWpheSwNCj4NCj4gT24gMjMuMDUuMjAyMiAxNzowOSwgQWpheSBLYXRoYXQgLSBJMTU0ODEgd3Jv
dGU6DQo+PiBGcm9tOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPj4N
Cj4+IEZvciBwb3dlci11cCBzZXF1ZW5jZSwgV0lMQyBleHBlY3RzIFJFU0VUIHNldCB0byBoaWdo
IDVtcyBhZnRlciBtYWtpbmcNCj4+IGNoaXBfZW4oZW5hYmxlKSBzbyBjb3JyZWN0ZWQgY2hpcCBw
b3dlci11cCBzZXF1ZW5jZSBieSBtYWtpbmcgUkVTRVQgaGlnaC4NCj4+IEZvciBQb3dlci1Eb3du
IHNlcXVlbmNlLCB0aGUgY29ycmVjdCBzZXF1ZW5jZSBtYWtlIFJFU0VUIGFuZCBDSElQX0VOIGxv
dw0KPj4gd2l0aG91dCBhbnkgZXh0cmEgZGVsYXkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWph
eSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4gRG9lcyB0aGlzIG5lZWQgYSBm
aXhlcyB0YWc/DQoNCg0KWWVzLCBJIHdpbGwgYWRkIHRoZSBGaXhlcyB0YWcgYW5kIHNlbmQgdGhl
IHYzIHNlcmllcy4NCg0KDQpSZWdhcmRzLA0KQWpheQ0KDQo=
