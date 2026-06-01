Return-Path: <linux-wireless+bounces-37232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O+3HkAeHWoeVwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:53:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E3619D82
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E873009B03
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F8A23EAA0;
	Mon,  1 Jun 2026 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H434eiA8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jQ9t45Rl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5381509AB
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293098; cv=none; b=VJMLGOJTdc4pfhrKUUWfXL4C7MBieuhnhpY9Pjg34ae0xFY9WsgTT14/j05zf970bWyqcUSCkzHrAt13/RTVaC+s49WO7FVJgVhBdEfWYeR2R1b1gss851sMCJGdkXnkybbjbAAuD5om5aJVV3UPccwQ4XWk1D9zBwiayWVJb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293098; c=relaxed/simple;
	bh=epOdyADDKi/Oj3pk3BcyHpjGEJJzDk3p1oBGanYPrP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/ppcxoMqJIpIDzni0ZiSkJzM0q/dL9NiZBfc4DDNycLlOCT8H+DJxpb4sa82tqx+sueXtS9COhDrCcXvMkJL+JOm64MDQlpQBdtBxsTB+l2kiSgWMkIMrik0BSf4Q7nI8zCr7Ve7sm+sr7zlAlp/ePYs7McybK7ywGCI8VxbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H434eiA8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jQ9t45Rl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VNe1fB3029821
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 05:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJtGUerJFVn5MdnCbZOrAmuhDmZzvbEglzjHjPl8uCo=; b=H434eiA8aBpG5fBt
	zC9aGKLSS7pE5pwbfiAQtCZTTdTzXApjCzN069dnfrWWUcF3DkjQOX2Hrytb/DGn
	Z7za4A1PP4KBGwWZecfuYj9+2RcYwNY7kAjYUq+KVad/fJOEwWK5T7xcd9+QV0n2
	TIBuKup/jIx5XjNPxA+Y8ZBSB+u4q8UcsECqqcfrgJyywMXgpx7+BFWYQ4zIu/8X
	8NwsqJ7Jlv2thR9YKuvT1mS0vkSBDfR5WDMF+9/b8xUb5eqdmtVbIpkKGk1T8MjG
	4n4O0v/k7tSJrfUqpAqBsybyzVmle9908fkwX6sb5sjCUI3RY8kGK4EShIxi+tcR
	vVJrqA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyuwwex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:51:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c20f7581so10992255ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 22:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780293025; x=1780897825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJtGUerJFVn5MdnCbZOrAmuhDmZzvbEglzjHjPl8uCo=;
        b=jQ9t45Rl/4X9DFNjNbNOuwP20L2nHZYix49MAW6M1xkzA3T4y3k7bjF4P7VOVVgvyH
         tzea9uTATAJ08X3kGmJNNPPmNaVPvlJdiUlR/RJnFoU2QNs79MClUT1wFfMiywNaXZPr
         9F8yaJgyviJKKOZta4UpXNwaQpb/6oDJcthTRCLYC3inJZ/RFDScxkKXC7PCh30wmWzi
         IzWZaVkIXpHyHw4SNXIJy0qGvL2ObC9HjiDByh91Rd8k7La1ZocKOQliExzHkxI4n+nI
         VxnLp9/lAxyMko4Uo+LOS79XhNe02Sk2ApkJ7i2ifVUOEmqtBVZfj76YP/AEiQYqWi5i
         UU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780293025; x=1780897825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJtGUerJFVn5MdnCbZOrAmuhDmZzvbEglzjHjPl8uCo=;
        b=HGtHBodq7B/tZZVRdY35GnmdI9UKaQEKUUJ14eDwFpTSgKzKQYKFKyuKkN/Q+Lus2j
         8oj+iwlu644iv0zrfnRY7i5FltuR+GHLafjLCazU6EXW7NEA1j4Q8GQChby1KIQJttOY
         f9NnhPeDUh07HCyjBhbYyYQ8ZAyq7tVqvHl/c6oPm+jsqKoLOjnJDtcrq9HZt7oKd9QX
         VjqWYGD4vmt9A6iWa46uV/rGNLqc7LpU//wnKND+ICSMyvjkDzaqSu39T0KBn4bUOAmZ
         notTZPBYv5/Uq7brP0x6aoFrs1ZNCIwc11PAdIcM+Z2rrvTdEeCAo0/6xZsjBvJQsJX6
         8+Lw==
