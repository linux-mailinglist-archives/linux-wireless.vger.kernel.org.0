Return-Path: <linux-wireless+bounces-38287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FyhfJeI/QmrI2gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:50:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B06D873C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Nq0dTQhO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BCU1AENs;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38287-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38287-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978B0303E4AE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1273FAE19;
	Mon, 29 Jun 2026 09:44:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F283F9F21
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 09:44:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726286; cv=none; b=r0bvzM52S0R0Mgo8hfccvtehwv4sXhCB1I75BCNcW9Q235QgKp82IPS1bWKzUYykqxE5ZwVYZgsmVxjB7Pc6P8dbEdwENEBph72PTf91eSDBlavLCTb3NS48mK20iwCztC+Rk89pUS9xJedEXPIDwacRmlAC+xeOc64p80thePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726286; c=relaxed/simple;
	bh=MjjXrkMnUwdq0FJ4Cu9/oZ/NIF4VGt0nFl1suBh70b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvPJ0M24dUdnZO1fPcoVgF8VTpl0OwEIjxQUM5EUAaYGOCqfkWflPIJBMCltp6QuzI18dqI8IqO5vjDWXSkVmKE/zLxScOpwCqvd+JfIueeo8AVmmDOFveDL6j/iEY2BeWj2fw2hg1++tXNfB5Er9TnrxdoOdq3TPdE/oJ5pGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nq0dTQhO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCU1AENs; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6r2Rs2088759
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 09:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29xDUNTed4jXAy3Mgxyo8ge5rsxJ/2Bn9rzkJN7OPjI=; b=Nq0dTQhObC4rViq8
	hHEZ1cCiH0k/XJAfNPJgmIX1a/lj4zi3R2RIn2uCc6bDwNWPmxVgpitUNAQtfPoA
	soN48DtvuBi0duKZozhcNkj3/BKV7Nkfu1Oapfs4FK8Wy5IDtQIdRmqiJWhfxFT+
	21BuaT7nZAYyZ1B8DNrxj323ONG2jt8M+lfHNwJhSO4y4T+Ya+725vXDoc+vxqGL
	1jor/PekNcFzoYt+9d6kK5+SPfQcA1t6O+jq8pFIbmvIynVwDdRPn15bFFLvBqNG
	+SYJdAEhTC0zFWxP50x/mgdQzXMZKSMVYhHlq6I/zbBpnWM/XyJrukNHo79Aqifg
	xqgepA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vh19b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 09:44:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845c296374cso2117653b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782726281; x=1783331081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29xDUNTed4jXAy3Mgxyo8ge5rsxJ/2Bn9rzkJN7OPjI=;
        b=BCU1AENsrcqamFZ943Wr3D+TobYkJSw4NxAhAS3Zd5wrB2B0sePMXGg77+hLiMdDuq
         5ZcKsw1epLRW3uY+6lMfWGhbdJACIJdn2GPbtoRNeHvDmAGgnOcQLGbUU0vZX+LqF+bY
         VFs82o/JfeledXZOzm1JoQu6s4je1ErkQlSVlaUuKxJaJDizGXFss2JIsKz9GJFwYwJx
         /o52mLwJU2QZMRZuYJ7I4jpiIRmRPS7Y2kDAi3YDW1t1y+hSuWfEveloBmuXQCZ2xbfs
         1t7lrkm5Vmm5BcavnefQCDVfPb1AKsLH+603/Bd7kd5v6C7nYnIWlNWSf2ws3uycyAtt
         qcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726281; x=1783331081;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29xDUNTed4jXAy3Mgxyo8ge5rsxJ/2Bn9rzkJN7OPjI=;
        b=E/3Vu2Omvs29GdnhD+eUpKcoCg937NU7RO8oKMyavgFcXObGgYQPe+T1AxZrJ3WnyL
         mmhixXoiu0gbTOg0hkeFsbZoPzVR8juvhnjH8E++yh8/moxQDdF1jFtdjPpqzXz4baqM
         mRr1EyU7KZRJ6+1Y/ZUsRuqOO6DZEGki95jRzRjvWljJqiBEuJSEzWul5RwvrkVhhy81
         K82hPcJopPgJt+GPC+hOWQMmESwvAGMv5xvoD0qxKY8hMKodrjaOYtfSNt9LAh03PPCk
         535qEjHo5G2LdImwE95nQ0fKE4QqWARa9K7yWfSudyG8R7MFNkNggddMf1oYQl77JCdR
         jIDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4fRu2xv/YPHHVOYtjPhNqnHHKeHgHBmHs+QL7l5s4L14PWwXzHVs/MQ1LcV7XErcDLUD+u+lhEqLVTXGPWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4uKsevSKyI6AvDBYI+8tvpzYwO5MtiCM3vGuxqu/tIOBznyn
	ML67LLY8T4G9q/zaULsn8+lWC96CtHjsUWoJUb//qTnO97mUJBlvEJwzZ5IpHZAL/wNg5smtjZM
	m4YvkAh62cmhWt8v6iuDynZNKFaPrYzTafbF/4L04WguUpSnxneSaUpCmgrgVH3mJLfp+A7JS0G
	Lp0irt
