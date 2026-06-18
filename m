Return-Path: <linux-wireless+bounces-37910-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zJjZA4qENGrFaAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37910-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 01:51:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EA76A3219
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 01:51:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="m/bjOfWw";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37910-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37910-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5F473015194
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8CA347533;
	Thu, 18 Jun 2026 23:51:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9F1D432D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 23:51:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826688; cv=none; b=axnNofnBmuvG0ahJvi16p1F336IJmEPfd1p8dn3DyjBtz9EEIgwPsrGqZoJH8KnlX+uq0kqc6dpJ96kxFoJ0/F2oVyl3v0YBeDRfjdsI58GdY8hPGBlyTQqLfD12ocfP+KoUnfNLUrrKXI3OISLsYDbIBcex3HktqUO33LqWv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826688; c=relaxed/simple;
	bh=3A7AtmR5Fjx/ufI6DBaF4ORsth5x4xO8x5gV+HyqeX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRWSMZkD7ljoUjzCVtQVZVNd45SnK1TpJQeVMuth7oLOv5Gx8DvRhzsE2FufHBkJx5jD2HlA0hzgczYqqoRqZ3aF/g2utMqTOhVgdWiMye79peb1bWdtrVY/jNsGjK3T997mF7m+avdKChOuTtdjfHpEhq/M8p8e+bMZuY/LIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/bjOfWw; arc=none smtp.client-ip=209.85.167.52
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ad4c0c94fbso1579338e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781826685; x=1782431485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8uZEinBiEzubyVwK+mDqbuOj5jjsF/asva00uL4IEmk=;
        b=m/bjOfWwXJ0oy3lGJP6pc0/K4a7XworB7sVG5CT2iwHdvaLT+Rdfxi+aROThlo7nNG
         yckdVBf+eNKXa5Aa+U0zMV7OtffprSoubo4Fp5GCKyLm6ZRxcJ4fnGl9xSsYPDoQXmrL
         DA0+SDuH+bmB41M9kI8UlQYrzifSZkyHYowmCkwE5/O/A4dkKsyPjQ99fBRKX72V7/Z0
         hbW8OhtYiwlvYEQ/4h4kF+X705J8yYGMRZKLaA+OiwUHqVZ2wgnu/sX1T3NTlpglIS2S
         dJov4MVNF4Bjc0Mo2dhI0YD0GGdwOaRfl+myHUrpuyrDplQjTDfSEYntkFNlo+MHF0pQ
         s0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781826685; x=1782431485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uZEinBiEzubyVwK+mDqbuOj5jjsF/asva00uL4IEmk=;
        b=dEASNulOMf5FoEXLvKoPLu3BHkF/86IdWCCGAlKHA/kwktl5U+9QPGmYPDxrLgIN6L
         fUppaWlFWrdRvJ8uwMUPcQBza63/lSpE87UBYwxnpp6OD4DwNQePNs5hf278p+4kCCpe
         yPe8/+Qc6cPkDD6ZNIxbw92FCzqtTlNwmO+ljssLLzmcYqayQqhQTA+TKSTWDboeS3GQ
         j7n3Qx4/NLembY6WZBOwQC9ADe36EUO0PZIadaFhSYAbgaYbtvp1Kpc9lTjmXAvQcI2D
         CqGvQemCvwV4JGk5HXOJbyACsRM6eS/XeIu0EhWID42FO0z0RGBR/c2rdtM4L5To4hn0
         tjig==
X-Gm-Message-State: AOJu0YxYCFLzEehqEgv/9/4fPSYeoZJASWcIAk8rUB92o3deYN6T/m/1
	IWhR3FEMxChlOyiEWwCK1oEGINn1tX+wNGKN/jIfWTAfQML0iYN8f86m
