Return-Path: <linux-wireless+bounces-23813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D56AD08F5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 22:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D55189E9FF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CAA221DAC;
	Fri,  6 Jun 2025 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iCdmUHjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4A221269
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240639; cv=none; b=TGIw6BW4kMkqlcLFRiLhRgVdMO8VpS4OZ6sLsbIYMNmtB3fZTIQqI4aN+5wrhLNjwi5pgYLyFZT2dTlT1Y8JJvne5JBRvdLw8xPzEoPQXDKcuX2P4W6xCFgEWpykVoNA9vXjcRmpPVrLaJrh4NmvNEVgVqXL3Vn3QhH9UIzzXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240639; c=relaxed/simple;
	bh=GR9GNd7G/RSaThcNFF4SKH+7F8QY7LTL7Ul+a8hqAJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqZRNq+14Hl4Q+ijAbYxNU2X16U+1KH1KwQLuSvKAgozmnSU1Ve44lwcHMRKkJArYQMVXTNHmtZhhXmgtxHFcQH/E9U+bauXjHKg1gYKiJ8IhVxy/sOw3c8ocNCzY0BZ8xwLjci63HZz7+bDZxhon8cOYR1E1PDBy6Pad0Fs7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iCdmUHjy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F9En1007904
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 20:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/XoDUDBk9akkE3rW9BHGzxNajsChtJR+CqYJzQpMrw=; b=iCdmUHjyTVMyznVg
	jGtppUYZnXkpDCvLE38O9w0C5wBwSxrk2H5rM6ufd/4HhcCZ+fSTq3jhMuTA6ggs
	RsrfLX4/ktSmHRlSYkCNHQJ7ghqexSalUANsjUbDKgeSi7b/pcoKZuE6HnKdaU3A
	IzyA0zJPcr13q95a6yOM+FNihC59GX3fdbZgIhwOTBDnSYDVfESNFhcoh28ONtyJ
	LbQvF5a2RlaRz2LDBdrAadYIY9H+bFIOE8AqXvxx6fiumX91D/2gqQn2Gzuvu6nd
	85xAY19IHnWEFksqd7qheUIEpSXxSIIt0NMl3+5r5MIqsgr/Gze0rl1C1k9OI1xB
	KLQA0Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 473nphtppm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 20:10:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so1855941a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 13:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749240634; x=1749845434;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/XoDUDBk9akkE3rW9BHGzxNajsChtJR+CqYJzQpMrw=;
        b=WjaJBO9kaZlrQLgI/5HWKlGgJFdcclIL90HxSo0OI5rr/WWzAAljrHk4/VQs+3jkc0
         +3Ov1UMlxw+vOsF4n89UTDd+jr6cNHKG9pOHMqAuYD+wliwYmZV52dKj3jPgxeWmDVpt
         VTjqy8mXco+y+Hdty7X0MoSl8fyto852N/150MnyTW4dMm/dioaiSFdpFgPKw6fJUgRp
         AMvFGxhUxjHEembvj5OFVI5RYa7BtW+6yA+2ej730ajntCNRpak5qXEc6p9UpcMVBebX
         RQkYCKTm4YYiEroSuh4oDdfva8+VuN4aSEOJ1hUXC7KuDZyT5aNME9Q84WV7xL7QoRTr
         UsHA==
X-Gm-Message-State: AOJu0YymdgVyc0gXJOy1n3q3n+ogM7S4YV4zEjMzLMcEraSn/A4DK0ir
	7K/ATh/HHOTPm/Ihho219Y8D5Axv4ITee+MwUbW3rJQmcnWGPjoXhMn7NbTb6eSO0HPYAYPphTW
	hfy/w7WIuN2uC0Xb8buC++yNTNqHDdjdjor0ngmwmax3DGbxA6aqYx43mO/OVCapgwq0vdQ==
X-Gm-Gg: ASbGncvrjyd42LqOOWuG+DY+vUJTPbTh8zf3H9mU+PjIBfh0g75diAIwUrkGWrTTM+H
	udjJjAcAI0bLuR9+8SzZUpwUuW01dcSKanc90oGRUxydEjJY8/A8Hkoua3yRHgRxR4xyYO09w9H
	InhPmBfuuhGbyiq9kDO8CHsdx3X/NPZWVLVZOedO/3HR07rYZ1zEVT6A7mlbMl1o1befRxvq6Lv
	rCTNSl3qKfD1dE7SQa56CLsuVEBLxkIzwnRLJ0c/jCuYmA9pduQ9Wbl6yqr+DSMAxTcPwjx89NJ
	TbtC+lCtE8HyD0Pd1yd+1qyf1tnNDw6vSQha2e6NT5RgWibbv78xPgc4mxsXXtm0vMWTNWxDkQV
	Ef6yL
