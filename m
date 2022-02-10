Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCFF4B1229
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 16:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiBJP5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 10:57:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiBJP5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 10:57:41 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CBA1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644508661; x=1645113461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RSD7YIkiDUNGggMQLdikMxjZweqO5Q7h0sFo2VupULU=;
  b=xyC8ZI57g0nTuKWOmV4o+WCeCNBICxZ5RfhTe/UnyIer31cpMhmqEsy6
   Y0NbycIZBdsVhPZ0cDdmCTRQg1v33xy29uaulg1GPkAGcOQPYgzgeM1/m
   H2M6qSPwGJsFul9hGuSHE97egejawHA07J1s12RVIy7pjYe2s7nV55aZ/
   A=;
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwXUZxXZLcj0WKnLm4YRS9ulvrZVo9DydYnJoU+j9SAA0FNQCdUtXquHrA1+Vuzlv19T9tTkILzffU2JYUYM0FoIGeOI30CXHH98cXgvveuZl06dTqpG6wrWxjed1tiNUxvgJB56DHK8R/sTCrYun8EyejLRi440kd9z7bRWVrbONkP60oh9sEF4pninPE90NFxvIUMeLbmqvp7hVLDVDQmVEEBXX0vk9VaDsr2WoEqfRl3LorwFGIefPumsG7xg/IKbHwkeg2p3F6hhM9RVG+yZduuQvyEUPXVR52nfxa6sRkZyCCmygNPFv/Yy27ogkWN3YehRG8cLTmqmIYCd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSD7YIkiDUNGggMQLdikMxjZweqO5Q7h0sFo2VupULU=;
 b=irKcldjM95TkCHZUrjxqbuJXt4vstgnZPpuIMsNTjW15L6iLdgm/tNlcmXb3hyfY7JBEkS8DWWhjOAknBxbGMF2i0ZjtSW2x1d/i9Bq3/Fdn7RxauzzXdLBwj0yfh8G4TCv83od/LV6hroAFlh0LrPyYl50+krZF0dIcFHHh6IoX0gWTNT70EBm/LL2dq75Z7g5BRN4kydnd5H0NIPQe9/gOemMb6yYKh/64+rzoZxfi2dk1zRLj4wEJDkT+pYDndaeHtTBm8OgK9Xx6LKu6zeZCU28kuZd9f8U5OceAPLWE0Yzw4Cil0CuMnRJmB/E6Jct6vo0yivyaCGPjZG1CUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR02MB7958.namprd02.prod.outlook.com (2603:10b6:8:13::19) by
 MW4PR02MB7105.namprd02.prod.outlook.com (2603:10b6:303:70::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Thu, 10 Feb 2022 15:57:38 +0000
Received: from DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9]) by DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:57:38 +0000
From:   "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>
To:     'Johannes Berg' <johannes@sipsolutions.net>,
        "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Vikram Kandukuri (QUIC)" <quic_vikram@quicinc.com>,
        "Jia Ding (QUIC)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "Veerendranath Jakkam (QUIC)" <quic_vjakkam@quicinc.com>,
        Aloka Dixit <alokad@qti.qualcomm.com>
Subject: RE: [PATCH 2/6] nl80211: add support to advertise driver's EHT
 capabilities
Thread-Topic: [PATCH 2/6] nl80211: add support to advertise driver's EHT
 capabilities
Thread-Index: AQHX9xMZbu2tD2Lr8EyrjmTcX6eyyqyMi5aggAA2IACAAC+cAIAATl6F
Date:   Thu, 10 Feb 2022 15:57:38 +0000
Message-ID: <DM8PR02MB7958662AC1065ED1D409AA90FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
         <DM8PR02MB795853BB4B1C71B20857D2D3FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
         <793a595932ea0adf7a72eeafb6ababdae8e21fc2.camel@sipsolutions.net>
 <bdc46437131fc41a1e3217099ca9395ca3c63b41.camel@sipsolutions.net>
