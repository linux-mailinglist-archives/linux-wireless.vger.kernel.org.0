Return-Path: <linux-wireless+bounces-34882-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA6zBgnC4Gm8lgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34882-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:03:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7A40D19E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77AEB300BE19
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516430DEAC;
	Thu, 16 Apr 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9hfFIEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B12DEA7B
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337409; cv=pass; b=SOxkux5ghBruXIQrgB17gwSnoP6spTp8Uy5AIfDwM26aujSSpEKjA/Hgr75xi8GGwc65bjhJbEomhUAmDGCNbeGInGDQti60blAxFSGl1RmhyjjDzSeaGSlw3tH3RyqXvsob43lgX92q6NGRj5x+lKm6QLTLugKne+X80jlgpuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337409; c=relaxed/simple;
	bh=FSqE8jrgvskquGpi3bsqdhmSbz3H030pUHE8JrJekAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDqxhRdj0IAlR/gu1ZzE6/qKsIH8Hp4QH511NJkiJaHV+jI3GFVZUo4GK5SSPndjegT5melksyBBtr3u2Nhkg9w3CxswvX9EI0E4IiGZY2+ZOc8cBLuTJ79xiA92s6tlTWhk8EG/OkdSz8vFrJpsbzQg2k+dkP+f7PyRSN1uE50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9hfFIEq; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c6e2355739dso3571753a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776337408; cv=none;
        d=google.com; s=arc-20240605;
        b=WMmo/4BSV87WVKYUNQBg/xaVLImwHtx1+thd+PAcvHwrezfxmVcJYRDKgj7yNcrtcO
         H+COjetOSmVlKRCYD7rCbuTQ532IBu+HkNlHgMU6stW3SPAKJ4+jeNAn3kj0gGlZ/kEX
         E5yhnDgIoCviEiElaNUWc0AhdO28Hcfo6fEE1JdfVwDXoP8NhmSq87NOlRsjLClkMMzJ
         6PnkMqUkCIjMNgQMX+MTzyVrFCx6m2RTlAqBA+9kJx18pnU6KcWExAbHsxckC6UE61Oh
         xuf+gw9v1lu9MW6WOpOIce7jFrpFcpQtX5TumiwBt0M314YJOyDWL23PgX9oq7kdjsm+
         Qkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jfa749J2sCeEfktUiIDDvwCTMiH8adtcJ683ydNNL1g=;
        fh=C6LApgc9NK0pnnt83W+yqOoTu97u7h9piqaZtLW1yPE=;
        b=exZkb5IORsuhMwCd9RpPm7Yk5gPfrA7ZHugsKSgSKa7SlxKjuPPtXuk5+j4W6AoqsY
         ZGaaslyAI2onYRH1qz363JVSiH/1o+UytRoVJcyhrDEX33M9TjjPnvDMM0x0/DVCj341
         x5wnGLso+jmb19ygL2Q5wG3q7wy6EcwfQT3wE0rXb/5wRcKgkHYdcyrmDqfY7ML+5wec
         lSCh6zZ01e0vmu1r6qKHlEgSws9LFb4R55ppYfpIqjkzF0iF9iC0DB53vZpt3cSUqTrL
         PjthNPBJkqL4Hkbu+peSmxyPLMvVxShd8Q1xi+psE6o/LISEDu1ey3x4n6LyddnNRYWN
         jOAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776337408; x=1776942208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfa749J2sCeEfktUiIDDvwCTMiH8adtcJ683ydNNL1g=;
        b=L9hfFIEq2ENWbYjY1FdAp7RwK69uWEvALTLaKPkarGE5nA+1Awx88PSoiiDTxwpdUY
         EOUuq2gevihl4142jp4rILGbZ7+Fwhp56OzcPvZm/805ZmuYEAaH7aWAwRJN5SCPgrxl
         K5IS7Qe59vIbMTkpWrCIcahNbft2bxdwf3qz1T+ISAuzG33LPaR2uwE4OytGWq2dpyQM
         g8vetqNtpKPuKClRT0DFEqvgEnPenJvfFa8f2qmE5F1TaUB5xCyruhRXIOLCeoFZB85b
         1L/8OlDSpzdtckwhfqob6nxJjk+aMNvF6ad9SbKswRaJkMuO0iQgMe4bDQXfBK1Bwfgg
         KMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337408; x=1776942208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfa749J2sCeEfktUiIDDvwCTMiH8adtcJ683ydNNL1g=;
        b=VeRczHnReFDfXv4pv8vxRyvK/iC8+aEM3b9PN+CCRr4Dmh+rNGU947lVej5Ty9Qg5W
         zcaOY/0pvKmPkyiWVtqcAouMwtode/xC5Sjmj2sVn6o9B7Mo7DHydPyFnbsEnvicD6IE
         /AdbXBCpJWp1j0j4wn2856VfQqxJY7ldJLk+yvnZ1h7TNAzzDS0yD7ioE9lHgZjWJOgc
         b9ndwa4pMdgMwps51XEbWqkmjBDlPab5BuE/A7iAZTj7QxhU146ah6ulX9E+VF/hd+Jd
         KZ8AQuApdlZR1MUZq20AtglwQ4VPrnRQTZbBkxlF9HUYeTjOaUJMfeBUI4gwbf0P/F/8
         CANw==
