Return-Path: <linux-wireless+bounces-30131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6837CDE8A0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B903007C7B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA019CD1D;
	Fri, 26 Dec 2025 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfSbp3ei";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LMBdZHnB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F61DF256
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766741759; cv=none; b=pvDJU9gB2BAAOOnPRHUTj99lI3PeEZhDapsloE3Kj+b2mXY8RcghMw0dI5zMG2LWEj9rvw2HdHlozjW94G3gLUY13Y5uTwe8jOrDNxHGrfqtOQA79SpYnrtLHlELNaPa16ZdT+GOnTUQFzn+DNL5jA8AwBCAP+9mPrjkxIA+89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766741759; c=relaxed/simple;
	bh=qw1wUnk7SqV6y45p7hhUrfaWmx0xrKyYdiWa3dNSEew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzExH7Ps41SelLQrB4v+NPTNEc5qe7OPrJqk12fdJOrMCakYGoL2meED8RBnJfKQHuzOJGKvw7LZBwsIWwu+DuYYj43mc8Z6mU9Wte57fBHs1jhOIPpYHQ/D3QhzHoIORJPm0nznSMtikDpmT41eDug5BPWa8D2qTSLhYvs8Vsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfSbp3ei; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LMBdZHnB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BQ8baWA1011830
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 09:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4XZZBtHRHHx8H+AuCQZACsJWB296NqgLjtpchYRkgF0=; b=OfSbp3eiScDOT400
	rUJOTJt+bSTij+UEkle9dmROfhNOtjCN83gBzYSnet99HDuPYwgeMGrLaEFO/T7Q
	RObgqsefDKL71PNTY+sUNkf3rOJ6bTwEKnYVg3FzeJoz4npLQTaMeUWt0aBs4SnD
	zC06yipQ24oURXTQNqHIw0AhrSu66lV96h72rR3FNkjNzp8Xlclt746Vi3VClJdk
	W5ZvKDf9jJ3EzwrW/d8STTm4bEhVOVTIspOm9/inRBOx3QyJRLWH6u2fWw6gDfbL
	KUWPwLXqWXf30Oki35SmRSH+nVtoxHchN67Od3X+a4C2vMjy0vCuNwCD/m8S3kT+
	sQR7oA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8kywkhee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 09:35:56 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6447a801fbaso1453237d50.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 01:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766741756; x=1767346556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XZZBtHRHHx8H+AuCQZACsJWB296NqgLjtpchYRkgF0=;
        b=LMBdZHnBpDQWLh1PmKpFkhlMjFltmq1SDJBlP8G1wLng1p/nx9yi/Ez81hLSn/2ctX
         UxOwzxZc8nOjETLqu95iQ3UZNwPJ+htmMeofCV1/XHwgsIaQ4ja/B+ojeacLwojrRK97
         Fvbc0z4+6KRwSwVb4kqn6gn7D232wbA8MroMM7z3eEjfnSoGuFq0/lOHC0cRXsCOeT9r
         TYCfBGG5AoiMyDQc6Pl4DSIuE6Sreebbf3UzLP08cCUZs9SpQsoY9yFP3RSioNK/KnaB
         A7ZnuhlHAWlRHlGaFAEFJ/twFoHE61bkxXGcLKzvrPrGjoG+AeAPTrxp1JqXGJVcbYJg
         ZLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766741756; x=1767346556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XZZBtHRHHx8H+AuCQZACsJWB296NqgLjtpchYRkgF0=;
        b=PBi+SFlqzJ8AOAdFmtNL/+OV53g/LpaGty/u7OmMz1//sHRaAlUUXB8kXEKmNiiRUe
         5bpckir5/40hQSKk2ESrC0vqvOInhinC1c0hxQcmsm2h+uKYADPk4oYD2bwpBy8Li8+A
         B8Q7QqRHTKWcsUGmCYGUj1MoydMGh8e68K9CyClJGUw19kziLReuectM9bQSMULig++A
         7pXRvMEfUaEK6Ax4yvVNV65XxDl/kA3iaG4ktrPQWylAmKs6pPZS0wUJCIOt7qJF87W5
         yXGzXRIO7dLHHCeJoM0kmuuwniDrvR0M1E5L+QG2Rx4wwHi9OaFlxIwKgYsfn8gjudY8
         XMDw==
