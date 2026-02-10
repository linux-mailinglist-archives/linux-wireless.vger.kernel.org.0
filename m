Return-Path: <linux-wireless+bounces-31683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBC6DqqkimmhMgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:23:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA9116B86
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62C173009092
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524DE2D97B4;
	Tue, 10 Feb 2026 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4F17Vcw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cN4uuBp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F427A904
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693799; cv=none; b=VVISwstCvpReMdvgMA40jzOMdLgO3HNY2eNmnJxG+h/3+Uj83lsaFJwXXzwfttTtfIRRQgD+qUZo3mvAfqPEst2NaDg5Nd/wbz+/Fo/qngZQS0xC8Iatg/U3WV47ieonh537T24btTR88khLEnFodd1qqzt1zyx1acSOluj82pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693799; c=relaxed/simple;
	bh=h+5QwpCvZmBTBYF9Kan34DfsonOrpEfM3jZ0v5a5EEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJMFhhh3rawVK+v5UNepi0LeqOnr4TAQYsxahKvu4aDVAj7OpH7RiP7di2cH5KflkLubpmRjdwp31jX3IB9hQaZ44Dq1rZUPyFhN+YfAbOK+AxSu6xMFv2tIr8znvnB/XiBh/0EZhG096D8yHp1Wn/cPZ/PL0zz9jYyNh5vSSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4F17Vcw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cN4uuBp6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619MUbJo857095
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sas1ZJd0Kb7E7fpR6SS6u+XiXBW4YnNy2/f4A7c01O8=; b=A4F17Vcwp4alj6/Z
	qDcz0EgakZmzbs9B5gtwkmXWH0rQOi2mULhDWoUwCgK45g/23l45Q644f+6FDXIk
	Wiu5zbp+y1BYJ9+fdZmI6MZJsGVGh+/3fL6GSFGVBm7xfHPkx4tZQwsTW+WLOO9o
	wj8r9bCRk0Z8o6CPKBSCaGikoi/mTFLkNu9Bz/yFTf/TJizGYrLHj1wFm+1D8UX9
	GN8MP2o2azYPsLL8P212DKBU0XLfSMx6+PVedjMLnLJ3WYOVlq/0QnhvCGsLHt9s
	oFFQm1P+mCFlvr+oHrjx3KIINAd9w1bxvAO64FrrCFNEpzLtOfczCXQ4OQS/XW4k
	2oqdxw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga62hvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:23:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8243a081fd2so2287963b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 19:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770693796; x=1771298596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sas1ZJd0Kb7E7fpR6SS6u+XiXBW4YnNy2/f4A7c01O8=;
        b=cN4uuBp6lXLkFvYX39TJlzzclFWwfqzUxKrkyNot6MvQ46FozHD/+ttG5KHSab/cdc
         yclKo6JE/LY5BipF7o6i5ywNSUdSBS/kzLm5Ff9X7m1CdV8RcR6BDFUoY3dw1gDL37CJ
         PVmejhifHwT4yO9A2r1lA4feV/3uFCsDe9bnnvQgD8zuW6oy4xECkUoLS1UXQuOY8t4i
         5kZmiZKiaLyTb8i42VE+4uFppVWMYgEhfR6HM8nfLiAye65IONKfbjp7psdYCkpTcJlE
         NwJ/JUKCDip1/48NJlwLdBxdAGsmwXgaBt6Kg2lDtiUdk8l6VuI7d8rM7moLTyxEerS6
         1bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770693796; x=1771298596;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sas1ZJd0Kb7E7fpR6SS6u+XiXBW4YnNy2/f4A7c01O8=;
        b=bLLqvgeS7cTgXaqvXFrMiSYPdoMeDn2WT4/bmViFsoAAGXU3uLC8UKSyOTLCmiDbND
         oRj8hXgFE9uVH9wyqrlspLslhBIudm441ixTaWKMXj01HyWRThS/BNuAbEFcjDOZ42CI
         isBsyVhwtiBeKeE2o5YKlhBzbxYcnkoRxxCuNpwuMob6fLEzilsUBT+HlOhMDMq7QOyk
         43lueSWukM4/e6wQ/LrLMY+oycxVHhSa4g4L+PQNx01boHC07cyy61ltdwX0Ct6SdoRK
         xvFhWJz/NABUgBV3l2WbHlgOtsDqBt5IaYpdX3zTdtBMS8dkxqznDinsCkx37yOpK1GW
         F5Sw==
