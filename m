Return-Path: <linux-wireless+bounces-3079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E078848686
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BC11F236E3
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C5F4F20D;
	Sat,  3 Feb 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Bz8SWK9R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467B433D5
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706967334; cv=none; b=saVqPjgsxCMbvNlplbCdobJSDM1s6GuV2z4xv6GbwfyE2V9JpvNSHV6HYzX7ydUI3hb2wA3R0F8vpSN0Tr8lL7KIvFiKiTdyd9YWLni3vjlZm/UUK9TnlOJQU5/v0R5UaQ/wwqvGqNxPM1Qe+IGmO8lYjfqIrlkUnXcAtUJKgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706967334; c=relaxed/simple;
	bh=YJOtvJIYPQd5XtTnmTH8r8R7gRj6X3xFO/v+A/D2rMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bem/EAnZznWtrZ51TyAS6BfB7NU1UGEMyrHeQvtXo+8r33EsEVfW/Vt5so3DsCJVeHENp9klK9dldbfYQ2oUl7FqxhYIlgDwcPCyt7I7AIb0VrSL5b17YMDJ+EEdgzYj3WIg4WDtW/ukHUkn3y68Yo1eaIWZNFfxFVI3eXl1Pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Bz8SWK9R; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 25515 invoked from network); 3 Feb 2024 13:35:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1706963729; bh=QxxHIImV3MCE9vd+VshaUVCrAULAaVrobwEDQL3IfCQ=;
          h=From:To:Cc:Subject;
          b=Bz8SWK9RnnDHmgp+IxCWREb7z7VmAqKooQhz1VeDsGBWW8vtpqqop2d8UvNK7fppn
           IIBz6dYfiFdxqsDsYd487VArRi0IC7o+vll+eUmlLIYsmKxsq5wG+WZvXjM8Mn9+J2
           yMkUlA4utp51JSKt3KG13EBx3en4duGA55m54pAk=
Received: from 89-64-3-131.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.131])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@kernel.org>; 3 Feb 2024 13:35:29 +0100
Date: Sat, 3 Feb 2024 13:35:28 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] wifi: rt2x00: fix __le32 sparse warnings
Message-ID: <20240203123528.GA170353@wp.pl>
References: <20240130151556.2315951-1-kvalo@kernel.org>
 <20240130151556.2315951-5-kvalo@kernel.org>
 <87il3aaqoz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il3aaqoz.fsf@kernel.org>
X-WP-MailID: bd8e06ece1c5ddc73ba64b1554e50a1b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QeME]                               

Hi Kalle

On Wed, Jan 31, 2024 at 09:48:44AM +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
> > Sparse warns:
> >
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39: warning: incorrect type in assignment (different base types)
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    expected unsigned int [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    got restricted __le32 [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43: warning: incorrect type in assignment (different base types)
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    expected unsigned int [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    got restricted __le32 [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43: warning: incorrect type in assignment (different base types)
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    expected unsigned int [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    got restricted __le32 [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43: warning: incorrect type in assignment (different base types)
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    expected unsigned int [usertype]
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    got restricted __le32 [usertype]
> >
> > rt2x00 does some wicked casting here so no wonder sparse warns. Clean that up
> > and use cpu_to_le16() to avoid any warnings.
> >
> > Compile tested only.
> >
> > Signed-off-by: Kalle Valo <kvalo@kernel.org>
> 
> Stanislaw, sorry somehow I corrupted your address but fixed it now. Let
> me know what you think, patch here:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240130151556.2315951-5-kvalo@kernel.org/

If I analyse it correctly, patch is not ok on Big Endian machines
where we do bytes swapping.

Let asume reg value is 0x0D0C0B0A

On previous code:

-	*(u32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);

result is

eeprom[0] = 0x0D
eeprom[1] = 0x0C
eeprom[2] = 0x0B
eeprom[3] = 0x0A

After modification:

+	rt2x00dev->eeprom[i] = cpu_to_le16(reg);
+	rt2x00dev->eeprom[i + 1] = cpu_to_le16(upper_16_bits(reg));

result will be

eeprom[0] = 0x0B
eeprom[1] = 0x0A
eeprom[2] = 0x0D
eeprom[2] = 0x0C

Maybe just casting to __le32, i.e:
	
	*(__le32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);

would solve the problem ?

Regards
Stanislaw


