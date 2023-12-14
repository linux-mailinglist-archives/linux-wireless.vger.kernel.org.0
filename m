Return-Path: <linux-wireless+bounces-772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E37812497
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 02:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C6F281CAA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 01:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA5645;
	Thu, 14 Dec 2023 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjZ2HvA0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389BE4
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 17:31:07 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b6fc474d16so316446839f.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702517467; x=1703122267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faxZCPIB6BA+PKGwJpg3jnTyxYaNnS6OziZiTTL7mN4=;
        b=fjZ2HvA0KDvtNR/kLUU17y+TsPB3txOhrWtlMBL0RaEjpWIV1MOukUrtr3NgDlZ9ha
         blSlioyHuVSkWHF8oDZTKVMY+z6vJeJmEVicRw/yOB1Wv3fmGGUvARbEdgr8RpoBQ4hP
         cnkzXVPh+2MWz4+Hu34akFMK3MUq7UnrE7HWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517467; x=1703122267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faxZCPIB6BA+PKGwJpg3jnTyxYaNnS6OziZiTTL7mN4=;
        b=XrsHVC2BvYM+Zq0ZtfSQvQCmOPogBRZ660gnGNptwc1urH8pmy/Dq8aK9Q4PahYFXM
         8omLctl4uH7iTguEyxBN4TO0zKq38YKQrVHMZ+CzITONc4QysSMi1vDlKFhvHS8nDqpk
         oukgslPL8s1E00r+NLNWA/Si7gTyPt21VHMxgGUiAKWeyDgsn8UKogVcq+oScLUaH/3M
         rZmLoZnVc+jsoKqqqTxGIJJhWd4h1wgtZbDyc5aj2yCsAG08eh7Efwz60EtcUsdIKThY
         DfJABiSnokng00uF88vpLHpPbodevL9sBlXGuZU+sX0UQSWPnjIJ6UCg3IcDIPUgedga
         IOmw==
X-Gm-Message-State: AOJu0YzPh1yWOnTlr3JsPlHnp9aAzRROX/nhZArkcHREpxENEPnIXcgu
	+l5mu8XKFCVJOUxTMeQEcjWM0Wvl2la+lzDtAhU=
X-Google-Smtp-Source: AGHT+IGcft8mTr1NcnoXOaDWWv6KIsuOrSLK8C2duW5H45U6QWQb3tGGHvbC6VAZWxKswazTsZZJmQ==
X-Received: by 2002:a05:6e02:1605:b0:35d:7ac7:359c with SMTP id t5-20020a056e02160500b0035d7ac7359cmr15752917ilu.40.1702517467173;
        Wed, 13 Dec 2023 17:31:07 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:17f:673b:ab18:3603])
        by smtp.gmail.com with UTF8SMTPSA id j3-20020a170902c08300b001cfc68125desm11207835pld.203.2023.12.13.17.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:31:06 -0800 (PST)
Date: Wed, 13 Dec 2023 17:31:04 -0800
From: Brian Norris <briannorris@chromium.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Ganapathi Bhat <ganapathi.bhat@nxp.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Message-ID: <ZXpa2PE_qMmCoEec@google.com>
References: <20231205210237.209332-1-knaerzche@gmail.com>
 <ZXDHgo5QnZjb237S@google.com>
 <ZXDH5S7rM32y48Fc@google.com>
 <f0f3a0fd-8019-4950-8682-902cf985a81e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f3a0fd-8019-4950-8682-902cf985a81e@gmail.com>

Hi,

On Wed, Dec 06, 2023 at 10:51:03PM +0100, Alex Bee wrote:
> Am 06.12.23 um 20:13 schrieb Brian Norris:
> > On Wed, Dec 06, 2023 at 11:12:02AM -0800, Brian Norris wrote:
> > > On Tue, Dec 05, 2023 at 10:02:37PM +0100, Alex Bee wrote:
> > > > This patch restores USB8897 support which was removed with
> > > > Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")
> > > Did you look at the reason for that removal?
> I did. And honestly I didn't understand it - in the first place.
> > > "if both mwifiex_pcie and mwifiex_usb modules are enabled by user,
> > > sometimes mwifiex_usb wins the race even if user wants wlan interface to
> > > be on PCIe and USB for bluetooth. This patch solves the problem."
> > > 
> > > That sounds like a legitimate problem, even if the solution isn't
> > > perfect. Do you have any alternatives?
> > > 
> > > I don't have such hardware, so I don't know its behaviors nor can I test
> > > it. But it'd be nice if we could differentiate USB-only vs PCIe+USB
> > > somehow.
> 
> I re-tried to decipher the commit message and re-checked everything and I
> think the patch is fine as is:
> 
> What they probably mean in the commit message is: There is an USB id clash
> for 1286:2046 with their "Marvell NFC-over-USB driver" [0]. So that has
> nothing to do with bluetooth :)
> However Commit 8a81a96bd116 ("NFC: nfcmrvl: update USB device id")
> restricted the InterfaceSubClass and the InterfaceProtocol for those
> devices, so that this clash does no longer exist. This patch here takes the
> correct ones fot this wifi adapter (I checked with lsusb).

That's a nice theory, but they never mentioned NFC. I'd expect they
wouldn't have such a large omission in their description ... but maybe I
place too much faith.

It also doesn't make sense how commit 60a188a2715f would have helped
anything for such an explanation, because they were already using an
appropriately restrictive ID (via USB_DEVICE_AND_INTERFACE_INFO) in
mwifiex_usb. Disabling mwifiex_usb wouldn't do anything interesting;
disabling nfcmrvl would.

And I suspect Bluetooth is mentioned as that's typically the thing they
expect to use for USB (and not WiFi). Clearly that expectation has
changed in the intervening years though.

> If it's not that I really don't know what they mean: Neither 1286:2045 nor
> 1286:2046 usb ids are used anywhere else tree-wide.

I suppose I'm not 100% sure either, but I'm guessing that somehow both
PCIe and USB interfaces are enabled for WLAN -- i.e., we see a PCIe
11ab:2b38 and a USB 1286:2046 device show up -- and it's just a matter
of which one probes first (and downloads the relevant firmware).

That'd be an awfully silly design, and the datasheets I've seen suggest
that their pin strappings determine a single host interface for WLAN
(SDIO, USB, HSIC(?), or PCIe). But then, they also suggest the strapping
don't impact the hardware; they only affect software, which may or not
be coded well.

Personally, I only ever had SDIO modules around for 8897, so I don't
know how this PCIe+USB combo works in practice.

> [0] https://cateee.net/lkddb/web-lkddb/NFC_MRVL_USB.html
> 
> Fine?

I'm not sure. While I don't have sympathy for the Marvell/NXP folks
who've abandoned their products, I do have sympathy for the users who
may still have such systems and who we may be broken by reintrocing this
change.

On the other hand, if such users pop up again, we could probably cook a
modprobe.d entry to hack things up. I'm still not sure how to *really*
fix such an odd system in a generic way.

Brian

