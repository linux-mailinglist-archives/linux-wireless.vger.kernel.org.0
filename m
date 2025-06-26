Return-Path: <linux-wireless+bounces-24566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D47AEA3FD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71775561ADE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26FC27464F;
	Thu, 26 Jun 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1ykj9SJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687D216E24
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957785; cv=none; b=ih73Swllz440aFr/qgRivHvLzPICslEBSkGb4ng74jhYZJLTKp58iofLAWxXD2RVJZnLHCcfIilObsoWUVCIgUfEjf5AJTHrPEdxI3Tb2v1Nv/GhEXbZZzvnxlsoSdfGm93lcCgckKkYj9/xIJvNFFABW1kveH6yvqMqeF3NFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957785; c=relaxed/simple;
	bh=fHowx9gkotjmzpZIOvMfeLrzrpkMMdR/OHYdpt7D+TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Astr16617Gn8MnweI50jUwWymm9FMUZSU7V7yEq5xE6MCItB3B/Nm9oM2mwgTPDG8SDuiawLTnl+sqXujb3DOdTeALwmmRs4aljeW6WI6vNQ+sWuUxcEcvevu4VP9mEASku89W4jdIYkfS7NL6JOiGnBF5HyLIIE+rIHqqGkHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1ykj9SJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9lWEN008318
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dBbnGS+oYggGP8xcINqPzDyg9bhVTBGX167Aobu7/VA=; b=l1ykj9SJRAFSWTpM
	fsbWB7997HjDjDIZbrxeDq78WL29oFqpgpnvs1Z9KAwHztWb0DkwT1EcfHzVjqjd
	QLrYH9zbsFXJkKRaXN2o2rglEWfoYeAoT3WzVs3qX87fnCXYSSCTKDS26kIbZB5A
	xddLlUk8qi/W5esfLE8MkpbPkdnI+vH+RYKsvUMx+thWXEMdn70NqgMvtsoidgm3
	7s0KBmS6IuPxsb7A3ZRxwh08KPAfWiOl2pAfNQkARjCltcIF1aK45NzgFwp4TklP
	p/KKhgDBoNPe8JKbxT0N/F+VSGowgLsYBIJQdqfqEkmwMk2IgHXLNPmdppSWAhsS
	RLcWTg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqthgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:09:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c37558eccso908233a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957781; x=1751562581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBbnGS+oYggGP8xcINqPzDyg9bhVTBGX167Aobu7/VA=;
        b=pw6qfrGc/MqL8e5tiP+YQVx2paiQPv6ZF5s2dYDaloMg5BxLnXN8ootya4d5t1hyfh
         hyYnqseyhUsb0Cm2v0lW3DL6+X6DVTfFsyRAVeiLtIgeYebCndbRx3eXSJW09mI7owxt
         zLUNg96crRXpL9ZafMqMs5rZL53M882iCa8zZpGMyk1TrBbMPQgxs2u/5MkOXhjfmgTl
         BC++VgDO/aHPe79PGxc8cywpF0c3ipDQW88GVTZfwRZWlNQoj1pXWUiF6ukztNNO7iVZ
         DdqZecRvhmiaJnBRZuYCVOPKZe33XCNuIObvbTMCdK5dZK+4obdIe++BhkQhd/ZjjpF3
         AYTg==
X-Gm-Message-State: AOJu0YzxJH5stMLIbX68wsUjCBo5Iqh84l1bplD6bEc0DxfHVLfRQPia
	h2biIQ+omaf8KwKEgfKPeQF2rfUVih7qyjw3si/G04POxL8xHW8vNZQ7fFWHYHYd90oGAz4bq0y
	H6nnaV30mS5RzcpJmeRDXTjxelnmizOzJTcuecKW3mDAX7I5Av7p7L4CNQTBJCbRNS+YAqA==
