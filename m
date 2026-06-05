Return-Path: <linux-wireless+bounces-37444-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7uigLIUtI2r4jgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37444-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 22:11:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C7D64B1D0
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 22:11:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dnCiCPRm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QX+aRQDE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37444-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37444-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C5773024465
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8D3CF1E1;
	Fri,  5 Jun 2026 20:11:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC943932CF
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 20:11:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690305; cv=pass; b=PbnOq5uQik+NYAQzTp2uGlq7fl54H9Hzh8LiF8JhFBIJgOO4Mw9ARfNVNl53ZmifXfiDtF1yTpv3ZHWSx5GTWlwcMtgk7V4tC/Jmm3uKv/xrosxLr2IX4KMYfUse7afpOs8Uxc9eN75aSx0DCDT+Axe5xmrJCW8CItaF4kjhBcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690305; c=relaxed/simple;
	bh=Kh9FZsNcby/59vtV400yN2iN1SMfWTZreeqxFsvFzUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owEGvcfzLD+5s0pWagRY/jpO+D0o44g+HkvxNVx0chyBgjBUHo6O7elM3i9tTyLTLbzgcPoCFqEPdiaw8c6tOu0FPg9nIJnpyiByLM6kVFBa1JIdwcAdLEy9YnEEjWVcLe6V1JS8x9m0iMESracuNpMZ4Xhyik2LSlAy20o+7HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnCiCPRm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QX+aRQDE; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655HK1oH1461950
	for <linux-wireless@vger.kernel.org>; Fri, 5 Jun 2026 20:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gW4pFbmVt8/R9P9UQ8bLmaxfJ2bwhUoChxoP7lEuFgc=; b=dnCiCPRmwTDokkbG
	zSnGoxVxWGE3+ypLyU/2Bd7xk879cTXB6ebD6GRADOJXHk6eCNc+Er7sbp8HFnBl
	uZiCXDm/L94qPubt5gO79JFr1g3u9rpFkjX+DVpjhzPsyosejTb5VIlTyVIhi8aG
	0fWRlWGNGjhtGR5mXaXL1bVJ1pZ07oPe97gciNImW6IS2Ntps6xL8SpwfOba+sUW
	rpMkA6ZSSjLsAgHwRSBNl6Tx4zzEiLG+1bkiOTA2ta3+iX+4bh04/3TR2V0qbnAE
	X0gphPGYwuKFX+PQAA/zHyzaseAeTtANLPS9hK7msXQFlliDFYp1Q9k+TyPIAwuM
	D3tXaA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em2rvgtb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 20:11:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91577337648so498885685a.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 13:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780690302; cv=none;
        d=google.com; s=arc-20240605;
        b=djWvUjyTpAN0qguVG/kYup+it7f7xwL4HQeNEWr7lOAdQlsot0ep9LQIafM2ittOkz
         PpgD3Qaf02HgGYYhRkpMR3Egcl7irpEntgml6uPWr3As4R/mY4llc1L04R5Z6ap7EvHS
         uSG4KGHXATMQ9jSxbk50HOlVhBLX4wAib++oU5twzj7IkhLcIocX64+9tDURWp5/gFhn
         5zBH8ZaZqdwbelvqL9CUmbk+TH/rUfNGWeRw1vCB5LlvsqEQYiifGf/Z2VAt7NsIjtX2
         5UadPOIts99qY7nhXG+cwUfTbq6qPPAGISN60ycYB3uu8Osqnoi2pgGsJ7NSPGuKFOyI
         N5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gW4pFbmVt8/R9P9UQ8bLmaxfJ2bwhUoChxoP7lEuFgc=;
        fh=huDI2AjuDxAij2cU4RQ5DvPyXmKNcsMykgX0zSxPHrs=;
        b=iYhkz0fhK+cmPqWvcwr+TDQJj7/H6G7nMm5RXa05BxZ9jBz5lzOysyl8ns2nfPvoxe
         UTGV5/hotSaj2V7pqt/5Pa/QIqTo6BwV29aatsN+ZvjLT9K2At2jtweXhrPCsNtpg/KM
         Vz0FrWojKp8LP+243MFaEeYE0Uhwe4U1ZU0jcdPI5b3bULOZ8iFGF6lLneby3VC35UHw
         GCp5UTmlewxf7HDYc7cOglsYJ6N8W4w+QY/yHWYHltMCtA+KeNDCg6kpoBiPBcT1m+kn
         uphdnHoq8CM9NP8rm1EbF9IjgmxaudneaEfhPmiEgCL6+FnHfk3zX48P1WgJAhanJTwK
         FEqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780690302; x=1781295102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW4pFbmVt8/R9P9UQ8bLmaxfJ2bwhUoChxoP7lEuFgc=;
        b=QX+aRQDEurApkouhmpA3T4r/Ebm9uw5wITwVUx1mmGvl2+9zTxGRl3qVzh36oEj31L
         0wKAOYNvW/d7W/kXkXLfBO4kX6aoVU9PAuLFvVF+4RKjAfIIPpzIm9/tDiSohurmNpol
         7uXmNi+g59mHllWMkDmdzrOPrQLeKQGqS08VtZ4wel7d6GuVjdE5ZDXoCuzNhqVwndwk
         ePFgTl4et2AAEWA8jLHIW5R9IC29eFWeTPphYCCHih95CrPboUOhIZ6CxOToCHvip48n
         +k8g9u0by1l50Ho/jaYbN+DxONuOoLsz4Qxa6yOB2LFTmzqSToCJFFuNtEwlXkAI1Cya
         9ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690302; x=1781295102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gW4pFbmVt8/R9P9UQ8bLmaxfJ2bwhUoChxoP7lEuFgc=;
        b=Mvl/BwoLDcMW0VCjt8bWO3m0IXnU3YIx52C+sOL1dwc6jf2Au+Z7DeVP6sPxF116rE
         KhMiZntuBL71tkS6v2u7iG/+F5JJIunx0tbaZBm4bmtTsXZIaNaR00rXsn0c2Ki6iwFP
         J4OlFHSgn2Wb+2f4KMkP0AEJl5wg4Aaft07+ozIH+e0ngwFuQH9MNy2IfRt0/wxwmri1
         hjhSbY8ZIGqBmEfhdvvHfbcQW/M8WGKUlWkkucWWa/Q5gTHU2gQEtAkFuaGU8F/+h45R
         urXGnNGCuPgsJobR8ib5UoUd8tapygY7iScxl9g+Dzhcc8yFqeeoAgCAMKbkUQVTGpYf
         0b6w==
