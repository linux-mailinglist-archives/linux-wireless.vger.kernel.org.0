Return-Path: <linux-wireless+bounces-31459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFoOMPy2gGn6BAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 15:38:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C8FCD765
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 15:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66839302A551
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C436C5BF;
	Mon,  2 Feb 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K03YTCDh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9SVa+C5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25936CDE4
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043020; cv=none; b=aMpj0VFzPY4+A8Py0QW02jqofrPuaBl56nL7aQ6L8h1Vat6kk11kEXePDBRWWMbJOyi1rtbjrnpEigGbrf31Xp+2jwMBxENSQ51MVQkNJlnxqnH7CNCcmhUzakeYaHnUDZ8RY8CPPYpwvasRH3GYhJLLdS0gG5x2dRxWwUvd/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043020; c=relaxed/simple;
	bh=SYToky9I8inlph4FOyYrW3lJEbzsumD5Iy3Spvl03/M=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=fGd3g1Ft0mAWuJHnCCbFpxqFDzC4ckpYUGPgNENIqmiP2EiwEmtS6RPtbD+11GCjIFaybRDOJBuCbbVcxtp/iAw4A3UIPtV662NEDlQI5htM6QF2tD9dTKyHf2Z2T/7C4gADbwicAh6EwjMIWOR/CLuGyghJm6SSgfxBiX/24Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K03YTCDh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A9SVa+C5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B4C6O2848510
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eAWb4km5TleWO/t5iavF0a
	Qqzr8+qMuKOS8aZDkQyDU=; b=K03YTCDh88rDSmPGCDsBvsMoc7RhBbElFTVDfZ
	l52z6+FxCIoL283X3IfYkCXGFoM+ul5cMVA5NFz86voYlVvEpYoMIMuEWA7iF2SN
	4ZjH47I0tHAc8doVZhV0OKEGD7NvRLvpG0JOxELNRzb12mXPpgD4tEdCrUVaeCVo
	NpsxHxY8AagL+shDT3hHNjlyWi/BlDS+wbi00wVBn4TaY1/L/pVJJkeYDvDd6Vmt
	uCmI01BbTkvne3wsIaFNxDWa6Fy+bpfWh/CCm7z9mVRayp+AEFeNawVd09oBQ3GK
	2iiZh7xGYlyCZ9lzU8jcHOYqvjRsbZKoweyAi5ysi4d2Sqew==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tqtgk1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:36:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b713fa927dso3418815eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770043017; x=1770647817; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAWb4km5TleWO/t5iavF0aQqzr8+qMuKOS8aZDkQyDU=;
        b=A9SVa+C5SVB+CglmDRR5ERsziqGkS3m3iZvTNZZacMz2emz94j2GVOgegNLxUkRPMH
         ApotOrp1vddm1MCGmz5nB5emfJT+eHO5JtG3HkLjdceQCZi9fVj0jQeUUQgT/xmkh/iH
         2S+2WV3dGQw0b4yweIKKu5eIH+omGsOy7eu5pe1CWNXF9WKOF+D6KYB7DwmP4o3wiOQO
         kvmeY/2li61YNOIneGWvNzafSX/R1pYvBcswNqzJuHiyixI/rnaprxELWd/4lAk4Ddhs
         jiSC2ia7kDSVFSCyo53si/2+9vyvnrrgCPpJg5b97oupdAKMtMwXkmIQ8jnhkPgQRm1F
         r2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770043017; x=1770647817;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAWb4km5TleWO/t5iavF0aQqzr8+qMuKOS8aZDkQyDU=;
        b=Te0qW4RdjYtW1PLug4cI6acZzqdtJCJ2KAi6DRLGIkx3UsD4p+Q6oGXzWGl6jUUuWO
         24ZkIO4JVni78EXsYpuYjZDfH63/rNOcZl6ebk6wTX3gaepvPKAdon485KJLpU76/RnQ
         R8F64lPcDVx2YkaAFP4vqleWgZD71WR3PM8u4aWA7fHnXVW4eouLYRhe584b8z2JVKDK
         Hd8Vn3mZcVzE94pIFsMGoqD+cVFhxNb94Y+VtOGGcRygugPL4L3byVp5KGnSsO/ZdaLE
         v6NySvZA8CcAm6w4O1tHsgU76KONgPusHq1GxQ5inuXBSKvG7Falo/P75RqFan684H7a
         uhMg==
X-Gm-Message-State: AOJu0YzAbDWDHcARwp3mekfPnyT48xPOiV80t8/Xgk8LA+KSRd7Q9uxw
	sWZQifCxkXhPybKd8j1Fq9d7JO6S7zQQSFmMgkwGuKwkDWoaJst5Dle6YJ3WOGM6saJL5N76CVg
	Qx5pafJsRvYjNHTR+JuqTXbkwhtGgr8RpT/Mf+kUILFiHylUh58N6BSFAG2oQpcYKLbQPD7h0TN
	qSAA==
