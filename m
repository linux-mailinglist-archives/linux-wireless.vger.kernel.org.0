Return-Path: <linux-wireless+bounces-22920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A1AB59A0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E42864C17
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D042BEC32;
	Tue, 13 May 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSY132EZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACF2BEC4A
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153202; cv=none; b=HUDToYhAhibOWdXNd9h/ZAzZWgFG5I0bA1OTVet81beKeDMmD9m1TWJhZtRfvs8E367qKtGzbeQ4gu6AJkcPjhpF4RmuZhvPJ/19yKeRIZYIwV7KbzdGiBLLNXsinmL6C6bA3uoFDyKa3mB3RgK1kXTiGqeHKIFizhJuJC/X+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153202; c=relaxed/simple;
	bh=MAn9eSI4SVQ3m9A3+mtKR9+nKFC7A3vfUpb8FFuPLyQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=brG1N94RHT5VV2E2KQO6WXl1odRLWcBav1jFrTT8zjrp7jX/C1ID7ZchkY1FERVBHRAXgHfMSzhiJN8Bhwunk3HndTMZQsa/TiaaK5bfeMgVMgKv+ka0jFQpqvRJPrNKk86G5lexrP2FXAEWtxgQrHyOG4NHMEVHj3fmG8FuyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSY132EZ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fa6c54cc1aso3946167b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747153199; x=1747757999; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MAn9eSI4SVQ3m9A3+mtKR9+nKFC7A3vfUpb8FFuPLyQ=;
        b=lSY132EZpFzbIZV0Pl75x8XV0HNQmN9FhtDBkbpxcaFIsMSf2pJQrsYKIi+7sdZRBO
         3kxZphHa516wb/GsNmOib/I8I5L/PDhDqbs3vCQHbHMkiXYgRUcfOTLkD51AusRjb5Ts
         b0I5APgxf6dpo2NhudK9JOpEgQsHuJEy8oXkjro5TmGjifYiGLK8lVlZNrb2GqFsN1//
         6jpHrxKNjAgNwqtX+566OaKrOYoJJ2/zIhtQ14Q65+2p9OUmmExKoM4jk9I4+fymlwWb
         DTxoPQTEcDRPDjmTu8EukjxAbvQOFV2+0snYIO0H38aIAu/Qv4Hk22B1ve4bouS1EHB6
         vVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747153199; x=1747757999;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAn9eSI4SVQ3m9A3+mtKR9+nKFC7A3vfUpb8FFuPLyQ=;
        b=eOsd4gn6HRKxeODGr/uNM7REVCAJrJxpgSaxuNsZOQ20LVFUHRIjJziGRRKbhuACu8
         snq+C3xrr2OvUcNyJl4AJh9QZJW7oRIs9cJQkVgl6PymNNsCpgfy70xE9i1cBzYpkzRT
         QbABWQavbT13pPGL7UelCy8KUDvH1B6/oL/BtXECIOQD564usXUX66F3tCmzQ/10EQXO
         GTxSaqLJjRZayz+3AWCfjwMkdKZFIInAByj3ekyy906lEEkG6M4SGCo0MkMAAXH4z1EE
         HzmETATfuHiyXb6aoWoFoDFwISPODr5cX+T6BUgimueLePk/68qASM/DNxDKF5Eqr4XI
         AIgw==
X-Gm-Message-State: AOJu0YzutHhWYlNy2JJNmqKPbR1TdYlCdTXTsixGNocoIL5DTJdUTG76
	/p6KjHSHxzt1ekcZNJ9BaAPc99tXM49xiAjkyfOn0ua/DSqiWpiGQahnkHLv5nJ9KRaMXF46jk5
	OfgBC7boLFEmPCQ50tDT9aaDQw664xtn4Ho0=
X-Gm-Gg: ASbGncvytOKzXx1gXkZPBocrhqWexKjHwjj/WbdeflGTJ/YSjZY5A+8JeCq9bnpbGhH
	hq/8Wmg1vmTM6MmlWgrRA2KtbKooixTwC8J+tQuCvL8lWnyrC1vM9rP1XSsWGykbVo3I6OHuzWz
	ewKoQpbDNaaFirenLISgxoe6CF0XSKRsJbfQ0JhB4/nb/gcA==
X-Google-Smtp-Source: AGHT+IHUAHGvKeuH+9aZRsX2qbHOehCCfTTFyD0LU0QnPfc7Tg659OAnhkGMmPN7bEECBQm+ZidLpWpUlIaBsQd9FQM=
X-Received: by 2002:a05:6808:7004:b0:3f6:a703:b71a with SMTP id
 5614622812f47-404c1ffd541mr134706b6e.16.1747153199477; Tue, 13 May 2025
 09:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oleksiy Protas <elfy.ua@gmail.com>
Date: Tue, 13 May 2025 19:19:47 +0300
X-Gm-Features: AX0GCFuffcDtzBVnS6DabIMfkXcd-ePQBGCHuEL3SOZUarBGfYPG4jAdwo_rfSY
Message-ID: <CACC_pfLYxUXPTAo0P9aqeP-xKAMdGsAckg_=j0HO6fRf7rNxoA@mail.gmail.com>
Subject: MikroTik R11e 5HnD monitor mode
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm sampling different wifi cards for a drone radio project (OpenHD).
Essentially it puts the card into monitor mode and injects/sniffs out
frames directly bypassing the whole 802.11 stack. This works fine with
"conventional" RTL8812au, but I get very strange behavior with
MikroTik R11e 5HnD.

The card is served by the ath9k driver, AR9580 chipset. lspci:
> 01:00.0 Network controller: Qualcomm Atheros AR958x 802.11abgn Wireless Network Adapter (rev 01)
Manufacturer page: https://mikrotik.com/product/R11e-5HnD

What I see happening is that on the TX side what essentially uses
PF_PACKET sockets, the monitor mode code is unable to find a correct
queue and goes into the following error:
> af_packet: wlan0 selects TX queue 2, but real number of TX queues is 1

On the RX side it's even more confusing. The card goes into monitor
mode as intended (via command line, without any extra software being
involved) and can see the radio frames, but only for a split second
after switching channels. Whenever I do "iw wlan0 set channel XXX" it
captures like 2-5 frames according to ifconfig and just stops. If I
switch to another channel and back, it captures a bunch again and
stops another time.

To me it seems that there is some mismatch with TX/RX queues in the
driver or somewhere higher up in the stack. I wonder if anyone can
give some guidance on how to investigate it further. (Got embedded
experience, not so much for the wifi drivers specifically).

Thank you.

Kind regards,
Alex

