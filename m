Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABA24C51C6
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 23:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiBYWz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 17:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYWz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 17:55:58 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34C1EF354
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 14:55:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfXfV/s4dwQphWmo7qIg58HzJYXeO8+seBdw0gcQMjZfcO/rBMEO1L6zf8dQqglz7B6wAfYBocBQgI6iiOYyprnfIkSGq1LZlaqbCc1Bb5cfGPjXrkn78VLsX5t5rNGSEVbzNbo0BcCBINqPn43JyMrmraqt17EGHIRvRtuGz63TSn3/gMI/rjajaAibJ0JgR/4EFFvYiHe2mTElgFD86MLRqyIA9eQEQB59KlGEeYJ7cEKlzMGrmS2lslIW2Rn/Uk1Y2LVKnwdKDBzL+I72k5ZhLAVs3DV54MiMQD54MBWS+9hGSm/U22i6KVF2M1MCNaKNlNSHvWgdkDq5EVGomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBrnWFyD8uNKVXfNDWAk467mvczC/9qHhjE2gA689+w=;
 b=W7TDulV/kcZyJWPFpS3io6oBqUFQyTm3+IM5yTsW1Vli4vcuiir4sYZlcg5dGxTZ9KIfdWCKdyrK5P6lHS/A2rKjMdk0Hm4ZJFy8Gi/tMOP18zlZq/t9J/rPnnahEACyf9Q5fHhrf3+NqZkmIyRI37yTnulMhSIEENShDbcUKdyWsZa/G37vsMI2kQEduhz6qv4S0N9Sq6DGkhUzzNQoUjCgdJRMR7IA/8wVaj4SpeiIBp0msk9y+QuRh2kV+mFsS9l+524DOzII/m4l8KjY64pOuGLVUxlZPlM+EXa8arM6+23C936Y1lOdPnqtpX121yzYLWZIVQQ2qhAZdKDOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBrnWFyD8uNKVXfNDWAk467mvczC/9qHhjE2gA689+w=;
 b=g0gTeyw0irXIZQpUfrC37dfwvwQjhw27+biesXPR2sKmw6hG+84WHnXzBvaU0C3kFO/YTwGuD0emD0ykGZN/lDd+Glwv9WwlzH5vQy6PcZMDaaYvFaE3pm6hDAYEXAaeoBAV0eErQf5zi42fu11g1gkigAz29jcy+sr9BbYuFLY=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM4PR0302MB2689.eurprd03.prod.outlook.com (2603:10a6:200:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 22:55:21 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e%5]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 22:55:21 +0000
