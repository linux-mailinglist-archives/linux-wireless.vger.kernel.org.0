Return-Path: <linux-wireless+bounces-15738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F979DA11E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 04:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4FE28169E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 03:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1758D48CFC;
	Wed, 27 Nov 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQd290ef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AC11713;
	Wed, 27 Nov 2024 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678139; cv=none; b=N9fCfbonc2FALutQ0VjUjUGp0bbW1+XtZHL+fUjPZr8ERuYIx0WO0yIeHZJTL6/Z59iXWvT/u7RrAsng6CUn0Iss007x/3accHHdLTk3XR4stwgTa8hdHPwInl4myEUGpArfTgk3QqH6irG4pEAsShQ2KhTbPI+uVahOmohDD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678139; c=relaxed/simple;
	bh=qtjJS5S9d7iRXTmqTHVEpQ3V/a7tVsVH/VFWvkaXMP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZerJcvIBKWXXEv+mBpVQUAGJtx0HOULe1fFHdKN9m6DiJdnS1xtplNEs3ZLYVMNB9o6ZtnCj30e9XcIqnm/z4djnoobqlq3MX4wIqaY1Zz3p4tKMyOrHdwjHkAYuNBxEkiSERAr4EMRwgZChxrS+xXkU2VpxD9Hzr+iK5ij6JtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQd290ef; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71d551855c2so1224594a34.3;
        Tue, 26 Nov 2024 19:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732678136; x=1733282936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXkezjBItwFS84EsFcYZBkVvSdJtp9PC1f5y3QrDEwE=;
        b=DQd290ef5zN/CrwqZbTp/9Dd8UuPFyG4Qku2wNpzwo9kma24K/LlbKRQj7HRNiW/Wu
         rnkCBwdfFHx2xnOh9LMEWdNJbJWHHF87DPK5lPH0c2DPkLTWKyvJWYJkGqzdE4uFPMRE
         n6Agb+pKtdKHX8H2Mj0LMa81NJuLIKoPLWjd5ZmfNOWCnvmpoMdzRI5Y5Uiwxw4PfOnP
         KuMTRln+rgCwsjlGPAT8JM4p+PnifhLcC7ZYC4cH3Y84hayh9VnJyp6MPQfulp7zK1RL
         eA3vSyxPSEDkBOUFmo3Oqim6rp0eMM8QVxm0fjmyR6w+ZvKqYNPjJ8hd3Z9Fe9ewHWqZ
         h6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732678136; x=1733282936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXkezjBItwFS84EsFcYZBkVvSdJtp9PC1f5y3QrDEwE=;
        b=gu34qcRHbFieUliNndILUdNQjnglvT5hNJCfNDQ/JUoA4bymb2JGesV+V0RQdgERbu
         FCa5d5S7HIWK7px0UMDH1GKCn4ybvGyXb9pyGfnVbgzE4XCpJFkYYw++HowccfjeDVMN
         ugM340RGJ6tJX3+fjDCreQ3q5v73fRrIj7iAK4Pk0s8rRUbRuWGvg+SgqLgK3h6GT7eA
         fCM4JM7kEqBu0K6geui+Sh9UuW1pPDGoXwAy3UV3ezAP4lx4Mb4ltXrv+hKQ2GLhQUg3
         fE71ouvxl5tyRXJlufSwXoAxiraO6pJm66LB8u0XvihgBhZT/Qd03MQjXuSySsXK1RoM
         PdrA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmFBf8HTeP05+puYPZ6MbIZyV039945QjeNv6SWouuQLUrUWZDUxE0Q0U6LMf0YOpWRBErlo3+3KCCWU/YBA=@vger.kernel.org, AJvYcCWVf+X+/KJfjgsch5IWgs0dJpvwlT7Ow4U+gzm3Y6UgFxZ6FHcUC10zM/q6GRWuuUUpmTCZQHGmfo0Ud3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJCwEXJkDR+ETEZF8k+Hyyzsllbhm+98OKoWFzpWAExGkH6a6
	F7/+pQG5gP4EaIhe8eWS3+J86kySOBc0AqawcgjtBzXult5QjGJv
X-Gm-Gg: ASbGncsK3biJR2VF0sWuW3HVKDRHtixtfHboh8w33eJ2+ql11L6KNC+hPYtcfqo0677
	BMiX3WNufyyFLggw+JXRQND1HAsvpNAZBfsMKl9xHlwLMdXedNR9mUZlRtfXMPHOTg/A3NQ/+iR
	I9vM5+8SEOAEFjgv4/jJDgl2i6naBAJWqdeZOB2orntP7nbjWBGL7xiNvnjklTz/m/fywg4IVwj
	GFK7v7/7ntk/8+J8A4NUwMswXS6gsH+bablVkYA+q+csvv7QR8BAfqO
X-Google-Smtp-Source: AGHT+IG+5uTiwcOWjsWrsStnJeepttuhfxKuCGJ7NLB7+bGxe8Bt9UDRSsvgK1Ld4hoxOBhmASKnsA==
X-Received: by 2002:a05:6830:6e99:b0:71d:62bc:85ec with SMTP id 46e09a7af769-71d65caea6dmr1506440a34.13.1732678136236;
        Tue, 26 Nov 2024 19:28:56 -0800 (PST)
Received: from LAPTOP-SQ5KB8RN.lan ([222.249.179.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3dee7asm9562849a12.61.2024.11.26.19.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 19:28:55 -0800 (PST)
From: zgBCQ <zghbqbc@gmail.com>
X-Google-Original-From: zgBCQ <hbczqbc@163.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: Re: Re: [PATCH] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Wed, 27 Nov 2024 11:28:21 +0800
Message-Id: <20241127032821.57468-1-hbczqbc@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
References: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thanks for your reply

> Is there a need to reconsider also such a return value?

According to the current code (commit d5c65159f289) of 
this function, this function should be terminated directly
after checking the null pointer, the return value may be 
meaningless.

Baichuan Qi

