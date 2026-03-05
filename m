Return-Path: <linux-wireless+bounces-32571-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIsMMobWqWl5GAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32571-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 20:16:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA12C217559
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 20:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E85D3009827
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028872F5A12;
	Thu,  5 Mar 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SJuY0VFU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGvjaBuP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484C2F6193
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738176; cv=pass; b=BiQ2eTb6oA7HSAxLeN0gqtgX1A6yxcEYQqoc1mk3QO3YdFGHsoOG1lV6C5CKX5JeUwIGHgoUfXt7ZENMLa8gRXGNDLGnqkHGXebdd8GErXoYBCBpAOqUMmHdHJNvaGiOdyeMlFY2BX5SiQMZXd+BLbpnS1T6hsYi7CIgZ0NKf+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738176; c=relaxed/simple;
	bh=T6mSzgIW84n78L1oui6Tey80VTrBXBQQ2EtxjS8uHis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FABNcvy2rdd0goBQeSds9Utoi5PdxXlJM/0Ku9l60ZrFntnI7X6juJxS+Jw1hrkxiijwpsHcqM3W/yvc41zC2tCxFfmXE+WuqZdntdjh/ZzTUQkhyD2WJVXG2FFRaw0TOQMrZXXrqeU9whXTPlDkkDEO5p4v9fO0UQsklCkcYTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SJuY0VFU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WGvjaBuP; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625HvaSf917147
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 19:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6mSzgIW84n78L1oui6Tey80VTrBXBQQ2EtxjS8uHis=; b=SJuY0VFUW+EYt7Di
	8sqA0lDv2LrEAMbxpn9Q2x64m6PUEoW9YgH/jXkxCbmvMnm8pD9ZLF1ryzYyvG2n
	gG+oUsXhxDePWXzGBvl4Efw6F1NotGsFqFaZUeI264z55fjF9ui187Wc2cZerpnD
	QYxrvioO9GptmIlorO9EvrTMUK1o/nfUnZ9iEKji8hJvoblzTzRKhGwWzrxmPZqP
	yri2uPt8QiFuqejiUaTufxn3u2kl64XEL36o5GBZqY9vWL+4lNF7sadkPtJ+4XMw
	jbTQCUQKdf9u1hxFsOv32LkiD8/ZfXRs8hVWGzPF2LiHdEkpfCKocmBzBsYbKz9w
	IR8i5w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380tud8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 19:16:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50620483ff6so612121441cf.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 11:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772738174; cv=none;
        d=google.com; s=arc-20240605;
        b=fu/k7VL6RHl7cuCW+2fKt8pnLdG0cuNBwzzod3bkxDm9r9MaaXQdGaDc/w1+Ukf3FP
         aggwVJG3ofvxnZkjtV4IjN8kG4V7xCP3gmzNgBWWzLbYX1bDYQPfIJ4cz6/7HwSEmPR/
         VzDVrqZP/yF6wNtTyevNGht382lL8W554olisaRDHRCVXboh9Ev6HljQXYSakjFXd87o
         thLPly4YwrsEY1WnO2w8gz+9zB4Xw7xU0JMrICo0oD1y0xpj4f9ZA4dzZydd8wmAH7JE
         CRPEDb7xMhtKkgZO10z7XHqQ1r8slp+Ch3fwlNXeow7nWTKDgAjNF/hyNIJd4+yVCwlS
         5XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6mSzgIW84n78L1oui6Tey80VTrBXBQQ2EtxjS8uHis=;
        fh=yuyL6yJoWdPmgGI4PTkAKu4M9ZJ9MtV6FnMw6zXtQ0w=;
        b=a2fWTbSqwLMU77UXL6KRlk87Hqy4w24UBPEN6ocGwDwL6DyiwYJ5ECA54/vmEHrQGA
         kxqFX5iCw7qPKFCp0JAxprQbK1gfp/ZHpLFxLhcOHkbF+4EW4kWSTCI8tOcrqS++EvJn
         ij7Y+dxHYWtSXL83rkYL0k27etA3rT+scQqos7m99O1hgWFuaCwuFlCgZlx72VOgrKaz
         dga1PClCw7cnSAaRLqL/4G6bcuFNWJuLaGs2MkUASlvzrnnFqav2WiUSX/frHS8uIXUx
         dA1P72ZfsETQywskgb9pNomoCYKL7uIZPa4gL599qxJ2DEO1ZkBi8OszXDEeHWQKrb4d
         ECrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772738174; x=1773342974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6mSzgIW84n78L1oui6Tey80VTrBXBQQ2EtxjS8uHis=;
        b=WGvjaBuPlZgy4w2ShPaT3kGymear6CqE7+nuTbltWd36jVgl2JhLEZUAbBID8AWbRX
         +NXDP2xN6NcAHHqiLGNsPOZ2LGFjmP/38FexB0XW87PgusqAir+vKfL/XCoMJ+9XjdUx
         2Ghbp7H/pGh+x2Vq0AISrCE6bmi4uiRhMLn2W3VWchQkKWMGFtt37x5tuIfRuGEB7uP3
         AuCqPoac3Anut9ny8wtmDispyGjySo3+oajeJmsnOI968Usvimd1He9jVlgvKc4G+oun
         i6WsBTjiON9/HsrsuesX3SZKMx4ow1QhcAy6aAeVNOiu3sUPOYguEYT3XtNR/wNI3fJ5
         Lokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738174; x=1773342974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6mSzgIW84n78L1oui6Tey80VTrBXBQQ2EtxjS8uHis=;
        b=sRAmoWmFvvmNS+nMuIh/um/lIU1XnB4Aaq2UKgbwB/+AFvVKz8+exghElsMuBk37xL
         MVkYkNwqBRQUgKo4qERukxX+Ccn07bDnItugAJxfEVxuTQYxEDE5/ORWGUwL6KS02A7N
         f7iNblXAu9Z3BwyQ5js1uAkic7duy3BzkVv81fcZ0Cdnj1IDDY4eagi7Uaj8GHVOcOzl
         196QtIjnzFBC20gMXAn2hreo1Rvtqwas3OUGGjc1zDimppEJG3+KCUscE139YpRKMW9b
         dnmFR1mxQtwR3L6jqXo91zA/vICMvAU3ircD6TzmCP2XY7Wm28nmzmmohmhQ12znS60u
         DzlA==