X-Gm-Message-State: AOJu0Yw45L+iBR6ZH2AlTndUkfFtV42ZpbGMtC3lZH7NwQr651yOd2A5
	60H0cieIVtTV3tLRtzOx+8mrjlzHnh5dwrb0Lb7gvFafnsax4fb4h0jIdEo7E/24mF3HRwq/JPT
	+iJUuRnltT12R6skJCox/kO4ffSaYkdJUl/VPY5JD9nqS71jm5KzFQhQZdki9n9la7I7Tfg==
X-Gm-Gg: AZuq6aKLNWKyorA8BIzw08XglPMaI67PX8QYJxa9Xxg3Mt0Tx4xLWUNKta0B8vvx0Ff
	HzuRzsjcOQ5+f8PdEDnet6g3/KnQEnk1tOodklnZvCexsBdyJZUlWKy/AoBe8Feoj6GLgwdMyZF
	CGmwMkE3ba4ddHgezqJE1mp/QR6PhwjqnR7qry7kRXUoKsJW+O30PcERiJqNSs8m3V57aMZXecA
	rqvXq2OZdOUjru8iba2/jodaZ2I6T4NTJXrmafLeIfCbE96ifIit/KlJPKjh5v4EogEZ1g5Rked
	D3mcAZdMSc6O7oRvznGmC6vdU7TBZQS7oIxLsusBFDvjEzeqyiY3+IbYqFEDL3wGMQqocmV6DkD
	+9PFSJ6VnuL/5hEsywe/qZiYBklqtJeELZwfktFd9P2mNtZHT2GZVrH0/cgiCugyy76gPab4PdG
	nN9MsoyYg3zXH9Ie51bg==
X-Received: by 2002:a05:6a00:b8a:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-8244170cf92mr11945070b3a.46.1770693796362;
        Mon, 09 Feb 2026 19:23:16 -0800 (PST)
X-Received: by 2002:a05:6a00:b8a:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-8244170cf92mr11945052b3a.46.1770693795875;
        Mon, 09 Feb 2026 19:23:15 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b7cc3sm11804819b3a.51.2026.02.09.19.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 19:23:15 -0800 (PST)
Message-ID: <5823c5ce-274f-4c0c-b072-93bf418c02a9@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 11:23:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix incorrect channel survey
 index
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260210024440.3422264-1-yingying.tang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260210024440.3422264-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -aGcl4C4s-zoUlDKsCHb_5Ep0BS4pvFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAyNiBTYWx0ZWRfX4hpqYZMud5dk
 g1tra8NXbuFM2TmzjLMX7rbjQ2ow8vRZ92ssoqLWycIIECspBC8TDShNnNXUekUx2UyQJstURmm
 B4kudZtrS0VlkjXEdcTACJAsLTxzf4oAeGlQbpeE3aTqVkeDxL4sflpubqQ+H0yzrxs3+3yqRPR
 zlDYUIYLLWFyUJWxqjd/9jwdtJS6dmxKMcJtOA6mYZsBoPsYF3/wkjEkvfT8lswt01Jm7/Ccgb8
 I2cMzFziH/9U8YCZ+vyEipwb9ESrejPB/PAtW/ncRw6e2DpeFeri3AgF1x7cVcY+ZFKBYNx/QBT
 8K3DoiS+3RDRThmAivDrdpkreRESR/jHuks6Vj1QW6NM6sbhCJBp9O8O7e5QDMxrg6RfGSZBrpI
 xpkgArovYMzis84Slk4Au317FJRY0z4S/XaREQ283FlhYlAf2XO/X6JR5qqZc+s8PxAp7Ewpcyq
 6bgzxPMACyjsB8xBgPQ==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698aa4a5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=_VGBLm3PVvvAHgW-t2sA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: -aGcl4C4s-zoUlDKsCHb_5Ep0BS4pvFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31683-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: C3AA9116B86
X-Rspamd-Action: no action



On 2/10/2026 10:44 AM, Yingying Tang wrote:
> A wrong channel survey index was introduced in
> ath12k_mac_op_get_survey by [1], which can cause ACS to fail.
> 
> The index is decremented before being used, resulting in an
> incorrect value when accessing the channel survey data.
> 
> Fix the index handling to ensure the correct survey entry is
> used and avoid ACS failures.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single wiphy") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
> 
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index e0e49f782bf8..86ce7d87b5a5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -13086,6 +13086,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	struct ath12k *ar;
>  	struct ieee80211_supported_band *sband;
>  	struct survey_info *ar_survey;
> +	int orig_idx = idx;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> @@ -13120,7 +13121,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  		return -ENOENT;
>  	}
>  
> -	ar_survey = &ar->survey[idx];
> +	ar_survey = &ar->survey[orig_idx];
>  
>  	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

>  


