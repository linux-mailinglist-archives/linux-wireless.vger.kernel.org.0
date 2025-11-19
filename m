Return-Path: <linux-wireless+bounces-29136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC94C70E8F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 20:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE5244E1125
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2F34104F;
	Wed, 19 Nov 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1DbucWP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="djhA+5m/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD291DE3DC
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582000; cv=none; b=P8uWSG4MnW1ZKmWQBWyECnWCG4/nS6A1n6HiFDkuL9326Ng1TbZIbAj6APNOgMtRkJmB2JPAaNg+c1NUw7jmrs8DwLvQCSgtXidgfn9QncxiQj8VexytVQT/tei6R36zKVvfRmvyStr4ak1DvkJtSMnYExHwYlSAsXiI/HGHl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582000; c=relaxed/simple;
	bh=cLy6+A8ANWk6D6evPjtTO6KeA9OXUWIsVHrKzCr2qc8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nxl/vyhniqMRuPOGIVBechSBiLIB5+sk34Vm5Vu/XTtB4MZFN0DOJwVqkWks7PnwzVlnB2UVcrRxFFw1YNC9c3OtdWrBrdpuwlDm1bFuka84UoayTctfd7bVT+ccmtuvP2dp1EG2MGkIsfpSfjv27tMgCJ90qEgISa5qmOHBBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C1DbucWP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=djhA+5m/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJFkLbO2112317
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 19:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcsqynF3Bp8NgG/vPKyY0OFUD80XZUlirrGBzWaYS3A=; b=C1DbucWP4OfUp9Jk
	RODNCO5rPbr70mTDQG4AD3gTKWrZzOiT6OQu4rrA0SEMS7/TkSsk4OgcYsV1y8+k
	8v1xRSrympAixGQCtY+rR0zr+q0QywMGPHEbCnNcHdh/Oin+qqHFzzdlqzKO340u
	XmFFWUbYsuKrIcvv9EPN25WmHkm4l2hUq0LrR6IvMVBkoPcehN3zrCF3dDFs27e/
	UVPHN/CHACqq+pmVMbP76NDWIf8aNtMNi/X4qtNLPwQGdQVY76bbhoAKaVyrlwIi
	zpYThpk50TikKBiBwfWisU4HWpafxhhy97wr/S/X/9zRYN6kpOw99lTNSBTVQlTA
	gkcmSw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah65t2tym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 19:53:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2954d676f9dso950255ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763581995; x=1764186795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcsqynF3Bp8NgG/vPKyY0OFUD80XZUlirrGBzWaYS3A=;
        b=djhA+5m/wopNyOC82ZgktG+9D06kriPlQ2m8CwJK2A8tWKt9Jc9zrFNrWXe8gfPxNI
         xM/uDQvsCByYO2mSGgxL3PmzQ9Pv8hAVkVhk9E+EGN/PCfrm1dvP0lhBTinB6dSp84Y2
         V351b4VELhK9Sckz4b6XiKCZG5j0TuqqXyprYWgLxh+dX0mU3fHwIP6N4173NXsgRXHS
         iXmcWyp+ynkn+JlavjIeHAcw0vHh0u1Y+IXML3ksptU8VuoRPmE5hmal54JGYcR74PoL
         GjS0/CvYHIOBZxBJFjw3xygb3Sx/SJczE7WsQKUYIK85hBMBvIypMTGxwATdOLcHrICq
         lwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581995; x=1764186795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcsqynF3Bp8NgG/vPKyY0OFUD80XZUlirrGBzWaYS3A=;
        b=aVa8UrChq/cALbZwQKJiqG4pydS8eL9YSR7M2uSQjka/fLjYfPLtQa/A1Q7by5r7kH
         zup316zdGY1iP3rkHMmPD8sJ3r5zeJ652uOnYkG++DCY4BEOZ4FXkttXpl/a7OVjq2BB
         wz6ZP2O60go/qINytKd9nRHG8mnLXvSzwKLL50vWL1grA+wwQd6EgwOGBEbyJU6l2Mhf
         VjRjmkZD3ZzWYl+dRIKmgUThDOPlAD7Oq0pp+sp9bpya9cwET8RqU8FHs9M0lms3v9nv
         Fp/CfcZEFuAAYIwue3HeXWXRnz0dLDS1ba+ddQHtkP9LwX+oLP9dOWzE5W0UgKbr9OAM
         q0fQ==
X-Gm-Message-State: AOJu0YzFR0EyPOtP2MblDL7XxGLoEe7Wf/SnL4RIw3CGWztyd5RMsIA3
	jv4b+ya71wkQMyitFOCDMPrebcAq2voaZgNUrYy6CtQk8SJhQzGHMGbDLuvVYPXBMNyf2HNuAno
	Ftty/1SsB+P59VNz/rDpqc8/FA7/6NeZQEBxg2XzREAgHNIF8gv+j2QWRkvP+J4aCOX9iwA==
