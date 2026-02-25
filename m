Return-Path: <linux-wireless+bounces-32182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D/IeI5gsn2lzZQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:08:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82619B444
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 006183015B62
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E43E8C5D;
	Wed, 25 Feb 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yjr4AUnt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ic9KjhqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310113D9028
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039312; cv=none; b=lCbE6dSObwkswXbi7eMf3OfIV7l+FQ2KosjXd17SoyeP33upxAT12WD37oOR3ZUFQLt0KwC9b83EjjrvId/LSyX+9m+Ny0OASouB2rz51MBdyUF9zy8GQsaoKv1fFy6u8Nu2dyv1Q46LzUz4W7Cnf/kN2VwDML7G3E7qc6hF6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039312; c=relaxed/simple;
	bh=LYCAQ8fCYTXn/BSkVmUs6thsT01rP7Hivy6uzBuSojE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9dPOddXj/GfXG5o8HoApkYDCUXQwIXzostCQjSlBgHaQw1LBFoEad4Ynux3pwpqszmfrD/unapXvxeUychcQg+dtThA1nGB9SCXEMUr10ibbFw5dbdH/WzN3llUrHU1U79pla0qlPqe8hTrCXoPadSPtaKWzy52FbBSTw6YqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yjr4AUnt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ic9KjhqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9RuWJ3056472
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j7HOJfjFPMkVquotJuVPSJWPzpnCEvIOb9pPizeHlH4=; b=Yjr4AUntdJE0c5x1
	6fS323ILEA7fC8WwLPpONZ+AIq/QNvcA0by4+O0vwRFWL0408XH/d3sAjWXnbcxU
	X6Agt9uv15sgKgjvrMxS41Sw/N9zuEgZG3eS3Da8urpTU6cKTDXzt5o57T6IpLa3
	d6HK8zqyZWwsFNh09q2aWiszFc9NkpIeAAkyNxcn5gfmEE15YHIzUedl0tnB8LYn
	HU0Tv1bVlnqTOw/w1/lNxOsPZTEzLxYvoFVga1l+Hz92X9WdpayjBXmVWBHLSlh4
	X0M5L0DPd4+jtNi5mcKQSnNqJdewhtP1vGTUZH+2lK/8yw3Ug4w+TAbrP4Fx++eP
	2fKohQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chx39hhf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:08:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aaf0dbd073so82098655ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772039310; x=1772644110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7HOJfjFPMkVquotJuVPSJWPzpnCEvIOb9pPizeHlH4=;
        b=ic9KjhqC+2xfxdIUZX0Xau+qZEsaWsPp9pkJksbdCYbu/VmBJgcL0ip1JebjQU4qes
         LDZftKFhBxTgOFfXYRvERSK2ISeiZSUyPIDtFVEpmKY1/uoXOQM2/S+QGBHNvdgF6+Z/
         EIMdRDv8T6HrVxGl3Qrs6q2rFVZn9eGyB4SkQsxWDxtKIZ7SO4Yq+uRjdbkRHrPr8FrR
         oGDJJb4MBo+lqdi3K4aGy2UxN1NB7U0Gm62TPcqi3eTlLGEkFXeIDrzwUlYlQ/8bdQKc
         mPUnBA3KsVarfwL8TBjUkehzy+FTJbj2KRw/oKRyrIbfuTsDfZObqJHG9GF/bKHna8f/
         oOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039310; x=1772644110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7HOJfjFPMkVquotJuVPSJWPzpnCEvIOb9pPizeHlH4=;
        b=VTFgH9abeZEURgXH/WEDdhkUVoP13b8BrynzHCrf1+7bqSmtARzz73Rjv5ozMcxz/d
         4eiAluP/O+vPYm5ydYIvOCePjw4Zci3cXRDELy1H9iS8VyXBDKgPzGielgcHfv4b/o9a
         9EfkR209/SG3PMzSnZ7yRPK4JaT6NZmcjHNHLWwJEfK7wl9kaWfeB3YOItoTPVuuhOpR
         FsGe1PM0N4tHju9nYsFSi0HEh0EtKpFLl89L3cc2h85W50/N/+Hxc01nApMtgvQ5mxXI
         nImTvszesey5llUvALKBaO7CbzDNG1NgovuB31V63KtJON2KJGAIRzmvjapY33Nt50ie
         pNQA==
