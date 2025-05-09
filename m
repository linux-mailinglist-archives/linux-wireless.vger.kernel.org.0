Return-Path: <linux-wireless+bounces-22798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36FAB1B86
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 19:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACBD3B98B6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA8238172;
	Fri,  9 May 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aq4RSGKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CD23183C
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811620; cv=none; b=odrNZ4UErymuikLAGoiF/tUQJAK8/stmt4z9+SNhotFiXXso2w6u4Oj/FhmZdWC0FabKZDh4Z8jinkDQJp9y7FK7UnvSvkrQ0U6oKonsunnZixDPCrQVbpxLlXapyxFQNnlA8pxDHyQOWb9FVQ0Usni7bOWCkvrI6UX45PAt5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811620; c=relaxed/simple;
	bh=Tv51iCifaNwhYZxM7lUUyAfZ76kxlBfYATAgonwaBA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwpV8TLZ8uWXlZjRpcLyPlCE5vgfgMTQQ2H27T33MFbwtYRkKxWI4HRm0GPoBD6VgxgT0nL6Ok77VxwAQH+fWrhqFH1l5sgnjWhVVuWbcWlSQqEnkBzSLOy7Eg6ZgM22l52RO22SwQ/gbEB+CaIWxcsBrUPpAfdWNcgHnNa9fvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aq4RSGKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549BpLJ0010664
	for <linux-wireless@vger.kernel.org>; Fri, 9 May 2025 17:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1wUapQOrEwYp132n33ZM87lG9BL1ZkFAOuhX9RAXCbY=; b=Aq4RSGKNLykYMGhb
	WB1R461DbyFBxyBfcmhQwSxqHNxGy+pFCuY1W8P9s4hbOleP/H952SCIo6J/w1XJ
	bOvMxwWaYWl176wqbjc5VEsv2Iebf4jpgNjmBzUMSe4BL60nVk0+qwFG6rKUjz2J
	nnYVQLDbTCkeOuxTX90+7W6zTvu1LggPip8JM2HkyJ+DgwjIl+2ao6uYZUvPTAPJ
	fH0U1lRLMiA/QKbPLMTYw8FLNWog6j6zPhukOsy3bEVxxO7jpVDWV0R0ktDDKBRQ
	D+1KBYUcIyfaidBCArg+VtwU7R2BlBjv8zTtsoOn1Lfm+EGnBbgxJTurPomu4gfq
	5b/MIw==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpmnd3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 May 2025 17:26:58 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d81bc9b763so38102455ab.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 May 2025 10:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811617; x=1747416417;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wUapQOrEwYp132n33ZM87lG9BL1ZkFAOuhX9RAXCbY=;
        b=RKz6V8YkqwV2EWatc5mSNeS+CoEVMbSRil/Sjn56ueJc9K5TFlsrgdjXRuSW1qbi3k
         XUYHjgvExusshtTpH6DpF1A4i2Q3hz57sed1eplB2s9UJXnq0YqouOmGBtQkrsM3NhiJ
         9/egykxG6d2Gq+wf8U0xd0tLAki5+TrMQtPlIOY0N3z+dlpqVCxRIWO+C2UTDpdcmIKm
         SUW5C8SbDsFtedwjqlR9r0QOugrzodFSJ9BtGLPybFfS5nJ1UM2lQhlLWnyIgKQD3EI5
         u6v88kmyF9H0QikfNeRlREurtcaCQ7tMDoMDoXlbxedmpsZVXppHAWuLBEzOv0ZBPCu3
         5mwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTNPYMYZmXyBByLzGgNgABPqZAXWbnZaDTAye+7yinFOhqfXzx/IgQeEpxDK+7VnJZzuK+Or9re+MXrIf4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWBRaP0byufqeYUTgSqhDLm9GrwotuaS2pH1HKsx8e5C7seks
	s2g8JGbaldaw2nzBP9u6V/TyBRsdxs+L/H9lrl+mIpFKrgv4uJcLhr/Qe823aHiUhn9S3LjdvEF
	bM3YkIU918r7A6kFZnI+6jbFVZ0D53ZVz33osd7vfSpBglTiMkwqm7NncI6hZwLTZq10Gs2UFMg
	==
