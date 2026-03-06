Return-Path: <linux-wireless+bounces-32592-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHl8J0eTqml0TQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32592-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:41:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6721D373
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2AD30179F6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBA3793D9;
	Fri,  6 Mar 2026 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1tOPCek";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKFXh+DF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B7375F93
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786486; cv=pass; b=X1OsAFEIs3TOxi5yVXh2WhvofdB0G3W8JUJ4/UlKkBz/+3oRbbaki8l/Tu6nt+jtlzDxlyRq1KvqythD/qyMwBtmddARYOhQllDVX6wYdug/oHDAYcq9toUUEUKlojfW/4b+qzxCrRecRinBs7ZUkmM3q6lGXdsRPU0bK2KDvnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786486; c=relaxed/simple;
	bh=YVPiTvc8HSEbsl+v0TAOxckYPX6yDiMrRYbqiKFL+bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHgcRQMA4BJek6K0gqAQY95EE7pb3T6pUbxuS52tGojersPFmo6A9vRJuip4N+X4jPGyaQWg950I8mPgMDcY6quvejGtfaPsI5iiI9ztu5ChgDv/NgRPQXB3UH4ElP0I0svJW+7fKfx7rkAjOaueL6Hviza8nvJ1orTR0RFqPFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1tOPCek; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OKFXh+DF; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aE0m264636
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 08:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0sAnhwFJhRCHu2yMxo3rKkoCI7pR6vsYT3BN6ZZbduo=; b=g1tOPCek5pHSdOg4
	2QNQ2ucWEMZcs57rrHH+mTWLXiNqclEI6liaAmPV0w+STL86Ny9HWKp4NIYKSVw0
	FZ/UiyJMutkzifp9iZdT44Ue//MuhU3hUXl35rSar/RkfMGyaA02ZSwseDx+jxjb
	M3fUjK+0jrE/tkYHxZ54cA91mo+ynlYh3r28J0zsoSBG0M2aMT8TmifwLG9Eyb2j
	2vc01YfYS6gq+kyq9kK3e+YAnT1yQCJeTd07Z2P8ppo/H537jwm/JDIUnxeSF9pu
	JPu0yGAx0T/BXHf9gDrr282caSu5BpR0VrfpgwVSgL+K75lCOUi/xlqR0KZMeoc3
	qYdDcg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqdvktt04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 08:41:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4d191ef1so1174337185a.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 00:41:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772786483; cv=none;
        d=google.com; s=arc-20240605;
        b=KLIT176G2tUW5LxeQisNjAWEXlxygFwUrj1WzRKu+rHE5EMHZuMdhGB5TXVPp7QncV
         9ogkhGwgBh8m6Olc3TwKOaXCC9zd5tiv+p5jmr68gQgf4QGizIonVqfvh6z4WIImgbV3
         ZSVfICziBfRYS7RJGdqYtClzF0t8U9cAoHDYclo49PI5to7zehxMFnul6j3s4ejtQRE7
         0kvqnnfEssytRVby6oUs9P2ulqTZgFUNSNT6BX2nkBdRTNSb96fLlbSzABYacf/1BV48
         Z213X0ZQLPqvrbTVSdr+ff/1hvB9QFlVW47dA3k0U2AVGrpe6756NtSRk2+sWno8emOB
         F19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0sAnhwFJhRCHu2yMxo3rKkoCI7pR6vsYT3BN6ZZbduo=;
        fh=qrY2IfSgnWjwYvntHv82E+uqMFrSL+XsdtwRCEK3yrU=;
        b=j1ZO3t/Z1xI95danl1QyZDFCRs1HhsmGQu0tKFvDP8NMCpdfAI4p1d5Y+V9LQyVljB
         63ri4HxEDXZBr8ApQM3muxhSq7cQr+T6eDI5kD2grBxqkUKjKuWXCMuzXhdzmkTVNgl4
         ujJfKRImB97YezivF37fM4znNjoJPwj5YgzE97YNL6nhOicZEzLFaNfnQmhw6xtYvb1Z
         4B2I9OJSKk3zby2zo7aqBwdeI7NOTGfsb89WL8ALxH9Up3Yxvtl3pRXUCHZaPmm/mg42
         IpAM8Vtif/GENiFLQOY9fgrm7DxRGAuQ8kQdGJVYnxmsNai63H4hXmr/08ebrN2ltKI/
         nUTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772786483; x=1773391283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sAnhwFJhRCHu2yMxo3rKkoCI7pR6vsYT3BN6ZZbduo=;
        b=OKFXh+DF384LeuZtat3m7W7zdf0e/WXA/TB2uzD2h91XwXSKre5Ud0eGOwZih2zN/J
         6a5dYwFSkWDrTV3T0Jn6vgckmBMbt6U4tebYm6Sg2bmjaefG/aKuptHYs5A/VWYzgIFo
         oQo6evZ3BRHBdXpB3bO8hKcMRMuA/AtHC3n/y8xXcoxdigsJz6oTIO5fRmNcA9qpwDbJ
         yM3KQp0WB+jYVcqepI+qvOLAxAj4sYOEpzw2w+yc3FSmtmpj4sTi/7WgkxJusbgQGaaC
         Ce9lDzjK2hfF5jSGRbD78/8sfCLoj0Lb6Ty9kW3nPAOav6RMhW54+9TZ6XdcT6rUx8G2
         32Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772786483; x=1773391283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0sAnhwFJhRCHu2yMxo3rKkoCI7pR6vsYT3BN6ZZbduo=;
        b=q3+gyis08rYxmGee2I7bYtyrUliQDRbJfBGM8wPgtm/k3YCzFiCn3fm8i5hAjQ8K0a
         Y+eSaB7p2w8Cj2vaDNeXHElWeiPnLBDhaRkUbt5NqUOX9WBHpipzPZaMOSPzJbtVVjiZ
         byAb4vbiWFv3RK5eSckY5UbHarSCrRv1jtjk7rrldxKvemWXPsZzaWFhWezd4f68Ozsm
         84heOqSBclrRWA3FSQTpHFNQKQe5fxJIZ8ExLsbFAK5u0ctn1mmRX9O3wzHzRkfpobRm
         rBF/Sn44jim9RiunM9rCmaBPXVdxNfFMd3Vo5yAHr7Jm5RftIRJcmrnZZQZs6USznjVI
         TTpg==
