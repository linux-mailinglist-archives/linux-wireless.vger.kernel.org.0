Return-Path: <linux-wireless+bounces-30243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C319CEC57B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946833026AD7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11B29DB6C;
	Wed, 31 Dec 2025 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0aOkgdi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="boHBFXRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86C29D287
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201165; cv=none; b=B06ZaRIJW4SAozdnZJp0ZhXGYcXR/JK6VwTv0P1RSpXNf6Cyx9DGTQlKiqsb6WkFEu0iK4hcEYxbHlJfbtRAG0D67xHQnnMNA+ahYojXz2bV3u04sHjApN59fTrnCyjHNY7AOH8MbzHi8heFBg4hJupNnlG18Lwufp0X58ykhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201165; c=relaxed/simple;
	bh=9w0JUYZCMRP6cVFZrRzlRFu/FpISjq+8d/7iGhuCXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1rMUuVjDBRfRwiJdJTDB9OthYW9Fp4rEViex7/LaXs0IWIUQh2DV7A9J+tu+jaxt0/LsCeydFuMOHaqM229T6Di1X7QlM3aHauXhJKtG3z25Ne3cmlgCt/GwKBpmLnlu6a/isd41IHdQABG5kOhaZo9iHFQDg8m0wVOL52bTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0aOkgdi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=boHBFXRq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVCiKWw3607765
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IKTh23jrXofXXT0Slbp+Ytpw
	7vST+8Ljsbw/o3S95tU=; b=L0aOkgdiQKjso7SyBTq4kvMIAbSbVIP9T2qPp/sH
	RQpDkGDyySR/ljWanjJU4aEYBU2Nj+XP1Qv9c2GFnOdN/x0ssaXikLGhERcGWTER
	BPz8Fty8y8rscmAnWrwjbTdYTeyRRAtfj6p8/uU41r/LyqOqcuQ7o7ayXSYcD5+b
	J7A/hgmxgiIHInLx+1JLoF0SapllGp376Efga0toWZlMB+13zLnq25MQ1tWQ6UBg
	k7rK7WO59NYvpZ0yVT5f1Ato9KX6O6MqwtULDyCWzBpJvTIBCnj6TT4R+wFOIUVb
	/hMzkCnJILJdTEXed8zRzAtqW++F6H8PEg19KYmqAn+duw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd2bb0kgm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:12:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee09211413so291271841cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767201162; x=1767805962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKTh23jrXofXXT0Slbp+Ytpw7vST+8Ljsbw/o3S95tU=;
        b=boHBFXRqRdRmiqe1AyqSLqBU1OaaW55TpWxM5FbUYH9Q2X2W/CpJQiiNwZa6S/np1z
         pWByMg2xq9WAb4w6C2Iy8f18EJqV3WQ2cuLVUN7quAo4iRpNnux7Eo3QJViB30eUYmsc
         eWZ1yJHSYpUh9YDqOuKpg/7hNa1fpa89aS/LmYeEiSC1EUdhLjp6jstq0NaRbvFQhB7y
         FeAvh731pyqbGIw7sFYTS8ujMsbwelQTCDqZ7DvNE6XALzEyM6EjNq2GjQ46UnLLXJLH
         H2zp1/JtdxBpFSpkpKjJnaW/aOvjv6BeghmeGonjcGWCzg3yI6JBtjCEMTSmJooxJala
         2ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201162; x=1767805962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKTh23jrXofXXT0Slbp+Ytpw7vST+8Ljsbw/o3S95tU=;
        b=vhToLudNVoNeiN1ZXjUcM8AFbiviRKha1Af79Dc1uF6UhdzTBoRMVtbaL59QsTHhiv
         rXflUbFPV89p93FRFTOhgqed550EGg4aid/vc2BtA3mbM6DKYeX5XZ7izsKsVpnDQ0Xo
         HIEsLzJ4h+o6kUwCFoW4tQmIt+fuPmuv5rAFta9xPuZ5LR6DYsvW/EHB1zLnMus0oNoX
         pmPRTa1VOfaHuEn4enEj8O7dmHTh9LDOw6yYFZHpIdJtS241phe/T4d9hS7J3CGTp+CV
         T2BgI4OKzwi5bc5DqvbcYiBho76FNDB0sLyMQa+aAcVGkRIAAK68GioyJe7hxIuSSioP
         eJww==
X-Forwarded-Encrypted: i=1; AJvYcCWHLfiCXak4+sGPI+iKBVdW5TziCPy9BKbvo/O7NEi1Oi7+e/Sru31uSUgvGDGwBRpZLTtL+DH0Wsl1x6hTeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWpAae0Qbj8WJRuvKH8C0/vVOUG+EJxX1FaHdWzbKQ0SraOaTq
	Gkg8rQsIcxeYGZuE3S3nF3Y1wqm4tErehDIjYpZL4mezxn+SQULtbx2Yb2S4G2pnTAaOA+bDN5m
	vbPdxi2FcgFafEhGnpvHIBi5QNIAERcp2M5un7Z6WZ4UOjs5ZXG0TCM/E7BlardH2ud/uqw==
