Return-Path: <linux-wireless+bounces-31681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIImHdGfimniMQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:02:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E16B3116A45
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE97302B20A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2113957E;
	Tue, 10 Feb 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMycwz6l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7F6FC3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692557; cv=pass; b=ER/gmhUYJwmRjFDcjBqNtNiiTYup1logCXzPTi0fqedRcl0Qw025NHcKEXxsC4vyZYUTH8anW5WzCWNoyRw+jvHBAowKGO8Wc8qdpD3kqmDHpVn5rZzg5me2/PEuOLyU9xPuEqNb7aS9PfU4w/I/SVHXXZTzMKxMkxI7stK8FhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692557; c=relaxed/simple;
	bh=fEminvrWFtU/oAbYcuIulH2cA+XVHi2dJMXGIY0KVrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DslAIDcAMaZKKgtYJVSi6afP/QFxGnxsdFKB7ZBEcH0wP41wDTX1STxgXn9lET55Niz7DjePS0nPzRtWwlC6rcK/oiL3MSn9LAboCwN/fpLgmoKEJQtu9c1EDrFYJUpWPbiA5kekmoSgREZ04oCfPqkto4bMifapxh0vuCIHKzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMycwz6l; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5032e951106so2998641cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 19:02:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770692555; cv=none;
        d=google.com; s=arc-20240605;
        b=REkclT9f4aqC655ynKqJmxvksGEKs2c2i+IWIigKf+tstKBYLwXiYEp0Ure/qi26Ls
         594Rb4LDvC8GllhScl7mwLLkDwL/hmZESP8EizA6dLudes4Pkd2kS0nokGr6CtNgTkf+
         4vBcqErw07Cns2XduRov+fR8c80EbN+5W8IqaFiPrKn1m8xboEcgs+WmMURph5G4AUkL
         kWV9YK/oYRx0z7Kvn98ceBubj1+l669s6tZWR1z/3mmfcrZAYIi06aOOR6oIzE3GwdaY
         dJempemjcjLjJTqTUYbMssuSBAyhXL7YAB4JWjASp2ovhpMMWSUvI2VyZNOYWwwKT3c1
         iPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FCZyfg/DS8U/cZaGb/surJLWJeSOI8xOwIvC9JqN/OA=;
        fh=ZWfoUpDFJfXf5Hp9P76vkykGT00k9e+xwYPMQKqfm+A=;
        b=KMRRSSHdG0J/XjT4dU1mnG4ARTLJhxS9EGg+E0OSAvjlJ73Uvtja0vc2xQ17A9hTaJ
         1kHQ44EFx9mSDe2aIGZX7rv7DzDqOvxtcgyBeg4549FpSXllLCIDAACCKDOTLnUNjziT
         ZSVq9rkWtFRLCboHUkm4Iq4cY9QknK2EA0SJ6CqqNfuuszx+BaZf8ZZ/wITZ03/AES24
         x9GRcXsPsUv7a91mOe7vdp/5E8aQYtQ9/DJWkp4Mko+ASuAgNB5DNyZCJluzmV8ywPES
         BVPlYFtSqv+YIFXHj5OmMgo16iAFeqB4CnCigDgjZikFp9yfBkAHEfrYQDrkCI0tVKwM
         e2fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770692555; x=1771297355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCZyfg/DS8U/cZaGb/surJLWJeSOI8xOwIvC9JqN/OA=;
        b=hMycwz6l5o1xCfFgtJCuIcGCZEi9zNMfYXhb5QMtEwSHrX4j9G5oEQ0OHM9WC/Ropt
         5vGyP54MhDPY1OCDFGqVHyABnmzendPrxNOw+DCcPv4Peiy/4k9g69Ld9lB+UTzwPZsa
         91agtJbXzCi1hRsyFnyctj98oyD4L2O1LYnmKk406XaWuuX6wgVb0Sapti128hw9la2i
         lPtiUWa99rozUhjJyM1fyIysVnhVLobL/0KLj0s8exwueyRcmX4P3akm4dsZkoIdjr77
         UZJyHYe8Ujffq6ETEQB2T2FLZ1kfpo9MUQ0ApX94eP8zg2VQRS/Hi4FHKtJisPlwhuXQ
         7NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692555; x=1771297355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCZyfg/DS8U/cZaGb/surJLWJeSOI8xOwIvC9JqN/OA=;
        b=rZD1TlWl3rF8Fo19Ftws0y8sowdhwHobCxwFpR35KHtMuHUKdPBVq8/RA3pr6lCzE4
         KC2yBtU+esSWHVdi180pUDdEkNtvEovbIiG/gs+NnHt+8GQvTcqs18I0alzpxjhl0gML
         UwNWJP56MRNdl03uBxnY2sECyRlIjb6SfWCiyY7Cw+JGd8exY2DnAHCP824hcXTp43x9
         fV16OvSW0HgHfCh9jT8wep+SftvxSGDauS8BixqoqMRB18QQ9aU0yChCQQhvYOLUcQAB
         sgvfT8nivIaxlE3AXY3l8xUbaDQl8QQbBBoT/Lyl9PyEj39h+qbzMWcnDapH/rGvFg4q
         m/8g==
