Return-Path: <linux-wireless+bounces-33231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBZzHy1XtWkMzgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 13:40:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9428D2F7
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 809CE301511D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2640A3451AE;
	Sat, 14 Mar 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctzVvJsW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8F33EAF8
	for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773492011; cv=pass; b=A4sW8TdgBzqMNmnYWrC2YTeR6oLQ5sVLLiInhTwhHpd07ggD2R0I+Ir3lU+l04ikOUkgFNLMxu5vsQY9hN/kVFWLv+s309EK048YPE9tuftdOqNNMJbkNn9g0uJ54oWGZ8fp+ibVtmaMLN+YDSzHkdnlsZqW5NAofgT0oMPsNxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773492011; c=relaxed/simple;
	bh=NPiEcpwTfzeoz08xk+oJb97Z8sjGsHwJP4jXFKLhU8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxq5cnkGbl/2jpALN3UMJJji807+UuAttPY4p5dBg5IKAJ7cvQXAxbs+5YwjvF0GmAIa9zU0uhw5tabjkzCOu6z4zUJyII+aajrGW6althWNCXZxDiE1jjooGuTNgc3ywq0wi7X+8p0dXrM1XFGO1CVmyRXceyTBMD2ynxBNgeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctzVvJsW; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4670bcc40d7so1175962b6e.2
        for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 05:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773492009; cv=none;
        d=google.com; s=arc-20240605;
        b=ZghlZU6ovD+i67hAPuAOCn+qghKeWOlFEhLLht+eDRZ5pH/bwEBXITdINR2QGGZReI
         ubMlAUTZOgVd7u2gZhEKqRAb4hNXO6H+Zr+F+LPddGbFmc+p5aiFgY02jyvPUi2qCqcl
         A8GcrfV88XC3n/m9bS08sIWWyDzZnSL2Lr7osjzzQyVjH4AGdZvZDkYmi6DM5+2bjcvs
         z+onGLT6DcOw978pc4O/xYnajCGeGSScx2y8BAdMD7CZIlU1NTnJLqE5c6fhKFSfSOaY
         BrnYln9t5CLEAiA1ylHlolqOCppItYx9p08LAScZV6OnyKQn6DClWbikp1F3h0bBprbG
         jBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hiEhmw1vcClLQd0zqzr4IDRovE6h9unJHNp2D3tJSFo=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=Bphj4pYpsC4Ec4473Ep79AlHBTgDbE8gZLLT4IC8HOWFVWG6YD7hkDOqrQIBJ+g9Cv
         TpIi5KuexYjROxz+Pp/c+jDgS8MzACculcwiOyra3p8Rbnlf8zEenDfoKywgJEWbFQL7
         k6DtlJaV2Ke9j2MkpjbXnzHoAFLiqFUT0sejBLXvv5+mv1+LTCrMNTSPR9a2eayevpuH
         bdoYyIanf4LzFHFI1Y5ocQbLmHs8oSTtC0/L0slK4ufNN6Z+BzAOHPHFSiiP5DXY0jaV
         WwneolJexSVxIGaBRGmJDcnxt8G4OQsgAhnV6d/RcftBYWqIngjwLhzx2HBnQXAZOktA
         BPGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773492009; x=1774096809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hiEhmw1vcClLQd0zqzr4IDRovE6h9unJHNp2D3tJSFo=;
        b=ctzVvJsWvW3/RWGBqt/4M142f2foTeGj84kvBSr+xqMexmFmmAw2Q5YgclV2u9Mu9h
         fIn/vD/zvRPJXG7Ej8x/vgL0IbZeMFypdK85eHqR2eZX5YYo2oq5OqmvodMaQ/vntG7y
         PAMiQn3FQgRdk/ycMTGBs0TxmHhQkDzLjHMTJKkVEblDZrcwhUMzWqD90kJ6nfNDNvjj
         W8N7Z0ZzPumYtIuk9UY7ogB8N+qE56zP43aNtY96bt55W+h4eAqTPjpsNkD6doBN3+V3
         WxICF9n93A47sRjNP+IRHtI2fUzqyx88L3ExQg4KaxKiZJL1j8X7auZBqnCYTSFDApy2
         Sg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773492009; x=1774096809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiEhmw1vcClLQd0zqzr4IDRovE6h9unJHNp2D3tJSFo=;
        b=P3ix8rUeYvSgXewMiKsI8kopVjZpCJj8Z2gmg+TNBAi3Es6ZoHImAsSaUtxQnhbGqQ
         j4Va0ZXGr99X+pC9knHkiSnqPgZlalh/juakYd+ofiywIjZApMpT3K0EsafaYfRlxqun
         d4b1ZfBhHF8o/gDLH0rcJ0dDG21oNR702FzPF0CRm8tUz3mec70LCkahE3TMKni0iZxd
         jhete0bLuPbR1kozntECzCUbYTdgWYEXI3JBZhoqe+7CffvDuh9HLpxqynx/LqROklWv
         RwV3VfSnaqnkiqNOMxX5YVZmVzvqnwjCKzkM86Sdf0rjGi29fuc6nBmpOEOtEkojaX/m
         L37g==
