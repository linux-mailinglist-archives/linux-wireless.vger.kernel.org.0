Return-Path: <linux-wireless+bounces-36683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNJSOGkgDWpptgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 04:46:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E0586EF4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 04:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED54B3046FC2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69A30E84E;
	Wed, 20 May 2026 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+KLXrFL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RX+0B65u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F31A9F97
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245073; cv=none; b=lF17ZinoCmUichEQj80tht03OTOTyRgSOEIZGAhaejfdv5y7eIo0KyfaCFFbwSTF1wkwnTQJYc9/8TXNkCey8MTRx3RaxdxtsPM58X8ixzdVfCHvzwbEvrZEk1Yv0VeZQvQvGdKhfZ5NpVlcpw4+NatgkSxSQdOjmIOv20amOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245073; c=relaxed/simple;
	bh=d4WSiSQ+zJRrb8ILEOxUbig72mTrPUWwa/0qrL3mxJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5vJBrQXhNM7S0i/iEZXRUj3aRnI90mp5eSSNY+a+SA5ycm4lLUL8/qjA5mnBLq6yJCxTCk+nNch+BOMYf/m7mBIQCNY/5vRuy1ma2HvDwl/ZcHwnixhFc0gvNQev5OCqQZjgTc6OvmPJBYv+QFAfjmnsj51wlPQUC/ZaR8EJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+KLXrFL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RX+0B65u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMKNVL1954028
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gO24hNW6jY+HDC4ZQoE4FY38gPRkws0t23Gy7B4dY1Q=; b=H+KLXrFLVPDZ/4S8
	k6IDuz9iFFWt82u2SM7lKhUG3z/0+ZBeVGA85c2poFrmA0iOF1jzg5yBmuT6r26O
	Ov3dg0kW2AhUYtUDeHYeO1Ev223PNsP7QMxfpqDmcJSeqbZU4OMu3n56jIYf+GLn
	ehk5zjdU0V15O78YcQJdIfAoLvrbcYI0RYk5Uh/PXwU51uWusDh0we9168kQqbYw
	vjYlehBYCk7QRkUiPS6KwIipc4pFCQFBLZD8BWNCUX8f4ovsEYUAGEzTPMHRBkPy
	HByZdqtUAoTvwFTxJ3xmUhF9U2cwaNE6H/u2BUKrjmjCOGocOQX8IWjJDDVuOw8C
	3ZdG/Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xtkbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:44:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-368b01f8adeso6111735a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779245071; x=1779849871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gO24hNW6jY+HDC4ZQoE4FY38gPRkws0t23Gy7B4dY1Q=;
        b=RX+0B65u9tFFg6398B7RAQfrBYaYjrJlm6iAsybMJK4IoLCZQrDWBCBQJC6TnttdL0
         OPG3MpvZoBNu3CMqF9MqWgvYaDKWuCS/eE+nyybn0FcYKmJ5QTCITAZlkJ/vJqIxbTjr
         uPfznzCHPueBS1Hmawqbr8Gh6Na41eLQ9GCX1LhWXDU6PQ97pmY3uBAI4s/GvzyCGqai
         TSXoUUTcHrp0s/pHTDAYSRK+Gk6Z8goPUqX4uwgpk0/TVW1uxZRbqLTTerakEacQmgRt
         SRkd6H8QlgPiATGUDnHjn0Rbuoj6ObJgn7+060ijcc0/9yZ+rj68vWEwKkIES83Q1+cz
         kIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779245071; x=1779849871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO24hNW6jY+HDC4ZQoE4FY38gPRkws0t23Gy7B4dY1Q=;
        b=rY6wDIs+SH1DbNYtofGLwJtwwUXJVpepT5faEaWSvEL5eeFpoOSP7wz24u2BDt65SW
         gLVClsl0z5EuJEdG1pmlIXJSSdrIHn98LGr5lCVWM+CukJ1LHjN5Z0UkSS+TzN2f2bD9
         MIzyt240gMlYXdcSQ701izP5xqGO+0U93PewvFHsk3lwRyxLFep3Q7ksyqAIQzsvusgS
         L0rj9+pjTjakqUXphVXnGHQlAvvOalthQOxx5ttvqA0ZFOngFlzNLH9TJMHQcHYbGPUm
         tRUhcZ324/bNdW5k5eEn98okRR+PrB/HctGlBGHTt2JIF6dGGwn0zggy4ICoTANDH7Ik
         yDHQ==
