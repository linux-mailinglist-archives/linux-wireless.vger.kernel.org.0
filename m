Return-Path: <linux-wireless+bounces-29135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD0C70E95
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE88234D940
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48634DB5D;
	Wed, 19 Nov 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5zS0Qh9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7/ryTXO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8B2F83CF
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582000; cv=none; b=bMIGQivmB2dGqXKPucQKnRmN5Ae1LC/Q49IxNpuw+fdiMN3MCKy4rMbWQ4IAOGkvHBatnESR4FZoMKgK5HhA3YgO76732VJ3/7Zr6ik9/U6umC072b1Y5g4u+pxT7mDDapsSQzQBVcOQt/pKOA+TnjEbGwK7U3B8v1u2KCbgueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582000; c=relaxed/simple;
	bh=iBIRMwQDvuqKe0ltHxTvbtVuTF1XNGab0q8pz5P5r44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SyFq3BxBapQNc7m7EXuTtDd3uDXju5xiRpVIpkOFkVXaXXLkklPG2w+9ZILj3Njy1M8oqlnpfkeQ7tPNdvQYrzk1so5UewObfffSmgasEN/xWYpUGGZESChS5Fv/fOTiwR2VfMnkBLWqhg2ltZmIA33ZZ53eIRwRDlh8Ze2Rnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5zS0Qh9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7/ryTXO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJFkZm82094039
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	txsRffx2z5dci0osZKf4njtB+LEONXPzlw++ycP4mTU=; b=B5zS0Qh9utJ5L6cx
	UtaOPK2ihxZ1o2OpH0tVT19qgznmgeJY0at3BlVr7spL1a149xL6I465SWdRhXKz
	c0oGG54rBS15A4XaQ+4/HauELtgLuRbmlaIA8N/1zX56qfLdYYgFa4eUV/RDoUip
	wBCoOu8xC71/wqvLgBuaNE2LLb9ena2F26DUGCLUNrSJqWJ+Z9xOSG29J5f4027P
	a0VqbMTb6YQBm8Gx22HG6mNmiVV3RFwRZvqPFJo4TFRKeOgKCv4/9XbDpTqUxdfe
	jbM08I9NkZ9yQw8NjcT7I/jNQb7xQvLViO9txRj4oFE7UK1rTVE7QptNhayCWtkx
	VQjurg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah88wafq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 19:53:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3438744f12fso98013a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 11:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763581995; x=1764186795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txsRffx2z5dci0osZKf4njtB+LEONXPzlw++ycP4mTU=;
        b=P7/ryTXOLzvQUNmBmxvLRj5c2h1NjNodAO3sk+a0EhNHSx6+iUhiqIOl+uyMAa2G77
         UYhRlFD9kOms7xczC8MsiF0SF48BT5/NmZcndGEl4dNDjwCwnuz3Lx/9KArDW6KCzaTc
         EjVeREZDOf8g5qlWkLa1WlyjaNMnBBYgEQVzLxBCKlm5U4CE7MYDlsahvBcCs+HUw/qe
         2qlDUvZo7ertvG79FL23p5dtv9WNOxOIp0nZ1iVii49Efa10Jys2eJUWCmLRmBsY4oDl
         Z+Hk42x2ctU8QVjI8ZtYtsCjeRTI5Bg6HRtjtDrIFPEe4bwrLaiirB/1wiVgCyA3cORd
         6uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581995; x=1764186795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txsRffx2z5dci0osZKf4njtB+LEONXPzlw++ycP4mTU=;
        b=Pnr7uC4MLVcaA+TcaitFdsZSnBFlnvWazhqt+BdFWCkrehl8sR7sbh1R7GP+ugw7/Q
         vuptHfsSJUx48DBoCLx6PN5IOrrSdfTD/qjA+1iJFe3hQAgoEgoWB/v+kaLvYuw3Y82/
         9eEM7kOb0UMAHJDIfOcc0elLEAbELE3GSWnM42A91xWjfwL+gGBy0wKqhMypFmCn0tpd
         soLcDPqgICkPDiQZBeNqmBLrH2OLm3QrOftHHeYJwjqZKTWvo0ntafEe3iNIAZ1nytWj
         1fG0uB0VpQ7xauEmdhVpkledl3vCmST/+90B/wY9o4xUiSIIDFpJmFndrAj0PMd7gD53
         rxKQ==
X-Gm-Message-State: AOJu0Yy/dbbVNruetE8cDYJt9+H2iJbeMGJs7lgKJZfAcfXSs3Rc0UgC
	/ePon/sizbD1QxHhzxqlLD/L0t65FEdrAwSn9b1QMZfDdpXXPzC4OPqgqAH6sZp3KSYhh0dyCO7
	JTwSYtSok1U5JDL/UjKNdJz3n+3UMZdAfmMoU31FNy5SQJxd+VTwxc28bK7qoK1gVjufGow==
