Return-Path: <linux-wireless+bounces-11149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E194C5BF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159E01F2335B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1300142E67;
	Thu,  8 Aug 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORUiJEHu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F5450EE
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149234; cv=none; b=RkOuRXgzBwJtGPUApNKoCBK3KKRAxOk9CgDIRq7QKpBT5+oiPCeDwhF1jiI2PaaD2sctr1rHElqPQw4jrLVM8osjzwQvmV2YRTFnZ4rnqAPd7ZLlWyBRP4E9aRF+EbIP3KJJTTqnSaeik5twFx6gUNNaYk9aw5NQMj/01hsNY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149234; c=relaxed/simple;
	bh=seHn3hgu6UTSmqAcAi0Wir9GGPHWi4I0PsaQ9xlGd/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8DC0n3a8tncTyxBGpVh/g5HGc6s+MPwwznupEBei4Ijo3VlkYLVSB5hezvp/hnTQAI1gMEndfzoAAm3Zsjqk2SClAQWd55ucq4eBZerGvZgDTUa6VZ00VV9tiDzJWgYzdhuFG84LQE6+7AYEb5iG59uuT/OjB2fARIyLPifnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORUiJEHu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e087641d2a2so1336831276.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2024 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723149232; x=1723754032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=seHn3hgu6UTSmqAcAi0Wir9GGPHWi4I0PsaQ9xlGd/c=;
        b=ORUiJEHu6aUdt0b+ID8566zZuoDbNCMgvXgz4CcL9GDDx4lqRuTJ/kpNrSs2Op8QGr
         ok4R6DIkFi0H8Yyu96NjQYoGh7HGcJDMYGtWOnlqdJEAlczgp3x9M2WZIPlrAY5+k0TD
         +j40z5bcNkW9kctfoumtnw9Q73lCYo5inn8rgdLPZxP1tZEnkguijre455MI35yMUpO3
         cuTKqiHI9/gf4xH4QhVuFqew+v6GKMbXuuJ7kYirymY7R/oJ25iC8e7NS18q6ZPc8gLo
         wIJNt7kaoiZUTnC1h4IjOu9cHScYmm45kVP72ptARamcJToNC5SATS2fSDVO5+7HEgQt
         zIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149232; x=1723754032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seHn3hgu6UTSmqAcAi0Wir9GGPHWi4I0PsaQ9xlGd/c=;
        b=hYgu0OlxPe/Ddx+QBBxGKmFlsNPG4I7PeZM/Z1/jNBVmexOdVJFVuE7eolC5MSxLS5
         w/w1Vhar8PmFtWl9aKem0FOQ9skU1lFtwSci27wJlsKaRglgnIDhw3zW2r6GLrEoM+rU
         g4DafzpBwYsXoqLr0e1Gj1/e/FGge2rtGsjjy8sZEMc4WC0cEdNpV9ZjE91uXdq5kMdU
         3Sm2aLsWIYhLRuQ2h6n+ogFso6dUXg/9r/mZOvU4sAywMAudUGLQMum76njB+iiFCcli
         MdLcTd0DLmpSJJakAqS6mC+HIYUu/MNgcHnJeKu8EUDl6BGQKO395WnbcEDT4nYDd4S7
         Pfmw==
X-Gm-Message-State: AOJu0Yw9uZia9TVOPlghauGdnQJnhDMn0aQnRa0d9djVQKhRSDN0Asgl
	dFzav01wrDzfLAXrQdRCDeFgMyifse3NHJPvrMWRHYo6PSv8xtwIOBUl1sFUjWKWwWzyeW7OVhA
	mh97pmPGApXNQ0V6Ymo+hMdzLMPY=
X-Google-Smtp-Source: AGHT+IGsBszfKr9JqD4wS7duIAR+f3h3U7fHKLAoPc9XS93h9UfOxb6I5PP0r8b/xfJXPC9fF6d9g9ie1sR866lDYmM=
X-Received: by 2002:a05:6902:1604:b0:e0b:ea37:9c36 with SMTP id
 3f1490d57ef6-e0e9dabdd28mr4306844276.18.1723149232259; Thu, 08 Aug 2024
 13:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808172948.303258-1-benjamin@sipsolutions.net>
In-Reply-To: <20240808172948.303258-1-benjamin@sipsolutions.net>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Thu, 8 Aug 2024 21:33:41 +0100
Message-ID: <CAP-bSRZTa-AM=aPvoTW0Df2qQaTD8O7LgSLmZGZtEe7fVXigMQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: iwlwifi: correctly lookup DMA address in SG table
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, benjamin.berg@intel.com, 
	miriam.rachel.korenblit@intel.com, regressions@lists.linux.dev, 
	johannes@sipsolutions.net, Kalle Valo <kvalo@kernel.org>, 
	Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 18:32, Benjamin Berg <benjamin@sipsolutions.net> wrote:
> [...]

Works for me.

Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

