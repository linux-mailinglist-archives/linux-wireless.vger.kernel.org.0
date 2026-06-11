Return-Path: <linux-wireless+bounces-37668-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0EDoHNmlKmpduQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37668-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:11:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C11671B08
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:11:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BGtw19oG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=keNQ82Ib;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37668-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37668-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54C1B300E31E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA723E63B7;
	Thu, 11 Jun 2026 12:04:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB045233921
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:04:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179454; cv=none; b=tIi7+otu+SbCzUa/ZdESNuGsQlwGRRMgnQFXn9XplQuwhDkdq1WA8zVfFNYz62pKGq8rdxC32atxBKfw9tNH1FUzdqIaSUFXYKI5SJo+pCUr2TaP3QOB87WZzCbhV9lwMNujqnwom1istt9pM2K7aZMje1y0zonMBqecMPW10S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179454; c=relaxed/simple;
	bh=w+y1X+ZNiJg65rSDstMld5R8KxYOqoox95WB44xxs3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOAqfDnSWAQ+8dcHjCbiBC4jCc91aM7glIBxsDPuF0o1ge5YTDjnp/3IYiDXRsWkJemN8NbCUP6TvKEdxuQkeGIbqVwuvdqcWFViFwLDT4Hx4bTDuh5SjSg15NSV8yO6luMWq3SvGEhVoRuVFWwdNGonb8Ws0RYpQu4aVCc0iOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGtw19oG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=keNQ82Ib; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xLUR284246
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=; b=BGtw19oGKNB/HWnP
	yq/EmwUlaOsudKOSR02wTI4jjuMRQpJuFqB5jrtIyovdYrbVvtM0pNx23k1IaYuX
	D7vuzLzmjgiucyVEgcWOZB2OlDDpZVx+Rb9zA6+VN0NXCCotSgsH8DWQXYx8aNs8
	w6IpmV0jmKN2o8KuGoGxdPlqUODpQ48JzDvCKnvRz06q8WrAYtkm0E8HzToWUY56
	RwegB9KBvinRANH/I2WlEfrrHPK/PGTf5qmd09XNchyRB0HH8nk1bi5ig7enKoyb
	S1CMe4Pq6Lo3iFZqhKED/eI/pyE8NgVtSGRGEzm3CtjyXnShmG5dx3/wDnG7ribp
	B0QCpA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tka1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:04:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c6d4a825d5so324660137.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179450; x=1781784250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=;
        b=keNQ82IbYioI/w7JjixnBHIeW39mQUVQuniWrTxN28c/S+a3wOnCjijgACbNNh3xMc
         Ydu+Ke7DLyLnXIc+EksfGDsEM3qhI4+/pohH93jUSYyKPaVRv5gnJbSjscwiHtoZTc0c
         AN8RXY4JhzLVgaWhqLaiNTuWOANZPrMHv4TGmLo9ZlLHwjKzQAsDjoU8LepQ8NyB5A7N
         HsA+VqKjcEUNE5YfLqFgychHHiYLzY+C6Ct+5P/ALk7tTXLLTvnnX3kkXkjapTgN8vTd
         HV/m5utHuJ6zUQU39Tms7vMlXh7hmq+Z4uf000oNB0viw9OsVD54wzOog0MveyPgqQmR
         ysDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179450; x=1781784250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=;
        b=TtCF1D70BffdfrR9qCvDSAuAnIk0ooLfC4JzfGPgtvc6Hn9VTp5YjhcbxlqdOkE3/s
         MUtv6AVhxrAMTTt6eHFCkULymDjfoIaB2tcH45wLMUScxM+bn3EDN/zpmsPa+ycaTyrS
         gZTl+QbIsmm1jH58vFIQ0x02tASGIj09CEAV0tBoMko/DxhV7yYw3e3Up3z5kAB1Cig3
         f+dWGoY4H8gj1YthAp9uDA4lt0njIDN7w0EoVenmX7uha96UbuuLPHR68hjS/NuInLT5
         6GedAegIcwSVwGX+LwHMueG27lUqPCMZwchGT93ofbISfW2q4QMjYIOHt/w/ucgLsKn9
         Rosg==
