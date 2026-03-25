Return-Path: <linux-wireless+bounces-33822-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF1TLM2fw2nGsAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33822-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:41:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76F321864
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A53CF300693B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4021313E3F;
	Wed, 25 Mar 2026 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0bbIL/u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eM5BF5Vb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF83451AB
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428102; cv=pass; b=kAFoGhx0NbWCI4FlFK617onsmk1vLi3yRBqZhpuiUrqXtwcvdcSnNyB7yNeqtgEXhVNgIuVAQmjsqp7/6Cshmlu0rE7yt6v2VCwIZYGZaiVgcnimc2kQgogtcJc5y8t77o7x9k4+Hg+rJ0p9JahLXgFb0mJ0Tem23BevSAiZ1sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428102; c=relaxed/simple;
	bh=NLP9hzE4XkomrhxX+oPsTQWcg5YjmigBke85hB6mMkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/JoDEwx+KjU7PHa8ovNdmReGMi3r6bZ1yvs9usZBRlShHq0t6UEmM6DWUfMi9QtQM6JLvEB+pKe0sD9kmUJmTFRFUhaMiyB1EFSWZfDhes+O5OVF7IqJPczLosRLMQ/Cj5cEUgnNbaMyGmEiuHil2S5+nKsapOt5OCCV5NvvYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0bbIL/u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eM5BF5Vb; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3xGAq919620
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 08:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T1zjHPQ5lI8PVuba+qVukuxWu4EsG3GpdABCtQnUozU=; b=B0bbIL/unu+PNduN
	ad8zuWeNp8wjkCCTiuG0L53hsS1wCtBuCqNJhIsyA1eoJvgJBmnBv6T0WjWsL/Vs
	eRwgIBr/8T2mfIO8ncAS9pI262Z1O6TGatTdJ6VH2vp/q/JlWiz0wdwZOzUCMK2C
	uSP+dlNoXKLMg4ZaVgflMf5LwKFAXAytnzHzmXmHUfwFix9LXa9gMsIUnvUOb6Oz
	RRYNQ3ifQatwSHyXdhOX9hbH+sTSE+66c1fMlEHqsofeE4pGkm7fT25dCVQc4YYq
	8q9GzPsq2HMkoriCmH2nbVMqlhhTAgLxRFHA5JLu7zvwZjZ/VXujxKIPg6qpZTK7
	P3DsXA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489mgxfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 08:41:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89c56300e64so129532706d6.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 01:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774428100; cv=none;
        d=google.com; s=arc-20240605;
        b=WbQ5p/DzEgtJ4K4eK0RPWzSCmwcBhd0N+EIuVzo9fp80H1ZaLMu3Dtb3bzWS6aSant
         l5eQbxmC+pcZd/Kkg0bev8j9RACXraCkczrGshJsgYkIpxCeEIrkQRrYALGclsuynGcL
         w3dZrQTw7IkqUg7tnIVyk1jsWy3QxKTt20Cm+E9rRWZn8KjEaWO6IQvGe1uBbICVk2I3
         r9wMGq4JhLQgEFEJvXvcmdYJBWNaWA5ibTFnZ33ccOmkDJT6crQIvGxWnK7XzKXKNTfQ
         NecbtdxX9UTtTy8UApOX2l/Xai6zFYwvTZPynNnSIbPWEwIgjw5kbJ4Owgj1vx7JXoqn
         m2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T1zjHPQ5lI8PVuba+qVukuxWu4EsG3GpdABCtQnUozU=;
        fh=HGqLKM4vPS3FHRCxG1BCRRBELg56zc0CHmwSFxfw/4s=;
        b=RVQaxrRHv2KmHDHDmCMx0J6dZ4azlIzFV7BdidIS2B/SJTmILtPicnnoOaga1vVmAV
         svWL27FDJ/mhBSjDQnC+RtOeu5krSk7qnvVLmoQIylFsH0VV1WpP+WOq79sSF8kM7KHq
         3VJskRHIaYe8wceFnm53JO40/WTDkWujFMxFt+2+bQ5MPdAYn2dpl9981s9E094p0nlr
         BZx6O58AI2KB4iA88VY1/kRgpG5MJHxYgsb2gyfzhmoKP433UD0TbA8EnRHv7gpeRVeq
         OAdaU/BdfHijpdPUOc5ysFMhPu11PFX9xlFZSO6HSrG4Run4OeQe7G9NifWg9UXZSIAS
         sqcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774428100; x=1775032900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1zjHPQ5lI8PVuba+qVukuxWu4EsG3GpdABCtQnUozU=;
        b=eM5BF5VbhoB18Uuc7xuty5zkjBC9PnU5OQaYxrj5/NQ6slVNuEnXMyV0tQ2BRK6qZA
         HHvuR773EjIQvh6YUF6XUt6I2+9Vt7NIdfagTi3C3ILAk2Rv8J0daCos7YTpnQ8ATRjN
         TxDpfJZ3wXXfA67KliztZnmQ6aWo3xuNLXDCaX8udA8by6F+xONNmvnjZT2EhJ4BCU0X
         d1fnuhbrXFYPt5zZaQjAKCI8CgEL6f5D0zKN0ycdEGpVkHBH9hc1Wqzy53CgSg44UbiR
         XCeCMQGXRDj7RmxPcBsL12SyjZCdc+R8pS7Wfap2dWj7pcMSmKjPB7vLc+XQoqlHksl6
         BQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774428100; x=1775032900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1zjHPQ5lI8PVuba+qVukuxWu4EsG3GpdABCtQnUozU=;
        b=Yne+919l5PRx+Gaci4v45wJwUNHHbY1A7zesHbLIz08fkQkDvrRUyLFR+Sbv+4fWcY
         MKc1NhJW3v/dwayEQ+GC5zCv2QTYeMY4rPY2Rgq7Ko16qs3e5qZ+f03wCMtbaM40BZiv
         I8k7YH3ci7qcFfv9iLPDwnVNEzBmtik9iaYSU7Y2wNiwtiVUY1JH1QFLkp1cpgBz3f6P
         A84ncN8amOlitBdj6K2YAfRGoX45Cpp1sI71gmO3wkXTLl4sa5wn31hOyoacdb7US/z8
         e9hLvSH0/zM9yK6dl8yBuXR05q4ARcsywicD9daaYlNzzwX9PnGxJdhCZdNc3RpSDTx2
         Xmuw==
