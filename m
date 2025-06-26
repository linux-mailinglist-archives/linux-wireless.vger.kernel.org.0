Return-Path: <linux-wireless+bounces-24535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82DAE9A43
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3103A5A0BCB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84634218AB4;
	Thu, 26 Jun 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS1kUxMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD34191F7E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930697; cv=none; b=luLd2b4yPXpSjlwk8M/AV83dxCrRRhADV2OUWnqkgCfmByMIjCJaTMvilR2GFeJFgxdfvEXrCjBqWU2JVCbVdorlNg5RJvdG/qq5ZIREkUnKF4LOfqrOT3nY4cecfpYOo0o05kDEEYK6MSpnEMfHxVyIu1tot3ly4+D80i0eGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930697; c=relaxed/simple;
	bh=UUoaqti/topMPcvNtzcgRph5DmYS+DjEIoDu39jfxlQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JSXhKCFYklrcMHy+sftt24gbbFZx+E0+uWjBuo7B1/dW5sFJ51tS2iGiPRYMGrbRRMeMg3SCaq5qNfDy/cHzUwRU7scjgILULuJRoL7hAEjkyV6cev7APE18yyS2OxHJLIzi6QbsTg8FofKAz5Z8lNQwJ7geAHXcfVH8f/KMpMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS1kUxMT; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40a9f8b75e6so31037b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750930695; x=1751535495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUoaqti/topMPcvNtzcgRph5DmYS+DjEIoDu39jfxlQ=;
        b=WS1kUxMTDC7UDL3AifzJTezJrFvf2Wev4Yjrto6DgIYrk74MTMm6H9ejd81iH6OxE+
         W5EMkSix+z4PR3A8JaXbWXwJYnZH9C9u2PI4/8TywbFjDqLLCC/HXW4SKJs374OvL77s
         o8i5NfPtiZX2KNRFoyR2WriLK9+j2nci6BpvegMQa7qkg8gxLCvolMpBoMhTvaI/InXp
         hWrj2j+HonySP0E3tM38bCbH1thZzz/ySsQPHGUseWDpLhiCwC9+JkHvDxBi6+7Nh2ik
         U573wOqRMfbbp5hWbkhclznLDDWm4oruItGC+KDnahQkp4Q+6BtDn59joMR74kENs1uV
         Q1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930695; x=1751535495;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUoaqti/topMPcvNtzcgRph5DmYS+DjEIoDu39jfxlQ=;
        b=JyGNcZkF7p0XilaIqNp0HvBIvAztvq+SrKimnKfjkskUZGlfBK8LZ2HRHasutU2I2+
         2/Qjn2QUntZI/b/9X2YRj/USohXD3uTy04lVaTpjsNq5zZAKrBRMdq968vqQHUftNWBW
         579Oa/+zG3r0kXAW3OOWpGcnlo7Jns/J0+LaA1EGGDEYjZJn8uX7U/KEuya1u879iRBf
         Q7R69XDe/kcVTZ7JZxm8Q+SOnvEFj7ueHOVEraOqMJuqvrfwetLzdscMyYOHwiWwfI9A
         xCEQp+ZJOqnofsSr7nWs2R0V3tKrDJ9FsokAyg/e5hBx/73xMBJca8oJ/W/Af575OwF3
         WYQQ==
X-Gm-Message-State: AOJu0YxogzpXo9dNcA9yjzIbOFtA9y711QbdlcNFveGbnSSWcYJFsk6C
	KGXWxuKMEiHFWdtEgCKX+7s8obKp3JcPwcbDVjmaNt2RlCvrUTKlCX9rDMUjWGcn0XdSmgaSYRC
	VYyGILjadl8bjCA6DNzxY9z4A7GE3KTbL9yPf9hG4fA==
X-Gm-Gg: ASbGnct10KYnGPxxWwYeStHNWxliM1uiIVWbL8dRQ0tlHK+22LJtLJZ1NJTz2NkLhED
	ZjwVzbxMauZ7krlGgWS/ZBNg85x7o914OhvJlNTcHp4i3ZETIPYq5532nMepxNuD6ss19krL6CL
	mmMqn0V3JZAgDDqEwJIqwei7pkhUii63Iz/mBlxKUYoL3J6Fjzx1rnJrhjzCgjjCQ=
X-Google-Smtp-Source: AGHT+IGAxK+edB8fzfFXJKVuj8IMPflq4WxRraMC/63T7/rOHcPP65nD3daF4gExdUtQKBbw2ySN53wZ6rr+VvgIknc=
X-Received: by 2002:a05:6871:3294:b0:296:9146:f455 with SMTP id
 586e51a60fabf-2efb254b57bmr1476581fac.7.1750930694776; Thu, 26 Jun 2025
 02:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Begench <ballarov99@gmail.com>
Date: Thu, 26 Jun 2025 14:38:03 +0500
X-Gm-Features: Ac12FXw27BK6WhBDxGVB8yIdJISFYyPdJDgNuhxMbedbsm4PwQDNYNwWeY3FaNA
Message-ID: <CAGqgb9FFKS9GSxJFq=HC6RAA5FRKO524FbtO5xgQrA75Aj0yFg@mail.gmail.com>
Subject: wireless-regdb: Add regulatory rules for Turkmenistan (TM)
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

country TM:
(2400 - 2483.5 @ 40), (20)
(5150 - 5250 @ 160), (20), NO-OUTDOOR, AUTO-BW
(5250 - 5350 @ 160), (20), NO-OUTDOOR, DFS, AUTO-BW
(5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
(5725 - 5850 @ 80), (20), NO-OUTDOOR
Signed-off-by: Begench <ballarov99@gmail.com>