X-Forwarded-Encrypted: i=1; AFNElJ/BHgcTihtPGZnBsMtgjrFLeofqqDsroeFPHpxI6K0cV6XfvrhT+ogvzZlgoOk5+fs0KN7TJ3HIXkecpx+n0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgFmIMHyPQ6OLaQ4N3yo4VXR5nr/6MdxZtb4ZZvxzLQfkdA8q
	7G+Hoohy4f06AfdPEKDgIdC8MCBt7ZiwMFA4CfQhriX42z0MmfdFTmvajvU/VJUyCe99eUC2giK
	iziH38rDKzdMpQw8wBCA6m5WFhujcJjqLaPEGf1l5IfQXIaBaMNhXYhZJh7Z7QnBRvtFOZg88SY
	ZY9A5sA46HEI+BkdH1VPneeSkkVnGNUV2Z5CzP2v2ytjYD
X-Gm-Gg: Acq92OEEDg9mgnFtKkQIh8IeIWvk0VleYK/9t2c2eqPquAInK8rY7pZMltZNt2yGz8A
	CpSlYn8vNaa0MJdPb/yg4Eu+2POSfE/Cb4wXpIhDOd0fFomEspQRIPkw+ytLjthMQyFGzaND8zc
	5NEDeUOJseBTlsqUG2WB0p8aiOGZBJW4Izmn2abBdWjIgr/od8oFQswsIZIyVEVjtrqACspkIAS
	VBm7FaPD/buLMXRpfUFP9MrhMAJB2ungwHUCQkKU+66MisJ5kE=
X-Received: by 2002:a05:620a:3707:b0:914:bd3f:b6d0 with SMTP id af79cd13be357-915a9d761cemr958742985a.31.1780690301885;
        Fri, 05 Jun 2026 13:11:41 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:914:bd3f:b6d0 with SMTP id
 af79cd13be357-915a9d761cemr958737485a.31.1780690301373; Fri, 05 Jun 2026
 13:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421135018.352774-1-tristmd@gmail.com> <20260421135018.352774-2-tristmd@gmail.com>
 <7c01afaf-5530-4ca2-b2f3-dbe95ddfe6ee@oss.qualcomm.com>
