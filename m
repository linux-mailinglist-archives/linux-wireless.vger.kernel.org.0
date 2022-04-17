Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A384C504805
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiDQOc7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 10:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQOc5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 10:32:57 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4287167EB
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1650205821; x=1650810621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0WDjaVo4sbkG8cSMWG4hRyCPkcD1MWwwGot509deogE=;
  b=JVst6sZy4bumy+plglrEmayM85oxIwMIKIz4p4ILBpFHE5Uj+LQsyaPM
   o2bLo5XBch8vAp/zvYX8XZKka4hbvd1f1VN4pgJ0kgUMWiKBnSfcTk9Jf
   n/7XKaVdZXEEXK5K4RcCwYmpS+24msDc+sYxjDP2aG1hHokGZsCpVBgRn
   s=;
Received: from mail-mw2nam08lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 14:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC2Q+6VBkkk+LIfQJxedLdvMMsjmYqdOz45v8D+/8lPAvk0dV/Fi76qRkX1aLQcTH4VfrmngAFdiWYbJTcea9FOA0dMmAmIsLF4wDzPNG2R67pQap6xROJXaiJ9gM3ZzgtiDTz9Ra2MrWBxmQXttD3pHqIQANHUchFkYxp1sFanzkQYc03WV1pKw/KiSCs11SR9Q5QWGBUeW5sDz4MOCBbGmwVhehY66ZVZHCl2PVOtjASOKDx4Hyg/0Ym7xg/htsakGlZzy7iyQq9wbZmobWaaA6eLqtBZ1er1SnkNxG/2pEuQcdjawl/+nat+uMw6OytSohzflVMOev3Z7McnkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WDjaVo4sbkG8cSMWG4hRyCPkcD1MWwwGot509deogE=;
 b=NOI8trpPRYho3xklFD6/EImrW1k9LczzGc9hd+X+ofd0XnmKUX6ON0Y+ooUBdzWw2ZtTBHupoOwMmAVBEFFAZDRYDKuJvNwX/otTfzVC5Md1myfh9tdROn0qhRAVHWT4rLSS7HLoP/pD0riLM+PnSmGZWlcgkLmYzJzXFtmWP21PoLL2nIRcz8FCyjggE3JbPI1NzgQGz9QTe+imL4y/2zWxiqWJ+bVaAkytJlzlF5LbLPyUA0YhkISJKHCcO0XUSpVcgANp7znAomNtFQF8n3DB2IAZfnym6u1G7fTtGCogrcgWpJUEZMrdBntnOb8B4EAj26o/IkeIFd0oIo3+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 DM6PR02MB6283.namprd02.prod.outlook.com (2603:10b6:5:1d3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Sun, 17 Apr 2022 14:30:17 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::955a:aab3:e6b:456]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::955a:aab3:e6b:456%7]) with mapi id 15.20.5164.025; Sun, 17 Apr 2022
 14:30:17 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: RE: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
Thread-Topic: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
Thread-Index: AQHYIkgqfAgpLdnS+EWoRYfPSRKpZ6y6KrAAgA9VNCCAAD8mAIAB5AFwgAAUnICAHtl0oA==
Date:   Sun, 17 Apr 2022 14:30:17 +0000
Message-ID: <DM6PR02MB49379E377E3E7940540DF587E9F09@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
         <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
         <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
         <a537c6e02afbfa26eec2a54dbd8bc649f77ae3a3.camel@sipsolutions.net>
         <DM6PR02MB493734ADBBC6C996845B9EF3E9179@DM6PR02MB4937.namprd02.prod.outlook.com>
 <babc75d310031f9f92736d5da65679ca50542849.camel@sipsolutions.net>