X-Forwarded-Encrypted: i=1; AJvYcCWyoJkmbnH9Wun/KT9U4uorMHcqLJylx2vbfSQsfBTm+Xxt4y3kidUq37RRnZ5yXw3q0oCLoBWGkc7XXWGu3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ01EwHtez7ilZD1etTcJPTnYK1ZinBI8pmkPwD8W1FWHi/p/+
	oAgYzlCYXp2yKZa+CIgiD1Lko9E8pBoAfTnoj9ftKXbPQkCahNVShAZZoqfspCPkLr0hZqbMMF7
	kidWPZ77WAq8DF09CO/pvghh3+7LNmL67UPcEVM0t+rfEFA5e2c0SnqFbgm7oifXUdyESHG6VeN
	6Yxj7OBUjDrOzXxvjHn0eOGuMMbJ1Z2tetXC2tPiqyNucv
X-Gm-Gg: ATEYQzwRy57CySMT1ZuZc7nXZAFbaXMViY0rM3f5dahrg+BUVBkewlQ2/EsrX3kzq2z
	NsM22vPY7v+UkWW1QuyDP1sn9HdKzkU3ajc1PVrFaj6dQ4lskcLmqmRphtSke63GBnb/rORX+Co
	sO7WVoHE/tITdE/8vU1C03nrzLr+l8PoovZlwoGgOgGY/pXCrhxKAL6/Ar2Q0mf6bqTrisiacfk
	ZedeiEh8Q4MipJ7bVNON9QCOXlxcoRhvJUH3AH/wXzzw3caZtmKDuLd61SPBgQmtAwj
