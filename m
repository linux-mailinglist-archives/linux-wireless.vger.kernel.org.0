Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DE0E1740
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390932AbfJWKDP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 06:03:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390897AbfJWKDP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 06:03:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 52B3F606CF; Wed, 23 Oct 2019 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571824993;
        bh=UqlHqz8xo4v8Nzzocg5kFsjmpvsPKRvEEF3oVwz+tpA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oPrynONPVLlJ5D11SE5qwna/LsCq7m5b3QsRL+TF00ghkixzvECdUHYIsRcN6xghr
         xCUK7kFp3/xKwp4saY7AmxezThlcXJsdJbojc4Q8SWTgb4wk9W3J/gmM9NzsLEcInN
         gqE77llxkiTkbuh/HQOc1BYLGBSs6EHqrHprjp/Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A2F8606CF;
        Wed, 23 Oct 2019 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571824990;
        bh=UqlHqz8xo4v8Nzzocg5kFsjmpvsPKRvEEF3oVwz+tpA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=THSowuSJ7FbnerN3acnzorfayDL+SorSnXvp7Lu1lgPkkNo1xpRt2MkY1ARMrYvy+
         EM6dB6Nd2JQ7AbltH33EgaAWJR+w4ZwTNRwUvs6G2sNcksHlE54GrQF0AxyRkqAn6a
         HlWInnOFcakTmrn6VfWE+pQzQXo4qGnkv7D6K6U8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A2F8606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/16] wilc1000: add wilc_hif.h
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1562896697-8002-2-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-2-git-send-email-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191023100313.52B3F606CF@smtp.codeaurora.org>
Date:   Wed, 23 Oct 2019 10:03:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Moved '/driver/staging/wilc1000/wilc_hif.h' to
> '/driver/net/wireless/mirochip/wilc1000/wilc_hif.h'.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

(My patchwork script doesn't support cover letters, yet, so I need to reply to
the first patch)

I was supposed to do a quick 15 minute review, but I got overboard and used
over an hour for this :) But anyway, below are my comments. Mostly looks good
but some work still to do.

+#ifndef HOST_INT_H

Add WILC prefix?

+struct assoc_resp {
+	__le16 capab_info;
+	__le16 status_code;
+	__le16 aid;
+} __packed;

use struct ieee80211_mgmt?

+   	   //extract RSN capabilities

No C++ style comments, please.

+  wid_list[1].val = (s8 *)&auth_type;

A little bit too much of casting, like in this example, for my taste
but I guess it's not that a bit of problem. Didn't investigate why
this particular cast was need, but I think Johannes already commented
how odd this wid_list looks like. And why sometimes it's (s8 *) and
others (u8 *)?

+      case 'S':

Isn't a proper define much more readable and as a bonus it would
document the meaning of this value? For example, it could
WILC_RESPONSE_TYPE_SCAN or whatever it means. Oh, and the same for
'R', 'I' and others.

do {
    ....
} while (1);

I see quite a lot of these unconditonal loops in the driver:

wilc_netdev.c:157:   while (1) {
wilc_wlan.c:532:     } while (1);
wilc_wlan.c:602:     } while (1);
wilc_wlan.c:730:     } while (1);
wilc_wlan.c:753:     } while (1);
wilc_wlan.c:1002:    } while (1);
wilc_wlan.c:1009:    } while (1);
wilc_wlan_cfg.c:151:   	     } while (1);
wilc_wlan_cfg.c:167:	       	     } while (1);
wilc_wlan_cfg.c:183:		       	     } while (1);
wilc_wlan_cfg.c:198:			       	     } while (1);
wilc_wlan_cfg.c:230:				       } while (1);
wilc_wlan_cfg.c:303:				       	 } while (1);
wilc_wlan_cfg.c:315:					   } while
(1);
wilc_wlan_cfg.c:327:		} while (1);
wilc_wlan_cfg.c:346:		  } while (1);

This is not recommended in kernel code because a small bug can cause a
never ending loop in kernel. Put some kind of limit to the loop,
either counter or time based, for example:

count = 0;

do {
    ....
} while (count++ < 100);

Or even some of the while loops could be replaced with for loop, like
the one in wilc_wlan_parse_info_frame().

+   u8 type = (id >> 12) & 0xf;

No magic values, please. My recommendation is to use GENMASK() and
friends, maybe u16_get_bits()?

I also see identical magic values elsewhere, which should be a strong
indication that this needs to be implemented with a proper define.

