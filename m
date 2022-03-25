Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002F64E6EEC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 08:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353308AbiCYHei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 03:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiCYHeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 03:34:37 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1EC4E16
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1648193583; x=1648798383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ncy77LZpZqJDn9oxpvFA+U4XV/DOdG9Ago/sOd6kTuY=;
  b=zeL/iGi5tJwFK6EpkCXCL/nQEcI/GkOl8Ed0oUJD6PbX8QqrN1E5oqE9
   wtDHH5E0/td/C7wSDq2WqaK0wv5f7J4aqg64llzTExhmYZ8AvayHiEvSO
   MREqm/UVkiKpxp7OwgpHSABJymagciQXF+kN1wFQkuaAI8nFMrjNUOWdl
   k=;
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 07:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnBjRESSm2WsMSl9Wv8c/AWYSFN0QeTHNB+0QSUxIme4UU1DJA+8SEuPc7P1GmBr4RUnIEQzlcTpzGnSql5K6+uinYGrsyybJYjbe382fBghuQa4t8Vx8RfRAeyaVZoVoXxPrVQuhFp7DGbnyChJF1PzeQUPXOregO1mCU3ZHE9kBOD0TGN5xpC7f0U2Wl5T74jsEtnTXhIFmThyW6CFA2b1yOqqS/8bNYT72hoR+jToupreHYMGdfRXFd7zY98Oucd9kpJBtXRtokRK69QnbGuDFO1sFdUzP9iYJFwsmk3QZ055/t9nAMwn67VGg1ZbeHs+W5GMv9SvdhnUxQbutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncy77LZpZqJDn9oxpvFA+U4XV/DOdG9Ago/sOd6kTuY=;
 b=DHWPH4Z+EgXvmMzVUYZWghcBWMjwbPhUeyt6CkH9SN8O8nlpOaaNqg6dzgykY+NxlU4w/xB4uke48QdytmxF/ySSMUipOlMNI0ejrngIGOPvJtPVs0cIX4G9gvfNlfzjKRxNpMMabMwYauvTrKwjUwTJuVdCGMxTtmQwIQ1GHO4wElr84rKZGXGpbyIXNp05Mr0ukBtzK1PGuCnnK4I0WrAGo7AumfJmlIfYL89mkyeCbbLABWFKaXgc3DIcX27t4v2z3bVTfITRWpUibpTKRyb1z+TlA3bZdzOFvOviQ6I9g8cgjcr+EnEDBEJQvIDh4XUsTPBFkUhixMnlJHK4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 PH0PR02MB7749.namprd02.prod.outlook.com (2603:10b6:510:58::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Fri, 25 Mar 2022 07:32:59 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e%3]) with mapi id 15.20.5081.023; Fri, 25 Mar 2022
 07:32:59 +0000
From:   Rameshkumar Sundaram <ramess@qti.qualcomm.com>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: RE: [PATCHv3] mac80211: disable BSS color collision detection in case
 of no free colors
