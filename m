Return-Path: <linux-wireless+bounces-36094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DOBDLwE/WnkWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:31:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D4F4EF502
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41175307DFF6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A82344DB9;
	Thu,  7 May 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXJax2CO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dyW7+3Sg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E3344DB5
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189357; cv=pass; b=prWE39akVlwftzysrIBSTL/RqDH939fUKNwlHOsKPyFBSuFARF6Ivys2tjMA8VtcN50MGwYUn8s8zVZnFT/tD2lNDKBdy109SuoDo/gXQ+TwByDBtjZGIlNNAqXzCH+dp2wpsMlImQhW/0dPig4EsYjMDrNUt7/cUgLZ6oYcLG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189357; c=relaxed/simple;
	bh=gzwIzgBhKK+YDU/+3DXeILI1D6/3UzZ2KYoSzuWVe/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCu7cd9TYYd+UZxMLkZcSRwHAgUFSPyRQSRxci4vKM3mOXPLpsKMDAe2r2USTS7liAl8Fu0d80MLjMxRhVnOs+/THF8Djo1ZDPG2znmOSFldGt9OAv+VQa/aY95CLk7iFlF1WxFlAumy8RqA4YR/rE8PRDyXYwZt/NOs3CHkbb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXJax2CO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dyW7+3Sg; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647HVC431971666
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 21:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DB2gJVEwLFvzzeNWS+F3DBNgxOzTFPLvx6r6MOGnYWM=; b=WXJax2COiafQWb4V
	YrDgC4q+Vl7uwGNHM1S31g5lvvy5F5b+ewCaa7VBSHtMU8I/gfFA7irpLgmahfKq
	FJ0hCWzk+w01e9rUonivoPG5g4MjnzFVZT52qMXkUipufnKBQrm2j6YHvldJksbQ
	HqX9YINr66DGAGULUkmiSD3yQgGl2J1jjLCWfMW0uyxAZCewSjlRF/RRx9mx+N7W
	9HmtKbgz50qqcNMNX1HPFKd/Z8voWgnCcGluiFXxeyQC8wiBUoxV+Bnx5gwo2Qtb
	QBluZagPLJtjZvFqMhgNu2fDriH3eLsWqAO976tG6KUAEQEPY0qN4C8qt6Fxi9GV
	7lWN/A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0teja5sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 21:29:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b49260e3d5so45162816d6.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 14:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778189354; cv=none;
        d=google.com; s=arc-20240605;
        b=OCV1jlGgXgYVXXwQ75bV/NqrTrdvGWJjQRErlqG4OUzjld8yQa4gmKFgu9rrr/jOpa
         YdozCAc6yv+nyw+PWxa1T8zwefX+PuG4IEcUOOl3YBZ2ZpuY0ki8qooc2H3/RJiLhczV
         tbxTN41N38Tp8LL/SqlAYDuycC6+OyaDGAYTzA6PvFNdxf4MysivVjObZOEYwoqCKlS4
         DoRXTMWH2iwGVFQT5i4M/A4E6X2OSOY+ZtOEPhGoPQc62gOk3X7CtqXezYkz51THsz7+
         AsekDdT+Dp8IQageWZ3IQ3G1WzUnWZKDZ8kk8H4XNpx5v89xwrYA/JLW9xtuPLif1V4g
         b2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DB2gJVEwLFvzzeNWS+F3DBNgxOzTFPLvx6r6MOGnYWM=;
        fh=0Pufqq1nQlgFtN0qrUY4JBqUAX4nLD1CGn1PDB3DCFY=;
        b=RidjF3qC+cwJjEKDMSDwU0uJlwRX736MoK4Uu3J/YlYeh+HeXBkvRtDFPWdBk4AkBA
         UJvdPiJMasU35b+hYk8iEFJ+eOpE78iIigN6Z9McO2CGKVO8RP4pXaMbGBnCRnq21Sow
         R9b9ryhAXnApc2HGH676RxhxIUpyPrm8uDzqwvAYj/nZDcyZKsLnYRGkO+BW46OhIOJj
         08Q0RsVf0UF1NMznB7nRex63LvgdT1KO49gUQ2A3pUFjnfjPwc754LAEGLm4f6XigB7q
         xBLRNZG9wSwWN9ZQqiLhIIOCEXPJUTS33TraqXgcw0QhAF+s4dv6lHrVNoWJcCwkxpEC
         aB/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778189354; x=1778794154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB2gJVEwLFvzzeNWS+F3DBNgxOzTFPLvx6r6MOGnYWM=;
        b=dyW7+3Sg8sLJx1pSrrCMudt1Qff4Tt9hK5frH8hSMDSbFaYXWpp9a4zwbj6EXmjUD3
         rb70gOokNnObStHZwrDvyXRZHhZ2UYVj9Bph0yvuZejXUNGK+HtUUE+66CCyDJ1VO4ML
         lY0nKLW8ZJW9ZciON+P4uuppsStUjEZJNp6+MqHvFbF4K9JAfC/rwF7G6sArigyZ/8XC
         rO3+WSMu8nKb5Wpx1LH08ax9XhUNvo0A6qKHGAyaSd0H3E3bSWwgs7Am8fAV/ZlqCBSJ
         rlGl2/zYNpAOa6T801esK599IQXnv2gVkdTWpnn+MpqHJPfh7QY0ibX8QH+7khHOj8GU
         r6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778189354; x=1778794154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DB2gJVEwLFvzzeNWS+F3DBNgxOzTFPLvx6r6MOGnYWM=;
        b=hoA0oqZs8Fpj+YDTHHXauVy2jb8zngHjmfp28aCVrXxycBjr7CuVON5gHZuKnnAi3y
         Al95c25Ka/yg2Uj51HBkGSx49e3kL0uvxrBPkf2iLcOlO69KwpUFAjEA0LpW6jIhXZdz
         +Z18Bir2Uo3EF7wwHJNLx/2fN0RmKlehlWRrME85YOOmOyhy1IuxmDmNRMRyj0l8QYVA
         z6b8GpwAK5NsSoba51iT4Y4X8n60U5UHfYjIbLfRbfeMxc7gr9Hp1/H8Ik88gFRN7vNm
         q/60/FpC9P1pwU4jjOIXotLhCJJo8WT737kVp3i18CEaZbhTIirUD1HIbitnhKmNg4ZZ
         gN8w==
