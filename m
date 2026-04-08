Return-Path: <linux-wireless+bounces-34529-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO5FF5OQ1mmiGQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34529-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 19:29:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F39043BF919
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C268304C8A4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04563351C04;
	Wed,  8 Apr 2026 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J50gLstg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edoI2wgt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3313D75D3
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669233; cv=none; b=smqv9h+NqiAFy3oHLtv0djfYQoFMJsYLsn+V42YN2twLJQvdZFMaifbD5aclsNbxhTieJybuv4yTvO5d9EFmV30O0SB6FkpGSK7qRVmLT4E7EaLPT0B+jYhORkxh7CMuDy7O9Ok+U7Al8BgpMrJ61Xkxl3DooaUNSSrSFyieTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669233; c=relaxed/simple;
	bh=YYbZBe0rumsW2vmNVvL6jqeAqaup3akyXA1RKKo5dcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mdozg/8PU32fFaSy5YTgfoWFxsL9PGJ1qCe26D8cMZkI+bzkqK4MFCMJeRJDfEq6WCRkl0dw2nBs6Z8N+ef+nbPQcVSnuRt/qu1u8v/qk197G1MnK6Azonc+0tIxCl+R2ShDVy8iUMUYRk0sY1EiHsk/Nv7hjLav8c770O04mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J50gLstg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=edoI2wgt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638FrBQG1922417
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 17:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRHdJEFAz4Y2PwD53tIsM2jKn4k+iGIR20zLlJkpvAw=; b=J50gLstgP0fA/ciJ
	ewIGPNAE8wZOH1nGkgIZ4B9IGehpZoH4YqJO5/U/XeiPzqcWbER29r+PdzpciDLR
	S9ucj11HgcuRduSbzAvDP6MZQHFsu1LARrkcH2hG1CFqeF69SVYAuBdiGRrH66w7
	ogpojaBeYo8B9QLnjV5hva9EfpHNoCmrQVUyp2OUPsfy3jAuUIZWKqCGHPiCaoWb
	NX4CLvlvxY49StRSydOeZp7ANA6dlnrCJu6xp52Y/ki6BlZEf6YtxhuMzH9cYkXW
	KdpgFEIS8NcgAVGtOPR/WqGW5lo6fwpiBfW8gufQWemyZfmyXRgxpCOOAkk4hwi4
	Cb/2IA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt28rbgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 17:27:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso241152a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775669230; x=1776274030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRHdJEFAz4Y2PwD53tIsM2jKn4k+iGIR20zLlJkpvAw=;
        b=edoI2wgtZfRQDW4PKanIq20lhY2lfrSXRhtZE/BK5UathWtqI8gmhXxNZd/15rPj7H
         1eeu3J4EM59rOmXhCLLs1bzFcNv59ROZstzjYL9kQ9q3BacWPINwOmLViGY0VctWEBVT
         xcU3aRHE0eAqYL+iH9fn2kKI78HTLWuK0QbyCMCfu6jrJ10yRlzHrv7joc4S7M1SI+5G
         +jYLU0VunXOpDBYRZIqq5puY4pE07MlnF334dqFhM3yGamEa/82XQrTiirGkVYP21M+y
         Ig2LC38bDEo2RWOUAB8IsblHpCQqTv7ivthrDyctSrjN4TgO3e+s4ixlPXS3de/uIbzX
         jpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669230; x=1776274030;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRHdJEFAz4Y2PwD53tIsM2jKn4k+iGIR20zLlJkpvAw=;
        b=e7cQEEBCsHKd/Nd4mZekq22xLpBT2+BbIwVYGFdeLDE/RpegN9K+2T4XvaMvw0q8c6
         mC+BtfWe6jH7LfqzxgR3Ak6n8ubOGBoN/8ZAS7omWdDnxmhVJEPYDUiehRNk9q5m/EII
         BtuHIZRzqtJazmjm/vGdxldwp1TF68pr5XkYNec9RrsP5BdvXDtseLVNDtJRB59U0/MI
         SieUsP/QUOIJmXdtwjOP+orYwMzrZsRekNm9PwopebP29QFe/yXzDN25Ui3DLe899Rya
         87Jx+RnLt8TdgeWj3Xe5ABawKLJsawBbB34xgVbnn7xze6vC4bvaztHo9/FtWSItoUMN
         MkVw==
X-Forwarded-Encrypted: i=1; AJvYcCUgBqaZHi43S+XyS5MdUUCm9yFL22jOj9bZJPwne5oDPZM2bIM9F7M8/TZFiYIIIIEszXI6vAxvTPYgui01yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwiXozmiKIgUjiDevqPMeKpLAkR+RKX+nbLeWzsuTvRTlB1Nw
	Zmc/NQdJjpajQursXsuUwQ6bplLuJ30NHeppl85ecphy6/fDn7iah/18EbYHIVRBes4pH/lkVzq
	IvWNBnncBD0pGZmFLGtfGtvJumFSEAY/S/Ki7qnu4CS1x7HgVmoK5uEBuIlixpTcUbXN1WA==