X-Gm-Gg: AfdE7cmsrh6ybQrJZpX6z8L2ZpDNoXCbsoqhbSQzy5QZ9jJkYkZ68kzmCb+PllTP/AN
	6nJGN7LrxOSZ9FzTDkhiBYzKWNgGTV5qRNdxQ5MvbLmT1LBtvUhUBk2b4cJIu2JbFHlTiDq0on1
	7XiZFDBMZ8ZnfGIixpCdwtY5IDWJw+CcIGKIKgyJISFFLhVY39CWXNpQ8r9Qt1MFbGQZN5226nm
	GJlYRbSfSQWaGwccCdRsOsIFlHE1v87Dgx3hQnqidgY8c1J+9n221NaYJAwrZKM7hC2l3k5f5bL
	EOOuTKJgXhZelp/2muWD39n50YCxX9loIDO/UdBN0oOlFSnYjNy0f9Q0A4nZoiBtIu4bNFXDXaj
	E2FmKJQQrqBhQNl7l3zGgSCVFouql3+TK0Y7yHBDL7Xa0LGqjZRftDMfyolL4mXiLy/QFsl8C9o
	kmDDdsp3j4pgDp3w==
X-Received: by 2002:ac2:44d4:0:b0:5aa:8823:aeba with SMTP id 2adb3069b0e04-5ad57720e67mr181855e87.47.1781826684481;
        Thu, 18 Jun 2026 16:51:24 -0700 (PDT)
Received: from localhost ([2001:678:a5c:1204:3d4f:47f9:ac7a:fb85])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad57245f5csm197309e87.28.2026.06.18.16.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:51:24 -0700 (PDT)
Date: Fri, 19 Jun 2026 01:51:23 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix of_get_mac_address error
 handling
Message-ID: <ajSDtsJCmYnMNJSD@parmesan.int.kasm.eu>
References: <20260427051746.954704-1-rosenp@gmail.com>
 <ajRmlyx_AEGybykL@soda.int.kasm.eu>
 <CAKxU2N-gfH8Tq29-j2MArogLZuO7JEqtN5LNPVygJzrAERa3cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-gfH8Tq29-j2MArogLZuO7JEqtN5LNPVygJzrAERa3cg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37910-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[klarasmodin@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[klarasmodin@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06EA76A3219

On 2026-06-18 16:01:45 -0700, Rosen Penev wrote:
> On Thu, Jun 18, 2026 at 2:47 PM Klara Modin <klarasmodin@gmail.com> wrote:
> >
> > Hi,
> >
> > On 2026-04-26 22:17:46 -0700, Rosen Penev wrote:
> > > Check return value instead of is_valid_ether_addr. The latter is handled
> > > by the former.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > > index 93d91264687f..0f6ccf6ed53d 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > > @@ -93,7 +93,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
> > >       if (err == -EPROBE_DEFER)
> > >               return err;
> > >
> > > -     if (!is_valid_ether_addr(phy->macaddr)) {
> > > +     if (err) {
> > >               eth_random_addr(phy->macaddr);
> > >               dev_info(dev->dev,
> > >                        "Invalid MAC address, using random address %pM\n",
> > > --
> > > 2.54.0
> > >
> >
> > Recently I have started to see randomized MAC-addresses on my x86 laptop
> > with a MT7922 and the above message printed in the kernel log. I have
> > CONFIG_OF turned on, but since this is an ACPI system the device is not
> > described by any device tree and the earlier of_get_mac_address() likely
> > fails with -ENODEV. Looking at the !CONFIG_OF stub for
> > of_get_mac_address it always returns -ENODEV, meaning this will always
> > randomize the mac in that case too.

> IIRC, the normal device_get_mac_address supports nvmem now. Does that
> fix your use case?

I tried this:

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index b99d7452800f..243a8f2c7bda 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -174,10 +174,9 @@ int
 mt76_eeprom_override(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct device_node *np = dev->dev->of_node;
 	int err;
 
-	err = of_get_mac_address(np, phy->macaddr);
+	err = device_get_mac_address(dev->dev, phy->macaddr);
 	if (err == -EPROBE_DEFER)
 		return err;
 

but I still get a random MAC.

> >
> > Reverting this patch fixes the issue and the correct MAC address is
> > used. I'm not sure if there is any case where of_get_mac_addres() could
> > fail in a way that results in a valid MAC address but it seems unlikely
> > to me.
> >
> > Regards,
> > Klara Modin

