Return-Path: <linux-wireless+bounces-38501-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlnhI39BRmqtMwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38501-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 12:46:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F706F6211
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 12:46:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=o0fW9Z8D;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WzH6LMnX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38501-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38501-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B7543284E05
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80649253D;
	Thu,  2 Jul 2026 09:56:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88944E021
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 09:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986169; cv=none; b=EqZeIed8uLzqCcvHkaQy1b8V8mXSymdW4LDZ71FH8Oc8K8+Y6lmabdPasmEVizbs+Rea6bQkITlRS1VDKkH+7Wh1igtLr8j/Qd0r4FyFIlePdBmf7wdlO2Km95vUtFMJil7SUIr/gZQg1voCSnD/qfOzyVaejliNyVcK9TLpWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986169; c=relaxed/simple;
	bh=oa39J5Vbq61tCuJw7ABqSD6dMS2Vr07cKB1Fdz0+aIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/c0K9sHRamzy0ztDftCl7gO6VvmD3WdLXzTmNUZAw6n2x4LfECcr6WUL3z4PKT3nU5nGOkFa8d6b+r9tpHibVVfGkkyjm2c/f2/n9GRaJdBFuBL96PJ4kpexKeBho7n2ukKY3CQGt0oHkg5obDgU3eNm6/XEbTKM0JND9xFKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0fW9Z8D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WzH6LMnX; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628kq1N3049496
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 09:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UnUR1LOesZgE+LhExMMNkZRlI6t8z7VRKCRBzJBUFR4=; b=o0fW9Z8DPpV5Nebk
	0wNp1ydqmGqi0YInPLG9F9eTTDAe+pgIjnjWvkoKKMJcdK4nbW+c0IB0nCSsczxx
	M5mZ/UX9WWJreEDTB744zcZOSsBJ9Xht9BuO1PImt3tOnhemyVdkBWIlh6FNHHAC
	andSu9HU9egIPz1OwdAl6vMYv9PBZflabA6vDAIBEyrC8xrAw3jaCqzTyMQxFZzT
	HqB6YwHgrNTE+OpmQigzfRKkaDi3UdZaIEZM2OtE5eFuvozSa1KglngoN7XM1iTe
	TnodHd3VKG+IJhhOm6Qie185Wc0pOeQSj6ZthO3+tgXOOpZ5fR2hiwj40sG3LfuD
	45zVtQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541v3q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 09:56:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37c9127e316so2442902a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782986166; x=1783590966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnUR1LOesZgE+LhExMMNkZRlI6t8z7VRKCRBzJBUFR4=;
        b=WzH6LMnXK/r6PmBJkfNNGPZLJk4ou9Np/0365ksUfC9Kxy6OEW2jzMtCTwkopMvU02
         rR+pPczhTTCc4jF5gSA4t80hbNt8jozmrohAkVTl0LThjIjG1GMaxxz6a2jjFNpEAf3m
         9qE9jB+78idTEvjrJolAEER9ztaNy6IlyqIMS0mVhc8u6gF0BbRvgtsD1FySDu5lYEAX
         X49NF+n16PR8CZ8TpyUV/7kieVtmR7oLt9vH2oTggJHNrh4FJFaomEDBMem8RHPd7lev
         o+zyFcIO2pT8pWjCs+dj+wNjDCO1+svQHTcR3qsIOslNiknhmMvh0LngJBvihIasZKZt
         Gnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782986166; x=1783590966;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnUR1LOesZgE+LhExMMNkZRlI6t8z7VRKCRBzJBUFR4=;
        b=Evv0JNgUN/CIyrBxJELjqUkvfk+8VzauelGcBXeZONPdnr9b93VSUr0aXSEJVXGMZ0
         uRopQxnpYkxTHUom+A/l9yswCi0Zyke1cBjtAG+t/WtAO0GW8C0+oHGJml0AsJuvsO7L
         ZX7pn0nJNVuL/5bd+8McQxRDC5BGldfXna/559rtsbLieXRGes4coLiipJVufGdAYN3N
         1BNlXJ/FpIt0Z8YvdXnh8ISK8B5UGv0NoJzoa7i+sNs3ISy0in0lY9UWtw6ZSMuSnhOL
         J0aXRcFJaX7g3SLpqMUx6G2uC70RmUdBNgH6T2ZggC+CAy7x5vt1oFVUjIsvEQ7YzSog
         WjKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz7YaVy4bKYRGBGnRbvHgAFmbKB7+u46qU8yvVObxjgMwSnYdF56SK8hEBqXKZVv7Q4ImAfuUU856pq3d9DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pJQ/oY6ZFYaViyfINC2/JtiU52EJCuFr+28KllxNUbTRd4GK
	G/owAzzjbesX67S/CvaXsATmnjw92HgWSp6soYXzXbWKEUgY3QbuQBSBj2rylGYxSQ4SyUYcMRy
	pAIgRZSkJU73c8mx/TJqAJCNibFAmnVGmJ2WEmXeJT/Q45yiI3DBOhpgmtmxLj/2A12wEyQ==