X-Forwarded-Encrypted: i=1; AFNElJ/PgcZZe8LyHN99k43K+I/Yd2OuVt4yeGlm7fmZ75EF37FankqbHt9XQ1ICsSK3mY0bfvBdlGac37epPveh3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgbtlxnVuivj4c5oUWFvjLJq/UkuPIIHgeku2Ar088zmy8VI2
	xFWl6qy8IqUl9XLctUc2NRI4CbL0FpqYe50Ma+rtDcuzVJzjSPmwv2iyCdewaHGmDqtWGl1Ts5J
	w1RJCrn09iCQjPIGc5VZB8rQeWXRGLnQ0VX2zaNMLg/ZCTcfLWc7nQFlvPgKn7A+cKpReE8KMPw
	wu51Vrz7Mr3HdlFsVuKWfozH+hhDOt22twB4jW419H/poN
X-Gm-Gg: Acq92OHnvkjH6yLu/tLnLAKsVy3P1uXLtwYoh6cn+NNW7BeDfSOAaGSG9dWNejXxRHv
	Do4FfUepwv4vLjLNo+tREGEvMwWcyhXOXe5sEPs1yF2o3FHZNLMIa9tLNV6hLZXb12LOxDuFSUz
	MNbqNuHH0uE9U9F2YwIZeHg7WYmw4w5JEBrEGXW85dS73Kp++6oNEjkwG9WV9HOEmXd0283hw5G
	2L9zIPQ7RZP6inga1O4ig6wqOv8rzhq00nlzrBm