X-Received: by 2002:a17:90b:544e:b0:311:fde5:c4c2 with SMTP id 98e67ed59e1d1-313472b5a4amr6713315a91.1.1749240634261;
        Fri, 06 Jun 2025 13:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlsRdQ1XO4Bwg6k6mOZ+8KmtOsn6/p4bkl/uU7TMeF64H9p30YnRmA2nNlp8Om12iFkxGGKA==
X-Received: by 2002:a17:90b:544e:b0:311:fde5:c4c2 with SMTP id 98e67ed59e1d1-313472b5a4amr6713272a91.1.1749240633811;
        Fri, 06 Jun 2025 13:10:33 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f32df7sm1695741a91.15.2025.06.06.13.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 13:10:33 -0700 (PDT)
Message-ID: <1d552523-901e-409b-b15e-b2dd94549417@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 13:10:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: Avoid vdev delete timeout when
 firmware is already down
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20250522131704.612206-1-loic.poulain@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522131704.612206-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PNtrE3zNeiadGr7NH2w0EKnh1i0JtGSU
X-Authority-Analysis: v=2.4 cv=N8QpF39B c=1 sm=1 tr=0 ts=68434b3b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yQ4uHgFH2KKLFym4FOkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE3MiBTYWx0ZWRfX5vZJneiCEHJC
 AIeLTLcOEevLGXglNjeObLAq2Cf5QCM5xkIQbQQxp7qmS8BvjygLb2xu4LArhHIZs+TtHv2pEni
 6EQc1ofKEeQf2Z+pAeDmBK2pSRlzHxhUn3pnq2rOmIJZl2F9/4SvWqwo7j2jNsBCrhr6p7XbyRa
 XSDZwU6kFphXN0wn7v5QTKwIh1EFlVHzMsYRoyrRqQtYm1fHx01xPtYGqYbaFob0JKwYcsC1jRj
 CRKiASID0e8XfHFKnTbnS2pRzh/bapqMxfZdKnT0gwsqJ9Xm6yk5P6U0hOdhTxcdB4I8m6z4izV
 htyjUbgYEkjyYaT45HavG5asDECn2yry8at7GOAMgk9Sj1ISBTLi9HADPn1RTzHTQ5mcf0AbEGf
 hlDjMSuIGarh8VsvOiP3IbuJijkfQ0zFGV2utMPT5SaPgnEnaw5bv2vlX5jUr1yk7ja6/tk6
X-Proofpoint-GUID: PNtrE3zNeiadGr7NH2w0EKnh1i0JtGSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=978 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060172

On 5/22/2025 6:17 AM, Loic Poulain wrote:
> In some scenarios, the firmware may be stopped before the interface is
> removed, either due to a crash or because the remoteproc (e.g., MPSS)
> is shut down early during system reboot or shutdown.
> 
> This leads to a delay during interface teardown, as the driver waits for
> a vdev delete response that never arrives, eventually timing out.
> 
> Example (SNOC):
> $ echo stop > /sys/class/remoteproc/remoteproc0/state
> [ 71.64] remoteproc remoteproc0: stopped remote processor modem
> $ reboot
> [ 74.84] ath10k_snoc c800000.wifi: failed to transmit packet, dropping: -108
> [ 74.84] ath10k_snoc c800000.wifi: failed to submit frame: -108
> [...]
> [ 82.39] ath10k_snoc c800000.wifi: Timeout in receiving vdev delete response
> 
> To avoid this, skip waiting for the vdev delete response if the firmware is
> already marked as unreachable (`ATH10K_FLAG_CRASH_FLUSH`), similar to how
> `ath10k_mac_wait_tx_complete()` and `ath10k_vdev_setup_sync()` handle this case.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 32 ++++++++++++++++++++-------

FYI per current legal guidance I added a QTI copyright to this file
when I pulled it to ath/pending:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=b9193382408c8f4859c6401bea9c028d8a601171


