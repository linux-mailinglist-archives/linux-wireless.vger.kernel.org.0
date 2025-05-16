Return-Path: <linux-wireless+bounces-23082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF285ABA1F6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3EA4A4EBA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C0F247293;
	Fri, 16 May 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqVr4qZv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBB1B6D06
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417246; cv=none; b=OtutwiFIKZRgs5+bfeJ877d882UhXk3myFDpVFPQlH8uyVUGehsOVLBIYgXhwf2kEl7JHoLM0TMAq20T4pHseEFnndWOCondDpPgKqFqVaIPbeTUgXsQFRaFc5cHJ/PzCRx9QVbU9xdewFyoV7hD1/1FzUidxUKC9to6aBMlJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417246; c=relaxed/simple;
	bh=FAd0FQv58ofZSVCeYce4aQUTlTTF3YYkMDkMLqH22gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n19JhxtD9wddk2mkyMsZON4xXVvfXPPh0HUmoDx8YlyUrs0ijYiA3J7RYeawfwhqqaQdvtVNwYEpVMKPhXQCtl5AKDZw9a13joOKfs9XZMT2XWtAd8JunAydmJsqr6U+0998zLpqdAjL1AMOt87q2SeRLWN/jDx0l37MX3Mbt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqVr4qZv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBjUeb014961
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTtm/d8DLV3214L4Iawe0s7r2k5QONABJ/WVp3kJ2is=; b=BqVr4qZvreveU/Ac
	3HPaugrRH6kdkvrZ6qzxFepCWe5JPtgRqd9bWIXleMrbMCotzoBOw7OIqFvLzE8f
	VIaeDUDZDDKghIdYDzSuT4fgTe+AEHMg+ktDNrKcJ1Tt65oQzEgwq0zWcEP6TqbX
	/ZrenOybpff9vD1HcTaMRuY0Ey4yeSRa0aFBprUp34Y9EzRthhug54TmEorCuKjK
	oAUKxh86qhEDPKd6oIDqiNDj9bsLjL/zMTOzbS81RCCqFdwek3MJiQ5YJo7jeixA
	/Y5McjOkdpkXfuHvVUxwflrYv/D+fqmq1X5C7A7qrPXX/EJrWdVehVczbDGVuh27
	UavJMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpjw6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22de54b0b97so23778625ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417243; x=1748022043;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTtm/d8DLV3214L4Iawe0s7r2k5QONABJ/WVp3kJ2is=;
        b=HcFxGTpSBnwq/EM5G8qbETRHz2lS7Q4YsNS/wtgDpzcDbW6xPpVcqW/7SF8LzB/Pt3
         mpqqF550ivgjhmz053W7dSpwF5X1l8byB/wp1b0OMi2waut0T598Dtzh5d9xMsI7dMXW
         9ej1ET8+4RS6IxAqD0ul/D5OuH/MLfZAxRS0Ou5yRgdUaHLP9927DW+84H9Wc+CdZnZ6
         GPqxFNnEN7nl9v6rZBWTnaax+c1/Vg+S4f8fVUYIfYijRheicu62It/LQu5wvC58e5xr
         cGrI1uRc4LW99/qdhL3guExszHVCJMj6HC33qyBlD0sE7Cm1yE0G6JkFccXrR79AbmqY
         5E0Q==
X-Gm-Message-State: AOJu0YwoBo3mVTxqyS+RAttfNgyW9nipzHsJRa5CxOqkeHnVHb2j7D7i
	6CK3YC5w7gjA4sjsZCcWaefTvScUUM2JvJqBNTKhREe7V37Q7QP+qyc5qVOLIKdc1fkKp8IvnCC
	1MbmOHQmBIVB3Nr8jMfe36+cVbQm9q6aJ//LqRJgZIoRPTPjQmfrQnlW9l/BgaukGK0dZ6XQyth
	FFGA==
X-Gm-Gg: ASbGncsnVwq+KK6MFiAAQJCMl/wzRLbP2PwDYOa1wUE52B2Sj5/mBVMd2EzS1WN1KXp
	DM3/olVoxpf4O3bJGzFTwfrEvvAMt/gfLWj+ue6xk/1jVTuo9dBwEDodXd72M23mJDVFlx3w0Uz
	YhpvRI0B+uz3dD3PL+NvEaAX6y3wutBMZtDMMri5DKN9TcMYnhu1irocxfWQagC95SfqgQSMAal
	0hTOXwiegh0ie4OEkVXQQH9+ZJv3cuOzAQolHMv6LyMIvVIxQgn3VH58henhm/tRSOcknR+GIxZ
	2+/NIMnjWVVa7Q4Kg8/clBlveG4mbL+N/XLW8dQtPPwl6nP2
X-Received: by 2002:a17:902:f706:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-231de3001cemr55969975ad.12.1747417242647;
        Fri, 16 May 2025 10:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFobjA5XqcWBEK9A60Oy92wauWosEM5AF0oxH7QCZyrE4WDwFY1aAUoCQNI/WNT4jVB2AuQlg==
X-Received: by 2002:a17:902:f706:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-231de3001cemr55969655ad.12.1747417242233;
        Fri, 16 May 2025 10:40:42 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ade573sm16994125ad.80.2025.05.16.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:40:41 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
References: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v5] wifi: ath12k: read country code from
 SMBIOS for WCN7850
Message-Id: <174741724095.2935573.18062919254197960306.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 10:40:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 6FK-ee22p2iVyBOGw0yAaBXYdSGvLt7G
X-Proofpoint-ORIG-GUID: 6FK-ee22p2iVyBOGw0yAaBXYdSGvLt7G
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=6827789b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=lGko7cT-K_rkadHLPgkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MiBTYWx0ZWRfX0q6F+e5Benmt
 W44rXmUBPMDY8gIULw28FIORMtsrzRMwcZiIXkOLYx7IRKMpaN9R3i8JPN1M09m+01sEsJU5Cqi
 JqJ3tiCcqwRrRuh3MAda9kHKciVqkdZFXHwcBVKrJXdRnanExjubwmmWgiADg6hfhpcn5QqGVWd
 Nt79fQGq88eUk0AffdYTayhnFlQaKriBYSXtiWuoC5foF1H1GWsb/vSu2QEyqeS8HMGWq2dFA2p
 dBKxFCSKqOBw/zXnZw56tcuk+VdKxt0TtikOHZIOuiyVm+o9tu4rG9+6MYPPU0ik8tD4rjw9SP4
 in7Ar41Thl4l9metIiXWiWqDDZKLaU/GDzu9WXhhD72jpZfNtC0F+9U+zLtPf7RZKpqh+zhWfTp
 N19YFlitK+vdaEqCHl5k3oniwPcRAEfc2A0XhjuLOFUTILuHV1+B7FWuBi+x6bsPNVHpMoo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=830 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160172


On Thu, 17 Apr 2025 10:42:27 +0800, Kang Yang wrote:
> Read the country code from SMBIOS and send it to the firmware. The
> firmware will then indicate the regulatory domain information for
> the country code, which ath12k will use.
> 
> dmesg:
> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: read country code from SMBIOS for WCN7850
      commit: 31d48b93b1f8697254c4d7fa922eaaa3b28a7ab8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