X-Received: by 2002:a05:6214:4699:b0:8ae:67b2:89ed with SMTP id 6a1803df08f44-8bc422a67ffmr146398716d6.7.1778189354410;
        Thu, 07 May 2026 14:29:14 -0700 (PDT)
X-Received: by 2002:a05:6214:4699:b0:8ae:67b2:89ed with SMTP id
 6a1803df08f44-8bc422a67ffmr146398216d6.7.1778189353934; Thu, 07 May 2026
 14:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421135018.352774-1-tristmd@gmail.com> <20260421135018.352774-2-tristmd@gmail.com>
In-Reply-To: <20260421135018.352774-2-tristmd@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 7 May 2026 23:29:01 +0200
X-Gm-Features: AVHnY4LtPXTkgRdWpxAMO7XNV-SEalNkLDgA-v8bYbQXnHdpWdtGIBvU_MA7_ak
Message-ID: <CAFEp6-34XV7yfjNVgkCWKBtbS-7MMJX14GBrZhLXmfNtPxXVYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] wifi: wcn36xx: fix heap overflow from oversized
 firmware HAL response
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIxNyBTYWx0ZWRfXztwxW5DS2qNC
 ED20AYZZBxRD6SJBCOCj+CWLMWDI0gzJmZgHUahUtZZjOn+USqL/+XQAwGFUYfpla4w9xhG+vme
 Xv5u5244eLtmVQwX76Yr/3GTXZvUIVkTC6POIYajLcvgb0jDRvRkDz67/VPbSiZ701v44MgDzKF
 cFmNqqoMRtgJ6E4ajOjsSBY1kbutQ1tjFFQY1Io+5UE9U76t5s7EECc+vWp16V3/sE+Aw2/OOYM
 8V8ps0WaPN7c8gOXNzuMG+BRwkK7PFFFyI6UNmvcr86H8g+ilIMIRuSDnslUQwOIfAlCIbzzDle
 AxJg8FIDBB7tnYMelwpPXMshPw1Kj3g/uHFPx8nBeQtv4iH5YIdv1wdqOPPZ/eMNSyD6NP+iw+O
 mre6KzMj01TgoFi6yWQcEUWPQC+7t9fcGv0ANRHL1uU7CXuMugaZ+CCQiD9w7rIP/Gj/Hz6BcN0
 WqRZ3vCxXjOW3XIDzPA==
X-Proofpoint-GUID: bzQoZO0jAfQ0lJAhN3Q3oAZvukOtmQvR
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fd042b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8
 a=zoG6pt3vYd9LuZ-_mncA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: bzQoZO0jAfQ0lJAhN3Q3oAZvukOtmQvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070217
X-Rspamd-Queue-Id: 80D4F4EF502
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36094-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email,qualcomm.com:dkim,talencesecurity.com:email,oss.qualcomm.com:dkim]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware response dispatcher copies all synchronous HAL responses
> into the 4096-byte hal_buf without validating the response length. A
> response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
> with firmware-controlled content.
>
> Add a bounds check on the response length.
>
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN36=
80 hardware")
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
>  drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireles=
s/ath/wcn36xx/smd.c
> index 813553edcb789..f65328329f4f0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -3293,6 +3293,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *r=
pdev,
>         case WCN36XX_HAL_EXIT_IMPS_RSP:
>         case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
>         case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
> +               if (len > WCN36XX_HAL_BUF_SIZE) {
> +                       wcn36xx_warn("HAL response too large: %d\n", len)=
;
> +                       break;
> +               }
>                 memcpy(wcn->hal_buf, buf, len);
>                 wcn->hal_rsp_len =3D len;
>                 complete(&wcn->hal_rsp_compl);
> --
> 2.47.3
>

