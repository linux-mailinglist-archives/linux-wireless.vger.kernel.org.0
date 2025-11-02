Return-Path: <linux-wireless+bounces-28470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D67C28F7A
	for <lists+linux-wireless@lfdr.de>; Sun, 02 Nov 2025 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62A264E1EDB
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Nov 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF415208AD;
	Sun,  2 Nov 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayswOxPf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA811CBA
	for <linux-wireless@vger.kernel.org>; Sun,  2 Nov 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090046; cv=none; b=SrKDIL5Bf1EKJaXoWDRcnupgLyxREsLADQ7P6HXE+8WxfdIE3uGX9MFxDYDWu2+Tupa/ouL4mDXztabDVqqWjIT9BfKPdzhP7u7E4TCp88khUHV/OV7bAL2pHGWwYip+WtyPb1jbZtnhwjYCySq7q8mrE/VnnbsiQH7RMfqVcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090046; c=relaxed/simple;
	bh=R6SA1ev4vId5ptZ+vYLkDAhDbJK/+ZkuwUIWh6j/WKk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ERHgdCYfcJ2j1HfnkIEzsQ5SBokiZv63cpEWKDNc1aCEqOziKcN8BFLkALYDrNMCZZtxlTbVH9WQk5ltgt/fOkuH5Sqnr5jWTACXgH2biAHeVmw7Yc3lUquuANOorqGbh2wi5eHb8/3xTrJp18H6ghIf4lYRe5U4BofuUBGXYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayswOxPf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso2617169a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762090045; x=1762694845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6SA1ev4vId5ptZ+vYLkDAhDbJK/+ZkuwUIWh6j/WKk=;
        b=ayswOxPfB49toV1ChSk8/53ta8obO8p7qh8HcIbnZoxevE+n1T+yIJIqG6HahtNMuY
         pbJjBgm932SWwQTNSD9Ruv448++hhZ1xRxO5ayMAEUrR3WGIYiUvTjsNprJjebu8ZphQ
         PdGSvT6d1rLEVDreX1MzuqTprgdq4Skt1xS6f7LqC5Dpt6P7xhJMliQX7yGN95S091Ec
         eK6kzC+7sg2IBG33tfBc5KQs0YCBZsOXKSevQPcaTW5e/vS4JMTGnMlgmstL6ZGc/PlK
         u/A8YwNeIbxpkjQ///DldlSZJOpeaFcMwPsiyg4jCGr3Trd4q1WrPgNKpWjHA86c+qhX
         XxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762090045; x=1762694845;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6SA1ev4vId5ptZ+vYLkDAhDbJK/+ZkuwUIWh6j/WKk=;
        b=PhSktiTCVpGy6c5aSb0dg8qpsF47niLewN8dtkOoLeCH1OabOci6R60HPH+FgtKTgz
         Kqgm2xQC46y5zYU7zN4VFYqiOhFyixMMlV00TcX+ThpaPaRhkJ15XiVtQo22A9mLROXB
         hxKH+rtX6vv98XxP1wHg/QNCuha5UTUcZ6SurGFqZRc5KNptyomY8BNB/6GaZ6PnS558
         /v3mvZ10lP3r4nCKpvfmyESC5zHp5FbRx23YbzElvsQVAwzfgM53RLbeV505gUNJcnFg
         JV4Hb7LG+SGNQMbAdl38lC5IW+gBWNMmjHThwmfRRMTwfiAX0EEVAL8yHz9IZA/EYwru
         1q5g==
X-Gm-Message-State: AOJu0YwLokVEe2z3ryC9fNHiqNDdNZefVX9l7q4y4vdvjRZfZHpyJcQR
	qXoizSJ8i3faQfOAVDk+xXfS/UMhufIMYp7tZ3mb1Tyx06VnGsbKqKFHOlw+C897TDpYOJYMgKL
	vRt/KcXNKRjUGOgg/EVgHke5RUVxTqArHeZw1ZnI14A==
X-Gm-Gg: ASbGncsPqkk1jbs5Nm0rrCLQufqKhU9SC92NWbDd0o8F9SoBTfVThM+6skVnRNgUsxJ
	7c8trkMqFAPg14k1FaNWvHmy96BwioKCrWrogc7ywMNaKBNOFWaPgxNIOwUqVgegxe9JFNOh7oo
	Y54ICG274vMlOHEpPbpNo011QmScMIKCbdcYnUeK39RloT+beqtub/bWYY9er7oiptTmxyy6hyN
	Nyg06rZNPaFE92SUaaghtpS1SjD5tiSuJLjUidXuvbfJ9ZzoVVhwGiP5f28n1XeqhGM
X-Google-Smtp-Source: AGHT+IFXMNQ6bqxdCUMAZNM5lKRmt9hh7BQRNqn64KpipxL/6mIadWN9lRa31KZfIcU6b/9SCfuLY45Z4lEBUJdNLk4=
X-Received: by 2002:a17:902:be13:b0:294:66ad:113e with SMTP id
 d9443c01a7336-2951a5c1fe1mr93261775ad.47.1762090044707; Sun, 02 Nov 2025
 05:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Zedequias Marin (DECO)" <dudecco@gmail.com>
Date: Sun, 2 Nov 2025 10:27:10 -0300
X-Gm-Features: AWmQ_bkl4GMIpjJMZYaT8OxjgnDEUfa-gArWTwHZcR95LlRTrqRtPKZnNI7wh00
Message-ID: <CALaz+jkqX=JX5ODuSJTm0k_qokgYidQ5+Zu1vBuu-zmFZ6JWqQ@mail.gmail.com>
Subject: BCM4312 EEPROM corruption recovery help - HP Mini 110 U98Z049.00
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Wireless Developers,

I found your 2011 thread about BCM4312 issues and need help recovering
from EEPROM corruption.

My Device: HP Mini 110
WiFi Card: Broadcom BCM4312 802.11b/g LP-PHY (14e4:4315)
Subsystem: Hewlett-Packard Company U98Z049.00

Problem: I corrupted the EEPROM while trying to configure as WiFi
repeater. The card is detected but no wireless interface is created.
EEPROM shows repetitive FF/3F patterns.

Request: Could anyone provide a known good EEPROM dump for BCM4312
(14e4:4315) specifically for HP Mini 110/U98Z049.00, or guidance on
EEPROM recovery?

I have EEPROM backups and can provide diagnostic info.

Thank you for your help!

Best regards,
Zedequias Marin
From Sao Paulo, Brazil

