Return-Path: <linux-wireless+bounces-335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE78020D7
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 05:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2160D280FAC
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 04:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E04427;
	Sun,  3 Dec 2023 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2rBOZ7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4B4420;
	Sun,  3 Dec 2023 04:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC5C433CC;
	Sun,  3 Dec 2023 04:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701579114;
	bh=nEojWos07lNJnamlqJbrt8DW5wThbZFynqJl6pMGPRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2rBOZ7ubLvJwYmh6YQlCz07l2CmRBnbMx00r4RB4GI35C6pYNZGCj0mcRha6/L1l
	 iKXpVO8lWX5cYO9Ri2rfvrcMF8Q/wY9F4gekfgO+2vNHGhi7TAS2j/6VJC4atVGXMV
	 pqYt30tRS96Fz3FS2XBMH2xO07V9sqlv8eAcBAyIoYHgnm/ZoberzDc1egIlFnPw1r
	 gHB+CWE6iA2/3fIGKb6BV4+UkvmpWGnItSeueUiiLYP58R3AdT3MuVCQ4zfRDJF7xb
	 9adKVGdGD7M8JAD+HUopTWaigKR7OUQ0MZbY0wdr9Qb5TXjy3RRKfLv5F8H5xDmsY5
	 4oDtHMvfAFvGQ==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm632-fairphone-fp3: Enable WiFi/Bluetooth
Date: Sat,  2 Dec 2023 20:54:42 -0800
Message-ID: <170157925817.1717511.6338511271605322593.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127-fp3-wcnss-v2-1-a5154fae4768@z3ntu.xyz>
References: <20231127-fp3-wcnss-v2-1-a5154fae4768@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Nov 2023 22:55:38 +0100, Luca Weiss wrote:
> Configure and enable the WCNSS which provides WiFi and Bluetooth on this
> device using the WCN3680B chip.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm632-fairphone-fp3: Enable WiFi/Bluetooth
      commit: 5b006a82a2bbc0ce18bc6b084fc8d8d9cc110001

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

