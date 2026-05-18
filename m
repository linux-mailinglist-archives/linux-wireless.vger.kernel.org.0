Return-Path: <linux-wireless+bounces-36595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAnoOWTWCmqc8gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 11:05:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8CF56952A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64EFA30075E3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681103E3DB7;
	Mon, 18 May 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVgwnM7b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376D2367D3
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094855; cv=pass; b=PqyiaqgqkADBfQClo3AvgjSULFvXqR73Gaued0esSHHPm7RlZkRxBh+gbgb+F0BgdL/JAlfeB21rXMTetGwv7m3Bv3QrXjAz7wSG1T78XS46L9PgDNHbqo3WccFYxIqoZG+b0Jytlv27iFJR9dGjnEW3Vvph1wxhgykJBNzzGVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094855; c=relaxed/simple;
	bh=toLnmszmRH8S7X8n8IPbcj9Ttyhu7NqB4dd5wTBY0NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrSEwOSiwJ1ZYrMgyg+86R2J9yVNeE+YkqeGrIJ5vEBgMbSlifUN+pgTnDZvXq+OfczxUOK4hgIKcd6DkA9pSgLC3A1yVTTR1pbjRCDUA+OTbhRwQrcmk8WIdeSbRxaTLg0JPvJdG88DsyZzcUC/8ne09mJcNKidgO84OqxaBYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVgwnM7b; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso3549141a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 02:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779094852; cv=none;
        d=google.com; s=arc-20240605;
        b=gYY7EQ4DQlsoK29L05KvYNYaz0DEMgboy3OLQr1+C7oQz3nQI6hUZTKZgloulmllYK
         7N1kblvqbco7h/J7KBaqP2UVFOMZQNRBn4hPhdjV0WDMl2yC+BceHfFt9J50hk8Jmb4V
         n7yIuMggpMIAvzf5BByr1zZlxBbXCdMiR7isLV3gVvsgP52RkAbGU8tF5SNQ4nJuJsDH
         rxI1fQ692HZNSk5QbNIPjiu3JSk1M+NoQCxFp0Zyy/03LNnNKTjJbx30Uk+aTafIZgLK
         pTDVCwpRbWnDr0BHwcqFPeAeyZ0KdXYnBMq4/YpPHyu0jVLZSODD3NjeHzUqjJydlmAj
         en4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNpE3lYGeoeKlcj71cF5XkhLwAuKB/sgpWjTF2ZBW6c=;
        fh=ecY3AWkosI496fCOyvqOhMbTWue0THHhofPeVGmnugU=;
        b=QPJzYDJV6IriNLCJ+43Op805uN8ArBMb0NwiQVdIfwJpOxeiMJG7//oMQ+ICxKqhbp
         v38XqSbcNEFpvocvkotvpBSQdGdH5wVhunxSKA1tTzUlkto8ixQQMJKOf1zmW5hjQX/U
         eNPJP7D8KVk8R07k0rBlin0pDIZ0Xb2mXgnqhXR5aB7kcy0gbfBIeer6wU5ruaIXcJby
         98KVsD800JrdJRmxrGVzcq46K1Li0QiRjzbmIiYwadTYApsUVbfNwgRt5SEuLFkwHG2D
         O//Gx/3Ywvz+6Mk+5vNXgnR/QSmZZbjD7JxzAuMECLAcpHJQFsbi8AvMrUnjAFlmHRoL
         +Edg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779094852; x=1779699652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNpE3lYGeoeKlcj71cF5XkhLwAuKB/sgpWjTF2ZBW6c=;
        b=nVgwnM7bHsiv9LM4TPHm/LiYtE7XYDfoFEUaSmzaTztjeYgGTEVmgeTyoY8ujMucWB
         y2F1lAHbLjxZ1cR8s5tmH7inb99yXnJ/uclj8cVr2Gr/POJFoVx3PjFKImyg3Znom5w5
         bYKguP9gBG6cblDWDHEK7Zjhh+TO/FmqO4ktKC+IIYbODDVrMUKNEaQE1HogdPPX9XdK
         m9uynR6/lJ/XFObdIeKb+6a+FHDaP7ZK014Iqdfra4V3b6YHBN1ynEjo9slXlOIOFT4w
         b4zAKuQ4Rr82bq0LYjXuP8nNTrAJLe0e2Qo2z0SBwuNmIwf1pFV+G/tUxGvhb9vLaxen
         6q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779094852; x=1779699652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FNpE3lYGeoeKlcj71cF5XkhLwAuKB/sgpWjTF2ZBW6c=;
        b=A6x6oS/AmgUlXkSOjevoETZ1FSQoXSq8q1pEvbFWstYqXzvDHeL7aCLXXweGVJBg5U
         4VgwnfCc9rLZfGg9DDBmnpHkICdXxpRsftXDp4roFEoh9LVoI3gBqAOmuehoe1T4Mcz5
         4u7MtxiWj74L/F2KEd37fygn1FSJCOQQwyXQc8XWVXoXFuNh6WtYNOa02rozDLjDsr4t
         otWJpj0mHoBUAyAUrLugHXypr28nb4zEffG92KCOXZcOWHWox+44OBy2CgsWtjhb8n+X
         /W/NoPKB4Lxpu/NYGlehyFuU2otrtEQe6nrOmPiADjaHxLdkWZ5mxYbKNn3bir7jXzdD
         731g==
