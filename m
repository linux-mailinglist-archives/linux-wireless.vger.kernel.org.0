Return-Path: <linux-wireless+bounces-9286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB659910110
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707021F22814
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE41A4F30;
	Thu, 20 Jun 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArXWFJQJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB22BAE2;
	Thu, 20 Jun 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877929; cv=none; b=iRisYDlxp/7TtHHAZELCYZU9al9zWKkWCcnsQE41owGMJnq0rbjJBJcAtTa6yKo/42sVHBq5izVbFViOFTVbxBWZftgxQyI+KLewAon8/YDPg6bqKUqMIHW2OF5OJOTw6B3ArjnKTh9sGcbkkl2Y5RBm6DZYdP0JJwaVnSPCf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877929; c=relaxed/simple;
	bh=HDZk9HJppUsHiLTg26al0A+m7r+GdOYBJsYGlt7Qx7E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D4uwjFKXlwkT0DzPj727AbWwtI94mNA098zW7+r23yyqcnSoS75t37Spu45LRT/RhAJ/uFbzYssPQOUmh1OydXk66KMVqNnbygzgyWVCwybmNBOJdU6zVRol4abGeXNwELqMLTPxjRbWKDJ4ITblZWxkHBnxDOGklhWzgn5af4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArXWFJQJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f44b441b08so5315555ad.0;
        Thu, 20 Jun 2024 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718877927; x=1719482727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HDZk9HJppUsHiLTg26al0A+m7r+GdOYBJsYGlt7Qx7E=;
        b=ArXWFJQJh37gmCLv2Wo20HdCZtzaoSMtV0fjcH/2WUfTGRhVOcl1JHzEvQM5M+WGx9
         EVDZznNAQMS7uMtf8YJEjgmII+5OxgwuZlc3125lBjmet5CEI+VF7UgV0nMkfh+MySkQ
         /yb3D/+2GpItJsatA2VcWn/fbgwaqENK8rE48zTOyTryyan4NAa5BR9SzmVge1KPwxdL
         uKKRBKhIsFn01q5gfFdPbkDSGKIb6aiirsj4vPmkO3Hb8RS2MbhLkMvMnIBTUwAy6diW
         EceK/E8maqv0Yxdufj2Ny2USdlViUVQoYABS0UXlOzCPcOzRHonSdN/q8DuIM/wUkQxd
         xeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877927; x=1719482727;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDZk9HJppUsHiLTg26al0A+m7r+GdOYBJsYGlt7Qx7E=;
        b=i5qx31MclfmOkhBmB2HpVeQHKFph+dss92EcC7xGkjGMNSu8TbjNNhYvsuXPoHilBF
         fM5mhEFZan8N1EybrsWAgB+N3NqLi3Hy59I1CH2FxR+p001YY2P+plHXqqJyYvI963gK
         /0e1us/ZwbebQGSTxft2LjPs5uXN5/ex/EoQTHwpsc60k8vXMncq8xqo9nMRF1Ku3zxj
         9O2ITt3whJxTzwhss9LYz8r4FXWFwESq2yft2q9b4euQrHQxd0aFKgkl+3bAPORCh58A
         DG3x3XrQFd9wYWJFg4hNe+1KsMOHGdojhhtQ9PZtH/YXlUboZjXMYuZjBmUR/By+4Aig
         FuUg==
X-Forwarded-Encrypted: i=1; AJvYcCVp/TlDnV61CC015QtyKpSIuoFLIG7HZdNrw8t0+nzrZ40ZlHjCH9MhqtRXa+ZJg/5aEio/LuVlnePk3JCR7SebXTBhVp5waU8=
X-Gm-Message-State: AOJu0Yw3uEM7dcSryYCiwf1AXc3xXAUGrZOzF4YpvVpp2WwiO2dRL98H
	JLokIy4XvAiMVyXOqdCeZY45c8Y5Jig1reJXvXtEWSaHOQIht4f7
X-Google-Smtp-Source: AGHT+IHKP0cjFNlKm9wf9h08SQSeHk8JMac7e/kdLm1Cay1idYN22fHCErHQ1so6NkdBrqsZNuoh7g==
X-Received: by 2002:a17:903:230a:b0:1f9:ddb9:3ee5 with SMTP id d9443c01a7336-1f9ddb94098mr411145ad.26.1718877927301;
        Thu, 20 Jun 2024 03:05:27 -0700 (PDT)
Received: from [127.0.0.1] ([49.205.38.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b17f9bcasm30533305ad.161.2024.06.20.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:05:26 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:35:23 +0530
From: Mathew George <mathewegeorge@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Bernie Huang <phhuang@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
User-Agent: K-9 Mail for Android
In-Reply-To: <342b6b95d97a4bf09afee15c09481efc@realtek.com>
References: <87tthpwkqf.fsf@gmail.com> <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com> <6970398610c546b1b62e599902c67572@realtek.com> <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com> <342b6b95d97a4bf09afee15c09481efc@realtek.com>
Message-ID: <CFB0314C-AE45-4563-BF41-F5D635BFCF86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I have seen that, but no clear idea for now, so I will install Arch Linux=
 as yours
> in my side=2E=20

I really appreciate your dedication here, but I'm not sure that this is re=
lated to my OS=2E I
feel it might be a corner case that manifests only on certain hardware con=
figurations,
otherwise it would probably have been encountered by other people by now=
=2E
I can't say this with any confidence, since this is my first kernel bug, a=
nd I don't have
any factual basis for this feeling; I just don't want you to burn yourself=
 out with the Arch
installation process when it might not help in diagnosing the issue=2E
Ultimately we'll go by whatever you think is best, though; you're the expe=
rt here, not me=2E

> I feel this problem may be easier to reproduce on Arch Linux, so I would=
 like
> to know Arch Linux iso file you installed=2E

I don't remember the iso version that I used (it was years ago), and I don=
't know of any
way to check, but it shouldn't matter=2E AFAIK the Arch iso is only used t=
o bootstrap the
system, so its version should not be of any consequence to my current conf=
iguration=2E
You might want to look at https://wiki=2Earchlinux=2Eorg/title/Installatio=
n_guide
to get an idea of what the process is like; as you'll see it's very manual=
 and takes a fair bit
of effort=2E

