Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BBC4D9AB9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 12:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348078AbiCOL5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347986AbiCOL5f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 07:57:35 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1A517F4
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647345383; x=1647950183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AzFHxQ8gP6Kia+BMidIOYDLC/8oFSvk8c9RQIBGmCcc=;
  b=mjSH5TRPoqOijs2wGsdpXS7jHJoaXxQhR4OBzuuaJb19+Vm9YG2/+7D5
   TChMslWYKGnZKLtxh9SHozHKngspmIJL+I8BjiuyL2Yq0pfArBhuHpb67
   gTL36Lr1/19BjYPob4pqn4H++Hk//oPA0mF4XoOq9VUUianLwnvgDWWH3
   4=;
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 11:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUi17haTPQrktbynSpDLjyftcgj4DiqD6DNJWli5bVhW0XyqfRtUOuaDIuTRMn+SyiFLIZ+GI5wfCU9iuIBFMFy5aEs2gxL5fgUZAe5fGLbC97Cv17KHVFXXYBOrrcHUl4M3BS6NZWLmwkyy9dtm29np1EzHDceVxDjllj+e95ZJJezVCbWZEg36SaL+yYhJd6CH3Hym3vDa6Xc8+dKmSXStDyFTW7k8UlxFCw9PMI9Ha7Gp+RyPkKo17Sps2lijlFurfNDUf1CDDFLVHU/jXV5s3+9lhq4/bfeRqehCZIC8KlI1onV7Qlkcx+kCKO0GtUwEQMEQdXSrvn5uH+JOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzFHxQ8gP6Kia+BMidIOYDLC/8oFSvk8c9RQIBGmCcc=;
 b=koLkeQS4rB8GYMqH/pA/DBfPNovoyM2iHP/HBt+m/kTUg2QAQrN0nHC9BtaMyNi0fhjYxxDpN6TVRHbvSyKGSyVSta1RS9ywXP7aceuxgimsWcoSEFannqTGtdM5vxBf1Fbnro1J2wIg/Lp7B4Q+rcfue7dM9cdfjaAHucOxKgQsngaHwrusq63hmdBtu+uFwpM8IlNZeTcZOZiAbm//InGA8zw/xCU0ecnemImGlchkFgLxboqBpULbUvrL/W0O6zPy2htXXwGbNfv9/T5vViOiGmFjfl9nYzV6RP5h/ZvSjmuxfDqR8bn3yG4R6oNM5k0Jc6nffqG8BEuBO6NoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8154.namprd02.prod.outlook.com (2603:10b6:8:1b::15) by
 BN0PR02MB8269.namprd02.prod.outlook.com (2603:10b6:408:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 11:56:19 +0000
Received: from DM8PR02MB8154.namprd02.prod.outlook.com
 ([fe80::6da7:2584:aa5d:c39]) by DM8PR02MB8154.namprd02.prod.outlook.com
 ([fe80::6da7:2584:aa5d:c39%3]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 11:56:19 +0000
From:   "Venkateswara Naralasetty (QUIC)" <quic_vnaralas@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Venkateswara Naralasetty (QUIC)" <quic_vnaralas@quicinc.com>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCHv2 1/6] nl80211: vendor-cmd: qca: add command for CFR
 configuration
Thread-Topic: [PATCHv2 1/6] nl80211: vendor-cmd: qca: add command for CFR
 configuration
Thread-Index: AQHYIxy/nrTVybcuGUaoD9WQtSpD/Ky6KVMAgAZXzMA=
Date:   Tue, 15 Mar 2022 11:56:19 +0000
Message-ID: <DM8PR02MB81549B15CB1855C71ED4D330E6109@DM8PR02MB8154.namprd02.prod.outlook.com>
References: <1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com>
         <1645005922-7252-2-git-send-email-quic_vnaralas@quicinc.com>
 <623add710d06dfd90291cb788756d37046ea2c74.camel@sipsolutions.net>
In-Reply-To: <623add710d06dfd90291cb788756d37046ea2c74.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8d52af3-82ba-454e-c61f-08da067ad17d
x-ms-traffictypediagnostic: BN0PR02MB8269:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN0PR02MB82697B24FFB25EEB1F2A2BDD9A109@BN0PR02MB8269.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuVmtht67skdrxLAe7ClRWvS4ZlNV1TX/xl3zw4a2CyP/wLBIQcJP77xHjhA7c6QjuWCHoydMS8vzbEcXQWMRCrl3PdzUPAhClvzytkJ/JEbmXZPwk/F1g0cGV5ZQer2Poyp4KblOxTXUQ3iefPruRnPlhzUHEU9XkGTuNkMcazLgAMw6NHJo1oA+RDUi8LSR3NTsB8XE5PxyO5K0bipjAnmpHWSPyWLkVxqsYNG54TAnsZnd1eQzSXKaLTn/hj4i+RFoF5qo3Wt2CL3l/ndOWWfvTcqD2ZzsQBoy2LBb7wovjMUGTtp5dbf/53FnWY+iB9FYGpGFrUmCeisLXA0QvgldNSuHxG8jD7SemL5Kvht47YtBWCDE2snB5kuvEhA8w/awSZxCSYD1hG4wyBNQ3UBtMWC8gMiMv17c2SjauSBm9j+Do3CIDNjIgzqIGr2pGJJ9NLPwEkj+OdzW8Z8qHz/iwqp+CR6OKo186S2FBn6v9g9pB3tr6/y4Hbt3PmNsqfb9Ya3flewnqQIXfxQGN5FEPL2nu5C61qsCLBYM3LVK9QwYol2V8yDmnIbKBRYb/CLUw8fA4+3zemGfNMk9IseirTfjeUISt2D3OWue57dwe39N/q6jlV73xlLFcYcb/KxHIC+J2IO9N3sBBXcTplToWEEh0ZSkBr+9ngAXKPSp7P0XnBPw//eYoaUeuoSbPAPfF7ODIvmzR1stm+A3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8154.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2906002)(508600001)(38100700002)(110136005)(76116006)(8676002)(4326008)(66556008)(66476007)(66446008)(66946007)(64756008)(55016003)(71200400001)(8936002)(316002)(38070700005)(122000001)(83380400001)(9686003)(7696005)(6506007)(5660300002)(26005)(186003)(33656002)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWtJakYrWW5sTG9tNVg2SmUzZ1VGQ1VxQWRqQnpzKytLRFFnTWlOSDNucnUz?=
 =?utf-8?B?cWd6eEZMempQcW5rVEE3RXQ0NjFSOXFtaVEwZE9wZEhkblZIazlINnFMTVJU?=
 =?utf-8?B?L0Z4RGYxejZFcjI0MlNFT1E0VEo3UW91Nk9NMDl3UHY4dzJCOGlEWERNWWF4?=
 =?utf-8?B?bEVoQ05DWUxUMUJPQVF0QXdtNCtUZHBVVlNTcSttdk9UcmVNa2U3WWUxU01y?=
 =?utf-8?B?VnB5YTlWbkdCak4zalVtRmZveVppMU9jcG1vN2tsUmMwNEtrWE9DN0VFaFY1?=
 =?utf-8?B?RGhZaThNM3ppUFFYaUVpWE94ZDFZRGk4RmRveVNjWWhjOUsvcDdqd0ZDWi9Y?=
 =?utf-8?B?dW5GR3N3N0IwbUFpNkl4dENnTUZrdjRNQmJDZ2ZsYlhseTNEZUlSVFM5RDdC?=
 =?utf-8?B?ZS9Sb0R0dE1wZ3hZVkc2d0RRdGVxdXUrR2RVY21uVkJ6S1F1UHBFQlh3Tjlk?=
 =?utf-8?B?aitMa0x6YlV5cE9tSDhZWHhIUDFXVTQrWTdyby9OYlMvcWpUVXRZeG9md0M5?=
 =?utf-8?B?VnVGc3ZEV2pnVXp5Y3VmTkZhOU4zQ1VRdmxBME9XSFlySlN1ZllJOEsxb0tu?=
 =?utf-8?B?aGJJellFZ0V1M2d3ZkJxVlo2Vkl0WjVXZmNBZW5waG9HdXUyUHFRRVpUOWs3?=
 =?utf-8?B?T3RJV3VFRFA4RHJKOG9FQnQvR0hNSVNTeDEzaXM5Njd2WXlxdlZtbTdqRVpS?=
 =?utf-8?B?T3dSZmVJVWk1S2djVVEvLzlOd0s0cS9sZTRUaHN0cHZYMVBXUDZMdEVLbVZQ?=
 =?utf-8?B?UnNrS3FuYzB6M0REUy94RHpMSHE1NEtGMGVkY1BsdkY5enNicHN1cnpLK1Fm?=
 =?utf-8?B?QjNtUVE2bi9BRFczTlNrVEZ2aVpXTndpd3UxQU5wcjRzYUdTTk1BbjN4V2ly?=
 =?utf-8?B?a1RlWFIvQjFIMHFnZm1XRmU1ZldLMzRhMmk1YkNmRXJXNDl3MC8wcTdobVNp?=
 =?utf-8?B?dDU3a1YrRHVIc0kzaVdDL0J3dUpKdWo0WUJ3Zkhod1ZzVkp4T2QvcS9iQ3Bt?=
 =?utf-8?B?SEZWdUNHZ2ZxWDNTNWg3MWdKMGtRdnhxOXVQY1loWXJucEViSGNJalMwcFpU?=
 =?utf-8?B?eUNncENUWFlra2VZYmFiTTcxcTVoT1RrYURhRkVXVm9rRkZsYndrWmx0QnJy?=
 =?utf-8?B?OElIRzcyc0tLc0pyb3pIOWtLcjZsZDhhZjg5d2FmNzc4U1phQlJJaGhKeXRQ?=
 =?utf-8?B?ekJkUUFrY3N2STJHTDNLQWhybHRGa1hQQ3hUK2lvb0RXZTdCT1lVZzZyZGVx?=
 =?utf-8?B?enM5YUFoanZ3ODNFcHhJZlB4c2d3a0ZGYmFvVEdCbys2THJwTjVnQ1ZibWZn?=
 =?utf-8?B?ZnhpeUEyUGlvZk04MG1DQUpCZGhSN3c4N09iRDRVbzZQRDdzdHNMemhOcE9L?=
 =?utf-8?B?T2RHeTE2UjNybzNjRTc4dTc1cFJuMW9MeGs5ZDNja01mZXczOEg0cmk5WWZa?=
 =?utf-8?B?RW9HcmE4NERhNStXUFRhb0svRFRJdWxZbjJGYTAxLzVHUDNvUk1YY1hKVFVL?=
 =?utf-8?B?TXNIUUZuV1RNaWRJK0Z2UllJaGh4MndKSmVscjlaK1kzcVNuRlQ3MGhXOURK?=
 =?utf-8?B?WWUvdjhWMDlNNjNlRWpMclhIV25WczFsYWZSeVkrY3JYR01WTm5yamExVk0y?=
 =?utf-8?B?OHRuTDQ0aGlibFhrNG96U091T0ZvZHFVdWhqZFIyZGQ3TXc2b3RDVkNYL20z?=
 =?utf-8?B?emtFWFdyektNTXp0R3RObnc1bnJsdXd3akpTZmdrYWNWdVBwT2J0NUEyUkZB?=
 =?utf-8?B?T2M5ZXV1UVErbHhVZlZsZHY2UTAzYTZqYjRTVGUzOUozZ2ZiS01WTkI1L1FX?=
 =?utf-8?B?bFFYaXZ2TDR6K3hLcWlEcDVmS1FiSzU1YXdmZmNUVWhpKzg3TDN2Mk81WnE0?=
 =?utf-8?B?SXFtNlc4SUd4ZmhWaG5hZmJLejRBRGhhNjlhU3pkTWZIVDZ6aWg5THQ2QVNz?=
 =?utf-8?Q?Yix2ebccg3+QbIEgVZpmSsNySHPhLKGy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8154.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d52af3-82ba-454e-c61f-08da067ad17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 11:56:19.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPzd8s/zIA/XnIdRr5IHBrcnrqVX3dImjcH6LmzIxaJvpGB3CgbnT3A/zykT12s2kVXBiSU9lhjVjzJ49CsyRRLfAQ5s+M3gbsPB9F1dhFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8269
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDExLCAyMDIyIDQ6
MzQgUE0NCj4gVG86IFZlbmthdGVzd2FyYSBOYXJhbGFzZXR0eSAoUVVJQykgPHF1aWNfdm5hcmFs
YXNAcXVpY2luYy5jb20+Ow0KPiBhdGgxMWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2MiAxLzZd
IG5sODAyMTE6IHZlbmRvci1jbWQ6IHFjYTogYWRkIGNvbW1hbmQgZm9yIENGUg0KPiBjb25maWd1
cmF0aW9uDQo+IA0KPiBPbiBXZWQsIDIwMjItMDItMTYgYXQgMTU6MzUgKzA1MzAsIFZlbmthdGVz
d2FyYSBOYXJhbGFzZXR0eSB3cm90ZToNCj4gPiBDaGFubmVsIEZyZXF1ZW5jeSBSZXNwb25zZSBm
ZWF0dXJlIGlzIHRvIGdldCB0aGUgY2hhbm5lbCBzdGF0ZQ0KPiA+IGluZm9ybWF0aW9uIGZyb20g
dGhlIGhhcmR3YXJlIGJhc2VkIG9uIHRoZSB1c2VyIGNvbmZpZ3VyYXRpb25zIGFuZA0KPiA+IHNl
bmQgdGhlIENTSSBkYXRhIHRvIHVzZXIgc3BhY2UuDQo+ID4NCj4gPiBDU0kgZGF0YSBpcyBmdXJ0
aGVyIHByb2Nlc3NlZCBpbiB1c2VyIHNwYWNlIHdoaWNoIGNhbiBiZSB1c2VkIHRvDQo+ID4gaWRl
bnRpZnkgdGhlIG1vdGlvbiBvZiB0aGUgb2JqZWN0cy4NCj4gPg0KPiA+IEFkZCB2ZW5kb3IgY29t
bWFuZCBzdXBwb3J0IHRvIGNvbmZpZ3VyZSBwZXIgcGVlciBDRlIgcGFyYW1ldGVycy4NCj4gPg0K
PiA+IEFuIGV4YW1wbGUgb2YgdXNhZ2U6DQo+ID4gaXcgZGV2IHdsYW54IHZlbmRvciBzZW5kIDB4
MTM3NCAweGFkIGNmci1lbiA8dmFsPiBidyA8Ync+IG1ldGhvZA0KPiA+IDxtZXRob2Q+IHBlcmlv
ZGljaXR5IDxwZXJpb2Q+IGFkZHIgPG1hY19hZGRyPg0KPiA+DQo+ID4gMHgxMzc0OiB2ZW5kb3Ig
aWQNCj4gPiAweGFkOiA6IHZlbmRvciBzdWJjbWQgaWQNCj4gPiB2YWw6IDAgdG8gZGlzYWJsZSBD
RlIgY2FwdHVyZQ0KPiA+ICAgICAgMSB0byBlbmFibGUgQ0ZSIGNhcHR1cmUNCj4gPg0KPiA+IGJ3
OiBDRlIgY2FwdHVyZSBiYW5kd2lkdGgodXNlIHRoZSB2YWx1ZXMgaW4gZW51bSBubDgwMjExX2No
YW5fd2lkdGgpDQo+ID4gCTEgLSAyME1IWg0KPiA+IAkyIC0gNDBNSFoNCj4gPiAJMyAtIDgwTUha
DQo+ID4NCj4gPiBtZXRob2Q6IE1ldGhvZCB1c2VkIGJ5IGhhcmR3YXJlIHRvIGNvbGxlY3QgdGhl
IENGUiBkdW1wDQo+ID4gCTAgLSBmcm9tIHRoZSBBQ0tzIG9mIFFPUyBOVUxMIHBhY2tldHMNCj4g
PiAJMSAtIGZyb20gdGhlIEFDS3Mgb2YgUU9TIE5VTEwgcGFja2V0cyB3aXRoIHBoYXNlDQo+ID4g
CTIgLSBmcm9tIHRoZSBBQ0sgb2YgcHJvYmUgcmVzcG9uc2UgcGFja2V0DQo+ID4NCj4gPiBwZXJp
b2RpY2l0eTogUGVyaW9kaWNpdHkgaW4gbXMgYXQgd2hpY2ggQ0ZSIGR1bXAgbmVlZCB0byBiZSBj
b2xsZWN0DQo+ID4gCTAgLSBzaW5nbGUgc2hvdCBjYXB0dXJlDQo+ID4gCW5vbiB6ZXJvIC0gZm9y
IFBlcmlvZGljIGNhcHR1cmVzDQo+ID4NCj4gPiBtYWNfYWRkcjogbWFjIGFkZHJlc3Mgb2YgdGhl
IHBlZXIgZm9yIHdoaWNoIENGUiBjYXB0dXJlIGlzIHJlcXVlc3RlZC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFZlbmthdGVzd2FyYSBOYXJhbGFzZXR0eSA8cXVpY192bmFyYWxhc0BxdWljaW5j
LmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAgKiBVcGRhdGVkIHRoZSBjb21taXQgbG9nLg0K
PiA+DQo+IA0KPiBUaGF0J3MgYSBiaXQgYmV0dGVyLCB0aGFua3MuDQo+IA0KPiBIb3dldmVyLCBp
dCBzdGlsbCBkb2Vzbid0IGFkZHJlc3MgdGhlIHF1ZXN0aW9uIG9mIHdoeSBpdCBuZWVkcyB0byBi
ZSB2ZW5kb3INCj4gc3BlY2lmaWMgQVBJLg0KPiANCj4gSXMgdGhpcyBzb21ldGhpbmcgZnVuZGFt
ZW50YWxseSB0aWVkIHRvIHRoZSBoYXJkd2FyZT8gRnVuZGFtZW50YWxseQ0KPiB2ZW5kb3Igc3Bl
Y2lmaWM/IEknbSBub3Qgc3VyZSBJIHNlZSB3aHkgaXQgd291bGQgYmU/DQoNCkNGUiBjYXB0dXJl
IG1ldGhvZCBjYW4gYmUgZGlmZmVyZW50IGZyb20gSFcgdG8gSFcuIEZldyBIV3MgbWlnaHQgbm90
IHN1cHBvcnQgYWxsIHRoZSBtZXRob2RzLg0KDQo+IA0KPiBqb2hhbm5lcw0K