X-Gm-Message-State: AOJu0YzG9wqZ/YbVaUtQJ8aZJkycAF31HLW0sI658d2V7xJ/2omtSYiM
	eYPi1CmMm15SafeOeTUAGjI1Q3PkpooxVb2rkbBVM+CWGccvY8TQEWv8hB15jQHC0aQmo+fN+sK
	/3S6Xh1xnimaxd/53B7WOZQrhgx0jXzihNo6KComn0+QQ2GYERFKlBgKqjpSHWRDSiV+jhA==
X-Gm-Gg: Acq92OEBkzJkCXgD1miY1bTKfeo/GlmNZT7MrVK0nEIRyTL7yAfVpy2aa+jbT2fmirc
	IGiq3Ng4ZzOEk09r4r4XIPdZwTjbyeiTrT4HGJgSPvGvb9TsZkZCTx8+R32q25yoYR5zwe6dorr
	fsgd5lWl+Be+X9bJIWZV+sEtZYoMD5g727hoqizK04KZd0GKrhfBLyt9O7Knl0Ni3Tq3JrVRh5W
	u6rfQuQ5fZVacczoV9cfhkggL3oacQU4mqHGzIZkjCkVAqnJfR9UHET25QS36erBjOiWC+tkNsm
	iBkUqJZDqA173cdGqGJ6gcQxnwrxvpLmHPki+sjdb9ziZtPbDRyPICJu5GhohObGHuu2ngWZlj6
	pjit1gNMrq9Nq5EJNf9McQrlaUoMBnWc0lpYsigIalIrMDls8xZijvoOMO7fXHbsVq3z0vTaTkb
	qM
X-Received: by 2002:a17:90b:2fc4:b0:367:bf59:6f99 with SMTP id 98e67ed59e1d1-36951cb8825mr22338381a91.26.1779245070932;
        Tue, 19 May 2026 19:44:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2fc4:b0:367:bf59:6f99 with SMTP id 98e67ed59e1d1-36951cb8825mr22338353a91.26.1779245070430;
        Tue, 19 May 2026 19:44:30 -0700 (PDT)
Received: from [192.168.11.105] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157d963sm14945756a91.6.2026.05.19.19.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 19:44:30 -0700 (PDT)
Message-ID: <96f916ac-5725-48f1-a25e-cb34a51bc54b@oss.qualcomm.com>
Date: Wed, 20 May 2026 08:14:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix error unwind on arch_init()
 failure in PCI probe
To: Ripan Deuri <ripan.deuri@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0d200f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hhaimfcYFxIno_I0_EEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: mUF_RSbdt97xkii7lJ-0v0REMkIntu8-
X-Proofpoint-ORIG-GUID: mUF_RSbdt97xkii7lJ-0v0REMkIntu8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAyMiBTYWx0ZWRfX1tnv5t4useQi
 Av18voSRfnh6v+xP1X74Aw+W9jqcbiaexveZuJoTam/nbtrqikjnHVZ3YOtXWdPXwu9X8DZTJy9
 ZcFz8FfeFxHxmEzQCoWI5tsfbvTR2QkUdE+j42sUSYHTGhJdZ8NUU+Vg10idgW3dBaTVGrHmJg4
 cdTr6M4WORlqBq48ZPNHxsd6vfw1ZktQwKLMlwxjBE7EERFjyRePpLxt1QfRVjj+M+Y5FOBW2Y0
 GqEy/Zv3pSenSgWHwRAgpv32pNPlgNq1qI/+7CxZA0Bhs7mvNlhgs/ipTc04QSsUZcFHO+AyPIQ
 isbx0RNv21eTUkI5Uk9big1ISq116G0k9HA9ygxZWmpSrfEnfzEjzj6SM4xwAxVwVg6cwsMINb8
 IU1eiH/lpXLsVikydg6GLxOXbIUE73Vdp3rQZxTd+3D1VPPj7cgssTY7vB6BvNngonkPi70AyY3
 sNx4WWbrovtRyUdUzSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200022
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36683-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 493E0586EF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/2026 12:58 AM, Ripan Deuri wrote:
> From: Ripan Deuri <ripan.deuri@oss.qualcomm.com>
> 
> When arch_init() fails in ath12k_pci_probe(), the code jumps to
> err_pci_msi_free, leaking resources in teardown.
> 
> Redirect the failure path to err_free_irq so teardown matches the setup order.
> 
> Compile-tested only.
> 
> Fixes: 614c23e24ee8 ("wifi: ath12k: Support arch-specific DP device allocation")
> Signed-off-by: Ripan Deuri <ripan.deuri@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

