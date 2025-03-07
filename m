Return-Path: <linux-wireless+bounces-19961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D2A55BB9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0678B3B778C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97F7F9;
	Fri,  7 Mar 2025 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWON7Bx4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AAFDDA9
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306862; cv=none; b=YcjcVUi6gELYL7aDbzA5EmoeqHy4RvjUU/PIdC7pZL5BtQVqB6cwzH3jxxeVYbAoEwUBpWwV3Ez6tvr27ZvZiHb1UrxGkZZaQcNXBH0DDR2hqn8wkMVSUYdEW7KY8mCDjYh09y4HtTRwd1/7iR2V0z0T5YpX1+rd2OXvehRlYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306862; c=relaxed/simple;
	bh=Y/RKtARV55hshgMMOThfeivNJmgdsnao2NCWo0F1xFs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mOxBTIFzk+IsmGWy05EGoWsokEinkGVRfRnN7lB0KKc0CbUxbdlsieYyiZZ1keXBffWcOHuuJpryJDOCxLIuCTudoemr2IHkLHv7ST4+j3Co+4jn6nsmbsyXXItDBppugPGDrj3zEVw/LidW9QbgIfbdF6YnngFut/bX9eFGPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWON7Bx4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf6f3b836aso197819666b.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741306859; x=1741911659; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s8l1GoWqcEjsTPQFWOhmnTF1QA5xT4gV01fDhrslOQ=;
        b=ZWON7Bx458liY/o+3w3B8vk2vkZrVkmNN72of9fLCPJhq03aKq5vKfuUXREZd8ihK1
         MY3JqBkfM/omockghUJEsf/z/fNokX311mOFNXO5dqIe4aFdOIndNVcpreqiumdVhIjr
         RAkijwTNcRN3qEB7kNPlCErIHwb1B4ZX/BdTo1rIjbsMT7NIyd7RRzgfBnjK+9wSU3qx
         5bqmeLQtE6WGWwguk3KKGGDntB/ZOhRxdh/oqf4Hw4AdtKgtcUhUBu52/t7Oy1mSQybo
         tGtgFftlfH64RP92QYMGbUjgF/7DyZHEUBe2sUSzjcRo8nz+X9Tz3pwEkt7sUIFtHbS2
         nrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306859; x=1741911659;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8s8l1GoWqcEjsTPQFWOhmnTF1QA5xT4gV01fDhrslOQ=;
        b=SiGLiFZhUO//jqgDvThaPYuL/JJKGb7ws85Gs46tacMdSU0/rVW4EVgzOLXmI7kARO
         wV9qwZHZssv7DRMhgbyUz0My8N5uRXyPKkEMEeOjGevEO9UlPNzrN3i7ZiqLfz0BXqEh
         TNQ4BKmzttNThJwj7Q+xVSYT/yjgUsYQlkz7ggY4fs2gq3y/4OIUFPhZLdtEl6RuDq5/
         +l1u4SZAVMkJwhuj5QGkEaMsmOXcRtwdK2HZJLu/JtYOLRJO++JFoaiE/9JieNUDPTm7
         vm6JQuFhYOKbnBX53SleBcyRvqL+OoVxnllDGvpw1WoGv/jtVhqtOvdwy1ywsLA7kUPv
         xhWw==
X-Gm-Message-State: AOJu0YzYdWBzQj0I9x9OBXHNl2NrZqN+4AqFnANgFNsg1fjrr6hK+9Hi
	qC09wSC0A1uRYu8uvsanGysqepScWpwwWWH1lgEIAe9bdl+HdFlWAyg8tw==
X-Gm-Gg: ASbGncvzkxH56apJQjLB2ltgNKTHsCF3ovFHEKzIrKZMruaRLTnBIw+498JVhFoleKd
	Snyro6UZpBTfQlJ3mLrpQydCRNw+H/TelFsIgjbqkvM0XCKlENpP3RBncpiA0hFDlvgYtY+6aP9
	5ueS0DZMg9GV+WY6NcMgUxoklhOAjsHMbJqAi+HI8Jjb8NXkbYNDMYIZF6pR6xEqafjP0DR5HC0
	CaCBm/oQNF4fhisCsiCRI2VYc0WwjsDDPO7Q8FbTEV7/jQtK3jKof+4/bJPBa4zNtoSi4hMcMGU
	3hCxKnExDPAQ+g5fBHb6AJE37LkinuODS7kFgMLXLGJ4HVzTgNeb5A==
