Return-Path: <linux-wireless+bounces-38828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qkHgHDC3T2rPnAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 16:58:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9369732900
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 16:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=fPA5pYyN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="U/pf0gHP";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38828-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38828-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42CC630E8492
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329F365A12;
	Thu,  9 Jul 2026 14:49:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610A30E84A
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 14:49:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608591; cv=none; b=bc0BZvSuvR7UTf38gJx/j1vj4FyMzQYvREoejQLekUwAPhXb/cDjO+V3AW6aEUREbSFTODRStgfT3knJ6UDXFGZP6mRy3iDR1L7qjxQgBOFbT4sgD9sqJB3SeE+vyGQFaX66vMcX2nka1MZRrj1XBq2nZ3/xdXGG76pCZriVEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608591; c=relaxed/simple;
	bh=QIdn8hL4nNiB3KOvBHHXDb8b4ie6vF8pOo18PmyPmZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HdroKjLE+Rb6dphajZ62iwPpjmFmwFlzy4JP1t8doQyOQCIH9MAMZdM6ogqAFqwG+DyC/Mqjx8jc7kKXRO0DJyfb+GyBcD9Le06IZ93KKj7Ze376n+pWHksFlrjFiqfLIoVbbb1rqmxYciHYSXENx8Lq/SUwpbN6SDa7nNmEykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fPA5pYyN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U/pf0gHP; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Dw6QR2012994
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 14:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPc0PsftVnE7aCxsCXlTpMZErMgufUZdgPI6m9JGZCI=; b=fPA5pYyNklZM25Fp
	wQRw1vQ0Y4G7neZm1mAQtuYkmTCrEFluWcYezLBnR+TXuXWz3sjBKjuC4iHIOSFo
	NVP1NoPzoyAIXCMFiQ3FI3CiZ5PjTdcKFzKoY5ZrzYBBXXOP14Ic4URYMCnN+YGY
	oQkkumOApJ8fiviySsicS9g7torJMBXCK8a8fJYXCUV+oAhVtF/6A9hCLMxXHgnY
	zs2sAXq7TJy5zJZmS8f99dOz1Vau7xrJo5D0OxdCHK/Y1MW7Mn0KT76zBSRAEiNn
	GhAVVaPLKeopbJo6t7UX+dvkcE5iO3uWJMaIm/Z0tOrYGwjjXH1SeF5eR32KtlK3
	l5Ro9w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418jsv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 14:49:49 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7ff3b4afa7dso38337767b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608588; x=1784213388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPc0PsftVnE7aCxsCXlTpMZErMgufUZdgPI6m9JGZCI=;
        b=U/pf0gHP+x/RXU9j8IHJJcbp+pX8dB7OmZ0P1n7qGgAye2JT7tfDG1OiC2Dn0wygUz
         qicoVxzzSyZTdZfi94V9g2Af5S368z6X4q+mm3iTBF4ek44hblR0iCNIV+xXs+4dznhS
         BOTeFVIDbjgCmXJjXpmmXbfGF0ck49OijSq4Et3J5rum16FqweUY/Dj9BzNol/rli/UC
         6legJCRU85qbC5id06x23cjZucSis39lES9etFRR6b+jhIWcVtzdwf0UJWWf/HOyDDMp
         XIssr30KhfeghQj0XCbseamRB2O2w1inwyiAx11nw3ebvJJ7sgkFCvAu7SN9JXzMQ7c/
         1g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608588; x=1784213388;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPc0PsftVnE7aCxsCXlTpMZErMgufUZdgPI6m9JGZCI=;
        b=NvVG72hKCzIeFN88XGASnl6qZEWUDxVKROL34IT5DyFfKylbVFPZYzkW2VDHoFDXQV
         lJu1qYXdXYZ1HCwdrjnlWSEsLN4O5njcbRBh4iECe9OOtHZgsIkQ8shOLWGQFzht4SWK
         RXKhBc78wpYD25bVdyoetic+CC/phIsVj9w5MhvIrFsYMZMPHLxM8WuS1x4jsxXK3DzE
         Q+/PiW+7Lcz/r8IQoLM27OWbikKX1mg9eExYw08n3mP3nzdD2ORy5+eL9xFqby0Cz8HH
         1F894+8v1tE4xtuT2mwasDnTLhAcfZfTbVrBTkeoo5QN8BBrInZFM9qXB+pZZ+CvOVNM
         IIBQ==
