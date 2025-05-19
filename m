Return-Path: <linux-wireless+bounces-23163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E2ABC5DE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797927A2230
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECA28980B;
	Mon, 19 May 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nBAZIacE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AF289359
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676896; cv=none; b=M1GYFKnGy2lF59VIZnwGyigvZAXkSniBQFLfqMDEnfmxoVIqxULQUDAi4Q0x15KQvedNl/1/MIJa+kiBLzuRkoiSSE8MOiiUlzKx1dwP1xunffKi5K5JoiBICHTYeln7riVwfCHO7uq1IaSZL9MmSz98jO+XCyvJjj+nLcITUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676896; c=relaxed/simple;
	bh=vsNkDDC8i8tSmyarv5U2ns1Y2U/vMMf6WrDvv4lrWCQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IF6uPF867a8++RYHX6rtvHN1vja0NQ5IN7rbWTUF1STX5UP+goxtD3JJakP4ZtcU4t40jCiVw6TP2oISfbJgSj/k5S5yjVGsH25IUH0yu0clrQqSCEC0jD/VUUdszqnm6PXKU5qqBFlMZhiQCxQzkpMD341jQxAumYgkHSgIRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nBAZIacE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9iokh005266
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/iqUYcQ/ZKzUE0OzM5wAJzodMofqq4SZ0eyOXeP5OsI=; b=nBAZIacEk1H+H/rM
	JhG2yO5ZBzJOpq7N5vO+eS8FI4zCu3ZVE1z3+ia5nfBp+7qBE7kwfBknYowPhouK
	ajPXRi0mJq97G6IjQJwhDRDxVxgiJpbNog01EZdV0xw3DcPfxFVp6aCDl8uLTPEK
	Lnf3iDrcKEZi3tPLCpXo5tTQRG0zfEBm12PskkkxZLHOa2srcOKujig6i1kKD7dk
	0oLsG/vMfG8BkrSDbicX4NJeYPPu0P7oqMMdhjDef7InmhiZ1gkho8Q89IG/MpOZ
	Hi4qsSXIMIy9JEasvSl0y1lcU3hfMYU84INVMYEAGZZshUhC9kuA1maawSYF0ZIN
	Fl0SRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4w7rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-231de0e1ca3so27095085ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676892; x=1748281692;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iqUYcQ/ZKzUE0OzM5wAJzodMofqq4SZ0eyOXeP5OsI=;
        b=e6YgHa5jnkxk/gjH6pmEEHBV8LiZDWYdBGD21h/C7UF5H5ry55+j2T7EF2WSs0U23L
         ALB+xPw9BdAyb6i+OONu1yabGyICa6KM5clFVIkvomvLGN+aJI1fYKGceFfduA6xX4NS
         uzkBiR3r34wL5QOOjEbMFRpdxd4O1fjsn6eZzoLfkpfG61NRqVZWEF/UZGwLR2B/GPIm
         9WmH+3r+4GfEBSKi4MSEijE0exLoFuINxPgONBrvZOJh/iTo/at8XhREjksQxUnxqThe
         xmIJfgkXPmgIPQ2YrXomRh3LhxrBaufICHIfKq8H5CPcKsOlFaLd5gcz9EKj62NrbpMX
         z0MA==
X-Gm-Message-State: AOJu0YxpAR8A2rLhU6Xh9sKSncQvbZNd1XM7kNO40/5fX5XHDk/fTA+A
	EQ4nLwK9m+TEvvyxNalmh7b3JHGxIXBqcas73Y501RkvRfWY7s5PgK6PgivXg9EOKXbEsHhB3gP
	Qp/3AVjWCwTTZkCNuH2hcocFraMi/VAP9Z22kXqEggzSPjhDEBbtKJw3JlhJJRPkDdsSsAQ==
X-Gm-Gg: ASbGncsJau5naROcEo8WH8CEq7I1U344haVcEAiCTMTmoPNLLK6tmyN2UgzDSN7gHNS
	KtCSY02TISO6PHhtrt9JLc9ZawQZCfZO3hAkNU11mhLG6THp+rMtevyFv+L+VEQHHHCSFtgp6JH
	7YFtewg0ATS6NJdkrgyvl7cjI0EGhv1uxPBm91CUXFAZ7G6qBENWwv+pSgEkV9G43TxkF49gnSn
	FdBTVpi3ML2rK3gNPlpH17/MCpeRVpVqO69ULnfWYkCdNyQFomc5G+mJN165NhlDkWBDN54qOn0
	BTiubfjM+eq6is26+enXOaniCmZRKkcKvMLre3wDQDQTlQTv
