Return-Path: <linux-wireless+bounces-38989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3KuCLAobVWoIkAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 19:06:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1474DDB8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 19:06:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=l9cpGty4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Rhpr7HkR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38989-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38989-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC824301C2FC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20A342CB2;
	Mon, 13 Jul 2026 17:06:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD23340407
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 17:06:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962365; cv=pass; b=QYD/XSJ3zIvw+YIj32MRV6XaG/fmtGoY7DMgt8JXvIpL8y0G9Xlt4QX0CYdYBk1NBpBBXLrG2RTJs1vY9w5RQC1rBerhU1hdqo9C7xwiCplIRbqc8aC7IOuU0IR0pLlwGbM86LX4m3So1dOai6BuvKHOoq2Z3oHdUq1PQ3ZoqZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962365; c=relaxed/simple;
	bh=Qx+4tjqW/VYM1RWPOA4yEFjNai6l4rB66SRwRlTHn+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzckJmEDszYLMReg2qc+B5MXCOfjhMek7hb7JLQUSlVWR75bNpWDmItDVWaoAnrPkhayzs/h7VZqHxDZ2sGM5b5sOzWRHjuaoKCKXqHYXuvXazQiSCT5QQ32uCqTr2U86Or4kh5nJrYoiVADshhcvgZEQQIdn2zHWfrafg1r5+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9cpGty4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rhpr7HkR; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8Gke1709130
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 17:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6SyzZ6EPMaoE03KHkavFTA6TatdreHGVofNf2BUFYTg=; b=l9cpGty44rYnBmQd
	CpGqfJgd3s2WwkUQcmF36AN77AeUJC9OQsooppQLOa3AhlRPpipW3Ncvip3r04+3
	RJXso6KMeWwwUqY3b84P7X608OZYXGKRxrvqhQHAJ72Hi3qAgz66mxh+BqyokT6S
	HpSGl8esY9eNz0053mFi6TksvdRX+pRA60FCDWbhs7QJ4czV1QijQG68rynHIBvs
	LRIS42eiWdpT46eG8t/zhpXjPnmHJQUdy3NvdXk+h/22SDAjDl09MK11YeMf80zE
	eq3rTL/cL93ay69LkBCE3/pJPi5QfbyJy5rdouFhrRf9eFfZwai06gWh5fDxVVnq
	wgLWHg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9sshm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 17:06:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3811343bd68so1106633a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 10:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783962362; cv=none;
        d=google.com; s=arc-20260327;
        b=FOpNCazax3UsBYxwzMEAQQm5n2HnRYUwAHZlVDhMdUWnZXG/k6fscEe+I3T72cFh4E
         qAeYItdHTZUq3SEWtOALo2ypXw4goCembDFW7gQA+bdthm3RGMjnIsIXsA90yCZEH8Q1
         a+kr+vHgaBiRN9eQmyXkaIi1xdxAxzwlM3KfnsP1xDDYrVwHY2uZAu28WdxO1gmcY0GT
         dLXXR//T5X/j5bAipjr4FouC5nqjmqL8wsxNwQC92ClV9KjSVVKS0a7ua1/nwGq5iWxd
         mAbEnnetTIvd2N2KCb67Tm87trSibTQFvXUMojpuUSzTYGGa/Lu6ahIkEHzvuhxku9UQ
         yNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6SyzZ6EPMaoE03KHkavFTA6TatdreHGVofNf2BUFYTg=;
        fh=VcyDHNsCazLa8+uqFCrmm8b15ia+ncpUC3iZp3Esxc8=;
        b=I3AwX0wAsbO7tmBL5wwNguB7cXkwmg6IIi7j/firooRA5BN1JMaoZWsv8EcU587OKO
         AY94eLBn5xuKJFQ0Uatesnp3b3Cvzj34QdRxTtvb8FvZ29SxvCAnls/k+owZJR9dLPz9
         ie7v+LQlFNJm1foyfTaJUoemCgK0WO95SIPxSDdMlbBBnd+A/BFbwjcn2ANabdSzfktJ
         G3zb0VIRYA0O4Wo2oc9MHRNFqf0kyvFeV9bC1qH2gWKTc1e/GP0ad2HzDw/JwuYLhW6w
         FIT3STAePcUfLn6VUh001RUPRnenFNr49J9R1yOr2GBoLtBjG5ZT3Xh8lilZo8CXavhh
         bW1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783962362; x=1784567162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6SyzZ6EPMaoE03KHkavFTA6TatdreHGVofNf2BUFYTg=;
        b=Rhpr7HkRzDwsmtEYJ9eEI8HOKArNl9Jit3GSPCNjpn0+BnTOd0TMu/PQh6Mz7R7CEg
         X84ORmgVVO3dGOi37iBbnXlVZsr5F32XT60cijDQ89NSV1TNpMaFOMBugJB0e5QxbeRd
         32AyIR5Hf4uWIAgetx/OLEPoxx7BU8+qn67SV2NgQmpXDDQuA3eIo2pXjAK50Y/EhHWV
         CDVLSq90nc5i7CIWJyZYqWCMCtkCo1kWnTW3Fy3Y9vGRX65amJWThpI1eIwsW+vNCEVp
         895g9UVb4ruBFDfEkZLpOGrDSr8BSBf5k2NrgTinMgb8xa/hlp9jBsODE3bhb2qT3Pof
         fxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962362; x=1784567162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SyzZ6EPMaoE03KHkavFTA6TatdreHGVofNf2BUFYTg=;
        b=I1Zt7IwzQPBb4eqg5HN8jH0umftz+/FoKO1ezUUqJIvcgJ5AD6No0+zqlxMkT9qdOA
         do44XY61x2X8kIgwTflGsjcRYkmxh5GjW1ZWnIPqUxhhj7bazflrvMGdMdEn3Jo1KckZ
         N82i9+e6wNxdAZn0UCG2hnhg6DfVnxvG09jc6Bj5oNoIRiD9qlCGWZHPd01MiXolycUW
         HPQEw/Pc4odlmYqWZN/ZbOXOWtKdIXyD3oR8nnDtJfYa00+YVvCQ6sE258P8K00kWH7M
         30tWuD7okuDBK6XGNt39d0IvT9YKr7NVwD6Ph0k49fm5JU0lfoCpf1+owVxzIvAS76sR
         7wJw==
