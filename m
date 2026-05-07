Return-Path: <linux-wireless+bounces-36096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJndGMEF/WnkWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:36:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA54EF5F2
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1E7302351E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788C1C6FF5;
	Thu,  7 May 2026 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofW0vVHr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bmEVI/Xs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737C2F8EBE
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189753; cv=pass; b=fnUe6KzaTx8P4pQqHoGr8fxWWraRkli7dUzEqMyFyk3muMa8227OZFgsc5ZN5GgcADvjVUJnQHPp+4QLXgvnZECJK6/RUbfoNrP4bHijmKoHFPnWJilk5yftSr+C93JtwfWXMOp8zCXYw6VAT7pnKqHyYgT4SYu35wE7qEQcVto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189753; c=relaxed/simple;
	bh=Xn03YFbdSXbnXTZO6Byci8kbji09aCTI8YOvizqWSNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiEf/hWkDk7ov2fYLAoDmQFwNPJoZb/PEP0DZpOuExDGTvmXPaskylioWHrNLaWmg/RPK1jU85GGr7IId8fhIGoaqdXMNCpxpXCZJ1r9WVgUVFiQBnQTB9hwCfd6HXYxFZfgKXNyMDw43sA3z5v2hcx9wToc4UCOTUOcxTYfLr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofW0vVHr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bmEVI/Xs; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647IFHEo3157738
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 21:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W8C7xCnoB+blEIj15VTjx8Xuem7fYozPHZZItIm5jhs=; b=ofW0vVHrp31lcP+B
	vlmPf0sADfnN5XrymJ6Yo56FLlyd/6Veviy3En/6MtxT18WiKJyYa3DcGiQrCDAz
	mYxkRcixIMLQ+7mww8iCQFCDbynIXMu1VdpZBEkh1fhw7Bac/Qu3/bHnoafyuCHC
	E8lY22W+HUoySxOmqfM3rnOFDDMFx10YlVG92P+SoyjeASebl6lUYwaTql548Qjx
	khbRKvuruBBdvgMBGJywMcxu4XDoi6EUuSKu2tTekRIyX7NNeKg0vke43vNvON0z
	FcKrSFKVMtp1CGJyiZLQwSczys++NEwpa9sA2tp+ZPvkQtocEXkZASd3rbP36FQJ
	teP3dA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhf3p0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 21:35:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e136aff17so23147941cf.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 14:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778189751; cv=none;
        d=google.com; s=arc-20240605;
        b=FfFkb0Pei1luB4/G4RT9A1A5AwBzSIHreypMo+b/CFh9XcgPmWrrTzExfSP/Tpja+H
         m7MKFcBwGnDS7jIqKzF6AdP69Cye/xA5QWrDV6ZNrUq0SSDbyKlICO2byJ5ItwrQsBpk
         ufVowasNtWxLCXiTTPaVhTK1hW89VerZLT3dT0JJ+GOanZ6N0NrDZ+GR2Oe4wSMZG3no
         fmXulULxo99taPSAsHaBYavykUxcHAKWPkIurRH3w2GWIp3ave8ELnjCuky/UHmGHYYZ
         ZXxLYQMigW7cqLMov0sroYCl/UI/0LCarZ3k/LHRVXjTV06+/3CLBSxkeLITxEPtRj+D
         ByaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W8C7xCnoB+blEIj15VTjx8Xuem7fYozPHZZItIm5jhs=;
        fh=vkwlqpvknNOrSrb4yosLF9EJJGn6KTlOI08CgNBcDkg=;
        b=GbjZLLY4ZoIjj+8SAtiB077EKnhb3aRfNc7AAxO+RrhvHpUyg5NxOHZl5Iw1WpkEak
         +pimRuXDAjSuuP6wTkWPYoPddnZLwDsdIGJUXJlMjIdFtviLhKo8Zjf7DyRLeGlgrvD+
         l3XsVk/LrzOUhypsu7ahtGclW1BUKZwZfpfFEj9Usv/vZKQ7/iYWhUttzlt6elclkyvm
         /VXbn8xi6kkK5jBN6NXjdOu7V09AEYWE01d1GqrdUi0HiUG/qQU59HSDjdbU5Ppux76V
         kL+Fcp+LQBcC9YMK4TvxKIAEI9o8rTgbfSG8yc8kv/Abvbuwpvqf08+zS4m5YQXN0pyV
         4i5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778189751; x=1778794551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8C7xCnoB+blEIj15VTjx8Xuem7fYozPHZZItIm5jhs=;
        b=bmEVI/XsKm7ZAjXWwKKiDn97jEApQMhbBfLbSQWE1g62zWIwYAH10ummRb8lxyPC58
         BAdIjr4xAZwgfoxE67Y/rTlAl4d0nePG6Fp6I5i3Vpa04S+VA+zNTnO3K9e78E7vPD0u
         U023qWvIz6Ms0vV9DUWrToBNokbz4fa5pgBdddMbPsxtqPqZgleQPSouonk+kNLhC84f
         U8dE/s6DYm2KTyj0ekDZorGhQ3ATpbzdsluPelTxTyMxwEnYySzykiy+ONg75ZUZ5Qed
         b/MSDB4+RdImEbL/2s0P27pB6vWmDkKdMtAMVvk8tGMeQF2q3PTRn8gw7yj3JXUk1DyK
         s2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778189751; x=1778794551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8C7xCnoB+blEIj15VTjx8Xuem7fYozPHZZItIm5jhs=;
        b=Tg6NvtiKtFFrNhtdf644+7i7mNrz1H6/TnTOJqkwH84Zo37ntOtnaQmAalvoMb/TRw
         tnbBDRl5EZ+ff1WKwkG2Kdvj1X0ILtrU7IGpOshe7bUAosY8egwAArvpRs3q26Z963VN
         nvBODWbw5tQtdLsYDHwp7FYu/v2Byeo3LGi9J1GKVimt0KrmJcxOFm7TNIBzUEOTx8PA
         XhpI4lze9mBZ43rkpHST3WMm6WPdfIQ/fX5bWczbkADBxexvp69WGSUZqRIstqpiwFaD
         CfEKdb064H32eefehQ76uhHGEh8UuOnvLEULH7KTKCZfx4/qGrthqgCukEA5lNcvoDmQ
         RAcA==
