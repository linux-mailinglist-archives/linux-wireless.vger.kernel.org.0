Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2CA4EEEC5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbiDAOHP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiDAOHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 10:07:12 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B51E9C93
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648821923; x=1649426723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyaLUaML0fCsGmiRXyEKsZr5hwOZXsvDU029KN0cBtc=;
  b=yORQECjKC/t9HhA2fVaWMAgYuzExMyYkw5fxPGqjxKHOKv2xsLufGLvw
   J84bhSkoaDrjz9gicHvIxbJtT10gP6qP0mIagmZnvMpXGPpR6Gr3Fl9qk
   87R2IxtHzdnscor6S4Gdc/boEw00ovLNmgHGSXZTzKTf+Q++/sz0x9Fpa
   w=;
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/XHa+yQQ0tnJ38tQRLIXHAoOc+CjO82dF5rpYHdckois56EM3mwYFCutBdJ9w7jEHQEiAqCshZsAvUCiYa5Qd4YeIihj0zwoc/1tajw2iHf0S3VtrFl6fBjHeQ+w/VraX9HcNkmq4Jm150/5sZPWacqgVXgInqYjWyiEt+EuYwKs4CG5QyCAHLAkJ28IB/R/8oJIJDLTiqP703ndz2h9YJffPuvzm2XO0Q4W1wbcWJwiKK6FJnqJBk2jR9T5S/MkzfSZPAyJtAHsr7ZoveKDgLgi01R9dce0taP6+KHcG0iovAUc1s30NSqTuwotSFxqx31A0ZeOgLWWCKxd/bUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyaLUaML0fCsGmiRXyEKsZr5hwOZXsvDU029KN0cBtc=;
 b=nv6VLOKZsXjJvloI5tYrNAn1dYe8tv0PImRRDhOwsErNfotWi8zIRhYKLiglXR0/tWaEnbUOm8yriH21Y/sQdZGeMVqCAGH6OpvOCgvjvtViLWHeST3mSGiS2717b5ZiWduZx4tuNAN4I5LLHV2zdhCyzVelrO/E2KAT9HX/MfL1iKz0BEyFBRkQq7kbg9QT3cAfq6VWj26d1sKcLFDDcOEK0qaE8Pkw9G6im9Rdli8KQfkXJi1iwSYdntSzdhMo4R2ZPjXcDC3+Btzd5gFn87ZFDjKJlT6Ejvf8h2Yxb4vMen5TOAsUWnmvy6xnaG85AnP+qED7cTjOc6M7k2T2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from MW2PR02MB3899.namprd02.prod.outlook.com (2603:10b6:907:3::30)
 by BY5PR02MB6372.namprd02.prod.outlook.com (2603:10b6:a03:1fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 14:05:18 +0000
Received: from MW2PR02MB3899.namprd02.prod.outlook.com
 ([fe80::d163:1cf6:9fda:4b82]) by MW2PR02MB3899.namprd02.prod.outlook.com
 ([fe80::d163:1cf6:9fda:4b82%4]) with mapi id 15.20.5123.019; Fri, 1 Apr 2022
 14:05:18 +0000
From:   "Nagarajan Maran (QUIC)" <quic_nmaran@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Nagarajan Maran (QUIC)" <quic_nmaran@quicinc.com>
Subject: RE: [PATCH v5.18] ath11k: fix driver initialization failure with WoW
 unsupported hw
Thread-Topic: [PATCH v5.18] ath11k: fix driver initialization failure with WoW
 unsupported hw
Thread-Index: AQHYRNFW+lpV0OMIdUmEcCGwKggX46zbaWMA//+vjQA=
Date:   Fri, 1 Apr 2022 14:05:17 +0000
Message-ID: <MW2PR02MB3899523D4B643CCD0E4AFA2DEDE09@MW2PR02MB3899.namprd02.prod.outlook.com>
References: <20220331073110.3846-1-quic_nmaran@quicinc.com>
 <164881389362.6665.5091759680024849832.kvalo@kernel.org>
In-Reply-To: <164881389362.6665.5091759680024849832.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88c7e52b-e831-43e4-afe4-08da13e8a6f5
x-ms-traffictypediagnostic: BY5PR02MB6372:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB6372C393CFEE97E5A729A8DC91E09@BY5PR02MB6372.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUdLfHm2dc04k+aUuaWdH/Ww+jkT4cE8ztMtIRdgja6vq4Bn2p3XKYbUnE1b8HbJwd7ejOAj9UR3TRsczU6f1Hmm4yEVteAAHmGDeahMNHM7tlOlZIy7ANtqpJSt3pyMhG14fw3oh6g5cAGFCBxNwkpNALDEILegLevMg7RL/Dzi51UpYGs8G4Nj3FHPzm7dIkI/8dZk4J+3Q/w0V2CYhUswXIqPpKvLTDtARKgMczVx7s09MdQIpu7vADmHZtexBKk2+0l/WflAZy8HcQRpGe9A6Jzk1UpfM3bGRqQMv2ShAweLDEwLLAZ8Mzgy+jjUvW/KYQta5E4d1uSxvP2N0MVJEj/Oj+Qcyza8eEOfXDxsG43LDy1ARbWpxGtjCIrBMCYpTFbEypmZlIU/XcvkA/UIMsJZkg8BaE10Nwr4jWQ+TLdspbQLa8m/0Gl6/mDqRFiwVeWLSyZj0k3X5ZZ6RZ06rpGeVgsn9Sgq5zMwN59yVEU3RhX2CihtV1qHgA6wLvMXzcrzQLIrdPeDE/nwNQOArGCrmdGnaQ4BrbAElwuL4JLyWromlepb9O0N3oNeaPfJ0iJoOfloqXQCqjvA4w3LbuVX1cq9W3Jp+t7TgwurBf6FNfjThyccMQIQynVWrNGsOeViAC8W0HOusLo/Wag83a1P1FCcpFqKL5NMONY6YPrqKE3FEB8OxHoy6KTlRWeISnqpCOTUypU3fPKdie1zc0o/8HiykzzJNRWJC3CHvtz47/qlkEpKwB5A5E4MO48846TovNeAQvbYsMzRcbQlvOE8zv8GstZGbsfvRkJ1TwhnR7j8rYCK+vFYHJj6tkkJvAuOz2qRuDlZODSt1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR02MB3899.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(76116006)(66946007)(33656002)(64756008)(66446008)(4326008)(8676002)(66476007)(66556008)(316002)(83380400001)(55016003)(508600001)(186003)(26005)(7696005)(107886003)(86362001)(8936002)(52536014)(9686003)(2906002)(53546011)(6506007)(966005)(71200400001)(122000001)(45080400002)(54906003)(5660300002)(38100700002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEFnVWxBRVFLS2JJNGF3YitVdnI0MGxkTlV6UVU2YWRWUWE2TVA1eUlzbjhS?=
 =?utf-8?B?WUcySGxiSnIxWHdqZmhMelNYak9kbkpyZ3J4RnhuRUtIcjNXRXZPZzM5Zmdn?=
 =?utf-8?B?NTdUSkRhTVNMblk4bkpTM3lZV01NNlJ4bEU1YlVLNFRLK2t4OSt0VXNWNTM1?=
 =?utf-8?B?QTA1Vi9WdEdUY3pKc2w0a2gzTXY5cyt4NXFEQktxd0FNU2Y2dU16U1pyR0xK?=
 =?utf-8?B?MCtEa3MvZW9WRE5iUjg1VG01a1ZhMXdxb1ZHekQxRi9KYllENjNhMC81enAr?=
 =?utf-8?B?YWRyR3QxWHJuUUtncnhXZE5aMmVLSUoyZjYrcG53U3M4aldOekk4NVZGU1RM?=
 =?utf-8?B?ZklGS0N5Mm13NWZ6Sk9uKzYyeGh3cEx6NFVjRzh6ODFpdE1ZTXhkQ0M5V2M2?=
 =?utf-8?B?em1YWERtSURWUzRsOXFIaWhKbGY4UnJUdFY3VzM0enhma1hvQnl6c1pNYnF4?=
 =?utf-8?B?TTBYSXVORE1scjNNRDRYaHorSktucC9FZTlaZ0gvTXhRbHNDa3BBNGV0dzJn?=
 =?utf-8?B?WGFXV1dxSTFNRzBwRmhXUFR6d1RGM3UxdkJZTExkZ0pJSlZyQmorajRzYUhm?=
 =?utf-8?B?OWFuanppdjBPV3crSGEzUUJuYXJkOUZGRU02RHh0SDVXT1BRUTFxZkdzbmRs?=
 =?utf-8?B?WTd5cXhPL05ldXVxdDJsK2c2dktJT1NVcllMWU5pR2R4VlNxSUdMbHBNaDRk?=
 =?utf-8?B?SE5LOVE4aDFLNkxIaFprdmE4aldMd1lvTXJidXBzaEZIZFBPcmJtOUsrblo4?=
 =?utf-8?B?Qk1KdmhSSGtSem1GNmJxTTQrbVU5RW1qSlE1endiNFZqMGpMbkNrUjBDTzdH?=
 =?utf-8?B?OFdmQ1U4K3k0WGlPZnA1LzY4ZkRBTG9lRjh0R1ZNbWJoeklERmdHSDhha1hE?=
 =?utf-8?B?Q2Yza1FVSjk0djM3YUJRT1BEUW9RRGtSWjFwOG9Bb1JBWE9PMVVvUWZ6NEJp?=
 =?utf-8?B?SGszVzlxampsb3VkWHVEdkV2cDNLNVNqTU8vNStDRDJCcmYxcDRDM3oyUHRH?=
 =?utf-8?B?TWZCUjc0eXM2YUQwdTdTTnlwWlJyMldDZHZuL3dnblRiU3NLeGEzVFI4TWxt?=
 =?utf-8?B?MFl6ZTZyaVFtTXk1ZW1xVWo0OXlidjNBL3VRKzUzckNrVHdmTW9jQ2pyaVN3?=
 =?utf-8?B?OHFuVXBkc0d3bU5KeDJYZDlEWkN6dTVQeHpTbEZ0cWVsdU5sOEdZQ293RWJm?=
 =?utf-8?B?cGtLYmlpYUtkWHZMRlQwS2xpV2tLSDZ6Sk9SdVhSdS9hbTVnaWhOWi93OGhs?=
 =?utf-8?B?VklCcVdKVmVpdStEendJVmQ1aXJHSzFsM0lyZUU3akpWZ0JwUVIyME00Q3Z0?=
 =?utf-8?B?TTBwSGhUemgyS21zWlo0aDVYUFkxOFhuRlc5RytXa2dqOHBQNGZDMUUrYTFR?=
 =?utf-8?B?U0dJNGhXOFNDZDIwUE0vUjVSWDFHbWJUckl4VGtnYXhFbXZJL2FCNzl2R3dz?=
 =?utf-8?B?YjFvYXhEcjNjUlVQWGRrdHhzUzNHM2poYktNZWVkRlRubHN2ODYzQ3VGSm5y?=
 =?utf-8?B?N1RVc3JLaEVETUR6ME83SEY0a1dMcGI0dm1kVjhwRGxmMm5WWjJBSmMyK0RD?=
 =?utf-8?B?L3R5Ylo1ZGZrd05LMldFaWgxRkFIRDhYU1BMNDdiL0NKZWlEb2ZMYUV6MGda?=
 =?utf-8?B?S01IWGMxbXE2LzZYVXh0THpUeHRvakMvZkNJWVV0QjFDOU5IK0dzZDZEOTNL?=
 =?utf-8?B?YjUzdmFwUXE5bTF2aThUOHdPcDVhK3JpcllDdElwNTI2ZWQ3NDdVdFJqQzhD?=
 =?utf-8?B?dktaU3hsNnlDQVZjem9SQ0c3NThxVWdHMVlSYUNxc0JGMTRTN21IVDlPOXF0?=
 =?utf-8?B?eGNTOFhGRmpaWDN5Q1dwWjJramlTaEVnQ2MrT1JSbXpOY3NPOWk0cm1yZEZD?=
 =?utf-8?B?STkwZ0JTc3JqSEppcXhET0Y2VTdpVnhybWFXVlFwcnozb1FpRkpXUFFXaWhj?=
 =?utf-8?B?SC9vT3NwSTE1QzVwV0U0Ulk4a1ErS2dWa2N5OFlxK0piellqd1U5SjlYQ3BM?=
 =?utf-8?B?QUJPN3BZT0R3dG9DUXhjZXhUYUdZTzAyMVRXdUZlL2xYU1NERXZLNTJMWGdo?=
 =?utf-8?B?RWRNdnBuL3g3cGZVMmlwUi9yZmZMTVovVGRQMkJHanlFaGJHNjg5NFVFVlRQ?=
 =?utf-8?B?S01IKzgrbmpCcGxYSEcwUThoVklZL05SQzEzMmVzS0o4d3psL1NaQ0F6RTZX?=
 =?utf-8?B?TUxPbi80SmNMTEtRbzVjeXI4aEdEeUwvS3RBZjZuNDRZTmRhSUQ3SXdLcEZy?=
 =?utf-8?B?RHZBR0ZuUUJ2R0FpRFRDWStLQzR1djQ3OEd0VXE5VitpY3p5MVM3UFd6c2p0?=
 =?utf-8?B?UGp4cklQU3lyMk9kVmJCZXFtcW9hZ0RJbFpiZzdSOU5CL2RFdVBtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3899.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c7e52b-e831-43e4-afe4-08da13e8a6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 14:05:17.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYApdY9tAcZkdEC7iN+wKy3sXKomU92PYC4QahLgQ77csYl3+5EuwycveK7tma/PJjXRylo7kUyv9pdNfgYvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6372
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5l
bC5vcmc+IA0KU2VudDogRnJpZGF5LCBBcHJpbCAxLCAyMDIyIDU6MjIgUE0NClRvOiBOYWdhcmFq
YW4gTWFyYW4gKFFVSUMpIDxxdWljX25tYXJhbkBxdWljaW5jLmNvbT4NCkNjOiBhdGgxMWtAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBOYWdhcmFq
YW4gTWFyYW4gKFFVSUMpIDxxdWljX25tYXJhbkBxdWljaW5jLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUuMThdIGF0aDExazogZml4IGRyaXZlciBpbml0aWFsaXphdGlvbiBmYWlsdXJlIHdp
dGggV29XIHVuc3VwcG9ydGVkIGh3DQoNCk5hZ2FyYWphbiBNYXJhbiA8cXVpY19ubWFyYW5AcXVp
Y2luYy5jb20+IHdyb3RlOg0KDQo+IEluIHRoZSAiYXRoMTFrX3dvd19pbml0IiwgZXJyb3IgdmFs
dWUgIkVJTlZBTCIgaXMgcmV0dXJuZWQgd2hlbiB0aGUgDQo+IGNoZWNrIGZvciBmaXJtd2FyZSBz
dXBwb3J0IG9mIFdvVyBmZWF0dXJlIGZhaWxzLCB3aGljaCBpbiB0dXJuIHN0b3BzIA0KPiB0aGUg
ZHJpdmVyIGluaXRpYWxpemF0aW9uLg0KPiANCj4gV2FybmluZyBtZXNzYWdlOg0KPiBbICAgMzEu
MDQwMTQ0XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgIDMxLjA0
MDE4NV0gV0FSTklORzogQ1BVOiAxIFBJRDogNTEgYXQgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRo
L2F0aDExay93b3cuYzo4MTMgYXRoMTFrX3dvd19pbml0KzB4YzgvMHgxM2E4IFthdGgxMWtdDQo+
IFsgICAzMS4wNDM4NDZdIE1vZHVsZXMgbGlua2VkIGluOiBhdGgxMWtfcGNpIGF0aDExayBxbWlf
aGVscGVycw0KPiBbICAgMzEuMDU0MzQxXSBDUFU6IDEgUElEOiA1MSBDb21tOiBrd29ya2VyL3U4
OjEgVGFpbnRlZDogRyAgICAgICAgVyAgICA1LjE3LjAtd3QtYXRoLTU5NDgxNy1nYTdmNmFhOTI1
Y2Y4LWRpcnR5ICMxNw0KPiBbICAgMzEuMDYwMDc4XSBIYXJkd2FyZSBuYW1lOiBRdWFsY29tbSBU
ZWNobm9sb2dpZXMsIEluYy4gSVBRODA3NC9BUC1ISzEwLUMyIChEVCkNCj4gWyAgIDMxLjA3MDU3
OF0gV29ya3F1ZXVlOiBhdGgxMWtfcW1pX2RyaXZlcl9ldmVudCBhdGgxMWtfcW1pX2RyaXZlcl9l
dmVudF93b3JrIFthdGgxMWtdDQo+IFsgICAzMS4wNzc3ODJdIHBzdGF0ZTogODAwMDAwMDUgKE56
Y3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJUWVBFPS0tKQ0KPiBbICAgMzEuMDg1
Njc2XSBwYyA6IGF0aDExa193b3dfaW5pdCsweGM4LzB4MTNhOCBbYXRoMTFrXQ0KPiBbICAgMzEu
MDkyMzU5XSBsciA6IGF0aDExa19tYWNfcmVnaXN0ZXIrMHg1NDgvMHhiOTggW2F0aDExa10NCj4g
WyAgIDMxLjA5NzU2N10gc3AgOiBmZmZmODAwMDBhYTEzYzQwDQo+IFsgICAzMS4xMDI5NDRdIHgy
OTogZmZmZjgwMDAwYWExM2M0MCB4Mjg6IGZmZmY4MDAwMDkxODQzOTAgeDI3OiBmZmZmMDAwMDAy
OTU5ZjIwDQo+IFsgICAzMS4xMDYyNTFdIHgyNjogZmZmZjAwMDAwMjgyODAwMCB4MjU6IGZmZmYw
MDAwMDI4MzAwMDAgeDI0OiBmZmZmMDAwMDAyODMwMDAwDQo+IFsgICAzMS4xMTMzNjldIHgyMzog
ZmZmZjAwMDAwMjgyMDAwMCB4MjI6IGZmZmYwMDAwMDI4Mjg1NGMgeDIxOiAwMDAwMDAwMDAwMDAw
MDAwDQo+IFsgICAzMS4xMjA0ODddIHgyMDogZmZmZjAwMDAwMjk1Y2YyMCB4MTk6IGZmZmYwMDAw
MDI4Mjg1NDAgeDE4OiAwMDAwMDAwMDAwMDAwMDMxDQo+IFsgICAzMS4xMjc2MDVdIHgxNzogMDAw
MDAwMDAwMDAwMDAwNCB4MTY6IGZmZmYwMDAwMDI4Mjg1ZmMgeDE1OiBmZmZmMDAwMDAyOTViMDQw
DQo+IFsgICAzMS4xMzQ3MjNdIHgxNDogMDAwMDAwMDAwMDAwMDA2NyB4MTM6IGZmZmYwMDAwMDI4
Mjg1OWMgeDEyOiAwMDAwMDAwMDAwMDAwMDBkDQo+IFsgICAzMS4xNDE4NDBdIHgxMTogMDAwMDAw
MDAwMDAwMDAxOCB4MTA6IDAwMDAwMDAwMDAwMDAwMDQgeDkgOiAwMDAwMDAwMDAwMDAwMDAwDQo+
IFsgICAzMS4xNDg5NTldIHg4IDogZmZmZjAwMDAwMjg5ZDY4MCB4NyA6IDAwMDAwMDAwMDAwMDAw
MDAgeDYgOiAwMDAwMDAwMDAwMDAwMDNmDQo+IFsgICAzMS4xNTYwNzddIHg1IDogMDAwMDAwMDAw
MDAwMDA0MCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiBmZmZmMDAwMDAyODIwOTY4DQo+IFsg
ICAzMS4xNjMxOTZdIHgyIDogMDAwMDAwMDAwMDAwMDA4MCB4MSA6IDAwODAwMDhhZjk5ODE3Nzkg
eDAgOiBmZmZmMDAwMDAyOTU5ZjIwDQo+IFsgICAzMS4xNzAzMTRdIENhbGwgdHJhY2U6DQo+IFsg
ICAzMS4xNzc0MjFdICBhdGgxMWtfd293X2luaXQrMHhjOC8weDEzYTggW2F0aDExa10NCj4gWyAg
IDMxLjE3OTY4NF0gIGF0aDExa19jb3JlX3FtaV9maXJtd2FyZV9yZWFkeSsweDQzMC8weDVlMCBb
YXRoMTFrXQ0KPiBbICAgMzEuMTg0NTQ4XSAgYXRoMTFrX3FtaV9kcml2ZXJfZXZlbnRfd29yaysw
eDE2Yy8weDRmOCBbYXRoMTFrXQ0KPiBbICAgMzEuMTkwNjIzXSAgcHJvY2Vzc19vbmVfd29yaysw
eDEzNC8weDM1MA0KPiBbICAgMzEuMTk2MjYyXSAgd29ya2VyX3RocmVhZCsweDEyYy8weDQ1MA0K
PiBbICAgMzEuMjAwMzQwXSAga3RocmVhZCsweGY0LzB4MTEwDQo+IFsgICAzMS4yMDM5ODZdICBy
ZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiBbICAgMzEuMjA3MDI2XSAtLS1bIGVuZCB0cmFjZSAw
MDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gWyAgIDMxLjIxMDg5NF0gYXRoMTFrX3BjaSAwMDAwOjAx
OjAwLjA6IGZhaWxlZCB0byBpbml0IHdvdzogLTIyDQo+IFsgICAzMS4yMTU0NjddIGF0aDExa19w
Y2kgMDAwMDowMTowMC4wOiBmYWlsZWQgcmVnaXN0ZXIgdGhlIHJhZGlvIHdpdGggbWFjODAyMTE6
IC0yMg0KPiBbICAgMzEuMjIxMTE3XSBhdGgxMWtfcGNpIDAwMDA6MDE6MDAuMDogZmFpbGVkIHRv
IGNyZWF0ZSBwZGV2IGNvcmU6IC0yMg0KPiANCj4gRml4IHRoaXMgYnkgcmV0dXJuaW5nIHZhbHVl
ICIwIiB3aGVuIEZXIGRvZXNuJ3Qgc3VwcG9ydCBXb1cgdG8gYWxsb3cgDQo+IGRyaXZlciB0byBw
cm9jZWVkIHdpdGggaW5pdGlhbGl6ZSBzZXF1ZW5jZSBhbmQgYWxzbyByZW1vdmUgdGhlIA0KPiB1
bm5lY2Vzc2FyeSAiV0FSTl9PTiIuDQo+IA0KPiANCj4gVGVzdGVkLW9uOiBRQ045MDc0IGh3MS4w
IFBDSSANCj4gV0xBTi5ISy4yLjUuMC4xLTAxMTAwLVFDQUhLU1dQTF9TSUxJQ09OWi0xDQo+IA0K
PiBGaXhlczogYmE5MTc3ZmNlZjIxICgiYXRoMTFrOiBBZGQgYmFzaWMgV29XIGZ1bmN0aW9uYWxp
dGllcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE5hZ2FyYWphbiBNYXJhbiA8cXVpY19ubWFyYW5AcXVp
Y2luYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEthbGxlIFZhbG8gPHF1aWNfa3ZhbG9AcXVpY2lu
Yy5jb20+DQoNCj4gRXZlbiB0aG91Z2ggSSBhc2tlZCB5b3UgdG8gbWFyayB0aGlzIGZvciB2NS4x
OCwgSSBub3cgcmVhbGlzZWQgdGhhdCBjb21taXQNCj4gYmE5MTc3ZmNlZjIxIGlzIG9ubHkgaW4g
YXRoLW5leHQuIFNvIEknbGwgYXBwbHkgdGhpcyB0byBhdGgtbmV4dCBhcyB3ZWxsLg0KDQpTdXJl
IEthbGxlLCB0aGFua3MgZm9yIHNoYXJpbmcuDQotIE5hZ2FyYWphbi5NDQo+IC0tDQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIy
MDMzMTA3MzExMC4zODQ2LTEtcXVpY19ubWFyYW5AcXVpY2luYy5jb20vDQoNCj4gaHR0cHM6Ly93
aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1p
dHRpbmdwYXRjaGVzDQoNCg==