X-Gm-Gg: AfdE7cnsXFU0YGJ7W0SWF5pw6ShuscdSD7DT8eJ9RAdVWLEAOF+Ymj0JxZURriY8I7D
	fLOXpJOES+8aW5F6YxHv3U5JSOmkAojZXgVkDSKjJfO6vpTsA/MzHpCCueK+TQ+Iy1mocOIqjIz
	LOYDeXeUdess+08jltc8bj0EmjvLG8rPMhfI+VeR9UlyS6WuJCzDQoaOWAYmXnv1p407Na2yNcW
	ry4nOOlUJY5zNqoFt5753q40FfWZzZvt6AgszrcvbstGptZ6c6kI+jxv1lqQ+WDuIEsTCH+d8q6
	A4fB5nGZFRJyfdd9/06dFB1qntREEjLy1/MuSQr+QDpWGMKMsZczSoTdKFT85ou2HXCwHfaRwP9
	BPd+N6ukJIBNe3rQZTxQzhZ85reEwBi5JBIZL+0/oSUEyt2uub6HPNsMReHIcFLVMkCl/1QpJSq
	TSUc569g==
X-Received: by 2002:a05:6a00:2d8d:b0:847:9692:5cb4 with SMTP id d2e1a72fcca58-84796926134mr348457b3a.53.1782726281025;
        Mon, 29 Jun 2026 02:44:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8d:b0:847:9692:5cb4 with SMTP id d2e1a72fcca58-84796926134mr348440b3a.53.1782726280533;
        Mon, 29 Jun 2026 02:44:40 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847833efe03sm1741991b3a.44.2026.06.29.02.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:44:39 -0700 (PDT)
Message-ID: <b2f3eb30-ff30-423b-aa8e-3cdf47aa600f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 17:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] Add device-specific reset for Qualcomm devices
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, bhelgaas@google.com,
        alex@shazbot.org, jjohnson@kernel.org, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260623183115.1585273-1-jtornosm@redhat.com>
 <4cdfb71b-2ef8-4985-8294-c4a29e37faa3@oss.qualcomm.com>
 <l3pcelhxn46p4smkkg5yob5enf4d4garp2p6macopnq5h2gwyf@zbbn65k4tz2q>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <l3pcelhxn46p4smkkg5yob5enf4d4garp2p6macopnq5h2gwyf@zbbn65k4tz2q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zlk1zwdkN7pUso7bSwfab5qAz0xPAv1u
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a423e8a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=RRcNAnSy7hG7cj1Ejq8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3OCBTYWx0ZWRfX285/A6DPiuYs
 qCImtpZTBdLWKoJ1RCjE8sM7emfht+ggvns6017ynNj0+j+/4r8MTJkjIqr7VZRZftuYoHNSDXn
 +kxxfJFZnPIZ7w4qCpiqCJVynNx/ApQ=
X-Proofpoint-ORIG-GUID: zlk1zwdkN7pUso7bSwfab5qAz0xPAv1u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3OCBTYWx0ZWRfX9xa6g4krXi69
 8eG4xV1i8Ms3ch2rtEMHGO5EqvNkI379PdzFeCd8HLGJ87RYSVZQfvt9dftLZNFHlLUodNT72Iz
 vnINqVTn4Ic0PBwX4/Hn1hDV1pIQKTwW0JT5vqzInoxeJJyhFKKZViPrK9bV8651EVPCElrIK5T
 fFUOfLPb2bCLS/5gkp6QurGqxZYgb2B1RdWddLpVfKcI4IzoAUnnR4zZf8IsOFhTd7HSHMsOAjs
 8J+5UtkC0KCp/WmZO1cbBRYscFvu2ZlOn9AOFBwJ47itcdWpvZeKQCBztv99rWtD4gh+88HG4sV
 TvpF1sc2SYelAUxOoPxQJIjV59yd02k3YXtkxDt7JTsyj0vHHjUX7tk0xLK0NDhnYY2wk5YT+Tb
 FMR3XCpb1PxJQ7nL/b9fbgKfS82OCXlEw7zYqY80EMM9AsffFQzObMsCpHV8Y0FofEu4/sEic5t
 onVAvlW3IKnoVvMPi2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290078
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38287-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE2B06D873C