X-Gm-Gg: ASbGncscFs1A7UYZVs5EVJR8pu1pLzUFiSB/PrXF3Okbte1Y0+4aiAbJKi8jE8XhKHD
	2lazekdn978BuDIcKAzgLe1kEI3kuNxB/DmrRBtjkYnBOrH2XRROyVayTtHKd7yM5bt1tKGsQJR
	pcEE46W00WPwI8Cp+EZJDUcyGkLLB/8GGLCsS11ONgQZR1UTlD6MyIqpoxlrtENoAbI64qgi+PH
	ZibzyMcCzoWK+cOOIONBDs5ULdElqZkFOfMfV7+lF7JK7l+CF5ohJZk/4u8rM5n4bdqHe89I5Sr
	7xaI0tZrgs206TJZVqeTe4AnvlfVO3JCjRR30/gun61Pbam20aClOxXypw1K4Yyvo/moYTBE7vM
	0qtOPTlPc9yz/V4jNZ0cqRddLqOi619OKCDfmRBLgEB4New==
X-Received: by 2002:a17:90b:558c:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-34727d68093mr333303a91.37.1763581994606;
        Wed, 19 Nov 2025 11:53:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoZ4HuTkismhMzSeuYt1Q1rICYobswYfjT+1TEBv8W7OiokotZj613ZTQzgB9boFQsZELt3w==
X-Received: by 2002:a17:90b:558c:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-34727d68093mr333271a91.37.1763581994075;
        Wed, 19 Nov 2025 11:53:14 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b0512211sm2646721a91.13.2025.11.19.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:53:13 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20251119-ath12k-fix-missing-rcu-lock-v1-1-8155de1dc4fc@oss.qualcomm.com>
References: <20251119-ath12k-fix-missing-rcu-lock-v1-1-8155de1dc4fc@oss.qualcomm.com>
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: add the missing RCU lock in
 ath12k_dp_tx_free_txbuf()
Message-Id: <176358199346.3002662.16180061512061490406.b4-ty@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 11:53:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE1NiBTYWx0ZWRfX05JnCRljY/HP
 ZxT+rT6ufJsUssQsM8fZZiz+k6FlGIRRsEubNKycWkSjcvlggrfqJB1m7qOlRRWbYNhEZHUXXDS
 064EkMMl0rqbafO2U+a4ZRW7FtatjLzN6d1+QUU8cV9WHtGWZWiAd44jUoFk0KVCfJzikUxFiYy
 X7dOLB1siT2jcZZHbwF9fFeKkiPfixtdPqwcoxnr5E3qxOg+pzhc68mMw0kOxxNE4o14piKEkPG
 +wI5LYtJnKk4Lwotsh/amXNNIivppE4Ia8/9HxHH1X3EmFSfznPG5yAkOtsnI4poaN/Gjwj8m/4
 B2pcscxR2gdbXPoOjnfLiB0CnwXWEzvq7W1GHrtGHnSJ5fkToF6ssLPGGt767Ndm7F2ltCk2VaA
 GFbaTjL+r3iHVTVpB0LzDTx9A/f6Qg==
X-Authority-Analysis: v=2.4 cv=YKqSCBGx c=1 sm=1 tr=0 ts=691e202b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fpXTjR_PzDRLIX1BWiwA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: jG5KT-Mg9uRA68c0f2Zo1-jX55COn42v
X-Proofpoint-GUID: jG5KT-Mg9uRA68c0f2Zo1-jX55COn42v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190156


On Wed, 19 Nov 2025 10:15:57 +0800, Baochen Qiang wrote:
> RCU read lock is missing in ath12k_dp_tx_free_txbuf() before calling
> ath12k_dp_to_pdev_dp(), causing below warning:
> 
> WARNING: suspicious RCU usage
> -----------------------------
> drivers/net/wireless/ath/ath12k/dp.h:653 ath12k dp to dp pdev called without rcu lock!
> Call Trace:
>  <IRQ>
>  show_stack
>  dump_stack_lvl
>  dump_stack
>  lockdep_rcu_suspicious.cold
>  ath12k_dp_tx_free_txbuf
>  ath12k_wifi7_dp_tx_completion_handler
>  ath12k_wifi7_dp_service_srng
>  ath12k_pci_ext_grp_napi_poll
>  [...]
>  </IRQ>
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add the missing RCU lock in ath12k_dp_tx_free_txbuf()
      commit: 5a384854d81f83d59d812b54bfa27fd0e56e36f0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


