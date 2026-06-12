Return-Path: <linux-wireless+bounces-37687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oltGCcJYK2ot7gMAu9opvQ
	(envelope-from <linux-wireless+bounces-37687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:54:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F58676046
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=lh2hyXdf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37687-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37687-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2006630095C2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE725228C;
	Fri, 12 Jun 2026 00:54:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8778F4A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 00:54:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225660; cv=none; b=JnuP6Kdv5jFqtmvNREFEYJIWHT5Y7WGTXvwH98MZVT/pQeDWaLJNZLWZdUbNWabWGTSf/e1JdRy6Awk6iH2ktIjCtd/HAcVi98CKHA+bEpTx8XGU5xKvdpRF/yau5K7+vTttJo5o7tifawnrFdPrfmda3h6PLFdkEHVbzWbwZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225660; c=relaxed/simple;
	bh=IgWK4QwOggpqffFi8zzCuP2iTWUQZGV2bDAQa+u6lxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvD/vZuTlcpSnr0KVTsSXa5aw6VOdu6JbOuOY6qGA9XhoK653wx++920GcwC3WEN2xGRRcXkfNmir/1InBDXWe6KkPHiKOUb0Umodqx1Te3FJuQC3ay4llX35zi7A717lqLFGzA8oGqdZ8CLuTfkyDbm8GD+ExEayBSn9ompfBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=lh2hyXdf; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c2a68d01so2978605ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 17:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1781225659; x=1781830459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgWK4QwOggpqffFi8zzCuP2iTWUQZGV2bDAQa+u6lxY=;
        b=lh2hyXdfcYI/ENGX24XW562jVKpqXWhr6GfirNB+n1/iUBzzGHegJTPAJt4nlfUBFr
         Uh27Zb/YYy6+uemzbTmlsHmqL8u6rXA1/XHZye7d0GVIptM1dzF9TYqJDoUc+XFSnmAb
         aTA7wcrQVrIlclXyXRzCfeaqq3U7oqzCJhWY9FCBGlKpVfe6l0UJGqG/Ey45/oMnP+l/
         UcSyZ00r0aNpR0hAtC8WgiH94AchHeUtYlkFXH4KjEM811rj4d3eeeBdAIHZaSv4QbOd
         aaMoa3QaNugH11+l7AsWIG/phr2kMUdfW/eFVt2osWi6ho8Ei9Z4VcsbwThlAjpJCeoe
         ubdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225659; x=1781830459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgWK4QwOggpqffFi8zzCuP2iTWUQZGV2bDAQa+u6lxY=;
        b=S9M1QF1u1Hq5UFWLoVVl/onSoZyO4LUGQCoRzkPgk3NUZPLIThgA3hwl7T11cSm6oC
         g43qL91SYyyp+hYYtAXMpj1l4BdRVY+D5n1SSaurtpjIOjvamCA4LjE51gdRe7QzaGdK
         W93uE+vZff1NzJHyP4dhy5D8yjx2uMRwP2T/cVY8EfGNpI9r9CjXDkLTjBIFcRAq+cZI
         L+KvQbVt2IWnCGb+VREXu71oNshihAPdwNxpBeE5nPm2Do9zB4PvRouAa9FXlDXOSh1m
         R1gmMrmdPVI9LpwnZvSZ6NUZdvjYU9SslZuEBD6KXvvnKiXzNl5fcMHzpb8TIaWW8v+m
         WciA==
X-Forwarded-Encrypted: i=1; AFNElJ+sWJETo6U15DN4oEJdmFM08C0u5aO0jdaZHljyUlShmOZhosdsCfy+4zG2n+UMNYsvkwJ58Ho1bYIGCWyUtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nFRLTsyBPfG5N23rmtjySxSrwmAaAide8LjPmyFP+KyaXr5z
	Zhgh+4eg1fCxsXYNGkFzmr9UzbEhgSATFrjtTAekylrf/DrFzTzVoT9y3kXTpwjZzcE=
X-Gm-Gg: Acq92OHrAbl7UtcPSjL1Ei5/jkavLKmJKhkOPloBYcF9uch2Og0YCN912oij4xzCRnB
	TYvC+YGkcq39NMuo0DpUbpf69S8WnjkoSmvK6D+GuZcTMSYcEgG3wUNUsSg7wO+qNRJx7IB3ajm
	yzIh/+ChhDvDCJKEKSwDkROnnyNiulj2b3QsBnB88od7XiqjN19P1f531tsD5CGMF2CZfpaFrxx
	Q35wyx2z2J9aWhEhpoxIGqry0bcMtkmx+w1L3cS5PauULN7ySquawW2N+VBPGPpgpnBq4dJQeXQ
	zQopLpPgRe0r7vSaZb6lr4EaVUUHPCRQbbDRV6Xi2+CH6r422xj7HBWFMABu17cfh07CkcwEpdN
	RCJ68oRGOf0EuwNDecH06AwOAOtwTLNPm39dZrzZLPN9uBrpyRMeGHWxz1A1VfuEfhuhCyMRO60
	/HFwKXEWMJSwnPR418IVY1qpwZc04JHZFYyxyLFApXcOQomThhXQWbxWL2k1VqzFWj
X-Received: by 2002:a17:902:ebcb:b0:2c2:75c4:4b0f with SMTP id d9443c01a7336-2c40ff3a21emr8524485ad.2.1781225659041;
        Thu, 11 Jun 2026 17:54:19 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433369c8asm1417545ad.73.2026.06.11.17.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 17:54:18 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:54:14 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Pedersen <thomas@adapt-ip.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] wifi: handle S1G and extension-frame RX layout
Message-ID: <44nzahhupgftm5sqwtm4jrnpqaqnywgmvu5r7ttmwcsa6b7p72@pid7epae22cf>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611161943.91069-4-enderaoelyther@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enderaoelyther@gmail.com,m:johannes@sipsolutions.net,m:thomas@adapt-ip.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37687-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,morsemicro.com:from_mime,pid7epae22cf:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18F58676046

> For process clarity: I used AI-assisted tooling for data-flow tracing,
> state-machine analysis, code review, security checks, side-effect review,
> and patch drafting. I reviewed the result and take responsibility for the
> submission.

FWIW I believe Johannes was saying you need to disclose via the
assisted-by tags [1] on each individual patch, not the cover letter
(since that is not applied)

Thanks for these fixes though :)

lachlan

[1] https://docs.kernel.org/process/coding-assistants.html#attribution

