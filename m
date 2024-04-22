Return-Path: <linux-wireless+bounces-6670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A088ACDF7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 15:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1081FB2345C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE314F128;
	Mon, 22 Apr 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7DzM5Ei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0614EC67;
	Mon, 22 Apr 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791716; cv=none; b=Jc7vUndLtg9cxmb7ymqsdcEHqjgkGQrr4Fkei7bulY406dpoCrqfGzXQ/+GA37GD2Z21/MX3jGpw+V1jOzNDZ2GBB+w9jfYFnTxTdwDpXvDt+kbZm6ItBi4HwmqGHkDaOVvcrVusKCvEciyxigN3ArrcDv7zx5xV1jBjNgriomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791716; c=relaxed/simple;
	bh=Eio/1AEc7ubO0FasZh46qzObS9lQSnNE57hP8qhc5Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgeui5wni9UgOwxjCC+LBq0FUOO/btUn3lKSL/tbMBz+FSta301EFY6hqWQkfSmlIb4hBJ4LOy9mBzBeUF09xWYbPr7qaqJkZ7akBziDDr2YRJeopO9H/SPLqSfzmk0v8s7wM50mu3IpGl0nhsq+oP8E4x/HCz1qz3X8GnzE42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7DzM5Ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7718EC113CC;
	Mon, 22 Apr 2024 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713791715;
	bh=Eio/1AEc7ubO0FasZh46qzObS9lQSnNE57hP8qhc5Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7DzM5Eib4LTUdtI8EUX/6yzxsvNX3ccwNEngynGV/pqCi6g4O+IrzcTi5u3Q/5nQ
	 wgmR/xx7BLiImCXH1RCOIttNXHQt2ZViIBDMqnn7VgGTn3mxDiiTD6yVuaLuVNJKz1
	 r+59rFVB21rdOC87v5yC4KnSiplLLhFAacJaIedNz7v19D7yMyIDqcwRTTF01NAlYH
	 pRQeGREO1CKoHDZqJT/MhFg2ZpGixj4D54c0TrnH25TVvr0l5ib7ijZYrFD2BM1hfb
	 0D5LfRU0B0vzHsAOE9cvoHRN44CM+npJ14iC6PTiZK7X/WxJjAWw+Js1j3lzZ9v0lH
	 80BV6ACi7rN5A==
From: Bjorn Andersson <andersson@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware overrides
Date: Mon, 22 Apr 2024 08:15:12 -0500
Message-ID: <171379170888.1217989.8167751161214805581.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Mar 2024 10:16:44 +0200, Dmitry Baryshkov wrote:
> On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
> modem DSP via the TQFTPserv. These MBN files are signed by the device
> vendor, can only be used with the particular SoC or device.
> 
> Unfortunately different firmware versions come with different features.
> For example firmware for SDM845 doesn't use single-chan-info-per-channel
> feature, while firmware for QRB2210 / QRB4210 requires that feature.
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
      commit: 57ce4b27a12c827a24aaa18aa444bcb8733cb053
[4/4] arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node
      commit: 673b174b5b2ca2fb99fe52bf7bad3cc348432170

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

