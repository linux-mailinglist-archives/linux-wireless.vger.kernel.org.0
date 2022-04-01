Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886704EE8D4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 09:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiDAHKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 03:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiDAHKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 03:10:48 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF941C2D92
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648796938; x=1649401738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HgdcUgD4ChENO9FA8dr4IXO5otxY88QCWuc23g8ayD8=;
  b=pLE3i5US/YusZrFaq2DVmGqMu81OE5jkg3TOTae6UVL6fbgQ119aXyD4
   SQyO5nyMFTsP/XQ5yVwDXTMZ9egeJfY2x0fvcBW5WlU3XE8eyoEPweiu5
   kaLukrK8aPnHuims4z6LsjRe4/3FVT5XQM+g7X55pz1DgN8Rm09G+wJoi
   M=;
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 07:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq7Oez+meeRMUEP/3W5g8X5WP2UrgBPtie9upbCYHnRTDEfYy0dNHuKnZhmvHg6+Cgkwn2SC3g2cgkp3VIgKJALJCd7hTznLZaHnMEZ8NT6afYf5cAdjQMsdsIU2LrPWBzAOrqCzL/E2NR1hCddSS/A8rfEPIazUcelBXJbkp1o1u/roxog9j8yTQrXme4vP2H3Mh/Mn5l3QHi329tB804ezLS/wWk3dkt2plLNbFYLja9Ive6lEoAPlfCVTgITNNswD3085XYA8zZaoeSLMy/B3wxjmCv9SDJ+LTGyAymDd4Yvtaj4pYYc1wacNKR3nNFRcmWwhf2r/T8OMyoDFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgdcUgD4ChENO9FA8dr4IXO5otxY88QCWuc23g8ayD8=;
 b=km734M1QqDC5fy9l58QJ5BHKjq1ScwtaEj2EnDrUAz5/uq9T6EDDyTSTo5EvBEAmqFLpJfPEYANrzyHlH0JWQpM1YIzim5uuGjdRECI0TxljNaCT66SZZ+t3mXciexQYzvh3DucBEjqJLtVULb5by+plQV+MdANFeIB8Q/Mv0F2RlJ093mjUFbLUoo9wsS8NYxQM6swWzXNYJaoM0VLwk1kqcRktcNoI0NoDZtji4N99UyF2Phru/2FOJfwJpzCSlVqscYWHdGLAmAjFW5QqrOaF6iFdtaEhXWvETmZ4bh29MJ2Dsd8sggYvlsZN8hI01bdj0hv4lq8qnPXOWRYz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BYAPR02MB5430.namprd02.prod.outlook.com (2603:10b6:a03:a4::25)
 by BYAPR02MB4501.namprd02.prod.outlook.com (2603:10b6:a03:5c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Fri, 1 Apr
 2022 07:08:55 +0000
Received: from BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::1d1d:ddaa:4a23:3055]) by BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::1d1d:ddaa:4a23:3055%5]) with mapi id 15.20.5102.030; Fri, 1 Apr 2022
 07:08:54 +0000
From:   "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: Add support for SAR
Thread-Topic: [PATCH] ath11k: Add support for SAR
Thread-Index: AQHYOt/13uQjUd0QyUesekUNDXsOnqzJH+hQgAB+KhaAERqYgA==
Date:   Fri, 1 Apr 2022 07:08:54 +0000
Message-ID: <BYAPR02MB54308B0BC8662EB16495B923E0E09@BYAPR02MB5430.namprd02.prod.outlook.com>
References: <20220317012728.18932-1-quic_bqiang@quicinc.com>
        <164761864196.8951.13534371903381562941.kvalo@kernel.org>
        <BYAPR02MB543076C526E59CB0E98B3DBCE0169@BYAPR02MB5430.namprd02.prod.outlook.com>
 <87fsnbocie.fsf@kernel.org>
