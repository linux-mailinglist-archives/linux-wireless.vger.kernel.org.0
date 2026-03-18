Return-Path: <linux-wireless+bounces-33397-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GzZGyavumlXagIAu9opvQ
	(envelope-from <linux-wireless+bounces-33397-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 14:56:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2172BC72F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 14:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284C131CF6AF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F203DA7FC;
	Wed, 18 Mar 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKktueFs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8D3DA7E9;
	Wed, 18 Mar 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841844; cv=none; b=HkxXYJ2+abPBefixoYufDGzQJ2QiE7tixhg8xf8bdejw2pIaIUMwP76GgPIq2eRreD+KussLYEZiIP+7PdqveZ88DrLmP13eOnlY23t73yia0c1BDsbXeVGnnenXQ53stBrYFL7VuQVxlwNRC5ClKq1xBrAk6FV5Jv+z+8ErYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841844; c=relaxed/simple;
	bh=KWzc1RhRpcc1zceizbJVzn7r1CLlyMQaw4Z3lAe0GWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qB4kal3KQCAdtX7XZc9sw8j81rwwlBzdbF1KNUcOkx+L5MuaBTJ1QS1odBWn2C45U+kf5ke1l0vBvClirUZ2DQqOtNG56QeGY6DAqw3vBCi31MrDfsjOQI9xLpKu8UTISlqG0YQVG/AnI9jY749CjORPKmCrtmxqNamKPsQfwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKktueFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A75C19424;
	Wed, 18 Mar 2026 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841844;
	bh=KWzc1RhRpcc1zceizbJVzn7r1CLlyMQaw4Z3lAe0GWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKktueFsubrLlQg02btkIb9U7h1du9eA2v15Uolv1AX53djENBo/UlLVylBPHHEKb
	 b+ZMc+8uSSRCaZd+Ajl6F2h1IwAXoh+BHJhKzUu/zRjv9Q2wnyuWOLAVnR5zg0HiA/
	 8ZrGnd/pAAF8YhkBUMegwZfBI1oGEOHxrgmhJidSrHb+L98vLt2/GJgid5gBmpz0U1
	 LpNboWefW/vDgmTKmcDZnGWSOgZqGrPv2C2yVVw6jVpxFt1zw0qdiaxdCXiPTVcr8I
	 5l5mmBd2RlG71q46pxzhaH/WA2lmQ/WkCbpZBkxsWsU3KENmzpqZhSbXIv7UgFrMLC
	 CEbCDGKeLAnxQ==
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
Date: Wed, 18 Mar 2026 08:50:06 -0500
Message-ID: <177384182865.14526.18396654374290648632.b4-ty@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33397-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD2172BC72F
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

[8/8] samples: qmi: Use the unified QMI service ID instead of defining it locally
      commit: 8baf6b3b7695849581a91bdaf66af2be68ef32ed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

