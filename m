Return-Path: <linux-wireless+bounces-36345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOyIOmGNA2pN7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-36345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 22:28:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF9529257
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 22:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CD431125B3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A03C8C73;
	Tue, 12 May 2026 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgCAiBRg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD603C8C49;
	Tue, 12 May 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617412; cv=none; b=US84CvqZG29Vxrz2uoYKWtRRrqqEswhcOJ+aJ/N8j84ot4pjKx1jWINytdd/wBuRYv7MNKvLyWlQnf8nMoYrAzj8AtouJF4xfjPL88wjLrZLwobXNFM2MG50UNgw7JqEtOOXbVF+WKQU3RYpQ6ZY5hSl3j9EKEtfBXiTG6gZrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617412; c=relaxed/simple;
	bh=J1BiYjoLCuq5Sl+Tr6ytUdAEbeIfNy3/RWKvWcOp61Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJ/irdBc2ySh2N7pA0agWvdfXbcqr6c3TwWEIF39y7HfAe41Sc/yMnXgDSS4+Kta20+zObVv91t1NZcFHpUvCZUZdJeJ9ZQl2Knfo3gQfVOWgiubocJ0XOnxMz9dtgiWkRLErYfZDs07EIQr8TWT9epknkCqnyqIboCVIUK/4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgCAiBRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC83C2BCC7;
	Tue, 12 May 2026 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778617411;
	bh=J1BiYjoLCuq5Sl+Tr6ytUdAEbeIfNy3/RWKvWcOp61Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgCAiBRgzkAokRXT7UzLtqU5ksvNHGcgsT0kWvMJXRai7jcncVxMo6aepS40hrOY6
	 xEVTbochr+wSgNVfZ3k6wyEValUI7EQRUmgSNAPbSCD1Odq/5Fo1IQbL6We0SNTok1
	 Rf42AXHflneS6wg/m9pP5cg15Vq4oWNnIWprkN6QJLyOxmHJ/IucUi8RPHvF1rAzC6
	 Bg13ls87UMHHZHEOA4ImMS3iuogKY/8yYaOlNZV+FUhlvQvYEuyQJcLWVy8JdFbdRC
	 eOPpsIk4ofCqE8OdyerR/w5N7GdRr1lyxXez0mwykbLfB4+F/0ok+GC7s6knekboN9
	 O3PCGCgzF2TBQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Paul Sajna <sajattack@postmarketos.org>,
	David Heidelberg <david@ixit.cz>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/3] ath10k: Introduce a devicetree quirk to skip host cap QMI requests
Date: Tue, 12 May 2026 15:22:43 -0500
Message-ID: <177861739361.1242344.5682040550852862805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
References: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98AF9529257
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36345-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Tue, 07 Apr 2026 08:43:53 +0200, David Heidelberg wrote:
> This quirk is used so far used on:
>  - LG G7 ThinQ
>  - Xiaomi Poco F1
> 
> I'm resending it after ~ 4 years since initial send due to Snapdragon
> 845 being one of best supported platform for mobile phones running
> Linux, so it would be shame to not have shiny support.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk
      commit: 113343d57607937102d843775560fea0ce5cbe6f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