X-Received: by 2002:a05:622a:1914:b0:4ed:6e70:1ac4 with SMTP id d75a77b69052e-508db35a31amr82530391cf.42.1772738173763;
        Thu, 05 Mar 2026 11:16:13 -0800 (PST)
X-Received: by 2002:a05:622a:1914:b0:4ed:6e70:1ac4 with SMTP id
 d75a77b69052e-508db35a31amr82530021cf.42.1772738173307; Thu, 05 Mar 2026
 11:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305003253.1022386-1-kerigancreighton@gmail.com>
 <20260305003253.1022386-4-kerigancreighton@gmail.com> <dea45e4e-aebc-46e4-a245-3603da1779f3@oss.qualcomm.com>
 <CAN6+ztxfcNR8xR1qwgHQcHHM=zoQbMd-8oggb785ssPZ7f=y4w@mail.gmail.com>
In-Reply-To: <CAN6+ztxfcNR8xR1qwgHQcHHM=zoQbMd-8oggb785ssPZ7f=y4w@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 20:16:02 +0100
X-Gm-Features: AaiRm522mri_3_E_tLhvFR2PzRjD2c5pLyo0FI7lB2vgbC2_G-1Iu1ExQrqtndw
Message-ID: <CAFEp6-3JVicAVJB_+5ceSar2Jqstexo-0tyemg3C=qcznQsmxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] wifi: wcn36xx: add support for WCN3610
To: Kerigan Creighton <kerigancreighton@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        andersson@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9d67e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=29fU08-qhLxzT5EMGmQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: HpLIdK07af3SH-0VdV8MuMtwt09NPUph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE2MCBTYWx0ZWRfX4iI8o0jw8TzK
 Hv4A54qDoGQh1l+Hkm0BhrX3ysAz0F0iGNsVw3lnK6hs0/8J2/vFRgxHxFXpI9QTSbLHRsSZzZb
 VKQ3x9lYqIzu99T4Y1HskDgRoh1WB1mBx9FUtv2tWIrmmC1iwWNCXT3+hF8R0S42nl2hTXOyPzt
 hG9K1oRsou4RaWM9PQ4WESSjmahXwqaWqnf09FydPWFySDEwKnEHBiIEtn4wqZaHLo+VHY5EW1R
 LVG53f1qTYo7rGSmA44hkRe+c/hfuvRF6of+prMu+DSE5VCN9iERaJZs2ir0PTSuI9jv/oyLiJ2
 umdAQ095U53bbYO0uEAdr7Ut/FR5PousMc3MPQSqZGiPFkn3rBIZDcpCuV/qJGJ2VMslqPrh2RI
 9olU8ODjk+rxDWyhL3/A8uHKDoDHMmhjRaq3xEEnC2v7Nqw/p7vQruUDJmyNCgh5yfaHrDwfhXg
 7hdGH/78KC+UTFgm1xw==
X-Proofpoint-GUID: HpLIdK07af3SH-0VdV8MuMtwt09NPUph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050160
X-Rspamd-Queue-Id: CA12C217559
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32571-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 4:51=E2=80=AFPM Kerigan Creighton
<kerigancreighton@gmail.com> wrote:
>
> [resending to the correct people]
>
> Some of it is observed behavior, some of it came from seeing what
> the downstream prima driver does.
>
> With the default configuration the WCN3610 shows extremely high
> packet loss (~95%). Setting ENABLE_DYNAMIC_RA_START_RATE=3D0
> (as done in the downstream prima driver) improves this significantly to
> around 5% packet loss.
>
> Further experimentation showed that configuring
> BTC_EXECUTION_MODE=3D2 eliminates the remaining packet loss.
> With the firmware default (BTC_EXECUTION_MODE=3D0) the chip emits
> BTC-related SMD events that the wcn36xx driver does not currently handle.
>
> BTC_EXECUTION_MODE=3D2 forces PTA_ONLY coexistence which avoids
> those events and results in stable operation. The downside is that this m=
ay
> increase power consumption because PA remains active.

Could you please add these details to the commit message?

Regards,
Loic

