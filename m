Return-Path: <linux-wireless+bounces-32174-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDYFMMnUnmkTXgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32174-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 11:54:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE09196095
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE6613011F06
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD77322749;
	Wed, 25 Feb 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dshEJyBJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tgq/3AaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE56284682
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016745; cv=none; b=ZuS7DvoxePYxsvbXy5asqFjsrwYQfCWXHb9JgQOpbG+On/sqLwSBZhkmWCwXJpb4l//ki3t35/x7ChsYI0vMFRL2ggnxw5MHs7v4X2R8tWvA52alqy68pAUGknB+U/vGnRQBrnP8L7kz3TKm/gnOdyg88zvS18708zbLrYsCF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016745; c=relaxed/simple;
	bh=FKzjWti9Us44cWxiPdN7ZPHO58SCrD/oItWU6K8mDcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9aQlJGxKsvuWajK7x4SZANams+4W0z1nTq8KOfqyNCOyb0E9Itqv5RfscgLzFnWjRbPPLN1GXhGtvSVnuWrWWhMy/rG9OqN/DqsVp+Hazx7Qr0dt1bouaiHFJ+7hUBeiZXVsNaqmbpzZPTJ9q4jrb1guA9XyqMSDcC2zZ31YDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dshEJyBJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tgq/3AaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SqAA229725
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 10:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OAUAXtj0TpegUipm2O3M8vHQ88s1bcphnoolZD2pbd4=; b=dshEJyBJiRlm+Sbb
	au26Ge63pu2Jw6FKKM1/wX7JCsXYun9o0xmlCsAzcacvmiIka45TeCwyBFJOeQ1n
	wDcoVdZ4aHEfGVyDCD82yMkMylpO0DYKHFGBm0pVKLW5hZlcQIHM/xgS9tfiNLEw
	QperNFVNKTU3IbePhS+gAH7UTg8W+9TSmmQmbS88vu3SUk9heIynLCzs4XDUB+aE
	9nC9MlYofnRKZ8VO90wMdChMHnrQ2kB3xliYUl/c5ZYVQAz7NnMIY21xA4YrEpJS
	vQx4aX8F0PlaMsxSu8kz1hFDOs1zFeFvhosBzRy37VPZldV/hNe4RHW5w/UdbqPt
	xNwzGw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg37tyqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 10:52:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adae3b2135so51881375ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772016742; x=1772621542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAUAXtj0TpegUipm2O3M8vHQ88s1bcphnoolZD2pbd4=;
        b=Tgq/3AaCZsPR9Ius79wcGzr57b+jCxm4ZToDZMyNqgJnHq1TcCezUg08ub8Iu1k4vZ
         OWD2l4xRuQG3u+dSkZBXWPmSLc8GnDA76fYZcPQTouB9xgh8Xxlvgxe2JqZcCoD9RjqM
         2xYWiH3/Y/C6klmn7qOWAnatDanBKdKUcSaKtWg8Hdu6jmurUkpulScKqdPOox5C02hw
         2UyfGryPS4BPpn1M6ySYocnBO98NYl2ZlXWblZtjAd5SqVwicHfY9GUvrnnT55uxOjMf
         +Nc5q5NbtUwFCqCVrwOdFQC9/ZDyKVsE643+Xh8c5ZDB+CmsZR0jgo9mBA7fy6wj3Ac3
         1pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016742; x=1772621542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAUAXtj0TpegUipm2O3M8vHQ88s1bcphnoolZD2pbd4=;
        b=i9N10/LAC1jOthos8FIs8+beA1yyPPqeKDHEH8hAo5iJsCD7Yzf+Fj9WjmNudIqlnz
         EV8N6z25BEbWY8O6tuIGXmwiZgenhb2lDoIRyA2ny35OckQKGLxZiy+9uDHTGREedFTH
         ELkJUf6ruDO5Shd0gBzUbimz2C8X1N3w4y8h3c8beRRnOn+Ywj+V3RqDZrbggmgjvtu1
         Amc01u6TvAemiB7NUfrLQ0XH8Eqy7WmN7uHrooxGh3UF6/VDq+KPCBWzwADui6x60d5O
         e5QUS9M9lYwvTnPeGDgcpf5KL7DEY2gDcOD3qVy7KS3iWHau2pk4JzbaqOE9cvyNtMvD
         9Ejw==
