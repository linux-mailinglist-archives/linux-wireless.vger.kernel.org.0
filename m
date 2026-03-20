Return-Path: <linux-wireless+bounces-33535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUyBN+gvGmc1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:20:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7F2D49D8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CDE308957C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DE26461F;
	Fri, 20 Mar 2026 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEdIMsps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D83C465
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969627; cv=pass; b=H5ZR2d53Iz4hWDLfwBcsDjBzFcGbuKQmwLTasxsTImV1r+kp0BUZ29uc+VxiP7UyhiaoLPwaM9PUMcOw4zuzVoMXx7MqYAmKeZbgzsjmoOZd992J9amlL2WNGPPdyUY+F962woicLG2AmjsICY2yY4T2Fnp7BG551GXUKP03bRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969627; c=relaxed/simple;
	bh=woB8YM3lsH0LqvOgxXg9qchSflhcLImeKMVClIzw5zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7NefphuQqEPj8v4tOahWDgCxUKd0ooG4EaW6SHHEk4IKI9QFG+9PM/d1TOxd23QiZnRYcYXQwPcydX40FxJrojgn/MQe4YeshuAZd5a8kosjByM7hW4mSdNK/M0kLSiflbD3+rlarb7eyYxDS751jYePMOf9V9cS/oDVmdRsek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEdIMsps; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46701f2077cso1866051b6e.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773969625; cv=none;
        d=google.com; s=arc-20240605;
        b=E8OVkkK6HKsNEXxGbfzFLqST+1FgTae2FF43Uji6iJbO2AVd23iYLbjDb3lxrGo+Nf
         0F8zzF/F0J+MwYG5MhMcSkzRR36d10Y64KBdbtLfqM5uT/+cvMDiyN6KLQJTe5LmHzQ6
         K8eAORSXDIVAhOT8A4Q+GN9qBWYJ9C/H06EiW7gd4VPv2asOBzn2CuFKPSn3ZEchUjwW
         L86moUXEWxaREQcgKPwQmoWGi9tTX5q0ZOusDDTgg2skuFjRmQhOZgsFq+zdxjCBu3ES
         uMYMZMFN5NJsAVDQmhO629VmmydYaGuGwHI3FtYGPboielGpR8YSfqUdZR9AIJ+v2yjT
         JM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BEgdEAiWJutYpcWzx95x0i1pQfXun3GH7d4z2MsuksQ=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=ZV/I8+FPZEOjBvc/y3S3OSlQ1doe7/o97N5yxWss+SDSrp8EZ2zdeZ1ry1mfupzE1z
         eE3EinGvy5PwEv77WTPjRh0EtGeVidUGcTBGl5jBmJaOf/6EDqQlhiijwOfp1HoTA4Zs
         Jlis6DXbL2HKj7jEuoRl7Gd9ahyM3l35vQXrK+Cn6vjqJ1X5CpjpFUDP8dbXpilIVM5E
         wuCLGguO1vIb/DC2ZVl8ZUQ8hqy6VvdTyGmojARn6K299f1fHo41N2PrQCNb5qKwY65E
         sw387rfquG5X0NlWM6lDetTLgkcVdLYX5CTzf8PA8ZlzGMW1uNAvbZZovDaqoypFBSBB
         Qv5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773969625; x=1774574425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BEgdEAiWJutYpcWzx95x0i1pQfXun3GH7d4z2MsuksQ=;
        b=QEdIMspsthG0qP9ZWRRvnkJH3FJKlH0OZsbGiRY+UY/R5RIGtDRudt6DdvGnr+ze/l
         FmEo9KZQYudMW9jdg+pwdHCr9rQSxv/+rVYw6xw5Dd4zFsmC17uvPs85G7RBKlCjF3ht
         0kPt+WiCsvLsP8gssj/hBq3BPEMHJuaiR8pim7GcWAdRM9FZlcmfFKUfM9nLxYr4fbcr
         dT+Q5doarHVcLd6ghlEslDUw+AoUdPVyQZaOdORfM8otn7Q5vvErEaZnRjMZ+u47fANo
         TfiRY+mdiEh7eWirYwTv7dGaie0KEUTCzrFIFGgwM/wGZPbDz+OSbnU/67Cb22fNsezn
         lEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969625; x=1774574425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEgdEAiWJutYpcWzx95x0i1pQfXun3GH7d4z2MsuksQ=;
        b=etAUpZySz2iG8mAOQD+kqmPyokOKU8y5NjHw38ad4Sf3+5ptBMZSfebFE2hBZXN1pF
         i0XvYpF+Hpvw4xoxh7fiY7pdwZo0W1PpC+CuS9CUP7I2ValebqyjDYILixaju2yqacf5
         z1xdzV9+eOKWZaXbIw1ssW5O/TjGeqwlDgjQMDyx+skzUbUgD17B4zsgmx5lDQkupryK
         MPBZpas9bE5V0px6qw30QvyevyV/nOGTX8skTI3oOKjaJR22prSJNzGrtXOv4O90bicB
         npw2qoI5iScAZluyfPrhfPfsg/iG4Yd6Mm/R/eR2U4+ATU8+xMiRJxHJwN2+Nj4i7GcX
         dsdw==
