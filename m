Return-Path: <linux-wireless+bounces-36901-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODtdJafEFWoAagcAu9opvQ
	(envelope-from <linux-wireless+bounces-36901-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 18:04:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10A5D945E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 755B0301C666
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03946395DB8;
	Tue, 26 May 2026 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aTSnsWm5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2FDznxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076F3932DC
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811137; cv=none; b=THNfJrkZ3f9z37Eruic/iRui0CxxAdzWeuCLMT4oBzYjlow4qSdtIKLjAYaerawL0kh7Lmu72idFA14vatYwFkIqDU4t+CiAfA8FyqdOCAZa1HPElaih9TbRGiJFYmxKqCgPkhlQY8w2z24AU+SoFwlDbecrQbJFoznvgR8FTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811137; c=relaxed/simple;
	bh=m7IhMGPxWVXPp+9lI/mnJOg5fz6nb61YrYStZBQZ32c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t6A0FJn3qh/kDHTwtOuy+aRrOn2qkBFbyJo0fu6y+pnloH5WFGWrVispPKnSWCBw+M0ZtatWHvqYB8qww6GmpNoDebZk41hVxExwbOx/wlq98apjQfrQeiC0uwztNiSJthbZO/oeAWqSYe5qOTx7Vc1jk0NB9SSVh69Rt/CfHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aTSnsWm5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2FDznxP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QFlII92901756
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 15:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oN5fW6z9Sxv5LrKWtpk/pNrVz/RjeSZ2dahvl6Pb7/Y=; b=aTSnsWm5WFHPAfiG
	Zun0ogL2CJOeJatnYBzeRQP+JdT1JB4rAECZPXTVcdQbt2IkgR84apib7UIp3uE6
	m5nytr1HQg6iD1FhrFDnM7egQRuBWs6x23vzTzHNlmq9I9BCIQoAk/9w3OJLlxq/
	Ow19mO1bbQRqD9UBJSgiA9KNs+nF9LmxXez5QnFjEscw6B8HyogWaXAvBfdeV+IE
	tdf7HrjSZsPSVRYK1T6c8bx0CBpkKZOdJQ8cVuxYX9kgNd6YfxSCMXJSoraWVtun
	zNcFn/HsFp4ZMi0SsITvHFziSOA5udqCcWeuqlIxz86xpnDq2HId8/RdWGTrnzNm
	vBuJ5A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edeff01sy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 15:58:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1365060ac82so3061667c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779811130; x=1780415930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN5fW6z9Sxv5LrKWtpk/pNrVz/RjeSZ2dahvl6Pb7/Y=;
        b=F2FDznxPBN0VLyjdkmeF4TCVxldtjwR5ehIBOrIp+bdRVuD5yDJCgI29sPBqec0AZs
         SJSInIiCYsNXa0Cz2uIp6WteZ/qor20T6UldbSW9FdPHV/H9hkJY2sRBYr8ppwR1l9/p
         hi+d3J4E/ClnSvJ2ccTN7rtJjdFteTyZCguNTcpaKhUxEhKgWnXOadFEemjzazqP6ldO
         VvpHxPLVLHBJR9maA3QDQYTmKKM8bdyGtQ9U+GnPluU1Ti3ihKFxQO9X1OnvgoXsT+KQ
         slOYLOdKwTJ93g8Fk0w5VB8NW8oeM/ZW/NpnFn9Z0uoOFQk2/r89xJuplcsoQCPJ89Cg
         syqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779811130; x=1780415930;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oN5fW6z9Sxv5LrKWtpk/pNrVz/RjeSZ2dahvl6Pb7/Y=;
        b=gncN03EvBUn0qoc924olYgx9hRP5FUy5y/zptDq5dIGsKZBJynqJPZ8O4kb/d2V4sT
         ZyDELvp74PnkOhSla6C6e6EVba07K0vfV5cMU1+to57Qkx31ExuvfLyRiOSPLhvdrIhZ
         33jU9CZwpKobo/6qeOttZnMYyx6jcCvY42s7WIlieCJJZy7HIFk16Oib0BmlaD2Mvv9c
         uS3x90YG6AolXIDLnHbNGL2JIBX1sqlKUPBvKS6mmsGll53zaQsJTKXAT7i5Wipjs7nx
         NzdMO3BvSrxDnZw3lOJRjHJQhLqXnM1zJdVPPLpXW/5uFLlYArR4m43SkjwU1Kfs1qD6
         1wbw==
X-Gm-Message-State: AOJu0YwQ0Lg4hIv2hizWvNuh6L1xMU5d0R2iOefoSVUxfgcH949tkuwT
	R7kJfyGzeThLoH9xosgSx3i/Nn9clBYs9/dQyN+sVjOI0nHIgtHPtcbL6W7g+boneArDBjd2eNk
	OMUX9WVYh0Bgp/sCunL/HwlDY8NBr2FpHuR3aZtf9wui/NMI5aQMng+zthOeCwKg3cZQAdENbrt
	cheA==
X-Gm-Gg: Acq92OFtXX9MzvJdIAW7FcVpgwjwQ8dSq8GoSSSOpQ/xkqRWWwgl+B0Z9nef5nNWJUy
	ZBRgYXijeSZ4r9qo6Sm2YCxF+OV2YrrhGZ6UESbV8J8En8paM1Jb40EqFtZrgaBpj01atal7y4x
	jPzFxNkqWORn02t5P9kqSi4hwcJOA3yAmGbMxth/d0vwOzLJD7GaTOe+ewp+cTHyGMllrygnomE
	VgvDEXcSovlpYhMIDN5WEP24xbkc5LnAtVUZ6klJCZ4nDpStdDGcnTqhGt2HtW7jSgol8mzpq0v
	FvMB/PYo3rNXnC+EFtFiJntMIjW7idAelzG7ios49VFn6EHl2MrzYZIrWB2HMkO28pBA3p4lJqp
	mSXVjyid9UvT+kOd1wImIQnLj1TT2bokBrZGGsdUiRW6ExC9cxcsg95lmkfIVpqRUjP7muqeP09
	B0
X-Received: by 2002:a05:701b:241b:b0:132:133f:63a7 with SMTP id a92af1059eb24-1366129c82cmr3517283c88.8.1779811130392;
        Tue, 26 May 2026 08:58:50 -0700 (PDT)
X-Received: by 2002:a05:701b:241b:b0:132:133f:63a7 with SMTP id a92af1059eb24-1366129c82cmr3517260c88.8.1779811129852;
        Tue, 26 May 2026 08:58:49 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm10449396c88.3.2026.05.26.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:58:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <ripan.deuri@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
References: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix error unwind on arch_init()
 failure in PCI probe
Message-Id: <177981112914.2898644.10933293159211172747.b4-ty@oss.qualcomm.com>
Date: Tue, 26 May 2026 08:58:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a15c33d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=W0DvjKP5zDoBJA8oHBUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: igg15TEgWGplN5jNeqfULQyyw-1cYj0A
X-Proofpoint-GUID: igg15TEgWGplN5jNeqfULQyyw-1cYj0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNyBTYWx0ZWRfX+LDgyiVSp2lc
 vwRAvSMKsFNvjc50ZBkmUmmkeP+lzKKm+vssJj2Cu2RwOqwhWl7OfN8Wv765CGHTlosCoYAl5cG
 fyck80lz2KeUab8M6ZpxKTHj53KyJs1QNF1K0cPyXykRLo3o8dl/OOYQFu6DPWCer6uNE7NRqRS
 GljLQu+9PQPSLABvk1QdpI7O7l9yoBZQiA1SN/Azl5GcXit6uLKb14W5yqwysMWVwyGOdQIig+D
 64IB31jSP/1TR8cRyvlXZsoh0zEYf9dEohWd+p8u1lnG6gT4cxIQtlQRSvlvvgUpMOrveQO1eI9
 gaB3dA0+ekPaf0SWl98WAowu1zMvnHFYHxa3pN6ed96fcfWdBgN3RcxwurP8DnyJdYOSXuuvQCi
 H8sC3EgiqjxPQeNd+4p1HWL+md9sapPZ2eiHn08pSJF32i9rSXVKVMsP8RYFIrdowG5Knzk4ggp
 2bopbcPMot+/3z3ZgjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260137
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36901-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C10A5D945E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 20 May 2026 00:58:15 +0530, Ripan Deuri wrote:
> When arch_init() fails in ath12k_pci_probe(), the code jumps to
> err_pci_msi_free, leaking resources in teardown.
> 
> Redirect the failure path to err_free_irq so teardown matches the setup order.
> 
> Compile-tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix error unwind on arch_init() failure in PCI probe
      commit: d5c336161088c588f85da64f48ba6deead194afd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