X-Gm-Message-State: AOJu0Yx3h8En1YdqE1DLB1Ovvb5+r8jr86YvPeIo9idr4Z6QSA8FerxZ
	nwEJ1J6dMOhtVWbKW8nhKHLXA7595KxQbejriCh0gxVBL0/njI0W/pMYTRbAOnw0tUzHhbM3SNK
	jtCqKZCH6R+xI2DVF8DUJFNci33heINlWlIx4jEgdyH6Mo9FOStns721NHIL2aCsDCF9uebggfN
	YzJDlKe3tfx0dLvfkrDWlOXGOIf+TOg2+Gu30mIuQk9FxY
X-Gm-Gg: ATEYQzxL6ZKyJdgz4TKlYW9L1sVsPCgTd0Td0zRbwQJTwD+vTwVwyfoNQipI/A/JmBR
	dFajAWB2LGGligZumTObBSrXTOY5zDHmesd5lmMY6ksYOfQWYFKYzQpvIRjsZKwTP9/ywFHoyJv
	nUK9B/8kRRytwLX64f+pOZKAjlsOwH8SSPX8NWQZ4mg1bSz2C3bRjw89nyqh8UoFz6CGCBRxg5r
	u86SmrTv8hyYwS+3sTTx95tsXEt+SeZGoATAw==
X-Received: by 2002:a05:620a:bd5:b0:8ca:123e:8194 with SMTP id af79cd13be357-8cd6d38ed0bmr156599385a.33.1772786483290;
        Fri, 06 Mar 2026 00:41:23 -0800 (PST)
X-Received: by 2002:a05:620a:bd5:b0:8ca:123e:8194 with SMTP id
 af79cd13be357-8cd6d38ed0bmr156597685a.33.1772786482792; Fri, 06 Mar 2026
 00:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306004344.10968-1-kerigancreighton@gmail.com> <20260306004344.10968-4-kerigancreighton@gmail.com>
In-Reply-To: <20260306004344.10968-4-kerigancreighton@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 09:41:10 +0100
X-Gm-Features: AaiRm50ityeSqNbLbi_vlqBFaxP1tMie2ALHub6uuVR7TUiuZkBUrj9KPTvuhPs
Message-ID: <CAFEp6-2MVFXfz4=_Em7YkH_Vx5VcryWMdDnrwe8C0=TnBmknZA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] wifi: wcn36xx: Add support for WCN3610
To: Kerigan Creighton <kerigancreighton@gmail.com>
Cc: linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        andersson@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=M7xA6iws c=1 sm=1 tr=0 ts=69aa9334 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=hsp69BweicYqoijZIzwA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfXz+4Yhz3D4Kkb
 F7ttKB7SGjQ+d6A8ZlDrNmDKlBgXbnLjXj/nl2dHMmtywHn067n26iRPk1vCo6oc78lXGjZLxPM
 9KZyVMxPwC5aHKIflDsHC3HBNJmI8UQ8PzTXbA5x64Gh1wBDttLwmhtoVIjjJdb/e78yikd3QAt
 S7TnARx+khwpRXKOEC4vzZ63zSQ+PGlfWx+C7bcR0d+erQUCv2cJwqWEBTaP1zaNL+gp+rkaDa1
 0Kj/P2o9pM3wAhdJLt9zg7BdrhU+jD/nYVb6LNClrQY4nZjvzj5CEnv3Dm5318ruTP+QsX2+a6k
 lv1AHXzSqxzVPvwwtf+4HMidtPmiAou20jpcneldVsKyu6hmmxvf4WAK9R2JO9B7SX2SSuxUw44
 VwrpwgM8qIPR4hwCjPnu2q9js39eMwilqr3VgLnGgJf2BA+VAwXF+JY/uqXU8fJU38vdg1Xonag
 /p08EDocFWJqFODoWTA==
