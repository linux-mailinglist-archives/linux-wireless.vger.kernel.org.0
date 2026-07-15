Return-Path: <linux-wireless+bounces-39127-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OlY9KiUkV2pXFwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39127-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:09:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDA75AD85
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:09:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p98vovTq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39127-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39127-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2070301BC0C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12136E46F;
	Wed, 15 Jul 2026 06:09:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1D30BF70
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:09:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095755; cv=none; b=pmTHkGpWe9luFbJlx6y2R28knQq1ejBmVXpklo+y2iiAak7YkiaRDAtJvBFKQrc2kpXiBES/KNEEKEmwohxPqS9cg56sGjBseEasEKmAXcq6VvRmJYeYbuSL8rhMDOEItIvDglmZazd5cfwYNTpN3zUDWYS7EiLqwXdKuowg7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095755; c=relaxed/simple;
	bh=hhbkVFWqfeb6wr5PFPqn4mpOBnm0ya1NeenK6+bGYOw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcviVCsxWEBNFge9+bFJrNgUrGFjqMMU/kiPh3Ag1ae17YhsI6/giAWYJHWthsO8FHwcvirh6T0crHe3VXJ7rcpSLgjOtqgoapfwF7zpyQG0zGRJLAqHDGcE0YKVywlE9r9Hc3Zu6fELbJRdJrRPdQxH5ETNq2eDceMZa72rGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p98vovTq; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca88130e09aso3394311a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784095753; x=1784700553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Lh6JTO9nCo+UydcGPYZiKr3ZrK/RHTWgrneFQPjvC0=;
        b=p98vovTqCJiVS+/z5CqVZwUFLuNTPWVFLz9Ld4ZxXvW0AH9F5nT90AIGkcyjQqbAvE
         PASg/wdzsyMU7lnzpHm6BoE0DJ2VoqAKjt0Y3wJjS7TdhzH9wXTewkRuSOB63KnZjwVZ
         8XUxdjum+xiyAv9m1uWVcBg+GjWdRprCmwKG7tBvMq6ySwl1WTtnUFg5KSSB+gkx2KRv
         OJsipStecCXuFjBT5OPQtcjuWlzrMwIMK7ZWFaNSmY/25iCGDKi7kY73PNF8TfMOhgQt
         EpAhjB18oj2rVDV8HQRS9Z2m4jAr0AST5Qg2iLxV+/bM6z4D/J5F93tD6ps+A+T+jd+P
         EkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095753; x=1784700553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Lh6JTO9nCo+UydcGPYZiKr3ZrK/RHTWgrneFQPjvC0=;
        b=dTBiJnsfMzAN5ubjOLKONvOvTkMWh2u+Mlzv27xlgkhAQ0L1ZAS3lCwGL4CgHPug53
         C6sO/ej1G0QJ7nY18w+3t8F5PQQayI/PjO9mxDS/ZdQv4tDJYwP1WcPEHCVepwcJZ/Oz
         O0CI4pS+LsKZ5A9pM0P1EUUjYkxp5K2cOg9E3/rpPKjab08Ztq1TsKAHOvbK49fb2lRk
         6MTeZfARbxHtcHNG6H73tbpeYZ69qtiW5aTcAE9oiHFkid/0R1u1STtiJqXliM7W3NcS
         bCczYcCpL0bJAWt4WRwuVW47fbEO44mT3sxILX5VeaPbzEOSUMyWt43qS0c0nzR0fwR0
         BF5g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0PLZSIWJfr3+OvR4xLT2mctxn2wsLKxNrLilJagCxH9a6NwgiXp1aBKMA2FyivpXy4wX0hUcN3EKsFaUgbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mNWXqzv9Rx4jSFbPWJZ4if0s7RkLMp7wdrSIPi4gfkMKfg2A
	wNIuDO+mdjJgTioF4u5Fk0bnYnL57gGc8GTGYAle3nlDi6F0cwAOMjCI
X-Gm-Gg: AfdE7cnMYv+9+8mbKO20o6dpO+D3r4o+kM2J6DaWLv57oioS+pdbapTqlFUU4C/jlmh
	UBkv+lvMYhk0AcLoKQDRlaRofbK7NEL88/F9hJVa/2oOpEOarbF1JjlFOLgJjgHqdPcmEzsq3i2
	m6tXrss+ES4WFLs/zB8z1ppKIPN33Y900BCRMl/+fg82RusrWgsS2z/XPqpeQtjim30xE9PjxIx
	rYURw1GYg7vm/YPFc+UWIqJMJGsvCkRZx+3R/7HI9TVpRKBM/IQIFgq4HNtxCoB0zGA09PDPqRv
	fIGWSnQjR0b4jqxFlDsOVJgaFQYvT0S8CBJoaw/cbj4ngMHuNF8CBOWzkbLHIQka+9qGNpUSVXa
	CFtYe69d9UIlTqqn4vqbRVGEFvbBZBQLbTM3mR7GcoEeJfvWmdYDFe/uwyWbFpsCWsFR/SbcnvW
	4Nw5X+aHF1Qe7TS2PnoMdZ1g0jfarD7mpv3FdkZWQzaVCMNBUxfZ4=
X-Received: by 2002:a05:6a21:7905:b0:3c0:9c18:d5a1 with SMTP id adf61e73a8af0-3c35725cfb1mr4795350637.62.1784095752812;
        Tue, 14 Jul 2026 23:09:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:93:a597:7931:c950])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm63352902eec.24.2026.07.14.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:09:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 23:09:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Michael =?utf-8?B?QsO8c2No?= <m@bues.ch>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Waldemar Brodkorb <wbx@openadk.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] MIPS: BCM47XX: convert buttons to software nodes
