Return-Path: <linux-wireless+bounces-27888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D6BC5F5E
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C06C4ECBA7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C372E22B4;
	Wed,  8 Oct 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYYhrOhS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12B2BDC35
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939772; cv=none; b=DQjRRQzuk9E3aSLspKUkWgdbS6ynKDJUyV2ZGQP6F+l1+PhTCv/0Y+1FIacjivWWBhpPWgGAp1XaHIj8QRKqlu5e6ZGU6cOztDozu/W7ebewrYUnqxy86S/jy16FLqRuXwaKcp9hBnNSP5E+XRM0ziINukJ3qMXPReNUDrf7YUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939772; c=relaxed/simple;
	bh=Pf9PFBePJibtPuZutC39spPo/GZoBM9xhcwgpcje558=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmROaPDcjLrZpxsqNn/brMVgfcnzMWtb2qNG11xG8rnslalVVpx1pbUht5FZ0SsvBE6tV7MYLMrCdEjbpgwWm3N3tz+FZCKvre3DmVvFmjJ1Joh4EQUnU9jgccPyIQwn/TocRDovqJQKZj2J4rUtss6FWXdj0yBb0TpbqKj3eBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYYhrOhS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890N8X001621
	for <linux-wireless@vger.kernel.org>; Wed, 8 Oct 2025 16:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9SjNOmBYkgmQ4w218km+CPYe5MEFlAVFtIXfYnTSkI4=; b=NYYhrOhSr8+/V/wN
	mCrm98SqJlQE3wnZ4aSfbXipocoNNbFitASkoM4ij8OO1g3/EKjiUtz6bLIoMOsX
	v8Uz82Y3gbyo1kqlEqxncpnaXknpoWWqVhSs9/CDgJQfcZBk88kQH/40KT9bJYdw
	3sEpHSQRO3vmNsm1A8ABBAw478RxIlnf4fNMDEhCyXjARsPNBwDrVA73JpCKWqeN
	wnQ2vZaIWNWYJRIYBW4tx5pe3FpD3y2r03FlTiAj+IL6LjioJnpGgyL/8fazkfPY
	k485sJ8TzQAda+olZV0ggo4p6QcMqAwp273bg2xD6jtushHlYOlOp1zDdGdHtEr/
	0ypBcg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxnbggn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 16:09:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7900f597d08so3760154b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 09:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759939768; x=1760544568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SjNOmBYkgmQ4w218km+CPYe5MEFlAVFtIXfYnTSkI4=;
        b=vWgXmeHuUw5JE9SbxEJ/v8gCsdsNSa01d99Kfyevxy906RJZbDsoJ4H0XlEEyyTSAY
         cC1wQZJZ8EVelWZ5MGfGSwQC5L+A8c6R+yG1UU7sLY7QwCL09Zy7yt/tdbGDn+Ish667
         7FPzvGSichtWYYq5YoIvjF9xHNFL273hr4EnA/czWE4TrMqJb7AqXuA6ScmfmWRAN7d9
         nHyIREkyPSS7js6Wh9LP3rrjqTgy+kcgzqsbTnmwI7MVIJSZmAl0IfcGm6rB895P9Lh3
         noeBM8s2DTE3J934ZdmMHynTTp+HlC1gx0vyI8QcisGegjeD2cgdsHwFIpHCLjSMBw0f
         hNNA==
X-Gm-Message-State: AOJu0YzIOAi27To4wYnyxwqEcif6PAJQAoor0GJJAvGS9ufFp7h2hfO5
	z/m2wBvvrxxyStDqQrAHpsM1AjwyI7Nxvn7kj1P8n8PLLMPd+cmsoUiV7hKcaB1CQYp1WBtO+gt
	dIKQmXX8gjvOKbuC2YLrQZKWvUoKm2VTJyQIOBkxtpkOUG1mdCeBs9ptUfl2ja4+Z4757uC9+EO
	1bWg==
X-Gm-Gg: ASbGnct1iSm/8RK5kyjd9w4Tgwl4gk72vGtT1WDc9WhYS0aIeDPGXhca3vdOhNQujDO
	cUni0ANCDoQPfT+CxUp3PEof08D/pdsXYCjixshcDpe6VkGSOWDuYOT+YBd0QQp70Snt/QQcjiv
	klQ6yNDJsClBXkM7GZtrXVzbYbaU6/LuuQqFCZ/kAX9xgMOiklX7Cxjl9J0907Jh4m9h6fEb7JX
	Fo7GqY850OF2pGzfDwwx6rj7gjh5MNhTDeTlFV2UXHi3zIMYupWxfmD2ImvKuSpFGeXvJOv0JJT
	KJD3ntJ6amArQChC/DEzx+Koi4SGAxR5TrsZdk0gHunCJNqCI4I03WOoPOdmghdB4ZqAMlhiSUk
	k3rnVC+g9okODHr2BoqKTJQ==
