Return-Path: <linux-wireless+bounces-35402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOT8Czy572l0EQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:30:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 808DA4794E2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2BC301C15E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905473DCD90;
	Mon, 27 Apr 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOXVIgRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DA3AA4E8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318164; cv=pass; b=NHTsGecmrH8z6/EDt8c1VqrVT3GsQBzYhaFBaiQsgCXb90gLyg4V/FY1hCbkyhb05nESqAvaLaiIJiLe9/31UXF4twZRb2cQzJCxxOdBQlXG/GBRXquxdwLLrkKsEPj4/2+zaX70aFRORYLIvCIznU3TmFrNVgkIcFMd1slcvt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318164; c=relaxed/simple;
	bh=pQExcR9h/ZL9n08KBh/CERl8h5WgWQHPzdybQGi+r0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSroclM8Pru/bZ+GjoplQZzSkZ0acZY1Hcdqkz8lsN9i/uSr7Z2kUPvmRoYKSCWgB+uHTMKnnC8nYqAMdU6dylToEIfUwDzzX16uOv8lDjaZbgnzG4+oQ4IFduEWJlG4gX2xLwvIrSoWixbP+dpKZ6XTMnmOtnnuCq8q96q3nFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOXVIgRJ; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f9568e074so1755020066b.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777318160; cv=none;
        d=google.com; s=arc-20240605;
        b=QQXX43mUQW8Xv+VBMkItP3FPuPyV1+S0SAM7At/uoBv/S170Sle1N2QfKhDviN2Mu8
         DQt6H2YUsiGmq6G5laez9QqqdAkRh0y73b5Azr1ZDFAmnFxh8Jmipz9xvZHLjLfTLfzM
         Yld2I1Ue8aPY+N9YcftJmX/bL8IHw9NtkiYoXE+f0mITNglM3UzJKs2BfyBXUw0gRf7N
         BOOwDhezrsPQy90RuI5b27ZXGuga5LcbOysv/c1ylf+0wUivg/Q7RAPsHNd0xGppJ63l
         iuU4LPbWGYhPJnIKLEJRYu5fr0kIpAmwVmXloFrfH2e9Ete8fp/n9CGAlQT+eb+wjs47
         uYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQurm3gyUMWsECztgAmZh5kFWRm6aSAskWm6zIeBKm0=;
        fh=Rh7kkKWWiTDpUIyFOYdIbBXqZgMYqYZ/zCrW/u+kaOc=;
        b=EkR3Ko++nKwWgUaFnVPBf9nV6lvdd/4ITBDPdLOAfqA8oLO6WNw0GB3m52iqLRo1Kd
         igkNJZq3qNxU7SfYs1G4vK46H0lwvXdPp2inmkiwUMXxhDKcpqOmQj4tA8e+9z877Gax
         xxtMnhUF5z5/SDH+JcgqzjEW5VbcVGHLsC4rmhoBzAPsOuAQLj3XMuynwPWj7f1t7aVE
         aDQi9a47YBLyT5BcHBkHTkxdq7snuNcBPh4lVk3V0Z+/N3IzPpRbW7k+vh+UEj/g0BEv
         1yyqtfvuMonpU8styvwtcdei0mkHoHx2uEqtPrtHhvTef8Ag1Lu+4IXUh+ErJ9oqd7os
         e6+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777318160; x=1777922960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQurm3gyUMWsECztgAmZh5kFWRm6aSAskWm6zIeBKm0=;
        b=KOXVIgRJJLBe+qYfMGyo+8XiRJwQPAx9fxn+v39ZEkVf1M88z5E81Mgktc9sRLDrzR
         IO/nXmP1KFg/+j1rmg8/4AtlhIyVsOmX6zUIsKqigcB25Xrhj31ndF3uKRB3xamElfTq
         ez6Hd/W4W0fbjBpeYRnXFOlaU6yfsM7tKtr2tjhPZ5M9eZilond4l1Cnj8Hj8FwLfV6V
         WCa1f/UaD5Xq4yy8j1ZWAhUaXmxQ6LYIO/W/OV7U2xif+vRLuPshuZuQmEicDoYr5eFu
         TEliN3rOMDCY8+0GeisTyI+j4YHXu5ZOCc4H4LLhDT2oBJCNmX7KrdAqH5OJVOP1pcVU
         0q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318160; x=1777922960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQurm3gyUMWsECztgAmZh5kFWRm6aSAskWm6zIeBKm0=;
        b=Q+q0QVFohIdQECpShHckLmCKT6ZEDXipgtWq1orRhWAZsO6F12sNJGCBRuPpmrmDF9
         hapmXikP7inhr/xf/mYwc4OAsTbaPb/X+J9wyv1KbXT7X2NHfD0JeJarsODpwnB0FIcp
         at1rNf8sQNS5/XqzVdYe926znBxMkqBsTc+jcg5ba50rpR7AnsogPAjQi8Mca9GfnAxv
         Q10kEcNRTmrAta8CHuLtLkxd+D4XS05p9Sth0VO1udrZ9r+ZwTxPMDGPNWmb21ZMCRLh
         OX9B48Epb3Vtkew7tUbmr0GxT5QJn73G5BlUuT0RS+ILDAh+i/Oj29jw20UTW4/XSnxQ
         /+sg==