In-Reply-To: <bdc46437131fc41a1e3217099ca9395ca3c63b41.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b9de44-0606-49c0-0676-08d9ecae0fcc
x-ms-traffictypediagnostic: MW4PR02MB7105:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MW4PR02MB7105C94B63A749844CD7C019822F9@MW4PR02MB7105.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIeiitpuHzIzVMIRvlx9pXK76TWAy7DGsnY4NQK+zX3JVnQN9h7HDB0ahQ9YRqXXL6b+opjez0urwelttdk0XEJ2s2pnCuAeF+qYtrlj+IJADHvSW8sncW3o9HKJ1D4iDY4sgiAyLOF+kROIpiPjarFvev1I7ma3yhBI+Z1hfMATtF6SP4J7MMoE1ELfeub7U/k417tJ1SV43DwdoO2iFRfdi1+xEEl4VcqbhE4a71vF+7HsZ4IQ06gF5X7+x9Dr5rnCRfkgWO4/m49G6BsIXbt9JN7Fg8Zc09g7nY+5o9D4oUtk5ujY1xVycQF62mE9YoJ7Zl5r6wkYG8Kam+emtbvx5b5xBjmYfYY5WrirlRvpEE7+J0Vn+RxWy9Ucj397PCWC/LbsJSU22O10cySbc/PdEYGXkMuH0LtZSx6yiujgIcHQDgL0wd5plDyQ0LrXwfSA6JM1arZJJ31t6ht3j1fD3UBMiXd5eqXnpDorVR/PLRJhmd1JgVyt6WWHoaspkKb8NkdeeupGTsnOqBXUd4a+vIrD6fH4snP5s6feIeSs0zh8QGwsc5lizIo2GMgcXRQ61PTu3DEmVPgU51EaesI/TjLt+W7LPk8KezrQY5UFtleHIE3aLqnRL6C52KaEP+bN2kOKJFr/D+7YEO4sgPtnx7FvqwLd80BKTJI67rhunTXIp+rzfR5R6JZaTDoWAeRrQ3Y+5HARMdWT48W2v2CSJ+qUnBk758fh0w4MERNSfrBmTN8C+BmWzQiOoE92hB/+ZkGxsJZnWtnT/y9gliH4/5eANtV4v0WohBCsUUbf5qZhqes6orhp9DbdXoPqZo+QFwKpyswptTXtGTCfCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(107886003)(508600001)(186003)(6506007)(122000001)(55016003)(316002)(64756008)(8676002)(66556008)(33656002)(9686003)(2906002)(76116006)(26005)(7696005)(66446008)(71200400001)(66946007)(66476007)(8936002)(54906003)(966005)(5660300002)(86362001)(38070700005)(4744005)(4326008)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGxuY1IveUhnZ1prVDFtcENIdE91M1hNaUZFN1VtOFpwNUVRT28wcWZ2TTF6?=
 =?utf-8?B?a0Y5T1o4Smpwd2tScDNYWlZSNnF1UDlGK2J2UmJUbzV1QzEwOUZQOW1xd0E3?=
 =?utf-8?B?WUlSV0QzbVcxSFZleXU2QXJWZmI1Tk5KWit5dVUyYWxiME1pb3ZKNlNPR3dE?=
 =?utf-8?B?d3pZdXA2V29aYktqb0R1cDZZbXgyZEhDaSt2ZTFPUUtXZGpvWCsxSG9OeXhY?=
 =?utf-8?B?S2MrbnZZRVVPWUZwYzR6cVhzSVl3bDZKYytPLzE3SG16M2Raby9YSzNMcG5i?=
 =?utf-8?B?ang4cmxBSjZmdldBa0UxYWhWeVJNNjRWakZhYlJZaFZ6aXI4QUQ1V0V4QUdB?=
 =?utf-8?B?eTNzYTdZbGJUc2UzTTVoUWQ4b1hQU2tBQjdTSHR4Vlp3WVcyTlRUUHA2T0hj?=
 =?utf-8?B?RmhzR2E2aU1NQm8rMEJRL1VOckxWbjhFbHJuclBDSVAvSzg4MUQyaE15cjNp?=
 =?utf-8?B?VUJ2Z0VpWDBZWjFZTEVlNTE0dUNRbmFLWGlraWg4bk0xK0hhWkdETVNWOVRl?=
 =?utf-8?B?Q0dTWjZLRkYzWVFiczlOREZRMEx5RHFwYXZkQ1RRVDFXd3RqK0k1K2huOXgv?=
 =?utf-8?B?K2x3VnFNN1pqb1YrZ3Jnby9LMEJqU1ZkQW02YlJ0WHo4dDRSc1EreFBtVkg3?=
 =?utf-8?B?RmNVc2R1Y2hKdWJiNExLaDBxMS9XYXhpTlora2xWSUE3VTd1OG5hVHhFa2Vq?=
 =?utf-8?B?RGRKM3piYURra2JrNlJrQzFJR3dvdWVDZENPSVZRRUplMnhYSmJ6NGZaWlNC?=
 =?utf-8?B?TGQ1dTlQclpsNkU3WXdrT1RIRmJoVlhveDZoaGd1WE84YVU3azgvL0Jud0hi?=
 =?utf-8?B?UEY4V1hEYkJraDZWZzVQTlJadG5YSW56Ri90azVJR2c2ZE5UdTd5aFk2ckx0?=
 =?utf-8?B?anJOK25sM1RRdFArMFI3UUxyOTIvbVF4ZkVtSU5wWmJlVm5iR2E3WmZHUUFz?=
 =?utf-8?B?SU54MExoa1BhUGJvOENXK3IyNU83MkdKQWRLa1A2RmhZUWlMQStlbjFBUW1q?=
 =?utf-8?B?WGZXSHovUkhvcFJjMXpzTlNvNk5obmRNL0t3Y2pmNGhkTi8rWTlKOUx1WlNW?=
 =?utf-8?B?YU1Pb3FjV3I0clBwKzZUMlpKMkNnWjhmTGVJS2hUTFlCRGlOZW1PU05USkxW?=
 =?utf-8?B?TjRrcFRJbE8yUXNodEc4VGFneHREZ2VqMzduUUZYUnlxaVlxbm16TXZRUmtL?=
 =?utf-8?B?Ly9pZ3k1ZVdDZHNhOTU2NnA1bSsyWm9BRmV1UnUyZkZxU3QxTlhvK0ZjTGZT?=
 =?utf-8?B?cGR2Y2N2c2VLNFlyeUZzS1dHa0JSSGQyM0VqTDhSaDduVWhDVU05TUxxWExE?=
 =?utf-8?B?eEFNdTBYeTlIQXNqREE2RU5BSlMxRVdhZ2Y0bW01NE9oSWZOdlI4NFdzdHNS?=
 =?utf-8?B?QnhxYlNzd09HUGJMZHBmQU9Pb3FFV3BJY0JHWEd1ZjJNZk9OU0N2ZUFXUmE2?=
 =?utf-8?B?cUl3T1NxOEliYkdhdWJCYldId3RqYlVoSnZLME53L0NYUEhPRzdHcWRoT2hn?=
 =?utf-8?B?VU13ZFNQM0pwK0xuYnFOenJLRXJmYUVTS3E0cXdyK1NIOERhZ05JS0l1dzND?=
 =?utf-8?B?K05FSVFxeDY5Z1ppemRYL3dyc0huekIwU3d1WXJndmRIY1FILyt3ekkxcVll?=
 =?utf-8?B?bTRnZWhFVERKNnM3dFEySEowd0hZN2hHaUlXa2RqczNHRmVNYnI5NDd1b0cx?=
 =?utf-8?B?R1ZSSFoxaUpKUWozZzNqSGVmcE0reXMzSi9OWE1HWVJDZ0RObElFVUtXN0ly?=
 =?utf-8?B?U0phcGRMYlZNVUN1QnJEUGtYOVNmWjJTSnl4UFFJc3hEU2I1b2FESEg2Rmdi?=
 =?utf-8?B?K0VjUDVqc0VWWnFtcjNraGJQOHMzMDF2cnhndmtFOTJ3aVdnN0NCYlNKWDVp?=
 =?utf-8?B?R0NueW4zakdMOFJ3UkNRQVU5dGt1dm54N085NUxBTXRMcXFqTDdTeitHa3la?=
 =?utf-8?B?MUNnSXIvZzY0V1BJbXBWcW83cXpqWVNaK1lrUlg0d2pvczZhSHpzbUdNQXAr?=
 =?utf-8?B?TFJMbmdwdlhucHhJK3JEWHROQlUzV2xzZk85RjVLaE1QQkZ4SWNkQnVqN0Zm?=
 =?utf-8?B?RnRuaHBEZ09XYkJZZjMrb3F4K0g2VmVwU25pYXFtdHQzbU90U2hkUnNFTloy?=
 =?utf-8?B?S1hwelNXVWZFVlBWalhnanM0N2xEM3F0cHJSeDg4d3ZETUtFR0duMlNtekdj?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b9de44-0606-49c0-0676-08d9ecae0fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 15:57:38.2348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLQJ1dEhGEKyL3RryyIukovkyFU1EgpqzkWtZGs5MfBZ6T4Ess/ipFFqFgr2iT5+4+y9rxC60NntxkPb9ky+Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7105
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBXZSBkaWQgc29tZXRoaW5nIGxpa2UgdGhhdCBpbiBvdXIgcGF0Y2hlczoNCj4gDQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIy
MDIwNDIzMDExOS5iMGVlYjUyN2Q3NjEuSTI0MTNhMzdjOGY3ZDJkNmQ2MzgwMzhhM2Q5NTM2MGEz
ZmNlMDExNGRAY2hhbmdlaWQvDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIyMDIwNDIzMDExOS4xZWU5MjIwMmFjMzAuSWQzMGEz
ZWYyODQ0YjI5NmVmYmQ1NDg2ZmUxZGE5Y2EzNmE5NWM1Y2ZAY2hhbmdlaWQvDQo+IA0KPiBOb3Qg
b3ZlcmxhcHBpbmcgd2FzdGVzIGxpa2UgNCBieXRlcyBvZiBtZW1vcnksIEkgdGhpbmsgSSBjYW4g
bGl2ZSB3aXRoDQo+IHRoYXQsIHZzLiB0aGUgZXh0cmEgY29tcGxleGl0eT8gSWYgeW91IG92ZXJs
YXAgeW91IG5lZWQgYW5vdGhlciBiaXQgdG8NCj4gaW5kaWNhdGUgd2hpY2ggb25lIHlvdSdyZSB1
c2luZyAuLi4NCj4gDQoNCk9UT0gsIHRoYXQgbWVhbnMgd2UgbmVlZCB0byB1bndyYXAgaXQgaW4g
dXNlcnNwYWNlLCB3aGljaCBpcyBhbHNvDQpzdHJhbmdlIC4uLiBTbyB5ZWFoIEknbSBjaGFuZ2lu
ZyBpdCB0byBhIHVuaW9uLg0KDQpKb2hhbm5lcw0KDQpNeSBjb21tZW50IHdhcyBhY3R1YWxseSBh
Ym91dCB5b3VyIFBhdGNoZXMgYnV0IHJlYWxpemVkIEkgaGFkbid0IHN1YnNjcmliZWQgdGhpcyBl
bWFpbCB3aXRoIHRoZSBtYWlsaW5nIGxpc3Qgc28gbmV2ZXIgZ290IGVtYWlscyBmb3IgdGhvc2Uu
DQpTbyByZXBsaWVkIGhlcmUgKGFzIEkgYW0gaW4gY2MpLCBqdXN0IHBhc3RlZCB3cm9uZyBsaW5r
IPCfmIoNCg0KQnV0IHllYWgsIHVuaW9uIHdvdWxkIHdvcmsuDQpUaGFua3MuDQo=
