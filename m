Return-Path: <linux-wireless+bounces-23815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A53AD0A0A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 00:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F82172722
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267331DD9AD;
	Fri,  6 Jun 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdm7Utow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7A1A83E4
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249950; cv=none; b=JZ5lwnanTu6AqAwxiu/l/Ik3aPUW9CZF4Smc7fNlJg80v9Zks8TmfT63teGMVI+40xpAVDIrFtu5geHlVLeiUBsqnsfoj7EG+yXYaGub8n+MJejKC0dcAmi6H4iIGYMSEqQlbx3Ve1RUP9MGMJ+RJgl0ajMJEOdqAsMPu74aoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249950; c=relaxed/simple;
	bh=cuHNMODLf9Eg0wkDtGbOXgPpsbg5A3HdnFXyL5m/RXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d625Pjr6xyZkQ6BwbttTM4dOtZd6QYP/CJ8WCfgch2BMp2k6ESYBEW1yq35OMgyiGXSa0COhxSHXgwfJNQU5sEdvK6v8IwUX0SncKmTnPDb1Lkc1Yo3896JVToR4WM1ohIyFALwjn95lRzb2go+5rbQudAKz7dUs8OSWXrbPlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mdm7Utow; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F9Dh0026130
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 22:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLU9qoqaIrPsB96aIxIERU7iL0ZQJHlgdTGXyRV+TLs=; b=mdm7UtowMs1VWUY7
	pAFFJO4f9AqeNFQTpqSH1j6FFcCZKUTAdoRHA3MLC8p4bm5wMfxwL381SJ5sJe+z
	YCaRkczJl0ezIcGu2ShfYa3WbdZEvJH4/Yc8WHSyfDnbaCH6zPRneljU37WQkG0R
	fftt0HjFCiqC2Hi2m9Z/n3LitYKwy/dcdhxmytXlw8ultddjJnV+kN+sYTk0qOAy
	NFXTbr1UaRvmlnxyyNRiLYMIEFbWPmGTwkeOexGAajHbXfYj+AuAWt6wu/mNPP/T
	Sba2sk0FY1T72z9y6Csw5bIrDXMKs7pDPS95SLUf+xtMEOhB+DPDhuly+i4EP6b2
	J69ZSA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn084t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 22:45:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23536f7c2d7so37440305ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 15:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749249946; x=1749854746;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLU9qoqaIrPsB96aIxIERU7iL0ZQJHlgdTGXyRV+TLs=;
        b=PWTLtfZmY1wFSww2klN7LNf9QBxiGIWQ5o2fBTmmBMLBWZhfzi9BmjXeRMjpdXzZxz
         joXeh5fxjDLINrvX8Q4w74rLtfjbNaxbSPAtTUT3BLqqr1efL+i+Hr9nYcYOgKpMRgBd
         spbNqQPZ9QQPY01Ek36pTbdwaPQj8GD3bNhrmv5q3o6Omp2xlN8bbt+y/QWiZjor3quY
         ZiB+omOnFXFCF08PlT+nrSQbFUFcSN7OcqYtJU9yNmMQIfi7DNgpTRDDwMmQv1KO9q81
         0WMMm2MVCWwVLDj5db3uuSYCjKVWGXXDuwFqWLfxfozPjyfjaqrV9e80gM9yf9A6Dec9
         pmQQ==
X-Gm-Message-State: AOJu0YwZ+R72z8u/gqkeiHFjKhtitmHNJWg62cqEydl4yCKgl0W8BKn+
	nw/h7T3Mxpd8pLSCJ5xr9SleS7SMCiIzgAJQoTHAGfO/R2LtsO3SFMMJ8N2x7UPQtE+xmjHDx5Q
	SCTkVP/OitQeCqea3zBIU3CK6i669PFlQY0mfxMOVhXJZ1Et8KsJcbxCqBThiBn2hJk9zdw==
X-Gm-Gg: ASbGncu0ez0w63b/1NKRuB0hcoy9aIeZTzDLxQQ7J6oy8qI9I/lsR+agYXXV68K/7qc
	WaLeJAYFk5HXdn4VdFfBlOwjUfgHWdGqrc0scX20BLs1BYvJT8othDjmCRhHhp/USnkQPGIp3ik
	pvA7zYmoX0Y2nOvxeajxgVVMxECrSBfKk/pwZZVZd8m+eo8maCZRh46qOM0qUIA8rul4Jx1zMpN
	ppajLPwkGjHY8+J7HjDcG5UBa/ckiDNso7tEf12HsrhTYw5h7AI4vhR1d51H7hpKh/6idpUeLS7
	SKUASpsDfCJaK33YEUE+qPn5hxRK+mKLs+VbulAloBrmenEjm/4YjUpjgFdc+ZNIT/h1uDQF/+G
	q/3sD9IwErsgfUNA=