From:   =?Windows-1252?Q?Alvin_=8Aipraga?= <ALSI@bang-olufsen.dk>
To:     James Prestwood <prestwoj@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] brcmfmac: include missing AP scan feature
Thread-Topic: [PATCH] brcmfmac: include missing AP scan feature
Thread-Index: AQHYKas3uPpI3oxfi0CdVC9vzqacgw==
Date:   Fri, 25 Feb 2022 22:55:21 +0000
Message-ID: <87o82ud09z.fsf@bang-olufsen.dk>
References: <20220224181809.2808754-1-prestwoj@gmail.com>
In-Reply-To: <20220224181809.2808754-1-prestwoj@gmail.com> (James Prestwood's
        message of "Thu, 24 Feb 2022 10:18:09 -0800")
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e648e86b-4212-4e85-d9a5-08d9f8b1e6b9
x-ms-traffictypediagnostic: AM4PR0302MB2689:EE_
x-microsoft-antispam-prvs: <AM4PR0302MB26892A2DA595175E944D1934833E9@AM4PR0302MB2689.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y63DwXGn5FJXu8DVXnPnoGVvwEdI+tnT4Hg06L6yj11sHPOffnN81Q2rTxjzaFZO0EntJMOQhd+CF0BaFKeOTOJTgJpTxhTHRYAaywSECKO34eZoJ9ye0+0jiRTbLl1B38W/RqMbV4DPpSd9IajWtjwVnRq9g3lNrdiUAapUIyaPbyc+zCh+QnDkpwplTeoOeh048Zk+WlkFGPOlPhcCv+ItcZFEyiaojIuo4r3o1xbwKKT9V7EPkvsKl7D42lSyWKndNXFnB7+XtLHt1RR55np0EKlrxx2ufU18N7lpRqkRVFPbRNPBJQnBOVPBVr0Jk6Uz1myqyPiD2yYufIs/nlyEILt8/I5nRJREW0t67XP+uMdguAD+cR4K8kG2vLPZYP5iiFjybcdR6JZKrDpQUcQ620/I+fTCUWnaT/eAwbOAqpRDXJbFz/NPVRhwOTZUQTNZU8D5mHy/PEg+AhIGGfLUGrEvgTl+MASDsuKbtbIxlFZjmsdvDw5yoEqUFfc0Dzjm2VNhDaY1V+PDDCAr5qpA+S1CFl27c4BgiQMfzJK+H4oabTrMLi1cUvOn1Wxenw4bJ9KBvoVYdLnfPss3x2xMPLM52xPBNyl87TTm0ploRYiySK5jcY4VMHe0mPitehuVFmnJMO76Xdwe1G5UEpc1u9g/sbfZ+8xIhe6gAjSOwHud96Ac/Ud+uv2dAVFNqzJQTr086Ch4S2v+r83rZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8976002)(8936002)(36756003)(6506007)(6512007)(5660300002)(86362001)(71200400001)(91956017)(76116006)(66476007)(8676002)(66556008)(66446008)(66946007)(64756008)(2616005)(2906002)(26005)(186003)(38100700002)(38070700005)(4326008)(122000001)(6916009)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?X9SGTGIbfNI6FA7xNnN1Q8icY68oSiWCkt0HUf8U6of3sLzNvyaBIpSC?=
 =?Windows-1252?Q?6cQEdpGKUnmSVISTODLv6PpfFESZuM2jnCYZELOTP4/5ftLmSAh2p1U0?=
 =?Windows-1252?Q?9gS9KEfxLn5ZgAg6FLZ0JNPku9QZ2LaU6A0/0LRxroJEQXcEdekQN43B?=
 =?Windows-1252?Q?FfRl1sa6P5IMbTir8C0kTgw+cnKfCqSrmH0c16Jc1J1AMljuvimNXYRI?=
 =?Windows-1252?Q?rkPz96RHU3j3Fln73HWsu1DFDjQoUffzAFAGkEmecoSxjwmtLJKECq/D?=
 =?Windows-1252?Q?hkG0XJUaB5FriHNCwERC/Bd45qCOxtvbN53GxemLzAL9jpJbkPrXiiQH?=
 =?Windows-1252?Q?ipCKzSXcTvgbH2PXRSJYNpw3AaTMNPbvyuhcETrNRlUtcCfaGWj9bGkx?=
 =?Windows-1252?Q?pP2obPDJ4zV0XeMb7L/9gwLKA8kyBg18BrRE4baIZAL01NMrMruUof99?=
 =?Windows-1252?Q?93JqXuEx90olLa61O9FpIK7SzNEFM4ijq+LA2ajA/O4nq6KJL5pjq65u?=
 =?Windows-1252?Q?KIwrcG0eC1UxwnAFC5jWp5t2D4p5Bt8yiPXtOjhDwZ6cI8dI2+aVfLvT?=
 =?Windows-1252?Q?zHg5hwbUZpu+VrbrnMLHiBAyr7mD/Tku+cS4uTI2X+G6fyJxfmt59vky?=
 =?Windows-1252?Q?ekL4CZ3Y5E8zj7nYww79kOdjnTNC7TLlsyLRzzEhN9gxqebi+V8eyEJc?=
 =?Windows-1252?Q?HC9BZPMx7pj5vnT1Mt4EXwlq06E/rr+gzJdOK7POq7D5pSGMJwxzjOMz?=
 =?Windows-1252?Q?cBcgJkTyjnpfElf59ksafiiwDJ3YdIqTYF2WdniJ3/89g+m+lcahwTD9?=
 =?Windows-1252?Q?7ZI0MpxmZg4880FivRSkQPDIaWEw+432tlZyI8qZJhadCLZxh8HXH6Um?=
 =?Windows-1252?Q?vEpAmBe4UPzsyjzarPOB0mGkB9DBCt70TLG8vvyUwrpd9xKDjzHc6S6g?=
 =?Windows-1252?Q?PpFWCbquSbQIIh5wK0FhcjCZxI7vLxcj4nltimJma4sqQrz78SdPuF07?=
 =?Windows-1252?Q?94HZ+TFhQbnCR0AT9A8y3uW/sxl4QqjMgTw6jJ4PpT5BLP7o2N6okHkM?=
 =?Windows-1252?Q?J0KQCjGCi2vZluvG9Bi6bWeZ0p9bnxJ6qLi9/Vn9c3hscCDKOGGb9PZg?=
 =?Windows-1252?Q?ET8mDvAb8Wap7mD2zGOUY6cRPi7llu/R2r1NlH8EvoL7sWPdrqocZnP3?=
 =?Windows-1252?Q?3oQY9kfbJ/3whfOhr3Zb1mdgZ5m1S2AnKbpT0zfzftRjQLjriABJ6cF2?=
 =?Windows-1252?Q?AXfYLZ3u/t6t9lacz8wa5AujExgNj7r/C4jfq5XT047KKwE6ZTImykIc?=
 =?Windows-1252?Q?qoQBDEQ1dV0rGeKBZ6xGEV/llqTNIZz2LCo3G1PwoiZRqxhnrmn5LU+R?=
 =?Windows-1252?Q?eEieqKATUiFTYRGyrQaMlSfToXWO+4fDvCX4DKRqArot4YLYzljCtTGu?=
 =?Windows-1252?Q?23WQIRbU/xLY5T9RSOi6tnIyr4ffQxkXH1J+LGpowrdGB1ycc7VKnTrX?=
 =?Windows-1252?Q?W/p1e5k2ssl0scz4qqXvdnSsoPvRR9Ec1TXPxjj8dIih5p32YyzJr82w?=
 =?Windows-1252?Q?9XoLuIku7FwcH9X3p9PqU6nNnkGnX6/KI/K8qEzZBIbofxMzj+AsbWaL?=
 =?Windows-1252?Q?R7uAQk1YI7ae6eeUIMfbXnJ//rAan6VJalY/O2PtN4UyYYqoyTF9rfhz?=
 =?Windows-1252?Q?FB4IAFCYa/m/6xNgdaR5U1gX3Pjtk5HuwnPUuAGPk8Dx7nX5JUwnprls?=
 =?Windows-1252?Q?jPHOE94wE899iMkquQE=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e648e86b-4212-4e85-d9a5-08d9f8b1e6b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 22:55:21.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50Ijl4Ws2EfjwEDv/3gQPiSSMunvTLIGbjJWUqq0sYqsocoMsU+MPPWMtvYe7NUoYoZVCdbyCj7DSuZIzTV43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0302MB2689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

James Prestwood <prestwoj@gmail.com> writes:

> This driver does not advertise this feature yet scanning with on an
> AP interface appears to work just fine.
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> I've submitted this patch mainly to start a discussion about it. I
> find it hard to believe that ALL brcmfmac devices support AP scanning
> in which case this feature needs to be limited to those devices
> only. Trouble is there is no FW feature for AP scanning AFAIK.
>
> In any case I think this driver needs to sort out if it supports this
> feature or not, and advertise as such rather than leaving userspace
> in the dark.

By the way, what are the typical use-cases for AP scanning?

I know that hostapd does a passive scan on the AP interface on the
assumption that the driver/firmware will gather channel survey data, but
that's not a universally applicable assumption. Not all implementations
will do that.

Kind regards,
Alvin

>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index fb727778312c..b6a50e65dbf6 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -7729,6 +7729,8 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(s=
truct brcmf_pub *drvr,
>  #endif
>  	}
> =20
> +	wiphy->features |=3D NL80211_FEATURE_AP_SCAN;
> +
>  	return cfg;
> =20
>  detach:=
