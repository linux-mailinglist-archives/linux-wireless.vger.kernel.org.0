Return-Path: <linux-wireless+bounces-24747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE4AF08B4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 04:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E624E1C24
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D318D656;
	Wed,  2 Jul 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k94441mR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529619049B
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424742; cv=none; b=GmdWhDs2p7r+7hMTKniB1sTZx7SszzSkd6Z+mO5zbyfc2zIC+jdnsSCS+JnTh4KD57MYf6EPWVxr0P+ylmuWhHKSE4KerWuvruf/n3TpXAGHdlsDjY9y9GSbH8lkNFDP6V+iv11JIIGbhC+XqYi11tklR0cJnuCT9hf+vmvnNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424742; c=relaxed/simple;
	bh=G4ERL0+D1jaQ17f3/35QJx6RGMr53J8NyLHauQ60aWg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zova2RgDTENWwC3px3Tfi/urS7MfcwnTPtujCC7nBM5Jg61paFQAkixW2gg2c+2kIYqnny0E5h5c2Gav1HMrwG7P/E5Kv0tKa5sEPqIpNqDED67tH9Ru2FMsyI6koA5GO3xbHLvJJL1iN2fW0+qneyMqmD3Dky4BNHBp5vN19J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k94441mR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso5499009276.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751424739; x=1752029539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4ERL0+D1jaQ17f3/35QJx6RGMr53J8NyLHauQ60aWg=;
        b=k94441mRRIee+AjO2lJ+a+O0gToHek3xFU7xOY4lW0KaRpL7/x16byujD0229Drif/
         tEFyBj7+j/AlWZ/KhB6GldQNiGDsSaClzdhcdgIHOg8d9brd4IoMPyFybm1m/TEHf/Km
         ZhYHGzZ+qmXP4KQftaIG1xfKWhmkaAZxe1Crqchu86WthhDY+g8tw9l5YV1s1T7dnbbE
         cv5RwquBKW4cG36I5opuAtP6vfDYJrC8xTXucjTEZq7h9RMvijHhK4xVanTeQGhOAwk4
         nKlzUvhxUR4Kua21lJkrAVSclGFuUB1riAFhNZvHoqWPXnwOcRbLUhhbFvCBPGXapEhD
         yo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751424739; x=1752029539;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4ERL0+D1jaQ17f3/35QJx6RGMr53J8NyLHauQ60aWg=;
        b=PXgl8q8vh2oBg5dY9NDTmGDl2pw16vu61b0cgoVpISdgQA357uWYt3HHa36NGF7lZG
         +ugnIosJVMkUG4YhgIacoSYmVmWSmnJhmaqSEo3L8ORC6Qr8QRzwTZJYJ8QbZ4QXUe1A
         xVRj3omlMvFjEuqN8J9paaUeKvfBg8l4mjd1RLBQhAXBdLPHLK5eKNk3sGSjI99gouQ3
         HgaiBploVco0/MWEFn2RFj3fOCD1eCS/0fZBaMXQ9aMG9f0CY+JhtblEjZZ8w8JGis2r
         d8Hlx9ftQTzNZWysgeEaO6ACATWbcvfXWkPYY09sDyDvIpX8qbZV1QhPCsZeLlwkcAY5
         fpTw==
X-Gm-Message-State: AOJu0Yx/9zQ0n8VtjfVeyvb5kLPsE3bEPblz9msVq4XYBH9mXPbSz7mN
	x6HH9gquDhQNsMp1/OnUriQ6qUroE6ougDQ44XdoAkzA8u0YJeSEZA9Um8IOvz3GR3QV6y3VjdV
	PntgrhvxOGEmFUqYzlbilYmWvY3GQ/hPvJQ==
X-Gm-Gg: ASbGncs8Rie59WNa6nYbWXYKWX07VKGZg4wHJ7j4ZfWs8M54OL1cKW4r4K/JyeLa60H
	GE+DBb7LQa/0jI2wHCxWyQnxJz+rQwo5Ze+jSTJqn7+AKA7pk4QJ7zbGfS+Qe2Rq4ZzzVYc8F7R
	D01AtKR2BqONN4F2+NvO3ZUMEh1M3jvCaeV68EIKPyILD/Mknr1Z192zQ=
X-Google-Smtp-Source: AGHT+IE1CAl9s3T6XYLeg5rNyggiWbmMZPMGrcXq40hSXV+aIlFBMtLs3/SBRNLdtsGcqlQwiRjurFVOErAOVvyCsoM=
X-Received: by 2002:a05:690c:998d:b0:70e:18c0:dac5 with SMTP id
 00721157ae682-7164d3f1debmr15093277b3.10.1751424739660; Tue, 01 Jul 2025
 19:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 1 Jul 2025 21:52:08 -0500
X-Gm-Features: Ac12FXzcajfW4ToO9YyYZBxRsMyHnjKZ_sFymR_YUAsE8SxJvAcYcJZfAGYeIyE
Message-ID: <CAG17S_MZsrzhKj5XtT1y3Z61h6uzi99RxkDLB=VPiwYs+c_g=g@mail.gmail.com>
Subject: wpa_supplicant floods log with scan error when ssid is not present
To: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

New to wpa_supplicant and wpa_cli and am using systemd-resolved as
network manager.

I have everything working reasonably well, but struggled with one
thing. I get this
error flooding the journal log:

Jul 01 13:26:10 pi4 wpa_supplicant[420]: wlan0: Failed to initiate sched scan
Jul 01 13:26:19 pi4 wpa_supplicant[420]: wlan0: Failed to initiate sched scan
Jul 01 13:26:28 pi4 wpa_supplicant[420]: wlan0: Failed to initiate sched scan

This occurs when there is a known ssid in the config, the ssid is
enabled by wpa_cli, but this ssid is not visible and the wlan is not
connected to any other ssid.

If I disable the network: 'wpa_cli disable network 0', it stops
spamming the log. If It stays enabled yet I connect to another ssid,
it does not spam the log. It is only when it is not connected and
there is an ssid in the config that it cannot 'see'.

It appears that when wpa_supplicant is complaining that it 'Failed to
initiate sched scan' it will immediately connect to that known network
when it reappears. As long as the ssid is not available, and is in the
list (in /etc/wpa_supplicant.conf) and 'enabled' by wpa_cli the log
gets spammed with this. It seems a bit strange that this would be an
unexpected situation: that wpa_supplicant may not be connected yet
have an ssid listed that may not be available.

I am running this on an RPi which is running RPiOS with systemd and
have tried this with wpa_supplicant.service (dbus version edited to
specify wlan0 so that it can save the configs) and with
wpa_supplicant@wlan0 (without dbus).

Any help appreciated.