X-Gm-Gg: ASbGncsAriYEBV1atGU7v0KclEX8j8GM6DoI0oHT/+G3Zml5fNYELZPPVQ4i3lZ8vB1
	xIk71uSAnO9ObBZ4qG3IlnAcCN/w7zg7d/aIM+xXz75hFOEpp5pupViNWhBzdb7DRHNXvGNTKzw
	SjMegjYxeU8/gg3mddUbWAvmIGJu0C/U8FkqZvtJtFykC3XPXrPZTjUyFNFNoVnsp4t9ymQM00j
	s4RqmPCzwoX02t6v86QH5QQsa5/Sq++roY6qdre6G6HhK78HRMvvZ6fYOX4bkW0shrl2KGg9jOL
	jQxUSBePJvkdKmIvflXgVOP2xEMGopzWnSl54h885szE1QTSHuhr+tp8N22ekon/n9jCl+4kahS
	w+UIm
X-Received: by 2002:a05:6e02:398f:b0:3d4:e6:d872 with SMTP id e9e14a558f8ab-3da7e1e3ab8mr54625325ab.9.1746811616810;
        Fri, 09 May 2025 10:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE07AB4b/+Pf4nyMGbIX4jP3EQyt3RqCUIg7THoH1pbvrDKMFpM29PCxiYGbZo0g5pPaPC2Bw==
X-Received: by 2002:a17:903:32d2:b0:220:e5be:29c7 with SMTP id d9443c01a7336-22fc91a1e83mr53377865ad.39.1746811606037;
        Fri, 09 May 2025 10:26:46 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb42fsm4697857a91.40.2025.05.09.10.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 10:26:45 -0700 (PDT)
Message-ID: <a3d69b71-d204-4e4f-b6bd-d7e80bf7b546@oss.qualcomm.com>
Date: Fri, 9 May 2025 10:26:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issue wth ath12k in ath12k_dbring_buffer_release_event
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath12k@lists.infradead.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e26e4e8b-90d5-4543-af0a-ba5cebf516d8@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e26e4e8b-90d5-4543-af0a-ba5cebf516d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TpjmhCXh c=1 sm=1 tr=0 ts=681e3ae2 cx=c_pps
 a=5fI0PjkolUL5rJELGcJ+0g==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UYGBsdy-ktPGMqgawXkA:9
 a=QEXdDO2ut3YA:10 a=HaQ4K6lYObfyUnnIi04v:22
X-Proofpoint-ORIG-GUID: W4BEk4hRlKI2nz_KbssNtYnqdVBM9bf2
X-Proofpoint-GUID: W4BEk4hRlKI2nz_KbssNtYnqdVBM9bf2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE3NCBTYWx0ZWRfX8EQWPmafAInz
 +1w/5tJRwJ20RVimlyDeGnuchqeLpbQjYlcmgn1WA89Lf+OzP4qVX4+ezgIU7TmOmPTk46E0Y7A
 EuDhc/hpzcPand0h9PvMxtj/uj2hRdUL6G01pXN2Ec4L7okHetw+YjOMc22HeXowGeq3RZX3cTW
 f+tUtgWDoNWzEH7W+i96S+D/lhec31on6dwroRf/OvVCF8gFfH9NEr1KTD7iAGgMm+Dn3hveTOl
 chyTHLVq29ulE3atFbQ6LKHdje3Uw6THlDM2rsacH7f938NtbRuRz8uppmJp4faHzgtnnV2MUgf
 ozDyGUs+rvvSaWU6tLuFyEV9Ul8iK3BqcJx+JSW1hJtPke8uozS+7oA9IrMPsP74hDosFSDcf0r
 zkpNDcgQmYL3075iAGHZrfuMBC/+qR6KkzyfnNaUMsb3KWphsfU1zgi17qw3FxLpfI6hcWpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=787 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090174

On 5/8/2025 4:00 AM, Colin King (gmail) wrote:
> Hi,
> 
> In drivers/net/wireless/ath/ath12k/dbring.c function 
> ath12k_dbring_buffer_release_event() there is a large hunk of code that 
> is never executed because ring is NULL.  The code that is never executed 
> is a fairly large part of the functionality of the code, so I this looks 
> like a bug to me.

The features which use this functionality have not yet landed in the upstream
version of ath12k.

/jeff

