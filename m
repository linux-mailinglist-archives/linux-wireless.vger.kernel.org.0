Return-Path: <linux-wireless+bounces-37259-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCmdGD+HHWrAbQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37259-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 15:21:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBCC61FF00
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3640303AFB6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9663A59A7;
	Mon,  1 Jun 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1/DQvDl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HFCo2aoK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614993A4F46
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319776; cv=none; b=jsCy/brnYpUNCD4OinMAVaNZz/2RVhE+Lr2LuqZ/wCxXgZFG4akMcFU1pLPK0scyoFdMnzWLRkIVT1MOycUEiWeNS0ZBNTbC4qa2K4xX/JWU+dI9FtWBhOJSvmvFjoYK/w25ETO4FlGuK3Rf1v60sIXvN2d4xEtKQAGZ9bKW9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319776; c=relaxed/simple;
	bh=0Vgsk9FE8PcHtzYc4FT1PEEvja3jf6WaLRhOuhSGGEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHwAFSz7gTz5jJ8EgbUcoUYlBirTHP9lf/MzYQ8nZUT4tFRva1BO5k7S5KZrJjcbZYU98rGtD65kQAiTZwYMfXJPZCGow1/m+sZ+upSXp9Wh//Kmz/3G2mX1PgXdN+IH6IWBDRpbTBaV5WBo4ziiPxG2sJRmSF5anEkonLtA3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G1/DQvDl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HFCo2aoK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651CbtTZ599781
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 13:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JEmjlgCDRIf/yZc6sCfPxlrwhqDhj3LtIw0r7cYtkgk=; b=G1/DQvDlzBawTqJE
	STsUb8yuGwn/aretIIz52SxVuKYKK8gb6j6gnUtqde7VX0G5c0j6FpzGFdAI/mB7
	KAhF54ndq/yeh9jGBY4lkP3rOPlg9jOgI38a/8R1EabDEUmMmZHaVYuRbd/ggZPh
	fyjkAJPurdsq1Y+L81wkXesi+ig1W5uasf8Vka2a26MK1FhYDfEBMxUngyxnCKpK
	LBMerQUruZPDEO/zNZj9vBrnd7dy4ikhrhDWJpDsyu6AK7MyrFUwcOBtQ9Ba4a/T
	NPF0ZZSATH5U1esGQ8QDBjvKUUNg0BU7b+nJHyu0u8Nxz1CwF4TNMzNuO0S9iBNW
	yQ5Zng==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eha8r84j7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 13:16:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85a2c0b56fso1469848a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780319773; x=1780924573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEmjlgCDRIf/yZc6sCfPxlrwhqDhj3LtIw0r7cYtkgk=;
        b=HFCo2aoKHh2/b/CDTmERSfo8pZ9VRjjfpWJdteqjDycV2lW2hUYMNvxu+KGe8eb551
         wdNsa0oSqGPTw+E9piXK7IqiKKpK7/XouFyVXhbOm/r+GO8+0O0rV/d+BpB4iztHiHQd
         RLSXG1nQUnyZZ/7E7d/rHzK2HWcc0wuMH4KU06JWpKiLFtLWsoflsBoYu/FeS/MKh83Z
         l1deJenDlDPVVXwaD+nsj62nMqD6ZhhA3uib4uihgYV5o84wkvOouJtXSVDDKCC7CcXA
         7DLbqPTfeN9DG95KtnUwW19EjiiUfjq7P2pY+F+w1ybXxzBnX1lLusFCPCMQWfjimsw4
         BDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780319773; x=1780924573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEmjlgCDRIf/yZc6sCfPxlrwhqDhj3LtIw0r7cYtkgk=;
        b=FuyhJ0uhJJB5BIUXh3vTwKNSgZWxmIiWgySjjr68vZxtIioifQua7/AIzPjRhlbNt1
         s1R712fBBkrXlo5FMunY9P/M9SMjrEm/DPRlIMqGmXisNokbCk271i6yNQO1GOdyari8
         B0Pg7CwzlcAwxo56r+HcPurwPdqwlIsj/jcUbfja3gBN+A0OANhRRNbq21Q2S935h6ce
         ht3KGwyW60ea4oc/pK0ifV5s9n0inR1yuKyVen1a/pobA/LfIV4szXnfMjZKVa5j9CHZ
         QJyWa5zKmmkoe//IoqoeomSO8Y+/d452sr8dVaZ7NetNJJU8INTLK3UGTfL0YyDgQYcX
         jMyg==
