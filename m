Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1E566203
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jul 2022 05:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiGEDvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 23:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiGEDvm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 23:51:42 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDB10FEB
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1656993101; x=1657597901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s+Rv/SdJObON06RHTsdyu6N0oNHkNkhvzRdmfU+eU3s=;
  b=SnbNvgOnqCS+UwwZLCRuQoU2l/8CwBDBH4FHlIYRTrhny1LXwTKv4tj/
   JcgievYED6+Hu9qxD4I5TnZTd8tsVD8jhcMWyA/bUHxRdgb4PW1UA45CR
   whQ7wdixxMhM908xJLaNb91l9+tP1qj+jjjXoj636o1lmaEuzQ+k0ABYp
   Q=;
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezf087p73Loeoo/LBVvSZFUR/zaWCk8ieJm6Ism6owOo5iQ1wtbmnwLrSdW+PenF/88bLVSSrkYZ+BC+iRaF1JNp7lqD9lX6Mq7kHmJFebTbpFIkXUEARJJRLuhVgdJZLVCFMiwJV9cIqhE2olFAUwfDVj9rIX44XzVlXb9XH58A6D1XGWuX6QDDA12YjCfwVl2t70at6yZxQf31HM0af0PL8rYwX3CPJueeHozLJuQobw9SZgqawHX5cLQs6xamcSYAm6Hfhu09IwXq4YIH4KB5O1iIsBvLUFH+6m7dmc9nrSmxhrOC2P7CcJRmst95Uxo4Jf4jIbWlbab2O54x4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Rv/SdJObON06RHTsdyu6N0oNHkNkhvzRdmfU+eU3s=;
 b=DiYbGFL4Po1mnzkXHc6a0hTRXRIwT9pcWiQtExoYWvHDTm0ABX/4WEkkbe7VZ0yfFN7BVd7wKPB7L5bP86tsg6b/f1Gi1Wvx+dPpZ7+BkfovEyM8OxVITJsn3wfHZBo7KzFjSYK7R/vms3Cszeyb5EEymhYgDfKuJlK55YJLH8JlWdSPjgboVw5fphQrMK72aNp1OEs87Wla5xXGWd63fieBU7OhV7A0dm2WEsvKMwuiW6CADXNNKzMCGvz7dYpYo7Mqa1VSlWgGGyBX45lvhX662aAyg9UkWjp6Rv4G/Q50e6Eu1mBDb07O9TQGSkyq7CRhyKS4RePKIWM/mtbxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB3652.namprd02.prod.outlook.com (2603:10b6:207:4a::22)
 by MW4PR02MB7284.namprd02.prod.outlook.com (2603:10b6:303:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 03:51:38 +0000
Received: from BL0PR02MB3652.namprd02.prod.outlook.com
 ([fe80::ec4a:7669:7a3a:27c5]) by BL0PR02MB3652.namprd02.prod.outlook.com
 ([fe80::ec4a:7669:7a3a:27c5%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 03:51:37 +0000
From:   "Paul Zhang (QUIC)" <quic_paulz@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Paul Zhang (QUIC)" <quic_paulz@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v1] cfg80211: parse RNR IE about MLD params for MBSSID
 feature
Thread-Topic: [PATCH v1] cfg80211: parse RNR IE about MLD params for MBSSID
 feature
Thread-Index: AQHYjSQdeY1REoo+pEW6TNSMyDOc9K1vKsIQ
Date:   Tue, 5 Jul 2022 03:51:37 +0000
Message-ID: <BL0PR02MB3652335E49B4762AF40D084780819@BL0PR02MB3652.namprd02.prod.outlook.com>
References: <1649335871-9173-1-git-send-email-quic_paulz@quicinc.com>
 <13d1ae9e406d7192e0b47dac5496f16eac7387d7.camel@sipsolutions.net>
In-Reply-To: <13d1ae9e406d7192e0b47dac5496f16eac7387d7.camel@sipsolutions.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43109665-6b40-47a8-6e2d-08da5e39a9a9
x-ms-traffictypediagnostic: MW4PR02MB7284:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jv3smVSV9AoHSWGOuHNSiBiQPwdpzgWMCqo5SjvUtvhVV5LZpzSishUo4LwNUc1MrCQ65lykAK7Xj2X7J9aJo5bQtu1R5Va36PmflWxD4iA3UBIntlTFJfZjRQ8+hss8Ho/oEmLb7Jj9ZpAlFTsOxfw7N6ocVQv+bgDhYTKsoErrTSmjKaGqQGHTHOEQYIjvfaMNB3Z3QqOlVNpzzdUzHJwlo4HmEzyEQYw7NXxpZG31BNe4JbynvORoWDD+oz3QTD2gXCPeBQvOgeVMtaL9r4RJ7gJkx5vkNBdpBwlo99RBKu2JQZC0Dd8d/AwJEdA3QlLTbG8Hfgy+/kjpX3IZSFtaTFyU3SaGNSxI46Ur631L+tRhKpMMFskyZ1mRSGBWbcQ2mK1OLq7BrjgKE6rJi3sG71uNM/cwJb3YjgKFYcFR7u+2GUWoJrTprMZ65uS9jhjykXjogsRMfV0PhXEildu0DP3i/83uZGi/azOFwyrR+rsf1JkSspeLIoRFvcJxo8Pvq8PPGcn3YRZVHgvAHBC2/z7eiv6dS1hw/mMSDLBk2QxUJet4hg8hmer6esHuQZXyB4kM6h5DbtgB0PxTZZvYL2dGBYwb01Z90YKOrfDjkRKX6v3SC9P2p9DR4ovonAgx1AAL1C3GTScm9zaHW86xdSacggF/vEnK6d4WV/XlccvV3qSqHAaOu1VP6ZQdiuyDX5yBm4QiBrJ2ZR58zbYYAjMlLsVwZjJHCoDAL6ZjqovRz5OT/gdBPphxV60sk/fUd4upupWIQB3yhRvCyfbLvsbzPvpj/WRIMPQ/Jd6ydMv8tJEpqKLlSmv7WsGOUSz5apUAvo5RFjmzmZ6cSOegKPcMYaK/MQwPytApBzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB3652.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(4326008)(64756008)(66446008)(8676002)(66476007)(76116006)(66556008)(33656002)(66946007)(38070700005)(966005)(8936002)(52536014)(110136005)(316002)(478600001)(55016003)(71200400001)(5660300002)(2906002)(41300700001)(9686003)(86362001)(122000001)(26005)(38100700002)(186003)(83380400001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmRFN2dhc3VDeFRTMUlvb01rblFGTTZUMHhud1VqR1J4RVF0S2NuTkh5RlJy?=
 =?utf-8?B?cm9OWmtkNDcxY000TmdZbkE1Sk5CeC8yZUx6WlpnTW1VRDVvOFJwNVBmait2?=
 =?utf-8?B?V1pYMDRQUk5NMGR1L3BiUmE2U3RnY1VmWlFrTFJXNlNUdEc1dXdSTVRIZ2Nw?=
 =?utf-8?B?d2czYWYwSGJ1dEFwVzAzcXBraytXbmF4NkFsWnAzNmdrZHBKSFNQUm9POExY?=
 =?utf-8?B?VS91dXpoMDNZTjYxN0p4NkRjRGJEa1gveWhYdHk5eXhFd0kyWjdPUVlvazlh?=
 =?utf-8?B?QnRyZk1LQnhhcDNKOXZ5SkdUaWxHY01KL0J1ZzRGNVZVamNON1I2YTcwNmor?=
 =?utf-8?B?ckNjc2ZtbWZWKyt0azBTejBRTTl0OXJkb3dEemxuOHFqanBtRVJBU1ZBK0xQ?=
 =?utf-8?B?Q3Jvem9vcGtvc3dYaWhCZ09uQzJNakFiUU8zYmlQQWUrcUdjZFB6YnA3S3Jy?=
 =?utf-8?B?RjM0RmlDdEl6NjNta1dxSXRzeHF5Qy9nbjJLbnNhS3VrQ1Q2OUhxTjBvcXBw?=
 =?utf-8?B?WnhjdGhnckN2azhKcytFYUZSeG5PM3dwdDcvMTdsbHJ0bUV2cmovRTZKUUdP?=
 =?utf-8?B?N2dIbEZOak1WVnM1NTVXbHI0OEM3Z1M4THpMd3lraXhuWmROMHQ4RDdBdXg5?=
 =?utf-8?B?NWdhNEQycWJiK0l5ZnEraGNZd1JUU2V0ZGQ5UlQ0ZkE3Q3hqZUpOWFBpYkR4?=
 =?utf-8?B?T0lLemhPQkxTSjlaUHBMUDRZSGcrTFZJZWY0bjd1bGhsNjdKeVQyZzB6WFNn?=
 =?utf-8?B?VnJPN29PcWpUQnpxbzZ4MWtuR3hEQ3pGOWxpUmVuRnBGVG5jbUFOT0JrMDdV?=
 =?utf-8?B?OGVRNzBleXJwcUI0WE9GWmp2UHBVMEQxZnNIamxPWEd4aXVxMmtuUFBxZnlB?=
 =?utf-8?B?dFZFVmVidW4yWnUyZTFkblJtT1FLSU54dTRzTHB0UFUyMTNzbnRyS0RkQlU0?=
 =?utf-8?B?ZW1tc0EyczlUeFUra0s3cWdtcWZPeXRqTG1jWHNkellvTmk5emQvWUczRC9z?=
 =?utf-8?B?eFhnVU9IVXdianZGMDhlaXFCdzdGSHJENHNseVN3TlRSUEUwMkwxWXBsRWpI?=
 =?utf-8?B?ejV4WUwxdFd6bFlIVXFEQklobHB3V1l2ckwwR3E4azY1Z0gxdXhIR0g1UXZo?=
 =?utf-8?B?UWZEU1VVWlNEb0lRM29qcXRGNjJJK2hOeW00QWs0b001U0FsQjFKb3JhUDJz?=
 =?utf-8?B?VFFwN2I1Zk5sdEdxSldzTmVET21rQmw0NWd2YVB3YWd5VFVyTjFubUtmbndk?=
 =?utf-8?B?RmN2bjFnYm1PZnlFRkR2YWNRMnJMenlZdkJMclZxMXBERmM0RFpHVUJIMm8r?=
 =?utf-8?B?dXlsT3ZhZEwwMXZVY0ltb2JDQWszZGw3L2tPcUpQelRONFZ3YjlQYUZVYWhK?=
 =?utf-8?B?c1pFRmVRNk1MWEJOSXJHSXdIY1RLVzhnMHVsd3FYYWdpbHN1M08vbDdHa1pU?=
 =?utf-8?B?cjhaTGh3TWFJYmd4TDYyMWh0bmc3YkxJMHJ0T0kyWHJyWWFHZUZodHdIL2FF?=
 =?utf-8?B?Z2txaWtGUzhnRDFLbTR6N2Jab01TRHA3bHNONllEanZjMkdhdDlHUEV6VlF0?=
 =?utf-8?B?THg3a2Q4dHRhTTFsTlRiSFlHOEhmU1VSNTNmcmF5UFl0cXZ2dTVBYTZTcWxM?=
 =?utf-8?B?dnVraVU4MGQ4RTlvM290dFpVekllTi9UQ2JESzFMYkhtR3RXV3BHa2pmZnZp?=
 =?utf-8?B?V0NOZkw2QkVEN2U5bE1Ldk5CZlRQRVhQNEo4OTk0aThSeDBucERNTW1KdzdE?=
 =?utf-8?B?OFo2ZUU0eGhhOFhleHZaTlZuMk80Y3ZqMzRlR2pwb2VDTUZRN0ZndXpFUVNx?=
 =?utf-8?B?ZGpBOVhlTEtUcnhkOUpsTTNDdnh2OWlTR0d4OTdOMFlvZ3c0aFIxTlllbEdU?=
 =?utf-8?B?d2Y2NmxxdnQ2bEQ1b29DclhuSGV1Qnd3U1g0UjVJZGNLdFA5VE9OazZSZjNJ?=
 =?utf-8?B?aHdxRG9pNld5QnBmUGRvVHFLV28zWGNvbkxCQ24zeWwxL2x5cGFJWm1Cd0hh?=
 =?utf-8?B?MjJhb3U3WDgwQ3VvOU9LZDkrUkwxNlp0RVNTQWdLdlpMRkVvS3hzOC9vUStp?=
 =?utf-8?B?WEY5dmVndytkWk90bjZGSzNtU1hnZlVZeUtiK3Q1Um5kWW5USjhEMVEydUQw?=
 =?utf-8?Q?uh0lMYuPo76uOjNiSf6tGgQdy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3652.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43109665-6b40-47a8-6e2d-08da5e39a9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 03:51:37.8477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0/CZ0WgkE8paMHZitWz5RSJS24f0x3PZhu1oDbovMwUfmQAvqvepU9xUJbABVd60Q7IqT5HDs9EqSFabRTG5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7284
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

W1NvcnJ5LCBteSB0aHVuZGVyYmlyZCBoYXMgY29uZmlndXJhdGlvbiBpc3N1ZSBjdXJyZW50bHld
DQoNClRoYW5rcyBKb2hhbm5lcyBmb3IgeW91ciBraW5kbHkgcmV2aWV3Lg0KSSBoYXZlIGFsaWdu
ZWQgdGhlIHBhdGNoIHRvIDExQkUgRDIuMCBhbmQgIHVwbG9hZGVkIGEgbmV3IHBhdGNoIGhlcmUu
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0
Y2gvMTY1Njk5MTE2OS0yNTkxMC0xLWdpdC1zZW5kLWVtYWlsLXF1aWNfcGF1bHpAcXVpY2luYy5j
b20NCkkgcmVwbGllZCBzb21lIGluZm8gaW5saW5lIGZvbGxvd2luZy4NCg0KPiA+ICsgKiBQZXIg
dGhlIGRlc2NyaXB0aW9uIGFib3V0IE5laWdoYm9yIEFQIEluZm9ybWF0aW9uIGZpZWxkIGFib3V0
IE1MRA0KPiA+ICsgKiBwYXJhbWV0ZXJzIHN1YmZpZWxkIGluIHNlY3Rpb24gOS40LjIuMTcwLjIg
b2YgRHJhZnQgUDgwMi4xMWJlX0QxLjQuDQo+ID4gKyAqIElmIHRoZSByZXBvcnRlZCBBUCBpcyBh
ZmZpbGlhdGVkIHdpdGggdGhlIHNhbWUgTUxEIG9mIHRoZQ0KPiA+ICtyZXBvcnRpbmcgQVAsDQo+
ID4gKyAqIHRoZSBUQlRUIGluZm9ybWF0aW9uIGlzIHNraXBwZWQ7IElmIHRoZSByZXBvcnRlZCBB
UCBpcyBhZmZpbGlhdGVkDQo+ID4gK3dpdGgNCj4gPiArICogdGhlIHNhbWUgTUxEIG9mIHRoZSBu
b250cmFuc21pdHRlZCBCU1NJRCwgdGhlIFRCVFQgaW5mb3JtYXRpb24gaXMNCj4gPiArY29waWVk
DQo+ID4gKyAqIGFuZCB0aGUgTUxEIElEIGlzIGNoYW5nZWQgdG8gMC4NCj4gPiArICoNCj4gPiAr
ICogUmV0dXJuOiBMZW5ndGggb2YgdGhlIGVsZW1lbnQgd3JpdHRlbiB0byBAcG9zICAqLyBzdGF0
aWMgc2l6ZV90DQo+ID4gK2NmZzgwMjExX2hhbmRsZV9ybnJfaWVfZm9yX21ic3NpZChjb25zdCBz
dHJ1Y3QgZWxlbWVudCAqZWxlbSwNCj4gPiArCQkJCQkJdTggYnNzaWRfaW5kZXgsIHU4ICpwb3Mp
DQo+ID4gK3sNCj4gPiArCXNpemVfdCBybnJfbGVuOw0KPiA+ICsJY29uc3QgdTggKnJuciwgKmRh
dGEsICpybnJfZW5kOw0KPiA+ICsJdTggKnJucl9uZXcsICp0YnR0X2luZm9fZmllbGQ7DQo+ID4g
Kwl1OCB0YnR0X3R5cGUsIHRidHRfbGVuLCB0YnR0X2NvdW50Ow0KPiA+ICsJdTggbWxkX3Bvcywg
bWxkX2lkOw0KPiA+ICsJdTMyIGksIGNvcHlfbGVuOw0KPiA+ICsJLyogVGhlIGNvdW50IG9mIFRC
VFQgaW5mbyBmaWVsZCB3aG9zZSBNTEQgSUQgZXF1YWxzIHRvIDAgaW4gYQ0KPiBuZWlnaGJvcg0K
PiA+ICsJICogQVAgaW5mb3JtYXRpb24gZmllbGQuDQo+ID4gKwkgKi8NCj4gPiArCXUzMiB0YnR0
X2luZm9fZmllbGRfY291bnQ7DQo+ID4gKwkvKiBUaGUgdG90YWwgYnl0ZXMgb2YgVEJUVCBpbmZv
IGZpZWxkcyB3aG9zZSBNTEQgSUQgZXF1YWxzIHRvIDAgaW4NCj4gPiArCSAqIGN1cnJlbnQgUk5S
IElFLg0KPiA+ICsJICovDQo+ID4gKwl1MzIgdGJ0dF9pbmZvX2ZpZWxkX2xlbiA9IDA7DQo+ID4g
Kw0KPiA+ICsJcm5yX25ldyA9IHBvczsNCj4gPiArCXJuciA9ICh1OCAqKWVsZW07DQo+IA0KPiBU
aGF0J3MgYSBiaXQgd2VpcmQsIHdoeSBhcmUgeW91IGRvaW5nIG1hbmlwdWxhdGlvbnMgb24gdTgg
cG9pbnRlcnMgbm93Pw0KPiANCj4gU2hvdWxkbid0IHRoZSBlbGVtIHN0cnVjdCBiZSBtb3JlIHVz
ZWZ1bD8NCj4gDQoNCnJuciBpcyB0aGUgc291cmNlIG9mIG1lbWNweSBmb3IgZWxlbWVudCBJRCBh
bmQgbGVuZ3RoLg0KQWxzbyB1c2VkIGZvciBjb3VudCB0aGUgcm5yX2VuZC4gDQoNCj4gPiArCXJu
cl9sZW4gPSBlbGVtLT5kYXRhbGVuOw0KPiA+ICsJcm5yX2VuZCA9IHJuciArIHJucl9sZW4gKyAy
Ow0KPiA+ICsNCj4gPiArCW1lbWNweShwb3MsIHJuciwgMik7DQo+ID4gKwlwb3MgKz0gMjsNCj4g
DQo+IFRoYXQgcmVhbGx5IGNvdWxkIGJlIG9wZW4tY29kZWQuIEFuZCBpZiB5b3UgaGF2ZSAicm5y
X25ldyA9IHBvcyIgbWF5YmUNCj4gdXNlIHRoYXQ/DQo+IA0KDQpybnJfbmV3IGlzIHRoZSBzdGFy
dCBwb3NpdGlvbiBvZiBuZXcgcm5yIGVsZW1lbnQuIA0KSSBoYXZlIGFkZGVkIHNhbml0eSBjaGVj
ayBpbiB0aGUgbmV3IHBhdGNoLg0KDQo+ID4gKwlkYXRhID0gZWxlbS0+ZGF0YTsNCj4gPiArCXdo
aWxlIChkYXRhIDwgcm5yX2VuZCkgew0KPiA+ICsJCXRidHRfdHlwZSA9IHU4X2dldF9iaXRzKGRh
dGFbMF0sDQo+IElFRUU4MDIxMV9UQlRUX1RZUEVfTUFTSyk7DQo+ID4gKwkJdGJ0dF9jb3VudCA9
IHU4X2dldF9iaXRzKGRhdGFbMF0sDQo+IElFRUU4MDIxMV9UQlRUX0NPVU5UX01BU0spOw0KPiA+
ICsJCXRidHRfbGVuID0gZGF0YVsxXTsNCj4gDQo+IFlvdSdyZSBub3QgY2hlY2tpbmcgdGhhdCBh
bnkgZGF0YSBpcyBwcmVzZW50LCBpLmUuIHRoYXQgeW91IGFjdHVhbGx5IGhhdmUgYQ0KPiBzdWl0
YWJsZSBsZW5ndGg/DQo+IA0KDQpBZGRlZCBzYW5pdHkgY2hlY2sgaW4gdGhlIG5ldyBwYXRjaCBm
b3IgdGhlIFdoaWxlIGNvbmRpdGlvbi4NCg0KPiBbc25pcF0NCj4gaXQncyBraW5kIG9mIGhhcmQg
dG8gZm9sbG93IHRoaXMsIHRvIGJlIGhvbmVzdCAuLi4gbWF5YmUgdGhhdCdzIGludHJpbnNpYywg
YnV0DQo+IG1heWJlIHdlIGNvdWxkIGRvIHNvbWV0aGluZyBsaWtlDQo+IA0KPiAjZGVmaW5lIGNv
cHkocG9zLCBkYXRhLCBsZW4pIGRvIHsNCj4gICBtZW1jcHkocG9zLCBkYXRhLCBsZW4pOw0KPiAg
IHBvcyArPSBsZW47DQo+ICAgZGF0YSArPSBsZW47DQo+IH0gd2hpbGUgKDApDQo+IA0KPiBvciBz
b21ldGhpbmcgdG8gc2ltcGxpZnk/IEFuZCBtYXliZSB0aGF0IHNob3VsZCBhbHNvIGhhdmUgYSBi
b3VuZHMgY2hlY2sgLi4uDQo+IHdoaWNoIEkgZmVlbCBhcmUgbWlzc2luZyBxdWl0ZSBhIGJpdCwg
bm90IGp1c3QgdGhlIG9uZSBJIHBvaW50ZWQgb3V0IGFib3ZlLg0KDQpJdCBpcyBub3QgZ2VuZXJh
bC4gQWJvdXQgdGhlIGZvbGxvd2luZyBzZWN0aW9uLCBpdCBuZWVkcyB0byBtb2RpZnkgdGhlIHZh
bHVlIGFmdGVyIGNvcHkuDQpJIGFkZGVkIG1vcmUgY29tbWVudCBpbiB0aGUgY29kZSB0byBleHBs
YWluIHdoYXQgaXQgZG9lcy4NCkhvcGUgdGhlIGNvbW1lbnRzIGNvdWxkIGhlbHAgdG8gdW5kZXJz
dGFuZCBlYXNpZXIuDQoNCisgLyogQ29weSB0aGlzIFRCVFQgaW5mb3JtYXRpb24gYW5kIGNoYW5n
ZSBNTEQNCisgICogdG8gMCBhcyB0aGlzIHJlcG9ydGVkIEFQIGlzIGFmZmlsaWF0ZWQgd2l0aA0K
KyAgKiB0aGUgc2FtZSBNTEQgb2YgdGhlIG5vbnRyYW5zbWl0dGVkIEJTU0lELg0KKyAgKi8NCisg
bWVtY3B5KHBvcywgZGF0YSwgdGJ0dF9sZW4pOw0KKyBwb3NbbWxkX3Bvc10gPSAwOw0KKyBkYXRh
ICs9IHRidHRfbGVuOw0KKyBwb3MgKz0gdGJ0dF9sZW47DQoNCg0KVGhhbmtzLA0KUGF1bA0K