X-Forwarded-Encrypted: i=1; AHgh+RrQV1y3fT2QEGxzKiG5H+UX92YNkvWdFadp4fgqtP3JhmFGWvBkBdRnGMk7IFMOWmgufBbbl4TJ1bsrKeHqXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxebeP2xDXhl816Lep4HjtkBNG5xwJaJdA/y4hNFcsYchzgqS3G
	A0i3TtSJp9BoFBrORdYQNk+4ZxsEMNUrBKTZSj6cnrClJMw0C91bAsqiR1tdkM1iAiMwZ5XzRrt
	3QMLXrKNQ5b4hVfJnc8Bl7+cmo1VNCPW7hmU8/bz6B8aJ4J58Ktu4456TrCyiciEjWybxom1oCb
	GoxD8rDtVhNF2Q//AWfjZhhUovBmg828Dqy7CNc+TWyCpH
X-Gm-Gg: AfdE7ckSZ1Va4tyR++oEUh4uV1C76FDl0Hz2DMRbY++wFTqcNV2Ke+7s08se5KCpwMz
	ytPxyy3aJjO2qRV16h5hzlAg3UiBBdrfEmURmLY/lF1sRCEjEt4Utr5lyXSptyr6WYTNOsWtJur
	TSWT65IArY9zcEeCqropd/U3QusrrB+sjQsa5GE5hqdjZ4x5BrAe3+SE3jAkT6DMXRKmeHCylXg
	a82f0aWLogrA/jGtK/18aSl0i3baw==
X-Received: by 2002:a17:90b:51cc:b0:381:6cf0:d5f5 with SMTP id 98e67ed59e1d1-38dc780f503mr7747519a91.5.1783962361889;
        Mon, 13 Jul 2026 10:06:01 -0700 (PDT)
X-Received: by 2002:a17:90b:51cc:b0:381:6cf0:d5f5 with SMTP id
 98e67ed59e1d1-38dc780f503mr7747489a91.5.1783962361387; Mon, 13 Jul 2026
 10:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710155443.1761760-1-jtornosm@redhat.com> <20260710155443.1761760-3-jtornosm@redhat.com>
