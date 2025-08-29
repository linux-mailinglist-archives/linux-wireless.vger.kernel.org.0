Return-Path: <linux-wireless+bounces-26863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FBB3BB97
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B1516F7A2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5A2C235A;
	Fri, 29 Aug 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mT0Qxt13"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932A33F3
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471710; cv=none; b=DMgsWDcjlTHq3IKcP7Vzmwn3yRKi/kvcZDrvs53p4/P48116fEReg3fHYzbb/Fqqii8JxSvTT6ZqbTtBMT/X7Bal5+acHZP9al8H4OR+BwkatvDVxg5d4CZ3/G31Fbn7VDNgfRHEHXiRgv9NHzSGAw3eVO51i8quHTMLjMil69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471710; c=relaxed/simple;
	bh=s0Y1Z5NRmIswO1bXuLmTtrvgrV4SkjVpWswCBrXNYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q76N2f1+voQ7V0/ww6DbCkRV/xsuOT2F9S6S+RddG+TAYpuFPwbPDiYeQomii4qd+bNE7+vXFf8MCXPD6ovBz1SuXX/yWil1wqo0tl56R2fCueppjFkAnX4xZMAgCyosfghf+CJePhG9FQNDawJ+9yhCzT2Wx8A8SCbt91LMPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mT0Qxt13; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so679315e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471706; x=1757076506; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1TiY7ysjOZKRPS0v/GfCN7RvRXXI4uCIgolqPESgxk=;
        b=mT0Qxt13CfTHbqi/4KcL3oGnvLvJFHPnFiqtzAueflzKko/BozHXlp1ZkYvdRGCqhR
         qwuwgLgo0DDjgy3X33jKvDhekv6LnAJjbwgqYxwkDCeJdo3JzKkJSLQsNxi981T5Xlgk
         xlfme0zuxdHzr54ojBcLXD4qlL0fkA1ALINuJWqY2q2BeEaAe6uZtqAV3Whyhywx95/T
         6NoGirhRpA/k9cFwyjYh2hYHv7CznihRzdNK7O59JSSRpuZvuHa+FQUUcFFr/4C5COSr
         gm9xd23r020aLKyXodwbtaZihGGeJznkZ4GT69UpvrimmpK+kkGhXzRYQVQbJAOq4bKb
         0xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471706; x=1757076506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1TiY7ysjOZKRPS0v/GfCN7RvRXXI4uCIgolqPESgxk=;
        b=qQHQJ0kJ62RInevtp6IAq9TRJki5GsHjmq/hEuoBpMXkzg+W0TIZGPoIA/fIyjfSYM
         bnDDT4pQaOFJ5EvH1z6yDZDbN0cPUuu9LdzfGmDmBl9kFI/KfBtZSFacjjRWvqEvVIi7
         DSTI6jrP1B6JrulBaXwiecgTWvq1Q63/crI7RMEcZ+BZJS82FjR7nOxRFy/X18TXcVcb
         73IiYBKTIzrwMItwVM6igOcsiU9oVU/ATgchHrtDLYOUQ2JhdSJ5NFCTzg/cdPI6L2D6
         hUs1WqBnEyqHtBA9U6yZ5SYcwEIdkpjvjXmB5fDozyZIef+q82T/veOW08/3JYtvtm2b
         fAXw==
X-Forwarded-Encrypted: i=1; AJvYcCUDLkxUUF5TOFipS4Q3dhlGojUCyJYmbOn0voaca8OosYwZk7ygB/q05qKjJFJwSVPLEdPeBo93gb5cWjEPyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlMZrXouqE1759IwHXTkr9kyx00M5bPsDs8gkljCuqSNbcOrt
	LsakJQnk7NDhYrPoHl12VEV4+dWW4vWfbACOcLP2Cytb7Oha74OeGn52jVPNMZTTL94=
X-Gm-Gg: ASbGnctfJ4BFwgTByYrGbYRQZsd7mMvGHYk5J+Zx28EF0QpwNVGh2mkH750HfT/fsrv
	0knAo7h7pkIIhyIfsfX6vfgjhCj63sDcvNbFI7EcwD7JJypc7maaldEgYgGApe80N+Fp4d72QoV
	S5nij4pwH3QFtG3TMgrCsvrA1CverFYMOv34H66czMIbO7GFzuDrOWdFmDHgTx19fhyJAFoVv+X
	hxhOcq08uMYL80gHQUi3NzHpVtA6dmzWbEDLJ7QlK1wuVbxxUDB279iIJjT4rhOHn0ToGoJuMsZ
	/ujREH+acbOgyBIMyKqnxlaNhuN6mRqBptymwAUaBTQPnEzucnIZ5RxJqnymypKzrj5LeezL1ff
	rmEu+OjHoEvKDDQTaOwBP8wgh38CH5bbcjsq5Tw==
X-Google-Smtp-Source: AGHT+IG5ZyAiHuK1O/1CVyBhFH7yFbM7hahLKw5Q/RCW2h1UrGvO45lEpWadjzIhQtCVo+X7CY44ZQ==
X-Received: by 2002:a05:600c:2ad3:b0:45b:79fd:cb45 with SMTP id 5b1f17b1804b1-45b79fdcc32mr37397295e9.29.1756471706168;
        Fri, 29 Aug 2025 05:48:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f4aa8a0sm118810715e9.12.2025.08.29.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:25 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Bornand <dev.mbornand@systemb.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 0/3] wifi: cap a few SSID lengths
Message-ID: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These patches are based on static analysis and review.  The other places
which get the ssid from ieee80211_bss_get_ie() do bounds checking to
ensure that the ssid length isn't more than IEEE80211_MAX_SSID_LEN (32).

Dan Carpenter (3):
  wifi: cw1200: cap SSID length in cw1200_do_join()
  wifi: libertas: cap SSID len in lbs_associate()
  wifi: cfg80211: sme: capp SSID length in __cfg80211_connect_result()

 drivers/net/wireless/marvell/libertas/cfg.c | 9 ++++++---
 drivers/net/wireless/st/cw1200/sta.c        | 2 +-
 net/wireless/sme.c                          | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.47.2