X-Forwarded-Encrypted: i=1; AJvYcCXc/kX0zraE3i6JvY520usQ9NXMGXetq/MG6A2zwD/3Adnn3omD+RImGCzr/pqSM7ExFkjOPqnNvk3mPb9RnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLL6jMlHNC3f5GEEEH+uXoovwDiXKD37yaOkIfSvwnsCsf9RR
	s6P9INqWnC/DeuTHrFBXfp5Rh5PG9JeHEuNekWr1mhulOs+54qNBRJ5rF5mdmK21T0Dn9rAL3DG
	rE7z1vdRpUc8gcz8jqzmHLe4DqXa2iZPauMHGM/YcA+GFO0ZMrEcI78Iy3oYFTw2nOD3Xw/mh3D
	F3PHO3heZgNBTZ8WHG4wXuwl/v95dj7FnucbnrpdUgs/edZmLApF5oO34=
X-Gm-Gg: ATEYQzzO9Tud/TfuLXBM5M37dnZAzf/6+DQF8f8mjuJxT0Hqliq3SnAUVgUz3dlnZMm
	rHHGuCqXgzte514qd6XA/KCpguww91TQ3B3334epeqiUWMaixYGi1s/mn1EyZHDZ+hJzzFwK+/b
	h8YH/1adI+uQfJ9rswECWRML+6D2wTtscKGH3mbudLr41Yu1T10CzIvkfv/EDftKua+FSOZBpv7
	68nxHHemgSanwRaVp9V+uYrH3HbmunBWbHBJ+vxyhDrn3WHQYyns9bnMWy8Scb5gSqt