X-Gm-Gg: AfdE7ckLNp3sff+5pbahW0u5oWEmcDo4Q27UXNeYVcoDHUdravUljySdfPn0Y5GZyQd
	Ven7ZCQgjfzVDbu+k/0aJr65hJ0xGUbL1YagPMhEFZsoKVRmZT9DiBmd6VExmhGuJ+nl6B0Mc7I
	8qxWq6rM4I918CupdoRuafd82+C8RHdWuXAnuwWaofjkOgBE0iDCkpHiVB54F1dqho/CsnLoE+O
	R9neUbY0D+RnbChut9Zu8d45IJgrdpJ3ee3x+uQDaC5UtDhKyKObycNhZN7+wdomsrx7kkR7Y3s
	suXcF7aQ5xzKiBvSxYluHaH/kMjGQkd38E+BNL2lbeKoVM8Om3vgh/lQbaH3NPY4zPjFJn7KLvV
	X8knQXtKRgZcGx7e8wcF1Qg9xUcxjlLKkoIF942oPqeGhSJ9pIK7Rlm2lFPGVKWrRnrQssg2EP5
	68f+jf/aD5
X-Received: by 2002:a17:90b:1806:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-380aa1cad60mr5597215a91.22.1782986165857;
        Thu, 02 Jul 2026 02:56:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1806:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-380aa1cad60mr5597187a91.22.1782986165247;
        Thu, 02 Jul 2026 02:56:05 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3810200f089sm138115a91.7.2026.07.02.02.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:56:04 -0700 (PDT)
Message-ID: <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 17:56:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX> <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k-8aKJ5x2VSEmd961DyUM15wm8UtjtzU
X-Proofpoint-ORIG-GUID: k-8aKJ5x2VSEmd961DyUM15wm8UtjtzU
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a4635b6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=uj8kP0hEhypoEna20nYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMiBTYWx0ZWRfX4S9zVbjvyhgO
 lerM3EVHycyucdLl55zMs4sMtmOWa9QkQkSPIe6n8ufAvrXX9AtIfIHi1VVgJofF6ChuHCShCBv
 gbUnDAFAJ5JUnLKIHQpVww+f2ZtsXHS16IjLEMrSzCzohAUNu+/C+TH3s2FxHYHvceXxG92Icrc
 evSIB+KtxBsTi2OBHMkNUtNDR8Y1G/yCG4FZSUB4MslAw6tzq2+RisriV7SKExv6v9HMdrbufre
 fy2Wm7MR0siqD9WopDovNcxfI5Khuv6P3pKrCYEzFhX2+XvofRcDOlbisPMLG9VLd3qnzecvNKc
 QnqkWnrntKHznSwrIG7b+KCoLJrzN+ocs6jsxJeLgGKFzP8+5CQtbe0gssATr99W8jMpsLXLoCJ
 TRmyffW9GCloIi6ZSgi+A0LRosSdRf0zwE+SDRnNm1clO/7I0G4g9v+PMzUzOiN4IwYp+nKEoxq
 jtz5VcZNnMgeu5SLKaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMiBTYWx0ZWRfX46bSML0J5jfl
 0lKOWtP+WDkG0U4UNLoG8B4At/n4ZOTZUALM+UBzj0Kbat6jE3XDKH782eme87gBQL8kuFC5WWp
 WrrsfVRob+1YK5ukQPaNukqVbQh0zTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38501-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0F706F6211



On 7/2/2026 5:17 PM, Alexander Wilhelm wrote:
> On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
>> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
>>>
>>>
>>> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
>>>> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
>>>> CPU-native data types into an u8 array. On a big-endian architecture, this
>>>> later results in a null‑pointer dereference. Convert the data to
>>>
>>> Alex, did you find a time to investigate the root cause of the null pointer?
> 
> Hi Baochen,
> 
> I am now running kernel v6.18.26, and it looks like the null-pointer issue is
> gone. I only see the following log messages:
> 
>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110

what is the actual mac addr reported from firmware in the PEER MAP event? My understanding
is that, without this patch (if we really need it) we get a wrong mac addr, then in
ath12k_dp_link_peer_map_event() we are more likely to fail the peer look up hence would
create a new peer and wakeup the waiting thread. But the log here clearly indicates that
the wait timeout, which does not make sense to me.

>     ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
>     ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
>     ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0
> 
> Should I rebase the patch onto the latest `ath/master` branch and update the
> commit description accordingly?
> 
> 
> Best regards
> Alexander Wilhelm


