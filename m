Return-Path: <linux-wireless+bounces-38964-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XfK+H9KsVGrvpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38964-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:16:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CB7492F4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:16:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=EI1KbGmq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LH3aOFwc;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38964-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38964-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 573FE3005D28
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291243DDDB3;
	Mon, 13 Jul 2026 09:12:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00103D953F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:12:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933930; cv=none; b=ES5amxV88tjGf1qHOcntH8lhlhQ11LKp42jI2HlEpFJaGlN3zQPdYSxy85f4til6nYqYl4HJUcB+rTuFhxYI7pLwyNMTXBXgl4FjlYKNorgrQkzUmw2R3x9F9qyPLCjWVSesRMIQyHUzvJicGc5+L0EAXqEKdLUKTVu1ta7ju3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933930; c=relaxed/simple;
	bh=nAFClP3JxQsKLl7d/NJzJJnZB+h3SYhZtlfOwJoG7TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sApe+VjpHQmljw/zoA7m+FUQ+D0SN/NJx8V4nwe/TArmr7/OENx6yitdGwQ7a8UKzP9FnzarEx9cAxYy32eBFsjL+v3sC29YNWxv08Jz0YwdbpVmV4fIVNj/IGbhrdRaX9ERS4qTCNLTMyjC0KNcrnr8hArnqzT02ora2TGgCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EI1KbGmq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LH3aOFwc; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D98viD793186
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iXAJ3dbiQ9FQdSrTuK4dIfmh7nCFrqDUavEQf1GJa/E=; b=EI1KbGmq0fg3v1iR
	IxM0nLDXiR4eSUqwwS7QwIpIHvYhOWxI+ypkNyLVVFXlcHhoULTY7mra5ZewDQ4O
	uY+Bq1jgg0CpGjrAQkyKlnlZzcO9xX3g25t2j5/utoiA1LZUAw/pDnUDUOaOsrqX
	lx+VhN6zE42FTp4NVgD5oDr4iBCf5LcYb52+bnxKm/+OT1yIpIBM8Ux7OMPabB1j
	KFO3vA3W+/WUloNbtp3k/6duMIZHkKnsvHT0/Y3+bnPesBqKpmosqFxG5qZOWtme
	IiX5zjGoYzUpjik+rY4TfCKpGLYgwDRb4pzZIpbjXSzl1tN+fVLYvZF/NEd0jNf+
	VXUKXg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qr0d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:12:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so3918323a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783933927; x=1784538727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iXAJ3dbiQ9FQdSrTuK4dIfmh7nCFrqDUavEQf1GJa/E=;
        b=LH3aOFwcGj/c34Cc8QEMYFKy5Qs4Bexr2pdA7dt4FZ3lq2Rc6sLZneOdfeGUwMBgf2
         JAMe8Jl8kmFSdmToHxYqjatoaEfycnN3f/BKYBv/mdJqFxehuFAlN6QBDmKBkpHBk5T/
         lvNduRBxGzbCbakrLGStmNbZz44BkhCWzCTg+EbqJgwlanA+fMkKaddqFH8lNZKyPGHW
         afYPJMDt6Rr1QCYkgxmL7qy8U79GJuE0lWaXIVWtrzXNhyo71i+dEepcH/pg6xvm4aDa
         iLLEEGNg9GVFFzeDlkrDr5ekq1f+LyzwaPOYLWjoOIexUBiWGJCw3dzxTJ9A55NHab0s
         ZrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933927; x=1784538727;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iXAJ3dbiQ9FQdSrTuK4dIfmh7nCFrqDUavEQf1GJa/E=;
        b=Y3wrRuf4TNxGjOmdXAKcwViMxVX0OL8Q6/aOYGsLguqK7oVKXAlhb5hDhDzARhLqQS
         fwvZj9DRVjjcbCcisCMrTsKBrBb7zpdijThCl69tPh7azUdgH+d2KEi8YsbDJsSi7/cI
         lI39/m1D8rls6uFDlneqXb2BaB4QTGpkRuIHP52yNsvYhz0Ct/vbE1ALNOiB8BS9raAr
         srTbakMTtDwbbLPkghA16aa9HmU5X552bpoBz3mUMFhkOlDWWNbP7nwz6NOmNStr230a
         sXWrXA4sQuALbPmmN9nSiIPmktEMxa1zdaAXaUrnZSeDkfWMo9odUWftI1i9TK+d7E5K
         KCWg==
X-Gm-Message-State: AOJu0YxEj8cSYYKTF7HR+gcC6UWxxSWI5qTPufynV8rP6tRqeeuorCJe
	+kC9zUEO9NoKGToku42akvfEi4SYGXgMlf/5+us+0SwysAiiMLGwBlYuQs0ca0uj9DYYTLQQwWG
	ORtLfSNnb9tc1pvqfEcXeBjySycZWov/kJ3x5In3AUihcsfsvj50Acml3r6CWaFV0U0esm0yA9g
	iPMQ==
