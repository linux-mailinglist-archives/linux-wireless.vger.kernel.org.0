Return-Path: <linux-wireless+bounces-33264-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCnqEvNkt2kMQwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33264-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:03:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9C3293C2F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8E2301BA54
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702AE30B520;
	Mon, 16 Mar 2026 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enSqJOGE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90E309F08;
	Mon, 16 Mar 2026 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626563; cv=none; b=TNJCnGsq9jmfRZpAnTweoVdH08ZnxrCZTpNScWSnLc2DuvmmEgJr1WO5iXh8LDOw9KgMWbu0jyFR8mydNI0ZMCH0EDbXmNzRAZipFOsG4Tx6UpiCg7EQp2+7tELZWWO0vfNin5085+uc3M6JnTxH1oI0BkY4mMFUjh2/YdgjxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626563; c=relaxed/simple;
	bh=BuOo5vxj1gLbW3Ia7bVSuXN20wkAZTTCpKCe+LqWza0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxLKYpRZ0IQYlc2l5D07CzPk8bQ+5DR2R8kUv+i4BCDvM5WBQ8KPfmxavg8DiIODeqXkCw6nsRMpFmtfAeYYKbd+by/YPaWi+WumOBJPpMaRVGoayjbKy2W/+Z9LmCv79dF4+OG0CnXNnWRC85wOfVfMqqcdHOMSeaQa/5LOi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enSqJOGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B57BC19425;
	Mon, 16 Mar 2026 02:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773626562;
	bh=BuOo5vxj1gLbW3Ia7bVSuXN20wkAZTTCpKCe+LqWza0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enSqJOGEpCVeo23yF51TwkmQQ1+nVNEIQWHEEohawdzs3ilK8JaMnaRaq/Qs1PMgF
	 uXcc2B9rR0z9Ks54GvcG1gLFj/p3Zp7A28TZKLScBdaD25yum8C1eUDCzRnNMAADu/
	 14T1y2Utn3b5V2rvs/yv4/WuJXE12k/wbkoozUEJKeGKiC1IsM3LnQ1e5mQAAbTLIc
	 aQf7zY78YR6j24QOQFqskpZBSbeGwEuf2J6Uw9cKQENna/aAYO6IT1mJb9QA+Xjwev
	 ywJXEyks4yfjWW9//wAtWZK0sxfSiRFYsRXdKeBkUnd2LuADBkL6R67wPOc1NloTQL
	 L3TzwMePPXcSw==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
	Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/8] Group QMI service IDs into the QMI header
Date: Sun, 15 Mar 2026 21:02:27 -0500
Message-ID: <177362655085.7429.167557193442435410.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33264-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE9C3293C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 10 Mar 2026 00:03:29 +0100, Daniel Lezcano wrote:
> The different subsystems implementing the QMI service protocol are
> using their own definition of the service id. It is not a problem but
> it results on having those duplicated with different names but the
> same value and without consistency in their name.
> 
> It makes more sense to unify their names and move the definitions in
> the QMI header file providing a consistent way to represent the
> supported protocols. Consequently the different drivers will use them
> instead of their own definition of the service id.
> 
> [...]

Applied, thanks!

[6/8] soc: qcom: pdr: Use the unified QMI service ID instead of defining it locally
      commit: 24f80cbe0b8f4c6b27d03c7a7ad707d76c1c4885
[8/8] samples: qmi: Use the unified QMI service ID instead of defining it locally
      commit: 8baf6b3b7695849581a91bdaf66af2be68ef32ed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