X-Gm-Message-State: AOJu0Yyvifd6IWeI2nlM7GUyQbUxD+n2R2A8GuVbgioVLIMtJ+wqA6qi
	9BvrixlSK14xsO1i6i6IdcI6cB1X0lt2u7lhHGC8NGPm/8svrFFXIXXMe3VDwwkAg0Nq9kI143g
	UtzFQgLTIVEoAyz2VgFAeK5EJCbdpad4=
X-Gm-Gg: ATEYQzymRyD7JTGRAUjK4r9GorcqaENAgwLFed7KIYQlpWJcA8PiqWIg6kbkaML8Sy6
	2p+NT0aE3X3Dxzl1QoUaIljwo/p8+fDXqp/2UVgfJIcK7yAEkMbje+0Db7HjhGUPyVAFa2pggES
	DRkB7tTr43fxSXbJB+YRpprhcPOqKJe69C11gyku3Z4oskYE1NMRZ21KrSw7+orcw/hz1YSFDxs
	5tZxCVzSagfzTrNVgW2KNEIWrRVo5OYDCjy2GqM52MkJelCbfbUoJHSpzazsXwYX3GnYXjlZZL0
	IKoYF9bP
X-Received: by 2002:a05:6808:1807:b0:463:9acc:f4bc with SMTP id
 5614622812f47-467cd5c5ca1mr3239715b6e.13.1773969625558; Thu, 19 Mar 2026
 18:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com> <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com> <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com> <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com> <b231d63665334ac786e808610fe4a1e9@realtek.com>
In-Reply-To: <b231d63665334ac786e808610fe4a1e9@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 20 Mar 2026 03:19:48 +0200
X-Gm-Features: AaiRm52w0XQWvJP3crR_aJBlA4gLJVGKaHrmwqIQ8HIwr-_V1aE6qhF4OY-Mqas
Message-ID: <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33535-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 62F7F2D49D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Not sure what hardware get wrong. Let's validate rate when reading
> from hardware. Since 1M rate can only 20MHz, I set it together.
> Please help to test below. I suppose you can see "weird rate=xxx",
> but "WARNING: net/mac80211/rx.c:5491" disappears.

Hi Ping-Ke,

I can confirm your patch works as expected. Here are the full results.

--- Test environment ---

Kernel:  6.19.7-1-cachyos
Patch:   your rate validation patch applied to rtw_rx_query_rx_desc(),
         on top of the v2 DMI quirk (ASPM + LPS Deep disabled)

--- Captured log (relevant excerpt) ---

  [  43.046] input: Soundcore Q10i (AVRCP)   <-- BT headset connected
  [ 111.551] rtw_8821ce 0000:13:00.0: unused phy status page (13)
  [ 111.635] weird rate=101
  [ 111.635] rtw_8821ce 0000:13:00.0: unused phy status page (7)
  [ 111.741] weird rate=102
  [ 115.045] weird rate=98
  [ 118.371] weird rate=104

--- Analysis ---

1. Timing: the anomalous events began approximately 68 seconds after
   the Bluetooth A2DP headset (Soundcore Q10i) established its
   connection. No anomalies were observed before BT connected.

2. Multiple invalid rate values were captured, not just 0x65:

     weird rate=101  (0x65)
     weird rate=102  (0x66)
     weird rate=98   (0x62)
     weird rate=104  (0x68)

   All four values exceed DESC_RATE_MAX (0x53 = 83 decimal). This
   suggests the hardware occasionally reports a range of out-of-bounds
   rate values during BT/Wi-Fi coexistence, not a single fixed value.

3. The "unused phy status page" messages (pages 13 and 7) appeared
   immediately before and alongside the "weird rate" events. As noted
   in my previous message, only pages 0 and 1 are expected. This
   further suggests the firmware leaks internal coexistence state
   into the RX ring during BT antenna arbitration.

4. Most importantly: the WARNING: net/mac80211/rx.c:5491 did NOT
   appear anywhere in the log. Your rate clamping patch successfully
   intercepts the out-of-bounds values before they propagate to
   mac80211, preventing the invalid VHT NSS=0 warning entirely.

--- Conclusion ---

Your patch achieves the intended result. The "weird rate" printk
confirms the hardware is the source of the invalid values (occurring
during BT coexistence), and the mac80211 WARNING is suppressed.

Please let me know if you need any additional data or further testing.

Best regards,
Oleksandr Havrylov