X-Forwarded-Encrypted: i=1; AFNElJ8hpaNV/BmVuw9xfnPeMpGBjoQWaeHYORAJT0KXthRd7/AEX4f056HFBmoE0jt/Ug56DD21grsFtsY1GDsKVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+/N8P8jin7RkntoebD06Jt2GGwu3m+ZuBkt2Yh5dbL38iUtG
	N+40O1lGMOi71WNNcJI9HmYKvDZH/vq4CYKva8aF1vhj/moxIkzik4zy/uhvpeaZBRKJXHQ4552
	Tgg9U4kNLG+7qTozsPoIrdD6TCSrRq1Kb3niGzQdpnIM65LX7N4cd6EJKHzkgiKSr4Cm1CkOHjE
	NH+TD6iQTZMUPoOtlvZoC8yqK1ycBMBHRU5d7wgDse9Mjc
X-Gm-Gg: AeBDiessr9goF3y0dnMOHtFP+CcRx1L2ahk4136zcWD04JvNdzMt0IHN0s8QFDWdsE4
	ctcMT/s1RUNyZM3DqCM1QR/DEPeQVP99lN/M3CxPMIPysVrNxAFOLObxYrFARS7rugcvNFtz4oq
	+fAA5fWsec1BE+9KEwLdnoraOv8YNRut5mSKKAncsHNBMxbvHgFwSoQVVr7aK6aNSRjnUV02XB+
	A0UKW0/trZk2Axw062OlYYDO+5beHM6KGToBqZ2