X-Proofpoint-GUID: NmeQAZzsw48MpqARrZlsCoR0KyjSNO1E
X-Proofpoint-ORIG-GUID: NmeQAZzsw48MpqARrZlsCoR0KyjSNO1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060080
X-Rspamd-Queue-Id: 18E6721D373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32592-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 1:44=E2=80=AFAM Kerigan Creighton
<kerigancreighton@gmail.com> wrote:
>
> The WCN3610 has a lot in common with the other wcn36xx
> chips, so much of that code was reused.
>
> The WCN3610 requires specific configuration values for
> stable Wi-Fi. Without these values, there's packet loss.
> An extra CFG table was made so other chips are not affected.
>
> ENABLE_DYNAMIC_RA_START_RATE=3D0 was discovered from the
> downstream prima driver. That brought it from 95% to 5%
> packet loss. The rest of the CFG values came from my own
> observations and experimentation. The current settings
> allow for 0% packet loss.
>
> STA_POWERSAVE resulted in BMPS errors and unstable
> functionality, thus it has been disabled for just this
> chip.
>
> Tested on an Anki Vector 1.0 and 2.0 robot with 3
> different APs. Support for other WCN36xx chips has not
> been affected.
>
> Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>

STA_POWERSAVE is disabled, but the interface still enters BMPS mode as
controlled by mac80211. If you get the opportunity, It would be useful
to air-capture the power=E2=80=91save entry and exit events when this occur=
s,
so we can verify that the transitions behave as expected.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>