X-Forwarded-Encrypted: i=1; AFNElJ+NxkKuAXCeC5cgCeSQsFzJ8uzbue/6WajB77cZog21u3cIhjU+LC7gim5F3SDUAX3D/mPBr4kNSKQSTADQ/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Xc6Fen3BP0uY83rm/N4VMCUibNwjs/V8vx6/I/Em2u71SNVz
	MNxYsRDn8IUmlKLHcSBn8JMOrSbeC+84kx8JnOaEd9PGVmPmGQfP6kBfmt4aVa3ESZnfj0fts8F
	5wAHz/PIdx0jT7JXpfAP1A8As991PAlhNgk5wikAOtABuDP/6s0WpDJCxUqm61r6IFho7hw==
X-Gm-Gg: Acq92OFVF8bOMHwP5grN+ODIrVXMCVdUT8TLuc/ZblpuHJqkWMt7TjAaxY01MQE3fZ1
	gyHrXWdbK6atljz2BAxNRixEW2an0+g5KwkHropoSdomMbS3kRV2uU7fffCI5xfTSo4SHEBUix/
	Lw++2Yk+v1o3g63+khb4BKm/H6H9q4h6nt62M7fv2/lTXybSk0gZdB6P+KFRWZb/cGsRvImNpzn
	RJNa6qeXfG9zPWnSgIH3RzQzitaFoQMYH/cv0QZgm6/FeKSYLwSc+hYMGx4vmBnJ2xv/cIsjwBi
	iHrchxhr6RqAYHkKrgqu/5lhPZ+Q0e5epCbYXdcPa+vQKdcPgDxeEkDqhjtvgcFnUszcnda8YSQ
	Hguuegv3Vq8H4DmHngBUSCX2cFfgujX68YtP5lKjG5e5R2+n6ApzqC62h
X-Received: by 2002:a05:6102:374c:b0:632:c8af:8a8c with SMTP id ada2fe7eead31-71d5948c72bmr230965137.2.1781179449904;
        Thu, 11 Jun 2026 05:04:09 -0700 (PDT)
X-Received: by 2002:a05:6102:374c:b0:632:c8af:8a8c with SMTP id ada2fe7eead31-71d5948c72bmr230784137.2.1781179446795;
        Thu, 11 Jun 2026 05:04:06 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65867e67sm10883829a12.21.2026.06.11.05.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:04:04 -0700 (PDT)
Message-ID: <34796b1c-7c82-46fc-87c9-6c0b9327e894@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX/y7qyoS0UbqH
 TQunaZktaF3eU5arJFT6i0+RSiX6aJuRP0kDaT6CVs5H2vRD/HsWIW1eNUtW74R/q4ckyQoJdQ3
 ZVp7Z/wrpPLBhkqH6kkzKcbEOCj8Uy0hAfSoZD96IpJRC4hNA2eoT15PZQ+XFNlZuJveAFxrNhg
 VC+wJbUw9dBFa16zfXVfowaVBSEhJrNb/GtxfW3QqYB/YLlvwIyAYRu353b2W6yg8ZoChvOKjYM
 fMCKmrk35oyNzyR1Ro9R+LrMAqt6OqE+ChNeiqPlkSdxTmRQ3WTeiqpe7870d9B0jGuljClu0ss
 PquHZ7R1/59ZfxAyQd6fK7vuDFmNeunyIXf6x6RTKfCbsPSs8kjagu121stc8X1dCBjyoNWpsJI
 X+IZhnSOZMdRrcJ7ShU08b7ppmuwCP9oPhRkpwS4CWDzdgXfpwXdxH9tPTHO2ifLDKUUMTVAqP6
 2HniYzVk4vVXm3XKX5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX8uetAOXYImRC
 KkApnkXRrgO/WR9d8XEWXBWbqfFvMDgU0w2W7ZnOjWa3HVNrRL1i7jlr48nY9DRvD/qO0hCYyl7
 kDB7qYQOnwqUcJmfPypHkwC2UduLE00=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2aa43b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=IZRSYuELQJJGqPscr9cA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: UokT5WOeoWTN9UywsgGtkSbisXw71hos
X-Proofpoint-GUID: UokT5WOeoWTN9UywsgGtkSbisXw71hos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110121
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37668-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,google.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73C11671B08

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
> Bluetooth or other similar applications). Add all 4 pins to the default
> pinctrl entry for the UART.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