X-Gm-Gg: AZuq6aI6Tlg7lPCBYhm6VyH1JDeSvgbsqlyldK8GIi57WilzVnoyQtwnea3qXzwMRES
	OVBPGw3XRnV1oM2g78lPqOqqUY+p6En3WxtSES3BUCiwR0j/wZD3wVTGu6VOh8p2b3nHSPjzTM8
	osFOb1kCRLEeC0joKNR1M98Zw+CrqNpfFWIF/0x/Wt9pZ8o7nkq5TJqKNniGQpdd2oqi9DwB0YE
	B4yXpphMi52o99fRXjPjCpwxI/qgfZnP+oE0LeG5LWsBgRbKDlmo5hf8XZpDNw2N2e/fOgPE7YX
	7pePWipzWj1Hd14upWF0y9QSb/KKPmwY+jY+JNk3T3ySnF85M3yNTei+E0Rj6S6ExyfxNvaj2Uq
	t1pa4CftQx9eBoJh39PLQa2ZtbqbMqfGGyuelUOqnpy5Nag==
X-Received: by 2002:a05:7022:2485:b0:119:e569:f86a with SMTP id a92af1059eb24-125c197f8aemr4890409c88.7.1770043017318;
        Mon, 02 Feb 2026 06:36:57 -0800 (PST)
X-Received: by 2002:a05:7022:2485:b0:119:e569:f86a with SMTP id a92af1059eb24-125c197f8aemr4890386c88.7.1770043016725;
        Mon, 02 Feb 2026 06:36:56 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9debe5dsm19571387c88.11.2026.02.02.06.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:36:56 -0800 (PST)
Message-ID: <28dfd5c2-9c97-420c-a37e-e43b215799c0@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:36:55 -0800
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
Subject: pull-request: ath-next-20260202
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=6980b68a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=qSke-fb0mpNoTSwYOz8A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: nmBXueK6hs5UOXgzZpD_GXjs07iorwcI
X-Proofpoint-ORIG-GUID: nmBXueK6hs5UOXgzZpD_GXjs07iorwcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNSBTYWx0ZWRfXwBYYA9rDSCx3
 pFMD7lxwlDxVKelcCudjZ3CFW2MIGK9hbEACyCG/vOCY9uKPqeFS7ifzQ++wKeVXg/BJBelN3Sx
 AJL8asQe5V8/2s0ABONveXf/Ph4ENs+Pn5vzzcgI+rfH/wrY9CHbUttGofZzjbzn8q8kziC8OZc
 pO68qDjhA0RGk4D/6ljd5kaYB5n1YVOGhSrcIg4kSSp0vKMN/IyxEq+zBZ8BR11o7QwCNPym73/
 BLsj/3gXP5QdVOuLzBuB+30xDVQFnl0jaOchgGzljkrAk1IhDggJFJW2cbSOfY2xTe91aLPhnQ8
 eh140upl9jskdUvbt9AF1iNprA3BDCwJGyvjzeFnNjpnFpOf+k4cUr3+SokZH/vQJvAkpjBkykd
 2DdlVC+rB4NL5XnZsO4956M+ug5cYFqvd60k3mhKjanTXAkq2IPOtayV4mfGPkU+EXI44sAKA0s
 wAHTJzba7OH1Jc54S4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31459-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37C8FCD765
X-Rspamd-Action: no action

The following changes since commit c30e188bd2a886258be5facb970a804d8ef549b5:

  Merge tag 'iwlwifi-next-2026-01-21' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2026-01-27 13:54:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260202

for you to fetch changes up to 2c1ba9c2adf0fda96eaaebd8799268a7506a8fc9:

  wifi: ath12k: clear stale link mapping of ahvif->links_map (2026-01-30 07:12:38 -0800)

----------------------------------------------------------------
ath.git patches for v6.20/v7.0 (#3)

A set of small features and cleanups for the next merge window.

----------------------------------------------------------------
Aaradhana Sahu (4):
      wifi: ath12k: Fix index decrement when array_len is zero
      wifi: ath12k: Add support RX PDEV stats
      wifi: ath12k: Add support TX hardware queue stats
      wifi: ath12k: clear stale link mapping of ahvif->links_map

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: support powering on the device via pwrseq

Miaoqing Pan (2):
      wifi: ath11k: add usecase firmware handling based on device compatible
      dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property

Wei Zhang (2):
      wifi: ath12k: add WMI support for spatial reuse parameter configuration
      wifi: ath12k: support OBSS PD configuration for AP mode

Ziyi Guo (2):
      wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
      wifi: ath10k: sdio: add missing lock protection in ath10k_sdio_fw_crashed_dump()

 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |   6 +
 drivers/net/wireless/ath/ath10k/snoc.c             |  53 +++++-
 drivers/net/wireless/ath/ath10k/snoc.h             |   3 +
 drivers/net/wireless/ath/ath10k/wmi.c              |   4 +-
 drivers/net/wireless/ath/ath11k/core.c             |  27 +++
 drivers/net/wireless/ath/ath11k/core.h             |   4 +
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 197 ++++++++++++++++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  81 +++++++++
 drivers/net/wireless/ath/ath12k/mac.c              | 174 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c              | 142 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h              |  47 +++++
 13 files changed, 730 insertions(+), 12 deletions(-)

