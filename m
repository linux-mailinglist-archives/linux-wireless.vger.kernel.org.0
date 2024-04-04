Return-Path: <linux-wireless+bounces-5868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2489865E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBB71F227AF
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93D84A31;
	Thu,  4 Apr 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ3ysiRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898D82876;
	Thu,  4 Apr 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231305; cv=none; b=D+8yb0+SgR1hRCQUP3i6eQTzSITk2hVlVfBVjiClxrTQgjFeZY59ILBoeRz64TkIlzM1G0OWNad4BiqH4+nhTAj8CO9L9vWya9K4ExG9oErrVPmDSNInRahkKNy1rfCY77gati9UxH8aCrCAZLFlxRBC9LB4mCYLuC1aqWu8WQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231305; c=relaxed/simple;
	bh=dAhTmkzD/Nmh0C2TGZh+xAa7rrEqwqkaz/GvQ75Pxgk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jB+TlZB0/JZIMdXxSgW3P7uD7QTXiUavDgHMaKOnsC3+eNL0o9+1z9UPDypv/IH0nUEZab2ej69OBSMSnF15tcwDNRXnvqXM9lORmcCy9fXDb/NwWsdKdHEwpL0QKxF4nZN7qfodZCGx/hOk023F863bpH96a3OCUAbe1KkSU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ3ysiRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A850C433C7;
	Thu,  4 Apr 2024 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712231304;
	bh=dAhTmkzD/Nmh0C2TGZh+xAa7rrEqwqkaz/GvQ75Pxgk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oZ3ysiRJDSYt/kN9hfKEvbX+lYFhMkuZPFEjeLM1IaNtVCP2RO4mgUpMVciE8KRga
	 065MjFV57yg9nErRgKXpwZ9OvAYKvJEDWryQwve7yNEupWPEU3KY50zCX1Ec0Eib4u
	 B4+w8CyWSMmI6ZEJ2hyQtb83sa2yjAsy7lNyHSTvydru95AwCfhz3xZ8eyjL6oV2Qj
	 E9ts3COC0a+/R4KGw87uNxJzApcCR7tn6iifhs6gGz/olk6KiBoaYezIU4KvGd1W5D
	 btUrI0dUPOKAmKuHIE3mRpMemLR/aI6wgJoUjUF6c1qhLMj9HqzAZpALXW9SFSN9vu
	 5x/IM/wXbFCSQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  <ath10k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-arm-msm@vger.kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific
 firmware overrides
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
	<CAA8EJprpmC6+ePxw_G6y9YEszndq1VonS1HP=aP9OVHNm42LLw@mail.gmail.com>
	<c2bd01d1-8ddf-44b8-b5bc-860cc9754b76@quicinc.com>
Date: Thu, 04 Apr 2024 14:48:19 +0300
In-Reply-To: <c2bd01d1-8ddf-44b8-b5bc-860cc9754b76@quicinc.com> (Jeff
	Johnson's message of "Tue, 2 Apr 2024 16:40:57 -0700")
Message-ID: <87y19t4ad8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/29/2024 9:47 PM, Dmitry Baryshkov wrote:
>
>> On Wed, 6 Mar 2024 at 10:16, Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>>>
>>> On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
>>> modem DSP via the TQFTPserv. These MBN files are signed by the device
>>> vendor, can only be used with the particular SoC or device.
>>>
>>> Unfortunately different firmware versions come with different features.
>>> For example firmware for SDM845 doesn't use single-chan-info-per-channel
>>> feature, while firmware for QRB2210 / QRB4210 requires that feature.
>>>
>>> Allow board DT files to override the subdir of the fw dir used to lookup
>>> the firmware-N.bin file decribing corresponding WiFi firmware.
>>> For example, adding firmware-name = "qrb4210" property will make the
>>> driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
>>> directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>> Changes in v2:
>>> - Fixed the comment about the default board name being NULL (Kalle)
>>> - Expanded commit message to provide examples for firmware paths (Kalle)
>>> - Added a note regarding board-2.bin to the commit message (Kalle)
>>> - Link to v1:
>>> https://lore.kernel.org/r/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org
>>>
>>> ---
>>> Dmitry Baryshkov (4):
>>>       dt-bindings: net: wireless: ath10k: describe firmware-name property
>>>       wifi: ath10k: support board-specific firmware overrides
>>>       arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
>>>       arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node
>> 
>> Kalle, Jeff, is there anything pending on me on this series?
>> 
> Nothing from me -- this is outside my area of expertise so I'm deferring to Kalle.

I was on Easter vacation and now catching up, that's why the delay.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

