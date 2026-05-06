Return-Path: <linux-wireless+bounces-35987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN9qJWff+mmGTgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:27:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4824D698B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14BCC3040C87
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F130C630;
	Wed,  6 May 2026 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnRA155c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042F2F28FC
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048860; cv=pass; b=ZgPwnurNPjUB8TTocK4GUL1mHUz1PIrtqzh4QTcc8eh33014pPjxddXWuFF4qtS3TlNfa1/BQQoi/jocZk7U8L4FRHBWHeasBS+MhdyhKTaCD4yRhBDdLunnlFairBLzgCCUMgryCbiZIK8sl+Knf6Dm+NUrPLflP4LgpqED138=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048860; c=relaxed/simple;
	bh=xEOiR4R5Nub8uot8lmurdhabTA6f+DyYDnUxrrWCWbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEC6dp8cFeXhKL79gHT9Pw5Cqf6fKmGTgz5mNQfw1lSGRLTplSWXcSKrYCrl+7tciNU2KhcEAnqBFbOU61p24bulbaCtUJyHTr8AxGDVQcMpJZkUvxN7vU1nyy8ESRaGcZIT806wUwsY5nNgTeMlKkdS052H1VxILpj8T9PxqMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnRA155c; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso2725103f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 23:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778048856; cv=none;
        d=google.com; s=arc-20240605;
        b=IIKn4bsNC7hoNLPFmUYzP1BaqiyK4/bAGhsam1ukUOEmeux7kZ+7ZBXQ/Ju3D3oHFr
         ZUHpz34y09HJq3iMffPq/j7MlSpILz1gIeKi+EfveZpmOpfsIH3lv9AYsz4onLWPky2B
         aaPcZ6Myrs77kv8/3DT/8woPXpq97269cEX3/li4Fmkan9B4/KltB+bGDpwfZX6EiUgJ
         tG716qNNle6LW3baM2pbdiXE5gOmsrTYrmSHtrP1A/MFwh0D6jONNKAs6gvQMydEHE3x
         U1t/Kd02bRFguFJG18YczAu1SrhHdJNn2hAMmeendpT3oOyEtrwsUG0qSBmaVZVHwYDg
         QCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4B1XKaQ2ZFrAle9X7AY20qezITN5Vu2bUxqyPBw2UqY=;
        fh=8IAy5qup0a2EY8QRGpBSpKR+Jn4fWjWAV5x6xozgXOQ=;
        b=ICvEkgm6iLaOUR2ayDZOOChoU8Kg6mizxvLR9RuzTKR7XTgg+PJ+8kJynkgrVkPjco
         ua0e/YZCPSEcrvnHPHdXoUdwjHL2/kFZRPcHpZZhTd12aCLtvKete9BSSTDOouzq4Art
         9vx83usyVkLNIY/WxPYOrC/LPf6cchLK0qc2SsMCDomd9Sz3jhNshTsQ/lqL5traL6E8
         J2/WN3R5QU++6mLB1Q5qtmRfucfPZyno3BPjpgbE8kixZSQS6jdMPW1yfOIU+vUNZNZu
         /MkHcqZ6G+FLMC4w5PnIc4uDHXkOrB9xpZ+UO5PcYOccPpX+MHvc/A7C/WfOor4/TdmR
         Wcyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778048856; x=1778653656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4B1XKaQ2ZFrAle9X7AY20qezITN5Vu2bUxqyPBw2UqY=;
        b=LnRA155cL0/+xXxMjocC/OJ1GUJM3gEx1cAkX3ZaJuaIqj80HzzeecZIpouYEH198Q
         /tMYJbmNSgdJ+lDjJxp1bvZK/HZ/9yVwOqyA9S2kJ2Cn+ZaRfic93oeYxxoKQklQ6m6F
         HnnBl/YGcV9rwuNT295/8pC6EmOJmK4Jx5jpwLFP8iFTbgiGxtoNEPBY7sF81gawnykp
         5I9LqKAj/3HizDBq6ZEJATAyOC7XIayxp6+Ctbgn3yQaHozvT0ps4By0cufsaARxMwH+
         lGWRVMqfOTOkSjV9PfHeP9YtnU5ivFctRbaQ/Q9Ck32DZg7RqF/rQ/J/2afO654mh+Kg
         NHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778048856; x=1778653656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B1XKaQ2ZFrAle9X7AY20qezITN5Vu2bUxqyPBw2UqY=;
        b=hbQI9QU1VGuvZ8E1M5FP+FktI04TH0PV3YCUDu4kmsyf+vi3xNIa95AcoSkYM0E1Bj
         Xa4I5pXeQLy4OKtGFQihCD5dBElquult6+4m3g6+m2znRXK9YRK3my0ErPGqEZUCOaGQ
         sedrz7BpS0l5eQrXZXZ9yaitRiKKa9/AAnvCLwCmPBtfMFWjqcMLgutjBCS3pNob93ci
         7MyvmM9syHSk6vLBnAC5dKO7YClXpqpVVP5YIszrb9+yrJ7OYG39d8M1AcEgEfnMNA4T
         enjO9t6LQ2FFkhqNIsbvkaycvIdKIK7sqgYXkuqj7chYnhAfPTA8YB8HglGxQPx5IZ90
         kzwQ==