X-Forwarded-Encrypted: i=1; AFNElJ/7ms0FXiFnW10aJ0VnGeWgLxqPOy/DXJPty4hQlh3iGExLvmsNZkU5ZDWxdAAt6GhHHnLF8nM+uJ6SsfoELg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/05BHPQ3QwhjBLqYfJlMgFxHpVMK7vlO2UEb36cQ5wwpJPXY
	Q1cSgrzZp2TFsaB4nbnrB0Ru9J1qVJsFqM1q35DsY0q5i6ZHN7uQXuNzg3CdT8nf6pZ3kucJKmj
	1oMbNsiJZpbCrXl76pOw2YnXNWvlJJnSpaML5
X-Gm-Gg: AeBDievmrfddKEdZk82fQjp7pPGneF/Hee4r8u9Q8CW+qMM2yWBFtdWKK4AhQ4nelHd
	uBHZ6CN9gJ9Kl3CbVPZzAuydPWnM/+tSkxSHzSJgyPwyvSeUSVuADOgV2e+3ZSktvcq1sv1WUVY
	mT6ig/g1eJpG4XLdQFBv2w4evy1GqXddBmf8OncTJJT2LejbOn4/FcDABG41O2HSgjdVjAcbyXb
	YvVFfvNXGN29o9AEtE3opAyERrjjgWLvFqBgCCqTCGuSuD+NkeM8FDEUC6akH5DViSSBAJU5KMO
	hsZyZaBwUnwneUOw4vE5aM9IEB85nDVhfZ19N4q6PQBn8S2ALhCxtkad252wPbXiXzKpx7L4doc
	hlvRhcpg7vZUass66+yuMUrxHxDeyLZY2J0//faMnFRDtI8NP
X-Received: by 2002:a17:906:fe03:b0:ba2:ea16:af6b with SMTP id
 a640c23a62f3a-bb803e5c93emr7975866b.40.1777318159390; Mon, 27 Apr 2026
 12:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427051652.954059-1-rosenp@gmail.com> <20260427073206.GA2096@wp.pl>
 <c2263e4917557cb1e07a56c3bfb9a0507bf81f00.camel@sipsolutions.net> <20260427105445.GA2620@wp.pl>
In-Reply-To: <20260427105445.GA2620@wp.pl>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 27 Apr 2026 12:29:08 -0700
X-Gm-Features: AVHnY4Jdijc_Cqdqka5z8xGK_T92ju_NCxcx0w_1_k7dIoNNEerdKHd5R2fWLBE
Message-ID: <CAKxU2N_bGO-FBgutLyxLW=E1ZroONnT6FjKBj5hRiB2K6P6KDg@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: rt2x00: check for of_get_mac_address error
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 808DA4794E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35402-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:email]

On Mon, Apr 27, 2026 at 3:54=E2=80=AFAM Stanislaw Gruszka <stf_xl@wp.pl> wr=
ote:
>
> On Mon, Apr 27, 2026 at 12:45:14PM +0200, Johannes Berg wrote:
> > On Mon, 2026-04-27 at 09:32 +0200, Stanislaw Gruszka wrote:
> > > On Sun, Apr 26, 2026 at 10:16:52PM -0700, Rosen Penev wrote:
> > > > is_valid_ether_addr is already a check of of_get_mac_address, in wh=
ich
> > > > case it returns an error if false. Just set a random MAC on all err=
ors
> > > > except for EPROBE_DEFER.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> >
> > Are you sure? I just randomly checked one caller to see what the
> > *eeprom_mac_addr would contain, and I see
> >
> >         mac =3D rt2x00_eeprom_addr(rt2x00dev, EEPROM_MAC_ADDR_0);
> >         rt2x00lib_set_mac_address(rt2x00dev, mac);
> >
> > so that case assumes it can get it from EEPROM and override with OF, bu=
t
> > if OF fails then it would still use the EEPROM address as long as it's
> > valid ...
>
> You have right, please drop the patch.
>
> BTW, the code should be changed to move getting the address from OF
> out of _set routine.
Where should it go?
>
> Regards
> Stanislaw

