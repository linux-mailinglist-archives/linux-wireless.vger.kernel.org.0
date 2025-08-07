Return-Path: <linux-wireless+bounces-26203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BFDB1D7E4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785A13B3C72
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518D91E48A;
	Thu,  7 Aug 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKb+e7L8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F14A0A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569892; cv=none; b=nuEF/uUxf8tlcuGXPJN2RIjQ8Vc9LKZUGkDA8GfLkYEAONzZOOdlkcvKb9UNDR+XUR+4tOK6jzhLKJX1shtHiBIVUtTciaF+JF9suZ7uBKID2mDWZfxNGVfjmqmTJXbIEqdxhK19wqCahgqf7pvmD5FE4Sd1ZYq42LC3kc2vvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569892; c=relaxed/simple;
	bh=5VRr0yi2SjlT5jW7kr6gpTIwT8EepAd+fbkWm2i6ccM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUrgTURfVIo4He3ZJUecjeEr+4A8dfF+FLiHXWFJc0X0+cswRvhGc5xiGpP9c9jO6EVuYjq3fXUC2ayj/Nz6IbSy7/FUoSaeFwbxMEcDtA/F3hp/JPmg5MT6fO+MEkFtUXKiXXplXxopE9VybjgXE+0TgA2HSw7jbOl00s9gCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKb+e7L8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779CtIj022425
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 12:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Hzj89PdCGcQ2wYW8aWZx1cGKAdeJLsUTERFjJ58HFE=; b=KKb+e7L8Cb0PRsOS
	piH2sBvAB8hRhWnjREO2lVB90TEPV7deEjyUF0YZO3IJxYQ9TzvznlfOavuwQMFp
	nrWTLKNhMTMwiu9Gg76z3/AVdvOQkOwAAscXc4OH8OPXULcP+xpabyupb0uRSIu1
	bGgebQTrGq4j200oPI+nWkdbca7xeixZCV2MU+BxyG+DNm9qwSolrzkJdRc3teDI
	K3ZJM4fxkjey22KQJi/IlqtntljY/GLG1Hyp2+JxQNXMeczsxi/K85HSvaSOxMq0
	7ZRT5AShb5Ez5BSKRIpBuLWkodaLy2CNnAFngyi+/V3EMq0anb6U29cAM6xT3/7j
	RIgD4Q==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cs5n8h76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 12:31:29 +0000 (GMT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881855cd566so87785139f.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 05:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569888; x=1755174688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Hzj89PdCGcQ2wYW8aWZx1cGKAdeJLsUTERFjJ58HFE=;
        b=p9XcT3bvQFclgrfIFPPRiH89gHsON84Tj+iNE0mJQENEq/afdH8BQce3FTK7Q0eH/Y
         5PcUrNXK5P7FjuBZYclVjEoRlvGa5A3DeL8qN4DARaLdAxIIU08F2cqh/+uchUZnuTPV
         0WIPxtZq1w47RxTYgKAKyNGwkAVeDv12aOnS/n1Awib7c3LlHOBWQQaX7LorRJ6GlAgN
         kj9xEm8SBM//dF0poAVqvb6eENh+Le9qtxF1Rfgpp8lFnlqviddMkY8b+PWKHn3RHRGv
         OPivkKd2AyKL/ToGyeWwzrzNkN39LqVvfIariZws+6lVwHibxzQjFnxpBIjkcN6QciNz
         wnvg==
X-Forwarded-Encrypted: i=1; AJvYcCVx6YIc57VswJOZCJq/sZLGX5N7cb4fEKIo/9FfTxGwUaViBiiGc1bXMPQ+8TWKpyg+kGSYiz5vKx+NjJ2pQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fcu0tH/eP3WZ6AusbaWJLd0hVoagg6LL6C1nAo3f5e/QNmkF
	Y0AdWSCIIxFQfGvwSFjKElHUGGbt/z39vOM/LpCbTJxnhN59wYykzpljt/piZU2J0kvl2pNUwB0
	qSWZSyDP4j9cun3dSkBXgKii+wGVTD5WtL1O4Mywzf/GSn1uTDR85GTFUIvG2cHZEnXJWQuYRdC
	84TAldFy3fL+8cA0QWMq5/s4KtIMzY4l1POEF+GKqbSOTxOS8rwgovNcI=
X-Gm-Gg: ASbGncu/7ZSzGr7pU7qdWoJtfUdCTejZSiF4Gf6WUKGRcq6FgGaX1kif1W3hvJqx/Fz
	Dw1krpBgEYyYiTYlgcCHxQvN/zgzWTOcTSosbCz/WrJN3MP1wYzB09/bNMIqKonS9dTJsMuEjD1
	llTYLMWknCw69B8aHld+s94w==
X-Received: by 2002:a05:6e02:2404:b0:3e3:e78e:4dfd with SMTP id e9e14a558f8ab-3e51b88ab9cmr104910845ab.4.1754569888217;
        Thu, 07 Aug 2025 05:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGMeg2RbCRlLoxf95o8RhoJYbqKFVf1VIyCayu9nBMd4pCGtxYa5ziSlxaKAz/GRJ50on9FwpajCExPjQ2H0E=
X-Received: by 2002:a05:6e02:2404:b0:3e3:e78e:4dfd with SMTP id
 e9e14a558f8ab-3e51b88ab9cmr104910435ab.4.1754569887749; Thu, 07 Aug 2025
 05:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <DBVM2YZDTS15.1WAPW69YQ5XOA@gmail.com>
In-Reply-To: <DBVM2YZDTS15.1WAPW69YQ5XOA@gmail.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 18:01:16 +0530
X-Gm-Features: Ac12FXz3aDMv-msx9dizo560OwJfZvCBsrsu7JYp0aSZyUQh3pu-jcKaiLSQY8Y
Message-ID: <CAD1Z1J+jXWng4ma9_BPJh4N8b7AhTvRKtJ=tg1dTyk8E3wqupA@mail.gmail.com>
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX Queue Updates
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Q+XS452a c=1 sm=1 tr=0 ts=68949ca1 cx=c_pps
 a=WjJghted8nQMc6PJgwfwjA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=pGLkceISAAAA:8 a=DzQ5D1QIoQUFvDlUu2IA:9 a=QEXdDO2ut3YA:10
 a=CtjknkDrmJZAHT7xvMyn:22
X-Proofpoint-GUID: 5QlMk3qqO8gUeOWLwbDSKI2DQJ6C4--D
X-Proofpoint-ORIG-GUID: 5QlMk3qqO8gUeOWLwbDSKI2DQJ6C4--D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA2OSBTYWx0ZWRfXyIhEunwx6aB0
 8zsJdMAYiLDGwTgXv0MiCffoZnUgQ3ejQdg+5J9k9E0YgBZ5ySWXG0k9bpn9iRlTzToFloREqYJ
 dmkO4dMXfhegKQqqrXW1iTLLYzfwofxyq9JU4NomC/DTnT1zLrz16VFb7+t53O/NEIDSAV02KWt
 554cPBjZO011NFwVHcYRXfyojFPUTWcEXc6EePxm8vy86uF5zU9PXV0+fUE50yxM4YbQGdcVlch
 pu5u6+Zi3UJxVh1YM++T/JRQFGYmmHyo18cB+auDOIYH0qtRMpygKTLDXTAnBeUSZw8SatfHD76
 xDFwCy0/v5xr+rWwk81GN3TJ+F3LdIWc9grQtE37mqy+lxwYHAFyzz/e+Mqmy5KuUDW+Nv+HOl5
 9rfel9jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070069

On Thu, Aug 7, 2025 at 1:32=E2=80=AFAM Nicolas Escande <nico.escande@gmail.=
com> wrote:
>
> On Wed Aug 6, 2025 at 1:17 PM CEST, Nithyanantham Paramasivam wrote:
> > During stress test scenarios, when the REO command ring becomes full,
> > the RX queue update command issued during peer deletion fails due to
> > insufficient space. In response, the host performs a dma_unmap and
> > frees the associated memory. However, the hardware still retains a
> > reference to the same memory address. If the kernel later reallocates
> > this address, unaware that the hardware is still using it, it can
> > lead to memory corruption-since the host might access or modify
> > memory that is still actively referenced by the hardware.
> >
> > Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
> > command during TID deletion to prevent memory corruption. Introduce
> > a new list, reo_cmd_update_rx_queue_list, in the dp structure to
> > track pending RX queue updates. Protect this list with
> > reo_rxq_flush_lock, which also ensures synchronized access to
> > reo_cmd_cache_flush_list. Defer memory release until hardware
> > confirms the virtual address is no longer in use, avoiding immediate
> > deallocation on command failure. Release memory for pending RX queue
> > updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
> > if hardware confirmation is not received.
> >
> > Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
> > likelihood of ring exhaustion. Use a 1KB cache flush command for
> > QoS TID descriptors to improve efficiency.
> >
>
> Hello,
>
> I'm not sure I fully understand so please correct where I'm wrong but fro=
m what
> I got looking at the code:
>   - you increase the ring size for reo cmd
>   - you enable releasing multiple tid buffer at once
>   - as soon as you allocate the tid you create an entry in the list flagg=
ing it
>     as active
>   - when you need to clean up a tid
>     - you mark it as inactive in the list, then
>     - try to process the whole list by
>       - sending the reo command to release it
>       - if it succeed you release it and remove the entry from the list
>   - on core exit, you re process the list
>
> What is bothering me with this is that when a vdev which has multiple sta=
 goes
> down, you will have a lot of those entries to push to the firmware at onc=
e:
>
>   - So increasing the ring size / being able to release multiple entries =
at once
>     in one reo cmd may or may not be enough to handle the burst. It seems
>     that increasing those is just band aids on the underlying problem but=
 I
>     understand it's just to be on the safe side.
>   - If entries do not get send/accepted by the firmware, we will need to =
wait
>     for another station removal before retrying, which could be a wile.
>   - Or in the worst case (one vdev going down and needing to release tid =
of
>     all its stations) the more entries we have in the list the less likel=
y we
>     will be to be able to push the delete of all stations + the ones stil=
l in
>     queue
>
> So, on station removal, why not make just things completely async. Push t=
he tid
> deletes in a list and wake a workqueue that tries to push those to the fi=
rmware.
> If the ring is full, retry periodically.
>
> Thanks

Hi Nicolas,

Thanks for the detailed observations and suggestions.

You're right in your understanding of the flow. To clarify further:

When the host fails to obtain a buffer from the hardware to send a
command=E2=80=94due to the REO command ring being full
(ath12k_hal_reo_cmd_send returning -ENOBUFS)=E2=80=94we treat it as a comma=
nd
send failure and avoid deleting the corresponding entry immediately.

This situation typically arises in the flow:

ath12k_dp_rx_process_reo_cmd_update_rx_queue_list =E2=86=92
ath12k_dp_rx_tid_delete_handler =E2=86=92 returns -ENOBUFS

Given the command ring size is 256, and each peer generally has 16
TIDs, each TID sends 2 commands (RXQ update and cache flush). So,
deleting one peer involves up to 32 commands. This means we can delete
up to 8 peers (8 =C3=97 32 =3D 256 commands) before hitting the ring limit.

From the 9th peer onward, we may encounter ring exhaustion. However,
we handle retries in the REO command callback
(ath12k_dp_rx_tid_del_func). If commands fail to send, they remain in
the pending list and can be retried via the success callback of
earlier commands.

Do we foresee any issue with this ?

Regarding your suggestion to make the deletion process fully
asynchronous via a workqueue, that=E2=80=99s a valid point. Workqueue-based
handling is a good idea, but we need to account for potential delays
if the worker thread isn=E2=80=99t scheduled promptly. We also need to
consider timeout-based rescheduling, especially during command
failures, to ensure retries happen in a timely manner. We=E2=80=99ll evalua=
te
this suggestion further and get back to you.

Thanks again for the insightful feedback!

Best Regards,
Nithy

