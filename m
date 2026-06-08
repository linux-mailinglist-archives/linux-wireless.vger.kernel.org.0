Return-Path: <linux-wireless+bounces-37498-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MwT8KceNJmqgYgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37498-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:39:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3679654A91
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Jm+rzYcW;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=X9GPruAx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37498-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37498-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D11823014BEC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1C3B38AF;
	Mon,  8 Jun 2026 09:35:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783E397332
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 09:35:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911303; cv=none; b=X/b9qhPg6IsKZljqVrOJROQhWh6PH8mo48nNN928dLK5+3dSZZyBatO6Pjc4n/ovV0lPpgqKLw3v3hAYYlDTY2yY+o3leXYqfSXNmXnasAknmNdAd/hEt+usxqE02hb4HbZfxP+6XcLCcJq5inxJzYZ3fKBT2J0ztHBdjEJhXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911303; c=relaxed/simple;
	bh=xcS8+PTdPjia2DBa+T7ce3/XFD4I1lgSgkQoFiLYDnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV12vz3Y+4+B7ITHBFDX+GWSkBjMUqDRgNl0Y1hWmIWWRMF3Dc54bmAeX8+Oa6JTVccDPvzZN5Th2260VtMzvCNpU6iIVNj3c11GB1SEQBiwZm6nthOrbXyY2IgsFepBlVCqDx3KkBYaKk389uF9B4OpO56b/dNCEcp+qbbllak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jm+rzYcW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X9GPruAx; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586QrYI2771593
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 09:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	noils2TMNs914sTPuUGf6yPxz2nxtQ6POyQJ6i0X/mU=; b=Jm+rzYcWw424UMaf
	a6G4DrKNHyqLC4QeZ+4mXROqjrbFBVZtS4hqLHDHXjUaGZApYU65UUvBnUKOm/tn
	Y+SS9tLch7/LWzt+BLS4+V2eSJs/u1vX5uJPanOb1LFxNiPERp3833DylOPUpWyV
	SoGB/HgM5EjTK6KoK+3tssRvbNYvO7pVtfZmjPiqKv01DCtDgafQLdCtTOXXBvjT
	fl/YHJBDE9mh/pFM2KxCagQnACXM3+N1x4q7PULVm9VI/aWQP0f7GjQ9Tr7zzoSr
	WKBHpndHgqNF+HW5T9HRU2KQJ4PkI4QcGrzJKcCAhw0D2JbJr53YRQYujVW+QCEV
	ZOIjcQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6f1xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 09:35:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517bdeceb54so1255731cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780911300; x=1781516100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noils2TMNs914sTPuUGf6yPxz2nxtQ6POyQJ6i0X/mU=;
        b=X9GPruAxihhoxXGGQEGaGG+lSkUWUMcJs79EMowaWL1uW8nsl3Sj4709WdHaaMozLi
         EOAXFO8UaZrpmbw2g41H3JFDvOdD3CsvV5K/qG+WV4s53OIYTf8Z+Nk3kNaus9eud+k1
         faiOCr+/povcAzVTK6a727wD0rX7H1IAdRy6yYlKQVhw541J1Z1Hse582eKgiKAukKtt
         yG4xhcekpPEEf8QWmq5oMVqd67v73yXKbEZKAYmG0rPLbBXS4b6OG+y5l/UO7eGbB4pz
         kbtDWe3vZPhDSKk08q9p/IXqsiI2riaQHy6h6AFsYt6r5paQOm87fe6xCtS1lGVJnAy4
         F72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911300; x=1781516100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noils2TMNs914sTPuUGf6yPxz2nxtQ6POyQJ6i0X/mU=;
        b=NZ1LHki2xX+aunjhUckToGrpNNZfDsA3lRF4PTBbQgsgSXfHiwmYwOJSiaryoO0xbV
         j24EBArupmr6uDM10NufjXCsujo3et8umsgTViZmHQZrGClxDuqJX1Mz5GnSFT4N/REF
         zPhiKM0tqrUZ+Su+ub+xsXAenRN2gRKpUQ5xEDM6/BKAzPgNQPwkz0qPYR1WKQtVej/3
         Y/grzb+YGvslWVNLpUgY36xiHTFE30eDdn7a8CHnPAFnaddh+zTDsh5gekN7r/NPnwiE
         kEXM2eP5oLmtXOPA03hH8gHos5s+cvgUt2e6Q4nhTx9FzhJ+9DWUlDpnh1ioS7afcOaA
         D24g==