X-Received: by 2002:a05:622a:620a:b0:50f:c15d:3f65 with SMTP id d75a77b69052e-514619dde33mr143848851cf.1.1778189750546;
        Thu, 07 May 2026 14:35:50 -0700 (PDT)
X-Received: by 2002:a05:622a:620a:b0:50f:c15d:3f65 with SMTP id
 d75a77b69052e-514619dde33mr143848441cf.1.1778189750134; Thu, 07 May 2026
 14:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421135018.352774-1-tristmd@gmail.com> <20260421135018.352774-4-tristmd@gmail.com>
In-Reply-To: <20260421135018.352774-4-tristmd@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 7 May 2026 23:35:38 +0200
X-Gm-Features: AVHnY4KswJLlBw7jzdNlyXYENYfRnRaMt6wOJlOZt0D3Bxlfri0yqcvtRiEvi1w
Message-ID: <CAFEp6-16eHJL2u-UdQGV2kPp43AUCVXhCdBSs2XY1QL4ZoSACw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] wifi: wcn36xx: fix OOB read from short trigger BA
 firmware response
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIxOSBTYWx0ZWRfX9v5woWtRPIGb
 T2C89kC/WS4tSgsg3IhsyVmwz+JhF2upv1VtvP8F+0i55EDuh78glMVtUaBMLXv+0Bc/nI76s3o
 YDuTKSRgiCBm3O1y7MtNMi1zO4fPLGddOklWqZ1JdYpKJCQnupVKZy4/tLwih6QLkBApI28cyLt
 UopxgbueOuDoE7+w5hcTaqRmQeiXF0djei6p0Sbh8x1KoRQAgFXZc8L9CWDZDX3IjlAygyVUvOI
 vi9kiYaiviq3cdx3N2O3V4b4q1UM1PJ09JQz3bFLMrvO7n50QuRZyLRPWWGjunvxs47uOGpq/v5
 0Z7RxYh/kzf5R+t/a7i/H6uNJQAnIARfIECB1F5/trJGWLmRsxRKo1ecfDX/vETV8dO4DplOyYm
 DJoAw/6dSM6Obsm2dBkIgu6g3YuUjvedRhFd7QKPMKi4AxqpvGZd8AYDWJyz4FEV4egRVzmtswm
 2w+ATNeC051zGqozEnw==
X-Proofpoint-ORIG-GUID: 1Sdw0RvhJDbF6UZiDTXfrcmLIvICNs2A
X-Authority-Analysis: v=2.4 cv=SuagLvO0 c=1 sm=1 tr=0 ts=69fd05b7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8
 a=zoG6pt3vYd9LuZ-_mncA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: 1Sdw0RvhJDbF6UZiDTXfrcmLIvICNs2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070219
X-Rspamd-Queue-Id: BBEA54EF5F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36096-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware response length is only checked against sizeof(*rsp) (20
> bytes), but when candidate_cnt >=3D 1, a 22-byte candidate struct is read
> at buf + 20 without verifying the response contains it. This causes an
> out-of-bounds read of stale heap data, corrupting the BA session state.
>
> Add validation that the response includes the candidate data.
>
> Fixes: 16be1ac55944 ("wcn36xx: Parse trigger_ba response properly")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
>
> Changes in v2:
>   - No code changes from v1.
>
>  drivers/net/wireless/ath/wcn36xx/smd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireles=
s/ath/wcn36xx/smd.c
> index 2a0c946d81095..c0b477345832b 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -2599,6 +2599,9 @@ static int wcn36xx_smd_trigger_ba_rsp(void *buf, in=
t len, struct add_ba_info *ba
>         if (rsp->candidate_cnt < 1)
>                 return rsp->status ? rsp->status : -EINVAL;
>
> +       if (len < sizeof(*rsp) + sizeof(*candidate))
> +               return -EINVAL;
> +
>         candidate =3D (struct wcn36xx_hal_trigger_ba_rsp_candidate *)(buf=
 + sizeof(*rsp));
>
>         for (i =3D 0; i < STACFG_MAX_TC; i++) {
> --
> 2.47.3
>

