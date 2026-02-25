Return-Path: <linux-wireless+bounces-32169-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDBcMH+nnmmrWgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32169-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 08:40:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 657151939CC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 08:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8242E3021947
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827822BEC30;
	Wed, 25 Feb 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cuk8PU7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9829E0F8
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005244; cv=none; b=Hw0wzebIv6N2Zeh4xfiHeKEoLY7WvgCjmzyfkpVEGsepP+/9XVfhP4B4Q9IRUAE7kLR0/K7qaz6cVKN3JbUxcqYtdp+nQXzPL9RDwO8xSN/okB9yXA6BNjduF3tWpAbOE6aIMHs9dUlJWvDbh7X11v4pqw4TPtccpb59ZsfSU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005244; c=relaxed/simple;
	bh=z/7Cg0ExGv9P0DICWygB37x91UxTi3NikcqOl/mHm3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K1/1CcemLBm5JDZ6HZNqci7UjEg6DqzLhVQmbauUN5YYL2pWgFVcK+Z0lbE3uiSGj5tZr7rae2dJobKCiY2GgHYbWTm8m0mqjWg1MbNst4wRy83EkI2a82hJFo9Bcr5MhTy/HrTPPxDvKkprOKwRi0ORDNHMLBZukrENDfIe8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cuk8PU7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8FC116D0;
	Wed, 25 Feb 2026 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772005244;
	bh=z/7Cg0ExGv9P0DICWygB37x91UxTi3NikcqOl/mHm3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Cuk8PU7nOQS1Xi2i7I3SA5pKlpWdDEa9cvYmvO+erHzDQexIRPP1ROtHqla5QZ3A/
	 giypyj+Uzr+9bzjd8lGOz7zSqTMZeQc6V3vg0u3cqZaK1cy1PnAkUe6vHIbAbYpUqb
	 OSrmEWmRECWZoDfWzlDxSBpuj54QpFkd69EmKxlBP9HvYyV8eu18qibT+U1D2NVExK
	 O/znYgU+JLm3HRl5OSx3Rzpwe+IV154TiOyXLBdH+7yS0MsU9q93A/+OS+jJ13zOo9
	 mik9JkXCrXWPTCZQw45pPh+km/gW03r2Xux+LHslIjwaiXwkDk3ez8Cd8TLBLlFS1w
	 2sEwEyUAjeJ0g==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 9D0AA5FD2A;
	Wed, 25 Feb 2026 15:40:41 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Ben Hutchings <benh@debian.org>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <aZN3thlmaiBxYVQQ@decadent.org.uk>
References: <aZN3thlmaiBxYVQQ@decadent.org.uk>
Subject: Re: [PATCH] wireless-regdb: Fix regulatory.bin signing with new
 M2Crypto
Message-Id: <177200524161.1547788.6280278042260443537.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 15:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32169-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 657151939CC
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 21:01:58 +0100, Ben Hutchings wrote:
> In M2Crypto version 0.45.1, the default hash algorithm for
> M2Crypto.RSA.sign() changed from SHA-1 to SHA-256.  Since the
> signature on regulatory.bin uses a SHA-1 hash, db2bin.py generates
> invalid signatures for regulatory.bin if a recent version of M2Crypto
> is installed.
> 
> I reported this incompatible change as
> <https://todo.sr.ht/~mcepl/m2crypto/389>.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Fix regulatory.bin signing with new M2Crypto
      https://git.kernel.org/wens/wireless-regdb/c/dcfad17e607c
[1/1] wireless-regdb: Replace M2Crypto with cryptography package
      https://git.kernel.org/wens/wireless-regdb/c/88951a4a9b07

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


