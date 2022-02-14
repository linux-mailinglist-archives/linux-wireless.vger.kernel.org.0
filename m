Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295F54B556F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiBNP4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 10:56:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiBNP4F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 10:56:05 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF34C4968F
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644854155; x=1645458955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dVJ0FutEggDKi8QWp6hnHrgyf8KoZsGOyefo6MWzFAM=;
  b=p+xyrIbW82g9vtRJvgYNkophquLehA3ydzGEAGAmSRXY/lD2ZQ+ny1Y5
   C8X1eHf3DYfGhvDNPlzs72wMFL9mdjdDa7s74w8e7Y8uPIlh1k0hSsWjE
   ahHai14OkinlAcr/DN/2HNbSw6IMH0aWvVxOR2rIJYOtz/xdaOHEhkoPg
   c=;
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWD4YhWHk793hNTDYkK1heHXGuKLxnF62rlfget9YCCRhT1n8FQ0mU3uLxiDbNyQlnAzHRBHbVIKeQ+IX9KW4Py8xWN65ll1MREir02oUK69Ig8bzcTpbCMSHWr0oypwibvRCkcNZPzGC3F7BZu0+5FyyJ2QxhKvH/gWBOIYSVccHmgGmuorxPdJkzseX0m+7IcRi1BrZQ7y2/1tBdpH6rHT/pStJYxmGTm244heg9D0abntZ6cLb1Z9IFYT/NWYrpxWiP2NrH2wiDPTex14wg8ryIKGXzJj+gGPbtPqVsEnrYJAdSGFYnSIzTPqc14ryOb2yWN81leENEPbY/oAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVJ0FutEggDKi8QWp6hnHrgyf8KoZsGOyefo6MWzFAM=;
 b=Wkg+opjcuL/6ZRp1kkS6RFmIkFKGdAJUF2E/PXw/P/DXfF/6a136aEDBf0itWSbA1EtvipHr13lCRKWi4NGhinNDvzjiCjwdasUYNz+16gavMGls313ScaxnmPQOZNB0dzrzXKWtjPHnWM0gbc4/cIlNWOOd8vU1V2lO+f7rvxUlrEQcBMtu4aDPVs1/2QA3OrIa2TGFX5UHUL+yndEU7MBH3/QvswcUZoYAlex3Jcr+de0n/vWMClb5u7XHNuQC+hIIQVJQQ/v8aFEV0S7KyZjzXhqVabgFe9yrIYulHdVRplsCM4vLJr2vXg1PPe0asC1s8fBgPTXTqyh4/8U87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR02MB7958.namprd02.prod.outlook.com (2603:10b6:8:13::19) by
 SA2PR02MB7532.namprd02.prod.outlook.com (2603:10b6:806:142::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.14; Mon, 14 Feb 2022 15:55:52 +0000
Received: from DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9]) by DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9%6]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 15:55:52 +0000
From:   "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>
To:     'Johannes Berg' <johannes@sipsolutions.net>,
        "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Vikram Kandukuri (QUIC)" <quic_vikram@quicinc.com>,
        "Jia Ding (QUIC)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "ilan.peer@intel.com" <ilan.peer@intel.com>
Subject: RE: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT
 capabilities
Thread-Topic: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT
 capabilities
Thread-Index: AQHYHrNJZcplRJTMmUmfY0kLbEi9TayPJLeAgAAX/QCAA/wL8A==
Date:   Mon, 14 Feb 2022 15:55:52 +0000
Message-ID: <DM8PR02MB7958BEAFECDCC17097F4A731FE339@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
         <20220210201853.c40044dc90e9.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
         <DM8PR02MB7958C66988E52F40F0ED8A6AFE309@DM8PR02MB7958.namprd02.prod.outlook.com>
 <13d897bae6ac5bfd25c7b2e2c80fdaac392334ce.camel@sipsolutions.net>
