Return-Path: <linux-wireless+bounces-34372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALCmF9HP02n8mQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 17:22:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CE3A4AD7
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 785CF30143DA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9F386567;
	Mon,  6 Apr 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFbjQkjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613C386541;
	Mon,  6 Apr 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488970; cv=none; b=d0uUNJzovyGcJnXU64sfuMTOHNNb047O8sK/Q8aeF5Xw3QsXdon1sSPwkdhQWfcNDgdZh4eCz5TR6tjWKQ7ns3nX4khKP3YOPb0zzssIoe/S1lpMz0z45nReUvzWETgDuJLXqfdrnLMbp4R6fLSHd/ZInX72rE5EgC1G9R6Kdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488970; c=relaxed/simple;
	bh=iC5RuUkjr4YheJjq+5kXm0uCQrLTCZePxmO0UJuDLJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MvsIPdmVPD43ZcPOHmlQ7OfBNlw0mvhAFhts5gi5i5hmuBmv8amMmR1HeFpBPoUa1LOQArVaF8sPaRzSAhnIPLGnY7qvIViv4xHMWIwETlBC9oqGb8MRmhdi0FnE9v5q/lZy27kGNUtB6xhEqSdDgki31hw5Ih/68ofyROyxOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFbjQkjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9718C4CEF7;
	Mon,  6 Apr 2026 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775488969;
	bh=iC5RuUkjr4YheJjq+5kXm0uCQrLTCZePxmO0UJuDLJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vFbjQkjDICQPatHELDGaZzMGsOG7IMqZS8Nx0QZ7vwFj+aO7qSZLsXOzn/2N3Aj8P
	 GQaS+U+vr2nDy11N5l6FpMnGTPxVQCPaO44HkAA0aJr7qr1c6F5Nfjt8wEOGHEdnaG
	 uvklpS8YoFvJ8yZ4D9kHX5qNvlrRjscjnj6mvcxJIR/OHxiuHuUTfNloMmaxYvV1hs
	 p9NclkJ/ClxVwPY7sllotz/eUaHLFeDjYUhXB7y9xDxfCsmLWmVlApD9hr+Nsa2eDI
	 rE+YsIJ/4bKRYOWBWiKAMG5g4+q2szxGIIDSDYo+GQLzupJ/idfiqks9ySg9L9GvoR
	 THwzn+tommHiQ==
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <AKoskovich@pm.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
Subject: Re: (subset) [PATCH v2 0/7] Enable Bluetooth and WiFi on Fairphone
 (Gen. 6)
Message-Id: <177548144839.46304.13972601101594073712.b4-ty@b4>
Date: Mon, 06 Apr 2026 14:17:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-67696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iC5RuUkjr4YheJjq+5kXm0uCQrLTCZePxmO0UJuDLJI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp08/EHCSvABc5+hfj7LywcFO5vIyiMIyPbeR7h
 ppJ03irVwuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadPPxAAKCRAk1otyXVSH
 0KVpB/9S4D+rqQdrlGK7dDEaMH4ZQMEuGOMsBF05rICalPIeS+4HrqIdPQlTVFXQS+2FvhlW2v9
 05Q1bZHOQZs52JJs+bbrwIb+9HnsD4fm4Fcq/CwxMBFfcb3D/8Uh7op9NLC9TMkaPvIlEyMVD4V
 2eZIcjoyQ3ZyIsPzOqGIEKPo5UdI+TQyvmwOYnNcJ7Pg/Ft7ElkHEieBdQ7gR8SjyUegXQSAXNJ
 Lklhvvjd7b4qNJo6F8BDqvjelJFrUH+BSDJI63aYQTuDG5KvMSdQqyGFYjyO6PyvaEmtsmtpWY1
 OBo9Osy1m0mMXQWQCHFcbL50CpXYNDkWKuhxF3yLVZDqBqGq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,fairphone.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34372-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C99CE3A4AD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 03 Apr 2026 15:52:46 +0200, Luca Weiss wrote:
> Enable Bluetooth and WiFi on Fairphone (Gen. 6)
> 
> Add the required bits to enable Bluetooth and WiFi on the Milos
> SoC-based Fairphone (Gen. 6) smartphone.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.1

Thanks!

[1/7] regulator: dt-bindings: qcom,qca6390-pmu: Document WCN6755 PMU
      https://git.kernel.org/broonie/regulator/c/b043657c35e5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


