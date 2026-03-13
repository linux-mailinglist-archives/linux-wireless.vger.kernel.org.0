Return-Path: <linux-wireless+bounces-33222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB1YMCd+tGmuowAAu9opvQ
	(envelope-from <linux-wireless+bounces-33222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:14:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 237FC28A11C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFECB3090ECE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9A382392;
	Fri, 13 Mar 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1E9kh7b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A4382396
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436448; cv=none; b=ObyMDRhEBieLjWTVWM+HHtmJH8BPoE1536hHlzdQsky0fv6IFq4pKIxyBotDit9N55tmBOHdUKkjFbrIJkg+jokgKZ6cWuh54PsQYrXbOHNVEMxkM0CHejYl+6RvWaQu674y3qjtn33m5PVHzTZj36n26XCkMGNXv928qbaGDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436448; c=relaxed/simple;
	bh=XbgQQkEEYOCLnNVD52XhGRy5MZPAAjDNgXaQm44O1lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGsJ1rfLZWuD2NeIuhbuwpDSkdjGFrtGsn2mQPOzgjKnL394aqoJe3jJwuzQ/ukFEJfpa+aWxzUVCrb/g41V33OBiNT1XI12k/dvv5efH5sdMgFmPEQr00sV18NZ6vr2J/muvlb/Wp/cDHv6D0RCBit32m6ii1upBOhqrAhRtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1E9kh7b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-482f454be5bso37051465e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773436445; x=1774041245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFMDSCnpiDsU+2BfApiTZUy/shEnjEeqRYQD2WrICHY=;
        b=l1E9kh7bF5YlHOXedDj6kwQKeOQ9YMOmd/Ig2PwT7OwsImDRDoe4Pvn4UdcyxblnfZ
         gpJPPGarnv7FdFf9mFQlXiXiRD9ANNmF5kjAOhZBJ5tqtYVqy2HC0PZPiVEVTNLVIFTT
         J0wKYZbJW7wQ82Hf8uJ6VRJ+TDGpQAMxcj3YaJRhUbbV3XlEB52DX378+1tgnqWUdYk+
         AOJXIalHwm03lmtyucsN1iOA48SRo1Ft0jD1xXGVgb8yXuzjEYeJGADv3b3hJUjhVzhi
         ZMNfD4kiI/TRWABTMxXgGecXZqsCNq9Rq1emEXbfIlZtAUC4EgqfBwnVSB7gh8hhwfOi
         rslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436445; x=1774041245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFMDSCnpiDsU+2BfApiTZUy/shEnjEeqRYQD2WrICHY=;
        b=Uu//vmbTI9kYNmpR4s5wcft6iKzeIAmy98/kbamfXygJR/VgM5ZKt2D0iAyZEF1ClP
         nmUKBg8CRXeCMYRey7LIwyMQArByWS9HfGnIPUxDgDLXyVAecrdJMcXD0MyAkcMHd3PY
         RXqtTQ8GDq1vXJj0pX9+JX6LeIi7ufvDggRnbM0Dhn3X84gog7N1U3Zs9gsN5/CVMliX
         HNrQRM/dmKRfcwJIDi7xaTAtrGW9+0b/Fa11b++5akg3MCqxaPzrsdlAt4tKlMn3ygUw
         00w1nV6HzpW3dkIdMFGOcMF2Hx8mNW9V3DQbuU6RXLx+r5nQ1ZMe/p/570q+MJTCu508
         elRA==
X-Gm-Message-State: AOJu0Yy1zCk02NaRJMyybapedgGTAQyPkDqwztes/0bRYik9Rwz/uIEk
	3EHlF+c0uLuCZn6NL1LIWV4S2cmvR4FKCN8ukXSpulkGCwP6Z2q8H5aF2If9nQ==
X-Gm-Gg: ATEYQzzZzVprcOgcJCOFsJeEBdj0j+Ve5GRvEWPbPEAczk2h+G4/kSCApukadkB+wa7
	e+A7QCg6ELJi9G0yRfF85gLyON6ZaoICMr0rt7BbtSxe58A4MDCJh4gLzmU+7+zlyWI75hPSDxb
	S3iZvM2LOj+8R0S67/0tD4VKmoKsJOHOJ8Jbt53RObj2HwP9dirSsXo5U684r++IIDh3mHl/KcK
	GKpY0HTUrYXa842TJMmSTLcrITzmj3dQ23v+dBBsBv9rNOCFeJa5LRUcSkQg5NVqm9YxyBctJrF
	iyh9yX2Atm/FwckWIAGfakDETvW4BV/O/R5QdYS6W2K2rDYG1Mr7cFLNgtAV4WmQR+1O1BRtbc/
	TE8N0zwqKmZ5BbVk7z48m7y36VhVXehItR7Vlh1DpoRRDXN0k6VyT00Cw/rrIoldQAhAhI9Dkkj
	mVeARxraaIthUm7IEaylyhohvjKnNjXVsg/GAOGPT6blxNR5P16fa4cgpf0gVfVMOYiM/Atafoc
	XHY1B44RngvwB9//hVuED0raZ5QHvVbEJwh+QZpUw==
X-Received: by 2002:a05:600c:83c5:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48555ab09abmr77845785e9.3.1773436445011;
        Fri, 13 Mar 2026 14:14:05 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm228556605e9.3.2026.03.13.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:14:04 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w19pb-00000001Lyo-1A5A;
	Fri, 13 Mar 2026 22:14:03 +0100
Message-ID: <950c999a-f1de-48e7-9fbf-94806825d31c@gmail.com>
Date: Fri, 13 Mar 2026 22:14:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] carl9170: 802.11n compliance and driver
 improvements
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <AM7PPF5613FA0B6D188CBDBAFC0CE13247A9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6D188CBDBAFC0CE13247A9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33222-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 237FC28A11C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:37 AM, Masi Osmani wrote:
> The carl9170 driver for Atheros AR9170-based USB WiFi adapters has been
> effectively unmaintained since 2016.  While the hardware shipped as
> Draft-N certified, several 802.11n capabilities were never advertised
> to mac80211, diagnostic counters were left as TODO stubs, and some
> hardware features were never wired up.

