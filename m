Return-Path: <linux-wireless+bounces-32067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMuqKZ+omGmvKgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 19:31:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CE416A12F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8D6300F136
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2330BB80;
	Fri, 20 Feb 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NyABdxrg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0Nue1ON"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC623C4F2
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612317; cv=none; b=E2zQF6k0xSUshIq2LKzDWkkSDjEDvXtMGluwKrzAhUKtEI0EgEBLGr0bsFCVfXenYbSFjBHIvRGSnV4OSWhGBK3Wgl6h2PBi1hilTbP+tLbMt4Ze6zKn/SQaF9l2bjjdOuO0wUUizT4l1Z+VILXdTMbR8Bzz7gOdpRRHTzkD7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612317; c=relaxed/simple;
	bh=UWh1q8ABrUB/P39S0/qfOJHw+vhVGCThzIlTdanP4MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaL9NtBGFEgoimFPe1QUdcHf1blEmGlH8SatqEIAISNiVckn9MtrZ+HGlcHVnbweDsABfY+E88hgGOmnkb1igimxt8OV/9bF+jWfIYpEVMwnQ3gVKE31KqJtCCvg0TwaKdIdZDR9skdcoo/PVwpo1OVW9jkxI3RGLg8kEn3XRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NyABdxrg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R0Nue1ON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDRV9A3058064
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KKzKOatQ+QtX7F1+D0TaVkzD/OW2SSQh6xZiOY2OyK8=; b=NyABdxrgoqh8L1LG
	eI7PxI1YgyJVRYwqjPiN2eFkRnOm6pA4XMHniPI4O8Eibm7jmOsoJMWbuRreeHMd
	X1ZRf0Viql3Av6Lcb34iJXMj9hgFiAj9Qc1bk9hP6qzSz4GHNTc6hzppZiew+aZp
	Tf6iFJuWCwRKSN+PgvvjoUFykyzkDGVX//gr6FcBuBBVx9YP11qmbWV6Aby6zxH0
	+g64oLazz6s7v9C6zlSqREpmkSQu9MFz61Ppqnv9ZIPG5dqs+I/IL8YyqaSqtFPE
	QIFu1LUAdTzeK+6SjLPmnESuW/g72xHiMW5CQADVtenCT69c4vBD/QmcZQ6BzrFr
	wI/xrg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cenhgsb3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:31:54 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-126e8ee6227so3625255c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 10:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771612313; x=1772217113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKzKOatQ+QtX7F1+D0TaVkzD/OW2SSQh6xZiOY2OyK8=;
        b=R0Nue1ONQ4yfUBbkh6ZjUrv2SQ+gZ4k2lOJJhXpMf4FIwH5eZ/FDiQjEzOaDcCF6EI
         KatEi8Rrjj3mKf2Zwwk7zdFKugDJTNk1AC7FbS+vyKX4nKjsIiK2b2lOKD1X2YNB9qJj
         QAtf0JdTonsv2ZC4T1ssWb0NRz0rz21mKJvbBDKeJYWYNWIrSPsJmSjFSDjB+CIlAp+5
         caAfUdTBWcrg5r9VkcMHfO9gs+oXsNROB7Hjddj98311cPUZ1td5xX4hStRPUWgtmu0V
         KIOVf49C2x+Po8va1/ovQ4q3BjVUQTmO1sfOTxDy0qkhM5KEKP98lAgGZw5Kc7COWv0I
         pHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771612313; x=1772217113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKzKOatQ+QtX7F1+D0TaVkzD/OW2SSQh6xZiOY2OyK8=;
        b=nnPYwXo1nMuWVSSCgys/pCwQirInAEzHxwQmigSJN9442O/l1flsGMayWOkayo9ex8
         jOQIDHzQjHw6/uzp4dw/DWdVnL54gC+XjsKageu9o+ZkJUcjCR4+S9sOg5xPKJbLw+J3
         zsmn/08C6myKhMpeguJda70uGLsCKZrFvc10Tw3uhn0ZsBBgD50I2OTFwc1mEJ9WZDyW
         n+I4t9sRXM17CjoDV4t3FUpNDTWRRjW235xMmch2sJkAVpeJzJAWS7KRZIlE+slyQTgd
         NinWaQ/jwAXfxidMhs9S2y6QbwUdziIkRKri0ZB5QBPnJ7si6NU+I9GxsK7lBUwpYOYw
         QWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYDEGcuPUKbCSypQ/6C49RmXoDoTf1S0ZB9GK4MzaC4l3ImR21Bgmv0LaL8910/CoIXJz9KQ1nxjyxNbJ05A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywds51O628Oil5sh3cGm0FOQ1ev04xCEqnCRVkn02Kge4Jy4v9K
	Tnazjri4jPneOC3+Spm94Hfcs5pU6u0tkcL20LPrW9rXhMHITFr03yAl+NqWuhHtdnaX/4fvAXB
	eNrPQfJx6I4f4hma+XzTkaH7CTSN1xYrfJNBeZlxLCM7ec4t/P9ZDDSEB7VNWyY6XOhPcxg==
