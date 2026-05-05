Return-Path: <linux-wireless+bounces-35939-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAM4JpQe+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35939-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8C4D192D
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 294D7301F22F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31E492194;
	Tue,  5 May 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9QTDCN3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/TSrWxY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AB492502
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999403; cv=pass; b=e45p+JpcqSbKgi56pMAicywZc0v5BBBtAoDXA186Ifudf65y4doMKegVH5p24NAwFR35zKLwQyYJy73USt06TAXzqw7RgGuC5q2bq0b+utOUg6eyPpbvVZslLBAzvHfbHD9JG1OJae0D2+rkWlu6tZQ7gb6mknWhmNp/kMortu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999403; c=relaxed/simple;
	bh=35ywRKBGNmds0HER/Ya5UGphWIblpOGkZGn4zb2n8PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QspeSvOPt6oKUz3tVDuhlF3jtrCNPwkW7FXbnvFiK4NbmdjE4g0qxFZWLoYoxeu3yPHKoHw42/8+jO1Q44KeNKusjrQ+AEOahECGVDxNoPHs57+gYk0bCG+e+8Jd5+yWWBjcddgoBO6kPQa5trtMo4HSU1W7yRN+crRHDdG/AI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9QTDCN3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/TSrWxY; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645DPArk3187548
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 16:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O8/YiQfhmqRY/IAROP7g/igP37JipicyKl59Byo7gDE=; b=T9QTDCN3d3QZFS1p
	uriz708aPh7giDV7ThXdVh0IFmcsrrqzwnfKGUV+r1qKLmLKoUMgnrOl2qrZ615e
	rSBN8XXSxFYeGDjjToF2pNq/qDNe9JsoaEjBiNC5CG8eylVeR0tV7UQDvb17ZKo/
	MMbJqF01sFDi5Ntyj3LBH3ERgXes2CabrSYs4ZKsYuDAgiJfiFELlkG3yvMk38bn
	QmTcst3w82iEYVdjqyCWM9LRzy31e8HOc3jcldmgQ0ulPXUhtTrl3lGaeKnXbAwm
	c9/e/CJFPpqaREP8apVdgLAfuvk1vQNOo13dQ1YRuCjRLJAL4ELFIiHEiRKgoLqv
	r8Nj8w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkab94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 16:43:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2eed3af222dso206067eec.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 09:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777999398; cv=none;
        d=google.com; s=arc-20240605;
        b=iCrauYzaYQnd22+85mG1Pa54SNV9GxF0WTa3SwHXhU6sBTurBpEO+nM6JH4kaxYxmW
         DXqWkFqMUPPsQ8Pp4dIGU3ljCSTiI+skxDIVQZqoZXDw+BfL/Ikh3JSaFGdO7cXrW2cW
         7aOb0qdErgs+XwcFkt7DkSE6GG0hxePiRL5RkURoOmtb0vzzihlj0qdidqhx29sdbcJU
         T6kI5ASLqTMS1DmYtHVPHbP2GXfwc8K0ECIBgvG+Cb6q5tCsKg6XsvutCEL7IVnnDDvJ
         eE3biNRHIe+hPGdeM2gjlchvHrZMVNhR0Cn9kTK0f0Df5WG+WrCwsRM+7JVbS5+n7D9N
         zUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O8/YiQfhmqRY/IAROP7g/igP37JipicyKl59Byo7gDE=;
        fh=aPetRQu2v7y9Fz5MkjnFej7LrzLROlV7xxlmoUWWKMU=;
        b=j9IVGwjMP/iMZiiw2NOJfEg4uJJCmSjew/TLdubKX7gg5E+Oo/jwLFPSoi72q9JbFc
         KuoYXWhHDTVf4XmbbPeIYsqOLDWgq9hjkXRfQBAFxQ5yZ3GNTjwGSfyoyJKePS/6bkBg
         u4860o8NWVlW1w1qFkjz0sqbje+x8jdlF2ecI353S7FCUuVtOjpUzL/HGewqgoHW6eAP
         bGhqJ9A/95GDVXPvM7LGi3eOP64f83tAySjRNSsRkb53ofyFeuoylo2M8cmrWbX2YPLK
         aLev0oaHCuhL/ik6zYnj7EeDgpzFhEeEB7/h77Hncccb50Qp8gntXWCY955TyYOmHDR0
         Fg/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999398; x=1778604198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8/YiQfhmqRY/IAROP7g/igP37JipicyKl59Byo7gDE=;
        b=N/TSrWxYeFbgygy7oDWE/cttHnJZ6iulQZHHVDhx/5M0IrnvBs2LNRN3xA5U8Prr5D
         4AJhvoU+NrTIh5Nj84NfueHu3KXMEkrpK3wsf7T1adNg31+mLy59CHL0r7LdyB1gHFYT
         FFNP0jCrj7l8VKjNOs731L4zVnVbhnWOLiAutjpCFmoytq19/rmnscP1ZrfRWqdgGCl+
         sG4Rs56VvSeRMJ/DScBMqbGGj8vvpo0QgBOibDNxVqwDRXSGhWM1oEicRpLNog1LizBU
         hhSANUdAz+Idv3A1SOxhTk8JTrBZJTovspJENoKeufirrtjp18SsWW3MLml+tyjazvj8
         A93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999398; x=1778604198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8/YiQfhmqRY/IAROP7g/igP37JipicyKl59Byo7gDE=;
        b=LyK9fNiN81hHmbyUFBSsMAiZlcBnz7zzFAF2Rid46z3UEzI53rTOXv5nrYVI/kAPbB
         7Uzf10TdInr5M4U2EYCvHCoMMIqQ7fekklyO2kptHo/SdDZ/hgnk76nCqjbPDMkvhHCk
         BOSaJHjlYP262Jma7zcM5r/BxSRRl/KZXEIZ9WOaO6Ro0ci7Wdf9bo7rMZynnqFqXqtY
         lyR70tZGgkhhxjUCnasMd90fRqR/g3XhUKVymrFWVmLWDzvlmSrHMdWVaWeEDFnkJHjY
         Kjfl5usTEdSigW/+lm0eLypV6oWF7V9nxgHM1QbiUSYF4kHtsp3VCZhASyeRga5YD+D+
         xfoA==
