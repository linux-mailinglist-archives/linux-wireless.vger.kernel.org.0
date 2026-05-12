Return-Path: <linux-wireless+bounces-36325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DSZAsNFA2ri2QEAu9opvQ
	(envelope-from <linux-wireless+bounces-36325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 17:22:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532325238CF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F793155C30
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B33AFAF8;
	Tue, 12 May 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UtpwTOfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AK5rn5C6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B046399888
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596135; cv=none; b=Zr//rlGNqA84hNlojA9qf6Y4b+h+jV48VZU7CALKd+EQgEykNWYtq8y08jNVfo2EAYRSKdRO4zTgvl0ZbP0+P67k6r1NpdNbb9+exVH1tcXuLzRX4whZQ6MZ1jVt0u2LcKX1oDOTG+zLuWPnC9Pn2F4YsEfFt+PIs75JGsQM+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596135; c=relaxed/simple;
	bh=mDVMNbQMQ4EY6P2tQv3qXbrJdNi8O+NnaboEgUgeRuY=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Kn0bJ6scd1Fe0l/mKjvFPWAN9NdqUiGBLku26qJGo8P8ESlUcbnJtRmfYYHk4mvOgGVLjei6G2RNikIPBcSPaHxYNFSlfs/kNO1p1GUB412vvb98f2UVZ+1K+EEzKv9QpeXFgaTVcN1i/WVeI2Jp5QHao7jkeFY0dNR9JZ5vfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UtpwTOfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AK5rn5C6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CAioUf3444973
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BVIPrR0dky89V+VLYJhc15
	1VZ75vhVXCOk5HK0StCLQ=; b=UtpwTOfiZJjZXE6+Dqj0PcunZYS7Nt7qzPbzsC
	FA9jCcu1pE5sboc/6GQf+IIF3wtMVfNl3qXuMYreRQDwdmvLs8zxswZN9iqmMYDC
	IabEJ4RHKSWkxEg0zLfJ2bM8C3Y5131i9TP1lP4/EM1M+S76Kv8IC3HYY2YT/Lck
	ZXWbqKjTRCXoOkYRz+N6ZZYu0zvDbI9NZHZmQb4riT5dmyN2ET55TUXZ9gFNV23o
	t+iw1znWZEBYmBE5hVPvDZ9x6mBHm4nMNCnToeiyMh9ooG20UDW7RNr+eE7BQE6K
	6Ra3KnrQ38sTKzARYZqwVmspMw+F+6MsqV5J6w3UgobruGCg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0knv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:28:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ee34588671so7889065eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778596132; x=1779200932; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVIPrR0dky89V+VLYJhc151VZ75vhVXCOk5HK0StCLQ=;
        b=AK5rn5C6ayVstCU2wBxh6Z85+zXG0zlhHtJYtsa+ZQNCAYJl4CNufXoDokRqeriGV6
         zCW7qss0Opo0rKuyxhwliipUsuPshM6jg3cU15NZV/aAJ87MSxG2sa+nyzXFuJH3QBcU
         yw2xsO9jV79JZnuRiBadWndzdCLTELT9d4a7WQaFzZM3DGdf4IOSLe2YEOXKWg/psDf1
         gBAMi8tm3VpvoT6KVeZdEWwXIUmjzkSD3Kkz/hu+rYMPaNdwNNEwx1TZmhZzkwsomG69
         ZsRwUTZ3WNDsH4K0C4MZkLY+YVJjFdcmbAORavuFvKq3mArCFtOSnca//qkSDcoQCbPR
         ff1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596132; x=1779200932;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVIPrR0dky89V+VLYJhc151VZ75vhVXCOk5HK0StCLQ=;
        b=aN+FyQYu5EzTIFA/D3CWYRpRYMA2eU9teUqk3z+UpmGXZLlTqLfjnKmEtsStkcabVL
         rjE/bdEBi/L04XoV/szEqRl5NUNmU9gm/8ATVbXNMGVehlk/4cgqyUfOnzAEjAcQobQt
         HIcP76kDtXBIQQmfiJp+FBa5Knbm3F3zPp988/oMaPliq5IO9u2tgKFptBzeTAhfaab+
         i6JXYPriW/I9SZ+ikbYN38DD4sssRlYeh0cIHInqY0M6mtMln72uwS0CnI8I4ECTRjCc
         IfqPBKYwlzM7Fhnn2B+4mszi5vGCbDkgy2EtCNowpvOgj3w9DGfn+4imnKPc8XuxYfef
         hn1g==
X-Gm-Message-State: AOJu0Yy9xlsb1qzRREF0QRNAjWje7EyrzHbwpsb/ZtWNqZ9nzMwJuaSl
	CAsv0h/xyqaqKnQcJh4ILsgC3pBDfpW/pJWTPrfeZ74vH1LhCVsMQCz+M/C5us1FWad5AxEPYht
	hND3Y5SeJyzGsgZEIMyFEXagTgYJr7JXeRjJwbTgfsgfwXszDw9ztQYhUp2tR0rQoMsVUchcIRJ
	4Tww==
X-Gm-Gg: Acq92OGDQm2BujYm1yOcZN3gpvQcwjMla6V5jE5y/D0x9XnEvrPgeZDNmLm7jVAhZ4a
	DsmZfHwRagEaejXNwvmYY1axbTfe+j6dn/JlSOkPrc9xyqGYRSOYa620EyPAfa3m7VvvhUe820N
	c/o5a5MPcTC9YxuBhq5GO0O+eWh7tU7sgYC6DnHOhaMxiopb3ey+uj2pydNg/7+CfcT7R2J9KM7
	ySEllQahaje7CpD7Yu5hBejV8JfWYOSXp9ujxoYb5kKZZqZdTtigs64O6htapX4045yh8djauTt
	a7CbcEKSNRYzE4p0Ginmual9FxQgs7FHcgNOAMUir/m/FgFSyNmTIEYEXh4EOOKknU0YPT+MEUF
	94rL41lHRzqbEdDDjuc/rJj0Yd5GCtXPTVD83SsRoz9Y6UC4fGUg/VOughQ==
X-Received: by 2002:a05:693c:2c0d:b0:2d4:94cc:eebb with SMTP id 5a478bee46e88-2ffd5ace39dmr1711481eec.13.1778596132219;
        Tue, 12 May 2026 07:28:52 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0d:b0:2d4:94cc:eebb with SMTP id 5a478bee46e88-2ffd5ace39dmr1711447eec.13.1778596131568;
        Tue, 12 May 2026 07:28:51 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752a9sm17776009eec.16.2026.05.12.07.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:28:51 -0700 (PDT)
Message-ID: <8756e3ff-52bc-4003-99ed-cda3170f118c@oss.qualcomm.com>
Date: Tue, 12 May 2026 07:28:50 -0700
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
Subject: pull-request: ath-current-20260512
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a033925 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=HDnrh3WxrgwM_mXiSj8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: SLAwGt220Cwn2vfpiir6ypuj-1YJcjGo
X-Proofpoint-ORIG-GUID: SLAwGt220Cwn2vfpiir6ypuj-1YJcjGo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1MSBTYWx0ZWRfX9Wdk3rpUorlx
 NJsgDwPRjMQT0u4Sgecl9WW8iUgYcpyMt8j078qo3y5/w33fxK9oYPL8A9+Xf2/DnG7A0drZWv/
 n1fZmz7JuDi0LKxa9wBg5c4zFMgY1JglrdzH/hrxQAUz79UEZ8g8Yb/pIj8j5ZM5CWMlos/qxZM
 FAokjoHfHf4wPBddUm63mvXwQG/M+9WBbRGZGaAaa0+0nww57QtPOqhCSYcq1nIluGSACvcHq5I
 g5Bl73KtsZto3i6AVppDdqV6RRpo8ztB1L5YUpo4+R+wqqwla9s7LMX9xikDnOW6k5xGXwVlM5H
 X1avzKavCS1eD3bYLAtxmBTXl60scKMjL4ZEHE3aG50jZBSJxqz433m8f4EJsnssuZpiu0RF9xa
 ij+3W8u0YoBOfjwCPN6NkOen2JNmGDHonyhbYPrxtSeiGOmtuJA67Vu0G0eC1uJbaMs3f1consU
 q2l19JCkqmV80wYTvcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120151
X-Rspamd-Queue-Id: 532325238CF
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36325-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The following changes since commit 7666dbb1bacc4ba522b96740cba7283d243d16e1:

  wifi: cfg80211: advance loop vars in cfg80211_merge_profile() (2026-05-08 09:20:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260512

for you to fetch changes up to 54a5b38e4396530e5b2f12b54d3844e860ab6784:

  wifi: ath10k: skip WMI and beacon transmission when device is wedged (2026-05-12 07:00:00 -0700)

----------------------------------------------------------------
ath.git update for v7.1-rc5

In ath10k, avoid sending any commands to firmware when it is wedged.
In ath11k, fix WMI buffer leaks on error conditions.

----------------------------------------------------------------
Kang Yang (1):
      wifi: ath10k: skip WMI and beacon transmission when device is wedged

Nicolas Escande (3):
      wifi: ath11k: fix error path leaks in some WMI WOW calls
      wifi: ath11k: fix error path leaks in some WMI calls
      wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

 drivers/net/wireless/ath/ath10k/wmi.c      |  15 ++--
 drivers/net/wireless/ath/ath11k/testmode.c |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c      | 131 ++++++++++++++++++++++++-----
 3 files changed, 120 insertions(+), 27 deletions(-)

