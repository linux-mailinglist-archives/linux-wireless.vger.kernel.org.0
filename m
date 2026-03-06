Return-Path: <linux-wireless+bounces-32650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBzwKrAXq2kfaAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 19:06:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DA2268F6
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A4E306493B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6F4218B1;
	Fri,  6 Mar 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T76Ns3nV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E93ACF0C
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820365; cv=pass; b=HhdQ2utPZGoOUOoTICAGD0LIGtM+kxP+i7gEDBJ9qZibhZy7ph7BbgHGNi8rATegPlc1VBEX+HEAJkGs5XcQEgA3GHDWYVm0j7uPTn5ctWCyxs9LQq3TXVJdrdN27OVXn8vlaykWE2erXogt7RVBCIVE1om46dHUwoWO837MyXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820365; c=relaxed/simple;
	bh=gTr7Tq8iACpqbyVR9jDz+kdN5xKREoo57nUaJ5OZEJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ald5yeHnyfZB23mt31vD8ypKTG4qjZeXatzfuM2TX0mloQDLqU7CayTHGvpTDtJcqDv3fr3FimOTF4DuQoDeXRejYE3JfglCCWt/5lbtRjjhW4aDMRRwbObBK/7O6TxP6k37aqKSE4WLRVzfax2bPGYANPYejJ+lp2LuouKpPAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T76Ns3nV; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b790af67so3642244f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 10:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772820362; cv=none;
        d=google.com; s=arc-20240605;
        b=LuWSg7Q6gwXtLRSMfDs+vTQiCrUelo7jVrrLqH+OGSwtiO5+Z+zvPpEWemA2UbK2QI
         3KcoZefmjjGUOmVG/ZQzaFuqdlkg+ADR92NWJp5JeCvsb5rwzoU0Ibt6DTEi5Jea5RUq
         Jfftn+WmqsXR6jZjW57pEEQmQ6Hfva9u7f4UInBwuC1hZ1mdvW2O12KUji+/gQpwc4UM
         6/YnJL68Ui+sANsU7s5OiILf6ZKR4tAQjNWbnjqd5FiJHjXJwYakJfxfNlLPUQUo3MFj
         v9Clh5CX+egU8HCiqT5TzXvwWNS3pruOeWylOlsNqmsucIAra9EWg7DT0ZDciVaG9KSA
         ri1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/dDWc/gnlxKUDh7QeLsWpq20nM7X8WSl+8DE7p0FbI=;
        fh=9Kbtz0RmOZA/kvonwzq3/CsuJFtX0+cCk71eJIQHzOI=;
        b=LfKaFoJ4j2VlReECIKO5kEA+n31R1PiTNwpea1+6pkx8R4lXGJIipccLYGEISGKdMG
         71s6MgNoj2PDnd5IZHBfqPvewEEcM+clFc3VWQeYs9ZvuZeAL9xIXek/P8j2f0M8wVky
         d6eFLvsxp1BNwGDGLeP+Tfzd8IwvyoIp3nxzuzCVLiKEk/duHVlAqoo7uhVM+7qMzCh/
         DvAWWzSvw685zJv5WUPYg198nR3F0LuZs7YS2Cd4dAUN3PNQI2xqY4MXIO5/XnqaDrd9
         9epbTOHcW/7TAAnnLLASjpiSNSKuAin4tjcFMjBNv8K4APFDOyOJ1PvApil1R57hddMx
         VhYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772820362; x=1773425162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/dDWc/gnlxKUDh7QeLsWpq20nM7X8WSl+8DE7p0FbI=;
        b=T76Ns3nVZ8acmzK3iIpKn3/5cnSWz1R1w7vTarOkD03aVodxBCuYTV2Q3DOT6zlStu
         acatMmCAfLwLgJJcZrS7QVzUw2i4pmvPASsNlCL6KlPA8sot5U4lE5w/dLEA2Z3N8R1W
         Qwgn4j7xFFjSZ0uiQEa7t5m0spvJx+0+cK+wR9t3S09OEsrhAPRfxf7dVBckX9JCsg1a
         z70zVB7FB5GhpneU7hxN2f8MitKNSzfmDcTc7MUmGstWNBLi0i5Q/005PJI7EcSzDAf+
         ju4jDe8iGsstCNbgqTg2d42DG9HDQ10Ef0YD8G/Z1a5tR1QrNRzw9UuzitiA1vFt1N9w
         vY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772820362; x=1773425162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/dDWc/gnlxKUDh7QeLsWpq20nM7X8WSl+8DE7p0FbI=;
        b=uHRmjZFqDCO1vRhP3qHRFF2FSKnShMtyK5aLwzYf+7gGCWT54qGMB4bwDYiILwhQrf
         AfcL/JHJs0QA0sBj2T+tvnV5s6y22FhEjwcsJ/5RFV0hLeHo8r+0hwWSUvfoQnk5yI7y
         Dwtr6ezykATwNbjT7ThlL9IPrqne9tPKgvtrqKHeIP+D1/LztKvTvld1kQNAG7t5SaTF
         VjFzWXvvexb11d41l6H9xtF4FyVodXl0GgXfcQqJh6BlJqjesAGPW0sv9DLwNv7erGng
         SmZKwkevzbkehhseSKDAL9U2vBnSb7MNcU4tqMfq2eXlxvljnvcgRH1YMxSUi42t4z6A
         1afg==
