Return-Path: <linux-wireless+bounces-36647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO42OFwPDGoZVQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:21:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D3578EE8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3617830422CD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663033A9DB;
	Tue, 19 May 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrxMR7Qo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9A3AD51C
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175123; cv=none; b=VgS8sSjJDVM7EbTa2NTde1LG2EI3cvwdBZ8GNiZCf40Nv1wFMFUwHVIr3Pxu8LmR5yLlmS16hsewr5acIodkPbMcwqhR5tOOND4xz4ztZoO/fyYt6nqRUu1hfxrzLDKwcD+p5pkbwTS9Xh1tWoFA/NpftUlyUVJ1zHePL71kPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175123; c=relaxed/simple;
	bh=v1dAr/RmtJKN065HerC6F9gjL1ESbddIV2QMbJ/qAQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ip1lwKRz+LIUnByjc4jPwkKTwHpbx1ngxLEtV76FUXtnf9ADTMv9ecPwD3le56Y4rP3ZC+9KbBu1l39tL5Fyt3E9Pl91S9xZbhxfDUFyJIpcZa+l9jWuTdQpWcTxMl/tns4QIX/jEycHcIsAweeaw19ocz44nLZv8Bx8WNmfeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrxMR7Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBEAC2BCB3;
	Tue, 19 May 2026 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779175123;
	bh=v1dAr/RmtJKN065HerC6F9gjL1ESbddIV2QMbJ/qAQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZrxMR7Qo14tT6I4OfLfPmilsWKl5C3CyT2z1hwPXt3PG9ZRBib77XgnRCxygQSsyu
	 58n4RcmXy571kJjEF3BWbdt73A/Jno0HSoFos6ekAOHlQ6eOnYBKhxqFfcURm9kP2x
	 hkKRX96hGwV4m84AUG2SymjyTpsZEyRQyAy+Jk1YvHgk18q2X9kMoxZCkDsVoYDzUX
	 S8ddkUJYNf8Hj1LygFfcmeDuK9uXnEu1kMc4ebmatuuJl8uyfaw+RiCQT7/C3E1npe
	 8QVsJD0G564mLWWoDwsUN015Gz2LWaVvA4Exs4xLcPweED9SR7qRb2nkCXCObTV7B2
	 VJSF/lJCxYoPw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 78FA65FE52;
	Tue, 19 May 2026 15:18:41 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Mohamed Aashif <maashif011@gmail.com>
Cc: wireless-regdb@lists.infradead.org, pkshih@gmail.com
In-Reply-To: <20260518074743.179402-1-maashif011@gmail.com>
References: <CAHrRpu=-ngPpe2MsmWz0gQq1VVxbr9L0+jUos3o62wPUY-wXqQ@mail.gmail.com>
 <20260518074743.179402-1-maashif011@gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory rules for Sri
 Lanka (LK)
Message-Id: <177917512149.547955.1025630128470868369.b4-ty@kernel.org>
Date: Tue, 19 May 2026 15:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36647-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trc.gov.lk:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E5D3578EE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 13:17:43 +0530, Mohamed Aashif wrote:
> Update Sri Lanka regulatory domain based on the RTTE Type Approval
> Rules 2020 from the Telecommunications Regulatory Commission of
> Sri Lanka (TRC).
> 
> Source: https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-English.pdf
> 
> Key changes:
> - Change DFS region from FCC to ETSI (document references ETSI
>   standards EN 300 328 and EN 301 893 as the applicable radio
>   interface standards)
> - 2.4 GHz: expand to 2400-2483.5 MHz at 23 dBm
> - 5150-5250 MHz: 23 dBm
> - 5250-5350 MHz: 20 dBm with DFS (no TPC, 3 dB reduction per EN 301 893)
> - 5470-5725 MHz: 27 dBm with DFS (no TPC, per EN 301 893)
> - 5725-5875 MHz: 24 dBm with DFS (per ETSI EN 302 502)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
      https://git.kernel.org/wens/wireless-regdb/c/63d0d6b6aa47

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


