Return-Path: <linux-wireless+bounces-31524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJG6L5gsg2kxigMAu9opvQ
	(envelope-from <linux-wireless+bounces-31524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:25:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378AE50BC
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C431D301014A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59EF345CA5;
	Wed,  4 Feb 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfn+1s8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5E30E83A
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204095; cv=pass; b=r47jHnE81E2E0pTaMw5NKFZyd6naAZQ3x78bLHVsLbGtjrWSUDIVJ0phmB2SthbypbH4VvLJAiUdDT+meEEU89dVvLsWDKk8Vm6Vt4mWILyp0EvGSGejJwNxvsRkhAWd9l2jJaBg5R919wDQe/YgtJGfbkp1mLaNT6tptKG7M5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204095; c=relaxed/simple;
	bh=SvtMDCDwIpBhd/Zjo6iSRYvXLthlSVmZCy8NEgqR44E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4+0UKluOVF6VfyGs91BUb75rFG8y/yg48Hm6zmMk0v3Uw0riA0KFrliUvV90ttIK1ck4o46rEUi8voj3EQG0KLXmNKsbpOPKGaR9ePHnGTB2PwBKTqgAtARvLr8+nBbFN1cwlSpce0hJakA3vmBP3N0ZBsgxgHefjBsXcb3tGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfn+1s8l; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64965ee303dso776954d50.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 03:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770204094; cv=none;
        d=google.com; s=arc-20240605;
        b=EIbbXBhMZiBEWboHt9//nFI7KLMCTq5mKMVXmaT/1SbxVpWjOw7bSPN32ZhhbRxSIg
         MlVhVwHVgus1DLcqWckzwBOE/47LXOdOhNqMAwUU0aqfRadGW3OpyVHa2y3DomVqqGaF
         a7UZ/qBMbHcBk4mn9dmq4iSAS63Ir2ehkATmmN3pR48QAfdOp+Ah4QQlaIHUgX/OqiqA
         bjcZtTrQh8YOxoqaiEZuhE0/YctTkXpzit/jKHzO4LjDm9GWN4cCaULWcLXXCl+ZNEg7
         JpiRsDGz7pqW52Ie4PHZ39SFxuFppM5t1PZUmOkmKWxlTe58DV+XG5LE23NM93AqUDr/
         YdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SvtMDCDwIpBhd/Zjo6iSRYvXLthlSVmZCy8NEgqR44E=;
        fh=8IAy5qup0a2EY8QRGpBSpKR+Jn4fWjWAV5x6xozgXOQ=;
        b=VZWddwT68pE2ko2u1TgX01LI4Kfc36q9fJYSe4mJH8ljRYTnNlggfZ9pSJmoTto+xQ
         ZOnMlPm34GWnD2YXnUSSFuWKyBFS0aT5AK1cUW8Q+Fst01tr6QBwELVAxw5xQWCSNbwU
         1I6HdceEtf7qDKHbf+sNRi8gVqx9qicRZwTdVMjd3MQAt2Ah70eiyKc1rNw9Z9w1ak7p
         +qFHWIV78aGpBYXaDHKnEiQWnOVJuZkkhweR/sccqlECPfryDN4YwawywIFd0VB8PbwT
         u02cytEut3r5CzMIbhYzTjjXE3LlmK581xsVq8VrX8fTqkAZfUvpoOZKtJ9MKeSdr+XL
         KcZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770204094; x=1770808894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SvtMDCDwIpBhd/Zjo6iSRYvXLthlSVmZCy8NEgqR44E=;
        b=Mfn+1s8lfjhv+up96y1VPQ/lY6zDN4z2eWQ3NZDZ2lzpxF8TRaxiAXHUB339pirXSm
         peG1LyNYTg/JeDSadOHaKNR9dhQKqeyPz+OifcD2U/vzZfBDgMj8iCPVWZ/TE2GtHpgk
         8n5ViAeQUqkgn/BhUxRVkfSShymLPJBitAuNJM0jAWn+Kl2jrpuweAE/ZP2rqwodth8G
         5rYbnnaIGt/4AWRzUQe0KXWqty/WlzAHWrPuMqA+7gkqnGOilCRTNRDmhhLdXhlgVASU
         Anp4V/luf/obfR9cKwwD2gjcsDAWD29xGTtUvm/Nzjs3cNfVUBBca46Aapm6aoohHXnV
         Rc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770204094; x=1770808894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvtMDCDwIpBhd/Zjo6iSRYvXLthlSVmZCy8NEgqR44E=;
        b=wUIzdQieZYyg6D2noK3XIHNz2TP0dcdNryrPUtGKeBpfUGpGReAhUzkerfBJTCfvS+
         oC5gNkFMuyST8jnqhN1K3x7zPjDtJPTBrDpyTMaQR9DMAiKXnSe8NHjrxjDE3LveDAj+
         GN1iTeAnEIml39E/2Hm2pNgVU2dRQcnqF9hpe7z07gLl52j/wIjwQOXjmQEwzu3DphEW
         3gyhDO18FjbZuCEUHwBZigo2xrZ+8u1oiha1tiMk/1YKFhFXJmmnprFuzCABASqyfghr
         ibgYi+TFe30r11MEYIuNIabxMmLDUxrVFNyFsHKly+znh5LN4zXxI8H9lzUL7pkHO0Ld
         +q+g==
X-Gm-Message-State: AOJu0YwHGoBs92nhF91Al/GtPKPuAAWfJIAKOlUTc6ed5Sc4RO/8oxrl
	u4r41n+q8usPsU6TTOoA6y8pV9+ggAwWay8NssaN6Qw9CTj5sh9bftk0G9baLXiOuoTxqNxf5kX
	4dB2uK+xWWnbkxv9Y+t2eBaBZuUQqhog=
X-Gm-Gg: AZuq6aJpNn+yrSCtS86fGZkarS75jYeYJ7W+IIlNWOPN0nDUoQvOD5nvdpMKRG6+wwe
	OfdtD2LPIJyeqN4sQYh+EcwNryfuKH3H25Rg10rnzXERNKGcQr3hBd0g4jzeAWlsrLtQSnfuKRa
	scoZGfYTmNNtILbVKDgxBB5rJtrtkGx2vN3OOxvV2i/PYvLXNe7YxB/7c+w9ZiDVcJMtVpylNCS
	aSCVFHGgP2HPbR5kwEac0U7cdsIatuzV9iC9iVNSjB6ZlsQENcpYSxkMHeKs6yggzPNhw==
X-Received: by 2002:a53:edd2:0:b0:63f:31f7:b956 with SMTP id
 956f58d0204a3-649db34b0f9mr1762823d50.27.1770204094635; Wed, 04 Feb 2026
 03:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
 <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
 <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com> <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
In-Reply-To: <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 4 Feb 2026 19:21:24 +0800
X-Gm-Features: AZwV_QiNIXdBwQd07EQ2WiudkslAGfbL0wQMSHU-X1rOehvTN6oxn1L8vSgY71E
Message-ID: <CABFUUZFxH1noKq-=zSTrqpirJtTQ2AA6anb7Pk=BDGC3aTs+Og@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31524-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0378AE50BC
X-Rspamd-Action: no action

>
> applies _only_ to signed short, not to signed char?
Fair point, thanks. I'll drop this patch.

Regards,

Sun Jian