X-Gm-Gg: ASbGncvsXGKJaSrDu6byGcHOgQ6aFxInwHZXUG6F41jaC/ah1Q34vyaHkXC3JI0Rj7B
	SAvUQSvCQ0dvPUamgmFIGE57SrioFu9sREIxbxlLBoe33D0XFuC8PD66Ggvl+/BbGKrC5NKipZI
	Fmb+joXNUAka7cpMm7TkQxErBfWd+NgggqLvIukOa0XuYgQCDM7qSY2qz61MPwnsui0jaVRa607
	gO9dBJaEZnjws8+oQUS/sPXdRdKcTzQtPPOW/PEcmxvbhlGeWdQNzj1uzSSdnukmRpuqnGjqAhc
	49hRU6KkhRbA5vPU/mXqcBc4qlv7ZOVG8o3BdZUPoubFs/SxAduy+pKwMQkVl6ejP52MAW4=
X-Received: by 2002:a17:90b:57e4:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-318c1397935mr660831a91.10.1750957781063;
        Thu, 26 Jun 2025 10:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCW1a5ZF1co8iF5irAQQqZFuyGyaSJButvzUjfwQceOTHTXSOKMBGL+pdp6nWeXhiWrb/+WA==
X-Received: by 2002:a17:90b:57e4:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-318c1397935mr660793a91.10.1750957780630;
        Thu, 26 Jun 2025 10:09:40 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.255.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54420f4sm4731292a91.49.2025.06.26.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:09:40 -0700 (PDT)
Message-ID: <a535ed15-9c88-7830-f5d4-adece072fbd2@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 22:39:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Send WMI_VDEV_SET_TPC_POWER_CMD
 for AP vdev
Content-Language: en-US
To: Hariharan Basuthkar <quic_hbasuthk@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250606112316.39316-1-quic_hbasuthk@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250606112316.39316-1-quic_hbasuthk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VV7WGuhDMmflRmBpDTC-rlZ1Mqpo675P
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685d7ed6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=/xG1ZwzdjF5UbGEDupzz2A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fQuKbg9plGXEwmXOFSUA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VV7WGuhDMmflRmBpDTC-rlZ1Mqpo675P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0NiBTYWx0ZWRfX/Y9VkX0bdGRE
 rjdkfsuprpO9itmWr8F3HHAghv+Ei5FyE09AXpRCrnz9L9Jlum/gNh5lSbI2pX985isTrRDGKVa
 cldBnkJzC2hN0LilJuhDzsuFqUX204FyFZreRk6UmfjfKrBSYEwugXOQINB4flakqja5RtBV917
 4+GGE/ox6UMToN2eYoBQIF66xN2EfmtFG/lwYZfEpBhAJU5ne7+L2WKw/lClUL/8FBCOJfsURc6
 sKf8A4rgteLNjPB5KEkP7csKbDZZEva6C61XHXwL0tuy+Q8yu/VnC+zCUIEM7yWKNk0JQpYlx53
 hSOIKrx+5422KjnOLsiCMmZhaCrS+T9FMolYuH3eKfw3cdk5+occYTlRDbMDVGArMW4XGXdbO9/
 V77jGeUMmnBuJ//oPai2tiSAIRIhOmj5GF5NS7OkSAbZEPqlj+TyBcJZM+NDDkKBPtz544S1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=890 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260146



On 6/6/2025 4:53 PM, Hariharan Basuthkar wrote:
> The power value is 6 dBm on an AP operating on the 6 GHz channel.
> This is a very low value.
> 
> On 6 GHz, the target computes the EIRP based on the power values sent
> in the WMI_VDEV_SET_TPC_POWER_CMD. Currently, this is being sent only
> for station interfaces and not for AP interfaces.
> 
> Therefore, add AP vdev to the condition in
> ath12k_mac_station_supports_tpc() and rename
> ath12k_mac_station_supports_tpc() to ath12k_mac_supports_tpc().
> 
> For a AP vdev, hardcode ap_power_type as IEEE80211_REG_LPI_AP, which is
> filled in the WMI_VDEV_SET_TPC_POWER_CMDID sent to the target.
> Currently, LPI is the only supported AP power mode. Since there is
> no method currently to set the AP power mode from user-space, the
> power mode is hard-coded to LPI.
> 
> Retain the existing logic for populating the power mode for a station
> vdev.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hariharan Basuthkar <quic_hbasuthk@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

