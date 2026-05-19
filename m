Return-Path: <linux-wireless+bounces-36662-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB4EOBx2DGqihwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36662-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:39:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44A580AE8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 697853059FB2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29D12D0C63;
	Tue, 19 May 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DK0MDlr0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cbju8xZ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF01327C13
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201279; cv=none; b=otZghZ53E47fz3vlky9uEn6OHr1RIIminhfxwyuTJ+vdgpsZfY88GLYFQZOi1aW99wu55Cs8IM+OU+4d0VpgC7mo3LiFIvqw0GSVG+K0jVzGhmsb76U878Dxtuno5WHUgaNRA/a29x0NuAqyj5vgUOt9jB4td/dnrDQHN3BV+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201279; c=relaxed/simple;
	bh=jJcddQjTm3RafCJKkZPbcoFZiP4B7Jn0jPZO52rtKSY=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=tL0gqANhqOrq12K85tZU6JKcq7/cBKDQJ7RdARNTXYbxkbZzZrASE9acWzSqZjUBqGVDgLA9+F0aa5//lggfgxGtiYEzHipRs2G+sUiMt4kUtQBlRiJbdoC7CgFO8KeK+1oiP7kMHbUcEuNEhTNaa4YDgs6bFaGdFkJUic4Gk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DK0MDlr0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cbju8xZ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JAwUqF867200
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bIoRuAJAPcJrNuPsGqklan
	qR/gpLUP+rn1KnUvtrXQA=; b=DK0MDlr0X1ZNkZUEDuVb36fmYCLwDy3nHTXVte
	ouDf7K9IzR+CyHYWNCoAZIBSvBOId1+NkhxKeDuahqK752emdnVzUMdW8mN+t78x
	SDPZPCixbZ0YccLP/5XQUjQH/UlPdS7nrEifmaxj4C9UezJJkPtEfUWFdsUn7Id/
	udeN6bY3Z+FyzQcJ7uZEnU3JKt9zif85GrSDh+He/yAkAEIDwgFJJ76wZpWZtCpP
	znN6xcP0nSl1eKIP5XIvfsfwe9OagJeZJAr4Td2WMwsXHhMmsxt5IzXbd6YiJyEn
	5nHDvc6KVefe1wLoNW+9YxI0r5wp2tJrW+2F8hWbo8t5hpWw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8hv1j81n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:34:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so6928593eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779201276; x=1779806076; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIoRuAJAPcJrNuPsGqklanqR/gpLUP+rn1KnUvtrXQA=;
        b=cbju8xZ/dbCVmcMgz3YJ8pcWwS6yKxBb0jOfFWHP8EmMDKe1waZs9zzW7IWSh/5qUa
         8Dklu+fOh7vmCaEQxbVdrE1HP9zOUnzDcsBYLm5ooudNm2l8ehRsN1IWXCIKyJui0sRF
         ahLsiID4d25Pp/zBhb6XyPZgx9h5QrcJQUhJAJUH5lxIcgPTwkNhSNPTLqwtb+pud2h3
         7uoIn4gF3AQnOMpMEZ0Qtei9b4ipD62/ikr/rgk/43/cUEGh8As5qHK6h1CKI7acG9Qb
         5lv+IRgsrpSMRVXB7/ak0dqR972c1eoFmKR5M7yf/lB8eTYfejUi77NS1G0eZJ6g5GgP
         PO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201276; x=1779806076;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIoRuAJAPcJrNuPsGqklanqR/gpLUP+rn1KnUvtrXQA=;
        b=gg4SNRndiB8wcq824Ko2naJql731L5LW+XIFh17BBBdHLXrl8OsGu5AyULeSvQH1+j
         LNB5jAZ7gu2Ng3JDJItUpq9p3WlTKIrdRkbfvjqPC2nLnYzp7JDwNkMCD6mCtCGOLRB8
         CdSQBV7Bx+qCQFw1/loHFcesBz2mDVjFY7LHLw1h+fKww7birUtapXgQCdcEkssli3QE
         odbsC4O30LzxbZYHaPAhofb9eBrzjGUwHbHBa/1PL2U2vrJDf6XijuLD92F2RTluwXRq
         tVLjzWt6hWvo2e/RKPdQWDyegmvIj7UbkR0reGEPOEVhV0tqPLJ6c0zipydyaOCeyQfu
         y+2g==
X-Gm-Message-State: AOJu0YzVJtwVGuhdoag5/LTBVy9W6KpkfJpW/q3vgxnZsfiySKjY5j5w
	CRnej1sqB+/JfhbdNkywEUhwblHylMr5KXAnVcUoxoIDotQgfXheYTrEKqFf4lmasbFnUI9becK
	0xbLzH7u4A+kLBxZaxdLHt/FothWiXAAFpPReYjrpVkFIjQme9F8OSAmgq0trcWHvR7eV+KUdbY
	rAJQ==