X-Google-Smtp-Source: AGHT+IF2j7ADnlG5R2RRT1IgZZ3YSn7hCs4zegUqNRTy1CHbxoUuaUdxEeYM4FgTAC7nrXYEJVm8Vw==
X-Received: by 2002:a17:907:3f2a:b0:abf:4bde:51b9 with SMTP id a640c23a62f3a-ac252f5ca60mr127985566b.35.1741306859288;
        Thu, 06 Mar 2025 16:20:59 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988e579sm175284466b.154.2025.03.06.16.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:20:58 -0800 (PST)
Message-ID: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Date: Fri, 7 Mar 2025 02:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2 0/7] Add support for RTL8814AE and RTL8814AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches add 3 new modules: rtw88_8814au for USB devices,
rtw88_8814ae for PCI devices, and rtw88_8814a which has all the logic
for both.

Originally it was supposed to be only RTL8814AU. Recently I realised
that RTL8814AE can be supported too with minimal effort, so here it is,
just one extra file and a few lines in rtw8814a.{c,h}.

Another set of patches will improve performance a bit.

Bitterblue Smith (7):
  wifi: rtw88: Add some definitions for RTL8814AU
  wifi: rtw88: Add rtw8814a_table.c (part 1/2)
  wifi: rtw88: Add rtw8814a_table.c (part 2/2)
  wifi: rtw88: Add rtw8814a.{c,h}
  wifi: rtw88: Add rtw8814ae.c
  wifi: rtw88: Add rtw8814au.c
  wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers

 drivers/net/wireless/realtek/rtw88/Kconfig    |    25 +
 drivers/net/wireless/realtek/rtw88/Makefile   |     9 +
 drivers/net/wireless/realtek/rtw88/reg.h      |    66 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c |  2257 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.h |    62 +
 .../wireless/realtek/rtw88/rtw8814a_table.c   | 23930 ++++++++++++++++
 .../wireless/realtek/rtw88/rtw8814a_table.h   |    40 +
 .../net/wireless/realtek/rtw88/rtw8814ae.c    |    31 +
 .../net/wireless/realtek/rtw88/rtw8814au.c    |    54 +
 9 files changed, 26470 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814au.c


base-commit: c61da149b9c2e439abe27845a71dae5ce5f5985c
prerequisite-patch-id: cbbeefd71b59d1fcea72cda22b1eb0e62b40a751
prerequisite-patch-id: 18beb866f984f1ed6769d95b3ab7894d75b3e7d1
prerequisite-patch-id: e1e0ceb709fe71d6c48e063768698c78558f11c0
prerequisite-patch-id: 17ec15a2287ce8766e35b1113fd043d25ebba9ed
prerequisite-patch-id: 36ff8f0da543fbc931db6cad60d8512dba82ecd0
prerequisite-patch-id: 0b5c2a854227b26491421be28b9348e098195881
prerequisite-patch-id: aef15a0990448c435356fe7631ddafbf35606731
prerequisite-patch-id: 56dda569e509fef7403a02d4700b22f27301ea37
prerequisite-patch-id: 0cc73f75273b064d6e8783b8ac4ed06a1025ced2
prerequisite-patch-id: 04fd029f6ae8a5f3d944ecb4c959e55d2599dd87
prerequisite-patch-id: fd5c77b6933048355029ecbcdaf3107183c26aba
prerequisite-patch-id: 6f50c5e526f96008b795477ce97e3c75845f113f
prerequisite-patch-id: 6d85bbc95c0eec75de67992a176907afa1fdbd4e
prerequisite-patch-id: 1e4fd27474a3622807b7fe5bfd3a5a09261fba46
prerequisite-patch-id: a762f356fc162e29375af231beedfc06dc3a4fc2
prerequisite-patch-id: 1c68d0186aabcd2c7ae21b605288aaa872651307
prerequisite-patch-id: b0c4ae910737add0d3068aa92efa265d11dd66e4
prerequisite-patch-id: 5b58a4a0870850a6768eca1a2e9d1523dfdeae84
prerequisite-patch-id: aa98043b8ed5ddaba365c045aaf0466213d18dcc
prerequisite-patch-id: af6b19b41c6357b9ff8714639465b8e95f74bf73
prerequisite-patch-id: 2855bad33fc600e2d5145902462f0e20d6d92e0d
prerequisite-patch-id: 70c46911f78d2e88af8ed220cb692e098e1572d6
prerequisite-patch-id: 2321dc9826f91f47d58605b810b626842dbc4312
prerequisite-patch-id: 55be10515d0350bcbfb3d42fd085e1492041aeb1
prerequisite-patch-id: 0cdc30856400ecfeba230ed9b794829afda6a4d5
-- 
2.48.1


