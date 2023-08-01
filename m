Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F176A881
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjHAFuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjHAFuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:50:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381A1B5
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je/+01fTk+caeF7NHXAkP7ezSEreJ9+9FcVXsyA/SB5Gn/bn4/8MgR3K//VtZCqlw/Qq1wXyMs8NDmGUdz8i19AHeDUr+rTph38xqlyKoqGLn0i43+w26AQzvzccmZgFQV83Yrz50dId+vwvilSK7rrSLVlq3mI8n0UayD9wQ8v9F+DIShqO0SJx6T3CVXU7ACE3EezXDUfxf/oBEF6JVvphmvK78cqrlUDTmOCnbHYdu77XnA+D/0XPQjisJF2Ep1iYjx11ZuWQZYOAplAVBXqSm1y1B847BYi+ZnrgQAcx/v8JbkYvWKz58boQkuG2uLeaXm1YtPRsaXy9UGXlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6qLgFyBDs+oJd5N99db+YMm7xeZbAPb0iDxsDVapj8=;
 b=YBNSWFmcMunr6OzXv4JOGsideRkKbbYLSdYEbZGr9RzqBjSK9hvEtyQ641hp8CmHTTr9MHNi2Nuw37I5e5/ctzxn47I5nLaGwlMwmVjpMQkmbyiU8rDoIav7UsSUCqpyuadO6HLnrjN5f9+OULHv8xEV2eL5LVNKX0mTIVqIAU4q9KDQxpYzGL94SBmI37LEiWalOyZMZq0jsHlq0te1qMtpgy8Mfj00AkKOc0dKNS2Aplxs1qcqfurmZrRlOuFleW3RoKBdr+5sT5ux4OBjz4wXmJYmr34IlgU6WuY6QTnH6jHitNqaP2Eb6tKXZ0Lptee8O+0h93UDGEYjm6REeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6qLgFyBDs+oJd5N99db+YMm7xeZbAPb0iDxsDVapj8=;
 b=B0Iro4jJU9iUAAYP8vgX7/lkfUaS9LfRC1DBhDykLEqnbOhEwiz9SPg7zdmINxwljJATvwCRcT+4CcFpzVdvqrV74YZfOuisy7C7uys24dHvZkp2gD/HDYRg8Ob8/ElU62NRt0wmJcZuHu0/oKCbk6Zxkm0gYQS9XALYESJmlWY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBAPR04MB7349.eurprd04.prod.outlook.com (2603:10a6:10:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 05:50:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 05:50:03 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnBG0VbUku3Gob0RoOlmlRWbISqeAAVIG+AALL1uhA=
Date:   Tue, 1 Aug 2023 05:50:03 +0000
Message-ID: <PA4PR04MB9638F315ECAE762875B5FEE3D10AA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMx46aLztpKHqtS_Ab_yV_0GvRdWinf4C9o=9zqtTGehQ@mail.gmail.com>
In-Reply-To: <CA+ASDXMx46aLztpKHqtS_Ab_yV_0GvRdWinf4C9o=9zqtTGehQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBAPR04MB7349:EE_
x-ms-office365-filtering-correlation-id: 90ea3b6f-06e2-46a9-e259-08db925326bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBkrF3uueaevKPUQrZxNvT+MlZQe3OlN58s/7Rn8jYQ08rFSQI2jIb6cLqYVmOEwU0Odw5bEe+EwbsZvTIh0z/pZc0vsnM8whcXG4WFXbvPKs9jqYkNoiW7/rCetHyNY0rUlWTYnHYpjvVIojt2ozbS9+p+in0KiWUdSWKKk8MTL+a7z21yoe6tG+r1ALJZBWH/c4p0i32enWVfg9eWD3GxgQFugEyg91RLFJQpHT665IBChfmVX96hjvGwxKoHcMkn+JF7TmS67E2Dt5qNF8ynIql6G5qzvq37QEGVurjlNSSq0VTTxE9m+749vgs4eMQlUcARVDgC7AWzKeJYouKtqZpAU8fghqfX86LHZBdhWDZRTLKjJjBKbsgLKwgwT3spiQ1S4eUOFpzjXwebXCQDPCPKXc6wd637W07oxV3fwUziQBzitCBrVRZczFiZJwBsAcmIrYrVUeGclyw++01vnM0VTXhUtYbUI5YLpLcBPCA/dfVJo0g4dyLP521VfuCDYkZrsxcDjYj9tSZbX2TarfvitGhhzX7BT0pD/6yglier9dbylQ5POv+qDwGo0kF06dwT0ZgWByqkTnCyQqkyXkJDpbYjUai3hIOCkj2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(52536014)(54906003)(122000001)(966005)(9686003)(33656002)(6506007)(7696005)(8676002)(8936002)(55016003)(5660300002)(66946007)(76116006)(66476007)(64756008)(66556008)(66446008)(71200400001)(53546011)(4326008)(6916009)(2906002)(83380400001)(38070700005)(478600001)(41300700001)(45080400002)(86362001)(186003)(38100700002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bS8yRFZPY0xMM1NxcTFudFF4TUh1aEFpSXVhWTh6YkJvMEh2Y0ZTcmtqenZl?=
 =?utf-8?B?VGVpbElWeXBwdHhyNzludlNCRVBwRyszamczZE04eHc3U2NsN2M5Qy9vN2dw?=
 =?utf-8?B?OGVlZ3ozRUJLTUtJZDFFTHhlMEpxa2dEa3NkbldldDhYSm4wR2I4dFY4N2dC?=
 =?utf-8?B?cWU5VTcva3J1ZVR6SkE5dndPN29SamtzQllwSitWWmpFTlp1T1BkalEraGs5?=
 =?utf-8?B?cVMzQWl3UjRlcTh4MGpJUGpBWVhsNkVmSVdicFV4VnZuVEwxdmdKUGl4MExF?=
 =?utf-8?B?amFPeitsbGloZUJVKytzMXJweERYQTV2VnViYU5kdHc3TXAzQ2hMTFpOdWdK?=
 =?utf-8?B?dzJvSVRod3BXS3hVbU82NWJWclMzQ2RXS2ZSakxKKzFWRW1nRForNEl4SnFB?=
 =?utf-8?B?RythRHZxdU9QYXBaZlBHZ3JJWWxlOUJvRFJFWWFVbFpoV250R1VWMHNjblNx?=
 =?utf-8?B?RmlUckxiSm0wRENNZUZvdEpFNWhaWkYyd0M1aEp6NDBtb0E3RGh2bnJxQnZ3?=
 =?utf-8?B?Q2drMWZiOGhCTzk3dVk0SmRUU0EyQTlyWkd3Rjc3UzVFVWsxQ2RhTkVEK0hu?=
 =?utf-8?B?d3dET0J2MjBwTFRyY3MvREFwaDUwdDRucTRkSkdadWh1S0tTWVVBbDEzc0NW?=
 =?utf-8?B?M040eEZFNTE3U1RJSFpvSklMTTdKVjBnNnFocXl4aGxJemZqSXJtcFFUYWtl?=
 =?utf-8?B?RXpReGdsMGdSNXRZWkQyOFRyM0JUQUxoRVBNUGVMU3Rxb2FQRDdvaXVlN0pW?=
 =?utf-8?B?OTZsVStBblRXU21VbVlGK0lEbmVCMnJ6VXZndzFQOFJBcWhKUGhxdkpkOWlW?=
 =?utf-8?B?emJzZjNzRCs4Wm1IVUJmbU9mREwybkVrMlJRbmVoclJhaXQvZHU5akdqdXd4?=
 =?utf-8?B?ODhHdzZwWkowdlIrK0lYVXZxemliSlJXL1g2RGtGMHpqZlo3TEpBK2poeldW?=
 =?utf-8?B?UEhQVTJZRjBYNEVNZnhhSGJtQlNQa1JncXFlTStnZEdmaWNodldtcEREeHo0?=
 =?utf-8?B?ckdGZmdzUkQ5MzFsMGFZN3ZjcExSeUFZYUc1Tk9mWGJ0OHFqNzMzT1VEd2l5?=
 =?utf-8?B?TFN4ZmhqbUhkRVkrYzN6bGJrNGVrZ0lpQ1Vwek0xSHNQY05KSDVoQnJueW5N?=
 =?utf-8?B?YWJrZTJrL2RrZDFweVA5dXVGbjFPZWVhL1c2VXE3QjNHRzVRbWg5M0lFbzNM?=
 =?utf-8?B?aWRWZUt3dmJBR292ZmRibi9zbXR4ZEN5blN6UUFUcFpsMEJLUmNJVjBEKzEy?=
 =?utf-8?B?T1NEa2VtRTNBMXh6R3NkdWhHOWYzUjJWQ2wyZytTM1FjdnlEa0c5Q2p3UzFO?=
 =?utf-8?B?dUE4SXpoKzF4YzRCN2FkYlo0eDIwMDZqdEhRVFB5Wk1QVDQyeGFiUTl5ZnVW?=
 =?utf-8?B?NUV4UFdnWEwwWElVRjk0eXhpWWJVL1BackE3NVM4aVFza1JDU0NVRmFBd1d4?=
 =?utf-8?B?NWpXS1ZsWStyb0NTT1QxRFZESzNsM3FPUWtpWjhCc0EzMDdzeXVRejBBZ3gx?=
 =?utf-8?B?NVh4b01Nc0JqdGtaT1Z6OHhkM2lPR0o2UGpZMkNyMm1kZGxJQzZjUVdnbVFG?=
 =?utf-8?B?SVFYbkdKUWpKdE1UdzByWG1IUWtpSnByRWV6VWFla0svM1FlMjRPbHNwR0FV?=
 =?utf-8?B?NFBZK2lCVXNXMnlSV2RISk0yVk9UaWgxTk1OR0FwRVRYZFhLR0JQdGxSakt1?=
 =?utf-8?B?a0hIWHNRMk9BSU9QbmhwcC96YlBuMEdEbXE5VVU0Z1Q5NEtFUFluMHVvOXA2?=
 =?utf-8?B?TmszR3VoNnN0MWwxbXA0VlFUa2FqYzFYK1hCcFpYZmt0WDA1YXBUbThtRzAr?=
 =?utf-8?B?dXE5MTVqVGE2UkFsbmlyL1d5TU9XNnBQTkhhYnk1TDlIRGFhM0xCYVN0T1Fh?=
 =?utf-8?B?NjRIaDNRT1d2MGQvZGdENk8zY3dpQVpXSTdLWjMybWpPZWpHeFRtVUl0d3cw?=
 =?utf-8?B?TmhmSThOcGJ5RHJ0YU9HZTNndVM3SXEzMFc1N2JEbWF6dTh0d2FtZGhxcWZu?=
 =?utf-8?B?ckdOYXVoeS9QbmdsVmNvaC9EVzlrb3Y0WG1NYmtkbENYZzR0amoxdVJtRlYw?=
 =?utf-8?B?NCtGdnQyR0JWVHI0cS8zZTdyazU4Z1lDRG9xQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ea3b6f-06e2-46a9-e259-08db925326bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 05:50:03.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YZg3tIOoDOobdDa/ehI4m3f5ylbcM8RsIbj8X18KyLEt94//HwEyIZxlA+gI+NcwAHz+VijU0EDCCASkrE34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IEZyb206IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnPg0KPiBTZW50
OiBTYXR1cmRheSwgSnVseSAyOSwgMjAyMyAxMjoyMyBBTQ0KPiBUbzogRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IFNo
YXJ2YXJpIEhhcmlzYW5nYW0NCj4gPHNoYXJ2YXJpLmhhcmlzYW5nYW1AbnhwLmNvbT47IFBldGUg
SHNpZWggPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBb
UEFUQ0hdIHdpZmk6IG13aWZpZXg6IGFkZGVkIGNvZGUgdG8gc3VwcG9ydCBob3N0IG1sbWUuDQo+
DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUg
d2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRv
dWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcg
YnV0dG9uDQo+DQo+DQo+IFdhaXQsIHlvdXIgY29tcGFueSBjYW4ndCBhZmZvcmQgdG8gaGF2ZSBh
bnlvbmUgcmVzcG9uZCB0byBtYWludGFpbmVyIG1haWwNCj4gZm9yIHllYXJzIFsxXSwgYnV0IHlv
dSBjYW4gYWZmb3JkIHRvIGFkZCBuZXcgZmVhdHVyZXM/IENyYXp5Lg0KPg0KDQpUaGlzIGZlYXR1
cmUgaXMgbmVlZGVkIGZvciBXUEEzLg0KDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2Vybi8NCj4g
ZWwub3JnJTJGYWxsJTJGODdzZjlqM3dkMS5mc2YlNDBrZXJuZWwub3JnJTJGJmRhdGE9MDUlN0Mw
MSU3Q3l1LWhhby5saQ0KPiBuJTQwbnhwLmNvbSU3QzI2YzE1MzBjYTYxNDRkYmM0YzRlMDhkYjhm
ODZmMzIzJTdDNjg2ZWExZDNiYzJiNGM2DQo+IGZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2
MzgyNjE1ODE5OTEzMjYzMDYlN0NVbmtub3duJTdDVFcNCj4gRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVg0KPiBDSTZNbjAl
M0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPUMyWnVBeThOdVU1UjNETDFQamEyZGo0UXFiJTINCj4g
QmZ5ZDlnNFI0YTVaemlLVDAlM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBPbiBUaHUsIEp1bCAyNywgMjAy
MyBhdCAxMToxOeKAr1BNIERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IDEuIEZvciBzdGF0aW9uIG1vZGUgZmlyc3QuDQo+ID4gMi4gVGhpcyBmZWF0dXJlIGlz
IGEgbXVzdCBmb3IgV1BBMy4NCj4gPiAzLiBUaGUgY29kZSBpcyB0ZXN0ZWQgd2l0aCBJVzQxNi4g
VGhlcmUgaXMgbm8gZ3VhcmFudGVlIGZvciBvdGhlciBjaGlwcy4NCj4NCj4gXl4gVGhhdCdzIG5v
dCBhIGdvb2Qgc2lnbi4NCj4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4NCj4NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4
L3V0aWwuYyAgIHwgIDc0ICsrKysNCj4gPiAgMTQgZmlsZXMgY2hhbmdlZCwgNTU4IGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPg0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21hcnZlbGwvbXdpZmlleC9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
YXJ2ZWxsL213aWZpZXgvbWFpbi5jDQo+ID4gQEAgLTI4LDYgKzI4LDEwIEBAIG1vZHVsZV9wYXJh
bShkcml2ZXJfbW9kZSwgdXNob3J0LCAwKTsNCj4gPiBNT0RVTEVfUEFSTV9ERVNDKGRyaXZlcl9t
b2RlLA0KPiA+ICAgICAgICAgICAgICAgICAgInN0YXRpb249MHgxKGRlZmF1bHQpLCBhcC1zdGE9
MHgzLCBzdGF0aW9uLXAycD0weDUsDQo+ID4gYXAtc3RhLXAycD0weDciKTsNCj4gPg0KPiA+ICti
b29sIGhvc3RfbWxtZTsNCj4gPiArbW9kdWxlX3BhcmFtKGhvc3RfbWxtZSwgYm9vbCwgMCk7DQo+
ID4gK01PRFVMRV9QQVJNX0RFU0MoaG9zdF9tbG1lLCAiSG9zdCBNTE1FIHN1cHBvcnQgZW5hYmxl
OjEsDQo+IGRpc2FibGU6MCIpOw0KPiA+ICsNCj4NCj4gSSBoZWFyIEthbGxlIGRvZXNuJ3QgbGlr
ZSBtb2R1bGUgcGFyYW1ldGVycyBsaWtlIHRoaXMuIFRoZXkncmUgYSBjb3Agb3V0IG9uDQo+IHBy
b3Blcmx5IHN1cHBvcnRpbmcgZmVhdHVyZXMgKGFsc28sIHNlZSB5b3VyIG93biBjb21taXQgbWVz
c2FnZSkuIEknZCBoYXZlIHRvDQo+IGRpZyB0aHJvdWdoIHRoZSBhcmNoaXZlcyB0byBmaW5kIHRo
ZSBsYXRlc3QgYWR2aWNlIGFuZCBydWxlcyBvbiB0aGlzLg0KPg0KPiBPdmVyYWxsLCBJJ20gbm90
IGVudGh1c2lhc3RpYyBhYm91dCB0aGlzIGNoYW5nZS4NCg0KVGhlIHBhcmFtZXRlciAnaG9zdF9t
bG1lJyBpcyBhZGRlZCB0byBwcm90ZWN0IG9yaWdpbmFsIGNvZGUuIEl0IHdpbGwgYmUgZGlzYWJs
ZWQgYXMgZGVmYXVsdC4NCg0KPg0KPiBCcmlhbg0K
