Return-Path: <linux-wireless+bounces-33311-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MpTMXFouGlEdgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33311-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 21:30:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0792A03C7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 21:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34E923046D88
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CAF3EF0D8;
	Mon, 16 Mar 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RokfTiEd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C773EE1E1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692874; cv=pass; b=EJCrfmH9QjE4Ow717mp+1nKAdiAsax6mMffNniRZj5J/CFQO6PiuSOVlO1HAF3Hx38V/MlZ3mCEr+26B8KxS+VK5KmYuQVdJUVUN6rijhABsq86TGhZbgCjb2pRhlz5w6MMB9sbg6JPxFHqOuZQuBO6EafaYTiYjwnfA2eLIfJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692874; c=relaxed/simple;
	bh=FP1uqErZfD76XoobcjvO1RSspkWei4fffgzfkDQKtGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9l5Z4uHVN9fzXeYGvpwRvPPXQozGcigy7i1ZpjClxaDrdc2K86VympzqvQu272E4oapOnN3UsgYY5b1yhJsk6xejDsRGopBgJNMg9iYXA5S9mgyUio5t4YqMQ0piH8XYYVZtYIeER0mZr2rLzF/8C3YyjTUI9pW4NfjSQ3HzPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RokfTiEd; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7422b4ff1so2175789a34.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 13:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692870; cv=none;
        d=google.com; s=arc-20240605;
        b=avjv94ARps+kNAaHAwSIN+iny5reMy4tM++YHQryTJSmnveFxMWoxiBwdiJ37XKBFa
         Gly3zPTltbFl4/oMAeUdv+1ZCWXQsUwvWjaD6DG9bVTSmp7hkBIpc/Ddvln3Chx7LB/F
         0lt6KNntwWaPETMnXBG0u6whnt6wJjPxkkaEEQ6tcn7cnlxJ/SXHlvOVegAPkRKeqDve
         m8qbQcEuKVsYD7S6lGrJGNyAL56WJCLtaXiVD/lFKNjDCQj9KXPnKnN48o3GFb8C9Bwk
         Wb7g+lil0p+0GgB01xf7PaDf8qcfspeDrmgZq3VXoeYSEzP0j9hJgRFHQamjPT7HZuEE
         bDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wpf1VtIwZa0YFIHXoYncUB78SkVzhVwwyD5F/vBb9Wk=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=lSRRCuEHxRBblHnFv3mnTEfXGwXcsUY97unJlA4/XgCFhicfH76wAXTMgs3fKdBXIM
         a1h1YGWurGVRaS9/gq96FGCECkhLP3nnlVjfosgJQ6U42MfMqZIuzdcYW9ITDJeARf4C
         UW1WIthT49NZ+QNIj5M8lq/BrBeUzV2kDl3OsM1L6FRK7N7oJpx9cCvPsQr6+xN6WV32
         oiclDSPdQJCUSWo5WrxPoU05Er5NaLYGI2aTYg7007gZwpqtLFEw5AFSf9/V0BUpx2KL
         0SVl6f3+95ErwVlCwtw8iY8LIpucx75QEJ78/yKthLne1xZzmK77ZBZj6iDer7sT+njy
         /H3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773692870; x=1774297670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpf1VtIwZa0YFIHXoYncUB78SkVzhVwwyD5F/vBb9Wk=;
        b=RokfTiEdKBXNTTsBwBnxGjKwaFDAJY80xFEKivRBqUSxCC7uHuveXAT0S7ou6x/WIQ
         5Sw9LsFGBDG3O0iAY2uKQ0PNEb6QTGUS4zk88gEbNSItWuIPEfyeCjg9nl5H5wJt7DTj
         wDYWEq9e27vGIqxCgz3OhterDcNted8YT+sdLqiFu1LZpJKL2YQllBRyoHzz9T4yPxHb
         bxgn/3l9QzLeaMZi0j8krDzi07L5T03UbEFjPcxLXNMdV17FTQHfTbZf8AtVzRfiYKPy
         OLxisSgb5btMx7eZsJS7WzV6Xo1JDwEK7FbeQW4JNSFM21k9p2UP9UtG3iavRskoXCzq
         vYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692870; x=1774297670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpf1VtIwZa0YFIHXoYncUB78SkVzhVwwyD5F/vBb9Wk=;
        b=CQq60v3HGRC8Tu+0TQ0FQX7uvbz8j2SSypI3L/CEVdjsestpwVBWiOty5lY2eaXLJI
         H98GETpLBu2Xb2ZjTsXEPJNpmj1dJd6x07BhtOMoX5GiWmXghT/++aTCbjX0I4GFGFzX
         zEZ7OGr54FBOU4I0xu44UYVZQC/kCVbyFCDI6bPFMc0yUsgBINJBSMUOiwVWS8HFMJ/a
         W+yy90H2QAVLQQj++GNUGu3pH1rrqmJ+UxX/yvxvDUPHztmzkq7Lzx+dxCgaKK2M44M8
         zhgc/vqR+YHNszGBnyyEyv9TH87f+nay0OkjuTe1FIoHvoyB3B1eaEZ+2JOB3MZUnguW
         +lCA==
X-Gm-Message-State: AOJu0YwJG3hC2hyj1tI7Sn7l/biQAkjn0+QPzjgPHOsWrMEBTnuBOCub
	UbTy1PzZegao1LQJ3QavF99IcYbmKImQdaZFpUF7RLNd11rAzr/Q46e0MO2h3ewvaUpSZwLkfHo
	0AyyGknFC2ouPNxO8XwzDBj1y4xPgxNU=