X-Received: by 2002:a05:6a21:6da9:b0:262:d303:38ab with SMTP id adf61e73a8af0-32da839f896mr5751525637.33.1759939768052;
        Wed, 08 Oct 2025 09:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwSYhZX4V4TmEwCuDMwX6Kq+U1LCW3VSwEhMXEfdqhJXPuvkVj+O+uuSORendAHkxiUu8ehg==
X-Received: by 2002:a05:6a21:6da9:b0:262:d303:38ab with SMTP id adf61e73a8af0-32da839f896mr5751472637.33.1759939767494;
        Wed, 08 Oct 2025 09:09:27 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.106.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d510e3fasm148113b3a.26.2025.10.08.09.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:09:27 -0700 (PDT)
Message-ID: <fb9ca418-4df3-ba1e-9fce-9353c2a28136@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 21:39:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Defer vdev bring-up until CSA
 finalize to avoid stale beacon
Content-Language: en-US
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250924134336.888-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250924134336.888-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfXwi9NmnXrPlDv
 FiYI7kQvMkiEufO6hnBIJO5xIxutQjioH9YXBnye8UHX2QtiCW1BSHdOlkwrcq1q3nOpoCcVm7B
 mNU41XPPa+GxiCRe65KaLMJXnJqcGLQW3o8QAClwZVN6eYJC4lUD9KfzQz1sZqwQ/tAaRgpkmfL
 S4pZgM/mdvReZ7uzst6d8W6H3yv3CjO7CbIEFJtnveULazmUh2/HUxWicw+xL/9thKOuMqehnwG
 hL74moi3nqS8XZjDWXJHFB1PUZfH54sHMrmMGyk5ntTN1AIRxRjeWHLSRiOSvrMDG+K3Xy77blk
 RkSVkUa4IEL5JVzrJj7Q+8hUE7+n7SV1ENaK2DK8SXeG9uYYu5mfJcOLkb7uGNcpEuk+d5JyM0F
 2V1XSG8Zk7ebJQcD6/26Br5pyz/isA==
X-Proofpoint-GUID: -wwZXlq8RGWqfId5SBJ61uKhlINqmm5m
X-Proofpoint-ORIG-GUID: -wwZXlq8RGWqfId5SBJ61uKhlINqmm5m
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e68cb9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=z6xreaRxtU16OQ9bEhv1vw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=BueIPD__e_aKeFq9xe4A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001



On 9/24/2025 7:13 PM, Maharaja Kennadyrajan wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> Mac80211 schedules CSA finalize work twice during a channel switch: first
> during the reserved switch phase and again during the finalize phase.
> The beacon content is updated only during the second schedule, which occurs
> after the reserved switch completes. However, the ath12k driver attempts to
> bring up the VDEV during the channel switch callback
> (ath12k_mac_update_vif_chan()), which leads to premature installation of
> stale beacon templates before the updated content is available.
> 
> This premature VDEV bring-up causes outdated beacon information to be
> broadcast, which can result in updated channel parameters during the
> transition. In MBSSID scenarios, this behavior is particularly problematic
> because the transmitting interface's beacon must be updated before
> non-transmitting interfaces are brought up. Failing to do so can lead to
> beacon mismatches across interfaces.
> 
> Introduce a is_csa_in_progress flag to defer VDEV_UP until CSA finalize is
> complete. Set this flag during the channel switch callback when CSA is
> active. In bss_info_changed(), check this flag and issue VDEV_UP only
> after the beacon template has been updated.
> 
> Ensure that in MBSSID cases, the transmitting interface is brought up
> first, followed by all non-transmitting interfaces. This ordering makes
> sure correct beacon propagation and avoids stale beacon installation
> during CSA transitions.
> 
> Additionally, move the call to ath12k_mac_update_peer_puncturing_width()
> before VDEV bring-up during CSA handling. This ensures that the puncturing
> bitmap and bandwidth settings are applied before the VDEV is brought up.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 8c6faa56bfb2 ("wifi: ath12k: add MBSSID beacon support")
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

