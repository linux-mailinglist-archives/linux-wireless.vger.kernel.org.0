Return-Path: <linux-wireless+bounces-28855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C68C4F17C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF003A6264
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCA3730E2;
	Tue, 11 Nov 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExLxiB1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD436C5BA
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879337; cv=none; b=qXHlh5gILxUgeTcaH3mlASkWO+JT9+F0g9i4OnE+2C9cpKai8m5sPxB/7Ad14sQ2GdFgWREg9QpCRvbMh4qI9p2OB0ZSZlRyXuHyfQLavsVpCTQ7Jp2IHWyDKTe/HUqNUb0ZqwP5tR/J2dnk0QMQGEQJ23lm4pBeYX0QkxVlptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879337; c=relaxed/simple;
	bh=efjDU5VLy/vhK7zGORTrIfm+fmHIuPXe9o5jy9CuX/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN3iaIXTYs+96YHc5UilSchOCMRS8gUxSh0FSxDYCkHB44TDngZAM0plWwRoTKYLK4hUZqKPQCWyiddZvnwpG9AT1RBCkSx81G/adDtPIaKsfIpKNtl5JFUkoxJpEPcADa/hnrzC2jRXzDHhpPqP9GhgzWBizBHGpKSr2Ci6IsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExLxiB1F; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so3469523a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762879332; x=1763484132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNryKZJKDI+/b+cj8nyxlCwTcA9Z1oifPT/azcc16to=;
        b=ExLxiB1F7Sjs7tobSW2TghBdYpAP0WhpPEiV9RsaDRS1kfZ9udztEfEjkJ6TXWp3Ek
         ZpCftkwvX4Ct0L3WsfHKpbKKHypSqDwp+yNI/K8iboWUGztbapjXu5g64oG8w715ZcLx
         IBAvhN0on5ZNE2jR1ju2vbJYgnCN8fQR+kvoHKKhAowAM1gF4Q9Jxaeqqn5t0Y4gjcxF
         ON9y7anuC6nwbckWTwd3dfSTJzXQxib+tnHcLBYyDvh6nX2MwrD5ZYtaFBtTZDJS/lEQ
         BLzq0gV2tp2XeXwADp94dbm1HWeUX/E2hegcVhQkHykxgUUFyZ3iicFWKgAVRcJzZ8Cr
         H7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762879332; x=1763484132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNryKZJKDI+/b+cj8nyxlCwTcA9Z1oifPT/azcc16to=;
        b=N1nEprCcT4CDJWN8wmyvrYvH2DNjU5xwSEUnRq1TQCglmLiRDXROmgfBSOkIGIO47l
         rj5eNKsSQzE1hWui9mdLd6L+Cc/2zP+wiLV6Ocvd4r0ZnnNUTC+KK5UvyEioQXcJTiqe
         b7ZsPCPFVaVPQy/SWdHHMmDRpVG8UswjzDHk2hs1NpdyGMe0vE58LdR4OrNBQtq1Q20g
         wd7c3r4FnSTvtXLD5qIIL58iAEJj82sTpfFRvT1pgTIM3bdcfvyv6dmbTljQjeS+Qqxa
         pZ8Yhprs/wjYFdNFGGbZUDpRHxbtBfqZnOFxRCk1UjsdoPu3PwI2+7R/ToOuSpUCGa40
         bDnw==
X-Gm-Message-State: AOJu0Yy6/yhbbTAwv8NqZ4BYD6pyxN/q0H6buWVqT+2RfMvJRexXcVEf
	oS+T5jptc6fC2u75RhOUKM6LaoIQXmF76R5cp7DYnD4SFhYPRNMTLU+vygrtUdfH9vR7mwoqtYK
	kiIthiS1QMoZJc0Brp4yroNX0aPw641c=