X-Gm-Gg: ATEYQzzdaq+yRG5hLbeBdqjbPBd7Al/ssoUfv0kp9T1kDE6JPX1WxhIIScu61/ZI3NH
	aL2ok6u71A7oDecnu1f9WvDkGjmTMQrT//DeDfvZJn9WUBjDsn3MRAoby99C/iPBo1mxdYdvAX0
	opsqXqSFW6uzH/zxJgOLid64vSoiHrC1HNYaoYW/TIQuXLmoaCqpVU7L7/S+X1qJOd7sBsSL+3e
	MbZGWyPpRa1rDkQHsel58y49O+WOM/SDarnsrMLaoiPNfZBYIdIM9eYu05qNuebkuUHZzGiTsU6
	N4w3jks=
X-Received: by 2002:a05:6830:4124:b0:7cf:d119:9953 with SMTP id
 46e09a7af769-7d7824cb663mr12080777a34.16.1773692869573; Mon, 16 Mar 2026
 13:27:49 -0700 (PDT)
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
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com> <1bd495ffe57c47eb827eec084729afa2@realtek.com>
In-Reply-To: <1bd495ffe57c47eb827eec084729afa2@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Mon, 16 Mar 2026 22:27:12 +0200
X-Gm-Features: AaiRm52lOFfZmpvisgy4CeeKVFeDzA6wEYGQc7hw9fe3htSS4KzapDilTaeJlyQ
Message-ID: <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33311-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 4D0792A03C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Not sure if this is because PCIE bridge has no ASPM capability?

That could indeed be the case -- I do not have a way to confirm
without further hardware-level inspection.

> LN5491 (kernel v6.19.6) is:
>                 case RX_ENC_VHT:
>                         if (WARN_ONCE(status->rate_idx > 11 ||
>                                       !status->nss ||
>                                       status->nss > 8,
>                                       "Rate marked as a VHT rate but data is invalid: MCS: %d, NSS: %d\n",
>                                       status->rate_idx, status->nss))
>                                 goto drop;
>                         break;
> Looks like driver reports improper VHT nss/rate? But this warns once, and
> you message isn't like this.
> Could you check the source code LN5491 you are using?

The file net/mac80211/rx.c is not available on disk on my system
(CachyOS ships only .h files in the headers package), but I located
the exact warning message in journalctl:

  Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0

This confirms that line 5491 in my kernel matches exactly what you
showed from v6.19.6 -- the RX_ENC_VHT case checking for
status->nss == 0. The offset in my trace is slightly different
(+0x183 vs +0x177), which is likely due to CachyOS's LTO/AutoFDO
compiler optimizations.

The warning appeared once in my initial test session:

  Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
  WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]

However, in subsequent module reload and reconnect cycles I was unable
to reproduce it. This is consistent with WARN_ONCE behavior -- it
likely fired on the first invalid nss=0 packet after the initial
driver load and has not triggered since. I cannot confirm it as a
reliable symptom.

---

Regarding patch stability: the results below are from testing your
original RFT patch [1], not any newer submission. I want to be
explicit to avoid confusion:

  [1] https://lore.kernel.org/linux-wireless/20260311020816.7065-1-pkshih@realtek.com/

This is the exact diff I compiled and tested:

--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */

+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "main.h"
@@ -1744,6 +1745,34 @@ const struct pci_error_handlers rtw_pci_err_handler = {
 };
 EXPORT_SYMBOL(rtw_pci_err_handler);

+enum rtw88_quirk_dis_pci_caps {
+ QUIRK_DIS_PCI_CAP_ASPM,
+};
+
+static int disable_pci_caps(const struct dmi_system_id *dmi)
+{
+ uintptr_t dis_caps = (uintptr_t)dmi->driver_data;
+
+ if (dis_caps & BIT(QUIRK_DIS_PCI_CAP_ASPM))
+ rtw_pci_disable_aspm = true;
+
+ return 1;
+}
+
+static const struct dmi_system_id rtw88_pci_quirks[] = {
+ {
+ .callback = disable_pci_caps,
+ .ident = "HP Notebook - P3S95EA#ACB",
+ .matches = {
+ DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+ DMI_MATCH(DMI_PRODUCT_NAME, "HP Notebook"),
+ DMI_MATCH(DMI_PRODUCT_SKU, "P3S95EA#ACB"),
+ },
+ .driver_data = (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
+ },
+ {}
+};
+
 int rtw_pci_probe(struct pci_dev *pdev,
    const struct pci_device_id *id)
 {
@@ -1808,6 +1837,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
      bridge && bridge->vendor == PCI_VENDOR_ID_INTEL)
  rtwpci->rx_no_aspm = true;

+ dmi_check_system(rtw88_pci_quirks);
  rtw_pci_phy_cfg(rtwdev);

  ret = rtw_register_hw(rtwdev, hw);

Results with only this patch applied:

  - The hard freeze lockup is gone.
  - However, during idle the logs are flooded with:

      rtw88_8821ce 0000:13:00.0: failed to send h2c command
      rtw88_8821ce 0000:13:00.0: firmware failed to leave lps state

  - To give a concrete sense of the volume: over an ~80-minute
    observation window after a clean module reload, I recorded
    11,757 "failed to send h2c command" events and 2 "firmware
    failed to leave lps state" events -- approximately 110 errors
    per minute during active periods.
  - These errors cause Bluetooth audio stuttering and WiFi
    throughput drops.

When I additionally set disable_lps_deep=Y alongside your ASPM patch,
all h2c errors vanish completely and Bluetooth/WiFi remain fully
stable. This confirms that disabling LPS Deep is necessary for
complete stability on this specific HP SKU.

I also noticed what appears to be a new patch in a separate mailing
list thread. I will test it shortly and report back with the results.

Best regards,
Oleksandr Havrylov

