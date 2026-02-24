Return-Path: <linux-wireless+bounces-32146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CMxFV/hnWnpSQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:35:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451D18A979
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45FA830432CD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD033ADA0;
	Tue, 24 Feb 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7x0LQeL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MbCb5/3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0F2FDC30
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954523; cv=none; b=E4aKJdMY4xz14L++KAxDeXNxG8u/gcvQqvgdYoaxJO4MJiEo6HMuro4IExW/tOwp9dzj78PPY7O78fETjmOQglq+J0PeN5gVuWrndmm7nfvZV7UN45MGco8xvHqb4t6oBbmIyYZ2nxY5hc9VKcf1sJfaUiEyOeFyx20n+IERKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954523; c=relaxed/simple;
	bh=J8JtVTkSzhtC3xzooQaeYuKBwje6IXwpINls53o6TaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pe2TQvplvxw+5sGjrvkarOOgP24nMtJsEqT5dKE78yTJKXiOmiIkiyrCWwZlYOiQoPutu8iyGbdr70XgDRIdI7GwS4X/biJvxU66Ro5wgkdVdosOh12y/t8epy5lru1KWjRtQ7jTUgshGjNtQhAQqMRkhFyqXniG18qVocXRZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7x0LQeL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MbCb5/3I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OHYZLr057141
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bSPWN+9gH/4U3rQH+70kCR12kvUcjrrLboofx4Hl/hs=; b=Q7x0LQeLulACCa3V
	Wpa26UcDuG9gx1UOvhFK8o8mFnnzV1GgrgeAtwiyMFmvPvaV2Q4hFCUKTHiR0AIs
	VfMKyM3FPoP6BdiaWhQO9nckV92OAchZDCwy+ItyVMZQ49rYsd0LRtbmgGZK+XmL
	anEwPU8DHZmticDHpvWSq23ZSF/GAuiNZl+AiQ1JOlVx/Ec8qePlCAR/lruCPxXi
	EpqzdghL5v6ml/6mzujp9KGD4OBxWfap+kU4HzycbnJBpBLVp5eX5/qlQNMGq77E
	WOnB+/enyLqV9FqsxOTwackxDZIdTdal4B8noCwkj3KO8wloCwDWy4hFqU5WaJfs
	HZwBgg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch9sa9e5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:35:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-824a1d441e7so2427311b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 09:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771954521; x=1772559321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSPWN+9gH/4U3rQH+70kCR12kvUcjrrLboofx4Hl/hs=;
        b=MbCb5/3IixqSfsBegXpfC2WkTrG6KWe3DEoKWvz9e6pTnou29bgSIwJgGudqOMsn/8
         lVJwGe6QN91kA6vVbb3V2GRpU0ZTajlxXLXuOaArtiVIcb1NJtDzduvxn4jKrX4M+I7W
         ecWpNui9yfCTOGjNjU5JkAQ9R+h9hRv/pgk5pL/oUFLH9FDkMb9UIu7+ZUX4SOV9j1iG
         eh4PX0ne1rHsIN2m9WM83H0M22MM17qwrtc7BhXLvb38ZX14KnYNnQAUQY3kj9B2PFYK
         0BQYXl1zaRfLcuGlZqCMBIcXkkcv82cneZvX2SSZVkrPtzt6BtVoElE+uucKZEmGnAtn
         kq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954521; x=1772559321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSPWN+9gH/4U3rQH+70kCR12kvUcjrrLboofx4Hl/hs=;
        b=rtUlsZC0Z6cCgJHHTgQcyDLG/09uLTYXyGqAaP98nM3XFi+eo6aBSLpefwQZ71pzCG
         jSuJYJKCCCeyfsd8LO3jVrZqi9IgXx0YYZoYQVHrdj3d+AAMDgENrNXzHb+mGhYaOgr7
         duHfPLMQjHJsdvnntIj38ATDCc4asltEsa7ZK+8xG8cHEzmFI6+FXG2NQyfWpX90Wf9j
         31owweyej6qLqvheS/bpGCP5UwVBXS65i0mAcy4LJUIcznQ24MJIaJrQMNgMUkQZHHca
         SKvLFi61l33g1Kq+4UvcoxW5yeO05lAmoAb/xjnuZO/uR73/nAzOn5CMQIhKoKebzJzM
         38Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWPkEnwpz/3N73Wr00DncyT6/REUiIdDx480fejUmga5qLWttoE2p4Z0+nPEHz79RX5nbfxHTzupcbBC/ulpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkrN+rTR037O7yRcrZkJiiAX+dVR5NIykGVTYU/pA3fkjdqxB
	zyniC5oPFQisybzCrANcFpVuY9abDWIZpDSJzABkJqA67NBqi1q+M1eV5o4z/ubpe57Qf5FCAk0
	qEJq+nlmzRbIGD1Z7zsbYxDro07SA1txfsAlnq8+nGlZ7m6azVJ+xtvKvK8HTxrFnq7yrpg==
X-Gm-Gg: AZuq6aL0HRF/9I2X/RSAQmi5JVna0JpFIbDE875q2XbXOYi1jE+Bzm137uhL6wHvBp8
	7r0Ps2/i4H41MXT3I7yreMBqNhKfywqYwV+vR3UYU13Lk+JgOHsIqdSm4SjNqgBvelzoNkV5yEA
	iSl5zSSsbzhTyS0/AcxK+dZ6cKtf9jhF04Vszk7OrURtpSeTDQTDBTN8oD1oQajSiWnLlqAaGj0
	zF1omqGx/wbX0HjZ06XLLdj0pTT2KtI+lTPGLr/goEuFwbgckfDwVXkHHFff566bhbZ7WKR+vDw
	AjtYqLkyBKmT9vhwXb2zM34ED8CePRgkd8DmgGOYE8pQCxgs0yhh3KO/mx/VVcxerOz8acDMM7a
	2N+c+jK2c9HE5igXgCPEahjOPoAaU7QXntQyDcNK6Tn7kIQf7+uRRBVk9xfU=