X-Gm-Message-State: AOJu0YwhuoS0gEkvMYSfhuheYTrgK6rLUsy5T/3opt+2RJ7X1GVarGdn
	GTOu+qW8J37p5zbqcgQzYT/itSHwykK/2zjLrQtkfddRtapH/Bx/V837qrthVnQCxz1ShzVN8Bc
	PRBbVTToj3bOR6yj7aI5sTfSkDW/48GtpIKfagOg=
X-Gm-Gg: AeBDietaQsfMU260YXQDXGUqetxP+979EebpTiL2LGYdMixcd/Gpv+kQDFHg3tgg2EH
	ArbVHJgo86eSe5YMACsgdOXDsDdrzUCNI2VsG3wIXvs0DF1q3EUS/+s0BA4OSFJ90ndLNWhdmMJ
	aCHjxJJVeCO+MniYq/gAe9hhr76Mu/EpMoQe76R5Npq69oRl3egINIk+I8Og1q8YMBKOt3LcLzd
	A9XuigrY+JO7l3ob4kltLKpx1hCs1yLbcPP08B9H/TS69fuLF1+wN57K4PUhjEnwDM/abJgvfa3
	5rpX5vDeXK02psirGtuwhw==
X-Received: by 2002:a17:90b:3d01:b0:35f:b4c1:91f6 with SMTP id
 98e67ed59e1d1-35fb4c19544mr15668004a91.10.1776337407736; Thu, 16 Apr 2026
 04:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
In-Reply-To: <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
From: Benson Bear <benson.bear@gmail.com>
Date: Thu, 16 Apr 2026 07:03:16 -0400
X-Gm-Features: AQROBzA3NubvkwMBgE_3onZVk7svq3Qgob4yax3pbpFTzupNuv4yOehFEOzFC4M
Message-ID: <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: Pablo MARTIN-GOMEZ <pablomg@eskapa.be>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34882-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bensonbear@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BF7A40D19E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pablo, thanks for your really prompt reply.   And sorry
for the spelling error in the Subject header ("Mps" for "Mbps")
and the horrid line formatting.  (Not used to using short lines
although that is what I grew up on).

And... you got it!   The MFP flag is lacking, and googling
showed me that instead of  messing with wpa_supplicant, I
can apparently do the same with nmcli:

nmcli connection modify NAME 802-11-wireless-security.pmf disable

I tried that and it worked!   Internet speed test back to 600Mbps!
What a relief!  Thank you very much!

I will try other testing with just pure Wi-Fi and with all machines
after I get some sleep.

Can you tell me why this is likely to have happened?  Surely
one side or the other is misconfigured?  This misunderstanding
between them should not be possible within a good specification,
right?

(Sadly I think I might have an idea -- it's partly my fault.   The
mac80211 module was disabling all HT and above because it
felt it could not meet the BCS criteria laid down by the AP.
Many people have thought these criteria were way too onerous.
So I first had very low speeds because of that.  No HT even.
I applied a patch to the module that ignored these requirements
and got back to a high connection speed, and HE or VHT
enabled, and got back a little of the lost speed.   Clearly very
kludgy but seems a legitimate response to what the patch
author called "aggressive basic MCS rates". But it may
have opened up the room for misunderstandings.  I have my
speed back in practice, but I wonder what the "correct" way
of fixing this would be -- without the kludgy module patch).

Thanks again!

