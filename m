Return-Path: <linux-wireless+bounces-15815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D39DF9CF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 05:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038832817DF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21911273FE;
	Mon,  2 Dec 2024 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="BxNMWPjT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D810F1
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113271; cv=none; b=ZHKvt+GkWygLyW0UoLyFUYOn80/kh854mH6AFfyMmvzLPUDOnhJUXobPO1G7BGO2bt1vXZvHAbEZwZH/LuUbLKvzdU9kpt7iWLTt3wOWVx2euaRit/cpBs+jJ7xe669DShXTmHBDfV7PgO/4bOzJaDEgD3uSDNIQ8iZmWaKsRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113271; c=relaxed/simple;
	bh=7USzoEU6Xcui4TulsJfKEW7xW48TUJZVi5W+nJEQxOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDO6SP7U9bB/U7kGTjzFUSErnZfX+ezcDJ1bGz+5xhDPq9HvcWK8ZxWsCHOotY5Li6fLBO0odIbOr/CZvRvxZwmSVWPPfeiZXuKsZYYWp/NDB7Kx4UIY4CkkFc2N0av9LBRoxZyfEofEeg4kFUyjiWz0FGNrrWerKKmqIxw2GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=BxNMWPjT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7250c199602so3104197b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Dec 2024 20:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1733113264; x=1733718064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7USzoEU6Xcui4TulsJfKEW7xW48TUJZVi5W+nJEQxOM=;
        b=BxNMWPjTBPwc16FYNg3Qg9BMg4wVA6HDYvUCbST1zkUVCmOeO2OF1v1aSpZP/70V7j
         lD3G5g0LHvGGnFBwejzdJQCcvUhlD78sHdsWeenZf9DmnI7aJxkvyYpllmJl6IsRWaAL
         q3recrLlPedzvI0yiomQVNVN57Fyt5iTgPEtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113264; x=1733718064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7USzoEU6Xcui4TulsJfKEW7xW48TUJZVi5W+nJEQxOM=;
        b=fje9HIpT/Ms62JmEMEOpgURVp8juabmEAHMALl6XNvxo3v4G7I3FF/dEVNxQSMw7qs
         CPGl+6FUysgRHkZ/3+BRBJw8ra5PkU83Xyt2tyWLzi7TdjpK0zXZpjvVXQV9R2gGqqja
         Cmp8zr1QMKnpYSu7lwJX2XeuRuJb5RwfMZCiyq/Xq5o2RfEDtTFZFNpwC6NEAtioIaCh
         +qiCPRruZ9GT7bXahk3PdTL5E/+xIbTrmbzmFR682af0mJWoY2Va8S8I3RJ94TdQFjKy
         OYrRlY5Fyk4GxipzfC3Pytb9MXjpcsU8igqcxf65gwjgiNh7qNi+kp0Rwn1V1s8eqPPe
         t3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6VG/bOJj3QzERXl9pC7B9lx1shMnvaQ8G69ipVFvWvqqdBD0gvjUPKv6NpckjKsyiPTkYI2OYm4teLYaC8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcg0oCfYBDWf6RhAt8jQPicxpksl/1IC/AjvR+pPauRSWMTeh
	I92TwdfLrUzzKQxqu6wmSGWjzXqs3jvy/aQuH53q5MAbNh3yHBx4T4ToQk+LLg==
X-Gm-Gg: ASbGncvaxWAuCxgyDeqQOS4XVSPPf5J3P/8ACnKBO/e4YbYCWovw3qxffdhCjAI3JpL
	ukv6EN3gbxjxQoEr33NfhTr6OxxZgWi3ilgf0pk1SlqIfE/Ds0aI0Ah3ZvE0lojd/gLbVzRxzOV
	Ohenu6P0DmDVChgzcKFOR3etgwWVBd5/SdEaOS9+MxXBr75c84wLXWMM3CyTpV0BSmiKfPVdf/r
	OGC/YD+pfXyW5Yoks49UuKL8lqb/n3dx0dKK31Kk4Q97+11MkwNKYs9sL7sd2Wke+QIWNzsmtIM
	ILS1jBc=
X-Google-Smtp-Source: AGHT+IE0d77tTzHu3w/uhDBXIxj6sTADlB76crZC4Q8OZi/5uEJoQ3bK2deCXGIuZ7wYwPVbxCTF2w==
X-Received: by 2002:a17:902:ef4d:b0:215:5d43:6f0e with SMTP id d9443c01a7336-2155d4373d5mr118961885ad.41.1733113264308;
        Sun, 01 Dec 2024 20:21:04 -0800 (PST)
Received: from SE-151.formulatrix.internal ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215413d0579sm49266695ad.133.2024.12.01.20.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:21:03 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: ys3al35l@gmail.com
Cc: arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Date: Mon,  2 Dec 2024 11:21:00 +0700
Message-ID: <20241202042100.6384-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I believe those errors are not fatal but I still hope this can be fixed
in the kernel (or firmware? (or wpa_supplicant?)).

Fortunately, you can disable DUMP_OBSS feature to disable dump_survey
which triggers those error messages.

See: https://github.com/raspberrypi/linux/issues/6049#issuecomment-2485431104

Regards,
Renjaya