X-Received: by 2002:a05:6a00:1bc3:b0:824:a2d4:724a with SMTP id d2e1a72fcca58-826daa8a14dmr12291697b3a.62.1771954521088;
        Tue, 24 Feb 2026 09:35:21 -0800 (PST)
X-Received: by 2002:a05:6a00:1bc3:b0:824:a2d4:724a with SMTP id d2e1a72fcca58-826daa8a14dmr12291658b3a.62.1771954520511;
        Tue, 24 Feb 2026 09:35:20 -0800 (PST)
Received: from [192.168.1.11] ([122.167.98.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8764c7sm10764019b3a.42.2026.02.24.09.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 09:35:20 -0800 (PST)
Message-ID: <d4a93b2c-c22b-42a1-8ec6-26585b1d4e80@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 23:05:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] Adding NO_STA flag and reworking RX link
 resolution
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0OCBTYWx0ZWRfX+Jx80CS1awdC
 ef42WfMjmIyrVTowPo51nG70x0ZwmklrtUaCCMIhYyqeuFu2GvDinK1XrXyufxREalVDXvd13gY
 jVxrW+N6qIy2Jb4wrRJT1aE13HwpqyYwe4IFfPipvTkmgthHrlWjlr+jweUnCzCc/BbhuX+4P11
 tV/vkeuvv9B4scOiFNcHfdnLRtx+DZgXaDupBDUw13fVp3Hdukysotgs6pnhlHBZK3/3x57QK5B
 sRVwbxZS/1Oy9sSX668CNPnhE61ow/bXlkamC3TC27zX7N9wtZ+A+zYp1Zom5EjW3VfvN6XFc1X
 H7ZU9A7kn7qMZ+1Mdp8e9HmWLp6WsxDnRgFYmeNWsJg4mOq79Q/wYap6+mo7Czcl9t5YzLPLWL0
 YI63KT+NTlV/ae/yMO7ZYet8I9u3LiaatdG01RjKGgnUROLm00lzvKrEQDT6RNHK/lzjG7QmQs6
 SfWhpsygMKx4Y3hF7Sg==
X-Proofpoint-ORIG-GUID: pU_0c8-ZRgjt1fElESWvTE4n2zbPqeSG
X-Authority-Analysis: v=2.4 cv=e7ELiKp/ c=1 sm=1 tr=0 ts=699de159 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=3qja58XoCTMbiOcPuMMiMg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=RkBCWdiPywd9OFos0c8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: pU_0c8-ZRgjt1fElESWvTE4n2zbPqeSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240148
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32146-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9451D18A979
X-Rspamd-Action: no action



On 2/23/2026 6:08 PM, Benjamin Berg wrote:
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
> 
I'll work on the hostapd side accordingly and share the patches for review.
> Benjamin
> 
> Changes in RFCv2:
>   * Port other drivers to new API (untested)
>   * Fix a checkpatch warning
> 
> Benjamin Berg (8):
>    wifi: iwlwifi: use link_sta internally to the driver
>    wifi: mac80211: change public RX API to use link stations
>    wifi: mac80211: refactor RX link_id and station handling
>    wifi: mac80211: rework RX packet handling
>    wifi: cfg80211: add attribute for TX/RX denoting there is no station
>    wifi: mac80211: report to cfg80211 when no STA is known for a frame
>    wifi: mac80211: pass station to ieee80211_tx_skb_tid
>    wifi: mac80211: pass error station if non-STA transmit was requested
> 
>   drivers/net/wireless/ath/ath11k/dp_rx.c       |   2 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |  18 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |  15 +-
>   drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  21 +-
>   drivers/net/wireless/intel/iwlwifi/mld/agg.h  |   4 +-
>   drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  50 +-
>   drivers/net/wireless/intel/iwlwifi/mld/rx.h   |   2 +-
>   .../wireless/intel/iwlwifi/mld/tests/agg.c    |   7 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   6 +-
>   drivers/net/wireless/mediatek/mt76/mac80211.c |  22 +-
>   drivers/net/wireless/realtek/rtw89/core.c     |   6 -
>   drivers/net/wireless/virtual/mac80211_hwsim.c |   3 -
>   include/net/cfg80211.h                        |   4 +
>   include/net/mac80211.h                        |  25 +-
>   include/uapi/linux/nl80211.h                  |   7 +
>   net/mac80211/agg-tx.c                         |   6 +-
>   net/mac80211/eht.c                            |   3 -
>   net/mac80211/ht.c                             |   4 +-
>   net/mac80211/ieee80211_i.h                    |  14 +-
>   net/mac80211/iface.c                          |   7 +-
>   net/mac80211/mlme.c                           |   9 +-
>   net/mac80211/offchannel.c                     |  13 +-
>   net/mac80211/rx.c                             | 436 ++++++++++--------
>   net/mac80211/scan.c                           |  10 +-
>   net/mac80211/tdls.c                           |   4 +-
>   net/mac80211/tx.c                             |   8 +-
>   net/wireless/nl80211.c                        |   8 +-
>   28 files changed, 390 insertions(+), 326 deletions(-)
> 

Thanks,
Ramasamy