In-Reply-To: <87fsnbocie.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ded282d-9569-4032-c8a7-08da13ae7bd3
x-ms-traffictypediagnostic: BYAPR02MB4501:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB45016C379A51F043233780999CE09@BYAPR02MB4501.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bco22IQwoIqXZb7woZ4i4x5KI3gCLc5m6rRtS0EQcVd/Ejp206Bw3caDq5zImffgPIv6qRlYq/1nn5o0paXgrjblNC3Ky67dQDzQLBYb1c9oYtMaORieqOeD9AFrIpjRqRLTxvfS2ckoHbNyj3DFoAwsGJGKE8vasHMvj9kwCEyfCUbomCJmMZiPGeqtBLsjYZIMXHIbEi0P/qePf15y3h5C2OxGJS+8SP2XHY9T+sWlcEqaD1HH03Z05pQIug/6d2wS5snjja0XxE/pP4+Pba42Oczrs/GEIBIdyNLMXCsz7OssrEeKUxtaQFC4Sx1udGrpGyman7g/FT2XpELLOhgkCqXe3eWMGVKARnTFDzBCXeYHeGgucL7PmSG1XJTvRmuKad/xXh5DAXgQH/JGe+BI5TSwIaeuJ/5cI8GrkBKhQfsKkr5wXsa8ZiuGsxStPsoZMVeeAUSiSKcTaMXMeobcAmpMFQS4EezY+UQK5eUgCNQ6hjteNtQ+xfkWow4NiphSmjcRZgl7XpUHgNpGMZ7sHoUKoWXNyYbTL2WTtJBEnH2xVF9pXAy6oY4nZmwQiLLC/vthvFj7mi3wl5VC/2/VctZk/n6v1vz19N5QmxxgDm0julgX5chaiHmooI5QH47Pm70iipxBLTP3/TdvgnKrScrVtxE7RYwfBpNoW0ZqYot2oPGuoPvIjJUGCw7GetSYbspXQBa4H1XX9RsOxnn56vXbVgwy/c2FmtRsgr3whUXn8OWaf0bDjBnrzV0X/LyexTfaZxSYSyNqzIarkT+GNC8bbFHgrXrHAoIStig0MnXPb8glIAVslILah8kGzQ7glHpzfs6ylOhuuCYymA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5430.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(122000001)(52536014)(38070700005)(2906002)(8936002)(38100700002)(54906003)(33656002)(55016003)(53546011)(6506007)(76116006)(9686003)(64756008)(8676002)(4326008)(66446008)(66476007)(7696005)(86362001)(83380400001)(186003)(66556008)(66946007)(110136005)(966005)(508600001)(71200400001)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wx8668vrRt1amdZVPVWeiRm8SovW8yvRRY6xVFPAqbqWoyYzI5j4ISrFcuPR?=
 =?us-ascii?Q?tOM+TFQqykid5hy2W7ONXF9WU6h5I6jaY75kdKT+EaIw+QDFiZxmVyVh44Pl?=
 =?us-ascii?Q?SSANTyV7qQYmsSh1dYDLEHhIlfAEVRW0stuyAnIFrLHS8hdVIA9z4YwPN6DL?=
 =?us-ascii?Q?OsIAqz8n5IlEQv6joaz4g1IztzIPFnr06Tc2XhPMIMAqP4v0/Fdd2RcTngY5?=
 =?us-ascii?Q?zAU03HfIOWxHzPXW/cf5SmX0oi5qYY1Zb/gwzzB59f3RMhiRMbOc95vO5efD?=
 =?us-ascii?Q?B49O9sfT2yu1mRfahWzQ9JT+WoZmdKRcb9XjPF9l7Pk02FO3UR4ehbKEL6dQ?=
 =?us-ascii?Q?hxoDNNd4WcxV0Ydrly+nTjEXX9rqxKRJi7nrjit/hJAqBwPKz0m3L1IHm5xg?=
 =?us-ascii?Q?R5iGxpNAB0VNThTR6QusPFcd9UASt4ZEeU2rew2goUGK6NLTNjWC2XgPtU45?=
 =?us-ascii?Q?rDi1bU3Ud9/MIiraeR1IpPAY5zhkSdFZgESY0h748COQRMUSVVN/fXvJw4nw?=
 =?us-ascii?Q?6UCgXljhYapFk9b4Gew6u4aqkisnxqmlGAVxqm2S9sz+DpX1hsZlcIuCC1aj?=
 =?us-ascii?Q?V/iWxr57ynj3IziUYCaBw7a+RlsyZGVZiXeVxXIzqrSy94y7dFUrRPP8Si2t?=
 =?us-ascii?Q?LlP7QuBZw1HAjgNGdyPKIy79H/zHjEg5N9gr04N+96OT3vrL26tCk7HED/pV?=
 =?us-ascii?Q?JxJ2EwguzGhcLepdKfN93VszCQoD0/BSXbGIobKC1VOkAiycXK9jJ9zWhcFD?=
 =?us-ascii?Q?d23xCOfTTIs1HyjC6MUl+xWb6TZ3w8en5ZS0YOr0+VpmGytCQNZznFpbazQx?=
 =?us-ascii?Q?Fmpq9j51cbL2nbzxX3ocAEKrGQWgC8fVw4/ncv+hWwBFXeHUyTFzzyulKwJJ?=
 =?us-ascii?Q?L5Hdhyq8MsgwlAGnd/+VI8EBr0qOav9vMek0rwBWXG06ZXd5C9v3qdUtnWaJ?=
 =?us-ascii?Q?BqoyehQyeRW+02Sq4873W5UP4XajBRH+oUBU+lQlfyntb0cjt7GncaGF3Krq?=
 =?us-ascii?Q?ws8R8FMCnH0qnZr4oMXDnhmv2DwDSlxwwDZ35vmY0hV+vsqaX5gaKAL0V7Hz?=
 =?us-ascii?Q?UTBwuUcapbJ9TEA1tPKE8YsbzV9zCleHFEbP4KGubDy/7cr8S9BUBBr4MpEP?=
 =?us-ascii?Q?YNSjLhgS24DJaKZoZ9spXsLobIQxck6GnJsNC1298nWsw3Ym1Y+PvrJMvJmF?=
 =?us-ascii?Q?aYK43hmMlmVgx8FpROMU973H55UdVimKtqdXijUFcXLqEpYOkfMmnnskF118?=
 =?us-ascii?Q?xEiauT94llJubqhOAa2ZoI5z8lF5isMoovRSCkDw6CBd1he3H/Cq9PZukNvo?=
 =?us-ascii?Q?MgoIUzyiX/jOvkCWvymyhShdH/iNbgKLaVuNRguMgC6pbeGyNBhQfNHnUFj0?=
 =?us-ascii?Q?ZXmYCxZXcz1iVUqJLkGWu8x77iAEwotQHxfttBJHG97TzV1mfkcRahKIrEpo?=
 =?us-ascii?Q?NTbXV3VVcEQ0YBwHUHC9HK6HoicSQk63baEdeRgIsg6I3HJj3ePLZXcwWTmZ?=
 =?us-ascii?Q?O1y9N80HJ8YS+dUd0ZIUPFrPPbk1ayCshA69cSDve6iw64ovgaEUU62+oe6V?=
 =?us-ascii?Q?v/HLQXQDEtSQ7RDTWfP04b1UyhluBFsB4pp06UUYGhzHFcrsD+ps8D9Y9WuN?=
 =?us-ascii?Q?zz+8+c+N3I5X6zKH+CuHZGEaushDa3wl7plH0WV/PT2yDUcp2fjhJh8BRDHU?=
 =?us-ascii?Q?/Q4UbnP/Aito6B9papQaM04GaRTAqO85d3sXNi30bWbD+Kp4Xmzyo1gPoFDi?=
 =?us-ascii?Q?TkMTP/Ymaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5430.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ded282d-9569-4032-c8a7-08da13ae7bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 07:08:54.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqRXxttgXNzGZKDspR2TL8r6PYa6dR9QNInRmkN6+wt4HpI6Yt+XEKHB93zJyxl5SfmM+x71L3UtGZVZK/tILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4501
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, March 21, 2022 5:56 PM
> To: Baochen Qiang (QUIC) <quic_bqiang@quicinc.com>
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] ath11k: Add support for SAR
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com> writes:
>=20
> >> -----Original Message-----
> >> From: Kalle Valo <kvalo@kernel.org>
> >> Sent: Friday, March 18, 2022 11:51 PM
> >> To: Baochen Qiang (QUIC) <quic_bqiang@quicinc.com>
> >> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> >> Subject: Re: [PATCH] ath11k: Add support for SAR
> >>
> >> Baochen Qiang <quic_bqiang@quicinc.com> wrote:
> >>
> >> > ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops, and
> >> > this function is called when user space application calls
> >> > NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR type and
> >> > frequency ranges to wiphy so user space can query SAR capabilities.
> >> >
> >> > This feature is currently enabled for WCN6855.
> >> >
> >> > Tested-on: WCN6855 hw2.0 PCI
> >> > WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> >> >
> >> > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> >>
> >> What did you use as the baseline? I could not able to find an ath-
> >> tag to which this patch would apply. I strongly recommend using
> >> --base, that way I don't need to waste time trying to guess what was t=
he
> baseline.
> >>
> >> Patch set to Changes Requested.
> >>
> >
> > Hi Kalle, I have added the base flag in v2.
>=20
> Thanks.
>=20
> > And please note this patch depends on
> > https://patchwork.kernel.org/project/linux-wireless/patch/202112240852
> > 36.9064-2-quic_wgong@quicinc.com/
> > which is now in public review.
>=20
> If there are any dependencies, please document them clearly after the "--=
-" line.
> I don't have time to start guessing what dependencies there might be for =
your
> patches, especially if the dependency is several months as in this case.
>=20
> But why are you using that patch as the baseline? It's marked as Changes
> Requested and it's unclear then it can be merged. If you need that patch,=
 you
> should create a patchset with patch 1 being "ath11k: add support for exte=
nded
> wmi service bit" and patch 2 being "ath11k: Add support for SAR".
>=20

Sure Kalle, I will send a new patch set including " ath11k: add support for=
 extended wmi service bit "
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es