Message-ID: <alci_45CzdVznaN2@google.com>
References: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
 <4a8d64e1-5f8c-4ac0-afb0-2d68c3f53ada@app.fastmail.com>
 <ala9C6XMB3-ywpph@waldemar-brodkorb.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ala9C6XMB3-ywpph@waldemar-brodkorb.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39127-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:wbx@openadk.org,m:brgl@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[arndb.de,gmail.com,bues.ch,hauke-m.de,alpha.franken.de,openadk.org,kernel.org,vger.kernel.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45CDA75AD85

Hi Waldemar,

On Wed, Jul 15, 2026 at 12:49:47AM +0200, Waldemar Brodkorb wrote:
> Hi,
> Arnd Bergmann wrote,
> 
> > On Mon, Jul 13, 2026, at 23:58, Dmitry Torokhov wrote:
> > > This series converts the legacy gpio-keys platform device on BCM47XX
> > > boards to use software nodes and static properties.
> > >
> > > To do this properly without relying on legacy name-based matching
> > > (which is being removed from gpiolib), we introduce and register
> > > software nodes for the underlying GPIO controllers (BCMA and SSB)
> > > and reference them in the button properties.
> > >
> > > The first two patches add the software nodes to bcma-gpio and
> > > ssb-gpio respectively. The third patch performs the conversion
> > > for the BCM47XX buttons.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > > As Johannes mentioned on v1 this best should go through MIPS tree.
> > 
> > Adding Waldemar to Cc. He has recently done some work to
> > get this platform working again in FreeWRT and should
> > be able to test your patches on hardware.
> 
> I normally use LTS kernel on the hardware (Linksys WRT54GS v1.0).
> But for testing I updated to 7.1.3. Attached is the dmesg without
> Dmitry's patches.  Button works, I can go into failsafe mode after
> pressing the reset button on bootup.
> 
> With Dmitry's three patches applied I directly getting into failsafe
> mode without pressing any button. Dmesg looks similar, but I get
> following kernel message:
> platform gpio-keys.0: deferred probe pending: gpio-keys: failed to get gpio
> 
> Looking at /dev I see no /dev/input/event0 device node anymore.
> 
> Attached is the small failsafe script I use on bootup.
> Hope this helps.
> 
> Do I need to change my failsafe script for the new stuff or is
> something else broken now? Do I miss some new kernel config option?
> Or is the patch only for latest Linus git repo.

Thank you very much for testing. I think 7.1 should work. Could you
please apply the test patch below and send me new dmesg? Hopefully I'll
be able to figure out where I messed up.


diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 151a4ee2803f..72524dc390dd 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -521,6 +521,9 @@ bcm47xx_buttons_add(const struct bcm47xx_gpio_key *buttons, int nbuttons)
 		return -ENODEV;
 	}
 
+	pr_info("XXX: bcm47xx_buttons_add called, bus_type=%d, gpio_swnode=%p (&ssb_gpio_swnode=%p)\n",
+		bcm47xx_bus_type, gpio_swnode, &ssb_gpio_swnode);
+
 	/* 1 node for gpio-keys device, 1 node for each button, 1 terminator */
 	const struct software_node **node_group __free(kfree) =
 		kcalloc(1 + nbuttons + 1, sizeof(*node_group), GFP_KERNEL);
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 869228a65cb3..20f89e6a57f6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -561,8 +561,11 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	else
 		return -EINVAL;
 
-	if (!refnode)
+	if (!refnode) {
+		pr_info("XXX: software_node_get_reference_args: refnode is NULL for swnode=%p (%s), fwnode=%p\n",
+			ref->swnode, ref->swnode ? ref->swnode->name : "none", ref->fwnode);
 		return -ENOTCONN;
+	}
 
 	if (nargs_prop) {
 		error = fwnode_property_read_u32(refnode, nargs_prop, &nargs_prop_val);
diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 87922479946c..28de62a42140 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -238,8 +238,10 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->to_irq		= ssb_gpio_to_irq;
 #endif
 	chip->ngpio		= 16;
-	if (bus->bustype == SSB_BUSTYPE_SSB)
+	if (bus->bustype == SSB_BUSTYPE_SSB) {
 		chip->fwnode	= software_node_fwnode(&ssb_gpio_swnode);
+		pr_info("XXX: chipcommon chip->fwnode set to %p\n", chip->fwnode);
+	}
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
 	 * a random base number.
@@ -444,6 +446,7 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	if (bus->bustype == SSB_BUSTYPE_SSB) {
 		chip->base	= 0;
 		chip->fwnode	= software_node_fwnode(&ssb_gpio_swnode);
+		pr_info("XXX: extif chip->fwnode set to %p\n", chip->fwnode);
 	} else {
 		chip->base	= -1;
 	}
@@ -481,8 +484,10 @@ int ssb_gpio_init(struct ssb_bus *bus)
 	 * one SoC instance in the system, so there are no concerns with
 	 * registration conflicts.
 	 */
+	pr_info("XXX: ssb_gpio_init called, bustype=%d\n", bus->bustype);
 	if (bus->bustype == SSB_BUSTYPE_SSB) {
 		err = software_node_register(&ssb_gpio_swnode);
+		pr_info("XXX: software_node_register(&ssb_gpio_swnode) returned %d\n", err);
 		if (err)
 			return err;
 	}


Thanks.

-- 
Dmitry

