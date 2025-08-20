Return-Path: <linux-wireless+bounces-26474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E33B2D9FE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A56859A3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C4A2512E6;
	Wed, 20 Aug 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zhh5FXxw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854E2D838E
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685770; cv=none; b=FesTMXRfnyupYv7UFxzXBqqXH5BbLzUyAO+Y3p/xqQd2bSTdkN5ydAuLmqEIN0/FirYy3+OlqfVPEpSx/4BT7P54FMTNQIsgM5sxq8LoTp7r0y3kJm9PJqCZz494TBpxXEUlD1hOigq/yqwvLyUkhfB1zF+ZDIZ6hEjCffRd/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685770; c=relaxed/simple;
	bh=W9mEWSNQ8m436jCGAC5XKyXkcVMAuJHJ9+sJFcM5fgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVP3fbpbvsI8DIzTA9RuEfkOQPJ6JuyqwMgdzmKvWuEiLwjNFcR/SqBKa3hYaKtEYu4JU9lQwxUcNdCLkXuqQyVBEbQnZhSaUDyz40vEr+vbRLSaWvwJWewd5vFQWwBv/2/E1eCImUOWWJRv9peB8gaqUc2eErQKNq2trq8HeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zhh5FXxw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA7Lqm011391
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 10:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fRW9kchawj6P40fyxmcRiMMjqOd0SQuNWwNOjUiW/WA=; b=Zhh5FXxw1TmeKj0p
	LnN6O16K5tjkZ5o0Z7Ciz9dXbkKLOShkYphl4lResk+t6T9Q4TIszyOXWO82MNlX
	HOnB7w2gfUlBO53c/38G1nCR/GRTNSTqqB6f9KVDuvzjuGQfpbYtfCV0OERDDE5e
	cXXiBRNa8yrP+9rpeq+g2hvPCRr5xUMecuzNwbouZijDRFniVsdOzaqjuw6lSSDQ
	FYOvbbEAPmU2oHGJVWZgh3MwmeOnHMhYOMxCuh2z+WdUNo/bClrhHX5PaACTZ8cd
	erhUm/ka3XIF7EhqzdLA5P1g2AjaVKbaKL4ewEmPy+1HSUYoZrwKeXeeIdrFQr0j
	1IoMAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52bhd8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 10:29:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32326bd7502so5740942a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 03:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755685767; x=1756290567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRW9kchawj6P40fyxmcRiMMjqOd0SQuNWwNOjUiW/WA=;
        b=ubACQCilcdLCn9kz1uiQysIYaOCqldGjRUQi4hCE2+pceEn0e7gIV8K0ukR3wwmO1t
         NliaJqBeuRgYiGgvs3/2z6cdAfFhxP5X85+wkidFDjB+9CUPy3BsAV854VdLpwM7nd1p
         X1BNSzUX15KvY9UbHHDM3Pi97jtsUpw40CoUAVV8AUwVFpbl50H8Q3oA6qIPhEjrdv7v
         bbrztK2PL7WLMCeKcy90806svY+SYRRrBDf5jHsKald4TwzfvLg4QYva5zN7a5eRG+bF
         J8cr1jgjssLnKLvoB+FXoTSCFmfOvZmcglznGF+xWGZwbu0Qek3Kr/MGvjEgEkAYeUVT
         3AdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9wnXXdGEXN6oSvBnHuSkV1MIB+88U1LrF315qkFttFpzLKVvpIl1OIk7uEhbriWHFQh/k40iPgJE2iMVM9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VI2kGSwMY5FqH8VPfUOU3Y0td+TBwmLv7ADfwjlYLRp70ain
	bdXMhjZ2qwyAbbndJv1z52x1iOZPTJD/gPVJORGRRg/WtLbAgQFQgQVB/Gez6qpyKJWbhvAZRA5
	Xgx2AeqE8wGhSL3kSZ8BE5LByZcgUYGyi+LiDmefDD3BRmcQ8mPDdcKedCooQZwvVnhIlBQ==
X-Gm-Gg: ASbGncu94qEC75Zlb5eSydaOpXPooB/nzoMo2ycwQxenOX8+piww1fkEXqONCXA1BF1
	f6CMxakk9OsQsYVZd7tfZPCw4ct0fwQbVyGDL6dRg0MTHq+NMllPBCVYNLMaylSpDHgIdUmc09C
	FelJUCIAhljpHNcgXd0O3XzszzutZWC8YI3KPGW23ErMMl4lss5XWzVtYfKghsBKB14vdhoERxG
	f0IJR3cdO49+e3fH+GCDFARlmRWtfZaUNVEzoXKYCLdncy0dge9iH+XiuXcklsFksgAmIKemQhY
	7n7P6JUfCxRtEdtU0yhc6W6mut3lvbFaTf0tNXwx0Dp7Jx+D5fjKzkieCLT4AobMbECeeImCNS8
	+iMtX3aKKOuI=
X-Received: by 2002:a17:90b:5388:b0:31f:2101:849c with SMTP id 98e67ed59e1d1-324e12e2822mr3465719a91.12.1755685767126;
        Wed, 20 Aug 2025 03:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxdrz2WGofSLyKj6b5aAPoDJV8+XutugfRT6KDyoTu39P+ltuXKjvdVJTwEqnYbI19KzygBQ==
X-Received: by 2002:a17:90b:5388:b0:31f:2101:849c with SMTP id 98e67ed59e1d1-324e12e2822mr3465651a91.12.1755685766513;
        Wed, 20 Aug 2025 03:29:26 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.248.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e25532b1sm1932700a91.13.2025.08.20.03.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 03:29:26 -0700 (PDT)
