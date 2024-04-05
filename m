Return-Path: <linux-wireless+bounces-5896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E829D899C50
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239211C21DCE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F916C6A9;
	Fri,  5 Apr 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsXmEvwb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1C16ABCE;
	Fri,  5 Apr 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318664; cv=none; b=aRzGeCpZEtsS+nXjmJ5SkDf6C11UNJFz86RTE2dGs7v0juxGoKOACVUhWnTKz8RQ67/7v7kVYyUCPuPE+zZ4mud49ChOCWg+28T+vSdUN6CPIzoHkC0rgfSujYtSAMzx7RVU3SnQb7YHH0hYov0po9Fma/QcCQ8/uaBAJF+aAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318664; c=relaxed/simple;
	bh=AWVqdr9JP3qgtTgixeT9P1xElXTV4mYyJSYRInZNQCY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=HUz2zcv8tayaV5UrE5uqnCQ5Ej9KJ56Sv9lxVGKvAsn64YbzYepsdq5fxtTCfET1czZHzKMB/UWw+E5uFZkREtUVvLiuz8XNm5laWY57TjnnITz6gePWFIRALirw/SVAL808sAaC4K1wbjjftMJxT6hSdslapvmkfR5wTsQWq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsXmEvwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8C5C433C7;
	Fri,  5 Apr 2024 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712318664;
	bh=AWVqdr9JP3qgtTgixeT9P1xElXTV4mYyJSYRInZNQCY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZsXmEvwbfAkT+FRrggPYFIQ9O3Ecnjbo59bRGcIti7C/nghaRp/T7BLdkqzQMOyhR
	 dMYqhyflDx1dFoM3CWhH2Z9E8ypQXkkEK6iEjRs52ReTqmkn5VAHXj+RVIkL5Ae6t8
	 AlQDCO6wMsg+6TCzCfMTLARnphwwuUr+mbZ5lHqy+4921HojVqG1D763/Z4lHh2tJM
	 iPdl5M0tKlCbf3Y3+PTFenMnYx2U+QSia7nmgO1Ime+IR0pP2basrURGIU6tPzMABF
	 HqNZUpk66dKkxKYHsR7ztVdIM8hBFISeiys4dKCyce6wbZLCu6ZOh/lJozGwwuvIb8
	 NVl5e33jMgViA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC v2 1/4] dt-bindings: net: wireless: ath10k: describe
 firmware-name property
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240306-wcn3990-firmware-path-v2-1-f89e98e71a57@linaro.org>
References: <20240306-wcn3990-firmware-path-v2-1-f89e98e71a57@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171231865932.2186783.159747685882106713.kvalo@kernel.org>
Date: Fri,  5 Apr 2024 12:04:20 +0000 (UTC)

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> For WCN3990 platforms we need to look for the platform / board specific
> firmware-N.mbn file which corresponds to the wlanmdsp.mbn loaded to the
> modem DSP via the TQFTPserv. Add firmware-name property describing this
> classifier.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

158fff51b4c3 dt-bindings: net: wireless: ath10k: describe firmware-name property
5abf259772df wifi: ath10k: support board-specific firmware overrides

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240306-wcn3990-firmware-path-v2-1-f89e98e71a57@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


