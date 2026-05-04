Return-Path: <linux-wireless+bounces-35867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HSuDcOr+Gn2xgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:22:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE84BF3E6
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74D8230416A6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F4C3DE452;
	Mon,  4 May 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LqIZ5zMD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A8MlabJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB21A6827
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904479; cv=none; b=gEBgT6Q+sWcJhQkz1nuuxec5CdYXo8YxYiRpJnxIzTCrXPvZYM12FFOZ9wlQcezoxEhL6mtBeQsLBId7j568pK5F1xoF6CaBR//yqX92DPCUF0+QGWvUw+I7mszr60S0jMQ1YA3iWRX2jGOxWJ6AIanATriobbcxjpjQUrwNdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904479; c=relaxed/simple;
	bh=LTIyvaHOntrcga99zvzPMx1LT1Qh9wK4gfZE7wr5+qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ceHibjDaUxFjdBz2aomNFQXBvflIBK4wJ8Qa5jMGzo1on759zL9WWj9GxnspfWOTNctAv16VBcLSaTEuyFulLGafAVoOrkvec7siX7OJlZhzLdU804tiqrvy56F7gxUvJEy9Wzqtrfc73OVbktQY0Ly6wqXT+Epjrx2b4jlg4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqIZ5zMD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A8MlabJK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B4And4128691
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 14:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o3mBsFpKwPQKIyMmFcNYgNvNlST272PJWU6KGY+4LoM=; b=LqIZ5zMDIZBHUV0v
	dsKGzVN3pJfU1cb1VuA+mn1B88bEskI0pn+GHz87JshhI+469QO0r5RCY2cu+GEJ
	64Vb2xUAr8Q+uInafHd0IuBdvGjogcfT7HuBK4WMirQ9+DYvMNsORHzCIw2dHug6
	qWBGmC/4JQq9A628PWIMxDj2BRVZolGjjF9ZSzGpuDlqjTvK4p4cC/erx73DjPWI
	4GR8kcp7gRPFIS20qEmK7xVRL8D/ZLO0CZEdqdiTCaiCOPLCpXe9w5Fof+CqNnPx
	ErZIs0VAkNLaLkT6Vy2QlHFKv1vsD2ARjhkJUrHL10yWAqt0b5AGzSPJUlMrG/c4
	tLXVew==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsdw0s4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 14:21:17 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12df9e440d3so4957567c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777904476; x=1778509276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3mBsFpKwPQKIyMmFcNYgNvNlST272PJWU6KGY+4LoM=;
        b=A8MlabJKYktnlJPcKft5C7d93QVu1rvAwCEnj12LXsIIlEZgJ8VhUHInKHxtBh5gO8
         mJsqvC3Qd6Uz0Pt4ApI2wU/Wuu2GMUWVsgt1pqWG89LwGkWgTfP6jv0jnr0PG5bsvTtQ
         wRqQ5IprC1mdZg1sDzG3Vf3qGWFESKNyFB/HnddeHx9fI5DRob2LYKUmKDbT0+OIhuL4
         ZIfgOgVHriMSwsIxi+WBGR1mgo1rlaIqwQ9qorUjDBlc+0gFeLG86Gcoo9Ua0kMJ4Ihv
         xzrFFGKeALicJIMAU9VZhUZOnLvSZaBnkJWjEte1caeDvvl1lSqP/DTmTiC54CCeQvV6
         ecoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904476; x=1778509276;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3mBsFpKwPQKIyMmFcNYgNvNlST272PJWU6KGY+4LoM=;
        b=PN9EaIJyQF9iSqlxhjvvPfVYaFa7OAAYtDK3UGhzVtnvqQobUSGGvtR6oI45xstSo8
         1PrlqdIA49+OXxqAhXdPCq6kCrTuSu2n9pWP6gc5KT3i/9nW0NVQ0ASNJx0NOQv7MKK0
         F9oPDl4YK/PX5ZCP0cYhhbAgxV0bjldPtPKpYzrKpOpv4TwfC1+yGKa9UkpnSOvibHzh
         RD+sFEx9XdpCGkBASTeay/hwza/gW7oDQW4cnTeTLwYgM7q7Cg7lV+zlZvyc0q2emtXl
         ZX8Kddw3A+tmucwA6lajlNFpnndsTd+2rh5uO+w5fyrT6SWCGqzn6+YpxZ3jaEKT0K2L
         668A==