X-Gm-Message-State: AOJu0YzC2aVoFzEJMXp9efc5MWs8bpBlo3uN1CubasotR99KcwF4QMlQ
	QXkUitlIvc4Wi3rJ6RePr7j8AwW+ULqtqslrdufVIQ4Ob44CN8A/t+HzQxdOucsJcrd6i2PX/nD
	1sGmXr9ekeIUboQnJOjpzAVZY7qoScmA+0zzny4NMaSI/VjHhRh9am+thA1rTjccZE4MZVT4fKi
	vUOA==
X-Gm-Gg: AfdE7clkOVd81R6IYDyNwfu9LqJisJbnNSuwGPJVE5Jexy2vj4Kcq7hljyu1uca/ga8
	RJNQtA36WgikTudGKsU1sRyDOyF/eltlBhGgz0FwC/1MNobSM2z0EwfqrRZ9zYTcHUqeZ28B4TU
	f1pMVxwNtFN1oR307JnbAEoGCb+hiC5KVK1UQQ1Nu9hB9WABYFnD/4ZulSoNl9aMTNM4mYfapnO
	5oNfRRZYeJ7QuBPUmL4zrTokhGiS31NCu86B3HuJhTczcVW+Wdv4Ln+vbV1L/ISVhQkiwwwcart
	HX3gdqxcoXspnDn+gt+6Vb74nnGGP2pe8XHnzsjcUV8lti1ilv5LfM0/g0WoHHO78aNEff4Ekze
	lx2f+wcX3E9Gwb/Qm5oUjiLjIxQVF0fSTPl2kvnRIw3WlKbC/OZRscVBh1HT0C136qA==
X-Received: by 2002:a05:690c:6c07:b0:80d:15a3:7b1c with SMTP id 00721157ae682-81dbc049eacmr66480117b3.4.1783608588530;
        Thu, 09 Jul 2026 07:49:48 -0700 (PDT)
X-Received: by 2002:a05:690c:6c07:b0:80d:15a3:7b1c with SMTP id 00721157ae682-81dbc049eacmr66479907b3.4.1783608588060;
        Thu, 09 Jul 2026 07:49:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm4989277b3.26.2026.07.09.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260609092528.220547-1-vulab@iscas.ac.cn>
References: <20260609092528.220547-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] wifi: ath11k: fix refcount leak in
 ath11k_ahb_fw_resources_init()
Message-Id: <178360858649.1031194.15594754786646144074.b4-ty@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 07:49:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4fb50d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4uP_mf1xeMm0amWCCpcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXzU8vfqybnx2W
 mz9dOI8T6dE7Qf13dLctswY0eYts7UuN0o4ft3yS3doIg8SJBQ0C14lBXvKWHXIWDoUlX5ekqUp
 GoItx6/Pjkwmhmo7zSm2o5GkuRNgKA9hKt9NwnP63T5cURDvMV89SJ6Whbz9FYUn7dpHdyAPSoS
 VxM2EA6p99h6rhlHU293+m4XkBMW4JI81D0Aj4sx5XuiXDZU1+j9HvU/AuHgNvYLnKuqt5d9itF
 Y0Eau0Qs4DGgLd6gcJeHCT6e/B6kjGapBCXDHt3kiK09Zz6hSOT9ZitcxJPKGsEdAL81Ad4hmEr
 aX6KIYaJt4j+un07eZ6YWRVQhnPfowdS9/jkGL5prKrnFghzPxwgfxGXGrhI8z5K2TImV3KwgwF
 TCEzf3x+c9HBnOLvsCqrbBXfmtw5zsViHVllbeh5SrRqEx2kJMujpDUbnHA9RTChI6u8E3ouDb9
 653Y7Eqbg4KDtxspT4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwrYN7GIXnLZD
 Fl0qTGzpRSWz8VpP4zn2m7pUxyH1wQ5XuOhSBMTqGewR7+5qit/FfLroG0ncwbajyQe7A5TBEuv
 /csAJq8dGbAlB7VLjBwIMz/S+/sTcmQ=
X-Proofpoint-GUID: bK-xOAIIuMGJ4DBe60wwx9EQJ_7j7n2u
X-Proofpoint-ORIG-GUID: bK-xOAIIuMGJ4DBe60wwx9EQJ_7j7n2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38828-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:vulab@iscas.ac.cn,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9369732900


On Tue, 09 Jun 2026 09:25:28 +0000, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, but the error path when ath11k_ahb_setup_msa_resources()
> fails does not release it.  Add the missing of_node_put() to avoid
> leaking the reference.
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: fix refcount leak in ath11k_ahb_fw_resources_init()
      commit: 0e120ee0822b7cc650bd7b29682a34e137cec10d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


