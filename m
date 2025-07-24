Return-Path: <linux-wireless+bounces-25967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71AEB0FE67
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 03:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB651C279DF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F595186E2E;
	Thu, 24 Jul 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbGqk9l7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46236187332
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321311; cv=none; b=ljOCNbcDzEwq0F3Rq1sxFD9TwNUMwz45Br4R+PZL/2Z4VeYmkaUTjoH80bpDp3I3lvfS7x+rHeMmuiXfJcfmLrmQzz8U2HES2Tve2Dz6B1eYxabmB9GcsMPN901442QH6gW1FsztlQI/AmctiGCJBr2OjU6zq3BBnB4Zn2Gz1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321311; c=relaxed/simple;
	bh=tgMrZhqcs6LlFm9tZEm1ilzQvjFnP85Koztg8DHCrg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POKDp979MeWAi3tdD/ZHYHPQTP563aBdZNFjWUG81+5Q8YrwGuYmiFxahu34ZSKk/5l2sWsd/u6Xd+jzhJ7juBkAFh0L6cnL7/LjuKumH/8uWe24nZ2cPSRFxzsT/CVhMjiQjQyXVv+QE27ixL5dVOwRJTnGr+JuJ9RnfS2xa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbGqk9l7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXKCZ018046
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 01:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3l5vVTkH19Z282OOXYT7AVaSkeC2Vgr99aP1Mh72ErA=; b=AbGqk9l7JyqEvtLG
	xPu315+pSjIiJznXNvDVSuZN5drzlf/fsnaMZKwwQcpqSlz/tMOHSd0x1sFIYzOf
	kgkL0bdLc8gR1JYnazgzgNQvlXd0muA72uIvbPBiDJqmt0grTKMCunivB16vpnMb
	soTCx99XCWCotjSpe04Qojqt5pUIX/mlPrkmF7rIJR4ZZUyb0vFJ3K5+7/SZHacR
	Xfk9sT1AQQ5d1WuAu33TSwpaRrznLm3yK1tfkUMmrqoF5UbPwFdaARN4fHrXUPeO
	sgBo8ed6dK7+bpyGj3F1Xu33Ey+Vca5lyzl8Dvfbg+H/F576z7CiiBgsYTme02Aw
	9PGGSQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6s6rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 01:41:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31f112c90aso404722a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 18:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753321306; x=1753926106;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3l5vVTkH19Z282OOXYT7AVaSkeC2Vgr99aP1Mh72ErA=;
        b=h+hMbGld2P4oMEZ82BjBNVezuFpsSt2OhWSOBo7I5BPi/EDDH2N68EvO4yXvkYqVG/
         x72YTZO1OyRmaQ0QDhuq4gOrqKlky1pkVJRT6zK1y70PxdNlQ7JOQ9W1ovFKBVw4A3QC
         nDuz4/iQvyawy3MQE698aCbj+Oqt0IJzhiLphhUKjjTnGV8dv1Y8475JsBNM0/SeXPQ6
         c7H3Q2tigFtxZQ7QTRDRjy/XaGgDAAQAgD2s5tjPAeZpMIBZ2N5dNLZXSjDZbLNmb10a
         uyE23NInBo91+jQ3lmtgPcehlVWXpVfwQ4dpQjHqtArkSxbtczzjxL4Ozr5tsgFNvdSW
         iZgA==
X-Gm-Message-State: AOJu0Yx0uJkyq/FepQQxxZ7+c5hm4iFqjHHO9PjdM5/MGepFmc7877OC
	J48izfxBDPZa6Fp88oZFvUl/vQt/oM8lHFC/EdWfPi3pT0RM4CJ9CEIGcO5UV74J7bCkrnFW6ps
	eWfV3/Xsvi40QdEAAmu+SHm7UmaNcW6zd877hkDGrlnCo/3aWX0ukG2hBJr7g0HzQK+cZ0Z7XlU
	M9Lg==
X-Gm-Gg: ASbGnct56TgkpU1d+IAplVINTEWnGxvs0rlbmMakCkHMXsTi+M3ScbdsgaxluwEW/aZ
	/VuISqjBIZUacbiLTwNI47S8vquE0lrB2zM9H4jc9cNwUr1Wjjf1XTTMRK63dyKT/Cb304S33Hn
	8tuTf5seG4dJ0uJN71GmJa4Ys0r4t+vFR/X5G33wbCZvEBGkfWeYusCKOJhztdNvla+oQmb7A9Y
	nuBUSgGR2mTZRiBW6Oqe++IgNOq/Rh+KJL7YbIx1qua0w/tT6s9yQft9P4QkH46SZrMJXVG+g+Q
	MKeyMuchyOHhmMp02RykkxBvlSSMaOKLmh5ruaZEpOCvWrHOGSdNZymrPkKaWhX8T+1pCDpuYKd
	UBlWJBCPhYMuWNON2algbsJTLXiAEi+uP