X-Gm-Message-State: AOJu0YzX1wr8Vxjk6deJmaVCwmSc0f4sDjnImWAPDkkmY6NZMnC2KGQ2
	QY98XPWUtx5BzJ/57wbqxc6bt+/5IGvn3zZGassYA2uN7/6NK+3qCK0e9D/hNHuXd6qtYULmRzm
	1yRdcdMS86VCP0kwpjjGYCOU7+zXAsqGpyd3w6w5ZZA6iiYqygy1mFSieJdKyxnt9EgPlngq0b6
	fB2A==
X-Gm-Gg: AeBDiesYl3KXJ1uKb5P4xbiwYIZ7kzrG9xlHKRFPavKzk9MKOCpdOCY1pLW8jQ9HZb/
	MlJlHzrCHxFRasRhyrHFTyYD4ITIS4LdNCePr/WeS3wEvSxUtX7pmVAGr6xy/ivIsw7+/oDE+9d
	Ej16KO6Kd2yajrXn5UXjMm53OZ+wMkcVmYKApHzGiqfr/DeN4ImqXKa8v6oYzcSTHsZBjCic61R
	+n1cUNsffo9sqU6pOxSoa8qW4RcC+A5wf8rFa8MD5A4iUk1Bi6TrrnkFjmxx7E3uNva4LkuF/l/
	l0p9Xx1Be/SS5kOdBbWYbGFDoDCl2gVPt52Bt0NwISJMQ2Q9sP06978z4j1lqc78HV7ME9RKGWO
	uGaywoFE2iWptI5Zk4IKGf4it33PakiT4+1JBtwEYaFX3DxFG6f34jVn/q+h3zPLKswuM9bCY7p
	RPKeYpGdAIzkE=
X-Received: by 2002:a05:7022:f404:b0:12d:de3f:f3db with SMTP id a92af1059eb24-12dfd844f3cmr3219351c88.37.1777904475424;
        Mon, 04 May 2026 07:21:15 -0700 (PDT)
X-Received: by 2002:a05:7022:f404:b0:12d:de3f:f3db with SMTP id a92af1059eb24-12dfd844f3cmr3219327c88.37.1777904474814;
        Mon, 04 May 2026 07:21:14 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8452edesm16546186c88.14.2026.05.04.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:21:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260427103011.2983269-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20260427103011.2983269-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: initialize RSSI dBm conversion
 event state
Message-Id: <177790447392.1253723.2410134562149698817.b4-ty@oss.qualcomm.com>
Date: Mon, 04 May 2026 07:21:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=a7AAM0SF c=1 sm=1 tr=0 ts=69f8ab5d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_I3uSAleeTxDR0ymUIQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: QD8PxZrXxkwQ3szMgKvKROcYwz1NrSxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0OSBTYWx0ZWRfX9JmLx28WMfNp
 v4YG9+gWEbu1hk/eJIfQB3oSetiLAoKGlGqDb0sb5itNansj5+W3HWI79dq6zp1ZhXi9O0TzM6T
 39JxaLgzOXOjb7kJTgAVEG/cQCj4mzg7g+Rn1rf0kO74+OFJeMGDNJxKkdyiFmZsBLF3wRFM/0r
 GGxFWtS61KW3qkaW9WzK8h9Ofb4M6gf4JpNN5r/guf0I5DTd+WfP6wb7qpzK/p6botBkl/a2OEI
 O3icXL+ft372af8bGRJnrf/dUzeiSfcy3cmHu6/s0TjzY2MnHm3xhN2F0WuKDDIG6uGgETmWjrC
 gzuJ05QOhxURa9u2kAEWW0lC4uxu5n/qlb1iQ2pO73aGY7Crj6jqN60Yz44JTs1Jj60v3taKEbP
 zxx7PSfgxyS2Yb5lQ8bRWp2HkKO/QIv5wwCaGKbMDJSkuuz0UEmWnmpSErl4InBSi+UQE3Srxh+
 h6gXzGaVcFNt0tfRgEw==
X-Proofpoint-ORIG-GUID: QD8PxZrXxkwQ3szMgKvKROcYwz1NrSxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040149
X-Rspamd-Queue-Id: D1DE84BF3E6
X-Rspamd-Action: no action
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35867-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, 27 Apr 2026 16:00:11 +0530, Rameshkumar Sundaram wrote:
> Currently, the RSSI dBm conversion event handler leaves struct
> ath12k_wmi_rssi_dbm_conv_info_arg uninitialized on the stack before
> calling the TLV parser. If one of the optional sub-TLVs is absent, the
> corresponding *_present flag retains stack garbage and later gets read
> in ath12k_wmi_update_rssi_offsets(). With UBSAN enabled this triggers an
> invalid-load report for _Bool:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: initialize RSSI dBm conversion event state
      commit: 81594a12d5cecb3ab35b603a00037c7c3ee87ab2

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