> ---
> Changes in v2:
>  - Move wcn36xx driver changes to the end of the patch set.
>
> Changes in v3:
>  - Describe where the CFG values came from in the wcn36xx
>    driver patch [Konrad].
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c    |  4 +-
>  drivers/net/wireless/ath/wcn36xx/smd.c     | 61 +++++++++++++++++++++-
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
>  3 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wirele=
ss/ath/wcn36xx/main.c
> index c3f0860873..6c90c13251 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1438,7 +1438,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *w=
cn)
>                 BIT(NL80211_IFTYPE_MESH_POINT);
>
>         wcn->hw->wiphy->bands[NL80211_BAND_2GHZ] =3D &wcn_band_2ghz;
> -       if (wcn->rf_id !=3D RF_IRIS_WCN3620)
> +       if (wcn->rf_id !=3D RF_IRIS_WCN3620 && wcn->rf_id !=3D RF_IRIS_WC=
N3610)
>                 wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] =3D &wcn_band_5g=
hz;
>
>         if (wcn->rf_id =3D=3D RF_IRIS_WCN3680)
> @@ -1535,6 +1535,8 @@ static int wcn36xx_platform_get_resources(struct wc=
n36xx *wcn,
>         /* External RF module */
>         iris_node =3D of_get_child_by_name(mmio_node, "iris");
>         if (iris_node) {
> +               if (of_device_is_compatible(iris_node, "qcom,wcn3610"))
> +                       wcn->rf_id =3D RF_IRIS_WCN3610;
>                 if (of_device_is_compatible(iris_node, "qcom,wcn3620"))
>                         wcn->rf_id =3D RF_IRIS_WCN3620;
>                 if (of_device_is_compatible(iris_node, "qcom,wcn3660") ||
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireles=
s/ath/wcn36xx/smd.c
> index 813553edcb..8d5a746de7 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -83,6 +83,61 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] =3D {
>         WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
>  };
>
> +static struct wcn36xx_cfg_val wcn3610_cfg_vals[] =3D {
> +       WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
> +       WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
> +       WCN36XX_CFG_VAL(LOW_GAIN_OVERRIDE, 0),
> +       WCN36XX_CFG_VAL(POWER_STATE_PER_CHAIN, 785),
> +       WCN36XX_CFG_VAL(CAL_PERIOD, 5),
> +       WCN36XX_CFG_VAL(CAL_CONTROL, 1),
> +       WCN36XX_CFG_VAL(PROXIMITY, 0),
> +       WCN36XX_CFG_VAL(NETWORK_DENSITY, 3),
> +       WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
> +       WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
> +       WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
> +       WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
> +       WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
> +       WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
> +       WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
> +       WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
> +       WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_TWO, 15),
> +       WCN36XX_CFG_VAL(FIXED_RATE, 0),
> +       WCN36XX_CFG_VAL(RETRYRATE_POLICY, 4),
> +       WCN36XX_CFG_VAL(RETRYRATE_SECONDARY, 131),
> +       WCN36XX_CFG_VAL(RETRYRATE_TERTIARY, 129),
> +       WCN36XX_CFG_VAL(FORCE_POLICY_PROTECTION, 5),
> +       WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_24GHZ, 1),
> +       WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_5GHZ, 5),
> +       WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_5GHZ, 5),
> +       WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_24GHZ, 6),
> +       WCN36XX_CFG_VAL(MAX_BA_SESSIONS, 40),
> +       WCN36XX_CFG_VAL(PS_DATA_INACTIVITY_TIMEOUT, 200),
> +       WCN36XX_CFG_VAL(PS_ENABLE_BCN_FILTER, 1),
> +       WCN36XX_CFG_VAL(PS_ENABLE_RSSI_MONITOR, 1),
> +       WCN36XX_CFG_VAL(NUM_BEACON_PER_RSSI_AVERAGE, 20),
> +       WCN36XX_CFG_VAL(STATS_PERIOD, 10),
> +       WCN36XX_CFG_VAL(CFP_MAX_DURATION, 30000),
> +       WCN36XX_CFG_VAL(FRAME_TRANS_ENABLED, 0),
> +       WCN36XX_CFG_VAL(BA_THRESHOLD_HIGH, 128),
> +       WCN36XX_CFG_VAL(MAX_BA_BUFFERS, 2560),
> +       WCN36XX_CFG_VAL(DYNAMIC_PS_POLL_VALUE, 0),
> +       WCN36XX_CFG_VAL(TX_PWR_CTRL_ENABLE, 1),
> +       WCN36XX_CFG_VAL(ENABLE_CLOSE_LOOP, 1),
> +       WCN36XX_CFG_VAL(ENABLE_LPWR_IMG_TRANSITION, 0),
> +       WCN36XX_CFG_VAL(BTC_EXECUTION_MODE, 2),
> +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_WLAN_LEN, 90000),
> +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_BT_LEN, 60000),
> +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_WLAN_LEN, 30000),
> +       WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_BT_LEN, 120000),
> +       WCN36XX_CFG_VAL(BTC_FAST_WLAN_CONN_PREF, 1),
> +       WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_BT, 120000),
> +       WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_WLAN, 30000),
> +       WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
> +       WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
> +       WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 0),
> +       WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
> +};
> +
>  static struct wcn36xx_cfg_val wcn3680_cfg_vals[] =3D {
>         WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
>         WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
> @@ -632,6 +687,9 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
>         if (wcn->rf_id =3D=3D RF_IRIS_WCN3680) {
>                 cfg_vals =3D wcn3680_cfg_vals;
>                 cfg_elements =3D ARRAY_SIZE(wcn3680_cfg_vals);
> +       } else if (wcn->rf_id =3D=3D RF_IRIS_WCN3610) {
> +               cfg_vals =3D wcn3610_cfg_vals;
> +               cfg_elements =3D ARRAY_SIZE(wcn3610_cfg_vals);
>         } else {
>                 cfg_vals =3D wcn36xx_cfg_vals;
>                 cfg_elements =3D ARRAY_SIZE(wcn36xx_cfg_vals);
> @@ -2380,7 +2438,8 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36x=
x *wcn)
>         mutex_lock(&wcn->hal_mutex);
>         INIT_HAL_MSG(msg_body, WCN36XX_HAL_FEATURE_CAPS_EXCHANGE_REQ);
>
> -       wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, STA_POWERSAVE)=
;
> +       if (wcn->rf_id !=3D RF_IRIS_WCN3610)
> +               wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, STA_PO=
WERSAVE);
>         if (wcn->rf_id =3D=3D RF_IRIS_WCN3680) {
>                 wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, DOT11A=
C);
>                 wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, WLAN_C=
H144);
> diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wir=
eless/ath/wcn36xx/wcn36xx.h
> index 7ee79593cd..cb409d48f7 100644
> --- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> +++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> @@ -96,6 +96,7 @@ enum wcn36xx_ampdu_state {
>  #define WCN36XX_MAX_POWER(__wcn) (__wcn->hw->conf.chandef.chan->max_powe=
r)
>
>  #define RF_UNKNOWN     0x0000
> +#define RF_IRIS_WCN3610        0x3610
>  #define RF_IRIS_WCN3620        0x3620
>  #define RF_IRIS_WCN3660        0x3660
>  #define RF_IRIS_WCN3680        0x3680
> --
> 2.53.0
>