X-Gm-Gg: AZuq6aL6jvhXSHEl8GYVWVq3X+Y72aTYrv9dyHs9hBBtQztU2tQZ9PY60hn046M50pY
	dwhQfG8Dt5M3G+z+NKXxDgRIbVhD5Vq2JWGepdRVh61qvg6ymNUvhT1dbi1jAGGmBwZUvz5/TjD
	/J9hpBQSW3yMzFd5CagiwsiVQzXCLQhwr9IVkeNP6X7N2Exn+ShL0io65GeymL80b659tbHlXfF
	xCCj4q6zNt6ZiJNAiLkhgZpCFu5WW3kGxyy+u3Ikc3VuKAigrmCaJIyoNiIxZvPXNqKwqehSL9Q
	Dpxzy7ryCAaPha9q4lYLmIRIDQ3xB67NGD7y2JOomI0R+dRjSD/QFJu+sMi3puCgdO1QWi9ppBJ
	ELUp9J/ysVw5NUWvOig+utTfcwKsB+F3nr5L2qR8zSXNas5mlblbL+sfaq2VyE5Sr8SwXfcaikW
	lp3REPydqsK1DWuQ==
X-Received: by 2002:a05:7022:419:b0:122:345:a944 with SMTP id a92af1059eb24-1276ad1b530mr224771c88.29.1771612313445;
        Fri, 20 Feb 2026 10:31:53 -0800 (PST)
X-Received: by 2002:a05:7022:419:b0:122:345:a944 with SMTP id a92af1059eb24-1276ad1b530mr224760c88.29.1771612312923;
        Fri, 20 Feb 2026 10:31:52 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af9f74bsm147048c88.15.2026.02.20.10.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 10:31:52 -0800 (PST)
Message-ID: <ea008cf8-31b5-423a-8cc6-9f3ba478de84@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 10:31:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] Adding NO_STA flag and reworking RX link
 resolution
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260220141929.206976-10-benjamin@sipsolutions.net>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260220141929.206976-10-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJVIilla c=1 sm=1 tr=0 ts=6998a89a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=QyXUC8HyAAAA:8 a=m6j-YaEfBUw9QP3J9igA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 5C3gERx9x4GCBrThNNlLfrdy1IUlUv3q
X-Proofpoint-GUID: 5C3gERx9x4GCBrThNNlLfrdy1IUlUv3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1NiBTYWx0ZWRfX3ZsMsUv6d0b7
 +0D/DITB4c+XMN0IGrmXp2ABAFD7dfowTBn4p4PntcmvIaP+G65D/QetCGkj9i6xCxoGMQ1E+u0
 IPzvGsiPnKmbbK7OIjliyb8Eg7Z5z5LqJiGWQSreRdPvk1PzCDAhDrB4V7mJSmKXbqaCK0vOFe7
 ADp/wQ7Kr+46EiZYyyFaobLFHHlMEnkvKrU97u+kNtU5wtX1PR0pLRIVioBSUTz4MXtMeShAWZ9
 Szl/mPJXc6HNR+TUD2hi891871QVxELc064lsjFZQl7OAcpPOpetAgUOY83pl9edRXWDuwVRH93
 R75P4lPBngs9d6KYb8AkgvwY8OjdfiIuK0cc+h7oHzysO/VUU8t6b4uxwOxFG4Evh3zTe3QyjDA
 aQAAn/0bXDrAFCI36qxGcwsq3ZiqHdaKvQODnLiJmRQiOuUkfbTIUoLfMvV6PU4mMULd3WIrFci
 iUN5aVTSb4h2ybHksRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32067-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03CE416A12F
X-Rspamd-Action: no action