X-Gm-Gg: ASbGncsONjzVRcvSzyrakNNMHkbQvp58zzZnyFKMU7HeXfJnuCdD8Z4iK7PPcBNjlP1
	2tNdMsG6l73zap1f8ibGefuKnlWH8qQzBur5vhpY2We6Q/lM3z3etzz/o6PHDRBu3scIoIU6Wal
	Zx0zwUt+4j2EsqqADI23yF/KtQsVn4r7Dbwb5mHJPb8r5gPiQ+5sw0fGapgK228jUZo/nf6vVCA
	joeLzmfOlkwWONzmm0MVg6GHxoNPq4cWwf4fr2woALUBSnURWSXkrfmcLl1D5WbzjQT6hjIqg==
X-Google-Smtp-Source: AGHT+IGSVL0wAfnyrx39IKNIVp80O8aKQq/u5oTLQupOVuO3no8kuQlP/ohvoiWDIH1oJEEOaTN2GP9WjfouQuBg0HM=
X-Received: by 2002:a05:6402:4310:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-6415e8228f4mr10881097a12.17.1762879331998; Tue, 11 Nov 2025
 08:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109193543.2858854-1-janusz.dziedzic@gmail.com> <eeb4d8484a590d39590dbbd71d0924851115b0ac.camel@sipsolutions.net>
In-Reply-To: <eeb4d8484a590d39590dbbd71d0924851115b0ac.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Tue, 11 Nov 2025 17:42:01 +0100
X-Gm-Features: AWmQ_bnnAMGwJLkJodFoKwoW_TWdKG2nRwIj772pPEXZCDHC9oAy1_4fG73D1xA
Message-ID: <CAFED-j=DABs8dTqLdSs0Qs19xQty_1bEnu49dQmkam=G6jC-Tg@mail.gmail.com>
Subject: Re: [RFC v4 wireless-next 1/2] wifi: cfg80211: allow send/recv tagged EAPOLs
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, j@w1.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 10 lis 2025 o 09:46 Johannes Berg <johannes@sipsolutions.net> napisa=
=C5=82(a):
>
> On Sun, 2025-11-09 at 20:35 +0100, Janusz Dziedzic wrote:
> > Base on EasyMesh spec and traffic separation we have:
> > "If a Multi-AP Agent configures a Primary VLAN ID, the Multi-AP Agent
> > shall send EtherType 0x888E frames on a Wi-Fi link in a Multi-AP
> > Profile-2 Network Segment with an 802.1Q C-Tag with VLAN ID equal
> > to the Primary VLAN ID."
> >
> > Add option that extend current control port implementation when
> > NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN used and allow to setup
> > VLAN id for control port frames for both TX/RX direction.
> >
> > While easy mesh AP could serve both fronthaul + backhaul:
> >
> > RX accept EAPOL:
> >  - with VLAN tag (backhaul STA) - strips tag, forwards to userspace
> >  - without VLAN tag (regular client) forwards to userspace as-is
> >
> > TX (controlled by hostapd per-STA):
> >  - For backhaul STA: hostapd sets NL80211_ATTR_VLAN_ID,
> >    frame is tagged with Primary VLAN ID
> >  - For regular client: hostapd omits NL80211_ATTR_VLAN_ID
> >    frame sent without VLAN tag
> >
> > Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> > ---
> >
>
> Having some indication what you changed between the versions would be
> good, I barely remember older versions :)
>
> I do note that on RX you document the "good" but not the "bad" case: the
> VLAN tag should be stripped, but that means userspace cannot distinguish
> if it was present, so I suppose the driver must drop frames that didn't
> have it present? Then again in mac80211 you implement that both are
> accepted, but then it seems userspace should know which one was tagged
> or not?
>
OK, maybe report it as
+               cfg80211_rx_control_port(dev, skb, noencrypt,
rx->link_id, vlan_id);
And if we strip add NL80211_ATTR_VLAN_ID, so hostapd could check assoc
multi_ap_ie/map_profile and AP map vlan config and reject EAP without
tag?

I also think about smth different. Add vlan_id to struct sta_info,
then hostapd could setup sta_info->control_port_vlan_id after check
hostapd config and assoc multi_ap_ie/map_profile.
So, for rx/tx path we could decide base on sta_info.
For STA_IFACE we don't need both tagged/untagged support.

BR
Janusz