+int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id)
+{
+	u8 *buf;
+
+	if ((offset + 2) >= WILC_MAX_CFG_FRAME_SIZE)
+	   return 0;
+
+	buf = &frame[offset];
+
+	buf[0] = (u8)id;
+	buf[1] = (u8)(id >> 8);

In general a struct is MUCH better than manually playing with bytes
using 'u8 buf[]', but I think Johannes told you already that. Here you
could just have a simple '__le16 id' and you could assign to it with
cpu_to_le16(id), a lot cleaner than what's above.

+		  /*call host interface info parse as well*/

A space after '/*' and before '*/'. Have you run checkpatch? It should
catch these simple style issues? And you can run with --file directly
on the source tree. Not of course all checkpatch warnings need to be
fixed, but obvious ones like this for sure.

+#define GET_PKT_OFFSET(a) (((a) >> 22) & 0x1ff)

GENMASK() & co

+/*Parameters needed for host interface for  remaining on channel*/

checkpatch

+	struct wilc_vif *vif[WILC_NUM_CONCURRENT_IFC];
+	/*protect vif list*/
+	struct mutex vif_mutex;

I would add a newline before the comment, that would make wilc_wfi_netdevice.h
a lot more readable. But that's a style issue and up to you.

+  if (ch_list_attr_idx) {
+     u8 limit = ch_list_attr_idx + 3 + buf[ch_list_attr_idx + 1];
+
+		for (i = ch_list_attr_idx + 3; i < limit; i++) {
+		       if (buf[i] == 0x51) {
+		       	  	     for (j = i + 2; j < ((i + 2) +
buf[i + 1]); j++)
+			buf[j] = sta_ch;
+					break;
+							}
+								}
+								}

No magic values like 0x51, please. And I think this loop needs a
comment what's happening. But I suspect that if you had proper structs
(and not this ugly buf[] stuff) the code would be self-explanatory and
there would be no need for comments.

+  if (op_ch_attr_idx) {
+     buf[op_ch_attr_idx + 6] = 0x51;
+     			 buf[op_ch_attr_idx + 7] = sta_ch;
+			 }

Ditto. And even more of that in wilc_wfi_cfgoperations.c.

+static struct net_device *get_if_handler(struct wilc *wilc, u8
*mac_header)
+{
+	u8 *bssid, *bssid1;
+	int i = 0;
+	struct net_device *ndev = NULL;
+
+	bssid = mac_header + 10;
+	bssid1 = mac_header + 4;

And here a proper struct for mac_header would be so much cleaner.

+static u8 crc7(u8 crc, const u8 *buffer, u32 len)
+{
+	while (len--)
+	      crc = crc7_byte(crc, *buffer++);
+	      return crc;
+}

What's wrong with <linux/crc7.h>? Why reinvent the wheel?

I see so much this u8 buf[] stuff that I'll stop commenting about it
now. But, for example, spi_cmd_complete() would be a lot cleaner with
proper structs and some refactoring (one function per command or
something like that).

+	  if (addr < 0x30) {

Proper defines for magic values, please. This was even used multiple
times.

+	wilc->hif_func->hif_read_reg(wilc, 0xf0, &reg);
+
+	wilc->hif_func->hif_write_reg(wilc, 0xf0, reg & ~BIT(0));
+	wilc->hif_func->hif_write_reg(wilc, 0xfa, 0);

Magic values. I'll also stop commenting about magic values, I think you got
the point already :)

+#ifdef WILC_DISABLE_PMU
+#else
+	reg |= WILC_HAVE_USE_PMU;
+#endif
+
+#ifdef WILC_SLEEP_CLK_SRC_XO
+	reg |= WILC_HAVE_SLEEP_CLK_SRC_XO;
+#elif defined WILC_SLEEP_CLK_SRC_RTC
+      reg |= WILC_HAVE_SLEEP_CLK_SRC_RTC;
+#endif
+
+#ifdef WILC_EXT_PA_INV_TX_RX
+	reg |= WILC_HAVE_EXT_PA_INV_TX_RX;
+#endif
+	reg |= WILC_HAVE_USE_IRQ_AS_HOST_WAKE;
+	reg |= WILC_HAVE_LEGACY_RF_SETTINGS;
+#ifdef XTAL_24
+	reg |= WILC_HAVE_XTAL_24;
+#endif
+#ifdef DISABLE_WILC_UART
+	reg |= WILC_HAVE_DISABLE_WILC_UART;
+#endif

This kind of configuration should happen on runtime, not compile time.
In other words, the same kernel module should work on _all_ hardware
without recompilation.

+	reg = (BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(8) | BIT(9) | BIT(26) |
+	       BIT(29) | BIT(30) | BIT(31));

I said I would stop commenting about magic values, but here I really
have to comment about it :)

Device tree bindings were not visible. And CC
devicetree@vger.kernel.org as we need an ack from the DT maintainers. Also
I have understood that they require the bindings in YAML format now,
at least that was the comment I got with ath11k.

Please remove the 'wilc_' prefix from the filenames, the directory
name is already wilc1000 so no need to replicate that. For example, rename
wilc_hif.c to just hif.c.

+config WILC1000_HW_OOB_INTR
+	bool "WILC1000 out of band interrupt"
+	depends on WILC1000_SDIO
+	help
+	  This option enables out-of-band interrupt support for the WILC1000
+	  chipset. This OOB interrupt is intended to provide a faster interrupt
+	  mechanism for SDIO host controllers that don't support SDIO interrupt.
+	  Select this option If the SDIO host controller in your platform
+	  doesn't support SDIO time devision interrupt.

I think this should be a runtime setting (see my comment about other
compile time settings), for example a module parameter. Would that
work?

-- 
https://patchwork.kernel.org/patch/11040999/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

