Return-Path: <linux-wireless+bounces-35139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJU4A4d852nC9QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:32:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A043B664
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5866F302BDF3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF153D6697;
	Tue, 21 Apr 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRK0+moU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVhPkYtk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE91F91D6
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778220; cv=none; b=tfytCRsNd+FifSQBbKZ7CZHFTxKfKN5D1qlLiafQoAxFB1X8YnahN+BkRcLpjdNbMBII8ZjPULwUJSszwLvWFKPlvUqwWELHtNjPZr0lK+QxFU6eyPc516hQ0sVxriNbU6AYL3umLHgExEHMirCHGS5sfFsajyMIVA76he179WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778220; c=relaxed/simple;
	bh=7eOrL8mW0LhGXOXojeYXaM/CkVnoYaHOqdXlFCIbUbw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fYG9rgnlPAnqDIKK55dyPeJOWLMzhN8PmN+5ripIblX6UqFffiyte0rSz249HOzkNjBcO414V5oa2kVMkCFAPf/dtnRGgv5R19R0aQ5aQGDOp+l2+B50Nc81oMN7hW0uLOYVP/EH9fSv08s1yTRfLHd/OyDwtrhabHF5O4Zle1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MRK0+moU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SVhPkYtk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LA6QAE1835489
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vaq7HhAI6PkkjTf6WdCaxZxLFavrSQBcq8uqy2gDSWA=; b=MRK0+moUpKeb3Vy6
	8uODqbqwo25d6xVuoZfxU+EuE5u0lFDpMBN19gSnQTAucCWKjMVh+cWB079DjXQs
	bnGdnm+2be0b7tHuqBDPi0+c3KZ4PRkF3YDEbMPLKHa/KcefRzIbspZptKosVRan
	/xkHZCmvtrTRe4QCSfvWdv9Lsw5W4mAqo4kgZII+pGJNve/ydqw+GSxbPXrRweDA
	DuBT02jdI9Zx+mcHYXjJ0QdQKpEg7HDmD53zkaYL91v1QlQm6UlWt4XWbk1/+UfF
	UbrfIz4UhYL3qhqw88TZQhUyhZPAF1xu9V66UtB+BBwBxC7fa4713TM6whz2A5L9
	UOc3ug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp76grnhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:30:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c0ba59a830so6612055eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776778218; x=1777383018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaq7HhAI6PkkjTf6WdCaxZxLFavrSQBcq8uqy2gDSWA=;
        b=SVhPkYtk3nHnv6og5IA+Wc/S7iLZRCIjsOwO8VzGFelzwvWmOZJB3Hnzwu+lwTRAYG
         MD8sHE2VtHU2GyarbOEif5ossbhp/prtQnc0B9HfkuNaeqUpkTZsxUheSJCOk4Ugsl4m
         e9qm9J54Zbf1LqJbG+sHGtfwqxNUpVzKSqHzsjkLvA8K97gXViBsRSIbxJvBM6kXJ8WU
         CURPXW/p1vkMGRMAlsS0zfWat+lSVClxU7WqMSC+61yjHANxnARfjiguMs5wP2SMcLha
         kV4wCFMfwihnkXaQPeBefCdi2622U15JULAGqAcjfCOObMxdCpouWm3NhZqqfpv8CHL6
         SbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776778218; x=1777383018;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaq7HhAI6PkkjTf6WdCaxZxLFavrSQBcq8uqy2gDSWA=;
        b=c7pkyq3YAYYWQXPQkpxYEEUbiZ52XKyyHgnHG/DZpcgKl9jkbutmmIzDv+tr/aEXtZ
         7+BPPUMAbBWxdFXRKqPrFoN50uPqsUZR2kga+5iT8tvdF2cNwEw1Pro30L5Dt4TqtqJn
         35ofNUUL+COsc9hIOA7CYuhhg1OFx9DdmLUHNKHdWjsBJt69NhW43pKVjHLPTybYXVEK
         vyvGOeDifrRn1qR3uD9Vmbu+cPaKdv2iEL+6nDVlnVjyazYOlKDObyAuUvwC0W4JLFcd
         43sVmYczPo+H0HHvKqExborpACsUeb3Enat8ObsKLf4kmmhkqIxSei/E+k2J0/72ojrF
         XFKQ==