In-Reply-To: <13d897bae6ac5bfd25c7b2e2c80fdaac392334ce.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e77883c-4d4b-400b-9bfd-08d9efd27a67
x-ms-traffictypediagnostic: SA2PR02MB7532:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR02MB753247C47F1101C3EDD23FB482339@SA2PR02MB7532.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WoNKwAAiufE2LAa9NWJdKswK29PMi7iDtsOautELOxc/rpf/EB0Nt3ERYhA1JTiQcp1NXFLku4XcGvVhBJOJZxsiz54Ud1Js+7tvPWJeh8hhZ8ru8g3zk5rIf9C+jBGjN6eOQwi8+N8TvBz4x1mKx1EZ4rrpcJEjT/b4FPtpB2sgz2S+dQST0zvJMt+oBErIwm+Va2+xUGAdbXE5So8nOrplXjiBVc04e8uLeNIKc2+VRoLhM5CasAISIk7Vs3liJA33a1EWi9hw/zsM7BovAr/vZSKAHBHVZyDeuULQG5j67o5JKCh4pSYsV4ujEzuVnQJPoG1tG9L8v3yPN7O/yGZ8ScSzmHJxLatSWBWhMMFtRCIGVFGeWwQGG5C22CH4Rj/LxtIDJXVoDIw9PSeppLrVTnnwtz/sk1YY3+/2d1ck86b3ETEUTrE3C+BR8rMmqOy3rrAUi4NkiTbqbK2snZGU1Xz0zGkzKNWhlBfhB0HSJkLH7olarrS6osVGJqYTgJdVAB4t1r+oCNKaZxeIet73LT/UShmqSW7YPXBSf6kYMQJ+i6keL0EV0bOYegp9cRVA1tIcXYZz+QiTmaMw6v68O+uzbKEuAzDVHoEHOqb8NLByClyEj+O38ukF6e9SXw83s89r5lwaWEPxq2WF3SX9gs2l3c3Rfg1oKCT5Ryfl80gnWHC/Zne0x3UAtXnwnUXjUt626oCy3HMTqi3EkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(38100700002)(186003)(26005)(122000001)(8676002)(54906003)(2906002)(52536014)(4326008)(4744005)(76116006)(316002)(64756008)(66476007)(66446008)(8936002)(110136005)(66946007)(66556008)(5660300002)(9686003)(7696005)(38070700005)(33656002)(508600001)(55016003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0g5TnVEMnpDbUVhTDJXRHFVcHlBak9uMklVVkl4aFR2Sm85MmZna2lqd1hD?=
 =?utf-8?B?N0JYMmxWNlVPZ1A2Ry9CV3FIWVFEeGpsVTN1RlMxYlZCSFhuNGZVWU84MXZR?=
 =?utf-8?B?TllqUjhPUkNCdXFQWEFsSldvZ21ZN05GM1cxdnBoeDFscTlHL0txR0RpRTRs?=
 =?utf-8?B?RVl3TFZJRmp3SmNod0doV1F6SkpxcG5FOVZwZUFQZ2cvZWlQNUgwQWhzQ2hK?=
 =?utf-8?B?UHppYjRFK0ZseWVsTDRvWmlEVW1PM2pKT3JobU9NM2VhZTQ0aHpyVUIrdXFh?=
 =?utf-8?B?a2tSOGVMQzQ5TkRHdWxWcUtzelpiTFNMM3BGMVRoelZFd2JvQmJkcEZTWUJS?=
 =?utf-8?B?N0hGRnN6ek5uSkxqSWVlSFJWSkdlLzNPMHBodkhHWmE5SENWVjBFMUJEa29y?=
 =?utf-8?B?Tk1kLzRvQkQ5MldJY2FwMHJuaWRGZ3RYckxISW93ZUxvbHBjTlhYNnNlOWcz?=
 =?utf-8?B?VWs2UG1uM2hBZHk2eEdFQlQzUUppVzRlSm1kcUl0cWJVSE5adWNJZG5sSWR3?=
 =?utf-8?B?ZXZ2Mk5IUGhHQk5TaG8yUExzc0NaVGErTkpvMVB4Q3pGeVJ3SmZEdE5MMUg0?=
 =?utf-8?B?WVBaT21QRXRYS0VBMG5kMzNXOXpXdS83aUsxS1hBUmlBUXBNR3ZQUUt1dWd5?=
 =?utf-8?B?cmdnUlJMaDlRTEpIditIVlVMVmE5RjJZcXFjWURnanVMZzN1dUxtWnU0dURa?=
 =?utf-8?B?V2Jpa25vbDBFYTJUYzJvOFVIWTEwam5VVW9pdStJeVY1LzBoSFcxTHhZWHAw?=
 =?utf-8?B?bFpnNG92N3VtYkZpUS9rbmlRdTNFNEdHUElhemhoQmVUeklNYk1BdE5wNjBS?=
 =?utf-8?B?M3BDa0ZsaGxmUkZrUDFmRElFdlpYRXFoTUtkV1JYc3llWkVVWjcvci95dmZU?=
 =?utf-8?B?MVR6TU1Nc3Nrb0RSUy9HNEJVZjd0U2ZtWXRpL2J2RDJObjVLMUtSRWdReTFE?=
 =?utf-8?B?SUg4OTg4VXY0L003RFlnMzZoRjlvbWVGdWdLLzR0dGNhVFZMdmZySXI5TVha?=
 =?utf-8?B?RWQxakRMOXljWWJaRG43ak51MEdZamJaSDNyRE5nemhGSGlIVmFnK1NsUFcr?=
 =?utf-8?B?YzFvR0VIOE5jZ3pMb0ZCVWVheTlZQTdHTExyM2UyQ2ptR1lNVmM0NnRGWXhR?=
 =?utf-8?B?alFIaGxxcWhGMzlEcjdpRkI5YlhNRU5PaWxiWnR4c3Y2WThJYmNiT21RODRJ?=
 =?utf-8?B?bDV5bEpmYm1nU0J2Nng5djByakRVUHozSklzWU8wWTBJdHdLVkxCQnhkWFR4?=
 =?utf-8?B?R2FxK01PYlUrbjN0d1R2WCs1bWFQN3pyejY1S2tkVWhpQ0piYkZjNlNYeXFu?=
 =?utf-8?B?TGh6QjhlL09jTjZhTlFlbW5qRW9DUWp5VG9HdkpoZ0dlR2sxM29hdlBOM1ZJ?=
 =?utf-8?B?K1RDQzBHSDE0VGtZaHNPamJBZlk2SFBWWEdjUWhGVHA3MmpqcmVRc2lFZzlR?=
 =?utf-8?B?SVpKcEtYSG5TMXRNYXhLdy9iV3FZM3E0UEg0dCtibVVuYVNtTHovbHJPSERH?=
 =?utf-8?B?KzlaSFlrUmtQZUdMVnV4N2toSzNxSE5jS0RxTytLVnZqMlJmVDRHMzZhNEJQ?=
 =?utf-8?B?U3dHR01SelhWdkRHa2Z3Sk13YWFIdXN6WXFCTUlwODhNcW16Mk1ndHp3NVBj?=
 =?utf-8?B?RVZsYklWOU8zbm1zYjhBT1pWcHkrVG9pNkRqeGNQOWhQSllnZG54QWJhOEJh?=
 =?utf-8?B?Y09sZ2pFZmhBUFBraXQ2alJkcDBjQkY5WlR3OFVsTXlWNnYxVzJYcy9GUUov?=
 =?utf-8?B?Wkt3bU82U1l4eC9KcUozR2Q5ZFdLQkpCZFpnK2J5NzcxN0Q1TEo0QjgycE1m?=
 =?utf-8?B?dks5czFOeWtyTHBtQnVIKzNMMGtTbS8rS0NYUFlJdEdyL0ZKeWJZVUxQcmxE?=
 =?utf-8?B?VmhnUlpIbGlQSHJhZWEralNWcDVDd2V4OEZHWjN4dHJNTFZyM0MwYVNxYTR3?=
 =?utf-8?B?U1NPVys4aU00akJCVDAyL0xWZEljMWpadkJuV0g1SHg3NkJJMldvRzBBVXFY?=
 =?utf-8?B?bEtUczlDdWVwdVJMR2hjdldiQUI5anNlM00wVktlRUQ4OXhDWFkvMTVBcitt?=
 =?utf-8?B?VmpVRURabUJFdTZYemZmWTlkZG45dG1CYmdVR3JhK2NJNkxsSDB4c1RJd3JJ?=
 =?utf-8?B?Q1B2NWlxSERSYmhBbFk3cStPTC85NElNVTllL1VLVVJFRXp3RjhHVXQxQ1B0?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e77883c-4d4b-400b-9bfd-08d9efd27a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 15:55:52.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAB43C0Pzk0MWQk/Rfyll6SA3lT5pkhrmstB99ZBGgbhJ1JRFqpyxdBysUGMCEaT4uum7718qvOAyUDLg39yzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7532
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

KHNvbWV0aGluZyB3ZWlyZCBoYXBwZW5lZCB3aXRoIHlvdXIgcXVvdGluZz8pDQpZZWFoIOKYuSBu
ZWVkIHRvIGNoZWNrLg0KDQpBUCBtb2RlLCBlc3BlY2lhbGx5IG5vbi1tYWM4MDIxMSwgd2Fzbid0
IHJlYWxseSBoaWdoIG9uIG91ciBsaXN0IC4uLg0KDQpJJ20gYWxzbyBub3Qgc3VyZSBpdCByZWFs
bHkgYmVsb25ncyB0byB0aGlzIHBhdGNoLCBzaW5jZSB0aGlzIHBhdGNoIHdhcw0KanVzdCBtZWFu
dCB0byBjYXB0dXJlIHRoZSBFSFQgY2FwYWJpbGl0aWVzIG9mIHRoZSBkZXZpY2UsIG5vdCBzdXBw
b3J0IEFQDQptb2RlIDotKQ0KDQpJIHRoaW5rIEknZCBwcmVmZXIgdG8gaGF2ZSBhIHNlcGFyYXRl
IHBhdGNoLCBsYXRlciwgYW5kIHdlIGNhbiBkaXNjdXNzDQp3aGV0aGVyIEkgc2hvdWxkIHN1Ym1p
dCB0aGF0IG9yIHlvdSB3YW50IHRvIChJIGNhbm5vdCByZWFsbHkgdGVzdCBpdCkuDQpBbnkgb2Jq
ZWN0aW9ucz8NCg0KU3VyZSwgdGhhdCBzb3VuZHMgZ29vZCENClRoYW5rcy4NCg==
