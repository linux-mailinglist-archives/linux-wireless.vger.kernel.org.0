Return-Path: <linux-wireless+bounces-37211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZlN4dBHGqQLwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 16:11:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2699616A0D
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECF173005318
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C231D381;
	Sun, 31 May 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6ZuRhvU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81318314A6F
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236672; cv=none; b=hZQxUPX4LZy5DGUSIGvZ5uqVXYZHUX05MUCqc9U5GJL8WXEuXYPzIrgiuKJv37VpOpQRekcbw9Or/IcqpquH8/6S325Na0MoGVSItXoCCeZv/8CNBahMUKAKzIfop9EURPEzXoRXcoReWCw97RjsCDqAqbxI1C5qFX3cPristJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236672; c=relaxed/simple;
	bh=t+oeycO6GvQOzbd+lQKlyL6XozWlqFqRzNzs8x0N4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mIzyhRkyNcUy5uqUrA43Fui7HzMskCEJqrKcoDq3hdX1a/E8dTjJoYoSoeY0l+++72PqjhbBeTPUKRfIJy27DXRp5FuYogcfiNQtRirnCp4o7kvtH+iJLEzwMRuz48yPrQqD7k68MG75d4sdVDS4GWoyqaD1EWMex/tyL82knKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6ZuRhvU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a765f2feso5506925e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780236670; x=1780841470; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8QEYFNQnPe+ewpbSA+VRJYZ9+X2s8GENU7SK9q9FNc=;
        b=Y6ZuRhvUDzLF09U/qCJuaeYWiXtI46LIJcBs/QoO89CDiNn0OWwcjXjykQxnoJkeVk
         xkRIC0XTpZGhHlpQMtYVQe0MYeQrLWfADXp4JhDPvVO+of2aKFJqggnLPo0WV8Zx2knU
         hPgKqSe5MnpptBgAMIBu0/9VWyPYvXtc8q6OM1VYu0jcgulFfGYD36DKj5TKJzaHMRwW
         H/6N6jNcPemLSR/9x/qVNCEZjI/kl1d9i+69PFozjgNYE9IV9Kc6tCRy4salF+e7NVud
         8+nexqYCYSaAR+K5cph0GvE8kbWBwEBEw1HO4ZYyHni/u00zraT7T1iHZDg83ga93j5P
         WqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780236670; x=1780841470;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8QEYFNQnPe+ewpbSA+VRJYZ9+X2s8GENU7SK9q9FNc=;
        b=ARxUiSMG62RMQbvrANwvb2QOxd+SMVzb7tsx1b9Va8cKhTCbZhhe6ypoE1xw5W1rra
         O96S+tCyCQTHWfumnzH293PxRE942rifg9JcR13EwoeLwV+0i8r5iv2PAm8rgxgK3l9B
         4WuJIENFKs4cmmxLk8PF8/PfSClDrxM2pWS4ix0SNuGNUgRaSlVCwPX2YIXVHQ86Usie
         8Y3uiu2QaoDs6eCcuvyWVdN7pLRtUsmyf5Thb21LEuLRzKb587an/3+twPhVrvN/HUpH
         Y4Sxz9FaHSc5VvTWgTf3wtwWfomvz4w6z/FVZBQR6klqctdui0C/aC1+zaBg2sFYfqgO
         mgrg==
X-Forwarded-Encrypted: i=1; AFNElJ9IPDuIlnz6/5/HcLf3/AtFJBwhmUFkf7h6YhfsdaQDGqGfCRqMeHXg63Kwxkl3j1Z8wxHZAsQo4bYDi/EI4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyePtHmXqv0zGTB0elB99+pJVLuMnAtzhElGPkLx0nHxotDQz17
	iTyexaW/bN8sH/JyIhWbLGwabxdqcrNGs3sSmKxxucIVvpuXA3WiPtk+
X-Gm-Gg: Acq92OGwqoKFOgf0LSrBQwtUKYlf/JH/4rZPloygY8e8ZAB6IAsdGKr+o8ZA7GJxmxn
	WINYXT+1O9SVrkesmhqEbIXiQ24jFQaHwgueETB7QhIIRny9JVB6MQpZlGGz/ndwYwDR3vs2VJV
	AUyj8N/qVy3F7Rk7bfiAroN507OrVSH/tfeVZAyhjekQmHVV2icWDRrUXTxALiOsGZc/SgH5PPs
	IENXBALa6hquJIuL7knko355uFL9BxtDXirtu163LyYvteffkQ+U0v9hnKyTZBNVGVWO/yZ1wQ6
	zWpxWlPLpg+g3wiEtCisol24uPEOnabz+TWZn1uyTJ5mU6FbMpbZXtPV5Ljx2nIwdVec1Yx/sqG
	EydQkkSpSS9CqrSVwD3C8QqFtoideW+EtJwTBl6XnpA3owRHDH/wwaFb7mFIsPvjVqXqdQo5Hau
	j9jvLpD/hwYFeTilDBL0jtAsDLw3EIUKTsSg==
X-Received: by 2002:a05:600c:3487:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-490a2918103mr145485145e9.10.1780236669641;
        Sun, 31 May 2026 07:11:09 -0700 (PDT)
Received: from Red ([2a01:cb1d:897:7800:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c12b2dbsm75410815e9.6.2026.05.31.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:11:09 -0700 (PDT)
Date: Sun, 31 May 2026 16:11:07 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: stf_xl@wp.pl, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: net: wireless: ralink: RT2X00: regression, hostapd do not work
 anymore on 6.18.33 (work on 6.18.26)
Message-ID: <ahxBexU0n_yb__EV@Red>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37211-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clabbemontjoie@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E2699616A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello

I have an hostapd setup with a 
01:00.0 Network controller: Ralink corp. RT2790 Wireless 802.11n 1T/2R PCIe

The setup work fine on 6.18.26-gentoo
It breaks on 6.18.33-gentoo

I found an hint in dmesg:
On 6.18.26-gentoo I see:
May 31 15:48:45 trash01 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0003 detected

On 6.18.33-gentoo I see:
May 31 15:22:57 trash01 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0006 detected

The RF chipset seems badly detected.

Regards