X-Forwarded-Encrypted: i=1; AJvYcCWzd/mGd9jEiVzJqdFbIiTu3zRNlqeLUCbIh9BROeiynHa1PoraNC4hiFwFMOFfM5MeGzgqYJPgeBGFdVqVIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QvE4XzqoKdLSNuS1AlMFqhrf5KwSxTDAec9yiYLlVkZtPCgx
	hjVJztuVPLA6BzID+yL/9hxeMGi3OmYXlHJh6QKZcbBRlHonq5EaTh/WSq/XbPPMld7N3sQzc3F
	MeEaSHw0f+rpCbteK2p7kPdGR82atZd3cDf1DdXvWGRb/Lec99Ns7lriuOu1jfkDKG6zG7onkWs
	cedVxntN+JriLOn7yofdithjaGFdTqN4qolZfkNR3tNib0
X-Gm-Gg: AY/fxX7YzuIkYz4TEJN4OZMxX6236CUClYPbApnLJizjoxRzr0PHxB1JM3pIahWB21T
	/Hk8a3cn8/jcCTi1bVk6mRJG7pJfNHtIzKY0jf85++KazAuLKigco40jDOo6IuDGHFDzYzzvIC1
	sP5xP9mBVo/oC6Fmj6E1TO03GbTTZgQJz29vKyxdNir0AMqHPHMP4jQffwvaQvJAh8MI0=
X-Received: by 2002:a05:690e:bcc:b0:645:5b0e:c91b with SMTP id 956f58d0204a3-6466a8321bcmr16916994d50.14.1766741756107;
        Fri, 26 Dec 2025 01:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQrpjX7hlPDPgxyI/zjSWgTKf51eEUVBCbIrACuGHsbiwk9fe89YSiTFhR2JLLXxD5i7CvV0No8uHokhiGfAs=
X-Received: by 2002:a05:690e:bcc:b0:645:5b0e:c91b with SMTP id
 956f58d0204a3-6466a8321bcmr16916980d50.14.1766741755729; Fri, 26 Dec 2025
 01:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com> <90fe1a15-9e22-468f-a1b8-3550212b78a7@oss.qualcomm.com>
