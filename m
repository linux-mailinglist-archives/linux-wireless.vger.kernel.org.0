Return-Path: <linux-wireless+bounces-7628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA08C4C0E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 07:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DE91F246FA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E218633;
	Tue, 14 May 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b098mQF6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB718643
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715665798; cv=none; b=XWwR1/pVJxbTajsyNITYupq5/HNoAz1lYhbqx2ve1GeKyQ5rM4xQfVkr/5MnOvp5D9TKHfTZEfOAx4I5hOqAIz21SRqHuWLuCh0rmcxqd4wX4tXRcSVa6CyIuHrdkXO04TvhCX9HOb61KW9Jxjd/SaNg0PxpHoOJf/+LOvpkjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715665798; c=relaxed/simple;
	bh=N7yQDXUwAdMII/0o6Jb7o7sMy9XOiB5X0F3FoWxeWrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYyfmQ/MSC++t91Ok48n0fy1pa5zJCjOO1p5c8GLJAsEjgyxXJAkCTVTXo7rdT50KLhc8+pzPf77owTKY9cU7dEXU7fgEsMU+UWxnbWqDRghv+dKb2vaWWSVh08klwcdjFGy0pFDsRm/z4kqtZS8evMqCF69TQtJVej8mi5bQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b098mQF6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so3665667b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715665796; x=1716270596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk/9cCSuKPAzQ7d7k8DYOmgE1U27tp+avu7N/6VE0BI=;
        b=b098mQF6X9bHmfJOj2UMxXvYNCOYEBZ7lxcJloMkNOepgQOJE/fvCx5/jMqxkaF/Ye
         t9mmXKtCU4cLwUTnndJ/bvhsoq7dFNVbVqXewwDusQpQ0JVEqVdHc2GDUK5HWCc17s7O
         0adQnUHRagfAp3L4ShnKjCCiuHsOJpZZUhSDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715665796; x=1716270596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk/9cCSuKPAzQ7d7k8DYOmgE1U27tp+avu7N/6VE0BI=;
        b=Ux7dOmzXQt4uV/+36hbotSM8JbqLdX6OHg5fVDLWrt85wrLR0HLUKGI5QojkfzCMs9
         +W3Jm+8RVhEZts9Reiym6/KqSBMJRRfC34cFF9z/mvTO5YHmlp2va9qOFvLKSODoqyB+
         X3lK8RMKy7khwX/nZiR12ofxNTeLRVGo8P6QVqS1xVgIU6VRUdgkprrnPDueGs/h9JgY
         WfgnT9trOY4opjKeyxkti/X/toWhd1SIEjvWWbk3+jOgPw5bmInu+KzndW9U1kWMlpOh
         2Ha+MOZ+6oWQ3r8SicvdEUywKxn8ndSFqwa8g0YoAGatzi9hg2E9k6yzLygAHyPaJ5Ja
         HxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVklwTvc/3qfIaJfP1Pfwi3FJUPo5ASj80ro8/wv7NKlRDFxE/cpY3kh26dnLkhr0/1SL1Wy1oONrRQMz0JWih+gWBGJjnapDH2BsyV1rY=
X-Gm-Message-State: AOJu0YzRLdSHyoYBjH6gWKYIcq5z+ecM9wWALu1NpXZjQvQsxb5C4nqJ
	Z4viSGlXvXtuYZIgh1j7m297YZhpDZeOPUcXcmKg5+U9nyuiBXQYsQv5uwK4jg==
X-Google-Smtp-Source: AGHT+IEPTKz5GyCkr08NrFCu81IdrD63NGlNxv736d9HhFlB58SSNTeMeE90nf4HCldQN4VyiI9ANQ==
X-Received: by 2002:a05:6a00:2d8e:b0:6e6:946b:a983 with SMTP id d2e1a72fcca58-6f4e02ac8e1mr13440522b3a.10.1715665796214;
        Mon, 13 May 2024 22:49:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0f7fsm8289079b3a.120.2024.05.13.22.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 22:49:55 -0700 (PDT)
Date: Mon, 13 May 2024 22:49:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Sam James <sam@gentoo.org>
Cc: chunkeey@gmail.com, chunkeey@googlemail.com, davem@davemloft.net,
	edumazet@google.com, helmut.schaa@googlemail.com,
	johannes@sipsolutions.net, kernel@quicinc.com, kuba@kernel.org,
	kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, pkshih@realtek.com, quic_jjohnson@quicinc.com,
	stf_xl@wp.pl, toke@toke.dk
Subject: Re: [PATCH v2 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
Message-ID: <202405132245.017023A@keescook>
References: <202308301529.AC90A9EF98@keescook>
 <87jzjxgfnt.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzjxgfnt.fsf@gentoo.org>

On Tue, May 14, 2024 at 05:51:02AM +0100, Sam James wrote:
> I think I've just hit this, unless it's been fixed since and it's just
> similar.
> 
> ```
> [  291.051876] ================================================================================
> [  291.051892] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.30/work/linux-6.6/include/linux/ieee80211.h:4455:28
> [  291.051901] index 1 is out of range for type 'u8 [1]'
> [  291.051908] CPU: 2 PID: 627 Comm: kworker/2:3 Not tainted 6.6.30-gentoo-dist-hardened #1
> [  291.051917] Hardware name: ASUSTeK COMPUTER INC. UX305FA/UX305FA, BIOS UX305FA.216 04/17/2019
> [  291.051922] Workqueue: events cfg80211_wiphy_work [cfg80211]
> [  291.052082] Call Trace:
> [  291.052088]  <TASK>
> [  291.052096] dump_stack_lvl (lib/dump_stack.c:107) 
> [  291.052114] __ubsan_handle_out_of_bounds (lib/ubsan.c:218 (discriminator 1) lib/ubsan.c:348 (discriminator 1)) 
> [  291.052130] ieee80211_rx_mgmt_beacon (include/linux/ieee80211.h:4455 net/mac80211/mlme.c:6047) mac80211

This looks like it's this line in ieee80211_rx_mgmt_beacon():

            ieee80211_check_tim(elems->tim, elems->tim_len, vif_cfg->aid)) {

which is:

static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
                                       u8 tim_len, u16 aid)
{ ...
        return !!(tim->virtual_map[index] & mask);
                  ^^^^^^^^^^^^^^^^^^^^^^^
}

UBSAN says it's because the array is defined as "virtual_map[1]":

struct ieee80211_tim_ie {
        u8 dtim_count;
        u8 dtim_period;
        u8 bitmap_ctrl;
        /* variable size: 1 - 251 bytes */
        u8 virtual_map[1];
} __packed;

This was fixed in

	commit 2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")

which was part of the v6.7 release.

> (It was a fun mini-adventure to get the trace usable and I should send
> some patches to decode_stacktrace.sh, I think...)

Please do! :)

-- 
Kees Cook