X-Forwarded-Encrypted: i=1; AFNElJ9hKim3RZI4G8o9eXFhjHqwpngxXKBEkvFA4Cybdj0j4o9QBExaaCOfsG45R6srajVCECryq7T+x9cPANK4wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJewBNnKATXCDzTEVbuGhUtwJ8tJawR48vEsCKXMR5vnWY6aut
	+IvyvEDC0+xT8pwbnulUZTnF54VdNhpr96VstAyKcYqCDR4QLijke461UktepfIBmYkdbQdT16F
	hr96vnS3QRW/jJYiooul0tcwju0KHfX7fongjSA7admXe7y7yxBn/1qoRX2a+aC9LshUKsg==
X-Gm-Gg: Acq92OHuD+2OxPjLGHdkYYyPsdY85SaZcEZbxovPjEvFOQpQIooBwYrul+BPWN33S0L
	uKRe372MY/eAVzioy8FGXJ26//s5ZXTqUSke3mLnlCtBtTi2ed7A4W58uiFcs9zI/vkHwodS1ul
	0wuwV6bc8P/8ZNgwodZSvAe8EoL4f0HcOtaE5h1ovgpXNTimxCA61f3Cr/Hor2uAk9iISPKybn9
	CEmZvNzvuRJ0MXzKmPtNYn970yCCVte4T+P5S0qVOmtYnvm62dkkDddQCY/+6qv4nh4+DARrQzx
	khIPqe5/uaIuVD+AFec1zQUSX3mTVXo+vbLdwkP9/e6mkeVCZm7c897jEzZS2kdusr0lkXIoBVC
	TopiqIw/voMY7TzAcYWYUmG0CeTrjBrulkvqfwPoSU+/7K1ef0cDa1kYofVcA0FPdEWsPzgSAAW
	JT
X-Received: by 2002:a05:6a20:4303:b0:3b3:223f:d3fc with SMTP id adf61e73a8af0-3b42826287dmr11259986637.45.1780319772935;
        Mon, 01 Jun 2026 06:16:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:4303:b0:3b3:223f:d3fc with SMTP id adf61e73a8af0-3b42826287dmr11259951637.45.1780319772537;
        Mon, 01 Jun 2026 06:16:12 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8591b76862sm6464766a12.3.2026.06.01.06.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:16:11 -0700 (PDT)
Message-ID: <271bd9ed-bc77-4910-81d9-7f1f1f077def@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 18:46:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath11k: dp rx sanity checks for
 invalid length in error paths
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aKnAb79m c=1 sm=1 tr=0 ts=6a1d861e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IFtaPKmWozPZQlw0T4YA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Bx5idv3r-X4RY61U32TeyOtEAEB90urO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzMSBTYWx0ZWRfX8Vp417+Gj0jh
 V1GqTN3eOLyNQdTsxOEWPHjcDgvMjRYR+MifpAX0Wgero+1VUc7Y37ouogpLZAvPjfhzl2EuL+F
 MJm6f4oyhqjOITOBrDwYeR5n/F1+9Vhn275UPU7VcOuEG3GwRHkX5wHxhgRBVtwP992WAGjGcXL
 rUzxebK9HefHv5ZsCh2aOLcgGAvUlegfRFYxSEpAkLTMD+ZX8bW/WdFTW7HHkOo/etm/oQ6sawk
 LZnOjz/pD4U1NZ9mKOfWKqpYp+uEKVmwGtHaSso5aQi0PFmAryRpxUcP1LwnVGg1R2aKnK9CHcc
 +6h68Yj5NonaqJUGUJfOiiVb4sID5K8KfViOhh/Eh1ABtVcXZ793rRw0uBVauwDBOBmLEOAI0zV
 XPMRSlG8jUxYT7/CdahashZAvbaCcN671Y+2MK3TVUkFI2JDCTQffrbNmHNbBLhkS73DTQOZlhj
 CsvIV0ZD8s8zNcXUj5w==
X-Proofpoint-ORIG-GUID: Bx5idv3r-X4RY61U32TeyOtEAEB90urO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010131
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37259-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CEBCC61FF00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/12/2026 7:53 AM, Miaoqing Pan wrote:
> This patch series adds two defensive sanity checks in ath11k DP RX
> handling to prevent invalid memory access when hardware/descriptor
> contents are unexpected, especially in WBM error scenarios.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
> Miaoqing Pan (2):
>    wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
>    wifi: ath11k: add MSDU length validation for TKIP MIC error
> 
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 59 +++++++++++++++++++++++--
>   1 file changed, 56 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

