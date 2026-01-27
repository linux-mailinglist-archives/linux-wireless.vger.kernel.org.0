Return-Path: <linux-wireless+bounces-31194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IpHMBIceGnooAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 02:59:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6578ED5B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 02:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03B663022907
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D26239E9B;
	Tue, 27 Jan 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBTjPy7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74D20311
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479182; cv=pass; b=PXQ/GyPDwL5RBGPeF0P4MqnGNMEIJE82mqFJuK3glbNqfe+D88Ps3KvHGXOzdZIgrr+f6uFZ3Sac+ud4J0FdyWrvUOvYjLG2wU4hjLisq5e1b5p7+jw43f91fJ6abiu89tGaaQqoBz8juTwBJuz/Kef4rbLXfGvtRuyHJxP+DfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479182; c=relaxed/simple;
	bh=lfZMq/FpiIrRRAuMM9391z+tYTxhFUphA3opClREgPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9KXV4zKa6Lgd5I6r9IXcmfqxxF6JyNGp0bort3U3QjDScwiX22zWhmAPsJMRS3hxYNqwrp+V/F5aFlKzhqux3nUnK9S701qymdA6yuJTa5SwGcFIY0WRVEQEX+BLc/FNQUrrRUrhXMg5UFaklSX3O03EQ163ZP3byN9lm+LgKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBTjPy7Q; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501506f448bso32100541cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769479180; cv=none;
        d=google.com; s=arc-20240605;
        b=ksLicDl7uCs36HisQucXXfXaju9U7P+OwqCytxcpZwEiQa7sGVn+oUBTL+O3SDrAfS
         Cnr+ur5ItPLWjELDggjPw41UTxQD0sKyhDnlAihWJAtVXwqB9eHAsXOeKaUlfvaqU6rQ
         oIhg2uaesSYkFetMI5DYYt+JXp4krpylHHxvhRfq7sqhK2YlIAql1Vdcymw76PSSA/W1
         cFDQXYWz7c5KQKxvMGL0+sjC/C/UKIncnEC4CYzgkfVOcYSRNrst4ckoyz1ND+AaJrju
         /2eWShjvetNKqgbK1Xh3IamSYL2sgk7HRcRfqv2tn/isO/pkq6COK3ciSCPZ3kFrD2xj
         NSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fp3BaSbQQ0q+wx7rdCQJbxcEyE4XtIgDn53dS8QK6Ow=;
        fh=72XZa5poSvLRVMej0cIRnyw4ShV49J0zQDPsLtLuTus=;
        b=Clk1R8oTExC0+o3XqBgGzmklfpEuZbT435NZ8/fvp3PhMjWBLXvurBAzcTB6/K2dI2
         v7hR5+B4rQm6P7gVyIQX8VvbzeFPkDWIB2e+ZM9AAqISL0nMIemG0VElAvrdflC/Vrwb
         /v3suyz6d3or0K1KZrIlmdsBkASgtFSNoZyu64l9Xzv92WNayS2QIfKZddNY6jpGdHYG
         Huk3IVHxyHaQZRZZ8PZxX4Gtlos905kVWg9ONi2l/UExStq1f7nviS+OGWIGA7KzlwBV
         WK8slXM6rxFtuVLrRsqRCxeacQl9axloMD4WpGAHzjNtYxMh3VIRcivPkjcHOVhTnE3M
         9VwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479180; x=1770083980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fp3BaSbQQ0q+wx7rdCQJbxcEyE4XtIgDn53dS8QK6Ow=;
        b=lBTjPy7QYbzbAWUT9Ph3lL/gSAwZqJYxc4IZM97xmgoWYIfZ8si29rJvIJQJ9ylv4E
         JsE6hccDjHjCRUTpO3eJ8jeCzd/Orz2R035R0djV5SpSzsAcuM8BJZZ1feBgbGGBl+mf
         MIDmUi8N1ut+W5gQQGg+kxyTbf7HP1q1njAwYCZ0oAlf4OLhgbNDAyJl6WArDZ7DU874
         HNAQc0jfQf9r7tSG9lcapn4fEdE5/IFq+CEy7A1B1JmIbihMQftHDYo4uchmhycEzpD1
         WRKJab8U/Kv8teB+3V5YTaf3+ag63myiNeR2RgVUW+uylSeU1MdBhICg+F5CaxQax+p9
         hIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479180; x=1770083980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp3BaSbQQ0q+wx7rdCQJbxcEyE4XtIgDn53dS8QK6Ow=;
        b=BVDuDuL7fF0whNEI1bkNctNPEDI6WGFZf02JfR3qN91Q/EOeLeKb7RH2rbsC83qlYC
         N+YG0rxBiq84UNuFtm9uwk4hGYCvbGOEDurMoGZ4StzvQxGyIfhd5EH+U6BJ+u0Yv8KB
         g65AjIeQMLMS5V6W9yoS0A2TUmRtX2rCECwrqnwbAhx7drVksH01LTvHQIgzmkNNAlVM
         nR//CjvxV59J3mQshYHCI/FytVG6NU1KwzYk1O+2ldxtF828MIKmA1qG9TQbNW4C5KuP
         2jhRSC5TYBPAzfiuvAUXqahpPOoXnhfpYbCd2UIAO8Wfd3xOlYtVxpXWPH5ctPJ9YAV1
         Ckiw==
