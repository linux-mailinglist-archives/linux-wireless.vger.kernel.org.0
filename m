Return-Path: <linux-wireless+bounces-29822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01EECC4916
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6920C304FFCE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B126A0B9;
	Tue, 16 Dec 2025 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VkrTVqqS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpzfX+6R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128D31ED90
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904418; cv=none; b=ak6m7aqRD/xAKKun8fvrfMEEb/MORmOlDjSnXuN+edYxKQR1m5iixDgny13oWr4wWNejo2qfOjq1vs3FZyjQRLOqzrHNtjLBEwIwe6ZZXn7hlK95IHm5sP6TROt0ED/+i3/o11881Q7pXAuLuYt7amXGsCVG9rNor6JrVySSNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904418; c=relaxed/simple;
	bh=TEEx8ZOIqVaaJXZbASzMWtZGBEUAD7Bnsz8r5TpuRUs=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=ll/FyXkNJadix1PzglPI+9JgVfSK2kea50iKszUANOYOx19LhO7lsRBmISMmUFgmOQ/P9fVtqOkZAsKPhfVuCZDochEN1RWa+S1KD8MsAyjSylXIp0joSh6nREHB92RG68ceHOqkkblBQ/Y7OO73ItCwQrYnYKEAZX9TE+o+Eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VkrTVqqS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fpzfX+6R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGGixp34077211
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 17:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TEEx8ZOIqVaaJXZbASzMWt
	ZGBEUAD7Bnsz8r5TpuRUs=; b=VkrTVqqS7I1H+D3/+E7K+XGaz/Z8EbjK51nmjB
	xbCa4hdpCRvwSIJ8PyhaRWgWCj23a47J1MNk5Gop9HFzTPfm0V/AmzoiwaLC0awf
	uSBRdsiOyZK8n2HztWRWAEcfPW8iHG/FyOnrkc7HPphdNJ9yEd7UI/xR6kE4f5g7
	sXddMseeuJf1Bh659nLp8wXhmpzCnQp35djNCXHV1ZxIPWe7fcL1yWSrwUnu0pUy
	Qk1Jroli5oD2Xp0SU+qZjE19UjEEp6K9lDJoOlLadGwqRm/QTU7TbpJPvq5cnv1y
	DST9k5RgfNPAL3D4p9R2Coz2s0WU8mi8JLP0fHh4RDDvRmMQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3b7g01v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 17:00:12 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-11ddcc9f85eso7821289c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765904411; x=1766509211; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEEx8ZOIqVaaJXZbASzMWtZGBEUAD7Bnsz8r5TpuRUs=;
        b=fpzfX+6Rpyb593NpedQqTfw4mnm3Ad5EK+nBLjPG9QktChz7dKQUXdqR6WfDBkxo+S
         B571Py7E/2hLEZZmu8bprdLX+McX1pXhGXgm3z/IOdGtoSmKqbWe3qU6om/NfqD+PYWX
         Klxw5OZkiOfh4/sq2E9K3wnp1EoXX0IElyiiVDfNZUuhFMl2ZG3Md/dSahfx/WGjZRqp
         ixVLWlTTdW1/wbqEkXAyiq+maQDNvqpcLGuhgKANJTCPuejn/eCabDHyEjVUmttl4oxZ
         YtWmX98TjofwnVtCuxYLrerqr1UX1T2osR4Iy4SSjHQ3fNOrwfhVa6muHsIxAQqjyq7Q
         ltZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765904411; x=1766509211;
        h=content-transfer-encoding:subject:cc:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEEx8ZOIqVaaJXZbASzMWtZGBEUAD7Bnsz8r5TpuRUs=;
        b=JmAEHtGRgd68QVdQ3YTtsYD+pZInR2p64Gzi2wZ8a2QTDiGGLjMn9wn3tMxk5EKJfT
         Svl8Aq5ejjVt0y1AS+pQXtC+tCbcy+mh0Zt8qHeZ0gPrfMRk5AIL0DIe0MTNFJyWcKnJ
         /IlHsznGbUdH2mmjiC4ThukI4RKTFER44sHxRDzRB7URPtqLYxV0DEUQqno9fpo1/3Qn
         5TqdmbuBViW2ePhaPpRVqe6bq5y0B6Cjp/OKJYggdG9Kp4qhpsCuBdrmAoEHhP5LctWG
         uehW2EBYBcCQ3atZucHXteZxtYmgE6TzuwDD+zMCQLrVx3UACSrSjQ4omEN/70DuYXTi
         4Pzw==
