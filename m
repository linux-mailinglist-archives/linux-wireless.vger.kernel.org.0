Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE053C3CF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 06:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiFCEmI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 00:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiFCEmH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 00:42:07 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCEB859
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 21:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1654231322; x=1654836122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M4zux9ZvFaAZpWMGMMoMHhZpL1h728T+/JRGajhFfKc=;
  b=uBGxXsGVMD3LzthqQmNMj9N3eEnLzxg+yXWnk7/Wnpb3pLrql06no4LT
   LJJDTccFeGYyt5AN7FIrSXEU2ItbhaJRHO92YDTDYjY4pN3TDUrOj/aIp
   G2Q6uSjBfnYf0ka6pZDcJn5CXMwdeZiCK5m+wA/qMd6ZUQUGmx3pd5y11
   U=;
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 04:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHF/7ga/XVGWRpshu64qdVQcsiUhdQk1TZGJuCLfvpxI9LuNRyCNdTAN3zP7buwesOdB6GQgU8FpTexbaI2jTk/geRjLuvnij3JQtb2bQ9LISypoqn1KHtEfEFWGXZo0lNyFDgaZOkx6yWrec0TdTR4FY7SC9FJUTJvZhvJk1U7xk727oEwBMDLNCG/9ZEfqQZPXN70vBEGwxx14K4pH1RuXSPG6/6SfKYaQ8Woysy9Ykc8CsXsLA8kgd938aZTSya2DAleCVUeFvbYHXYYQlmrU34+er6qpPsHtYHHgFkZ6sITvLoPUXwglrSEOtfTTaOR3zGgnq0SghPaD75L7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4zux9ZvFaAZpWMGMMoMHhZpL1h728T+/JRGajhFfKc=;
 b=exbIBCH+JLV3+mU/mgzqRJH0nYylg0z8vA0ArwD+wTo29nS9ZlhzwyzXRWHmS4bqDVgwhh0DFaK4ygwXL4TJzHqhbK85aKJsKi9urpuK2JNWypnWIoDEtnLoq2lR5lC3EVjg3pvXpW+XD3+0bYURy/sQ6Ak6EzvPqB7KNyC032PZHPi7fmL/TWB1bS9aQoSAM2x4dCMGs8jTOquWLz2tc3E6jLhmBhDh5bwuZe/8fylT6oVLJwKG/heIJEdrAR1rj3RQ8uDE4oXxq6HHnq0IpH811ycxT3mMWemPa3w8s7hOExcMmtR6+COOKiysneCtOD2W//ZBNULghmCx+/uvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3589.namprd02.prod.outlook.com (2603:10b6:4:80::19)
 by BL3PR02MB8298.namprd02.prod.outlook.com (2603:10b6:208:345::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 04:41:59 +0000
Received: from DM5PR0201MB3589.namprd02.prod.outlook.com
 ([fe80::f5b9:2296:c8d4:764e]) by DM5PR0201MB3589.namprd02.prod.outlook.com
 ([fe80::f5b9:2296:c8d4:764e%7]) with mapi id 15.20.5293.019; Fri, 3 Jun 2022
 04:41:58 +0000
From:   "Aditya Kumar Singh (QUIC)" <quic_adisi@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Aditya Kumar Singh (QUIC)" <quic_adisi@quicinc.com>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: RE: [PATCH 2/2] ath11k: add get_txpower mac ops
Thread-Topic: [PATCH 2/2] ath11k: add get_txpower mac ops
Thread-Index: AQHYdj+vfCpLU/o/7UGp6gldxUlyUa08M+oAgADoGUA=
Date:   Fri, 3 Jun 2022 04:41:58 +0000
Message-ID: <DM5PR0201MB3589D62629069D1FA3FB11BE84A19@DM5PR0201MB3589.namprd02.prod.outlook.com>
References: <20220602051425.9265-1-quic_adisi@quicinc.com>
 <20220602051425.9265-3-quic_adisi@quicinc.com>
 <f6414575-6a9c-2e8a-dbb9-68680aca8822@quicinc.com>
In-Reply-To: <f6414575-6a9c-2e8a-dbb9-68680aca8822@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aff5079d-22a7-4baf-5b69-08da451b6513
x-ms-traffictypediagnostic: BL3PR02MB8298:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL3PR02MB82989E47D580C935AAC824B3F8A19@BL3PR02MB8298.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mqNnWQOi5eOaB2mM+5H68ZpHkwdndLIqE8Y5NQ1ByCNLCOKIsGiYF0cOP+UO224FYvkfO8eig4kMCsmiFTFKdjY3AgQzzOfLlgh2bpgiwdXA9UTpZxpTQ/w/2EVHI5RMPuqyGPurX5MYUdjxt5FEjNz23n6QLZglq2/EObMLsid3sI/XcrGRqWSXj2vnn8MkuqJ12FGlJwWzA21AJkdTE9FRoEJ7psHae6qTlDWRK21KYRVsuH6zgzJ4OXaIiYp9pK12f7KCuVWBy4KC7PLI6vf6RmsL6yyLE/to6z8nWI+lgqnL3hbQIeRJHtJEEX25kDjliqvy2edhW3Oz2Mx1omo/bRzcDMSHvFvQggi+8jF/LOTA9MeqXq6E2s8LaQLrxW7cnELBwhU2af58zYmcyUl8jJTskqYa5JxpJc4yBnnu3wmQqG+dpEwxk7GTzteQFjwAMVhepGh0vofKxRVwn5EtwdGMCj2G4xBDcRJFdfDs/uogRra3oz7XM38Uyybz/ttjAPGUubj932HHEVa2iO7lMNjTZan9PxkwDIeajpEzpt7rZFrt+7D/eeiA7mkS/bHl7dfIoE20ZVDAxlCoY+iV71IKpv+20z3GlasiEq2+CZh8Ei9lI74n/bBMA4fW5pK6u6qVBMzvit7G10gZNj/gh6EUAo8mf0fIn6fiahqExXDT3ivdWzNRLay6KY0ARF1yCmaIMWxAEoo3vruyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3589.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(6862004)(186003)(2906002)(64756008)(66476007)(66446008)(6636002)(66556008)(66946007)(54906003)(76116006)(4326008)(8676002)(83380400001)(316002)(52536014)(6506007)(53546011)(7696005)(33656002)(71200400001)(5660300002)(508600001)(55016003)(122000001)(9686003)(26005)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekJSSDVkZm5ncDZjMjZralR1T2dLdGsyWFVpcGgzOXZ0dGJweUVGMmRUTDFD?=
 =?utf-8?B?c3l5Y1RhcWpYN2FSNnV1Y05LN1BXL2N6SW1DZ0lGV21SVWNDVFpYZjVXSGNI?=
 =?utf-8?B?RUF1VDFydS9lNEJGZm9PZXRrb2dyQ2NjOFVBdFBiaklRUzN1dnVma1BrR3Br?=
 =?utf-8?B?WFhIT1VtK0JLRzd2VG91dXdwRHpJVUJuSngzRXZVZmdjV0VscTBGajFuaW1l?=
 =?utf-8?B?eGFmYUFYSkZBSndheXZ2N3lnUkJVWEVodmZUVmNiV3M2MkViYXdmU3NRY0Zy?=
 =?utf-8?B?UDh0ZFVud1EyNnlTSFIzWG9OUHBnSGg3RXBJdnFGOWR4Sy9YRzVQZGl3eHRI?=
 =?utf-8?B?V3laUzBFUVh1V2kzSWM0U0s3cFc4bEtNb2RQTkUyMnNBNWxXczZBSTdKR290?=
 =?utf-8?B?SFY2WTZHdU1OcDJmZkRFbXZtQjcwc24rVTE1aGJMcUJzVTNBSEorSnBrMlNR?=
 =?utf-8?B?VWtkWEVydUs0aVZ6SUR0ZktyRUlud2ZqdHhsSDBnMXJYU242REFWaks1eUl5?=
 =?utf-8?B?dDJGU2l0VDF5SmtjTnBpcy9BYUx0KzdWU1V1RHovWVREWFBlNTh6ME96WWJ4?=
 =?utf-8?B?aVVYRzNQMTRzbVBWTmdSc1J3MGxMTlVzdHJjKzRCdTdkV29kNWxPMlpWNjcr?=
 =?utf-8?B?TkJPbnQ4RlZPeUkxTjQ3Q3BYb05zTU85YU1kaGZ2ZU5TWkZ1bDNiTjhSU1NN?=
 =?utf-8?B?bDhlRWNIQUNmcmRmNzlEaHBUV2c5c09ZZDlFTVlWWUtZU3dHVHJSUzRWUFkx?=
 =?utf-8?B?RnlNQnpYMHJqYUEwSzhVRmFtb2xnNkRvYTRlNzZPTUttcmNUdzkzM2RJTmhj?=
 =?utf-8?B?S2FaS0hKNzNSdlhlOGlVeVV6bG5EWU5tZ09wbkZUUVBYK3Z5NVZySzRVRVkv?=
 =?utf-8?B?WEl5ajN2N242VlVBcjhMMFBySDJYcTVHWUROQlRWSEpKRTUzUnd0ZmkrbFNC?=
 =?utf-8?B?SGt3VzBPWlNKSDY5Q3NDNEtEQ3FlNXRQTTd1RG5IZjZuQ3M0U0Z5QlpMaGJH?=
 =?utf-8?B?TlJaM2tGRkI5WEs1a0orUlZaYUt4bkh4UnNSWVNzeFNaN2N2Z2xXa1FEekJE?=
 =?utf-8?B?MlIwZDNpQkYzdWRPamFIOHpVa0Q3cWRkaXFrUGNMN2czajUvdUovSStqcG1S?=
 =?utf-8?B?b1RHT3ZsRVQ5aERwZi93eVltSFlKNE81QnFCYlBLdGpLTjU4Y3JUMmFHOGNk?=
 =?utf-8?B?eFcvQWpWdDR3UzNkR0o4bmdGZU1Mam45RDFBVXdrQ2xyMktVS0lQUGZGaktJ?=
 =?utf-8?B?RUhscmFPUGhyMVZrS0FKUFhSdzNpZzRMQzJCZHRYZmNZSkwzbW1kalozMW9C?=
 =?utf-8?B?dzkzUUZqK2lvWi9WNUlSd3FzcHRvaFplTDBjV21INmd1aTYxWVV4OWFxeGdN?=
 =?utf-8?B?U2NXd2pMRHZtb3NHNWpPL2owajc2MzJKSk5ZV3lUYUZGZWpCcEFhdkRnR2lS?=
 =?utf-8?B?Y2pwNG9YN0xVUWlRSE1qN2JGYmw4WXlVS0tKZjhndC9uVmMwRkxGQ0JycmVZ?=
 =?utf-8?B?NkQ0ZnlrUlpvc2JpNWdyQXl1QWk2STFUY1ZKYWpKL04wNytjZUVuNE5LOGJU?=
 =?utf-8?B?bVJ0UE5rQU5abThEa1B2dmsyTVlPUXdPREFnRlYrVXd4RkVwc3lKWVl5Q0gx?=
 =?utf-8?B?RjIwMUNYcnJPbm8vL1Z6TUNJcEU2dXY5TG1od05VcHVWL0VuM24vOWJRYU54?=
 =?utf-8?B?enFqTWx4UkJITWtUQ1p6ZnhNYzd5SEJZMkduN0swaTQxZFJmQ0xEc05GdlJy?=
 =?utf-8?B?clJOUFJlNWxmSVd0d1AvdWtIYlB4eHJCMzJFWk80SUw2WVJoNGhiV3JCZ0oz?=
 =?utf-8?B?WFBXeFROY2ZuSWxkaVdPVDRvNkcxdlU5OGtwOG8zQVdVYnlSazlvbGNiMHgv?=
 =?utf-8?B?YXkxS0ZGVmo0b0dkSFRXbXRTb2pERUJEOGpVMDhiQVhscUNSN0dROFU5dVo2?=
 =?utf-8?B?OVE1YzZkVjltL3B4THZueEJQeXI4VmZFa2phSjdacFRxNDZLeFhmeENRb0x1?=
 =?utf-8?B?aFowS05venh0OUxUK3NOSHdYcVJKbVVBczZ3Zk1BSzhIK2dQMXFSN3JSYWZu?=
 =?utf-8?B?SzdVR012emtMYWNrVE5TdWFDQkpwaytmMFBZYytwaHhJb1Q5NWYwNDdlMHly?=
 =?utf-8?B?NGQvRzhORHQzMzE1VFphQ09jNnJCNlh6dm9yZ2dwWGVHYmUwSmpESkFSK2JM?=
 =?utf-8?B?Y2puYzM5SFhmVUQvMUpGTENkWWpBYXh2UktmRnRCdTlnTEZOemh0ZGxoQnZo?=
 =?utf-8?B?dWR1eFhkdHViQ2M4S2dSYXBleCtSZmhrUzZZQ2E2OWdYeTZMTHBqNUQzZ3ZJ?=
 =?utf-8?B?bGF1Zmo3NnhINGdZNmpuR3VvMDYxRGpYSyt6L2NBakNYS2l3RXdnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3589.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff5079d-22a7-4baf-5b69-08da451b6513
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 04:41:58.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8ibVRm9PxOA35BN69BxW6WQpr3BohaYIPMUb/uUnkm5bCH/pa366YwcH8DGIXSEOhkiNZS2W4SvMDSnkP8dvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEpvaG5zb24gKFFVSUMp
IDxxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyLCAy
MDIyIDIwOjIxDQo+IFRvOiBBZGl0eWEgS3VtYXIgU2luZ2ggKFFVSUMpIDxxdWljX2FkaXNpQHF1
aWNpbmMuY29tPjsNCj4gYXRoMTFrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gYXRoMTFr
OiBhZGQgZ2V0X3R4cG93ZXIgbWFjIG9wcw0KPiANCj4gT24gNi8xLzIwMjIgMTA6MTQgUE0sIEFk
aXR5YSBLdW1hciBTaW5naCB3cm90ZToNCj4gPiBEcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBnZXRf
dHhwb3dlciBtYWMgb3BzIGJlY2F1c2Ugb2Ygd2hpY2gNCj4gPiBjZmc4MDIxMSByZXR1cm5zIHZp
Zi0+YnNzX2NvbmYudHhwb3dlciB0byB1c2VyIHNwYWNlLiBic3NfY29uZi50eHBvd2VyDQo+ID4g
Z2V0cyBpdHMgdmFsdWUgZnJvbSBpZWVlODAyMTFfY2hhbm5lbC0+bWF4X3JlZ19wb3dlci4gSG93
ZXZlciwgdGhlDQo+ID4gZmluYWwgdHhwb3dlciBpcyBkZXBlbmRlbnQgb24gZmV3IG90aGVyIHBh
cmFtZXRlcnMgYXBhcnQgZnJvbSBtYXgNCj4gPiByZWd1bGF0b3J5IHN1cHBvcnRlZCBwb3dlci4g
SXQgaXMgdGhlIGZpcm13YXJlIHdoaWNoIGtub3dzIGFib3V0IGFsbA0KPiA+IHRoZXNlIHBhcmFt
ZXRlcnMgYW5kIGNvbnNpZGVycyB0aGUgbWluaW11bSBmb3IgZWFjaCBwYWNrZXQNCj4gdHJhbnNt
aXNzaW9uLg0KPiA+DQo+ID4gQWxsIGF0aDExayBmaXJtd2FyZSByZXBvcnRzIHRoZSBmaW5hbCB0
eCBwb3dlciBpbiBmaXJtd2FyZSBwZGV2IHN0YXRzDQo+ID4gd2hpY2ggZmFsbHMgdW5kZXIgZndf
c3RhdHMuDQo+ID4NCj4gPiBBZGQgZ2V0X3R4cG93ZXIgbWFjIG9wcyB0byBnZXQgdGhlIHR4IHBv
d2VyIGZyb20gZmlybXdhcmUgbGV2ZXJhZ2luZw0KPiA+IGZ3X3N0YXRzIGFuZCByZXR1cm4gaXQg
YWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBUZXN0ZWQtb246IElQUTgwNzQgaHcyLjAgQUhCDQo+ID4g
V0xBTi5ISy4yLjUuMC4xLTAxMTAwLVFDQUhLU1dQTF9TSUxJQ09OWi0xDQo+ID4gVGVzdGVkLW9u
OiBRQ045MDc0IGh3MS4wIFBDSQ0KPiA+IFdMQU4uSEsuMi41LjAuMS0wMTEwMC1RQ0FIS1NXUExf
U0lMSUNPTlotMQ0KPiA+IFRlc3RlZC1vbjogV0NONjg1NSBodzIuMCBQQ0kNCj4gPiBXTEFOLkhT
UC4xLjEtMDMxMjUtUUNBSFNQU1dQTF9WMV9WMl9TSUxJQ09OWl9MSVRFLTMNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWljaW5jLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMWsvbWFjLmMgfCA5
MQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5
MSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvYXRoL2F0aDExay9tYWMuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEx
ay9tYWMuYw0KPiA+IGluZGV4IGYxMTk1NjE2MzgyMi4uZjI1MDJjZTdkZWFjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMWsvbWFjLmMNCj4gPiArKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTFrL21hYy5jDQo+ID4gQEAgLTg0NzEsNiArODQ3
MSw5NCBAQCBzdGF0aWMgaW50DQo+IGF0aDExa19tYWNfb3BfcmVtYWluX29uX2NoYW5uZWwoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsDQo+ID4gICAJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4gPg0K
PiA+ICtzdGF0aWMgaW50IGF0aDExa19md19zdGF0c19yZXF1ZXN0KHN0cnVjdCBhdGgxMWsgKmFy
LA0KPiA+ICsJCQkJICAgc3RydWN0IHN0YXRzX3JlcXVlc3RfcGFyYW1zICpyZXFfcGFyYW0pIHsN
Cj4gPiArCXN0cnVjdCBhdGgxMWtfYmFzZSAqYWIgPSBhci0+YWI7DQo+ID4gKwl1bnNpZ25lZCBs
b25nIHRpbWVfbGVmdDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJbG9ja2RlcF9hc3Nl
cnRfaGVsZCgmYXItPmNvbmZfbXV0ZXgpOw0KPiA+ICsNCj4gPiArCXNwaW5fbG9ja19iaCgmYXIt
PmRhdGFfbG9jayk7DQo+ID4gKwlhci0+Zndfc3RhdHNfZG9uZSA9IGZhbHNlOw0KPiA+ICsJYXRo
MTFrX2Z3X3N0YXRzX3BkZXZzX2ZyZWUoJmFyLT5md19zdGF0cy5wZGV2cyk7DQo+ID4gKwlzcGlu
X3VubG9ja19iaCgmYXItPmRhdGFfbG9jayk7DQo+ID4gKw0KPiA+ICsJcmVpbml0X2NvbXBsZXRp
b24oJmFyLT5md19zdGF0c19jb21wbGV0ZSk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gYXRoMTFrX3dt
aV9zZW5kX3N0YXRzX3JlcXVlc3RfY21kKGFyLCByZXFfcGFyYW0pOw0KPiA+ICsJaWYgKHJldCkg
ew0KPiA+ICsJCWF0aDExa193YXJuKGFiLCAiY291bGQgbm90IHJlcXVlc3QgZncgc3RhdHMgKCVk
KVxuIiwNCj4gPiArCQkJICAgIHJldCk7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwl0aW1lX2xlZnQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmFyLT5m
d19zdGF0c19jb21wbGV0ZSwNCj4gPiArCQkJCQkJMSAqIEhaKTsNCj4gPiArDQo+ID4gKwlpZiAo
IXRpbWVfbGVmdCkNCj4gPiArCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhdGgxMWtfbWFjX29wX2dldF90
eHBvd2VyKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KPiA+ICsJCQkJICAgICBzdHJ1Y3QgaWVl
ZTgwMjExX3ZpZiAqdmlmLA0KPiA+ICsJCQkJICAgICBpbnQgKmRibSkNCj4gPiArew0KPiA+ICsJ
c3RydWN0IGF0aDExayAqYXIgPSBody0+cHJpdjsNCj4gPiArCXN0cnVjdCBhdGgxMWtfYmFzZSAq
YWIgPSBhci0+YWI7DQo+ID4gKwlzdHJ1Y3Qgc3RhdHNfcmVxdWVzdF9wYXJhbXMgcmVxX3BhcmFt
Ow0KPiANCj4gc3VnZ2VzdCB5b3UgdXNlIGFuID0ge30gaW5pdGlhbGl6ZXIgaGVyZS4NCk9rYXku
IA0KDQo+IA0KPiA+ICsJc3RydWN0IGF0aDExa19md19zdGF0c19wZGV2ICpwZGV2Ow0KPiA+ICsJ
aW50IHJldDsNCj4gPiArDQo+ID4gKwkvKiBGaW5hbCBUeCBwb3dlciBpcyBtaW5pbXVtIG9mIFRh
cmdldCBQb3dlciwgQ1RMIHBvd2VyLA0KPiBSZWd1bGF0b3J5DQo+ID4gKwkgKiBQb3dlciwgUFNE
IEVJUlAgUG93ZXIuIFdlIGp1c3Qga25vdyB0aGUgUmVndWxhdG9yeSBwb3dlciBmcm9tDQo+IHRo
ZQ0KPiA+ICsJICogcmVndWxhdG9yeSBydWxlcyBvYnRhaW5lZC4gRlcga25vd3MgYWxsIHRoZXNl
IHBvd2VyIGFuZCBzZXRzIHRoZQ0KPiBtaW4NCj4gPiArCSAqIG9mIHRoZXNlLiBIZW5jZSwgd2Ug
cmVxdWVzdCB0aGUgRlcgcGRldiBzdGF0cyBpbiB3aGljaCBGVw0KPiByZXBvcnRzDQo+ID4gKwkg
KiB0aGUgbWluaW11bSBvZiBhbGwgdmRldidzIGNoYW5uZWwgVHggcG93ZXIuDQo+ID4gKwkgKi8N
Cj4gPiArCW11dGV4X2xvY2soJmFyLT5jb25mX211dGV4KTsNCj4gPiArDQo+ID4gKwlpZiAoYXIt
PnN0YXRlICE9IEFUSDExS19TVEFURV9PTikNCj4gPiArCQlnb3RvIGVycl9mYWxsYmFjazsNCj4g
PiArDQo+ID4gKwlyZXFfcGFyYW0ucGRldl9pZCA9IGFyLT5wZGV2LT5wZGV2X2lkOw0KPiA+ICsJ
cmVxX3BhcmFtLnZkZXZfaWQgPSAwOw0KPiANCj4gYW5kIHJlbW92ZSB0aGlzIGV4cGxpY2l0IHNl
dHRpbmcgb2YgYW4gdW51c2VkIHBhcmFtIHRvIDAgc2luY2UgaXQgd2lsbCBub3QgYmUNCj4gbmVl
ZGVkIGlmIHRoZSBlbnRpcmUgc3RydWN0IGlzIHplcm9lZC4gdGhlIHJlYXNvbiBmb3IgdGhpcyBh
cHByb2FjaCBpcyB0aGF0IGlmLCBpbg0KPiB0aGUgZnV0dXJlLCBhbnkgYWRkaXRpb25hbCBmaWVs
ZHMgYXJlIGFkZGVkIHRvIHRoZSBzdHJ1Y3QsIHlvdSBkb24ndCB3YW50IHRvDQo+IGhhdmUgYSBz
aXR1YXRpb24gd2hlcmUgeW91IGZvcmdldCB0byBhZGQgY29kZSB0byBjbGVhciB0aGUgbmV3IGZp
ZWxkcywgYW5kIGFzDQo+IGEgcmVzdWx0IHlvdSBwb3RlbnRpYWxseSBsZWFrIHN0YWNrIG1lbW9y
eSBjb250ZW50cyB0byBmaXJtd2FyZSwgd2hpY2ggaXMgYQ0KPiBzZWN1cml0eSBob2xlLg0KPiAN
ClN1cmUsIHdpbGwgYWRkcmVzcyBpbiB2Mi4gVGhhbmtzIGZvciBwb2ludGluZyBvdXQuDQoNCg0K
PiA+ICsJcmVxX3BhcmFtLnN0YXRzX2lkID0gV01JX1JFUVVFU1RfUERFVl9TVEFUOw0KPiA+ICsN
Cj4gPiArCXJldCA9IGF0aDExa19md19zdGF0c19yZXF1ZXN0KGFyLCAmcmVxX3BhcmFtKTsNCj4g
PiArCWlmIChyZXQpIHsNCj4gPiArCQlhdGgxMWtfd2FybihhYiwgImZhaWxlZCB0byByZXF1ZXN0
IGZ3IHBkZXYgc3RhdHM6ICVkXG4iLA0KPiByZXQpOw0KPiA+ICsJCWdvdG8gZXJyX2ZhbGxiYWNr
Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXNwaW5fbG9ja19iaCgmYXItPmRhdGFfbG9jayk7DQo+
ID4gKwlwZGV2ID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZhci0+Zndfc3RhdHMucGRldnMs
DQo+ID4gKwkJCQkJc3RydWN0IGF0aDExa19md19zdGF0c19wZGV2LCBsaXN0KTsNCj4gPiArCWlm
ICghcGRldikgew0KPiA+ICsJCXNwaW5fdW5sb2NrX2JoKCZhci0+ZGF0YV9sb2NrKTsNCj4gPiAr
CQlnb3RvIGVycl9mYWxsYmFjazsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiB0eCBwb3dlciBp
cyBzZXQgYXMgMiB1bml0cyBwZXIgZEJtIGluIEZXLiAqLw0KPiA+ICsJKmRibSA9IHBkZXYtPmNo
YW5fdHhfcG93ZXIgLyAyOw0KPiA+ICsNCj4gPiArCXNwaW5fdW5sb2NrX2JoKCZhci0+ZGF0YV9s
b2NrKTsNCj4gPiArCW11dGV4X3VubG9jaygmYXItPmNvbmZfbXV0ZXgpOw0KPiA+ICsNCj4gPiAr
CWF0aDExa19kYmcoYXItPmFiLCBBVEgxMUtfREJHX01BQywgIiVzOiB0eHBvd2VyOiAlZCBmcm9t
DQo+IGZ3XG4iLA0KPiA+ICtfX2Z1bmNfXywgKmRibSk7DQo+IA0KPiBJTU8gdGhpcyBpcyBtaXNs
ZWFkaW5nLiB0ZWNobmljYWxseSBwZGV2LT5jaGFuX3R4X3Bvd2VyIGlzIHRoZSB0eHBvd2VyDQo+
IGZyb20gZmlybXdhcmUsICpkYm0gaXMgdGhlIGRlcml2ZWQgcG93ZXIgYWZ0ZXIgY29udmVydGlu
ZyB1bml0cy4gbWF5YmUNCj4gdGhhdCBpcyBzcGxpdHRpbmcgaGFpcnMsIGJ1dCB3aGVuIGRlYnVn
Z2luZyBpc3N1ZXMgeW91IHVzdWFsbHkgd2FudCB0byBiZSB2ZXJ5DQo+IGNsZWFyIGFib3V0IHdo
YXQgaXMgdGhlIHJhdyBkYXRhIGFuZCB3aGF0IGlzIHRoZSBjYWxjdWxhdGVkIGRhdGENCj4gDQpZ
ZXMsIEkgc2VlIHlvdXIgcG9pbnQuIFdpbGwgcmVjdGlmeSB0aGlzIGFuZCBiZSBjbGVhciBpbiBk
ZWJ1ZyBwcmludHMgYXMNCnlvdSBoYXZlIHN1Z2dlc3RlZCBiZWxvdy4NCg0KPiBBbHNvIGZvbGxv
dyBhdGgxMWsgY29kaW5nIHN0eWxlIGZvciBkZWJ1ZyBtZXNzYWdlcyAod2hpY2ggZm9sbG93cw0K
PiBhdGgxMGspIHdoaWNoIGRvZXMgbm90IGFsbG93IGNvbG9ucw0KPiANCj4gc28gSSdkIHN1Z2dl
c3QgInR4cG93ZXIgZnJvbSBmaXJtd2FyZSAlZCByZXBvcnRlZCAlZCINCj4gDQpTdXJlLCB3aWxs
IGFkZHJlc3MuDQoNCj4gPiArCXJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJyX2ZhbGxiYWNrOg0K
PiA+ICsJbXV0ZXhfdW5sb2NrKCZhci0+Y29uZl9tdXRleCk7DQo+ID4gKwkvKiBXZSBkaWRuJ3Qg
Z2V0IHR4cG93ZXIgZnJvbSBGVy4gSGVuY2UsIHJlbHlpbmcgb24gdmlmLQ0KPiA+YnNzX2NvbmYu
dHhwb3dlciAqLw0KPiA+ICsJKmRibSA9IHZpZi0+YnNzX2NvbmYudHhwb3dlcjsNCj4gPiArCWF0
aDExa19kYmcoYXItPmFiLCBBVEgxMUtfREJHX01BQywgIiVzOiB0eHBvd2VyIGZyb20NCj4gYnNz
X2NvbmZcbiIsDQo+ID4gK19fZnVuY19fKTsNCj4gDQo+IEknZCBsb2cgKmRibSBoZXJlIGFzIHdl
bGwNCj4gDQpNdWNoIGJldHRlci4gV2lsbCByZWN0aWZ5IGluIHYyLg0KDQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX29w
cyBhdGgxMWtfb3BzID0gew0KPiA+ICAgCS50eAkJCQk9IGF0aDExa19tYWNfb3BfdHgsDQo+ID4g
ICAJLnN0YXJ0ICAgICAgICAgICAgICAgICAgICAgICAgICA9IGF0aDExa19tYWNfb3Bfc3RhcnQs
DQo+ID4gQEAgLTg1MjEsNiArODYwOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWVlZTgwMjEx
X29wcyBhdGgxMWtfb3BzID0gew0KPiA+ICAgI2lmIElTX0VOQUJMRUQoQ09ORklHX0lQVjYpDQo+
ID4gICAJLmlwdjZfYWRkcl9jaGFuZ2UgPSBhdGgxMWtfbWFjX29wX2lwdjZfY2hhbmdlZCwNCj4g
PiAgICNlbmRpZg0KPiA+ICsJLmdldF90eHBvd2VyICAgICAgICAgICAgICAgICAgICA9IGF0aDEx
a19tYWNfb3BfZ2V0X3R4cG93ZXIsDQo+ID4NCj4gPiAgIAkuc2V0X3Nhcl9zcGVjcwkJCT0NCj4g
YXRoMTFrX21hY19vcF9zZXRfYmlvc19zYXJfc3BlY3MsDQo+ID4gICAJLnJlbWFpbl9vbl9jaGFu
bmVsCQk9DQo+IGF0aDExa19tYWNfb3BfcmVtYWluX29uX2NoYW5uZWwsDQo+ID4gQEAgLTkxMjks
NiArOTIxOCw4IEBAIGludCBhdGgxMWtfbWFjX2FsbG9jYXRlKHN0cnVjdCBhdGgxMWtfYmFzZSAq
YWIpDQo+ID4gICAJCWNsZWFyX2JpdChBVEgxMUtfRkxBR19NT05JVE9SX1ZERVZfQ1JFQVRFRCwg
JmFyLQ0KPiA+bW9uaXRvcl9mbGFncyk7DQo+ID4gICAJCWFyLT52ZGV2X2lkXzExZF9zY2FuID0g
QVRIMTFLXzExRF9JTlZBTElEX1ZERVZfSUQ7DQo+ID4gICAJCWluaXRfY29tcGxldGlvbigmYXIt
PmNvbXBsZXRlZF8xMWRfc2Nhbik7DQo+ID4gKw0KPiA+ICsJCWF0aDExa19md19zdGF0c19pbml0
KGFyKTsNCj4gPiAgIAl9DQo+ID4NCj4gPiAgIAlyZXR1cm4gMDsNCg0K
