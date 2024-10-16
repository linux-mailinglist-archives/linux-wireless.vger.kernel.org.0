Return-Path: <linux-wireless+bounces-14068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BC9A0763
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA59288C15
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D257206E96;
	Wed, 16 Oct 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAoTA0G9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658EF2071E0
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074514; cv=none; b=u0HWqtVFpsdU4/aIl8JEnLUWc0/zZpVm0bFUoKSscC293RMuigenpX+50p/1nV4VjmjOaG90dWDMlgb/h58GIQF9hJRfSqvzH+79X0QNMMOpXCn7DYYyPmLr0tVWa2lA9VpCaCE5iUqLhNlcQUE+bMURIaId3rBw1mQJxVLQlZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074514; c=relaxed/simple;
	bh=cPLPMI+yIzV0Ysp2WcB/FUdAA4R7BLdsnV3NMnx7rBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4sPd6ZD48JW4XFAn9GNDU8sWoekLwEKZ0HV4+5RFmfsxWhtNrK6o3HenKcn5QFI1GceY6/r0+p+6BQhNBM8TEBYogadQ79jdG6Nr0p8Grhwj0AJb0HcY7vmoysSYn130eqPOQyUmDJg4w9t0uixZUr/whowWFgbAdwTXQAPCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GAoTA0G9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f72c913aso3654287e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729074510; x=1729679310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAXpBaMtfWO8UJVVjb65PyHD/dGQ0kmBoOJFKkFJy0M=;
        b=GAoTA0G9+N+nJiN1IEcM93LkU/f1vLY3uQlt04OF6pmhzIUseLmg8xCQeMvweBcl5S
         9VozJBRHF2UGPzbRlGzP6kP1pdX8RhfTDX3xDWma3lWqs8qPJLsZXThx7oD6way2+VYe
         CUbLMnj8oc0kqhc8l9+A1fLI4Urrx5GgtcSPxoNezqF79kUi2ezZstpQN7sJQtoB9sMn
         c5neCtFHl/mu2RyfEqCFVxiVQ9gAiGpjy6gjVsWdfGqMB8+emeb+loNR4M1KIbAgVY8U
         iyea+YZallaOu9SgRvSQf7XYml1LubKe/14VDteIFnvWIhcubZiDm3VZsNV9DmK2KFux
         BMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074510; x=1729679310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAXpBaMtfWO8UJVVjb65PyHD/dGQ0kmBoOJFKkFJy0M=;
        b=fveKOvb49z/2Ku8CDm7Sy0GjLWF4WzHaO2IpGkqzg/WKN1MsipRm/ZEGD45Xjju6BX
         nQGfRcq6A3TKCx6pLDyXL/zpssPGMg36cB7Lvl+1RGwKPalE+qWC7VOCYUqvIroUgCTj
         E7F9wd0vcZP7BxhS68SBALYdoaYIeJa3agZF9fw5vEiKZ54mMq7CozCVctDm+5peLeCz
         JwudKRK+K2ewJy7ICvmbbjHkJzaHusXdeahIevMacVicN9M3mWqDG8EUbKjGafPgOnyY
         39QeFVvc2SuXW+BndsJXKMiOQaQimh/ei6mxC98Vd0TFENpik77c6tPh13rn7ugA3oP4
         Q/1A==
X-Forwarded-Encrypted: i=1; AJvYcCVcG0gEKlhNCyND2yEgtHv7ZrwNseag/Y9VF4bIynICrbVtjmZMYx0zdTeJdy2/CLLGfkIHKSNC8rKmeLupbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzat013FtY7B1/CgWSpgFk0MKmaWJ28RaDSwciEF6XBNhPxA040
	mH2eoqJBmVsT4ZUKTmE54/6rDMsciJ8xFsYHoYDRneB+8hHy4j3+bkk0+5cKsVs=
X-Google-Smtp-Source: AGHT+IGtiqjFOVGlArjjfVOfTBmXeHODhday3PR0qenIrPwNidjJwD23eHbV+vCHzblqwLmnxlmcVQ==
X-Received: by 2002:a05:6512:3c91:b0:539:f807:ada1 with SMTP id 2adb3069b0e04-53a03f97686mr2367940e87.58.1729074510575;
        Wed, 16 Oct 2024 03:28:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a0000677fsm402183e87.194.2024.10.16.03.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:28:30 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:28:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 01/22] dt-bindings: net: wireless: describe the ath12k
 AHB module
Message-ID: <qzjgpwemwaknwbs3dwils6kaa5c3inabfvkaryvc32kblzfhy3@6yduooj4dk63>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-2-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015182637.955753-2-quic_rajkbhag@quicinc.com>

On Tue, Oct 15, 2024 at 11:56:16PM +0530, Raj Kumar Bhagat wrote:
> Add device-tree bindings for the ATH12K module found in the IPQ5332
> device.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  .../net/wireless/qcom,ath12k-ahb.yaml         | 293 ++++++++++++++++++
>  1 file changed, 293 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml

Generic comment, please add qcom,ath12k-calibration-variant

-- 
With best wishes
Dmitry

