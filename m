Return-Path: <linux-wireless+bounces-13042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365D97D179
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 09:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570ED1C22EFE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFED76C61;
	Fri, 20 Sep 2024 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQjQDZv1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436F76035
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815940; cv=none; b=phNzIyjtgTxOy/Vmw2HKko7BNyi8qDsY26kT4LNa4C4H3RygBI1xr2QFiOwPyDvn05eB+cfBbFX4Vrz5rgWt3E4ezZAsurZ4ymO6SM8eCT3LgJzx9kqNCkBbNhjSVtXeSiQL8PxYK9PYcwZQKj8j/tZwjg6C1CWQXcSqOyv+ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815940; c=relaxed/simple;
	bh=CGHEJlX1yFNAmhaW+rMr0Vzd7rTaItP5OQVixTD0CnI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Q0bpHxE1LpTCctbc+/wh/3v/u20F0FB0hqivmcaaHA0Jdbn0FaWvn6xJbVMlwSDDrmUWDI53Gt54/We0Xmkhtla/Z91FBJApvytObB31Z/tg+2zuCK3BJFnmvXToxfulzET52ZCpf/yWn9Do8b2/Ok77wEHbzTKbtNen047qkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQjQDZv1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc8782869so15021835e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726815937; x=1727420737; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGHEJlX1yFNAmhaW+rMr0Vzd7rTaItP5OQVixTD0CnI=;
        b=BQjQDZv1nImEbNhO8a8P7Oq+zGAAxl+fMdhhqH2pMt9Zz1lNpR2/zFSVsrat0crWqb
         oTEqSp4bviCo6VF3CU8oESVC4gdXcMViu0ZDWtkUB4/xbqmNFOGXldeLhsbeOQ8E7yMi
         cmwnsloZt3AArkv26+zgN3z7+Nkrz8E7bpk/w4V8Pe+Lcln0AXwf60LbcxXIHWeGBqp7
         oGWehW02jBokOO4+dlcsoQKEO5mYpDrRyjvsH/By3WH5P0oC3D1tUjTnbL3qskuKn/n9
         9yxSDw61FKFukRjD/4zP11hT0bl8F0vHZpwhySm47NYK/PEsSotzao+uvGBiKgqv/YKA
         75xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726815937; x=1727420737;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGHEJlX1yFNAmhaW+rMr0Vzd7rTaItP5OQVixTD0CnI=;
        b=iWxB2T9YJnd0pIZVuouMQEOhwLalZLsKpZhWbiMHuO7qEfIBwD11++Da2oikXzvYol
         L3X4M8521+Yuk54haBa7Mryd34d4YEsn8WqabtwlqmIVrtb6hvfdhN6/Xx5YC/0iWPj6
         MmsNMAomN+RW5h6YwuJpAMAxYtg7LaPoXhAPx0AMlzgAiUtArixU0AoJqf3YfApwoEFv
         WefocT6SI+NkQSugqmXR2mwIrSqxr45XNBbxx1ZNrR1dLKWQNA+tj9McaK65O/kjY8K+
         mJv3pCZFP0wSG8mMhrlom/tBUV94R9A8YpqY2/l9snQkbF+18BQ5XcJnqb0gmmwFAL4v
         tT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrjIMxx6lup0fGXlTctWDdQCuEJr9Y3fPZkuSYfMmhJyEqweJLj/l0vEBJxfKIo/ENRtLfaKUO5l9dIR6lyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJdYSz09bmKJqgTyJF5mSKeuMeKYGi9UFwRITpjfx98EGG71H
	GKIsyhhr8ZiBEOL2g1CP5y6hBAiOnpEhSr3Xi0Bi+DC5+O/Yq99V
X-Google-Smtp-Source: AGHT+IFoV8v70Zl157ayStZiX7ciMP6clFFUwj5YtyZpurN5G+8Q3TP0KwJCuarQHRarHgJeZ2hyVg==
X-Received: by 2002:a5d:4850:0:b0:371:82ec:206e with SMTP id ffacd0b85a97d-37a42252e3bmr1008307f8f.5.1726815937173;
        Fri, 20 Sep 2024 00:05:37 -0700 (PDT)
Received: from localhost ([2a01:e0a:0:2100:375e:67e3:3e7b:d99d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0529sm17148684f8f.6.2024.09.20.00.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 00:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 09:05:35 +0200
Message-Id: <D4AX5T9YTARM.AJSGPZQJX8R7@gmail.com>
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Nicolas Cavallari"
 <Nicolas.Cavallari@green-communications.fr>, "Nicolas Escande"
 <nescande@freebox.fr>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
In-Reply-To: <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>

On Thu Sep 19, 2024 at 12:22 PM CEST, Johannes Berg wrote:
> >=20
> > Also the rate limiting uses delayed_work_pending(), There is no wiphy w=
ork queue=20
> > equivalent AFAIK, so the explicit lock is probably the way to go.
>
> That won't work, it's cancel_delayed_work_sync() under the wiphy mutex,
> so that'll cause deadlocks (and should cause lockdep complaints about
> them.)
>
> johannes

Ok then we'll go the wiphy work queue way.