X-Gm-Message-State: AOJu0YyZcIMpKfEN/8+LxXn4X+oJ1wAR/aojcLMKfzWbt7LT2WaVlT5R
	F9W7gtRiTDEgP7awslfB7MwvFL14eM/mvTTPkP0BaiLBaNxmvvhtgO5/Ju328aew4b9K52XsBiA
	Rp4XJVUj1u+ciVvhj/OXJw9+bKu3AJG5zgrTb
X-Gm-Gg: ATEYQzyuo60ngXYK7VR+XQOhkbe2qUNsCooXvMlwmZN8tn2URD3ikY6lsQj4bDiSQJ9
	BHde01HGz/bNyddrHue1rBkcwmVJUmn7DAQtT3oiuQS7yUSKQGnPIxF40yk/Xe6kptWQbh2Lv3w
	PaxqcUgkaKfhdyLKl0G9MPT4jMJ3biXJ+sHbewYSoBiNG80IUYKtzWvR2/IxFYJcSsAF8ZiT1va
	GfgltAb96r4CPxBC5vgJWR7x5ULWS3J0wrhJRWLZv53W7LSt9ymSmzi89HIU9068/CivqErCMAo
	t7YlKOQ=
X-Received: by 2002:a05:6808:3448:b0:45a:8cdc:669 with SMTP id
 5614622812f47-4675767b22cmr3348749b6e.59.1773492008644; Sat, 14 Mar 2026
 05:40:08 -0700 (PDT)
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
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com> <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
In-Reply-To: <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 14 Mar 2026 14:39:32 +0200
X-Gm-Features: AaiRm53AQsq27s8ttjayxz_a3yKhZSkVSD9IqtiHDSiPOhkRgQWDBhQDw9kJr78
Message-ID: <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33231-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F9428D2F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> I'd adopt your suggestion (dynamic LPS_DEEP_MODE_NONE) if the test
> is positive.

Hi Ping-Ke,

Following your suggestion, I performed an additional experiment to
validate the dynamic LPS_DEEP_MODE_NONE idea. Please treat this
purely as a field test report -- I am not a kernel developer, and the
implementation below is certainly not upstream-quality. I am sharing
it only in the hope that it helps you design a proper solution.

What I did:

I extended your DMI quirk in pci.c with an additional capability flag
for LPS Deep mode. The only file touched was pci.c (your patch) --
main.c was left completely unmodified.

The changes to your patch are as follows:

  /* 1. Extended the capabilities enum */
  enum rtw88_quirk_dis_pci_caps {
          QUIRK_DIS_PCI_CAP_ASPM,
          QUIRK_DIS_PCI_CAP_LPS_DEEP,  /* test addition */
  };

  /* 2. Extended disable_pci_caps() callback */
  static int disable_pci_caps(const struct dmi_system_id *dmi)
  {
          uintptr_t dis_caps = (uintptr_t)dmi->driver_data;

          if (dis_caps & BIT(QUIRK_DIS_PCI_CAP_ASPM))
                  rtw_pci_disable_aspm = true;

          if (dis_caps & BIT(QUIRK_DIS_PCI_CAP_LPS_DEEP))
                  rtw_disable_lps_deep_mode = true;

          return 1;
  }

  /* 3. Both flags set for the HP P3S95EA#ACB entry */
  .driver_data = (void *)(BIT(QUIRK_DIS_PCI_CAP_ASPM) |
                          BIT(QUIRK_DIS_PCI_CAP_LPS_DEEP)),

I am aware that setting rtw_disable_lps_deep_mode from pci.c is
architecturally impure -- it is a global flag that would affect all
rtw88 devices in a hypothetical multi-adapter system. A proper
per-device solution (e.g. a flag inside struct rtw_dev set during
probe) would be cleaner. I simply used the existing global as the
most straightforward way to validate the concept.

Verification:

Confirmed no rtw88-related entries exist in /etc/modprobe.d/,
/lib/modprobe.d/, or /run/modprobe.d/, ruling out any external
parameter injection.

After loading the patched modules, the following was confirmed via
sysfs:

  /sys/module/rtw88_core/parameters/disable_lps_deep_mode = Y
  /sys/module/rtw88_pci/parameters/disable_aspm = Y

This confirms the DMI quirk is the sole source of both values.

Results (10-minute idle observation, battery power, wifi.powersave=3):

  With your ASPM patch alone (LPS Deep still active):
    - periodic "failed to send h2c command" bursts observed
    - occasional WiFi throughput drops and Bluetooth audio stuttering

  With ASPM patch + LPS Deep disabled via the quirk:
    - h2c=0, lps=0 across the entire observation window
    - WiFi throughput stable, Bluetooth audio uninterrupted

The result confirms that disabling LPS Deep Mode in addition to ASPM
completely eliminates the remaining firmware timeout loop on this
platform.

I hope this experiment is useful as a data point. Please feel free to
discard the implementation and design a proper solution -- I am ready
to test any updated patch you send.

Best regards,
Oleksandr Havrylov