X-Gm-Message-State: AOJu0YzhfRve04hai73FwS5G15ROfwnr1FvQSdfGvE3HHhPdIGMIXd57
	YN0KMNWQAzXT3OVfWgAwOcwezQIbj8BcZWp4AtBv2+UOuMOmJYyf9TtnnltFGXCNiXDjBBqstiH
	kglzLQGYpM2XR611PPZ9zkvteNzhhTIGYKAhFc/b/Hz9cVWlAxgCyEdALvLMTTYOrnFQVhScrsu
	+eETMM
X-Gm-Gg: Acq92OH3Pw9M8HpwHMA0RTTkkOI+qh/bUJrqQxucDJPaQV83rF0rPME6XbWaQPXx/Sa
	AqDFrutRSZoZI6hi+FpQN3KW/LLO9xEFjQ3SAf1SHAp4Tmrpl6SfYp/T0Bq7WQSA1QYnM8ctLHf
	C8oGqBz9ZgYNmAFmV218lgnKIWZBnlEM/qM+EquyWmL8sdT4QVbJD5XgNViN9WWFx9ULbKyXFoW
	yzBb7+8hCpJAbsJj6YvXkp0hhduqoCe8ikHU+LUJTHcHO6uzRQFo2O+PaFkshhhUd7SnvzrQ26Y
	T3flcUgb/rSgV/wv0TtYy5vIwMGsXi88oC5mjzBHx+8gxLbAiTULFEes2IkUWehcNHW7XMYkVHp
	CY14An+Jp6hNtBYuLMBSOZ4vbzAZnPb0+bTEiMxNXkjAIRwpLEe6laAPhdQ2HWheffJuFEa6t3L
	OVzNK4e1OfkymwSGs/XwhvtfuCaKb1
X-Received: by 2002:a17:903:19c6:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c0a3738c29mr96368555ad.6.1780293025011;
        Sun, 31 May 2026 22:50:25 -0700 (PDT)
X-Received: by 2002:a17:903:19c6:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c0a3738c29mr96368305ad.6.1780293024531;
        Sun, 31 May 2026 22:50:24 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b00e68sm94142985ad.44.2026.05.31.22.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:50:24 -0700 (PDT)
Message-ID: <3390bdee-f837-496e-8b88-fad1b378fb94@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 13:50:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add hardware parameters for
 maximum supported clients
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA1NiBTYWx0ZWRfX0fEyO7isSpkA
 lS+h4Equ30is3vXQy4XAxbuPybSiK+RqFMCSbxZj0SODKsvxHwkvwpG8uYuMYD19cy91YzqVpX3
 1vRQtSAW125h4Zh4TMnEvl/Y3hzdWIUMqUXih2wqB/BMpO1hU6FhY+/tqo/1puAi44AlE7294P3
 5m4Dtcv6FGcp0I5iewbpmIaUpCqcOI0xJvO0MzOPazZBMdMFuXMxrjo5OoeJB3Hswa9N05Tdyht
 mCtkFI2aZwoIKtLAoVu4y2sUsdrkMT9BPacVBjsts8afSTgPHPakwvEjdJpq/IjQPRsXjgY6blD
 F+509eN7swlKEj8pCu7y4XqE61SPaJXgVBj+q3xsqJiEHfc/l/hPRp+ahpSO7gT0EdKZEvqfMxk
 vHyIhc/sACzlCG9qhr8ndB7bLhPk7NPmRB3N+bO/TSnvne/RQESbohOWmbDM9lFuv/o0ncBCkCD
 BEwCu6nySuWWZOlP9bg==
X-Proofpoint-ORIG-GUID: lAlCycW0ba7E43SPHBSESRFwod3i_sXW
X-Proofpoint-GUID: lAlCycW0ba7E43SPHBSESRFwod3i_sXW
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1d1de3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=MKq5ULF0EFEncfcVwOQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010056
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
	TAGGED_FROM(0.00)[bounces-37232-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF2E3619D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/15/2026 11:09 AM, Aaradhana Sahu wrote:
> Currently, the driver uses memory profile parameters to determine the
> maximum number of supported clients, with a default limit of 512 for
> single-radio and 128 for DBS and DBS+SBS configurations. However,
> some devices have lower hardware limits depending on the radio
> configuration. Exceeding these hardware-specific limits can lead to
> firmware crashes.
> 
> Add hardware parameters in ath12k_hw_params to define the maximum supported
> clients for each radio configuration. The driver uses the minimum of the
> memory profile limit and the hardware capability limit to prevent exceeding
> hardware constraints.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

