Return-Path: <linux-wireless+bounces-32801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEVaDs9vr2m6YQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:11:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C53243613
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E293056147
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00924679F;
	Tue, 10 Mar 2026 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfzlBAz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B122A4E9
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105090; cv=pass; b=rYCJPJK8UytpkQZ9w4j4o2chZWhXPGR3tDFK9G+0RNnz2QertJYLC9sCHsvEsVrrcBDG28ni2Q9iP0VRo7ydxwf8oaANUJXkYBMyGTcaUTPwkrMje1auu+6SS+At3i7ApAyoE5YSyj/pFp7WnSbKCXRdyf5UKqAC+eim64eZdNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105090; c=relaxed/simple;
	bh=juCfXUUuExcjNHcu3zSf1JQAn4aCOtYK/2BxSHv7/HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onCHl0EAB0fhswMcFUpa4dwS+3gGpdNiMkx5Z/cdcDVUdGyupiB125AQUzWMh/QAUluu023Z7NU5eVODQ+hkTQQgJ7/O7mAO5IIZxcUc5BSlyfjliLeP1GIKpgsvytO9oRrGAF+lPzXo8AuZR1KYOjfCDqhoITDdbuT0yR8As1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfzlBAz+; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899fbf92bdbso118801246d6.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 18:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773105088; cv=none;
        d=google.com; s=arc-20240605;
        b=UA2Ul/tK5IEdvpE/pGxgI0aiIGlLi5xwR+RsY5Dlfy17S0C6ip0ADBjLZGsEjCrGPN
         /X6qou9IqyQiptiz59y+YEvtTM64kfUAcIUl2nBUTJprbPfQ4rukeyNC/gHko2MSkKwC
         4xAI0dpLXiA/uHAXtMS1WvHNMAJFZwN6k8dha6oolks5/1Za2UX+NKMVpj5yWIvOU8cs
         zPXFyY0tV73ro7AXcHpjABEs9yfSfobz+5qEe1j9NIOP1Y1UC1/uQOxYvVgjwzskM/rS
         y3nmOh40qJfplwDvy+6LVne1QeEb6kAk/2yZFTtMYAgLC7oOUy3TNfqAFottsojTQs2t
         yxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=juCfXUUuExcjNHcu3zSf1JQAn4aCOtYK/2BxSHv7/HE=;
        fh=p5yqRjJi5uaU82wrj4SbT9RxW61qhLdWgdhs9hFVLUw=;
        b=fPuMbkKb9Xb82yIfmO/Gu2nuls4ZSJFhuc3LOFwWmWkh+7/myNI2TUtruMGUZrgN1Y
         zq1EYs2aP2KJZZqwZWmp/Pyk8+S5H4VXEwY53SRdB/Ronisc7F5PkPb85wlFeQ1VTBNo
         gvtO6w0tnqKQnL2SFss1aT1cxAIugqXKJQZwSTtUxMqlaYMe5p24gByaKgyeVfRWr3h0
         WOj4rYdLb3OPofRGqnP1FT24WSn3NWlc34TuUtl8K+H0MFv2/5ngAB9RGlRxh0/UcgOZ
         pdVmuSr4ikqfR9mXWIk4SFSFHS7p/ZVL9wwKbuCD73JuuUyTnTPanYVn2rIF+kxYPNFl
         /z8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773105088; x=1773709888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juCfXUUuExcjNHcu3zSf1JQAn4aCOtYK/2BxSHv7/HE=;
        b=PfzlBAz+QmtqF7NKd1G0V0oEF22FCW2e20rdq5n2WCaOX3jIOv8IXwx5Q/dreB2wvH
         vWeocWM0J1zYw+JwSAV1avz32YgmwOPgtXSrGf/RTuUlzRDIMsMBOm+l4uGf3DgeSIpI
         ro4qv0p0FgtxY56/1mjCW8rEGCx4N0pbEAEJ2ekrte3if0uumNOrxBZ5tqv6Exm81YsO
         1yQRA2GRNF3PARqQtxEVWyLuPNtAsq7gW3tJBzzcP+lxOFFK8JSeprx22Z3VSvdJ0RV+
         p2mpPg1oFdOojcpQbrh/pbX9IDk0+QX3UFDOIj5kKZVQzkaKtL+6YShGuRltlwE3vYji
         Wefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773105088; x=1773709888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juCfXUUuExcjNHcu3zSf1JQAn4aCOtYK/2BxSHv7/HE=;
        b=ACAS4fiLjc2gnBUVX86cB/UeNcOiqVV7eDbuDdcPaOeIyZwH1RITcOps+b7BN8I8G5
         j17z51DW8Iqx8VvZDUiTpIJOxdpLOVmkotUonKaI2/aWBpEibN9aMolLQyGxm7dEJFGk
         vs/u6GzW8kLFE+xWeT9KDRvR5+Oqx5OJC3x65tcrnCC8f/ARkspt/LGNIMmw2FCQjpvN
         FII0GSf9RjwU7HE3NiShrNTjtGGIo64VU2NOdwCQYuCqsVVBRJbQqfS6zf8WYQ/tMaCR
         YCBX7G7y+NuHS3jRtLSCyA2dTWjh2oJ3enZvssTGtsK5S7ZqMPJE2cp9Miwu2Vtzp7HL
         oS5Q==