In-Reply-To: <90fe1a15-9e22-468f-a1b8-3550212b78a7@oss.qualcomm.com>
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
Date: Fri, 26 Dec 2025 17:35:20 +0800
X-Gm-Features: AQt7F2qqZrewaQu5tT871_jZAdVwb24SnUc-FucDgDmNxWyB-EkJBxs3FaCj8A4
Message-ID: <CALC2J1O+g_aGT0UNhE4VvEFUmZC5RCCOXOQeBAQKRFm9TW6wBw@mail.gmail.com>
Subject: Re: [PATCH ath-next v4 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Yu Zhang <yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDA4OSBTYWx0ZWRfX/51cLmlnjSnH
 f9fJsjVS8lmtRiTRHiERlHHzJtRN3PDrdmpUEK+82YUWZyH64SXVr1U9PR+z7MSRoc4i2M2FkD7
 rrSky39bxZARl4rmv427NgDqbVcDpCDrfl0AF0YG/RwSB3obdWEhBBeEzt/SVkEtYAiyveF12O5
 4d2pRDZWxLkICddqkFQDZVz9bqtU4Q57C2lnrYpu8a2LFPT/+9IMrwsVy8zUSNAFiVSezBgMmC0
 Xt1r8Z3YFwNYH8htqDqcMvGiucj191Zuos9iujS2FlbXpsiY0qbYcBNsKdc63ZeDT7m31Qv8Ki6
 7NZV2rdrVtXa71Aq/Vdsv4uOWeVDl5MBpxzIBE542EmD5mZwr71h3VPInNyavLPlI5DpVn/TnpE
 8+d8Gnz8B7WcPWReVynKXMNku0jgoN8AmWN8x6gxAiBzg1yQT+UHAeGI8nse8ZlvfDmRechMnrD
 nrbAKjWWIP1sLP4jPtg==
X-Proofpoint-GUID: 5BmtF3H9cizHp-nZghzHEgtP563YNYbM
X-Authority-Analysis: v=2.4 cv=MKVtWcZl c=1 sm=1 tr=0 ts=694e56fc cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=xFDkkf_wISTah60zz5YA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5BmtF3H9cizHp-nZghzHEgtP563YNYbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_03,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260089

On Fri, Dec 26, 2025 at 5:05=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 12/23/2025 5:27 PM, Qian Zhang wrote:
> > To enable/disable cfr feature use command,
> >
> > echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> >
> > where, val: 0 to disable CFR and 1 to enable CFR.
> >
> > To enable CFR capture for associated peers,
> >
> > echo "<val> <bw> <periodicity> <method>"
> >  >
> > /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_captu=
re
> >
> > val: 0 - stop CFR capture
> >      1 - start CFR capture
> > bw: CFR capture bandwidth
> >      0 - 20MHZ
> >      1 - 40MHZ
> >      2 - 80MHZ
> > Periodicity: Periodicity at which hardware is expceted to collect CFR
> > dump.
> >      0 - single shot capture.
> >      non zero - for Periodic captures (value should be multiple of 10
> > ms)
> > method: Method used by hardware to collect the CFR dump.
> >      0 - from the ACKs of QOS NULL packets.
> >
> > To enable CFR capture for unassociated clients,
> >
> > echo "<mac address> <val> <periodicity>"
> >  > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> >
> > Mac address: mac address of the client.
> > Val: 0 - start CFR capture
> >      1 - stop CFR capture
> > Periodicity: Periodicity at which hardware is expceted to collect CFR
> > dump.
> >      0 - single shot capture.
> >      non zero - for Periodic captures (value should be multiple of 10
> > ms)
> >
> > To collect the cfr dump,
> > cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> >
> > Previous link:
> > https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnara=
las@quicinc.com/
> >
> > Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> > Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
> >
> > ---
> > Changes in v4:
> >  - Update patch 2/6
>
> Details of changes is needed! General description like 'update' here does=
 not help
> understand the diff compared with your last revision.
>
> > Changes in v3:
> >  - Update related comments.
> > Changes in v2:
> >  - Update related comments.
> > ---
> >
> > Venkateswara Naralasetty (6):
>
> The author in each individual patch is 'Qian Zhang <qian.zhang@oss.qualco=
mm.com>', please
> check them.
>

Sure! Will refine them.


> >   wifi: ath11k: Add initialization and deinitialization sequence for CF=
R
> >     module
> >   wifi: ath11k: Register debugfs for CFR configuration
> >   wifi: ath11k: Add support unassociated client CFR
> >   wifi: ath11k: Register relayfs entries for CFR dump
> >   wifi: ath11k: Register DBR event handler for CFR data
> >   wifi: ath11k: Register handler for CFR capture event
> >
> >  drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
> >  drivers/net/wireless/ath/ath11k/Makefile      |    1 +
> >  drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
> >  drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
> >  drivers/net/wireless/ath/ath11k/core.c        |   41 +-
> >  drivers/net/wireless/ath/ath11k/core.h        |   19 +-
> >  drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
> >  drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
> >  drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
> >  drivers/net/wireless/ath/ath11k/debugfs_sta.c |  142 ++-
> >  drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
> >  drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
> >  drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
> >  drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
> >  drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
> >  15 files changed, 1832 insertions(+), 26 deletions(-)
> >  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
> >  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> >
> >
> > base-commit: 25f833fff81de4fbb9b5382806860b63768567e8
>

