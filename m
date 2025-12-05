Return-Path: <linux-wireless+bounces-29550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C0CA8CF7
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490F1301D5A8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC8346E7F;
	Fri,  5 Dec 2025 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxLv868m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XPMuS8Mk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE692346FA1
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959576; cv=none; b=KmvFfFKCDqWJSkLhioCm4S2sWfRtXnzYc3gp394O/LW3qgtgZEtK7Ie5QBPfqsUP/YKI8FIWR7+GL1GuWX9Js5RWwSL5lZBPco2Bf61ba+zop+tfbU/y/sXeSuPqIu82FI4QYzJfCY0SANoVJ/R8eKpP9ut5FcE1puIBz8XagIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959576; c=relaxed/simple;
	bh=jdIKuAnog/XcSojsYWAamVSSCl3gzVoBPn7nGj0Ed5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPK7aFy99Vz+qAD9SzqpwFyo+SMze6nQKtNBLLMNHoXpkR0DDo/AxtTSM55fRLPfOIpcKwRi/TJSjxW1vofc3cMRtBMQaYGPnTFhofvY+8p2JI9+cBJ9P1XIWg161gj3uRPOBdDLttGX+re0WntlEOslaq1Y0J0n9uJ8JbVRg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxLv868m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XPMuS8Mk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5FBOuW1255878
	for <linux-wireless@vger.kernel.org>; Fri, 5 Dec 2025 18:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EsAN77b5jlhTs52JfrYgOkM2
	xokQh050KDwqvxtezf4=; b=OxLv868mO/YqXAp+QmHwTnhQaTowfZihrImLFYR+
	b8Z8x/ewGBmOZGkUHHGSsA2CcvndMtvDHXTHB1letNOVkH4RvdlzyUmjol9qAsQ3
	CmFj4x+MsfyIOsCseUQSWIbyDRfdGE1HsGV+9xXUvQNwW0blpwcZ52E1AGe5c189
	M7yZBwT3h75IUmXS8sYqV4yz+hrCrbkvQ91767ePR2faSojIhg8WozMbc+/LN/Nz
	5iwmK/MLj8rS4Sad74bcoNSAbc0qxueQnnsF2c64IZnCauNPBLuwLcRVr1b1GtQ3
	Mwa3qfajp6tIWTJMN4UONvzP+tBhlu127Cy6KOBCuAV+Yw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aukmj30d2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 18:32:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2dbd36752so485233385a.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764959567; x=1765564367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsAN77b5jlhTs52JfrYgOkM2xokQh050KDwqvxtezf4=;
        b=XPMuS8Mki3iEb2HSbVSxBLZ45opwc9DeR3ete7YxuGQrIA4Q4pbbkqgmZCu5NwxNuS
         yGPhU/7O7FZqGai6eJlypYlM9ksOtwzn/Z02o1yTYEbv/jkeAi33euIgCNbgNnRUI+AR
         yo1g0pLZosDEs4ts6zIXroTY/Vwj6Pd54cwXRqpkpiOlzszQY49+wZjXVxJ6yhyNec31
         qFKPGVBCjR5CIWslrTUlyycI9xMj2eSbTy6DALJSlEVMkd01+L5G5+ocSDAVCSYLF93C
         zf7zTPwK8DNfXcWnMHkYmuzgNuRj9lLR03oM4qCa+Z5zOBKYHJu6ABs0mmpYfm18E/y2
         YEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959567; x=1765564367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsAN77b5jlhTs52JfrYgOkM2xokQh050KDwqvxtezf4=;
        b=Zbow7iu/Z2R5Xd2X+tyVM+xMEW3xz0XvAZ33tretdPcE0IWU7ZFIO7TXZhEu6FV/Qy
         VPorBZhDCJwjeQp3EFeYAPYwRkCKBtV0hjzOnV1QIHUW0Ue/IO8vS3jH9Kq98J+9KlGx
         BLoZqIMN/Cog+XywJpoU9yffIT+f3AqdOTiVccnmFzMZbo8xv9yamHDzhncBPNT4CwOv
         nqQRxbt6RrlKm6aGQI176RFmzmcCaERfgQP6mg4lvm3L0yai3ZvgRiyaEBrw3HwtFBxX
         LfZCQxBv0Ut5M3ScvZJaoMg7moaecsWV4TaxwY3p9RmLtBaJ3gty05TgsJehyBinbKxw
         LuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOHd5E2mNum+Xz5yNtstOYRvjnTqVomXWJJnZ4SdbOmUWkaIrrTw2rZUmPio11UPgPLMvNmkf44j5+s9BT6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YysmBPiXznY1RUGoFi5LVqDCSfNOC6V3IO/huazb4UFjm4JU2jS
	w2uGcX9PBgr9LEy3NQ9XIyQIAsQHxviLnodfIFke9oTelcHJx4lSjPho39It+HTUMU+KvO94kty
	09ZLvxJTXVXbIun7bLYdozVs1G5vewiOOB8MZmrMjRjvLv7JLF4rMqmlMlYqQm/7WmkTxKw==
