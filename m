Return-Path: <linux-wireless+bounces-38670-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ritlH0ifS2q4XAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38670-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:27:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2304710832
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:27:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=WW7NU5ub;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38670-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38670-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28935304FA75
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE33191BB;
	Mon,  6 Jul 2026 10:25:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DF44213E
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 10:25:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333531; cv=none; b=R9Oa0kjbyta18siFvQa4ThrRnKqGSgs+7Pxz5hy2eqVkODrtbQlxzgEDvY3a9wi8j/sxoT1d7hSR7qhlZ8wXl0igYfAwB2h+whw9tFuZIxaii/MFozUMAfXGWAD1TbcfUrfR0QrntWBMwJJM/qx3Ksuvx5QuIYjZqE9ZT8svzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333531; c=relaxed/simple;
	bh=wXkmloe32wDeBpHMbchLne5t/itP8cURECNWNe6OBPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tlr2489hQFOAx0PP3QGKEH2AOXEo4zs+5peWGgQyahkAHhymH0q3cCa6PZ7243dd3wqjdyD3fW5My19vVcDg3yUZCiTsXSrhRds+Qf14YrC1Zwijkil5H43oZ8YR68z963IEBTxe9wC9VnRtIpBFkfVWtj/KpIIoYNOuqYdEInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WW7NU5ub; arc=none smtp.client-ip=209.85.160.226
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-51c149c5722so15922291cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333529; x=1783938329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CA5p8dVeCW7g5NSaVGN5KNCsgXkRD8Ko8sUb8IXK2EM=;
        b=TW0n3cZy4twRXoDDQtvGiN9ymZOioHvFl6/5IqKiL7v/4mGgawJMMYnzMQm2KHb+wL
         l9kVxFDFHodO3spGb0dQJf0CDsgldAn2bHZHsO7rpslWK5iaaBHQtINiwnaLTuve7KwV
         fNb8vIIFNqm43qSowvCehs7W9Bnbovo5d2aQot0GaGa6sndoVnbErv+xUPBs42QJHfNY
         ifEOkgbDNGXdV+LgC5590qg5wMmrOWdVyJsV/+JNym/QwfDz1MLqBF//Ro3XbW/ISG9Z
         FUlis1tA3s8dE+/8ZKsmUFGjb1mnhxYHhkz+w36AzSYhXceM2zsvnjjmcQ9hItfNsUSH
         BAcw==
X-Gm-Message-State: AOJu0YyYQo19tQiV53vQfd7Qd1eBGakYEv10XoCJvCceT7SygxIrDJFO
	FkZ937IB91CQ7ArGdTwJHZVUCVntADqUisl+V+Vd4X08Fc0YDpUjNBh747/OJuk4fde9wi1qgZz
	VQPDZ5g/t1dUDwZdLrZsYjcQl4ExB2rCuPZK8VreQPk+8goMtXKP9rFS4cGoOVCJSZ/x34V+YE8
	Q9SmOhZY4OgPGhu7D5+7uoeFHU5WJZsLNDoGfbeCbW5ct95w/+4JsCb2rj2bPmeFTJwVhQsvm6g
	NWH0kYP1aOzHYziErjgRpRzyKGk
X-Gm-Gg: AfdE7clLqsauMfGLhxsXMx4aGQ5sqB7eobS9r+v6OP24Tl5/czR/sJmm4ExRpS5EkFk
	+RVpgt49g7RhBfkneQeSPutpYMjGxE45eVXIrOr/SOnFIOqH/1NwQXZ+q7gp7C6fDBok95SbQFK
	hTzvPfxB8GkNyB3GUq1Kc/n89m7Jup5zeGFPRjKhpEP+J1K0aWbQvVrFrs6uTvSRcotjbnVyaBG
	cCTJZnaQ9ab/s3B5fA0Q+kJQbUQ4D9MP/7bpS+yNYb/ioKOzapzl45qFQzTmEfdxhvbeCPSOnYA
	aDMna3EPtGRttuZfoV/z4W+NU75uT7bbMXSen8ZECRaF60I1YXRRVSPTEZNTT7wXZOM2cOMWAJJ
	OCYKD6x0BUtckO8BqvMJYRpGUFwKiXwKlhDxIF0EBjQ/6vh6iTn7b4ZeaB3onfCz8HW4QTCosWs
	BmD5VnTOb5U6raT4nrgullPoZDLTDmS50OL/EkLYQnanvPyuAfEUwe
