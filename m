Return-Path: <linux-wireless+bounces-33682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GgJORPMwGlwLAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:13:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 562BC2EC974
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE843009F0D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2828BA95;
	Mon, 23 Mar 2026 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3c2eCbA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3F2609EE
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774242831; cv=none; b=ml2mc357q0xY64avg5UOFYvIuIYM+l361eUH8sllQD0OgkNSj9Miv5brH/Zo80wA6gsqwK0A2ZjMcwFhdb6erO8Ad8BPHHV+CyXez/OQwiA2Fxp5iHUM7Wab1cLqk4UF4cI+4Lh3QDFQwftiMJ464d82X6IZTyHvfF7H7dYgwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774242831; c=relaxed/simple;
	bh=n8xTohlnci96Oepuq8kcoqGBK5qDG9Vzur+/7V2FVpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MQC22R+RrNKAcHJJT539Y/bhHbAJ5t/fG7kVmV6L1BKpThtqYDAbTHXlpWs+DoOWzGnGuDPQQa3b154JXu/mTe0ZXs2t4AUuD2YZXPbK7OmsbzMplAMq6m4LWtbdfa4vh1SxFH0EjEECnq5tXYyleb/B20M6Ls+NoSkax8HWuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3c2eCbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AEFC4CEF7;
	Mon, 23 Mar 2026 05:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774242831;
	bh=n8xTohlnci96Oepuq8kcoqGBK5qDG9Vzur+/7V2FVpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b3c2eCbAd7ljBkT4V6MwASehoc/Ro+ELm6D5iPZGmPutSynvrnN43dwGFO6sU2hAp
	 dh/5cFoeow6gjncbrmUMQ05YXZxsEnAJjPoir0AlD/lOTTO9vtyjOGovSnNWLxXeGH
	 CNvwJRULWKub4CvjELznYEMFly7KRMbgOh6TpkT7Ui5pV+eZoFpROcq7s7fqpBJ3fX
	 GHRI1SkykEKmiFyzUo8a0qP2xSO+Ll8EvxwEJWHUvagEDrLGNoaDtvysZhCmR2+q0J
	 7rq6+vqnnEOh/kjMNP9yHCZ3OfEe3cbRFwsyDte78FGZSw26PHI3llbnW2LlMJ21Kt
	 +x9W3gVzU90Bg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6009F5F82A;
	Mon, 23 Mar 2026 13:13:48 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20260319023538.7707-1-pkshih@gmail.com>
References: <20260319023538.7707-1-pkshih@gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Add regulatory info for CEPT
 countries FO, GI, IM, SM and VA listed by WiFi Alliance
Message-Id: <177424282838.1096404.2213827406738511152.b4-ty@kernel.org>
Date: Mon, 23 Mar 2026 13:13:48 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33682-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 562BC2EC974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 10:35:38 +0800, Ping-Ke Shih wrote:
> In commit 5a8ced5ad313 ("wireless-regdb: Update regulatory info for CEPT
> countries for 6GHz listed by WiFi Alliance"), the following are skipped as
> they do not have corresponding entries in the database yet.
> 
>      - Faroe Islands (FO)
>      - Gibraltar (GI)
>      - Isle of Man (IM)
>      - San Marino (SM)
>      - Holy See (Vatican City State) (VA)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Add regulatory info for CEPT countries FO, GI, IM, SM and VA listed by WiFi Alliance
      https://git.kernel.org/wens/wireless-regdb/c/3ceaf3bc0a3d

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


