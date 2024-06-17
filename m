Return-Path: <linux-wireless+bounces-9060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5690ACA1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381E9B21F82
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2919408B;
	Mon, 17 Jun 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhrnY53u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A322575A;
	Mon, 17 Jun 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622597; cv=none; b=GlocitvCny2GwW9w9CIT16hVgTpNQ3mJPySAshQTwQtDk8uGRvZsh7l7c2wY5m+J0JN5y8OH6YUbiswAQy1lIbsibO0II3hMfXMH9S5ECdxl3XLd0GL4TUCE2gve6h+xVTijAUP6y/bTiMZfWQBLvl94H0VWQvn5zvJ34qbHcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622597; c=relaxed/simple;
	bh=0jlLTUdOHjWXlIemi6q/5eFkjO9PpJlfhxc4JTOGzho=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=lgOujOe6F0dG34PybtrpCEpnGi3h7RPEQcmEfOXSUzJUlpsJfVCuSotyuZSRbPP3AvY2Z+eaXumtJ8gqB80ZmEAIkcdOQO0/1XgIOcW3v2+Vr7O/7lIwwxw3/uKez7DwGifbL1X/hw92YmqUPxKkvrrYTHciQpHqqv6brg5opG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhrnY53u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1F7C2BD10;
	Mon, 17 Jun 2024 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718622596;
	bh=0jlLTUdOHjWXlIemi6q/5eFkjO9PpJlfhxc4JTOGzho=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OhrnY53ukmxxgRmX831WZcuAYGNQ+cK/LObFXIuh21G7CzW+wCqIoIOzr6GWbb/Kf
	 M8BZM6VOHlvdKmNvTuMJXvYIwnygd79LW0njFXFLbhsew6Jp6XElLgPf5PQ/i8fEzm
	 OYZEICH3w0ujOTDAUwceudneu53wvBZgYSWXmgothV7Iu7ETMZCyOqgtHrnUyrmRwZ
	 ECRC32gUo+cWnuZ3lCdA5+eDjZ7FXEADSm8meen/mU4hHhe0plPcaQMvQ/kSKu5WqZ
	 k1QSPCQE6JhqXQbsSG0MWsRIB9zs3BEUIzAJMuZAnbHHlu2mzbavvHOtfy5EkkfD4F
	 XMN7aG3FBiNMg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the
 ath11k on QCA6390
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240605122106.23818-2-brgl@bgdev.pl>
References: <20240605122106.23818-2-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 ath12k@lists.infradead.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171862259099.4124983.18069958656274980613.kvalo@kernel.org>
Date: Mon, 17 Jun 2024 11:09:52 +0000 (UTC)

Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Add a PCI compatible for the ATH11K module on QCA6390 and describe the
> power inputs from the PMU that it consumes.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

71839a929d9e dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
aa17d384971b dt-bindings: net: wireless: describe the ath12k PCI module

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240605122106.23818-2-brgl@bgdev.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