X-Gm-Message-State: AOJu0Yzscdx9MZfIAr/LlN8YSBl/rFnCF7hOcPkr2X1N33eNbEtbWmQ4
	UUdrcFxZGy31oVrHjUCU89ZcOCahHYMeu7v9Ah7kjgTGoYnEx8319MLSpAn7Ui0sMQBkVhVx3K5
	F8T06MZaB8/llz0TKS92S1Rn5zXjr4QI=
X-Gm-Gg: ATEYQzz+g1Lo3kNT/BIVau0MuGyPJr+Hd2F5o1MOBb16ZXKjkBjZLCpjyL1i7HkRvZZ
	ZOiQlsiyQ5pUx1uCGDMHkAvkElHwTiLLiV0okOmM0hFsFmfvEWLNqXT4/4oopdCP7KV2siWWpma
	ZXLS9+/QKGd/NBm0BMJI2cPH9zJDhUZ/Vjvj43+Itpa3TJzPU/Oi3F6MHP7D3bLDv1hsL9NsUcs
	SWoVhQiyH4Bn28JgVuGs53hHSZYPcmxGfNORqU+FUJGPu7+quFyKLIA6z39jQsq3pP/4fZKRjQH
	vnAi9gTi9ciDOOhpn6+QWOf9rY31u5n7RnJe0irxLWkxMeLgoQaFrQ6D+PBIyQdHodNiPKUZlKb
	3QQZCksHhEtQvAfr7nnJ/h6I=
X-Received: by 2002:a05:6000:3113:b0:439:ce30:5b84 with SMTP id
 ffacd0b85a97d-439da327d13mr5526227f8f.2.1772820362152; Fri, 06 Mar 2026
 10:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306004344.10968-1-kerigancreighton@gmail.com>
 <20260306004344.10968-4-kerigancreighton@gmail.com> <CAFEp6-2MVFXfz4=_Em7YkH_Vx5VcryWMdDnrwe8C0=TnBmknZA@mail.gmail.com>
In-Reply-To: <CAFEp6-2MVFXfz4=_Em7YkH_Vx5VcryWMdDnrwe8C0=TnBmknZA@mail.gmail.com>
From: Kerigan Creighton <kerigancreighton@gmail.com>
Date: Fri, 6 Mar 2026 12:05:50 -0600
X-Gm-Features: AaiRm532iLjnTqDjw7NIILKH4Fb3Iblc7XV8hlP-8BR1AKl_ztQg6PeShUMn_nA
Message-ID: <CAN6+ztzrTcBT+fX8VHJs3K9haygu9qwNHHhS8fMysbzehangRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] wifi: wcn36xx: Add support for WCN3610
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org, 
	andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 635DA2268F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32650-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 2:41=E2=80=AFAM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> > STA_POWERSAVE resulted in BMPS errors and unstable
> > functionality, thus it has been disabled for just this
> > chip.
> >
> > Tested on an Anki Vector 1.0 and 2.0 robot with 3
> > different APs. Support for other WCN36xx chips has not
> > been affected.
> >
> > Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
>
> STA_POWERSAVE is disabled, but the interface still enters BMPS mode as
> controlled by mac80211. If you get the opportunity, It would be useful
> to air-capture the power=E2=80=91save entry and exit events when this occ=
urs,
> so we can verify that the transitions behave as expected.
>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

[re-sent with full cc list]
I only had the chance to test it with one AP, but wireshark does show
clean power-save entry and exit transitions. Once I do more testing,
I will make a v4 which:

 - Adds these power-save findings to the patch 3 commit message
 - Amends all commit messages so they are wrapped better
 - Amends patch 1 to include a better description of the hardware

Thanks for the review,
- Kerigan