Ok, if you want to take a shot at this. Sure why not.

> This series addresses these gaps in 10 independent patches, ordered
> from simple HT capability flags to more involved PHY programming:
> 
> Patches 1-3: HT capability corrections
>    - Enable SGI_20 (was only SGI_40)
>    - Advertise RX STBC (1 spatial stream)
>    - Document the SMPS handler (replacing bare TODO)
> 
> Patches 4-5: Diagnostic counters
>    - Wire up the RX dropped frame counter
>    - Track PHY errors via debugfs
> 
> Patch 6: TX power calibration
>    - Replace hardcoded 18 dBm with per-channel EEPROM values
> 
> Patch 7: Recovery hardening
>    - Add exponential backoff to prevent restart storms
> 
> Patch 8: Antenna diversity
>    - Enable fast antenna diversity for 2-chain devices
> 
> Patch 9: DFS radar detection
>    - Program radar registers, call ieee80211_radar_detected()
> 
> Patch 10: Runtime IQ calibration
>    - Periodic I/Q recalibration via existing stat_work timer
> 
> All patches are individually compile-tested and have been verified
> on real hardware (AVM Fritz!WLAN USB Stick N, AR9001U) running
> kernel 6.18.12.  Each patch applies and compiles independently on
> top of the previous ones.


Interesting, do you know what PHY it's really based on? My information was
that it's a AR9160 and as you said Draft-N (that had issues with Radar) and
not a AR92xx-PHY.

And features like the fast channel switching, Radar etc. were never tested/qualified
and that's why they got implemented or as in the case of fast channel switching
had to be removed later. (See the post from Chen about carl9170)

Maybe @QCA. Is Chen still there and can advise which features are OK
and which might not?

Also if you have the knowledge/time: Do you think you could figure out why
the 802.11e (QOS) doesn't work with aggregation (see: __carl9170_get_queue)?
This bugs me to this day.

(Also there's a hack around the package filtering, that is breaking
the device a little bit... But it was necessary for the Intel 4965 Wifis
(AR9170_MAC_RX_CTRL_PASS_TO_HOST see carl9170_set_operating_mode()) .
This is also an unsolved mystery.

Cheers,
Christian