X-Received: by 2002:ac8:7d0b:0:b0:51a:8c86:bd2e with SMTP id d75a77b69052e-51c7407ca0cmr290481cf.35.1783333528907;
        Mon, 06 Jul 2026 03:25:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51c41cb2b6dsm4482301cf.16.2026.07.06.03.25.28
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:25:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e63df032bso317888685a.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783333528; x=1783938328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA5p8dVeCW7g5NSaVGN5KNCsgXkRD8Ko8sUb8IXK2EM=;
        b=WW7NU5ubtmnMCQExPTvwSZzJ2P/f6luftYTa9VtKOBuDV5caF2ZpY4fahyerIia/sJ
         LvSOKx8p+vCWcR2Xr5cObFqT52B3dUf6epNmlnrM7uOsXUKfyx+hxhjqW8rjOi/xibr/
         eJy9Mzkm0j5t1b1sICY4wBTXn+gW1PRS8hrP0=
X-Received: by 2002:a05:620a:261c:b0:92e:650f:c39c with SMTP id af79cd13be357-92e8b25d442mr1666946185a.3.1783333528159;
        Mon, 06 Jul 2026 03:25:28 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:92e:650f:c39c with SMTP id af79cd13be357-92e8b25d442mr1666943585a.3.1783333527680;
        Mon, 06 Jul 2026 03:25:27 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c926basm873038785a.22.2026.07.06.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:25:26 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Huang <Jason.Huang2@infineon.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Kurt Lee <kurt.lee@cypress.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: add DPP support and fix fw-supplicant/P2P interop
Date: Mon,  6 Jul 2026 12:25:23 +0200
Message-ID: <20260706102523.1430606-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604034227.590951-1-Jason.Huang2@infineon.com>
References: <20260603035722.145894-1-Jason.Huang2@infineon.com> <20260604034227.590951-1-Jason.Huang2@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Jason.Huang2@infineon.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:kurt.lee@cypress.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38670-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2304710832

On Thu, 4 Jun 2026 11:42:29 +0800, Jason Huang wrote:
> From: Kurt Lee <kurt.lee@cypress.com>
>
> Add DPP support in brcmfmac and include follow-up fixes needed for
> reliable operation with mixed security setups.

[...]

>  		if (sme->crypto.psk) {
>  			if (is_sae_akm &&
>  			    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
>  				profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
>  			} else if (!is_sae_akm &&
>  				   profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
>  				if (WARN_ON(profile->use_fwsup !=
>  					BRCMF_PROFILE_FWSUP_NONE)) {
>  					err = -EINVAL;
>  					goto done;
>  				}
>  				brcmf_dbg(INFO, "using PSK offload\n");
>  				profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
>  			}
>  		} else {
>  			profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
>  		}

The else branch resets use_fwsup unconditionally when psk is NULL. For a pure
SAE connection (sae_pwd set, psk NULL), brcmf_set_key_mgmt() set use_fwsup =
FWSUP_SAE, but the else clears it to NONE. As a result sup_wpa = 0 is written
and the SAE password path below is never reached, breaking WPA3-SAE. Same
problem for 802.1X (FWSUP_1X, psk = NULL).

For DPP, use_fwsup is already FWSUP_NONE at this point, so writing sup_wpa = 0
only when use_fwsup == NONE would achieve the goal without the regression.

This patch will also conflict with the pending "wifi: brcmfmac: fix
802.11x-SHA256 call trace warning" patch as both touch brcmf_set_key_mgmt().
Please rebase on top of it.

The remain-on-channel wdev tracking fix is a pre-existing P2P bug independent of
DPP. Please split it into a separate patch with a Fixes: tag so it can be
backported to stable independently.

Regards,
Arend