In-Reply-To: <20260710155443.1761760-3-jtornosm@redhat.com>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:35:49 +0530
X-Gm-Features: AUfX_myqBTA6Al-ASglZ6zXCxWVTaIWJ0S_u-PpqBDiSUnLkbGESlFGPZnjNZcY
Message-ID: <CABkEBKZABhFkS9MVqbeRFHLUXoNaJC-qocmcPVmZ8ov2j+DMzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath12k: implement custom wake_tx_queue with
 flow control
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NyBTYWx0ZWRfXyeh2oBdIFdyG
 3VNpvAyyCCOLbA0+47RDR0ii0CVzVw6QfttIKIlT6rvSL4oijyBxFfkjX4VL2gULZOi21gh3M+J
 r+FISsBGzJSc0g4R6oGEirccqh9CsDpxP3VpJbzf2b1LjT3Y/jNjjWM9uxGF4aQswpKKbV+dJSt
 8miR2nsVS1OAs4EEPK+Fr0o+2jh5nRk9WVDH+TARR2cwvuPGcR3aOJ7yMmdcnFNUvrdYhbqSCO0
 u5DhAKme9YDgtLcOGTkPJ00awairFUr7etNMQhSbbYa3uTi41M+4+eCyWiDqY2zbEDMT1tg6W3H
 fvJEOHDxYkJXFdT+0RPfQdEtj1OmqFbNo/x/QDgM6V9ff1l9FaHpyKxlxcoIsWMK7d9qea9R/Fr
 LmkarxT7pkqsk+qx7SsGkF1PpG285BY1qloJAsqaWQGbTIkyuov9RUM/boCLfLwMU4XmJez4BbC
 PtjmpmGeu8BzXeCtBJg==
X-Proofpoint-ORIG-GUID: TLNQFlK3MlP6sSeZs5hhzPRHPzHsfEoG
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a551afb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=20KFwNOVAAAA:8 a=6vpvkDlHG3n5nyPZv6IA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: TLNQFlK3MlP6sSeZs5hhzPRHPzHsfEoG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NyBTYWx0ZWRfX16voTvqASLVM
 +5KsAVSYNxu6i0X2SuDyNTHdCrviWdXK2qYbiAtqE+Msb+CF1OgOHGHRd63w3N0A01W3luPQBAc
 TQwrGK79UsU/0kyuU9Kpg19Hje1OYQ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130177
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38989-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48E1474DDB8