X-Received: by 2002:a17:902:da86:b0:22e:50f2:1451 with SMTP id d9443c01a7336-231d459a6f7mr183152705ad.37.1747676892205;
        Mon, 19 May 2025 10:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkfT627Sx+Y3lijWGrgnOM4K80G49i9mNQuYpNlnrPDaKycAmPH3/wNvhLyeyCLDdXtTPxaA==
X-Received: by 2002:a17:902:da86:b0:22e:50f2:1451 with SMTP id d9443c01a7336-231d459a6f7mr183152505ad.37.1747676891821;
        Mon, 19 May 2025 10:48:11 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Mahendran P <quic_mahep@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
In-Reply-To: <20250507-fw-stats-mem-leak-v1-1-8d4d1d8ec0e8@quicinc.com>
References: <20250507-fw-stats-mem-leak-v1-1-8d4d1d8ec0e8@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix memory leak in WMI firmware
 stats
Message-Id: <174767689082.2567051.3798725859514530074.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=dIimmPZb c=1 sm=1 tr=0 ts=682b6edd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=D1emlATrmXGj1goK3P4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 2fFsBQo3rmb9orAWyWSEJJ1pbDv9TLT5
X-Proofpoint-GUID: 2fFsBQo3rmb9orAWyWSEJJ1pbDv9TLT5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfX8m5k2KwQFz0A
 sLB7HekcObbzeS58Sdky2uwQQLe+/ThevhUitVGhNt6ybgcfo7uJWye+X4cfda5jRyEkZqA/qKn
 RB+J/azz83lehRTigbdufwNb1lsLVLxjm9GzvUOaUUAzeEaa7Qt4iTi3Sx1321EqStkgyrqSIZG
 maMsf2WaIIvWcH9DxV/hIdPBQNDIJ3auLFahLVygnltDNGzmeAzgPfXXMUS6Nh5+6AByAZ2BZyQ
 ES6CM1UkSemJ1lErHGohJZtXz+dYcQP2F0ctSVRmHVZ5VOchAcMCPzYIuLUJyPxDHJgHd9+SaTX
 vyqUubBPAV7bXLqV1OlJEL/GJ97bSnvDvVAIFQ3oy8b1RwP2CfpSPmQEWqDEvs6KY649gQQkYpe
 n0Gu/DG6ADtST5vUOsfQmkXXqtqlDcd6/l5v4kiux/SJ2QP1ISKvBFHYR8YRuevzkTZaxHK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=895 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190165


On Wed, 07 May 2025 22:41:19 +0530, Raj Kumar Bhagat wrote:
> Memory allocated for firmware pdev, vdev and beacon statistics
> are not released during rmmod. Below kmemleak trace is seen for this
> memory leak:
> 
> unreferenced object 0xffff8e76aebdfa00 (size 256):
>   comm "softirq", pid 0, jiffies 4299272453
>   hex dump (first 32 bytes):
>     28 19 71 c3 76 8e ff ff 28 19 71 c3 76 8e ff ff  (.q.v...(.q.v...
>     9f ff ff ff f4 d4 03 00 aa 88 09 00 bd 40 23 00  .............@#.
>   backtrace (crc dfe1b440):
>     __kmalloc_cache_noprof+0x2b0/0x370
>     ath12k_wmi_tlv_fw_stats_data_parse.isra.0+0x44e/0x730 [ath12k]
>     ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
>     ath12k_update_stats_event+0x85/0x300 [ath12k]
>     ath12k_wmi_op_rx+0x624/0xd70 [ath12k]
>     ath12k_htc_rx_completion_handler+0x1f4/0x330 [ath12k]
>     ath12k_ce_recv_process_cb+0x218/0x300 [ath12k]
>     ath12k_pci_ce_workqueue+0x1b/0x30 [ath12k]
>     process_one_work+0x219/0x680
>     bh_worker+0x198/0x1f0
>     tasklet_action+0x13/0x30
>     handle_softirqs+0xca/0x460
>     __irq_exit_rcu+0xbe/0x110
>     irq_exit_rcu+0x9/0x30
>     common_interrupt+0xa7/0xc0
>     asm_common_interrupt+0x26/0x40
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix memory leak in WMI firmware stats
      commit: 246eb353fbe9136ab3dd2ef979764a13984989e2

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