X-Gm-Message-State: AOJu0Yw8eWvwInXV3OyX9BaF7kPx1go5iU8vSDwhRQjrz90lQqal8kKX
	A1/W2I1iZkyuDcjjXlNUJrdEjdpUT0FlU5F1EuQTyEP8TmjGNmlCcgUx59D6N0ykYz8f/skS4OY
	3PSOfJ2CtlsEFyHzAUI4ZQRlLXqN3mZByZHg=
X-Gm-Gg: AZuq6aJa/T+ewLk3yFZNL3OEttU6znvy6pqEo6t1ggcjhhR3JyPtljhChy8HsNStBRd
	bvoT2BEocAAxnObqjrgwDxubbong8rujBtVHNRgezpZhbtTYi3Qa24RDBMCGoNakPmNIBWdwfcn
	Q+fIMOGpr5OSacl7VLChpqvQsoLdEebVbjIyXzMVcJBI65kksXhbkWQLYI1R4BeE5U1tzhaZJEj
	YJdPJIij2O3kgdw7mIfBix19QlbJ1D6wG4B6hnqmRVNNaruktGVqhBDze1HCd2rgJ4RLmuQCiVl
	qvGUvcpKCsTy3xl9
X-Received: by 2002:a05:622a:28e:b0:501:45d8:ea85 with SMTP id
 d75a77b69052e-5032f76f8e3mr1635181cf.18.1769479179920; Mon, 26 Jan 2026
 17:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125222235.36565-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260125222235.36565-1-lucid_duck@justthetip.ca>
From: Nick <morrownr@gmail.com>
Date: Mon, 26 Jan 2026 19:59:14 -0600
X-Gm-Features: AZwV_QhKfuxxCwdAyt2XK9qMe6fBgXhpwoaQMr7SEvtbQdrrdzzYpt4lURrMPLo
Message-ID: <CAFktD2dk8nj8m846fNUWHACWSzq8Mvcxb5U+vmGshEbuXeK2=A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: connac: fix txpower_cur not being updated
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31194-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B6578ED5B
X-Rspamd-Action: no action

> The mt76_connac_mcu_set_rate_txpower() function sends TX power settings
> to the firmware but never updates phy->txpower_cur. This causes
> mt76_get_txpower() to return stale or incorrect values (typically
> showing 3 dBm regardless of actual transmit power) when userspace
> queries TX power via nl80211.
>
> This affects MT7921 and other connac-based devices. Users observe:
>   $ iw dev wlan0 info
>   ...
>   txpower 3.00 dBm
>
> The firmware receives and applies the correct power level, but the
> reported value is wrong because txpower_cur is never set.
>
> Fix by updating phy->txpower_cur after successfully configuring TX
> power, matching the behavior of other mt76 drivers like mt7915.
>
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 045771228..7cd357419 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2251,7 +2251,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>
>  int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
>  {
> -       int err;
> +       int err, tx_power;
>
>         if (phy->cap.has_2ghz) {
>                 err = mt76_connac_mcu_rate_txpower_band(phy,
> @@ -2272,6 +2272,12 @@ int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
>                         return err;
>         }
>
> +       /* Update txpower_cur for accurate reporting via nl80211 */
> +       tx_power = 2 * phy->hw->conf.power_level;
> +       if (!tx_power)
> +               tx_power = 127;
> +       phy->txpower_cur = tx_power;
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
> --
> 2.52.0
>

Tested on kernel 6.18.7

 $ iw dev
phy#0
Unnamed/non-netdev interface
wdev 0x2
addr 76:19:f8:16:a4:48
type P2P-device
txpower 67.00 dBm
Interface wlan0
ifindex 3
wdev 0x1
addr 74:19:f8:16:a4:48
type managed
txpower 67.00 dBm
...

Device tested is a USB WiFi adapter using the mt7921u driver. The
txpower output is not correct.

This is a problem that really needs to be fixed. My hope is that those
that know how to help, do so.