X-Gm-Gg: AeBDietv5deX/FwXnevv7yNY6xAazVzptxbUq/0q8BKIhVV8r4U9ANkD7tmyVesyd94
	n42GsYuomdwv6J7HDTue17sXNJ1qNzQIXTNZkZT43RvX05tVpCXfBw743wCCcvWAY2/nO1gg0l8
	0jZc6zRKl4M2EqqzpQGwoSgxb6OBoYV1L2xv+x4uBlUC7+TVIntm+mkmoadhNIKVJahJjgoeRhZ
	oiJwBivy9Sh1TkYUXCy1qvAB3deEL9zxSHgshf009VxmDGEHF0e7ycHF4v8nxhLlUeKhu9ffbcj
	89mxgzyIQNfOCIXmWAES7tnFemBHYwmVEpgoM1Mt//2VlpQjVnGdoSE+R1Gql1l3gKQLddIZuYs
	CW05WivlZaw07pKwRtRqPD9Ppo+ftmcP/hjmFC6+TBz3veHZw4ip2z0Fep2s4eXapVVi/kwGiIm
	tfirevjw==
X-Received: by 2002:a05:7022:ea28:b0:128:d4db:4478 with SMTP id a92af1059eb24-12c28c2437emr155897c88.24.1775669229598;
        Wed, 08 Apr 2026 10:27:09 -0700 (PDT)
X-Received: by 2002:a05:7022:ea28:b0:128:d4db:4478 with SMTP id a92af1059eb24-12c28c2437emr155884c88.24.1775669228903;
        Wed, 08 Apr 2026 10:27:08 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d3a941b6bdsm1705140eec.24.2026.04.08.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 10:27:08 -0700 (PDT)
Message-ID: <d822487c-519a-4028-bfb8-47a778d26b8a@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 10:27:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>,
        David Heidelberg <david@ixit.cz>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <177566850912.1322920.17816533595535960130.b4-ty@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <177566850912.1322920.17816533595535960130.b4-ty@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q5hieZ6DfOBZMGF4bx3ZAZ0tdBGIS9xj
X-Authority-Analysis: v=2.4 cv=fIIJG5ae c=1 sm=1 tr=0 ts=69d68fee cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=K_8wqBj_W9ihw6XZuEMA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MiBTYWx0ZWRfX/Fa02p/7PRVu
 EHv4KZsk1CNEPR2a6oU/c8NBQQG6r1rthOJF4iqVX1dv6/neEGdB3JDwSotCDlQ3koDPrwjXfB8
 w4blSTJA8IIV2GhybZLx7KjcZal1/BdGTRjDP45lDG+ZNP2kb0mz8hN96BIQpxpaUfi0WGTvfcJ
 z6DrAORB9hELyeeuWx5jpgekwOuyXSa40UWEKUEVahR5WhEageeDC17tNqYzRkqA/ydac2bFgQn
 6/1A8EFVrauGDkZFy+vZbNn12n+tdLb3c/J5mX30MxBU6+0OvRUxj8dpNZmyKE+XdNvMle3JfcR
 HFetNUwGR75CgWT2i2cmZCBR7WvLZih0Q3+ap+0xrPJ87y3bDT3Eg8kkBBPKiD6pvOMCOyZ6IpC
 8zTD3Lw4PqYHeKTW0n78lMNXbXFq+AMRPo+kz0yL0C4ACSaBPu+uKo2ERCwbqLVIvDRbo4G46iX
 IRzoCgYOVA0Zz0+qMOg==
X-Proofpoint-GUID: Q5hieZ6DfOBZMGF4bx3ZAZ0tdBGIS9xj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080162
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34529-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F39043BF919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/2026 10:15 AM, Jeff Johnson wrote:
> 
> On Wed, 25 Mar 2026 18:57:14 +0100, David Heidelberg wrote:
>> This quirk is used so far used on:
>>  - LG G7 ThinQ
>>  - Xiaomi Poco F1
>>
>> I'm resending it after ~ 4 years since initial send due to Snapdragon
>> 845 being one of best supported platform for mobile phones running
>> Linux, so it would be shame to not have shiny support.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
>       commit: 3d7640b6c371a1795e6d9580695d20caf16be9a4
> [2/3] ath10k: Add device-tree quirk to skip host cap QMI requests
>       (no commit info)
> [3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk
>       (no commit info)
> 
> Best regards,

Sigh, I did NOT take v4 of this series.
I did take the 1-2/3 subset of v5.

Note the self: actually look at the output from 'b4 ty --dry-run' before
removing the --dry-run

/jeff




