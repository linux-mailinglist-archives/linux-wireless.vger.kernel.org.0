Return-Path: <linux-wireless+bounces-34312-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LGhL2AIzmkvkgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34312-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:10:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9153844B2
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83E4130151D0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D6317148;
	Thu,  2 Apr 2026 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G20XRXs1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1C2D978C;
	Thu,  2 Apr 2026 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110237; cv=none; b=paPEUKkRhoG9vLG4I2Xkgl0+bcJf6RlCHaWttnuVhhSloohez3zcZgn29vD3MkIzD8mL/ARhzVd8gMmN7NN775WVRU4wvGBQjIXbDXuPpY7LUzhCCNSlQYMFoR/8GH010EnT/qf7RF5Ogko5M7jDiyMWuYOx+6SxJV8YSmX8BAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110237; c=relaxed/simple;
	bh=sc41kJiOLLGZqWKFgyTpqbJuZ4SKzbDX6c120/ww51M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rRmrPPw6OiREWxCNRnWwnG1xYfWFbV8BCP+S4Vz6qYX7mfjsBnwzfmOyikuGX/Q/3xkijbBRlkES9MqlxO/z/5pUSrOOwmxzToHxz9xPn3IOKCN90sK03sV3AVviK5Tao4rtifOjlne2BCjwO0wp4EsoGYfClyDHsVhljs+2bSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G20XRXs1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775110220; x=1775715020; i=markus.elfring@web.de;
	bh=C3MReKGY6W5dG+h2Lnc7JydV07h/1i+NeudHyTbkeQ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G20XRXs1ISYWIcg3GVT2tas+AaQptymq+3ZPSuK9vz4sjEsK2Tu9J/Q9VN6cCmXy
	 n3CZDhUUcYQ1UUMpaHvVfEJmxatxeAeVhFN4x0ihKnGRN4k3GHJYyUgSEXFyJGB7c
	 zCCWXBkqk7VFpf/o7l658g/fo9hCUpVFj/JN3HBMsgp5SqvA17Kb/gLp0FFzUmk7X
	 U3sbgmwWuk6jhMfJxzgtvaHZL0jibqv09GyJNkOZq0jqoJ0jcnvkQwVY7H2qeL5g5
	 kZd0ce5dtnJym80NDLZMpa40qvePMXC6XRfg+35EdgCg4RWxK6Ah+FlKtQT0cWsSl
	 SkEoImJCA+jYWIYw/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1vUIGM1VAI-018DjS; Thu, 02
 Apr 2026 08:10:20 +0200
Message-ID: <604fd5a1-135b-4a47-b752-52cb21d8863e@web.de>
Date: Thu, 2 Apr 2026 08:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
 linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260401030555.541685-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2] iwlwifi: dvm: add missing cleaup for on error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260401030555.541685-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yC20lO+HAxEiYeLe1Cmuoq+9QQBygDRo+Q0tzBOuNJ9z1e+cN2o
 Mt4lB+P9J30BusfU27WCz28x86sSaL5E1JZBCSYiUcrVVnAecak3ZHrJeio1bk5ovYW9j3c
 rer2QzjOoUXvxzcQfxMMX6B9DQ9YwJoze4mgUb8SwuEkXHegXcXJsOyfwjN7R4HdK8LUAT6
 KywFcbzWe5J1WaLzXv5Yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5hump0JbnkY=;4QLbaenVRkCTM2PxQKZasCKmXbV
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34312-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E9153844B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> In iwlagn_tx_agg_start(), call iwlagn_dealloc_agg_txq()
> to clear bit on error path.

1. See also:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc6#n659

2. Please choose corresponding tags.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc6#n145
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v7.0-rc6#n34

3. Would you like to avoid a typo in the summary phrase?


Regards,
Markus

