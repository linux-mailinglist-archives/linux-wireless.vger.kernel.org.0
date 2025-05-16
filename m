Return-Path: <linux-wireless+bounces-23100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE5ABA436
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0B61C036B6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA5280A27;
	Fri, 16 May 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jumLbjB4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540827A935
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424435; cv=none; b=UKk+PVgBGzskQcW0kq0Vv2DnDc1DGp6Bgi+DO3nHXeLV1DekzJ41b84LaAdNtkRnJAmjo0mJV/yt27gy96ED7rOBIN6DluN81XJDwXOta3nGbBLyr/JQkRueZfkLZivdaBKnpVjKTh/nQtGi9IBbOiSExVILZy+WHCqTeCc0qoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424435; c=relaxed/simple;
	bh=wd1i3q+vCQjV58xQ+zgX9ppE3d58lSVmMJsaNOXlSno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kgj+k8t+KWCqkH+t1/pClPB9V+P5QofiJXdHo3od2HsiMpeHBEzxsMFvrZlzEI1OogIFgq6VDEbkSczd7b2cCF9ze3DRPRcmlqoacS6nsACFX+326KWH2+tkNP9+Fj4+pw2sen+LLnxucdsP1H78/RF585n1D4tIJ6Dxs9wcVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jumLbjB4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBIDB2026131
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+b4mipyrCPJdbvZfzWGaBRvV6xkj/kt8pxJ9PRpOlqg=; b=jumLbjB4Dh5rqC56
	AvPctt3LkJIU2iYtkhAZSRChledLzMtkohfUMIfHxjs+gW6YhlsTreuGHYsATchj
	rMW6TWFGqwG7bBlH9jqBtyHqoxQwuodJy1rBzSPn5w//RBl/3PrnU2ZpYe+tsgl4
	1dZWxuXJBlAz5mt/9Rox5sXNNbilvscd2P3o/XC6N9sRzvSHe812AOPz68usu9nM
	lVe62L5J2hpwbOAHVEYbaJ9MzyFFlTp6UC3U6Tr8J3nUBqrQE6yIM58RwLtysT4T
	GgjwsJk+1pqli92iILz/IyFN/Q0SLjDH5kKGVMslpihQt29DE+QBacHkPm7dh+Df
	uEK5qQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu82k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-231d7a20b31so11271325ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424432; x=1748029232;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b4mipyrCPJdbvZfzWGaBRvV6xkj/kt8pxJ9PRpOlqg=;
        b=cA+FegixyzV4fXRT7awoJ66zF8Y5CtIK2uBnkRQ4fW0GJ9glsMv4cNDVHOsoe/4AJL
         NDo42QzyBrN0ySHgdxKBAq0ZZh9UVsqyX0ZJMvql24Qoo3gLBYgsC6g0dkEZxbFkP44y
         EwcVuCSdISC5ywdQphddWcgi2Wy69CwIZ9oFAuwhw1153NgDl6XDO4OVQnsj/ACH0PVb
         5S9nq5DBuNCw32+6OQYt+DkQHEuBIdSiETKKeNpALw8Gr0VQ7lAD2OscxioLhznUA0nW
         p8O0FihNI+6bKyfRJ+ZvemJT/5RYZICFPo7JwQs9Dfot6z1jDpCWU0SbaCrzSB2/B+Vr
         Ygyw==
X-Gm-Message-State: AOJu0YyiS85XMt5EIZTDE+a/6/21Z+8gsa9TxdmpearEN8OvE92GDBXA
	Agm7aek+rsRClh9wANvc2n9p1p9d5GZTMqAFx763bY0xoQzSAikB08VimSiLBDxKbnPNZbe9Cly
	X/EBsPwJuIkgj/WiUBiAWPYv9xvIAs6HAv1nbE3tFzQmKT/dOyVDmT9Rwyp9s0bXjrHaJPxhUlB
	y2Ew==
X-Gm-Gg: ASbGncvwgwgLRC9YAk2YTWmtKdRP8izOPsFrQ6pdNRWSB+wXY832z0v+ihpYH10bbW9
	03BxMsmXEqfKF1c76ViIDQ3yswuXL3ykXv3OFtzlBjH/IwUrMLa7T9k5YyohC/ck0AFZIDDO2CD
	KAP9GcsxHsV9A0CTT0ozSMvVnQAYwZqdxl3u2dS7TgY1kaQjlL5h4hHKSYCltJbpghQ94fsB4YA
	55pKXZfvg5iExaISOi7Fgeit0xlxbgLrkYhiGYU7UixV4u1oN2gbM2ias39BLQr8n8wZeS/T4e5
	C4pIeIqK1DxxdiAnZRkwVx5cgcAfOOHQLC7+ER/lTAinu41Z
X-Received: by 2002:a17:902:e78b:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-231d44e641fmr61831685ad.14.1747424431767;
        Fri, 16 May 2025 12:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM762pA60yK/Pp86FVSbdlfl+30uTirqh9IDypL27MMC7XJvAErYG0SFmv7Lc8RLcGCQU/sg==