X-Forwarded-Encrypted: i=1; AFNElJ+1uHjWG0Cx9I7kmTYRZL55YmX6Nd41h/2jJ5lV1TE6Fcdwj7PhIugM7YttW77+3/Ihrlfl7s9prn+0zpFa+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpsce7OgCnKkqXYodTISwlA4L0kTpHovVz6ZOaGWyPNdwKVqDr
	ssw6dyxPkhA0POPekYbLuTG2Bjiay2iiAsEE42zVQ/ctmbnWTKYzKv65UKrIY0H2wnoJRIgD3Qu
	xNZXDrNtIi5eUi2mKzAYA86LeXnLCYxgFhWp/xoj0i0UIHos2/UDh2ypYaioKfYdJpxkRrOzNSZ
	WlQuF6FyYtWgVC3KjV/rppyM5KSJjNu914Yg/LAOyBZvsn
X-Gm-Gg: AeBDieuWkp8wKVF8QbAjBWWffWM3xeaKZ7CIbBj9fOLOdv+Pl8tTwmR2lYdmDCCo9oA
	SU4z3r2QtyoNi/sD54iLumcRS2g1bosHFmscSO8+u575oHLZdu7Gra7OTdrRfYEDCOjKUhp4WTs
	z82evvx5+9Qd+YJrP8Wo0e1F2PcWbW1mAUGLbInXSWiGMXQx876IsMH9pso+UBbk5YhGZlH2BwU
	EbDB14WS40dNCAdYYo=
X-Received: by 2002:a05:693c:2c93:b0:2d9:2896:2794 with SMTP id 5a478bee46e88-2f41e702b82mr899121eec.7.1777999398079;
        Tue, 05 May 2026 09:43:18 -0700 (PDT)
X-Received: by 2002:a05:693c:2c93:b0:2d9:2896:2794 with SMTP id
 5a478bee46e88-2f41e702b82mr899112eec.7.1777999397569; Tue, 05 May 2026
 09:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505040920.57521-1-laicheehou9@gmail.com>
In-Reply-To: <20260505040920.57521-1-laicheehou9@gmail.com>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Tue, 5 May 2026 22:13:04 +0530
X-Gm-Features: AVHnY4KzdHCeV-5OSFkkTeZc7KzEIGZXt1W7oIWCeu_Qt3IBwN13X9ixiyHlYyc
Message-ID: <CABkEBKbVG-UGWOQUgi0Q4M9HkMqOF-nc2gWTwBn9gebC8s7U8Q@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
To: kwan1996 <laicheehou9@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX9Go/5mU2YNBc
 4Gq/Atig1lJitwdreI/mEX5FTbZmyiF8V9xV95w/aDGLQW+3riLqG3rWsFpriIicebyFxPrhzc2
 uo/3BF/T3RwdTTurVEoTghpnl3EVSJcEEOaYcxyVdFMqrisJDOTdOmXNSeuyRe7Eg5CyUlqnou9
 NfD8fJZU+bV9sU3HGnAhQqP/pDmmw658LeayBesPkKIQuk6ekEtnW6WfKTC07rTeIzUmm1YOw4k
 E0dwJTpvul3nu90f1ovnB9A5BwlxCImZg7T1cwshLY/MVUCBc0cCZVKBT1cFUMWqxdLziRNdlf+
 ssuMWh1VEzEN0JcX+3oCXy2hiA7wfj+9WjDGzoHzDCSldTOmkHDPJcoTreJRcz0ZLKiLUxXTd/A
 DdwSMrHcJMqvakuJHPKAGhVEFdob7JtQeQ/WmXCrPaYdyJNY0vuX2wugwVjt5bSLGb0XCVS+QF/
 ms24vBabi8WnnUmRswA==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa1e27 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=24JUTzMKAzwX5QBAHdcA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: eYf2xVyGQz1qvQ1EzW1MQgUbiX7zzCOB
