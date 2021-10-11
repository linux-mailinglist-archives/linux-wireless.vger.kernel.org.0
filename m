Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114614286F4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhJKGqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:46:00 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:42975 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhJKGp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1633934640; x=1634539440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CD/aBkv3x2wR4SlpLaw07Kp7nliG3dSFzWJvOwJjmE4=;
  b=xoSnXBHdS+1vx8g7SotgDPOwQhFTFbYveXg+YfqY4VezfJfbo+Cw5spD
   W/kgJMGw1D9bni4ZGwKODvURC63bMtagPg8EFItg/1jXeK51xrmGVfD+I
   Gqt6JU3C2AU48AbzbExvhL4pfpX6MqDybeZsEJ67JCHG/Szzx+o1TDq9T
   Y=;
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 06:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpZ885iIMKGLwQBnDxSG6N3tWJ8fVxt5WnrDHJOjIWsQ/is7NkzbXl0/JjQjjX4Vr4JsZNZDg43hyCIrQy+xqRv93RA02CPcvjUGq72hhDDMPcbAexPxgFbVMfiIXuLRDqSLxhKCH5M196nk6llvK7D/InlhZN4PEdpM5W8WT04yh1digYau53lpZprJX7xFAJArtzTz8zeTVyj4NsW05os2y2XLcpsK1MpZ7cjSOGn5igqT0uS1iut02D3hY+pXj8uq6tkVrB4kHHEFJmCDQmuO0EqoNuBshKUr6mR+/wLU5ctQHF8X/2IaATXJyGjwRmmbNnKH+tLDAXsCV8pE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYrH40r2oiELFnqBN1CX7W8vy2D2clNlHcaXO259/I0=;
 b=ZCe8DujMHaNorJ2CUmBKtaKGi44+IOOEPas7fybNNYBv1zt1LSdIvkHJ7sLlLB4EOLhsLGYB3SsykqTAWb4H6HAbOowbFNlVXyuFFfGtxJMtG/ESse/Lh0oHn3SXwNMhddtnJE+8T3uKjRQ0Bfl6s3BVTwFk2M3b39AEC8ApfS0npedRqbQTFFjyCi2aDIh0aKJ+xzziYKAd9sHiXFXnttKuHayf6gEhjzny78s8w+OPRb3vYjLiasfG24zQYsOQPfPwLijNhC+N5naGcO0Zo/Q/gMeIt7w2PCZnLtFXK30EDvEX3L+lCTSnXt04VlbauzZpkW3qAhIwD0GG9cvKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8154.namprd02.prod.outlook.com (2603:10b6:8:1b::15) by
 DM5PR02MB3765.namprd02.prod.outlook.com (2603:10b6:4:b2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Mon, 11 Oct 2021 06:43:53 +0000
Received: from DM8PR02MB8154.namprd02.prod.outlook.com
 ([fe80::e0ac:da18:3aa6:65f7]) by DM8PR02MB8154.namprd02.prod.outlook.com
 ([fe80::e0ac:da18:3aa6:65f7%7]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 06:43:53 +0000
From:   Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "wgong=codeaurora.org@codeaurora.org" 
        <wgong=codeaurora.org@codeaurora.org>
Subject: RE: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
Thread-Topic: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
Thread-Index: AQHXtEjyv7cetWKDS06ApceBiYoWlau5bGqAgADxnYCAANyEAIAAqbAAgACmxQCAELcTAIAAKtYQ
Date:   Mon, 11 Oct 2021 06:43:53 +0000
Message-ID: <DM8PR02MB8154258563A4F7C805C84B4BE6B59@DM8PR02MB8154.namprd02.prod.outlook.com>
References: <20210928085211.26186-1-wgong@codeaurora.org>
 <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
 <cb20427eae96c4551084e4c899618b94@codeaurora.org>
 <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
 <2ed76cff292dcca18326de0407a93821@codeaurora.org>
 <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
 <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
In-Reply-To: <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 753d9719-4bff-4b48-d2a0-08d98c827e07
x-ms-traffictypediagnostic: DM5PR02MB3765:
x-microsoft-antispam-prvs: <DM5PR02MB3765F7398BE202DDA4BF7B46E6B59@DM5PR02MB3765.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06QnVBOBopgZJdJ8JgnsBexTENb1+GPcHrwkyE3xn/m0IfpTQTbgle6NaJBpH3s4GP54VceS4m+JMAZvb/HFjGl0Go3woFr8ipEAyEu0cyPqqT6VYx+wBlOvjxl8hm40xBFMU/ib4j/40Aa7NuL6NUYdA+EvbLD1VJASUdtXHGlkyW4ySyLLe2DXIb3Hf2NTv97etwwnvIfYcejim+e5DgrjxgYN/M1dSdInbdQs3QQDX2bCl4zv22xG0vIfMc4I3et0KawRtNpmzavq1AK6kjnxlh1jVGApvQ5Wx9FAOah0k76CvNBeGq+aPVgcQFclqD3JqGkBlLYpILQmsRGWxiM1KH+446faAtrQ1eGx5YZlo2pA+m+abT+JEjrvN6IJ5qSMzzxMu+5Zt9hR9Z3U/I0Rh4+IiHK7DimGZO1GEuR/p5kGwCXbFCnTMHCq3flRuQCjLtpU+0OVczxOOJHCrGzDao4k0Weey+T5qNIePrjgauFPKa7gJFKpvR2MgaRpQmZd1GB/uUg18hLeQNobvb09hFJb34lDJ/20sTZa5MErCMlwz+MqIfZxoXqfzNDUooEOe0x1KlBEGSaVoojPxiUm/+tna6qhthVZjL4ofZceBQuqYcrxPCXwwGvP6B2U73y+caygVlhaoAKRaP8tnWNLMuwuFh8AV7BtviRMGU0w29Q9inHuRGBwJF+XL9bWgaavYIhFjJOMmvjFiKyUVDZwfahg24r7wAKM40arDb+s3abQ5BPE9yfZvpstsrupURBUsa9OZENSJfR6YrVDeHW/3Vup2v66CNOqoXd8OwQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8154.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(8936002)(83380400001)(76116006)(33656002)(2906002)(966005)(52536014)(9686003)(38070700005)(66556008)(66946007)(71200400001)(66476007)(64756008)(66446008)(54906003)(26005)(15650500001)(110136005)(38100700002)(186003)(5660300002)(86362001)(8676002)(4326008)(122000001)(316002)(508600001)(53546011)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wz2vj+UWI1ovB1SKltcHjYanmP1hHKOmWhcAfjMxsLEGI0CeqR/gecuutfYF?=
 =?us-ascii?Q?XNqJ+dPzTZ6ZydwV9OaEeXRzq5GlMQc+iiv0wauBotaPkvmNepPNsu+Weq7Z?=
 =?us-ascii?Q?hX7i3znX+0CZZ8dwSEJf7ZJYxvPd1lWfGgYN9Gg/4UnfYLF5cTiJPD8gnW3u?=
 =?us-ascii?Q?wOWchipw4PbTLRI6c+GYYSwgUSkKLYDgwhR63gvT0HWFEBr7vH51vIbQiWcb?=
 =?us-ascii?Q?o83Ll5dDE5BPXmZgh5HR75S8hpYMPE/D+X6pqSIts2GJPgEnWAEvwERHm8qO?=
 =?us-ascii?Q?0ph6BUcLnQ41n9/BrUCEpSKAAonq6P8KlLZIjjVDRf0oc9UBhcL7OCvETuTX?=
 =?us-ascii?Q?/0hmVVd+iLfjr19F/E7sykqgL9VlH0Xkq79Fo0QydoUJPImDJnW/PUQv2oyt?=
 =?us-ascii?Q?KpK1Ln4YHeAxJujA7XZWNuuzjjGUVmh89UZJM2nixlbyXA4Zm794nY+lb33g?=
 =?us-ascii?Q?11LKb1CI47ACcAotd3yXBUGcdM3DARbbR2CeVgfWcV0kyi9cFGnCpSI1G0pH?=
 =?us-ascii?Q?S7mxkujbaTybyu0eZhvE/Y0SN6TjK4Wijjxo9L+QtQjiISpkXtLRPrRlXrmZ?=
 =?us-ascii?Q?pavlL71IGROoJnKjBqybzcMhKtfHelqWzFp2PzSNQSTN4cG/vVuUJSbBTdnM?=
 =?us-ascii?Q?9SzmBszxfY/Ueoi5aFLqfF2X2sHRkfcBIaKEiuoH7bFh/Dob2d1Uhp+l68xx?=
 =?us-ascii?Q?2uu5mgEWjXdMDVsRUF9fJvaiAheJnyXc9qDzHWM9RKxzmDe4MyX7YqVBo57o?=
 =?us-ascii?Q?xOugQUEdRvS9Nnnk1dSvCpOKMQESKSb9wE/D2ziChyfA9iZKULcxs3ERuRR2?=
 =?us-ascii?Q?UOnInV85iXhzfRD1/p0v4B95jjl8QqNrLJstLwwJjejWIVXimXYmsMKL79S5?=
 =?us-ascii?Q?E7jR6C1Ryl3bs5NQvrL+MV017W4uqWWyj5ZQNVX8qkuFuE43Y0eP9kyha/5N?=
 =?us-ascii?Q?vTSNExUr2Zcgag1GDP7IXWpAieX2J18qhNrDFPAsgNTLzgxGj2T47xzgyNb9?=
 =?us-ascii?Q?81thktrqKRmukGXsEpTVWfjwjr8Ex9rQj/hmRTU0eupkNB6Nm9fLgyaJNjIp?=
 =?us-ascii?Q?YCpPqwasrdqq8fc78vrpiN2j1nG7CoqDGSDSDDOdH8YO6wqCjMCsGrUiqamG?=
 =?us-ascii?Q?1BCPbktijKVXxICruOGIfV8udU4+KWmyzsH+Rgy5k2VrB+VllawzeOyVRrgT?=
 =?us-ascii?Q?y561luOV6uMu7TbTtpiCfGlSDDTUzlozu5NLiUFpoRtdn0pbIXKH9k9wSTxj?=
 =?us-ascii?Q?MY28/iMnSDyEY2qoqwuAZr7ogMpG9g+Zf4e+AjuTQRwI8JrjmxITumb3WS1f?=
 =?us-ascii?Q?eUs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8154.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753d9719-4bff-4b48-d2a0-08d98c827e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 06:43:53.7336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jTQFGvOMjggkSm6IgyN//Kc3clT3NAoZaLquFnC1D3lDaor1Hkp2Djv5loYO3qn+sq1s9iSOrqv7AQ1gpUK8a5DM68DVlnyVwWwiHXnLE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3765
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: ath11k <ath11k-bounces@lists.infradead.org> On Behalf Of Wen Gong
> Sent: Monday, October 11, 2021 9:36 AM
> To: Johannes Berg <johannes@sipsolutions.net>
> Cc: Venkateswara Naralasetty <vnaralas@codeaurora.org>;
> ath11k@lists.infradead.org; linux-wireless@vger.kernel.org;
> wgong=3Dcodeaurora.org@codeaurora.org
> Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
> regulatory rule
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
>=20
> On 2021-09-30 20:50, Johannes Berg wrote:
> > On Thu, 2021-09-30 at 10:53 +0800, Wen Gong wrote:
> >> > >
> >> > >          chan->max_reg_power =3D
> >> > >                  min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
> >> > >                        MBM_TO_DBM(power_rule2->max_eirp));
> >> > >
> >> > > For AP + STA concurrency, it should to maintain 2 group of reg
> >> > > rules, one is for AP, another is for STA.
> >> >
> >> > Can we maintain two power rules in the same channel one for AP and
> >> > one for STA. In this way, we can update the power rules in the same
> >> > channel for both AP and STA from the reg rules.
> >> >
> >> > Otherwise, we need to maintain multiple channel lists in sband for
> >> > all supported power mode combinations to apply the respective power
> >> > rules and build channel flags from the multiple reg rules.
> >> > right?
> >>
> >> If AP+STA is up in the same wiphy/ieee80211_hw, and AP's reg rules is
> >> different with STA, then it should maintain muti channel list for
> >> each band of the wiphy/ieee80211_hw by my understand.
> >
> > I don't think that's how it works. You can today have AP/STA
> > concurrency on a single wiphy with different netdevs, even with mesh
> > or whatever.
> >
> >> Currently there is only one "struct ieee80211_supported_band
> >> *bands[NUM_NL80211_BANDS]"
> >> in "struct wiphy".
> >>
> >> I advise to discuss the AP + STA concurrency in another mail thread
> >> since it is not relative with this patch.
> >
> > I actually explicitly pointed to this thread, but I'm not sure it's so
> > clear cut?
> >
> > If we have completely separate rules here for AP and STA, we probably
> > should have different "max_reg_power" values for AP and STA? Maybe
> > mesh is treated like AP, maybe not?
> >
> > But I don't know - does PSD really differ between AP and STA?
> >
> > Maybe this discussion belongs rather to the power type patch? But that
> > didn't add any state!
> >
> >
> > So - does this PSD depend on mode? It kind of seems like it shouldn't
> > and then this *isn't* the right place to be discussing this, but if
> > PSD does in fact depend on the mode then we should be discussing it
> here?
> >
> > Venkatesh seemed to be worried more about LPI/client power etc. as in
> > commit 405fca8a9461 ("ieee80211: add power type definition for 6
> > GHz"), but that doesn't add state?
> >
> > So what gives? From a regulatory POV it seems PSD should be
> > independent, but some other things might be dependent on mode?
> >
>=20
> As I know, below values maybe all different for the AP and
> STATION in the same wiphy/ieee80211_hw, not only PSD.
>=20
> struct ieee80211_reg_rule {
>         struct ieee80211_freq_range freq_range;
>         struct ieee80211_power_rule power_rule;
>         struct ieee80211_wmm_rule wmm_rule;
>         u32 flags;
>         u32 dfs_cac_ms;
>         bool has_wmm;
>         s8 psd;
> };
IMO, Only power rules and PSD info might vary for AP and STATION. Rest of t=
he rules will remains same right?

>=20
> @Venkateswara, please feel free to give more info to Johannes:)
>=20
> > johannes
>=20
> --
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k
