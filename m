Return-Path: <linux-wireless+bounces-33754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBldI3oIwmlBZAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 04:43:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36268301C95
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 04:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADDA930C438C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3C39F192;
	Tue, 24 Mar 2026 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R719frGO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4B366557;
	Tue, 24 Mar 2026 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774323735; cv=none; b=gueujRYNUfFk3gItwyv+XB3sM3iyYPmNsfUMTwBkJJ5EjaQzoCZtVBUjJDdxY+jH3S4cFmixElB/g6LLi3/k1fe8B2oYSK95JVEAYazinqvCs9e2E4nl1/ZuFGb5SAEt5WYNWTeeKJuy0bdrwxHl+kPdielhTfWFMo6S+Nsurfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774323735; c=relaxed/simple;
	bh=qpWNh+tTYj8MbrdcqgUMlZVZZhUWaYgGrvrVHLiKCBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfE3WWioYEGgsUTwcOL0a+TO4kjREcOEQBtJ3JSXFIgf4MV7YCLhJ9JQOgOZRXv58uIsLyxboqvk0P7DaSDteE+KmyP9dJ2RfUXHwNxDCIs/h+aXwJNAFqTWVHpk2GeIBhQvJtOX4CkIqS3viEpfoKfnaoXGfCv1I4nkwaeYWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R719frGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71660C19424;
	Tue, 24 Mar 2026 03:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774323735;
	bh=qpWNh+tTYj8MbrdcqgUMlZVZZhUWaYgGrvrVHLiKCBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R719frGOM/L0P7abqsQXEE2kqqXEtWJwQlWRwk1c6JSRqaOjfeYcyyOm4/lf51mLC
	 Nv1kOwcRbCBtHThGpyOwpG0IlUfZa4kYuRSFZM1GeQjBXDL5gJJ60wgiln/9o3hAiv
	 qGV2aOc5keMh/1LnL0lV0vPFRDnbgAhE4o0KX3+i3UQWBzuZqwy1qjRxXcULJC+P9Q
	 /+HYAhJ4SFlqQ4BqcnW2S9x6r2MFkwLsFwM+hCAQmU4sLYkFfZzOV/Pq2IqtPM8KAf
	 bjzY0XPVn/+ja3Em3n+8c0ghrb3PSd027BxIKGh6kcZZaqwS7RQiOoRti+dsrb2n8N
	 mGiW3gQixOGhA==
From: Bjorn Andersson <andersson@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/14] power: sequencing: extend WCN driver to support WCN399x device
Date: Mon, 23 Mar 2026 22:42:01 -0500
Message-ID: <177432372677.35532.960283784585134331.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33754-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,holtmann.org,quicinc.com,chromium.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 36268301C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 06 Jan 2026 03:01:10 +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> [...]

Applied, thanks!

[10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
        commit: 2d0840e31c8a6ceebc701822889424bb1927d1a7
[11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT properly
        commit: 1eea8321da0fa3b80eb19802ab830bf83d304519
[12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
        commit: 40a5da727ebc2a8d085feda501ab7bee4c5d9608
[13/14] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
        commit: 77648f3a7e9be4e7090bd326b2e4a4f9265b80f3
[14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly
        commit: d545fd1caf42a8f20531ba38c671f5bf10542720

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