X-Gm-Message-State: AOJu0YxMzoS4RJN9wD7P3QECGK90e2412xdoL/tOjcDiYqRlxz3vJvIp
	ILhDNxV3X+KdCGeKSEsHBivCcO6enABJuHbjSCCcDvFsuBcMmsNvRaZrADIHftfjEKkW2JbGjN3
	S7gLWQYCF3PxOEIjsmQG6FJfgptJ3SKTbFXfdfWqzbDM/CFnhMDZmkswVDwuMCt3s6l3t7g==
X-Gm-Gg: AeBDievZGSRqOXEJMHWPt7Y2Amxc7Q82oFYPs0i6ohZRdpwRpbEQS9BtGdEveJOS1ut
	7iN63L5KHt+USt4EPI+BBJFzkNMvgBMvfCuhEWBi7DUrdnICwjziOe3/LPkPtIEWAjWjQgZRJic
	UkyIGmQYGkEio7h2PgGv0KRPlI45QtXvFCFdXMzrnsSbBzvYxlonSQIHzY1vqXjVP6m4fXLLFnW
	bCGJ+nDgg1gpBDURbYGwB7IQ/qbsvqC2nReS3V4u262alFfiRcEW1VvcGKLwk/xs2nlMFjQJMIX
	Wze/qj2NUkec6QF2S7wIzPRaceRyWkBYNc88i4Yn2F0CrAn3VCE97XOXyhkoVs9CNdfq99kQ0mE
	7pVRZQ2O9nJaadqCBuRcm5WLK52fJejDm5p6/m3btfHesyMlHpKKIE1VTqsN3UbuerUG4Xr1HCF
	DR961EyVYCm44=
X-Received: by 2002:a05:7300:e12a:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-2e4528ce23bmr9313979eec.0.1776778217150;
        Tue, 21 Apr 2026 06:30:17 -0700 (PDT)
X-Received: by 2002:a05:7300:e12a:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-2e4528ce23bmr9313906eec.0.1776778213930;
        Tue, 21 Apr 2026 06:30:13 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm18480206eec.14.2026.04.21.06.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:30:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260416-hal_rx_eht_sig_ofdma_eb2_mcs-v1-1-c44a3177deab@oss.qualcomm.com>
References: <20260416-hal_rx_eht_sig_ofdma_eb2_mcs-v1-1-c44a3177deab@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove macro
 HAL_RX_EHT_SIG_OFDMA_EB2_MCS
Message-Id: <177677821267.4175191.2411009711200791690.b4-ty@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 06:30:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzNCBTYWx0ZWRfX62pHUCit0d2L
 ph1AKMQVJA744qG83wVMTm1OWwDvBPUh0lgv2ENhzN4n57EbMZbZi1r0A8odKTCXbZPPkZkUwXJ
 tuZhU9kcMr1PNTkY77PSSDLyMw5IVO2JDHFUfo0B08UFMvZbFng9uPSSLaYBKI/BjMMzN/kwPmK
 SUTUAtazJC5zMnyWGrZYh93aC1cb67cViZB7q9KmEyjhM1HZ4Jzl8VD0LiZJCMKm6kHdnASfnzh
 AG8vehfUFl+4+zF4UedtLTeS0CE0OE5bDV4bYDxMUM/rxGP6XCnvolGFp3/9O7Ga29cJq4aF0Fa
 1xlZjnpx7NG2EbGES+msT6wkCKBK9yUqRWNFbrhLKPKytYcLBwxBJO25GV/f2qpaKT1J380rroR
 akJA5OMcXGI3H7Wo8LjTYnfp7/KeH/CHvhgTLst/vqZ5P/us4ULYPrpOmeHFf6Z5b6ek26KK9Hl
 EmdWOrIFa8mDFfrfrug==
X-Proofpoint-GUID: zRyBXMt6mzkfzKpqFr6hN2n_k2J7L9uB
X-Authority-Analysis: v=2.4 cv=crWrVV4i c=1 sm=1 tr=0 ts=69e77bea cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=V8VLkJffjg8ibZ3tvH0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: zRyBXMt6mzkfzKpqFr6hN2n_k2J7L9uB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210134
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
	TAGGED_FROM(0.00)[bounces-35139-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B3A043B664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 16 Apr 2026 13:02:46 -0700, Jeff Johnson wrote:
> Macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS unused, so remove it.
> 
> No functional change, compile Tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Remove macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS
      commit: 5c2ab62af09f7394a538739a1b130f0c88ad15f1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


