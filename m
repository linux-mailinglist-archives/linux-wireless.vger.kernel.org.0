Return-Path: <linux-wireless+bounces-37636-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZQlBPGOKWoDZgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37636-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:21:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 961AD66B5AA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:21:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=beims.me header.s=protonmail header.b=B+17TuVY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37636-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37636-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=beims.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69EA6304B155
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E8428463;
	Wed, 10 Jun 2026 16:10:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD94219FF
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 16:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107853; cv=none; b=P/2Fru8PhD0fJF3MxkeEtXS5qjIbwpCscGqiTItLaY3Pc+ARNg/+WFZl7Z/OC2/BfSIe2n+yMWWtw4ef6fJM6tAOEqlZKCXvGSzJ2Sjjgp6ChjBH1bDXIf51sTMS63VBB3y3L5khHYtu2XlFOQV+ZNTzsWZFmlfOwjPOL+CWHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107853; c=relaxed/simple;
	bh=n6myGGLlEswD+VGjTFRSobSrXkL9iSUqLoHocO4EGsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4QwXpR9YRbMeUEPC/Ee6z0bagEHXE/3Gxj/bzNlnlpiGBPyg9BNEJz6TUf6wmznfP8Rg4d8gFa1w5pbGipPKDQDsh8ylzd9pWC18HXTZqeLHPBE8bzCdUlaQS865Rt+WVGJqUg/wkNwfQy9MGrA/yWd0671aJl3qa9i2AT0zJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=B+17TuVY; arc=none smtp.client-ip=185.70.43.170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me;
	s=protonmail; t=1781107840; x=1781367040;
	bh=n6myGGLlEswD+VGjTFRSobSrXkL9iSUqLoHocO4EGsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B+17TuVYAK/T7Tsns3fhiYAGhVIeSUf74wNpJ/4+3mt0gNteGz82Myu67O3ODNF2h
	 ZmUpXKjt/rIVRMj0XEBQpttMyySEOWhxj8He6AYNgEjAfT2F6QT96jsuczDbtw43JP
	 GFi0VZtezYvx9WLaejXgug5MPeRjotFLhroeMIBkr79+xnFBF0IaH6jnm2UVA2AWC1
	 T3toHophlJ8POF0EFWcm8DufFs8icaFD47q/Z+CMab0GhSPp5e9KI0fAeDhTVRzVyf
	 TWMoXuZzvtUU2bY5vi/MQRKWO7bOpLXlTnN30SevCa9PZDP7AFeissnk8KWmFYUndF
	 j6c5xZ2A+/dRA==
X-Pm-Submission-Id: 4gb9jm68gbz2Schx
Date: Wed, 10 Jun 2026 13:10:32 -0300
From: Rafael Beims <rafael@beims.me>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de,
	ulf.hansson@linaro.org
Subject: Re: [PATCH v12 10/22] wifi: nxpwifi: implement cfg80211 ops for STA
 and AP modes
Message-ID: <aimMeKc7yODvwNOT@burns.beims.me>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
 <20260605161335.2415583-11-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605161335.2415583-11-jeff.chen_1@nxp.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[beims.me,quarantine];
	R_DKIM_ALLOW(-0.20)[beims.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37636-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.chen_1@nxp.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafael@beims.me,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[beims.me:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@beims.me,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,burns.beims.me:mid,vger.kernel.org:from_smtp,beims.me:dkim,beims.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 961AD66B5AA

After a quick check, it seems that this patch contains the same
problem being fixed here:
https://lore.kernel.org/all/20260610150021.1018611-1-rafael@beims.me/

Maybe it would be worth it to confirm and fix it before sending the pull request.

Rafael