On Fri, Jul 10, 2026 at 9:25=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Under heavy traffic, ath12k can hang and experiences -ENOMEM errors
> ("failed to transmit frame -12") when the hardware TCL ring fills up.
> This issue is more commonly observed in VMs with PCIe passthrough but
> also occurs on bare metal systems.
>
> Implement a custom wake_tx_queue operation that:
>
> 1. Checks hardware ring space before dequeuing packets from mac80211
> 2. Uses per-packet locking to serialize ring access and prevent races
> 3. Syncs with hardware state to get accurate free slot count
> 4. Returns early during firmware crash in the same way as other tx paths
>
> This approach follows the pattern used in the iwlwifi driver, adapted
> for ath12k's hardware ring architecture.
>
> This prevents hangs, eliminates -ENOMEM errors, and improves throughput
> by optimizing resource usage and preventing unnecessary packet drops.
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.c       |  1 +
>  drivers/net/wireless/ath/ath12k/dp.h       |  2 +
>  drivers/net/wireless/ath/ath12k/hal.c      |  1 +
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c | 50 +++++++++++++++++++++-
>  4 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/=
ath/ath12k/dp.c
> index af5f11fc1d84..3d46cfbf0a1c 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1539,6 +1539,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
>         }
>
>         for (i =3D 0; i < ab->hw_params->max_tx_ring; i++) {
> +               spin_lock_init(&dp->tx_ring[i].wake_tx_lock);
>                 dp->tx_ring[i].tcl_data_ring_id =3D i;
>
>                 dp->tx_ring[i].tx_status_head =3D 0;
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/=
ath/ath12k/dp.h
> index f8cfc7bb29dd..68d2020be9b8 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -58,6 +58,8 @@ struct dp_tx_ring {
>         u8 tcl_data_ring_id;
>         struct dp_srng tcl_data_ring;
>         struct dp_srng tcl_comp_ring;
> +       /* Serializes wake_tx_queue operations for this ring */
> +       spinlock_t wake_tx_lock;
>         struct hal_wbm_completion_ring_tx *tx_status;
>         int tx_status_head;
>         int tx_status_tail;
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless=
/ath/ath12k/hal.c
> index a164563fff28..c1c656e4550b 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -390,6 +390,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *=
ab, struct hal_srng *srng,
>         else
>                 return ((srng->ring_size - hp + tp) / srng->entry_size) -=
 1;
>  }
> +EXPORT_SYMBOL(ath12k_hal_srng_src_num_free);
>
>  void *ath12k_hal_srng_src_next_peek(struct ath12k_base *ab,
>                                     struct hal_srng *srng)
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wir=
eless/ath/ath12k/wifi7/hw.c
> index d9fdd2fc8298..e3a6f9cdee24 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> @@ -1100,9 +1100,57 @@ static void ath12k_wifi7_mac_op_tx(struct ieee8021=
1_hw *hw,
>         }
>  }
>
> +static void ath12k_wifi7_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
> +                                             struct ieee80211_txq *txq)
> +{
> +       struct ath12k_hw *ah =3D ath12k_hw_to_ah(hw);
> +       struct ieee80211_tx_control control =3D {
> +               .sta =3D txq->sta,
> +       };
> +       struct ath12k *ar =3D ah->radio;

This assignment is wrong and all traffic is incorrectly steered to
radio[0] as ah->radio is a flexible array, not a pointer

> +       struct dp_tx_ring *tx_ring;
> +       struct hal_srng *tcl_ring;
> +       struct ath12k_dp *dp;
> +       struct sk_buff *skb;
> +       int num_free;
> +
> +       if (!ar)
> +               return;
> +
> +       if (unlikely(test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags=
)))
> +               return;
> +
> +       dp =3D ar->ab->dp;
> +       tx_ring =3D &dp->tx_ring[txq->ac % dp->hw_params->max_tx_ring];
> +       tcl_ring =3D &dp->hal->srng_list[tx_ring->tcl_data_ring.ring_id];

tx_ring/tcl_ring selection should be corrected.
> +
> +       while (1) {
> +               spin_lock_bh(&tx_ring->wake_tx_lock);

Do we need this spin_lock_bh?

> +
> +               spin_lock(&tcl_ring->lock);
> +               num_free =3D ath12k_hal_srng_src_num_free(ar->ab, tcl_rin=
g, true);
> +               spin_unlock(&tcl_ring->lock);
> +
Do we need this check and spin_lock here? already ath12k_wifi7_dp_tx()
has this lock and fetches the next entry. Can we check those return
value here and break the loop?

> +               if (num_free =3D=3D 0) {
> +                       spin_unlock_bh(&tx_ring->wake_tx_lock);
> +                       break;
> +               }
> +
> +               skb =3D ieee80211_tx_dequeue(hw, txq);
> +               if (!skb) {
> +                       spin_unlock_bh(&tx_ring->wake_tx_lock);
> +                       break;
> +               }
> +
> +               ath12k_wifi7_mac_op_tx(hw, &control, skb);
> +
> +               spin_unlock_bh(&tx_ring->wake_tx_lock);
> +       }
> +}
> +
>  static const struct ieee80211_ops ath12k_ops_wifi7 =3D {
>         .tx                             =3D ath12k_wifi7_mac_op_tx,
> -       .wake_tx_queue                  =3D ieee80211_handle_wake_tx_queu=
e,
> +       .wake_tx_queue                  =3D ath12k_wifi7_mac_op_wake_tx_q=
ueue,
>         .start                          =3D ath12k_mac_op_start,
>         .stop                           =3D ath12k_mac_op_stop,
>         .reconfig_complete              =3D ath12k_mac_op_reconfig_comple=
te,
> --
> 2.54.0
>
>


--
- Tamizh.

