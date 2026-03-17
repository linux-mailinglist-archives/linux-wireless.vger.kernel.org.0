Return-Path: <linux-wireless+bounces-33317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGFUIeOeuGnIggEAu9opvQ
	(envelope-from <linux-wireless+bounces-33317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:22:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B12A23D6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C4F930312FF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F4212550;
	Tue, 17 Mar 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEwjg4u7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2613959D;
	Tue, 17 Mar 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706973; cv=none; b=gHBGA3VAQTRi1RDA7H4Bcab5YDwiLEJfgFXtCSkfTKgJhnV7Vv8tTzBAQUVvIaDjzf4YCC/XwCOUyr8c3asGVimJqsOugWsY/3wb29+yLYdwnqZhi5XURhOXL03ZgFlPOyh2fXdg38PmstBkXCoq/iSOueRim7lPlkJQmganxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706973; c=relaxed/simple;
	bh=CMU0rXMHkg7Kxz8EUxJAiLNslnr9+tAGsBMf/5Uzwgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGvlCFClCMk7ik/Z0X9kMZCpZuhO/+X8YyHtJICbizXenizOxWi4Na4nfnsiZSpo7k6zO+K/awosMlOWz3A14VhIgp182JjpPOjXXyIbpC2uIOtYIMrFbgtOA6Hg2i2LlwU+0VZswR6Cc5VRUWjy/hu9OSl6UIF9ShmLIck6F10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEwjg4u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306E3C19421;
	Tue, 17 Mar 2026 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706973;
	bh=CMU0rXMHkg7Kxz8EUxJAiLNslnr9+tAGsBMf/5Uzwgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEwjg4u7enwkX5/tJVpV1sCJowHXevufzg/wpiqivQYHvlPfWhwV9MAP9VJ1o5oy9
	 TZ2/BCnT8T/6UmejZz7sqvm5pguvIPTdIRgudemMoHRs/cgh/edkt76ZpwucNxSRgR
	 X1wKb6i9gFMYrwf1RYPKD4jJyNPfgJzkjVg5pzVEf8kKmywet4kVGOtNTMHtTb9jpm
	 jpwaL87DlLkvWOBnIv1w2O1iVkIcTLi6Cs+Y9VxMJZicevHuU1Ibo2U6+uEKBIubcb
	 O2Puc6suuyZXZ87nmcHaNUJ7gspDgHzlAuw3LI8uOLT7STQWxFZOrhTAbrQJQEY+oy
	 gxT9go35MvrhA==
Date: Mon, 16 Mar 2026 17:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org,
 linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jeff
 Johnson <jjohnson@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Srinivas Kandagatla <srini@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kees Cook
 <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd
 Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Wesley Cheng
 <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Use the QMI service IDs from the QMI header
Message-ID: <20260316172251.2d57d0aa@kernel.org>
In-Reply-To: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33317-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC8B12A23D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 18:14:10 +0100 Daniel Lezcano wrote:
> This series is based on the immutable branch [1] containing the QMI
> service id definitions along with some drivers using them.
> 
> How a patch can be merged ?

Wait for the dependency to appear in respective trees after the merge
window then repost the patches individually. I'm starting to get
annoyed with all this cross-tree QMI/MHI noise.