X-Gm-Gg: AY/fxX7QgS+8Lzeltko+lofGo1KIe7APQhCBj1IjbOvUZlsfjlrQG0nhlVRTuVFHtLP
	yV/CUOac7pZs2JP2yz2jpFvwPRANi4WFXiK+cQxDX4fn2695ButmxGRhsr6v3FevJytv1EL+IM7
	KIBIlusWn5NrNqNmGrWnsoG7WamvOJhLIEsYIalvuaAZ9GPTZGX72LX1c1c8boInJ56ZHzx/nZ1
	lg48dWe2R6YCgqROTfcijZ+nhiRFWW+HtD+naBwfsSR98XyqrPXcKB82MvmiHXfutJY23rveuIp
	qm5O6KDIdmxgR8cacrGaDTIdJNOBRWqPTrHQybdfwNp9koCCFQi02/OA5xHEqY5+meI09H68sCV
	PtVZpi12ypbvaTlGvt7madgEULHz2PTG+5ngTEU/Aqd1hCSiK1FrsFMce7rntRD+Dcu6/Tyx3Jr
	EVBnsn9XOB7iKw455DFqaaIEo=
X-Received: by 2002:a05:622a:1b89:b0:4b7:a680:2111 with SMTP id d75a77b69052e-4f4abcd07c2mr533470441cf.8.1767201161838;
        Wed, 31 Dec 2025 09:12:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFooM6E3T59ev8qt0Af3ld0+KnpikYOj66YFUfc6YqMoSrGQ5YeifZppFToljB8W/kglGPeNQ==
X-Received: by 2002:a05:622a:1b89:b0:4b7:a680:2111 with SMTP id d75a77b69052e-4f4abcd07c2mr533469851cf.8.1767201161301;
        Wed, 31 Dec 2025 09:12:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861ffffsm10965451e87.81.2025.12.31.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:12:39 -0800 (PST)
Date: Wed, 31 Dec 2025 19:12:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
Message-ID: <df7qz7oz5et7px3ghdfteuyiyistbrpei5tq62s6uwmzng4ols@gklfvzhbf7tm>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
 <59f3db15-77f1-42eb-97e1-31129fdf363d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f3db15-77f1-42eb-97e1-31129fdf363d@oss.qualcomm.com>
X-Proofpoint-GUID: 02kdejX0rkXK7r8OQfBuL5Rt4IIaNCFL
X-Proofpoint-ORIG-GUID: 02kdejX0rkXK7r8OQfBuL5Rt4IIaNCFL
X-Authority-Analysis: v=2.4 cv=dMKrWeZb c=1 sm=1 tr=0 ts=6955598a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uWyKjS0O6tEDB_qzV6sA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE1MSBTYWx0ZWRfX5FlUuwFY/cLp
 ZLdRnNoxUeHJV7v8D15dlejdrzvuVWEFo5ajrDM7xhDEbq7V3S920zKS9OBcsbkXCd5pq3SLKPB
 iFGJ4G3bB3Bhgq9Bu4ycsXLZX/bsXRSPZDw2ffHEZvMKh//homzx4XUMed4W2EC2NpBak2AZ7Xq
 mWhti+q30Rahk2mPVJ7QrOKUBFPlCO0PnK5wpDgavDzLNCE8hipbEy7ga0G/GDE9Ey0LLcTu2FJ
 NTc5fi56F4dp3NpCa0LotijlojsWPFzYUATN51Qt7M8BBFkxwiaUANXq7pK23M6X0NlD4MKx7/B
 SwRi6rPejpwTxTd7qOMpwywYvcbA8cgdZpMjh8GgTEw6wYUGYSNLxt6ZrUqPTl1AI6MGz0SyHx9
 3DdY1FmeIU+hhgrMLbJ2Z7CXILcigFef3SzX4LVoTICLM8uOuPTDEfSRcJfcIgiudnIoudWApIk
 4r99MWD6mMEBH2JmUlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310151

On Wed, Dec 31, 2025 at 01:16:30PM +0100, Konrad Dybcio wrote:
> On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> > Properly describe the PMU present as a part of the onboard WCN3998
> > WiFi/BT chip. Enable Bluetooth part of the chip too.
> 
> [...]
> 
> > +	wcn3998-pmu {
> > +		compatible = "qcom,wcn3998-pmu";
> > +
> > +		pinctrl-0 = <&sw_ctrl_default>;
> > +		pinctrl-names = "default";
> > +
> > +		vddio-supply = <&vreg_s4a_1p8>;
> > +		vddxo-supply = <&vreg_l7a_1p8>;
> > +		vddrfa1p3-supply = <&vreg_l2c_1p3>;
> > +		vddch0-supply = <&vreg_l11c_3p3>;
> > +		vddch1-supply = <&vreg_l10c_3p3>;
> 
> Again, please double-check - I see UFS VCC is on this line too and I
> would guesstimate that antenna supplies may be separate

UFS VCC is L10A, while this is L10C. I've doublechecked the schematics.
L11 / L10 of PM8150L go to WiFi, L10 of PM8150 goes to UFS.

> 
> Konrad

-- 
With best wishes
Dmitry