Thread-Topic: [PATCHv3] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Index: AQHYHPQbutqz9b+QqUWFdFIeMBv3+6zP+W6w
Date:   Fri, 25 Mar 2022 07:32:59 +0000
Message-ID: <DM6PR02MB4937930BD7561DF65E3DE861E91A9@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644328740-31938-1-git-send-email-quic_ramess@quicinc.com>
In-Reply-To: <1644328740-31938-1-git-send-email-quic_ramess@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca3983b8-ed87-4afa-1af8-08da0e31afcb
x-ms-traffictypediagnostic: PH0PR02MB7749:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR02MB7749792994B3D303ED60C5F5E91A9@PH0PR02MB7749.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MXZEtTWEzejqUyM0urXc35rE5KIc2TRYN/D7uaRQy/zLScEdlaFmZApbjRxMk3uWHW2v7MFw+2daD9fCjYO1ourbNN1hz10gLBSg0SeUqyoWQ3oC043p1FXM3rPGtfTjJwm9jLCfFSnxMoX8+SPWAJ8B4T0+ZQRRWgVtPEXEDixI14rLXSVpwvNV/pnQ/mwJctpFZs10YObh8TeMG8LRbae320rA3AtEiofdV9C6susvsX5FqlON/0RoINFpzw38I6B+TyZBsTaeR8j0VmZCakbk7z0vrlmO9+n+nThIpLPbuKWLcenM1sAPPu2vN97vzCHZVkKrwWnpuemohoZ5hXHpDLMNRSxi1CIvUHu/LJ8SJdTfEeYdlIolyDCQ9k/JfpL91kPZa2JX/uT9blnRTI3Rmv/e2PXR6Ksc4jP1OeTfThPUrUDI8H4G1pBUIs4LAoO0V2ObprqCY2ZxreeSrtRxE49Aeb1JnYXl/uN/epgIfa6fqu5b1dDBcfUcD+Mi/QBkr920bXShaB+MbMrSFsCMjkV/boYZQf4IeTing08FhBr/zHaJEO6durghAkXxKnyIMX6vIzU5Iy2iCSGHx3WqnJDUkxe5VtdMQjRaKK8ziqJnPrkXUZdD2Pqj5RS5s+QhBdgzgYOhlj15bww9NpAhx6L5364fX3cYZwwF8dhMpJZIR+1A4hPQamfV80RpVH7N3ySMqan25GhYSqK5JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(7696005)(54906003)(71200400001)(9686003)(55016003)(6506007)(186003)(508600001)(26005)(110136005)(86362001)(38070700005)(33656002)(64756008)(316002)(8676002)(83380400001)(66946007)(4326008)(66446008)(66476007)(66556008)(76116006)(52536014)(122000001)(5660300002)(38100700002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6QbEPkpQXQnZDi14Gyvo9trGibtUwfefbbHIzmTqP+0UVBlc45qkbL2lTcoi?=
 =?us-ascii?Q?BT2HjkvoFmaJPjOvZpj0mYO+ZLT4DvpTdcUF6qFKlHyOzG7r6VG1uCk//h4z?=
 =?us-ascii?Q?c6LGCjozOdfQZi2L7SJhxOFSjwyZ9G+oMH8oIH5054xNAhDkbaOwb7Lsk7po?=
 =?us-ascii?Q?6Qfd7H7mDwuJgdb5YmMrxLSuKA2n8u/c2TmeYLzfzMnQPp9vV8I1R8ZjofLp?=
 =?us-ascii?Q?CLjjY45hSTWZtHsXmlcpE3IB6P3rw/nZCCMRBrXMzfoTGkRDQHbVmg1/hQWi?=
 =?us-ascii?Q?WAMyPjbcin29vM5xDRbT0xXUHKAye8Xtc1wUpUbBT0uxitPfzXmE04D5/7ul?=
 =?us-ascii?Q?5Wk5KwbftAz1RfySuzi2HQP7zvGSmG3QhPj3VwmZQOUvbphqOW+6P6dndqM/?=
 =?us-ascii?Q?9Cc/TL6Vhxmpgya6fB9XRiIC4xfMqiB0zBOjQF6gY4cI0w8TCdsg1lt1cAYE?=
 =?us-ascii?Q?A+e3jalr0JqPHDes12VjFKNHH9ev3LQ/m7K1KftZojQN3hDq9Md9FNdY2XpQ?=
 =?us-ascii?Q?Lb1DPAZYfZtVaIXeE8XdyloW6EWq9wos6GqiAocEVV8yQVYBKIlZ+dOXFU8/?=
 =?us-ascii?Q?DH9q16cOmeltlHEShmIwEtZB0iCs4GffF0HNy3fd4DjV6lTNiyu8FKR/dyVg?=
 =?us-ascii?Q?13g+96K9uRtUOGp2bhhY15NediG75SBT8Yb693AlOkJuVntuxZSxic3Yv55l?=
 =?us-ascii?Q?KCRAn1Ew3dMPHXU6Qm/PlWXq8xw/3puuPR1GBTa/ABvHtFg5Gq+O0tdLcxv6?=
 =?us-ascii?Q?Zfz4QSYRzwCrybPXBN6kInLXuZY9+W62W1vnYp3i2bwQT9FEfQMSY+GamjoW?=
 =?us-ascii?Q?L4KiBdptS9mYL7Muy6YSditewLwAVvSl6olmU/Vhrw7B/+7UmdJ22aqMWxLP?=
 =?us-ascii?Q?ynzpp9BLwyr7itTQuvu3UYx1d0jIaVgJopN5c8r3SXbHskolFqjOV5vStP5Z?=
 =?us-ascii?Q?OhmdVlHGVNtkQeUMEz2CPnMponOQkWlw7vz4MeU8qJwWUKXwQ80OcEOhR5QC?=
 =?us-ascii?Q?l4v2mE3NlGy+aC6hs7HVMpr4rPLRo0oJCY6zD0pX2VFfdyP6CTh3NjU8H3Gr?=
 =?us-ascii?Q?ohxp9uNCAx+O5qhczuWR2UHZHq+foXiZr5u4wTrrPVg53eWc30UI/MIsrlLv?=
 =?us-ascii?Q?g2ugIZsEkys3RR1yr/B5bgLPQEEk8Dw2KgfKUn70S08hlUXA84NtCkrBMGbz?=
 =?us-ascii?Q?iU08OYGEurGcumLPTBTyQtrvEAyfU1S9cAe8c0Va3qfoaSdwTRORZ0LueQQh?=
 =?us-ascii?Q?l8UVgA4xjPVjLqxoLMvSiQl+HD/+Q5f5Arsupye/YsGAZ+rBRuTVjB/6OoVk?=
 =?us-ascii?Q?HEIa2TpkdrmnAr4nqpNZe5SHYoH3J6oAOTTntoSfdGn7YlD2+McOS9bWN9St?=
 =?us-ascii?Q?FylqPo4ZmBiBE5wMHzbWOqn1d4470f05WG27YBC06edyOpeJ2OTFNxP/Lgbb?=
 =?us-ascii?Q?oCBtNAYhCpoS+sEqEFx/taggbdxwqNfD1wjlYs+DjMwQZFP07csYWPoeiGKF?=
 =?us-ascii?Q?cwWFlyLCMIbVbMjT0hglQab+vkiP97O0Is8R7yHDX1EdyUMjFXY+oDgjf9Mw?=
 =?us-ascii?Q?kFepA4A2nDrdVpItQjHYUiMpzmDbPVmfa5LGv3SEPtPHMjvK6+QBcVW/iRc+?=
 =?us-ascii?Q?M0klkU+sszW1XObuPI9XMA2jgsdhG7HJiq0miPEk17sJM0x8ahNw0jsH5kVi?=
 =?us-ascii?Q?Rk4SLkQs3rKuAz0hUUdnuQQ/naeFo8ntyYx8vgBVhVkaU0DrE6a4XhXJPG7r?=
 =?us-ascii?Q?VkX9/yjFFeMrnzAjY9/r7wRXODw1Ktw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3983b8-ed87-4afa-1af8-08da0e31afcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:32:59.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foHr7D/6VCckEWDIoCUINta67ieGOx3lB7r5f3DHAZv9ei7/T7wkVkFSN/wg505Ok8xlVU3+fktus5DypekbLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7749
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please ignore this patch, Sent the patch with wrong subject(PATCHv3 instead=
 of PATCH v3) , will update the and send v4

Thanks,
Ramesh

> -----Original Message-----
> From: Rameshkumar Sundaram (QUIC) <quic_ramess@quicinc.com>
> Sent: Tuesday, February 8, 2022 7:29 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; Lavanya Suresh
> <lavaks@codeaurora.org>; Rameshkumar Sundaram (QUIC)
> <quic_ramess@quicinc.com>
> Subject: [PATCHv3] mac80211: disable BSS color collision detection in cas=
e of
> no free colors
>=20
> From: Lavanya Suresh <lavaks@codeaurora.org>
>=20
> AP may run out of BSS color after color collision detection event from dr=
iver.
> Disable BSS color collision detection if no free colors are available bas=
ed on
> bss color disabled bit sent as a part of NL80211_ATTR_HE_BSS_COLOR
> attribute sent in NL80211_CMD_SET_BEACON.
>=20
> It can be reenabled once new color is available.
>=20
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
> Changes since v1:
>  - Moved the logic to ieee80211_change_beacon() to have this
>    BSS color enabled unset only during set_beacon case based
>    on NL80211_ATTR_HE_BSS_COLOR attribute sent by hostapd.
>  - Removed the relocation and parsing changes done on v1 and moved
>    he_bss_color to cfg80211_beacon_data and parsed
>    NL80211_ATTR_HE_BSS_COLOR in nl80211_parse_beacon()
>=20
> Changes since v1:
>  - Relocated ap params to cfg80211_beacon_data and
>    nl80211_calculate_ap_params() to nl80211_parse_beacon()
>    to have them parsed for all (start_ap and change beacon) commands.
> ---
>  include/net/cfg80211.h |  4 ++--
>  net/mac80211/cfg.c     | 11 +++++++--
>  net/wireless/nl80211.c | 62 ++++++++++++++++++++++++--------------------=
-----
> -
>  3 files changed, 41 insertions(+), 36 deletions(-)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h index
> a887086..08b795d 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1113,6 +1113,7 @@ struct cfg80211_mbssid_elems {
>   *	Token (measurement type 11)
>   * @lci_len: LCI data length
>   * @civicloc_len: Civic location data length
> + * @he_bss_color: BSS Color settings
>   */
>  struct cfg80211_beacon_data {
>  	const u8 *head, *tail;
> @@ -1132,6 +1133,7 @@ struct cfg80211_beacon_data {
>  	size_t probe_resp_len;
>  	size_t lci_len;
>  	size_t civicloc_len;
> +	struct cfg80211_he_bss_color he_bss_color;
>  };
>=20
>  struct mac_address {
> @@ -1233,7 +1235,6 @@ enum cfg80211_ap_settings_flags {
>   * @sae_h2e_required: stations must support direct H2E technique in SAE
>   * @flags: flags, as defined in enum cfg80211_ap_settings_flags
>   * @he_obss_pd: OBSS Packet Detection settings
> - * @he_bss_color: BSS Color settings
>   * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
>   * @fils_discovery: FILS discovery transmission parameters
>   * @unsol_bcast_probe_resp: Unsolicited broadcast probe response
> parameters @@ -1267,7 +1268,6 @@ struct cfg80211_ap_settings {
>  	bool twt_responder;
>  	u32 flags;
>  	struct ieee80211_he_obss_pd he_obss_pd;
> -	struct cfg80211_he_bss_color he_bss_color;
>  	struct cfg80211_fils_discovery fils_discovery;
>  	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
>  	struct cfg80211_mbssid_config mbssid_config; diff --git
> a/net/mac80211/cfg.c b/net/mac80211/cfg.c index 26cc762..f54aaf1 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1133,7 +1133,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy,
> struct net_device *dev,
>=20
> IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>  		changed |=3D BSS_CHANGED_HE_OBSS_PD;
>=20
> -		if (params->he_bss_color.enabled)
> +		if (params->beacon.he_bss_color.enabled)
>  			changed |=3D BSS_CHANGED_HE_BSS_COLOR;
>  	}
>=20
> @@ -1190,7 +1190,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy,
> struct net_device *dev,
>  	sdata->vif.bss_conf.allow_p2p_go_ps =3D sdata->vif.p2p;
>  	sdata->vif.bss_conf.twt_responder =3D params->twt_responder;
>  	sdata->vif.bss_conf.he_obss_pd =3D params->he_obss_pd;
> -	sdata->vif.bss_conf.he_bss_color =3D params->he_bss_color;
> +	sdata->vif.bss_conf.he_bss_color =3D params->beacon.he_bss_color;
>  	sdata->vif.bss_conf.s1g =3D params->chandef.chan->band =3D=3D
>  				  NL80211_BAND_S1GHZ;
>=20
> @@ -1272,6 +1272,7 @@ static int ieee80211_change_beacon(struct wiphy
> *wiphy, struct net_device *dev,
>  				   struct cfg80211_beacon_data *params)  {
>  	struct ieee80211_sub_if_data *sdata;
> +	struct ieee80211_bss_conf *bss_conf;
>  	struct beacon_data *old;
>  	int err;
>=20
> @@ -1291,6 +1292,12 @@ static int ieee80211_change_beacon(struct wiphy
> *wiphy, struct net_device *dev,
>  	err =3D ieee80211_assign_beacon(sdata, params, NULL, NULL);
>  	if (err < 0)
>  		return err;
> +
> +	bss_conf =3D &sdata->vif.bss_conf;
> +	if (params->he_bss_color.enabled !=3D bss_conf-
> >he_bss_color.enabled) {
> +		bss_conf->he_bss_color.enabled =3D params-
> >he_bss_color.enabled;
> +		err |=3D BSS_CHANGED_HE_BSS_COLOR;
> +	}
>  	ieee80211_bss_info_change_notify(sdata, err);
>  	return 0;
>  }
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c index
> bfa5d74..df609e4 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5124,6 +5124,30 @@ nl80211_parse_mbssid_elems(struct wiphy
> *wiphy, struct nlattr *attrs)
>  	return elems;
>  }
>=20
> +static int nl80211_parse_he_bss_color(struct nlattr *attrs,
> +				      struct cfg80211_he_bss_color
> *he_bss_color) {
> +	struct nlattr *tb[NL80211_HE_BSS_COLOR_ATTR_MAX + 1];
> +	int err;
> +
> +	err =3D nla_parse_nested(tb, NL80211_HE_BSS_COLOR_ATTR_MAX,
> attrs,
> +			       he_bss_color_policy, NULL);
> +	if (err)
> +		return err;
> +
> +	if (!tb[NL80211_HE_BSS_COLOR_ATTR_COLOR])
> +		return -EINVAL;
> +
> +	he_bss_color->color =3D
> +		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
> +	he_bss_color->enabled =3D
> +		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
> +	he_bss_color->partial =3D
> +		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
> +
> +	return 0;
> +}
> +
>  static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
>  				struct nlattr *attrs[],
>  				struct cfg80211_beacon_data *bcn)
> @@ -5204,6 +5228,12 @@ static int nl80211_parse_beacon(struct
> cfg80211_registered_device *rdev,
>  		bcn->ftm_responder =3D -1;
>  	}
>=20
> +	if (attrs[NL80211_ATTR_HE_BSS_COLOR]) {
> +		err =3D
> nl80211_parse_he_bss_color(attrs[NL80211_ATTR_HE_BSS_COLOR],
> +						 &bcn->he_bss_color);
> +		if (err)
> +			return err;
> +	}
>  	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
>  		struct cfg80211_mbssid_elems *mbssid =3D
>  			nl80211_parse_mbssid_elems(&rdev->wiphy,
> @@ -5262,30 +5292,6 @@ static int nl80211_parse_he_obss_pd(struct nlattr
> *attrs,
>  	return 0;
>  }
>=20
> -static int nl80211_parse_he_bss_color(struct nlattr *attrs,
> -				      struct cfg80211_he_bss_color
> *he_bss_color)
> -{
> -	struct nlattr *tb[NL80211_HE_BSS_COLOR_ATTR_MAX + 1];
> -	int err;
> -
> -	err =3D nla_parse_nested(tb, NL80211_HE_BSS_COLOR_ATTR_MAX,
> attrs,
> -			       he_bss_color_policy, NULL);
> -	if (err)
> -		return err;
> -
> -	if (!tb[NL80211_HE_BSS_COLOR_ATTR_COLOR])
> -		return -EINVAL;
> -
> -	he_bss_color->color =3D
> -		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
> -	he_bss_color->enabled =3D
> -		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
> -	he_bss_color->partial =3D
> -		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
> -
> -	return 0;
> -}
> -
>  static int nl80211_parse_fils_discovery(struct cfg80211_registered_devic=
e
> *rdev,
>  					struct nlattr *attrs,
>  					struct cfg80211_ap_settings *params)
> @@ -5677,14 +5683,6 @@ static int nl80211_start_ap(struct sk_buff *skb,
> struct genl_info *info)
>  			goto out;
>  	}
>=20
> -	if (info->attrs[NL80211_ATTR_HE_BSS_COLOR]) {
> -		err =3D nl80211_parse_he_bss_color(
> -					info-
> >attrs[NL80211_ATTR_HE_BSS_COLOR],
> -					&params->he_bss_color);
> -		if (err)
> -			goto out;
> -	}
> -
>  	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
>  		err =3D nl80211_parse_fils_discovery(rdev,
>  						   info-
> >attrs[NL80211_ATTR_FILS_DISCOVERY],
> --
> 2.7.4