X-Received: by 2002:a05:6214:2485:b0:899:f6b6:543c with SMTP id 6a1803df08f44-89cc4ac0f92mr39247756d6.47.1774428099614;
        Wed, 25 Mar 2026 01:41:39 -0700 (PDT)
X-Received: by 2002:a05:6214:2485:b0:899:f6b6:543c with SMTP id
 6a1803df08f44-89cc4ac0f92mr39247456d6.47.1774428099202; Wed, 25 Mar 2026
 01:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322124822.230492-1-m.schababerle@gmail.com>
In-Reply-To: <20260322124822.230492-1-m.schababerle@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 09:41:28 +0100
X-Gm-Features: AaiRm51dz42AW6D-9JeQTbw_dWAmALtuGZ73d70-yAcNiIPTtSxKhjMQtI4OEDw
Message-ID: <CAFEp6-0xShGtpWEhmYmqs0156GHZDsF4Q7E5HOrMbnGSAb56wA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ath10k: WCN3990 firmware workarounds for WLAN.HL.3.2
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Malte Schababerle <m.schababerle@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2MSBTYWx0ZWRfX3mOJCFq3B8Pv
 84HjHK0BDQEkM53KWKz0J0cJiS4697zfYKXgoz/Z3R8WwqVvowYzCSZxj8cd4d7ViI1SvhYEh0K
 8n2vg66NMghe95CAMwUh3cZ+V6d1opZXB/E/hva25+ZaBtEZnYxq40E896YVR/0FpUn3m+oRFPh
 9RqDeKe3Dsjjmr52qaVZXTot+Q5NfRRAWOUr5SLpEZpIpWWT01A9MC06QKItiKu3Q1FJrbxI0Qu
 3izo1cchQNJRcDmo8u0kcrFyqN9wZcv/Oq4k6UJzJjEEvE2Dzecw6XU0FEe+XDhyq+mBR4HWwoq
 C2autenKP1AxJ2zYmPUdfY4srWFau2y7pdTk32su/6CsLT9+HIijYZuL71b5PwjYbEAb81Eh66M
 l6574QNzdrpH48EN+PApUhbx11W4I1FR+FuzvCKuTS/46nC5D5RxyUFdI5HXmagzVPe0fnjQodV
 /OJxjy7MGdFqJ1IHHZg==
X-Proofpoint-GUID: YdCjzvPrNiXtP1sX8KuQlxxPRvxrw36J
X-Proofpoint-ORIG-GUID: YdCjzvPrNiXtP1sX8KuQlxxPRvxrw36J
X-Authority-Analysis: v=2.4 cv=AKSYvs3t c=1 sm=1 tr=0 ts=69c39fc4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=I7fk8Y-XGR-JG7Q1fIEA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250061
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33822-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE76F321864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jeff, Malte.

On Sun, Mar 22, 2026 at 2:49=E2=80=AFPM Malte Schababerle
<m.schababerle@gmail.com> wrote:
>
> Two firmware workarounds for WCN3990 (QCA6174 integrated variant on
> Qualcomm SM8150/SDM845 platforms) running WLAN.HL.3.2 firmware.
>
> Both issues are firmware bugs where WCN3990 advertises capabilities it
> cannot handle correctly. Tested on OnePlus 7T (SM8150) with
> WLAN.HL.3.2.0.c2-00006 and WLAN.HL.3.2.0.c2-00011.
>
> Patch 1 fixes a deterministic firmware crash caused by the quiet mode
> WMI command. The existing guard from commit 53884577fbcef relied on
> THERM_THROT not being advertised, but HL3.2 now advertises it despite
> still crashing on the command.
>
> Patch 2 works around a bug where active scan does not tune the radio
> on 5GHz non-DFS channels, making 5GHz networks invisible. Forcing
> passive scan mode restores 5GHz discovery.
>
> Malte Schababerle (2):
>   ath10k: skip quiet mode for WCN3990 to prevent firmware crash
>   ath10k: force passive scan on 5GHz for WCN3990

Jeff, is this something that could be addressed or worked around
through the firmware or NV configuration? Applying this workaround to
all WCN3990 devices feels a bit excessive if the issue is limited to
specific variants.

Regards,
Loic