X-Proofpoint-ORIG-GUID: eYf2xVyGQz1qvQ1EzW1MQgUbiX7zzCOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160
X-Rspamd-Queue-Id: 98C8C4D192D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35939-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,mail.gmail.com:mid,oss.qualcomm.com:dkim]

On Tue, May 5, 2026 at 9:40=E2=80=AFAM kwan1996 <laicheehou9@gmail.com> wro=
te:
>
> In monitor mode, the driver incorrectly assigns the legacy rate
> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
> frames, ignoring the actual MCS value parsed from the hardware.
>
> This causes packet analyzers (like Wireshark) to display incorrect
> MCS values (e.g., legacy base rates instead of the true MCS).
>
> Fix this by assigning ppdu_info->mcs instead of ppdu_info->rate
> for HT/VHT/HE/EHT frame types in ath12k_dp_mon_fill_rx_rate()
> and ath12k_dp_mon_update_radiotap().
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220864
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ
>
> Signed-off-by: kwan1996 <laicheehou9@gmail.com>
>
> ---
>
> v2: Fix indentation and formatting issues in v1.
>
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wirel=
ess/ath/ath12k/dp_mon.c
> index 39d1967..4119bb8 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -1925,6 +1925,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>                 }
>                 break;
>         case RX_MSDU_START_PKT_TYPE_11N:
> +               rate_mcs =3D ppdu_info->mcs;

Can we assign this rate_mcs before the switch case? Since in all cases
we are assigning unmodified ppdu_info->mcs.
>                 rx_status->encoding =3D RX_ENC_HT;
>                 if (rate_mcs > ATH12K_HT_MCS_MAX) {
>                         ath12k_warn(ar->ab,
> @@ -1937,6 +1938,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>                         rx_status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
>                 break;
>         case RX_MSDU_START_PKT_TYPE_11AC:
> +               rate_mcs =3D ppdu_info->mcs;
>                 rx_status->encoding =3D RX_ENC_VHT;
>                 rx_status->rate_idx =3D rate_mcs;
>                 if (rate_mcs > ATH12K_VHT_MCS_MAX) {
> @@ -1949,6 +1951,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>                         rx_status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
>                 break;
>         case RX_MSDU_START_PKT_TYPE_11AX:
> +               rate_mcs =3D ppdu_info->mcs;
>                 rx_status->rate_idx =3D rate_mcs;
>                 if (rate_mcs > ATH12K_HE_MCS_MAX) {
>                         ath12k_warn(ar->ab,
> @@ -1960,6 +1963,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>                 rx_status->he_gi =3D ath12k_he_gi_to_nl80211_he_gi(sgi);
>                 break;
>         case RX_MSDU_START_PKT_TYPE_11BE:
> +               rate_mcs =3D ppdu_info->mcs;
>                 rx_status->rate_idx =3D rate_mcs;
>                 if (rate_mcs > ATH12K_EHT_MCS_MAX) {
>                         ath12k_warn(ar->ab,
> @@ -2259,13 +2263,13 @@ static void ath12k_dp_mon_update_radiotap(struct =
ath12k *ar,
>                 rxs->encoding =3D RX_ENC_HE;
>                 ptr =3D skb_push(mon_skb, sizeof(struct ieee80211_radiota=
p_he));
>                 ath12k_dp_mon_rx_update_radiotap_he(ppduinfo, ptr);
> -               rxs->rate_idx =3D ppduinfo->rate;
> +               rxs->rate_idx =3D ppduinfo->mcs;
>         } else if (ppduinfo->vht_flags) {
>                 rxs->encoding =3D RX_ENC_VHT;
> -               rxs->rate_idx =3D ppduinfo->rate;
> +               rxs->rate_idx =3D ppduinfo->mcs;
>         } else if (ppduinfo->ht_flags) {
>                 rxs->encoding =3D RX_ENC_HT;
> -               rxs->rate_idx =3D ppduinfo->rate;
> +               rxs->rate_idx =3D ppduinfo->mcs;

rate_idx should be assigned with ppdu_info->rate only not mcs.

>         } else {
>                 rxs->encoding =3D RX_ENC_LEGACY;
>                 sband =3D &ar->mac.sbands[rxs->band];
> --
> 2.34.1
>
>