X-Gm-Gg: Acq92OE92CXaJOFWj10Fqrp3GqmSMGEpws5p9oo4kZrwBuJ5HEEtFWkreid51aizcug
	WiMIOa0VB036/ql9KEM218+ykyxVG6eAebwgz7Rk5sRB6rzqw7RIM7fKhCxCnuSuf17kot+gpjw
	K64KV1wvT7k5dInm9z4oYP2dBOH7Wpb3c60mBMw9Mp9bWe6CDPl4ovPcdR8i2MIxTnoigjOMPVr
	rsmY/BJxLKvRvWskXqEUL3pqru2J0TjfpEuvl5UsgjaAX56Uyc3qQ0DPsXzILNzQ60V6+SlcEDD
	Sg+Cgz9CyXNi8hz6xaKyGWM5M/vgA3uJkra4QKhhiz2VvTAK2syPQgaLaH483q5uMeDsNsUtx4C
	KBlJajXvo4G9hv4X06+lom+GdSe7NPWDOWA/K3wvXltkmxbGCCoLrPQK/og==
X-Received: by 2002:a05:7300:fb83:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3039818afa7mr9591098eec.1.1779201275487;
        Tue, 19 May 2026 07:34:35 -0700 (PDT)
X-Received: by 2002:a05:7300:fb83:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3039818afa7mr9591070eec.1.1779201274916;
        Tue, 19 May 2026 07:34:34 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978afdd3sm16526448eec.29.2026.05.19.07.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:34:34 -0700 (PDT)
Message-ID: <651b9fa7-ac08-4b50-bb68-1d649d27ed91@oss.qualcomm.com>
Date: Tue, 19 May 2026 07:34:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20260519
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfX7q7tBxwSKEwu
 WDsRgBQdIkxcsR7XDQLPn58gYYt0+JJghNjFRY24Goh9lIArAReU5NPdd+7fQh9AGVG7ihSyxSE
 1cen4vYAczrBKy7IuQxBcSm5cOa/VKqnN3L+raYS0R22leyx/W6QQrDgSOdC3XnZvgyjJbtrnrZ
 ymkBxhHy8xWLp5rEtyoBBfDtbVkyX8R5sA7WwvyLtPpknsJgoPxxEm8pFDOJrEV/O7FF/Trslp1
 Wl/5lTzYf6Kpo9AcbzJ9TqOtxDvMZaKJF7RtkVI/WR/wRCMyoDXnTFsUG4N7TS4MyEd9WrnWwGS
 ABII+ry+HgLL8NTVKHhjGNTDltROqH2fRMbTqJa9kQH+1VI+lNxl+dINeOF2xNJkyBFsquLqsjT
 ZhSJvEkc4zImhOI/pWPNR3CgrHkjFtWoIiiQRVec86J+IWvg2Yi4Db7DZl5dcGgnsvSb3D/WFCs
 praCKZAyIAEw7SQbH0w==
X-Proofpoint-GUID: PHDLCHVfUj51BUR4pM3nKOvFuv-mrg72
X-Proofpoint-ORIG-GUID: PHDLCHVfUj51BUR4pM3nKOvFuv-mrg72
X-Authority-Analysis: v=2.4 cv=WZM8rUhX c=1 sm=1 tr=0 ts=6a0c74fd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=MhPGfwmvrDdq-928PkYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190143
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36662-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5A44A580AE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 7666dbb1bacc4ba522b96740cba7283d243d16e1:

  wifi: cfg80211: advance loop vars in cfg80211_merge_profile() (2026-05-08 09:20:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260519

for you to fetch changes up to 60fb2cf51e77bb1c0261160b4be44209d68956b1:

  wifi: ath12k: fix EHT TX MCS limitation due to wrong 20 MHz-only parsing (2026-05-18 06:47:03 -0700)

----------------------------------------------------------------
ath.git update for v7.1-rc5

ath10k:
- avoid sending any commands to firmware when it is wedged

ath11k:
- fix WMI buffer leaks on error conditions
- fix UAF in RX MSDU coalesce path
- allow peer ID 0 on RX path (legal for mobile devices)
- reinitialize shared SRNG pointers on restart

ath12k:
- fix 20 MHz-only parsing of EHT-MCS map

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: fix EHT TX MCS limitation due to wrong 20 MHz-only parsing

Kang Yang (1):
      wifi: ath10k: skip WMI and beacon transmission when device is wedged

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Matthew Leach (1):
      wifi: ath11k: fix peer resolution on rx path when peer_id=0

Nicolas Escande (3):
      wifi: ath11k: fix error path leaks in some WMI WOW calls
      wifi: ath11k: fix error path leaks in some WMI calls
      wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

Willmar Knikker (1):
      wifi: ath11k: fix use after free in ath11k_dp_rx_msdu_coalesce()

 drivers/net/wireless/ath/ath10k/wmi.c      |  15 ++--
 drivers/net/wireless/ath/ath11k/dp_rx.c    |   9 +-
 drivers/net/wireless/ath/ath11k/hal.c      |  14 ++-
 drivers/net/wireless/ath/ath11k/hal_rx.c   |   5 +-
 drivers/net/wireless/ath/ath11k/testmode.c |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c      | 131 ++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.c      |   8 +-
 7 files changed, 143 insertions(+), 40 deletions(-)

