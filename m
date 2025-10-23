Return-Path: <linux-wireless+bounces-28188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8D9C01499
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 15:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FA024FCF54
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94537315D36;
	Thu, 23 Oct 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="CMT5uK7P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC142314B8A
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225240; cv=none; b=NnGcTzb+0MlWdEUhxmV5VR/XED0cM38Bro3qhoYzRHTEasSETdISdpJ7sbMJQ3d07otBYk+w1LI1X2Ij4IE5ju93uK863hsJvxv+d4txRPe1qGYTIh7n76jFTtq97xHxcCXX/BNuaL0D2ldK/iQQvROFadQahiHx5o9qYyeGR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225240; c=relaxed/simple;
	bh=nevV8ASjZvhV6DfxDUGAvsJQALIDMwhyk8NEig3mSE8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mQnEWSzxSSge6JObFSwmTrTumUqvO8W7R/UGEUu7zRonAiKCSG9KMNSSRRE4oi9nJvHH4q0l9javYFay/Isb4YLwhI1miaQh5JVOd10xQ1lEZ/O60MSEUGvLxZ5hhW9Xca9uxkuP2Gsw8qT9IZOrCaTYPxUi1ywIOJbjFm8CJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=CMT5uK7P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711f156326so7827875e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1761225234; x=1761830034; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTinALRsi7F/1cEpv5oPd+oVaJ2+tGNHAZgNemAbn54=;
        b=CMT5uK7P7h/6yhs/l30sK0iLsRxfBx1qXsU/JCtuFRx/ItqM+2Vzvfp3YRBxXV7R0p
         cziNjYlhPksfQvA6GNx9Z6otQhuus8DKRvk3uuxa1stArh3hwKP/IzqYMSb3wtWPSrQE
         G20Ptpl1hjN+BYCa/BvLht61+ei4BXYS1ZzucDLCp2p4QwpJDtf3Sdeg0tywrhEEAOdd
         Zq7OfBolo4+aEqddoX+f6gNwFJvG6R+3SJCGZkxdamJRiNuGwJfebTHEGceaMTcAnTl5
         EYgazcB7P/vyCLpMeA7d1d6VSTauSfh41e1ou97VwGjak/LDakvVfr6J+b64RMgaOqt9
         myKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225234; x=1761830034;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lTinALRsi7F/1cEpv5oPd+oVaJ2+tGNHAZgNemAbn54=;
        b=iMpF9IAUqwit4/tGqc5LsZJg7WJN4JzkE5r3SCsq4nHrNyf8zHcO8WsFnEIhNgbu9O
         2wPs1maYm85ZBJFF4N4eGf8IuftwT01TFm4uY2pRKhdFU8bI2z5bxF2NHyIBpJruWvV8
         7PCmi1nmehnnAz6TeuVr2O475NolBIvE4THWKC7CccxOgBICFF6ijMJzkoQ9rAq8dTBA
         HUIy80Kx9/ocP6kqDdxgxajtVmyTtiSCxz3WUh5hXsTzHJuD7cPxGdmjUXFanmpfF8A3
         almtqpbj0jLfUWAqLv7H6lfSDf0R0P8nU7SyhzUlBmJ/b8AkXcHYbtgrLbeVHmxo4zV7
         hfxQ==
X-Gm-Message-State: AOJu0Yw/wK7kClM7VQaVzfJzCnre6OLkhgbvSCGFIhKhCREXoKnmAw1n
	dBW01Z+KI/DAn17NHni60l12b6CjmKx2NHBEzJQG8XnnM7BU7aVMLWnhX2VcccjUfIxwyQQ5N4c
	BuVuX
X-Gm-Gg: ASbGnct5d0OESoWtgWd6/CETQ77e6gsQg6j2mNzIf6jod2oYRrHkqSm6h7rjoQS5A5d
	h/ik8Xll/ziiKfR3xPCdJ7XxD1sV0nH66clAbIybgpmdnvGWcx11L0PaRTcNl8WDft/geQ3++YY
	4S40ZIbtY2a93ROrJJ4m6WuYqnirmVilJgDptU/XPVhDb0e5+UOzqpyJZDJfSBKBI16IuG3OC/7
	dHgRaDuzAMEOWv6eKrwp78g5PlqPD3TsbsCA489WCSP+YnSct6tVziD/6bOcdEFLXjo4lWO14en
	IA2EYAeMlz3/lrXTSkPodkiXRHimKsggH+EKLstP37IV6c45NPiauItAbtDB2p+KkV9YptcOmaO
	E8Gs9pFYp2s7k6l8bz+/dicuRMqFn65UtCPGmnLE37gkMxVFqtQ/7cYZz0pQ2guaAvyDGnoj/5x
	EWoqnEOTSluVlEx6iBQcLE9jD3MwH05xA=
X-Google-Smtp-Source: AGHT+IHmWwDJPjlmNCQZ/n9b1fQRiSImlOFtey39CCImPqd6rT1vyYFGumd9Zk6wiFyVAr4AcsDI0Q==
X-Received: by 2002:a05:600c:3e86:b0:46e:36f8:1eb7 with SMTP id 5b1f17b1804b1-471178a3a94mr170328695e9.10.1761225234520;
        Thu, 23 Oct 2025 06:13:54 -0700 (PDT)
Received: from [192.168.108.124] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm114002615e9.17.2025.10.23.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:13:54 -0700 (PDT)
Message-ID: <cd2ec7dc-1987-4f8b-8c5a-1f420a2de3c7@freebox.fr>
Date: Thu, 23 Oct 2025 15:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org,
 "hostap@lists.infradead.org" <hostap@lists.infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: Extended Capabilities bit values overwritten by the kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello all,

I've encountered an issue with an ath12k & hostapd based AP: whatever 
value I put in `he_twt_responder` and `he_twt_responder` in the hostapd 
config, I always have the bit `TWT Responder Support` set to 1 in the 
Extended Capabilities IE. This happens because hostapd overwrites all 
the bit values of the Extended Capabilities bitmap set in the config 
with the values coming from the kernel (ext_capa_mask) since commit 
8cd6b7bce8b8f1fe2803bc17ddf0f51bd07330b1 (hostapd), and in the case of 
the ath12k (and also ath11k), the driver sets 
WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT in ext_capa_mask. I'm unsure on 
how to fix this: should hostapd be change so the kernel values can be 
overwritten by the config, or are the kernel values an invariant that 
shall not be overwritten and therefore ath12k should be modified 
so WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT is only set in the user space 
or elsewhere in the driver dynamically. I'm taking the example with TWT 
Responder and ath12k, but I believe other drivers are concerned (e.g. 
TWT Requester Support and iwlwifi).

Thanks in advance,
Pablo MG