In-Reply-To: <7c01afaf-5530-4ca2-b2f3-dbe95ddfe6ee@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 22:11:29 +0200
X-Gm-Features: AVHnY4JeTcV4Fij1zc9BVMqFzRZFbePA4SLKO3xdw1_oQ8VwNSsRSKDUSTO-72U
Message-ID: <CAFEp6-0GH2pupFR4UyR9WdrWAQjb7EnM92U1LBnBpkpv0V46+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] wifi: wcn36xx: fix heap overflow from oversized
 firmware HAL response
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Tristan Madani <tristmd@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4hK1OViJ4GqLuw0CMba9QuYGhz0wEXE2
X-Authority-Analysis: v=2.4 cv=BOGDalQG c=1 sm=1 tr=0 ts=6a232d7e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=J_-Nd1mkAAAA:8
 a=SitMJa3SxCcWHF26XRkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: 4hK1OViJ4GqLuw0CMba9QuYGhz0wEXE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE5OCBTYWx0ZWRfX/NR1QRzXfkb+
 fZVpGmX/ly3XznxSMc0CNcrRTl/aH/xntcy9hpzgpu/F2OWXJajhvfIrKoXr8P3LAPb83lZxiYa
 8N0d1lWJGmmhnpcv7lC2jGYjhZo6wz07giP4ajQXOBFuboKxTV8IjBkAbqmH91Jid7zlKf0tZNb
 IwiL5ZT2fE9WiyS9Ftf8XtuMP/qIN1IH3POmxfmjM6oT8tWIRHIO8oAAY5mVnfGU+v7mvPihe9k
 ceNev/o69a/qO/W2u0F53GmrelLLMFse/dTtE+A+bYxC7rdFAtLpOhVdqtO+IFFN4pmUn0fIZvr
 nb8Ldz5RWQlHJGYDcf4UKgjTMabO9msqBXXKM9hNRTySUPUcQHOzBrJDGaHSdXZcrrH7NLKiHgh
 bht0nrs6Scb8EDW11aljehXpEQ3BNd/dqbzIsOcOXZK0nyJ53BymDoNt5XDE8CMUHWowlkrfYbE
 pr21qzan4x6Rkbmpl1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050198
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37444-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:wcn36xx@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,lists.infradead.org,vger.kernel.org,talencesecurity.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23C7D64B1D0

Hi Jeff,

On Fri, Jun 5, 2026 at 3:43=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 4/21/2026 6:50 AM, Tristan Madani wrote:
> > From: Tristan Madani <tristan@talencesecurity.com>
> >
> > The firmware response dispatcher copies all synchronous HAL responses
> > into the 4096-byte hal_buf without validating the response length. A
> > response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
> > with firmware-controlled content.
> >
> > Add a bounds check on the response length.
> >
> > Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN=
3680 hardware")
> > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> > ---
> > Changes in v3:
> >   - Regenerated from wireless-next with proper git format-patch to
> >     produce valid index hashes (v2 had post-processed index lines).
> >
> > Changes in v2:
> >   - No code changes from v1.
> >
> >  drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wirel=
ess/ath/wcn36xx/smd.c
> > index 813553edcb789..f65328329f4f0 100644
> > --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> > +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> > @@ -3293,6 +3293,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device =
*rpdev,
> >       case WCN36XX_HAL_EXIT_IMPS_RSP:
> >       case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
> >       case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
> > +             if (len > WCN36XX_HAL_BUF_SIZE) {
> > +                     wcn36xx_warn("HAL response too large: %d\n", len)=
;
> > +                     break;
> > +             }
> >               memcpy(wcn->hal_buf, buf, len);
> >               wcn->hal_rsp_len =3D len;
> >               complete(&wcn->hal_rsp_compl);
>
> AI review points out that this logic will bypass the complete() meaning
> callers waiting for completion will be stuck (either forever or until the
> specified timeout expires). It proposes setting len =3D 0 instead of brea=
k and
> having each waiter deal with the issue that wcn->hal_rsp_len is 0.
>
> Further probing gave the observation that there is only one waiter
> wcn36xx_smd_send_and_wait() so there isn't a "wait forever" scenario.
>
> It also confirmed that setting wcn->hal_rsp_len =3D 0 would subsequently =
be
> processed by wcn36xx_smd_rsp_status_check() which would return -EIO due t=
o len
> < sizeof(header) + sizeof(status_rsp).
>
> So setting len =3D 0 and still calling complete() would avoid the timeout=
 and
> would cause -EIO vs -ETIME to be propagated.
>
> I can go either way with this since it is not expected to occur.

Thanks, the above analysis is indeed correct, but let's make it simple
and go as is, with the timeout.

Regards,
Loic