Message-ID: <127cb2e9-5371-21fa-1f09-586e6770afcc@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 15:59:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
Content-Language: en-US
To: Balsam Chihi <balsam.chihi@moment.tech>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        jjohnson@kernel.org
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
 <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
 <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com>
 <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
 <69f3fef9-017d-86fa-8fbb-2ac2a1df8ae4@quicinc.com>
 <CAONkfw4cQktTqR6e3PGfVhGQPsqPctwjwLSPjdiAvm45tq5qEw@mail.gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <CAONkfw4cQktTqR6e3PGfVhGQPsqPctwjwLSPjdiAvm45tq5qEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6XhfCOQFrxN0
 QQtOc26kc/EGTTwwTQC+583a+XMynslijYxXMgCOAdwIT765nFrfBf8CHo/qFlqm87xHjYEdDXk
 1ss97YRVmo4LZp7YdYfT+9GPOTCTCJFSwGjY0bSyyOghfNtm714/500OrOPrRioE3cq3A3pcSDS
 wn8ThQBb8sox1XLx8UrME+H0C1gmTsLBRdm2g9/zuZF+LUTe8Qu7BsOi6NkDdOyKlDlxOnvKUzG
 dlTe6mxESMd1mC7YZBu1ekH24QtbG9R5E8ud9aZzP0pj/HaO+FJDGZn8cFClW/qeJfqPdmgIhsZ
 b8rAwu3OOcwtIL8QiN2hdsgrO4njlcJBr8qT+BLgREmVrzoxyQVNe0Ilk5M9PqJxO26ozZltbKT
 K0YcF509Bzy8zziI3Ag3IMFWhY/kkA==
X-Authority-Analysis: v=2.4 cv=cr3CU14i c=1 sm=1 tr=0 ts=68a5a388 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=pagehsHO18wfKU6DcLw+7w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=YwNWzT2bHXl3X7RLWIYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: e2b6Eyd4g21ZxPuNDZUyumBHW38lSTDM
X-Proofpoint-ORIG-GUID: e2b6Eyd4g21ZxPuNDZUyumBHW38lSTDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/20/2025 2:03 PM, Balsam Chihi wrote:
> On Wed, Aug 20, 2025 at 10:03 AM Vasanthakumar Thiagarajan
> <quic_vthiagar@quicinc.com> wrote:
>>
>>
>>
>> On 8/19/2025 2:20 PM, Balsam Chihi wrote:
>>> Hello,
>>> I Have a question on the same subject but not related to the bug.
>>> I have many identical PCIe WiFi cards on the system and I need to load
>>> a different board-2.bin on each one (1 adapter per frequency band).
>>
>> So you are using multiple pcie devices at the same time in a system
>> with ath11k? Wondering if you are using any private patches to address
>> QRTR instance id clash issue [1][2].
>>
> 
> I'm not aware of any issue of QRTR instance id clash.

Then better take [1] for proper functioning with multiple pcie devices.
The other one requires a new firmware feature flag.

> 
>>> Is there any kernel built-in solution for that?
>>> I could not find any, so I had to create a patch that loads a
>>> different board-2.bin for each card based on the pci device address.
>>
>> Current board data selection for QCN from board-2.bin is based on pci+chip-id+board-id
>> combination, not based on pci device address. You can find the chip-id and board-id in the
>> debug during QMI boot stage. Then you can use ath11k-bdencoder [3] to encode those
>> board data binaries into board-2.bin. This way you can package all the needed board
>> specific binaries for a hardware into a single board-2.bin. Ath11k board data file
>> load logic uses chip-id and board-id to download the right board data for the given
>> hardware variant.
> 
> I have multiple PCIe WiFi adapters based on QCN9074 from different
> manufacturers.
> The problem is that I could not distinguish between them at the system level.
> All have 0xFF as board ID.

Hmmm, ideally it should have a valid board-id other than 0xff.

> So, when loading the default board-2.bin they behave the same way.
> When I contacted the manufacturers they sent me board-2.bin for each
> configuration :
> 2x2, 4x4, 2.4Ghz, 5GHz... (maybe calibration data and more?)
> The default board-2.bin for board ID 0xFF does not support all bands.
> My requirement is to have 2.4Ghz band on slot 1 and 5Ghz band on slot 2.

I can not think of the cleaner solution when board-id is not programmed.
If you can make changes to ath11k driver and your system has device-tree,
may be you can add a hack to pass board-id/chip-id through dt (new dt properties)
to driver. In any case, you need to encode all your board data binaries into
one board-2.bin to enable auto download of the right board data into firmware.

> So the patch reads from rootfs a text file named with the pci device address,
> the path to the custom board-2.bin.
> 
> P.S. : qca-swiss-army-knife did not succeed in decoding the custom
> board-2.bin files.

I that encoded binary with TLV for each board data or it is board data
binary itself. You can run ath11k-bdencoder -i <board-2.bin> to
get the information about the board-2.bin. You can use ath11k-bdencoder -e <board-2.bin>
to extract the board binaries and json used to package the board-2.bin


Vasanth

>>
>> [1] https://patchwork.kernel.org/project/linux-wireless/list/?series=692423&state=*&order=date
>> [2] https://lore.kernel.org/all/20230111170033.32454-1-kvalo@kernel.org/
>> [3]
>> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath11k/ath11k-bdencoder
> 

