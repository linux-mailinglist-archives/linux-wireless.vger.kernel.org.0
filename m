Return-Path: <linux-wireless+bounces-25746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24DCB0C06A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612AC189C00C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBF28BAAC;
	Mon, 21 Jul 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="SY3/bwiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3D28C2AE
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090543; cv=none; b=Cl6aJjvU38qs1gJ7Plc+WDc9IUMc4+T5qohKNjrPD/D2BFybN2jmJRel5puqB3lmLLlNk8OxGzfZVLoR+p5hHaVbfzg8ielwr2C3yAnM2T4bIOIoBa6MkuLN8TZE4ZztfjhatLIHwom07cGavWnQO3uJgd0zWWJRMDn5YWF1elU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090543; c=relaxed/simple;
	bh=naZ08eZHvCTGd2t3B5pVc16gcjutotIgoHB2ezgmeNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RUzBoO6OnUBYBfDoZfMX/iLHi5Vvp06b4zdL0UC+qkkeIg9zS4fqp5Gp7NfQwHmue1F1PQYErP+MXGiB9O5BkFHKdX1XQi5hzH5h0eOQw9T21QKdgZR1lF+/HRZ9m9RhwNm+130oUTBH/F445edyYZdWW8+JFo6dTe/q61PD8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=SY3/bwiJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso3098243a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1753090541; x=1753695341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naZ08eZHvCTGd2t3B5pVc16gcjutotIgoHB2ezgmeNA=;
        b=SY3/bwiJ5/YPczqwjR6M/Gv0zGcSmWMcyun0BItosmycVxWjb4M5/KSCKLlSQpmV8f
         j1AcEVl5f0DZdrSRMZhl1ESrBZwICpoU6M8sQrkI5ZHd7l2HqJdleu0+gzGQ1rMBbJ1O
         HywBJvaUpEAMXuBn1qZD3DQdxTgsMZR4D71w/xx+f9km3zN5n2UzBkUyhJPagAeMr1AZ
         Pa1BUvaKihyP9LX5DF2IHBaHZ4Y15jeXlqFCYN53KtsxNR0w2MuIsUnlyJLnSPwfzjkw
         OAMaGyDDY8o2m+pDoO8rIuCzU1t69BOcHm+hy6zREXRCQ15WPwpHAEaXqfRFTehTQj5a
         l7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753090541; x=1753695341;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naZ08eZHvCTGd2t3B5pVc16gcjutotIgoHB2ezgmeNA=;
        b=ULcrudtbGgQCz4SnfQRIlx61knjOJbyuVMij82O9O726GRttOAHptQVjdlPSr4kWci
         +GzZexhlBQYmxbUR1GwZwRjTZwCVViqyvkZaya0zaElxXzjPlpGSsRcwzw9ZqvsoDapj
         dZSiQz6Aj3+rbawxGpzscB6tCeIxS+doAxyt2HSYHsnntAA0Pjb1OJNrl3Bg6kUV4eAT
         d+XN7+vFUnKNkoGihgK6JtVgPJM7rL7rQoab6yaw1RTs0fsRRGN2KBuMPcxtu8PylZMS
         +UieRx7poen5+qCJkleDIeqSFglU6HbyUxa7p5z3VEH3ggaisgnf935kOXTBEge3pE/4
         wsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2X3T8Q6sdTdT3cy69z7LREPGuo4A2HEbqfRYmNquaPyNB2if40z/2uupj4WT5KRxPd2AVFv+9vlSj/27g8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgpPWql9bCHPpQycGWI9a4MgHXRISG7+cUyx+fU5/6P2e+QRb
	b43tyS/6W4iJyz8vAeObVro5tvg210vqfV17EbOehn4aQnGdDKJL2pio0FemNaacCqYcgt12Xzk
	6XyrlkqB5E0lVUJRJ7vXR8V3Lg+ImO23/AVP/MQPP
X-Gm-Gg: ASbGncupzLGsWtMLiyvXKOo79PJbyCjmxXJKSt6WIkRsnsXIAuVSKJij5n8+MR5NNv8
	hgKVTQKNRE7uIrTYB6NehTMuCVC57hZrczaiU3WdLyXhetHGdMC6m3q3KZ4BTXQHvEj6+wVz+A/
	Bi5BFn660PJmeNuJwVUndDl0pei6N4lY7Ey6hAgoSrN3PdP1D1UkUoPiBY2OcMQaMjIOzyEERtk
	mgAN8YBHAK5uEIDtv0dkSUq6O2jtOcgKxQyV2fynA==
X-Google-Smtp-Source: AGHT+IEmGl8oHtP/ZY80q8/nt0kMfo7G1cG1EHfeOtSqBLGRr1JBiLzQDQKV0rqaHt080HFfakgzt+pVfNLopOCBnX0=
X-Received: by 2002:a17:90b:28cc:b0:311:b0d3:865 with SMTP id
 98e67ed59e1d1-31c9e7931a3mr23557065a91.32.1753090541568; Mon, 21 Jul 2025
 02:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 21 Jul 2025 10:35:30 +0100
X-Gm-Features: Ac12FXw7QcT0NXYbODghRoxTCBGSd_SUNDYC9GHU9pvPg9XuP0F2KafmxpIpWpg
Message-ID: <CAHbf0-Gae=dYa=Zkx3ZJkL1SQOgHQWAMMvm68T9PPu8_=5oT+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] wifi: mt76: mt7925: ensure all MCU commands wait for response
To: mingyen.hsieh@mediatek.com
Cc: Eric-SY.Chang@mediatek.com, Leon.Yen@mediatek.com, Michael.Lo@mediatek.com, 
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, Sean.Wang@mediatek.com, 
	Shayne.Chen@mediatek.com, allan.wang@mediatek.com, deren.wu@mediatek.com, 
	km.lin@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"

Hi

I've just raised https://bugzilla.kernel.org/show_bug.cgi?id=220353
and I was wondering if it might be related to this commit, is there
extra debugging I can do to help pinpoint the issue?

Thanks

Mike

