Return-Path: <linux-wireless+bounces-18061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8FA2073F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54DF1683A7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4831E008B;
	Tue, 28 Jan 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBahelHu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6851DFD99;
	Tue, 28 Jan 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056127; cv=none; b=Fen3uvbnXTRWwsapbS0eoMTmOFrTPMrdfKoXUBIc6AE9OTnZH3C39SN/MqtC/V6EulYM3BaqED+P55h41bJ+wVu1h6/mg5Um/lFb8fCdfjunkIrs5H0kdkXvVcfGzVGqDtonhRQ5wL6wOIOVT34YhzLXlFB+VO3+hqvjme2V3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056127; c=relaxed/simple;
	bh=ZGMtfJK8F/y9wYUABuXbsCjnUzFs+mshaotaFvxQtBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdFT4oL1bDiJH7dr2oEWPnxXriPqssEoW48NlQt8xUU/uQkpm2PeTXBvjF47QGoXfW1Ep4HFXHfHtjzl6NTbayJ+jtfcQeOHEONmyU+a62tv2PbepnH1Q67pjqckWNZkoAPMZJlHUni6GTC//5uba1tF5xRY/aVpyJ7VFDZhmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBahelHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327D7C4CEE1;
	Tue, 28 Jan 2025 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738056127;
	bh=ZGMtfJK8F/y9wYUABuXbsCjnUzFs+mshaotaFvxQtBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PBahelHuMA+pwUqaBYu/kN9lXamu7webxLVzp9zsa8b1k1tPycvXMleSrKmOygvNU
	 zCAWRMFZttb60xb/15alXrFy7e14yaOab+28DTwnzzNz7B85t87/mIGeESr1pkDFpE
	 ul5IkSUve94owKZK0tnFWDlTMTnAAkChFl9GsTHWUR+RHFca5H16iCsdj9oq27Sup5
	 p8LLcxluQPtmJkF0oR37giKW8Xzl/IHWZsWuaO3V/aK5ATD2XhqJp8FxVTeD7IlbzX
	 EfrrhIAiTtuo1DDcJMfbr77gbhHTCEzbxb/1HWYf98CoB8bqJD/Tksz3YSoeHG1K6Q
	 zMyORrcFYOa8Q==
Message-ID: <b3ff05c1-6424-4ace-a873-ddf1a0d3d07d@kernel.org>
Date: Tue, 28 Jan 2025 10:22:01 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250128091012.2574478-1-quic_rajkbhag@quicinc.com>
 <20250128091012.2574478-3-quic_rajkbhag@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250128091012.2574478-3-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2025 10:10, Raj Kumar Bhagat wrote:
> +	/*                 Default Profile
> +	 * +============+==============+=====================+
> +	 * |            |              |                     |
> +	 * | Region     | Start Offset |       Size          |
> +	 * |            |              |                     |
> +	 * +------------+--------------+---------------------+
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * | WLAN Q6    |  0x4A900000  |       43MB          |
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * +------------+--------------+---------------------+
> +	 * | M3 Dump    |  0x4D400000  |       1MB           |
> +	 * +============+==============+=====================+
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |            Rest of memory for Linux             |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * +=================================================+
> +	 */
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		q6_region: wcss@4a900000 {
> +			reg = <0x0 0x4a900000 0x0 0x02b00000>;
> +			no-map;
> +		};
> +
> +		m3_dump: m3-dump@4d400000 {

This fails with your wireless patchset.

> +			reg = <0x0 0x4D400000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
>  };
>  
>  &blsp1_i2c1 {
> @@ -63,3 +104,16 @@ data-pins {
>  		};
>  	};
>  };
> +
> +&wifi0 {
> +	memory-region = <&q6_region>, <&m3_dump>;
> +	memory-region-names = "q6-region", "m3-dump";

Binding said you have four items. I don't understand why this varies and
why this is 2 items instead.


Best regards,
Krzysztof

