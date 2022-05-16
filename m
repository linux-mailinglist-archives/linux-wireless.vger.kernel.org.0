Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E5527FFB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiEPIpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbiEPIoq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 04:44:46 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01CCF5B4
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1652690679; x=1653295479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kvrq8SqDjTdePNvd7y5DWrvcCz6Crix+pWFQBvJui5M=;
  b=I7quD/f+hALJhVsZp+K+4/Sn20hwYYP/u8gsW0xhxrW9Fh42g5FJfdHA
   4LQBIRvJUg2spFI8nguGjQJ7IstVZJqA/zJ1TWe56/UzG/IE4rjo4UKLM
   hvgtejXnF3ZncDKrTL1pPxJiFjqMQytixQs/zUP58VwT+WPge1ZoKWBCT
   o=;
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 08:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuOH11KV8M8aHf2MUWkjfnc59NRpqNOawif/LbSkl7F9pTQsRziRFvgbgdYLoHiTRQZRh6oYUYd6lV/7TW1gNHU4n4QFq3vMs76j3wUaiLMlmozhfrckU4AAilhQYa3WqJTZ6nZiA3j3itkg/yEW1R/qUwdr1KWD+ohTSQiznhZYfPaw6hOMdYORwmBiQb+8z4vd4PBDMyfgjPPnxVU0KMq1qB2AMwdBRfl9a7FrpatYmZgqv2SHwC1v0stH0OsmmieUISPY6hEz//yCHh2CxXnb4DQKvF85mDhM3O5j0VrYtwMJdLz43Q+ib3ezn28Z51ANX5njscX8Vl7FoYpSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvrq8SqDjTdePNvd7y5DWrvcCz6Crix+pWFQBvJui5M=;
 b=cTHXUv/EPXL+aiqHd2acDC1osdiFZLor7iK/VN0PFpD3MaDvHm9PEEqfCujDYK1NrXke/tUwqcIDd7/bDqVk81T0C3rVroKAiEYfcncbo4zkpQ7kVH8vjcMglyIuP5KxPNrll2bOCo+DFnmU8URa/y6loPjGrChbDH/N8cxrzJ/5R+d5BEBwnQibRQUZldO7waZlzoX44qfJvZgnu87kycEcbD65Yy3lWss2T2ZZN/+LddoBOcN7jVuJwuDwaURkJG777gfzbBsGmZLCrMcGHR/vL3HqqfPAWnmZ21BrkE4wJwOu/gVvX0LPlMXnRnTAHD0eknpgMEk7z6k6/LH/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM5PR0201MB3589.namprd02.prod.outlook.com (2603:10b6:4:80::19)
 by DM5PR02MB3323.namprd02.prod.outlook.com (2603:10b6:4:64::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 08:44:34 +0000
Received: from DM5PR0201MB3589.namprd02.prod.outlook.com
 ([fe80::cd70:512:f399:21fe]) by DM5PR0201MB3589.namprd02.prod.outlook.com
 ([fe80::cd70:512:f399:21fe%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:44:33 +0000
From:   Aditya Kumar Singh <adisi@qti.qualcomm.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "Aditya Kumar Singh (QUIC)" <quic_adisi@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Wen Gong (QUIC)" <quic_wgong@quicinc.com>
Subject: RE: [RFC] mac80211: add support for 6 GHz channels and regulatory
Thread-Topic: [RFC] mac80211: add support for 6 GHz channels and regulatory
Thread-Index: AQHX6nKYb8NaFJzR1kq0IoctVAcHwq0iIc2AgAADTxA=
Date:   Mon, 16 May 2022 08:44:33 +0000
Message-ID: <DM5PR0201MB3589EEA811E6A0D5375F396884CF9@DM5PR0201MB3589.namprd02.prod.outlook.com>
References: <1638775571-24366-1-git-send-email-quic_adisi@quicinc.com>
 <a86cae34b3b60ab60bc8c456812e7a115f192e56.camel@sipsolutions.net>
In-Reply-To: <a86cae34b3b60ab60bc8c456812e7a115f192e56.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c45c90df-b865-4bae-6336-08da37184d22
x-ms-traffictypediagnostic: DM5PR02MB3323:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB3323DCC39570F858E0D38D1884CF9@DM5PR02MB3323.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18x3zfbmP6D/Y0jdjtdt8YjLUhsOObgcWlpe0KI3D3lgYFFbQPADlRjPjbv+ep9PdfQD6AyIELt4zztvXoRnkar1LSm8DPNG3yLZQ33x4Vmde/cEoIzXGd+t9N6qIRoU0T3EtEq/OWVsTxQlb0i/sEm1/uCv3ccTmNjUHLgdx9ogdTWQqddMSg9OAcMmTYuJvcTt5VoSamFVDg+NlOJAAW8+2NOVae6S8pV5CZCf7q3nlmwTXan9FdfURBVUfYCAjuOatUS4ShW+T/K5R8M/9fvgD1lKZ0A5CWTLnkAJd4LzW8L6I0RBOn5cdah5k2DVA7+VYtE5woZ9gezVt1LKwdb6ZUYzZlm1KQT2n09KkcgBcLy+s9tjiSQy5dhHeheExZEDBFpXP9SCtRo3kGXpl0nLypv8S6u7wgReK3YrYW831yLkDjTe5UILR2Nk3Sta5vwb23g/Vx19i3Ye0m2xKiBgEJc8UpY97kJo017seJOnfPyj7UA64kcz2HL9OK6dTImrLVBXEQp4GbgUL946X7qIPb4ARInBNX4A3q2Oyk65AShmr0hpT3M1XO34Z5p1doPZv8ijey7rvz74L01gAbrlrYTcuR8cScf0xPtxhmgARVsOA4htlNrZrYPekPrWgEFi0dNYgSfOj3CRaysPpnJoBOgtw6EuxKJEu8COBK+AWr8QqXespcG1+KmNriDgBxZz6BfeV3aowLcJDKgxYCIV0rPh7jZUhFmJjZCR34SdjtgsnYPH85hnvF716ebDwBMQqyy5cWcvBj1eK8V3DoIvh0/NpjM6dPXEhlkQymA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3589.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(5660300002)(52536014)(508600001)(186003)(53546011)(966005)(4326008)(8676002)(66946007)(66446008)(66556008)(64756008)(66476007)(76116006)(33656002)(2906002)(8936002)(15650500001)(107886003)(55016003)(7696005)(86362001)(26005)(38070700005)(38100700002)(83380400001)(316002)(71200400001)(9686003)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUJnNnN6Y0pScy94dVpyK3BDNStaTVkvdkFaa3dvWTVPTXRLYkhMWlVTaEhh?=
 =?utf-8?B?RTFWLzV0MDR2OU81cGk5WmFVQ1k0ODZvOFhidUhFTnhvTnZNMTE2TVZsdUFu?=
 =?utf-8?B?eUxGRGZnVWpYVFFDbUJWVnFmMW1KTHlXVlkza2p6ZjVqOHFkNGw2UFBqN1Rz?=
 =?utf-8?B?bEk4U21hdVBkMzdKMDQ1SGlWMFFiVlRqNDhRMFRsMzY0TVp2eTdqTHVNZ0wz?=
 =?utf-8?B?ckdlMHhONGw3c0JGRDNncmhjQUVLYjlVYjhITkFEKytZMG1lM3JuYjBtQmgr?=
 =?utf-8?B?a0d2OHZibk9KWjBsdTkyOUZ1UkE2N1BwK1RDYm1ZOEU2Q0YxTEV6OFRDMTR5?=
 =?utf-8?B?RG1pWTRMaDQ2NmptZEc5Z3NHWVpmUzcvQ3RQQ3hjb2drMHl4OHIzT01UOFVN?=
 =?utf-8?B?RVdJVWVTcUJTdVMyS3MrSmFKTDRjMU1JUHRCVEV1L0I1U21wQ0VOQmpDUTZG?=
 =?utf-8?B?Rzlvem5EbnU3NEhRRm93aU5PRDFDK25xVTBXdEs5TmcvTkwzb1FQY2VNRElS?=
 =?utf-8?B?N1FSSEdvSjNwd0tHVHc1SE43cURwVFUyNDBtc0VtcmcybjJVbHpaT0wrM1dQ?=
 =?utf-8?B?eXF1WTEzRE9Ma0hzcU1PdmVrdHM4K3JFb1E2cXBHUmZRdjduV2pweTBxTGk4?=
 =?utf-8?B?YStJdFVnOG5vNjg5dy9hMVZ6V05Ub0E5Y1RzbTA0eDhFUkgxRFhQYmNYY0ta?=
 =?utf-8?B?dEV0OC9tRmx3ZWlNaElOWTFZa2ROZWIzTXhGakpTZzAwVU1HZStDaE9aYWxU?=
 =?utf-8?B?RU8xckFkbGdEQUV4eXRuQ1pBTkhhWWNlTkRDU2JhcEpuYlVOVDdUTXBoZEF4?=
 =?utf-8?B?akNmRFZEdW45WUlLQjgyRXduZEpybXBjRHlFbE83VGpGd2lYZzhsbU00WU1V?=
 =?utf-8?B?M1dqR2ptcFlSdGM2dEQ3VldWNHZNL0ZVSmtXQ2RTelVSeHdEMHBlemFQVExz?=
 =?utf-8?B?TG5BUDMvRkh1L0IyOTNNUVZtQnV2dFJlV2owaU00ajN0eEM1ZXBKd0ZrMk5w?=
 =?utf-8?B?SERBdFlmbHp4U2VsMGowZVl1a3JNNjkxUDExSVE4TG44N2x1Z2VsZzdDT2FK?=
 =?utf-8?B?WG5vTVA3NHdPamVxZFZ3dW1DWnNsRm1YZmRKSnZqWkN6bWxaUFNaRkd2R09j?=
 =?utf-8?B?OGcvWHQ3RGgveVpwNC9SUWxPOWVuRDlnK2hkb2FHOHdYYjJENVdDMk9YL2Fn?=
 =?utf-8?B?dTg5bE9ad3ZGRCt2T1dsRlN4ZmpQcGZEVktPL2ROLzZUanFrVU1JWDkwbis4?=
 =?utf-8?B?SWZtN0M2djBmNnE5TXBDS1IwSjh3MGhQSFEySzVkcW14SUp4RVF4Qk5CKzc0?=
 =?utf-8?B?bmN6aGkzTHkzK2dFU3JuWmdRQlV4WEpodTlDMnJ4UVZENjMxZkdaQkFieE5G?=
 =?utf-8?B?emszSDRmZDI3QklFc3JRMW94N2ZqUzVwMlY5NVArMjMxeTFtOFpMelVESGxV?=
 =?utf-8?B?ZlNhN3dUamhUc21GYk9QcG1kT0pZK2k2NUhraEN1K2JIYjRic1pBSUY5NGx0?=
 =?utf-8?B?L01ST2FqSEd6YjlBZnlqSzc5dEpLUGZaMHJNSXpEVkpRRmNuTVplU0RETk03?=
 =?utf-8?B?bWZvTk4wMjl2VmplN003UUozU0dlY0I4RFBWbHY2dWVuUTJLZEpKcjU1enVp?=
 =?utf-8?B?Qk1xTTFrMEFxMy9QN1FoVW4vZGM5NnNGY1NlT3dDRncreUpybHN5eHlWL2Zq?=
 =?utf-8?B?SjBYS0JkdG5SbUptQ3R1dkkrOWprblZqU2g0eHJhSlU0NXQ1eE1TdFNZZkpG?=
 =?utf-8?B?VVRQYzlkQkZZUnJVY1VhSE1UNU1rdW5BN1h1MUt3RVN4S3JzMWQ4aEdybUE5?=
 =?utf-8?B?ZFo5Qy9FWkVTcTNQMHIwdC9VM0JmY3IxMkxlNzFndjdBUktPcS94RzQwbW1w?=
 =?utf-8?B?c3B6TFpWSjJneURTVjNGZ0crL2twMWZRNjNlVHJ0eHhsLzBEb2swN3dJaFc5?=
 =?utf-8?B?em1ITm93MmVxazdOb3FSeXBrUEtKVHFQeUo0TW9RSDd2blBjTDdkcG9IYXBk?=
 =?utf-8?B?RHN5bnFPNUpjK0xZa0RmMWJsTCtETC9VNStUQTVYTFdWc2hBMXFMSW5pTGkv?=
 =?utf-8?B?YUMwTTFEVTRWNGxtR04wYWhoMEZNOU1JVVlNY0JqaTlRRkk1a3VWWG1PVkt4?=
 =?utf-8?B?QmJzazFwWm82UTNGQWFkV3Qvc2s2ZlhiV2JzVExXS3YyZ3BKOVYxRWw1dncz?=
 =?utf-8?B?RVIwU0o5Q2VwV25kNGVmaEc4QzhqellKWTdjMkhzMWdkNzVDTk1iekZHVmdR?=
 =?utf-8?B?WjBTSGs4VHRhaUM5UXB4WGN5M080U3dYNVdDQ2M1REpyS0VpazM1U1Z3OUE1?=
 =?utf-8?B?NExYcE4vWVNnUTFyeUhzZENMdDZ4V2RIMEl4cHBMQTlwNWxnQ0JrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3589.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45c90df-b865-4bae-6336-08da37184d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 08:44:33.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjyT89IvdK4Pxefgbk8eotzQgqtGiZUfwG+b6KgKcDyyGqeYW5ramdMQkOupS/WmcgWG3QY5k1ccelhPuoZd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3323
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBNb25kYXksIE1heSAxNiwgMjAyMiAxMzoz
Mw0KPiBUbzogQWRpdHlhIEt1bWFyIFNpbmdoIChRVUlDKSA8cXVpY19hZGlzaUBxdWljaW5jLmNv
bT47IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFdlbiBHb25nIDx3
Z29uZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gU3ViamVjdDogUmU6IFtSRkNdIG1hYzgwMjExOiBhZGQg
c3VwcG9ydCBmb3IgNiBHSHogY2hhbm5lbHMgYW5kIHJlZ3VsYXRvcnkNCj4gDQo+IFdBUk5JTkc6
IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBi
ZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUg
bWFjcm9zLg0KPiANCj4gSGksDQo+IA0KPiBPbiBNb24sIDIwMjEtMTItMDYgYXQgMTI6NTYgKzA1
MzAsIEFkaXR5YSBLdW1hciBTaW5naCB3cm90ZToNCj4gPiA2IEdIeiBpbnRyb2R1Y2VzIHZhcmlv
dXMgcG93ZXIgbW9kZXMgb2Ygb3BlcmF0aW9uLiBDdXJyZW50bHksIGJhc2VkIG9uDQo+ID4gdGhl
IHBvd2VyIG1vZGUsIGNoYW5uZWwncyBwc2QgdmFsdWUgYXMgd2VsbCBhcyBjaGFubmVsIGRpc2Fi
bGVkIGZsYWcNCj4gPiBjYW4gY2hhbmdlLiBGb3Igc2luZ2xlIGludGVyZmFjZSwgY3VycmVudCBp
bXBsZW1lbnRhaW9uIHdvcmtzIGp1c3QNCj4gPiBmaW5lLiBCdXQgZm9yIG11bHRpLWludGVyZmFj
ZXMsIGZvciBleGFtcGxlIEFQLVNUQSBjb25jdXJyZW5jeSwgdHdvDQo+ID4gZGlmZmVyZW50IGNo
YW5uZWwgbmVlZHMgdG8gYmUgbWFpbnRhaW5lZC4gVGhpcyBpcyBiZWNhdXNlLCBTVEEgcG93ZXIN
Cj4gPiBtb2RlIGFsc28gZGVwZW5kcyBvbiB0aGUgQVAncyBwb3dlciBtb2RlIGl0IGlzIGdvaW5n
IHRvIGFzc29jaWF0ZQ0KPiA+IHdpdGguIEhlbmNlLCBwc2QgdmFsdWUgYW5kIGNoYW5uZWwgZGlz
YWJsZWQgZmxhZyBtaWdodCB2YXJ5LiBJbiB0aGlzDQo+ID4gY2FzZSwgc2FtZSBjaGFubmVsIGNh
biBub3QgYmUgdXNlZCBmb3IgYm90aCBBUCBhbmQgU1RBLg0KPiANCj4gDQo+IFNvIC4uLiB5b3Ug
Y29ycmVjdGx5IHBvaW50IG91dCB0aGF0IHdlIG5lZWQgdG8gZGVhbCB3aXRoIG11bHRpcGxlIGlu
dGVyZmFjZQ0KPiBzY2VuYXJpb3MuDQo+IA0KPiBCdXQgd2UgaGFkIGEgcHJldmlvdXMvb25nb2lu
ZyBkaXNjdXNzaW9uOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8y
MDIxMDkyODA4NTIxMS4yNjE4Ni0xLQ0KPiB3Z29uZ0Bjb2RlYXVyb3JhLm9yZy8NCj4gDQo+ID4g
SGVuY2UsIHRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IHRvIHN0b3JlIGFsbCBwb3NzaWJsZSA2IEdI
eiBjaGFubmVscw0KPiA+IGFjY29yZGluZyB0byBwb3dlciBtb2RlIGFzIHdlbGwgYXMgYWRkIEFQ
SSBzdXBwb3J0IGZvciBnZXR0aW5nDQo+ID4gY2hhbi9mcmVxIGluZm8gZnJvbSB0aGUgbmV3IHN0
cnVjdCBpZWVlODAyMTFfNmdoel9jaGFubmVsLg0KPiA+DQo+IA0KPiBGV0lXLCBJJ20gbm90IHN1
cmUgdGhhdCBpdCdzIGEgZ29vZCBpZGVhIHRvIGhhdmUgc2VwYXJhdGUgY2hhbm5lbCBzdHJ1Y3Rz
Pw0KPiBXb3VsZG4ndCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gaGF2ZSBlYWNoIGNoYW5uZWwgc3Rv
cmUgc2VwYXJhdGUgcmVsZXZhbnQNCj4gaW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoZSBwb3dlcj8N
Cj4gDQpJIHRob3VnaHQgYWJvdXQgdGhpcyBhcHByb2FjaCAobGV0J3MgY2FsbCBpdCBBcHByb2Fj
aCBCKSAgdG9vLCBidXQgdGhlIHByb2JsZW0gaXMgaWYgd2Ugc3RvcmUgYXMNCnlvdSBtZW50aW9u
ZWQsIHRoZW4gYXQgZXZlcnkgcGxhY2Ugd2hlcmUgdGhvc2UgaWVlZTgwMjExX2NoYW5uZWwgbWVt
YmVycyBhcmUgdXNlZCwgd2UNCmhhdmUgdG8gYWRkIGNvbmRpdGlvbiB0byBmaXJzdCBjaGVjayBp
ZiBmcmVxIGluIGluIDYgR0h6IGJhbmQgYW5kIHRoZW4gYWNjb3JkaW5nbHkgc2VsZWN0IHRoZVwN
CnJlcXVpcmVkIG1lbWJlciBiYXNlZCBvbiB0aGUgcG93ZXIgbW9kZS4gIFRoZSBjdXJyZW50IGFw
cHJvYWNoIHdhcyB0YWtlbiBjb25zaWRlcmluZw0Kc3RydWN0IGNmZzgwMjExX2NoYW5fZGVmIHN0
b3JlcyB0aGUgaWVlZTgwMjExX2NoYW5uZWwgZGlyZWN0bHkgYW5kIG9uY2Ugd2UgYXNzaWduIHRo
ZQ0KY29ycmVjdCBpZWVlODAyMTFfY2hhbm5lbCBmcm9tIHRoZSBhdmFpbGFibGUgcG9vbCBvZiBp
ZWVlODAyMTFfY2hhbm5lbHMsIHJlc3QgYWxsIHRoaW5ncw0Kd2lsbCBhdXRvbWF0aWNhbGx5IGZh
bGwgaW50byBpdHMgcGxhY2UuIE5vIGZ1cnRoZXIgbW9kaWZpY2F0aW9uIGlzIHJlcXVpcmVkLiAN
Cg0KQWxzbywgNiBHSHogaXMgc3RpbGwgZXZvbHZpbmcsIGFuZCB1bnRpbCBub3cgd2Uga25vdyBQ
U0QsIEVJUlAgYW5kIGZsYWdzIHdpbGwgdmFyeS4gV2hhdCBpZiBpbg0KZnV0dXJlIGFueSBuZXcg
bWVtYmVyIG9yIGV4aXN0aW5nIG1lbWJlciBhbHNvIHN0YXJ0cyB2YXJ5aW5nIGJhc2VkIG9uIHBv
d2VyIG1vZGUgPyANCklmIHdlIGZvbGxvdyB0aGUgQXBwcm9hY2ggQiwgdGhlbiBhZ2FpbiwgYWxs
IHRob3NlIHBsYWNlcyB3ZSB3aWxsIG5lZWQgdG8gaW50cm9kdWNlIGFub3RoZXINCklmLWVsc2Ug
Y29uZGl0aW9uIHRvIGNoZWNrIGFuZCB0aGVuIHRha2UgdmFsdWVzLiANCg0KPiANCj4gSSB0aGlu
ayB5b3UgYW5kIFdlbiBzaG91bGQgZ28gd29yayB0b2dldGhlciBhbmQgZmlndXJlIG91dCB0aGUg
c3RvcnkgYXMgeW91DQo+IHRoaW5rIGl0IHNob3VsZCBiZSAtIEkgZG9uJ3QgaGF2ZSBhIGxvdCBv
ZiBvcGluaW9uIG9uIGl0LCBhbmQgdGh1cyBJJ20gbm90IHN1cmUgaXQncw0KPiByZWFzb25hYmxl
IHRvIGFzayBtZSB0byBmaWd1cmUgb3V0IGFsbCB0aGUgZGlmZmVyZW50IHRoaW5ncy4NCj4gDQo+
IFBsZWFzZSB3b3JrIHRvZ2V0aGVyIGFuZCBjb21lIHVwIHdpdGggYSBjb2hlcmVudCBzdG9yeSBv
ZiBob3cgdG8gaGFuZGxlDQo+IHRoaXMsIGhvcGVmdWxseSBpbmNsdWRpbmcgbXVsdGktaW50ZXJm
YWNlIHNjZW5hcmlvcyBhbmQgbWF5YmUgcmVndWxhdG9yeQ0KPiBkYXRhYmFzZSwgaW50ZXJuYWwg
ZGF0YSBzdHJ1Y3R1cmVzLCBldGMuDQo+IA0KU3VyZSwgd2Ugd2lsbCBzeW5jIHVwIGFnYWluIGFu
ZCBsb29rIGZvciBhIGRpZmZlcmVudCBhcHByb2FjaCBpZiBhdCBhbGwgaXRzIGZlYXNpYmxlLiBC
dXQgc28gZmFyIGFzIHBlcg0Kb3VyIGVhcmxpZXIgaW50ZXJuYWwgZGlzY3Vzc2lvbnMsIHRoZSBw
cm9wb3NlZCB3YXkgb2YgaGFuZGxpbmcgc2VwYXJhdGUgaWVlZTgwMjExX2NoYW5uZWwgc2VlbXMN
CnRvIGJlIG1vcmUgZmVhc2libGUuIA0KDQo+IEpvaGFubmVzDQoNCg0KQWRpdHlhDQo=
