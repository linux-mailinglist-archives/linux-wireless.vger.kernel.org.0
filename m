Return-Path: <linux-wireless+bounces-38052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0uPHFamO2pKawgAu9opvQ
	(envelope-from <linux-wireless+bounces-38052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 11:41:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB36BD03D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 11:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DoPqQleB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Wt1+jdp6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38052-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38052-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3BE0300D6AC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759503A6F16;
	Wed, 24 Jun 2026 09:41:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1F3AFB01
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:41:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294090; cv=none; b=lT+EhWUW7tP4B+/NWuQa7KPIehR3LZ0XXfQkxXbuQj26o/bGWV38MvzGLVrjVfyckm/FR2xEk1Z8LIKBo5DgRRdtmKxMq44wVeamU3L4xZh6KbZr0WN6sIEJeVYCvkWn/Ga3P0EJB4rKo0vaMSs6SydGBshjTAcgudH/hDk+5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294090; c=relaxed/simple;
	bh=BBchgOzynC27KqtpqFWyN1B7/n+ZIc+au/DpAixncjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aklRz2wrS+fOuUwJwwDj7hchBr4NNPHfoBJnnR/MKfwkM7pEIbX7RcLYaSBb7CtNDrVLO8P/K5lN+1qgl+5J/g2MVXycnptpp29P3lFUL16JqqpohqvYHujdBNl4VwX+vP6vxQRTb7XfjhyqboJTAzCbabZnOcKKyuUb1gVbsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DoPqQleB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wt1+jdp6; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5u5Fi1889412
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ViLcShsroT81kRk6zGqQSPcM9M8p8/P9J72RygnYvA=; b=DoPqQleBrhJPBycp
	/lMT2ereUQ+4zg9B76zLHJ43Ux094daLkakd8SD+9tHpHcMWbnv9s5B5f/GynYI1
	TfbQ+D2W6LM2VQsxvECHYh3/vtvu/xm1RvzOjWP2mX3c+ykM5HtOFtqIsdzdeQ3w
	mORKuqlx3oQuOKvmC/mOLLNtfKixC3kytTyP18KKeptUIHjk5FJ98s2rDVCuzKZr
	STGs8hhjuXmdFjdzxbLLyhKYUI8/wYkGOTo6swezhqnxomqEG5lAUJ3LmaCImPEb
	+0lzfO7VSSw5FD+UFC2oe4F1sgS6ElKIHlBdOYELWjyI0WQ1wYSz1ph592wPSAeQ
	uATzUQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eysv3mcxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:41:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so747464a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782294081; x=1782898881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ViLcShsroT81kRk6zGqQSPcM9M8p8/P9J72RygnYvA=;
        b=Wt1+jdp6rCwsryi289C447KbcaNh0QBpfYqA8jxjCQd+z2Mznz5mwcvVXxDIBpDrIE
         gXVZQDlhZtkwKjT5UfIIyU2hPrNGyssBPS9pQsj+QPTS2ffbYvscjNnpJHXwyi1Hue1s
         TFhRw6EyTRlz3ReVB9gELI2G1lWYj0L0Suai+257EfkZGVKJwdZQdkNrUL2xdoJ9ZZcg
         06Lf4+BMLyIBFP4C9fElWtg4m6ZKd1SVF338JQL6Ehqmnv2/ovJ3rgeL7QyMN1CGKe17
         370XrSkOr9dX5w7emKv4ZC7JeIqnrwqtRA28y6WfqH8BKN6a+2cpx0SILr6HzOQrBQIQ
         LXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294081; x=1782898881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ViLcShsroT81kRk6zGqQSPcM9M8p8/P9J72RygnYvA=;
        b=LGTm869qxhsrNXnB2OmaYz9owni0zOLHjCupMTPocATbSaBy5Ej6o7eQ+9jQ2t3HS0
         aFNVv+GQx+KUWnh/O9q4Nj2rFefFilnMWxcF6ROkB+Qr5978lY2rtRD1CzZEu9R+cpLG
         JM1hY7c+9eGvvgQOFEeuEQ0fJE9t6fDrh2OmbPjim+Gye/Kn7VKsg5rN63vI/TCud1q/
         cyxf3lFEQtdLGNvnd+3NDYy8fehYwZPAzr7AK8rlb2oiLHZfg1lL9ONiiI65STg6WnPo
         qL/YFDbB/Tt+ZDBGqILgXsNy2Ly0kq/dM4PcB7zE7Tzrfkxii8FP/qsPKy3unct+ucpq
         IdQQ==
X-Gm-Message-State: AOJu0Yymk/rajYGIVmIfPfvI/rXqUi3TOZlHCRe9d+a8n70SlItujg8g
	i1KhZI6fHXzz6J7FeoW0mIgYE+RPaIYXSr3pS8bX2+ML7zw5n1LJAcfJv+xKBi1cpzJoKjID9z0
	lRJZX3zgPfZt/LZr3mNTvHbpNQm0ork8RnH1LvfhfN1uPSRpaQLe8ryrlLJBkI+9dTVhbpM1Nat
	sPlw==
X-Gm-Gg: AfdE7cnN+WfE9W82sM+ckeUojP4DUWbxNc/5ifVFE00H/V3i9LhmlzUSQXjWd22tkgP
	nvx7jsoqrX9BxnFYjDxnz68x2/k3Fy02cSeEADkWDfdYP3MLcDhXDPCWeMrIprcEuHyO2dITMCt
	UxbtKhFZaRTpIlc092v2XksHEymH+FzNrxGgpjZH2Xwl62yCSeP4mCMzZfX945q6SqB0I/Zvszr
	ChDwvDmT3bdHIRrfwshGfH8Im131LnEl5QaWOHJJkwubW4ejLEgWu1Oa1iq3DglNU5Kctbd4Kv1
	Wf/kAAP014BKaRxpojVJBAOhJCEZ2OLk2w3VQV3nYMWm6nKMe6vV9i6AFy3P4tGpcCc5QM5axPm
	rcEzdYcr+0VNpEY0h51G/t5GXb1kIU1M7BGo+IpFgNzyLHwZiXvekAp+5IBpAkunVKxr+Ankokt
	Un/alqnbf+
X-Received: by 2002:a05:6a00:3694:b0:845:399d:96a0 with SMTP id d2e1a72fcca58-845a2ca4dafmr3316576b3a.43.1782294081099;
        Wed, 24 Jun 2026 02:41:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:3694:b0:845:399d:96a0 with SMTP id d2e1a72fcca58-845a2ca4dafmr3316544b3a.43.1782294080698;
        Wed, 24 Jun 2026 02:41:20 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d22e8sm1662804b3a.33.2026.06.24.02.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 02:41:20 -0700 (PDT)
Message-ID: <0452aa73-5707-4a8a-8c27-c37b5bf6c282@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 17:41:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: remove unused QMI definitions
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260623035104.3765404-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623035104.3765404-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MCBTYWx0ZWRfX15hnwWGsA4UF
 IKYhE1fPG3mVbfoevkkUzx1xS4mVjCNxYGW4ae3LYXkOsyYnlu9G/1PO5FjTCLkiPBJByxPM57I
 uXf674zMo+iczVtRDsaUN3gL2HuPLCM=
X-Proofpoint-GUID: 3Rgqc7iug-QTNvDfdtind6NVkoDlXWmn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MCBTYWx0ZWRfX5xEPQBVFbBok
 xNC+xifEIgMVFifzlZ362YWGVOdwrclkcCwZiofc4CiltN4LkkzpWFLWh7XUMPXMCotuIX8ItDz
 Ot2NyNhxa3mBTuEo8zE2PeEkDvgFqhdaBDKcq0wFSQrKIwKLB6bw8i37E9KsqRBTQUjNUieGPQo
 xG5j0D0HV61e5ZXkuEY04nk7EgReQ0/fF4177506LaPfnF0dskRTZM2Y29IURzwW0RXjQHUW8Aq
 cm1k9TyG4SqxM8LWHatV5KTyS7566UgTTy54GcKnNfNTU/bTpmFlou/zixuHM32aZbgFHdbJ6c8
 iO+oOIQZkMimrhKsVe/5Db4ChrzFXWVgCaCrI3qbux+oxmQjcV+53JaTu06JzpZl4cvkYPJOkqa
 9v1yKFpLGrL19jKeI6HDx5Hyt+uhiQ==
X-Authority-Analysis: v=2.4 cv=WtAb99fv c=1 sm=1 tr=0 ts=6a3ba641 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=UbNLQpdtM3AkULRREDgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 3Rgqc7iug-QTNvDfdtind6NVkoDlXWmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38052-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
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
X-Rspamd-Queue-Id: DBBB36BD03D



On 6/23/2026 11:51 AM, Aaradhana Sahu wrote:
> The driver contains several unused QMI definitions such as response
> length macros, message IDs, firmware segment length definitions, and
> CALDB address size definitions.
> 
> Remove these unused definitions as they are not referenced anywhere in
> the driver.
> 
> No functional change intended.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