X-Forwarded-Encrypted: i=1; AFNElJ8gkusZjW+mtfoOnaU/V4W+ItuXTlKapI1/9JEQYhpWVLMbcNiPYTpBRchQzWCKFkpMAqOyqF3P1VTrXfG2Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKC4cVZJwPY5aKDg3JLmoZW7zswDyZYd3r0wX6vgHHh/aU+eo
	EcJVE0BjvJ4lNG3NXXI0UEAKIsq7M5r5QvUh0r4q0BLQO88brDHqR5JRNazbYhvtrQ1Ut1PVmoY
	vF0G5+0eNALtJHMcuTCRdMDiEnpz9jqeqlw3SfDwCRe5o9I5AYj1APGx64gUUhbNLBud9xw==
X-Gm-Gg: Acq92OFQwmy/EfmWkN8iUwuHEdHObHNeSZiwBTKZF09xkLjfghg6VcCqXR+UuL4qzEu
	80m7dmW5KCISR2Awfyyeip19bhS068RV5HG8nZhqteEg303ph9G/nALKo28rYEeKj8JtrPuUMfl
	nK1dhNSsfZz+2E78pkhE3nkMzxW4UO9/88eePrhZuT2Dhw7w6gjueWeDr0RW/8FRuFM5iY0sI1t
	4c/lUe4vhb4/jSSjZUHvmbszY9kDg+6baWDyuL7qmZtZpz/MR0Cdpp7ccbCQTnrI1XVZAzxX3kL
	14bvsLNxzo2pcErTB/hu9iFRwXCvpIgnWlTZmCVGwkD276HFSDrwWXOnQsggGL7XTFimvWy1pOX
	E1iPuK00eLB8ibjVr4DusfIik1tJAmYnYiSREEZbF2KBQ/3643zv8DtFq
X-Received: by 2002:a05:620a:6486:b0:8f3:5988:f97c with SMTP id af79cd13be357-915a9d85addmr1243694685a.3.1780911300315;
        Mon, 08 Jun 2026 02:35:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6486:b0:8f3:5988:f97c with SMTP id af79cd13be357-915a9d85addmr1243691085a.3.1780911299749;
        Mon, 08 Jun 2026 02:34:59 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm838592466b.52.2026.06.08.02.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:34:58 -0700 (PDT)
Message-ID: <a5783c4b-abf6-421c-84cc-b7b565d37fdc@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:34:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
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
 <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a268cc4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=bMn7uSZEEfIJnIPTgxAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4OSBTYWx0ZWRfX/3jF4UOGuUTN
 Il5f+jq/AjZ8UOnBemfPvUdJqVoPE4LHxRYf/WRo7ACCrMdAkOqfgsiN5eM6x38U8b73n7q/wYA
 5wLfvGIbJ6VXIDp8ulVjTQ7r5alqMDxvH17rWi0tFU27wohuRRIlp+ITav5xSSG6a2pvy1Fxu13
 GV15LyR/1fMJClzFZetIg+Jforh+DvIewSeGg0smHes4W8ZkK0cY/X2aK0NFxSy8t6GhIjKfyAh
 b5+j7RXFBF/kd6pnB2uJ0XNLJqLAGn55xmhNu5xIH4sOPPikgas3PB4QPs4urW8D7cH35kBghtT
 vy5XU1vdJHdhm0GCn9RO2esr5A/UH42sWIv8HR7hSo6gZT8mBoOf6ceBcd2LEmtxrf+n7xYa8i7
 uhHu9NKx0roeMUSgD7Iijjn8ZjZ7sJrUhWvpLhHy1ytYUPctfIIMh9r4VAsnrrgR71CWDD4gym3
 +3H3HqqJ5M1gGHjHyDw==
X-Proofpoint-GUID: VudSTSeLCY2lal5qofM4miLzP7QpctuX
X-Proofpoint-ORIG-GUID: VudSTSeLCY2lal5qofM4miLzP7QpctuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37498-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,google.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3679654A91

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
> port rather than RC device. The kernel recently started warning about
> the older style of DT. Modernize DT for SM8350 platform by moving the
> entries under the root port device node.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index eb2a795d8edb..136daa444865 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1583,12 +1583,9 @@ pcie0: pcie@1c00000 {
>  
>  			power-domains = <&gcc PCIE_0_GDSC>;
>  
> -			phys = <&pcie0_phy>;
> -			phy-names = "pciephy";
> -
>  			status = "disabled";
>  
> -			pcie@0 {
> +			pcie0_port0: pcie@0 {
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> @@ -1596,6 +1593,7 @@ pcie@0 {
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  				ranges;
> +				phys = <&pcie0_phy>;

Other socs put this between bus-range and cells

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