X-Received: by 2002:a05:6a21:7182:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-23d5b6d0d5bmr271127637.21.1753321306551;
        Wed, 23 Jul 2025 18:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfD+HGAkMnjB5I3dCEWR4gDruV20/UEZdN21kQ2WAho8Z9MdvKFzZRB08ebGbrhWrhU3FYaQ==
X-Received: by 2002:a05:6a21:7182:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-23d5b6d0d5bmr271093637.21.1753321306071;
        Wed, 23 Jul 2025 18:41:46 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761d52fe8cbsm189010b3a.111.2025.07.23.18.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 18:41:45 -0700 (PDT)
Message-ID: <1d5f27a4-5407-4cf2-bd52-1ee75a4050ef@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 18:41:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] wifi: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20250723201741.2908456-1-helgaas@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250723201741.2908456-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68818f5c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1XWaLZrsAAAA:8 a=NRXtL9kN6jlbBn24eUgA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: wBK9LeF1aO5PACzPPTjpWjWrpNhF0EuV
X-Proofpoint-GUID: wBK9LeF1aO5PACzPPTjpWjWrpNhF0EuV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAwOCBTYWx0ZWRfX2qNd5J/aFh4O
 GtGTxay3gsRZMtpUO1hdb1FbE2Ne75ax43pkEuDzzkIe2s0PQglniFafu60KJUPFQ2Oc7SFfFOZ
 wJmOZLdGcxKM3xgGror7bvM7WFIe/XY3fUcFQPeAgTlWBRcFtnQlj+j9Q9NEyDzESVYvzu0zzwz
 jb7+rOopxVOa8iwbHBbQhdrkbg7f4qwHTodh0iiTYPXYWcFUiZS9BQL1HvMoyHN4k0lMLOpYAGd
 37mlPJ/HugKDlf9Lkd53cZFzNgVpT5fQ4oyJFjdIwGvZwT+4TuXqjOGVvgpwnS7VeWaW58+3omk
 yr9mmCtaAIJ47QoEPbl7vZm/sJLigm7JiFsDmz71cVJWKrnklhTDWLR9duulCkEIYagyGXpTzYR
 A0LN6u6fVQpnxPwI3MJ/m0vuCQmHRYWQUaddjStYU4D0VFIIr0SwaB1qJCUABEvG/sueJ6al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240008

On 7/23/2025 1:17 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments and error messages.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/wireless/ath/ath10k/hw.h          |  8 +++----
>  drivers/net/wireless/ath/ath5k/reg.h          |  2 +-
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  6 ++---
>  .../broadcom/brcm80211/brcmfmac/common.c      |  4 ++--
>  .../broadcom/brcm80211/brcmfmac/common.h      |  4 ++--
>  .../broadcom/brcm80211/brcmfmac/core.h        |  2 +-
>  .../broadcom/brcm80211/brcmfmac/p2p.c         |  4 ++--
>  .../net/wireless/intel/iwlegacy/commands.h    |  2 +-
>  .../intel/iwlwifi/fw/api/time-event.h         |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  4 ++--
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 ++---
>  drivers/net/wireless/intersil/p54/p54spi.c    |  4 ++--
>  drivers/net/wireless/marvell/libertas/cfg.c   |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  4 ++--
>  .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
>  .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  4 ++--
>  .../net/wireless/ralink/rt2x00/rt2x00queue.c  |  2 +-
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  |  2 +-
>  .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  2 +-
>  .../wireless/realtek/rtlwifi/rtl8192se/rf.c   |  2 +-
>  .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 22 +++++++++----------
>  drivers/net/wireless/ti/wl1251/reg.h          |  6 ++---
>  drivers/net/wireless/ti/wl12xx/reg.h          |  6 ++---
>  drivers/net/wireless/zydas/zd1211rw/zd_usb.c  |  2 +-
>  25 files changed, 55 insertions(+), 55 deletions(-)

At a minimum it seems that this should go through wireless-next instead of
net-next.

Even better would be to split out the patches that have dedicated subordinate
maintainer trees (such as ath.git for the ath5k and ath10k changes) unless
Johannes wants to take this entire set.

/jeff