X-Gm-Gg: ASbGnctP4EeFhcIo6aGu3aMJDK+TdDOvf2XLg8zTgvTZb86+bDIjHIR3uclBiyrtklF
	+twAip8bYNlBaKYJpOIRtO2O0tE1MBPGk2JL4NwXsX67hfbPuXd3pb27m1sf8zWfYt4UrVKqbOS
	7bjTvXWNawOWUubeFy4ytV88Gf9LcCmmrvqZK12N/rLK53678JYTiRbwn7EjmqThwocs3k58K2g
	HKh0UULW/x+SKY4Uhc+t+v5uskbi7I1XHCImqFoZcQv6e5ZTyihL5yuVmBA1YXEjP5bpRIudXrk
	uw+VrGqEu3IEgLaFyL754wEPusjFww2Ymx4lyuB2XKqfIw9CZ9s3h6+zE+ZSXty9avzOi7T9OUJ
	C6fxhFR4vSWInhAU4a7wgc1XKktmq596I+wgiZgsQsl+hCg==
X-Received: by 2002:a17:90b:2b50:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-34727d5681fmr320463a91.19.1763581995401;
        Wed, 19 Nov 2025 11:53:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqD0DgRfHn8ijfztlr1eLiOvaKkja28SN+BYIN8BVb8OVjnufIbt7/EDUPxlqbExnykc86hw==
X-Received: by 2002:a17:90b:2b50:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-34727d5681fmr320431a91.19.1763581994841;
        Wed, 19 Nov 2025 11:53:14 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b0512211sm2646721a91.13.2025.11.19.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:53:14 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20251119-ath12k-ng-sleep-in-atomic-v1-1-5d1a726597db@oss.qualcomm.com>
References: <20251119-ath12k-ng-sleep-in-atomic-v1-1-5d1a726597db@oss.qualcomm.com>
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: move firmware stats request
 outside of atomic context
Message-Id: <176358199425.3002662.13560863807983005117.b4-ty@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 11:53:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=avK/yCZV c=1 sm=1 tr=0 ts=691e202c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OAyIG4kq6eV51QKt1ZkA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE1NiBTYWx0ZWRfX2CWrpgGmrNkG
 Yz97HyZV/ZMd77LoHwGlVHFPxbFmejU5jYUuGkHYKVCaIKkRjZO3X1W7dfyBi4j+l81csaZg0Cb
 0rXOZvtrr4B9qcHlTrrC57FcqFKD3tiE3YGhH6SzS4ePIok9x2IgiOYy5+x4Vz5yvZpzO9tAzfA
 vJdN7KhVEe6O/rIDpSpjtI7MIci+BWn6O6IanafX3Bl34Wz3+eBzvJroCvUtfQWvJIktGbbei4y
 my2IZPNsGciMs/T2GSUz/Ng3stteczO+T9W/NH6kx/D33wgkGPppQVFw0ppNLN9YD6TX/qd3/hQ
 EwhegHFN+42VkGC6WP4a0qmqz0HIkGNzlM+gUFLkw2jtt7sl5vUygdG/6SPpQ4Rp0P9ryLySgBg
 stdytbnvAGwQXv0FWKIOV4yWQe9vDg==
X-Proofpoint-GUID: lvK84tnnJwJn_YJ3dfsWkFWja8cASvAZ
X-Proofpoint-ORIG-GUID: lvK84tnnJwJn_YJ3dfsWkFWja8cASvAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190156


On Wed, 19 Nov 2025 10:24:47 +0800, Baochen Qiang wrote:
> In ath12k_mac_op_link_sta_statistics(), the atomic context scope
> introduced by dp_lock also covers firmware stats request. Since that
> request could block, below issue is hit:
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6866, name: iw
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by iw/6866:
>  #0:[...]
>  #1:[...]
>  #2: ffff9748f43230c8 (&dp->dp_lock){+.-.}-{3:3}, at:
> ath12k_mac_op_link_sta_statistics+0xc6/0x380 [ath12k]
> Preemption disabled at:
> [<ffffffffc0349656>] ath12k_mac_op_link_sta_statistics+0xc6/0x380 [ath12k]
> Call Trace:
>  <TASK>
>  show_stack
>  dump_stack_lvl
>  dump_stack
>  __might_resched.cold
>  __might_sleep
>  __mutex_lock
>  mutex_lock_nested
>  ath12k_mac_get_fw_stats
>  ath12k_mac_op_link_sta_statistics
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: move firmware stats request outside of atomic context
      commit: a1e19289932aeef26085feb97597d624da6302ab

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


