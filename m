Return-Path: <linux-wireless+bounces-16625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D49F82CC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24671881C78
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA751A265E;
	Thu, 19 Dec 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjjViz/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D41A0AFA
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630897; cv=none; b=uHNUDvZTF3EF0g6JR7nIm9Ao0Qbtx01Sa1rf2RdoWsAiXnytMdVziS3S1mpVxFPxkzRa1rMnGRciKKV+vR9g7bISJqE0cW2T812RGMmrUMd8AOYhN8Ix86HBy74oSZOyAT2GIX0AJi7UnOdmnoSf9WASs5MgUODgC80WFQxxbCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630897; c=relaxed/simple;
	bh=qv8J9S6PcbRgmiO8BQFLSLBQ5zJAPOG4es5TS47+1dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NbkcFP30zle0NlBHE4FMpktaalukA5YFp0T15qFmUjpa33XLyVi8ZmBwLMdLSxsw4OHisAxUmJMTyvHonNraTuZRKTCcoYNaQSj85ZdjFQWGrUKz9DF1fE8WpnrGjIAPbCyvbpYrw7squNhG/AKlGWbGkR0vJ+Qh9G3/ynpVpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjjViz/A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJGelah004065
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXWpfwq6s9n4hTpXy3T+kYTh7FpeKtWlQozmhDIIrtU=; b=BjjViz/AO4bhp0Wa
	Lwvydi9LeSUAuyb9RTQuGM/8BR7w5f46QCNMtaKko3bS/DeSulrY/lnd8T894Dv1
	qp01TTv9G4DM1aN4NbrrW8FBDZFVM/k9SuXGBi3FeTcMpfR2ZtZppqRyIKLbVRQI
	QTApn5/iJ1YtXIcB/HR4SfHJo1wsuaSRZ9UneqPq4UDy+c4qke0P7+POhvSutZyb
	e3RIfMHeAoZVEoJh/RoUs3bvPbrJtpvgxt4K787dJhi3U1wdvssj+/UNt/XbBhOb
	JbKig7UCxoj4Pdj/Hp6rmVy5Wql0GGRxwcOdUhLUYwcMRSxqzBGmQkiNUq8eo3Q9
	Gdcs3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mq7fr6hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso1340398a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630894; x=1735235694;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXWpfwq6s9n4hTpXy3T+kYTh7FpeKtWlQozmhDIIrtU=;
        b=tJOGnY+hVP+b5rRy7XFaRZlQOEC/8t6XyTUiFB1J3OEWNNqP/pqbm/gdA4CDKc9z5A
         RyQPeHPfSpM2PeHd5dCeTqQr6H/agDLAHX5NVXrl3KMkUl+giJJOAS74v12yY9PXaYXV
         FEdunL7Xp5f1fnLNIjPhofR77VcyShU8fkpgneyfxJfm+EwYzm156JJIEfd1jVVzL+1u
         TZ5ctCM69DoHcGicLkiVKEJBWtsooP5VABRupuSOi4J1f87o72NOVoWvLCF3ZRyDhu3n
         xJLknxwY8V5Prd/hyL5W0OJ2K/suY11aB5/G+cbaYELL+y0FUWVoXozfaeGSJgxiajjr
         NeIA==
X-Gm-Message-State: AOJu0YxF+/VoN+TcTREAwhGv+8LFsIdC29769eoSvix/1NnpHNJGRetG
	ZPjh+lfQPp4ts0bOCbMMJfLpnYyJ0f1PSwn+gFS8OMLkS/+rLH1+SSS9sBFsL+hU/5B3JpT9TsD
	90jMIh3G4V8qIQBQEUO07fh0+6mAn6XJarPO7S9chYItraQP09uMeT4GcDjaryB40aZvRpe7Xrw
	==
X-Gm-Gg: ASbGncsrxZ1CIayFRltGI7nxl0BVeC5cauPfYpBEtU6y9gPl6LET1EJpUdTj/SC7xA9
	iDfkLJzItHPXyLdYlOoeQXQC0zLKOvL+EUMtrqZ01n1hv53bVkw9mOCO4iasbnIhrDKUYmstMPD
	OlBkeG/vu1noqqxULLjSFtGWMdq1Y7dsHUTnlhgaYWIjllygIhcjvturupYvOUjtnRHFkTjEyNa
	ZZ2k+EAvD+m8rnFAqltklOWAWqLK4q/4Cw1qO2f6goiz5GCkRKNpHv9RlhD8lvkSy2LbQB+dyRn
	QvcqGZv/yB7TC4JO6Q==
X-Received: by 2002:a17:90b:1a88:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2f2e936a09emr11516344a91.33.1734630893774;
        Thu, 19 Dec 2024 09:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHVEWGrl+yFM6z11suYbeXyHBZiPYWwvLuMCDB/ECAksoqc0Hxz/YQPnTbdLKWqWqTNUNjPQ==
X-Received: by 2002:a17:90b:1a88:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2f2e936a09emr11516312a91.33.1734630893402;
        Thu, 19 Dec 2024 09:54:53 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fdfdsm3630628a91.52.2024.12.19.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:54:53 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241217202618.1329312-1-kvalo@kernel.org>
References: <20241217202618.1329312-1-kvalo@kernel.org>
Subject: Re: [PATCH 0/4] wifi: ath12k: few fixes for clang warnings
Message-Id: <173463089278.2609009.16421252529059119912.b4-ty@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 09:54:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: BmDiTzdxpxODPJJDF8bdvqNPWiw0atEu
X-Proofpoint-ORIG-GUID: BmDiTzdxpxODPJJDF8bdvqNPWiw0atEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=936 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190142


On Tue, 17 Dec 2024 22:26:14 +0200, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> While build testing Jeff found some clang warnings, here are his fixes. Please
> review.
> 
> Jeff Johnson (4):
>   wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
>   wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
>   wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
>   wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
      commit: aa21668ab3c7c479998be11393e1a1c3c2624fce
[2/4] wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
      commit: 445718c9958c8c160654068014c0e72505f59d63
[3/4] wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
      commit: 6ff412420e5ea1635385038a0bb4c77420862bc9
[4/4] wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage
      commit: bf2da5c4f5b576d45f5f0cc0f508b8255f7ab015

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


