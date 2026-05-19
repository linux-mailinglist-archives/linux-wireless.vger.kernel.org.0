Return-Path: <linux-wireless+bounces-36648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP5kIl4PDGoZVQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:21:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EB578EF5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A74EB3042F07
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66C83C5525;
	Tue, 19 May 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXTfrbQb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90363CEB8D
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175123; cv=none; b=U/jbFyl080lnryo+4erpLmnJn9s4eGilQjp/+VFk8zlhBhErj8tuk3e2VMWGtjzobNvucr+DQ9WLEIGm8TYlA/NfBcP7vvRXIMAIJUn4EwpvoYpx4M5YHbFjH+13ovPStCFFBD4/+sMAQcIC8wAiuVu0kQFOSOaSNguyXOPeLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175123; c=relaxed/simple;
	bh=0WLCfl1LEn537cT14Wwkq10gRDSFNgmgI1auUY4hKhg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WFDR2BNDihdCSpsLU9pr6/Yyc7/GnN1fFXJigseiIVn1Pgwl5l6ovK42pqntlHjGFr01gcAulYRaAkVIoqkJExfe55T6rQN/gPQuM/ezfS3lyQ4K63IFDtijBJ4Yqc1eVHV0Q3LM12oc+S/25jcM2vD9zgy3ksh1Hzew72fBmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXTfrbQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64910C2BCC9;
	Tue, 19 May 2026 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779175123;
	bh=0WLCfl1LEn537cT14Wwkq10gRDSFNgmgI1auUY4hKhg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OXTfrbQbCx07yPXY3xua73yqPpCKjgZxnWmiwl3EG/aObNlKUkZfjcaK/yyvMDHnu
	 jKozc/Wcm7mO6FIuku2WdQnn6gQ7Jps+iMmZAawF+djp3o7TZBG8jkgG1pnOLKnGwG
	 T0DPb8MF7ynQMWuUsvQD7DY3b6iIlID1XYIS5IasWAOABoQ+E+ugJ0WUgLowgdfxLv
	 XVkU79tZfOgO6CO3ciQ0CuRy1GAwC/6zPDxzjXcVLbqcnLvMV9kMkMhlGoVfKMtEfw
	 4EPcmp690e860rouJJdW/D/7fLHfnkA3lcTg/+UivIyS7xSLf97zSgy8gNpyTlsS7y
	 AkdziO+HpiGog==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6883C5FCA0;
	Tue, 19 May 2026 15:18:41 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, hfzz7@duck.com
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <17568FCB-64AC-4CF8-9766-51FEE44EF7B8.1@smtp-inbound1.duck.com>
References: <20260501153303.8521-1-hfzz7@duck.com>
 <17568FCB-64AC-4CF8-9766-51FEE44EF7B8.1@smtp-inbound1.duck.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Brunei
 Darussalam (BN) for 2022
Message-Id: <177917512140.547955.5730399417374750867.b4-ty@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36648-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,duck.com:email]
X-Rspamd-Queue-Id: EE0EB578EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 01 May 2026 13:25:08 -0400, hfzz7@duck.com wrote:
> In 2022, Authority for Info-communications Technology Industry of Brunei
> Darussalam (AITI) updated The Brunei Darussalam Radio Spectrum Plan. [1]
> 
> * 2400-2483.5 MHz
> 	- 200 mW
> 
> * 5150-5350 MHz
> 	- 1000 mW
> 	(For 5250-5.350 MHz, DFS and TPC are required)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Brunei Darussalam (BN) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/0c24afb228db

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