X-Gm-Message-State: AOJu0YxJUHGPFV6AmK/C3XEMkyuQEXcGc9bHnz5XoUzBTudJa/vwD5aV
	9sIMY+bhoCFU2DEIR0I8RF51IBKCltT5vrReXFYvyOAUv50rtBU+tBuynPxKkR+ym8Nlg5f/m57
	gVXbZon0pxSYqnozmgf9X9NxM1kdnABo=
X-Gm-Gg: ATEYQzypnaTc+SoABUMy5fhM7yZi1HnV00hftAOq/Yshv0rMokI1mx4kdSME3gwFcho
	cIgqqj06y73iDkRhcDiVTfz9X+/aJpk0d404FEdy0unR0Vh5wVsHX3kPTpwMWN8rjCTW8cmCMaA
	EXl1Kk942IkWQqo2+6H01JxP5y7d32YBhwRc58fS1+Xnv+xENvQIcGWuereAopXdR1NY1fh6l+H
	Bu9YgvkQCfetbZ9tvNGhF/+IsXluqVQc/MghXDF2wvrEAll8Bt2k4zrxTttmX/tSWN06UV2qk1b
	9eOVeF3D8rGrnWSjvCPDHA==
X-Received: by 2002:ad4:5d6f:0:b0:89a:3bb:3c45 with SMTP id
 6a1803df08f44-89a30aa0cefmr198616826d6.33.1773105087965; Mon, 09 Mar 2026
 18:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309215907.5789-1-rosenp@gmail.com>
In-Reply-To: <20260309215907.5789-1-rosenp@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 10 Mar 2026 12:11:16 +1100
X-Gm-Features: AaiRm539ilhUNKbLBRR37080yIh2tOm94CHupgXvPMVDWErfsgjc9mqMF7mrcx4
Message-ID: <CAGRGNgUsVxecZobcXvVwmaHD+QHmzp4qTPGSLOpJb6Uinrpa+w@mail.gmail.com>
Subject: Re: [PATCHv2 wireless-next] wifi: brcmsmac: use FAM for debug code
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>, 
	"open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS" <brcm80211@lists.linux.dev>, 
	"open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS" <brcm80211-dev-list.pdl@broadcom.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5C53243613
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32801-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.linux.dev,broadcom.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juliancalaby@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Arend,

On Tue, Mar 10, 2026 at 8:59=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Debug code requires a separate allocation to duplicate a string. A FAM
> allows properly sized allocation with a single kfree.

Sorry Rosen for hijacking your patch here.

With these changes, does allocating and copying the string really need
to be behind a DEBUG ifdef?

The allocation, copying and freeing of the memory isn't in a hot path,
so allocating/freeing a couple more bytes shouldn't matter that much,
which only leaves the memory footprint, which appears to be less than
10 bytes.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