X-Gm-Gg: ASbGncv6mak6ikm6VExlgDuFTaPtqHyk9bhOhAEy1PwsHQSLEocqXt0cBEQATnTN7lZ
	nzS/UIm1v2o+A7JZB3E6dtenuMr1SnRF43lMpysfAs1BPTtrDkW0jLdAPcmjmgRQJ22+SP8wgLd
	vfxjlw5xKrtqi8xG+Q5t4/D/4SMpCmiA0tsIc195C7dv/d3+pRsbiM4c6/ar9J9wAQLe+kF1mSA
	mZx57lrC8RP5yGRnrjuLjdB9uOIKxxOaqEkrblO1PgozP0gkRuQN3mcb2LR4Ing7oy4wx935qGQ
	WYgbuR0zs3vvAYIBuoYxnkg8MAfLnUVhuq3k4wS1kNm3KuXgJgsbZ5N0VeCL/COEeDLxyHMRukP
	CyEmkpJ0h97PQWgfDM9OuKzRKgj+LBE9rUzmbpOe9DdhmN1Y2p8aclI80XAZjIQbpJKqqqlZGcm
	fedQufBxZsszLCR3rBFegVuPE=
X-Received: by 2002:a05:620a:4095:b0:8b2:5df1:9341 with SMTP id af79cd13be357-8b5e7451b33mr1656360485a.75.1764959566954;
        Fri, 05 Dec 2025 10:32:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF083DzGWn2LEo8Ae9UWqRNGaIZu8Bc7SHuw0in/lgRyW4AhyA5NMTa/wtyUxLpleFgvwoOSg==
X-Received: by 2002:a05:620a:4095:b0:8b2:5df1:9341 with SMTP id af79cd13be357-8b5e7451b33mr1656356285a.75.1764959566491;
        Fri, 05 Dec 2025 10:32:46 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c27f0asm1710142e87.74.2025.12.05.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:32:45 -0800 (PST)
Date: Fri, 5 Dec 2025 20:32:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20251205
Message-ID: <ggvvbyrdqvbjjf5kxvnzswwpkzsbnnjc5hsw37qreyrekheoze@p4iavaks7rmr>
References: <f4e1e95f-672d-418c-9f3a-e47d01a1fe91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e1e95f-672d-418c-9f3a-e47d01a1fe91@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bYtmkePB c=1 sm=1 tr=0 ts=6933254f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=BankifvHBk-6wX3BIUYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: kmTilvJHwUCxQgb2i44GRXjJ2b7Xvx6L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEzNyBTYWx0ZWRfX4Cfy/Mn0o84y
 LTYhXAYuLZioDNfPEp1KeXZaV/Qf1P8QIXIndl37gzYm+Y6gRWLxboAORUOrspvt47i1wpN5xiz
 JIVNx9vDSFwBbaAFeGI4TL7IHVC75HefOuXEmruJnxOdAygtvjRDDHgT19iA2+eG6mRRui9sDKE
 Oe/Swa+gxkovRA6syCJI+mbK9TgW2hWp4G0B9dY39dTpaSu7P9BZj1eCW4U4LPatp20em6I6a5y
 LcSVqq9OJkronfwiiMBbwK2MVROnohHEhh4ww7z0UDHMT9LGScP8EHxw3w29c58+WcqT1PAozUA
 dEG9mx2d7PBJJVZ0haaI5ZcGCOmNtIuLh2jETOz5TEPh2STMMnEPEUMfW3P6MtpYJ2ksiJ6hzXP
 dBvtdsO4pXl7xFlv9wi5qsVAxyM3sA==
X-Proofpoint-GUID: kmTilvJHwUCxQgb2i44GRXjJ2b7Xvx6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050137

On Fri, Dec 05, 2025 at 08:30:02AM -0800, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> Only ath10k board files are included this cycle:
> QCA4019 hw1.0: Add Netgear LBR20 specific BDFs
> QCA4019 hw1.0: Add Meraki MR30H specific BDFs
> QCA4019 hw1.0: Add Meraki "underdog" specific BDFs
> QCA9888 hw2.0: Add Netgear LBR20 specific BDFs
> WCN3990 hw1.0: Add board file for the Arduino Imola (UNO-Q)
> WCN3990 hw1.0: Add Xiaomi Redmi K20 Pro/ Xiaomi Mi 9T Pro specific BDFs
> WCN3990 hw1.0: Add board file for Huawei MateBook E 2019
> 
> Please let me know if there are any problems.

Thanks, merged and pushed out: https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/819

> Thanks,
> /jeff
> 
> The following changes since commit a0f0e52138e5f77fb0f358ff952447623ae0a7c4:
> 
>   Merge branch 'amd-staging' into 'main' (2025-12-03 21:05:40 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20251205
> 
> for you to fetch changes up to 05c97f71a5336854054db1dd4acdaf68c5b7c144:
> 
>   ath10k: WCN3990 hw1.0: update board-2.bin (2025-12-05 08:20:14 -0800)
> 
> ----------------------------------------------------------------
> Jeff Johnson (3):
>       ath10k: QCA4019 hw1.0: update board-2.bin
>       ath10k: QCA9888 hw2.0: update board-2.bin
>       ath10k: WCN3990 hw1.0: update board-2.bin
> 
>  ath10k/QCA4019/hw1.0/board-2.bin | Bin 1822336 -> 1895232 bytes
>  ath10k/QCA9888/hw2.0/board-2.bin | Bin 218596 -> 230744 bytes
>  ath10k/WCN3990/hw1.0/board-2.bin | Bin 670116 -> 742192 bytes
>  3 files changed, 0 insertions(+), 0 deletions(-)

-- 
With best wishes
Dmitry