X-Gm-Gg: AfdE7clQ639Jn9OFKN/3R3g59qwGH+AI5KMI6b/NUkt+Um120W1NSjrzp4ZDMjHjJ/7
	lGnUfKWo6EVJ1pmJ4y1U7D4RDq13V2p+kCy3WglXJpsOndec9oMttXbAw/WFXv7TlgksgvgIxCp
	xHDw1bwZEFgz66oebxtJ91uMEdmjUvyEc7luPRIpjMnYMmqCNEdWqaxWdVDFOyLP2yazCzGFWTX
	ziJ/BQwc7vCVoMDpA0CBuFSHxneD5cq1YuY9PPZjeQRhjkgkrDv7FteQkH/Yf6EqUtPavc2Htil
	Sfz7VVcei0P5RGzLvIfLfh8GJTdbeGJBjLH2nknm/Yp94bvH9WeXyzHwojZv4Kj29QMkbDYoD28
	bKaGz5QaK6/9nrgfeq1qL/rwHw0gOBBNCH2pOSUSOSZsW16tG7NM=
X-Received: by 2002:a17:90b:4c89:b0:387:e0db:3d8d with SMTP id 98e67ed59e1d1-38dc77c6b26mr8078869a91.40.1783933926719;
        Mon, 13 Jul 2026 02:12:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4c89:b0:387:e0db:3d8d with SMTP id 98e67ed59e1d1-38dc77c6b26mr8078847a91.40.1783933926280;
        Mon, 13 Jul 2026 02:12:06 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm74258036eec.0.2026.07.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:12:05 -0700 (PDT)
Message-ID: <75c4d7f6-0252-4438-b3fd-cbca81b1a189@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:42:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Set
 IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NSBTYWx0ZWRfX9ZIjJPklLlGq
 vn9VO+MvFckQCwObBMndVTxNgXrOVObQ/gzQoKARse4MbBd8O7XQ8w/nxLuYJaAcDL4Fu84tLH+
 14a0d3wGGQbjLOTS9Zaw/UwWHNo6WKdqesPZ1p/YmFKZLkr0wtqkaQmGuuL2imScMaKAwuJLr2Z
 AZAmF63PGyfr2ey/9nsln5cpjXFS6KVHhqWASBEknvGyYEhvMoH9QS3b3XXsZOGrU6Iy7SIqO2H
 n6CSA6zLOr36o6oKaM26fhh2MLT4o/KdCmEI8jNGARs6UW9fuEliUZVuFaWx73Umb3T1M2lr38A
 Gk0DKerYsFen9C0ifRCg7e7FCpryAZrWj81BMTTYFck6ygJDiB4PexOE24GboPHNlCGUnzqCf+g
 5bSRl+KsptzmZd1jDWODDeArKSNAj58PFHllxIOmXuPehQl3mD393B5ew3l2jFci07M9z6Pzb6v
 rgnBObE6KeQ4uuNgQqw==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54abe7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=OkBu-d0m6Dx8VpF2E6cA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Qr8HAky5Fj_NbxpQvRqFfV2vly9FParq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NSBTYWx0ZWRfX9pQo6lYMR6J9
 QRI8N+3jpOy32xMzZAz6uNYPvB4ReU2EhK+06BtEn7ielGeiQ7QjrG9V5XC0TvcxrFijgoOFM6M
 6ctgN+1/DWAMQPTxMxAIYOaWd8S17aI=
X-Proofpoint-ORIG-GUID: Qr8HAky5Fj_NbxpQvRqFfV2vly9FParq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38964-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A10CB7492F4

On 7/1/2026 11:54 PM, Tamizh Chelvam Raja wrote:
> Currently, IEEE80211_OFFLOAD_ENCAP_4ADDR is set when
> IEEE80211_OFFLOAD_ENCAP_ENABLED is present in vif->offload_flags
> at the beginning of ath12k_mac_update_vif_offload().
> 
> However, if the WMI vdev set_param for tx_encap_type fails,
> IEEE80211_OFFLOAD_ENCAP_ENABLED is cleared but
> IEEE80211_OFFLOAD_ENCAP_4ADDR remains set, leaving the flags in
> an inconsistent state.
> 
> Fix this by setting IEEE80211_OFFLOAD_ENCAP_4ADDR only after the
> tx_encap_type has been configured via the WMI vdev set parameter.
> 
> Compile tested only.
> 
> Fixes: 729cad3c3c9e ("wifi: ath12k: Add 4-address mode support for eth offload")
> 
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