X-Gm-Message-State: AOJu0YxSKviCZaTnaE7NJzix0u2IQa6qY1/XcgI7ux5KIo1Y1AAuMCJN
	XVvriqWqQvM6t8KkMEqnJwtnBy29MxJuW3+RYoq3VfenL2MiyUALhJ1w7Irg6DkF4h4E0IKcTaf
	zZtnzmmMP8ZR5PqEXc8VoTwh+pg9kLjk=
X-Gm-Gg: Acq92OF0dF0OSjBAtO0/EEJ+C7+trOodyY4lO3qpYYVDuOo6YK6N32ObeSvfD/EfV9A
	OVfEHjsCBzhJoUua7IJIAJLk+3R0PpNOIPtv8C3/3wOdCv1oLnP/PicptO0MHFvh609ly9Kl7iP
	c0BujhEOBOQNF/mUtBvaj8i+mCyJZSQnfTYvi90NcP6sEcTWk8Qm8AwtUPnOQ5rGDm7h7Rfrjys
	DeIQxp79rUNfzux+F6KucI0RpRTkrBDb5x5knUj4H2uCcwIQkKXI/kIDI7b3CXD2tdUDqPEap81
	5rVQ4WP0
X-Received: by 2002:a05:6402:11d2:b0:673:b696:8823 with SMTP id
 4fb4d7f45d1cf-683bd28aadcmr6943638a12.15.1779094852093; Mon, 18 May 2026
 02:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHrRpu=-ngPpe2MsmWz0gQq1VVxbr9L0+jUos3o62wPUY-wXqQ@mail.gmail.com>
 <20260518074743.179402-1-maashif011@gmail.com>
In-Reply-To: <20260518074743.179402-1-maashif011@gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 18 May 2026 17:00:39 +0800
X-Gm-Features: AVHnY4KXHtzi7zm3bUuHzFr8ihDjpZR2CNoduByYfz8_mPayjL-Q9goLSPeL9dQ
Message-ID: <CAHrRpumxeADuUXs4M+ZQstH9rp359xH3PL3X_yb2ojhRhrM-_w@mail.gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
To: Mohamed Aashif <maashif011@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4B8CF56952A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36595-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Action: no action

Mohamed Aashif <maashif011@gmail.com> wrote=EF=BC=9A
>
> Update Sri Lanka regulatory domain based on the RTTE Type Approval
> Rules 2020 from the Telecommunications Regulatory Commission of
> Sri Lanka (TRC).
>
> Source: https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-Engli=
sh.pdf
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
> Note: The TRC gazette conflicts internally by allowing 30 dBm for
> 5725-5875 MHz while citing EN 301 893 (which doesn't cover this band).
> Lacking TRC clarification, we conservatively default to the ETSI
> EN 302 502 limits (24 dBm).
>
> Signed-off-by: Mohamed Aashif <maashif011@gmail.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