X-Received: by 2002:a17:902:e5c6:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-23601dc0342mr67817365ad.39.1749249945831;
        Fri, 06 Jun 2025 15:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+MKMoSG07ymmGCV1qvRXT8UZkTJQiJqZa3jE3Iv3VNxkmQDQuLf/vtXu05HBa6PWT2Ae2fw==
X-Received: by 2002:a17:902:e5c6:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-23601dc0342mr67817235ad.39.1749249945501;
        Fri, 06 Jun 2025 15:45:45 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360309262asm17358025ad.61.2025.06.06.15.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 15:45:45 -0700 (PDT)
Message-ID: <3ef0f7d2-7219-4caa-abf4-f18ac8ec8545@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 15:45:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: Add WMI control path stats infra
To: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Rajat Soni <rajat.soni@oss.qualcomm.com>
References: <20250120184447.658660-1-ramya.gnanasekar@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250120184447.658660-1-ramya.gnanasekar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3dmI4ReRP4TM7tHMv3R72ozNsMZF0sC7
X-Proofpoint-GUID: 3dmI4ReRP4TM7tHMv3R72ozNsMZF0sC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5MSBTYWx0ZWRfX9F+V20QWG/mp
 Bh3ToVN9zbEBCE8f3eJI6BdVGfcqUtMwi+xHP/whFbLDxyCzjiXWqrQSNVTupHJPf0yqRs2Y9V0
 ULGo/LT5Iy6LHlabroWLPFSg+PwCmeEeOdIRsuE2R+dgDQ3gm9px4M0ENl8sgy1m8yH1WOiIPrV
 BoEmJKYDmWWxokrPfDaffm2OAXI61wAE7UrBftZBTGHKQ4Am3CZ1EL1yo0xrh6WYqGkWdRI+mFl
 wZJv42HBJDY/lZsW6J0virOKhD1+zKMFRxR0Bk1203TyoqtO2mwnHFQ+g74ihCkCU8bs+VlB/Gx
 8nAjPbAaq4i3s4y4cBMRria9rDsP2ljqgU6/qdq1VyFeBJocSF5YWtpdvzYoTmqwj3wjtWjJwkf
 ccbHIwUc5DDzy7yKyJYSc6lHKG2SzZnpAweYIgmaOMVXt3r4H1VJIJMj3p3ga5jp+GTsu6lk
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=68436f9b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=3mt_E4_60Pvx-E9vTmYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060191

On 1/20/2025 10:44 AM, Ramya Gnanasekar wrote:
> From: Rajat Soni <rajat.soni@oss.qualcomm.com>
> 
> Currently, firmware stats is requested by host through HTT interface.
> 
> Since HTT interface is already overloaded for data path stats,
> leveraging control path to request other stats through WMI interface.
> 
> Add debugfs to request the stats and dump the stats forwarded by firmware.
> 
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
>         `-- wmi_ctrl_stats
> 
> This patch also adds support to request PDEV Tx stats, parse and dump
> the data sent from firmware.
> 
> Usage:
> echo <stats id> <action> > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
> 
> Sample:
> echo 1 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
> WMI_CTRL_PATH_PDEV_TX_STATS:
> fw_tx_mgmt_subtype =  0:0, 1:2, 2:0, 3:0, 4:0, 5:37, 6:0, 7:0, 8:908, 9:0, 10:0, 11:18, 12:2, 13:3, 14:0, 15:0,
> fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0,
> scan_fail_dfs_violation_time_ms = 0
> nol_chk_fail_last_chan_freq = 0
> nol_chk_fail_time_stamp_ms = 0
> tot_peer_create_cnt = 7
> tot_peer_del_cnt = 7
> tot_peer_del_resp_cnt = 7
> vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rajat Soni <rajat.soni@oss.qualcomm.com>
> Co-developed-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

There was no feedback on the v3 review comments.
--
pw-bot: cr

