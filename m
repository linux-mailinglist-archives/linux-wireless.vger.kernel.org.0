Return-Path: <linux-wireless+bounces-35706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBwxJ4s182kUygEAu9opvQ
	(envelope-from <linux-wireless+bounces-35706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:57:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBC4A11DA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0392300469E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287F3C9EE0;
	Thu, 30 Apr 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5ZO948G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B93C2772
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546605; cv=pass; b=HPe3JmbRfiGLwBV3B/uiYeNp3XPNwap4VOS8fr7+yC46wswwq1EkLtbvwBfEfmEaeIKHfUBe/dKtsVlSoPeW8KnA8wfWMKsVDXX0RoNepTM51RR95md9/jJZrFGElcdTdZWSJMTx7zL49TGB5qQFlrke/AsaFGdK5eZRnyhCoGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546605; c=relaxed/simple;
	bh=MwXHvmrcRbKdjprT6HN2tBN2gp+C9/IzHgZSHIApaVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkh9rB/P+czlKGDB7Am8o0GzPfnPvv4dO37PFwRgUwmQmzUXDQUSvf0ggvchhuYc+jz1T9/qHQh4VEh0FZvpMixEzqOcrj4BDTzWg7mXGVfgU+un5gZ4nD+Ehrxrc69fKU2fON8fUnNpkWY3By4koJ7qdI8PNrgybiMazpY/3a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5ZO948G; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-42c0b0ffac1so351276fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 03:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777546603; cv=none;
        d=google.com; s=arc-20240605;
        b=BrG7RZFJa0j+7E7jE7scMgq3Rw08nFxoiqFZqFOqp6yCpNceZ1qKf+vUJ8UOmntGOK
         QQvfbw2Hg0cFxs7D/UDFzIi2MBGiFAijCWWGoRwv7y3wng6m8gfOP+mknP47KZTe4aF3
         TZSZaTnCxUmSKb+IdwpXao2deON7Bo4teIYzamAaNA+83UGddQRz1YS/Xg/bZBwepPkX
         7UB//a3ncgHmnzeMuOPdS+5tOmYBuDD3uwYMw8XoxnaTYgWPzfe8JQm0XSz1fvEcXu7J
         Nyo7yhpiKXIWjn0/I22NNzyLHKKuIBoAyJCNFQc1roDAl5GYPndJZpneyMDhnZmqv8R9
         Aagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0PZtKo1YB+mPEa2qZH7DkJZdcjilHXg7MC/OVZKoRRA=;
        fh=HrjnhIYG3TGiODzIxEQff+e1/QHZPZZCjqfMgomyt4s=;
        b=f1YcwlE9u+YbjW3bHNpQxFbRbZcR8KMMHery6vz2/QZOaWRPd23RIbdqMVwnO29Z3J
         uR7UiYcjeh1EPRCzxPpxgxdVu9aETaymt1l0CCUiPHrezLPaGiYLkACOwpGxgHMM/1Wt
         qQ64QOhUrZuOnKMy9YyfknHZwC4ysdNcavYfKaEbWWf+rdC+vWBFts9HC+7WE0eWNkcx
         KUHpdvCck2xR5IWfNrl48AvYMHtKH4ZjTWKo9CKlTTYtPL04cLp57m4s8e4BWLB+snLW
         eKSLlwBhkhDPPR2O6ycYOdCVWQ5iaRrI5unTJjMJB4MdvzMWTbxZd62IBTLOrdPke+Hk
         Ntew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546603; x=1778151403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PZtKo1YB+mPEa2qZH7DkJZdcjilHXg7MC/OVZKoRRA=;
        b=V5ZO948GvTfD6Ob8VJ02tzZS0Tw9av5VPVSt39201AjdUbcAh6ASOgFPFU4C8lJllV
         ZkKmqJBGXcTOyMOSW2WsRi6vthZImBTbOF5jinJsy3smCcSjbrUVEoAvlVxMePf7n2SQ
         JEEgF7sLkFFZ0Je7PKTmRbAgHVl1mXSmYOyf0VLch9ozfovESZ0dPO9dIjrDyoEYApNY
         ARVkgOnwdy99Pgs9dwGfrEDbCzOLNqFXEhlZQAIgHtrl+Ygzpeag2CpAemyAhjPsvnBK
         IefdNa6gA04oac+UsByoB+r/+pExbW6EQeikqm9MI5ak5LWnP/hOqkH9HQqoBldG9+ra
         TwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546603; x=1778151403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PZtKo1YB+mPEa2qZH7DkJZdcjilHXg7MC/OVZKoRRA=;
        b=XmLVh/osWbcunXIz62Ibnb3h0rZvbQ9CqPEFpNHFyj6DAn81yMm9aAiAT91WmXStoe
         v0hZnrXkj8Gjd6BcFJ+ml4OiERc5JdyfEdil7KrlykIUjjOk1hk2dpeUf3kUySUC0sBt
         0vWOHYjOf4W3/uTjN5rJt/UQJFQcSZCbPV/NsPhURZ4rWu2cNIG/vjziAb8chqqas3+A
         UcNsiisl2TlSgeSrMSNmLlZIeHWCbPdq36VNud0ILkV/4yJrznbHZ+1pMe0rtsFk1YWU
         4JRnVvh0EQ1avIT8RfWGCNKLeFRBPlNAUB7g3QKCCUxxGhWFornH58rYjoNZwVztRsKW
         v7kA==
X-Forwarded-Encrypted: i=1; AFNElJ8Q9PMir887dR/vMGRB5vmm0cPAcBRczx09ZRBZtK7LRfShQqFL+Ke5/wj1dWDehhOfE04n02zWMyong4Wq9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIeXC2Du4Wm3qxeT2z/5njrMqfOK06quVA4D3CikzeS78Y1Yx
	3FJCFmRwc0wcRsqZn6PHQcxjrYzfXM28veksImZb7g78bwg1JdYI98wRFOYFnieTGuxCeAQKQ6j
	NoTVgPAz1g9YlQV8Ry/6AvPjAMuB8a/yvs91V3w9srw==
X-Gm-Gg: AeBDieuv92AcOwDEc8zD72mhkr0sQNEOKqujXYKO+XIkIZGpK+R2l5fSe4/uREMSs1z
	tkiZFccJ0Tf1XgNWb0kbOT3q+2jTd9TN2DfqNtrhTK4U8t6AkUVCTpRy7i/gERTB0yIW/4MImdm
	bUxYIB1Yb7NuQ/HrmjnebVrYYFkHCaAMqh3NcTGTpmpxXe8xH5/krB6OX2ooFCPoaxMdkzevuZ3
	yukfIx6Vl26KPaA4kFWl1K4w/TkSwI/kYMKjRs+qVhJjwzs/AgDIRpTzScm7d3+z6HqqWhM+IpT
	eMqOtpQcm7LpTAprX5cXw5vQm/KVbw==
X-Received: by 2002:a05:6870:fba8:b0:423:a076:9034 with SMTP id
 586e51a60fabf-434337146dfmr1308335fac.5.1777546603127; Thu, 30 Apr 2026
 03:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com> <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
 <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
 <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
 <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com>
 <4f40d96c-4cd5-4e01-846b-745e346b6744@gmail.com> <CALdGYqSAr9kgFQw5=fht1N4Tn3JEZwro8f+JveDGMU3VVYNvzg@mail.gmail.com>
 <CALdGYqTRqWO_3aZewGKix=PWROnXXdYiLYS00faBKymhEKcC-w@mail.gmail.com> <CALdGYqQio_byfdhDdc8hhebg2gDuB1MzFW0gv_39S5JJnN0FzQ@mail.gmail.com>
In-Reply-To: <CALdGYqQio_byfdhDdc8hhebg2gDuB1MzFW0gv_39S5JJnN0FzQ@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Thu, 30 Apr 2026 13:56:05 +0300
X-Gm-Features: AVHnY4Kikyl5OUnYJr7GveLpe3U3SS0QuvF41mXRzfBT_1lxuHOJvq5ukQ30aNw
Message-ID: <CALdGYqRhDJjB2p2QGWtpf14_ZbiEXnKm6Yrg+ChxgxhWfHjJ9g@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E0FBC4A11DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35706-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi Bitterblue, Ping-Ke,

Please excuse the quick follow-up to my previous email. After looking
at the code again, I realized my previous suggestion (changing the
`query_phy_status` callback to return an `int`) was unnecessarily
invasive, as it would require touching the `ops` struct for all
chipsets.

I wanted to share a much simpler alternative that I found, which seems
to address the issue of invalid PHY status pages without any
structural changes.

Currently, when `query_phy_status()` encounters an invalid page (the
`default:` case), it prints the "unused phy status page" warning and
returns, leaving `pkt_stat->phy_status` set to true, but the actual
signal and RSSI values uninitialized (zero).

This leads to two minor issues downstream:
1. In `rtw_rx_fill_rx_status()`, mac80211 gets passed a false `signal=0` value.
2. In `rtw_rx_addr_match()`, the frame passes the
`!pkt_stat->phy_status` check, causing `ewma_rssi_add(&si->avg_rssi,
pkt_stat->rssi)` to be called with a 0 value, which corrupts the
moving average of the RSSI.

It seems this could be completely resolved by simply adding one line
to the `default:` case in `query_phy_status()` (e.g., in
`rtw8821c.c`):

--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -677,6 +677,7 @@ static void query_phy_status(struct rtw_dev
*rtwdev, u8 *phy_status,
  break;
  default:
  rtw_warn(rtwdev, "unused phy status page (%d)\n", page);
+ pkt_stat->phy_status = false;
  return;
  }
 }

By explicitly marking the PHY status as invalid before returning:
- `rtw_rx_fill_rx_status()` will correctly fall into the `else` block
and set `rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;`.
- `rtw_rx_addr_match()` will correctly early-return, protecting the
RSSI moving average.

The frame itself is still passed to mac80211 (since the payload might
be valid), but without the bogus signal metadata.

Again, this is just an amateur observation from reviewing the code
while testing the recent RX descriptor patches. The current patches
are running flawlessly on my end. I leave it to your expertise to
decide if this one-line addition is worthwhile.

Best regards,
Oleksandr Havrylov

