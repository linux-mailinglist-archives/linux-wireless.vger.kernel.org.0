Return-Path: <linux-wireless+bounces-31547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePrLKlN/g2mHnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 18:18:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D82EAEFD
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 18:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675083010D9C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521B82EDD62;
	Wed,  4 Feb 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ks9sF/V2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQQ84OFu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B227464F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225488; cv=none; b=NjqeoDrmUx2rH7x38aavWeRWteJk5OjciFK/JkiaW5hCpoYLweZZPksXJSBDfON3Jxz3kBBDKWUjNNPOymyx0eHw9xgyz2c/kso7oAKVOKlESYCkFZophWD/I04ZbeRPOcT5/XxLtWttUc6sPxYeYnAwe5xb55CRwDAjai+/r7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225488; c=relaxed/simple;
	bh=HB/2y2fHVJQBwqKtNYnVoas2MEiFW4DKG+OKGR6LCDA=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=B6JLl7p/ljAN6BLA8Sgl0TK6OPyvIM/s2hejcTH1Nk2uMGkJ+G3NQaXIX1c2kPPfHUX+n7NenqqEnV7OdJP7gWT0rrYOEUGKPyo9fmwyu9jj7dfax/aJ0dzQGbPJI82xf0ZNlHksAeQ0fOeXCwhvmB8L//PJoSdOXgK8ln+7/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ks9sF/V2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQQ84OFu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CISxU1880671
	for <linux-wireless@vger.kernel.org>; Wed, 4 Feb 2026 17:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8opFdOz/tc1NxrXdMT7CER
	6PwqQ8gtJ2RmFX8c40zGk=; b=Ks9sF/V2fez3S/ZVEalIMMMix3TE4RWWsl4hye
	GeRpXhA27IIxmC/RPeaKrw7r6YctIzFMAE5/LAgIjksA4fEBinvshUEW3pknapMi
	08NQU4AyK8pfePH4ICxyQ7UmoQws5BbeQ2oHqY8/jm7ZxWyKRPXd9t7sFjjcKSz0
	v9sP6d+cvEfedSYM8cqFwK8Bnvr7rsmcZXw47eU9ou3jHdHeegnS8i9qMG/CBdnc
	Q+bh6H2jL67g38xbdPJzjw2VZLCrhVqmWMPVmGRSXcU1whLN2IHmw6gPXJWj8LgB
	hSNQmq2IhU4AmFKg6UwakbVY+BHYDASfg5+sHQIP32HWSNsw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43n9scs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 17:18:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b71d3ac508so6672275eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 09:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770225486; x=1770830286; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8opFdOz/tc1NxrXdMT7CER6PwqQ8gtJ2RmFX8c40zGk=;
        b=fQQ84OFutWwV6O78Q4rTA/e54dqa5/G6Qox3xBKyqjOrho+CldHbtPa1L/vcYKfMmD
         UfG63cBANAlVrN64N7dWMel4Kl5IGvmNq0d9AX0GkDS+EzDqPb76dVaU8LZKpdgTQ+MA
         /47co1z0qZY0YI9eVLiOZuhbsu3l+84rV6k+jFrUVCAoDuQCOlZjrBLy57iVZIDwUKWq
         n0gDRInYzwUMv1xcjc2F2j3UuoP0iNhk8FX9rSkdyOxwGS+BbG47XzD38XZGsw1ZdPtV
         8Zt2Nah/vlVixPeLEvQIbbQ/FAkC4cn2CfXREeoCPfp6btmo9skcIAvIUM2h6PZT/12+
         yfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770225486; x=1770830286;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8opFdOz/tc1NxrXdMT7CER6PwqQ8gtJ2RmFX8c40zGk=;
        b=Sr7ipimROZB60R74iwErCIVKZN/j8Jo6ywfYXshZAUFXqvAmMx6hv2bHSmpwhzK3dj
         L1qp2JYQyQwq9/eaxy5v38s+b+zAHmqUXmd0wWdpJvTJCRM2AbOVAsTerufAWl7hbpYD
         uwYvRoCv+RMPZyXyHZQs/OY2TcuoUK0wzbwxh4KpWntlbxAnNoKhwQLe7GMtOZERa05V
         5SP5UmUw42W2uYDIik2vPH/HyEgMiQNRwjH0jl4icQRiIgvCUL1wMwXcx//dBi3sle5R
         1jq0H9NOzexCvmM0i441sZXJL/PFR/yOUG8Sp/zJ8R79Sp1/4vY2HxnBQt6V21Uxz9WC
         TSfg==
X-Gm-Message-State: AOJu0YyuighMTysLehd1irh+qctI48fvl63ZmL0e7IPyl6HGFAlOGoNR
	rULakXnQMWLGS+jIFi1I6CMH8BeiUCsBxMZ8fji7mOhY+CaHeqSlsi9VlcCqD8Wf+Cxx26aVxBN
	aXpA3BLpw4y0c+SzqwyJoLe4NWP9PqbZhToSkXJMZDyCE9dtHX07j9gOc1vYhLa1KwBmBiUTepe
	xSRg==
