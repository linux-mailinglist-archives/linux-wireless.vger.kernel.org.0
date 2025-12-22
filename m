Return-Path: <linux-wireless+bounces-30046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C8CD5A44
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 151233017EC5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9532C92A;
	Mon, 22 Dec 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1kJCwEt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9vmOakL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E732C922
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400228; cv=none; b=o4oZYTS0nLvZlJkWKXjNBoMfZe/Bm0u2lReDCqszqesZe3SC9QqkNr/gx5UFtvW2NCdTgvUQqIWgduhVvcwcwD49iNKKzwSnOqtjZdCm1iKb4sdPP4McLSvanb35iLkcdgVjfzPbqiw/GvpRgPh/jaOo8qjCbg7aZ5toYgr7OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400228; c=relaxed/simple;
	bh=jTs07bqTgYv7erFfBZUMsAp4XHND0kph1dtWWouAIqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCKjEsILd41cDPg43K0DEV9je3QyTLSE77vHe0aRg9XDoXshjbEUZtlOXW8AWuinLtNzH9LYU4KO1aZZQlnCOe0GVN6ao6s2Hf1vaxJjtt4pPFs09/baZNibcyvJTF166xN/H9zpnDCVssjWvP3dHkQdS+hIqNN/rrDZ99T0q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1kJCwEt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9vmOakL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766400225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jriSitIljjr+kWzTnD12aRVC8oF8L8pmUuavzP5imQ=;
	b=Z1kJCwEtZtGJYxZtjk9GMSlCd4NsXaCFM0pR8HmWQF1zcKYpQeAAJggjOnr08VZ1MTjNcP
	PCsyfn9EKIS7Evd4P3HOumRm6BVM0QknxFTGMYQMWpOHrlWFvSrBfAYc8rFJvFY1XzL/bg
	fXemFhhdHYpWEevVvpssUO8q8GFBOhI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-r-0u5ysyMIu7xOSIkHECuQ-1; Mon, 22 Dec 2025 05:43:43 -0500
X-MC-Unique: r-0u5ysyMIu7xOSIkHECuQ-1
X-Mimecast-MFC-AGG-ID: r-0u5ysyMIu7xOSIkHECuQ_1766400222
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso26291695e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 02:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766400222; x=1767005022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jriSitIljjr+kWzTnD12aRVC8oF8L8pmUuavzP5imQ=;
        b=H9vmOakLBbekofEfiIqVWf/a5qslq0b/1KbebCkNYD3EoBshlBSboiDKbhG3TIBgWk
         bftcjiH2JvrpbadVznwQDSAImWKZNoxa4VvRZ/ndLRZFFzVtVOnI82mAI6v6F257vr1y
         HVlwPwEViD3kjF/cC7zM4hTNTZ5e/ppjU/uqQ3/dPHynDDmbUM9YdzYbyYUNhA5pnTGh
         WcCaWpxVgfWOQetje/hFT5COanmGYNRG0VWUAkbRoLY1JuMIzT29q/WNNLDbS2Yb45ZL
         HabjXrB6syVNvOdMSts+OczNnqUIkEkgn/jeid7n7RjfCqFWqQAGCPt5OWOtJGrHKvgh
         lZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766400222; x=1767005022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jriSitIljjr+kWzTnD12aRVC8oF8L8pmUuavzP5imQ=;
        b=TMJuXGDqNAJzx5l2ypwn5HyttMKApxKAJfxRRlq5OPBEd+QNpbf4GW4iEuKU1rIwt9
         KOOsT11S5ETHBnjO5HvVdyyxIH6UXVKdqFEihB7L/9/+t2LgSeAF16HY3+nVB2nOXQ4E
         2banC/Y/brAbQv7KwNTExdZ0tOxk9ywpu+6KcTFLsyIYXj0gtWhw5+fUVaagsXBxGj8S
         SEAfEUJT+Nbpa7h+HyILxvI1d6bjecdQf1VcEwvAGmJ3TSmpfvzhV0lR2Uj/TT4pd9l1
         PGbeP7Yyj95IqwFEGP5GWXTeYDOMQZoRwMwA5vdii6s+85PV6lGoSS/fQsDjYEIfTM+U
         r0vA==
X-Gm-Message-State: AOJu0YxzEPIMKBcLiMWLEqBcao7lmlcutlY7zsyBeZ5IpBZIXgcWQOFj
	hKIRowz394P4ROtMMO5GLlyYbOyr5UsYOGmctP60HJB6nBa3d+gYMz4Fb8spNxhAAWLT3p11ODD
	IWWtzEGP4KOjeHbNILxx2FOqxaCisONzN1Lc7nsKy7CK5FYBhjhypd6LHXnNnqFuziMC0
X-Gm-Gg: AY/fxX7SeDuCkRJvGpHG8+POUnMosBYU8kGUYUlII/jX0SMGaGZrp+T2fHJ45BiVPPQ
	WAfkvam+Dh/PdlSClp+Bl3i+ZubKpU4kMUkCEw/4oKZmgpDoaCGtfootR41f5eFSMM9PAQyo8AA
	TtgWFw8aZJdxKWyGRkZtFlmXTPTn+IgiSUb1OqsUjbIIKxJeoFpCmKlhmshRqWAndBpibASuIQL
	01IzJJzETY5YtTdwjuOkwHIZkLZHVPUZV5uE3sVo66G0Ai8bD0GeeAY1i3yebWqfpBBvFE4u9Y2
	rJhtGaRON2lJLQn0N4Vrbb/lt4ObO0aptuOuMVdxjlFTNh2CgvTukyMEiyc/lL+qeGBmqXM9DNX
	ZWZZgKz38MnXz
X-Received: by 2002:a05:600c:4fcf:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47d194d17a8mr100201665e9.0.1766400222452;
        Mon, 22 Dec 2025 02:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwziqKZWoCLSZ7WKnLHPBxd4RYK2XEWC3BMRdRlq9go0z1AzGbZJP7+juAwSjJEOUFpkihoQ==
X-Received: by 2002:a05:600c:4fcf:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47d194d17a8mr100201465e9.0.1766400222016;
        Mon, 22 Dec 2025 02:43:42 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be396c909sm92216295e9.0.2025.12.22.02.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:43:41 -0800 (PST)
Message-ID: <9280406b-d21a-47e7-a404-f494a0419431@redhat.com>
Date: Mon, 22 Dec 2025 11:43:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Nathan Chancellor <nathan@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Richard Cochran <richardcochran@gmail.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Daniel Gabay <daniel.gabay@intel.com>
References: <20251204123204.9316-1-ziyao@disroot.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 1:32 PM, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> required ops are NULL"), PTP clock registered through ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings when
> the interface starts up, like
> 
> WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> 
> I don't find an appropriate firmware interface to implement settime64()
> for iwlwifi MLD/MVM, thus instead create a stub that returns
> -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> be registered.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> Signed-off-by: Yao Zi <ziyao@disroot.org>

@Johannes: I think this patch is already in your tree, if so, can you
please share a PR with it? there are a few notable users hit by such
warning:

https://lore.kernel.org/
netdev/221ba5ce-8652-4bc4-8d4a-6fc379e32ef8@hartkopp.net/T/
#m3e671c8c9a482d90a6fa81e953af723af5546118

Otherwise I could directly apply the patch to 'net' before the next PR
to Linus (on ~30 Dec).

Please LMK!

Thanks,

Paolo