On 6/25/2026 9:03 PM, Manivannan Sadhasivam wrote:
> On Wed, Jun 24, 2026 at 03:47:12PM +0800, Baochen Qiang wrote:
>>
>>
>> On 6/24/2026 2:31 AM, Jose Ignacio Tornos Martinez wrote:
>>> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
>>> lack working reset methods for VFIO passthrough scenarios. These devices
>>> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
>>> broken bus reset.
>>>
>>> The problem manifests in VFIO passthrough scenarios:
>>>
>>> - WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WiFi devices:
>>>   Normal VM operation works fine, including clean shutdown/reboot.
>>>   However, when the VM terminates uncleanly (crash, force-off), VFIO
>>>   attempts to reset the device before it can be assigned to another VM.
>>>   Without a working reset method, the device remains in an undefined state,
>>>   preventing reuse.
>>>
>>> - SDX62/SDX65 (17cb:0308) 5G modems: Never successfully initialize even
>>>   on first VM assignment without proper reset capability.
>>>
>>> Add device-specific reset methods using BAR-space hardware reset registers
>>> that exist in these devices:
>>>
>>> - WCN6855/WCN7850 WiFi devices use SoC global reset via BAR0 (sequence from
>>>   ath11k/ath12k driver: ath11k_pci_soc_global_reset(), ath11k_pci_sw_reset(),
>>>   ath11k_mhi_set_mhictrl_reset()):
>>>   - Write/clear reset bit at offset 0x3008
>>>   - Wait for PCIe link recovery (up to 5 seconds)
>>>   - Clear MHI controller SYSERR status at offset 0x38
>>>
>>> - SDX62/SDX65 modem devices use MHI SoC reset via BAR0 (sequence from MHI
>>>   driver: mhi_soc_reset(), mhi_pci_reset_prepare()):
>>>   - Write reset request to offset 0xb0
>>>   - Wait 2 seconds for reset completion
>>>
>>> These are true hardware reset mechanisms (not power management or firmware
>>> error recovery), providing proper device reset for VFIO scenarios.
>>>
>>> Testing was performed on desktop platforms with M.2 WiFi and modem cards
>>> using M.2-to-PCIe adapters, including extensive force-reset cycling to
>>> verify stability.
>>>
>>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>>> ---
>>> v10:
>>>   - Complete redesign based on maintainer feedback (Manivannan Sadhasivam,
>>>     Alex Williamson): use actual hardware reset registers from
>>>     device drivers instead of D3hot power cycling
>>> v9: https://lore.kernel.org/all/20260612142638.1243895-1-jtornosm@redhat.com/
>>>
>>>  drivers/pci/quirks.c | 118 +++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 118 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 431c021d7414..8ad3f214e520 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -4240,6 +4240,121 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>>>  	return 0;
>>>  }
>>>  
>>> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
>>> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
>>> +#define QUALCOMM_WIFI_MHISTATUS			0x48
>>> +#define QUALCOMM_WIFI_MHICTRL			0x38
>>> +#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2
>>> +
>>> +/*
>>> + * Qualcomm WiFi device-specific reset using SoC global reset via BAR0
>>> + * registers.
>>> + */
>>> +static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
>>> +{
>>> +	bool link_recovered = false;
>>> +	unsigned long timeout;
>>> +	void __iomem *bar;
>>> +	u32 val;
>>> +	u16 cmd;
>>> +
>>> +	if (probe)
>>> +		return 0;
>>> +
>>> +	if (pdev->current_state != PCI_D0)
>>> +		return -EINVAL;
>>> +
>>> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>>> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>>> +
>>> +	bar = pci_iomap(pdev, 0, 0);
>>> +	if (!bar) {
>>> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
>>
>> QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET is beyond the first 4K bar area hence requires MHI
>> wakeup before accessing, see [1]. the wakeup callback for WCN6855 is
>> ath11k_pci_bus_wake_up() which calls mhi_device_get_sync(). Not sure how this can be done
>> here. Maybe Mani can provide some hints?
>>
> 
> I don't think the device needs to be waken up before
> QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET. ath11k driver wakes up the device for
> accessing the MHI interface I believe. Since this callback is not touching MHI,
> there is no need to wakeup the device, AFAIK.

MHI register space is constitute with 3 segments, with mhi offset always being 0, bhi
offset 0x100 and bhie offset 0x224 (the latter two offsets are for WCN7850, but I think
also apply to other devices). That said the whole MHI register space does not go beyond
the first 4K region, hence wakeup is not for accessing MHI interface.

> 
> - Mani
> 