In-Reply-To: <babc75d310031f9f92736d5da65679ca50542849.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec39a8a6-4743-4058-d9cd-08da207ecb7e
x-ms-traffictypediagnostic: DM6PR02MB6283:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB62830BB440087AEADDCAD05395F09@DM6PR02MB6283.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 264nAKTAlQ0Nrnap6aqUo5oyzPHwFZvkoIlBbCC2/qnhVzZ57uoNdbycy2tPpEh98Eb2qJcTy8uxnrd/bWrKF+iCObGkubfIANEVKNvq1DckOo7Y1Syqa1MU/kOq9P0JBcTHkmwgdrzzql6JcFPY+9K1PbaII4nPnsYyh/bAQeImqK8s6c8AwwUnzaaj1NON0RhJlzLxwCpFQy/ktGKjoIxXgWVd/Tm1vF5px8hTaN/WYQHryCiXVIwWpaP71sC4cCreU4jIQPpdZv8+6ZS72L3kiyGpSIeFKcApP/anrEnPs/L68RppzzQQublxCE2qGPnF/CuHt6SCkPxExMl6tV3LfmuszRJGL8i2opiYt1GaRd4Dez4nGfEM1ltMQs8+JHf1p1vg1uIrWRjXkWeDBoLA/9tGMQNDkPMMPxrNF+4rPLuLapwqugpgBvixvK+z5dfM45yOOmR4AvwGBs3J+155S0KEU3hr5ffTJCXXxBM0tJ7sUfaw9GbfijBzZv+ITLTV63kBYzna9wzJZfrygEJeIC6L9F6d8DoWkkPzwDLs0bIGBOdDUUDnigGbO7D+/f48vTvcJtmEa3hmxXU6l1QjPg2MOE5uh4U10ZNvcwtlyjEEg9Brs3DpP3ibZjulfhRE7+eg914VeYOfTpdgdLfMaqccZbijxXla8bpbIlGLPSod1PiGV67IbWe25T2duvm8n9JjfGjMaftxXsi9+jTTucFifA3wn1b2uCco89A7gZVJ9zNn4ElxVnNWu3l4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(38070700005)(316002)(66476007)(66556008)(66446008)(4326008)(64756008)(8676002)(110136005)(66946007)(76116006)(54906003)(55016003)(26005)(9686003)(2906002)(53546011)(71200400001)(33656002)(83380400001)(52536014)(508600001)(8936002)(5660300002)(6506007)(186003)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDJVWW0rVTZOMVFGR1RqZ1E1VEw4cUEzOHNoM0hiL0xmY01VLzhVU1RteFZr?=
 =?utf-8?B?aVlJWWIvVnY5TmlRTmlNSUtuU2lqV1lHY05ZSkhiaC9kODBpei8wblVOQ0Y1?=
 =?utf-8?B?S3c5dHovTTQ4Rm92WmRWenFMdU5VWnpjdDk3eVdWWTVPd2FQcHVlUEtBS05u?=
 =?utf-8?B?aHVKWEdLK3AzT09QRDl6L3dRVVE1Z0FUaGZUbExRTFBHYVdIdmFkSlBEd3Vi?=
 =?utf-8?B?bjU2VExJS2V2M0loVXk5ckJUbUlGUmxhelVzdytjWHZLQ3hPcFhnN2lLdC8z?=
 =?utf-8?B?cTNwRk1LOG11ME5nSjltN2U3Rm5JSUYwRUZzTWtYZzI0TVM1bGxicDRjRXpE?=
 =?utf-8?B?YjROR3Y5RERsMFoxdmlsTnJCdkpmc2VlWE5PNHhCbnIxZ1NtK0NRSTNJNmFV?=
 =?utf-8?B?VEszcjk1b0RVM1h1S3FyUFc5bGFtZmc5T3hXd05ZTlNOMWprN0pCSW9TU2N6?=
 =?utf-8?B?WW10cnFCUmoxY1pCaXJkckpteXVRc2RseVd3c1U4TEc1YlJSd2swVXB1NUJz?=
 =?utf-8?B?bHNrcElqdVJTeThaeWZNbHg5MVRUZmdad3dJSUI4c1F3KzRiaGV1YnU4b3g2?=
 =?utf-8?B?Z0JjdTgwYnNieUIxUlZrbzA0QjFqV1AwL3BCdFZUNmlaNzZJUHFNWStmOWV6?=
 =?utf-8?B?NEtnV2g1dzhtMzdBTzNacy9FQm1LcUhJQ3RTL2xYbDdQdTh3clRSeStqeXB5?=
 =?utf-8?B?ZEluRUNicWxHcEtzaGpndzdFWmdyMTlGMmliRkdjTUNVRm1LVVJwcUtEMURK?=
 =?utf-8?B?cCt5anhMRG1FaC94RHZGQ0g5K2tXWUcybHVNS2JzakMyRGZpUWJLTWhxdkVw?=
 =?utf-8?B?d3ZaaUZ6RFdmNlhKZVE1MnZTUUxEenU5Tyt5SFVuT0RsK0pBZkxJQU11SWxU?=
 =?utf-8?B?SnJHS3E0Zm5TZHB6NThSeWcvQWZiU0ZSZ2Rmb042QzlicmJkS3JzZ3BVS1dM?=
 =?utf-8?B?S3BqMnpuejdSRkZrT3dsckoyeW5BSjJta0V3MHhSVmExTDFwT25BbWR4bm1R?=
 =?utf-8?B?YWp6MTF2dkdVVnloNHBWRFdhN25GTFo3RVNsUnp1MnprbWRxSFRqYTNqYVk1?=
 =?utf-8?B?WXJDOUdEeVlYRnFEdW5UcDRTMmdmV2dTOUNwamt3KzVYdUQrREZBMDhDd2tT?=
 =?utf-8?B?aUl3N29vL2FVdGdDcE9qNitqQjhLbXlqMlRZZXkxa0wzaHlEZjlydTYxeVhu?=
 =?utf-8?B?bkpaa1h4STRESk54RnBZbVA5UUViM1VvbDB5REFPM3h1aldSZmxzL3dRcm5n?=
 =?utf-8?B?OUhXSWtIUXNVUk1qZWlKOXlqaU1pSUoybnBmdUltZEQrTUxQdkIwZFRESDFZ?=
 =?utf-8?B?c1h5cDQrQ0REdTY2M0ovMTk1Q3BPWDR3VHhHUHVpcnRLUldZWUdpNFVkZUR3?=
 =?utf-8?B?bmkzZmUzRUZUVGtqSDluTXBQU3hWM21OakFHVmtYZ0FlamFHMGRlNzZlN2M1?=
 =?utf-8?B?L2FCY1JFNGtVR1Qyd1dkOWVtTnVCSWlCSDRPVXUxVUJGOWRkb3lrZVNwTXJx?=
 =?utf-8?B?U0JISFFoK293b3ZYSjUrZFBoZXpuTE0vZVNya0RadGFpZHNtR2NqOHdTMGND?=
 =?utf-8?B?MUV4NWN1UHpyZFJxK0Y0YlFEUjRvT0M4WjYzR2xzc3ZKQkJ2cmFMUWIwd201?=
 =?utf-8?B?L25ieDRwTkRaTEk4OWRRbjZxa2FhZ1lTNFM0eThkc0tLME1PdHU2emNiLzRz?=
 =?utf-8?B?TkZoR0s1MnpuUmpqQzVxSW1mRFFQVWZnTHQ1d2d2ZS9wcVB1b3pFTkcyQzV6?=
 =?utf-8?B?L0w4REhsYTQvQmcyQldhVGVUc3V6MmlIUkZ0TWxQVVBsQTU0aEMyKzRZU3VC?=
 =?utf-8?B?VVJxTlBPNVlyQ3J6cG5JZUp0TTVWeStlNGZtcllFTDBoY3ZVTUpZTG1WNmxw?=
 =?utf-8?B?SU5BdVkxalAya3dMdUFTSXFzVEhJSkRoUWdFRWdhYWxwNy9tc21OakV0c1Nk?=
 =?utf-8?B?UkUrVjB2SFFINkNKYjVVSUk0WC9vOWdVRTNlUDMrVVg1VUhleEhpazk5dXdD?=
 =?utf-8?B?TlVuK21lMmt6d0FFQ0x6d2dKRzZncVV3MUNlLzVYUmpHNTMwTGhuQ05HbURm?=
 =?utf-8?B?RFpKYjRzQjNWb0VHSkU3c0t3cmpaUDFwd0drUVZaaUZwRG5vQ2orUld0bTRF?=
 =?utf-8?B?K3dYM2FCYkpRdFJDMlREZXd3eHpXTnA0dEVPR21RK01nTFRMM0VvNzFXZUpU?=
 =?utf-8?B?UFpKTHZ0U0p1ejV5dW9YWHdYMklhV1VOb0JSelVvUXI4OFp3bWlmd0NBWElJ?=
 =?utf-8?B?VWgwSExJQ1REYzByZlRsKytzeTBhZ2g5QXdlbmhFYnJjQzdrZEtlcGtRaGdj?=
 =?utf-8?B?TkFqTk15a3krbHMzcWJVWW1uMHg0U1lXL3BYZnE0YUJjQjlaWkFsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec39a8a6-4743-4058-d9cd-08da207ecb7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2022 14:30:17.6059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/6RVoOa9Mzz8XnWpy6Phw2vpyWmZddRSxtQ+TkCu5KG0gcZdpwInRh5VwLLKtpYEvEorgbFmnCkxdBdAJv1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6283
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDIyLCAyMDIy
IDg6MzQgUE0NCj4gVG86IFJhbWVzaGt1bWFyIFN1bmRhcmFtIChRVUlDKSA8cXVpY19yYW1lc3NA
cXVpY2luYy5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGF0aDEx
a0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBtYWM4MDIx
MTogYWRkIHN1cHBvcnQgdG8gY29uZmlndXJlIDZHSHogbm9uLWh0DQo+IGR1cGxpY2F0ZSB0cmFu
c21pc3Npb24NCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNp
ZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2ht
ZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gT24gVHVlLCAyMDIyLTAzLTIy
IGF0IDEzOjUwICswMDAwLCBSYW1lc2hrdW1hciBTdW5kYXJhbSAoUVVJQykgd3JvdGU6DQo+ID4g
Pg0KPiA+IFNvLCBTdWdnZXN0aW9uIGhlcmUgaXMgdG8gYWRkIGEgbmV3IE5MIGF0dHJpYnV0ZSB0
byBjYXJyeSB0aGUNCj4gPiBpbmZvcm1hdGlvbiBmcm9tIHVzZXIgc3BhY2UgZm9yIFNUQVJUX0FQ
IGFuZCBTRVRfQkVBQ09OIE5MIGNvbW1hbmRzDQo+ID4gYW5kIHVzZSBpdCBoZXJlLCBpcyB0aGF0
IHVuZGVyc3RhbmRpbmcgY29ycmVjdCA/DQo+ID4NCj4gDQo+IFdlbGwsIEkgd2FzIHRoaW5raW5n
IGl0IHdvdWxkIHJlYXNvbmFibHkgY29tZSB3aXRoIHRoZSBiZWFjb24gcmF0ZSwgaS5lLg0KPiBh
cyBhIG5ldyBhdHRyaWJ1dGUgbGlrZSBOTDgwMjExX1RYUkFURV9EVVA/DQpTb3JyeSBub3QgZ2V0
dGluZyB0aGlzLCB5b3UgbWVhbiBob3N0YXBkIHdvdWxkIG5lZWQgdG8gc2VuZCBuZXcgc2V0IG9m
IHJhdGVzIGZvciB0aGlzIGNvbmZpZ3VyYXRpb24gPw0KVGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQg
dXNlci1zcGFjZSB3aWxsIHNldCB0aGlzIGJpdCBpbiBIRSBvcGVyIElFIG9ubHkgaWYgbGVnYWN5
IHJhdGVzIGFyZSBwcmVzZW50IGluIGJlYWNvbiBvciBiYXNpYyByYXRlcy4NCj4gDQo+IGpvaGFu
bmVzDQo=