X-Forwarded-Encrypted: i=1; AJvYcCWQCOFzgJpUAGTP6vfBuV5jlJGArsaruEGOJ/N0PlyQenhjg69kdZmnG3nZU+IQD9nAh+3Ay6JtzxRVQfia+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+V71LqNMd9c3GJKCrRhbj8fersAsQbyG+gIHH5opVReCT79C
	EAEXlIxMdgjKAxa/LXfbQ8JMwx5xQg8yqXWf2GrOImd4cq1x42/PLO+1aFG6eV85ZMFuHaDVUlx
	x8NtQ4ybxcdIiAQhoWxgBMwoIh6B5ybLl
X-Gm-Gg: AZuq6aLOGmXn9KMpMf8ZkdbZtrBIHiYPo5S+pwC3w9W729srKQmkz7RdtQxIR+4UvVm
	nyBjPHFxIk38/F1/YDbntJYIjJD0rovY05Rq/uxLSKk/u8M5ZC7oGosjxr1QougCF4IPu5v0ibF
	oaMZg733K/P9cfTvAnyGCuEgBV1dHbBqU4gYEp1U0urI/zSZCTXfKVw0+RcWlvQAs8ZKJ1jDVGo
	di7SAP4cNVTMd7YBPeRcGEAn3+s9EqkIVBBkmm8550BzugakIqFuF2HmFSaW8KGM7zoh96ENu8F
	a3IOiBN+JbmFNWi7Mg==
X-Received: by 2002:a05:622a:198d:b0:4e8:baad:9875 with SMTP id
 d75a77b69052e-506398694e7mr197628811cf.4.1770692555276; Mon, 09 Feb 2026
 19:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125222235.36565-1-lucid_duck@justthetip.ca> <20260130215458.52886-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260130215458.52886-1-lucid_duck@justthetip.ca>
From: Nick <morrownr@gmail.com>
Date: Mon, 9 Feb 2026 21:02:09 -0600
X-Gm-Features: AZwV_QhFATj5JXS849J8XI4r2TUg1461s18J5Q28ws44zY2PrDxxKzOXS8PuPmk
Message-ID: <CAFktD2dZwX9-Cq8Pv7NEHE5agDLqVau+4fHjre7Zh+2M_1u3Uw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix txpower reporting
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31681-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E16B3116A45
X-Rspamd-Action: no action

> The mt7921 driver never updates phy->txpower_cur, causing
> mt76_get_txpower() to report incorrect values via nl80211.
> Users see bogus txpower readings (typically 3 dBm or 67 dBm)
> regardless of actual regulatory limits.
>
> Fix this by updating txpower_cur in mt7921_bss_info_changed()
> when BSS_CHANGED_TXPOWER is set. Use bss_conf.txpower as the
> primary source, with a fallback to the channel's max_reg_power
> for cases where bss_conf.txpower is not populated (INT_MIN).
>
> Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.18.6:
>   - 2.4GHz ch1:  33 dBm (30 dBm limit + 3 dBm path delta) - PASS
>   - 5GHz ch100:  27 dBm (24 dBm limit + 3 dBm path delta) - PASS
>   - 6GHz ch5:    15 dBm (12 dBm limit + 3 dBm path delta) - PASS

I just tested this patch with a fresh download of kernel 6.18.8. All I
see is 3 dBm
when running "iw dev". My USB WiFi adapter also uses the mt7921u driver.

Also, something just doesn't seem right with 33, 27 and 15 dBm. You are in CA,
right?

> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index f37a35b..99fe46d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -725,6 +725,25 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
>         if (changed & BSS_CHANGED_CQM)
>                 mt7921_mcu_set_rssimonitor(dev, vif);
>
> +       if (changed & BSS_CHANGED_TXPOWER) {
> +               int tx_power = info->txpower;
> +
> +               /*
> +                * Workaround for kernel 6.18+: bss_conf.txpower may not be
> +                * populated (INT_MIN) even when BSS_CHANGED_TXPOWER is set.
> +                * In this case, use the channel's max regulatory power.
> +                */
> +               if (tx_power == INT_MIN || tx_power <= 0) {
> +                       struct ieee80211_channel *chan = phy->mt76->chandef.chan;
> +                       if (chan)
> +                               tx_power = chan->max_reg_power;
> +               }
> +
> +               /* txpower is in dBm, txpower_cur is in 0.5dBm units */
> +               if (tx_power > 0 && tx_power < 127)
> +                       phy->mt76->txpower_cur = tx_power * 2;
> +       }
> +
>         if (changed & BSS_CHANGED_ASSOC) {
>                 mt7921_mcu_sta_update(dev, NULL, vif, true,
>                                       MT76_STA_INFO_STATE_ASSOC);
> --
> 2.43.0
>

