Return-Path: <linux-wireless+bounces-34962-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMcBKfTE4mnD+AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34962-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 01:40:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03BD41F34F
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB15B300D76E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01108347503;
	Fri, 17 Apr 2026 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iAorpp+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED6346E75
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469229; cv=none; b=srhEJWxA+p9XV7Phn3d21RmDJa/pYuC++4c9JvqOegCmJ69VicXQ+bWQfPpYyY3ILeW63AnVgBgTnc/GaXz4iSBqyWt6i0dyWipQ2YqtZWNERv3/JUN4UrmjIuWFQCYoO13bKDtcpdLqUYXZPwlAGJ8s5WVP/DY+GmEiqOIMSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469229; c=relaxed/simple;
	bh=/gVI9zlnMYH6OqX2zfrV18YOLkTHuG9sy7NpY48nb3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCJk2pJ359d+ylNw7xWXmiPnGYhXE0Y5aXGA3g35sw7vv0LbluQSLCItstNQ+ugsU4xbCwfnz7kLZywNSbG39Qr74bwySvxTjCaru4NZwouNXaji8x3hVc6dKtEEyR3lmWu9Vj3xwvVji9HZvuBldgOF3pMhZ6PZboAN1SeXI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iAorpp+N; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c565476d7so883719c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776469228; x=1777074028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=587w1wnLhDqtfLPXlc1+b+SeT2OB0wSJR6dBONl9mpg=;
        b=iAorpp+Nd5myXJe/g+VDw5S6uEuLGJdSvJxZb/GlptvWusvSrRd7fc+w00kmmCEULd
         TGKfRBv0F7Yq5zHprP6XLx7/d4TJ/I4akptlj9Vcx74256ogA9Q0EkBV2wXd3FPaNA9k
         b6fVTm1Ou3B0hkz8blLh5u+5oSdQAvkB8bQdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776469228; x=1777074028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=587w1wnLhDqtfLPXlc1+b+SeT2OB0wSJR6dBONl9mpg=;
        b=jd1jFCxy2JTEU/YSKDkVDy5stVESTPYpxb7ThdUqk16U+qjiJtUwmV71xFaprhD4gy
         NfMQCV/T1FUEBHHgq+svelfm+10Gm9orT1RneDZeAzaMjGOOjmyJ6/RJuzKqlXX53OQg
         i0hN1STujqGMojLeREmXYwCfL+5WTKBXPqwA6xtujLm/iziIMCADLgMV3clKlwOZsOzp
         acv0X/kd5wTFtuX6KN3E7A2nXTDbnXfPaQM94FI0JgnWc/pe3BtcRm8R0z6z1s4QASkA
         s06jtYlmQQEJRItEkVzQ28plV2m2eOHaIbrLHOln1JDtJiVr6C1m2SdRLFHiA1cZV+cP
         kO+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+W0BTlpK2QfRJGICEihCO13fBvA9HTxnb99ylPCusVbRxrSMF56WAn4EPaVyzBuAuLOiJ72SArrKlu5IbfFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysIZCOiNO6ec1o3AGXO3R2ayBSgscZ1Ppoa5THEXqU7T0jSWIK
	6ADqG2Syik9q1hgO2QoTTTMD9cMR+VsH+0POH2mmlQ4MPBY1B7Tq/mfCsh/TgdiAWA==
X-Gm-Gg: AeBDiet5zCQTyQLhOi0COV/J2D9qjwpRDnn233UbTjsuHDjFYtlplMN1xHNCdfjtKyS
	7GE6ki3hzDlmlGgYl6kFXsTFxCeAQYQbxt4ulbucP/oQpjx7JIuHyq3LGfM5QN2bGtp89dg+zfo
	NjAOZNTllN3dxxmoT17nA5DyaPloTtLLfAHDSpF/bj5Hn4QhlyRrtDOxBGaYLinSXSEClOuxEvd
	uZ5muTx7uzO7A96B4PGEa+wWW6MpbzWv9xEd6NdzyoPv0uTgPUx4KKZbhDyTwFpEXc8P2KGqjAl
	Kp7QUOSZIE7inYBqPGONKPlUfRz2ojBHZV5+74n+G0OqtlIU+eR58KhA49JhuwUbFQoHY5k4Ujy
	W0vyWuFakmmoPvWjfcfmqyCdAO4TgCkiptNFmL2eQdpaH5gAtzQEO25zPZ2z5vJSHbdIIsmn7qB
	33zJV8BMqXJ6dPWWa5p+WfKZNyHKVi7H5SYcTgBIyVSB7Vgxcym75xFGHtNnR7qJxVmbGk+O4=
X-Received: by 2002:a05:7022:6289:b0:12a:9b80:8a1b with SMTP id a92af1059eb24-12c73fb27fcmr2581165c88.34.1776469227758;
        Fri, 17 Apr 2026 16:40:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:a468:d4b1:9c3:f6c7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12c749d322csm4256694c88.4.2026.04.17.16.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 16:40:27 -0700 (PDT)
Date: Fri, 17 Apr 2026 16:40:25 -0700
From: Brian Norris <briannorris@chromium.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/6] wifi: mwifiex: Make use of driver data pointer in
 sdio_device_id
Message-ID: <aeLE6dFmr40xaKNn@google.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <9dbbb7a9a8ad3a12d562b589a6756baf226d5dab.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dbbb7a9a8ad3a12d562b589a6756baf226d5dab.1776429984.git.u.kleine-koenig@baylibre.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34962-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: A03BD41F34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 03:10:52PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Recently struct sdio_device_id gained a new member to store a pointer to
> driver data. Make use of that to get rid of a bunch of casts.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 24 ++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>