X-Received: by 2002:a17:902:e78b:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-231d44e641fmr61831335ad.14.1747424431344;
        Fri, 16 May 2025 12:40:31 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:31 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 00/13] wifi: ath12k: add monitor mode support
 for WCN7850
Message-Id: <174742443073.3316767.14591077884677831955.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: CFMpXOh3rtc5SCZJ2qbCwEmMwmhYq8jh
X-Proofpoint-ORIG-GUID: CFMpXOh3rtc5SCZJ2qbCwEmMwmhYq8jh
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=682794b0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=B1sZM3WIyRSAwYCktj8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfXxg7QCWy4Whpc
 BFfWBHu+XXy5NdNS4w5ZkQB+uMkLdIX76ERMl+0gL/C0Z9v0etWFC/kqOseDnDE8s+elSov/jla
 EPteZp/VgzZ7hybl4AYIu0kiLJESY5ogGdFCwtpr9ZzuNwWDMKo+tS/MR7dZx45WQyjHYkx30mA
 FZa+n2Q1UkEPLYXzTVSu276FBvH3V2zjoQFrDbpK9IL0f2OTcrfBk6DLxEwxoLoWTjg+jLhrvMx
 RPTQpzOKuHkszr9dNtHbeGcw+nMegu0cJBHZb872NXLYmT65eEG2Af/hah6G1IBJ2Q39bdC08wU
 y0bigqOL7Ka56N/+dDlqXQB0sW9YZuTXjERk4YCUpKqiIZ4KanHRmVq0mgPFTqjrFuZMyfrYH9D
 tKIcIqw0qk5FTBWywZzwQat8bgw6vABAWBoPeGqPF/72pGmcKzsN70wgeq8st8+iojqFzGnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160193


On Mon, 21 Apr 2025 10:34:31 +0800, Kang Yang wrote:
> Currently, monitor mode is not support on WCN7850. Thus add ring
> configuration, interrupt configuration and ring process function to
> support it.
> 
> Kang Yang (13):
>   wifi: ath12k: parse msdu_end tlv in
>     ath12k_dp_mon_rx_parse_status_tlv()
>   wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
>   wifi: ath12k: add srng config template for mon status ring
>   wifi: ath12k: add ring config for monitor mode on WCN7850
>   wifi: ath12k: add interrupt configuration for mon status ring
>   wifi: ath12k: add monitor mode handler by monitor status ring
>     interrupt
>   wifi: ath12k: add support to reap and process monitor status ring
>   wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
>   wifi: ath12k: use ath12k_buffer_addr in
>     ath12k_dp_rx_link_desc_return()
>   wifi: ath12k: add support to reap and process mon dest ring
>   wifi: ath12k: init monitor parameters for WCN7850
>   wifi: ath12k: use different packet offset for WCN7850
>   wifi: ath12k: enable monitor mode for WCN7850
> 
> [...]

Applied, thanks!

[01/13] wifi: ath12k: parse msdu_end tlv in ath12k_dp_mon_rx_parse_status_tlv()
        commit: 07a273d1e6f4b1aa537a4028b5b0ee0022cc16ec
[02/13] wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
        commit: 5887ffb18703cd64afcc2f6364a5db11ce2751c3
[03/13] wifi: ath12k: add srng config template for mon status ring
        commit: c703c6acd6672a3f7005d76ff53f8ab04ad6c90e
[04/13] wifi: ath12k: add ring config for monitor mode on WCN7850
        commit: 4cd8b48f5d88ca0006952de93583ff827cbdd33c
[05/13] wifi: ath12k: add interrupt configuration for mon status ring
        commit: 18d26d156c22a914e9d461d0305a8448841b31fd
[06/13] wifi: ath12k: add monitor mode handler by monitor status ring interrupt
        commit: 5f15468f5fd3353dc012bcecfa0de2b9390db572
[07/13] wifi: ath12k: add support to reap and process monitor status ring
        commit: 78d3d907d0f1c7c0df866876e9e551cf22d5aafb
[08/13] wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
        commit: a69bbf89d751ba2d6da21d773c4e29c91c5e53c4
[09/13] wifi: ath12k: use ath12k_buffer_addr in ath12k_dp_rx_link_desc_return()
        commit: ac885978a5ab49809784b3ad20b4cbf7f14c664a
[10/13] wifi: ath12k: add support to reap and process mon dest ring
        commit: 72bfbf19b7da6edc6db1d8ea81751ee6d31fe2f2
[11/13] wifi: ath12k: init monitor parameters for WCN7850
        commit: f4dd79e9b5d3cae04e166186e7b325453cdbaf7e
[12/13] wifi: ath12k: use different packet offset for WCN7850
        commit: 1cf514fdc7904e0a29d694487e0c36d3595e3717
[13/13] wifi: ath12k: enable monitor mode for WCN7850
        commit: 6c262794ad9dba9ad23224d002e1ba5451f71fa3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


