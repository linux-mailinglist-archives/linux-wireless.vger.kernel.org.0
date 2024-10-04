Return-Path: <linux-wireless+bounces-13514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B3990767
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7F9286380
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90D1C3040;
	Fri,  4 Oct 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNHSkmsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15D1AA798;
	Fri,  4 Oct 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055516; cv=none; b=dp2YPM9Fliz5BJsaxQUCFEyc1p2k2aJxUtL6cn7Cb/69tKubUBLmW3Py9n7eD0qQPII7N+m2eP6AtQ2qHX1SpZuMD3QvXbkuoezNrGOxF7u88QONnzL+9ABsoa9EpQj4W+OF08v8rSJHuHNBNsjsyghlBtkdLfguvaIkefxSEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055516; c=relaxed/simple;
	bh=e6TKmiRlr3jIBiPeSrDU/+JnyFrTJDdS/82UhHlZ2KU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uVu4b3zOu4GXPGCTf8YTfLSJa03PM8P8aaqt7EJh2ddPwnZctpO93ygHDrCFBsqeNXQRuEgE/Iofy423oj51V1FtBnk0Mn7Zs+6WtAkZ2Fw5d1a2q+iV6pptHT9pH8bpnfG1q2xF+E6sE6KuZX6QThcx9Dj3pE5oKFNnpHSsBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNHSkmsp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9b3cd75e5so213234785a.0;
        Fri, 04 Oct 2024 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728055514; x=1728660314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEXLkLzVw+ZwuISj1WyZNMLTYv32POESldDSS3USLSE=;
        b=lNHSkmspexiAFq4wKXXbOefG4Vzis46RpNGg+tfjCCPzb2RXDG2097hDRFv1XOG4Qk
         sPu9HyMm94tlKL9K6+MRL0fauqc/Ui7flJLILKA4Rej9dzZ5AFIVtcpBoKqSdtT/HCfg
         +XjobqTwK63qDsVK4HBEfl7JY2S8bnb/y0OTYzS90Ntq+Kk8wPJIdzJg2BtxMq8MSLOj
         Ge4b9R9nV6Ai1r/tvS2zYB9TY40Q//5rOzCvt2Pqe866wMgNdRTZFbpra5GcM/0kEFKQ
         O3FZFYTxmwMVEJY5Mcj94bhORBre6yczoxzHODtecR+b1/R/tVUhMYgdQzq33DPOCY2b
         wLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728055514; x=1728660314;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NEXLkLzVw+ZwuISj1WyZNMLTYv32POESldDSS3USLSE=;
        b=nM39XzjNs4cLXNJ5iMs0gFvKTG/FR4cyzbWi92HyWiCZpoq6PacMJhbLBSXu9+BaSh
         eKYp8rvFCD0xvX4PlH7Fb+L1DF8NesENTNC7wji3DN1pTcD/+9L/UY8imTycoBiJlYzg
         w6aTy55na9oPuJXbWZUjApyeQVEjIMhPWN22YKPwmeJdGpjEYcaC84CVybqRW2HUtkEd
         /v3BmdmkJATfofxfuXViNo6gBK6YBKnjWhQiu1J4dT+gUWbUShVbCMf1CJr3I/c4gQta
         7ny4bJckC6zYg/GcfVAa1K0kr+uJ+uUxEO711yAe0SKyvAD/0IUrk0Fj4l90YnbtNGaQ
         Rw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUSi4JsODJtvaKXwYyNCX+NGOxrTw37HpHk+GAJuzZHsBcWRrfFovPTRQOHycRnuQSow4ABhYJUlmOl1i7kBws=@vger.kernel.org, AJvYcCUos2UMywzeUAicZrLuJRavXVjvJlDSVulUwOax/PLDcb1XY7fUPEJ2H7BfVJFhAouGRLY4sl6pS57en1Y=@vger.kernel.org, AJvYcCVu63PEGj+rNJGi5QvHNlm6TeJVue728IcXqFHDWZbwArvB7qBM4gXXSEmTgOiWAAlf36c0V580@vger.kernel.org
X-Gm-Message-State: AOJu0Yyomgj2sEpkRl5zoJuihUbvTwN6QKSMYJD/ySiqmM7zhbZsBOIJ
	MzA8Z98GmT29VOBGdPEAgsdsMy/Pa/+fJD2qc4HUz0bnHiT5NqVT
X-Google-Smtp-Source: AGHT+IG5TVJVHAw+yR7Z8M+pCTpyek3EyxDN/H/sbF806T1p/9yGUnDuOfLTaeqcylW0tcl1YPhGMQ==
X-Received: by 2002:a05:620a:199c:b0:7a9:b424:ffec with SMTP id af79cd13be357-7ae6f4535f0mr453290285a.30.1728055513926;
        Fri, 04 Oct 2024 08:25:13 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6cd04a32sm122172985a.57.2024.10.04.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:25:12 -0700 (PDT)
Date: Fri, 04 Oct 2024 11:25:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <670008d892bf9_c21242947e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241004-maint-net-hdrs-v1-2-41fd555aacc5@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
 <20241004-maint-net-hdrs-v1-2-41fd555aacc5@kernel.org>
Subject: Re: [PATCH RFC net 2/2] MAINTAINERS: Add headers and mailing list to
 UDP section
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Horman wrote:
> Add netdev mailing list and some more udp.h headers to the UDP section.
> This is now more consistent with the TCP section.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

Also a reminder that maintainer and reviewer roles are not fixed,
and open to regular contributors to this code.