On 2/20/2026 6:19 AM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Hi,
> 
> This patchset refactors the RX link resolution a bit to fix some issues
> where mac80211 might accept frames on the wrong link and incorrectly
> translate the address. It also adds a new NL80211_ATTR_FRAME_CMD_NO_STA
> flag so that userspace can know whether address translation was done by
> the kernel on RX and can also prevent address translation for management
> frames during TX.
> 
> This together should be enough to fix the existing issues in hostapd
> where stations that are still associated try to authenticate again but
> hostapd for example ends up sending the frame to an old link address.
> 
> I would appreciate if you test the patches and work on the hostapd side.
> Note that I have not properly verified the new nl80211 API, so it could
> well be that I missed something.

Lack of changes for ath drivers prevents me from running this series through
my automation.

drivers/net/wireless/ath/ath11k/dp_rx.c: In function 'ath11k_dp_rx_deliver_msdu':
drivers/net/wireless/ath/ath11k/dp_rx.c:2503:35: error: passing argument 2 of 'ieee80211_rx_napi' from incompatible pointer type [-Wincompatible-pointer-types]
 2503 |         ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
      |                                   ^~~~~~
      |                                   |
      |                                   struct ieee80211_sta *
In file included from drivers/net/wireless/ath/ath11k/wmi.h:10,
                 from drivers/net/wireless/ath/ath11k/core.h:24,
                 from drivers/net/wireless/ath/ath11k/dp_rx.c:11:
./include/net/mac80211.h:5249:51: note: expected 'struct ieee80211_link_sta *' but argument is of type 'struct ieee80211_sta *'
 5249 |                        struct ieee80211_link_sta *link_sta,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

drivers/net/wireless/ath/ath12k/dp_rx.c: In function 'ath12k_dp_rx_deliver_msdu':
drivers/net/wireless/ath/ath12k/dp_rx.c:1344:25: error: 'struct ieee80211_rx_status' has no member named 'link_valid'; did you mean 'link_id'?
 1344 |                 status->link_valid = 1;
      |                         ^~~~~~~~~~
      |                         link_id
drivers/net/wireless/ath/ath12k/dp_rx.c:1391:58: error: passing argument 2 of 'ieee80211_rx_napi' from incompatible pointer type [-Wincompatible-pointer-types]
 1391 |         ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
      |                                                          ^~~~~~
      |                                                          |
      |                                                          struct ieee80211_sta *
In file included from drivers/net/wireless/ath/ath12k/wmi.h:10,
                 from drivers/net/wireless/ath/ath12k/core.h:24,
                 from drivers/net/wireless/ath/ath12k/dp_rx.c:11:
./include/net/mac80211.h:5249:51: note: expected 'struct ieee80211_link_sta *' but argument is of type 'struct ieee80211_sta *'
 5249 |                        struct ieee80211_link_sta *link_sta,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

drivers/net/wireless/ath/ath12k/dp_mon.c: In function 'ath12k_dp_mon_rx_deliver_msdu':
drivers/net/wireless/ath/ath12k/dp_mon.c:520:17: error: 'struct ieee80211_rx_status' has no member named 'link_valid'; did you mean 'link_id'?
  520 |         status->link_valid = 0;
      |                 ^~~~~~~~~~
      |                 link_id
drivers/net/wireless/ath/ath12k/dp_mon.c:538:33: error: 'struct ieee80211_rx_status' has no member named 'link_valid'; did you mean 'link_id'?
  538 |                         status->link_valid = 1;
      |                                 ^~~~~~~~~~
      |                                 link_id
drivers/net/wireless/ath/ath12k/dp_mon.c:586:58: error: passing argument 2 of 'ieee80211_rx_napi' from incompatible pointer type [-Wincompatible-pointer-types]
  586 |         ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
      |                                                          ^~~~~~
      |                                                          |
      |                                                          struct ieee80211_sta *
In file included from drivers/net/wireless/ath/ath12k/wmi.h:10,
                 from drivers/net/wireless/ath/ath12k/core.h:24,
                 from drivers/net/wireless/ath/ath12k/dp_mon.h:10,
                 from drivers/net/wireless/ath/ath12k/dp_mon.c:7:
./include/net/mac80211.h:5249:51: note: expected 'struct ieee80211_link_sta *' but argument is of type 'struct ieee80211_sta *'
 5249 |                        struct ieee80211_link_sta *link_sta,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~