X-Gm-Message-State: AOJu0YwqYUqvpkFWOlfPscyZAB1VtlZG2TV12KfplQRP4b7Yrowq/ksV
	vaVd3PtaekuKB+vuWV7VJ10ZsfaWaQ6B7Pr23zQe5za38Qmn4K4pGFYOlr3i2q63I97zM51fX6B
	fMv7XD5KSlArDE7WzCno7sLF9qrcWqpdDw+WQ/Bzy19NNnyfUNI5dWDCm07am5L/iK9+WVg==
X-Gm-Gg: AY/fxX4rn4idJpQwZdOQvCtkngACBr0kDeCygmX/gCt3LHcAImUa4JS8D2eDPyy0Fvt
	ySopIFNMjnuAvQxyOvPuFtmXHn4Aee3DCpKI3dElrY28u+VAcImaYR1QovRiI58UzUWzBilmZ94
	ZNTYW68obhtPsWXXaF3RmZFAJVb27fZw7xB8nmGaEXckCFaOWXAumTmDW/5XRUCq2oLXN6YsEHF
	DuWhbR6KW7NUk1qfS8zt1nMb2lNSGxqZa9lLZJJM95k3MlukJ4OZQ6rrriNt+HYxq7pzgOtFSA7
	a8HTBFLcp+qHoOuC41ovgjBv1KHoLowb3WqIS6SArAuiNZkzRp8rAsPJXT4/WVYf+qLi67gFzq/
	q1lfTXBFcAX6UoQsqGgri/HauoWKGgdCT4obtoq6HcTJkBSvGyXMUE0jqfYIztgXkQD9cgQ==
X-Received: by 2002:a05:701b:2201:b0:119:e569:f865 with SMTP id a92af1059eb24-11f34c15dd7mr6793739c88.2.1765904411251;
        Tue, 16 Dec 2025 09:00:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh807O9wiCy2hOIzivkGcucYDhCOzbGHBxBBe7cIzrKYGT9utY4trJEMwvJscRHXitqTUR/A==
X-Received: by 2002:a05:701b:2201:b0:119:e569:f865 with SMTP id a92af1059eb24-11f34c15dd7mr6793708c88.2.1765904410549;
        Tue, 16 Dec 2025 09:00:10 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e304766sm56584837c88.13.2025.12.16.09.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 09:00:10 -0800 (PST)
Message-ID: <b23501fa-d30b-4ad9-a88f-2c5431b399f1@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 09:00:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ath12k@lists.infradead.org
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Subject: Merge branch 'ath12k-ng' into ath-next
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5N_hpk_B_bPzweM7cN07o6KYYIEXh3YS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE0NSBTYWx0ZWRfX6KKy3GBC6SO9
 fGPHRQdqaENIGRFHR0zMm1OeY9mGPkxoHXEDNSzWLQEJsPDNFhjxvxyLHhqHUdazEKarJr2pr3C
 ycdX3pEwH18vHEhFrnolPrfeD8dqtuL3Chi9++jX0/Nk5QBP8A4ePnzReaog22ZGf5orxkW+Pyq
 WyrFFLJMR1UPNDTI3Ig0bbVgKTGvFF+SsA+NWTiiJ5Fug+euw1zQTOAprGZA3WUgX0qJDm0dtmx
 Wr+GyUYrBTRnYnIXay2Nx/qUZH5omG33AaDdFe7dXRk0ijFyRpWRgphzp2yEvFZfVD6VjVZj63n
 uEHlRkEcHUDRfz/PO+2PjAwRyq2dLFwuoSczsHI7P8PQ+PRjz/R0ECmu1XChVCaZJvQO8UJe2Io
 9Szg58BFTHpr4dLk2q2nTLg4uKIh1g==
X-Proofpoint-GUID: 5N_hpk_B_bPzweM7cN07o6KYYIEXh3YS
X-Authority-Analysis: v=2.4 cv=PbLyRyhd c=1 sm=1 tr=0 ts=6941901c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=u2hKJCGcxp1EJyTXNiQA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160145

As originally proposed in [1], the ath12k driver was re-architected in
the ath12k-ng branch to separate the logic specific to 802.11be (Wi-Fi
7) from the core logic. This separation will allow ath12k to also
support 802.11bn (Wi-Fi 8) in the future. Now merge this into ath-next.

Many thanks to everyone who worked on this re-architecture. Special
thanks to Vasanthakumar Thiagarajan and Baochen Qiang who reviewed
every patch, and to Ripan Deuri for the ath12k-ng => ath-next merge
conflict resolution.

Link: https://lore.kernel.org/all/4a17d730-ede8-463e-98d8-9b0291d0ca45@oss.qualcomm.com/ # [1]

Actual merge commit:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=ath-next&id=631ee338f04db713ba611883f28e94157ebb68e5

Note that as a result any pending ath12k patches may need to be rebased to
conform to the new architecture.

/jeff