On Fri, Mar 6, 2026 at 2:41=E2=80=AFAM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> On Fri, Mar 6, 2026 at 1:44=E2=80=AFAM Kerigan Creighton
> <kerigancreighton@gmail.com> wrote:
> >
> > The WCN3610 has a lot in common with the other wcn36xx
> > chips, so much of that code was reused.
> >
> > The WCN3610 requires specific configuration values for
> > stable Wi-Fi. Without these values, there's packet loss.
> > An extra CFG table was made so other chips are not affected.
> >
> > ENABLE_DYNAMIC_RA_START_RATE=3D0 was discovered from the
> > downstream prima driver. That brought it from 95% to 5%
> > packet loss. The rest of the CFG values came from my own
> > observations and experimentation. The current settings
> > allow for 0% packet loss.
> >
> > STA_POWERSAVE resulted in BMPS errors and unstable
> > functionality, thus it has been disabled for just this
> > chip.
> >
> > Tested on an Anki Vector 1.0 and 2.0 robot with 3
> > different APs. Support for other WCN36xx chips has not
> > been affected.
> >
> > Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
>
> STA_POWERSAVE is disabled, but the interface still enters BMPS mode as
> controlled by mac80211. If you get the opportunity, It would be useful
> to air-capture the power=E2=80=91save entry and exit events when this occ=
urs,
> so we can verify that the transitions behave as expected.
>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
>
>
> > ---
> > Changes in v2:
> >  - Move wcn36xx driver changes to the end of the patch set.
> >
> > Changes in v3:
> >  - Describe where the CFG values came from in the wcn36xx
> >    driver patch [Konrad].
> > ---
> >  drivers/net/wireless/ath/wcn36xx/main.c    |  4 +-
> >  drivers/net/wireless/ath/wcn36xx/smd.c     | 61 +++++++++++++++++++++-
> >  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
> >  3 files changed, 64 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wire=
less/ath/wcn36xx/main.c
> > index c3f0860873..6c90c13251 100644
> > --- a/drivers/net/wireless/ath/wcn36xx/main.c
> > +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> > @@ -1438,7 +1438,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx =
*wcn)
> >                 BIT(NL80211_IFTYPE_MESH_POINT);
> >
> >         wcn->hw->wiphy->bands[NL80211_BAND_2GHZ] =3D &wcn_band_2ghz;
> > -       if (wcn->rf_id !=3D RF_IRIS_WCN3620)
> > +       if (wcn->rf_id !=3D RF_IRIS_WCN3620 && wcn->rf_id !=3D RF_IRIS_=
WCN3610)
> >                 wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] =3D &wcn_band_=
5ghz;
> >
> >         if (wcn->rf_id =3D=3D RF_IRIS_WCN3680)
> > @@ -1535,6 +1535,8 @@ static int wcn36xx_platform_get_resources(struct =
wcn36xx *wcn,
> >         /* External RF module */
> >         iris_node =3D of_get_child_by_name(mmio_node, "iris");
> >         if (iris_node) {
> > +               if (of_device_is_compatible(iris_node, "qcom,wcn3610"))
> > +                       wcn->rf_id =3D RF_IRIS_WCN3610;
> >                 if (of_device_is_compatible(iris_node, "qcom,wcn3620"))
> >                         wcn->rf_id =3D RF_IRIS_WCN3620;
> >                 if (of_device_is_compatible(iris_node, "qcom,wcn3660") =
||
> > diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wirel=
ess/ath/wcn36xx/smd.c
> > index 813553edcb..8d5a746de7 100644
> > --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> > +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> > @@ -83,6 +83,61 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] =3D=
 {
> >         WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
> >  };
> >
> > +static struct wcn36xx_cfg_val wcn3610_cfg_vals[] =3D {
> > +       WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
> > +       WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
> > +       WCN36XX_CFG_VAL(LOW_GAIN_OVERRIDE, 0),
> > +       WCN36XX_CFG_VAL(POWER_STATE_PER_CHAIN, 785),
> > +       WCN36XX_CFG_VAL(CAL_PERIOD, 5),
> > +       WCN36XX_CFG_VAL(CAL_CONTROL, 1),
> > +       WCN36XX_CFG_VAL(PROXIMITY, 0),
> > +       WCN36XX_CFG_VAL(NETWORK_DENSITY, 3),
> > +       WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
> > +       WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
> > +       WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
> > +       WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
> > +       WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
> > +       WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
> > +       WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
> > +       WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
> > +       WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_TWO, 15),
> > +       WCN36XX_CFG_VAL(FIXED_RATE, 0),
> > +       WCN36XX_CFG_VAL(RETRYRATE_POLICY, 4),
> > +       WCN36XX_CFG_VAL(RETRYRATE_SECONDARY, 131),
> > +       WCN36XX_CFG_VAL(RETRYRATE_TERTIARY, 129),
> > +       WCN36XX_CFG_VAL(FORCE_POLICY_PROTECTION, 5),
> > +       WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_24GHZ, 1),
> > +       WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_5GHZ, 5),
> > +       WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_5GHZ, 5),
> > +       WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_24GHZ, 6),
> > +       WCN36XX_CFG_VAL(MAX_BA_SESSIONS, 40),
> > +       WCN36XX_CFG_VAL(PS_DATA_INACTIVITY_TIMEOUT, 200),
> > +       WCN36XX_CFG_VAL(PS_ENABLE_BCN_FILTER, 1),
> > +       WCN36XX_CFG_VAL(PS_ENABLE_RSSI_MONITOR, 1),
> > +       WCN36XX_CFG_VAL(NUM_BEACON_PER_RSSI_AVERAGE, 20),
> > +       WCN36XX_CFG_VAL(STATS_PERIOD, 10),
> > +       WCN36XX_CFG_VAL(CFP_MAX_DURATION, 30000),
> > +       WCN36XX_CFG_VAL(FRAME_TRANS_ENABLED, 0),
> > +       WCN36XX_CFG_VAL(BA_THRESHOLD_HIGH, 128),
> > +       WCN36XX_CFG_VAL(MAX_BA_BUFFERS, 2560),
> > +       WCN36XX_CFG_VAL(DYNAMIC_PS_POLL_VALUE, 0),
> > +       WCN36XX_CFG_VAL(TX_PWR_CTRL_ENABLE, 1),
> > +       WCN36XX_CFG_VAL(ENABLE_CLOSE_LOOP, 1),
> > +       WCN36XX_CFG_VAL(ENABLE_LPWR_IMG_TRANSITION, 0),
> > +       WCN36XX_CFG_VAL(BTC_EXECUTION_MODE, 2),
> > +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_WLAN_LEN, 90000),
> > +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_BT_LEN, 60000),
> > +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_WLAN_LEN, 30000),
> > +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_BT_LEN, 120000),
> > +       WCN36XX_CFG_VAL(BTC_FAST_WLAN_CONN_PREF, 1),
> > +       WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_BT, 120000),
> > +       WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_WLAN, 30000),
> > +       WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
> > +       WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
> > +       WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 0),
> > +       WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
> > +};
> > +
> >  static struct wcn36xx_cfg_val wcn3680_cfg_vals[] =3D {
> >         WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
> >         WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
> > @@ -632,6 +687,9 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
> >         if (wcn->rf_id =3D=3D RF_IRIS_WCN3680) {
> >                 cfg_vals =3D wcn3680_cfg_vals;
> >                 cfg_elements =3D ARRAY_SIZE(wcn3680_cfg_vals);
> > +       } else if (wcn->rf_id =3D=3D RF_IRIS_WCN3610) {
> > +               cfg_vals =3D wcn3610_cfg_vals;
> > +               cfg_elements =3D ARRAY_SIZE(wcn3610_cfg_vals);
> >         } else {
> >                 cfg_vals =3D wcn36xx_cfg_vals;
> >                 cfg_elements =3D ARRAY_SIZE(wcn36xx_cfg_vals);
> > @@ -2380,7 +2438,8 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn3=
6xx *wcn)
> >         mutex_lock(&wcn->hal_mutex);
> >         INIT_HAL_MSG(msg_body, WCN36XX_HAL_FEATURE_CAPS_EXCHANGE_REQ);
> >
> > -       wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, STA_POWERSAV=
E);
> > +       if (wcn->rf_id !=3D RF_IRIS_WCN3610)
> > +               wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, STA_=
POWERSAVE);
> >         if (wcn->rf_id =3D=3D RF_IRIS_WCN3680) {
> >                 wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, DOT1=
1AC);
> >                 wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, WLAN=
_CH144);
> > diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/w=
ireless/ath/wcn36xx/wcn36xx.h
> > index 7ee79593cd..cb409d48f7 100644
> > --- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> > +++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> > @@ -96,6 +96,7 @@ enum wcn36xx_ampdu_state {
> >  #define WCN36XX_MAX_POWER(__wcn) (__wcn->hw->conf.chandef.chan->max_po=
wer)
> >
> >  #define RF_UNKNOWN     0x0000
> > +#define RF_IRIS_WCN3610        0x3610
> >  #define RF_IRIS_WCN3620        0x3620
> >  #define RF_IRIS_WCN3660        0x3660
> >  #define RF_IRIS_WCN3680        0x3680
> > --
> > 2.53.0
> >

