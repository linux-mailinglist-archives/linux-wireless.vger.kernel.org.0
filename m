Return-Path: <linux-wireless+bounces-33227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iICiHVSatGktrAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 00:14:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF94028A9F6
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 00:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F00D308B424
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060E342CBD;
	Fri, 13 Mar 2026 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBxmnPXI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB43C5DD0
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443665; cv=none; b=Zah6huNdQnDgQ5tuaixL1eLH0mJf2J7ONZVt0ERNHgtcJqXqiJHjMunylzKnLmpMt60jFNqN77dExye5l5WfXcNhJ5Zpxnttn3etSEHKXnxkkg8qOafGvVJkaY5HxLQW7SCEUGo/Mez8XddcixAsxai5Vd1ZiQA8Gi4Err9//qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443665; c=relaxed/simple;
	bh=wyUD0KxGKlpBcprXQb0zBN0folrhnZNylWOh2ik1HEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8MIffpUd+dQ/SiZ9usykdITO8kFEvhrFftky4T6bJNm+rErQYWfVlLKqwQ+vFHkxctd7Z/v+qbR1w/tU93lxY1ZMGPu3OcRRGh33mJwcsduOqwqNw+u3tL/8gs7+NUqnCEGcOODmN3/VC0i/FmbESLWDnyLa1C1EYNmqMXr76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBxmnPXI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852ff06541so28156585e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773443662; x=1774048462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHagiLqtRKMeQ/veOT5rPo09NSPAtOjaHWCJL5TQiO4=;
        b=eBxmnPXIKg7fVFYpR+5s509A33XbFolvPA2MDFnqcHL343JolymJOtbo0/rbc+MHBe
         DoOBZkbo6j+34TcnfU+RU9nkikKiIvMaDyBPcK0Nn1xhgbEfnrAr9b0BLYLCI5VOKgaw
         5k8KOwG9+ebF3/YqlGm3rBsY/hSNiXrIA+RbxsjBSj3DHJEFWFZBmxZYwjiImhYiNcxg
         bqL/T153lg3l7EUb7RONeeSdriIoET0a3bhCS3IipRHwAFF6cO4iglD49D5lmGr5bvKI
         M2w4xZE8U99gTnYkt7OFbZ+hS8m2LTG4qd+RfgVTZRzJsELSVqS3Y+CHrV+hnURyvvW/
         f56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773443662; x=1774048462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHagiLqtRKMeQ/veOT5rPo09NSPAtOjaHWCJL5TQiO4=;
        b=juKb9+V1kVufKi93f52gEQ246wlUJybl3RT00gWGx1B7yTE6v76zbDhCnoYLucdOF5
         T1Cx+yVBwGsEU+SbvimY7L6Pdt6hW2ntZuqzKoey5ExgqgGHcM45R+BsDy1k/rkucSmn
         0WhvYsCPTjdWyScLJLfeJMPKAU0NNwf+4GAJhrlIoC0YIifXyXGprZfmBBbKMUCTkTO2
         ggsD6XJ6A3ngunRLGP2bDKJ04mrKFuvSgYjgSo2ShzgwWaueCWIEU2I14rnRcu8tJ8yS
         oRDiZmUzstZ2coM8/2mdzjIhNS7IzIlkVCFh+5gd8UsjPpUv3AmkIPVdnU7gzpXH1ICz
         0Yiw==
X-Gm-Message-State: AOJu0YySmVBj3RQCfEvaue3EKESrOxVbBJobJ0f8nEUkgp+iPWtu+r4w
	X1zoEzNfb2G3ItQOJTLzeQD3sLbMt68u/poS2+JJAjYwULXxB5H0cbKF
X-Gm-Gg: ATEYQzyM+FSgLOeh2seSorGlTMK/z8yWtMF2P/gnsL5QzZzwKHBuLa4KFE9t2GeifTB
	cLi7QwKCHOyIizV1MKYiLFmdS+FW9aXoRIFK2OMy1HBQelJ18M/04PLeETl+CIqScLSJTm02SSq
	HP2830QwJrZ/Tv01MWrjerJgh7Aat0uriV34IsOtvx+IdZYvRhIKTGuWeUSUKV+1bWtPWs9nKZD
	MbPYZFca8h+B2o/pXJuqTdqezDHuUS/CFBwnxewnCH5y9BHj5seILdqfHDfU3BDlOQDK63M0/UX
	iinNcUgyrjO8iqvTKgDXsl5QIJ63CP2QinyTJ9DzECinqIBrMYbz1AUmUUxtGk0j3lO+gFPrSel
	tvIUrcVL1eFzTElE3SWk0t/5pe7usonc3W8dNBR713FHCuRo1wXJ2xQq+wMN9XganjOUYoO5PH2
	aeATO2bqPWZLxoFXaCQrbVtqAlcMUMsQ==
X-Received: by 2002:a05:600c:3b14:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-485566d94afmr72254595e9.13.1773443662243;
        Fri, 13 Mar 2026 16:14:22 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm341125115e9.4.2026.03.13.16.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 16:14:21 -0700 (PDT)
Message-ID: <984b3534-aaad-48a2-ad96-ff1f26e924da@gmail.com>
Date: Sat, 14 Mar 2026 01:14:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] wifi: rtl8xxxu: implement AP mode for 8188EU
To: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>,
 Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260313135321.3196688-1-georgmueller@gmx.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260313135321.3196688-1-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33227-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF94028A9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/03/2026 15:53, Georg Müller wrote:
> This series tries to implement AP mode for Realtek RTL8188EU chips.
> 
> This is not final. I still have issues connecting to the AP, searching for some
> input on what may be the reason or how to further debug issues.
> 

What are the issues? Were they happening with your original patch
which only added supports_ap and max_macid_num?

Another thing still missing is the macid in the TX descriptor
(rtl8xxxu_fill_txdesc_v3).

> Patch 1 could be picked independently as it shouldn't change anything for the
> non-AP mode.
> 
> ---
> Changes in v3:
> - fix compile errors caused by testing on machine with older kernel
> Changes in v2:
> - add patch to move dynamic_tx_rpt_timing_counter from ra_info to priv
> - convert ra_info to a dynamic array
> - update max report mac id after station add/remove
> 
> ---
> Georg Müller (4):
>   wifi: rtl8xxxu: move dynamic_tx_rpt_timing_counter from ra_info to
>     priv
>   wifi: rtl8xxxu: handle rate control for 8188e a per mac_id
>   wifi: rtl8xxxu: update max report mac id on station add / remove for
>     8188e chips
>   wifi: rtl8xxxu: Enable AP mode for RTL8188EU
> 
>  drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 22 +++++-----
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  | 41 ++++++++++++++++---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++-
>  3 files changed, 50 insertions(+), 18 deletions(-)
> 