X-Forwarded-Encrypted: i=1; AJvYcCUjYvgJz2i1/1nqfJJzpcK7aakJTUWE+KlPgQKKa4gZrtnC6f6r6JwsGOK5mqEoXfhjwrvZsV+PXNq+dD6I8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxniqfVQzuq8F+ZwRtTP6yig4sDNOGHiUZmZ53sJ0TWX6NaD56m
	YWUeEsUbwKmsWB6xG2Kkb/dUM2xDyvh/qnErvjPKAjml5zYoMFth2nf4PYDLlQ5yW/g6RV/3tf6
	I3ZKPcQN0ImB0vMcOtO69DwYBjcUR90GlnPWXcaNelIfwzNFAFHtsAEl6O1WP/dLTKVW/HA==
X-Gm-Gg: ATEYQzzBG8Wg4XpUmvN0obWzwqcYuT0UZVP7xIRzqjbVrixrM8eraGLFaXgH7i0nMK3
	Uhv7DQXznyalTTnipjkF35iuyD/FTAX0kunXStRbwLdsdQEQdugkKTbDvKo+L8YGTa7OZMa8PFs
	Ab15utCIU+oaKLubZQD96vBW6b01aEVaSMnf3goKIQzFUyvXuBlAmgEVCytDAR/8X01dFCktYri
	ZcH4tIisP2EiEPcs0yPPCbRivisYoDuZh+jgHF1MMp1YEYygYXWAjTHOvmMZCFS8WQ9gThRFpqR
	RGbmp69WUxWINDycBvN+mjt2JvCZVC1EGyzHQrm2q2QOc0+RxutV1tuUAgpW086VN9F2EnzJBtQ
	3nObaQSpaTP0A6OjkHQkmu/piaL9IBFrGNgSrxF/q46yyIT+cz5tYoN/dHn6gOaGXjiZmYpq38w
	==
X-Received: by 2002:a17:902:e787:b0:29e:9407:a8cb with SMTP id d9443c01a7336-2ad74548a87mr158181025ad.40.1772039309785;
        Wed, 25 Feb 2026 09:08:29 -0800 (PST)
X-Received: by 2002:a17:902:e787:b0:29e:9407:a8cb with SMTP id d9443c01a7336-2ad74548a87mr158180705ad.40.1772039309316;
        Wed, 25 Feb 2026 09:08:29 -0800 (PST)
Received: from [192.168.225.142] ([157.49.193.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm139143225ad.91.2026.02.25.09.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:08:28 -0800 (PST)
Message-ID: <80a9bcaf-4045-4600-ab9f-b6a5f6f6394b@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 22:38:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: fix memory leaks in beacon template
 setup
To: Zilin Guan <zilin@seu.edu.cn>, jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, baochen.qiang@oss.qualcomm.com,
        jianhao.xu@seu.edu.cn, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260130084451.110768-1-zilin@seu.edu.cn>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260130084451.110768-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2NCBTYWx0ZWRfXyZU8c36DB0OL
 WLcMY4+ROKPkfzshkLpMQM26qmzgLJ+8r1SCwmpqnmPMSRcsNYVTcnsHWF25eMCTAnJgWwfH5+H
 qAwpcggeFY1G5cC/zEveiamZlffngNg9Ym6RaYDFnoffbz6Nbn1VDPZj1XgU9h7169Tdsrfrk3R
 3DmU+5ZfOJm2A4CU4AXcsZKhn8+8ll3vNHhrtybL+prTUqSy7VwdO0x0kB+rxbHtOdIO9m8/0b6
 ELg/mBgW8B2FvD32ZZtY1XdCnrelbbQAeOANJyZlCKZaqslo5pqPnh7YtomhJRksej3sCyZlomP
 e2zFI5Y9KN42SzW7R6xXh4spi1YGz+ZWMN9BBT97ZtAIERXbtSDdhSnhsjOY2/6xkbRuYZ1yyQa
 iQy+QSyCXn69NL74r6HT64lmtC6ZDYVugqmPAekpnQ//ainf6TmQQ7L4EMZGT1WIj4K+TV8AwS3
 EUeamHvKTnq/jSRFMKQ==
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=699f2c8e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=hSb1S3R1191yeZY/11SCyA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=aTVLLDfeenT47zaNiYsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Ry5PTyshkGdcTiXHILygZx2sakjHwSBx
X-Proofpoint-ORIG-GUID: Ry5PTyshkGdcTiXHILygZx2sakjHwSBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32182-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE82619B444
X-Rspamd-Action: no action



On 1/30/2026 2:14 PM, Zilin Guan wrote:
> The functions ath11k_mac_setup_bcn_tmpl_ema() and
> ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
> but fail to free it when parameter setup returns an error.
> 
> Since beacon templates must be released during normal execution, they
> must also be released in the error handling paths to prevent memory
> leaks.
> 
> Fix this by using unified exit paths with proper cleanup in the respective
> error paths.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
> Fixes: 335a92765d30 ("wifi: ath11k: MBSSID beacon support")
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

