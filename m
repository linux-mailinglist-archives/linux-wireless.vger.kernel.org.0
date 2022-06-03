Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB753C6F2
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiFCIac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242839AbiFCIaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:30:30 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D17C27B38
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1654245029; x=1654849829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E/e3qcRvi4QKELu+Tt+2/p9KlQIocU8xzTvFQXHNPiI=;
  b=tHxF8zdYqZ0V0iDE1pYaEOfhdddQ0kRueF8rHeS05xJJ7Vtv+BdrMkIk
   LEgbCX82pOaudpwQycgWfeJoHI4a5Ww1+tVJzlxC/GctJYZOA+OMfZNdV
   n40UubzEDcgB0F0pOloKU6Z5abuMFkTs+NViqn5Y/GihcaNlznUoUX2Q3
   0=;
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 08:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isavwDt6ykL5MgBgZaA/2EKNGxTZm1pCK8Hrrj6Kj6Fm7ExSakUP10OPHNsfDc5pz85m9tedzDMWYgtvAnGBkCqxXuLzO7nwahBLI+fyvX6JtQB60kCkAoZ9G8a+PDn4qQweXSJyLgYfj2owMP/fAtFw8S5vJggw4ZiTiA57nS2HxaopMsLrGIF0XYslTRVS64LqPHjFPflyIeaKRatp5oRGEf1/NqaD35SCzxf0LZDCoQYjgx6sU5PV65CzokKVnX9tUN6t4TG8jPH3MbaSmVA4UxNeAhq7fyM9c7LSuQIU3n0LYrHKyrVzZZyE0fJewhE268ssJSjUsJiXqr16Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/e3qcRvi4QKELu+Tt+2/p9KlQIocU8xzTvFQXHNPiI=;
 b=PxnHbEz8z2jX+Dy6Y8ZS+BfF8ddVobfITukV/14YAUErqns3AHR72Q25gDHGpeZorn2lBNeafalouNz7KJjgmdgZSK0lSX2TNSDAB5z3nvspaV1kZCztiWEzMmG0yUcK/GMGjwMv5EUSu8fi3XNnszd4ckI/Sb3LYIgEq2dKa6bvUPczHK6mWJ+uMOLFRUNMD63cFtrjcunqaglvL5RhKlafqh85B3t/XZcgHQ4BFSfJnJB+ttq0Nz8Hcd5HTxnSGRqPAiFNVf4tKoQZnokDPWuJd+x08Y0W5Vg/TWGjF/APEF1QtRM582bTrrT10HtlqTtczEPjn1DJVaa7jVb0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3589.namprd02.prod.outlook.com (2603:10b6:4:80::19)
 by CY4PR02MB2839.namprd02.prod.outlook.com (2603:10b6:903:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 08:30:23 +0000
Received: from DM5PR0201MB3589.namprd02.prod.outlook.com
 ([fe80::f5b9:2296:c8d4:764e]) by DM5PR0201MB3589.namprd02.prod.outlook.com
 ([fe80::f5b9:2296:c8d4:764e%7]) with mapi id 15.20.5293.019; Fri, 3 Jun 2022
 08:30:23 +0000
From:   "Aditya Kumar Singh (QUIC)" <quic_adisi@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Aditya Kumar Singh (QUIC)" <quic_adisi@quicinc.com>
Subject: RE: [PATCH 1/2] ath11k: move firmware stats out of debugfs
Thread-Topic: [PATCH 1/2] ath11k: move firmware stats out of debugfs
Thread-Index: AQHYdj+uvGfmOr/9ekaKJGdgXcX7F609P/MAgAAb4TA=
Date:   Fri, 3 Jun 2022 08:30:23 +0000
Message-ID: <DM5PR0201MB35890931A39B89FB8E1A94FC84A19@DM5PR0201MB3589.namprd02.prod.outlook.com>
References: <20220602051425.9265-2-quic_adisi@quicinc.com>
 <165423896462.24941.15580147276579618500.kvalo@kernel.org>
In-Reply-To: <165423896462.24941.15580147276579618500.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84e2cbec-ae72-46a7-3969-08da453b4dea
x-ms-traffictypediagnostic: CY4PR02MB2839:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR02MB2839BE20A5EFC362D4E902D2F8A19@CY4PR02MB2839.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7niAc/hRIltspjLNF2bCxl/Hc/uvaz939MBeLxk2DiUex/6spysVjK3NZwRYQJhAOE7uPQgiuhlviC9ijexUNHZjTrg3CX1rHN58nMzAH+ECEKVtHKYiiu4jlXx1RkcErYSkSrzvCYsuTXRIiTZSWIJ8k+iqLolNoE38xfZYUk/jGF3wLsDa/jw8d4ZgybwnMSqml+IknDxSYnEdD38nhTRk4Gc43X5BMbLaYoMEr3hMDUdi/M+sf5Kcsv+ehUQO1VZUOS1T4URi+rByPAfF5UQcSFWXJI5ZybYXeGp4n+JedL9cE87wLFvS7hDapSWY7vGAqY/XH4jUXxWd54rE8lmeAtDxV7gCJHme2sIcX/HQEEOsc86QgZLOcnl9BRr6PT00jZkY5+AVUIXq//9KPWzIde+nWfTGm/81HcNdK4RI192gV9MLZaq7fKe+bAJjTdxVxPGTIp3zKQGUGeKCDw1liyTFFXWMbZI2EUgo1A+bieI40CuJxpcsu6QwSg5Cw9vZYTd9eRq4EqLpUaC6ndRx4WEXT0CdeexgU6QL2AOkey9l/+T6t82axsluV2fMza9HhWI/dBqODbQxw1c+SlZgmdXRPD7qlfrWYLGoFOmbqH/yjNp6rw00dVX6mPzqxDCUBeIdoBzXe4qC/PXYu+2v5VzWKbyoGPGIMxq3MoaoPZY9EAD/q0poep+bbnvLzdthRp3L1nZVAn0yhEM3r1CIolx/JcSr/g2ZGLnXk1QgG7ZjONtkuhs/U583rCk1fIGfAYjq0IexdY6Rh4PFWbol4Lyigs+W2wtjFuhZgJU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3589.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2906002)(66556008)(76116006)(66946007)(66476007)(4326008)(8676002)(186003)(55016003)(5660300002)(66446008)(64756008)(107886003)(38100700002)(52536014)(83380400001)(8936002)(26005)(122000001)(9686003)(6506007)(38070700005)(86362001)(966005)(71200400001)(508600001)(6916009)(54906003)(53546011)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUZvQmh1cjJNSit0ckRFeHFOemdCcGExZWRiT0pVTC9xTzlyNzlJQU1YdWJI?=
 =?utf-8?B?RTg3WitmVHQ4TDBJRnJNWkRWYndyVStCdGlVZGxvWmRRQ0NLb3d4OFQxT0Y1?=
 =?utf-8?B?a0duRlUyd1VsaVV3WXdNU1djbjV4bjh1MEd1d1EzdjlNQTJ4eEFMZHExTkpU?=
 =?utf-8?B?eFJ0Q2RPUW9HaE9RWitBMENNN25GT2RzUHJvRHg4UDNnUzFtcVVDdFg4WG1i?=
 =?utf-8?B?VHh6c0UyYXRBOVdwa1JldXd6TFlKNEJGa2UwZGoySVBxYmxScWpPRkdvbHJC?=
 =?utf-8?B?dHBkTi9LeXhUT3Y4eDdXUjlpbk82STgvQTl6MHR1Q0JpbkRQYnljSk9ETWVS?=
 =?utf-8?B?ck1HeklVY2RyVEk3di92RlcrdVBuSTVwNkhmOE83eTRMZXFndGxVNGxDSTEz?=
 =?utf-8?B?eG5CZC82NXdPK0VjMFgwTnFFb3BOSEhDYUlpdGZ1ekhwakV6QzdXdDlYMnpL?=
 =?utf-8?B?Y0dWMEFaYVR5a3FsMG9DREFHSXFmMitWNlR3MjYvRksxaFd6dWtwRG1HU21W?=
 =?utf-8?B?TXlpR2hpNjhHRUViMlR2L3NRQ0xGRzJXdUlzZkNtNkJwandSV1JTbnB2RzFK?=
 =?utf-8?B?NkRONlFZQzJ4VzYyaldySFlaLzF6TURwMFVSQURMUG44OEx0ckFQRTNoNDJl?=
 =?utf-8?B?cnJXZlZQNHZSV3RkMVVoL25zSFluQ3k4cFN2N3huZ0RnRFZ0S3hjVkloOTFV?=
 =?utf-8?B?UXk3Sm1XODU3SGU3empFdlByTzV5allCcVQvUG9zRW1DYnp0UHRDYS84TExt?=
 =?utf-8?B?bDY5UFhmdVBtZ1pLS1J6NFIwVWEvRnlRblFYbXgrZkVzR3NkU25ld29ZZ2c3?=
 =?utf-8?B?d29VYW5GcG8ySEQ5b2xlMXU2Mi9ieTF3elpSYVRERHFBVVgvWHN0aFdxRW53?=
 =?utf-8?B?YjFwMzU3ck5IZUNhUEdZdzhhZVR2MWFDL1pjdHFBbXlWTWNlUGRpdGJUa2JZ?=
 =?utf-8?B?TU9uRVBOa1FYTUd4MTVrN0NtVnp0cU1PUjlVRHdjajVGSS80dk9lQWw2cFNs?=
 =?utf-8?B?TDQyRnJKVTFxQ2g3YWVoZDludFMydlJBRFFPaHRWUWg4WTdPcXBUTEhxcW9T?=
 =?utf-8?B?V0ppcGVwSFY5Y0RGMGtsK1E3OGlKbm5ydGs4b1Q3Q2oyZHNZUHhMSXZ2K3pP?=
 =?utf-8?B?T3BmYkhmTDVVU2NBTkVFMTZ3R01WQ05FZWVLN2E0L3Y3L1plUzRJYUpmalZh?=
 =?utf-8?B?UVRkVVFWcGJTd0hRRUNrSUQxbnZFMWRoWnpraDM5WkpEMjlhNGM3QkhkUlNr?=
 =?utf-8?B?WGV6dUtEOTU4b0dDK0p1MUJKaWgvam5yNEZ5OU43V3d3d2xMMHJ2NlNUVmpN?=
 =?utf-8?B?aGZyajBTYmxTVzllaFFUZmd3ZXhZRVpGSzdzaXRQSEkyaWwrNUlBcFcxSTVl?=
 =?utf-8?B?OGppSGtKbTRCbnBwaCt0MWl5VVZOTXptcmNoYnV6KzdQbjRVdjExem1JM3Uw?=
 =?utf-8?B?Y09DNDJKYUJKZFF3dEJyWHB3bVdYQjdSdkRBd0Y3N2s1b0xyaDc5cEpFMkd3?=
 =?utf-8?B?ZkV4bTIzMktqdHZudzhJbms0U3crc2c2YzhjeUdISU81LzhOYW0rWTRINXhN?=
 =?utf-8?B?b3JxaGdNc3A0blk5MnFKZG52ekZvaC83TjBaS1VoT01kUWpwMExqRjJvUjRo?=
 =?utf-8?B?c2ZqQ0pKcnVIRUs5alFCZTRTZGRpVUd4eURTRXVWUVd4UjlITkRZa05GRGhx?=
 =?utf-8?B?STdlbEdBVkRjZlMzT1RDdkl4MVhLSmM3NUQxcDBGSmlrdHNULzM4NzBacWNL?=
 =?utf-8?B?TThFR2Zla1N5SzRod3lKczJPTzVSMXRzdVFudW1xbUcwcTZhZlhReWRsbGRh?=
 =?utf-8?B?OGRiUmtyT1hsS0xCNVBPQW9XdHY1MnpNZXVMVnFTR1BJK09IRjRabVMweTAr?=
 =?utf-8?B?WlNtT3Jhd1g3dWJpa0VlRXNDWDE5aEZLL3JXaGFYQnc2Z2lRWWYyZDNQS3pL?=
 =?utf-8?B?NjhjREpIU2RkT2tEbksyeGZZb0pDN2ErUGxkTG51aDNlZ3R3Z2VWcEdvYXFa?=
 =?utf-8?B?QklBU3lrUHRaZTBkZmF3S0w1RWphOHRTOWdoMXFlWDNIcmd0dEVxL1BvQUZE?=
 =?utf-8?B?K0szaEVVWHIvWHE5YkE2RDhIcjhxcmNQMUNjbWFWMlA0b3dGbE96MktVZjEw?=
 =?utf-8?B?dSt4TFg1b2JwZGFQMTd6eW9RdFVHdzdjU3BEdU1xdUpJRE9ZSGpvQnVwYS9x?=
 =?utf-8?B?TXVGTFlMTms3NENQQXlEQzNCcEZMVmFJdFVoYkRBY09PSFUxUkpwamxXMHM2?=
 =?utf-8?B?WlN3QUsxTzFWUFpuMG5lSnRRdnVWNWY3dTBkRHJzTjFJejAzeDkvcko1RmEx?=
 =?utf-8?B?M2ZucEIvNmtyTXpjd0xDQllVSFdwNUREOHY3ODhWdmNZeWdkNXN5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3589.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e2cbec-ae72-46a7-3969-08da453b4dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 08:30:23.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VisTKdXdFVp2HoyeG7BJ2ZUdRqfqzt5VH+AwRo8FuJRRcDKDW1PVuGxc7Nt+t3RokhApmG9J5QWDQISVKPb8/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2839
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWxsZSBWYWxvIDxrdmFsb0Br
ZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMywgMjAyMiAxMjoyMQ0KPiBUbzogQWRp
dHlhIEt1bWFyIFNpbmdoIChRVUlDKSA8cXVpY19hZGlzaUBxdWljaW5jLmNvbT4NCj4gQ2M6IGF0
aDExa0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7
IEFkaXR5YQ0KPiBLdW1hciBTaW5naCAoUVVJQykgPHF1aWNfYWRpc2lAcXVpY2luYy5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBhdGgxMWs6IG1vdmUgZmlybXdhcmUgc3RhdHMgb3V0
IG9mIGRlYnVnZnMNCj4gDQo+IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWljaW5j
LmNvbT4gd3JvdGU6DQo+IA0KPiA+IEN1cnJlbnRseSwgZmlybXdhcmUgc3RhdHMsIGNvbXByaXNp
bmcgcGRldiwgdmRldiBhbmQgYmVhY29uIHN0YXRzIGFyZQ0KPiA+IHBhcnQgb2YgZGVidWdmcy4g
SW4gZmlybXdhcmUgcGRldiBzdGF0cywgZmlybXdhcmUgcmVwb3J0cyB0aGUgZmluYWwgVHgNCj4g
PiBwb3dlciB1c2VkIHRvIHRyYW5zbWl0IGVhY2ggcGFja2V0LiBJZiBkcml2ZXIgd2FudHMgdG8g
a25vdyB0aGUgZmluYWwNCj4gPiBUeCBwb3dlciBiZWluZyB1c2VkIGF0IGZpcm13YXJlIGxldmVs
LCBpdCBjYW4gbGV2ZXJhZ2UgZnJvbSBmaXJtd2FyZQ0KPiA+IHBkZXYgc3RhdHMuDQo+ID4NCj4g
PiBNb3ZlIGZpcm13YXJlIHN0YXRzIG91dCBvZiBkZWJ1Z2ZzIGNvbnRleHQgaW4gb3JkZXIgdG8g
bGV2ZXJhZ2UgdGhlDQo+ID4gZmluYWwgVHggcG93ZXIgcmVwb3J0ZWQgaW4gaXQgZXZlbiB3aGVu
IGRlYnVnZnMgaXMgZGlzYWJsZWQuDQo+ID4NCj4gPiBUZXN0ZWQtb246IElQUTgwNzQgaHcyLjAg
QUhCDQo+ID4gV0xBTi5ISy4yLjUuMC4xLTAxMTAwLVFDQUhLU1dQTF9TSUxJQ09OWi0xDQo+ID4g
VGVzdGVkLW9uOiBRQ045MDc0IGh3MS4wIFBDSQ0KPiA+IFdMQU4uSEsuMi41LjAuMS0wMTEwMC1R
Q0FIS1NXUExfU0lMSUNPTlotMQ0KPiA+IFRlc3RlZC1vbjogV0NONjg1NSBodzIuMCBQQ0kNCj4g
PiBXTEFOLkhTUC4xLjEtMDMxMjUtUUNBSFNQU1dQTF9WMV9WMl9TSUxJQ09OWl9MSVRFLTMNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWlj
aW5jLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYWxsZSBWYWxvIDxxdWljX2t2YWxvQHF1aWNp
bmMuY29tPg0KPiANCj4gVGhpcyBhZGRlZCBuZXcgd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJzL25l
dC93aXJlbGVzcy9hdGgvYXRoMTFrL2RlYnVnZnMuYzo5NDogUGxlYXNlIGRvbid0IHVzZSBtdWx0
aXBsZQ0KPiBibGFuayBsaW5lcw0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTFrL2Rl
YnVnZnMuYzo5NzY6IEJsYW5rIGxpbmVzIGFyZW4ndCBuZWNlc3NhcnkNCj4gYmVmb3JlIGEgY2xv
c2UgYnJhY2UgJ30nDQo+IA0KSSBoYXZlIHNlbnQgW3YyXSBiZWZvcmUgeW91ciBtYWlsLiBCdXQg
dGhhdCB0b28gd2lsbCBsZWFkIHRvIHRoZXNlIHdhcm5pbmdzIGhlbmNlDQpJIGhhdmUgcmVjdGlm
aWVkIGFuZCBzZW50IFt2M10uIA0KDQoNCj4gSSBmaXhlZCB0aGVtIGluIHRoZSBwZW5kaW5nIGJy
YW5jaC4NClN1cmUgdGhhbmtzLg0KDQo+IA0KPiAtLQ0KPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtDQo+IHdpcmVsZXNzL3BhdGNoLzIwMjIwNjAyMDUxNDI1Ljky
NjUtMi1xdWljX2FkaXNpQHF1aWNpbmMuY29tLw0KPiANCj4gaHR0cHM6Ly93aXJlbGVzcy53aWtp
Lmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1pdHRpbmdwDQo+IGF0
Y2hlcw0KDQo=