X-Gm-Message-State: AOJu0YwwSAVtpAkFEFDDwdqIy/zf4WjHycQsd2gW4QaEVUeBheo/DjNp
	QwCva91ycotPIeu8WwPwwmoI8wGp/GwiuX3smNGCtCF4toa2gA6Kqj9hY/FMAOGmJgzS5OzDdrH
	uJn8Ms78Fq3hkjWk8rWip6v/gqCDtj1E=
X-Gm-Gg: AeBDieuzW87K84yro95m+2S8ADdpLfso/KhZTIGC5UZqBSBCzWj+TgjdCCZmSN6x5OA
	KUXvakYyPmhwo24UigfWyDSPFpOPUuZ9e4FmLkvSo5nYXL9L4NAWyAj/NUiwHeVkHHWuVOBRiMr
	LvU/C9Hev7VabqbP8tJ815WGO6l9tt0rDR3rxICjCQqg0eLObTHlvl98Go/4HgdeLi6oXsE4b8U
	tQzXd71k1hAA15AS73qOLr+Rfnq8zpiAvD59DHorC5aSYs70pkrVU9rBUtcBVUZLCM69Qu/Dtdk
	aA71zOW3Ah1BVkcM6w==
X-Received: by 2002:a5d:588f:0:b0:43c:f583:126a with SMTP id
 ffacd0b85a97d-4515b5243famr3360411f8f.14.1778048855705; Tue, 05 May 2026
 23:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
 <20260504135420.1178443-1-maoyi.xie@ntu.edu.sg> <20260504135420.1178443-2-maoyi.xie@ntu.edu.sg>
 <4a80d9a16c37af6f35904b5298238f64f030c374.camel@sipsolutions.net>
In-Reply-To: <4a80d9a16c37af6f35904b5298238f64f030c374.camel@sipsolutions.net>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 6 May 2026 14:27:24 +0800
X-Gm-Features: AVHnY4LTmmkkXY3NlVC2byzdgKZWbQ6mkhtii_2rh5sQ4rnuDbGoPZ8K2mzQ2Zs
Message-ID: <CAHPEe=Fpk21OLCmNo=q5tcd50BMWWLRHMsCETVXqOgUSeA==4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] wifi: nl80211: require CAP_NET_ADMIN over the
 target netns in SET_WIPHY_NETNS
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0C4824D698B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35987-lists,linux-wireless=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maoyixie.com:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email]

Hi Johannes,

Thanks for the catch on both.

>> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

> Crediting yourself with finding the bug seems ... a bit weird?

The Reported-by line was a mistake. We will drop it in v3.

> Bot reports

>  WARNING: From:/Signed-off-by: email address mismatch: 'From:
> Maoyi Xie <maoyixie.tju@gmail.com>' != 'Signed-off-by: Maoyi Xie
> <maoyi.xie@ntu.edu.sg>'

> so wonder if that was intentional? Maybe you wanted to include
> another

The From and Signed-off-by mismatch was not intentional. The
patch is authored from maoyi.xie@ntu.edu.sg, but our NTU SMTP
does not accept git send-email. We sent the series through
Gmail with maoyixie.tju@gmail.com as the envelope sender, and
Gmail rewrote the From header.

In v3 we will set the email header From to the Gmail address and
add an explicit From: line at the top of the commit body, with the
NTU address, so the trailer matches the author.

Maoyi
Nanyang Technological University
https://maoyixie.com/