X-Gm-Message-State: AOJu0YzUWRtvIIdi5moz/N7Ebx4v1y2HHV4rCQBd3E46UoCqkxzcgQsw
	NUx/dAERcRto6rGbQxSKZnAtDDkVAO1PTrqW9SOWqSUoo/8wbhK3YsNNRzTTjmnwM4HjpL3eqhi
	53grbBwap5wo++BxEme39S5+jvsZhl4GtvWJNxvAdhwqtWK2hOdF3crQJMYVr69MFiRG/JA==
X-Gm-Gg: ATEYQzwk6rpFZecEPM68loaM5DIqv6iOOiRWCZbTS2JOpWc+P5OnG5p+rc2+c0/9fMf
	kMd6JiD3MZF8dDLHdsc/O2xg2LaTfqCmx17N7INVrIYXKG9lwyijL6BeMsyjCgENgt6W2/EU6ta
	a2sOb9ABm72DxV/P4RTKUyQb9tt4ol7MhuoDAU0imVtmzJ7ibnpk8F2DtLilB+dF1aF/vRZVb2F
	daeiJUQisqtkumcjjBkRe/kcTb+4lXdvFIGcaP9XvVdHks2nobl5YEAEvOuRacm9TNJO9nsilLS
	kE54bFa0wJIjSkiBfqdWiWOxkQ5Ec0NrAlIe3Vpy9sAPW8a0ykBGZW+ojl7SKMqqKonz9FcwdoA
	RvzPSOCJuf+mqUQ+fkMYyU1xXlBnqGogVTal3KmF3mw5rGKoc6w4bucZlHn/luTYbHj0=
X-Received: by 2002:a17:903:228b:b0:2ad:da86:f6a6 with SMTP id d9443c01a7336-2adda86f8e2mr13518795ad.49.1772016742462;
        Wed, 25 Feb 2026 02:52:22 -0800 (PST)
X-Received: by 2002:a17:903:228b:b0:2ad:da86:f6a6 with SMTP id d9443c01a7336-2adda86f8e2mr13518555ad.49.1772016742005;
        Wed, 25 Feb 2026 02:52:22 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027affsm129081895ad.66.2026.02.25.02.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 02:52:04 -0800 (PST)
Message-ID: <cd7f80d1-7331-49a5-9c85-709d1c479a4b@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 16:22:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: add basic hwmon temperature
 reporting
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260223132622.43464-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260223132622.43464-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=699ed467 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=5bxsAFsTsoJVshfinvMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwNiBTYWx0ZWRfX0RiFqqRSphY5
 NhMT+XIFtts2v07i4CM0YT1feo39Pzy2gACbcD/4tnd0RLB/QKy/BQPr38WIBYhAnSOb9YukS+b
 Kg7XR5uHRkFD4RqN1CFi6dyJxga0bUedTMOWE5I+TClbnep+9mzbbcgNmOLdUihmj9pR5+RlHqd
 iIyiW0ESG6SvW88fomlJ4E3+9qHkirripExgk7Pw/QUCz3h4+8HYbpU+OQNjYwXMzCi7H1NIbQ2
 r6QUl+RZ9csZat1IE7aTHCWzxWpE/0wsfjP58psoFqVpmJlMvtxY7yHDL/fQyGRT/f5+tFwxjRI
 fDwtu//R8u9bvEloAt6aDRge037p7YfbnF2iXpbGivjUFm/EvuLlohmK0jAwFoIU8Kncv3dAIN0
 U/RgklhJq5aXv4nQEZeqTUfsj/ft5ZXlMAwVtUNxDJ2iSkahCBGOGTIKQRRzHuIsTPd4SmhoEbk
 XaAs+A4oRXJJKt3oANQ==
X-Proofpoint-ORIG-GUID: ZxzWTlO9QgGxp9ESVrYShVhJVfiZFipJ
X-Proofpoint-GUID: ZxzWTlO9QgGxp9ESVrYShVhJVfiZFipJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32174-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1AE09196095
X-Rspamd-Action: no action



On 2/23/2026 6:56 PM, Maharaja Kennadyrajan wrote:
> Add initial thermal support by wiring up a per-radio (pdev) hwmon temperature
> sensor backed by the existing WMI pdev temperature command and event.
> When userspace reads the sysfs file temp1_input, the driver sends
> WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and waits
> for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
> (tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.
> 
> Export the reported value in millidegrees Celsius as required by hwmon.
> The temperature reported is per-radio (pdev). In a multi-radio wiphy under a
> single phy, a separate hwmon device is created for each radio.
> 
> Sample command and output:
> $ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
> $ 50000
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/
> Co-developed-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

