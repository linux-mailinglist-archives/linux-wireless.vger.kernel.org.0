Return-Path: <linux-wireless+bounces-31175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF08ICBKd2mLdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:04:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5D8776C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E733004580
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204229DB9A;
	Mon, 26 Jan 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv/LAOYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D002BEC2B
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425415; cv=none; b=oLf1dn+R5X/nCgMwgj0U9cge+3Jk/cUcS3T7PlLDH3xILvh0an4aJVlRxJKULhbbU5kSlvxF0oaFIv9cBuXO42fsjNcf/eGtF+YmnYW5DAELBJael6OeFrOZogJZfzgWDEOj6xwEAWkGlUH38u0P6+IYF0I73FinPMvYeiIEEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425415; c=relaxed/simple;
	bh=ftANPfDkKCapPd7bQiu4qZa9B3OoRodj+GpPCtPKU+I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anbbTNxO7p/GYFY3EoXsJNh59yJLFZ8OgfX4TpnyvqW2pVB9IC61eag0daGtNtkq8KbNJp/it8v4vixFpK8HsZHIvpI//4Ir1OGybJdHSM3Va4Zio+gski84VlIq9anvpYtci1aOE0jNMjyOqhgkXF4NpijGRxHxOXBTOz0+1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv/LAOYf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801bc328easo49677965e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769425413; x=1770030213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aTH8w0h3kKICWLf+Wiu0sGV5MiSH0o7xe3QPb1+JG0w=;
        b=bv/LAOYfCaD+Ii5jmiOdcBNnxl6Rui+gfePpPGSA5leUCP6NtBhDi7b2lwnWuQj9uU
         s7WxzL+XPmQIIlaUyVwmhlfT/zWqYYN+5TFTQRWHOJK2bVV+sfX8AU2GY+uDj1TF4lZV
         ewU3qVxTsw3xqV2pGXyqxijJO1HeYT3Qwfm+vu9xMkXG9YemzA/H2hAcWbGeteGOyan1
         GRYOXpIBbwj2gvxkrpe7ksbI6dymOWRoVcyTtgqMg6BoPBhKqq5qZW5l60RoVqxzBP0r
         SjsbNGl+LMz+AP7nZCe3FBumMwDaXYdIQiEmQwz8F7ysIXxPyPi1mattU3adkB9pIym8
         XIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425413; x=1770030213;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTH8w0h3kKICWLf+Wiu0sGV5MiSH0o7xe3QPb1+JG0w=;
        b=YKIq8QWTz1y301aivBTV6HZoJs52yUGHe65H9gLrf5QY+IZ6I9vd+vd8ZemPulYZPS
         9gJKsS0w8E6sG8TGkVg+2NQ3CxRRb1upPxcHyWpr+j8uwaPRzGjm/isesyMEeK4pLlf6
         CioNSGpK6HelbRdhrWLok5hYDWJYMuDDg4ATPyMns2zsqxUld6X/Zix/cmH0cMPDRGP8
         Zzs/jPbxDdUjEkAlSDGNTYIG50ekq1NWkX5cOrKXQVM2lkv21Kno69EmLrlHRkcpLKyW
         W8gdVqMSbPiITsMwshwYydq57lCA4zuOkZMiVT4YdG6mSIcto8ptfDfGtQCqloVhk8cm
         yR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB6Flw7N6t7+L15o6HiiE/BJFxbBgKOzlz6Px2b00zKPMtbHL/HH9UXX3EWSYzVK5aNBig+y0qHwxpRfrWOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiFs8NlYNx25/+TAYlWhTwYUzuqqDrE/O8st7bcKvH2OEflo5
	lcQ5yoPTAR4Pc3U+n/Hj6EKVYWt6JyHTp4WTXIgWibMGKmPheyVQStPX
X-Gm-Gg: AZuq6aImYyYE/9V/jO5IAssaUDnYahKTCAlEBZ8YC9l+FBB9btGP27lrZVkNAGsq6cK
	/FtW9swQ81/VWDkM+UssziFUXexTOPoGAlgkO/7nohDY8QSTcEtIpamfLL/cnPVbGs5AT87Lvzg
	idk9pWczji/7SqPNLKABs/huDCzw0aCUA5RZimbnUd3/C/GHjc9qWkK47sfq6+cu0jkUjarg0U8
	6uq2DgzKZej+bTQtXF66TJUKde/2hkaYdXOZDrSrkX55CCH4wTansYn3dE7jDEkuCXrWBoW/lOn
	sXnznA4rwQ8mpv79pRjKN3+7PiCPbykOq8AzyqxPws2hahgUQoR9izduUYmlbBoxps5iLuSr3t9
	31qcN8oNyPu++n6iOVe15fSlBGTth0wLZ7EidtUCzd6xe33FdBsdQU4sG7RHwc2odiTwJe3nig9
	Qgatxevk5UIvMFKR7Zua04bXO2o+E1i3F9cRC9LKw=
X-Received: by 2002:a05:600c:3113:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-480650f2933mr10392565e9.10.1769425412353;
        Mon, 26 Jan 2026 03:03:32 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85d146sm286254045e9.8.2026.01.26.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:03:31 -0800 (PST)
Message-ID: <69774a03.050a0220.3a3ac6.305f@mx.google.com>
X-Google-Original-Message-ID: <aXdKAHW0z2qC7s5e@Ansuel-XPS.>
Date: Mon, 26 Jan 2026 12:03:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Shayne Chen <shayne.chen@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: Re: [PATCH wireless-next v2 2/2] wifi: mt76: mt7996: Add eMLSR
 support
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
 <20260125-mac80211-emlsr-v2-2-466329d61c88@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125-mac80211-emlsr-v2-2-466329d61c88@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31175-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,mediatek.com,gmail.com,collabora.com,vger.kernel.org,nbd.name,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: ECB5D8776C
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 11:51:31AM +0100, Lorenzo Bianconi wrote:
> From: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
> 
> Implement set_eml_op_mode mac80211 callback in order to introduce eMLSR
> support.
> 
> Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Tested-by: Christian Marangi <ansuelsmth@gmail.com>

--

	Ansuel