X-Gm-Gg: AZuq6aLmhkJTesZrRm9gECjhIOoz3JscD1q64HPod17NjnBW+SYbHZ70nqqjZrZoAnb
	80aOMyp55Xis7Zhy4ba3zxsWnFhtGcjWsbmkNXtwA317BYY56u6AJaTGaCDjjGNe4r2ZkCKTauX
	RM5BdHjmTmQvL5BRnskyHrfk8yiN5BdOqa9XI9QW8ji4ouhaa40+uuFV3aKe3PbY3YC231sgnQp
	nV8lsGvm6DMWkFgGSxr8JCbE/YPAMMcso0vId94oJMAC5RnyE6i90UjkKOyNFVYtyrGO1ylIUQ7
	y/xn9FKZvXXJVANClvfsIDpY2C2R34OghBBkzTpUSxLWArpBfdcJTB5YVmbgWk1qOkNmzZwc6QT
	8Geqdpes5+dUMUaVVtLflUvycwXuTWwxCitIfAT3h6bjVDQ==
X-Received: by 2002:a05:7301:1008:b0:2b0:56fd:4b67 with SMTP id 5a478bee46e88-2b832919b37mr1535420eec.12.1770225485600;
        Wed, 04 Feb 2026 09:18:05 -0800 (PST)
X-Received: by 2002:a05:7301:1008:b0:2b0:56fd:4b67 with SMTP id 5a478bee46e88-2b832919b37mr1535405eec.12.1770225485029;
        Wed, 04 Feb 2026 09:18:05 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f5030e22sm2490537c88.10.2026.02.04.09.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:18:04 -0800 (PST)
Message-ID: <18adf454-8e66-4b3c-a6a9-81faa2c57602@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 09:18:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260204
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzMiBTYWx0ZWRfX5ORMC/duFctX
 GJ7A4wHmmIiD90K+iWYHqle/oi9OJUDDxIikZuc5K01bOTLxnfYV7PH5somF+zQ7eTFRJxsf2i5
 rLPI8e6MdoIsZtqTS3ndcxk1/AsdoQXu4Ljytm4SWe7tyLMXY1zZjpImRReXkJOHd4V2a2Fxpta
 q4ARsTaYhBCqfvNhCTnLRNk7I0B6EbDdwk63UnxN+eEN0nWVL+Bb+thbSYEVEpf85lPU416r4X/
 4SYlggAwa5K9ltrr5CJ5sjvo2NNZh52OQAkuP1qvVZSSvdJVoVptR47oGAG7N6kaCshijn52xZf
 GsiKzx/Zq6qsmQlJgCXUyveVlPVKjFj6VLMgBwnP28tsQKkAuMhyCLmM49nf5Oeyw06R0EMyxCU
 BF31dg1CACPR5XTHye6M0wvcNNLNKBocZX6AgDb8M2E/LL8Zygu4yJWpuoMWHwOwvMuadd0lALn
 8OhDgb8E7gOkcIFoTuQ==
X-Proofpoint-GUID: Tqp9aVWY6BGU7OF8ZGRm9BduUyRcyN7p
X-Proofpoint-ORIG-GUID: Tqp9aVWY6BGU7OF8ZGRm9BduUyRcyN7p
X-Authority-Analysis: v=2.4 cv=b42/I9Gx c=1 sm=1 tr=0 ts=69837f4e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=DW_G4QuS8ySNF3ajTrEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040132
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31547-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 11D82EAEFD
X-Rspamd-Action: no action

The following changes since commit aeea3bf80600892be582a61de1551cf431341d9e:

  Merge branch 'robot/pr-0-1770184708' into 'main' (2026-02-04 09:13:00 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260204

for you to fetch changes up to 81a99dba039a21fd83d37a67a7de0fb80152e065:

  ath10k: WCN3990 hw1.0: update board-2.bin (2026-02-04 09:09:43 -0800)

----------------------------------------------------------------

Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

For ath10k update board file for WCN3990/hw1.0 to support:
bus=snoc,qmi-board-id=41,qmi-chip-id=30214,variant=Qualcomm_sdm845hdk
bus=snoc,qmi-board-id=55,qmi-chip-id=30224,variant=Qualcomm_sm8150hdk
bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=ECS_QC710
bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=Google_blueline
bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=Google_crosshatch

No updates for ath11k and ath12k.

Please let me know if there are any problems.

Thanks,
/jeff

----------------------------------------------------------------
Jeff Johnson (1):
      ath10k: WCN3990 hw1.0: update board-2.bin

 ath10k/WCN3990/hw1.0/board-2.bin | Bin 742192 -> 867116 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

